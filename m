Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D564ACD98FA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 11:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waX9B-0004si-K7; Fri, 19 Jun 2026 07:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1waX9A-0004qK-00
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 07:12:28 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1waX98-0001u1-2U
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 07:12:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHSqSxgD19YipT9UroH2E3wWdKFcSzxtYbaZ8x+yUZO1FEaq/h/Qc7Z8HK6Wxqo8s1MmBOVYxSpmtCYSnLkfd1mIGgehzE0JhANKPv8Wr6atO0qSoJA1BSKbzC90E/2eOZOtP5mbFT+yTQmgvY9yAQ/OoUHIHJi3UaMWyWYPay0uAgJG35phgwy9I4leZRqy1Vc8onT1N8e8TZ96FgAR6dtGY64KUy+68sdcZelxZZ5Kwed7O4Ws7cmN2TK4OJ6Pa9jB60K1ldrFVYJOI3n6cmt8+cLzZHQw/w+NXGMIgnfRexkxTHogmsCq9o5Qn0CO7YvNOyKlPiAepD1S84fTtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9iZZt72aB6aAW8K+LthA54eIgMie3ECirTdk47/BqY=;
 b=iVYmSHcekzzkC26Px6dmKKPWkPPy45ZNj8QsCUyVQLNP0RkOKsfoJuacQT1D8Sm7PXUKBy3pmLGLtb8K+YiuLALK4NS+2VlR5sxFQltcUlbB0O9tOmE0NQm7XGwoKidIj1ryFZ145yAwa5orpgaxH+956XDj1o4b4AzvVKjf30mR5dZ1IX8+0fJkXTFqwN8ugE4Pe+5gv2SBKpoA/wdc9+vEL+bQI9K6Wv16we9DPeZPUaJPV2T/+no2cuW8sYM8TAsV+teY/4m2p8/WaH11KZMDwAa00k86aXFJoH44Humz4KQherhNn2joae0srk9zyKtHmZK61qofmqBlgHxdBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9iZZt72aB6aAW8K+LthA54eIgMie3ECirTdk47/BqY=;
 b=J33540vNs9uA0ykfvilP6kAHgKb1dOmbkU2HxHxtZIxLxLREGZQt7xePzLB94Q60fqUvX2KMC72TKfIVppqqEEwjh94EOhpDVpE85BP7FDVJ3X8CB0MvvM1V0ayoo3otihTGuIfDmLorHMhPVB0YWrKWAum68xlPmc69iat+IBo=
