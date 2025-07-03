Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF9EC83F09
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHVn-0002qk-7l; Thu, 03 Jul 2025 06:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uXHVj-0002oo-LW; Thu, 03 Jul 2025 06:49:48 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uXHVi-00076R-05; Thu, 03 Jul 2025 06:49:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4fDs9tXyDowex5bnBWc5Y+JrMrd/PA2VfSfPZZhpyjQjdHxehAeNDgsLh1d9Yuej3RZO2mkUlQGcz6js2I9ZOkg80iXiHKnYcXlYwOlxhuByqMOmI3USdSG0P59Z87VibiBfL1cQJw4kzbMA+roh49RXd7d81tZkJ5llB+rpYwo76hShCOW9PKay/42ldfxhzYls2y6529a//5f6dvGpdn+MFgTdRBExFoE3PugLSvgdC8VbjJX1hi/e3O+zzdcqqZEbshRNUD3TL9CoTz5xug41x7rt/iM5JfAq3y6UQvpa8+EZYmJp4SuaZCQ8X0X8SEJYBlSPFFs73XOMNPWiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1q3rJBWImDAq4luB3RlZQ0coO+pP6l5EZ0FDzOxm4B8=;
 b=k/TYw3lsk4rN0ra39l3oxX+NhfeVd5EA19QvX9tySQ3UMIBA/B0qb8AAUsVrcBgtbaIeK+1rggWrgb6qcxocgjgkerSPy8X6W46zUn+UduTUgQkjsfvdniTnmzJPFxFky//nObrOFNu6TAd2Ek5+W7TLYF0eHWhVnkicM7jTGEDTW2Mye41LCok/biIDMX3/yYKCEx9605J5JkUOe2xX8PL7RcchZoeYUQ5lnmdJ/UKBDQKDYlyhBzKS0/76xqaxYZTdjOygDJY3xgI5uVWNPh+gFsRozU07/GIvAV7Zh0wDPCtUZ4Kxq3j2dm0dQb4o3hciaLFf10gxBqqQ4kwXlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1q3rJBWImDAq4luB3RlZQ0coO+pP6l5EZ0FDzOxm4B8=;
 b=ZlvVOcqvA4k/dyBmg6JjbjOJx6otu0uDH6sCYRPubPYTql2yRUq3DRhye8JZVQ097LhfranFMuTq96WJG4GdXGDTCUuUtBCWcH4wA0PLN33PnDbbARULz4Vi10SMDoacWiiEN5hD5QyekyH1c6yMuHW9e7NbEfULdVlq0XUP15nu1sorH6kVjKQf30tL7SjqW9u20/WTF8OcrnvNvylKbMIqE9nlauhhNwPjmOqJW6x3llAaSgtsQKzfkwWohQmY+gz9UbIN3MUHorHorpN0Nu+Nb7VYuONWF993FGbwoDUpBD6NdpXlikeva2WAEZbdSpwS6s0Oz7qU7PwvAJzmTg==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by VI2PR09MB7288.eurprd09.prod.outlook.com (2603:10a6:800:223::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 10:49:32 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Thu, 3 Jul 2025
 10:49:32 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v5 02/11] target/riscv: Add cpu_set_exception_base
