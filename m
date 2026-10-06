Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B97CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMxx-0006Kr-IG; Wed, 07 Oct 2026 04:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEHi8-00064m-5J
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:49:08 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEHht-00043C-SM
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:48:41 -0400
Received: from SI3PR02MB9388.apcprd02.prod.outlook.com (2603:1096:4:2a6::8) by
 KUZPR02MB9164.apcprd02.prod.outlook.com (2603:1096:d10:61::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.15; Tue, 6 Oct 2026 20:56:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fvx2CypaML6p/SMClBd/VkPdExBCBE0hsGMgxSG8E+GlX1Xs8H2eCQSQNHEKFgn91kVw+F67fuJ4Z8b3ha6zbK2l4kw0wxGGXq+n29S2Da9GgXmXQs28tpNxeV0jhRYA1R9O1QLVmxNu98fF0/128kjRrLRRfroaYa+wPQD89jzUsqStRJxzHmGcWcaeADxoWk9EQGnI7ff4SiYr5H3XSjvdbUdEOuPCuK3JYDSuFPlP+UHdbdP855Dv2YiuzTaiCzvVuiX6lPMlSwNXkOTP4QobHVO2gLcvtIsuW/chEH+FF2ZWHcbcUgUu2i5YxFjpv25lVt8HQlVrPA4bJNK0WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4gAsjQHgUIcQb+IqEWQIJMZ/KGu+uVQ5iNDNR97Guk=;
 b=RqUHPbwOGJcn+qvNFrRiH4PRpveaiMdHmuhTI3OCHP8uOTE59YRooRE0chFh/lNShJ8C6XXStvaDigusYEvjgY+qY7NH2RMWjp8Lyx8kX0aNdRFWHqGo7PI+h7Mc3YzfSJAphBbloes4RZIjCrmAkaVdy779BA5bWZzDguIq3aR6veWZmOLMgBySq1ze4Wgq9Z64tdhX9mDW8cDliprg4fyr2XM+RUwmqNA+x6lG6uoooUMWzUlKUxnFNmHBp9MiCI78QG+dXS8pAFXbKo/0oWXQKyQ0mUa80gUq4dRDCO9KfsmYo/QmDbazwGoUKwTX/xwPu5FQR9hytlis5Rw0SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4gAsjQHgUIcQb+IqEWQIJMZ/KGu+uVQ5iNDNR97Guk=;
 b=kK7Pui97pItKLyhObM72xKDJCloGcPsyHJMi5ubIAEQvhk+r1oGOtcjKrxgmLC0+2iVFGEmgeezbPtnNJqQ6I3EkfJRYvQ+uG2EZGljf0FCsD/HZZbRqZVlF4h71Wnc7/Zy7CYjVp16R8ERtvVeRz8WMQlS8PZNVmitzhqklIzIpN6iPmYpiFbS1UXikuouEl72f8hkFoDkVC/ca8RRWwM/kElv/lmMt3NMaCt5DHRjAukMLFPORqNpt2Bjhi74xHFCguJOS4m81hy/9za22gRcv4ogKkwlhNmmAtuVc44S9z0B6PM7aBUCNsPE+roFPGgohC8zcDCIGm2dBqOjxaw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by SI3PR02MB9388.apcprd02.prod.outlook.com (2603:1096:4:2a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 09:50:52 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 09:50:51 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 17/17] tests/tcg/ppc: Test FPSCR W/L handling on
 e500mc/e5500/e6500
Date: Tue,  6 Oct 2026 17:49:12 +0800
Message-ID: <20261006094921.110871-18-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006094921.110871-1-bin.meng@processmission.com>
References: <20261006094921.110871-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0136.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::6) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|SI3PR02MB9388:EE_|KUZPR02MB9164:EE_
X-MS-Office365-Filtering-Correlation-Id: a04e16c8-ebdf-4c97-f21f-08df238f4eb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|10067099003|3023799007|260925021311599003|260925021911599003|260925022911599003|56012099006;
X-Microsoft-Antispam-Message-Info: MWUMf6jSk7bqmp4MnkjlnMerKU007BijPI5NVTs6HciKWp/O/ifzQoFB9Kx9FSBk4YehMfE0wBKNHP+/lz9yOoIYCmZ85HXyqGmjIhKwNXPN9amq/dGp1aOSZv7ufq24yA5MTCMK5y4BzMT9YAQpPQO8Sq85WcQmmUo94mPtSNAxbXDOpvPCkt/bnr/qCXD6V1jXNoC8zP4+SqSvVGx7fq9MLmk0n7EZHUs+VzJhtVhm0qv0apQ1LbgHv5Hk9xbJy0boGqqFCVwgtui2ozZ/Nt+WYe8uJXpVaalA2IaBohRQ+UqCtTGYi2r8kvZ745JZLUmVhXdkDee9OtZOgl2QRDvXk/WqoQtAdUn99U5RBoxVJSaU8m1AH7aCR3Ze42gaTfWxIUA6R26fw1NB/OOoCiTMdpMRYeTawa74g4l66IBYm2gjTLwomw5bHKLU9chhfNk6+kdO2K0WYBsV4GbmFZrnPfYC+d6luL2AP2hzRVwwFz7QPRZAS4T17N/twA3NK4wMDt16rJQhJXBL/YcdtB7tsRAcwZuSQdSyVsW7Fgh05CLMuiguzIsdQoQ8peu5rKN4iDRraXkPQtTQ2zvvqFezdE7vgrhQNFceWin6oxBQCbntKKrM30dapbvN1ai/jEEFG/SQrQ4O6VM3m2dsc5FVk1F1a+W9qmXgNwHDc8s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(10067099003)(3023799007)(260925021311599003)(260925021911599003)(260925022911599003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WitRR2NWalJDN3I2c08wejhkQkt5L1lFRXVrUkJFVWo5dFlEdWNaNFg5T005?=
 =?utf-8?B?cUJ3elJuOTFIOTZDVjMyMEVwOHJUMUo3WDFPQ0lucHJxVlV0ZkhhdytDSTRy?=
 =?utf-8?B?c2lRbUlZTk5NRkIrYlljR3IwSU85RlNHMlpPTElhai9lbllOblhJaHlFYXJn?=
 =?utf-8?B?OHVmZ1JyR0ZwclVVRmNXTXZoYnd3a0lnQXhJSWdiMmxZOVlFT1lMYllIV3ZD?=
 =?utf-8?B?Sm9DMDJCQ1pieVhNcW1QRVlkRjRmN3BiZ3BtcERaWVNQUFRrZEZqK1Mxb1Mx?=
 =?utf-8?B?OUVZTk53TWZmTzVLSzhCWTQ5NFJBNUwxczFxTlpVRExvQ2pnWXRSVGVjYmlT?=
 =?utf-8?B?Z3hYWWQ3bDVVV0dJeElrTEtuMTJPd2FXNExkWUVobkJoQ1FyR0NKQ0lHY1Fa?=
 =?utf-8?B?K25lblhpQ1pCVjJ0ZU9PczVqVXhjNGxzLzBROUdVSzhFakFvQjBObVZTRWJm?=
 =?utf-8?B?eTYwZ3BOWlloaCt0bE4rM0JFaE5uYmQzWVVwdnh5WnBOOEtxSit0d2RjRC9D?=
 =?utf-8?B?ZVRKWlJSNFhEUmR5YlQybElVVkNHRjNBeHpxZTdKdmFUdnJ2cDVWOUZaeCt2?=
 =?utf-8?B?ems5R3ZIZXA1MHhYQmduNkZoTUxGbE1xNWQ0Z0NqL2pLVlRKN1MwUTJObksr?=
 =?utf-8?B?NkRjaEdkOVZKS0JIanV3YTRTcWZCMTFxSm1GNlV0K0NVd1ZzanNvMmJsdVMv?=
 =?utf-8?B?MXJIenhlRjV0dm5hT3pib2FwNU8rbXFXM1hIUy9NYncrU3JLRFJHeE12UzFB?=
 =?utf-8?B?aVlraVlUblZzaWswM1RmZ2ZmRmNDUjByM1laRDFtbWplS3VHMkVZTmRNdGIr?=
 =?utf-8?B?Ri9MQWQ0UHBSUVVjM0ltMUNUei91bFpKYjNEeFV1TmVpRXV1RjJHeHpMQXV3?=
 =?utf-8?B?TFNUOFRSM0VlRWEvV2hpNmFKUHRYaXRLRk9UdFBjMEJTcTRHK00yNWpUOVhQ?=
 =?utf-8?B?Yndyc3plU3FSSGhzeHEwaVp1OENuMWlySlVFL3BLb284YkF0MUE2Y3BkZGQy?=
 =?utf-8?B?R3NvUzVvQ1owQkhuSXQ1a0JzVmh0NjNVWkF3UnJpRGVieEpscFZHMzltZGt0?=
 =?utf-8?B?Wk4xc3d4WVRpM0NJanZMaVZVUmJORHBwQjBPcVl6R2lSTGlpVkI0b2xBaXpo?=
 =?utf-8?B?NG1MNDBJRkxuRnZOVkdSZGVzMDMyRDBTdHNUT1diajZ4NTYxMDhQYy9XM04w?=
 =?utf-8?B?Z2pvdVFybld3TVg4ejFkbi9VMUdIK3puZmc0ZlZ4SG9vRFpmc09EeWpRSS9m?=
 =?utf-8?B?K0o2Q0hGU3N5N2piQmQxaXVSZE9aR0hjTm4yVVpFcFdUT0dGWEttQ2ljTVB6?=
 =?utf-8?B?WFV3VGxBQkdLTm9NdTYyYjBTaUVNUzhBQm54cG1oMWZVMVY2K0UwWXBWOFJx?=
 =?utf-8?B?UW56RWJkcUI2UlNabGhRRWV2TmF0eDhBOGV6Q1h4akVGSW9NUlJuT2Y5Tjhk?=
 =?utf-8?B?OUZuTkVqdnBLbEZKVkI4K2hnN2JMQUJPZ1YxT051Q2ZLRHJEb0IzOWxZeTU0?=
 =?utf-8?B?c2V2ZER0blpvVmEvVWdmdjZtVVJ0b2MybEt6V1BxbWZUUlZVdkRYWEpvNUZB?=
 =?utf-8?B?S3hoL01aRkdPQmRYZGZtbTlqNkZvWkZ2d0t4RFFxNkNLTzE0aEN0aWNGOWNS?=
 =?utf-8?B?L3BHQXMrRGVRSUgvTlB4TlNBYVIzeXpNZTdveHpKbmNBclV6T2o4ck5rOElJ?=
 =?utf-8?B?eUVlNFk4MzhvdUhPQkx6ZnFGOXBtMFZpekMwZ29UZkdNNHV1TFNxZUIxVTdm?=
 =?utf-8?B?LzlOZ21DMmlCd3FtYzJ6SXNTVXBOcGdXOFR0VCtsZnVnaEw4NllzbmJCSmJF?=
 =?utf-8?B?NnM1QWlmTGlra2pLS0w2dEZpN2RHUXNIeS9tcFlUSHEraFB4Z2xkSFhPMWdR?=
 =?utf-8?B?cDMrZEFjYU42d1c0V083WHhQRm5GNW42TXhxN01FVExuTzlkYUQwdmpxMTdJ?=
 =?utf-8?B?TE9oa0U4OXptVlBtclUyN2ZydTVHMXpRQlQyOW5OUDRVbWErM2lSNWkzMU5q?=
 =?utf-8?B?ZzRmNm16RzM0d1ZSSFZjcENLQUlXV2lkU1BqMEJmVFNGMFVtblJFUUE0dys1?=
 =?utf-8?B?dGQzVjhiUFNEdUNYMlptRkJuUzNHK3FrNXRXWlVURlB3eTVjQ1NCaTcwZDAr?=
 =?utf-8?B?eE1mTDYxa1FUTWV5ME9oamg1c1FibllDenBLSHF0aUxGWCtPZFBqR2RjaXZy?=
 =?utf-8?B?d0VEQlNZM2dZWVUyaWRpSmUwU0NyMytOVm03dzBjYk5oT0hjK0xCZUR1Vmw0?=
 =?utf-8?B?cSs1eTNaTlRwNzhLalJVczU4aFNkSWtaOGg2dnNNWTRZMjRZbDU4WWdOdmho?=
 =?utf-8?B?Tjg0Y3hjM3E2aXZaZUJkd3p5K2xtRHkzU3RUMDVPS2RRSGhMYU5KVHR4L0Iy?=
 =?utf-8?Q?DlmqCDNj3wqi6WRA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a04e16c8-ebdf-4c97-f21f-08df238f4eb3
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:50:51.9096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b714DjIwesOU3jYxZmHKhX7zTOcSZ3UaF3cnZzEU1t7HtqBCzAdDC60bXHfYMxD0lwWUclQ/W9txPErphJ/hbyBTVZ+cTtQ9EDq3YNJ7IH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR02MB9388
X-OriginatorOrg: processmission.com
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
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

The e500mc, e5500 and e6500 ignore W in mtfsfi and W/L in mtfsf.
Check that these fields do not select extended FPSCR fields, cause
illegal instruction exceptions or override the ordinary field mask.

Test both W values, all W/L combinations and the Rc variants. Seed ZE
and RN before each instruction so partial and zero field masks verify
that unaffected fields remain intact and selected fields receive the
expected values. Ignore the undefined upper word returned by mffs.

Register the test for e500mc in 32-bit mode and for e5500/e6500 in
64-bit mode, using the shared Book E startup and result handling.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

 tests/tcg/ppc/system/fpscr.S     | 75 ++++++++++++++++++++++++++++++++
 tests/tcg/ppc/system/meson.build |  2 +-
 2 files changed, 76 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/ppc/system/fpscr.S

diff --git a/tests/tcg/ppc/system/fpscr.S b/tests/tcg/ppc/system/fpscr.S
new file mode 100644
index 0000000000..41e90b1076
--- /dev/null
+++ b/tests/tcg/ppc/system/fpscr.S
@@ -0,0 +1,75 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2026 Process Mission
+ */
+
+#include "macros.inc"
+
+    .macro seed_fpscr
+    mtfsf 255, f2
+    mtfsfi 6, 1                 /* ZE */
+    mtfsfi 7, 2                 /* RN */
+    .endm
+
+    .macro check_fpscr expected
+    mffs f1
+    stfd f1, 8(r4)
+    lwz r11, 12(r4)
+    load32 r12, \expected
+    cmpw r11, r12
+    bne fail
+    .endm
+
+    .macro test_mtfsfi field, value, w, record, expected
+    seed_fpscr
+    .if \record
+    mtfsfi. \field, \value, \w
+    .else
+    mtfsfi \field, \value, \w
+    .endif
+    check_fpscr \expected
+    .endm
+
+    .macro test_mtfsf mask, w, l, record, expected
+    seed_fpscr
+    .if \record
+    mtfsf. \mask, f0, \l, \w
+    .else
+    mtfsf \mask, f0, \l, \w
+    .endif
+    check_fpscr \expected
+    .endm
+
+    .text
+    .globl test_main
+test_main:
+    load_addr r4, scratch
+    lfd f0, 0(r4)               /* Source: upper word 3, lower word 1 */
+    lfd f2, 16(r4)              /* Zero for a reproducible initial FPSCR */
+
+    .irp w, 0, 1
+    .irp record, 0, 1
+    test_mtfsfi 6, 4, \w, \record, 0x42
+    test_mtfsfi 7, 1, \w, \record, 0x11
+    .endr
+    .endr
+
+    .irp w, 0, 1
+    .irp l, 0, 1
+    .irp record, 0, 1
+    /* L must not override the ordinary field mask, and W is ignored */
+    test_mtfsf 0, \w, \l, \record, 0x12
+    test_mtfsf 1, \w, \l, \record, 0x11
+    test_mtfsf 2, \w, \l, \record, 0x02
+    test_mtfsf 255, \w, \l, \record, 0x01
+    .endr
+    .endr
+    .endr
+    b pass
+
+    .data
+    .balign 8
+scratch:
+    .long 3, 1
+    .space 16
diff --git a/tests/tcg/ppc/system/meson.build b/tests/tcg/ppc/system/meson.build
index 1598348656..ad4c257c9a 100644
--- a/tests/tcg/ppc/system/meson.build
+++ b/tests/tcg/ppc/system/meson.build
@@ -11,7 +11,7 @@ ppc_system_cflags = ['-nostdlib', '-ffreestanding', '-mcpu=power6',
                      '-Wl,-T', ppc_system_link_script, ppc_system_boot]
 ppc_system_qemu_args = ['-M', 'ppce500', '-accel', 'tcg', '-display', 'none',
                         '-serial', 'stdio', '-monitor', 'none', '-nic', 'none']
-ppc_system_sources = ['unsupported.S']
+ppc_system_sources = ['unsupported.S', 'fpscr.S']
 
 tests = []
 foreach src: ppc_system_sources
-- 
2.53.0


