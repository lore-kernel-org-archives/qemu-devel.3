Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01619CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 09:09:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZPmp-0002Jf-TU; Tue, 16 Jun 2026 05:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wZPmo-0002JF-PN
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 05:08:46 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wZPmm-0004OJ-Ru
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 05:08:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IES/iiOZZqPSgzvC442VGo4qEjHoUXQ/hfiXW/h4WxLwAcuH93YpPEj+tKdZdIBQAS8jlfXuReOoG6mm1BU85urZlGyqYdtJgTUlVFMfhfLxMKvPs62U5G0s9oiGjmAWGqGscd7i5+kWldRx3Se2RaxjePUzKaVzD/e3fCd8fofbWeNfW5iThyW5b4EXRY9820qt1q8iUR/fYmvTSs2zspFCa8VNl7R5oX8knwnPQaijB+w4IWHy3Tb78iyFEGusA5BcKipPa1SEryxon2sFHJXsZOXCjkdoh6tuW18TUbYuwNueLtoCcEKUMXFJQhSDc/jvUhTj87ki93LjWTyXTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TWhbF3d0nvIsp9a3V1svbMHYOt+O61G6qdTmCLNzrc=;
 b=U68zyAKJ4jVd1IfNXOYyX/2rNFbyoLM6iJZCGUEOAkPBQWATHZV6ypW0ZUGFfnw8bLUtXStPyux5JFW4B0LBAx4grKVZ6aNYgYsNLtRlvBex2G14Td9aByrz017zIPmMfcnkFMqO3lbSI5+06s5Wh4I9+vAehTLe3NgDkR6GTXVG01gidbzrnUsHxCzPiFRG007U/rHZJ4bdfVwmTUuJD92hXwn2+ZOvNoY7F/0zd8GTJKOFz9tSgyAawJhIIrg4WPGt6vnV0Zvp2XrFi5XkImdQZtAsfzfhXBeiVYkS7BtyondrtW/MdzKuhr1vsYDJ0MJrAPguwl6WnYaEJCgbRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TWhbF3d0nvIsp9a3V1svbMHYOt+O61G6qdTmCLNzrc=;
 b=Yno2uKF/CiSYvJk+svIOwQbHLNmvB4Lyp26/CWsypuYfxnwyj68d0D+V1aSUmo7r3FJlU8bERCAEhce6o/vlVOaRyCEmywXF5Pa1hN8+bK7o1s9mAgS42Yn2+QUMTFHNl5NdkxdyjDLC9HlRKpetj8unzyk/fiqEKWRVvUpjnzw=
Received: from DM6PR01CA0002.prod.exchangelabs.com (2603:10b6:5:296::7) by
 CY5PR12MB6598.namprd12.prod.outlook.com (2603:10b6:930:42::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Tue, 16 Jun 2026 09:08:37 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:296:cafe::c) by DM6PR01CA0002.outlook.office365.com
 (2603:10b6:5:296::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 09:08:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 09:08:37 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 04:08:37 -0500
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 02:08:34 -0700
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@kernel.org>, <imammedo@redhat.com>,
 <gourry@gourry.net>, <philmd@mailo.com>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH v12 2/4] i386/acpi-build: partition device_memory SRAT
 umbrella for sp-mem
Date: Tue, 16 Jun 2026 17:08:06 +0800
Message-ID: <20260616090808.3047939-3-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260616090808.3047939-1-FangSheng.Huang@amd.com>
References: <20260616090808.3047939-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|CY5PR12MB6598:EE_
X-MS-Office365-Filtering-Correlation-Id: f8cac50b-805f-4ae2-1603-08decb86d9b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|22082099003|18002099003|6133799003|56012099006|11063799006|43062017;
X-Microsoft-Antispam-Message-Info: IM0+ZHvMTMYYm9Z2G6ODrma1C5/FCisI8yV+ySAJepoUdrNRYN5u598K42OnDxVOpuR4C7nRRsKELlPb42NLNCEISA8OblIzVRb0HQYBETLJyt0ZlY8qJX1XOpZpfEaAidc3crt4GEe+MB2PoDL3VyUpUuZnLfxHoy1BXX8pcJxw7NoHWQOccPoTDXDiT+AWpQijP0Y4ME38JClm0bJV8WeluehurJ37fek/quQbFTmB2BTHL1yy3wZOWk1bX6X3dq19JDDjNfjnIFUs/yA40GcY5YijWbwe/t3Xt1u6VoGKDowpAVQvXYeiL3RdCxL/qprMpLShV2n8cSB6CQHj1N+kbDbbOiQHGUVO8WsQ7wA9Gc1nbFhiCXqpV/awkW2teezmVh8pIGvHslcEJSU8tgToiprxzlHa4xHm2gtnRpiJ4NvCwfAHUty2/AmpyY58mFlk5aAj8a8BMokHX7GHs6ZUPUaQiWlG0zjPecAnQvTPVIOrA+iqS/Kf51gC6NyvS9r49TttwuAEcjntPDwDqYWC0rYBaDf7OcLjzcoSAVVtQbLKCPBobkvkp6e/QMSZB5UGLlEfpWBSIXPjHJtTYOquPUdAKWIx5sM+iEG8oI9XSNWa1pRsXuWQsycpdHI9j6D319IsbUAgIzV5r+u8uAMyXJwe7tAQYeIGVASaMUhoSVTeiAovjXZYN9FJWdxgdWy/wZNsCqoUaOgK0azMrq+2r4mxj1+yfG1zN3EBgQwpVgH4IYkgg2W4eh0eUFbwCix5XVCNBMXgWx+O4vmrHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VYqWWV/ozYC50EmafwgF1EHTkoWcqgSUPfYkoGQ7nVsXd3SLiwnCGQfKWiGm7l43s6leq4uuLN5cogHWeS+ORcn8KD429pK0RB32uCaUZogyzs8arJMkQinJRrhHCON41WkknP289VeuUQkki8Q3PFFyNMtwoLscPdaNCYN2YmJhtYV1LB0bkWqfyoT/mpkpBpoqAJTFGMwGP7Mw+wOKk9OJ7mh2uwPIdRB6johFHmq2izkepJNIwfU8qUexl5iAdapfBjb9WhCv1RLv9POMHBYO+J9Q4JOSItr/n2oh/6kP5dGv2qfv17tQS42BhlLpraUjRoNirIuTxgVxxF4ebiM57yfVHjnbitorGY8fHb2aRe+tgaDtadTy5FFMQKzpSx5c+5c4yxgLaQxKvL8Bmc+kXmY/tp7Ttq0rKo9ANtaFx5EogDzuyDNQVvn5HYRD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 09:08:37.1585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8cac50b-805f-4ae2-1603-08decb86d9b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6598
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

