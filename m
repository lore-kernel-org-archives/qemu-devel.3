Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A1ACAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 13:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Pl4-0000t0-AC; Wed, 24 Sep 2025 09:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1v1MpP-00013z-R0
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 06:34:29 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1v1MpI-0006Mb-7i
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 06:34:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ii6PcAwbz8HSw2s1CjQdSSpODsEoK/ZyvbyNdFoNF0YCitAUASc8MpP8xus9kK8v+z5a0Lr/CeL3N93HRuw/4U4S6QEJuzIeeqvl5musvH/HYW3C//Wp4lSo91A1OFasIpPX8e2kqJqgxJruHjYN8GXntM9yy1HALsgi6R5DPrbcJNbfpX7jbmEJAvgEWsr2u+lRWTAk9bi144Nvuc4NrwGiDrLf4gW0lmoWrCKeUvxmZ00RVgK0wIxHzivr9jK5muOaau4UUaEO3ZETSbAO8aL+qFsyl9mPxyep7qAGnlRcK5Ac8lP8jaz67GB37fZDvR6w1ySjkpnOQ+DFbAtefg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+KynMslOKc6sJ02BFjG8GviStsYz9fIfFX9kkRMKrE=;
 b=sCNH3zv08UAekoWtxW9zCaiTneJZZapwGmb6ImlvNCe9zSlrzbyZqYVMfhqYRzjlwpUPRCcz07AT1xBVP6k63h5xrsI+vVsGgeUmXrVqmJZJsN3XFs/IGWAMaDuIYSHyaYvH74BLagL4pYpAlPCoKgEs09TFgEhTpcC7XICUP9NUvcsjgfMgV9QuJGKbBf0QaqFLsMUuD7BPEkYusVK5X8YDxRn/V4zrnXSB11JiwbnxAm7rktYYJAOidVuDOhOF0+p++Rb/tLXpBNzy0CVdMJmosViDfvGuZdtNjbCjpWk+OznlR4Pb0h476nXSniTw2dzjzZ+RlZZtwae1qDInPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+KynMslOKc6sJ02BFjG8GviStsYz9fIfFX9kkRMKrE=;
 b=i5MKTckIsXY5+Ffgmh+CQo0tL/0+IQ+2S4j872KYy65zGwpgayAtZEYatPNMkeLsagLSp9n9eZqYCK+4Xtj1n0+R6IqFS4BTlQyvRtMpMTBYH9PWFTFDepJ6BrU7iI8oam1n9VN5WJdnF3Fa1LGTSOMmCjvoaftT/I0LtAEHZnU=
