


8.



create table [daugiabutis] (
	 [daugiabutis_id]			int	identity(1, 1) primary key
	,[adresas]			nvarchar(64)	not null
);


create table [butas] (
	 [butas_id]			int	identity(1, 1) primary key
	,[butoNr]		int				not null
	,[daugiabutis_id]	int not null REFERENCES daugiabutis(daugiabutis_id)
);

create table [Gyventojas](
	[gyventojas_id]			int	identity(1, 1) primary key
	,[vardas]		nvarchar(64)	not null
	,[pavarde]		nvarchar(64)	not null
	,[butoID]			int	not null REFERENCES butas(butas_id)
)



insert into [daugiabutis] values 
(N'Valakampių 12'),
(N'Apkasų 15'),
(N'Žirmūnų 46')

insert into [butas] values
(1,1),(2,1),(3,1),(4,1),(5,1),(1,2),(2,2),(3,2),(4,2),(5,2),(1,3),(2,3),(3,3),(4,3),(5,3)

insert into [gyventojas] values
('Fuadas Marius', 'Alijevas',12),
('Svetlana', 'Garbyte',9),
('Vaidote', 'Mika',9),
('Vytas', 'Mika',9),
('Arturas', 'Grigura',15),
('Ayste', 'Grigura',15),
('Akvile', 'Buke',11),
('Jelena', 'Chleva',11),
('Igne', 'Gonbao',4),
('Edmundo', 'Kuci kuci',4),
('Ryo', 'BUci',3),
('Lego', 'Edgo',5),
('Dima', 'Legasov',8),
('Bruce', 'Wayne',4),
('Martukse', 'Tutifruti',10),
('Martyna', 'Vaske',3),
('Pao', 'Chao',6),
('Paulo', 'Baleni',5),
('Fabio', 'Margareti',4),
('Ogdo', 'Bogdo',3),
('Vytas', 'Kristo',2)

--------------------------------------------------------------------------------------------------------------------------------------
9.




create procedure dbo.gautiVisusGyventojus
as
begin

	SELECT 
		db.adresas as 'Daugiabucio adresas / daugiabutis'
		,b.butoNr	as 'buto Numeris'
		,g.Gyventojai
		,COUNT(ga.butoID) as 'Gyventoju skaicius'
	FROM daugiabutis db
		inner join butas b ON b.daugiabutis_id = db.daugiabutis_Id
			inner join gyventojas ga on ga.butoID = b.butas_id


			inner join (SELECT DISTINCT butoID,						-->> gyventojas
							SUBSTRING(
								(	SELECT 	', ['+ convert(varchar, g.gyventojas_id) + '] ' + g.vardas + ' ' + g.pavarde  AS [text()]
									FROM gyventojas g
									WHERE g.butoId= gyventojas.butoID
									FOR XML PATH ('')
								), 2, 1000) [Gyventojai]
						FROM gyventojas) g ON g.butoID = b.butas_Id --<< Gyventojas

	GROUP BY db.adresas, b.butoNr, g.gyventojai
	order by 1,2 desc;

END


-- kviesti procedurą
EXEC dbo.gautiVisusGyventojus;