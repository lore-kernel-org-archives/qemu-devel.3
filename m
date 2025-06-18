Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B53C71157
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 12:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRrtb-0006A0-Ud; Wed, 18 Jun 2025 08:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uRrtY-00067y-AI; Wed, 18 Jun 2025 08:28:00 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uRrtW-0005VZ-K9; Wed, 18 Jun 2025 08:28:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=paxQEAbaYUGVxkZDc2uL1x7U3JDIZcxSBVox7jdFjUoN4giOpqJxxQ7dRcUGAb7DOWN+X5e+jqa8n74i87jqERAinVGV0GmwCh5OoydJc0ax87jzb1L/aFv4lCQWH87iilYdVx30kFyvmMVKcN7UPjuTPmnc/RB1Cyzt6mDG8Xb85760t92MAMt5aEoBgI+zE7J7Yup04A4raYI7s4wjDUV//acmuV/sHqiu30xl8l4t8VFdC+Mq0mYAJj2vPwkfXMXIcomw7AdDC9M2kAFT0xY1hWid5mVFnnbsQKkxUMR/JK/UKoCaDIu9JscP7wbJ8ip7wkusNaZNqyMJaAzdEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8yFD1lxxoYPmiAfsF+jsvPAu5MnQOZFj5EmDfWRgHM=;
 b=gWgfSIhnKiuoa86Nkt4k4vJkrdpdPiOyxRU+YombRtFgGBLG2CVw8WzABSLldV0XObE6ifMNZzCjMNQ34d0Fycn2VtO99K/ZgTUhC6DZjDY9AP7g9lfiNUe1ZZcEKbvooq55N60XBpAt/93RVEW1Z50MMzjAoxe2LWUrnbcO+MXhpCFsvP+6xpF6yT7JRkPjldJwnHgyokWXpBXvQ+5nmHtt80gcUu9eMxMhK2zbsCJb7g8SN7G5Z0iYumtUbFeZMEh/qWsc9Ip31vh/J5XathVvo0PMktEWxzuYCqwmcmuAgrtZ+wf4MkXnrHTdeItKFG9Z+oFguJzmPcI4Z58fiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8yFD1lxxoYPmiAfsF+jsvPAu5MnQOZFj5EmDfWRgHM=;
 b=A0T0CrwX+LM0Dw+6Qye5zAdHxadiGtzGO7U0sc4CdNhhCHlwPlpSv+oOKrkPB7+gnebUMCjnFjCFTyPLN0lSkq6hhwLdjNdYbfJMxyX4T7n8mtCI7CwMTFCeZc22IRK6qsr8gz7P8H3ADVK7XVGvrTtpPhTsghYUlTse2WzH4CnLLKhWGAJm+x+OJD7i4AUJAc3DS6CKFc0jr+sH/mR+AKdsI0EBl05/shbRW4QtCO0aS4AAEgK0+Yu6sNCp/o3gYCVxtwUV7aqoOgz234xzTnIoKkagLeReKZhnCORa3mb/KJA+2EhxLN7wkkCW2AuPKpiN3hg6+VF/l0320tSKeQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AS1PR09MB6509.eurprd09.prod.outlook.com (2603:10a6:20b:482::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Wed, 18 Jun
 2025 12:27:47 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 12:27:47 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v3 03/10] target/riscv: Add MIPS P8700 CPU
