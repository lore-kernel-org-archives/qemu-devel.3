Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25D0CA5FEF
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD3BL-0002FJ-7d; Sat, 03 Oct 2026 13:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD399-0007Fn-Q4; Sat, 03 Oct 2026 13:03:49 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD396-0007C3-UX; Sat, 03 Oct 2026 13:03:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdmNQ1u5S5jBRWdn65X456tw2U09PavUAuS44212tMdkY+00L9CzJk73sGjYTzbL6bnN30/Y0iFzLMMv/3C2nNCUfKGnWVh1mvFRzV+Z7s7j7W39hNwcr47VbYVumMdTjTbvKzi4NYG1TvhrDcfFmhZhIKed2fIzT3gJGSoJp597asIrtccVzNcCcWnLgm7trhESDyL+fa6gbrIWTjrFGqIC5dx+9NNzikxdei8Bolh46yDA3cZoG9uGhs+7nX3Mu8gb9mylqgorI9XhaTFZBsKm6gifbcP45YGVFABD+g/cEx865HLvi6sQACpaas9DkpL7/Ryn1lZe10UQupHCMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yu0LdoAlqBhQta1CtFFfSWkeZSBnOry6tXLCXpB+6s=;
 b=W+NP5JGFnaHwYHf1AypojNaNYre5n23+3gQMFUzyjRvjxHbc8RUHUa5Cs26j7YI6LzXemfXLk8KKwl71q9jsj0wvS4T5FWYbneeWErByIPp++/q/eozuhf5aEIX+30QgXCwyJl3EQfcgjQxqMh460pHpM244nrBCE8NwRSChHq2ju9BwsnuYQUfbP2XeeOr7NoEHIWgjTxv26A7xOgoMKA973yPrSkleTBsJEwgdd3f2R6z+qhGhLVhJCj6ZhEMd0eVYHJuah5K8Eyt2TW+g/8wgjBBDXTL1niG9PSrOq12yO/KdGGjqSddKAc7aoRrZ+eIOmu4tVxdm42WoahAPvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yu0LdoAlqBhQta1CtFFfSWkeZSBnOry6tXLCXpB+6s=;
 b=J8dvsyvrCIRPMZLwqMo5yzJTJRFeO7TZfEdmHPu+D06143SW9dIVD4jeM28XRBMRw4412QgiJ+QWuyhtWx0DMqrSCwWJsOJDINrRJoew5ybI2n4Nhuz5ZYRJezpPoZBZKg4zTFQ5/ZEY4YMJwcwt2JqKkQda8fdwKScN+372A7hRNu2uffjTfu3I/OANXH3Uj3yKMy99kz0Ef4bWf/D5Hb9553mIhUFZistAV9zvZefL+OLNcog36+N1n0OQVdsMExEf0dZ8yNLcOp5zmBTeShjiwtYf8/uqq9Z+OmHZNrf+O7oDaLYvOPvTn2tVj01QER1Vsu6tKySqUZvZuxUqwA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYSPR02MB7371.apcprd02.prod.outlook.com (2603:1096:405:39::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 3 Oct
 2026 17:03:16 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 17:03:16 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org
Subject: [PATCH v3 08/27] tests/qtest: Add SiFive L2 cache controller coverage
Date: Sun,  4 Oct 2026 01:01:58 +0800
Message-ID: <20261003170232.2450916-9-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261003170232.2450916-1-bin.meng@processmission.com>
References: <20261003170232.2450916-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0100.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::14) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYSPR02MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b688c9d-137d-496a-a91a-08df21703796
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|18002099003|22082099003|56012099006|5023799004|260925021311599003|260925022911599003|260925021911599003|10067099003;
X-Microsoft-Antispam-Message-Info: Q3Rzq8UIcyaLc4FsVofEqZ/g7x8huN10bHxk76xdhYkPKQIfyDTCkTBqIfqTIbeQ7TramO4Lz8TAc92uXtGEcICXjOQzJK9XtZxgkwfJRR2rrDr25PiqGAEAJzKA6blsi9wQUkCDRp1ez9Mv7FoF6+RkkWhJBtepZFl2pAFwIOwhX0Z/6xoOcyq/oVDMkVTI+nXG+ddFRKyaIOgNS1qOazRQNH30paXeZKmu/rzgxWgiEorPnqBzPbrQxqsjQaefvjwk3AgtetHrQWA/Oai9AolyQ6uVHIC28cPCuFjR9W8w//KW5RsvH7gXZXqGYxh4Rg/NuhyKz7T7JciugXjb9biKbctqNjrJi07/GnQlRenhvDw88zRXg0tov+fEWqwnI0od2wVwVf0J6p0FvoRd2QYMXG33Y9TVsMvEjwwbaW5gQNxYTz/GUVGLJX63krxa+eroNzcX10rhbXje4vJ0q2TaP6EmVTDA1B9gF6j3eqnEIyosEHUNaaMfKGEITJm+OGrALW3dc0P3q1Exv3gKOR2W3pnaUmIXTtJS4j/WdXCBeohQYp83hLcQiiCnDuZrwIHxad2CfGBoUCwCg33QKuDL1Ak5NsWu/WvkSXzVAopZEubPqHo/p4gD/pfT4WWgj/o+GJCI5PKqwu8taDyB6W852iPhOffsB9CdT6knaQk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(56012099006)(5023799004)(260925021311599003)(260925022911599003)(260925021911599003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Uc8iRt0G6EJh4aPF0qhzoA6yNV2kgcrB/rwqe8tq1zzWR6MP/3XbkTEBoI2y?=
 =?us-ascii?Q?KCK4p93XFZyhgYUxFSYiVSrKMcTxonv8TiV8OOlg1zeGL9Nzpddu0vT0xPgB?=
 =?us-ascii?Q?gZu5RUwVjpTBh4qziDwJCzHgUnbmtQsgJzcrjBaOHTeWODFuEINORy8yhVjB?=
 =?us-ascii?Q?+hZeVF/luR0rmu7sCIQTUR0cfMuwl5k5j/wHjTRE5AamYxXHDX6P4LlZ49TT?=
 =?us-ascii?Q?gIikMPkpZYYcn2WdkUQ32GE74fefMvveSz28+cEv5Ur/Biu7OjpHdLsu+vkw?=
 =?us-ascii?Q?bcLLHlJTwrqCKQwmoOckJC62GyxlON/G2OVPSXSPlkewMLt9INuO5fZDGN4l?=
 =?us-ascii?Q?VGJqpOH56PeNDBnEgKR4t7kiZIHXpPcrcC4GLXDwFFKXBk7phG1VGStpv9p9?=
 =?us-ascii?Q?aQdefBrObuP+hZXh9w3MppuSAK9HzrFX+DPI9AmZ4DjCYohIuU1sgjxxy8/B?=
 =?us-ascii?Q?/yVXk2o1TI3x1MVFrp+qeI5pjoRs6fGK1yd42S/xcq0paR5W1MdSdG0vb2lc?=
 =?us-ascii?Q?TVdY4O6eG0aC3id+wtmNaUp1UHZ1N6frknBzg9ZuD8Mlw8JepPwtyCQWlkZa?=
 =?us-ascii?Q?ziF8zCfR9IhHn+Yno7DAwhKBHdNPLmeUcVAzmuf4cqpexIM5RCvG2LOpUUdv?=
 =?us-ascii?Q?3Na3NncJHOnav6gwL6XwlFDT6kEt5mnd8Qytz4ckfE9I7D0oVOIyUFdfKKWA?=
 =?us-ascii?Q?LVB+dDIaaqKr58t6wT+jEKPzCyEZAPx7m/nwJVXUPc3/YNmX2tZ+45nUkx23?=
 =?us-ascii?Q?AXEB8P2MtEVSIy+HaM8srTmNDqzKgCU3bb2fyho+1o+0Y37X9UOBk7Y5BxHC?=
 =?us-ascii?Q?zNIiEt91iNetLd2te6O8G5+J7KlqX2mZZWDIsiMBzR//kWK9PSVB/m3Yz9dJ?=
 =?us-ascii?Q?HqY4C2M8zowT64m6F/FxqTp/n0vVA1zPaEJVVgfvAf6tmqmIUCheHcywajYS?=
 =?us-ascii?Q?2xYE2I+jKC0NEUH5+hJ8ABMH88vvNwVpUGkwqaD1sBCk66OQmMX/tSpZ7x4t?=
 =?us-ascii?Q?wEyZ7JI3HBtlE7ibPITaJhBJb/SDXrgsFuH5fDErAXsBcpysSPxvHCSTLUB9?=
 =?us-ascii?Q?5qRbRY7osLZq25ZK2ZOtGmgTZWt6zmcBTZdXHVosfudK+8EuGB2dM2xhgJgU?=
 =?us-ascii?Q?ntmNRzRHApoo+a4rzq6aqoRwZHvk0CQ8YRaNkl2GHmM33QecT/ewd08hB4n0?=
 =?us-ascii?Q?EwGZJmuz7BLUdjfTAFrIUmSB0EPvcZ9IrApatFVRDrk/c+FVXLegGXp7Gcie?=
 =?us-ascii?Q?w7urn2sECLo+JGsikEwB4QrsuF97SQhAbXiWQnrrb3V6kBbx1YjDkIhZQrey?=
 =?us-ascii?Q?fUSahZZnQuKkAmHLEGe2e41Isna3OkviqGYj/8geKrjJaF9/lWgUDKZOg2K3?=
 =?us-ascii?Q?HOKjfy4+Gka9Y5GIRXQxKzGyFFvYPGXA7/i4I1ihEevoZ/j3wukpTzVHxkYm?=
 =?us-ascii?Q?xBz4vXAH4Y6j1Mo9UdHzsXwdNea51nRGZY8bbCvwMlHSVo200JjljSf+hOmb?=
 =?us-ascii?Q?SJ3Oq84urHRl96cZatVa+Ft0/3AYjtYMgkIB99g5C1J+3MSDY2eZPntQtSON?=
 =?us-ascii?Q?8g2TxqK8A8x9zcgOvYgkzpoF6j1YtKOuUlIpexhTqPZ5mWKXetoZeuntZvtn?=
 =?us-ascii?Q?CXFaCKKOGl68WFKI0y1ZeyVd2RLEoKVS9af2ZMfW2cNaDBO6yQwqMhzfUjkj?=
 =?us-ascii?Q?RPLdptuME/bCOzEVrEwCJiRGG8Cr5RqUj1g4Yb1AxQRZol7v6TqQ0KicdcmW?=
 =?us-ascii?Q?bdkWsSnyiNk8sRjT8WjXo6VD0Tp3/cQ=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b688c9d-137d-496a-a91a-08df21703796
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 17:03:16.3916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: njER+xBMq5VavydenA9W2NrcL2RR+ASK6+fgZMOUWFT4cjMOuTg/sU9r/USEars9sHTSlZB0fGhuP2NdK4pyeVNIHM9MsOiJnN63uJRnqzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7371
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

