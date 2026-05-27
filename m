Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F202CCD6E44
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 08:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS9gX-0001Ev-7I; Wed, 27 May 2026 04:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wS9gT-00018T-L7; Wed, 27 May 2026 04:32:14 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wS9gQ-0003yk-Ox; Wed, 27 May 2026 04:32:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gelcZsDiSl6EkI5eUioPhbh0Bd2s9gk0yzio7tAy56cYo1AZna9BSEIv8P5Mth3gTUVv29vClek4SGgshK67QxYsEkt/0HclK2jVAhJJ4YlQlnr29cv56FJuhln6cnnuIZ9tFzVd9GI6UwKB/0gxf4pcLMC/kDfqOwf1Tb4yJPBasYUT188OfXThTA9VB4TvdgbzE61bG0DVozARNPkNdW354pQGrG2kuUR5c5Ws+ClJMIpO4Ry+DctXSeOsVeTP3Yr10KDrx/R6LKEFARewD9aKr4B2JsFJAzHRDqsB8B6EuJL3/ExuCIuCHDJxJRpkaA4nf/7ikNDpFYMk3Fyi4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpol/+8l63EXw85x9pJTGWP4H5YSpUlEDuZNHL6c2s0=;
 b=IcZPDAU9y5J59p6w+qwZgpFLn5L56LZ7k3VAa7X7Fcws6P6sGzFWMDbrkh4JcLcVZ8q77PxBjUxz5U4PqHh5zDP5KpNOERWvddeNcJZIm/u5tHCLluw0RH/tZ86hdo6mPfnNObGlPdTKpY/gmYG/0rGDDbrXPjER0NPh6WumiEP/QE5c067qNDqf9LhqUFwaRQnVMULW1TiXhWqV06HglX7Jw/MsjmtDJTJkVp6gRwSJ21+ug2MAxi20mqAOBHz6KZwS116hf1wifh/hAttY4VL0U6Lp8+PosEduQGmIIrQ6hNeVpAPoR+VgZPL1X65BUN6y8ub7iNjXYlidElXPnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpol/+8l63EXw85x9pJTGWP4H5YSpUlEDuZNHL6c2s0=;
 b=uvdgDLYVRkoNNbwKoz9OPDkkkdT1MbBOaOoKtvtgaQ0yX8t61z3NDibTy4aSIUW06DbdkqJwpAp3k9n6wYaGU75p2QwHUOUZdAcTF6nfVZIN6o0lHgKNv5PEwOeK/Vj4K+5TBxJJss+MMIHUPSYynXjLqoJaT1PZbBRw846DFjukRT0YKR+f9bgFaCyu+jChUmxC3nqBOMW437+D3BzXdW1ZBHTg28KW6YPt1odLf4TmtWqIWe/c4CKVkx901HxeQBGU0v9g3eVDR9hFAIM8jbGkNByJSR5oQNTCiIVCfW4X7v7MfDH/HDGZ3l3aPTYq3ELQy71xnCkp33AWMyQrpA==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by AS8PR09MB6314.eurprd09.prod.outlook.com (2603:10a6:20b:57d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 08:31:59 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 08:31:59 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v10 3/7] target/riscv: Implement runtime data endianness via
 MSTATUS bits
Thread-Topic: [PATCH v10 3/7] target/riscv: Implement runtime data endianness
 via MSTATUS bits
