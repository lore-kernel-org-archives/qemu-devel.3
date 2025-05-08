Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98429C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 01:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCq7U-0007EP-Nd; Wed, 07 May 2025 21:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1uCq7N-0007DL-O8; Wed, 07 May 2025 21:32:10 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1uCq7L-0007D2-4u; Wed, 07 May 2025 21:32:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lu9ClEgvTVi2m4a8+GN2yfHfDngtbXQVMCriRY++Y6+F6Uc3cJSfHryysfKV9C46b94FT4OYpK8Ld0ZaH/N306uSGPCiSLQ4BzExe8DR8+WHDyxKmHluq1VsixZxFoVkBwe34uAeH8pKCxxuIFx9+fGV3mSJb6SN6S5CVsKT8HY791c2KM9+iGr6tf1lYe3Z4gw5HsG+5XM5rk6E5G3fulhY04ZJTjpNzym2kQTgJd7Pc1Lqifcgcsrkey5HSZlnn+nvs0srIl9Wu4C3hnrniMwDhv96LvX2d2dP6EEtShMnCCNRGxk0P3/agXXqtV9WIItyXSt3n2fThLfdRa1mdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b62yWTKwqMq3z8Kl6nh1FchWGSiTx993XN4s7wOuB6U=;
 b=bOyy+O+vjyI7n2VLvZbiu3rgeynF5kXRRbt7g3AFfEL38OL6EFJ+bIYZ8Va+eB1AKa6zQF1ev1qUIC6i6oRdQUVxo67IbvtGlLJ05A9H50V1Ob+PERWoVPKxY+31XpXWW5I5UfqC0LCckFJ3OvC/CUSYAweBigoh7xkpEOaLbMKss8kZ4bgqIMI+8TLYGB9NdrrNA0/m834VZoYkGIXGZs5Xw1rsIp1IULcnVpt0OQ+1hJLhA2XJVwjUBRLAzT/cTActSjJCbCTmKTbyoHnHMOkvDCs9iCR50lfTm/Y++vGt5fKsdRhN5K7C3ZPvFsu/wLwc//D37Pv/9Q1Z3y6Wgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b62yWTKwqMq3z8Kl6nh1FchWGSiTx993XN4s7wOuB6U=;
 b=HofsgW+pG8czg9G5566JJauzXbOBB2svIpUKz6kVUwoX7aWszo5+5zt9iRlKfUgQFUV8SULzZKlMRO5y4lCSj5yJaU8Jz7xo9WZtgY7g7TgzV8RJj9rMobKujOU472/z5SbUU1LCjEn7+G2d0K+xZE7jVnd07N4+JShht9ops/Q=
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by KL1PR03MB7696.apcprd03.prod.outlook.com (2603:1096:820:ed::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 01:31:52 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%6]) with mapi id 15.20.8699.026; Thu, 8 May 2025
 01:31:51 +0000
From: "KFTING@nuvoton.com" <KFTING@nuvoton.com>
To: Tim Lee <timlee660101@gmail.com>, "farosas@suse.de" <farosas@suse.de>,
 "lvivier@redhat.com" <lvivier@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "wuhaotsh@google.com" <wuhaotsh@google.com>,
 "CHLI30@nuvoton.com" <CHLI30@nuvoton.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [v2] tests/qtest: Add qtest for NPCM8XX PSPI module
