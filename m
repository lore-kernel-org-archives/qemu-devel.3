Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A14DC531D1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvDi-0004on-DN; Thu, 23 Jul 2026 11:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvDD-0004Ep-TG; Thu, 23 Jul 2026 11:19:53 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvDA-00084Z-0c; Thu, 23 Jul 2026 11:19:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTLP29KRRhZ175RfFx42HnjDjWMK5LBN45XVzce3JUWIi1Bom7p41A2aW+zeGHZUv4OKK/+FmHwjhy9YX+jZ8mcht7M40eEgPeaH/b8Q9PAeoTfHJ6KnDq5pQZYrd+CucHR/CKzWcYqTDZPrnPvO51hlGWgxB/YtwaF79AsMA5ESltO5ywhpL342sPYyr6RgwwzylGF56CtvWyPu5hojpOW0nSBiWAg9PmjFBiK7+FvaAoGiUy4ZApkW/VisUv3fvxxfzEEthVGKX9ZeI9bP1IzYkown8V7Mf3CXuV3P9xv5I/eqJjnOnOpz1gmT10zk2kxm3v1KFNwt4xdYSZxeEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XK+3bh4DBfNIgmPbUdGkeSCH+WVx5qSrD9GZMBU3Z84=;
 b=czZRJIqJxUugvyDWd2i9mIxnQ2kKQ9O4Oz7WSa6h9kSh7Za9aPcSsH5aVuxsEduD7EhWXZHi9DTJKEYuENsQqQ+yk7aqJY6IY8XU1FrpXZk3ZEyb/U1TwTf5pXNIX6MjprM1tfLZTTY4YVcfqeMtBsz2oQJqubjBC+YyNwcgWmD/xlPD8NEXnHMHHwyykW7Bnu0tkrQz9P/4RZ4rdBxG2SzKrUVMRwE799zBm+3P2H3KOucNEfFUu80NTnGnncrq05m10c5g8AwVoqYbg84IJS7T2E+9MDm5PjZGHuuuMMD5V0TeRHRGfdoY9kgrZ5hjbz8Mhxt4cvjeaIgcAhSkCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XK+3bh4DBfNIgmPbUdGkeSCH+WVx5qSrD9GZMBU3Z84=;
 b=KCGeTPzjQjyT5WHXDrTfmlaF1Z1MMcA7N1Hatqi9IqTsXSKoID6sAA38th0roYWdXLPxWchwwKt/FcObgLPO8G7PGEAdZytJQF0FHsR0XsIOuLIyZeYoaIG8ezANzL9aaj2XOdXpUICAwZZtJ4VjpnjpFsHo7lLX0NOOffiD3W2RNWD4bXegehn5RwF8DUm9O/PnsWWfjrvCCXvQkIy00YyGJyKzPTJIJFXGQZE19MzxICws1/kMctuIrOeGQ0yBErk7a+AOfGdBymreFX/Auc+F9HoF/x3vK4LtB5KBm9Do65tO9RHHDIzs0XrpBdoOTtLVweLJQJMeRRJl08NBlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SEYPR02MB7097.apcprd02.prod.outlook.com (2603:1096:101:1a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 15:19:37 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 15:19:37 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH 18/26] tests/qtest: Add PolarFire SoC RTC coverage
