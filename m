Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7FDCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 07:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS8za-0000O2-DK; Wed, 27 May 2026 03:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wS8zY-0000NX-D2
 for qemu-devel@nongnu.org; Wed, 27 May 2026 03:47:52 -0400
Received: from mail-westus3azon11012020.outbound.protection.outlook.com
 ([40.107.209.20] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wS8zT-0005hy-Nj
 for qemu-devel@nongnu.org; Wed, 27 May 2026 03:47:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oOH/zC0oyRW0mgN0YuqcPNCu+iTsTt/9w9z9fyfbkG6SVN5W9mSqWvubOFujfoFFhLiUd0bhQ6w40f58M4agu6aQDY52zePId5GGHfZDyhrsAyCLXBjv3PS8xsP5QHefXwgUaiegf5igZatcCFgy952buV3UZOhiMeomIFX6xuB3aMuL9bEGitGm5qdnzHkWKP9Busk2ZUSUHnfctKt6u4knFG8tdaZoTFHmSbpFAY7wKgEwr1V92Urr5ulue+cvGf/INOtWUr+szGQ0oG8/X0m13y+0ULFFwjJJiE+J1d348UlA6pcW0rT5A2jidjwG51TSLy0Ogq2hNxWvfrF32Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaBpYnXJ7xLt/uYOvtCU0uEe6H4MYtkCMjsEAuaqfTU=;
 b=OK2FCRabIUPghRnudsrc8ZtiPfbntaUE5BZySqgJWEfS+m8wZM8gm6s4hdD6KizZAeHYz2yytzL6wUh5BuaEQdBjEmhouawEabdG6VKBs1HDM/886BL0sRM/Z4TncMObsZYgap0v4gFzh0e2siF9qTo/l+7W+RC00JejbPUOPg5y5EVm9yUemQjhSeZvWgT4aBcRr9R/uoEJlnVLuJY18NC2J/w3KiEsJUQlFKd9AN2F1EdmECQyaFrce7Oh8wk7eK9jqdkGeJvohF8UEjegBDexwXDQS0hKxMvOzSzjMhuwDsDZKjxI9lCAlbYz8Hd4+TkEjnEhpMWdWk1Q5+wQsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaBpYnXJ7xLt/uYOvtCU0uEe6H4MYtkCMjsEAuaqfTU=;
 b=n+XSSzTsQSXW4yY+hl40g6HG5GFTFjPmYZfwwXq66Q8VGxP3mCZ43Z/78DqJ8wUPBy6ECPN5bSf3UPcrpwE/jIzRwGgvBm+H0lEFQgKoFET1YxmLMmbOdGGg2uVoB8YkKrW4SMSwLyQY2rZCHdn/R5hsb1opozSJd+70Da1/RAQ=
Received: from BL1PR13CA0098.namprd13.prod.outlook.com (2603:10b6:208:2b9::13)
 by SJ5PPFCD5E2E1DE.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Wed, 27 May
 2026 07:42:39 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::40) by BL1PR13CA0098.outlook.office365.com
 (2603:10b6:208:2b9::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.3 via Frontend Transport; Wed, 27
 May 2026 07:42:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 07:42:38 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 02:42:35 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <imammedo@redhat.com>, <david@kernel.org>,
 <gourry@gourry.net>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH v8 1/1] hw/mem: add spm-memory device for Specific Purpose
 Memory