Thread-Topic: [v2] tests/qtest: Add qtest for NPCM8XX PSPI module
Thread-Index: AQHbvzEawdilDTWHTkWg/x8D69ZxP7PH803w
Date: Thu, 8 May 2025 01:31:51 +0000
Message-ID: <TYZPR03MB6896C472D3139E037779486EDB8BA@TYZPR03MB6896.apcprd03.prod.outlook.com>
References: <20250507091859.2507455-1-timlee660101@gmail.com>
In-Reply-To: <20250507091859.2507455-1-timlee660101@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6896:EE_|KL1PR03MB7696:EE_
x-ms-office365-filtering-correlation-id: 01424708-78ea-4fb0-79fe-08dd8dd01bde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?+Atx2u20aRNFjUyho9Jk6exSKVZsYnr7NtZTf433+dcJ5dBYhgJvFyg75Qps?=
 =?us-ascii?Q?tVLEp+0B8mCUlnUydmr4Q0x59LvqKqUNY+MolZq6q2znPOg+nvSpNzwsENet?=
 =?us-ascii?Q?D09Daf9ptMboFXH7m7adGT2ouEY454pSDrf+YHJtJXw3KPnT163Cz+1Ax1EO?=
 =?us-ascii?Q?1iIHYd2lp5FwqyycGe5Q0wNaYVrVM8VVUg5fqZqHTA+cJFFeVnWj2iglK1Ci?=
 =?us-ascii?Q?jr1mFhihlDe+ca1jxLOe0Un4XMeUmwiWS4J4G7/mSkng7+dkRF6g8CCKSl0r?=
 =?us-ascii?Q?hQZId8DvT960jk2WZyZdU3VWKsmO907yYsAncQfU/W9lM5+c5qmtkvTcSIkR?=
 =?us-ascii?Q?CQ5a4MvsVlEfDa1tvIZvrE/2U6eeaOjsdZAa81gnCSWgGZWQAEJzmwludvEc?=
 =?us-ascii?Q?5nxoFwOxiwmrJobq93nxk0h3jw1ca8WcgiXrtmwsikRYxspvw0Oq7vDZfWby?=
 =?us-ascii?Q?t8fBUeWr+1baizqHM/2hM4OMwlfs6p/x0pzd6mkGuRebnp7QelWFtIdPItmB?=
 =?us-ascii?Q?y/p9DoA6LVMW+ACi/ymBTKsMh0+QdVtniKoDPUb4mnKld85YXuoeetAknWAl?=
 =?us-ascii?Q?ALifDSJDI94qNJJMfLYOglQoIk2HLaY5lDiNcTMCwK6f9KUOoJDqRjT48xd+?=
 =?us-ascii?Q?C8B/xpnQEFxbvzZEcl4jr8yFFTuQAPNFxUg0g8oOHsiOC5pbFOH6VL9Gdz+h?=
 =?us-ascii?Q?hljPPFdtzqpIprEpWCQbkybxRES8gjJBP+f8U7BwmJhJccCLaC4xXkw5tJHl?=
 =?us-ascii?Q?dOcBAQINngEm1f9Gf1A9FQyvI0uCaVZE3u3Yt5prfisiq/81GArzBQJ3wbW/?=
 =?us-ascii?Q?su3xbfHXZn1VAAs5bWppbKeY/dzPm7B24VAq4ypp7ddm/TyS8yWP4v7EFm0l?=
 =?us-ascii?Q?Jn094tqo78IY2rJKM662fQ/Jik76rhn3gmccxw3tbrLYGqypZXYYGXt5LH+O?=
 =?us-ascii?Q?KVTusGz0FPhI70fYsNvCtb9ExNtZYOj0+p8gcmXoFu/aHz9EL3qm/1sQU1QW?=
 =?us-ascii?Q?c8qM4UaMHEQ+F5NcAQxmA2rN+ONvnIgeJY1QgGJaVaXRpQ2SsRLuRHLrd8sA?=
 =?us-ascii?Q?Pn9nReKDTCAy0AeODxhfyn8H74MjZm27p8DXXw2PFpyOrlFkwpH/OYo7QJu/?=
 =?us-ascii?Q?B/sRe2PIXgBwJlU9Uf+vbZMJv5Z4pF5/KmrjkYto8gTad998/FI0aqM0uAbE?=
 =?us-ascii?Q?+uRbviQ8ZOwuqDBjJXGZXymCwKHMOG668Xkjb4NKhgQn6pRA35jhTrkzJ+Al?=
 =?us-ascii?Q?XAY5PhorpcTToLo7F6lbieFTMBY+4DYiZkK21RRdJF0Coo0CEqK7zQmAeYAw?=
 =?us-ascii?Q?5onhMbCALCyblMntCFc9UkcHUPMc+1M/kg8jHxGjp7peqWb2AaUeLnpIp3My?=
 =?us-ascii?Q?b22gKjbDA0au2y1DtUNBI+CU861m7phAmNkZUgU2Rpzh9mtHiJjyHOqFfRBb?=
 =?us-ascii?Q?ei1edHDsV8CxcWuQf5pZqutGMEN5OpSAuhtECSQ+4NSvwbFOFobQLg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6896.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QtZ8QUTip3DWCmQ26AzeYcd5uJqbPm79enSEL5uwIcz6JWQVopm/hYosh60T?=
 =?us-ascii?Q?ZQASHmH6AGMApMusZBeMl+9EpiQ53Ft2c+pjenlhVTKzCu5A9RGHdyHNMdnL?=
 =?us-ascii?Q?bjxBYkywIxqwTfOZm2PjWK/ehMXfsdYojAWLu95ahTjN8M5VrtzSDalXLOF/?=
 =?us-ascii?Q?zhw6AjQhq4ZHlDD4WWU3ffuhKi05TwfHMhjNsmyvXS4NtuX7wYwlubUcWVrV?=
 =?us-ascii?Q?apIyEs2J6F0qCMkBAFpNXO+4FP1RuL3t+wnoKF1IYmbUBapQx6l4ecnW+X+P?=
 =?us-ascii?Q?FH+QZS7T+1NbBxra6q8ngyOW0cPAN8HIsqAAI5LXh5EvYdBeSvdQkde6EBqD?=
 =?us-ascii?Q?OTvH2qP9IsP3vEmAEMz3ViynQwgixlr3efBMKuItOBFYj+Rw08FLz4CtzaXM?=
 =?us-ascii?Q?/0eF3WD8ZFXQ15SzPLJq8rDpHHt275jGp5qA8K+Cipuymix8qfhDWDpxHzeL?=
 =?us-ascii?Q?JKbMjc/pKiyNt8Z51FggjI5dvYftj87cgAuRG4/IpBOb+nEGyoNAD0XgSef0?=
 =?us-ascii?Q?GRdqvlFPzZ9wDIF6yc/5yFtoXJHTAhDriyajA9Tz9aWhzbk7+0RmlFEuP/AZ?=
 =?us-ascii?Q?dsu6i9eHWv/EjrJHAejP8xw34t8uShilJNrfWObRaWFf7gDuVS4SicjGig3X?=
 =?us-ascii?Q?HdsllWDcVF3PVVd5WWsDrSIo4MM1dUZChXPb8u7QIoGIIeSyJkcRK905tjzQ?=
 =?us-ascii?Q?MEnG27xPj33o20crAFuwzoV8h5QIT2RRR0oDqW7eciERvB/cNT3CXCthNeaG?=
 =?us-ascii?Q?T+kopXyfIP6d9gr8pYWXToTPo2Jo4vY5M404sxbcT5+lFIYBwJEPORY9ImEx?=
 =?us-ascii?Q?ByEdgVlX7mArimqAZh89FV3JzIh9dDTY+GQW6MoAwGWecgQseJTp4XJbH+y5?=
 =?us-ascii?Q?y/m/+uC/hl8Z1DFlTLf8mS/EproAqCYMNs96usqMaeZBxiQt8A8gugUiDj6i?=
 =?us-ascii?Q?fOe1jYoNGKjcqQe1BJQVwAeCvOxr09V2jjSd+VgH/Xy5DdFrvM1qaTrTd72d?=
 =?us-ascii?Q?rEOcPaWNmTMS6T3D9SVLNobmDvIzqfBHnP66hoiu4EkTkSXNeLD8Oz8E8Ij7?=
 =?us-ascii?Q?JC2vRa1Qw6tDcJoR3aD/Q5pL2dssq7Ke7/+ZV7w+TAqZjcvWFkicoOMRTD+j?=
 =?us-ascii?Q?aSh5uMnAKYZFN8S0rCCMzGkt3GqB8bZUyaPMUqscTugvFsEyWPvnQ2iw04dI?=
 =?us-ascii?Q?pVkiKOJ7BiSJY25kc2HteyhBbG/wFJzyLthJjl3GsvkNsP3tHw2KMZs/5dHX?=
 =?us-ascii?Q?QZqBZuVHdJB4Z57iPsKykqkXxMbbOHfWZ6fPSejdrzoKOC23O9eD3W/d7EAW?=
 =?us-ascii?Q?bpAXQFxWgnkWJdQ4bmipKo6o5va1zf3FgMQ4W7PQ16AwiqCZBFoMzNUq/Tt7?=
 =?us-ascii?Q?yD/TeNIRxUEo6rmaVfNsjgbe8m96fUyPyLOV4tV7MvSV10zYZAg5jmle3+Kh?=
 =?us-ascii?Q?M2eQxaj1v3Vz74uYXIvNjicH5sZljNwMMe2kZM1uUlKjuZrBEfNXIm8ftTbJ?=
 =?us-ascii?Q?Ffn3qt4H9TFPLstJrO6GMWGUIziTbBlcnGUu+tHZNuOTic/uOtqP7mIWTMug?=
 =?us-ascii?Q?OizR8rIn/PDs3FnyBbEKiGYSkfzc8jaglSqthsCo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01424708-78ea-4fb0-79fe-08dd8dd01bde
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 01:31:51.6127 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e0u8n5tHeupHB74MuBTTeka3NkWUkeQw3uJASMLa4BykAGR3spBgY8E9fMF1PlqwczPynrKkg9sMX38WOcsGPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7696
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=KFTING@nuvoton.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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
Sent: Wednesday, May 7, 2025 5:19 PM
To: farosas@suse.de; lvivier@redhat.com; pbonzini@redhat.com; wuhaotsh@goog=
le.com; CS20 KFTing <KFTING@nuvoton.com>; CS20 CHLi30 <CHLI30@nuvoton.com>
Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org; Tim Lee <timlee660101@gmail=
.com>
Subject: [v2] tests/qtest: Add qtest for NPCM8XX PSPI module


