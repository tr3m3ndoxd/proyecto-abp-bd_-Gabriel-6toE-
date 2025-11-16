--creo la base de datos

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'ProyectosEducativosDB')
BEGIN
    CREATE DATABASE ProyectosEducativosDB;
END
GO 


-- despues de ejecutar el codigo antior agrego las tablas

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'ProyectosEducativosDB')
BEGIN
    CREATE DATABASE ProyectosEducativosDB;
END
GO -- GO es un terminador de lote para SQL Server, necesario tras CREATE DATABASE

-- 2. Usar la base de datos
USE ProyectosEducativosDB;
GO

-- -----------------------------------------------------
-- Tabla `Proyectos`
-- -----------------------------------------------------
CREATE TABLE Proyectos (
  id_proyecto INT IDENTITY(1,1) PRIMARY KEY,
  nombre_proyecto VARCHAR(100) NOT NULL,
  descripcion VARCHAR(MAX) NOT NULL, -- Cambiado de TEXT a VARCHAR(MAX)
  impacto_social VARCHAR(50) NOT NULL
);
GO

-- Insertar los 3 proyectos principales
INSERT INTO Proyectos (nombre_proyecto, descripcion, impacto_social) VALUES
('Concientización Natural', 'Ayudar a las personas a entender cómo sus acciones afectan al medio ambiente y realizar una guía informativa sobre reciclaje y cuidado de la vida.', 'Gran impacto'),
('Organización Eventos Escolares', 'Aplicación que ayude a organizar eventos escolares, ya sea por el día del estudiante, semana de la dulzura o cualquier festividad.', 'Impacto moderado'),
('Motivación Recreativa', 'Diseñar distintos elementos para captar la atención de las personas, basados en actividades recreativas o extracurriculares.', 'Gran impacto');
GO

-- -----------------------------------------------------
-- Tabla `AreasAcademicas`
-- -----------------------------------------------------
CREATE TABLE AreasAcademicas (
  id_area INT IDENTITY(1,1) PRIMARY KEY,
  nombre_area VARCHAR(50) NOT NULL UNIQUE
);
GO

-- Insertar las áreas mencionadas
INSERT INTO AreasAcademicas (nombre_area) VALUES
('Humanidades'),
('Artes'),
('Ciencias Naturales'),
('Matemáticas'),
('Ingeniería'),
('Ciencias');
GO

-- -----------------------------------------------------
-- Tabla `ProyectoAreas` (Tabla de unión N:M)
-- -----------------------------------------------------
CREATE TABLE ProyectoAreas (
  id_proyecto INT NOT NULL,
  id_area INT NOT NULL,
  PRIMARY KEY (id_proyecto, id_area),
  FOREIGN KEY (id_proyecto) REFERENCES Proyectos (id_proyecto) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_area) REFERENCES AreasAcademicas (id_area) ON DELETE CASCADE ON UPDATE CASCADE
);
GO

-- Insertar las articulaciones (asumiendo IDs 1, 2, 3 para proyectos y áreas, verificar si es necesario ajustar según el orden de inserción)
INSERT INTO ProyectoAreas (id_proyecto, id_area) VALUES
(1, 1), (1, 2), (1, 3), (1, 4), -- Proyecto 1
(2, 5), (2, 1), (2, 4), (2, 2), -- Proyecto 2
(3, 2), (3, 1), (3, 6);        -- Proyecto 3
GO

-- -----------------------------------------------------
-- Tabla `Actividades`
-- -----------------------------------------------------
CREATE TABLE Actividades (
  id_actividad INT IDENTITY(1,1) PRIMARY KEY,
  id_proyecto INT NOT NULL,
  nombre_actividad VARCHAR(100) NOT NULL,
  descripcion_actividad VARCHAR(MAX) NOT NULL, -- Cambiado de TEXT a VARCHAR(MAX)
  tipo_actividad VARCHAR(50) NOT NULL,
  FOREIGN KEY (id_proyecto) REFERENCES Proyectos (id_proyecto) ON DELETE CASCADE ON UPDATE CASCADE
);
GO

-- Insertar actividades específicas
INSERT INTO Actividades (id_proyecto, nombre_actividad, descripcion_actividad, tipo_actividad) VALUES
(1, 'Charlas Opcionales para Alumnos', 'Charlas informativas mostrando datos reales de contaminación y sus consecuencias.', 'Charla/Presentación'),
(1, 'Guía Informativa/Folletos', 'Creación y distribución de folletos con pasos para reutilizar, reciclar y evitar gasto de recursos.', 'Material Educativo'),
(1, 'Análisis de Contaminación Real', 'Uso de datos reales y análisis matemáticos sobre el impacto ambiental.', 'Análisis de Datos');

INSERT INTO Actividades (id_proyecto, nombre_actividad, descripcion_actividad, tipo_actividad) VALUES
(2, 'Desarrollo de Aplicación', 'Diseñar una aplicación con interfaz llamativa para la organización de eventos escolares.', 'Desarrollo Software'),
(2, 'Automatización de Conteo', 'Implementar funciones para el conteo automatizado de personas o datos necesarios para el evento.', 'Automatización/Funcionalidad');

INSERT INTO Actividades (id_proyecto, nombre_actividad, descripcion_actividad, tipo_actividad) VALUES
(3, 'Diseño de Carteles/Obras', 'Crear carteles u obras que requieran cierta cualidad para su entendimiento, como acertijos o idiomas.', 'Material Recreativo'),
(3, 'Ubicación Estratégica', 'Colocar los elementos en distintos lugares para motivar a las personas a aprender a resolverlos.', 'Logística/Implementación');
GO

-- -----------------------------------------------------
-- Tabla `Recursos`
-- -----------------------------------------------------
CREATE TABLE Recursos (
  id_recurso INT IDENTITY(1,1) PRIMARY KEY,
  id_actividad INT NOT NULL,
  nombre_recurso VARCHAR(100) NOT NULL,
  tipo_recurso VARCHAR(50) NOT NULL,
  ubicacion_url VARCHAR(255),
  FOREIGN KEY (id_actividad) REFERENCES Actividades (id_actividad) ON DELETE CASCADE ON UPDATE CASCADE
);
GO