Date: Wed, 27 May 2026 15:42:15 +0800
Message-ID: <20260527074215.229119-2-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527074215.229119-1-FangSheng.Huang@amd.com>
References: <20260527074215.229119-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|SJ5PPFCD5E2E1DE:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec60587-1cbe-40bd-8cd2-08debbc386a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|11063799006|56012099006|3023799007|6133799003|22082099003|18002099003|43062017;
X-Microsoft-Antispam-Message-Info: qwk39FliRoj+7j58roXBpEZ5EjhbNmYi+U43PCgOnm1MDPkzJG/kOD0ONABT1tAM5DpVhN3OisUyX3N+C5C61t8XrUkZSWz4pKOwoT5a/3zJQNhPwusMyrLLZUlccVnwLK8rIToUzlNVbDNsw1xlDVdwrN47z70KdzmKLdiyjIhiNmPRJShWIkRJUFW8VTN0wp+LlINZyLLuAMtYU4QT8dTMDTkna/oF7APVWx/rf0jtdma2D0tMmsAA4KMML1y4pIgYckVw2/MWQ3vZrwLy4KkrD1AVMEe0a0bnoPC8BOcNvQRk/0X7i7I8JRNxEzvy+1SPrq7PEnQMgFfZbouUTVmQdC0cM7YFdzYOWdceynuLM1lCA29AwmkChC+xxaI0yoGq/iP+5dR3gU3wbo8I5BunT3mRj35hi+8PxYOweM83jtvFJDVwlJL5cW9IEXoXCpVfzCNI/7fbikuWei9lgQTiTSONq4WMWpz1OpV5FEW40iEZqEvOpc6YkHoUjKBEgvNdSnAxBdNHM5rDhXMjKiSWoeNS6ePoh685r3320zUlguHmZF2R1ScNoSGvRK2c6XAHAO3fxDqtQFXTNKKxl/rF+ABT2IZalDPzzjDvxh1ny/rGfJpE7g9s0jWyHycttCFzzaGCPq1dSNnhGxh1poECO1dKMvtDds+S9UQXDw2fLK5uLbr6TMeKw/gAKrWwQiQlvH1n0KeWftm4cd++uKh+sEqQsM2mb18njKQgN9MmbzfJDSpXygMocBzTUkGBb2A8XECzGwz9t1SVTR07iHd6/7OsnZDNOgB1JVwRyWQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(11063799006)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FIYM+/qx2bMezwA/DAhxmVatX4olqBjoHUf7v+/OrncrcopXELHF07Wv79jxZdEBUAfRUVlxBHBVdRTnxb8rov2Yv+92ct4iGpa62DqUkRm4craWBz9w233J/p4x2YD/MYZw86nTfcK78jrnlb7PI2gtjcbUr3sTifqk2p/5mME0sXNlnYYwIYZ07h1QVfFMf6lYb43tBSE5jokqppyj4Mw0LmVwtCAgaP8M0515V4jypjRAp2htKJOKHylep7UbXXA5js341JiTmlRwM0dgRSGH2N/bdm/bplo4TufUhuhVu+qmU9V4YFyAHohbMB+VKa9sF+XWRxb+4xy6U+TzYP6qGGappV1NcI1xHD9O7sSzgchrkxOesGbl2a4In8HObOpikR72auuuWnR0yoBg0Z4rJFRy9jllU8i8k3GlEefwUnI6819sYJjF7JRwG2Ib
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 07:42:38.5030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec60587-1cbe-40bd-8cd2-08debbc386a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCD5E2E1DE
Received-SPF: permerror client-ip=40.107.209.20;
 envelope-from=FangSheng.Huang@amd.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Introduce a TYPE_MEMORY_DEVICE subclass `spm-memory` for boot-time
SOFT_RESERVED memory exposed to the guest with a per-device NUMA
proximity domain.

The device targets accelerator memory (HBM and similar) that the
firmware hands to the guest OS as SOFT_RESERVED memory, so a driver
in the guest -- rather than the kernel's general allocator -- owns
the range.  Per-device NUMA placement matches the natural shape of
multiple HBM blocks (one block == one driver claim == one PXM).

Usage:

    -object memory-backend-ram,id=spm0,size=8G
    -numa node,nodeid=N
    -device spm-memory,id=dev0,memdev=spm0,node=N[,addr=GPA]

The device:

- inherits TYPE_DEVICE and implements TYPE_MEMORY_DEVICE; placement
  in machine->device_memory goes through the standard memory-device
  framework (memory_device_pre_plug + memory_device_plug)
- is boot-time only: dc->hotpluggable = false, and realize rejects
  attempts past PHASE_MACHINE_READY
- emits one E820 SOFT_RESERVED entry per instance at machine_done
- emits one SRAT memory_affinity entry per instance at acpi-build,
  ENABLED-only (no HOTPLUGGABLE flag)
