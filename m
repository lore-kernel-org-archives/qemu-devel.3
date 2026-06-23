Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE98CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbvvM-0006X4-OX; Tue, 23 Jun 2026 03:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wbvvK-0006Qa-S6
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:51:58 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wbvvI-0000iw-UD
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:51:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKazGJklfDOzKswbMt0VeaGorGQ03qQVyX+lA/So53n55zazo2JSgRPk/xtI9DKGtspAWe0JSrMC3ElP8Mzd/bkcZJ0KmxqgHdKbGpmy0TM/Yov9F+uYUpPrhz0Bw43KmzTNh/K7i2aSARvftv01TNPqFI6Q4z4nUHsvkxsuT/nvIyvnhAgHU9n5PyCsyRZ52P7yuTQIGdlJX/H2Z6wzwCQXfB9eIFbRWj9nzh8AUKHrNrVGNZPQilReC8odT8F5RF2kQvOZt2d+LDxKinFFcURv7T+BShYlorjR9Tw7z8ruDcovMdZ6mPQuU0rwIreUEqZn9sgj0/Ynw2velMjFmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omCNqVj94aDrgzvJ+1Gz0A53gEmlKI/lQfzZxHuj+Pk=;
 b=Z2MOz6vshcBh98ixxlolYHnR6q2oAjeJTfzJWKyc45qLJDRYlu2lFIoX1GqmBgYI2090UQ2yZDb7ys6K4PvmevTi+ERhT+s+N9puQd2LnkZyP41ir6MzauS6CHqUfXcUciCiY/CoSaSr57q5GhUZUrOFdA+nw8mTNRDLk73bWJw3x9ykAoEKLN6HcN/94NyuR8WyY/vira1aKGhgA8FY7V0LFgbMxQD6MmGyAbnT/e+8rsj75m1R93QEPJu8s79uRBN5D48lESJpGqtLz4FL9vexsC0md1Wru5WWBnNzCrt7CPbylJtqX3gYWEkWP6t2JaT5KngcvurS77a3fdanGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omCNqVj94aDrgzvJ+1Gz0A53gEmlKI/lQfzZxHuj+Pk=;
 b=OdZLtOha4HsrQJ7+DywmecLRZakSoOdb+lBdt3lzLgjY1AoUADmUPAdSWjO3ZPTtnQjOGzZQdWaac1t4djwScg7aBm8s62doagD7/++v1GZdzCfmzTwCmQ79FSrW4g+uMPlBjtLTYQOQocYcmK9DuWcTAJo2tsUr8se2jop8mOU=
Received: from SJ0PR03CA0296.namprd03.prod.outlook.com (2603:10b6:a03:39e::31)
 by DS3PR12MB999216.namprd12.prod.outlook.com (2603:10b6:8:38d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.21; Tue, 23 Jun
 2026 07:51:52 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::9d) by SJ0PR03CA0296.outlook.office365.com
 (2603:10b6:a03:39e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 07:51:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 07:51:52 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 02:51:48 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <imammedo@redhat.com>, <mst@redhat.com>,
 <david@kernel.org>, <gourry@gourry.net>
CC: <philmd@mailo.com>, <berrange@redhat.com>, <peterx@redhat.com>,
 <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH v14 09/10] tests/qtest: add e820 fw_cfg test
Date: Tue, 23 Jun 2026 15:50:50 +0800
Message-ID: <20260623075051.3797975-10-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623075051.3797975-1-FangSheng.Huang@amd.com>
References: <20260623075051.3797975-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|DS3PR12MB999216:EE_
X-MS-Office365-Filtering-Correlation-Id: 346f153b-0a46-4ec0-03af-08ded0fc49c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|18002099003|22082099003|56012099006|11063799006|43062017;
X-Microsoft-Antispam-Message-Info: FHddVKW/V9v65j0oAt3e9uLvwhMthhHTN2oQ6RV8cUDy5YPxDPalDWqKx5Xt9uGgOPlcXAoNh6FLJkGktDw9dIPoXAV0Of+MoI2DKD5rC0P/Syjhebw5VlHZ+UZJZh0iXOHGKcErUZlHNH2AdjR08HP3Pe7UmMib6Vs8jt8jisRe0BZ2JhpX89+nZaxQyMmFnu6NxVSaqzzX4qcNkh97qD4zzh2k2EzuWyY2DIEq7teSClojKNXdRduS6geVMtr6ztwO5E5d9lYfF2iBtCjTUs0T51M6EYBaM/Z8UVR4CSPuqafVC3xlTgLtXwWhr6nDey39I33DNljQVoLFinxYiWIHQulz//XGG8Qh5yT25oc8s8lOeN/6XTa2l0iwMfKSx8ssxcoucTqTVFo1vrX06lxMUu+dvqVRVYHesMfutHC3YGc0uM8ZgpxnWF7WH7+r23umu680pzhdNzgtClh4mX3zDAJ7SxoCO8k2ZHwnrVB/WWuWqLlNKcUi8t/4IWLulaMTp6a3zUAP0nXsYpgEz0HeEetlFbyKVVd7tqZWssz8ODmBExrSmVIS/5NxqYT4iAduHk92GnmrSPLiER/nRgPbQCxyovxq0FaEEFY3hM9ppB9xaVumnjXpftRcHgJw7CaUd5sfL8Llcu2INUftnj6v5qYePWvSXcabok6Cx14pG4QGHDMlDxPOP3a8+GE8usDlKM5wC0UurN1NREP9D3WI5gnIQ6mIAsAnRmtxeO4hd3/G9NIKaqc91e/BosEg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: emuDrd9hCvx8Xbheacsu93ixDMqUTvG4Hdlp53S5qFyynektOpJN13YC+7jmXgNHzw1jtIKw4S/2FeanurRBj0lMjSmVEofP3hvqxlW8aV0FcShj1JtPIwxg5ZGIa6s0cE9zIR+1C6Ku/sCNMa26q7Nmq8bcpF2XXFSHF5vXtFEE+xzq8OKSEHqi/BpGq4rEi8NkY9GcamfvpX87QqKfzFdnlfS89IGFWP5K5cZsJi+JGsRGh0EtwizgE+LvTzqrEd931PZMV/VfSHl6AzjN1kmgd/ix7O5H8o40+7B239D/ZOX1UOe+hbsMX+7To5Pdd5mNH/OPbNpbcEPZrV+24hw1mKc2QCH4fw9oO7fJq2h86OHedI4ddIbgsrfjBQzi1S8+7K4vkImw34Gio55/1hYNo0rxaihSllV9DrwF6S7CEI1QQJcqfJsFPCZI3xTd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 07:51:52.0116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 346f153b-0a46-4ec0-03af-08ded0fc49c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999216
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=FangSheng.Huang@amd.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Add a qtest that reads the "etc/e820" fw_cfg table and checks its
structural invariants: the file is a whole number of e820 entries and
every entry has a non-zero length. The baseline q35 case asserts the
guest sees RAM and, with no sp-mem device, no SOFT_RESERVED range.

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
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


