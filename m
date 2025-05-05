Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3841C3ABAC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 02:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBm0K-0008R1-BJ; Sun, 04 May 2025 22:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1uBm0E-0007yK-30; Sun, 04 May 2025 22:56:22 -0400
Received: from mail-eastasiaazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c400::3] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1uBm0A-0000xG-Lt; Sun, 04 May 2025 22:56:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFicgHEEz5LHYVu9iyQ5fgkovwAJzB/gPt/YfIr1Hfl0q9YsgTWXNo2gF2a7OuecDcUurTC8IIoKe+C0B7oKrpcIV02Hi6C0XMK5yvrF2xCuWbgva8QRvj1J8wGjEHcuBqqg1Pp7QFpjn2uandfJ+pODs7KDJ8ogGa+MTugn2aBtsjTQ1aoSlyqz9alAiifK049BndRnWpB9Fnr4sqostOjyusMp1xWmTQUisvHqOzCdk1Uv9TMyixwC6qp3IvODU2XWMxPpAG13pPb6xFPCk9K3mQMsmdMk9YaLqenbFMvJP4M3Xsi5C1SqeZlZnSdkvbBphFgV3DJL102gN2B+SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgAhiYiL78f3U7cxLNDUStjr75GzTeKPBMHX8svISeA=;
 b=a9HynZc0ri/tVHHcI479NVJP+At80wgyVXuExls92QOMGr1uRf5g4faCPvC1et84bNx2v6V68E/wbspNAbXJNT/cBgngCaL87CK7c8QTSl5h5lX3yxWCkYIWxjQWTTT7EFRkxe6Rr+gAm06rNQm8WEh41QTnB8EIciaqtncdVe7zKR5oTOIeGXTeBb/u3uFddv9hOte3aitmlLjjAZutTyhLAsYJCjGar6NDklse6ZTBfMdSvsie5SVio0bDBvCHWE0S42EQG4Ux+VShxKj+Xcueq/nGWHseXwqzh9IJPiqPSawACO8q+nK32ZRkutGKLcyqZXyNRKvElA6blNDmRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgAhiYiL78f3U7cxLNDUStjr75GzTeKPBMHX8svISeA=;
 b=YtfiCKofhjKYROsP32bkXv2GjF6avPI0SJvjTNErBnQj7jif5oUSEND9oYQKwfR/7SesdeXmp8DJAD/UkN6rQ8XVIxAcgAo35oAotrNKrg4kaFZ/i6PQMMyb2d6GahDD2kvKakfL+5S5ICZauXTGP7cBufq6zJU6wf/0N67VZwo=
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TYZPR03MB7789.apcprd03.prod.outlook.com (2603:1096:400:452::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Mon, 5 May
 2025 02:56:06 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%6]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 02:56:06 +0000
From: "KFTING@nuvoton.com" <KFTING@nuvoton.com>
To: Tim Lee <timlee660101@gmail.com>, "farosas@suse.de" <farosas@suse.de>,
 "lvivier@redhat.com" <lvivier@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "wuhaotsh@google.com" <wuhaotsh@google.com>,
 "CHLI30@nuvoton.com" <CHLI30@nuvoton.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH] tests/qtest: Add qtest for NPCM8XX PSPI module
