Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D546C7115B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 12:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRrtV-000663-Gj; Wed, 18 Jun 2025 08:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uRrtS-00065P-Uh; Wed, 18 Jun 2025 08:27:55 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uRrtQ-0005VZ-Ei; Wed, 18 Jun 2025 08:27:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+Rm3ItVeZ43mBXewLnndUNnraBFwDs+vn1XvrgyQSy71wMiRwiL6pQeRfNz++3W+jtOLuxM2SJisfMs0l4inRygky5NMJJs+VOlTMpYDqFHfhPFfsCCXzuiP01hTfAuhYwT/bi6CsDeBmFqB5u/QcBWPmzE5gBpbOF31amkzXyCo0mfKeCzVlmruNpDjMfJrH26SueCIFF+1cHxrTkoc9mVvlK0r47i8fFMpyyey7+vDnGXPRVxwIPPHzHKZrAA82Y7OQKj1B6dwBgEbF6R77KMSbbKso0fgF2VU4CPX+2h29D6GAP9kvZiSXjaFFr8bV7cBVGFT5F2reDcsVw6PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7Nqr7IDfMQivuLza3uTbtJQJdoU4RVT4CEqeIgbzLE=;
 b=iG11eYE4pNGd+nZ/msK8QjoVo3KHADmuCd7GVj9lOJeMwXD1Anlqf+emHdQYdtMCB3n3G3JKfKBVG5VX5klxqipBM9nLs4/FoBVi8bSJZVBUimwFnz0wBa/ZgGSHjtg22kEchgrcD1wky19w5iPutcPRXCCvV9on94JkoxuAjhi7fVPvSNipFeeKbFuMx0iZSYqLMS/MH4U8glMqwIfYauOi+cHwbuMp6jY++pQY4OpL/zRsSeawpbcNzrdu5Nzjh6H7zk6r5T60fJJmFhXKnr/LP3YqS0aOXU/AAxwZYLEZIqqml/tkqYzS4TFZos5Qq8kPQ4gNEfJBG/DKFqjTwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7Nqr7IDfMQivuLza3uTbtJQJdoU4RVT4CEqeIgbzLE=;
 b=IXldWF7cYtOQMGce0TDJqPWcUyeVstnytHaMx0d6clVbmLN7Dhw0QfkC4K25UnmlK2Y1FoP1bNunH51bEocQWi4UWI/TqWPjTc6k6jJD0EFnG7xMmZRElck2UE6gDg7Tr40sZY3GgVnOrDifvQtpl4WBhq/up5OVGXwF/6AjYzR4VFCe//gx0mCxzT1/2082LwOQHlo5HFFioC2bGmpDWpzkybYKWxI6y30LRv6SpwMU9cF1GlyUXvgobeP8fYUwKHL0O07CgNUhVAZFjag8jkDdBLm1NpCtfD5HUWig0K7sZZhKKWvlaPiSn2ONk/BcUYBMJkmPP5kqO5nZ4P94kw==
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
Subject: [PATCH v3 04/10] target/riscv: Add MIPS P8700 CSRs
Thread-Topic: [PATCH v3 04/10] target/riscv: Add MIPS P8700 CSRs
Thread-Index: AQHb4ExmcradWaJ9/UmUKF+3FV1Eww==
Date: Wed, 18 Jun 2025 12:27:47 +0000
Message-ID: <20250618122715.1929966-5-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: ee475580-5681-45da-59c2-08ddae6388ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?mdBo+EHKoqn8tnU+GRqMqqavZOcg52eta82pLUBhB11IVxnGCGy0Ubq0vV?=
 =?iso-8859-1?Q?FtT3mmbhwKFfCpegHn96igPqC22YQPMfvlaxX7I0DJ49i0KICCfokxH8Z4?=
 =?iso-8859-1?Q?sNO8bBt3+oNn/MpCp8XMHEmKgFVQfHIfB/OQxK5W6WHJLDidoEy+Jm4cxi?=
 =?iso-8859-1?Q?0WvtimmExStA00Xt0crV6wHby7OnZDPDAbv5oZw4mTojcOyIiLJNkCvDNe?=
 =?iso-8859-1?Q?lnQn+Czd5R8aeifNMPwQYq42nzcT/eoLt1lQ7zt2jzETyHETMeSU5tZhhc?=
 =?iso-8859-1?Q?+DVxgVcu8O9k0cZj8Qr/L4IoxSqOpzZYWoLOHvnCXPBd+zwf3S9aGYxdoq?=
 =?iso-8859-1?Q?gEmfO9hysBveeYBNzlk3xq4yaIKavp8AcxSBjJn0+gKpf0mjtX/cbGFghe?=
 =?iso-8859-1?Q?pm3uUrDHvIoc1x9MPMwI05yALX2otw9+h3aVaFnydwMPtA1aH/dcvsdzRt?=
 =?iso-8859-1?Q?gsufN+2eg4zKagZwkj/fS1wpCYc6GTTffnJU3C2mpNzCuDNAh8ui3SrQJb?=
 =?iso-8859-1?Q?/6EZXmNBmlfCLx93RZGhkk2EC8xFp5l7aEhjQbxe2I/8xbuf7xJxnR86Qm?=
 =?iso-8859-1?Q?bDudDgsUqR3Wd0uRi+JwuUow9lcRhtyHx3YoKvS4ASti6GWmai6/6PNg/O?=
 =?iso-8859-1?Q?YhPHhhox/3qeN7gBlw5Ymjy/MOQuJuRRT4y5R+4gYaukxsF2wa94jk2bqf?=
 =?iso-8859-1?Q?VaP2GLYgaAxWKYx4F7dxduuntdK3DYFOKMzlP0vJsPVNrkzxzd2oFOc2XO?=
 =?iso-8859-1?Q?w5mDyqiJLcHszwzdxPxKhwTNzb6e9dl4CCS3+nPsWnqsbzPSqJh5dbytho?=
 =?iso-8859-1?Q?5B4R298JRwJFW4ven4UbK9j5SMMg4UHLWVAf4z3iz1vn4xkE5P21z3fE2K?=
 =?iso-8859-1?Q?L4lCmwwoq6nqopFLpnWrv+D1xdW8DSeRaTSNRseFqIlEAhIU7whNXiM584?=
 =?iso-8859-1?Q?7Cn4bMZenULWFgshhXKATFg1hOnj6/vub4/vuvYDNdQ4CVw4y7UIN9mPl4?=
 =?iso-8859-1?Q?IRoBodoseRlyZzWzjcAV+ZJkV+LXAtBGr6vzB5oxOzeTAIF0qs1yEb+rio?=
 =?iso-8859-1?Q?ETP/JJnTcneG43UPssJUaDTtrySZ2vtxXiK4BqQnQaMZ4fF8EDKul/p7ls?=
 =?iso-8859-1?Q?5mnuXKs0DaOXDO3vCH6vrtEM0zrd5nxRoiOxjJNz7d7tnlgWCaMy9w6AAq?=
 =?iso-8859-1?Q?81sl8m3Rz+6ZXIXhtNke+8SyFYyXgkPvbLXSF9w4dBZYqeOqXUKcxaVMjY?=
 =?iso-8859-1?Q?EIIS6GD3ehmuRyRx4MfOxR1c5IRAgUItBmn6SRHMTRrLjtmBhueREzuivT?=
 =?iso-8859-1?Q?ZytQvYFvtHAOghBnCDX8vSFgjrK7qvuvISRdL/Yv0K4BUqo181PAxE9KFo?=
 =?iso-8859-1?Q?u7BuQS6LhaDKIK/w7dcTEoKCGiSiQZF33l3UQcYCcp1y3m1jRv7c2RKdgE?=
 =?iso-8859-1?Q?z3tgzrDTYGwXyzuu3/gxqS3kjBTcc9LYo9D1NPDaF/8B4fynkqiIV9GdZS?=
 =?iso-8859-1?Q?V0h3gdm8G2R+p3v7zoBJt8G6R5sCDYjP3LbLEPTpzSYw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gg+WQuThgSJJYF0XXpcB0DeYhrtU4Lk1E1yNOdPOvOfLfUHVad8hH3nIHA?=
 =?iso-8859-1?Q?xkQrckNTnmPWkne00f4a0rXWPBid0MyppOO0dmzzsOJ1UmZlWC75adfpDS?=
 =?iso-8859-1?Q?XYMugoFtdtWBO/uKLNZx0szC52pDSwEIsgfVQfcji7kELfsaIeXTIsUj35?=
 =?iso-8859-1?Q?NPfb9cli9JzdbNG7vkSicJB9eo3KS5uh/UN5UphoTfzn9n2qxr74HHGkZ3?=
 =?iso-8859-1?Q?hABiC8mnagXCAlVBm3CseA50FacXzK5kG+Nq5/9Sv6n9stPi/RnA4CeudO?=
 =?iso-8859-1?Q?gH//lFQWOTAI24F2AosPgAIvG1OdOCGQTh5amo5XWwX/P7wGoi6XtJR2tA?=
 =?iso-8859-1?Q?/BcZbpskoi2cKeol3uNiTokpz5c8E/DNBn1yXYvHxcD02grex+TnNKQsLC?=
 =?iso-8859-1?Q?I+bBNP6tXPL0v3k5ChJF/8rvS7aY2HK9Qj56U/oT06hgJT0fq00dp69ZLp?=
 =?iso-8859-1?Q?BrrurnBo+H2IwNMt0A1ua1/4ADkXtxme1Bc46V39HUCjMj/lie/nUyGdQZ?=
 =?iso-8859-1?Q?G/JVU3YppvX+prCah2Y34VQimYjVRRN1589lIWQgB1Vc1fp3cRVdo/Pd/I?=
 =?iso-8859-1?Q?kY5VqPWkiy47XdHvcmZJ+ONCEzp9uh5HCI1kK6H1PKMMp2q/K/KIyo42Gl?=
 =?iso-8859-1?Q?P+ChnDZ7S7jqyVqovsbcNMPmdsaTp8tXMLqhyZvuZfaoBEqEwvIuZpW0f/?=
 =?iso-8859-1?Q?dRY1WoM341wWL/ETgz6BXn1cfuh/K9XI/Yd5458Ty1yVgydvn9+C9ZrAWU?=
 =?iso-8859-1?Q?bLQ7MuXxJ1gNsvjixjwUTk5RBHLC4dtq4f2kUdDeqKCQBGIf2UBCJ+sRSM?=
 =?iso-8859-1?Q?/pnrjezHPy9beerkZ3Vl/1R7xehv1g/6EJ4Gz+YePumCYzFGP6+0gDwQZX?=
 =?iso-8859-1?Q?WMf/JD+ExGbe+HIPirONZLLZDNp1u1kC3C8glyLRejoSHhf+Phqy0HmeLW?=
 =?iso-8859-1?Q?e1X9yousYNzoa6P/LHwI5jQ4+QwPGdqNxE0exhWSNV9EuD4yYRXJBeZiQt?=
 =?iso-8859-1?Q?GF3mtzdiYgLaQ4uYYRmCucsmEq6UlKotJOnz+tIYaKbDsHFPYrR2rTVghi?=
 =?iso-8859-1?Q?7dMc+6UhIPjP1kMxRwLszt9nOxxTNzCp4eArSaL9ZnjjjWXc+o5P+YmgKq?=
 =?iso-8859-1?Q?y6SWl1E00eeAZO0ZqAozOuGaZrEwxzVL3gjJgeSnM//XPn0e+RmbliQ0zt?=
 =?iso-8859-1?Q?6kMPS1n8LiFqdNvXbYeUlaVnknRgHrUkZucyA56iLrz5CnSerCAV0lbl4r?=
 =?iso-8859-1?Q?j5YTUnUkbm3doEMvep3KIX5hG/jhLqosH5VPszkcuhZQDNqb188z7b9VSm?=
 =?iso-8859-1?Q?zr3kETBWbWv0pyV4K75qG6hrNUPQiu2apU9bk7q48pNJdgZEwBs8sVJ/3F?=
 =?iso-8859-1?Q?ndMloJPmZ9H+ydh3vZXgboYBPLAFjcmKDvX7pVkL6hsBaaTS+8CisYa0OK?=
 =?iso-8859-1?Q?4yQtqv2F7uegE6q+zJuX6mj2kM4l0Ls9NhUD3l+5IDBiy82dRaYVgd0N+N?=
 =?iso-8859-1?Q?aXWMaa1rKs8t6M4L+SVWNo6UZbupKqoXuxFD0sx81x32BxY9zTUzMSGdd7?=
 =?iso-8859-1?Q?UqYM3Bg3t9xh2OGGNdEADxyTqo1YS+ojApDNFmMDJa89CknhcYPktNL95Z?=
 =?iso-8859-1?Q?FnZACFE8U/V3+Hma+TUO39x7cqZdHG15V6zNARX2VPH3cmweurmJ4amkzq?=
 =?iso-8859-1?Q?+Bd1AXPebQAcoy8W2YY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee475580-5681-45da-59c2-08ddae6388ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 12:27:47.7929 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OUaA6ZIJjYO2/X2KUSTkx6DSh6PVuNYxSnEOx/0hQgVRQqsftITPX15tycOXxVT75BbglomjxQM/XqqMHXHPoLC5JjH5RVAck0ATM563RDA=
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

