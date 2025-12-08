Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFA0D3B7DE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 10:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSYqp-0002Wt-Ug; Mon, 08 Dec 2025 05:52:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vSYqd-0002VP-5H
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 05:52:08 -0500
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vSYqa-0003Po-KS
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 05:52:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DnMMy27sbZ5eBMv3KGDmb1qgmsILolsq2pO+38YkymvN5EQKD9IUYKT94PV4mE3u+LhhZAv5fXBXBc93aPK44d1cDuYoxaFOThSxO256+CYsLR5NQIKJJZD/w/fwZuhT3ULx9hB7Q3KVpnMvzAnjKdWrkvzwIaIliEwgWQg7x552EGcV4MM8b/MGzOnalbaKQovbQiccYgw5HWL2wDSewiTQ8MYVU5d7SPmipuMXNBKCoOrlLhMJtc2lj0WMdCIUJ1KEcPMRbl5vr+4oyJYJaXFIB0vqCPGD1jqkEA4nTaM+pwpiOj95xAHEcGdD4HM/nb+gPIB8Qo2HIR+Bpo/ZdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCkbRZCT2AyaQWRF+3pPuVm9a8jvmzyJIk8BzGDF5qk=;
 b=Hf8i7I4WBUjpRUBhAxlEDaQtTZmb1E69nUZn0o9UlomZ43DzEzSktKw0Gomthaptx0eEU6A7VPkvLMGR55K3czYQ2I7PMtrw9PWqQXVEmUrqobBj7ICzsNSc6G3rcaYF0e4mLWeyKV6hDLSlasH4yg7NWQq48BTUppMOh4tJwpFvwaYucx8ln0+brU9xmNHjzlEW2wun46lMfnvKbcgaG+EwDP7ML+iY18ANs9wZblVHmnkOUwf1Y9fwh4lKXn45xWEUjM3PlVYkSOBjLz9LNC1aSh2m60nLK4sE8gkVBkC8X0NIyo9qlNz4A2zcbhpqUi5NnxsUUkhfs2xsd2iEKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCkbRZCT2AyaQWRF+3pPuVm9a8jvmzyJIk8BzGDF5qk=;
 b=bn/V4iQdxMVkOUcgbLaqkSIpzPE9Y+mUbslySlb/le8w+TwmV8oKupkK3rkF0LATybcG8WFxf+MQhw/VOHqAOzN6yo4tVWVNn3p+h3uviEZ1WQ7o99omhYdVCNpf249IEhk9NiX/t2ohxJe+UdgCYJlt9R3ggQ1OLuDlP05pTK0=
