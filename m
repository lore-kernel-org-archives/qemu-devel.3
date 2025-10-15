Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E558CCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 13:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v91ET-0003OL-2x; Wed, 15 Oct 2025 09:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v91ER-0003Nt-MT; Wed, 15 Oct 2025 09:07:55 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v91EN-0000nK-Go; Wed, 15 Oct 2025 09:07:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5qw579Xv8Y+mm0rhxTg1tGU/kFC1q4uJHWH2DFjikppMEu/j23dStNjFVHCP1Um6HAow4nTJuz2IfStY9Fdgwqhxnmhf1vFGOnLAuqqldMwpBLdkgZuAmJEYcwhDLp2mObF7fLQHhvoOgQIlgObirVJCYk7+0I3y/nE6k7igpLzURPZ0QkIRdhwSCuspdWDHCJqOWSk4GfINy5yGkjoMMibyOjvVypUjWM4BtZALntd0x5Q3ZoeObgXHiCgxtuMC+EHdoEGIJRcsUvUJydr0IILqg4w2XTsrATRBq2SE1JR3HmquUQr293vLjnSM6MmlSsi0d/OCZqmrLrRsaSrAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyW3Q7ZQ6oaIBLODAOp8zDllh3sILwEUmncfhjuRgAc=;
 b=pOEx7RXJTGdX3FHX6yCWxCNdgFmiX+eEtukdtZNgudc188IWv8TPAnzlP+9JQZn45Vm5gACfDgToT9ct8kip/lF8lHt9XU7270UePqeLvTwn/8y4UPBX6qFPSF75tTZHSgInakyADGn+K7TA9MejNroHfkIyfbIu07ArIdylM4/+B7V1pR+ZN2L4ePbTTv50p3hZA3iL+GOrveZrh493hoUHQbtVuo7jdBQAm3Uwv08M3KM01dfHLAUcrjbzU+Sg4TMpyymlz/I8MG+4FSV7KDIyOreb01fupsAGS8fxzLCbW35h2Tl0D/jRXvBCm/2vqBtmB0N8C2A6viLQHVQ7jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyW3Q7ZQ6oaIBLODAOp8zDllh3sILwEUmncfhjuRgAc=;
 b=Ve+WoOX+PW6wYniHJsCCEb7ybQE84U87SjDjvZSlsa/TOzO1pQKIhX/M77X5/tTLjCpURxeI2UTenUwR5nDF3w3NzozifbTJcqjkMleOd+UmV2pg1aUjV2A5Mx+iH7J6I994YAufIG2CwtQHgQStD7S1hGT0Ba/Lw+igY0kkzxqZjp30FSynGDdILo78a2r2SGElp52FV7IVjS652HaxovcFjI3XiJGIpPLbIaGgcKBaXcUG4WhtZIzgN+a7UDrY+VBUOEdUHZr/z3vhEP3J7MQ/foBZgsPD+mn5PFUxlPBsxfb64mkpTisgi4yjW1yNEG3glFKs1xx4ccPOPNhVQQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB9PR09MB6057.eurprd09.prod.outlook.com (2603:10a6:10:3da::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 13:07:06 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 13:07:06 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v12 08/13] hw/misc: Add RISC-V CMGCR device implementation
