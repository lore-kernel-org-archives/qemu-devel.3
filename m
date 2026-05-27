Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D6BCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 08:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS9gc-0001J4-4O; Wed, 27 May 2026 04:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wS9gX-0001FQ-Hs; Wed, 27 May 2026 04:32:17 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wS9gV-0003xv-9b; Wed, 27 May 2026 04:32:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uo5aBxarWnfgXPPhznybOzHcxzx4h+44ohS1gKPVvGxmEl8RlNCaVEXunsKmasvTiDezFYu49nix9s0ofQ8X27bJxQZEn3sVjPViwnyOJU4NRc0yZXmyZB0jVRV/4dBSGEahahrpkNvvTAhG8Km/TGhDggd4CKd6LpEj/Dv3rY/KCKW/rFvrM8wNwPXG6RkhaS/1pCZZF58O9Wmb1flLC/Rq4ElBK0Gj3yUeFIVhLmf/6514MLf144uBabOtq+DI9ZoRvDK2smqaTn6jgdq28XEzTK40G6fPv2AuKDKZv1qSXjKV1GurlZqXxC442KFVq/wDGYLRlzXENZ8KMokGkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EodHH3ajZBCu9QLgL6otieUKJJWjoS/7gqwcpP2KMhY=;
 b=w5EsNnvpjJLXABHFP5GigH6PNflj/0+3A+CoeLjARAlWNxHWwdlOMW8Ah/ATPIigzsXaStMopdRukgA1vvn8jna+f2foSl7JZt1e1IF1e8W/AaJKaLKdBikjOg0Fw4/LnEHcIbehjXGCNw6Aelzb9ux/c2lQ6nHTsF6Wvp/mgRyyxeUkrbUXIrWvxwRiW+hOOJhuAbLwW91kmUCt5hMvAdY7aL7OnWrDYSrcOCVTAyAcAsy+jPOnZe7USNXMSNyYu6BLPGGyqvh7Zp9Qv4i1ZptGy3rDxOeY0f/ULWfnhLLOBRZurSvfhYbpG9zhFbhtONMnthYOtPvCvCx/ltsvOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EodHH3ajZBCu9QLgL6otieUKJJWjoS/7gqwcpP2KMhY=;
 b=YYH+awKhPzKCglAJEQBoDYkEFQGoXV1ZmPx5AHEGT23nCjQWLvC2H2G2Yzhhwze7xQFxu0nEy1Ri6vIbrDpI9wcq86nHy99yZAXul1WGUN8mRMtPLaXYT/VlNJU9kBiwTRWWDkKv40Liys+Z77vHhbM3OBdySgHNMgV54S+oTJrm54N8GwWDIutnAGClgxT4/riKMgvznd76nwNcz+bjbeUsSUNiUXaQ4Y7GilSqv1RJxflnrrkWapTMhOHn7JyZqT/PN45j8/doCWpZxFymBgT+JkEyW39z4lb7eGn+2KY6nGehIn3frmaDRAW6g+8H+dMmbjSshcrhGMsNmmaQqA==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by AS8PR09MB6314.eurprd09.prod.outlook.com (2603:10a6:20b:57d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 08:32:01 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 08:32:01 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v10 6/7] target/riscv: Expose big-endian CPU property and add
 documentation
Thread-Topic: [PATCH v10 6/7] target/riscv: Expose big-endian CPU property and
 add documentation