Received: from PH8PR05CA0003.namprd05.prod.outlook.com (2603:10b6:510:2cc::24)
 by PH7PR12MB5688.namprd12.prod.outlook.com (2603:10b6:510:130::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.13; Mon, 8 Dec
 2025 10:51:57 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:510:2cc:cafe::3e) by PH8PR05CA0003.outlook.office365.com
 (2603:10b6:510:2cc::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Mon, 8
 Dec 2025 10:51:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.0 via Frontend Transport; Mon, 8 Dec 2025 10:51:57 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 04:51:54 -0600
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@redhat.com>, <imammedo@redhat.com>
CC: <jonathan.cameron@huawei.com>, <Zhigang.Luo@amd.com>,
 <Lianjie.Shi@amd.com>, fanhuang <FangSheng.Huang@amd.com>
Subject: [PATCH v3 1/1] numa: add 'spm' option for Specific Purpose Memory
Date: Mon, 8 Dec 2025 18:51:37 +0800
Message-ID: <20251208105137.2058928-2-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251208105137.2058928-1-FangSheng.Huang@amd.com>
References: <286f685c-0694-46d1-a8cb-13c77fc598a1@amd.com>
 <20251208105137.2058928-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|PH7PR12MB5688:EE_
X-MS-Office365-Filtering-Correlation-Id: c6622528-558a-4838-110d-08de3647cef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YQU+PVGylZSPtCeX5K2ghLbl9GDsp6o4HArtq8tmsarIsXPtzfoHosB2NZqF?=
 =?us-ascii?Q?/4z+upSESBYGn3D+YaETquHETRrBO0qWGdhStx82X8jTEFBsOejZTgdCrcYa?=
 =?us-ascii?Q?2YOaEIX76QDhFfELJWGvjS/FBqXaXncg3k8EumtPFwJSpQMO01R2wueRGONO?=
 =?us-ascii?Q?S+BmKD0dZ0lkgmyLT38o4NSpyfhuTdmOK8kqf3bhMwbrG7rMuQ6LpJ6IKVgX?=
 =?us-ascii?Q?NJyUseBAfNBmKXDbKFZbkvSESuaUj1hXynKEA2m1TeF1xICMlk9uJOH0nhFo?=
 =?us-ascii?Q?1KglJIXy7UDvU4dWSddfwQ1lGiZiSclw/GOdvjW4NMZV6Ooid0psJ8luGQTw?=
 =?us-ascii?Q?r56hxg+DpNCQmdqYgIBRXp9UO1Jd/m6BG6C+Dj7vRAqjb4fgNldnLGUCrSKl?=
 =?us-ascii?Q?w9nnSZEqcNPovl6D6uFrSgsE1HkiNbiujEGtsdCu2HhzaMr++PAXTIQKea77?=
 =?us-ascii?Q?8CsKnBhokIVu//9dEBCmVoH+5LMaOTpSjwTR1oTB81fwFvQupcodHM9tP/H5?=
 =?us-ascii?Q?CU39B2bH9aIs2JUMp6OmGwymoTyIEhOHYZuk1ufJdqw/5uPK0cZ7rUanJrs9?=
 =?us-ascii?Q?nYeAgeEY52P5c1Kcq5wYNnvp+2ADzOoci2enBzOwvKg0jqRqjQ+ahMiUNLpa?=
 =?us-ascii?Q?RAUxvpOHnN8dqmtHtzfK+d1+a4ycW4zecgJzLsjKq1WuhMd0VlG4SWoeXrxp?=
 =?us-ascii?Q?LxTtd5nuxNtCowkbcmNawIv3K271ZtVbxNeaR/z3YfCouvIA9dP9j9s9vmxj?=
 =?us-ascii?Q?nlfXlWvL45gBlLGArmHuV+asWe95qjvqTsmPgyo1JwzyvNFNufbxD3kCw9kE?=
 =?us-ascii?Q?/VfdHm23tXniG2TOdru41efFSLXf4pMknlUev5sPRl7fIzzkcs47IaajULq1?=
 =?us-ascii?Q?LIChjjjSitzBcDHfO6t5mx6A0Ur89umq+5jjgAopla8P5t+9uqdpHNbY3FXn?=
 =?us-ascii?Q?ePFFWtb6Fvys7WYmIt9M6zVLu4x/Fuw5wntu1pPCWba9orJ1iMey7CCNIO0O?=
 =?us-ascii?Q?phnIXj3EKfaDG8Yf8mzOjKUSuMfi+DBXT4OPg42NX8IMt/H7ZNq1C39eLGSU?=
 =?us-ascii?Q?rxAoN60NiJvEOMacbJ00sqnVBXzdRuqdQirw0vh+UMLxrCqIhKdGMoifmZ7t?=
 =?us-ascii?Q?wjONZET7Hsja/vPP14CtSzUZX2rfgxxwEV5KbqKf3mmMzznfrxmv99Lq/AJN?=
 =?us-ascii?Q?QptPRtMqQyeqsw4WsnnERa2HfhG8s7Jw3p0F3NL9AtzxIJ+cyCnr2yy8QO+8?=
 =?us-ascii?Q?WYah2FFOBnwoF5OLPeEnrP+YZlcLAc3IVrY0Eiq5eJHptxmUS33QDYEXj58V?=
 =?us-ascii?Q?aGwvrGsauj0IujaKHp5X95jdizsWp/g+0FzltcOV9EhGzg6YdXHjLHXXNTTB?=
 =?us-ascii?Q?zs8FBsfvwEy96YbVovv5+CXojjZLnJDmCkkN7uMd+DNTRxib1EIG9H5wJOAl?=
 =?us-ascii?Q?asMr2Ry52f8N6JrhqtGYJm4ba4rXzIvCYELxM7R/ssLVEnOGqrkG5WAqJrbi?=
 =?us-ascii?Q?CqqMeqBLyKqpEG2p8ti6N/6/d+LpadXPuN6ZWRbO2i+qlonN/yOyOjIvdwmE?=
 =?us-ascii?Q?Eh8AZ/vSTI0BdZIxGHyX6fIGYENMntCbSalzz90q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 10:51:57.4727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6622528-558a-4838-110d-08de3647cef7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5688
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=FangSheng.Huang@amd.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

This patch adds support for Specific Purpose Memory (SPM) through the
NUMA node configuration. When 'spm=on' is specified for a NUMA node,
QEMU will set the E820 type to E820_SOFT_RESERVED for this memory region.

This allows guest operating systems to recognize the memory as soft reserved
memory, which can be used for device-specific memory management.

The implementation directly iterates over NUMA nodes to update E820 entries,
avoiding unnecessary RAMBlock traversal and flags, as suggested in code review.

Usage:
  -numa node,nodeid=0,memdev=m1,spm=on

Signed-off-by: fanhuang <FangSheng.Huang@amd.com>
---
 hw/core/numa.c               |  3 ++
 hw/i386/e820_memory_layout.c | 73 ++++++++++++++++++++++++++++++++++++
 hw/i386/e820_memory_layout.h |  2 +
 hw/i386/pc.c                 | 55 +++++++++++++++++++++++++++
 include/system/numa.h        |  1 +
 qapi/machine.json            |  5 +++
 qemu-options.hx              | 11 +++++-
 7 files changed, 148 insertions(+), 2 deletions(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index 218576f745..e680130460 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -163,6 +163,9 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
         numa_info[nodenr].node_memdev = MEMORY_BACKEND(o);
     }
 
+    /* Store spm configuration for later processing */
+    numa_info[nodenr].is_spm = node->has_spm && node->spm;
+
     numa_info[nodenr].present = true;
     max_numa_nodeid = MAX(max_numa_nodeid, nodenr + 1);
     ms->numa_state->num_nodes++;
diff --git a/hw/i386/e820_memory_layout.c b/hw/i386/e820_memory_layout.c
index 3e848fb69c..5b090ac6df 100644
--- a/hw/i386/e820_memory_layout.c
+++ b/hw/i386/e820_memory_layout.c
@@ -46,3 +46,76 @@ bool e820_get_entry(int idx, uint32_t type, uint64_t *address, uint64_t *length)
     }
     return false;
 }
