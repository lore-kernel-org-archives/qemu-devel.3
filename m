Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6448C369DC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 03:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBm6I-0004TW-DW; Sun, 04 May 2025 23:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1uBm6F-0004Sz-MZ; Sun, 04 May 2025 23:02:35 -0400
Received: from mail-koreacentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::7] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1uBm6D-0001hy-GL; Sun, 04 May 2025 23:02:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7ALj6nBTlHRHnWX7q2oMwynvtsAHIlKSnXA8R27sLV6W6YW9A0qDuKr7ZwWUHhzOIwRN8g3WOhRU7h1I60sCP7K67/2Vg8wdEoOLkeOO2k4h39X96JN5R1P0XGj+evQRvE1485Uuz7Sg/oUdcbJ9bOM3S+r+SjE+elITQg3rt22cpZchK1sYIDpseTlt29L8HJ/CseeA5Z5sXMm1t6UPjyuMjoSmLCs+WvQVZepgmofhS5B9EonHDkVnkrQabPeOmjrihNP/R/7mUDQxu3Wy8KCYOXvzpB1FL0mygOJJfNsVqPMgPgau84/AVFx2vVwB6BkwTTyQj7k8TaQ81UHbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShQWlBWAsR23xkwqLebKgJCKMW5NCzBoYTj4yf6NOkw=;
 b=lp0wVY37FMtmFRxyAyXvJwG5QjKm2o0mV0jEtK9dx0ZpdBh98hr18eG4I4KAeKlpUiQHDK/EbHyY2+pS2FzYvxV6SwRl692PcRCOOIGv5r+I1c0GTxWE0yIhWEwJZzdThhcXwGw1xkVYkmBfvggJdrjSoFUaSEtJcae5nLfSl87nBEUIuxzib6eS4iR4VBaKDvtBtLW19615GDRaLXVwrKy4iOFD9n4vs1Cx2DkqorKvdigRE//PxHGT/sCD27U3iz0DRpdPEz7B1zv0YTDRh+zF64DdHAgzb/CXoFXG+z9gTR5mwb3oozbqPtYvwkLTJwWQ8dkscj2laSPlw4CwFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShQWlBWAsR23xkwqLebKgJCKMW5NCzBoYTj4yf6NOkw=;
 b=geCk/JDaX0LeYnfjI+U496Cx+CuB3SuN0hwp0i/UQMkDMOJcroLgq1WfYtienOMy+UOu5HvRgkqoI38gPkZ5MmxXqdKpCMAmBZoX5MxqejmUAOShAv941J6TIjs0Cwzjihxb8xMZsAvwWEF1WgYv/obhXzdNEh/Ehq0ovc/IKfU=
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TYZPR03MB7789.apcprd03.prod.outlook.com (2603:1096:400:452::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Mon, 5 May
 2025 03:02:26 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%6]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 03:02:26 +0000
From: "KFTING@nuvoton.com" <KFTING@nuvoton.com>
To: Tim Lee <timlee660101@gmail.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "wuhaotsh@google.com" <wuhaotsh@google.com>,
 "CHLI30@nuvoton.com" <CHLI30@nuvoton.com>
Subject: RE: [PATCH] hw/arm/npcm8xx_boards: Add auto zero flash image and
 device part number
Thread-Topic: [PATCH] hw/arm/npcm8xx_boards: Add auto zero flash image and
 device part number