Thread-Index: AQHc7bNJZXlwmt6BOkeRi6pAtn2UOw==
Date: Wed, 27 May 2026 08:31:59 +0000
Message-ID: <20260527083151.17876-4-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 212a62ce-7992-473f-c428-08debbca6bb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|3023799007|11063799006|56012099006;
x-microsoft-antispam-message-info: qLbhjxTsMbfUxvWRM7v/l3L+FC5dWANco7S45iLlElIpibI1bxs5J6H4BrLZi8IV3aazWwesWfuIMXNoKbMojlv3GGZ0NJJuIqGkLNgbcjX2D1QVOYGHqcyjTRgBOXDRnY40ZIklhPfpwpk5ozc28TqiC0iRX5+hEfi2H7Oj3KRArjaZSpqJwio8/vlEbMpZk9E30sIi3crdrmbDRaCnTEN/d65eugDOOcSxDccsMP+SnZxOcoICDnBOPURUQqmjsYo1NHe2l1UvjFwfFz0mT/yCrkt85AUX8zb+dRhyhYTrOpEe4zbBVxKhwo/fz4jvnysH7yafBH4H4tuMV/vgkGNhUk2usul/FdtpX9CEWWmTIUT77tKSESZVkFYMTU7RKtSNF3/LR1WZggEcy+YBPVwKh9AZxT1AwNOT8C/tyw8NrHuZD5PdJ+/BGOQjRg9vM66GNHQlGBeGpTzzxPKKYayflx4rGyAl+ljbHlyHWidyMmJ2BFjMsOa3ryTxKEzLe+MfUKDIUY2L95FUFzypZFW7mjF/nLRKk7wIaDf8RvmVLiJPDG72Hf+0JX46YgtyEJ0mnXwn2uViMU+aX8DBQ+5fMiJ94b464tZshk+l5QUz/CJOOkSSXTkGxWdkuJa6I81HkA29fE7i3H9TAURfpkIlheVEsbTzrFDOjQwCrbWYbGqSItvjUu3yvilg8puPolPBJOhAvTVrdENovv/mV+aEwFiXluCBu5U0zvrWAHGNeMKlFV04Ta8s4ZU48RGY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?x9dEdgDvw3k4Axu27S08fHeyJ2WyibmhDo8koWm5znSY7V+JR4hUiAOnoe?=
 =?iso-8859-1?Q?z9+uxFKFl4AhPsebXXLsGU+kAh3SPLZXnsLbdssKYzHeFqv2d+pZ4wi+4J?=
 =?iso-8859-1?Q?+N3esH4foo4VIE0ZBURR6DD6I6AM0UQ6NUXoTMO2UTdEQj3EvcOkX2sidU?=
 =?iso-8859-1?Q?l56Ac8jJgTUFHtiWBrFhLQAyLKDRvG6+YUlqUA+96hcL4R7dMWxVsn2kyP?=
 =?iso-8859-1?Q?WAdLIdBztsQUVeKSf0dJ1D7cxeIRaGbYPyEHtsAIubwRfREf8XEf64iHd3?=
 =?iso-8859-1?Q?8JMqu9ic9TxPIyDH3e3eAFhr1/Ji99nnLfUYgh+yhU9WdOIVcXxCVk5Vck?=
 =?iso-8859-1?Q?QEbg9am2WIFAH+6e+tdJzmuy75iIQNtQA2mBk4aYJo6ZfFrC6EM2/Szcpw?=
 =?iso-8859-1?Q?BvUVfd/uhUp45QmOPEUpfRqonvxQyCXBeYWQxgT2YGlF/tWLa7GVwUh2NO?=
 =?iso-8859-1?Q?kOLtzpiDkaTf8cOiSDM26P7sZej+wlYUbQpLaYVcS1jqXxydMxUCa4SjV/?=
 =?iso-8859-1?Q?pqybmHUq77IYDQIIUIzMoQGHDJGX9w/Nf/ukByOhftmR/HVezOsNbGmiCu?=
 =?iso-8859-1?Q?bo+yBBGWq/b4rB8diPjzwcBANI2VkFSg+7jmxbtRzrHi6c3JGqZy6Nb+eu?=
 =?iso-8859-1?Q?MBvsT2Mumhbzlbw+GpTJd3XoIrM6YB9IyZuq/DtUWD6Q0rU4YSZbR5pKSM?=
 =?iso-8859-1?Q?ixdZbyNxtyMQXkugZoxUk/FyN3l/6G3mMqXdwjVYBfWpDD9m1JlDsqA3Xc?=
 =?iso-8859-1?Q?vBULeKcJZLcwBLi4oGKEix1UCJu0dbKkmcYXX4bw3ZOr04NFU3qStlT2Nl?=
 =?iso-8859-1?Q?d3Rt8uiT0rH8THS0q6zGTwxJnCv0wBrZ6vEOf9oDZLQ30zgBCYrN5zLIWJ?=
 =?iso-8859-1?Q?a22dNWwTAJ4CEkaS8rA5OScLccm6TISD43oaXNLpPqFfmT2UB+90MRTeyv?=
 =?iso-8859-1?Q?f3l+vYMS3L6pFgoPdM1qgop9gI2k5a9YSK/Vr+QzXDdiVhRwF+MRnAMrJH?=
 =?iso-8859-1?Q?Fua71Q0ZLh7lPJAqVHfra5ewoS+wiGjn8nrzKF+kp9bq7sno9jSVBVnOj+?=
 =?iso-8859-1?Q?PVGBor3AaFfT3w6O3qOUbyQ/DYAB0Rxo4MCzI0ZyMKN8FI5e8AzpPJbpgt?=
 =?iso-8859-1?Q?TtQxGmvBIT1Fzl3wyZgJI6ZeAoTo8rMy5oiqN+rPgkhbqYhYb08Sf4ZS98?=
 =?iso-8859-1?Q?82RxwUjxrqnyj+6Oo9Ix2Ej2wvw5svFrtNcwisRLLFjDSVmGqQ1hg1gcTw?=
 =?iso-8859-1?Q?kuZMVqDZfa68e3TolgrvdOzUEgrhm1VPVWaUVjfZJYif/TpXSdC7ba6GiK?=
 =?iso-8859-1?Q?V+mB1SdWIpKkUcnh8EQ5vnOFK338xw3PqAkFe/M+f6CDAt6G4jSg7U97HS?=
 =?iso-8859-1?Q?A4UJCUdlRiQ6unH3AkpeKMxH5EUpG+Aioxc1uNhA8fyhpZsfCaMGs63jbE?=
 =?iso-8859-1?Q?hO/v2SqEwelL/mGZoLM6eJ+ZKSuUIuv52tRExEXNOoW+AsJb54v2plWaiY?=
 =?iso-8859-1?Q?TXkse46vQSh5+NFzsgdA2duR7dJR5X8qLyBJCJpP3IzlceTWk68frX6f3y?=
 =?iso-8859-1?Q?un1EPJ1u2yRL58kEKi33ljUX2H1z8XZD0E+rcn1d1JRl10WDTD73mowLEK?=
 =?iso-8859-1?Q?Wp/WlsF5VaRUmtIGAyZoIaf8gyFWJagYbQ9cz6A6jAJ/4n0UBPsY4+nyVX?=
 =?iso-8859-1?Q?vwCIvteoNYJ7hb0/oYxMQUVVVpdMH3INqd0L7BqgRZujX0wy8F3239NC5V?=
 =?iso-8859-1?Q?M7ZVK6dkfXTo28kqalPyOLfDJ8s9ncfWAT/BEcPMkcKfS7oMZ2rA/ZEbSw?=
 =?iso-8859-1?Q?gaj0GVB1Uy/jK77FKg9IhCCOa8on9O1t/3WLFQz9hwtrJp4EEQfr?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 212a62ce-7992-473f-c428-08debbca6bb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 08:31:59.7377 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fPwU81JsPFXSRML+XlBGmTgJeZwpP+67FMBtsHwrC9cCCK6fjYDTZTs7JjKzhlgiMXX4YJySRU0GhzKGbWtKAwr9MafJaDXbOBsC4rAl7ow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR09MB6314
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