Date: Thu, 23 Jul 2026 23:18:45 +0800
Message-Id: <20260723151853.2143177-19-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|SEYPR02MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: aafbe872-cabd-430f-480c-08dee8cdcf27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|376014|366016|23010399003|1800799024|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: iAbCtarlNPmRQe4+ufssQj6SovURBJjQkKFBLJirLKtXCJ3+s/Tzczzf25RwErPaNEMoiDl8yQQ+V+5EKjDJX3sc2mCTXi6ud4IlgP+dnIN0x8UTGx4F3/kE3XJt1Iis6OA0AswpWg3G+yPXN0+aYCOLSf7FmY910mg9Hvby7usrrSR6LrrUd+gaUlvEQaN5IhPqAM8nE/Kd/sssZUVQBO9k6kRJbexu+ttMbz8qJSX5LNl45iaunoKfw2U0e7zsU0WTl6TTgjMH3fys8XioREFjFii2MBQQvkGetT6LkIFP32SwS+7BlYNWm6Q73VxRq17UnNz9Hpw8nile5YFJNGCh55pbYDfKsQ2b3XBnXRb74slwJGlE7uROIJYxHhwwqjKifj1DsYB7X6QxyTlslngqso6LeuWAOkUX2XxYVdOsY44vg7Yabx1fNBIAZ3SBJsDg8jLRPJNcpuTsBG+yTo8IeSkWt5ydh1s8FI8R7zZwEplzxv2buu/FiR0IgW3V+BtDhef/QbRz8TTTxbzxif2NkvSWi/sAfXi8ZseXQthpNyEp/BWJAnQZsxDnHieZOLbae5d+E5MZW0qPAxj9dv6T4ock47vmo2+sGEgB26ec3JfuK4zWMbDLypXVQIJOYr61m+r9e9wnjsN6YWvT3ifz7Qapc1h+XR/qQ0jOnhI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BZlJcfBbTxU3QUWjPIs41Z5Effk+spiNemLgB14ccu/NfzfmSjcyy7baizpN?=
 =?us-ascii?Q?8SnF7IJkOWRKfpw7mvLHBDyl11LicRW2yrimNg+vG54WiqzPrKt/jp/qKSYT?=
 =?us-ascii?Q?7jnf60xvYpJ5GRrU03biSzDOFqbvsueNKy2HkYFgZcBJ/SA6ui9HYFGC+Dqp?=
 =?us-ascii?Q?qnxk3X2/L4IZ+TwRnFpcNK4qc9krcnnuNWSOarddbAEyBYaGj41C7mXyZmY4?=
 =?us-ascii?Q?5Z0Oc7TWlZRRCF7tInx8eF2Vhop6unyXWY4stlP2+Ci5E9CEL1hT4/Iu4+M3?=
 =?us-ascii?Q?zJrwyz9IYJUTDNSdd9VJ6LqGxLmJvyR8OXmJBbIu9+nEVUY3HcCX5aArZWQb?=
 =?us-ascii?Q?MpI+C8hMr2Cv0NTYl85B/XTn8suUvygDrePZ4eYiccXfLc+Dw7Dh1wUtcEF/?=
 =?us-ascii?Q?WbE2QgleLIima7+jxP6nWipQuVtGP2EuXJdZYWQT96haImY1ql6Va9NxQfCK?=
 =?us-ascii?Q?LGF4jeQZR/fVWnbOpjUDEKwGMcEFipO93owjdtXzX1qyvILCNhl6DQEAesYA?=
 =?us-ascii?Q?QMRjcM4iOeHqVX00/ylHqN1sr2DMggRUw5kGyQR9dqiqiPIWvyYzFUMlfMsc?=
 =?us-ascii?Q?AS0FypsV+1gX0m7carX2OJ07/X4mT01AqOVemj3YEVqYJfqJl6ssNJ6Ceq7P?=
 =?us-ascii?Q?U94ugNGCG/uvJp6FhXBKwSXOMSxr/B5F7ZQ+nILB/Z43fxZy7zWw2w5gyzaD?=
 =?us-ascii?Q?98s3W32+Pv4t844+rK/WFrB4BGyJjhqsoiFC/8MIy8casnDmuYQSIOGmvHZD?=
 =?us-ascii?Q?n69rncVov2qGzx7xQU8ipsnQeatMcLLGNewTUZfUi5PgoazySAhcKO1B9Gg2?=
 =?us-ascii?Q?2uc8CzP95FhPmLajih/qYTmu1gS7n5ZXDWhbrQQFyyNOM/RhYc20BnEoqows?=
 =?us-ascii?Q?db4Gw0LVjfX3nw2WgDPvHS9td1eXPtnmMSFL6v6Q+qLqxQgmXDzbQIG4Lxqt?=
 =?us-ascii?Q?XAfjGGzxDyWCYJl7XkRGFPbFlzXQW+bXKyT0NgVfS0yhfxZ9idAGyKBAkmk1?=
 =?us-ascii?Q?giEMufkZgskIQp3fCAzvl+esv13LjYwJu6OryN/GpCTr1V+YXlnJhz76CJwx?=
 =?us-ascii?Q?NNB2WrmsP/5XXaPCp6yjLQK6VBy9bLuzj7nq/3iGdvqax7xZNH0MrsDGSOBm?=
 =?us-ascii?Q?vKWpBBhE+WWtf5JCfGxwDBltNPo4qoXwh92osIZBARhM0SAfyEE43ocNZ81y?=
 =?us-ascii?Q?Ia2Q8WjyAuRzz1YQtBcf6N/p2e7pW2Ia6EH3xon2pqmkOxescr78Z0Z6GAJA?=
 =?us-ascii?Q?eNkGHDVLZaSqDlJOGaHDtz6txPm6nDGSMLAzUBen24mieSKb8pFm68daP3/j?=
 =?us-ascii?Q?635fWJMlicPhhy50rIrwsvNQNXYwx3bXjK+ZB5u8HIRidqUKdl3ajC7Ho0jd?=
 =?us-ascii?Q?2nzPfpIh+aRwpetuJV378H2ylRWCZvgLUo9oWWA7HV2VLOXurmuLGHOgn6gv?=
 =?us-ascii?Q?5o8egbmWSbbJ9HL5bUApt5TF8fm0Gm7j0d0i8Y4LtHJLMhoDX7/Tqb8HWWc/?=
 =?us-ascii?Q?Lt5VwH/mmvh23l+T0VXa26nUfYEkxOLljN6Ex5LQTlGyCi3n8UV2mRrSplD+?=
 =?us-ascii?Q?FHyatnGkrNtpWLOmiz4Mr4f1uVCMcCXy1EcIjQ8pT+GcvUlI9Gtji86mU9SR?=
 =?us-ascii?Q?ThBU3mrgaQUBLvxqyJAovi3MS6/yXhs6X1mvQZorr/7T3Lo66ZARbKFyRsa+?=
 =?us-ascii?Q?VJAq6cYDPpjGgx3GuOuMMn3e7ssQ3wQwwdApvqTYURtwKXK9O8pVKSaKZZXa?=
 =?us-ascii?Q?ciVj03bpBg8KcH11SwPmGLt2exrwQTA=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aafbe872-cabd-430f-480c-08dee8cdcf27
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:19:37.6365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6rKq4CN309UhV9GNDmmRDmrJFRQ7Fh/mTfNdsfTIRxGxhQyP9LbkBaCQUwtCJXHRofC34IBTqgwoD857A7JrXcuYy4NIwsVtXscQDI8vjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7097
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

