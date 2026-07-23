Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16936C531F7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvCy-00046o-8Z; Thu, 23 Jul 2026 11:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvCx-00046C-1p; Thu, 23 Jul 2026 11:19:35 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvCv-0007zZ-2T; Thu, 23 Jul 2026 11:19:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZ0pu0znMycjHSYcmopJs0rSS6VRqtaao5TqRwPxbM8GGLbj00UxEb4tuWaRj4vU75jCzERHUDL2/EPVPuzU6GtOg1lRmTpdpt3p60qe1hiHAzseqM/Nv+XtxqWyQpUujXgnsSoE0RoqdMbhBcR+l6/kGDY9lFJ8TXIB9x5NeoYXzMt7VM3Nbdh2cQrSaBeGktVjBECPEPakH4WHAx03RbkPFXr2geijmJrkzgA32yBo2FaXydv1yqntV4z8nVp4SOJJ4v8V8DvRxhrnIqn8Th3o+gU9fSfR9q2I/6D+kjbUvY1DUxSi1yFzYtE5ZB+ZTIounQlzj7bbbOr5wbmvig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7Zrfbauvrd6tYWg71Al5H5FDIQRSZ35W16uzRKeA2Y=;
 b=Bx0ntE1KUHN+qs/bgdk5mR0OHOxTKs5LvBD/kZFCNPtrMvsWxJmgoB7dQ1yqfxbe+hYUywrxykYUZ8Yzh/na4pLL/yW7YK2rdFnfOQPGEfRWgWGcSU4EiprYwsfM5lxRqhqXC+kvnVQdrJLAzZlCS/Bpm1U7rvnOxbaPsrIWsMyNL8YbeYL8cyA3YiyI27FA9c1UalqNYQPYEEO2tSEvLF9ebqhtBDJ7eL/LmDEK3K6tpOpSXudhIaEzsun906z+ZqDAy6tijQiOUdj5l5HmpeIiVyU03xlwWecGwwzJxYgPDjSZqbQdaWD6r90/Izhf41aEaTJ0l10e0/ZZKtsc5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7Zrfbauvrd6tYWg71Al5H5FDIQRSZ35W16uzRKeA2Y=;
 b=NX5vVv1JNDWUw+aLtcwwlRkzz11W7Rvb5VHLynIj24FLXHhaCuE7fV5ZKh+/z+/wiMmuAQL9zO7xWrJcHYgXOBpQagsnvy/45dDkW/k0qkwBhW5eHyF1fpDiszjw0AXMOCSYCJ3d5SgXykNxCVQIdvGRED9mkGlsgb/LXj3I9bQ5LJhCF88CucbvSRS9ySgV9OKXs8xKsGEl6Dkbv7h0gdub7KzqpajTN20qbl2MygU1/4SdK2chX+/cNmjRJda5Okxmp/xzMv1h07sh/cGq1o2jehVkBCZVJBXG4Fs68LGbCbtOwOwwMuTUQbEwfM9bVsPi+FeXZ6hhf0ClIahsWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KL1PR02MB6215.apcprd02.prod.outlook.com (2603:1096:820:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 15:19:22 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 15:19:22 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH 06/26] tests/qtest: Add PolarFire SoC L2CC coverage
