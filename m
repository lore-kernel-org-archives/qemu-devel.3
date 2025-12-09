Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2069AD3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 09:40:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSuBg-0004EP-1C; Tue, 09 Dec 2025 04:39:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vSuBe-0004Dv-0B
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 04:39:14 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vSuBb-0006ZZ-MR
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 04:39:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RdI+dp31EB/F3Bgb8+CGIqLtLJcNEsbj+Jz6MZQq6utx6NHSfc0k38z/7BlCl/0WutgZWJtEIxZyLWAjLwBl+z5n4QcvYgwuCawhJd5sUJR2/MmeHhY0ngy0gvLvbKnK8LPkNbKKYngdYPv2gdX0c7AX02e0Uy3002a8vOI70lXKEWRD1/OUTv6tRt4K4B72vyGvIpcMMJIy4swoBsb1n+przTrRsOUX4tpkB2DZV7eEcMR2Kx2VurM921c4B3C/oYFLhep7a8rX1iEQyGCwtqlD3TGu696p2gD5LlNtk52iSZbw9zLwzsXNbS2Ql6xuJZCL/eDC01BqpD+mflltjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtmuTAdwt2mSApMgZUsfYJj8TF7d8K1bPkCdBI+cceY=;
 b=zSqAiGtKGvbzYdAg7i9Fb/ssv6UuMT/A6sTc2AjSmIHA71Tre4rCNfUw7Bug+Nuwji+pMwZwMImTYKrRRgt2Xx8ZSGl91VCF75NK410NRvomMdHctQl4ZV5kV4S3VVCZdD/oeQ5ZNNx/s+5qS4pPIF0dl/uNBOZnIDAd59MSEgpY62+X2SShfNhhRXwGbYmFxKyg0JYtHW67LvLqMus54yQn8FURmyXgx1Zl+jD89aBsSUFai6Ci9kZx19cRFl6awEQ6FVZqQaR/9h+CeTOzuowA1tETuTv8UFU1SBpyggyteLcgbEdcWVrdXsxYo+Q76cV08t1nDg6aqNEEd2XUBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtmuTAdwt2mSApMgZUsfYJj8TF7d8K1bPkCdBI+cceY=;
 b=UelZDk5yc+p3gTty4M6chi7Z9SPqAOxGk3zDF1Rv5Vdmzwymlc4Nn7uzuijrK5fbbvsNsPX0Nz2wkBNRiBjDGeMuaJSEMb7yscthsF64IOuPIKsF4ozg+cwe1d/9Cz7rEPxgbvuA5Zk5NQSnuhpYtR8dxwvuzqJgZZExGqUcgX8=