Define MIPS CSRs used for P8700 CPU.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.c       |   3 +
 target/riscv/cpu.h       |  12 +++
 target/riscv/meson.build |   1 +
 target/riscv/mips_csr.c  | 219 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 235 insertions(+)
 create mode 100644 target/riscv/mips_csr.c

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index be362e1644..1e85a16971 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3179,6 +3179,9 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
         .cfg.marchid =3D 0x8000000000000201,
+#ifndef CONFIG_USER_ONLY
+        .custom_csrs =3D mips_csr_list,
+#endif
     ),
=20
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index fba0b0506b..bf1a931e60 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -199,6 +199,13 @@ typedef struct PMUFixedCtrState {
         uint64_t counter_virt_prev[2];
 } PMUFixedCtrState;
=20
+struct MIPSCSR {
+    uint64_t tvec;
+    uint64_t config[12];
+    uint64_t pmacfg[15];
+};
+typedef struct MIPSCSR MIPSCSR;
+
 struct CPUArchState {
     target_ulong gpr[32];
     target_ulong gprh[32]; /* 64 top bits of the 128-bit registers */
@@ -497,6 +504,8 @@ struct CPUArchState {
     target_ulong rnmip;
     uint64_t rnmi_irqvec;
     uint64_t rnmi_excpvec;
+
+    MIPSCSR mips_csrs;
 };
=20
 /*
@@ -972,5 +981,8 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32=
_bit);
 /* In th_csr.c */
 extern const RISCVCSR th_csr_list[];
=20
+/* Implemented in mips_csr.c */
+extern const RISCVCSR mips_csr_list[];
+
 const char *priv_spec_to_str(int priv_version);
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index a4bd61e52a..fbb6c8fb45 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -32,6 +32,7 @@ riscv_system_ss.add(files(
   'debug.c',
   'monitor.c',
   'machine.c',
+  'mips_csr.c',
   'pmu.c',
   'th_csr.c',
   'time_helper.c',
diff --git a/target/riscv/mips_csr.c b/target/riscv/mips_csr.c
new file mode 100644
index 0000000000..aab7f832a0
--- /dev/null
+++ b/target/riscv/mips_csr.c
@@ -0,0 +1,219 @@
+/*
+ * MIPS-specific CSRs.
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along=
 with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "cpu_vendorid.h"
+
+/* MIPS CSR */
+#define CSR_MIPSTVEC        0x7c0
+#define CSR_MIPSCONFIG0     0x7d0
+#define CSR_MIPSCONFIG1     0x7d1
+#define CSR_MIPSCONFIG2     0x7d2
+#define CSR_MIPSCONFIG3     0x7d3
+#define CSR_MIPSCONFIG4     0x7d4
+#define CSR_MIPSCONFIG5     0x7d5
+#define CSR_MIPSCONFIG6     0x7d6
+#define CSR_MIPSCONFIG7     0x7d7
+#define CSR_MIPSCONFIG8     0x7d8
+#define CSR_MIPSCONFIG9     0x7d9
+#define CSR_MIPSCONFIG10    0x7da
+#define CSR_MIPSCONFIG11    0x7db
+#define CSR_MIPSPMACFG0     0x7e0
+#define CSR_MIPSPMACFG1     0x7e1
+#define CSR_MIPSPMACFG2     0x7e2
+#define CSR_MIPSPMACFG3     0x7e3
+#define CSR_MIPSPMACFG4     0x7e4
+#define CSR_MIPSPMACFG5     0x7e5
+#define CSR_MIPSPMACFG6     0x7e6
+#define CSR_MIPSPMACFG7     0x7e7
+#define CSR_MIPSPMACFG8     0x7e8
+#define CSR_MIPSPMACFG9     0x7e9
+#define CSR_MIPSPMACFG10    0x7ea
+#define CSR_MIPSPMACFG11    0x7eb
+#define CSR_MIPSPMACFG12    0x7ec
+#define CSR_MIPSPMACFG13    0x7ed
+#define CSR_MIPSPMACFG14    0x7ee
+#define CSR_MIPSPMACFG15    0x7ef
+
+static RISCVException any(CPURISCVState *env, int csrno)
+{
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipstvec(CPURISCVState *env, int csrno,
+                                    target_ulong *val)
+{
+    *val =3D env->mips_csrs.tvec;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipstvec(CPURISCVState *env, int csrno,
+                                     target_ulong val, uintptr_t ra)
+{
+    env->mips_csrs.tvec =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipsconfig(CPURISCVState *env, int csrno,
+                                      target_ulong *val)
+{
+    *val =3D env->mips_csrs.config[csrno - CSR_MIPSCONFIG0];
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipsconfig(CPURISCVState *env, int csrno,
+                                       target_ulong val, uintptr_t ra)
+{
+    env->mips_csrs.config[csrno - CSR_MIPSCONFIG0] =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipspmacfg(CPURISCVState *env, int csrno,
+                                      target_ulong *val)
+{
+    *val =3D env->mips_csrs.pmacfg[csrno - CSR_MIPSPMACFG0];
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipspmacfg(CPURISCVState *env, int csrno,
+                                       target_ulong val, uintptr_t ra)
+{
+    env->mips_csrs.pmacfg[csrno - CSR_MIPSPMACFG0] =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+const RISCVCSR mips_csr_list[] =3D {
+    {
+        .csrno =3D CSR_MIPSTVEC,
+        .csr_ops =3D { "mipstvec", any, read_mipstvec, write_mipstvec }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG0,
+        .csr_ops =3D { "mipsconfig0", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG1,
+        .csr_ops =3D { "mipsconfig1", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG2,
+        .csr_ops =3D { "mipsconfig2", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG3,
+        .csr_ops =3D { "mipsconfig3", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG4,
+        .csr_ops =3D { "mipsconfig4", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG5,
+        .csr_ops =3D { "mipsconfig5", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG6,
+        .csr_ops =3D { "mipsconfig6", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG7,
+        .csr_ops =3D { "mipsconfig7", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG8,
+        .csr_ops =3D { "mipsconfig8", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG9,
+        .csr_ops =3D { "mipsconfig9", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG10,
+        .csr_ops =3D { "mipsconfig10", any, read_mipsconfig, write_mipscon=
fig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG11,
+        .csr_ops =3D { "mipsconfig11", any, read_mipsconfig, write_mipscon=
fig }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG0,
+        .csr_ops =3D { "mipspmacfg0", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG1,
+        .csr_ops =3D { "mipspmacfg1", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG2,
+        .csr_ops =3D { "mipspmacfg2", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG3,
+        .csr_ops =3D { "mipspmacfg3", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG4,
+        .csr_ops =3D { "mipspmacfg4", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG5,
+        .csr_ops =3D { "mipspmacfg5", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG6,
+        .csr_ops =3D { "mipspmacfg6", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG7,
+        .csr_ops =3D { "mipspmacfg7", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG8,
+        .csr_ops =3D { "mipspmacfg8", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG9,
+        .csr_ops =3D { "mipspmacfg9", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG10,
+        .csr_ops =3D { "mipspmacfg10", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG11,
+        .csr_ops =3D { "mipspmacfg11", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG12,
+        .csr_ops =3D { "mipspmacfg12", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG13,
+        .csr_ops =3D { "mipspmacfg13", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG14,
+        .csr_ops =3D { "mipspmacfg14", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG15,
+        .csr_ops =3D { "mipspmacfg15", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    { },
+};
--=20
2.34.1

