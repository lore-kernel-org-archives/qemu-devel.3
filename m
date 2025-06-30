Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FB3C8302D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 11:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWCfL-0004Rh-OX; Mon, 30 Jun 2025 07:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tan@siewert.io>)
 id 1uWCfF-0004Qi-9D; Mon, 30 Jun 2025 07:27:09 -0400
Received: from
 mail-germanywestcentralazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c20c::1] helo=FR6P281CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tan@siewert.io>)
 id 1uWCf9-0004Cx-HW; Mon, 30 Jun 2025 07:27:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpcyHPZw189hMXh9dBlOqDZazacMlPL3FUkPaXNAV428tGaLB00zGZ8ChWAo7HoHhnd6Vj70YA5V+tRh/Gi2sT5FSwC2PGF/xiTh0RU/amlXEnpthm0VUJriypbEq36FUjYayhavoPhEHxeFgyo1TxA93r82XuUwIGS0cw5LQaB/4hm+11g6wv08qluJdfP1wMzolSjxGUmoquCFlukOk7pxlqSEsX7L3ud3hzDbeujBUSw+LvGhtcBLPbg6/0UYtBlpMRFV+/Rd2b2I/lY3BgU8FNv/5yk4pFQf+5Kc00rpsztCy3XdzViX3NMIWVOXX40a0RMKT1wYc0wJRxe3bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjUzi9zbBEvT9IrqXSxk4POnifTF0vo/dnGQNhN2wss=;
 b=gO+ZE4xhuNXC1gsk4YMXwwluV/JeP0AB9yQl3SGKR/ObL0B/maWKc1YckTkzLJcet0E4hWMik+DRdqQEqhsyP6SVaFJEPUCUfSlnKX7e2D4FBJHL5R5tVUn6X+84enmcdocanW/T+UWbAAgzPjCOm1MwouUSWwLMhOu48iM32jmgHsbl4Xp6TqLydVkpN7IgOzOEHcXRHeLv7e5+3F1XfUfqd2NGDufgGHRepzuFpdhitMYTk2Hq8dMQeZezxmqw0tqNRWYiZMgFJs1h8kiJOdoSsSB95XPTsLP2ZS74go9SPvDITwbWiEXfpvFZ8Nb9GHGFTVlznQcoHDHtnom0Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siewert.io; dmarc=pass action=none header.from=siewert.io;
 dkim=pass header.d=siewert.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siewert.io;
Received: from BE1PPF7DB70B163.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b18::65f)
 by FR5P281MB3944.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:10a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Mon, 30 Jun
 2025 11:26:57 +0000
Received: from BE1PPF7DB70B163.DEUP281.PROD.OUTLOOK.COM
 ([fe80::5c4:893c:2523:a442]) by BE1PPF7DB70B163.DEUP281.PROD.OUTLOOK.COM
 ([fe80::5c4:893c:2523:a442%3]) with mapi id 15.20.8880.021; Mon, 30 Jun 2025
 11:26:56 +0000