Thread-Topic: [PATCH v12 08/13] hw/misc: Add RISC-V CMGCR device implementation
Thread-Index: AQHcPdSbvGXVlL/EL0iKJaCJc4JLEA==
Date: Wed, 15 Oct 2025 13:07:06 +0000
Message-ID: <20251015130657.571756-9-djordje.todorovic@htecgroup.com>
References: <20251015130657.571756-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251015130657.571756-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB9PR09MB6057:EE_
x-ms-office365-filtering-correlation-id: ee36deca-e8f7-4e9f-e627-08de0bebbe08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?oq1uFAjKcewrI1YV+NbCMiZmZlKUgXVilJAif3xmPRirnurHTyTQTb9gMu?=
 =?iso-8859-1?Q?DWpkysA53qf0hg29sPO8wa6Sgw9JUAqeGDZfGCfK71rkgB7VZP9iBSbWlG?=
 =?iso-8859-1?Q?Fbrt7HbRTADwgXfxkmJU44ndF4LcGSFJX8S0kATGZeXa+pu1V0z8s51LvJ?=
 =?iso-8859-1?Q?QBWYKH3zCbEIfqAptmH3czuQr3UPWiQuwqJZtnB3/nrA3xrirDa9mDsEK5?=
 =?iso-8859-1?Q?n5OvxqACHqzleFpdEj0WwZPWPVO6/de4FQ62Zl8R4BkCDh1dnE7J7Q34la?=
 =?iso-8859-1?Q?0+HCFTwOjLSRsbkt7axD0atgWqTRgPDluBbs2l84RZ07m8PPE6YB5aR+qP?=
 =?iso-8859-1?Q?p2gtqrzHxtAnNiSeOegK/AOSMFi0VeD8fQ2Ky80z6XVaTRMGUfew3dzOhP?=
 =?iso-8859-1?Q?obmI5LVFiGPmaa6ag6ioR0wh8eQAVfoae5wwy6OmJU1mI7z/mDLWTJPnnK?=
 =?iso-8859-1?Q?barZVrhqBvYyfgwjmcWmT3MFi6MEoAt2gWSzUikOS61WUiwmerFMcvVtQS?=
 =?iso-8859-1?Q?QtqvdAJuqsOtaFav0sFeNKgfiQ7cr/S/I3zmyADXFDYSLV36tNh7N3nTMO?=
 =?iso-8859-1?Q?mNm5u/M+PfBenABMjP5RlTy2/lkoQwDNLWa4AQV7JkE/Sl2gCnGe4uyRZi?=
 =?iso-8859-1?Q?YjOkaHvFmUQDqaPmQRB4Z+cK1mUx1mGVPsstliVcG36bH1itMvqdIy9Qgq?=
 =?iso-8859-1?Q?KNGft6z+bUyUKQKDEDtbu7cv9aCEEmo/ppvLwabAr4pOUHTsm3IkQadjMo?=
 =?iso-8859-1?Q?Ln6ivvHlLeKgdAJ/ms2g+DRCVSBVWeZoIgfPcyyU+G56ODMVz/AZTbUnm0?=
 =?iso-8859-1?Q?rWNwpEYeuVS45j6Av0W2RIsP5hzno5Di+oOvrdoO41WHsOfqPM9fTXKIIa?=
 =?iso-8859-1?Q?GU/M6wxaQpQ7Lj887JF+T9ppPXYWAK1OWzpehqRvO+2XnHYka9F5l56Mwg?=
 =?iso-8859-1?Q?FEWnjhWJHX3nlXj7XdGnwu0e1guL7mnISHU9wj8HyuKYeQq7J0KP0bz9/7?=
 =?iso-8859-1?Q?82FtXCT0zwDwfGjvNPMKrPGXMPHTbj5rYBA/ZYeJTxfEICJArPoOyvQE6o?=
 =?iso-8859-1?Q?WT3zG2t1EbbrhgaOaWozy97s8IaVYInPEF6rKBJ9vxOplhEJhd7e8WUri+?=
 =?iso-8859-1?Q?W/q6HrIJ3tavB/qMVJzcz1oTvAB9LL1qYtggPWxhUgVuHf+RCrZjtO9apa?=
 =?iso-8859-1?Q?N8QujzhqsiKECLKmPtGQBZs3xz3oY7kNMmMaYF5kZjFvAaRugdSR07wPt0?=
 =?iso-8859-1?Q?IiS2mhiPQ8y4Os1geROAK1bU+iH7oS7xA47InosJizrPVX1sWvZ5iuHknO?=
 =?iso-8859-1?Q?9Qg/biB3VuKT05mze3ExJRKB3DhWA4ScXxUEb8vDy30gtvWYfr6JFaGBwU?=
 =?iso-8859-1?Q?8MF6xpEgof3PiXtQT/NzaoWmg5fnNFYSTLBKBKRUJTKknsfMrjw8b5GKJs?=
 =?iso-8859-1?Q?yUuaSCsRDpYjdf6A/lwzI9V3eIrE6rRe3a2/3NxKCJF6ZZr/6ePnNBMVz0?=
 =?iso-8859-1?Q?OiW7MyqQbBviAam6iGa3nt87+KIU0PEWYC5a3BcfLBbZ2WuhfaPmTX7YIa?=
 =?iso-8859-1?Q?Di4gm6PU1oChWhugQpsWt2Kx2nCr?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8pDeokETcTxBUGTmaM/bMsuUHU8IlJY9TGr9mxvTwuyQrWFelWO/mqkxlN?=
 =?iso-8859-1?Q?gjQniV27EO0KgrSV96aS5nbd/vq49Yk+d+essL7bFwfshkvjIliSaXq2CR?=
 =?iso-8859-1?Q?PatrVGT5bn9QuWGN5YtkUUQdrbLHMTHJqJ/FYbfQ8syjoEHLyhkDWyi0gt?=
 =?iso-8859-1?Q?VHKUwWE0Bxi8r8SS8f49T0IeabbHEtdUVXr1GSSgUlWz7ve3z47vhE+lyJ?=
 =?iso-8859-1?Q?pyXieSv23z6lkSkUAyl0KCqwohH/DU28CMR4LQap0+OLiV+iLNm2OE6788?=
 =?iso-8859-1?Q?D+xw/5mEMni6AeaT7UYu1rlRroKYM2kkaRVNw+XSepQ7zSsZQ+jWfGmHO3?=
 =?iso-8859-1?Q?ZzYkPKYnMxpZqBplrT2I4hsApZlBxVYCj3q8qiK6F7blMLo+gUp8punKB4?=
 =?iso-8859-1?Q?tolD6u7QyWUWXygYv6reeIJcic0FYGhwzgmVXJoj4cKy+rLA5qIm/MohvP?=
 =?iso-8859-1?Q?Ps9QamqDy5zOP3zElbgADkvUBPN0Jb1appEoaSolrXflxKeCN2ZrRjbUsg?=
 =?iso-8859-1?Q?Y5WaXJS9aAYX/KEY2ngQXuTjOkmOWSu5wMXFW+Wcv8BtV3xyshLQUyOfRx?=
 =?iso-8859-1?Q?fWFFnnPumeZF76L8nQUVEKmCt5OXnDKlYdanWGz8K7ZqkW6qEOGVE+ke1n?=
 =?iso-8859-1?Q?PTHzBM0lLtM7hPAbhs9cQNLlIXopWKeXG4cbbBXMz3XT3Ej97e7W5nbiMC?=
 =?iso-8859-1?Q?cAtC66QzUSSkTNf7Av2z4rTp3HlhZ5Eiqa/W9X5aQqgKEwmgtwMRJKBIIR?=
 =?iso-8859-1?Q?/kZLbEtleKDV0tLSAk0LWU2MJUGGl8lagiw+B2FYtH3AiveKcRLbUbUcga?=
 =?iso-8859-1?Q?xhZQ35eKa7GBcDIuXrCBoCT4XkCqB2Kp5i8Qd0QI3B/AmpZQejw67fAHK+?=
 =?iso-8859-1?Q?K2EeUENo3iE5XnljKeC16Xn3elqCVIlvFtmwV941KErq0Iv2EOXrsqOlek?=
 =?iso-8859-1?Q?AkCpEL43gzeYi8MUcghDHvMPRpesA6U3pT0+ba6GFOgSkVNWVrFJYrL+nF?=
 =?iso-8859-1?Q?wZ32ToTXZIWvNaQsHuLkmYp0HnNIaWjqEH7cp+VUByhafXUPeumotQMZ8w?=
 =?iso-8859-1?Q?hLozu6LUVWhX1IGLjcdha1PFfNEdK/6X4Fu5Tu1a8xivfN7lpziIrrkFYN?=
 =?iso-8859-1?Q?ka8Qd4NE1YRr+SszB3DDz24yI473F2z8tkuHxPF1FHkQs3vC6+MHG/PgIE?=
 =?iso-8859-1?Q?b9Mj6NypjSZzzoR26rWTPwhvTbgRvsiupS8ktDmzfkhVTH77dfu0aejVyo?=
 =?iso-8859-1?Q?62tAhLjID9AwG4GuERG/bgYXXaQ7v2nWO0IGvHVWNk6WRZCRquADne6BtM?=
 =?iso-8859-1?Q?FnHE+0qPeb8XVC1FjKNOnlJDcPoYwfzhyxsGExlUsnVFjQiPwcNEXpInt4?=
 =?iso-8859-1?Q?URxfbdktOVVvmgipyhx48GUY1PIonvbDYoejV77MDw6E4mjof5sV7uarlz?=
 =?iso-8859-1?Q?eh1ahCSD2N4LNM1bQVVPQ/kUh46rEyWRU5ESVoNg6gkV8mgNv27du/Mvvh?=
 =?iso-8859-1?Q?4QMbXu/GJGFa7ipm4OKEqqKjgHQYKoNep4BUu1v1TFXo9v9gR85dw0ZMrk?=
 =?iso-8859-1?Q?zxX8qGuStflzT2VCiMvOI8t2o8JASFs1szx2rx2qtqmFTPQ+Dh05vyTNil?=
 =?iso-8859-1?Q?/luQbp68znLVp30+TwcuyMVvVf5SHQu6LQ8xCnONPD8Meaf1JqEk1xywvn?=
 =?iso-8859-1?Q?JiHK2m0rD54z0b93o7c=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee36deca-e8f7-4e9f-e627-08de0bebbe08
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 13:07:06.4318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: StbxAoYGnXe9aG4vTRqLoMHJnNKQTVO1/DOACylxFzecALd+Ina24N25beENowidskoNy2EHpim8RBaTdNN8QBh1XNEp0y9ewOpXzm4kNSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR09MB6057
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
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