Received: from PH8P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::15)
 by CH2PR12MB9459.namprd12.prod.outlook.com (2603:10b6:610:27d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 09:39:04 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:510:348:cafe::71) by PH8P220CA0030.outlook.office365.com
 (2603:10b6:510:348::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 09:39:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 9 Dec 2025 09:39:04 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 03:38:58 -0600
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@redhat.com>, <imammedo@redhat.com>,
 <jonathan.cameron@huawei.com>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, <FangSheng.Huang@amd.com>
Subject: [PATCH v4 1/1] numa: add 'spm' option for Specific Purpose Memory
Date: Tue, 9 Dec 2025 17:38:41 +0800
Message-ID: <20251209093841.2250527-2-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251209093841.2250527-1-FangSheng.Huang@amd.com>
References: <20251209093841.2250527-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|CH2PR12MB9459:EE_
X-MS-Office365-Filtering-Correlation-Id: cf00fe48-9b81-48c7-4cf4-08de3706cab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?34wvFOLTPy0dvaj0d9NbXi3qPjBPa3HCQ6PvidvuJr2A3GlkjQx16tYjQxrq?=
 =?us-ascii?Q?o+bTBavD2I7Ma93xaJz3QiC3s5ZCX4sgO9fq9ZutVllxcrF34YjDEG6XjAqS?=
 =?us-ascii?Q?xVNXZWonUpwhSHqFeU8muS+cbk5ekDSOy7Mlq/5WW24Nbxjk5cxpkYKh+i35?=
 =?us-ascii?Q?KVZOuq4H8LTYBu6bji5dDnXw6KSpFb4lFryC7qYHaw/BUVKjp4z3lYzEsTbn?=
 =?us-ascii?Q?f+PqAnTnLVF4FMk627ZZNo39CNlYV3KPWbFTKg2b/nXz09OJznN01amIhJ+2?=
 =?us-ascii?Q?D7Ncl12fTN6BFkUSnBaLxXdi2gK2GSqMd8YiLYBQtauaznwp4GF3SPB6UeVn?=
 =?us-ascii?Q?LSN/5y80je+8HuEvD21JHl7wn/Sn0Dx5HMme4BxJ/34CxRo+XldFKNf6ZP76?=
 =?us-ascii?Q?BK4OfJUT4EZAlrnoWqUmqs/IMALv/hODcSAfGmtWL2LSwHDkYs22eyzUm9el?=
 =?us-ascii?Q?9mVLHq1GNiQk5Eq38i7cKUADDSqIsZtXyXzitRiBIP7TcxKJ5bHY7/wiqMX5?=
 =?us-ascii?Q?TswFYq03ATSPKmEsLPY4ADYhnCdccw/8yV0zdCWpxdlm+Hg3PzduXl8dGbWa?=
 =?us-ascii?Q?jAqe69LZA69gG75bdejKpDVYihM6Q4h6K3rsRdkHNbek/3860hp4iLIg/3qu?=
 =?us-ascii?Q?zqyL1aM/YY5Fix24TUoCvFg3B4FSYIFPrLk5o0ynoUP1eZeqPrXCYaCya9nf?=
 =?us-ascii?Q?hkQYQpsdsFTgnZNGYpok5wq1P8Mdil8U1lrl/XosTSsbjBW/UBIPe3OTF8i+?=
 =?us-ascii?Q?saqSA9SV+jNpiis7fDeOlh73567yhqL7LIkubGSMD/Yq1J3b3SpAHxePApWX?=
 =?us-ascii?Q?EBhvYqivPrZUrq43Fv0NafUAGL0WYynVnUa4+P6j1ywXF/EqDvo3cDV4aA/5?=
 =?us-ascii?Q?dx5L723edTDUJvnFNF0+Xf7D7wxJAiYEKpP2z7Sq/2O85CJ3YRacypJthD8H?=
 =?us-ascii?Q?IDWqzK1buDOq68wLh0+cKViET0iihrAUAg+Z4L4TyzV5Gt4Nx6qcd7q27wkW?=
 =?us-ascii?Q?2BRep4LbVyE6C+FnH4YNxRPFfWgB3PmCrogstXRGNmKGNIzzu5MurvHVFBL9?=
 =?us-ascii?Q?GfeZxGJEpag+jg+G8LSPG8BU4g/loCJ1e+aUS+LZcoItepy1fSdPyu7kIb18?=
 =?us-ascii?Q?VHaocPPJF82Y3Wxem9ytlKBs/ZuVwYerAEC0qPBDiWVmh6/9I8PX3wlW17iR?=
 =?us-ascii?Q?XyQGQav6O0WQFwEsoRAxrLS2rT8cxgLcK3embj130NswvrDhHOvq/qwgnIAZ?=
 =?us-ascii?Q?Vzcf0pJhhDSro+c1ncM7dKe9nLy3fsCNIVmoNAmCNi2mrRIlBxQPY7GrFpaV?=
 =?us-ascii?Q?s08fibqLqaw6K6Q3WouUEK/OGbfTp01j2ghBqXtZzFqkj0J/vIbwOKD4STLl?=
 =?us-ascii?Q?7sghzd+mqeX4JUzDZrNhlZhY93mWpZ2CQlXmCG9vzxDPyzUeowpFGfxl5aRb?=
 =?us-ascii?Q?H6MBbW033ZU3IjlxQEhjt8yH/FGQfsz53ermwWZ/jl7lF8Hpd9f/G2SZZ11q?=
 =?us-ascii?Q?wwI1Rdeus8Kr3CLNBvRZE59WCRvBwyr6LkK8Z6aIXeZZURCR9cEPpcJBY3PN?=
 =?us-ascii?Q?Zi+3RSQwH3JXTfCrNMmyZoH24O8xavaSFmuucWoh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 09:39:04.2652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf00fe48-9b81-48c7-4cf4-08de3706cab3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9459
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=FangSheng.Huang@amd.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch adds support for Specific Purpose Memory (SPM) through the
NUMA node configuration. When 'spm=on' is specified for a NUMA node,
the memory region will be reported to the guest as soft reserved,
allowing device drivers to manage it separately from normal system RAM.

Note: This option is only supported on x86 platforms. Using spm=on
on non-x86 machines will result in an error.

Usage:
  -numa node,nodeid=0,memdev=m1,spm=on

Signed-off-by: fanhuang <FangSheng.Huang@amd.com>
---
 hw/core/numa.c               |  9 +++++
 hw/i386/e820_memory_layout.c | 72 ++++++++++++++++++++++++++++++++++++
 hw/i386/e820_memory_layout.h |  2 +
 hw/i386/pc.c                 | 51 +++++++++++++++++++++++++
 include/system/numa.h        |  1 +
 qapi/machine.json            |  7 ++++
 qemu-options.hx              | 11 +++++-
 7 files changed, 151 insertions(+), 2 deletions(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index 218576f745..83079ba1fb 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -37,6 +37,7 @@
 #include "hw/mem/pc-dimm.h"
 #include "hw/boards.h"
 #include "hw/mem/memory-device.h"
+#include "hw/i386/x86.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "qemu/cutils.h"
@@ -163,6 +164,14 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
         numa_info[nodenr].node_memdev = MEMORY_BACKEND(o);
     }
 
+    if (node->has_spm && node->spm) {
+        if (!object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE)) {
+            error_setg(errp, "spm option is only supported on x86 machines");
+            return;
+        }
+        numa_info[nodenr].is_spm = true;
+    }
+
     numa_info[nodenr].present = true;
     max_numa_nodeid = MAX(max_numa_nodeid, nodenr + 1);
     ms->numa_state->num_nodes++;
