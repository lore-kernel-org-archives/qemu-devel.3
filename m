Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FC8C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 05:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUgVK-0005JZ-32; Tue, 30 Jan 2024 00:17:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1rUgVD-0005GM-LV; Tue, 30 Jan 2024 00:17:44 -0500
Received: from mail-bjschn02on2060e.outbound.protection.partner.outlook.cn
 ([2406:e500:4440:2::60e]
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1rUgVA-0004ja-1m; Tue, 30 Jan 2024 00:17:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hs8Qi9ol7qIYtnVJuQ+uRTafLhxhwOXs/wL6p2zas3MAPfShoUgEzuoDXNEHY95p5ugsCZTpOIk4PXQC2Cmiyp7sjxjJg7pb0TzbH7Np55Y5GQU3jEL+8E4ji24D++zJ647m/1lTcaouNLTNAmQXUkz9Nm8jR2zCrQKVfVuQTP6yM7g29HxPoaxzu5nuWfpZyHeYHCx17Gs8MKTHPLxYy5DQDYHx835vBzZqC6QxIJcAvUhLkBLHGYk2fCjQk/QmycFUHcypIVsxtFaa1RAEnllx++PnItbzhsdt+QYymcCd+D286FdF+AxVHvZkfvwlyhC3daxJYPZq4/uhD0eYQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ck85rC9hE9KwgWjGFoyCYQerQ56E7XEMXAdzJzo/fX4=;
 b=Av6qSGTRA0UqSyjOc3Xcl+rPzyT+jZ6DLe/B7vCPAUvoHM4L6RgZsINKwLPi8nCe2HApRIzzX1DWB4Ojw/PNebaAMwhM9dXuPRktuFNCPkBd/b8JyN3jRJ6SL5iX8H7uVgNGh2aa/tPTJZKo9IFEOoF0kLq1yqyDH5Sh2jc05ptYeUOlYW/Ztdkt4xsRK37KJ1NBm1pAfJMzjDIp2aJBHV82+Y23Jo2t4YHlQTGHgs33FwjNR0T0ZzU2R8ld0y2UqUG9plDyHYyH/2N/WnrAiwdivE7C0ZWbAfbwZLALSDmBII3FLlxLGISE7Y3GChG5aLtqH9SDqTdOIPGcZzWRsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0657.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31; Tue, 30 Jan
 2024 05:00:57 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7228.029; Tue, 30 Jan 2024 05:00:57 +0000
From: JeeHeng Sia <jeeheng.sia@starfivetech.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "anisinha@redhat.com" <anisinha@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "sunilvl@ventanamicro.com" <sunilvl@ventanamicro.com>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "bin.meng@windriver.com" <bin.meng@windriver.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "dbarboza@ventanamicro.com"
 <dbarboza@ventanamicro.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: RE: [RFC v1 1/3] hw/acpi/aml-build: Add cache structure table
 creation for PPTT table
Thread-Topic: [RFC v1 1/3] hw/acpi/aml-build: Add cache structure table
 creation for PPTT table
Thread-Index: AQHaUos4ncMKIC4KIEWLKRAMGgrrqLDwoEgAgAEkC5A=
Date: Tue, 30 Jan 2024 05:00:57 +0000
Message-ID: <BJSPR01MB0561E7899F52BC33FAD1A88E9C7DA@BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn>
References: <20240129081423.116615-1-jeeheng.sia@starfivetech.com>
 <20240129081423.116615-2-jeeheng.sia@starfivetech.com>
 <20240129110244.0000606b@Huawei.com>
In-Reply-To: <20240129110244.0000606b@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJSPR01MB0561:EE_|BJSPR01MB0657:EE_
x-ms-office365-filtering-correlation-id: 4b6bc7a9-9322-4b34-17ea-08dc215071fc
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FghOODAhwTCtBVB8HKN7n/d+mx12UohZ4NfEyj2XbHJZiculUGF9IUAgD27XzjUqO7rWxxOPm0q4jazNncOsb25sTYNXBsak5+Iep9jg1JNmYki9qij6261XQKIfkzWJGnnsIaFPm9oH2NcJEZkfc7ClLcny9ZwSTFKfLAQbTXiEqojC9fEnhKe0Nm6clW5jafaMnNQ9sQNR8oWrmMdL6SSU6Zi6yBG5BxEoFAkCPfRWz3ziRFuiApwVKZBwOCXihUZL7KOlPkjI6I9rklWyfH7camfMTQpe9W94DSCqqSVr7Y2+jglQzMfAExCAgtoUlbHShzVACfRYoJ7w//rs4Kci23NwwarT4TtaZzIxMYuqD+AwqfR/1c07pYj4NuznZ6wjVvj9WWOBZsyliSefXDYG7/dGfl4LaKEYaYLwPD2f8I7eW+Wco4PnhV1URE6rbBSR/AA/EYkd4M90DF86PdY/h/Fa2Q6Y/dMbCmPL6G1dlBIlF52m91cyIjKYYqy6UY10OCyM2q9yZlmK9cZtIab2cIA5IMmVzU85tywUyRJP9kCaIQbPXkqclvWrmwR8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(39830400003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(38070700009)(41300700001)(30864003)(2906002)(40180700001)(5660300002)(7416002)(33656002)(41320700001)(66476007)(8936002)(66556008)(66946007)(64756008)(966005)(66446008)(54906003)(6916009)(76116006)(86362001)(9686003)(83380400001)(40160700002)(55016003)(71200400001)(508600001)(53546011)(7696005)(4326008)(8676002)(38100700002)(122000001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?windows-1256?Q?z2r1AybyQEjaOVuVXqWMJGsdft3D+RsYkyJEUroL6grKpSnJAgkxXyz6?=
 =?windows-1256?Q?w1YNAcMIHOY7LSV9Dhw90zVVRUKAERtTSXn+FNBxqsoDUkit8nVE80MN?=
 =?windows-1256?Q?wIagyMnnCuHVYWsW8ifJ4hwdb7CknWSnrR/6j/DsjSad+RdLaHY9M6P+?=
 =?windows-1256?Q?Qyk45QXSkUMrwCtf9maJE+QVNMe8zV3KKjq5j09T5sG//U05/gYj8V2q?=
 =?windows-1256?Q?A3ZI1Qqbmc9AtVX34FfwZtm4VCTvO2A6XPSzx7WnqN5rVjr10jviBh7x?=
 =?windows-1256?Q?5Mm7gUc7xBuMnzdCIDOP4CR86MmQ5mr16dVRA3LnSgxzIM6HnrQSMoH8?=
 =?windows-1256?Q?/hAE2ZpVfMqv70e8Fy/WHY+gqO+XXh/EXIZsGtY1RZGDC1ylPlkHLoVV?=
 =?windows-1256?Q?aJUvu6qMd63+pzXce3FqU+zlUwZ3/L5eXvoxclOrIduQtyDM3WGdkFfj?=
 =?windows-1256?Q?V3ysFYmJwBgCf0BT6SzHKlQBS6hgcL67QKmJgHhGVmMtz07b4OnYi3ML?=
 =?windows-1256?Q?usyZbLdrKiTtaRo2+gzIDpByhBJMlMZME7mhG9sd83GmNU68bZq7CzAq?=
 =?windows-1256?Q?v/7Xf7wuoSQ+MpUbXRHAIbVAAyWQAM4Z73WziTwpxlahvJkLRblvqp6Q?=
 =?windows-1256?Q?TgZiA00nOvEE46eZF9YHh27qUSsGl1l0d2WsrE2ann9yHEjGtS8gUAAT?=
 =?windows-1256?Q?YJsqxAPUBWnStgw6Nxt1D1vuzmfWHrxHO4lYNmrhsp89uOKGEUDL8qd1?=
 =?windows-1256?Q?46fy2liKu4T8AFNPg/yriBfzQQ4MSC7vz2OgqvzpMf5xLnjP5z/t/EIV?=
 =?windows-1256?Q?fg7YyeqPDIMLnTmD4tM9Aq3qOu1huKkT8rCl692vJNOpL3L0L4mYTiCd?=
 =?windows-1256?Q?72Yqbwe9YMK5rArN6CUWDXrwsvlll609e/ANf0SV3pWdpXlFZtmp98LL?=
 =?windows-1256?Q?7vgEjUbomzbwRz0XKLrtqwXJolY6EveQm7omi/RFS72vvxOlx2nQzif1?=
 =?windows-1256?Q?oUVy2cKl8M9O3DxS91qxGVMV6nC5pP4J/vrMP6G3bSk7FJ9tAhxyigGc?=
 =?windows-1256?Q?rufBUrP40ByvUQGhvnIL7UFu7nbFqQrpkhk81UeEYmbkjIPjcEd2mcMP?=
 =?windows-1256?Q?a64QlPq00afowI9XIO4gR/Ilo68Jbd4fs/1dXMOu2Uw+spEMHASRoYBH?=
 =?windows-1256?Q?E++ocA6TbLGvG3xwYy3A6MdXH55ZoDNkVaULXD2O0wpvzSDxr6mmhSDY?=
 =?windows-1256?Q?9tsB1t0xzWbumeKj5J3J47AgCXVtDU5AJlo/ihSaibfG87a55qCTLX10?=
 =?windows-1256?Q?k2aq2fUTJID81HSYjdreCVh5vYSkajcp6SqpZNdHAwSA7UACutI4ltGK?=
 =?windows-1256?Q?cX70+Gq0VWGMdMqO0Kg9jMJcouoXHrMKo5hY2A6w+u60dMsP3KuK7JLp?=
 =?windows-1256?Q?HpcowiC8xPp1IA+oPQ4PAyI6R0OyHhYQvb2QyaQcHeJuCX9o8n1CXRBa?=
 =?windows-1256?Q?ebuVVwrPQw5jE1UjNegWfwY4ys+Rlv8k6gkjRjqofNdHK1wyOvpX8Ljh?=
 =?windows-1256?Q?K9Lm6s7SaRr5bD6rwJHVvo5uaSGp01ocpe6YOlaT+in7Lh3hS7eskvFO?=
 =?windows-1256?Q?Xi3W3LULzZSmft8f9DUAZieiSSEIJsoqlVJKionRBxljq54YLgW710Vg?=
 =?windows-1256?Q?bEfTWTIPFF00oDZAZlb0MVT5NXcEbpXEH49Wg1VvC6H9GxWKNaez0g?=
 =?windows-1256?Q?=3D=3D?=
Content-Type: text/plain; charset="windows-1256"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6bc7a9-9322-4b34-17ea-08dc215071fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 05:00:57.2989 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7lnQiO3AygQaMka3f3mzRk8pJYdptv9+cQ0y61uIHRO5q0xQlFfE9ZYKU+pc5rCXRnhllS2P/i/iJw2xzb1Vw64KI4DAqbn3KdBvvPSm2vo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0657
Received-SPF: pass client-ip=2406:e500:4440:2::60e;
 envelope-from=jeeheng.sia@starfivetech.com;
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Monday, January 29, 2024 7:03 PM
> To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org; qemu-riscv@nongnu.org; ms=
t@redhat.com; imammedo@redhat.com;
> anisinha@redhat.com; shannon.zhaosl@gmail.com; peter.maydell@linaro.org; =
sunilvl@ventanamicro.com; palmer@dabbelt.com;
> alistair.francis@wdc.com; bin.meng@windriver.com; liwei1518@gmail.com; db=
arboza@ventanamicro.com;
> zhiwei_liu@linux.alibaba.com
> Subject: Re: [RFC v1 1/3] hw/acpi/aml-build: Add cache structure table cr=
eation for PPTT table
>=20
> On Mon, 29 Jan 2024 00:14:21 -0800
> Sia Jee Heng <jeeheng.sia@starfivetech.com> wrote:
>=20
> > Adds cache structure table generation for the Processor Properties
> > Topology Table (PPTT) to describe cache hierarchy information for
> > ACPI guests.
> >
> > A 3-level cache topology is employed here, referring to the type 1 cach=
e
> > structure according to ACPI spec v6.3. The L1 cache and L2 cache are
> > private resources for the core, while the L3 cache is the private
> > resource for the cluster.
> >
> > In the absence of cluster values in the QEMU command, a 2-layer cache i=
s
> > expected. The default cache value should be passed in from the
> > architecture code.
> >
> > Examples:
> > 3-layer: -smp 4,sockets=3D1,clusters=3D2,cores=3D2,threads=3D1
> > 2-layer: -smp 4,sockets=3D1,cores=3D2,threads=3D2
> >
> > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
>=20
> Hi,
>=20
> I'm not keen on the topology assumptions this is making.
> If were to use this on our Kunpeng 920 for guests then the description wo=
uld
> be wrong as we only share the l3 tags at the cluster level, the
> L3 is die level (NUMA node). So for the physical machine we present
> a cluster with no associated caches.  For other platforms this would be
> even further from the truth.
Should you consider a file like kunpeng920.c and then pass the necessary
value to the build_pptt() function?
>=20
> If we are presenting caches in PPTT (which I do want to see) then
> we need additional controls to specify the levels at which the
> appropriate caches are found.
I understood and I'm wonder if adding default value meet your needs?
>=20
> There have been various proposals for how to do that description:
> https://lore.kernel.org/qemu-devel/20230808115713.2613-2-Jonathan.Cameron=
@huawei.com/
> was my brief go at this (and had PPTT cache descriptions).
I can spend time to try out your patches, but it will be good for a
short command. Btw, it seems you stop for many months, do you
plan for a v2 or I will continue by update with your v2?
>=20
> Maybe it's acceptable to have some defaults.
I would suggest to have some default value.
>=20
> A few other review comments inline.
>=20
> Give an example of the disassembled PPTT so we can see what is being
> built.  Need to clear if you are sharing descriptions across multiple
> instances of a given cache (which is allowed if no cache IDs).
> Looks like you do separate entries which is good because that's needed
> in latest definition (but wasn't in 6.3 and people built systems that
> didn't do separate entries).
Sure, here is the example output with clusters=3D2,core=3D2,thread=3D1
[000h 0000 004h]                   Signature : "PPTT"    [Processor Propert=
ies Topology Table]
[004h 0004 004h]                Table Length : 00000208
[008h 0008 001h]                    Revision : 02
[009h 0009 001h]                    Checksum : 88
[00Ah 0010 006h]                      Oem ID : "BOCHS "
[010h 0016 008h]                Oem Table ID : "BXPC    "
[018h 0024 004h]                Oem Revision : 00000001
[01Ch 0028 004h]             Asl Compiler ID : "BXPC"
[020h 0032 004h]       Asl Compiler Revision : 00000001


[024h 0036 001h]               Subtable Type : 00 [Processor Hierarchy Node=
]
[025h 0037 001h]                      Length : 14
[026h 0038 002h]                    Reserved : 0000
[028h 0040 004h]       Flags (decoded below) : 00000001
                            Physical package : 1
                     ACPI Processor ID valid : 0
                       Processor is a thread : 0
                              Node is a leaf : 0
                    Identical Implementation : 0
[02Ch 0044 004h]                      Parent : 00000000
[030h 0048 004h]           ACPI Processor ID : 00000000
[034h 0052 004h]     Private Resource Number : 00000000
[038h 0056 001h]               Subtable Type : 01 [Cache Type]
[039h 0057 001h]                      Length : 18
[03Ah 0058 002h]                    Reserved : 0000
[03Ch 0060 004h]       Flags (decoded below) : 0000007F
                                  Size valid : 1
                        Number of Sets valid : 1
                         Associativity valid : 1
                       Allocation Type valid : 1
                            Cache Type valid : 1
                          Write Policy valid : 1
                             Line Size valid : 1
                              Cache ID valid : 0
[040h 0064 004h]         Next Level of Cache : 00000000
[044h 0068 004h]                        Size : 00400000
[048h 0072 004h]              Number of Sets : 00002000
[04Ch 0076 001h]               Associativity : 08
[04Dh 0077 001h]                  Attributes : 0A
                             Allocation Type : 2
                                  Cache Type : 2
                                Write Policy : 0
[04Eh 0078 002h]                   Line Size : 0040

[050h 0080 001h]               Subtable Type : 00 [Processor Hierarchy Node=
]
[051h 0081 001h]                      Length : 18
[052h 0082 002h]                    Reserved : 0000
[054h 0084 004h]       Flags (decoded below) : 00000000
                            Physical package : 0
                     ACPI Processor ID valid : 0
                       Processor is a thread : 0
                              Node is a leaf : 0
                    Identical Implementation : 0
[058h 0088 004h]                      Parent : 00000024
[05Ch 0092 004h]           ACPI Processor ID : 00000000
[060h 0096 004h]     Private Resource Number : 00000001
[064h 0100 004h]            Private Resource : 00000038
[068h 0104 001h]               Subtable Type : 01 [Cache Type]
[069h 0105 001h]                      Length : 18
[06Ah 0106 002h]                    Reserved : 0000
[06Ch 0108 004h]       Flags (decoded below) : 0000007F
                                  Size valid : 1
                        Number of Sets valid : 1
                         Associativity valid : 1
                       Allocation Type valid : 1
                            Cache Type valid : 1
                          Write Policy valid : 1
                             Line Size valid : 1
                              Cache ID valid : 0
[070h 0112 004h]         Next Level of Cache : 00000000
[074h 0116 004h]                        Size : 00200000
[078h 0120 004h]              Number of Sets : 00001000
[07Ch 0124 001h]               Associativity : 08
[07Dh 0125 001h]                  Attributes : 0A
                             Allocation Type : 2
                                  Cache Type : 2
                                Write Policy : 0
[07Eh 0126 002h]                   Line Size : 0040

[080h 0128 001h]               Subtable Type : 01 [Cache Type]
[081h 0129 001h]                      Length : 18
[082h 0130 002h]                    Reserved : 0000
[084h 0132 004h]       Flags (decoded below) : 0000007F
                                  Size valid : 1
                        Number of Sets valid : 1
                         Associativity valid : 1
                       Allocation Type valid : 1
                            Cache Type valid : 1
                          Write Policy valid : 1
                             Line Size valid : 1
                              Cache ID valid : 0
[088h 0136 004h]         Next Level of Cache : 00000068
[08Ch 0140 004h]                        Size : 00010000
[090h 0144 004h]              Number of Sets : 00000100
[094h 0148 001h]               Associativity : 04
[095h 0149 001h]                  Attributes : 02
                             Allocation Type : 2
                                  Cache Type : 0
                                Write Policy : 0
[096h 0150 002h]                   Line Size : 0040
[098h 0152 001h]               Subtable Type : 01 [Cache Type]
[099h 0153 001h]                      Length : 18
[09Ah 0154 002h]                    Reserved : 0000
[09Ch 0156 004h]       Flags (decoded below) : 0000007F
                                  Size valid : 1
                        Number of Sets valid : 1
                         Associativity valid : 1
                       Allocation Type valid : 1
                            Cache Type valid : 1
                          Write Policy valid : 1
                             Line Size valid : 1
                              Cache ID valid : 0
[0A0h 0160 004h]         Next Level of Cache : 00000068
[0A4h 0164 004h]                        Size : 00010000
[0A8h 0168 004h]              Number of Sets : 00000100
[0ACh 0172 001h]               Associativity : 04
[0ADh 0173 001h]                  Attributes : 04
                             Allocation Type : 0
                                  Cache Type : 1
                                Write Policy : 0
[0AEh 0174 002h]                   Line Size : 0040

[0B0h 0176 001h]               Subtable Type : 00 [Processor Hierarchy Node=
]
[0B1h 0177 001h]                      Length : 20
[0B2h 0178 002h]                    Reserved : 0000
[0B4h 0180 004h]       Flags (decoded below) : 0000000A
                            Physical package : 0
                     ACPI Processor ID valid : 1
                       Processor is a thread : 0
                              Node is a leaf : 1
                    Identical Implementation : 0
[0B8h 0184 004h]                      Parent : 00000050
[0BCh 0188 004h]           ACPI Processor ID : 00000000
[0C0h 0192 004h]     Private Resource Number : 00000003
[0C4h 0196 004h]            Private Resource : 00000068
[0C8h 0200 004h]            Private Resource : 00000080
[0CCh 0204 004h]            Private Resource : 00000098
>=20
>=20
> > ---
> >  hw/acpi/aml-build.c         | 65 ++++++++++++++++++++++++++++++++++---
> >  include/hw/acpi/aml-build.h | 26 ++++++++++++++-
> >  2 files changed, 85 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> > index af66bde0f5..416275fdcc 100644
> > --- a/hw/acpi/aml-build.c
> > +++ b/hw/acpi/aml-build.c
> > @@ -1994,18 +1994,48 @@ static void build_processor_hierarchy_node(GArr=
ay *tbl, uint32_t flags,
> >      }
> >  }
> >
> > +/* ACPI spec, Revision 6.3 Cache type structure (Type 1) */
> > +static void build_cache_structure(GArray *tbl,
> > +                                  uint32_t next_level,
> > +                                  CPUCacheInfo *cache_info)
> > +{
> > +    /* 1 =E2=80=93 Cache type structure */
> > +    build_append_byte(tbl, 1);
> > +    /* Length */
> > +    build_append_byte(tbl, 24);
>=20
> If we are introducing cache descriptions, can we jump directly to the lat=
est
> definition. That has an extra 4 byte Cache ID field so length is 28.
We don=92t have the compatible acpi guest to test it, do you?
>=20
> I need that for MPAM support and I'd rather we didn't go through the chur=
n
> of first introducing cache descriptions then updating them (and the tests
> etc) soon after.
Does your acpi os support the cache id?
>=20
> > +    /* Reserved */
> > +    build_append_int_noprefix(tbl, 0, 2);
> > +    /* Flags */
> > +    build_append_int_noprefix(tbl, 0x7f, 4);
> > +    /* Next level cache */
> > +    build_append_int_noprefix(tbl, next_level, 4);
> > +    /* Size */
> > +    build_append_int_noprefix(tbl, cache_info->size, 4);
> > +    /* Number of sets */
> > +    build_append_int_noprefix(tbl, cache_info->sets, 4);
> > +    /* Associativity */
> > +    build_append_byte(tbl, cache_info->associativity);
> > +    /* Attributes */
> > +    build_append_byte(tbl, cache_info->attributes);
> > +    /* Line size */
> > +    build_append_int_noprefix(tbl, cache_info->line_size, 2);
> > +}
> > +
> >  /*
> >   * ACPI spec, Revision 6.3
> >   * 5.2.29 Processor Properties Topology Table (PPTT)
> >   */
> >  void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *=
ms,
> > -                const char *oem_id, const char *oem_table_id)
> > +                const char *oem_id, const char *oem_table_id,
> > +                const CPUCaches *CPUCaches)
> >  {
> >      MachineClass *mc =3D MACHINE_GET_CLASS(ms);
> >      CPUArchIdList *cpus =3D ms->possible_cpus;
> >      int64_t socket_id =3D -1, cluster_id =3D -1, core_id =3D -1;
> >      uint32_t socket_offset =3D 0, cluster_offset =3D 0, core_offset =
=3D 0;
> >      uint32_t pptt_start =3D table_data->len;
> > +    uint32_t l3_offset =3D 0, priv_num =3D 0;
> > +    uint32_t priv_rsrc[3] =3D {0};
> >      int n;
> >      AcpiTable table =3D { .sig =3D "PPTT", .rev =3D 2,
> >                          .oem_id =3D oem_id, .oem_table_id =3D oem_tabl=
e_id };
> > @@ -2024,10 +2054,11 @@ void build_pptt(GArray *table_data, BIOSLinker =
*linker, MachineState *ms,
> >              socket_id =3D cpus->cpus[n].props.socket_id;
> >              cluster_id =3D -1;
> >              core_id =3D -1;
> > +            priv_num =3D 0;
> >              socket_offset =3D table_data->len - pptt_start;
> >              build_processor_hierarchy_node(table_data,
> >                  (1 << 0), /* Physical package */
> > -                0, socket_id, NULL, 0);
> > +                0, socket_id, NULL, priv_num);
> >          }
> >
> >          if (mc->smp_props.clusters_supported && mc->smp_props.has_clus=
ters) {
> > @@ -2035,20 +2066,44 @@ void build_pptt(GArray *table_data, BIOSLinker =
*linker, MachineState *ms,
> >                  assert(cpus->cpus[n].props.cluster_id > cluster_id);
> >                  cluster_id =3D cpus->cpus[n].props.cluster_id;
> >                  core_id =3D -1;
> > +                priv_num =3D 0;
> > +                l3_offset =3D table_data->len - pptt_start;
> > +                /* L3 cache type structure */
> > +                if (CPUCaches && CPUCaches->l3_cache) {
> > +                    priv_num =3D 1;
> > +                    build_cache_structure(table_data, 0, CPUCaches->l3=
_cache);
> > +                }
> >                  cluster_offset =3D table_data->len - pptt_start;
> >                  build_processor_hierarchy_node(table_data,
> >                      (0 << 0), /* Not a physical package */
> > -                    socket_offset, cluster_id, NULL, 0);
> > +                    socket_offset, cluster_id, &l3_offset, priv_num);
> >              }
> >          } else {
> >              cluster_offset =3D socket_offset;
> >          }
> >
> > +        if (CPUCaches) {
> > +            /* L2 cache type structure */
> > +            priv_rsrc[0] =3D table_data->len - pptt_start;
> > +            build_cache_structure(table_data, 0, CPUCaches->l2_cache);
> > +
> > +            /* L1d cache type structure */
> > +            priv_rsrc[1] =3D table_data->len - pptt_start;
> > +            build_cache_structure(table_data, priv_rsrc[0],
> > +                                  CPUCaches->l1d_cache);
> > +
> > +            /* L1i cache type structure */
> > +            priv_rsrc[2] =3D table_data->len - pptt_start;
> > +            build_cache_structure(table_data, priv_rsrc[0],
> > +                                  CPUCaches->l1i_cache);
> > +
> > +            priv_num =3D 3;
> Ah.  This one - whilst it's hard to derive from the ACPI spec,
> intent is that the hierarchy node should only point to the the caches
> that are nearest to that node. So here priv_num should be
> covering both the l1i and l1d but not the l2 which should only be
We can follow kunpeng arch, np.
> found by following the next level info in the other two caches.
>=20
> See the example in Figure 5.15 of ACPI 6.5
> - the spec doesn't 'enforce' it because the original text
>  was vague so that would be backwards compatability issue,
> but does include
> "Only the head of the list needs to be listed as a resource by
> a processor node (and counted toward Number of Private Resources")).
> Take that as a strong hint!
>=20
>=20
> > +        }
> >          if (ms->smp.threads =3D=3D 1) {
> >              build_processor_hierarchy_node(table_data,
> >                  (1 << 1) | /* ACPI Processor ID valid */
> >                  (1 << 3),  /* Node is a Leaf */
> > -                cluster_offset, n, NULL, 0);
> > +                cluster_offset, n, priv_rsrc, priv_num);
> >          } else {
> >              if (cpus->cpus[n].props.core_id !=3D core_id) {
> >                  assert(cpus->cpus[n].props.core_id > core_id);
> > @@ -2063,7 +2118,7 @@ void build_pptt(GArray *table_data, BIOSLinker *l=
inker, MachineState *ms,
> >                  (1 << 1) | /* ACPI Processor ID valid */
> >                  (1 << 2) | /* Processor is a Thread */
> >                  (1 << 3),  /* Node is a Leaf */
> > -                core_offset, n, NULL, 0);
> > +                core_offset, n, priv_rsrc, priv_num);
> >          }
> >      }
> >
> > diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> > index ff2a310270..2dd949f41e 100644
> > --- a/include/hw/acpi/aml-build.h
> > +++ b/include/hw/acpi/aml-build.h
> > @@ -234,6 +234,29 @@ struct CrsRangeSet {
> >      GPtrArray *mem_64bit_ranges;
> >  } CrsRangeSet;
> >
> > +enum CacheType {
> > +    DATA_CACHE,
> > +    INSTRUCTION_CACHE,
> > +    UNIFIED_CACHE
> > +};
> > +
> > +typedef
> > +struct CPUCacheInfo {
> > +    enum CacheType type;      /* Cache Type*/
> > +    uint32_t size;            /* Size of the cache in bytes */
> > +    uint32_t sets;            /* Number of sets in the cache */
> > +    uint8_t associativity;    /* Cache associativity */
> > +    uint8_t attributes;       /* Cache attributes */
>=20
> Incorporates the type.  I would avoid duplication by having a couple more
> enums to cover the other flags in here rather than having to fill type
> in 2 places.
This struct is almost identical to the acpi guest os, it gives great readab=
ility.
>=20
> > +    uint16_t line_size;       /* Line size in bytes */
> > +} CPUCacheInfo;
> > +
> > +typedef
> > +struct CPUCaches {
> > +        CPUCacheInfo *l1d_cache;
> > +        CPUCacheInfo *l1i_cache;
> > +        CPUCacheInfo *l2_cache;
> > +        CPUCacheInfo *l3_cache;
> > +} CPUCaches;
> >
> >  /*
> >   * ACPI 5.0: 6.4.3.8.2 Serial Bus Connection Descriptors
> > @@ -490,7 +513,8 @@ void build_slit(GArray *table_data, BIOSLinker *lin=
ker, MachineState *ms,
> >                  const char *oem_id, const char *oem_table_id);
> >
> >  void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *=
ms,
> > -                const char *oem_id, const char *oem_table_id);
> > +                const char *oem_id, const char *oem_table_id,
> > +                const CPUCaches *CPUCaches);
> >
> >  void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f=
,
> >                  const char *oem_id, const char *oem_table_id);


