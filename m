Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C71DCCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 09:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAlrq-0001ab-0f; Mon, 20 Oct 2025 05:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vAlrm-0001aH-RY
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 05:07:47 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vAlre-0004Yo-BY
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 05:07:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GY/m6LdK9UVYCgMZ0exOWxejhpTbRCcODqeiwjIe1j3Ox17/6/ZCgtpCTmE37Q2NeuVEnKvazH5aGH3xbYEiJyKk9Oa1a+8edY6hi+NOvr4dnbbLXHoJ/B1SEqVygVtFQUGdp/9mAgOVMhxJo9IpE2Njx2CXap8czmZ6ilR78zpomb1tnma2TGgj7XRTOz2kCSD62RhCq16blfAbzyV9NYOJajIW+yq8G4urYVmL5xOtBUdoHkqjc+RvKzHBhIWi8uaWMGSd5mS6TwtOYakfyn9zwD5j6nO7x2UNHb7B2nxr5ik+jCoh12ZWH/9hXsDv6rxBoGwjdrcLwu00+i8kkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUYDk7Mj/ezG2Vqc0/EbrI76F/k6ZM4eX5cIHx1v65Y=;
 b=b/C5p4pi0QNTaEYoirpCzZHN3pVAz//2mhnV5+gq1dFY03fOM7nOuFSoRJ2EfI4LXX3C42U/4NcbSVG/+WLxFI4Iqn0tU1eQo/AF92V79mch7s9cA0ZOVts7MYchqtNO+UXFpphwwrOoaIYsrhE07LbVj3Qr620FYZqM0qA9fyYZCiJ3IySzuyyHMsuSxpyzuzH0riTUa6qweFBmHcEg5aEXMlmqcl0qkGQNm3KRR4fRNs526CXskaeko4FHFBQGpRkWfAe+8HvZ/RdtLooWwhLHnOwsJyvznXK3ptLDd4JuiMT8e8xMKBKQ1W8OM81IJZTV/8U2Z3BbKOsUFhKz/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUYDk7Mj/ezG2Vqc0/EbrI76F/k6ZM4eX5cIHx1v65Y=;
 b=yE8t7L2sPk+BWXd5rhJgX8YIiDLIFeYhgGu5pcCUqzDscl4Y1g18MugtrOLvpPfFUMtOuTL1FVsSrIRnzaFRGSCL63q+pbh3pzb2fgYnlH8EwYqHp4Px3hG6H5g870WyRuqwmj0JhO/qDXJyk/+mzRAkQDhF0lh6xeDG61CVDJ0=
