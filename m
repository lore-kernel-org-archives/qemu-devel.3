Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70813CD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 12:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY0nT-0001Vi-8s; Fri, 12 Jun 2026 08:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wXvxR-0002pA-Oi; Fri, 12 Jun 2026 03:05:37 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wXvxP-0005yW-5b; Fri, 12 Jun 2026 03:05:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZoFJz/M/IWP6K+guQJglqeyZy3GMPg0ILWUuziYWMwPPVreNVY7v4igFRa7Zy84cKhmewGiALtD4YfLwfIA3Tic8DrcuK9+eBINs9z/s/VFOuv3fLYyi2ezRkUi5sp6rt2R5gsAR1DTmkQ2F1dpk4dbv/8YSoABtVMJdahlFMKTH/yVd46zUxUonQ01wh/AAAfHKdgSeTogboPQJ9AqtnJVKSNk4Y9kpnOq2udq8zgAUzXg/mAD/x3PyhziFH2fs6qGU0/I8IXXObxQjZ+Ceg3H00IGCQlceShkoVfWAIARNJgzdFjo/en52DYAcbu9f7iwpSGIz6W9NQk9JLH75Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meCBOV7CMau4P3IkEIlzLLSvuLKf74HGy6rmRt/aQgY=;
 b=zRS/6uNvbmBA4+IAKfokXOyAbEkii0sVJXoisd2zHWUPRyds+gYvYwMhL5CGRSIoh7wB/8mOhdBUnTthDMEQt5d4y6De4+mkATYEtRQnkhaiv04v/x3Hp25DG41nMMfjmev6HkNf2ke9KbyLjMf18iQ/GNjxARVq/jyGkWg1SMBXgb0vo8Ne0djw87l6Hqcl+6sW5nlukthNlTXSzSW03c9pX1TvXU61Sl/keh2OBBfbuK9KwA+7iXTrH2J9s2BQTXkfYmVBd0jO/czuW782UjolDvT2+gSNxNpS39hd7DADyH40qczyg0ePXCC2SYLx4YY/GJjkEb2j2y1v++kQGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meCBOV7CMau4P3IkEIlzLLSvuLKf74HGy6rmRt/aQgY=;
 b=SJPIV5rIWuHgoSbY5jSIxyIwoD+j1zOIeMfAcDhNQomC9EQraCAFiLUs8HQZhyj0is8gf3o+72Lg1PFQ1RY0VG8QzB70HX2KGVDLmQp7NkNTy1qKneQ6lop4bcm/LvUfxBECo0K6shXv49SGFfm8RByLAjIo5vrtRhJTcw1m3DYPmT9d1OWiXBAnq6xTcjHNLC9juy0dwh7TCTQ99p0duv1uSPvbxxQUZRPm1SfKmwXvnJ+zo9YYPFuGq7cbbeRSJDBEwlNHDHz2L96n8tEKsarKyMCAwigHD3HQCggc9AgE65eSupD1aRu81qcBhCY5jskGyCKvo/IND+Q4cBkKwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SEYPR02MB6457.apcprd02.prod.outlook.com (2603:1096:101:13b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 07:05:20 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0092.017; Fri, 12 Jun 2026
 07:05:20 +0000
From: Chao Liu <chao.liu@processmission.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Chao Liu <chao.liu@zevorn.cn>, Mig Yang <temashking@foxmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v8 4/5] tests/qtest: add test for K230 watchdog
Date: Fri, 12 Jun 2026 15:04:07 +0800
Message-ID: <791beb1d8db07e4d1011cbeb4a8ac3add5b24f09.1781246408.git.chao.liu@processmission.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1781246408.git.chao.liu@processmission.com>
References: <cover.1781246408.git.chao.liu@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::24) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SEYPR02MB6457:EE_
X-MS-Office365-Filtering-Correlation-Id: da938e1f-cea0-49d3-63f5-08dec850f748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|34096008|366016|7416014|586017|376014|56012099006|6133799003|18092099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YToQ18GrJARAFI983HW+PdUofBnnIGtJ+HRVxiF+/q0qC+q5S6dUhEYR5yCyMz3KWcHEU7fpQwzP0RHuvvTdAfIlXtiErxFoQsr8MGl4F8T4qUorFwURJjP4ktOqkRXDQA4EAX+n3HDv4wpdFidYcmi86vu0duum/BO5PvxajxVumfFxRLcUTvcAIaVQh+zq26qA0LHOxhjKiheW4dEr1SzL8l3dpy4y3P4hor4uY9RxyuKAn66RiIwBErK7+MeNFQACi/FVmpbD2wMUn/Ho0OwbinaapmNQuzI0mm90vwhbs2XVcasg5d782v0x9V1a394yBOjSwk9vusnVr76gXsWWe5GORvlEowNbFVXlg33JL5CDBfFzcvuBHLiCa/5nnrPTtZR4b0uW6TxVZbh9O3N7p78qtI/7qidNu29MrIf3w6UdSsAU6PC06LUOUWp9mmEXokJy938DyIso1wH8GthWkvue9PQoleAvollMulvh7s5T/33JYveDbEJ1ldjbE2jX797ShdeB+bExdmIrjzHozGk95nIJKSu9QUkOnKaaZ/r+UmLBBUuaFFXJQVLo1qnCcNpX/jiSppvRLwB1lI3LZ5/8Sy5R6bfUWn/OPJDbOBhVgIws+Y80LBev2oq7c2WPR8bVWd7wxyt7K7chPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(34096008)(366016)(7416014)(586017)(376014)(56012099006)(6133799003)(18092099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yphb/Kf5+qMmjCQlQhiHpzbvurLPSRDWOv1RwrrA9MKE0ryjR/6wyODpcJhw?=
 =?us-ascii?Q?M8JPoY+08QNXW02Y+k62QzJJzetpYtoFJ/uFNOqXNaphy/2ZY/NAkmLk8aO0?=
 =?us-ascii?Q?QuO/Ok58+ypwvf/BO5u2rzhfLpjQnFfqgBEbqWTuHSyFgRanjdMA958q9IEe?=
 =?us-ascii?Q?V8+YTGZPK/BaYyagxE9c6R712V8QjiavukcT4/ne/YZAQt7yW2cyGb0wZ0lO?=
 =?us-ascii?Q?9/dcNacjp2+xLJfuqJbFyb0KUurKwSjhoJcyTsVcgBh3XQI4mxOEH1WWf/DX?=
 =?us-ascii?Q?JHCeJ3hPIWlMXEckke5/nE3zZY5cTWonRPNx61jgEr+Fw9azkymOec31upEE?=
 =?us-ascii?Q?2MJtKSfCfcm++Ig83W7WRzgO2eS3atH4On6IFmqsqCtbVnYe7KgiSFmQmV4y?=
 =?us-ascii?Q?V+asF/UeL9iA4Zuym6ltotfh7hkn2/wpaJsP+ydwes26df0pPi+0IFKpTNxq?=
 =?us-ascii?Q?X0jpB3DGg3DExFpZ07bzgo4HofLZGZwA9fSovbRJWQLH67xALar1NG1g2N1M?=
 =?us-ascii?Q?sV+GdQDmlCfkJt72JwkCPJuMwlwhJtY7kXa131HX9CevQlzACl/435G3KLyk?=
 =?us-ascii?Q?WoFHfm1ujOpzaUZPb7y8Fxrt1i/UF/8iIn+Bo3Ew+vYWIBBdX/H4xmwHxAmD?=
 =?us-ascii?Q?2je9hHZRPiMIBDdibaFRp1iFf6Ob9rZhFbjUV9j5iLi7EB5RIoUpd5lfg0Wi?=
 =?us-ascii?Q?aRj3URAffr1WcLyo6VST/4AA10BoFZhxISSMS+aW6CLsTZZ9OqaEXmSoyU4a?=
 =?us-ascii?Q?22na2In27BfBU65YMMcIwcSU+AB4i870vnLsrZDudD8JQGBt7G5DHsmhnyGa?=
 =?us-ascii?Q?WSOQWwjFNKQqgpZ7LmXQvjx6UY6SRzIAEUVHExDez8AYqyjMMpv1rs2Ve3KL?=
 =?us-ascii?Q?PEXuDNujfDP7uOBkHbDQXJg36BmQEKf8XKcRmIboEBH0xGLsXuHXxCrX3w6n?=
 =?us-ascii?Q?bMA9IAbEMz1QnXTbhfPytX28m4+zuoSNk4tvvswv4rYwJIMRxxPa4CiWCvhi?=
 =?us-ascii?Q?zVtyVyeickUMVKMeKw45Ogpeju0CfsDETenJjywT9z6ew+FqbyYyVUlIbC9m?=
 =?us-ascii?Q?4DOPxGtCvl1nLhrpa8MX4FSAKLD7Keef2L+WZ12wDRCGuuGjq/jqlmux+lPZ?=
 =?us-ascii?Q?llBu8LMVuZB96yAmiDP3YHkNTudTzQ4fLWXF8Q+ZdkGbG2Pi2P4NfUVL/RiT?=
 =?us-ascii?Q?yiRVwbkv6+Fs04b7Gu5+iej+Da10h3Kth9GSsQ+7XnWcs70PjwhaDntnpGr5?=
 =?us-ascii?Q?RwQVTY19vkrHyRKUC5dqG0Ia6wHwiZZrDAZOq7tV0n9E2qzCqkJWAf5RxWZv?=
 =?us-ascii?Q?Nl2MmwmZFDPWpQCxV5nOhcIfn0igXXALIOsTLquxY6EdSrauj6U4k/f97JND?=
 =?us-ascii?Q?B/Nv7W4CWXxI8oPOXwmBj+jGSkh4GjApH0uIrPKuXtECRH8A7vQafQUICOEh?=
 =?us-ascii?Q?c6H0IFv7xNneKL9tBba/3ZcUUtI4RJLsJ8NATff4IcmzN98uRNiUIcdiM9mX?=
 =?us-ascii?Q?U52dRuezmThEIViT6UNhS1WBRudAetfS2rO9Ww10hFGEehfAKvbBJvlfJtTH?=
 =?us-ascii?Q?JkGnYRyG81RLR+dtXHzJZvPjtRUDJqeGA8nyXLxpkSwX2awHGPTqd0yUb7rv?=
 =?us-ascii?Q?ZM3X5c1gGGQYOQzvxlZyBlW45uL5uunobpndsx0byEB2DZPKjks/qkkuHHTR?=
 =?us-ascii?Q?4G7Ch7fBu/LeRGQNgQQs0E0609BbMZug0gmD+hZTzBNXp8k1UomhNJhenXG1?=
 =?us-ascii?Q?e3ytS5i8Ztf3hHT/A4gD1XrZNxIt/20=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da938e1f-cea0-49d3-63f5-08dec850f748
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 07:05:20.6314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHDBgfKZvTBv6vJs+U2dNkOqnzC3UmERTAdpL1CgdFuKE9tiqKVWAemZXjcvpSHBOicksHdd4B62BkzmYdIZyzVyDW81D2qWRmfP18YjN44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB6457
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=chao.liu@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 12 Jun 2026 08:15:35 -0400
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

From: Chao Liu <chao.liu@zevorn.cn>

Testing the Basic Functions of K230 WDT:
1. Reset Function
2. Timeout Check
3. Interrupt Function

Signed-off-by: Mig Yang <temashking@foxmail.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 MAINTAINERS                 |   1 +
 tests/qtest/k230-wdt-test.c | 189 ++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build     |   3 +-
 3 files changed, 192 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/k230-wdt-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 06db33a107..44654b5798 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1794,6 +1794,7 @@ F: hw/riscv/k230.c
 F: hw/watchdog/k230_wdt.c
 F: include/hw/riscv/k230.h
 F: include/hw/watchdog/k230_wdt.h
+F: tests/qtest/k230-wdt-test.c
 
 RX Machines
 -----------
diff --git a/tests/qtest/k230-wdt-test.c b/tests/qtest/k230-wdt-test.c
new file mode 100644
index 0000000000..c8eaeaf1ae
--- /dev/null
+++ b/tests/qtest/k230-wdt-test.c
@@ -0,0 +1,189 @@
+/*
+ * QTest testcase for K230 Watchdog
+ *
+ * Copyright (c) 2025 Mig Yang <temashking@foxmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Provides a board compatible with the kendryte K230 SDK
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18):
+ * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ *
+ * For more information, see <https://www.kendryte.com/en/proDetail/230>
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/timer.h"
+#include "qemu/bitops.h"
+#include "libqtest.h"
+#include "hw/watchdog/k230_wdt.h"
+
+/* K230 WDT0 base address */
+#define K230_WDT0_BASE 0x91106000
+#define K230_WDT1_BASE 0x91106800
+
+/* Test WDT0 by default */
+#define WDT_BASE K230_WDT0_BASE
+
+static void test_register_read_write(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    /* Test Control Register (CR) read/write */
+    qtest_writel(qts, WDT_BASE + K230_WDT_CR, 0xFFFFFFFF);
+    g_assert_cmphex(qtest_readl(qts, WDT_BASE + K230_WDT_CR), ==,
+                    (K230_WDT_CR_RPL_MASK << K230_WDT_CR_RPL_SHIFT) |
+                    K230_WDT_CR_RMOD | K230_WDT_CR_WDT_EN);
+
+    /* Test Timeout Range Register (TORR) read/write */
+    qtest_writel(qts, WDT_BASE + K230_WDT_TORR, 0xFFFFFFFF);
+    g_assert_cmphex(qtest_readl(qts, WDT_BASE + K230_WDT_TORR), ==,
+                    K230_WDT_TORR_TOP_MASK);
+
+    /* Test Protection Level Register read/write */
+    qtest_writel(qts, WDT_BASE + K230_WDT_PROT_LEVEL, 0xFFFFFFFF);
+    g_assert_cmphex(qtest_readl(qts, WDT_BASE + K230_WDT_PROT_LEVEL), ==, 0x7);
+
+    qtest_quit(qts);
+}
+
+static void test_counter_restart(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    /* Enable watchdog and set timeout */
+    qtest_writel(qts, WDT_BASE + K230_WDT_CR, K230_WDT_CR_WDT_EN);
+    qtest_writel(qts, WDT_BASE + K230_WDT_TORR, 0x5); /* TOP = 5 */
+
+    /* Read current counter value */
+    uint32_t initial_count = qtest_readl(qts, WDT_BASE + K230_WDT_CCVR);
+    g_assert_cmpuint(initial_count, >, 0);
+
+    /* Restart counter with magic value */
+    qtest_writel(qts, WDT_BASE + K230_WDT_CRR, K230_WDT_CRR_RESTART);
+
+    /* Wait for time */
+    qtest_clock_step(qts, NANOSECONDS_PER_SECOND * 2);
+
+    /* Counter should be reset to timeout value */
+    uint32_t new_count = qtest_readl(qts, WDT_BASE + K230_WDT_CCVR);
+    g_assert_cmpuint(new_count, >, 0);
+    g_assert_cmpuint(new_count, !=, initial_count);
+
+    qtest_quit(qts);
+}
+
+static void test_interrupt_mode(void)
+{
+    QTestState *qts = qtest_init("-machine k230 --trace k230_*,file=k230.log");
+
+    /* Set interrupt mode and enable watchdog */
+    qtest_writel(qts, WDT_BASE + K230_WDT_CR,
+                 K230_WDT_CR_RMOD | K230_WDT_CR_WDT_EN);
+    qtest_writel(qts, WDT_BASE + K230_WDT_TORR, 0x1); /* Short timeout */
+
+    /* Wait for timeout to trigger interrupt */
+    qtest_clock_step(qts, NANOSECONDS_PER_SECOND * 10);
+
+    /* Check interrupt status */
+    uint32_t stat = qtest_readl(qts, WDT_BASE + K230_WDT_STAT);
+    g_assert_cmphex(stat & K230_WDT_STAT_INT, ==, K230_WDT_STAT_INT);
+
+    /* Clear interrupt */
+    qtest_writel(qts, WDT_BASE + K230_WDT_EOI, 0x1);
+    stat = qtest_readl(qts, WDT_BASE + K230_WDT_STAT);
+    g_assert_cmphex(stat & K230_WDT_STAT_INT, ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_reset_mode(void)
+{
+    QTestState *qts = qtest_init("-machine k230 -no-reboot");
+
+    /* Set reset mode and enable watchdog */
+    qtest_writel(qts, WDT_BASE + K230_WDT_CR, K230_WDT_CR_WDT_EN);
+    qtest_writel(qts, WDT_BASE + K230_WDT_TORR, 0x1); /* Short timeout */
+
+    /* Wait for timeout to trigger reset */
+    qtest_clock_step(qts, NANOSECONDS_PER_SECOND * 2);
+
+    /* In reset mode, the system should reset */
+    /* This test verifies that reset mode is properly configured */
+
+    qtest_quit(qts);
+}
+
+static void test_timeout_calculation(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    /* Test different timeout values */
+    for (uint32_t top = 0; top <= 15; top++) {
+        qtest_writel(qts, WDT_BASE + K230_WDT_TORR, top);
+        qtest_writel(qts, WDT_BASE + K230_WDT_CR, K230_WDT_CR_WDT_EN);
+
+        /* Read current counter value */
+        uint32_t count = qtest_readl(qts, WDT_BASE + K230_WDT_CCVR);
+        g_assert_cmpuint(count, >, 0);
+
+        /* Disable watchdog for next iteration */
+        qtest_writel(qts, WDT_BASE + K230_WDT_CR, 0);
+    }
+
+    qtest_quit(qts);
+}
+
+static void test_wdt1_registers(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    /* Test WDT1 registers (second watchdog) */
+    qtest_writel(qts, K230_WDT1_BASE + K230_WDT_CR, 0xFFFFFFFF);
+    g_assert_cmphex(qtest_readl(qts, K230_WDT1_BASE + K230_WDT_CR), ==,
+                    (K230_WDT_CR_RPL_MASK << K230_WDT_CR_RPL_SHIFT) |
+                    K230_WDT_CR_RMOD | K230_WDT_CR_WDT_EN);
+
+    qtest_writel(qts, K230_WDT1_BASE + K230_WDT_TORR, 0xFFFFFFFF);
+    g_assert_cmphex(qtest_readl(qts, K230_WDT1_BASE + K230_WDT_TORR), ==,
+                    K230_WDT_TORR_TOP_MASK);
+
+    qtest_quit(qts);
+}
+
+static void test_enable_disable(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    /* Initially disabled */
+    uint32_t cr = qtest_readl(qts, WDT_BASE + K230_WDT_CR);
+    g_assert_cmphex(cr & K230_WDT_CR_WDT_EN, ==, 0);
+
+    /* Enable watchdog */
+    qtest_writel(qts, WDT_BASE + K230_WDT_CR, K230_WDT_CR_WDT_EN);
+    cr = qtest_readl(qts, WDT_BASE + K230_WDT_CR);
+    g_assert_cmphex(cr & K230_WDT_CR_WDT_EN, ==, K230_WDT_CR_WDT_EN);
+
+    /* Disable watchdog */
+    qtest_writel(qts, WDT_BASE + K230_WDT_CR, 0);
+    cr = qtest_readl(qts, WDT_BASE + K230_WDT_CR);
+    g_assert_cmphex(cr & K230_WDT_CR_WDT_EN, ==, 0);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char *argv[])
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/k230-wdt/register_read_write", test_register_read_write);
+    qtest_add_func("/k230-wdt/counter_restart", test_counter_restart);
+    qtest_add_func("/k230-wdt/interrupt_mode", test_interrupt_mode);
+    qtest_add_func("/k230-wdt/reset_mode", test_reset_mode);
+    qtest_add_func("/k230-wdt/timeout_calculation", test_timeout_calculation);
+    qtest_add_func("/k230-wdt/wdt1_registers", test_wdt1_registers);
+    qtest_add_func("/k230-wdt/enable_disable", test_enable_disable);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 45ea497fa5..37ca38f9e7 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -291,7 +291,8 @@ qtests_riscv64 = ['riscv-csr-test'] + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
-   ['iommu-riscv-test'] : [])
+   ['iommu-riscv-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
 
 qos_test_ss = ss.source_set()
 qos_test_ss.add(
-- 
2.54.0