- rejects mixed-memory configurations on the target NUMA node at
  realize-time
- is reported by QMP query-memory-devices as a dedicated kind,
  MEMORY_DEVICE_INFO_KIND_SPM_MEMORY

The device_memory SRAT umbrella entry in hw/i386/acpi-build.c is
restructured to partition the region into per-kind chunks rather
than emitting a single HOTPLUGGABLE entry covering everything.
For each plugged TYPE_SPM_MEMORY device the partition emits an
ENABLED entry at the device's proximity_domain; the remaining
sub-ranges (gaps between SPM devices, leading and trailing
padding, and ranges occupied by non-SPM memory devices) are
emitted as HOTPLUGGABLE | ENABLED entries at the placeholder
PXM (nb_numa_nodes - 1), preserving the upstream convention.

E820_SOFT_RESERVED is added to hw/i386/e820_memory_layout.h
alongside the other type codes.

CONFIG_SPM_MEMORY is selected by the i386 PC and Q35 machines
(same as DIMM).

MAINTAINERS gets new file entries under the existing "Memory devices"
stanza.

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
---
 MAINTAINERS                  |   2 +
 hw/i386/Kconfig              |   2 +
 hw/i386/acpi-build.c         | 105 ++++++++++++--
 hw/i386/e820_memory_layout.h |  11 +-
 hw/mem/Kconfig               |   4 +
 hw/mem/meson.build           |   1 +
 hw/mem/spm-memory.c          | 269 +++++++++++++++++++++++++++++++++++
 include/hw/mem/spm-memory.h  |  43 ++++++
 qapi/machine.json            |  43 +++++-
 9 files changed, 459 insertions(+), 21 deletions(-)
 create mode 100644 hw/mem/spm-memory.c
 create mode 100644 include/hw/mem/spm-memory.h

diff --git a/MAINTAINERS b/MAINTAINERS
index cd5c4831e2..2a06515fc8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3361,9 +3361,11 @@ S: Supported
 F: hw/mem/memory-device*.c
 F: hw/mem/nvdimm.c
 F: hw/mem/pc-dimm.c
+F: hw/mem/spm-memory.c
 F: include/hw/mem/memory-device.h
 F: include/hw/mem/nvdimm.h
 F: include/hw/mem/pc-dimm.h
+F: include/hw/mem/spm-memory.h
 F: docs/nvdimm.txt
 
 SPICE
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 12473acaa7..e31a25b634 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -84,6 +84,7 @@ config I440FX
     select PCI_I440FX
     select PIIX
     select DIMM
+    select SPM_MEMORY
     select SMBIOS
     select SMBIOS_LEGACY
     select FW_CFG_DMA
@@ -113,6 +114,7 @@ config Q35
     select LPC_ICH9
     select AHCI_ICH9
     select DIMM
+    select SPM_MEMORY
     select SMBIOS
     select FW_CFG_DMA
 
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 0d7c83d5e9..865ab5fa4f 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -52,6 +52,7 @@
 #include "migration/vmstate.h"
 #include "hw/mem/memory-device.h"
 #include "hw/mem/nvdimm.h"
+#include "hw/mem/spm-memory.h"
 #include "system/numa.h"
 #include "system/reset.h"
 #include "hw/hyperv/vmbus-bridge.h"
@@ -1346,6 +1347,95 @@ build_tpm_tcpa(GArray *table_data, BIOSLinker *linker, GArray *tcpalog,
 }
 #endif
 