Received: from BY3PR05CA0033.namprd05.prod.outlook.com (2603:10b6:a03:39b::8)
 by IA1PR12MB6188.namprd12.prod.outlook.com (2603:10b6:208:3e4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 10:34:10 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::5c) by BY3PR05CA0033.outlook.office365.com
 (2603:10b6:a03:39b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Wed,
 24 Sep 2025 10:34:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 10:34:09 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 24 Sep
 2025 03:34:07 -0700
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@redhat.com>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, <FangSheng.Huang@amd.com>
Subject: [PATCH] numa: add 'spm' option for special purpose memory
Date: Wed, 24 Sep 2025 18:33:24 +0800
Message-ID: <20250924103324.2074819-2-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250924103324.2074819-1-FangSheng.Huang@amd.com>
References: <20250924103324.2074819-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|IA1PR12MB6188:EE_
X-MS-Office365-Filtering-Correlation-Id: cce0c9e7-8b2b-46f4-c74f-08ddfb55e55a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y7KZ9BXNmcsOuQ6kzy2jXnJNk3ai+0Gv2eEzH/TBT8VQ72A6EGSnP45oPUtO?=
 =?us-ascii?Q?+G37sQ83uzvLYjllaKxzewXhA5FtZ33/RakcTKhQ3GtkrWmxbmoCyAbnuMNF?=
 =?us-ascii?Q?Um7E9nPTVgzTT6KbIaetV9zSZsKaJ4c3ZXXPbLvf3872kjHKcPaVi2BiFHsK?=
 =?us-ascii?Q?zJYxqkQm4JA8NHMoQMlcdZV2FfwzVsTtaRg8zvY8M7BG23vo5J7JyIkRTVNP?=
 =?us-ascii?Q?4BgCycfTuIzjWKJkxnxV3Nv3SMvnr8vPCPItgKVkRJrVocr9dmk6R7os1oE5?=
 =?us-ascii?Q?JEc6+dzMdwPID6I8BIWBa7Z/n7lCdpOhqPNODBXP2nmGjQuc9M4ycrvHCAJb?=
 =?us-ascii?Q?fMTqdhhQ8nJPZgL9p1kCmYnL1ZzGl2aea491SoduZgXTvvuBUPkeCj3wHXF8?=
 =?us-ascii?Q?qoqeSINgtHRQ8d6N0MTaCXALPK5H5MyQSjPgfvG1L+V+c0oMwLmZZI3xpf96?=
 =?us-ascii?Q?IKNhLSx+YeQojp1eRd7IGgKcfXQqd0oscXOzg6L/X1c/D76c12NPrpNNeB6l?=
 =?us-ascii?Q?ylv8WYmx9EO4lgcfSdEnIq4wdaWKysi8MTcMHnOOqwdguuFNUWCvt6nVptjF?=
 =?us-ascii?Q?GFZnjtBVhzNjsXdjun7ntNewPVwPerl8dXZSGPPE5jtY1kQRqq26K0A6364i?=
 =?us-ascii?Q?jbEXxnjlqrYTFCdWFCgmwVPWW+eOu7BfY++f7aCbwug3CsdrFLs7Ou8UQzHR?=
 =?us-ascii?Q?TnRIN8RAEKdS0r/F7CH9Hk45U79HxbDSHiXHSXXUHUqUqy4QKWFcXs90VY/F?=
 =?us-ascii?Q?eFRXzR1rAQWe7/xbOIRYiW7/5mlB2EIm5I3zefejIgZnhjLa1eQTEa8El/sS?=
 =?us-ascii?Q?VVlHLEho7NN4xwZkuMAgwDzVuTQ8Yl7P8cEahtg+S+FP6qG0Wd0RWE6ADQE6?=
 =?us-ascii?Q?iMTmSQtJkHshCpJv+LDQOvuGIOxd9373V9IcYPdAiSST4LXrHirDHEYbxzmK?=
 =?us-ascii?Q?yReGgoXV+b6Mab/TbzyTZZUW2hu60h7e5PaUqRLzxW4EKV7zK7NHKkQktSwi?=
 =?us-ascii?Q?DDAWGM3S03cob57VGCmENinJIjNJn4WnZR4V8VD4KmmHBgQ614iP1h9smQrt?=
 =?us-ascii?Q?PaK21DajJF1NeCZjmk0BaLn8aH9V3DWvV4kI8/VvWwt29HvFjWlUzfI7+k3X?=
 =?us-ascii?Q?z9nWAe1eh2DXJwk8EaFNJalkRjn1pud1UIxNCKjyeO0rjpcWhSTmnJQLAY88?=
 =?us-ascii?Q?quB1qdtt81oSOfwYTez37dbC3aF1Wq1ICnl0RzOjwdb3H2ATEqcKRm6XCSIt?=
 =?us-ascii?Q?bMOaZwjfNCYSwbnYuNIK13EWi/ZDwi5h/l1nP9qvprh9GiKRadJUb2ch9C4o?=
 =?us-ascii?Q?IPC5lu6SaDmn4W7bAElJ2GMqhYFD6GBydvDB5Mxb9s3JNcyPfQ1cNOUWhxoh?=
 =?us-ascii?Q?HzFrotWDyuiNiPrHM7rRiBhvb12VV8ZGuAgsFrWtEZ0MyyJYXGzqYzU4TSPs?=
 =?us-ascii?Q?OQY85PioEaCtzkfVt7BWABsjOL/reVzHJ28CJk/aO4tykcQS746vJVKPllXJ?=
 =?us-ascii?Q?uQNQRRy/2dpq2pRzlblJ9koQzzREAi0pn9Vg5dp+adQv7we5FI+1u0QtBw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 10:34:09.3869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cce0c9e7-8b2b-46f4-c74f-08ddfb55e55a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6188
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=FangSheng.Huang@amd.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 24 Sep 2025 09:42:06 -0400
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

This patch adds support for special purpose memory (SPM) through the
NUMA node configuration. When 'spm=on' is specified for a NUMA node,
QEMU will:

1. Set the RAM_SPM flag in the RAM block of the corresponding memory region
2. Set the E820 type to E820_SOFT_RESERVED for this memory region

This allows guest operating systems to recognize the memory as soft reserved
memory, which can be used for heterogeneous memory management or other
special purposes.

Usage:
  -numa node,nodeid=0,memdev=m1,spm=on
Signed-off-by: fanhuang <FangSheng.Huang@amd.com>
---
 hw/core/numa.c               |  3 +++
 hw/i386/e820_memory_layout.h |  1 +
 hw/i386/pc.c                 | 34 ++++++++++++++++++++++++++++++++++
 include/exec/cpu-common.h    |  1 +
 include/system/memory.h      |  3 +++
 include/system/numa.h        |  1 +
 qapi/machine.json            |  6 ++++++
 system/physmem.c             |  7 ++++++-
 8 files changed, 55 insertions(+), 1 deletion(-)

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
diff --git a/hw/i386/e820_memory_layout.h b/hw/i386/e820_memory_layout.h
index b50acfa201..8af6a9cfac 100644
--- a/hw/i386/e820_memory_layout.h
+++ b/hw/i386/e820_memory_layout.h
@@ -15,6 +15,7 @@
 #define E820_ACPI       3
 #define E820_NVS        4
 #define E820_UNUSABLE   5
+#define E820_SOFT_RESERVED  0xEFFFFFFF
 
 struct e820_entry {
     uint64_t address;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index bc048a6d13..10ecd25728 100644
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
@@ -787,6 +788,38 @@ static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t pci_hole64_size)
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
+        e820_add_entry(offset, length, E820_SOFT_RESERVED);
+    }
+
+    return 0;
+}
+
 /*
  * AMD systems with an IOMMU have an additional hole close to the
  * 1Tb, which are special GPAs that cannot be DMA mapped. Depending
@@ -901,6 +934,7 @@ void pc_memory_init(PCMachineState *pcms,
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
index aa85fc27a1..520dda969e 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -275,6 +275,9 @@ typedef struct IOMMUTLBEvent {
  */
 #define RAM_PRIVATE (1 << 13)
 
+/* RAM is special purpose memory */
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
index 038eab281c..1a513b38cf 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -500,6 +500,11 @@
 # @memdev: memory backend object.  If specified for one node, it must
 #     be specified for all nodes.
 #
+# @spm: if true, mark the memory region of this node as special
+#     purpose memory (SPM). This will set the RAM_SPM flag for the
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