Make data accesses honour the MSTATUS MBE/SBE/UBE endianness bits
instead of being hardcoded to little-endian. A new helper,
riscv_cpu_data_is_big_endian(), picks the bit corresponding to the
current privilege level (MBE for M, SBE for S, UBE for U). The
existing mo_endian_env() wrapper in internals.h now returns MO_BE or
MO_LE based on that helper, so the hypervisor load/store helpers in
op_helper.c pick up the runtime endianness automatically.

On the translator side, DisasContext gains a mo_endianness field
holding MO_BE or MO_LE, which the generated load/store ops OR into
their MemOp. The trivial mo_endian() wrapper is dropped and call
sites reference ctx->mo_endianness directly.

TB_FLAGS has no free bits, so the data endianness is carried in the
extended RISC-V TB flags stored in cs_base. It uses
EXT_TB_FLAGS.BIG_ENDIAN at bit 33, leaving bit 32 for
EXT_TB_FLAGS.ALTFMT. This keys TBs correctly on the current data
endianness.

Instruction fetches remain MO_LE unconditionally; RISC-V instructions
are always little-endian per the ISA specification.

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.h                            | 23 +++++++++++++++++++
 target/riscv/insn_trans/trans_rva.c.inc       |  4 ++--
 target/riscv/insn_trans/trans_rvd.c.inc       |  4 ++--
 target/riscv/insn_trans/trans_rvf.c.inc       |  4 ++--
 target/riscv/insn_trans/trans_rvi.c.inc       |  8 +++----
 target/riscv/insn_trans/trans_rvzacas.c.inc   |  4 ++--
 target/riscv/insn_trans/trans_rvzalasr.c.inc  |  4 ++--
 target/riscv/insn_trans/trans_rvzce.c.inc     |  4 ++--
 target/riscv/insn_trans/trans_rvzfh.c.inc     |  4 ++--
 target/riscv/insn_trans/trans_rvzicfiss.c.inc |  4 ++--
 target/riscv/insn_trans/trans_xmips.c.inc     |  8 +++----
 target/riscv/insn_trans/trans_xthead.c.inc    | 16 ++++++-------
 target/riscv/insn_trans/trans_zilsd.c.inc     |  4 ++--
 target/riscv/internals.h                      |  9 +-------
 target/riscv/tcg/tcg-cpu.c                    |  3 +++
 target/riscv/translate.c                      | 22 ++++++------------
 16 files changed, 68 insertions(+), 57 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 81c41e3429..1f2d0777e8 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -705,6 +705,7 @@ FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