Thread-Topic: [PATCH v5 02/11] target/riscv: Add cpu_set_exception_base
Thread-Index: AQHb7Ago41/vPSul10+EYrUOn6yIDQ==
Date: Thu, 3 Jul 2025 10:49:31 +0000
Message-ID: <20250703104925.112688-3-djordje.todorovic@htecgroup.com>
References: <20250703104925.112688-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250703104925.112688-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|VI2PR09MB7288:EE_
x-ms-office365-filtering-correlation-id: 75163c57-80a3-43a5-0729-08ddba1f4b06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?GH9Im+0EjEuJH7kaFCGpk9Fpy0eJFGaFoD97Dw7H/0x9VneRqoy6n6TkXj?=
 =?iso-8859-1?Q?hPh9lq5MVVO8LYKOe9m/Ne1ng7NJgNQL79AWqAOiAMWk3DfAXdQuZJh1V7?=
 =?iso-8859-1?Q?6WckHS+LFLP4SBzpA+YLy1ha94sDtbeaYpSQeFuMzK7ySJ42qxL3NwkT+B?=
 =?iso-8859-1?Q?1R5B4+kk9stQvJvpEpk1VR4KeMtAeDc/8/1SL6xQ1BUoIvohEyaz/RD7kH?=
 =?iso-8859-1?Q?qZ3ZFwe+bEYPd/khp803k4LOxbWSfoPN3thOlBTbrPS3Cl7VZ/AJVXuL4v?=
 =?iso-8859-1?Q?YXV+BakKFA6r7MYXJaQ59aXvFA93pSf0kk4omkOT6i/ahw3RB26tx7JlI/?=
 =?iso-8859-1?Q?RB2WoS/m75TOQcrN9fnRZ0uBflwUWOxny8abKRimXDza4aVzEMKSrAEout?=
 =?iso-8859-1?Q?FtsMSFBL3qVtTl9m5YIS+Nt7c8/kfvF2J1uB4sr4XnczyqDxMiZjvnzaD0?=
 =?iso-8859-1?Q?TlqkwdY6OiL9/s1bpT6c1FOLdE3CFsERgdbShVAG7fsN9CpSErXbsBmbWt?=
 =?iso-8859-1?Q?DuR6JGsBei0znq2oAMRce4XuyN6K+ndLmwimgJDQ9OtfxBeqRG378pE2bR?=
 =?iso-8859-1?Q?r3qm6quQ4XuRt/z6xNPTeyi16lbzOHPQZF2sYkupBETzRIFb9rtpvGN72r?=
 =?iso-8859-1?Q?ylvWCAeU7IvLfiycdSDJjOLnE+hczVXdXaJTXpU4FYHoxn4p2e6vDOjC0O?=
 =?iso-8859-1?Q?J+lm7UvJR/udL/On9jYTHn07bHqjcw57vsv6zMoi7noXhbe5mKUkLY9z9O?=
 =?iso-8859-1?Q?9WqIpQM/OeNqd496aqchvH+zuDx9ZKLzSna+NxMqdWKnO5XGW1UT8HqN59?=
 =?iso-8859-1?Q?06BTliiE/XBTxlVP4/jL0e7nI0DCYOLB+zEiztxSkRlooMbp1AUgB1ZcGS?=
 =?iso-8859-1?Q?PDsqOCiCObTp4C9tDOr4jAMCY3b7zncabm2FBrqJCkHvp37V9poPefeDsz?=
 =?iso-8859-1?Q?IglH/cBxaXbFAllH9ruFsNsXIRBDWtAlx4MNNDZLkXjtdhijK6z3TWNW7u?=
 =?iso-8859-1?Q?P1i8qZ/NICIZeZGj0ex9i3q0S6y2utiHrfOD9bcK9YX54kCZub0kqplOXE?=
 =?iso-8859-1?Q?sfunCgfRuBCLG+dgan1VWB2pF1EP/VxQr/2u/CmXZpV+K5kS7ntP1dXwK6?=
 =?iso-8859-1?Q?mKxyx6hXJI7PRW4CssLMjVQtoeAVtT7xQfudFDv5aJmi7IQOpilOBx+8rq?=
 =?iso-8859-1?Q?MUGlZ0dWOP5rfesBe+9zKwM98xVylmcATUQFSI4WLr9lxpcAM45Cmi1Phz?=
 =?iso-8859-1?Q?QLOIc0QKUn+lfKqTh9NVtC1fcj+ZPkRNYc7n+jboH3QGTakXAkaJ6lKjB1?=
 =?iso-8859-1?Q?0wDFTVtWAQd5A3Hv0d8kAglwmh/W61KlRUAvUouz+Qe6YX3/WbRjmCUm9a?=
 =?iso-8859-1?Q?qpItwR3Kki2Z6D69Dt2BwblnLTIS7kDCiqREvNxkWVnqnIy6VA9222+Fu4?=
 =?iso-8859-1?Q?8HhjoUD2YuW0gdb+g6+4zQWUQxBIb31Lc1bR1ERBA9eM1jeeRcb2Hxn/cg?=
 =?iso-8859-1?Q?moPqO53uWLnp9BhC+9Aei1rw25ekXElsrztbPy5d2nUw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JAVzX/3t7i6is+y1M0Qol99zodnfcEhPryH5sU9ZTUqEGAgs3mDoA9oTi4?=
 =?iso-8859-1?Q?7qpGxxlge6mUkxXr2iGktJ+HxWFA5ggLZ0PrSMmi5HmGBs9R4btQDQNuZC?=
 =?iso-8859-1?Q?48lKNnFI8yr3LwMfl10bcK+fNrE+TDKK/SSfM2Forus4y5pPVqmWJVgaIF?=
 =?iso-8859-1?Q?kY/Dr+ktEW+f+YlzwIQfiIENT404dDttDwxfG241HDZOOgiNw8tganSQll?=
 =?iso-8859-1?Q?7eMhzQ4lywjcfOlmxnXDZCse87SbBK8IzoqNWVjQvDw/LIRy1w8MIeIvuy?=
 =?iso-8859-1?Q?QDLpm/fqwX7WBrOXnx3lS1UT8L5Qq2Vl4OxxX45o7CLzj8lWgTl0g0xbj2?=
 =?iso-8859-1?Q?o9qY8KK7gnU8wGpDy/ydo8A4jJdbaZ0SSBkgONmFRt1mCUmfUwhJJ9O/AF?=
 =?iso-8859-1?Q?Ecom2RfhLHA7z20HK9n4EqGka28g59Iy5klxVQpUQsLQtibQsrYtrTTcHZ?=
 =?iso-8859-1?Q?/gh5FhBmuT79U+k7KEcskvlFC40nx0c2aBkOfbXlOrA1t0q2AotfAW0pm5?=
 =?iso-8859-1?Q?C7NG92fSd477emYTD47j5l9WCaRa4OeI19t55nM8+e2uENGm0evToGyvly?=
 =?iso-8859-1?Q?gtTM+AD0bspqza5h/3isD6WxezmwRt69sdBWQg3IF08hHo0kQ2XFojOdTj?=
 =?iso-8859-1?Q?k5PNOjR+A8PxkNNbF6ZwR7gdcMrU1Zqfl7Zz92S8dA3PYWmOxlFXIyIGxh?=
 =?iso-8859-1?Q?drFygp3dXtMfLxi7WaJ1MdpLRFZsv4R4vW4DGfffIh9Z+6SX+OPLnxAkyE?=
 =?iso-8859-1?Q?QuUo4IxXQl5Bx5bqot8eSzKdbYHCYNsTW6jXbEGJ/qsidRcsNoDpdiGn2f?=
 =?iso-8859-1?Q?va99ySSpm/BbPy4Ec7pvK+ssFGqTXui+WnZBINPOsGqwevUzYKubPUKrUG?=
 =?iso-8859-1?Q?5rUph90CAXJDsGjj5xW7qCv7GkAHkjn0UymgBHUFmuVZv8itcQmrnNoDXq?=
 =?iso-8859-1?Q?A5tunwNMWc5jf0l4APkavcwwzAi8T+4X0Phb3xy1ef3AXMxY4bAUcZn4FL?=
 =?iso-8859-1?Q?V1MCxk9e+mwFFFOM795DNvhYLPElqx6LPtNxI1LWe4mDL+2aKWmfcfrtWO?=
 =?iso-8859-1?Q?/BLGpXTXSTjOEPBjcm2ZvYFifNz60mE0WVxPSNDCxzNqlJOFGIx5G5AfUW?=
 =?iso-8859-1?Q?HO2J+iJvR87m5fgG1PR4AE6anGufw4ku5pxiPC/6vdAuwdOv9NDQM6siZZ?=
 =?iso-8859-1?Q?FXdL/gAqqVx+ieGl5ks4tmRmMvwFVUQvAIUoPNzfHt0Y3/K/VbHuN3HNlA?=
 =?iso-8859-1?Q?L+kTdXd5dU8AYh7er3VxYn2D6oFUpwot3DhuW/269bBQ17gUY+/sCVeScS?=
 =?iso-8859-1?Q?sp+z+F112xtPhLRwskZ+wA+1aPDqBesmVwsU6qXkF/rwi48F+QRd+QX+mP?=
 =?iso-8859-1?Q?Q1E8exEio2iqitopIJfwfAwaJRTUDPi8Pc4WBErd6ppOTDLiZmhcpBA6Ju?=
 =?iso-8859-1?Q?+8tbj93sd21PQy5IKiTimTbRU5iJl9FscUq+w318rzYWFpc+eGgptb2Hi0?=
 =?iso-8859-1?Q?99ZksCFSR2dpbybdfujcrxqXJgPSGFr8xA3coGOev7ebVjLlvOb1QW9B4n?=
 =?iso-8859-1?Q?BYXa8YydXTBbJpyVYi6+ReEjgEK8d/rMCKy0qK21ZJYU0ME+0nUQABawSH?=
 =?iso-8859-1?Q?9Jg6ywS8JKytXEKag4iPj6YnrwAFJOXpz1KUGQ2J+Am2Q3r+1PitsJL0sI?=
 =?iso-8859-1?Q?Iau18Qqm+P/BvZ4etTU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75163c57-80a3-43a5-0729-08ddba1f4b06
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 10:49:31.7204 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EoOr7rQt3AWEIGjZQ6Nq/RWWWHwqsFtoY9Ddc83XULHULE7hVB3oWperT2wYiSVlGt74jlIGbAFmljBOWEQ5kM/ZicShMDWN0tdKgAtiADE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR09MB7288
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

Add a new function, so we can change reset vector from platforms
during runtime.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.c | 13 +++++++++++++
 target/riscv/cpu.h |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 629ac37501..e584bdc5ac 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -73,6 +73,19 @@ bool riscv_cpu_option_set(const char *optname)
     return g_hash_table_contains(general_user_opts, optname);
 }
=20
+#ifndef CONFIG_USER_ONLY
+void cpu_set_exception_base(int vp_index, target_ulong address)
+{
+    CPUState *cpu_state =3D qemu_get_cpu(vp_index);
+    if (cpu_state =3D=3D NULL) {
+        qemu_log_mask(LOG_GUEST_ERROR, "cpu_set_exception_base: invalid vp=
_index: %u",
+                      vp_index);
+    }
+    RISCVCPU *vp =3D RISCV_CPU(cpu_state);
+    vp->env.resetvec =3D address;
+}
+#endif
+
 static void riscv_cpu_cfg_merge(RISCVCPUConfig *dest, const RISCVCPUConfig=
 *src)
 {
 #define BOOL_FIELD(x) dest->x |=3D src->x;
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
--=20
2.34.1