Restructure the device_memory SRAT umbrella entry into a per-kind
partition: each TYPE_SP_MEM device gets an ENABLED entry at its own
proximity_domain; the remaining sub-ranges get HOTPLUGGABLE | ENABLED
placeholders at the highest PXM, preserving the existing umbrella
convention.

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
---
 hw/i386/acpi-build.c | 96 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 4 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 0d7c83d5e9..db144b5706 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -52,6 +52,7 @@
 #include "migration/vmstate.h"
 #include "hw/mem/memory-device.h"
 #include "hw/mem/nvdimm.h"
+#include "hw/mem/sp-mem.h"
 #include "system/numa.h"
 #include "system/reset.h"
 #include "hw/hyperv/vmbus-bridge.h"
@@ -1346,6 +1347,96 @@ build_tpm_tcpa(GArray *table_data, BIOSLinker *linker, GArray *tcpalog,
 }
 #endif
 
+typedef struct {
+    uint64_t addr;
+    uint64_t size;
+    uint32_t node;
+} SpMemRange;
+
+static int sp_mem_collect_ranges_cb(Object *obj, void *opaque)
+{
+    GArray *ranges = opaque;
+    SpMemDevice *spm;
+    MemoryDeviceClass *mdc;
+    SpMemRange r;
+
+    if (!object_dynamic_cast(obj, TYPE_SP_MEM)) {
+        return 0;
+    }
+    spm = SP_MEM(obj);
+    mdc = MEMORY_DEVICE_GET_CLASS(MEMORY_DEVICE(spm));
+    r.addr = mdc->get_addr(MEMORY_DEVICE(spm));
+    r.size = memory_region_size(
+                 host_memory_backend_get_memory(spm->hostmem));
+    r.node = spm->node;
+    g_array_append_val(ranges, r);
+    return 0;
+}
+
+static gint sp_mem_range_compare(gconstpointer a, gconstpointer b)
+{
+    const SpMemRange *range_a = a;
+    const SpMemRange *range_b = b;
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
+ * Emit SRAT memory-affinity entries covering the device_memory region.
+ *
+ * For each plugged TYPE_SP_MEM device, emit an ENABLED entry at the
+ * device's own proximity_domain.  All remaining sub-ranges (gaps
+ * between sp-mem devices, leading and trailing padding, and ranges
+ * occupied by other memory devices) are covered by HOTPLUGGABLE |
+ * ENABLED placeholder entries at PXM = nb_numa_nodes - 1.
+ */
+static void build_srat_device_memory(GArray *table_data, MachineState *ms)
+{
+    g_autoptr(GArray) ranges = g_array_new(FALSE, TRUE, sizeof(SpMemRange));
+    uint32_t hotplug_pxm = ms->numa_state->num_nodes - 1;
+    uint64_t region_start, region_end;
+    guint i;
+
+    region_start = ms->device_memory->base;
+    region_end = region_start + memory_region_size(&ms->device_memory->mr);
+
+    object_child_foreach_recursive(qdev_get_machine(),
+                                   sp_mem_collect_ranges_cb, ranges);
+    g_array_sort(ranges, sp_mem_range_compare);
+
+    for (i = 0; i < ranges->len; i++) {
+        SpMemRange *r = &g_array_index(ranges, SpMemRange, i);
+
+        if (region_start < r->addr) {
+            build_srat_memory(table_data, region_start, r->addr - region_start,
+                              hotplug_pxm,
+                              MEM_AFFINITY_HOTPLUGGABLE |
+                              MEM_AFFINITY_ENABLED);
+        }
+        build_srat_memory(table_data, r->addr, r->size, r->node,
+                          MEM_AFFINITY_ENABLED);
+        region_start = r->addr + r->size;
+    }
+
+    /*
+     * Cover the rest of the device_memory window that no sp-mem device
+     * occupies. Keeping it HOTPLUGGABLE preserves the umbrella entry's
+     * role for future pc-dimm / virtio-mem hot-add into this window.
+     */
+    if (region_start < region_end) {
+        build_srat_memory(table_data, region_start, region_end - region_start,
+                          hotplug_pxm,
+                          MEM_AFFINITY_HOTPLUGGABLE |
+                          MEM_AFFINITY_ENABLED);
+    }
+}
+
 #define HOLE_640K_START  (640 * KiB)
 #define HOLE_640K_END   (1 * MiB)
 
@@ -1482,10 +1573,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
      * providing _PXM method if necessary.
      */
     if (machine->device_memory) {
-        build_srat_memory(table_data, machine->device_memory->base,
-                          memory_region_size(&machine->device_memory->mr),
-                          nb_numa_nodes - 1,
-                          MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
+        build_srat_device_memory(table_data, machine);
     }
 
     acpi_table_end(linker, &table);
-- 
2.34.1