Thread-Topic: [PATCH] tests/qtest: Add qtest for NPCM8XX PSPI module
Thread-Index: AQHbsEICpgR5wT+umEO3t6ZXxrGWRbPDcabw
Date: Mon, 5 May 2025 02:56:06 +0000
Message-ID: <TYZPR03MB6896EFC2669A7775D9521E1FDB8E2@TYZPR03MB6896.apcprd03.prod.outlook.com>
References: <20250418091208.1888768-1-timlee660101@gmail.com>
In-Reply-To: <20250418091208.1888768-1-timlee660101@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6896:EE_|TYZPR03MB7789:EE_
x-ms-office365-filtering-correlation-id: c70075a9-7b2f-4c99-dd30-08dd8b8061af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?kCLb64Sbqczr+RHiR8PkYHoErpcP32dF3do325jNECMU2iDEyZY7yUcnkbN0?=
 =?us-ascii?Q?SFzwic2DjkZezYFwOt5zsiym9CqITZf3YkeBnAVKhm3kbTw6rhgsvQJbsSIc?=
 =?us-ascii?Q?qQ22oMGtfHb85IM/klyJlzz1E/G4O9HsKQ60V2kWt3MSr2ATUi/ZEV/Azyt+?=
 =?us-ascii?Q?JRKgUnFpuJ4ljQNm00gKr1htULQt2PsKkRPWGj7APcnUF+JtcS6VvcZIockv?=
 =?us-ascii?Q?UdIrcVyn5ssKdtov/ZI0hoAOvsixEJ4i25/yNZcyzC22TVvnIWz5bm0I73M1?=
 =?us-ascii?Q?jVSdKhtinUMsIyk8fVmBcIx7pyFL79Dy6Qx4sd/0NHXDga5+yOxvJiDCTaDt?=
 =?us-ascii?Q?tW5luv5/r+Ix6AUxvnqbA9lcEhhqCrjX/xi9o1724au3S4T5+p2NnlaYX1nG?=
 =?us-ascii?Q?ZRxydzxMDjSw29eujPN0/0Yayi8IvJhn/dPvKWoGBWmt7279Fn2WcA3F8Hgo?=
 =?us-ascii?Q?0IxHgzrY5qJ/u8HOi/mJdHeZh/1roax40uiEaIbU3HBItkT1WONxz9yJpLYk?=
 =?us-ascii?Q?D9zHBdrDX4SeUrFXYKb/47+HZF6zAkvQaxZgV5JU4sGO5rV6+h2kODzUgRSa?=
 =?us-ascii?Q?qwtGKEl5hEG2vrTJVFvDa1g+ORqjN+zZdQ2L0xedYM5A54ji3/GQlqX/2k5Y?=
 =?us-ascii?Q?X44XsEeiZcffradREZ2IpSdzqmAXB3qxQD8f3VQWf8ACm1giBR/xC63Mm+3S?=
 =?us-ascii?Q?k53EZqHL6oUZ9mREboBz3jtnPUe5njNJp6kL4rE2zJCO4MfCD9cKCUeEglXj?=
 =?us-ascii?Q?Ms8m3YZAbe7TyJJR1mzLztJn0u1Ye6PykaAVbq68QrotJBZEJq3t/yuw4dA5?=
 =?us-ascii?Q?rnEFRoPkiqnkKX8TVe7y/5hHT5NkAIkdDS4dpf0/8wV3vMT/egWl6/whEsEh?=
 =?us-ascii?Q?q2c7Gptat66fNlXypoI2PRFxRXMLsSQx1FlOjmVLKGdM3f8g5DicIXseRfD6?=
 =?us-ascii?Q?CzxhvK3RsnOiZd0RVDu4/vtjCMgMu5q52vtO7apbPZykZeGKs/XeUDmD1ZHl?=
 =?us-ascii?Q?JFWIoFz5lOdh+x430CXSF35EM48AOFT+DElMeHZ5loI3OoDeWxGEPN+yQfhM?=
 =?us-ascii?Q?0tn9bKRJuw1n2kEVlqlHIfLOaC8XXWQTXUC4gKF2E//qEmozw+od62syPMyx?=
 =?us-ascii?Q?ouZzivuaT60/EUdmZk93FOF0NcSF0oIpAZL7IJQKAb0PpS6GQ8buml0H+bsv?=
 =?us-ascii?Q?XOjft0YHl5+aLHI+hvg4T6/xPPZiRKvLNYCy5TJSMMGpUBIwTRH+zMnP9nqY?=
 =?us-ascii?Q?x3tiXID7DSjhbkWFFDP1hHcRJ9tvJPzmjnutw5SpWF6cLgtYf3CGHMY9recX?=
 =?us-ascii?Q?2DQFgEtOKFjb5PhfycPnhRo/1vxm8JIphpONd1D77FmPTaM6oMHKcigBDBau?=
 =?us-ascii?Q?UUC/tJRqQxaY+ru75ogpt3Axg1rbuwXVB93bNB0dt3WXK0TFLXPNiEZwk/hj?=
 =?us-ascii?Q?YSXKIBkBW3ukr5T09hMNxuyBAhYoEA4TP9zJpFhuKhPZXkJZIsqGvQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6896.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F6dFc5lSw2t7GcFH+zABH3Gy3+soanplSrg5W9rPdFQF67rNtmqAoJ+9vQJd?=
 =?us-ascii?Q?mAPyOI0mbgzFbJkzDO8wGT1c6A7T+0i/YPbanPiqs+SIY/95dDAyeoIJxlNz?=
 =?us-ascii?Q?/imZo2s9qHf2mjcSPVDlqAPbuSgvMiEh9aHJcajYxZyA+m+d80l005g6qAaD?=
 =?us-ascii?Q?lWhL/xv8AEA1EvZhtpYc9P2UTMSe+LuReD3DD/o2hUvJxP22UE+AaaXiuxqq?=
 =?us-ascii?Q?PAPl08fSpJQsSjGoamRImoOB0g4P4+a9gfLmMPvvGFEnwX2buV/3cKaCUyJi?=
 =?us-ascii?Q?DZfO2h1ibNLYzDpa/l749dgRBaNdjrEoZVdlc9VTvsSrWVvJNRcNaDrR5lmd?=
 =?us-ascii?Q?t9P8xze4P7dhAWKTsQlU7jL9PM3lcJTGICXh5PJLdzw1dNt5ILDFiAerIAhx?=
 =?us-ascii?Q?yhjMHW9rBfHX3i2QEnlMGGTfJJeiOzwJMmA+HBRzf2/iLvmBYtWJZsbkDZvI?=
 =?us-ascii?Q?ADkvzKVRI/GOlAhhPjhhTDqhoGncAKqeBhY2BMZecWL3x/Mzfj+rWms9KaMU?=
 =?us-ascii?Q?TOzdyuIKuoOW1TrvnmXDGvR/vHEwEWesEiuHUd8e1nN4XfqHpoDELAk5/xra?=
 =?us-ascii?Q?qmGq8Y6O5z6zLeiQkvySNHqNkd1NOrWzySsqe453UaXYUXNq1aCpLS43KrVR?=
 =?us-ascii?Q?S8njklfJ6gdDFxynY3wgcdJ4iI0RAjdY4NRIfDJG2yQn/k4wKmmgYd7SOYh/?=
 =?us-ascii?Q?lBSjd5zbrTvEvm5vwi/Xfrm2OGcd5hF96DQf6YvpeMWA29gV9VaXTu1IjOZ8?=
 =?us-ascii?Q?S2ziriLRnLSAWjHKU9n/K2FZQegQ5VYN12tzC1BtKLBGkVwilcy2SXKcMW8g?=
 =?us-ascii?Q?FvA4/bTjzL6L7uItF6QnYDtiAQR73saCi4vLdU/qDXGuFjEVkjfbKzx7Ji5r?=
 =?us-ascii?Q?FZ6lLaqKxISXbxDwUYcSo60oOU+DxRIUZB3kNK7VUea/fC/PQzcxNySoTzXd?=
 =?us-ascii?Q?vAeUt/FF2xQ5dqVcCcXVV+MgLZelqT695LoQ09NxhfkU3IE6X0Hyc/4ue3tI?=
 =?us-ascii?Q?Wn85lgb3adwaDXkZQcl/SRVeEaEYcVIdKYbf3K3r2HpA3M0mYUZbfsmllD51?=
 =?us-ascii?Q?/N+dcSuLrbiFO2JE6yBlXnoGilFy1sOrNaUD8HSaxAUiUPtBAPIy5JERX7D+?=
 =?us-ascii?Q?MJN/1oaUWKMxAC9LBXjxyNIF7f+NAsYml5TbA71MB895qsO+a9tFa7Rv8vkG?=
 =?us-ascii?Q?1p8cKxcxtKUziw6174pdZTp8aQTd55bl567K92fVk/AuEmX/wqM6eWW84Pfw?=
 =?us-ascii?Q?N2JGhxewhG/hLv6VVgJB10G9NKAvQ/vb49wtBnTkPmhJppAq1zB/PBJNe6/q?=
 =?us-ascii?Q?xBJGkipNUoBhipeIkrVQQ92J+NElcUdfj/cBAjJWJ0r2Javt6QX4FWMk0fwg?=
 =?us-ascii?Q?mCNau01atdwHOHL2wfn4M0mRwjMP80JkjT6ed9xhkqYMh8OYFltaAR/gd35z?=
 =?us-ascii?Q?e2GoPNcHw8N1B4BckzQYeHQL059tOMu0g0RhgQBZF3yeMVDG6a3zuHkZPWhG?=
 =?us-ascii?Q?4s0b7b03KoaM8XPiI3NvFyRxWf6YjD3dBplX+5w+UUNCGLkdnKWuOnOFqhRI?=
 =?us-ascii?Q?EEDgxtiGyi15rIb7uoiyYs2y/XUhuJCLQYZLlI0d?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c70075a9-7b2f-4c99-dd30-08dd8b8061af
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 02:56:06.7196 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XlBJxFpXGEhJsQ11B4MFHFLlybumJ+AoCC9SE5j1XgMx6SvpTBKkmCijeqK4SkkqDbKOBuDV3zeBRpCfen9GHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7789
Received-SPF: pass client-ip=2a01:111:f403:c400::3;
 envelope-from=KFTING@nuvoton.com;
 helo=HK3PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Sent: Friday, April 18, 2025 5:12 PM
