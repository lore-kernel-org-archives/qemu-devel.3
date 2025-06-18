Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCC4C7115B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 12:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRrtf-0006CT-Kw; Wed, 18 Jun 2025 08:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uRrtZ-00068N-6W; Wed, 18 Jun 2025 08:28:02 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uRrtX-0005VS-KK; Wed, 18 Jun 2025 08:28:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dW28LL3jJsW4kzmW3g87J1y7mV4ka2suNOe9zj7zAEcsVy+YPp81CII+rEZ2ojg30MY8fod27F+dSR2mMXqy6iNw109Jy+E8JeNnp2U2F1tpnQEHR+om2ZzOJS/ALhrPMS2CSRYcxNmzkQ849yCDBXwFPmcmrhLODBSfHqjSHPVV+XBrTNKWjkdy048Dep6GNH4XceR1r2NB3jqNcwOkYQJdrmNguhlB477imjJSdvZ5LW31jlq1aIIOIfpgm7s7g05Jo7JkqAxmOmgBZQIGAOhmUQSj466SybhFZf8Tf+3Dpu3YdmG/kVPedD6ykzCx4DWKK4GE6/AUr5kX/XMPLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEYGVvnb/qe0vUA1JPAHcR/nvKhAuQenLqIe8H2Pzks=;
 b=Wo44CT8mRiPhE8GH4iTXp/LiTy2/ZwtpsxmkbBtQ7yRTNmm2MNVSyQOwgrgT6zaUVkcltGVwjoH5VY8S5x5I4mVJ/ekxyt83M0WlYr2l1ha5Kb9gkEXZL4Y01ClHiHJ6o3O8qZhQ4ol3F6eCvlPP5wJDjHZxKTZh84OJfGdrFRFusU1oLxYhxhga22kxELCrh9n8go5WiB9rsgXlws7NdK86TMNR/64KFCz/U9GJETTIUe8Im/9jKB7FuxhZ2SAmDmvB+eOBVigRr36ro+pwz0Pj7KJJDY0tCj2W24V89IeQzgDlHgLF1pAJghn8PVpb1W0kBGy/R4sw2nPmqXqJhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEYGVvnb/qe0vUA1JPAHcR/nvKhAuQenLqIe8H2Pzks=;
 b=rDFSBD+gh8PnLnGMo8T82Etep/0rFpzs61LYoPu5rxqyxzoVanjKj5ASE/Pr7xLLAja3zblwe7vZ+F7Tcw0BGi4/XjDSUrSijvnv4W4aOufymPqg8SYJTj6d2VSAWCHEifkcpH2Okt44OJnsnCekf3pk5JWYIydCvSaxnR598GjfPGdFCqll25r10CqA/tFg6JvxSc2r0jGJjnCf0m3PK5AWvqqirY2rAdQSXoGEMBRGP/FAsFK8ADAc9Q7553gADLPBNrERn4UiSXGMqB5ldk+rfkZuDYqmTDdZtgsdHx/rL+h0VZqOvCxMiQ0jGhiU99WJaXZ6lAJYI83g1PbV2A==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB8PR09MB3834.eurprd09.prod.outlook.com (2603:10a6:10:f8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 18 Jun
 2025 12:27:47 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 12:27:47 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v3 02/10] target/riscv: Add cpu_set_exception_base