Exercise Config, WayEnable, and indexed WayMask registers on the
PolarFire and FU540 integrations, including their different master
counts, reset, monotonic writes, and unimplemented-register logging.

Verify that enabling cache ways hides the corresponding LIM range,
while the controller's Zero window stays accessible. Check that reset
restores hidden LIM data without clearing the Zero RAM stand-in.

Migrate register state and both RAM backings, verify the destination
LIM view, and confirm that writes to hidden addresses do not alter the
data restored by a later reset.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v3:
- Rename the test for the shared SiFive L2CC model
- Exercise 15 masters on PolarFire and 21 masters on FU540

 MAINTAINERS                    |   1 +
 tests/qtest/sifive_l2cc_test.c | 306 +++++++++++++++++++++++++++++++++
 tests/qtest/meson.build        |   3 +
 3 files changed, 310 insertions(+)
 create mode 100644 tests/qtest/sifive_l2cc_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1312bbd1bd..acb79a7d61 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1827,6 +1827,7 @@ F: docs/system/riscv/sifive_u.rst
 F: hw/*/*sifive*.c
 F: include/hw/*/*sifive*.h
 F: tests/functional/riscv64/test_sifive_u.py
+F: tests/qtest/sifive_l2cc_test.c
 
 Tenstorrent Machines
 M: Joel Stanley <joel@jms.id.au>