To: farosas@suse.de; lvivier@redhat.com; pbonzini@redhat.com; wuhaotsh@goog=
le.com; CS20 KFTing <KFTING@nuvoton.com>; CS20 CHLi30 <CHLI30@nuvoton.com>
Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org; Tim Lee <timlee660101@gmail=
.com>
Subject: [PATCH] tests/qtest: Add qtest for NPCM8XX PSPI module


- Created qtest to check initialization of registers in PSPI Module
- Implemented test into Build File

Tested:
./build/tests/qtest/npcm8xx-pspi_test

Signed-off-by: Tim Lee <timlee660101@gmail.com>
---
 MAINTAINERS                     |   1 +
 tests/qtest/meson.build         |   3 +
 tests/qtest/npcm8xx_pspi-test.c | 104 ++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+)
 create mode 100644 tests/qtest/npcm8xx_pspi-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d54b5578f8..0162f59bf7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -892,6 +892,7 @@ F: hw/sensor/adm1266.c
 F: include/hw/*/npcm*
 F: tests/qtest/npcm*
 F: tests/qtest/adm1266-test.c
+F: tests/qtest/npcm8xx_pspi-test.c
 F: pc-bios/npcm7xx_bootrom.bin
 F: pc-bios/npcm8xx_bootrom.bin
 F: roms/vbootrom
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
t.c new file mode 100644 index 0000000000..107bce681f
--- /dev/null
+++ b/tests/qtest/npcm8xx_pspi-test.c
@@ -0,0 +1,104 @@
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/module.h"
+
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
+static uint32_t pspi_read_ctl(QTestState *qts, const PSPI *pspi) {
+    return qtest_readl(qts, pspi->base_addr + CTL_OFFSET); }
+
+static void pspi_write_ctl(QTestState *qts, const PSPI *pspi, uint32_t
+value) {
+    qtest_writel(qts, pspi->base_addr + CTL_OFFSET, value); }
+
+/* Check PSPI can be reset to default value */ static void
+test_init(gconstpointer pspi_p) {
+    const PSPI *pspi =3D pspi_p;
+
+    QTestState *qts =3D qtest_init("-machine npcm845-evb");
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
+    /* Write to data register */
+    pspi_write_data(qts, pspi, test);
+    printf("Wrote 0x%x to data register\n", test);
+
+    /* Read from data register */
+    output =3D pspi_read_data(qts, pspi);
+    printf("Read 0x%x from data register\n", output);
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
+    printf("Wrote CTL_MOD to control register\n");
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