Date: Thu, 23 Jul 2026 23:18:33 +0800
Message-Id: <20260723151853.2143177-7-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723151853.2143177-1-bin.meng@processmission.com>
References: <20260723151853.2143177-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU0P306CA0037.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::8) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|KL1PR02MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: 47165039-efc4-4398-4960-08dee8cdc60a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|23010399003|1800799024|376014|366016|56012099006|10067099003|18002099003|22082099003|5023799004;
X-Microsoft-Antispam-Message-Info: xg2AvA6q4rGPw3/ZeYdvpvfDjggjc0Bm2ypZi76zOHN/f7l40HEFMB4/85Rubhd2b3jRYj+IUyy27ncSRjvLuJoQsL+HCof1VKEeVfwOpFS93MSB+cQKSVmpvjcixMesKVgTaTWSCtNyxPafKr8zg7YuOMg1FlW6BS9If40Vc88fcVjpFLjATcmE6LK2osMqngWF6Sj0tpTT/NELHlt8Cb5GLnzPqkLg0Jc1qPriWgCjW/+hN5Womf4Y4SIVOEkFWHBbC9HfmFsI1SFenEGohXCeUoz/J4WqdEkk0k9cbN4uOFMIjGvRmqHcC/8Fuyk67vHhdf6oKgsXguVsHPoUbeDv3IKOFnYWmGhrdyrMQ6lmptCWWjbH58xK/uSjz0wtuFM5UiuMfUZ837Pfws8AdQMsyeDob27lI1Hm/PB8syu3QdrE+XjyVSU0KtSA4ysmhy2ThhFTzcsXAHGl1NfMYSeZ1HubkbUquxN06XROPt8Jg9xEwjqz0KjbVkT7Gz1Okxy1k8L5ipSVjQMtQvWPYUzQkZoG5fpJlAU5aUQySogIRIiVotSfRIg87FuXWuoaNLtxyZQG1gkR0hEtTvHO2XWn0tPK8tcO6PF+Eo3maREN/6zmURO2gLvWghg1EiC4QCAMPN2TOu/hkbeXVfw0mRLSTtNnip5++tAFUWII0uo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(23010399003)(1800799024)(376014)(366016)(56012099006)(10067099003)(18002099003)(22082099003)(5023799004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vjmQF+zL48SGOMmoKZYzOS+AQksfwc1i3wTbQIQx9O06JN0gwpiREBjhoNrl?=
 =?us-ascii?Q?EIFov+ffUfzP5BVI4couk4FQJJW9GaRps0M2r+K4eHt+K31jDeLv5XzKiwoW?=
 =?us-ascii?Q?JSLQ6XcVbrZZoa/uYiGcw3d+GbtYHy+RaAQMUVPGBhxIpjuzYcavoxuwjcnC?=
 =?us-ascii?Q?dnG5RwSY80ISmu1CpOWbNPjc1Gv7mweGIzHyk1qNh/xXfiJ+PJLlYtseYkiB?=
 =?us-ascii?Q?Ruw2WcOaewPGz2MRLeceLdeumB4DuX7khobRFOE6N48xxCeKTvLaM2y4bpmA?=
 =?us-ascii?Q?3Jni1G/jFZgJJAK1ymqFZ5uV6GMZ999U8a59HBRLIQvZmA2IhDloJjTpUBJ+?=
 =?us-ascii?Q?U1yaRO5F3RZdBPzQ7TZtt2SUI0gX8qzrV3DQRwX1A6ujoO/cCar5DP/gEx+4?=
 =?us-ascii?Q?1hEK1rdqOX7y0DXSlyYnMCuu2UAcgR/ADQ/NN1ZR4DQmYU0YhyKGBQCCIIhr?=
 =?us-ascii?Q?CfQ27u0O9k9Tc836z4JtoxYg3sWowBfwzVnWKw3x35uAj3xxQHEjUDajCDVg?=
 =?us-ascii?Q?MAQrB82+lFFirMhQ6j4Rm8YvW8f7MxFKCq5TyeT698bvTstiI70J5Ca4TtdD?=
 =?us-ascii?Q?NJAC1b8XLijFPdRlJHBYGB9fsjEMZGLnuoZfUzoEvnMlHvRspZplm6OJRE4t?=
 =?us-ascii?Q?CwX+4H49RHngqthwoi15IzWHH6IuIEXq5Zruo9PhejQGdF1lKdt7D02t0pxF?=
 =?us-ascii?Q?YrFnb22uU1webqaYvuRtA1Jm76i+Td4Pro+5k+gzCaz1SPxDJwV79Mcno11C?=
 =?us-ascii?Q?bX/dGyFtbthMxCcTkJCFuV2lYToS+kq+Eo/GzIi1kZKi8mZi7KxRtHXAryT3?=
 =?us-ascii?Q?Uf3BBTYF9cMzAcupwu/cM5NDwpW/fyuuQCKMzP02oleWnggrn7AKmmrP2NzB?=
 =?us-ascii?Q?LSKqqzrXaPgIagSOY4uE2jbDYC7gxY0Uwk25r+DIcH9QzHzXSk7WqHRi+iTI?=
 =?us-ascii?Q?uDM5KFxwJw5ZQ3Zoy+N0r+vCyUVYEpC67Y2Ngarv5u86nVgZtVA4Oo9xud5Z?=
 =?us-ascii?Q?poPOXaGcJzVBHtlhe9l8g/kJscqXmFrbZ2owQVqMxUAojyEwxuoqZwYrklMz?=
 =?us-ascii?Q?lL68OzZUSJ3n9x8X/2eraZlaeI4FmoiFN4559I8HsaK2Z3hyfBNRvRTKJPQj?=
 =?us-ascii?Q?quJEUZd4zh2+uIjg7nZnT+sMSNCicxgp1/7QOTIn2X14QPXMFMXOoXNumlc3?=
 =?us-ascii?Q?jXZNvPW2007gPqRhviSoobUHWHHg2xlFcus/gBkDihJuK4F9UgDHqJ7o7EC/?=
 =?us-ascii?Q?Os5dC1LDpp2AYd9paV42aGeCFCw4yruFNwOPj48Y66FtCl0WMjmTnkJnaFg2?=
 =?us-ascii?Q?OiiOEKQ/J+lyCDdIW5uNZmrZVijSpSEfZZ3n84y432ib92xuvU/ScF6GmnMk?=
 =?us-ascii?Q?O4j9rJgIY0n7oBApZdDCrGTyR3LV+Vn+H+6MW0twi1tekJXSw9/uJBTutKAb?=
 =?us-ascii?Q?I5OgK4GvvvsgIJ9xzOXFIg4vEtoqrk+l7ngP3M5BuYJ0R1ukDmNMzMuZAsd5?=
 =?us-ascii?Q?xWfkfsOopidPT5t6uRuCsrvYD5+IeUx5ZjHXL6wtUnOv+zMIJv9YzX0WzBxK?=
 =?us-ascii?Q?1C0Twa/r5SOcPeDSZfprLQ31wtnmY0ces4ISzXLndVUweAd18b/JHDt0jCI8?=
 =?us-ascii?Q?Usbna6j63lZ2yci/0dV0jx0nKDKTN4c9cIzkTTtg1dwa8MSos2kjHZJT7kj5?=
 =?us-ascii?Q?UMSzEoUBulYPvMFsu1ixTrUMhuYzUKJf0aHf9zB09dDOkAlQq6bn+U3M1cPa?=
 =?us-ascii?Q?dzUmK1Gz6B/xccT4q1muyZjM3fjiRe0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47165039-efc4-4398-4960-08dee8cdc60a
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:19:22.3697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3MMF/4YrwXLEAjZVfo12/K0xvk/j30jmIJPHuHoY5FlSrBNTHGW6LP+9nBsRZgdwIr5pDZ/X6bMri4NBhvQDfuiy8gb8nW7Dx3rC5beUgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6215
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

Add a dedicated qtest binary for L2CC register and memory-topology
behavior. Use underscores consistently in the test name.

Exercise Config, WayEnable, and every WayMask register, including
reset, monotonic writes, and unimplemented-register logging. Verify
that WayEnable resizes the guest-visible L2-LIM region while L2 Zero
remains fixed at the modeled 2 MiB size.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 MAINTAINERS                        |   1 +
 tests/qtest/mchp_pfsoc_l2cc_test.c | 221 +++++++++++++++++++++++++++++
 tests/qtest/meson.build            |   2 +
 3 files changed, 224 insertions(+)
 create mode 100644 tests/qtest/mchp_pfsoc_l2cc_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c0bb18c47a..e36594d4fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1778,6 +1778,7 @@ F: include/hw/misc/mchp_pfsoc_dmc.h
 F: include/hw/misc/mchp_pfsoc_ioscb.h
 F: include/hw/misc/mchp_pfsoc_l2cc.h
 F: include/hw/misc/mchp_pfsoc_sysreg.h
+F: tests/qtest/mchp_pfsoc_l2cc_test.c
 
 Shakti C class SoC
 L: qemu-riscv@nongnu.org
diff --git a/tests/qtest/mchp_pfsoc_l2cc_test.c b/tests/qtest/mchp_pfsoc_l2cc_test.c
new file mode 100644
index 0000000000..3401ce4300
--- /dev/null
+++ b/tests/qtest/mchp_pfsoc_l2cc_test.c
@@ -0,0 +1,221 @@
+/*
+ * QTest testcase for the Microchip PolarFire SoC L2 cache controller
+ *
+ * Copyright (c) 2026 Process Mission
+ *
+ * Author:
+ *   Bin Meng <bin.meng@processmission.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "libqtest.h"
+
+#define L2CC_BASE                       0x02010000
+#define L2CC_CONFIG                     0x000
+#define L2CC_CONFIG_VALUE               0x06091004
+#define L2CC_WAY_ENABLE                 0x008
+#define L2CC_ECC_INJECT                 0x040
+#define L2CC_FLUSH64                    0x200
+#define L2CC_WAY_MASK_BASE              0x800
+#define L2CC_WAY_MASK_COUNT             15
+#define L2CC_WAY_MASK(n)                (L2CC_WAY_MASK_BASE + 8 * (n))
+#define L2CC_MASTER15                   L2CC_WAY_MASK(L2CC_WAY_MASK_COUNT)
+#define L2CC_WAY_ENABLE_RESET           0
+#define L2CC_WAY_MASK_RESET             UINT64_MAX
+
+#define L2_LIM_BASE                     0x08000000
+#define L2_WAY_SIZE                     (128 * KiB)
+#define L2_LIM_RESET_WAYS               15
+#define L2_ZERO_BASE                    0x0a000000
+#define L2_ZERO_SIZE                    (2 * MiB)
+
+static QTestState *mchp_pfsoc_l2cc_start(const char *firmware)
+{
+    return qtest_initf("-machine microchip-icicle-kit -smp 5 -m 2G "
+                       "-bios \"%s\"", firmware);
+}
+
+static char *mchp_pfsoc_l2cc_create_firmware(void)
+{
+    static const uint8_t firmware[] = {
+        0x13, 0x00, 0x00, 0x00,
+        0x6f, 0x00, 0x00, 0x00,
+    };
+    char *path;
+    int fd;
+    ssize_t written;
+
+    fd = g_file_open_tmp("mchp_pfsoc_l2cc_XXXXXX", &path, NULL);
+    g_assert_cmpint(fd, >=, 0);
+
+    written = write(fd, firmware, sizeof(firmware));
+    g_assert_cmpint(written, ==, sizeof(firmware));
+    close(fd);
+
+    return path;
+}
+
+static uint64_t l2cc_way_mask_test_value(unsigned int master)
+{
+    return UINT64_C(0xfedcba9876543201) + master;
+}
+
+static void test_l2cc_registers(void)
+{
+    g_autofree char *firmware = mchp_pfsoc_l2cc_create_firmware();
+    QTestState *qts = mchp_pfsoc_l2cc_start(firmware);
+    unsigned int i;
+
+    unlink(firmware);
+
+    g_assert_cmphex(qtest_readl(qts, L2CC_BASE + L2CC_CONFIG), ==,
+                    L2CC_CONFIG_VALUE);
+    qtest_writel(qts, L2CC_BASE + L2CC_CONFIG, UINT32_MAX);
+    g_assert_cmphex(qtest_readl(qts, L2CC_BASE + L2CC_CONFIG), ==,
+                    L2CC_CONFIG_VALUE);
+
+    g_assert_cmphex(qtest_readb(qts, L2CC_BASE + L2CC_WAY_ENABLE), ==,
+                    L2CC_WAY_ENABLE_RESET);
+    qtest_writeb(qts, L2CC_BASE + L2CC_WAY_ENABLE, 0xd);
+    g_assert_cmphex(qtest_readb(qts, L2CC_BASE + L2CC_WAY_ENABLE), ==, 0xd);
+    qtest_writeb(qts, L2CC_BASE + L2CC_WAY_ENABLE, 3);
+    g_assert_cmphex(qtest_readb(qts, L2CC_BASE + L2CC_WAY_ENABLE), ==, 0xd);
+    qtest_writeq(qts, L2CC_BASE + L2CC_WAY_ENABLE, 0xf);
+    g_assert_cmphex(qtest_readq(qts, L2CC_BASE + L2CC_WAY_ENABLE), ==, 0xf);
+    qtest_writeb(qts, L2CC_BASE + L2CC_WAY_ENABLE, 0xe);
+    g_assert_cmphex(qtest_readb(qts, L2CC_BASE + L2CC_WAY_ENABLE), ==, 0xf);
+
+    for (i = 0; i < L2CC_WAY_MASK_COUNT; i++) {
+        g_assert_cmphex(qtest_readq(qts, L2CC_BASE + L2CC_WAY_MASK(i)), ==,
+                        L2CC_WAY_MASK_RESET);
+        qtest_writeq(qts, L2CC_BASE + L2CC_WAY_MASK(i),
+                     l2cc_way_mask_test_value(i));
+    }
+    for (i = 0; i < L2CC_WAY_MASK_COUNT; i++) {
+        g_assert_cmphex(qtest_readq(qts, L2CC_BASE + L2CC_WAY_MASK(i)), ==,
+                        l2cc_way_mask_test_value(i));
+    }
+
+    qtest_system_reset(qts);
+    g_assert_cmphex(qtest_readl(qts, L2CC_BASE + L2CC_CONFIG), ==,
+                    L2CC_CONFIG_VALUE);
+    g_assert_cmphex(qtest_readb(qts, L2CC_BASE + L2CC_WAY_ENABLE), ==,
+                    L2CC_WAY_ENABLE_RESET);
+    for (i = 0; i < L2CC_WAY_MASK_COUNT; i++) {
+        g_assert_cmphex(qtest_readq(qts, L2CC_BASE + L2CC_WAY_MASK(i)), ==,
+                        L2CC_WAY_MASK_RESET);
+    }
+
+    qtest_quit(qts);
+}
+
+static void test_l2lim_topology(void)
+{
+    g_autofree char *firmware = mchp_pfsoc_l2cc_create_firmware();
+    uint32_t original[L2_LIM_RESET_WAYS];
+    const uint32_t poison = 0xdeadc0de;
+    const uint64_t zero_last = L2_ZERO_BASE + L2_ZERO_SIZE - 4;
+    QTestState *qts = mchp_pfsoc_l2cc_start(firmware);
+    unsigned int i;
+
+    unlink(firmware);
+
+    /* Check the fixed aperture, not the RAM stand-in's eviction behavior */
+    qtest_writel(qts, zero_last, 0xa55a9669);
+    g_assert_cmphex(qtest_readl(qts, zero_last), ==, 0xa55a9669);
+
+    for (i = 1; i <= L2_LIM_RESET_WAYS; i++) {
+        uint64_t l2lim_size = (L2_LIM_RESET_WAYS - i) * L2_WAY_SIZE;
+        uint64_t hidden = L2_LIM_BASE + l2lim_size;
+        uint32_t tail = 0x96000000 | i;
+
+        original[i - 1] = 0x69000000 | i;
+        qtest_writel(qts, hidden, original[i - 1]);
+        g_assert_cmphex(qtest_readl(qts, hidden), ==, original[i - 1]);
+
+        if (l2lim_size) {
+            qtest_writel(qts, hidden - 4, tail);
+            g_assert_cmphex(qtest_readl(qts, hidden - 4), ==, tail);
+        }
+
+        qtest_writeb(qts, L2CC_BASE + L2CC_WAY_ENABLE, i);
+        g_assert_cmphex(qtest_readb(qts,
+                                   L2CC_BASE + L2CC_WAY_ENABLE), ==, i);
+        if (l2lim_size) {
+            g_assert_cmphex(qtest_readl(qts, hidden - 4), ==, tail);
+        }
+        g_assert_cmphex(qtest_readl(qts, hidden), ==, 0);
+        qtest_writel(qts, hidden, poison);
+        g_assert_cmphex(qtest_readl(qts, hidden), ==, 0);
+        g_assert_cmphex(qtest_readl(qts, zero_last), ==, 0xa55a9669);
+    }
+
+    qtest_writeb(qts, L2CC_BASE + L2CC_WAY_ENABLE, UINT8_MAX);
+    g_assert_cmphex(qtest_readb(qts, L2CC_BASE + L2CC_WAY_ENABLE), ==,
+                    UINT8_MAX);
+    g_assert_cmphex(qtest_readl(qts, L2_LIM_BASE), ==, 0);
+    qtest_writeb(qts, L2CC_BASE + L2CC_WAY_ENABLE, 3);
+    g_assert_cmphex(qtest_readb(qts, L2CC_BASE + L2CC_WAY_ENABLE), ==,
+                    UINT8_MAX);
+    g_assert_cmphex(qtest_readl(qts, L2_LIM_BASE), ==, 0);
+
+    qtest_system_reset(qts);
+    g_assert_cmphex(qtest_readb(qts, L2CC_BASE + L2CC_WAY_ENABLE), ==,
+                    L2CC_WAY_ENABLE_RESET);
+    for (i = 1; i <= L2_LIM_RESET_WAYS; i++) {
+        uint64_t restored = L2_LIM_BASE +
+                            (L2_LIM_RESET_WAYS - i) * L2_WAY_SIZE;
+
+        g_assert_cmphex(qtest_readl(qts, restored), ==, original[i - 1]);
+    }
+
+    qtest_quit(qts);
+}
+
+static void test_l2cc_unimplemented(void)
+{
+    g_autofree char *firmware = mchp_pfsoc_l2cc_create_firmware();
+    g_autofree char *log_path = NULL;
+    g_autofree char *log = NULL;
+    QTestState *qts;
+    int fd;
+
+    fd = g_file_open_tmp("mchp_pfsoc_l2cc_unimp_XXXXXX", &log_path, NULL);
+    g_assert_cmpint(fd, >=, 0);
+    close(fd);
+
+    qts = qtest_initf(
+        "-machine microchip-icicle-kit -smp 5 -m 2G -bios \"%s\" "
+        "-d unimp -D \"%s\"", firmware, log_path);
+    unlink(firmware);
+
+    g_assert_cmphex(qtest_readl(qts, L2CC_BASE + L2CC_ECC_INJECT), ==, 0);
+    qtest_writeq(qts, L2CC_BASE + L2CC_FLUSH64, 0x1234);
+    g_assert_cmphex(qtest_readq(qts, L2CC_BASE + L2CC_MASTER15), ==, 0);
+    qtest_quit(qts);
+
+    g_assert_true(g_file_get_contents(log_path, &log, NULL, NULL));
+    g_assert_nonnull(strstr(log,
+        "unimplemented device read (size 4, offset 0x40)"));
+    g_assert_nonnull(strstr(log,
+        "unimplemented device write (size 8, value 0x1234, offset 0x200)"));
+    g_assert_nonnull(strstr(log,
+        "unimplemented device read (size 8, offset 0x878)"));
+    unlink(log_path);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/mchp_pfsoc_l2cc/registers", test_l2cc_registers);
+    qtest_add_func("/mchp_pfsoc_l2cc/l2lim_topology",
+                   test_l2lim_topology);
+    qtest_add_func("/mchp_pfsoc_l2cc/unimplemented",
+                   test_l2cc_unimplemented);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 35c191bace..02b5780d78 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -295,6 +295,8 @@ qtests_riscv32 = \
 
 qtests_riscv64 = ['riscv-csr-test'] + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_MICROCHIP_PFSOC') ?
+   ['mchp_pfsoc_l2cc_test'] : []) + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
-- 
2.34.1