Thread-Index: AQHbouRahPv1vrkqgUOqzatIKn8Zk7PDjkaA
Date: Mon, 5 May 2025 03:02:26 +0000
Message-ID: <TYZPR03MB6896EA5FCFA59210EFBD0CC3DB8E2@TYZPR03MB6896.apcprd03.prod.outlook.com>
References: <20250401085903.224787-1-timlee660101@gmail.com>
In-Reply-To: <20250401085903.224787-1-timlee660101@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6896:EE_|TYZPR03MB7789:EE_
x-ms-office365-filtering-correlation-id: 57607d0c-c891-4f2e-5e14-08dd8b814438
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?gSArOoCGf6mSA71syBnf+J7l3d+WfV7TfGPUFwy4hu8XrhJtFYg9VTQwJGSQ?=
 =?us-ascii?Q?5TcLR3hEM6nGFZILL5KmvYsfGJyL6bhdraxVXyjqL2jneTCHds3yQjEHtwrw?=
 =?us-ascii?Q?41qxmL44Lszlo5rq53P5uusgIRrFU6lKe+MsTZ0zYQRACEQkfZKNxOjm8Hny?=
 =?us-ascii?Q?3I5eoZilSUPmxTIxOMb+ouhJUvQqubyhteCRULVe2tBsvEiB9BmY1OQjqdmt?=
 =?us-ascii?Q?ab6gQIZi8UXS5FJRudFmE+tSdJpnYcfeEu7bzdyzsgdT0iNd16YYT3T5J7Xc?=
 =?us-ascii?Q?Yo7X3DhY2K7L0+HSPxbzEEx1BZiPUg6a/fwJctjgiaOsd2Ltbsg/630rAmf4?=
 =?us-ascii?Q?4OS2DdieVQwtlbiq0yZ3DGftoEzcfnMlEngj7Sz92yPDnHq1MuvvoOffOmKJ?=
 =?us-ascii?Q?zihUg5vKf+iAgF3Lu/a8iuEDwueFXVGkxTjvAjtF23p4pzb8+SgVRRvzzoVs?=
 =?us-ascii?Q?YFNIQeSFEHzBrFvmH09p78QVx9eihSOMUt6yAoXtd9bP+ESYkCGecl54bjo3?=
 =?us-ascii?Q?vsYCMrEuzfAhHc32ZbPVOoHyYJVtnZR774NRQT0JVBDTVjtlAbQUsQUfK4mP?=
 =?us-ascii?Q?1irsDDcRGP/3WtS65v7OjWG1nftPEyTRnaaCOH52cyur4qsAtPJVhFztHS1T?=
 =?us-ascii?Q?T1LlWcP10pyUbXYHyexD/Yp3rzy6LB8/+0twY49S9xEds4J/usO7sNgll2E6?=
 =?us-ascii?Q?n4qlsNxWWHP/mrwC3RTTOlO/7RoGl3nuiKG+biappp/o7lOhznn0ZX3O02SP?=
 =?us-ascii?Q?QB94K4hxmAufiCrUqQuZHcw6xQxxA4iXA8WMdA5Ayz7Mc+8FAy+Ki/4Pynod?=
 =?us-ascii?Q?59h2T/QhFCUBk9WGE7cXZIf5zDvaEq3kK+rxRoCtzdlwts7mqhtOBfTXAIXD?=
 =?us-ascii?Q?NU02J9ynEGq4bI7LmWGeLJ2xJG2gZNQvlB8z5h2GLqZIyTa2iuKvzUdKV54i?=
 =?us-ascii?Q?ftepAdLg7G3Jb0+wmJdJQNzM1qNRNrB44UssVuj47759yRPAxYCSUJUjGeKy?=
 =?us-ascii?Q?ZTQMqGbaJwTRE7uHT5f3J9H02F0YqO13ybKLPXrD2yXXs448fIEgxlQya3Jn?=
 =?us-ascii?Q?lMNtwQPGqZOl+l8MXYKKYotsxCVZkBOM5fuaqBCNFcFLMVWdn+ScrmNpv2YR?=
 =?us-ascii?Q?aD2hO4Y+7mlfrGvCVZSlEHRJBYPQltzAPHTwY4Z35WvZHuQ1/ZPh6LTjtq8R?=
 =?us-ascii?Q?VtIDqZu8z21fSEsEsiFFac91RkJ4kKcCp4BuUYltfhYU/jcSxj2P8CSVpyEC?=
 =?us-ascii?Q?rCq74TtBY7vGClxvIzeLP9PBA4s/4wsIfOs6/0K4vEBhFb+yVBFibiEPnhJq?=
 =?us-ascii?Q?ADov3wCudBJRECkwEHAskY9WsCQ6SaQ8kuI6pZao5mNtmX4fzG2uggVV0yRe?=
 =?us-ascii?Q?YMwRknwfWm5evbDVhJRWQeC9y11P9IBLdh5Ull41Dgg2UNjnTHVjqGodEPTz?=
 =?us-ascii?Q?zrO7PQAw7luAtPqK9f5WiXzpskCpXW/Cp3TtbhhsI63WVOBiuSUtQw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6896.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HDwPzalvbvbCjbBKl7f3RBbNd7NdjSYbGJxNQ9+z4/htPd5Q5amEQ0w8/jw3?=
 =?us-ascii?Q?tGPZoGu4l0RhNWuTw8k4SRjznv9eckxXj4722BuQLZPAKGMT8NdbZ5cIo6vh?=
 =?us-ascii?Q?205mVSpOQ5XYm1xQoojXoXu/36X0jfHCir4AXdibLr3Ayk71gpLuaAjq5UmD?=
 =?us-ascii?Q?UxuY4CbF7MVaHvonlDz3ggM8f29Td7m3gdCpYdvg1f9V5XRbAQ58lVYE5JKa?=
 =?us-ascii?Q?isXlQD2g1SKvHarVt6RDKyIiE+JkoXr2wJ1NvDaz8WEeeTz6D4aPm8o96zFS?=
 =?us-ascii?Q?OFTK8E8qSc//WackXFQEm7SBGV8L1WuKOlt+kopsB0oXXsIyBL2AZHrWtIv5?=
 =?us-ascii?Q?mBeUoSBfnx9w05ddjZcOJaRXW7QNfafyQHmQaVOVnFTGt55Ns0jg8QyKSAp5?=
 =?us-ascii?Q?wLxCKuRN+u4lRPepfVfJkskn70wkaE48PqVId22CjqlPSj8LWh9Z0zglThMz?=
 =?us-ascii?Q?AdQ6/1Bl5XvxH2ncmm1yrUe/lp0vakAX4mDeBVSfuxP7Ka5pWCU/yYr167KV?=
 =?us-ascii?Q?QWSV2OlA7LTP0xydgzejUojINr7SNxG6Z3q7TlaR7jhmf9MgQlhbhOP5vAeG?=
 =?us-ascii?Q?BgGYNguhHiMNPhEemOPmVtTc3WjAuRl0KGCYRafnbX/PPXtu3cP0Ab6eCE1p?=
 =?us-ascii?Q?EZ7uanleE+m3I5YoumL44RgiTCYHemM5VYFWyiH0KxaY37H4JlHN7xt5fNS9?=
 =?us-ascii?Q?+Abp6P8KvcSEzEEwICZzDaatzgqyPWIqTOknobvH72Q47Q/2VQ2XQ3qhIpVS?=
 =?us-ascii?Q?NFB32m309pIU/WcqBNnkmHTT74yYNZIZCtjq/H1L5zYO+Kgn2GWYKohJd4pc?=
 =?us-ascii?Q?uwx2zCQsi5r3Fj084d0R8cVbr9bjRjOMQ+nmMO6GENNXva54LRj77wsgVva6?=
 =?us-ascii?Q?5VvZsrHjJXQMCS/t6jVIJ/q9ipz64Sl+yyDqGt5X0FPMn2bD2cSCBpwdO3dz?=
 =?us-ascii?Q?SDST4bcIClLBQqZzjIkY/5LufpNzJil5XZUSwpTxdvNbpGZs7MwfMx0ncwqx?=
 =?us-ascii?Q?OzOOFPCbBwchSd0myNTb5uqY7o/fxxbCTHOzeeD50bhvCFPspAGpnz2/65uy?=
 =?us-ascii?Q?JFhHI2PS7zxbsfLx/yMs9laWLCE9raIenw4ukyA2J5QnY/uPhB7ty1MkTqFs?=
 =?us-ascii?Q?Y9aNK3qthI5RW2JJJXhFMCqsSYPzPutxt9++bZCeH0MzmGBO4kbISHyR9bEt?=
 =?us-ascii?Q?4jJLwaEGz+vG0+YntZNThGNmdPYyahASTSfmQwCtLh9pBNop+qpDsOSccuiX?=
 =?us-ascii?Q?b1X0QJURk8eArNDAZMh0uhciuw2yJgxP9WRX4jnr/DnJj4wicoRsCZgQB0ud?=
 =?us-ascii?Q?G7vjtXQqhVuosjWaB5GK1yRUkCYnn0XSekI31Yo67wJKTBjkAZPap9Re57JR?=
 =?us-ascii?Q?1ktZT5hp6ze4EVOHjBfw2Von0ZI8+nTeDYc0C/rrefsZDWwpyfQNRea8qeXn?=
 =?us-ascii?Q?sB4WR1UbeOfszkEpz7Ni44LWigxAKKNmL9ztcz9mF39zU5g/0cFOGRQwFzqK?=
 =?us-ascii?Q?yJCdORa49xLccRXatbRUS3tPqPoyCxw2J9bLQg/MR3t0g+DEDfn0cCYLCpgr?=
 =?us-ascii?Q?gmGJZk1Ej/JuTyLFiWTLcsOSPwnVsqdXkh8Ef7+A?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57607d0c-c891-4f2e-5e14-08dd8b814438
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 03:02:26.7766 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yJp3iXXapLRvlcZP20Km4ovYZ/WIOUtvqMB3iXU4TWweuEsu6bCVXpQYNp2EPoJxmRl4FZYE1BpefPo5R+gPcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7789
Received-SPF: pass client-ip=2a01:111:f403:c40f::7;
 envelope-from=KFTING@nuvoton.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



