Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A93FC624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WJY-0004aq-Dm; Fri, 04 Sep 2026 11:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJX-0004Tj-0l; Fri, 04 Sep 2026 11:58:51 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJU-0004Sx-No; Fri, 04 Sep 2026 11:58:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OaRzWhxhoWOryZdLz61ncj0ZqmZz2du+FkOOai4byR5nOEOBJA/wB6ElyKwL1fg5RPA93A6GOfHU6ZoXkPRAYzP6Eao6BWvJ3bZceH8dt4HdTxyVqbE90Tyi5kKxcc0jOGuTcJL2ZNpW9tktj0KCLkS4eStKHNVZHgp9m5mVX99d1hq5v8pWUu9N8YKVyOMYf4EOmHEbmDbrJdEG/5P8ugH13m/cj0URR6m6Ca1dwJYZV54qxYzjqTyQJ+YGx5iLFzVhEpMDjXmgWZSSG+wanXzHclEA+0fILQFUAtvmV0uihtw6FoovMQi/W+J5OCTqESwIAs347c33YKcx+wpHWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZ6PkmE1xPaCacyIMLdHc80AFnKiP2a+SpnsCK7Nf2Y=;
 b=KcOuqMdZD2Ue7FyLDbj4/OH7TWwWtcvH3JeDIF8yXHa26iqQxEvp3MMB6GRgxwO1G4DhO3Nc/oS4lRR5cI81NfeL2jE7ULNPk3nA/Aegjlm6qtdPTGpMfLG10heEvCDGSJcKK3zkKnyiZUkoVpOBDjFhAqgzovS8Ea9sVv7ycbtXIqeQ4usXx+pWjNTCmK2pxFUQhB/6iMHSBKBRtVawWJW6esHLoP0VQo3+MMYyPC/3bDXeo9K+3WH3aN+GMEOJLNuf174Wj2ETcCpTpKZdC9vZCmVufzKxQ4cs+4dy7tjU4+1kfB2I+eEYlKL8VFwFMHbK+rHFsoYcO0tMmx8VTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZ6PkmE1xPaCacyIMLdHc80AFnKiP2a+SpnsCK7Nf2Y=;
 b=guZqAl35WAZ2i413BjuN+bvOYsMFv8WBpcwX3DwCkIehAo0p8vR9mMh2mobyByr0yPcY43I6Sp2V7TU1CyL/vo6N37f4I4T97z5UFcD7ZVAezQfuEJRk7tJsRD856WlnYm/Ngh4s+miPfJnstFQD8arwV+8D6DYLj7yCjEh1twJ4QnTQky5+Po20KQumTlgQIStF0D315m7gDaIh1Un7Lj4VYrfjPCpKU/PsCrAT8QpSRpB0FoaPJP0b1d+FeOO3WrrEzR1ct86m95+QsHzNUtDaxYbSE6s2t8bROnSG7SWaEDPAOLCL7QdFAehIzHctMr9GJdOpFFYK/WT3IG1FcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYPPR02MB9175.apcprd02.prod.outlook.com (2603:1096:405:394::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 15:58:35 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 15:58:35 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH v2 06/24] tests/qtest: Add PolarFire SoC L2CC coverage