Exercise RTC register masks, binary counter, upload and stop controls,
alarm and wakeup interrupt behavior, reset state, and PLIC wiring on
the Icicle Kit.

Also verify RTC state and pending interrupt migration, including streams
from QEMU versions that predate the RTC device.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 MAINTAINERS                       |   1 +
 tests/qtest/mchp_pfsoc_rtc_test.c | 317 ++++++++++++++++++++++++++++++
 tests/qtest/meson.build           |   5 +-
 3 files changed, 322 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/mchp_pfsoc_rtc_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c4026832d8..4bcc59f1cf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1781,6 +1781,7 @@ F: include/hw/misc/mchp_pfsoc_l2cc.h
 F: include/hw/misc/mchp_pfsoc_sysreg.h
 F: include/hw/rtc/mchp_pfsoc_rtc.h
 F: tests/qtest/mchp_pfsoc_l2cc_test.c
+F: tests/qtest/mchp_pfsoc_rtc_test.c
 
 Shakti C class SoC
 L: qemu-riscv@nongnu.org
diff --git a/tests/qtest/mchp_pfsoc_rtc_test.c b/tests/qtest/mchp_pfsoc_rtc_test.c
new file mode 100644
index 0000000000..5345c7689e
--- /dev/null
+++ b/tests/qtest/mchp_pfsoc_rtc_test.c
@@ -0,0 +1,317 @@
+/*
+ * QTest testcase for the Microchip PolarFire SoC RTC
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
+#include "qemu/bitops.h"
+#include "qemu/bswap.h"
+#include "qemu/timer.h"
+#include "libqtest.h"
+#include "migration/migration-qmp.h"
+#include "migration/migration-util.h"
+
+#define RTC_BASE            0x20124000
+#define RTC_CONTROL         0x00
+#define RTC_MODE            0x04
+#define RTC_PRESCALER       0x08
+#define RTC_ALARM_LOWER     0x0c
+#define RTC_ALARM_UPPER     0x10
+#define RTC_COMPARE_LOWER   0x14
+#define RTC_COMPARE_UPPER   0x18
+#define RTC_DATETIME_LOWER  0x20
+#define RTC_DATETIME_UPPER  0x24
+#define RTC_RUNNING         BIT(0)
+#define RTC_STOP            BIT(1)
+#define RTC_ALARM_ON        BIT(2)
+#define RTC_ALARM_OFF       BIT(3)
+#define RTC_UPLOAD          BIT(5)
+#define RTC_MATCH           BIT(7)
+#define RTC_WAKEUP_CLEAR    BIT(8)
+#define RTC_WAKEUP_SET      BIT(9)
+#define RTC_UPDATED         BIT(10)
+#define RTC_WAKEUP_ENABLE   BIT(1)
+#define RTC_WAKEUP_RESET    BIT(2)
+#define RTC_WAKEUP_CONTINUE BIT(3)
+#define RTC_PRESCALER_MASK  0x03ffffff
+#define RTC_UPPER_MASK      0x3fffffff
+#define PLIC_BASE           0x0c000000
+#define PLIC_PENDING        0x1000
+#define PLIC_RTC_PENDING    (BIT(16) | BIT(17))
+#define ENVM_BASE           0x20220000
+#define HSS_HEADER_SIZE     0x100
+#define HSS_HEADER_JUMP     0x1000006f
+#define HSS_PAYLOAD_BASE    (ENVM_BASE + HSS_HEADER_SIZE)
+#define HSS_PAYLOAD_SIZE    8
+
+static QTestState *microchip_icicle_kit_start_rtc(const char *firmware)
+{
+    return qtest_initf(
+        "-machine microchip-icicle-kit -smp 5 -m 2G -bios \"%s\" "
+        "-rtc base=2020-01-01T00:00:00,clock=vm", firmware);
+}
+
+static QTestState *microchip_icicle_kit_start_ext(const char *qemu_var,
+                                                  const char *firmware)
+{
+    g_autofree char *args = g_strdup_printf(
+        "-machine microchip-icicle-kit -smp 5 -m 2G -bios \"%s\"",
+        firmware);
+
+    return qtest_init_ext(qemu_var, args, NULL, true);
+}
+
+static char *create_firmware(void)
+{
+    uint8_t firmware[HSS_HEADER_SIZE + HSS_PAYLOAD_SIZE] = { 0 };
+    static const uint8_t payload[] = {
+        0x13, 0x00, 0x00, 0x00,
+        0x6f, 0x00, 0x00, 0x00,
+    };
+    char *path;
+    int fd;
+    ssize_t written;
+    unsigned int i;
+
+    stl_le_p(&firmware[0], HSS_HEADER_JUMP);
+    stl_le_p(&firmware[4], HSS_PAYLOAD_SIZE);
+    for (i = 0; i < 5; i++) {
+        stl_le_p(&firmware[8 + i * sizeof(uint32_t)], HSS_PAYLOAD_BASE);
+    }
+    memcpy(&firmware[HSS_HEADER_SIZE], payload, sizeof(payload));
+
+    fd = g_file_open_tmp("microchip-icicle-kit-XXXXXX", &path, NULL);
+    g_assert_cmpint(fd, >=, 0);
+
+    written = write(fd, firmware, sizeof(firmware));
+    g_assert_cmpint(written, ==, sizeof(firmware));
+    close(fd);
+
+    return path;
+}
+
+static uint64_t rtc_read_binary_count(QTestState *qts)
+{
+    uint64_t count = qtest_readl(qts, RTC_BASE + RTC_DATETIME_LOWER);
+
+    count |= (uint64_t)qtest_readl(qts,
+                                   RTC_BASE + RTC_DATETIME_UPPER) << 32;
+    return count;
+}
+
+static void test_rtc(void)
+{
+    const uint64_t initial_count = 1577836800;
+    g_autofree char *firmware = create_firmware();
+    QTestState *qts = microchip_icicle_kit_start_rtc(firmware);
+    uint32_t control;
+
+    unlink(firmware);
+    qtest_irq_intercept_out_named(qts, "/machine/soc/rtc", "sysbus-irq");
+
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_CONTROL), ==,
+                    RTC_RUNNING);
+    g_assert_cmphex(rtc_read_binary_count(qts), ==, initial_count);
+    qtest_clock_step(qts, 2 * NANOSECONDS_PER_SECOND);
+    g_assert_cmphex(rtc_read_binary_count(qts), ==, initial_count + 2);
+
+    qtest_writel(qts, RTC_BASE + RTC_MODE, UINT32_MAX);
+    qtest_writel(qts, RTC_BASE + RTC_PRESCALER, UINT32_MAX);
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_MODE), ==, 0xf);
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_PRESCALER), ==,
+                    RTC_PRESCALER_MASK);
+    qtest_writel(qts, RTC_BASE + RTC_MODE, 0);
+
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_STOP);
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_CONTROL) &
+                    RTC_RUNNING, ==, 0);
+    qtest_clock_step(qts, 2 * NANOSECONDS_PER_SECOND);
+    g_assert_cmphex(rtc_read_binary_count(qts), ==, initial_count + 2);
+
+    qtest_writel(qts, RTC_BASE + RTC_DATETIME_LOWER, 42);
+    qtest_writel(qts, RTC_BASE + RTC_DATETIME_UPPER, 0);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_UPLOAD);
+    g_assert_cmphex(rtc_read_binary_count(qts), ==, 42);
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_CONTROL) &
+                    (RTC_UPLOAD | RTC_UPDATED), ==, RTC_UPDATED);
+
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_RUNNING);
+    qtest_clock_step(qts, NANOSECONDS_PER_SECOND);
+    g_assert_cmphex(rtc_read_binary_count(qts), ==, 43);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_WAKEUP_SET);
+    g_assert_true(qtest_get_irq(qts, 0));
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_WAKEUP_CLEAR);
+    g_assert_false(qtest_get_irq(qts, 0));
+
+    qtest_writel(qts, RTC_BASE + RTC_ALARM_LOWER, 45);
+    qtest_writel(qts, RTC_BASE + RTC_ALARM_UPPER, 0);
+    qtest_writel(qts, RTC_BASE + RTC_COMPARE_LOWER, UINT32_MAX);
+    qtest_writel(qts, RTC_BASE + RTC_COMPARE_UPPER, RTC_UPPER_MASK);
+    qtest_writel(qts, RTC_BASE + RTC_MODE,
+                 RTC_WAKEUP_ENABLE | RTC_WAKEUP_CONTINUE);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_ALARM_ON);
+    g_assert_false(qtest_get_irq(qts, 0));
+    g_assert_false(qtest_get_irq(qts, 1));
+    control = qtest_readl(qts, RTC_BASE + RTC_CONTROL);
+    g_assert_cmphex(control & RTC_ALARM_ON, ==, RTC_ALARM_ON);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, control | RTC_ALARM_OFF);
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_CONTROL) &
+                    RTC_ALARM_ON, ==, 0);
+    qtest_clock_step(qts, 2 * NANOSECONDS_PER_SECOND);
+    g_assert_false(qtest_get_irq(qts, 0));
+    g_assert_false(qtest_get_irq(qts, 1));
+
+    qtest_writel(qts, RTC_BASE + RTC_DATETIME_LOWER, 43);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_UPLOAD);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_ALARM_ON);
+    qtest_clock_step(qts, 2 * NANOSECONDS_PER_SECOND);
+    g_assert_true(qtest_get_irq(qts, 0));
+    g_assert_true(qtest_get_irq(qts, 1));
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_CONTROL) & RTC_MATCH,
+                    ==, RTC_MATCH);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_ALARM_OFF);
+    g_assert_false(qtest_get_irq(qts, 0));
+    g_assert_false(qtest_get_irq(qts, 1));
+
+    qtest_writel(qts, RTC_BASE + RTC_DATETIME_LOWER, 0);
+    qtest_writel(qts, RTC_BASE + RTC_DATETIME_UPPER, 0);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_UPLOAD);
+    qtest_writel(qts, RTC_BASE + RTC_ALARM_LOWER, 2);
+    qtest_writel(qts, RTC_BASE + RTC_MODE,
+                 RTC_WAKEUP_ENABLE | RTC_WAKEUP_RESET |
+                 RTC_WAKEUP_CONTINUE);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_ALARM_ON);
+    qtest_clock_step(qts, 2 * NANOSECONDS_PER_SECOND);
+    g_assert_true(qtest_get_irq(qts, 0));
+    g_assert_cmphex(rtc_read_binary_count(qts), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_CONTROL) &
+                    RTC_ALARM_ON, ==, RTC_ALARM_ON);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_WAKEUP_CLEAR);
+    qtest_clock_step(qts, 2 * NANOSECONDS_PER_SECOND);
+    g_assert_true(qtest_get_irq(qts, 0));
+    g_assert_cmphex(rtc_read_binary_count(qts), ==, 0);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_ALARM_OFF);
+    g_assert_false(qtest_get_irq(qts, 0));
+    g_assert_false(qtest_get_irq(qts, 1));
+
+    qtest_system_reset(qts);
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_CONTROL), ==,
+                    RTC_RUNNING);
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_MODE), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_PRESCALER), ==, 0);
+    g_assert_false(qtest_get_irq(qts, 0));
+    g_assert_false(qtest_get_irq(qts, 1));
+
+    qtest_quit(qts);
+}
+
+static void test_rtc_plic(void)
+{
+    g_autofree char *firmware = create_firmware();
+    QTestState *qts = microchip_icicle_kit_start_rtc(firmware);
+
+    unlink(firmware);
+
+    qtest_writel(qts, RTC_BASE + RTC_DATETIME_LOWER, 42);
+    qtest_writel(qts, RTC_BASE + RTC_DATETIME_UPPER, 0);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_UPLOAD);
+    qtest_writel(qts, RTC_BASE + RTC_ALARM_LOWER, 43);
+    qtest_writel(qts, RTC_BASE + RTC_ALARM_UPPER, 0);
+    qtest_writel(qts, RTC_BASE + RTC_COMPARE_LOWER, UINT32_MAX);
+    qtest_writel(qts, RTC_BASE + RTC_COMPARE_UPPER, RTC_UPPER_MASK);
+    qtest_writel(qts, RTC_BASE + RTC_MODE,
+                 RTC_WAKEUP_ENABLE | RTC_WAKEUP_CONTINUE);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_ALARM_ON);
+    qtest_clock_step(qts, NANOSECONDS_PER_SECOND);
+
+    g_assert_cmphex(qtest_readl(qts, PLIC_BASE + PLIC_PENDING + 8) &
+                    PLIC_RTC_PENDING, ==, PLIC_RTC_PENDING);
+
+    qtest_quit(qts);
+}
+
+static void test_machine_migration(void)
+{
+    g_autofree char *firmware = create_firmware();
+    const char *old_qemu = g_getenv("QTEST_QEMU_BINARY_OLD");
+    QTestState *from;
+    QTestState *to = qtest_initf(
+        "-machine microchip-icicle-kit -smp 5 -m 2G "
+        "-bios \"%s\" -incoming defer "
+        "-rtc base=2020-01-01T00:00:00,clock=vm", firmware);
+
+    qtest_irq_intercept_out_named(to, "/machine/soc/rtc", "sysbus-irq");
+
+    /* Allow an older QEMU source to exercise migration compatibility */
+    if (old_qemu) {
+        from = microchip_icicle_kit_start_ext("QTEST_QEMU_BINARY_OLD",
+                                              firmware);
+    } else {
+        from = microchip_icicle_kit_start_rtc(firmware);
+        qtest_writel(from, RTC_BASE + RTC_DATETIME_LOWER, 0x23456789);
+        qtest_writel(from, RTC_BASE + RTC_DATETIME_UPPER, 1);
+        qtest_writel(from, RTC_BASE + RTC_CONTROL, RTC_UPLOAD);
+        qtest_writel(from, RTC_BASE + RTC_ALARM_LOWER, 0x2345678b);
+        qtest_writel(from, RTC_BASE + RTC_ALARM_UPPER, 1);
+        qtest_writel(from, RTC_BASE + RTC_COMPARE_LOWER, UINT32_MAX);
+        qtest_writel(from, RTC_BASE + RTC_COMPARE_UPPER, RTC_UPPER_MASK);
+        qtest_writel(from, RTC_BASE + RTC_MODE,
+                     RTC_WAKEUP_ENABLE | RTC_WAKEUP_CONTINUE);
+        qtest_writel(from, RTC_BASE + RTC_CONTROL, RTC_ALARM_ON);
+        qtest_writel(from, RTC_BASE + RTC_CONTROL, RTC_WAKEUP_SET);
+        qtest_writel(from, RTC_BASE + RTC_PRESCALER, 999999);
+    }
+
+    unlink(firmware);
+
+    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
+    migrate_qmp(from, to, NULL, NULL, "{}");
+    wait_for_migration_complete(from);
+
+    if (old_qemu) {
+        g_assert_cmphex(qtest_readl(to, RTC_BASE + RTC_CONTROL), ==,
+                        RTC_RUNNING);
+        g_assert_cmphex(qtest_readl(to, RTC_BASE + RTC_PRESCALER), ==, 0);
+        g_assert_false(qtest_get_irq(to, 0));
+        g_assert_false(qtest_get_irq(to, 1));
+    } else {
+        g_assert_cmphex(rtc_read_binary_count(to), ==, 0x123456789);
+        g_assert_cmphex(qtest_readl(to, RTC_BASE + RTC_CONTROL) &
+                        (RTC_RUNNING | RTC_ALARM_ON), ==,
+                        RTC_RUNNING | RTC_ALARM_ON);
+        g_assert_cmphex(qtest_readl(to, RTC_BASE + RTC_PRESCALER), ==,
+                        999999);
+        g_assert_true(qtest_get_irq(to, 0));
+        g_assert_false(qtest_get_irq(to, 1));
+        qtest_writel(to, RTC_BASE + RTC_CONTROL, RTC_WAKEUP_CLEAR);
+        g_assert_false(qtest_get_irq(to, 0));
+        qtest_clock_step(to, 2 * NANOSECONDS_PER_SECOND);
+        g_assert_cmphex(rtc_read_binary_count(to), ==, 0x12345678b);
+        g_assert_true(qtest_get_irq(to, 0));
+        g_assert_true(qtest_get_irq(to, 1));
+        qtest_writel(to, RTC_BASE + RTC_CONTROL, RTC_ALARM_OFF);
+        g_assert_false(qtest_get_irq(to, 0));
+        g_assert_false(qtest_get_irq(to, 1));
+    }
+
+    qtest_quit(from);
+    qtest_quit(to);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/mchp_pfsoc_rtc/registers", test_rtc);
+    qtest_add_func("/mchp_pfsoc_rtc/plic", test_rtc_plic);
+    qtest_add_func("/mchp_pfsoc_rtc/migration",
+                   test_machine_migration);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 02b5780d78..945c99d014 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -296,7 +296,8 @@ qtests_riscv32 = \
 qtests_riscv64 = ['riscv-csr-test'] + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
   (config_all_devices.has_key('CONFIG_MICROCHIP_PFSOC') ?
-   ['mchp_pfsoc_l2cc_test'] : []) + \
+   ['mchp_pfsoc_l2cc_test',
+    'mchp_pfsoc_rtc_test'] : []) + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
@@ -404,6 +405,8 @@ qtests = {
   'erst-test': files('erst-test.c'),
   'ivshmem-test': [rt, '../../contrib/ivshmem-server/ivshmem-server.c'],
   'migration-test': test_migration_files + migration_tls_files + migration_colo_files,
+  'mchp_pfsoc_rtc_test': files('migration/migration-qmp.c',
+                               'migration/migration-util.c'),
   'pxe-test': files('boot-sector.c'),
   'pnv-xive2-test': files('pnv-xive2-common.c', 'pnv-xive2-flush-sync.c',
                           'pnv-xive2-nvpg_bar.c'),
-- 
2.34.1