diff --git a/hw/i386/e820_memory_layout.c b/hw/i386/e820_memory_layout.c
index 3e848fb69c..4c62b5ddea 100644
--- a/hw/i386/e820_memory_layout.c
+++ b/hw/i386/e820_memory_layout.c
@@ -46,3 +46,75 @@ bool e820_get_entry(int idx, uint32_t type, uint64_t *address, uint64_t *length)
     }
     return false;
 }
+
+bool e820_update_entry_type(uint64_t start, uint64_t length, uint32_t new_type)
+{
+    uint64_t end = start + length;
+    assert(!e820_done);
+
+    /* For E820_SOFT_RESERVED, validate range is within E820_RAM */
+    if (new_type == E820_SOFT_RESERVED) {
+        bool range_in_ram = false;
+
+        for (size_t j = 0; j < e820_entries; j++) {
+            uint64_t ram_start = le64_to_cpu(e820_table[j].address);
+            uint64_t ram_end = ram_start + le64_to_cpu(e820_table[j].length);
+            uint32_t ram_type = le32_to_cpu(e820_table[j].type);
+
+            if (ram_type == E820_RAM && ram_start <= start && ram_end >= end) {
+                range_in_ram = true;
+                break;
+            }
+        }
+        if (!range_in_ram) {
+            return false;
+        }
+    }
+
+    /* Find entry that contains the target range and update it */
+    for (size_t i = 0; i < e820_entries; i++) {
+        uint64_t entry_start = le64_to_cpu(e820_table[i].address);
+        uint64_t entry_length = le64_to_cpu(e820_table[i].length);
+        uint64_t entry_end = entry_start + entry_length;
+
+        if (entry_start <= start && entry_end >= end) {
+            uint32_t original_type = e820_table[i].type;
+
+            /* Remove original entry */
+            memmove(&e820_table[i], &e820_table[i + 1],
+                    (e820_entries - i - 1) * sizeof(struct e820_entry));
+            e820_entries--;
+
+            /* Add split parts inline */
+            if (entry_start < start) {
+                e820_table = g_renew(struct e820_entry, e820_table,
+                                     e820_entries + 1);
+                e820_table[e820_entries].address = cpu_to_le64(entry_start);
+                e820_table[e820_entries].length =
+                    cpu_to_le64(start - entry_start);
+                e820_table[e820_entries].type = original_type;
+                e820_entries++;
+            }
+
+            e820_table = g_renew(struct e820_entry, e820_table,
+                                 e820_entries + 1);
+            e820_table[e820_entries].address = cpu_to_le64(start);
+            e820_table[e820_entries].length = cpu_to_le64(length);
+            e820_table[e820_entries].type = cpu_to_le32(new_type);
+            e820_entries++;
+
+            if (end < entry_end) {
+                e820_table = g_renew(struct e820_entry, e820_table,
+                                     e820_entries + 1);
+                e820_table[e820_entries].address = cpu_to_le64(end);
+                e820_table[e820_entries].length = cpu_to_le64(entry_end - end);
+                e820_table[e820_entries].type = original_type;
+                e820_entries++;
+            }
+
+            return true;
+        }
+    }
+
+    return false;
+}
diff --git a/hw/i386/e820_memory_layout.h b/hw/i386/e820_memory_layout.h
index b50acfa201..657cc679e2 100644
--- a/hw/i386/e820_memory_layout.h
+++ b/hw/i386/e820_memory_layout.h
@@ -15,6 +15,7 @@
 #define E820_ACPI       3
 #define E820_NVS        4
 #define E820_UNUSABLE   5
