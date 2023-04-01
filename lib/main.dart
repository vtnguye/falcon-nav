import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

//import 'package:flutter_polyline_points/flutter_polyline_points.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'FalconNav',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Color.fromARGB(255, 201, 85, 31),
      useMaterial3: true,
      colorScheme:
          ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 245, 234, 231)),
    ),
    home: ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MyHomePage(),
    ),
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _selectedIndex = 0;

  List<Widget> _createPages(BuildContext context) {
    final myAppState = context.watch<MyAppState>();
    return [
      Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Select a Building to nagivate to'),
                  content: SingleChildScrollView(
                    child: Column(
                      children: myAppState.buildings.map((building) {
                        return ListTile(
                          leading: SizedBox(
                            width: 48.0,
                            child: Image.asset(building.imageUrl),
                          ),
                          title: Text(building.name),
                          onTap: () {
                            Navigator.pop(context, building);
                          },
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ).then((building) {
              if (building != null) {
                LatLng destination =
                    LatLng(building.latitude, building.longitude);
                LatLng source = LatLng(41.376247, -83.639979);
                String destinationUrl =
                    'https://www.google.com/maps/dir/?api=1&destination=${destination.latitude},${destination.longitude}&travelmode=driving';
                String sourceUrl =
                    'https://www.google.com/maps/dir/?api=1&destination=${source.latitude},${source.longitude}&travelmode=driving';
                String url =
                    'https://www.google.com/maps/dir/?api=1&origin=${source.latitude},${source.longitude}&destination=${destination.latitude},${destination.longitude}&travelmode=driving';
                launch(url);
              }
            });
          },
          child: Text('Select a Building to nagivate to'),
        ),
      ),
      GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(41.377925, -83.639979),
          zoom: 14,
        ),
        markers: {
          Marker(
            markerId: MarkerId('The University'),
            position: LatLng(41.374498502, -83.624830834),
            infoWindow: InfoWindow(
              title: 'Bowling Green State University',
              snippet: 'The University',
            ),
          ),
        },
      ),
      BuildingsList(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final pages = _createPages(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            title: Text('FalconNav'),
          ),
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.select_all),
                      label: Text('Select'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.map),
                      label: Text('Map'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.location_city),
                      label: Text('Buildings List'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.event),
                      label: Text('Events'),
                    ),
                  ],
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      _selectedIndex = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context)
                      .colorScheme
                      .copyWith(
                          primaryContainer: Color.fromARGB(255, 233, 127, 28))
                      .primaryContainer,
                  child: pages[_selectedIndex],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class MyAppState extends ChangeNotifier {
  List<Building> buildings = [
    Building(
      name: 'BTSU Building',
      latitude: 41.377455,
      longitude: -83.640271,
      imageUrl: 'assets/images/BTSU.jpg',
      location: 'Bowling Green, OH',
    ),
    Building(
      name: 'Carillon Hall',
      latitude: 41.375662,
      longitude: -83.637580,
      imageUrl: 'assets/images/Carillon_Hall.jpg',
      location: 'Bowling Green, OH',
    ),
    Building(
      name: 'Central Hall',
      latitude: 41.376795,
      longitude: -83.637400,
      imageUrl: 'assets/images/Central_Hall.jpg',
      location: 'Bowling Green, OH',
    ),
    Building(
      name: 'East Hall',
      latitude: 41.376247,
      longitude: -83.636846,
      imageUrl: 'assets/images/East_Hall.jpg',
      location: 'Bowling Green, OH',
    ),
    Building(
      name: 'Education Building',
      latitude: 41.376763,
      longitude: -83.638251,
      imageUrl: 'assets/images/Education_Building.jpg',
      location: 'Bowling Green, OH',
    ),
    Building(
      name: 'Founders Hall',
      latitude: 41.375353,
      longitude: -83.641806,
      imageUrl: 'assets/images/Founders_Hall.jpg',
      location: 'Bowling Green, OH',
    ),
    Building(
      name: 'Hayes Hall',
      latitude: 41.377925,
      longitude: -83.639979,
      imageUrl: 'assets/images/Hayes_Hall.jpg',
      location: 'Bowling Green, OH',
    ),
    Building(
      name: 'Kuhlin Center',
      latitude: 41.375126,
      longitude: -83.640155,
      imageUrl: 'assets/images/Kuhlin_Center.jpg',
      location: 'Bowling Green, OH',
    ),
    Building(
      name: 'Maurer Center',
      latitude: 41.375182,
      longitude: -83.639148,
      imageUrl: 'assets/images/Maurer_Center.jpg',
      location: 'Bowling Green, OH',
    ),
    Building(
      name: 'McFall Center',
      latitude: 41.375654,
      longitude: -83.640965,
      imageUrl: 'assets/images/McFall_Center.jpg',
      location: 'Bowling Green, OH',
    ),
    Building(
      name: 'Olscamp Hall',
      latitude: 41.377968,
      longitude: -83.637480,
      imageUrl: 'assets/images/Olscamp_Hall.jpg',
      location: 'Bowling Green, OH',
    ),
    Building(
      name: 'Shatzel Hall',
      latitude: 41.376327,
      longitude: -83.642559,
      imageUrl: 'assets/images/Shatzel_Hall.jpg',
      location: 'Bowling Green, OH',
    ),
  ];
  Map<String, LatLng> buildingCoordinates = {
    'BTSU Building': LatLng(41.377455, -83.640271),
    'Carillon Hall': LatLng(41.375662, -83.637580),
    'Central Hall': LatLng(41.376795, -83.637400),
    'East Hall': LatLng(41.376247, -83.636846),
    'Education Building': LatLng(41.376763, -83.638251),
    'Founders Hall': LatLng(41.375353, -83.641806),
    'Hayes Hall': LatLng(41.377925, -83.639979),
    'Kuhlin Center': LatLng(41.375126, -83.640155),
    'Maurer Center': LatLng(41.375182, -83.639148),
    'McFall Center': LatLng(41.375654, -83.640965),
    'Olscamp Hall': LatLng(41.377968, -83.637480),
    'Shatzel Hall': LatLng(41.376327, -83.642559),
  };

  LatLng getBuildingCoordinates(String buildingName) {
    return buildingCoordinates[buildingName]!;
  }
}

class BuildingsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.buildings.isEmpty) {
      return Center(
        child: Text('No buildings yet.'),
      );
    }

    return ListView.builder(
      itemCount: appState.buildings.length,
      itemBuilder: (context, index) {
        final building = appState.buildings[index];
        return ListTile(
          leading: Image.asset(
            building.imageUrl,
            width: 50,
            height: 50,
          ),
          title: Text(building.name),
          subtitle: Text(building.location),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BuildingLocationScreen(
                  latitude: building.latitude,
                  longitude: building.longitude,
                  name: building.name,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class Building {
  final String name;
  final double latitude;
  final double longitude;
  final String imageUrl;
  final String location;

  Building({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.imageUrl,
    required this.location,
  });
}

class BuildingLocationScreen extends StatelessWidget {
  final String name;
  final double latitude;
  final double longitude;

  const BuildingLocationScreen({
    Key? key,
    required this.name,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 16.0,
        ),
        markers: <Marker>{
          Marker(
            markerId: MarkerId(name),
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(
              title: name,
            ),
          ),
        },
      ),
    );
  }
}