Add RISC-V implementation of the Coherent Manager Global Control
Register (CMGCR) device. It is based on the existing MIPS CMGCR
implementation but adapted for RISC-V systems.

The CMGCR device provides global system control for multi-core
configurations in RISC-V systems.

This is needed for the MIPS BOSTON AIA board.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/misc/Kconfig               |   9 ++
 hw/misc/meson.build           |   2 +
 hw/misc/riscv_cmgcr.c         | 248 ++++++++++++++++++++++++++++++++++
 include/hw/misc/riscv_cmgcr.h |  50 +++++++
 4 files changed, 309 insertions(+)
 create mode 100644 hw/misc/riscv_cmgcr.c
 create mode 100644 include/hw/misc/riscv_cmgcr.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 4e35657468..222efb12fb 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -121,6 +121,15 @@ config MIPS_ITU
     bool
     depends on TCG
=20
+config RISCV_MIPS_CMGCR
+    bool
+
+config MIPS_BOSTON_AIA
+    bool
+    default y
+    depends on RISCV64
+    select RISCV_MIPS_CMGCR
+
 config MPS2_FPGAIO
     bool
     select LED
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index b1d8d8e5d2..489f0f3319 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -157,6 +157,8 @@ specific_ss.add(when: 'CONFIG_MAC_VIA', if_true: files(=
'mac_via.c'))
 specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_cmgcr.c', 'm=