+typedef struct {
+    uint64_t addr;
+    uint64_t size;
+    uint32_t node;
+} SpmRange;
+
+static int collect_spm_ranges_cb(Object *obj, void *opaque)
+{
+    GArray *ranges = opaque;
+    SpmMemoryDevice *spm;
+    MemoryDeviceClass *mdc;
+    SpmRange r;
+
+    if (!object_dynamic_cast(obj, TYPE_SPM_MEMORY)) {
+        return 0;
+    }
+    spm = SPM_MEMORY(obj);
+    mdc = MEMORY_DEVICE_GET_CLASS(MEMORY_DEVICE(spm));
+    r.addr = mdc->get_addr(MEMORY_DEVICE(spm));
+    r.size = memory_region_size(
+                 host_memory_backend_get_memory(spm->hostmem));
+    r.node = spm->node;
+    g_array_append_val(ranges, r);
+    return 0;
+}
+
+static gint spm_range_compare(gconstpointer a, gconstpointer b)
+{
+    const SpmRange *range_a = a;
+    const SpmRange *range_b = b;
+
+    if (range_a->addr < range_b->addr) {
+        return -1;
+    }
+    if (range_a->addr > range_b->addr) {
+        return 1;
+    }
+    return 0;
+}
+
+/*
+ * Emit SRAT memory-affinity entries covering the device_memory region:
+ *   - ENABLED entry at the device's proximity_domain for each plugged
+ *     TYPE_SPM_MEMORY instance.
+ *   - HOTPLUGGABLE | ENABLED entry with PXM = nb_numa_nodes - 1 for
+ *     every remaining sub-range (gaps, leading/trailing padding, and
+ *     ranges occupied by non-SPM memory devices).
+ */
+static void build_srat_device_memory(GArray *table_data, MachineState *ms)
+{
+    g_autoptr(GArray) ranges = g_array_new(FALSE, TRUE, sizeof(SpmRange));
+    uint64_t cursor, end;
+    int nb_nodes = ms->numa_state ? ms->numa_state->num_nodes : 0;
+    uint32_t hotplug_pxm = nb_nodes > 0 ? nb_nodes - 1 : 0;
+    guint i;
+
+    if (!ms->device_memory) {
+        return;
+    }
+
+    cursor = ms->device_memory->base;
+    end = cursor + memory_region_size(&ms->device_memory->mr);
+
+    object_child_foreach_recursive(qdev_get_machine(),
+                                   collect_spm_ranges_cb, ranges);
+    g_array_sort(ranges, spm_range_compare);
+
+    for (i = 0; i < ranges->len; i++) {
+        SpmRange *r = &g_array_index(ranges, SpmRange, i);
+
+        if (cursor < r->addr) {
+            build_srat_memory(table_data, cursor, r->addr - cursor,
+                              hotplug_pxm,
+                              MEM_AFFINITY_HOTPLUGGABLE |
+                              MEM_AFFINITY_ENABLED);
+        }
+        build_srat_memory(table_data, r->addr, r->size, r->node,
+                          MEM_AFFINITY_ENABLED);
+        cursor = r->addr + r->size;
+    }
+
+    if (cursor < end) {
+        build_srat_memory(table_data, cursor, end - cursor,
+                          hotplug_pxm,
+                          MEM_AFFINITY_HOTPLUGGABLE |
+                          MEM_AFFINITY_ENABLED);
+    }
+}
+
 #define HOLE_640K_START  (640 * KiB)
 #define HOLE_640K_END   (1 * MiB)
 
@@ -1473,20 +1563,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
 
     build_srat_generic_affinity_structures(table_data);
 
-    /*
-     * Entry is required for Windows to enable memory hotplug in OS
-     * and for Linux to enable SWIOTLB when booted with less than
-     * 4G of RAM. Windows works better if the entry sets proximity
-     * to the highest NUMA node in the machine.
-     * Memory devices may override proximity set by this entry,
-     * providing _PXM method if necessary.
-     */
-    if (machine->device_memory) {
-        build_srat_memory(table_data, machine->device_memory->base,
-                          memory_region_size(&machine->device_memory->mr),
-                          nb_numa_nodes - 1,
-                          MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
-    }
+    build_srat_device_memory(table_data, machine);
 
     acpi_table_end(linker, &table);
 }
diff --git a/hw/i386/e820_memory_layout.h b/hw/i386/e820_memory_layout.h
index b50acfa201..6ef169db9c 100644
--- a/hw/i386/e820_memory_layout.h
+++ b/hw/i386/e820_memory_layout.h
@@ -10,11 +10,12 @@
 #define HW_I386_E820_MEMORY_LAYOUT_H
 
 /* e820 types */