Received: from BN9PR03CA0876.namprd03.prod.outlook.com (2603:10b6:408:13c::11)
 by CH1PPF0316D269B.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::604) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 09:07:29 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:408:13c:cafe::8b) by BN9PR03CA0876.outlook.office365.com
 (2603:10b6:408:13c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.15 via Frontend Transport; Mon,
 20 Oct 2025 09:07:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 09:07:29 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Oct
 2025 02:07:26 -0700
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@redhat.com>, <imammedo@redhat.com>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, <FangSheng.Huang@amd.com>
Subject: [PATCH v2] numa: add 'spm' option for Specific Purpose Memory
Date: Mon, 20 Oct 2025 17:07:01 +0800
Message-ID: <20251020090701.4036748-2-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251020090701.4036748-1-FangSheng.Huang@amd.com>
References: <20251020090701.4036748-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|CH1PPF0316D269B:EE_
X-MS-Office365-Filtering-Correlation-Id: 47f49e25-172d-4d5e-c6ff-08de0fb81869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?txzGUIzWkFcWYL3abnpn6SQmOVt2mEUCD8GiUq+fSx6lRV97lz4PwZ90gexI?=
 =?us-ascii?Q?8BCw25XuYUWCQnvqfrwSLd4qub8Azwl+QGbiU1QyT74HI+RIt/P38qhfaXcv?=
 =?us-ascii?Q?iJHu0BbKaP+cU9hKO4ldcbc9hk2NMmK1wHJwHtGqGs1QVEq19UBlO5J7+H7+?=
 =?us-ascii?Q?V1CNcTJZYKLZtL/o9zoRgUBLnLg93hnL0m2FA/M4pFzsro6yBTS5UFrlrOr8?=
 =?us-ascii?Q?c2vzLqEukWLrMfNfCap8BQq28Yl6BZzv/JIMVJ/5dtZYBJ2Q2tOd28DHkRKW?=
 =?us-ascii?Q?DkaopyN2t2gOptrAiOmwSiMWT2DJLJdLyvBN0b/Fjl3FDL3dgsKV6GRvMRlu?=
 =?us-ascii?Q?75wzvih84+1S8Jsve0SZgJArjyDDkH5gNF35VtHycdvmuESDQ8zBN0D2bK4l?=
 =?us-ascii?Q?/mPROuIurpAkcyDEiLjMgYuOCVXwFXyGNAhxxaZ8lTNqKljl34HDjHyQw9Cs?=
 =?us-ascii?Q?kwgHBB0wsDQnj9f6medr5/6hjFp8HtuT3eEbXQtIFXNOyQIIUo/2w2jIcNuk?=
 =?us-ascii?Q?xIncYhiWjGcIwIJiJAvDJ0zjiM04Zyr3gctDvvHIOtnyL6Qk37gjbCfSaOT7?=
 =?us-ascii?Q?3Uy/XTY+14C2RYp7tpLVTe9kBNSCPsYsa9tuaucKmaGdMm5AYYWf2qH5RAru?=
 =?us-ascii?Q?QB3YSLRMwBytxtE/QaTo3BD0ENmc7Us+1423J5+fjTosyC8VvD3t1h0sD/mt?=
 =?us-ascii?Q?GaxturdDsfvHIlZnY2ym7eDeiRKq6aHuPbc65+fOJe8QLtmzj7jKg3p3RK3H?=
 =?us-ascii?Q?6CAzrbn02VG8ai0UfruwsLN5fOAmMIio8bF5ve/aTsMU+cE58+CiFFo7GlKg?=
 =?us-ascii?Q?aVyAfYq06pYeKt0txhyYL7sOU0+S4ymhnuzKJPAUemDfdyfHlGW3new27jee?=
 =?us-ascii?Q?NcWVNDWNQ2dQzSkBH+U5NIW9HBIWXcut57yHrlSuzaljUA34a5Tadey++qKn?=
 =?us-ascii?Q?AbPdpY26/ZD3qxOiU09c1m7Z7Qomds1yOUtG5S/mGLU7XIIxr6iGRy8GedGS?=
 =?us-ascii?Q?y6isb5cWO25nHtBKvuj4t4jGKPKTYzZwoL6ZThQluMg/vr29NgFxkG82AaP2?=
 =?us-ascii?Q?DIr5cGOpOrFAE/f0aKfTcTBMigEi5iUYxSynn5EqCFpZoFHBTlvGyx6Q7+8X?=
 =?us-ascii?Q?FV/KLwai69LghdrD7Qy0hxBV02bZ4KBIBgyYm3X28bCt4xYOELe0uxGfIhjh?=
 =?us-ascii?Q?S4iEfriDP6uayik24bkTHk6VS9Rfze55MI1XTD1r2sRXiH0dvgniKDT1ovmf?=
 =?us-ascii?Q?14PXZYlWVdoM6zZd7y0/BuyFYeg3m2MlGtFsLT1px7ObmybQaL9/9O5a2iJd?=
 =?us-ascii?Q?eBTy8Fjf3wfpv2qOACKopvP2RrRoM1LGhfXcdwwkd5YnllLXJWY1PqlKFNDo?=
 =?us-ascii?Q?3aovAEOQEDELxYFd+GD1OsOvYdgonqJQJnmhFs8+r2OPmZc34OAMtfwTYWuD?=
 =?us-ascii?Q?zFXdruq0HhWf6yERVBq22pL/I/cUJ16RqBfsUvGFg5pmyQLGVXJjsHOulybo?=
 =?us-ascii?Q?KOX7KkjX+PsrpROF0ccDLzjmc2vXYRA/k11j87k3xm42j01LJdJMef0oNPNZ?=
 =?us-ascii?Q?7ai8hQEWZ6qc91UIEqbt8L9lbADMt2yz/rwg78rv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 09:07:29.0742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f49e25-172d-4d5e-c6ff-08de0fb81869
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF0316D269B
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=FangSheng.Huang@amd.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
QEMU will:

1. Set the RAM_SPM flag in the RAM block of the corresponding memory region
2. Update the overlapping E820 RAM entries before adding E820_SOFT_RESERVED
3. Set the E820 type to E820_SOFT_RESERVED for this memory region

This allows guest operating systems to recognize the memory as soft reserved
memory, which can be used for device-specific memory management without
E820 table conflicts.

Usage:
  -numa node,nodeid=0,memdev=m1,spm=on

Signed-off-by: fanhuang <FangSheng.Huang@amd.com>
---
 hw/core/numa.c               |  3 ++
 hw/i386/e820_memory_layout.c | 73 ++++++++++++++++++++++++++++++++++++
 hw/i386/e820_memory_layout.h |  2 +
 hw/i386/pc.c                 | 37 ++++++++++++++++++
 include/exec/cpu-common.h    |  1 +
 include/system/memory.h      |  3 ++
 include/system/numa.h        |  1 +
 qapi/machine.json            |  6 +++
 system/physmem.c             |  7 +++-
 9 files changed, 132 insertions(+), 1 deletion(-)

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
index bc048a6d13..3e50570484 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -26,6 +26,7 @@
 #include "qemu/units.h"
 #include "exec/target_page.h"
 #include "hw/i386/pc.h"
+#include "system/ramblock.h"
 #include "hw/char/serial-isa.h"
 #include "hw/char/parallel.h"
 #include "hw/hyperv/hv-balloon.h"
@@ -787,6 +788,41 @@ static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t pci_hole64_size)
     return pc_above_4g_end(pcms) - 1;
 }
 