=20
 FIELD(EXT_TB_FLAGS, MISA_EXT, 0, 32)
 FIELD(EXT_TB_FLAGS, ALTFMT, 32, 1)
+FIELD(EXT_TB_FLAGS, BIG_ENDIAN, 33, 1)
=20
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
@@ -721,6 +722,28 @@ static inline const RISCVCPUConfig *riscv_cpu_cfg(CPUR=
ISCVState *env)
     return &env_archcpu(env)->cfg;
 }
=20
+/*
+ * Return true if data accesses are big-endian for the current privilege
+ * level, based on the MSTATUS MBE/SBE/UBE bits.
+ */
+static inline bool riscv_cpu_data_is_big_endian(CPURISCVState *env)
+{
+#if defined(CONFIG_USER_ONLY)
+    return false;
+#else
+    switch (env->priv) {
+    case PRV_M:
+        return env->mstatus & MSTATUS_MBE;
+    case PRV_S:
+        return env->mstatus & MSTATUS_SBE;
+    case PRV_U:
+        return env->mstatus & MSTATUS_UBE;
+    default:
+        g_assert_not_reached();
+    }
+#endif
+}
+
 #if !defined(CONFIG_USER_ONLY)
 static inline int cpu_address_mode(CPURISCVState *env)
 {
diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_tr=
ans/trans_rva.c.inc
index 62c0fe673d..44c1696fe4 100644
--- a/target/riscv/insn_trans/trans_rva.c.inc
+++ b/target/riscv/insn_trans/trans_rva.c.inc
@@ -35,7 +35,7 @@ static bool gen_lr(DisasContext *ctx, arg_atomic *a, MemO=
p mop)
     TCGv src1;
=20
     mop |=3D MO_ALIGN;
-    mop |=3D mo_endian(ctx);
+    mop |=3D ctx->mo_endianness;
=20
     decode_save_opc(ctx, 0);
     src1 =3D get_address(ctx, a->rs1, 0);
@@ -65,7 +65,7 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, MemO=
p mop)
     TCGLabel *l2 =3D gen_new_label();
=20
     mop |=3D MO_ALIGN;
-    mop |=3D mo_endian(ctx);
+    mop |=3D ctx->mo_endianness;
=20
     decode_save_opc(ctx, 0);
     src1 =3D get_address(ctx, a->rs1, 0);
diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_tr=
ans/trans_rvd.c.inc
index ffea0c2a1f..3b9a745520 100644
--- a/target/riscv/insn_trans/trans_rvd.c.inc
+++ b/target/riscv/insn_trans/trans_rvd.c.inc
@@ -60,7 +60,7 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
     } else {
         memop |=3D MO_ATOM_IFALIGN;
     }
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
=20
     decode_save_opc(ctx, 0);
     addr =3D get_address(ctx, a->rs1, a->imm);
@@ -85,7 +85,7 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
     } else {
         memop |=3D MO_ATOM_IFALIGN;
     }
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
=20
     decode_save_opc(ctx, 0);
     addr =3D get_address(ctx, a->rs1, a->imm);
diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/insn_tr=
ans/trans_rvf.c.inc
index 89fb0f604a..e935523c93 100644
--- a/target/riscv/insn_trans/trans_rvf.c.inc
+++ b/target/riscv/insn_trans/trans_rvf.c.inc
@@ -48,7 +48,7 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |=3D MO_ATOM_WITHIN16;
     }