-#define E820_RAM        1
-#define E820_RESERVED   2
-#define E820_ACPI       3
-#define E820_NVS        4
-#define E820_UNUSABLE   5
+#define E820_RAM           1
+#define E820_RESERVED      2
+#define E820_ACPI          3
+#define E820_NVS           4
+#define E820_UNUSABLE      5
+#define E820_SOFT_RESERVED 0xefffffff
 
 struct e820_entry {
     uint64_t address;
diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
index 73c5ae8ad9..4145870881 100644
--- a/hw/mem/Kconfig
+++ b/hw/mem/Kconfig
@@ -16,3 +16,7 @@ config CXL_MEM_DEVICE
     bool
     default y if CXL
     select MEM_DEVICE
+
+config SPM_MEMORY
+    bool
+    select MEM_DEVICE
diff --git a/hw/mem/meson.build b/hw/mem/meson.build
index 8c2beeb7d4..2c28104282 100644
--- a/hw/mem/meson.build
+++ b/hw/mem/meson.build
@@ -4,6 +4,7 @@ mem_ss.add(when: 'CONFIG_DIMM', if_true: files('pc-dimm.c'))
 mem_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_mc.c'))
 mem_ss.add(when: 'CONFIG_NVDIMM', if_true: files('nvdimm.c'))
 mem_ss.add(when: 'CONFIG_CXL_MEM_DEVICE', if_true: files('cxl_type3.c'))
+mem_ss.add(when: 'CONFIG_SPM_MEMORY', if_true: files('spm-memory.c'))
 stub_ss.add(files('cxl_type3_stubs.c'))
 
 stub_ss.add(files('memory-device-stubs.c'))
diff --git a/hw/mem/spm-memory.c b/hw/mem/spm-memory.c
new file mode 100644
index 0000000000..85887b2479
--- /dev/null
+++ b/hw/mem/spm-memory.c
@@ -0,0 +1,269 @@
+/*
+ * Specific Purpose Memory (SPM) device
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
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "hw/core/boards.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/qdev.h"
+#include "hw/mem/spm-memory.h"
+#include "hw/mem/memory-device.h"
+#include "hw/i386/e820_memory_layout.h"
+#include "migration/vmstate.h"
+#include "system/hostmem.h"
+#include "system/numa.h"
+#include "system/system.h"
+
+static QLIST_HEAD(, SpmMemoryDevice) spm_memory_list =
+    QLIST_HEAD_INITIALIZER(spm_memory_list);
+static Notifier spm_machine_done_notifier;
+static bool spm_machine_done_registered;
+
+#define SPM_MEMORY_MEMDEV_PROP    "memdev"
+#define SPM_MEMORY_NODE_PROP      "node"
+#define SPM_MEMORY_ADDR_PROP      "addr"
+
+static const Property spm_memory_properties[] = {
+    DEFINE_PROP_LINK(SPM_MEMORY_MEMDEV_PROP, SpmMemoryDevice, hostmem,
+                     TYPE_MEMORY_BACKEND, HostMemoryBackend *),
+    DEFINE_PROP_UINT32(SPM_MEMORY_NODE_PROP, SpmMemoryDevice, node, 0),
+    DEFINE_PROP_UINT64(SPM_MEMORY_ADDR_PROP, SpmMemoryDevice, addr, 0),
+};
+
+static uint64_t spm_memory_md_get_addr(const MemoryDeviceState *md)
+{
+    return SPM_MEMORY(md)->addr;
+}
+
+static void spm_memory_md_set_addr(MemoryDeviceState *md, uint64_t addr,
+                                   Error **errp)
+{
+    SPM_MEMORY(md)->addr = addr;
+}
+
+static MemoryRegion *spm_memory_md_get_memory_region(MemoryDeviceState *md,
+                                                    Error **errp)
+{
+    SpmMemoryDevice *spm = SPM_MEMORY(md);
+
+    if (!spm->hostmem) {
+        error_setg(errp, "'memdev' property must be set");
+        return NULL;
+    }
+    return host_memory_backend_get_memory(spm->hostmem);
+}
+
+static uint64_t spm_memory_md_get_plugged_size(const MemoryDeviceState *md,
+                                               Error **errp)
+{
+    SpmMemoryDevice *spm = SPM_MEMORY(md);
+    return spm->hostmem ?
+        memory_region_size(host_memory_backend_get_memory(spm->hostmem)) : 0;
+}
+
+static void spm_memory_md_fill_device_info(const MemoryDeviceState *md,
+                                           MemoryDeviceInfo *info)
+{
+    SpmMemoryDeviceInfo *di = g_new0(SpmMemoryDeviceInfo, 1);
+    SpmMemoryDevice *spm = SPM_MEMORY(md);
+    DeviceState *dev = DEVICE(md);
+
+    di->id = dev->id ? g_strdup(dev->id) : NULL;
+    di->memaddr = spm->addr;
+    di->size = spm->hostmem ? memory_region_size(
+                   host_memory_backend_get_memory(spm->hostmem)) : 0;
+    di->node = spm->node;
+    di->memdev = spm->hostmem ?
+                 object_get_canonical_path(OBJECT(spm->hostmem)) : NULL;
+
+    info->u.spm_memory.data = di;
+    info->type = MEMORY_DEVICE_INFO_KIND_SPM_MEMORY;
+}
+
+typedef struct {
+    uint32_t node_id;
+    const SpmMemoryDevice *self;  /* exclude self when walking */
+    bool conflict;
+} SpmNodeCheckCtx;
+
+static int spm_check_node_collision_cb(Object *obj, void *opaque)
+{
+    SpmNodeCheckCtx *ctx = opaque;
+    uint32_t other_node;
+
+    if (!object_dynamic_cast(obj, TYPE_MEMORY_DEVICE)) {
+        return 0;
+    }
+    /*
+     * Skip self.  Compare canonical Object* pointers, not interface-cast
+     * MemoryDeviceState* (different address under INTERFACE_CHECK).
+     */
+    if (obj == OBJECT(ctx->self)) {
+        return 0;
+    }
+
+    /*
+     * Not all memory-device subclasses have a "node" property; skip
+     * those silently rather than asserting.
+     */
+    if (!object_property_find(obj, "node")) {
+        return 0;
+    }
+    other_node = (uint32_t)object_property_get_uint(obj, "node", NULL);
+    if (other_node == ctx->node_id) {
+        ctx->conflict = true;
+        return 1; /* stop walk */
+    }
+    return 0;
+}
+
+/*
+ * Require the target NUMA node to be SPM-only: driver-side discovery
+ * uses proximity_domain as the key, so a node mixing SPM with other
+ * memory yields ambiguous discovery.
+ */
+static void spm_memory_check_node_exclusive(SpmMemoryDevice *spm,
+                                            MachineState *ms, Error **errp)
+{
+    ERRP_GUARD();
+    SpmNodeCheckCtx ctx = { spm->node, spm, false };
+
+    /* Bounds check: spm->node must be a valid NUMA node id */
+    if (!ms->numa_state || spm->node >= ms->numa_state->num_nodes) {
+        error_setg(errp,
+                   "spm-memory: node %u out of range "
+                   "(numa_state has %d nodes)", spm->node,
+                   ms->numa_state ? ms->numa_state->num_nodes : 0);
+        return;
+    }
+
+    /* Check 1: target node must not have memory from -numa node,memdev= */
+    if (ms->numa_state->nodes[spm->node].node_mem > 0) {
+        error_setg(errp,
+                   "spm-memory: NUMA node %u already has memory attached "
+                   "via -numa node,memdev=; SPM nodes must be SPM-only",
+                   spm->node);
+        return;
+    }
+
+    /* Check 2: target node must not already have another memory device */
+    object_child_foreach_recursive(qdev_get_machine(),
+                                   spm_check_node_collision_cb, &ctx);
+    if (ctx.conflict) {
+        error_setg(errp,
+                   "spm-memory: NUMA node %u already has another memory "
+                   "device plugged; SPM nodes must be SPM-only", spm->node);
+        return;
+    }
+}
+
+static void spm_memory_machine_done(Notifier *n, void *opaque)
+{
+    SpmMemoryDevice *spm;
+    MemoryDeviceClass *mdc;
+    uint64_t addr, size;
+
+    QLIST_FOREACH(spm, &spm_memory_list, next) {
+        g_assert(spm->hostmem);
+        mdc = MEMORY_DEVICE_GET_CLASS(MEMORY_DEVICE(spm));
+        addr = mdc->get_addr(MEMORY_DEVICE(spm));
+        size = memory_region_size(
+                   host_memory_backend_get_memory(spm->hostmem));
+        e820_add_entry(addr, size, E820_SOFT_RESERVED);
+    }
+}
+
+static void spm_memory_realize(DeviceState *dev, Error **errp)
+{
+    ERRP_GUARD();
+    SpmMemoryDevice *spm = SPM_MEMORY(dev);
+    MachineState *ms = MACHINE(qdev_get_machine());
+
+    if (phase_check(PHASE_MACHINE_READY)) {
+        error_setg(errp, "spm-memory: hotplug is not supported "
+                         "(boot-time-only device)");
+        return;
+    }
+
+    if (!spm->hostmem) {
+        error_setg(errp, "'%s' property is required", SPM_MEMORY_MEMDEV_PROP);
+        return;
+    }
+    if (host_memory_backend_is_mapped(spm->hostmem)) {
+        error_setg(errp, "memory backend '%s' is already in use",
+                   object_get_canonical_path_component(OBJECT(spm->hostmem)));
+        return;
+    }
+
+    spm_memory_check_node_exclusive(spm, ms, errp);
+    if (*errp) {
+        return;
+    }
+
+    memory_device_pre_plug(MEMORY_DEVICE(spm), ms, errp);
+    if (*errp) {
+        return;
+    }
+
+    host_memory_backend_set_mapped(spm->hostmem, true);
+    memory_device_plug(MEMORY_DEVICE(spm), ms);
+
+    QLIST_INSERT_HEAD(&spm_memory_list, spm, next);
+
+    if (!spm_machine_done_registered) {
+        spm_machine_done_notifier.notify = spm_memory_machine_done;
+        qemu_add_machine_init_done_notifier(&spm_machine_done_notifier);
+        spm_machine_done_registered = true;
+    }
+}
+
+static const VMStateDescription vmstate_spm_memory = {
+    .name = TYPE_SPM_MEMORY,
+    .unmigratable = 1,
+};
+
+static void spm_memory_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    MemoryDeviceClass *mdc = MEMORY_DEVICE_CLASS(oc);
+
+    dc->desc = "SPM (Specific Purpose Memory) device";
+    dc->hotpluggable = false;
+    dc->realize = spm_memory_realize;
+    dc->vmsd = &vmstate_spm_memory;
+    device_class_set_props(dc, spm_memory_properties);
+
+    mdc->get_addr            = spm_memory_md_get_addr;
+    mdc->set_addr            = spm_memory_md_set_addr;
+    mdc->get_memory_region   = spm_memory_md_get_memory_region;
+    mdc->get_plugged_size    = spm_memory_md_get_plugged_size;
+    mdc->fill_device_info    = spm_memory_md_fill_device_info;
+}
+
+static const TypeInfo spm_memory_info = {
+    .name          = TYPE_SPM_MEMORY,
+    .parent        = TYPE_DEVICE,
+    .class_size    = sizeof(SpmMemoryDeviceClass),
+    .class_init    = spm_memory_class_init,
+    .instance_size = sizeof(SpmMemoryDevice),
+    .interfaces    = (InterfaceInfo[]) {
+        { TYPE_MEMORY_DEVICE },
+        { }
+    },
+};
+
+static void spm_memory_register_types(void)
+{
+    type_register_static(&spm_memory_info);
+}
+
+type_init(spm_memory_register_types)
diff --git a/include/hw/mem/spm-memory.h b/include/hw/mem/spm-memory.h
new file mode 100644
index 0000000000..c662864b29
--- /dev/null
+++ b/include/hw/mem/spm-memory.h
@@ -0,0 +1,43 @@
+/*
+ * Specific Purpose Memory (SPM) device
+ *
+ * TYPE_MEMORY_DEVICE subclass for boot-time-only memory exposed to the
+ * guest as an E820 SOFT_RESERVED range with a SRAT memory-affinity entry.
+ *
+ * Copyright (c) 2026 Advanced Micro Devices, Inc.
+ *
+ * Authors:
+ *  FangSheng Huang <FangSheng.Huang@amd.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_SPM_MEMORY_H
+#define QEMU_SPM_MEMORY_H
+
+#include "hw/mem/memory-device.h"
+#include "hw/core/qdev.h"
+#include "qom/object.h"
+#include "system/hostmem.h"
+
+#define TYPE_SPM_MEMORY "spm-memory"
+
+OBJECT_DECLARE_TYPE(SpmMemoryDevice, SpmMemoryDeviceClass, SPM_MEMORY)
+
+struct SpmMemoryDevice {
+    /*< private >*/
+    DeviceState parent_obj;
+    QLIST_ENTRY(SpmMemoryDevice) next;
+
+    /*< public >*/
+    HostMemoryBackend *hostmem;    /* memdev= backend */
+    uint32_t node;                 /* NUMA proximity domain (node=) */
+    uint64_t addr;                 /* GPA (from addr= or framework-assigned) */
+};
+
+struct SpmMemoryDeviceClass {
+    /*< private >*/
+    DeviceClass parent_class;
+};
+
+#endif /* QEMU_SPM_MEMORY_H */
diff --git a/qapi/machine.json b/qapi/machine.json
index 685e4e29b8..51b06d7cba 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1413,6 +1413,32 @@
           }
 }
 