+static int pc_update_spm_memory(RAMBlock *rb, void *opaque)
+{
+    X86MachineState *x86ms = opaque;
+    MachineState *ms = MACHINE(x86ms);
+    ram_addr_t offset;
+    ram_addr_t length;
+    bool is_spm = false;
+
+    /* Check if this RAM block belongs to a NUMA node with spm=on */
+    for (int i = 0; i < ms->numa_state->num_nodes; i++) {
+        NodeInfo *numa_info = &ms->numa_state->nodes[i];
+        if (numa_info->is_spm && numa_info->node_memdev) {
+            MemoryRegion *mr = &numa_info->node_memdev->mr;
+            if (mr->ram_block == rb) {
+                /* Mark this RAM block as SPM and set the flag */
+                rb->flags |= RAM_SPM;
+                is_spm = true;
+                break;
+            }
+        }
+    }
+
+    if (is_spm) {
+        offset = qemu_ram_get_offset(rb) +
+                 (0x100000000ULL - x86ms->below_4g_mem_size);
+        length = qemu_ram_get_used_length(rb);
+        if (!e820_update_entry_type(offset, length, E820_SOFT_RESERVED)) {
+            warn_report("Failed to update E820 entry for SPM at 0x%" PRIx64
+                        " length 0x%" PRIx64, offset, length);
+        }
+    }
+
+    return 0;
+}
+
 /*
  * AMD systems with an IOMMU have an additional hole close to the
  * 1Tb, which are special GPAs that cannot be DMA mapped. Depending
@@ -901,6 +937,7 @@ void pc_memory_init(PCMachineState *pcms,
     if (pcms->sgx_epc.size != 0) {
         e820_add_entry(pcms->sgx_epc.base, pcms->sgx_epc.size, E820_RESERVED);
     }
+    qemu_ram_foreach_block(pc_update_spm_memory, x86ms);
 
     if (!pcmc->has_reserved_memory &&
         (machine->ram_slots ||
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 9b658a3f48..9b437eaa10 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -89,6 +89,7 @@ ram_addr_t qemu_ram_get_fd_offset(RAMBlock *rb);
 ram_addr_t qemu_ram_get_used_length(RAMBlock *rb);
 ram_addr_t qemu_ram_get_max_length(RAMBlock *rb);
 bool qemu_ram_is_shared(RAMBlock *rb);
+bool qemu_ram_is_spm(RAMBlock *rb);
 bool qemu_ram_is_noreserve(RAMBlock *rb);
 bool qemu_ram_is_uf_zeroable(RAMBlock *rb);
 void qemu_ram_set_uf_zeroable(RAMBlock *rb);
diff --git a/include/system/memory.h b/include/system/memory.h
index aa85fc27a1..0d36cbd30d 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -275,6 +275,9 @@ typedef struct IOMMUTLBEvent {
  */
 #define RAM_PRIVATE (1 << 13)
 
+/* RAM is Specific Purpose Memory */
+#define RAM_SPM (1 << 14)
+
 static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
                                        IOMMUNotifierFlag flags,
                                        hwaddr start, hwaddr end,
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
index 038eab281c..1fa31b0224 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -500,6 +500,11 @@
 # @memdev: memory backend object.  If specified for one node, it must
 #     be specified for all nodes.
 #
+# @spm: if true, mark the memory region of this node as Specific
+#     Purpose Memory (SPM). This will set the RAM_SPM flag for the
+#     corresponding memory region and set the E820 type to
+#     E820_SOFT_RESERVED. (default: false, since 9.2)
+#
 # @initiator: defined in ACPI 6.3 Chapter 5.2.27.3 Table 5-145, points
 #     to the nodeid which has the memory controller responsible for
 #     this NUMA node.  This field provides additional information as
@@ -514,6 +519,7 @@
    '*cpus':   ['uint16'],
    '*mem':    'size',
    '*memdev': 'str',
+   '*spm':    'bool',
    '*initiator': 'uint16' }}
 
 ##
diff --git a/system/physmem.c b/system/physmem.c
index ae8ecd50ea..0090d9955d 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1611,6 +1611,11 @@ bool qemu_ram_is_noreserve(RAMBlock *rb)
     return rb->flags & RAM_NORESERVE;
 }
 
+bool qemu_ram_is_spm(RAMBlock *rb)
+{
+    return rb->flags & RAM_SPM;
+}
+
 /* Note: Only set at the start of postcopy */
 bool qemu_ram_is_uf_zeroable(RAMBlock *rb)
 {
@@ -2032,7 +2037,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
     ram_flags &= ~RAM_PRIVATE;
 
     /* Just support these ram flags by now. */
-    assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_NORESERVE |
+    assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_SPM | RAM_NORESERVE |
                           RAM_PROTECTED | RAM_NAMED_FILE | RAM_READONLY |
                           RAM_READONLY_FD | RAM_GUEST_MEMFD |
                           RAM_RESIZEABLE)) == 0);
-- 
2.34.1