@@ -71,7 +71,7 @@ static bool trans_fsw(DisasContext *ctx, arg_fsw *a)
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |=3D MO_ATOM_WITHIN16;
     }
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_tr=
ans/trans_rvi.c.inc
index 2c82ae41a7..2de74fac3a 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -392,7 +392,7 @@ static bool gen_load_i128(DisasContext *ctx, arg_lb *a,=
 MemOp memop)
         }
     } else {
         tcg_gen_qemu_ld_i128(t16, addrl, ctx->mem_idx, memop);
-        if (mo_endian(ctx) =3D=3D MO_LE) {
+        if (ctx->mo_endianness =3D=3D MO_LE) {
             tcg_gen_extr_i128_i64(tl, th, t16);
         } else {
             tcg_gen_extr_i128_i64(th, tl, t16);
@@ -409,7 +409,7 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemO=
p memop)
 {
     bool out;
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |=3D MO_ATOM_WITHIN16;
     }
@@ -508,7 +508,7 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb *a=
, MemOp memop)
         tcg_gen_ext_tl_i64(tl, src2l);
         tcg_gen_ext_tl_i64(th, src2h);
=20
-        if (mo_endian(ctx) =3D=3D MO_LE) {
+        if (ctx->mo_endianness =3D=3D MO_LE) {
             tcg_gen_concat_i64_i128(t16, tl, th);
         } else {
             tcg_gen_concat_i64_i128(t16, th, tl);
@@ -520,7 +520,7 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb *a=
, MemOp memop)
=20
 static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
 {
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |=3D MO_ATOM_WITHIN16;
     }
diff --git a/target/riscv/insn_trans/trans_rvzacas.c.inc b/target/riscv/ins=
n_trans/trans_rvzacas.c.inc
index 8d94b83ce9..79bca1e957 100644
--- a/target/riscv/insn_trans/trans_rvzacas.c.inc
+++ b/target/riscv/insn_trans/trans_rvzacas.c.inc
@@ -76,7 +76,7 @@ static bool gen_cmpxchg64(DisasContext *ctx, arg_atomic *=
a, MemOp mop)
     TCGv src1 =3D get_address(ctx, a->rs1, 0);
     TCGv_i64 src2 =3D get_gpr_pair(ctx, a->rs2);
=20
-    mop |=3D mo_endian(ctx);
+    mop |=3D ctx->mo_endianness;
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     tcg_gen_atomic_cmpxchg_i64(dest, src1, dest, src2, ctx->mem_idx, mop);
=20
@@ -121,7 +121,7 @@ static bool trans_amocas_q(DisasContext *ctx, arg_amoca=
s_q *a)
     TCGv_i64 desth =3D get_gpr(ctx, a->rd =3D=3D 0 ? 0 : a->rd + 1, EXT_NO=
NE);
     MemOp memop =3D MO_ALIGN | MO_UO;
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     tcg_gen_concat_i64_i128(src2, src2l, src2h);
     tcg_gen_concat_i64_i128(dest, destl, desth);
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
diff --git a/target/riscv/insn_trans/trans_rvzalasr.c.inc b/target/riscv/in=
sn_trans/trans_rvzalasr.c.inc
index 0f307affec..79b0b2c63b 100644
--- a/target/riscv/insn_trans/trans_rvzalasr.c.inc
+++ b/target/riscv/insn_trans/trans_rvzalasr.c.inc
@@ -29,7 +29,7 @@ static bool gen_load_acquire(DisasContext *ctx, arg_lb_aq=
rl *a, MemOp memop)
         return false;
     }
=20
-    memop |=3D MO_ALIGN | mo_endian(ctx);
+    memop |=3D MO_ALIGN | ctx->mo_endianness;
     memop |=3D (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
=20
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, memop);
@@ -79,7 +79,7 @@ static bool gen_store_release(DisasContext *ctx, arg_sb_a=
qrl *a, MemOp memop)
         return false;
     }