+#define E820_SOFT_RESERVED  0xEFFFFFFF
 
 struct e820_entry {
     uint64_t address;
@@ -26,5 +27,6 @@ void e820_add_entry(uint64_t address, uint64_t length, uint32_t type);
 bool e820_get_entry(int index, uint32_t type,
                     uint64_t *address, uint64_t *length);
 int e820_get_table(struct e820_entry **table);
+bool e820_update_entry_type(uint64_t start, uint64_t length, uint32_t new_type);
 
 #endif
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f8b919cb6c..96066a1465 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -791,6 +791,54 @@ static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t pci_hole64_size)
     return pc_above_4g_end(pcms) - 1;
 }
 
+/*
+ * Update E820 entries for NUMA nodes marked as SPM (Specific Purpose Memory).
+ */
+static void pc_update_spm_memory(X86MachineState *x86ms)
+{
+    MachineState *ms = MACHINE(x86ms);
+    uint64_t addr = 0;
+
+    for (int i = 0; i < ms->numa_state->num_nodes; i++) {
+        NodeInfo *numa_info = &ms->numa_state->nodes[i];
+        uint64_t node_size = numa_info->node_mem;
+
+        /* Process SPM nodes */
+        if (numa_info->is_spm && numa_info->node_memdev) {
+            uint64_t guest_addr;
+
+            /* Calculate guest physical address accounting for PCI hole */
+            if (addr < x86ms->below_4g_mem_size) {
+                if (addr + node_size <= x86ms->below_4g_mem_size) {
+                    /* Entirely below 4GB */
+                    guest_addr = addr;
+                } else {
+                    error_report("SPM node %d spans across 4GB boundary, "
+                                 "this configuration is not supported", i);
+                    exit(EXIT_FAILURE);
+                }
+            } else {
+                /* Above 4GB, account for PCI hole */
+                guest_addr = 0x100000000ULL +
+                            (addr - x86ms->below_4g_mem_size);
+            }
+
+            /* Update E820 entry type to E820_SOFT_RESERVED */
+            if (!e820_update_entry_type(guest_addr, node_size,
+                                       E820_SOFT_RESERVED)) {
+                warn_report("Failed to update E820 entry for SPM node %d "
+                           "at 0x%" PRIx64 " length 0x%" PRIx64,
+                           i, guest_addr, node_size);
+            }
+        }
+
+        /* Accumulate address for next node */
+        if (numa_info->node_memdev) {
+            addr += node_size;
+        }
+    }
+}
+
 /*
  * AMD systems with an IOMMU have an additional hole close to the
  * 1Tb, which are special GPAs that cannot be DMA mapped. Depending
@@ -907,6 +955,9 @@ void pc_memory_init(PCMachineState *pcms,
         e820_add_entry(pcms->sgx_epc.base, pcms->sgx_epc.size, E820_RESERVED);
     }
 
+    /* Update E820 for NUMA nodes marked as SPM */
+    pc_update_spm_memory(x86ms);
+
     if (!pcmc->has_reserved_memory &&
         (machine->ram_slots ||
          (machine->maxram_size > machine->ram_size))) {
diff --git a/include/system/numa.h b/include/system/numa.h
index 1044b0eb6e..438511a756 100644
--- a/include/system/numa.h
+++ b/include/system/numa.h
@@ -41,6 +41,7 @@ typedef struct NodeInfo {
     bool present;
     bool has_cpu;
     bool has_gi;
+    bool is_spm;
     uint8_t lb_info_provided;
     uint16_t initiator;
     uint8_t distance[MAX_NODES];
diff --git a/qapi/machine.json b/qapi/machine.json
index 907cb25f75..cbb19da35c 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -500,6 +500,12 @@
 # @memdev: memory backend object.  If specified for one node, it must
 #     be specified for all nodes.
 #
+# @spm: if true, mark the memory region of this node as Specific
+#     Purpose Memory (SPM).  The memory will be reported to the
+#     guest as soft reserved, allowing device drivers to manage it
+#     separately from normal system RAM.  Currently only supported
+#     on x86.  (default: false, since 10.0)
+#
 # @initiator: defined in ACPI 6.3 Chapter 5.2.27.3 Table 5-145, points
 #     to the nodeid which has the memory controller responsible for
 #     this NUMA node.  This field provides additional information as
@@ -514,6 +520,7 @@
    '*cpus':   ['uint16'],
    '*mem':    'size',
    '*memdev': 'str',
+   '*spm':    'bool',
    '*initiator': 'uint16' }}
 
 ##