From: Tim Lee <timlee660101@gmail.com>
Sent: Tuesday, April 1, 2025 4:59 PM
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org; wuhaotsh@google.com; CS20 C=
HLi30 <CHLI30@nuvoton.com>; CS20 KFTing <KFTING@nuvoton.com>; Tim Lee <timl=
ee660101@gmail.com>
Subject: [PATCH] hw/arm/npcm8xx_boards: Add auto zero flash image and devic=
e part number


Fix flash device part number to `mx66l1g45g` according image-bmc run on npc=
m8xx evb board (SPIFlash...SF: Detected mx66l1g45g, total 128 MiB)

And add auto zero flash image size to resolve error below after executing
`./qemu-system-aarch64 -machine npcm845-evb -drive file=3Dimage-bmc`

Error message:
qemu-system-aarch64: mx66l1g45g device '/machine/unattached/device[73]'
requires 134217728 bytes, mtd0 block backend provides 67108864 bytes

Tested:
Build passes and runs ./qemu-system-aarch64 -machine npcm845-evb normally

Signed-off-by: Tim Lee <timlee660101@gmail.com>
---
 hw/arm/npcm8xx_boards.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c index 3fb847=
8e72..11b792c613 100644
--- a/hw/arm/npcm8xx_boards.c
+++ b/hw/arm/npcm8xx_boards.c
@@ -27,6 +27,7 @@
 #include "qemu/error-report.h"
 #include "qemu/datadir.h"
 #include "qemu/units.h"