diff --git a/tests/qtest/sifive_l2cc_test.c b/tests/qtest/sifive_l2cc_test.c
new file mode 100644
index 0000000000..fef80f3438
--- /dev/null
+++ b/tests/qtest/sifive_l2cc_test.c
@@ -0,0 +1,306 @@
+/*
+ * QTest testcase for the SiFive L2 cache controller
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
+#include "migration/migration-qmp.h"
+#include "migration/migration-util.h"
+
+#define L2CC_BASE                       0x02010000
+#define L2CC_CONFIG                     0x000
+#define L2CC_CONFIG_VALUE               0x06091004
+#define L2CC_WAY_ENABLE                 0x008
+#define L2CC_ECC_INJECT                 0x040
+#define L2CC_FLUSH64                    0x200
+#define L2CC_WAY_MASK_BASE              0x800
+#define L2CC_WAY_MASK_COUNT             15
+#define L2CC_MAX_MASTERS                21
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
+static QTestState *sifive_l2cc_start(const char *firmware)
+{
+    return qtest_initf("-machine microchip-icicle-kit -smp 5 -m 2G "
+                       "-bios \"%s\"", firmware);
+}
+
+static char *sifive_l2cc_create_firmware(void)
+{
+    static const uint8_t firmware[] = {
+        0x13, 0x00, 0x00, 0x00,
+        0x6f, 0x00, 0x00, 0x00,
+    };
+    char *path;
+    int fd;
+    ssize_t written;
+
+    fd = g_file_open_tmp("sifive_l2cc_XXXXXX", &path, NULL);
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
+    g_autofree char *firmware = sifive_l2cc_create_firmware();
+    QTestState *qts = sifive_l2cc_start(firmware);
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
+    g_autofree char *firmware = sifive_l2cc_create_firmware();
+    uint32_t original[L2_LIM_RESET_WAYS];
+    const uint32_t poison = 0xdeadc0de;
+    const uint64_t zero_last = L2_ZERO_BASE + L2_ZERO_SIZE - 4;
+    QTestState *qts = sifive_l2cc_start(firmware);
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
+    g_assert_cmphex(qtest_readl(qts, zero_last), ==, 0xa55a9669);
+
+    qtest_quit(qts);
+}
+
+static void test_l2cc_master_count(void)
+{
+    g_autofree char *firmware = sifive_l2cc_create_firmware();
+    QTestState *qts = qtest_initf(
+        "-machine sifive_u -smp 5 -bios \"%s\"", firmware);
+    const uint64_t zero_last = L2_ZERO_BASE + L2_ZERO_SIZE - 4;
+    unsigned int i;
+
+    unlink(firmware);
+
+    for (i = 0; i < L2CC_MAX_MASTERS; i++) {
+        g_assert_cmphex(qtest_readq(qts, L2CC_BASE + L2CC_WAY_MASK(i)), ==,
+                        L2CC_WAY_MASK_RESET);
+        qtest_writeq(qts, L2CC_BASE + L2CC_WAY_MASK(i),
+                     l2cc_way_mask_test_value(i));
+    }
+    for (i = 0; i < L2CC_MAX_MASTERS; i++) {
+        g_assert_cmphex(qtest_readq(qts, L2CC_BASE + L2CC_WAY_MASK(i)), ==,
+                        l2cc_way_mask_test_value(i));
+    }
+    g_assert_cmphex(qtest_readq(qts,
+                                L2CC_BASE + L2CC_WAY_MASK(L2CC_MAX_MASTERS)),
+                    ==, 0);
+    qtest_writel(qts, zero_last, 0x12345678);
+    qtest_writel(qts, L2_ZERO_BASE + L2_ZERO_SIZE, 0xdeadc0de);
+    g_assert_cmphex(qtest_readl(qts, L2_ZERO_BASE + L2_ZERO_SIZE), ==, 0);
+    qtest_writeb(qts, L2CC_BASE + L2CC_WAY_ENABLE, 15);
+    g_assert_cmphex(qtest_readl(qts, zero_last), ==, 0x12345678);
+    g_assert_cmphex(qtest_readl(qts, L2_LIM_BASE), ==, 0);
+
+    qtest_system_reset(qts);
+    for (i = 0; i < L2CC_MAX_MASTERS; i++) {
+        g_assert_cmphex(qtest_readq(qts, L2CC_BASE + L2CC_WAY_MASK(i)), ==,
+                        L2CC_WAY_MASK_RESET);
+    }
+    qtest_quit(qts);
+}
+
+static void test_l2cc_migration(void)
+{
+    g_autofree char *firmware = sifive_l2cc_create_firmware();
+    QTestState *from = sifive_l2cc_start(firmware);
+    QTestState *to = qtest_initf(
+        "-machine microchip-icicle-kit -smp 5 -m 2G "
+        "-bios \"%s\" -incoming defer", firmware);
+    const uint64_t hidden = L2_LIM_BASE + 8 * L2_WAY_SIZE;
+    const uint64_t zero_last = L2_ZERO_BASE + L2_ZERO_SIZE - 4;
+
+    unlink(firmware);
+
+    qtest_writel(from, L2_LIM_BASE, 0x11223344);
+    qtest_writel(from, hidden, 0x55667788);
+    qtest_writel(from, zero_last, 0x99aabbcc);
+    qtest_writeb(from, L2CC_BASE + L2CC_WAY_ENABLE, 7);
+    qtest_writeq(from, L2CC_BASE + L2CC_WAY_MASK(14), 0x1234);
+    g_assert_cmphex(qtest_readl(from, hidden), ==, 0);
+
+    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
+    migrate_qmp(from, to, NULL, NULL, "{}");
+    wait_for_migration_complete(from);
+
+    g_assert_cmphex(qtest_readb(to, L2CC_BASE + L2CC_WAY_ENABLE), ==, 7);
+    g_assert_cmphex(qtest_readq(to, L2CC_BASE + L2CC_WAY_MASK(14)), ==, 0x1234);
+    g_assert_cmphex(qtest_readl(to, L2_LIM_BASE), ==, 0x11223344);
+    g_assert_cmphex(qtest_readl(to, hidden), ==, 0);
+    qtest_writel(to, hidden, 0xdeadc0de);
+    g_assert_cmphex(qtest_readl(to, zero_last), ==, 0x99aabbcc);
+
+    qtest_system_reset(to);
+    g_assert_cmphex(qtest_readb(to, L2CC_BASE + L2CC_WAY_ENABLE), ==, 0);
+    g_assert_cmphex(qtest_readl(to, hidden), ==, 0x55667788);
+    g_assert_cmphex(qtest_readl(to, zero_last), ==, 0x99aabbcc);
+
+    qtest_quit(from);
+    qtest_quit(to);
+}
+
+static void test_l2cc_unimplemented(void)
+{
+    g_autofree char *firmware = sifive_l2cc_create_firmware();
+    g_autofree char *log_path = NULL;
+    g_autofree char *log = NULL;
+    QTestState *qts;
+    int fd;
+
+    fd = g_file_open_tmp("sifive_l2cc_unimp_XXXXXX", &log_path, NULL);
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
+    if (qtest_has_machine("microchip-icicle-kit")) {
+        qtest_add_func("/sifive_l2cc/registers", test_l2cc_registers);
+        qtest_add_func("/sifive_l2cc/l2lim_topology", test_l2lim_topology);
+        qtest_add_func("/sifive_l2cc/unimplemented", test_l2cc_unimplemented);
+        qtest_add_func("/sifive_l2cc/migration", test_l2cc_migration);
+    }
+    if (qtest_has_machine("sifive_u")) {
+        qtest_add_func("/sifive_l2cc/master_count", test_l2cc_master_count);
+    }
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 200abf6f36..1fe008c9ed 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -311,6 +311,7 @@ qtests_riscv32 = \
 
 qtests_riscv64 = ['riscv-csr-test'] + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_SIFIVE_L2CC') ? ['sifive_l2cc_test'] : []) + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
@@ -427,6 +428,8 @@ qtests = {
   'erst-test': files('erst-test.c'),
   'ivshmem-test': [rt, '../../contrib/ivshmem-server/ivshmem-server.c'],
   'migration-test': test_migration_files + migration_tls_files + migration_colo_files,
+  'sifive_l2cc_test': files('migration/migration-qmp.c',
+                           'migration/migration-util.c'),
   'pxe-test': files('boot-sector.c'),
   'pnv-xive2-test': files('pnv-xive2-common.c', 'pnv-xive2-flush-sync.c',
                           'pnv-xive2-nvpg_bar.c'),
-- 
2.53.0