Thread-Index: AQHc7bNJmxAyTPNjUUOvcdq2L2i92g==
Date: Wed, 27 May 2026 08:32:00 +0000
Message-ID: <20260527083151.17876-7-djordje.todorovic@htecgroup.com>
References: <20260527083151.17876-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260527083151.17876-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA2PR09MB7634:EE_|AS8PR09MB6314:EE_
x-ms-office365-filtering-correlation-id: 3be0575d-061f-4178-daf0-08debbca6c77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|6133799003|3023799007|11063799006|56012099006;
x-microsoft-antispam-message-info: pfKhPr7fQaCkG8bsBeKeD2CxcxSiGDwUT5KOdxFM65aYLorQE++2jvVdrv6G0/65PzISIsQ3IAfgGRJRh5OJmes0J/5EzyaWgI6Vg0uD15FciBLbPFEZ1/11XvTVLaUli/EReABiF7d6NZklm/KJpvokEsxKSQomwGj9ewCFEUOr+zWB00vp5zWRgXYTaJCA3YpV+38b0qpbWSV7nYijaND+1nQ56IrAqNsRzbqk0mjZRCkSKzGSthPtm1R1wWZT5JCxAWXHtDURvflBADEImf9aNVLT2njC3uQcdErfUxoGoHzQeUyYaC17eBf1gbkNNrve7FL2XXm+1BulBfKSZot5L1YlmGZqc3RB436m2w8MPbQ9+RYDXvewmCs59fGdyOr/jpfQcjkSC15Qw7fmXflohrkyhvfEDhOGq2Q3T38k6vz17ckG/jJOHXZ+uVpjDhaoCrvWlR3dVdHSdIPb7wpaqkw6OangP+crhcJBpX0PBWAneYIkes8wZZH41T29CKQJ1i9i6+Q1pPbNsPk0URwzNHdqSaflHhhXtKl38ulCaHsiNiAYIAlCuD3QGFN1+uX/18m/HDBWnDKC0ETMCHSKtpEVhnP/9zlONl80lOUa6lGMt+ybUSpuYrAk0OWMZXqJ947ooj4f2GyTb+XYM5AV9UBuiRh4q/SGn/cP2Lo8TDzJ9KH2DsG1tvIl3WHn2EGdP91bVUS2oY9wVcXsBbo3d+BeJ0O8/iGlWDgtTMQ8qjpmJ9hCobGc78aXQgtV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(6133799003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Z/PvpL572pWBzvTw9jaxZPJ5L/1ziC6bTLl1sbxRu4kC1ZcQk5k3yuBgad?=
 =?iso-8859-1?Q?ig610eW8ajYbUOJ5RTdu5Z0L3sx73KaTJIXajt+fDCoj2nKfpqNCbqPSJi?=
 =?iso-8859-1?Q?OTaKx6fyKaPmqkwCqEverx/Ll8x6gMPzlyiR6Zhfb4DXkRT48GOvuW3j6h?=
 =?iso-8859-1?Q?Rg/54ydBD3zLHnj1zolUbk1BUEpaAjPY3H2cXDiyvnkl1qmcKKT0nODTb+?=
 =?iso-8859-1?Q?BF1auvM39/P+LWyekM1HGp1o1sCGT6oK72OiJdxQ683P5+9AwGS3wcPuDB?=
 =?iso-8859-1?Q?DlgahAbVLPSTlnW4cG/J7yNT3PNOKk5H1bglt777vAmzxW/gQgE25N3v0M?=
 =?iso-8859-1?Q?1d4p7wt+f5elhP/bZdujnbAKQMYZ4ouTJSGuIS/lb/d5T6JGBE0+7QKNF3?=
 =?iso-8859-1?Q?C1lN1kWkD17Ee0e7yeOlcBcgw+7H5R4sL65AqgxDfL+GHOz5IsAjm6nVfs?=
 =?iso-8859-1?Q?IUPMNICm6fjOCpttTKT2D3Wn5zkT8NH5lbwOdfTdQ5304l3HJ1/+bqVTsX?=
 =?iso-8859-1?Q?em36JGBfkVJflceOha+KJuPDF8HolLkDYCGaCfNki9QvVKvz5hgqlahnc3?=
 =?iso-8859-1?Q?55oS+LmcWVTIooJ2ZWznrBkmJafr9glaUGlWMrnIWAUkRNFKkfnhTQC/oa?=
 =?iso-8859-1?Q?oozjp66dP9fsEiriu2Cjk278DGHRAIgGV5cFlvNJcp9qGm01kTsr9ONnaX?=
 =?iso-8859-1?Q?QEuXWiGWZbRvKjG4fnljj7WByknRUSchzFjiu76f37yngWit1mILgAOkno?=
 =?iso-8859-1?Q?f+r6qam5U6LPqm2lC7Lbk8G2LLrmYb6iFf6CZaHzKhG6aHxeZD8acGfSNM?=
 =?iso-8859-1?Q?9J2kxTSYQ3Vp7n2tsiRB1pK+lK2d6vlc+dTHsBnGr0QGtBhSENhrLduIL7?=
 =?iso-8859-1?Q?HYM6DKB72KkNLc2yWgRX0wGsMnrF2tSdBtyNs5vraQgnRW72KFzTeHuVWJ?=
 =?iso-8859-1?Q?EFG6GDexxq1T1XtmXRiDU3K4EPd44dQH2KT+uM1zL3+JxcgncOE8lGy/s8?=
 =?iso-8859-1?Q?qr32hDqia7OgMzxNZufxSj2yTk/FPmuc0hesSQIjDYoV8MFPlzIBQr6b1s?=
 =?iso-8859-1?Q?+53BpB3h/XK94U+t3wh7qVtE8Vxv2PXEf2c2zYZGpbJYpcPoUXufJ2lTBk?=
 =?iso-8859-1?Q?34n1Y6n6m2qo48AF/rniEbEl9CNw8CkKnuiQAZAVxCwP8qsq9cspL6o0V9?=
 =?iso-8859-1?Q?lH6iNRhfKKcoVr60QBNaWBvsLEewtgvZ2lPyU4vMychDFOzMqgs+ISaoj5?=
 =?iso-8859-1?Q?E9Q7dcbd3D6ejOsxAFdhgtS6dZBR3PevXz8cJIfeg6KmNmg/d/XlPJYift?=
 =?iso-8859-1?Q?e/B7DTrrvSj2+yZrU8pz90DQaV8dZQeTdg+S6zNpF8BaA/GTj4XDye7ULg?=
 =?iso-8859-1?Q?iTw0vrWyl3fSRh4xzpQcc8i17c7hm3VCAms8pwd2HawkeJ0sJkr+l9jA7D?=
 =?iso-8859-1?Q?vlfKRlOPcibVkH0BS9wYLtaEj6dM3eJPNH9pzigJUxqhQfzEfZufUerPDg?=
 =?iso-8859-1?Q?r7VAUm28ap0UArpj7Bz9oWeGvpBHaX9xe/bll+ccozM7xbxkPJFU9Rp/s7?=
 =?iso-8859-1?Q?NRPAGPs33uLra7C+k3wloDkUAtpJDfRdCRXkG3/N+cPZUWDx54O7/CZltu?=
 =?iso-8859-1?Q?mvPKcJ2WUXLuw/nhOGU6jCZ+DUCex78vdfCpizePzR9Sp8LvKB0qg2U5fu?=
 =?iso-8859-1?Q?hGnWqYgbBRRUG5Pi8vqAEz25OHZb+P1wP2gCicY7JRDMFLB79/s2DTBuAY?=
 =?iso-8859-1?Q?Stsmgx6LYQL90RUCwjm4jHNPLkOt1IiQ2obNEa38hSRzF7M/drGw6kX0uV?=
 =?iso-8859-1?Q?q48WqBG5eUclUjZmvxT78lIWtwlVd+fmkNMNWlDriV36RgU10wwh?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be0575d-061f-4178-daf0-08debbca6c77
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 08:32:00.5466 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MKpBHv4RJxNBGECmZl/RXq8s8CdzbBUJOIHdOs4zFxLLOguo5r2vRD0plPRrHvQkRbp9/0sejOPNu1gT99MHN9lVht8f9hKqsoXKhYLdLXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR09MB6314
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Now that the full big-endian data path is in place (runtime MSTATUS
bits, boot code, and page-table walks), expose the "big-endian"
property to users via DEFINE_PROP_BOOL and document it in
docs/system/target-riscv.rst.

Document that the property models fixed-endian hardware: it selects
harts whose MBE/SBE/UBE fields are fixed to 1, and it does not model
a mixed-endian implementation where software can toggle those bits at
runtime.

The property can be enabled from the command line, e.g.:

    -cpu <cpu>,big-endian=3Don

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 docs/system/target-riscv.rst | 29 +++++++++++++++++++++++++++++
 target/riscv/cpu.c           |  1 +
 2 files changed, 30 insertions(+)

diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index 3ad5d1ddaf..afd86ca2ba 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -95,3 +95,32 @@ the images they need.
 * ``-bios <file>``
=20
 Tells QEMU to load the specified file as the firmware.
+
+RISC-V CPU endianness
+---------------------
+
+The RISC-V ISA specifies that instruction fetches are always little-endian=
,
+while data accesses can be either little-endian or big-endian under contro=
l
+of the MSTATUS ``MBE``/``SBE``/``UBE`` bits (see section 3.1.6.5, "Memory
+Endianness", in the RISC-V Privileged Specification).
+
+QEMU implements the full data-endianness behaviour described by those bits=
.
+In addition, the RISC-V CPU object exposes a ``big-endian`` boolean proper=
ty
+which models a big-endian-only hardware implementation, where the
+``MBE``/``SBE``/``UBE`` bits are hardwired to 1. When the property is set,
+the CPU is reset with all three bits initialised to 1, so the guest starts
+executing in big-endian data mode from the reset vector. The property is a
+static, per-CPU hardware configuration option and is not meant to be toggl=
ed
+at runtime.
+
+The property does not model a mixed-endian implementation where software c=
an
+toggle ``MBE``/``SBE``/``UBE`` at runtime. QEMU's RISC-V CPUs treat these
+fields as fixed by the CPU configuration: they are reset to 0 by default a=
nd
+to 1 when ``big-endian`` is enabled.
+
+The property can be enabled from the command line, for example::
+
+    -cpu <cpu>,big-endian=3Don
+
+No upstream CPU model currently defaults to big-endian; the property is
+provided so that big-endian-only RISC-V CPU variants can be modelled.
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 42d1b3662c..d93ee532df 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2661,6 +2661,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rule=
s[] =3D {
=20
 static const Property riscv_cpu_properties[] =3D {
     DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
+    DEFINE_PROP_BOOL("big-endian", RISCVCPU, cfg.big_endian, false),
=20
     {.name =3D "pmu-mask", .info =3D &prop_pmu_mask},
     {.name =3D "pmu-num", .info =3D &prop_pmu_num}, /* Deprecated */
--=20
2.34.1