Received: from SJ0PR05CA0033.namprd05.prod.outlook.com (2603:10b6:a03:33f::8)
 by SJ2PR12MB8926.namprd12.prod.outlook.com (2603:10b6:a03:53b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Fri, 19 Jun
 2026 11:12:20 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::1) by SJ0PR05CA0033.outlook.office365.com
 (2603:10b6:a03:33f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7 via Frontend Transport; Fri, 19
 Jun 2026 11:12:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 11:12:19 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 06:12:17 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@kernel.org>, <imammedo@redhat.com>,
 <mst@redhat.com>, <gourry@gourry.net>, <philmd@mailo.com>
CC: <peterx@redhat.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>,
 fanhuang <FangSheng.Huang@amd.com>
Subject: [PATCH v13 09/10] tests/qtest: add e820 fw_cfg test
Date: Fri, 19 Jun 2026 19:11:35 +0800
Message-ID: <20260619111136.3481329-10-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619111136.3481329-1-FangSheng.Huang@amd.com>
References: <20260619111136.3481329-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|SJ2PR12MB8926:EE_
X-MS-Office365-Filtering-Correlation-Id: d49ee9ca-6a96-4020-faef-08decdf3a152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|18002099003|22082099003|11063799006|56012099006|43062017;
X-Microsoft-Antispam-Message-Info: MxoT+FQHDSEz+362z4mqIVg6OHzEBzBJU+0bekQG9ciNlh6qTFz4nTNz9ZtHT3/CtaCwMksLOmqSv3NbxNIwnsxj2m8Rh8kphJ5S2cZLNDWB3ZHgWtYUxU1Sl3sCGFCyF21ANCMvUBnd+2QzfsH30/ljZ25sb5yXIpGsGHBUCqzXQC35dEsPUsHnAnujV7xwpbBmgYXK58/aoTUNd2l7HsWEEN5seaFo8KwLymfQLi/g0d/Fbkak47KOYmRTxn9haBPLUb4A38OnDpMeLGBDIi/OE79MIA8WBQvurat2eWULkafy9bzNccrTRg6k+q/YAOki4H8VBbQE/BwSxVl5OuHHv+Mr4kWPHB2miQpTvOqlArbOjX1VikmTsELv1JZ1V5A1Eo15h9d5AtpC5IZik2oxwFhaGXFwnqAgsbf9wolyrQKKLsaPUyG0nte1PXa5RvhGPI07EstpY5efgrDAfql09/I/ubWOjeG34imJIFRKbO5byc1tQJ2Dqn6IWl+KFt9lxvgCrleiEOTR7w/uPGzIE7f7PXn5Yxu9UB2xkwfdxLMwwe6VQAwclexzY4GWwNiS/JELbZBjts7ZeAUkW/k7ScPkrkdsYvbccqmcLT1M7em5EuSb9t6CtGv6FGBYEK0AkZXlGwp+yps6eTUZbwIhgu/PSKVR8YkjSMn2T7Su/pZSnN9cEFJBaGnbg5GMg3ImJsvRy78DiPtG9p13fWPINoTR1JStgLcMcFoRzZ8biq6NF4OUJQB+pXzBFkwi
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4DgppY9TvoRVm7EcHde0RTn81DtrGsUSDwB5AKvn3ws1+uE7Chs1mFtnReYFVXvg1AIPk08b+Ab6kcWxwbTrIi3KdkHU66+MaxJ3uXYufxuHHTBcaiFTafq9bs5upjiPKs3WKBUBqTheKxdVaS6fvfbbYz0AIXDMHQxdtShciDvKaSkKYC8o8yfgTaPfy8pxOwQF1Fl0ZWg5kWiAo3/dJwpn02+/wyi7XjhI7ECHmmSEV4GbolWOzWw87/WzPjVhB902WSgd71sxRU5h5lNkRl/T6d1NDai32cWrjbdLsO3bQlRaV1VcuwgCFn0png4TJIiRtRSUxkGnS0DDJshzOVhFOV7fxMhWVJTe9XF0VajH7FcIpFsPW6Lbymc0Z7TzXuQRNCN4VTsKyXn4q1RUUybIRiyLWKSm8AYdxX5uR/1Fo9eOcMj+J8kfZxLwXPCM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 11:12:19.9858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d49ee9ca-6a96-4020-faef-08decdf3a152
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8926
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=FangSheng.Huang@amd.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a qtest that reads the "etc/e820" fw_cfg table and checks its
structural invariants: the file is a whole number of e820 entries and
every entry has a non-zero length. The baseline q35 case asserts the
guest sees RAM and, with no sp-mem device, no SOFT_RESERVED range.

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
---
 tests/qtest/e820-test.c | 95 +++++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build |  1 +
 2 files changed, 96 insertions(+)
 create mode 100644 tests/qtest/e820-test.c

diff --git a/tests/qtest/e820-test.c b/tests/qtest/e820-test.c
new file mode 100644
index 0000000000..1db0744c08
--- /dev/null
+++ b/tests/qtest/e820-test.c
@@ -0,0 +1,95 @@
+/*
+ * qtest e820 fw_cfg test case
+ *
+ * Validate the "etc/e820" fw_cfg table that QEMU hands to the firmware.
+ *
+ * Copyright (c) 2026 Advanced Micro Devices, Inc.
+ *
+ * Authors:
+ *  FangSheng Huang <FangSheng.Huang@amd.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "libqtest.h"
+#include "libqos/fw_cfg.h"
+#include "qemu/bswap.h"
+
+/* e820 entry layout and types (cf. hw/i386/e820_memory_layout.h) */
+#define E820_RAM            1
+#define E820_SOFT_RESERVED  0xefffffff
+
+struct e820_entry {
+    uint64_t address;
+    uint64_t length;
+    uint32_t type;
+} QEMU_PACKED;
+
+#define E820_MAX_ENTRIES    128
+
+/*
+ * Read and structurally validate "etc/e820": the file is a packed array
+ * of struct e820_entry, so its size must be a whole multiple of the entry
+ * size and every entry must have a non-zero length. Returns the entry
+ * count and fills @table.
+ */
+static size_t get_e820_table(QFWCFG *fw_cfg, struct e820_entry *table)
+{
+    size_t filesize, n, i;
+
+    filesize = qfw_cfg_get_file(fw_cfg, "etc/e820", table,
+                                E820_MAX_ENTRIES * sizeof(*table));
+    g_assert_cmpint(filesize, >, 0);
+    g_assert_cmpint(filesize % sizeof(struct e820_entry), ==, 0);
+
+    n = filesize / sizeof(struct e820_entry);
+    g_assert_cmpint(n, <=, E820_MAX_ENTRIES);
+
+    for (i = 0; i < n; i++) {
+        g_assert_cmpint(le64_to_cpu(table[i].length), >, 0);
+    }
+
+    return n;
+}
+
+static void test_e820_basic(void)
+{
+    struct e820_entry table[E820_MAX_ENTRIES];
+    QFWCFG *fw_cfg;
+    QTestState *s;
+    size_t n, i;
+    bool found_ram = false, found_soft_reserved = false;
+
+    s = qtest_init("-machine q35 -m 256M");
+    fw_cfg = pc_fw_cfg_init(s);
+
+    n = get_e820_table(fw_cfg, table);
+    for (i = 0; i < n; i++) {
+        switch (le32_to_cpu(table[i].type)) {
+        case E820_RAM:
+            found_ram = true;
+            break;
+        case E820_SOFT_RESERVED:
+            found_soft_reserved = true;
+            break;
+        }
+    }
+
+    /* baseline: RAM present, no SOFT_RESERVED range */
+    g_assert_true(found_ram);
+    g_assert_false(found_soft_reserved);
+
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_quit(s);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("e820/basic", test_e820_basic);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 4897325d84..d69ee27fa4 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -58,6 +58,7 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_AHCI_ICH9') ? ['tco-test'] : []) +                    \
   (config_all_devices.has_key('CONFIG_FDC_ISA') ? ['fdc-test'] : []) +                      \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['fw_cfg-test'] : []) +                    \
+  (config_all_devices.has_key('CONFIG_Q35') ? ['e820-test'] : []) +                          \
   (config_all_devices.has_key('CONFIG_FW_CFG_DMA') ? ['vmcoreinfo-test'] : []) +            \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['i440fx-test'] : []) +                    \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['ide-test'] : []) +                       \
-- 
2.34.1