+##
+# @SpmMemoryDeviceInfo:
+#
+# spm-memory device state information
+#
+# @id: device's ID
+#
+# @memaddr: physical address in memory, where device is mapped
+#
+# @size: size of memory that the device provides
+#
+# @node: NUMA proximity domain to which the device is assigned
+#
+# @memdev: memory backend linked with device
+#
+# Since: 11.1
+##
+{ 'struct': 'SpmMemoryDeviceInfo',
+  'data': { '*id': 'str',
+            'memaddr': 'size',
+            'size': 'size',
+            'node': 'int',
+            'memdev': 'str'
+          }
+}
+
 ##
 # @MemoryDeviceInfoKind:
 #
@@ -1426,11 +1452,13 @@
 #
 # @hv-balloon: since 8.2.
 #
+# @spm-memory: since 11.1.
+#
 # Since: 2.1
 ##
 { 'enum': 'MemoryDeviceInfoKind',
   'data': [ 'dimm', 'nvdimm', 'virtio-pmem', 'virtio-mem', 'sgx-epc',
-            'hv-balloon' ] }
+            'hv-balloon', 'spm-memory' ] }
 
 ##
 # @PCDIMMDeviceInfoWrapper:
@@ -1482,6 +1510,16 @@
 { 'struct': 'HvBalloonDeviceInfoWrapper',
   'data': { 'data': 'HvBalloonDeviceInfo' } }
 
+##
+# @SpmMemoryDeviceInfoWrapper:
+#
+# @data: spm-memory device state information
+#
+# Since: 11.1
+##
+{ 'struct': 'SpmMemoryDeviceInfoWrapper',
+  'data': { 'data': 'SpmMemoryDeviceInfo' } }
+
 ##
 # @MemoryDeviceInfo:
 #
@@ -1499,7 +1537,8 @@
             'virtio-pmem': 'VirtioPMEMDeviceInfoWrapper',
             'virtio-mem': 'VirtioMEMDeviceInfoWrapper',
             'sgx-epc': 'SgxEPCDeviceInfoWrapper',
-            'hv-balloon': 'HvBalloonDeviceInfoWrapper'
+            'hv-balloon': 'HvBalloonDeviceInfoWrapper',
+            'spm-memory': 'SpmMemoryDeviceInfoWrapper'
           }
 }
 
-- 
2.34.1