ips_cpc.c'))
 specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
=20
+specific_ss.add(when: 'CONFIG_RISCV_MIPS_CMGCR', if_true: files('riscv_cmg=
cr.c'))
+
 system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
=20
 # HPPA devices
diff --git a/hw/misc/riscv_cmgcr.c b/hw/misc/riscv_cmgcr.c
new file mode 100644
index 0000000000..8e7b86867a
--- /dev/null
+++ b/hw/misc/riscv_cmgcr.c
@@ -0,0 +1,248 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Pub=
lic
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+ * Authors: Sanjay Lal <sanjayl@kymasys.com>
+ *
+ * Copyright (C) 2015 Imagination Technologies
+ *
+ * Copyright (C) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Reference: MIPS P8700 documentation
+ *            (https://mips.com/products/hardware/p8700/)
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "hw/misc/riscv_cmgcr.h"
+#include "hw/qdev-properties.h"
+
+#include "cpu.h"
+
+#define CM_RESET_VEC 0x1FC00000
+#define GCR_ADDRSPACE_SZ        0x8000
+
+/* Offsets to register blocks */
+#define RISCV_GCB_OFS        0x0000 /* Global Control Block */
+#define RISCV_CLCB_OFS       0x2000 /* Core Control Block */
+#define RISCV_CORE_REG_STRIDE 0x100 /* Stride between core-specific regist=
ers */
+
+/* Global Control Block Register Map */
+#define GCR_CONFIG_OFS      0x0000
+#define GCR_BASE_OFS        0x0008
+#define GCR_REV_OFS         0x0030
+#define GCR_CPC_STATUS_OFS  0x00F0
+#define GCR_L2_CONFIG_OFS   0x0130
+
+/* GCR_L2_CONFIG register fields */
+#define GCR_L2_CONFIG_BYPASS_SHF    20
+#define GCR_L2_CONFIG_BYPASS_MSK    ((0x1ULL) << GCR_L2_CONFIG_BYPASS_SHF)
+
+/* GCR_BASE register fields */
+#define GCR_BASE_GCRBASE_MSK     0xffffffff8000ULL
+
+/* GCR_CPC_BASE register fields */
+#define GCR_CPC_BASE_CPCEN_MSK   1
+#define GCR_CPC_BASE_CPCBASE_MSK 0xFFFFFFFF8000ULL
+#define GCR_CPC_BASE_MSK (GCR_CPC_BASE_CPCEN_MSK | GCR_CPC_BASE_CPCBASE_MS=
K)
+
+/* GCR_CL_RESETBASE_OFS register fields */
+#define GCR_CL_RESET_BASE_RESETBASE_MSK 0xFFFFFFFFFFFFF000U
+#define GCR_CL_RESET_BASE_MSK GCR_CL_RESET_BASE_RESETBASE_MSK
+
+static inline bool is_cpc_connected(RISCVGCRState *s)
+{
+    return s->cpc_mr !=3D NULL;
+}
+
+static inline void update_cpc_base(RISCVGCRState *gcr, uint64_t val)
+{
+    if (is_cpc_connected(gcr)) {
+        gcr->cpc_base =3D val & GCR_CPC_BASE_MSK;
+        memory_region_transaction_begin();
+        memory_region_set_address(gcr->cpc_mr,
+                                  gcr->cpc_base & GCR_CPC_BASE_CPCBASE_MSK=
);
+        memory_region_set_enabled(gcr->cpc_mr,
+                                  gcr->cpc_base & GCR_CPC_BASE_CPCEN_MSK);
+        memory_region_transaction_commit();
+    }
+}
+
+static inline void update_gcr_base(RISCVGCRState *gcr, uint64_t val)
+{
+    gcr->gcr_base =3D val & GCR_BASE_GCRBASE_MSK;
+    memory_region_set_address(&gcr->iomem, gcr->gcr_base);
+
+    /*
+     * For boston-aia, cpc_base is set to gcr_base + 0x8001 to enable
+     * cpc automatically.
+     */
+    update_cpc_base(gcr, val + 0x8001);
+}
+
+/* Read GCR registers */
+static uint64_t gcr_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RISCVGCRState *gcr =3D (RISCVGCRState *) opaque;
+
+    switch (addr) {
+    /* Global Control Block Register */
+    case GCR_CONFIG_OFS:
+        /* Set PCORES to 0 */
+        return 0;
+    case GCR_BASE_OFS:
+        return gcr->gcr_base;
+    case GCR_REV_OFS:
+        return gcr->gcr_rev;
+    case GCR_CPC_STATUS_OFS:
+        return is_cpc_connected(gcr);
+    case GCR_L2_CONFIG_OFS:
+        /* L2 BYPASS */
+        return GCR_L2_CONFIG_BYPASS_MSK;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Read %d bytes at GCR offset 0x%" HWADDR_=
PRIx
+                      "\n", size, addr);
+    }
+    return 0;
+}
+
+static inline target_ulong get_exception_base(RISCVGCRVPState *vps)
+{
+    return vps->reset_base & GCR_CL_RESET_BASE_RESETBASE_MSK;
+}
+
+/* Write GCR registers */
+static void gcr_write(void *opaque, hwaddr addr, uint64_t data, unsigned s=
ize)
+{
+    RISCVGCRState *gcr =3D (RISCVGCRState *)opaque;
+    RISCVGCRVPState *current_vps;
+    int cpu_index, c, h;
+
+    for (c =3D 0; c < gcr->num_core; c++) {
+        for (h =3D 0; h < gcr->num_hart; h++) {
+            if (addr =3D=3D RISCV_CLCB_OFS + c * RISCV_CORE_REG_STRIDE + h=
 * 8) {
+                cpu_index =3D c * gcr->num_hart + h;
+                current_vps =3D &gcr->vps[cpu_index];
+                current_vps->reset_base =3D data & GCR_CL_RESET_BASE_MSK;
+                cpu_set_exception_base(cpu_index + gcr->cluster_id *
+                                       gcr->num_core * gcr->num_hart,
+                                       get_exception_base(current_vps));
+                return;
+            }
+        }
+    }
+
+    switch (addr) {
+    case GCR_BASE_OFS:
+        update_gcr_base(gcr, data);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Write %d bytes at GCR offset 0x%" HWADDR=
_PRIx
+                      " 0x%" PRIx64 "\n", size, addr, data);
+        break;
+    }
+}
+
+static const MemoryRegionOps gcr_ops =3D {
+    .read =3D gcr_read,
+    .write =3D gcr_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .impl =3D {
+        .max_access_size =3D 8,
+    },
+};
+
+static void riscv_gcr_init(Object *obj)
+{
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
+    RISCVGCRState *s =3D RISCV_GCR(obj);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &gcr_ops, s,
+                          "riscv-gcr", GCR_ADDRSPACE_SZ);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static void riscv_gcr_reset(DeviceState *dev)
+{
+    RISCVGCRState *s =3D RISCV_GCR(dev);
+    int i;
+
+    /* Update cpc_base to gcr_base + 0x8001 to enable cpc automatically. *=
/
+    update_cpc_base(s, s->gcr_base + 0x8001);
+
+    for (i =3D 0; i < s->num_vps; i++) {
+        s->vps[i].reset_base =3D CM_RESET_VEC & GCR_CL_RESET_BASE_MSK;
+        cpu_set_exception_base(i, get_exception_base(&s->vps[i]));
+    }
+}
+
+static const VMStateDescription vmstate_riscv_gcr =3D {
+    .name =3D "riscv-gcr",
+    .version_id =3D 0,
+    .minimum_version_id =3D 0,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT64(cpc_base, RISCVGCRState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const Property riscv_gcr_properties[] =3D {
+    DEFINE_PROP_UINT32("cluster-id", RISCVGCRState, cluster_id, 0),
+    DEFINE_PROP_UINT32("num-vp", RISCVGCRState, num_vps, 1),
+    DEFINE_PROP_UINT32("num-hart", RISCVGCRState, num_hart, 1),
+    DEFINE_PROP_UINT32("num-core", RISCVGCRState, num_core, 1),
+    DEFINE_PROP_INT32("gcr-rev", RISCVGCRState, gcr_rev, 0xa00),
+    DEFINE_PROP_UINT64("gcr-base", RISCVGCRState, gcr_base, GCR_BASE_ADDR)=
,
+    DEFINE_PROP_LINK("cpc", RISCVGCRState, cpc_mr, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
+};
+
+static void riscv_gcr_realize(DeviceState *dev, Error **errp)
+{
+    RISCVGCRState *s =3D RISCV_GCR(dev);
+
+    /* Validate num_vps */
+    if (s->num_vps =3D=3D 0) {
+        error_setg(errp, "num-vp must be at least 1");
+        return;
+    }
+    if (s->num_vps > GCR_MAX_VPS) {
+        error_setg(errp, "num-vp cannot exceed %d", GCR_MAX_VPS);
+        return;
+    }
+
+    /* Create local set of registers for each VP */
+    s->vps =3D g_new(RISCVGCRVPState, s->num_vps);
+}
+
+static void riscv_gcr_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    device_class_set_props(dc, riscv_gcr_properties);
+    dc->vmsd =3D &vmstate_riscv_gcr;
+    device_class_set_legacy_reset(dc, riscv_gcr_reset);
+    dc->realize =3D riscv_gcr_realize;
+}
+
+static const TypeInfo riscv_gcr_info =3D {
+    .name          =3D TYPE_RISCV_GCR,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(RISCVGCRState),
+    .instance_init =3D riscv_gcr_init,
+    .class_init    =3D riscv_gcr_class_init,
+};
+
+static void riscv_gcr_register_types(void)
+{
+    type_register_static(&riscv_gcr_info);
+}
+
+type_init(riscv_gcr_register_types)
diff --git a/include/hw/misc/riscv_cmgcr.h b/include/hw/misc/riscv_cmgcr.h
new file mode 100644
index 0000000000..c57d4ada1c
--- /dev/null
+++ b/include/hw/misc/riscv_cmgcr.h
@@ -0,0 +1,50 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Pub=
lic
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2015 Imagination Technologies
+ *
+ * Copyright (C) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef RISCV_CMGCR_H
+#define RISCV_CMGCR_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RISCV_GCR "riscv-gcr"
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVGCRState, RISCV_GCR)
+
+#define GCR_BASE_ADDR           0x1fb80000ULL
+#define GCR_MAX_VPS             256
+
+typedef struct RISCVGCRVPState RISCVGCRVPState;
+struct RISCVGCRVPState {
+    uint64_t reset_base;
+};
+
+typedef struct RISCVGCRState RISCVGCRState;
+struct RISCVGCRState {
+    SysBusDevice parent_obj;
+
+    int32_t gcr_rev;
+    uint32_t cluster_id;
+    uint32_t num_vps;
+    uint32_t num_hart;
+    uint32_t num_core;
+    hwaddr gcr_base;
+    MemoryRegion iomem;
+    MemoryRegion *cpc_mr;
+
+    uint64_t cpc_base;
+
+    /* VP Local/Other Registers */
+    RISCVGCRVPState *vps;
+};
+
+#endif /* RISCV_CMGCR_H */
--=20
2.34.1

