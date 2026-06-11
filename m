Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA922CD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXcJf-0001kf-04; Thu, 11 Jun 2026 06:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wXcJc-0001gr-1W
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 06:07:12 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wXcJX-0006zr-Si
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 06:07:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v4/ZiIj30CgxkPeP8+yrhUWDxrDlmWxra6RWOhYABfneRxG2p8ghfRQfFxgZxylAEWUDWGsM9bUAYZpIlE9zQS2YAugyKkVqdhox0L+Guwzoh1nkM5dtwHtUgHfPpuFVIyiB2d2oQxgEfNP8PU/o6V7lJ6r5AF9BjfK5DbOG+Z4cY5YOkMSi0H29rBKzEtfPFsXGihJEzD3dkinMG9sUSKUPpJpiPlVGFO826+DW4Ndx3olcmIvp5DcqIZuENlUfJOfFGvv6DatUFP5VYpKSNQcJCeNP7EwXhvMmeoVaw42X+gLqctoQYmzbwZ/e+u0qtrScSkfgp8NlDT+tkBLmyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TWhbF3d0nvIsp9a3V1svbMHYOt+O61G6qdTmCLNzrc=;
 b=WQ7OjcdwbX2hiZ9EtD1YVFhu0dkgUIz6UXBiUl/V/GO2Crw5HTWn+bq3Ay/TtxQqb+VU/DMzTRJDOkMssxAbNooq2hT7id8f8R4cCMN6sx1M1CEkKLoIQ7aYUZY8mCXlMSt5fp8rW8dJirrLCbQFTTb2c1HdXkKCF8ufibpA8+93uXsCgZrRlPicdKWG4qwF17y8D/72WaUkl3hnjKubBuy6E3nxiw91DmSjbe5SO0f0VfJHtnpl2B0qdTYrd1G6ECmUdTA+UsLZh/zE0Sw2JChOzVplCjKvUnwlpiBCQ3FRLhGw+aZlNh90IYK69FrZBgPqG2lHDgZlqUQFjwSxGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TWhbF3d0nvIsp9a3V1svbMHYOt+O61G6qdTmCLNzrc=;
 b=xtLVc1nHiZCdHmq1MvaMY3sBesxYoE0t3FOmJzphA8NLhbch50AIPtKniS3+9oxZ2W7BtAI6R+NS0WOx7MKGBuqYfgXr8u9AI9l5UWoKphHu8r63WkIEMwDPGd3VC0egFWAhNHEWAXg4ZYeH2gQYKL95LaRKaj2r8bVC1oYWXH0=
Received: from BN9PR03CA0122.namprd03.prod.outlook.com (2603:10b6:408:fe::7)
 by DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 10:07:03 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:fe:cafe::a8) by BN9PR03CA0122.outlook.office365.com
 (2603:10b6:408:fe::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Thu,
 11 Jun 2026 10:07:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 10:07:02 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 05:07:00 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@kernel.org>, <imammedo@redhat.com>,
 <gourry@gourry.net>, <philmd@mailo.com>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH v11 2/4] i386/acpi-build: partition device_memory SRAT
 umbrella for sp-mem
Date: Thu, 11 Jun 2026 18:06:35 +0800
Message-ID: <20260611100637.2460507-3-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611100637.2460507-1-FangSheng.Huang@amd.com>
References: <20260611100637.2460507-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|DM6PR12MB4466:EE_
X-MS-Office365-Filtering-Correlation-Id: c456d5d4-ae28-419b-4354-08dec7a12f0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|6133799003|11063799006|56012099006|22082099003|18002099003|43062017;
X-Microsoft-Antispam-Message-Info: Fzxq+zAb2pPSNpu5OveuePImdBaITOy81qACRTKl/+A9cJMUrQk9X/OXJAtUJeXGUrqO3+s4FNis7eM3aUf29KWbcjVD5txwMs1b21F6E07L9dRrSNFoHU62BOAiz/9ykvPO3KiwAAcA6KWnXa93A0qkpyIqgxlW0R1IRfmQJ9VPIkGmInvflCaJj9cbgAWLhAlQwDM1+63SUYa5ZQQuFGgkyfOuSK4wbpzjrl8Lk1DIFCkSUfh+8U/mW878Oj6sFQXGq4A7QVjEr5IqV/5SuZNmV4pHhJuJckDpRCsHL0I/MP0TUCVPagJw7OWMZ5XBNI25cHCNCNGYGnyobVwuxjOBDW+1KGeUcVrFUgY2eMh1wuAZDGBl3zh3z28uO8TUDhNbrazjNU7yzg4gwG1DCMAX6fEKhnZIDeFS/iPhAt3ltAzqIPhthPaoVGO3G7F2JjltC66/BrQxQtkRa8UlmnColI/HJVqukqi/JY7oY1np5ch9mrIxcSP8g26f6K12YijqJgeUYHjgPGlPKJ6UrICrAt8kFbwQI6VKjSTG09hmTw+Tz0ubDhH7cRPd/B6PHpm1UGU6yFfFblS84TVu+btDRiMfTCg12v9ruJoTVBVO2jNrJK8JBqDJCsumbtWAcTkoGi+t0l5gM4faOOe7boAblclEBTJ+l90VQtnTFS3JOrByoXrg9e6vTTQDhCCp8+29CbeSxByyyqdTE+vZ3v1lu95dIP2xPfhaFrQJ5R0Ly0znfbrPHc6rj2c6ce98qFxbZYw3kBJcrc9l5T60vQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nrgp3NVmg6Ri/v3HYEsb/r0HPN/wLzt8F+QWKQqjoaY3T9jHBo5Nrwmu8biL778DfXtzXzNvnouGcAaPQTLqIH9jjy7rd9NlnJoygtDhSNgvn41qVp7vwK1h1XzsXOTh+K2snXM9ywEzzW8ETxyFSofzfYH9Fda/es3sjqj/Hv1nM+pgUV7bYoGs/uLLRl6gYAI5E1+9W+KPBL+vmKKSgIH9UMNkn+9A94MkrZiN0/NmbFvmZLUE+SzBNGMvUMdm5OfjynUOOJRjEFCol1sW52QMj2MaeguNfok+lwAcTsyodexltdAHSEBBpdWV2s2Vcfy1js4gfxeN3r8TZFahk70TonS6vZ7Q7gm0FUJZEAd68ygZeSdupYrXf1ZZaPbqo4BsK+uDfFrQTCh4+yudsfQ1WL8RNvjXsuKQi6GLfSIY5h7RykshjIGY50DVqubW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 10:07:02.5958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c456d5d4-ae28-419b-4354-08dec7a12f0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=FangSheng.Huang@amd.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