- Created qtest to check initialization of registers in PSPI Module
- Implemented test into Build File

Tested:
./build/tests/qtest/npcm8xx-pspi_test

Signed-off-by: Tim Lee <timlee660101@gmail.com>
---
Changes since v1:
- MAINTAINERS file not need to change
- Add comment for copyright/license information
- Correct CTL registers to use 16 bits
- Remove printf() in test cases

 tests/qtest/meson.build         |   3 +
 tests/qtest/npcm8xx_pspi-test.c | 118 ++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)
 create mode 100644 tests/qtest/npcm8xx_pspi-test.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build index 3136d1=
5e0f..88672a8b00 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -210,6 +210,8 @@ qtests_npcm7xx =3D \
    'npcm7xx_watchdog_timer-test',
    'npcm_gmac-test'] + \
    (slirp.found() ? ['npcm7xx_emc-test'] : [])
+qtests_npcm8xx =3D \
+  ['npcm8xx_pspi-test']
 qtests_aspeed =3D \
   ['aspeed_hace-test',
    'aspeed_smc-test',
@@ -257,6 +259,7 @@ qtests_aarch64 =3D \
   (config_all_accel.has_key('CONFIG_TCG') and                             =
               \
    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test']=
 : []) + \
   (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : [])=
 + \
+  (config_all_devices.has_key('CONFIG_NPCM8XX') ? qtests_npcm8xx : [])
+ + \
   ['arm-cpu-features',
    'numa-test',
    'boot-serial-test',
diff --git a/tests/qtest/npcm8xx_pspi-test.c b/tests/qtest/npcm8xx_pspi-tes=
t.c new file mode 100644 index 0000000000..13b8a8229c
--- /dev/null
+++ b/tests/qtest/npcm8xx_pspi-test.c
@@ -0,0 +1,118 @@
+/*
+ * QTests for the Nuvoton NPCM8XX PSPI Controller
+ *
+ * Copyright (c) 2025 Nuvoton Technology Corporation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/module.h"
+
+/* Register offsets */
+#define DATA_OFFSET 0x00
+#define CTL_SPIEN   0x01
+#define CTL_OFFSET  0x02
+#define CTL_MOD     0x04
+
+typedef struct PSPI {
+    uint64_t base_addr;
+} PSPI;
+
+PSPI pspi_defs =3D {
+    .base_addr  =3D 0xf0201000
+};
+
+static uint16_t pspi_read_data(QTestState *qts, const PSPI *pspi) {
+    return qtest_readw(qts, pspi->base_addr + DATA_OFFSET); }
+
+static void pspi_write_data(QTestState *qts, const PSPI *pspi, uint16_t
+value) {
+    qtest_writew(qts, pspi->base_addr + DATA_OFFSET, value); }
+
+static uint16_t pspi_read_ctl(QTestState *qts, const PSPI *pspi) {
+    return qtest_readw(qts, pspi->base_addr + CTL_OFFSET); }
+
+static void pspi_write_ctl(QTestState *qts, const PSPI *pspi, uint16_t
+value) {
+    qtest_writew(qts, pspi->base_addr + CTL_OFFSET, value); }
+
+/* Check PSPI can be reset to default value */ static void
+test_init(gconstpointer pspi_p) {
+    const PSPI *pspi =3D pspi_p;
+
+    QTestState *qts =3D qtest_init("-machine npcm845-evb");
+
+    /* Write CTL_SPIEN value to control register for enable PSPI module */
+    pspi_write_ctl(qts, pspi, CTL_SPIEN);
+    g_assert_cmphex(pspi_read_ctl(qts, pspi), =3D=3D, CTL_SPIEN);
+
+    qtest_quit(qts);
+}
+
+/* Check PSPI can be r/w data register */ static void
+test_data(gconstpointer pspi_p) {
+    const PSPI *pspi =3D pspi_p;
+    uint16_t test =3D 0x1234;
+    uint16_t output;
+
+    QTestState *qts =3D qtest_init("-machine npcm845-evb");
+
+    /* Enable 16-bit data interface mode */
+    pspi_write_ctl(qts, pspi, CTL_MOD);
+    g_assert_cmphex(pspi_read_ctl(qts, pspi), =3D=3D, CTL_MOD);
+
+    /* Write to data register */
+    pspi_write_data(qts, pspi, test);
+
+    /* Read from data register */
+    output =3D pspi_read_data(qts, pspi);
+    g_assert_cmphex(output, =3D=3D, test);
+
+    qtest_quit(qts);
+}
+
+/* Check PSPI can be r/w control register */ static void
+test_ctl(gconstpointer pspi_p) {
+    const PSPI *pspi =3D pspi_p;
+    uint8_t control =3D CTL_MOD;
+
+    QTestState *qts =3D qtest_init("-machine npcm845-evb");
+
+    /* Write CTL_MOD value to control register for 16-bit interface mode *=
/
+    qtest_memwrite(qts, pspi->base_addr + CTL_OFFSET,
+                   &control, sizeof(control));
+    g_assert_cmphex(pspi_read_ctl(qts, pspi), =3D=3D, control);
+
+    qtest_quit(qts);
+}
+
+static void pspi_add_test(const char *name, const PSPI* wd,
+        GTestDataFunc fn)
+{
+    g_autofree char *full_name =3D g_strdup_printf("npcm8xx_pspi/%s",  nam=
e);
+    qtest_add_data_func(full_name, wd, fn); }
+
+#define add_test(name, td) pspi_add_test(#name, td, test_##name)
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    add_test(init, &pspi_defs);
+    add_test(ctl, &pspi_defs);
+    add_test(data, &pspi_defs);
+    return g_test_run();
+}
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