Date: Fri,  4 Sep 2026 23:57:25 +0800
Message-ID: <20260904155758.3833179-7-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904155758.3833179-1-bin.meng@processmission.com>
References: <20260904155758.3833179-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::13) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYPPR02MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: f042dc22-1608-40b6-7689-08df0a9d6028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|5023799004|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wPeOl0TbXo3D6K7zPdvFYd+CBcTNZy3lOU1s96TAym8WAC3Y2eYY7P1yOEiIzALLTQqgXco81QOAsvfQM+hq8pyB7fYP7Y+vB8q4+Pl9LcazOLkTNQkwLsC+Rj+HHtYlwpOkTR4XR07a7noGzE9zuWDm25pqtXTNGDzzNtNBn21D9OwhGtUUHy1Qgcm6UTIWlPx13jqLaUJhofEMDQBPtlXfvmzz1DcayVsq2MnfbV+DFUIbE6SRFHY14ZkpIfqB0A9LWv6uujpN73qjyCAj5/s4nFE+it67w+Uz0eNRmJUQxREpG3zg3wTmjfgwiPYbHaqXbVfYvAmIvPt/62ayeXYGbkIM9UHZBL11nVwFp/qGb9+iAYLtA0dX3zWtce0rMebUib0lIH+W1zG4mJ55JYRUR1WbeL2cWXB/X80F2Bwp4bAmqU5DEMk6Gv8lbL5ssAeiMMOIVF334fhtqpdQvmpheZnBedbBzzCe++WkAmU2hy45NNFJVct8ZdyeJlA0IRPNgeOqLToj2OO9lNi6NcB295bzoM5JBFC23wZRdUHTQrhXd5gm5yqgjnpAJ7ZiSERuXK+xil5+gdJ7VlRwlK68+hACIMLQORqDw8ZJzkVopG+7p3qKLmXWg1MZWDP+WXrcSG7jSq2+oBy14SLqqDRPlbH/KrtE6mdftsnxFuI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(5023799004)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LgiIUq1a7VTtMyZW9ntK0no2Wf0+MiLGFeaIDVqkYt5eA5A9zF38GNctnU1Z?=
 =?us-ascii?Q?VsQINgWO/TM434t2kkAVkul0L6bin3dUj2LccflVQKUvyYVFtIFdAC/ryIpF?=
 =?us-ascii?Q?uCAbXRHYdUMRJalGSv5r0EJe9KQNQgNwhIDgLVR3TaSoW4U21bWPejAgV3u7?=
 =?us-ascii?Q?4Fnjj1M3ozONZG0lrIYkINWIRgNoeOx1Q/YR7FkRpDmikMUSE0l1F32qUKx5?=
 =?us-ascii?Q?vwsckCMdlF1XWs4icvvi9L2hLBqIH3YJ4/NRRylgkIN/6MZX/LQv2zlwYlCb?=
 =?us-ascii?Q?5e1vkaPDIRFkOuTuu+3xlG2msIM56fu5x/QtlGzXrpQWPPrMO7Py/KlVmx4J?=
 =?us-ascii?Q?B33QFt2TfUt/fyASIpQtfKB8UVdqu4cGzuDIDs7XHFcrIjjEpfdXVXs9H3Mi?=
 =?us-ascii?Q?9CNBBmw1QGQVbsgNGOUAjvxwaGSEFEUvM5bQLxmq0CvpNiyl3px7qY3K5taA?=
 =?us-ascii?Q?XVNmiY8Bf/DFfec4okv+plcHRmnv14dxB4ny8qSeCtnszAuY92SjeZDY+aaG?=
 =?us-ascii?Q?WU62EaLRBP4Mk9rEXAr6pV9faifYCOKa6NzL57eBOJOCGanu5py+Y+D3QeP5?=
 =?us-ascii?Q?Ev2fWqnsD/nKdi7GLZR0M4SegoOgcOl1zf2fuuhDcpv9IYEnxTxT46ayLrvu?=
 =?us-ascii?Q?dyDOYo+Omv27+JsICkWLcPsCODcNJQZLczKJllA2DElePcSnJ1c1GmJw5DbP?=
 =?us-ascii?Q?f6wQv0UV8bJ2jyh6S4j3nWad2qhT9G8ey+xigpNYogTKyZyvB4SWHr601e5T?=
 =?us-ascii?Q?wXxaY2dIBxbRQZ7SB86Te6PVBRh8cf4DJm+bVPhLxzyTUMGT0jUdO4EauHmt?=
 =?us-ascii?Q?L8FnDPbdWYBrzBzjU5en2BK9m2q9qZbH94IcDG1dKY631c66bnpAWcT+A2Go?=
 =?us-ascii?Q?ctaHK+NIdvz2IPsvW0TI3cu+lx1/wqmP6+6On5RDoTAr2nsno/MlaHo+SFlS?=
 =?us-ascii?Q?975n17/ILTioVl2YXHx0A8QeyBWtgACbVCBxZyh9JLQYuC2Gb0JeOfCLWvMH?=
 =?us-ascii?Q?2Uln0RiDEVmwcapMu+jB9aroh/YHKLWIBg84EEjx53WnIG38fo7G2jgfWD5b?=
 =?us-ascii?Q?xEJ6ym3Ylux8I0XsmyuvGE0bnF7EwsX5RbNrN7yRhNpNER87nFIMHxACztYE?=
 =?us-ascii?Q?99Tk6My/vOz1IfO3JowR1xcf4vEei9KbT80HzyJNsDIQol9mcNzLgt/QRU8u?=
 =?us-ascii?Q?BvP6orFBVhy8Vp+P8UiFezRwx4A4QRUKPKwII7YZtMSz9dC29shhSuDjaJNr?=
 =?us-ascii?Q?GjiIXMF7fj5uESGu4nrZevPZwc606rc1YM161VMf7QlH6oAGJivtEDMaaY2Q?=
 =?us-ascii?Q?t70uahYbyE1ZhepUDpnsxVdK3LwmKruhjZAz9mkMaLUBU9DJiaO6U+Sizx51?=
 =?us-ascii?Q?JAIUUbs/+g++EEuRg9xn8isTl+hxStPIYcGNz0yrEbcAcmj1nvR2aJbi4+FW?=
 =?us-ascii?Q?YGMatv2RHTlLknawllX3MTq2JgpOldxa5/CRQjMQMMQUd0iTFLcUtGTvV2uf?=
 =?us-ascii?Q?6aFXuJJGMj6qqBl1Es+IeekdQ3SytalBmTAIOb9Va4FldBejJGM+TgCkzbfs?=
 =?us-ascii?Q?vCsJpulYYtRlEPB6QM/f0sIqmL/iUtuWVT6rjCHz/8Nc+XYHtj4xoYNzsjbC?=
 =?us-ascii?Q?pAFNT0QHl3TjwJdKz9Het7emn6Hm/ZVtqxRrKzXm1XLuPE9EKOZpNofDypVG?=
 =?us-ascii?Q?xF8sUDrpa/f0rPPWzbJMf55RTEy1epp6drqTAsSYrMUPmI1gyCURELJnA1c1?=
 =?us-ascii?Q?V9zg+Z90F3LrbwVi03tUfffwUlzCxBs=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f042dc22-1608-40b6-7689-08df0a9d6028
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 15:58:35.0686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o09uaJWt9XP7fpiFwkkGCE5pbCbicrgm3/sIV/6FfgaT+N9uyEjRzryKq+eaNDpwaQqww+37rOEt3d1IK5WAT6VrIUwn6LtdimAZW0WstsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB9175
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=bin.meng@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
behavior.

Exercise Config, WayEnable, and every WayMask register, including
reset, monotonic writes, and unimplemented-register logging. Verify
that WayEnable resizes the guest-visible L2-LIM region while L2 Zero
remains fixed at the modeled 2 MiB size.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

 MAINTAINERS                        |   1 +
 tests/qtest/mchp_pfsoc_l2cc_test.c | 221 +++++++++++++++++++++++++++++
 tests/qtest/meson.build            |   2 +
 3 files changed, 224 insertions(+)
 create mode 100644 tests/qtest/mchp_pfsoc_l2cc_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d7615b2c2c..8b7319d3d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1803,6 +1803,7 @@ F: include/hw/misc/mchp_pfsoc_dmc.h
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
index 17870e339b..e7fea8c180 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -303,6 +303,8 @@ qtests_riscv32 = \
 
 qtests_riscv64 = ['riscv-csr-test'] + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_MICROCHIP_PFSOC') ?
+   ['mchp_pfsoc_l2cc_test'] : []) + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
-- 
2.53.0