=20
-    memop |=3D MO_ALIGN | mo_endian(ctx);
+    memop |=3D MO_ALIGN | ctx->mo_endianness;
     memop |=3D (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
=20
     /* Add a memory barrier implied by RL (mandatory) and AQ (optional) */
diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/insn_=
trans/trans_rvzce.c.inc
index 0d3ba40e52..71b4ca5473 100644
--- a/target/riscv/insn_trans/trans_rvzce.c.inc
+++ b/target/riscv/insn_trans/trans_rvzce.c.inc
@@ -185,7 +185,7 @@ static bool gen_pop(DisasContext *ctx, arg_cmpp *a, boo=
l ret, bool ret_val)
=20
     tcg_gen_addi_tl(addr, sp, stack_adj - reg_size);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     for (i =3D X_Sn + 11; i >=3D 0; i--) {
         if (reg_bitmap & (1 << i)) {
             TCGv dest =3D dest_gpr(ctx, i);
@@ -239,7 +239,7 @@ static bool trans_cm_push(DisasContext *ctx, arg_cm_pus=
h *a)
=20
     tcg_gen_subi_tl(addr, sp, reg_size);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     for (i =3D X_Sn + 11; i >=3D 0; i--) {
         if (reg_bitmap & (1 << i)) {
             TCGv val =3D get_gpr(ctx, i, EXT_NONE);
diff --git a/target/riscv/insn_trans/trans_rvzfh.c.inc b/target/riscv/insn_=
trans/trans_rvzfh.c.inc
index 791ee51f65..f36b46c211 100644
--- a/target/riscv/insn_trans/trans_rvzfh.c.inc
+++ b/target/riscv/insn_trans/trans_rvzfh.c.inc
@@ -49,7 +49,7 @@ static bool trans_flh(DisasContext *ctx, arg_flh *a)
     REQUIRE_FPU;
     REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     decode_save_opc(ctx, 0);
     t0 =3D get_gpr(ctx, a->rs1, EXT_NONE);
     if (a->imm) {
@@ -74,7 +74,7 @@ static bool trans_fsh(DisasContext *ctx, arg_fsh *a)
     REQUIRE_FPU;
     REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     decode_save_opc(ctx, 0);
     t0 =3D get_gpr(ctx, a->rs1, EXT_NONE);
     if (a->imm) {
diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/i=
nsn_trans/trans_rvzicfiss.c.inc
index 0b6ad57965..43f586dce9 100644
--- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
@@ -105,7 +105,7 @@ static bool trans_ssamoswap_w(DisasContext *ctx, arg_am=
oswap_w *a)
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     src1 =3D get_address(ctx, a->rs1, 0);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx), memop);
     gen_set_gpr(ctx, a->rd, dest);
     return true;
@@ -135,7 +135,7 @@ static bool trans_ssamoswap_d(DisasContext *ctx, arg_am=
oswap_w *a)
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     src1 =3D get_address(ctx, a->rs1, 0);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx), memop);
     gen_set_gpr(ctx, a->rd, dest);
     return true;
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
index c1a30156d3..1b9993a9b0 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -47,7 +47,7 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
 /* Load Doubleword Pair. */
 static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
 {
-    MemOp memop =3D MO_SQ | mo_endian(ctx);
+    MemOp memop =3D MO_SQ | ctx->mo_endianness;
=20
     REQUIRE_XMIPSLSP(ctx);
     REQUIRE_64_OR_128BIT(ctx);
@@ -71,7 +71,7 @@ static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
 /* Load Word Pair. */
 static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
 {
-    MemOp memop =3D MO_SL | mo_endian(ctx);
+    MemOp memop =3D MO_SL | ctx->mo_endianness;
=20
     REQUIRE_XMIPSLSP(ctx);
=20
@@ -94,7 +94,7 @@ static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
 /* Store Doubleword Pair. */
 static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
 {
-    MemOp memop =3D MO_UQ | mo_endian(ctx);
+    MemOp memop =3D MO_UQ | ctx->mo_endianness;
=20
     REQUIRE_XMIPSLSP(ctx);
     REQUIRE_64_OR_128BIT(ctx);
@@ -116,7 +116,7 @@ static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
 /* Store Word Pair. */
 static bool trans_swp(DisasContext *ctx, arg_swp *a)
 {
-    MemOp memop =3D MO_SL | mo_endian(ctx);
+    MemOp memop =3D MO_SL | ctx->mo_endianness;
=20
     REQUIRE_XMIPSLSP(ctx);
=20
diff --git a/target/riscv/insn_trans/trans_xthead.c.inc b/target/riscv/insn=
_trans/trans_xthead.c.inc
index f8b95c6498..f4e3051000 100644
--- a/target/riscv/insn_trans/trans_xthead.c.inc
+++ b/target/riscv/insn_trans/trans_xthead.c.inc
@@ -349,7 +349,7 @@ static bool gen_fload_idx(DisasContext *ctx, arg_th_mem=
idx *a, MemOp memop,
     TCGv_i64 rd =3D cpu_fpr[a->rd];
     TCGv addr =3D get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, zex=
t_offs);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     tcg_gen_qemu_ld_i64(rd, addr, ctx->mem_idx, memop);
     if ((memop & MO_SIZE) =3D=3D MO_32) {
         gen_nanbox_s(rd, rd);
@@ -370,7 +370,7 @@ static bool gen_fstore_idx(DisasContext *ctx, arg_th_me=
midx *a, MemOp memop,
     TCGv_i64 rd =3D cpu_fpr[a->rd];
     TCGv addr =3D get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, zex=
t_offs);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     tcg_gen_qemu_st_i64(rd, addr, ctx->mem_idx, memop);
=20
     return true;
@@ -570,7 +570,7 @@ static bool gen_load_inc(DisasContext *ctx, arg_th_memi=
nc *a, MemOp memop,
     TCGv rd =3D dest_gpr(ctx, a->rd);
     TCGv rs1 =3D get_gpr(ctx, a->rs1, EXT_NONE);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     tcg_gen_qemu_ld_tl(rd, addr, ctx->mem_idx, memop);
     tcg_gen_addi_tl(rs1, rs1, imm);
     gen_set_gpr(ctx, a->rd, rd);
@@ -591,7 +591,7 @@ static bool gen_store_inc(DisasContext *ctx, arg_th_mem=
inc *a, MemOp memop,
     TCGv data =3D get_gpr(ctx, a->rd, EXT_NONE);
     TCGv rs1 =3D get_gpr(ctx, a->rs1, EXT_NONE);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
     tcg_gen_addi_tl(rs1, rs1, imm);
     gen_set_gpr(ctx, a->rs1, rs1);
@@ -747,7 +747,7 @@ static bool gen_load_idx(DisasContext *ctx, arg_th_memi=
dx *a, MemOp memop,
     TCGv rd =3D dest_gpr(ctx, a->rd);
     TCGv addr =3D get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, zex=
t_offs);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     tcg_gen_qemu_ld_tl(rd, addr, ctx->mem_idx, memop);
     gen_set_gpr(ctx, a->rd, rd);
=20
@@ -765,7 +765,7 @@ static bool gen_store_idx(DisasContext *ctx, arg_th_mem=
idx *a, MemOp memop,
     TCGv data =3D get_gpr(ctx, a->rd, EXT_NONE);
     TCGv addr =3D get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, zex=
t_offs);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
=20
     return true;
@@ -926,7 +926,7 @@ static bool gen_loadpair_tl(DisasContext *ctx, arg_th_p=
air *a, MemOp memop,
     addr1 =3D get_address(ctx, a->rs, imm);
     addr2 =3D get_address(ctx, a->rs, memop_size(memop) + imm);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     tcg_gen_qemu_ld_tl(t1, addr1, ctx->mem_idx, memop);
     tcg_gen_qemu_ld_tl(t2, addr2, ctx->mem_idx, memop);
     gen_set_gpr(ctx, a->rd1, t1);
@@ -965,7 +965,7 @@ static bool gen_storepair_tl(DisasContext *ctx, arg_th_=
pair *a, MemOp memop,
     addr1 =3D get_address(ctx, a->rs, imm);
     addr2 =3D get_address(ctx, a->rs, memop_size(memop) + imm);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     tcg_gen_qemu_st_tl(data1, addr1, ctx->mem_idx, memop);
     tcg_gen_qemu_st_tl(data2, addr2, ctx->mem_idx, memop);
     return true;
diff --git a/target/riscv/insn_trans/trans_zilsd.c.inc b/target/riscv/insn_=
trans/trans_zilsd.c.inc
index f50c52f22c..8068cc1aec 100644
--- a/target/riscv/insn_trans/trans_zilsd.c.inc
+++ b/target/riscv/insn_trans/trans_zilsd.c.inc
@@ -30,7 +30,7 @@ static bool gen_load_i64(DisasContext *ctx, arg_ld *a)
     TCGv addr =3D get_address(ctx, a->rs1, a->imm);
     TCGv_i64 tmp =3D tcg_temp_new_i64();
=20
-    tcg_gen_qemu_ld_i64(tmp, addr, ctx->mem_idx, MO_SQ | mo_endian(ctx));
+    tcg_gen_qemu_ld_i64(tmp, addr, ctx->mem_idx, MO_SQ | ctx->mo_endiannes=
s);
=20
     if (a->rd =3D=3D 0) {
         return true;
@@ -85,7 +85,7 @@ static bool gen_store_i64(DisasContext *ctx, arg_sd *a)
     } else {
         tcg_gen_concat_tl_i64(tmp, data_low, data_high);
     }
-    tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_SQ | mo_endian(ctx));
+    tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_SQ | ctx->mo_endiannes=
s);
=20
     return true;
 }
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index bac6c8032a..dc505a9ab3 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -64,14 +64,7 @@ static inline bool mmuidx_2stage(int mmu_idx)
=20
 static inline MemOp mo_endian_env(CPURISCVState *env)
 {
-    /*
-     * A couple of bits in MSTATUS set the endianness:
-     *  - MSTATUS_UBE (User-mode),
-     *  - MSTATUS_SBE (Supervisor-mode),
-     *  - MSTATUS_MBE (Machine-mode)
-     * but we don't implement that yet.
-     */
-    return MO_LE;
+    return riscv_cpu_data_is_big_endian(env) ? MO_BE : MO_LE;
 }
=20
 /* share data between vector helpers and decode code */
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 02c98cc2db..81b56e5a62 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -193,6 +193,9 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *c=
s)
     flags =3D FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
=20
     ext_flags =3D FIELD_DP64(ext_flags, EXT_TB_FLAGS, MISA_EXT, env->misa_=
ext);
+    if (riscv_cpu_data_is_big_endian(env)) {
+        ext_flags =3D FIELD_DP64(ext_flags, EXT_TB_FLAGS, BIG_ENDIAN, 1);
+    }
=20
     return (TCGTBCPUState){
         .pc =3D env->xl =3D=3D MXL_RV32 ? env->pc & UINT32_MAX : env->pc,
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 1e4f340256..35c6b37c0b 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -120,6 +120,8 @@ typedef struct DisasContext {
     bool fcfi_lp_expected;
     /* zicfiss extension, if shadow stack was enabled during TB gen */
     bool bcfi_enabled;
+    /* Data endianness from MSTATUS UBE/SBE/MBE */
+    MemOp mo_endianness;
 } DisasContext;
=20
 static inline bool has_ext(DisasContext *ctx, uint32_t ext)
@@ -127,18 +129,6 @@ static inline bool has_ext(DisasContext *ctx, uint32_t=
 ext)
     return ctx->misa_ext & ext;
 }
=20
-static inline MemOp mo_endian(DisasContext *ctx)
-{
-    /*
-     * A couple of bits in MSTATUS set the endianness:
-     *  - MSTATUS_UBE (User-mode),
-     *  - MSTATUS_SBE (Supervisor-mode),
-     *  - MSTATUS_MBE (Machine-mode)
-     * but we don't implement that yet.
-     */
-    return MO_LE;
-}
-
 #ifdef TARGET_RISCV32
 #define get_xl(ctx)    MXL_RV32
 #elif defined(CONFIG_USER_ONLY)
@@ -155,7 +145,7 @@ static inline MemOp mo_endian(DisasContext *ctx)
 #define get_address_xl(ctx)    ((ctx)->address_xl)
 #endif
=20
-#define mxl_memop(ctx) ((get_xl(ctx) + 1) | mo_endian(ctx))
+#define mxl_memop(ctx) ((get_xl(ctx) + 1) | (ctx)->mo_endianness)
=20
 /* The word size for this machine mode. */
 static inline int __attribute__((unused)) get_xlen(DisasContext *ctx)
@@ -1156,7 +1146,7 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
     TCGv src1, src2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
     MemOp size =3D mop & MO_SIZE;
=20
-    mop |=3D mo_endian(ctx);
+    mop |=3D ctx->mo_endianness;
     if (ctx->cfg_ptr->ext_zama16b && size >=3D MO_32) {
         mop |=3D MO_ATOM_WITHIN16;
     } else {
@@ -1177,7 +1167,7 @@ static bool gen_cmpxchg(DisasContext *ctx, arg_atomic=
 *a, MemOp mop)
     TCGv src1 =3D get_address(ctx, a->rs1, 0);
     TCGv src2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
=20
-    mop |=3D mo_endian(ctx);
+    mop |=3D ctx->mo_endianness;
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     tcg_gen_atomic_cmpxchg_tl(dest, src1, dest, src2, ctx->mem_idx, mop);
=20
@@ -1360,6 +1350,8 @@ static void riscv_tr_init_disas_context(DisasContextB=
ase *dcbase, CPUState *cs)
     ctx->zero =3D tcg_constant_tl(0);
     ctx->virt_inst_excp =3D false;
     ctx->decoders =3D cpu->decoders;
+    ctx->mo_endianness =3D FIELD_EX64(ext_tb_flags, EXT_TB_FLAGS, BIG_ENDI=
AN)
+                         ? MO_BE : MO_LE;
 }
=20
 static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
--=20
2.34.1