diff --git a/qemu-options.hx b/qemu-options.hx
index fca2b7bc74..ffcd1f47cf 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -431,7 +431,7 @@ ERST
 
 DEF("numa", HAS_ARG, QEMU_OPTION_numa,
     "-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=node]\n"
-    "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=node]\n"
+    "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=node][,spm=on|off]\n"
     "-numa dist,src=source,dst=destination,val=distance\n"
     "-numa cpu,node-id=node[,socket-id=x][,core-id=y][,thread-id=z]\n"
     "-numa hmat-lb,initiator=node,target=node,hierarchy=memory|first-level|second-level|third-level,data-type=access-latency|read-latency|write-latency[,latency=lat][,bandwidth=bw]\n"
@@ -440,7 +440,7 @@ DEF("numa", HAS_ARG, QEMU_OPTION_numa,
 SRST
 ``-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=initiator]``
   \ 
-``-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=initiator]``
+``-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=initiator][,spm=on|off]``
   \
 ``-numa dist,src=source,dst=destination,val=distance``
   \ 
@@ -508,6 +508,13 @@ SRST
     largest bandwidth) to this NUMA node. Note that this option can be
     set only when the machine property 'hmat' is set to 'on'.
 
+    '\ ``spm``\ ' option marks the memory region of this NUMA node as
+    Specific Purpose Memory (SPM). When enabled, the memory will be
+    reported to the guest as soft reserved, allowing device drivers to
+    manage it separately from normal system RAM. This is useful for
+    device-specific memory that should not be used as general purpose
+    memory. This option is only supported on x86 platforms.
+
     Following example creates a machine with 2 NUMA nodes, node 0 has
     CPU. node 1 has only memory, and its initiator is node 0. Note that
     because node 0 has CPU, by default the initiator of node 0 is itself
-- 
2.34.1