Thread-Topic: [PATCH v3 02/10] target/riscv: Add cpu_set_exception_base
Thread-Index: AQHb4Exm+LNZXg8AbEK3klwOEhJq0Q==
Date: Wed, 18 Jun 2025 12:27:47 +0000
Message-ID: <20250618122715.1929966-3-djordje.todorovic@htecgroup.com>
References: <20250618122715.1929966-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250618122715.1929966-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB8PR09MB3834:EE_
x-ms-office365-filtering-correlation-id: e6e081a7-383a-4aef-b3d1-08ddae638884
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?McuZzpPqG0ZtaWY1UzyGLWsaaO6U5PI0pUiW7oWZS1mlBDgmhhOgzOOhyk?=
 =?iso-8859-1?Q?KauQKWPWlao5e+p1jUmkuVt/dl5tjtnWDQgRKgtSTXVQpTNvysvfTpi3tf?=
 =?iso-8859-1?Q?SLZlM6SFYdhH2uWA4IwN+bLGpx0jwh5USIa1Zq9RTXh5mdhLIijNDqxG9S?=
 =?iso-8859-1?Q?lmtwwJcA1PDBlTdgia2h9mqo+y0ByVFOecAPfWeXL61Mdool0rhAQxgGSU?=
 =?iso-8859-1?Q?PK0Yjm8U9OvZ42ArhDZ0yPNrxuq2sgNzmGN3wgMsQGHscI5Wkj/jwsqe/r?=
 =?iso-8859-1?Q?OyxVecXqcUxTwP1GtUOK19LvLqN9/KyD1oPH28QdBZZ+ZfxzOi1CCUOF7Y?=
 =?iso-8859-1?Q?+yK0+gmSdiU+QI65YseriQS10UXJ/iVBwMENW4wEGHUCAB2xotKhSZSmww?=
 =?iso-8859-1?Q?lHIbF4Gxi7q/r/FiFJgk+qrP6X5WhF3nao3NHYu0WzVK1AXtODi9Ys9QtH?=
 =?iso-8859-1?Q?3+eKg0rJCxU0wSiYjwrjVeKK6bZq7mHhqYQR1ZwOKbEjDLQJYV1S6g4XG4?=
 =?iso-8859-1?Q?ejeAGiBc4gaGgUNrfO/wuZ1hqzHh7PKCflusngds57rNzKw6HMt9lniqbJ?=
 =?iso-8859-1?Q?dAx1/owEVwqzJI7f9lhMy8Rh9GXOgER9sUUgwJxVhdInlyBzSflyycOMuK?=
 =?iso-8859-1?Q?0Ojayv5OcIrE7auTIOhltmDwDtldvD5p9F8wou238dGL4uOm8MUiLvMfm+?=
 =?iso-8859-1?Q?//w6XvfRjmyA8j0o+fXQ+W4NzPnOjmqoYIGlvktMOmliseQ2nakrHwcus1?=
 =?iso-8859-1?Q?IWCJ29k2hjX6NloFUUyZXiab1JLThtePjUIqNsLraGn9wKgFgh9ovpXdyg?=
 =?iso-8859-1?Q?k88os3jgxThl6gT6TJODpFt0axLjbfGkmrL+lPWTUOrJKJWO4E7KnBaYmX?=
 =?iso-8859-1?Q?rk/LkhgdRk8gwOmx18QDSolPbituOKDGx0etKh0m2YWqQPMgaNvyLkdSFK?=
 =?iso-8859-1?Q?3/XdL0F9nBARsG2QkmhhWrEKFhVgr3gX2YdMdyJKVOG2G81o+l7pjGInc3?=
 =?iso-8859-1?Q?YjgsrDKz5mlwSsMiy3zv7KeUIxNdkRheCycbPviGZI1Eg3iM0lzereoDhJ?=
 =?iso-8859-1?Q?8ObSLehXw6R7jhnFNXYfhPhmG6WtDYcZfYG6R34vMDUWdSt5TWr3Y91ba4?=
 =?iso-8859-1?Q?Ehz0Q7GSeI1Jf9AgVD0Dwt0CDqlxwAtrSkyhbMSDNBLQDYlrxLlihLTMZn?=
 =?iso-8859-1?Q?khvx7oUlZxWk2sTGe/UctmVz8CIhF+3AsD5Y0AVzVRvCzMm0Hhb2kaP7cT?=
 =?iso-8859-1?Q?ZFqY11wk90yiPz5tQcriPRFz8XIJTZWKgzouad4wawin88h1Ppos3OQ683?=
 =?iso-8859-1?Q?MQ+Ur2sHzi7rmcSHY8bheISacFOELkqOehnJoLncwAbjAK+KbSNkxqXHg+?=
 =?iso-8859-1?Q?lEQtERwiNr64tud2TUg6+4adKhOPIRiebSk0TsZQIvdhsab1iDG99/c3o3?=
 =?iso-8859-1?Q?ZPTtLycAyZwsPxseFNxk28CpUwYbey3LvKW6TtPeLnwXj1pheGhfdgV3dY?=
 =?iso-8859-1?Q?QzyL3sVxfmb9PvjAQpf5Cml2nlhSOzYlkBHbNPaO7zZw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?k9eJXtleIZLAFYEyCl0AIXVu3o1iFOLSabT0ohKe/RrUHPMLrW/Eb0hAj9?=
 =?iso-8859-1?Q?NrQZGvuy++EIb9jYoCfJjF3HwEs6US/TZ/CziG3CQEzfjMGKW5ErtBdpdh?=
 =?iso-8859-1?Q?/Mw2C9vLrni8Pjw84libNOs2iYO4BiuzFzoAk8bimkSm02BgTAtkxGfyEo?=
 =?iso-8859-1?Q?VjU7cdVX/oNmEOrqPAfk0FPysRX4E3hWLZQZlb6eOR0hlvPhfO9ExfbL8J?=
 =?iso-8859-1?Q?vUKa4TY/MpWtl4FPRq2tGgMkwy+r47pREicQSuQbCY1e7Ln7Dnvh6WNFMh?=
 =?iso-8859-1?Q?HRUeoMMi7lMe+0JrqlizgdEK92/xWRMqGIjMTpr8mYDg/VT5hvxkoLA7TE?=
 =?iso-8859-1?Q?AgeLty9veiv8gOkMwFp7ythFcQ1blvfL1fYmuxvqsNT7i/4SritY6NS1BS?=
 =?iso-8859-1?Q?fU3pJXtYdz78yt4sSmx1CQYyNNNDS+B5bl72ZzAUx6Vfno5gOUA1fij53l?=
 =?iso-8859-1?Q?HtkyEX/uiYmyAai5jpkByAQNL58dkxxZNOZpWFTKVFN3e9/IDqHao+P6zP?=
 =?iso-8859-1?Q?qAEuBJJ3/9hO7HmSGZTebYTsu5x33qFwAg1VEJfb/RAqf2YK7UePgf9T+f?=
 =?iso-8859-1?Q?lmO5rM19/otYflszkS2thabEQABrAXGr+siS4rxsYDhWHEIwTkjAg6auke?=
 =?iso-8859-1?Q?yoWKOHXWw/3uN7Jj3fRk7ibY+pIMH5hcgCr+hS/9Wc/9fG+YK1FmBdm+Os?=
 =?iso-8859-1?Q?7CTKAAPGcOWqZ3egPpPwwNydA7jHkFg85HvLazwDOpLXAMNU5+utuzf+2D?=
 =?iso-8859-1?Q?nWjQhM1sRpzy3l0CHNiOy0QIiSSce+7XaIolW/389bmw+RDz6o415o7XKG?=
 =?iso-8859-1?Q?dzbfr2GX5FnJ2bmTvYzYauSXfHBt14tEyRE9n13G7O/ZD+Ip5j0+93hb3J?=
 =?iso-8859-1?Q?y6vqplfHZqp0NpqnsQK+quDAcpD0hWMtzlbEqUYjVeS88hiwceWwt42Tq4?=
 =?iso-8859-1?Q?FdIffww7fSqWe7VcKbkpXUKON6ZUzIf83KI2pKYFLWavwI+0GwvvU+MCvQ?=
 =?iso-8859-1?Q?DYL7t5sQLrHlI7YB+De17fN5bM46hCrUcK4/pLOZ29sUStXpOvhBqgXkUw?=
 =?iso-8859-1?Q?BxiTAJp0ZxM4OIHQ4any7BX7f1NPEvUKwgrhe0mZJKka/LDbnnc76BNagD?=
 =?iso-8859-1?Q?H1zJ/ZF1HkFBp81cjiESFIm6ZEuE3zg666vAWPESpjOm4yORAhLzXDpV3U?=
 =?iso-8859-1?Q?OVVtvCWrZQ7QGAazmVnV4GDHlol0qyC2JZSXSnz6toZr/bUM93w1zw7BJj?=
 =?iso-8859-1?Q?+K7yyeYLj96bmrtMs8yeYzfxV5ez6bvYWQi89/SZRBQH2ufQ8opWJhXYNQ?=
 =?iso-8859-1?Q?gqV8IHinb8pa7Uuph8g+7TmWbMqyAf1MXC0+maT7UuZS7NdqOON29NUoud?=
 =?iso-8859-1?Q?n79RmQtKKU2BcV/HG/wUqgKpENU1qezJsirrfWMkdrquVrz2o63sYBON0T?=
 =?iso-8859-1?Q?+5rSanmGPk9zwEGUwk6gWtA7gHMqW9xS00/SoDK/vXU4tHt/hVZfiHz+HJ?=
 =?iso-8859-1?Q?LIeP0gu+L7naPd45JlPi43+mauSGLaKum++vOrmku4Thr8WBf0cbwVsEX1?=
 =?iso-8859-1?Q?R2wW/6axutGal1fXUhq2Na9pgFAhIinN2q6BrZYU+rDnRYm6P+lWAN1JDl?=
 =?iso-8859-1?Q?dO+sCAHQjZm6k8PZIhu3kwZK62Z1AFwnWXfigKPiCXUdE1Kpg/rPeONvp0?=
 =?iso-8859-1?Q?0jOzIumvmCLGKL2Thts=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e081a7-383a-4aef-b3d1-08ddae638884
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 12:27:47.1516 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9UF3ipPUdni7jnGHptAJepthi7hpzdR/SS0Sp70OC3aK7ow2HNdqrQwF+5RqYGSDh4CYehLMhM+bbIFPIn7jN22P/a3kJTTECD0FHFXmSa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB3834
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

Add a new function, so we can change reset vector from platforms
during runtime.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.h       | 4 ++++
 target/riscv/translate.c | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 229ade9ed9..fba0b0506b 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -656,6 +656,10 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *e=
nv,
 target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
 void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
=20
+#ifndef CONFIG_USER_ONLY
+void cpu_set_exception_base(int vp_index, target_ulong address);
+#endif
+
 FIELD(TB_FLAGS, MEM_IDX, 0, 3)
 FIELD(TB_FLAGS, FS, 3, 2)
 /* Vector flags */
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index d7a6de02df..c3fbae7cfe 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1427,3 +1427,11 @@ void riscv_translate_init(void)
     load_val =3D tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, load_=
val),
                              "load_val");
 }
+
+#ifndef CONFIG_USER_ONLY
+void cpu_set_exception_base(int vp_index, target_ulong address)
+{
+    RISCVCPU *vp =3D RISCV_CPU(qemu_get_cpu(vp_index));
+    vp->env.resetvec =3D address;
+}
+#endif
--=20
2.34.1