+
+bool e820_update_entry_type(uint64_t start, uint64_t length, uint32_t new_type)
+{
+    uint64_t end = start + length;
+    bool updated = false;
+    assert(!e820_done);
+
+    /* For E820_SOFT_RESERVED, validate range is within E820_RAM */
+    if (new_type == E820_SOFT_RESERVED) {
+        bool range_in_ram = false;
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
+            updated = true;
+            break;
+        }
+    }
+
+    return updated;
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
index f8b919cb6c..ccb2af2a56 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -791,6 +791,58 @@ static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t pci_hole64_size)
     return pc_above_4g_end(pcms) - 1;
 }
 
+/*
+ * Update E820 entries for NUMA nodes marked as SPM (Specific Purpose Memory).
+ * This function directly iterates over NUMA nodes instead of RAMBlocks,
+ * as suggested by code review to simplify the implementation.
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
+                    /* Spans across 4GB boundary - should not happen with proper config */
+                    warn_report("SPM node %d spans 4GB boundary, "
+                                "using address above 4GB", i);
+                    guest_addr = 0x100000000ULL + 
+                                (addr + node_size - x86ms->below_4g_mem_size);
+                }
+            } else {
+                /* Above 4GB, account for PCI hole */
+                guest_addr = 0x100000000ULL + 
+                            (addr - x86ms->below_4g_mem_size);
+            }
+
+            /* Update E820 entry type to SOFT_RESERVED */
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
@@ -907,6 +959,9 @@ void pc_memory_init(PCMachineState *pcms,
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
index 907cb25f75..98c2367ee6 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -500,6 +500,10 @@
 # @memdev: memory backend object.  If specified for one node, it must
 #     be specified for all nodes.
 #
+# @spm: if true, mark the memory region of this node as Specific
+#     Purpose Memory (SPM).  This will set the E820 type to
+#     E820_SOFT_RESERVED for guest OS.  (default: false, since 9.2)
+#
 # @initiator: defined in ACPI 6.3 Chapter 5.2.27.3 Table 5-145, points
 #     to the nodeid which has the memory controller responsible for
 #     this NUMA node.  This field provides additional information as
@@ -514,6 +518,7 @@
    '*cpus':   ['uint16'],
    '*mem':    'size',
    '*memdev': 'str',
+   '*spm':    'bool',
    '*initiator': 'uint16' }}
 
 ##
diff --git a/qemu-options.hx b/qemu-options.hx
index fca2b7bc74..7d914a9bc6 100644
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
+    reported as soft reserved (E820 type 0xEFFFFFFF) to the guest OS,
+    which can then manage it separately from normal system RAM. This is
+    useful for device-specific memory that should not be used as general
+    purpose memory. This option is only supported on x86 platforms.
+
     Following example creates a machine with 2 NUMA nodes, node 0 has
     CPU. node 1 has only memory, and its initiator is node 0. Note that
     because node 0 has CPU, by default the initiator of node 0 is itself
-- 
2.34.1