Thread-Topic: [PATCH v3 03/10] target/riscv: Add MIPS P8700 CPU
Thread-Index: AQHb4ExmlZ+ZHeBf70SX50MTAeCI1Q==
Date: Wed, 18 Jun 2025 12:27:47 +0000
Message-ID: <20250618122715.1929966-4-djordje.todorovic@htecgroup.com>
References: <20250618122715.1929966-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250618122715.1929966-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AS1PR09MB6509:EE_
x-ms-office365-filtering-correlation-id: 9fc78cb7-da0f-4248-cf31-08ddae6388b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?C9ZU4F+s8GYuYtiJg3v5vpvFpfcXeUkbFBVt51Q+5MEIuy+swrfjJnxG00?=
 =?iso-8859-1?Q?swXRvVcG0aFTK4BlmgTgUX9A9gGnPJwrlUU+4wlWhPGwqcO36SRA+LSE3H?=
 =?iso-8859-1?Q?kHT5S+haqfRHlM0bNvx28sNp3L6P+ZwF5Bsj35mECFesm7gjCuloawVgFw?=
 =?iso-8859-1?Q?mEt0qjx+3MDwHBJHMtZ8yqnZeUhkgG63TmGSQL42sYtvYJu/nZHVHf+ih3?=
 =?iso-8859-1?Q?3To7VJSyCjYA4zQVKm2llvStZLHmFedxH9t96wDZyBLkB4KZfOrXQ/YNHT?=
 =?iso-8859-1?Q?l9rkJO+SoWUJbwoDyLs8mn7MCDqxXjfteSXYu7yywM2HOCw/gFbB7crQ3l?=
 =?iso-8859-1?Q?YRQ62NNYspvwsZ7wJsHZF1OIGpE2IEtorIvOXyffKa1eLUoQ0eSvAwLdaD?=
 =?iso-8859-1?Q?i71DLRJnK2q/6PBv8SOCHquDWjiymE2nsjcQNH/fGc34vQEBEe4PR/hUFp?=
 =?iso-8859-1?Q?SO+tx+QIY6EKfi6Mqtk1acAJp3oOkU9n2iqh5yxecbCi3ZERc8CBHIYZAD?=
 =?iso-8859-1?Q?HYSQt9SmQ0HA7Tdw/dpEb9bXQef+RTtiWh+VZll3BRTaAmkRx26+0SYZEf?=
 =?iso-8859-1?Q?RbV6G2d/q98W3q+QpZicPBkYiJcAAKcQZwdNk5n2wNU62HNsgYkSC2Yl0L?=
 =?iso-8859-1?Q?fw0pMtPls58mMc16rXGu7V0ztECNOjzIitMgRGgnwoT7hfjaeaheJKJ/bi?=
 =?iso-8859-1?Q?e8LMKr5H67FzMmVCIJ8mVyJWV0EWLRaExdTQVXzN8BbARMvQG1pz1tdgeG?=
 =?iso-8859-1?Q?MfHYIS3U24BIC/QnpVkLQ4iBDHPJLP7xX81mfEfzwqBEzNyif0Jnuph4G+?=
 =?iso-8859-1?Q?QnZEhaVe65iu/0Y8ku7N7sszjQcrElEetPnN56JtngOL5J6B0SaxExfW9A?=
 =?iso-8859-1?Q?iTW+4d2AK0cVbBdIp2b198StcDk+g+qGIkBbV2wVneZnk8eyQCy81VmyrY?=
 =?iso-8859-1?Q?fbwbcWT7rkshLIFa6MuBdNvwzC9740tAUPbgTHTd16rXGAq2lpn8vtFnKv?=
 =?iso-8859-1?Q?7zjmTvDSm0SEUC8eWP17jzYSYrew1CXzZGMFdxsvKUaPfsXVL4iyl5/a0r?=
 =?iso-8859-1?Q?nrW8D+iDf3WE4h56YQjMCRNHWEZKGdcaNsq1MvFnuRla1rIy5n2lqabnj0?=
 =?iso-8859-1?Q?JaDjKZV8HHIHuiE/Y0bZuvhldQJSym0yHjxpJ+THxiNy9fVb8WXdao8eo9?=
 =?iso-8859-1?Q?15P27N40lhJgy9q021S8O+Z4FgVelH7ex6K8a04apn2PpzL8n9FdNaXKHu?=
 =?iso-8859-1?Q?MDuswWItGrWqALzvCfj3gZX6fza1umBbo1LrH4kkdK+49qFNPhIidrLSUH?=
 =?iso-8859-1?Q?jcPKV8cp6WKn7NfVUaA0FCqTqJwTceUS+/3qSr6hlzS2g36lUBd7HaGS7h?=
 =?iso-8859-1?Q?ayy5X7qo6eRavJX0d6JMeKBbo2hDDBYapVNgZ/NLD9KKnfdEHglQMqKZm/?=
 =?iso-8859-1?Q?hh8URbqNIWDLCcQQmJGANCzX+Peqnm77FyFtWjs9NoIQt+1rYFK8+BQ7zH?=
 =?iso-8859-1?Q?NYuQDVkVf8ye+6HTgWNC1xIrYBwRW34klbE3Rtd3cDHA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RSiARzvUNsQCgooG0GHy5hFotlSF/ilXKetmg7dI7KnaB+kyPtVKCLxODD?=
 =?iso-8859-1?Q?961c2MvdSGZRCuztNSGx1KowFTdKSouImO161oc3eKSxRQ2hlGPbJ+ICrx?=
 =?iso-8859-1?Q?eJ8aiwJBhXWo7b4Co+JdWloWhiwiGj2rODy3C9/FT3tN0FZx1gJVxmz9qr?=
 =?iso-8859-1?Q?7sZAkgqYq3wWm2c26EAYn/fIKaR3/H7x8x+6jGOeb6yd2TJkxefe7W6rEM?=
 =?iso-8859-1?Q?2/efgmuHvs29FrTmkwGvDTzPBvc03gcTfZjRRCfb0Nw2e3e1iSiMrGqa6o?=
 =?iso-8859-1?Q?kP93XomPnE8RkPRBchc63uQjc6dX3WzYPYbQ3aYx7Ox2iBaIw56vsf1nUD?=
 =?iso-8859-1?Q?vfSIABPOszAIShpgixUACq3jvf8FGDUgd6RpFvcXMomWOmCSVLYKKAIB/W?=
 =?iso-8859-1?Q?HC+Ua1iGpilk3voIRCP47bG6QMPRlbSShg1TSi+qGSptkrSGMdg6L1R0uk?=
 =?iso-8859-1?Q?LRLre7tKgfhMp/5u2ktf1b5q+GyBqO3k9Apesbx0Dv9jGDQVQKluPdMKkc?=
 =?iso-8859-1?Q?QvOMCNKalqTqKGAkeuWE6E+V2Y4O3WrjjVMpCPu3TFxJMuwX5W3FE62EC3?=
 =?iso-8859-1?Q?iRWSnD9ytwwrm9l5usbpQgRfmH9PLB7V/guDP78LPnqON+wkaT8JC0C9Mf?=
 =?iso-8859-1?Q?FXgnKp8QjzCjTfYuOEAmRGqLNa7R3ITddUkzRqsxB7rZQWEY101OTZmCNL?=
 =?iso-8859-1?Q?vkEUYF9Q7NBYSwY9foN52G7utp6mz473iwCyVyrb8JUdqY+/832ncjRAEV?=
 =?iso-8859-1?Q?5RAQXJDFqaV0nY1lNTCi7gr92AMoOsgUw4umSYMm1/M8Zi5AP0tM58SOhM?=
 =?iso-8859-1?Q?HUjeM7sjAtf7GFlGAgFIFYp2+8d+xDsgumLY2UvrCpg6HozdiIJrAH0fUa?=
 =?iso-8859-1?Q?YcYkPJAgvcx+p/dq7hyI1TxlGMLSnFoJwCa+NfobraPBTSQG/Pl/cCGEKu?=
 =?iso-8859-1?Q?QXcfpxauLi95u4pe54aJMM+CS0S+dzoWXzKB58cSy+bzbqm0LUZXmFa+ey?=
 =?iso-8859-1?Q?GOrqPcX/bX0JWLQyIinXlivBuAJymdhQrrrU/R/K3YtKr2exvvu5mQHULD?=
 =?iso-8859-1?Q?rUoN761SgtkDyBK3N5AAsautXn5mEP2NSmXaElXouLz2EXDNI1fA3Gyiyu?=
 =?iso-8859-1?Q?jCTYigxhJLMfgJPy+i36IBF/x/IXDjxEjn3I/Fa6SVBFUoc56/ZKRhp8lB?=
 =?iso-8859-1?Q?4WVqTnupB0hcYZDM6jRncDYOOt3pIO7DzWPLLXg41f4qw/whR7SPc0Fevv?=
 =?iso-8859-1?Q?0jGGxTTWqenSu8g782KgtHGoe3yfAx0WCUGjKKYDml8x+5XJb5AWCDM0SW?=
 =?iso-8859-1?Q?dmPHY+lix4XFLEYl/KSQxkj6OD/vqD8TMD5zBVeXZ/zk2h0yV6Iym1CeaA?=
 =?iso-8859-1?Q?pD7/axMutwTzFaD2IAHX0Yg4HhBEWgL+hK7FCIJcZR3M2aGEAApE+RZEj3?=
 =?iso-8859-1?Q?3vWUXnagisRf5tIDiG4WNrbN5oB0L39PkJblar6XJZ1Mwvca3+AS9plLba?=
 =?iso-8859-1?Q?3SQm9aVElTj6d71HHTvhuol6GJ0+YgL9lOPj2wcARqcV/+XmLFruksUwWX?=
 =?iso-8859-1?Q?3mLlZlyLXMas9gpu84M5LAYVh46QfAyNJDHWNnAhRL78PEKLqfJWqt+J5f?=
 =?iso-8859-1?Q?1H0/cyE9UgRDL+cdzAEERQFPgJ20YiShyg2f/RbsDKirhJD4gQQOU1dC67?=
 =?iso-8859-1?Q?OF2pWYDemnAdu2anmT0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc78cb7-da0f-4248-cf31-08ddae6388b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 12:27:47.4700 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K/6ORP2i+eXcscb8DXV0O6eoIWXSCHRt3KlAknnhdt42blCR54XjK1Q+gqWqC7jP9paglJ6+RyHR4vTKKAd0x1yEc+q+vdLtL0ghB943aL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR09MB6509
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

Introduce P8700 CPU by MIPS.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 1ee05eb393..1e62b96094 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -55,6 +55,7 @@
 #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
 #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
 #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nan=
hu")
+#define TYPE_RISCV_CPU_MIPS_P8700       RISCV_CPU_TYPE_NAME("mips-p8700")
 #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
=20
 OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 629ac37501..be362e1644 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3167,6 +3167,20 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.max_satp_mode =3D VM_1_10_SV39,
     ),
=20
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MIPS_P8700, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max =3D MXL_RV64,
+        .misa_ext =3D RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
+        .priv_spec =3D PRIV_VERSION_1_12_0,
+        .cfg.max_satp_mode =3D VM_1_10_SV48,
+        .cfg.ext_zifencei =3D true,
+        .cfg.ext_zicsr =3D true,
+        .cfg.mmu =3D true,
+        .cfg.pmp =3D true,
+        .cfg.ext_zba =3D true,
+        .cfg.ext_zbb =3D true,
+        .cfg.marchid =3D 0x8000000000000201,
+    ),
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode =3D VM_1_10_SV57,
--=20
2.34.1