From: Tan Siewert <tan@siewert.io>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Tan Siewert <tan@siewert.io>
Subject: [PATCH v2] tests/qtest: Add test for ASPEED SCU
Date: Mon, 30 Jun 2025 13:26:46 +0200
Message-ID: <20250630112646.74944-1-tan@siewert.io>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0404.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::6) To BE1PPF7DB70B163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b18::65f)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1PPF7DB70B163:EE_|FR5P281MB3944:EE_
X-MS-Office365-Filtering-Correlation-Id: 96aa5ad3-e1c6-4233-77ac-08ddb7c9057d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|7416014|376014|52116014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KpCGfCMuyBOdiL+0H63PqGR4+hb4rFl3yU22tjZMoP7b3pzkK6GxXPNcA5Lh?=
 =?us-ascii?Q?OBsaruI0szJWei1BgMXv4hkF0UzWq0qXCqGTHe6aP8eYunDkVy7USCp3gHY4?=
 =?us-ascii?Q?LFQlrxtyHvxrGQ/aWS/61qC4rZQNEZ73h8BIIABRsGR3DnJkA28tJxnQiZqH?=
 =?us-ascii?Q?+a4VM7gJ0CcLOMl/yKCzcPLazhXr3Vjzg4Jcd2qccXRY+VWTGiP74CfnEoxJ?=
 =?us-ascii?Q?zZw/YOt0jMh0mnSNg9FeqKdN+MBZTNo0ahdCgEzopIlLVb1jKX3X92dS2QDL?=
 =?us-ascii?Q?LiMaeemGcxFYx2aU+qLmlpXnMQ7Va+c9gcL+Teof1+M7Dt8i8MVlNrFawvUy?=
 =?us-ascii?Q?TcF3rGENKT3+zB3LsPsyqLvjU+o56gtWscwKaSWpVQPrNdiTPGM3Fd0ZE2+T?=
 =?us-ascii?Q?19IpVfpt+vfo+OCgCI0VyNmk54uYUg+CvjpU25jPrR3n3HGof22oTtF+NIgK?=
 =?us-ascii?Q?AGJuLgNTB5IinbrW19RvHcNSFpb442axGK0llpc4wnGqSNArsXZoIf/yn6Bg?=
 =?us-ascii?Q?M+0+wonLQUdmAhLtsFhJWGKv1tthm/wexZ9fjjfavviPJ3h3HrsGHb4MvDWM?=
 =?us-ascii?Q?sREOoR+f82PHuM0V193ZyHdsuFFug1TrVQikQQoahUGlOKPuASwdfUlq0nVk?=
 =?us-ascii?Q?sV+FxojC44xqpUUeR66xjZkRtM7/xgjURRwNSbZbQrQYqQO0ll7xK+ghOSfL?=
 =?us-ascii?Q?hxB1awsuFIkVUxqniLj4OZvqEzPPBKYFvaEZkk+1YMHGfDkBCe7LwPsj2lui?=
 =?us-ascii?Q?TMzzjT9EnZUwkX3LFahHVp3lHa4pWoNZjLd9mr7u+J2MU6sq5kSro6f+Cr9v?=
 =?us-ascii?Q?fNW06ub0WNWrVG21yEJ956JWtSOqwrcLazgaJVStygahABSGAIPearc2SDvP?=
 =?us-ascii?Q?RX1pZqXjUOlBaoC1M2vzKcbposOTWTVQCxoYvoyd5pdpZc2HPL/TTRP3zvs6?=
 =?us-ascii?Q?C9T0l1nuNkJPQz+OScipMMmaluqX5ihU0OfalGF8sJkFDEaHr6mUzfMweiBM?=
 =?us-ascii?Q?xiS0CRFrVtAWpRgN9pQlCagOkv+4v78AS2/xsVBN037jUq44CJuYcDFs+SOM?=
 =?us-ascii?Q?29OZ+s2hUmPvZ4cLLFcWOVqdEzUeuRvd90gkKXgzdz2kk+WfLh3C6tMVbEyI?=
 =?us-ascii?Q?dDy7QIrQ5uLq/QEHCvq8ZvRI1G9tbJ3TWg3DW9yn3V6vVKRVDd3iuF7IRsjy?=
 =?us-ascii?Q?ULQ/UavBJB4GCtO9K+XvGZVIMkNI632xWWjDxV0D+uR6g8oBwAQU6IadQO90?=
 =?us-ascii?Q?h4fFL1NFp15wz46cPbwgaP20cyv4Y85e8K7pU0z3CUqTpNwCSyFaOqaoLfQA?=
 =?us-ascii?Q?TcilPqDew+7M5xQ4QNie8NzrJKg6hLj4k6/kK7iQBCJ9Xh/etTFXUtEQ1le+?=
 =?us-ascii?Q?lzja48BVP7lmktBgSLBotIhPZs+NO/yD/XlBtlokTcfPJzzLKsMYbQKwK8Z1?=
 =?us-ascii?Q?JeHdUH6+pXtUDHccx+SEh46dSFki4pQfo1Dm2OmIvdhVhvgP51h/Wg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BE1PPF7DB70B163.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(52116014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qyEo8uGt/DmSm7k18dzyn1i05fv9DXkianwDXJgLyMa4AGuI1eEa/phstkTJ?=
 =?us-ascii?Q?MuBmf0d8PdlAUqhEm3fAnJq2WAr305dN46rnLnIcO1T2pYlFM54qBdH3gReJ?=
 =?us-ascii?Q?WC44oemBYryw5oAZq4zl1iOGRVfZ9XKam45Zgg1WeANS6S/u/zj1Y3TcIBrb?=
 =?us-ascii?Q?SPtsnnpp3g9bvCbnMECHdfdetJiqXGXlmiSsqeKfpK26PAt1I4ycBcweyfPd?=
 =?us-ascii?Q?2ZhoveQHqFcFyId+ElXSNXrabt5utVNAp9rkDwMEBw48U22OSBMyH0U8CHFk?=
 =?us-ascii?Q?20ua7+A1fqb5amuw/TRVznFOByNjip9GVrEqZ9L1G6SCicZItlmdEAzpbL54?=
 =?us-ascii?Q?TtxBsRFRan/tPawAwOjImFe4IDRHxz721JPIO+zL0zsz9FauyEcwV8CGRQJW?=
 =?us-ascii?Q?/qh1olEB3NMdl2QdLp5cDgwO2q1KPVumrZncVQlHqK4yJjWanYD/WNdrf2/d?=
 =?us-ascii?Q?Iz4Dnz5HHVm0UAwDLslZATYVVEpH7X+W16+1h5XmEmy+nWF3N2K9sa93eKQS?=
 =?us-ascii?Q?b7nPio37eIu3V/7C7Hb6gQk14GFH2HUE/PYf+aaBL7f4onzsXkattFZq+6wm?=
 =?us-ascii?Q?nf6Hvz4T+CnZ+ALRml5amKZ0wMtJ+0hnEPXHNFUb/0da4kuB2oa5/Kgq7F3p?=
 =?us-ascii?Q?MNLQP+VQnDsdMQ8h+5v1f1KwRlsLNwia1OnN9NdZIkEzoocT53azunuUVKrC?=
 =?us-ascii?Q?DFDBImE5YQfrXx83vmYKWqsVrD0NzAqW/FjyMNmboapeuv5/ZxILvjFMgnr3?=
 =?us-ascii?Q?IEaluje/R/VDtz00WV62bDfoS5j8Qst951/ndOi1Hn16CkBDdBX0DiQfrt+p?=
 =?us-ascii?Q?iUZmi35dWHRE/4K9tHvnYCqgRTHBigLi4zWG1YujEX1YijIKCMHqwXZ/Gzae?=
 =?us-ascii?Q?EtSy7m/MX2S6X51Q7YeGlF4mIS3WjGFYwoMvkx+uPnqt0y+jOtL2A9lcVLx5?=
 =?us-ascii?Q?xOJBUusQSUBelhlnv8HJe3opPDyPqSJ3c3FOGUTzvlChcFrENfM55kV5UUCl?=
 =?us-ascii?Q?bvzXZ9fPu9Y5uRBTi+IWWh5tTdaox6sFOt+zIOPaSP3gQh2lYUY737Nz2ktG?=
 =?us-ascii?Q?SeLYPODoyxHj+lwuekNxLdOihdUrmhxN9mW1JzAXXOadPIpYwgIYLaOteFgM?=
 =?us-ascii?Q?VYHc1ZtmiWhxhigTvXOBx2/UXOtXbcDDBztHoU3hufobCwOHANRStc6Xc0vN?=
 =?us-ascii?Q?uplcfFub5+E0ZUCCw+CDcl4rTsLcalum9qyPRtfOOObmV5sgMV5cpaaDgpU7?=
 =?us-ascii?Q?FhLZeiWMpYxCsbIOGBy1SgztNLq+HlIWMPLC3g/HoJyuM2lnBkSBzRZ7PRUG?=
 =?us-ascii?Q?R0QjsEmKvS4N06f5ZOISZFZ/jCUuuTZBGM/SxpZW+WWmIDD1RAZ6yQWUG562?=
 =?us-ascii?Q?9vRQhkszgNSa/dSDW8cDIuArpr2/LkiZss6s7ZnkoUfM1Ov9SP82H3jQEXFh?=
 =?us-ascii?Q?gs+AH1U71fqK3joyOyGkU4+7ulDENnjslXqfZtT4kiWQEGy6wQSfFPVcMgbR?=
 =?us-ascii?Q?2ydBOkYAHFvtbe2t5rZIi515OlbUh+32ya/JsF+SjIw3qii6QSgMwGlZnX10?=
 =?us-ascii?Q?vmZ8Bu43os1OZAB3mDpKXqvYPJIWpaCysNlZyFWi/ETJmfwlK4h1rN1JpJ/K?=
 =?us-ascii?Q?fmXd+T6/+mR6zxXk1Ywg/AQ=3D?=
X-OriginatorOrg: siewert.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 96aa5ad3-e1c6-4233-77ac-08ddb7c9057d
X-MS-Exchange-CrossTenant-AuthSource: BE1PPF7DB70B163.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 11:26:56.7379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e8b4abbe-444b-4835-b8fd-87ac97451a7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEgDzXiwF2xp8DmcCUHXy1KWRzAcYrET6O+i+hfxTr0p1KRV3ofNLt/il5g+1lOx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR5P281MB3944
Received-SPF: pass client-ip=2a01:111:f403:c20c::1;
 envelope-from=tan@siewert.io;
 helo=FR6P281CU001.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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

This adds basic tests for the ASPEED System Control Unit (SCU) and its
protection mechanism on the AST2500 and AST2600 platforms.

The tests verify:
  - That SCU protection registers can be unlocked and locked again
  - That modifying the primary protection register on AST2600 also
    affects the secondary one
  - That writes to protected SCU registers are blocked unless
    protection registers are unlocked explicitly

These tests ensure proper emulation of hardware locking behaviour
and help catch regressions in SCU access logic.

Signed-off-by: Tan Siewert <tan@siewert.io>
---
V2:
  - Merge unnecessary aspeed-scu-utils into aspeed_scu-test
    file [Cedric]

 tests/qtest/aspeed_scu-test.c | 231 ++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build       |   3 +-
 2 files changed, 233 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/aspeed_scu-test.c

diff --git a/tests/qtest/aspeed_scu-test.c b/tests/qtest/aspeed_scu-test.c
new file mode 100644
index 0000000000..ca09f9171f
--- /dev/null
+++ b/tests/qtest/aspeed_scu-test.c
@@ -0,0 +1,231 @@
+/*
+ * QTest testcase for the ASPEED AST2500 and AST2600 SCU.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2025 Tan Siewert
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+
+/*
+ * SCU base, as well as protection key are
+ * the same on AST2500 and 2600.
+ */
+#define AST_SCU_BASE                    0x1E6E2000
+#define AST_SCU_PROT_LOCK_STATE         0x0
+#define AST_SCU_PROT_LOCK_VALUE         0x2
+#define AST_SCU_PROT_UNLOCK_STATE       0x1
+#define AST_SCU_PROT_UNLOCK_VALUE       0x1688A8A8
+
+#define AST2500_MACHINE                 "-machine ast2500-evb"
+#define AST2500_SCU_PROT_REG            0x00
+#define AST2500_SCU_MISC_2_CONTROL_REG  0x4C
+
+#define AST2600_MACHINE                 "-machine ast2600-evb"
+/* AST2600 has two protection registers */
+#define AST2600_SCU_PROT_REG            0x000
+#define AST2600_SCU_PROT_REG2           0x010
+#define AST2600_SCU_MISC_2_CONTROL_REG  0x0C4
+
+#define TEST_LOCK_ARBITRARY_VALUE       0xABCDEFAB
+
+/**
+ * Assert that a given register matches an expected value.
+ *
+ * Reads the register and checks if its value equals the expected value.
+ *
+ * @param *s - QTest machine state
+ * @param reg - Address of the register to be checked
+ * @param expected - Expected register value
+ */
+static inline void assert_register_eq(QTestState *s,
+                                      uint32_t reg,
+                                      uint32_t expected)
+{
+    uint32_t value = qtest_readl(s, reg);
+    g_assert_cmphex(value, ==, expected);
+}
+
+/**
+ * Assert that a given register does not match a specific value.
+ *
+ * Reads the register and checks that its value is not equal to the
+ * provided value.
+ *
+ * @param *s - QTest machine state
+ * @param reg - Address of the register to be checked
+ * @param not_expected - Value the register must not contain
+ */
+static inline void assert_register_neq(QTestState *s,
+                                       uint32_t reg,
+                                       uint32_t not_expected)
+{
+    uint32_t value = qtest_readl(s, reg);
+    g_assert_cmphex(value, !=, not_expected);
+}
+
+/**
+ * Test whether the SCU can be locked and unlocked correctly.
+ *
+ * When testing multiple registers, this function assumes that writing
+ * to the first register also affects the others. However, writing to
+ * any other register only affects itself.
+ *
+ * @param *machine - input machine configuration, passed directly
+ *                   to QTest
+ * @param regs[] - List of registers to be checked
+ * @param regc - amount of arguments for registers to be checked
+ */
+static void test_protection_register(const char *machine,
+                                     const uint32_t regs[],
+                                     const int regc)
+{
+    QTestState *s = qtest_init(machine);
+
+    for (int i = 0; i < regc; i++) {
+        uint32_t reg = regs[i];
+
+        qtest_writel(s, reg, AST_SCU_PROT_UNLOCK_VALUE);
+        assert_register_eq(s, reg, AST_SCU_PROT_UNLOCK_STATE);
+
+        /**
+         * Check that other registers are unlocked too, if more
+         * than one is available.
+         */
+        if (regc > 1 && i == 0) {
+            /* Initialise at 1 instead of 0 to skip first */
+            for (int j = 1; j < regc; j++) {
+                uint32_t add_reg = regs[j];
+                assert_register_eq(s, add_reg, AST_SCU_PROT_UNLOCK_STATE);
+            }
+        }
+
+        /* Lock the register again */
+        qtest_writel(s, reg, AST_SCU_PROT_LOCK_VALUE);
+        assert_register_eq(s, reg, AST_SCU_PROT_LOCK_STATE);
+
+        /* And the same for locked state */
+        if (regc > 1 && i == 0) {
+            /* Initialise at 1 instead of 0 to skip first */
+            for (int j = 1; j < regc; j++) {
+                uint32_t add_reg = regs[j];
+                assert_register_eq(s, add_reg, AST_SCU_PROT_LOCK_STATE);
+            }
+        }
+    }
+
+    qtest_quit(s);
+}
+
+static void test_2500_protection_register(void)
+{
+    uint32_t regs[] = { AST_SCU_BASE + AST2500_SCU_PROT_REG };
+
+    test_protection_register(AST2500_MACHINE,
+                             regs,
+                             ARRAY_SIZE(regs));
+}
+
+static void test_2600_protection_register(void)
+{
+    /**
+     * The AST2600 has two protection registers, both
+     * being required to be unlocked to do any operation.
+     *
+     * Modifying SCU000 also modifies SCU010, but modifying
+     * SCU010 only will keep SCU000 untouched.
+     */
+    uint32_t regs[] = { AST_SCU_BASE + AST2600_SCU_PROT_REG,
+                        AST_SCU_BASE + AST2600_SCU_PROT_REG2 };
+
+    test_protection_register(AST2600_MACHINE,
+                             regs,
+                             ARRAY_SIZE(regs));
+}
+
+/**
+ * Test if SCU register writes are correctly allowed or blocked
+ * depending on the protection register state.
+ *
+ * The test first locks the protection register and verifies that
+ * writes to the target SCU register are rejected. It then unlocks
+ * the protection register and confirms that the written value is
+ * retained when unlocked.
+ *
+ * @param *machine - input machine configuration, passed directly
+ *                   to QTest
+ * @param protection_register - first SCU protection key register
+ *                              (only one for keeping it simple)
+ * @param test_register - Register to be used for writing arbitrary
+ *                        values
+ */
+static void test_write_permission_lock_state(const char *machine,
+                                             const uint32_t protection_register,
+                                             const uint32_t test_register)
+{
+    QTestState *s = qtest_init(machine);
+
+    /* Arbitrary value to lock provided SCU protection register */
+    qtest_writel(s, protection_register, AST_SCU_PROT_LOCK_VALUE);
+
+    /* Ensure that the SCU is really locked */
+    assert_register_eq(s, protection_register, AST_SCU_PROT_LOCK_STATE);
+
+    /* Write a known arbitrary value to test that the write is blocked */
+    qtest_writel(s, test_register, TEST_LOCK_ARBITRARY_VALUE);
+
+    /* We do not want to have the written value to be saved */
+    assert_register_neq(s, test_register, TEST_LOCK_ARBITRARY_VALUE);
+
+    /**
+     * Unlock the SCU and verify that it can be written to.
+     * Assumes that the first SCU protection register is sufficient to
+     * unlock all protection registers, if multiple are present.
+     */
+    qtest_writel(s, protection_register, AST_SCU_PROT_UNLOCK_VALUE);
+    assert_register_eq(s, protection_register, AST_SCU_PROT_UNLOCK_STATE);
+
+    /* Write a known arbitrary value to test that the write works */
+    qtest_writel(s, test_register, TEST_LOCK_ARBITRARY_VALUE);
+
+    /* Ensure that the written value is retained */
+    assert_register_eq(s, test_register, TEST_LOCK_ARBITRARY_VALUE);
+
+    qtest_quit(s);
+}
+
+static void test_2500_write_permission_lock_state(void)
+{
+    test_write_permission_lock_state(
+            AST2500_MACHINE,
+            AST_SCU_BASE + AST2500_SCU_PROT_REG,
+            AST_SCU_BASE + AST2500_SCU_MISC_2_CONTROL_REG
+    );
+}
+
+static void test_2600_write_permission_lock_state(void)
+{
+    test_write_permission_lock_state(
+            AST2600_MACHINE,
+            AST_SCU_BASE + AST2600_SCU_PROT_REG,
+            AST_SCU_BASE + AST2600_SCU_MISC_2_CONTROL_REG
+    );
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/ast2500/scu/protection_register",
+                   test_2500_protection_register);
+    qtest_add_func("/ast2600/scu/protection_register",
+                   test_2600_protection_register);
+
+    qtest_add_func("/ast2500/scu/write_permission_lock_state",
+                   test_2500_write_permission_lock_state);
+    qtest_add_func("/ast2600/scu/write_permission_lock_state",
+                   test_2600_write_permission_lock_state);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 8ad849054f..8c5fcc4fc1 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -215,7 +215,8 @@ qtests_npcm8xx = \
 qtests_aspeed = \
   ['aspeed_gpio-test',
    'aspeed_hace-test',
-   'aspeed_smc-test']
+   'aspeed_smc-test',
+   'aspeed_scu-test']
 qtests_aspeed64 = \
   ['ast2700-gpio-test',
    'ast2700-hace-test',
-- 
2.49.0