+#include "system/block-backend.h"

 #define NPCM845_EVB_POWER_ON_STRAPS 0x000017ff

@@ -59,10 +60,21 @@ static void npcm8xx_connect_flash(NPCM7xxFIUState *fiu,=
 int cs_no,  {
     DeviceState *flash;
     qemu_irq flash_cs;
+    BlockBackend *blk;
+    uint64_t blk_size, perm, shared_perm;

     flash =3D qdev_new(flash_type);
     if (dinfo) {
         qdev_prop_set_drive(flash, "drive", blk_by_legacy_dinfo(dinfo));
+        blk =3D blk_by_legacy_dinfo(dinfo);
+        blk_size =3D blk_getlength(blk);
+        if (blk_size < fiu->flash_size) {
+            blk_get_perm(blk, &perm, &shared_perm);
+            blk_set_perm(blk, BLK_PERM_ALL, BLK_PERM_ALL, &error_abort);
+            blk_truncate(blk, fiu->flash_size, true, PREALLOC_MODE_OFF,
+                         BDRV_REQ_ZERO_WRITE, &error_abort);
+            blk_set_perm(blk, perm, shared_perm, &error_abort);
+        }
     }
     qdev_realize_and_unref(flash, BUS(fiu->spi), &error_fatal);

@@ -194,7 +206,8 @@ static void npcm845_evb_init(MachineState *machine)
     qdev_realize(DEVICE(soc), NULL, &error_fatal);

     npcm8xx_load_bootrom(machine, soc);
-    npcm8xx_connect_flash(&soc->fiu[0], 0, "w25q256", drive_get(IF_MTD, 0,=
 0));
+    npcm8xx_connect_flash(&soc->fiu[0], 0, "mx66l1g45g",
+                          drive_get(IF_MTD, 0, 0));
     npcm845_evb_i2c_init(soc);
     npcm845_evb_fan_init(NPCM8XX_MACHINE(machine), soc);
     npcm8xx_load_kernel(machine, soc);
--
2.34.1

Reviewed-by: Tyrone Ting <kfting@nuvoton.com>

________________________________
________________________________
 The privileged confidential information contained in this email is intende=
d for use only by the addressees as indicated by the original sender of thi=
s email. If you are not the addressee indicated in this email or are not re=
sponsible for delivery of the email to such a person, please kindly reply t=
o the sender indicating this fact and delete all copies of it from your com=
puter and network server immediately. Your cooperation is highly appreciate=
d. It is advised that any unauthorized use of confidential information of N=
uvoton is strictly prohibited; and any information in this email irrelevant=
 to the official business of Nuvoton shall be deemed as neither given nor e=
ndorsed by Nuvoton.

