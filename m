Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42631CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 11:12:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waX8x-0004ix-DJ; Fri, 19 Jun 2026 07:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1waX8v-0004im-Oc
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 07:12:13 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1waX8t-0001rp-Qa
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 07:12:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQXoJmow1toGEJincmVPMO2Y5wA2WLHeM0q9/ki6jiFoGTYIiQ3w3cBDikwUvGVmXbe51u3r62QldZhGlkU17tIeve5EfM+BgHcLTTMR9E6zVPkgHe8DO4euTAnYr+Igg5KYkjz37ddbsFyLczDQDenbQMg8GeHJqeH9cpBkrl+ye++n2FJ5irOiHgqx6eccVh6rbFemhsxkca3rM4N85H0iTQxAjfaKAXnEZ28bcFm6nJSjOv09bla6DJVicdrB93Q6VsjzoSZ5EDP7Y7DQGHmtzmQWnAVuNsfvAqf62eFPmrUUEag2km9bbRTSZjpBOTUtAhy3X0CVtyGwtdjeLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLr26veEEN6L5LsbtaQLzbD1Y8Kev6iUaUeI+r4jQ8E=;
 b=DDktKPVil6FLN1dH3NTU8DUReYP2/tIiTgL3zNNRT4zCmTU1dtdQLav6pHFBspaTWU67NCftCpNs5NvDfHFOjlMKBolg/EU17b7gJVZiRxNbwo2ZuU0FcU1NJxZABc2PMQq9+UT1og6nqBNTrofOxjigak1Vxq3GCbvQ0YoUIGreZcbzrKTrJEPxERlIkg8guiaDOXQco4ElEWPOkAi4oTvVXrelh1GRZZwXl8uJExZpU0tcfETLYO5oOjnVr//fB4uDNK/d2oxthMYcXOoPiwpW8SaTmJZQHSUAht6lOI4QyyHgTE2ioj58/PX6o2nDKETWJruh+iq00X2NS+3VnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLr26veEEN6L5LsbtaQLzbD1Y8Kev6iUaUeI+r4jQ8E=;
 b=AvwGHAOCElTt4sxgQsfAFXaEX7hGVxbecUc7pqpLSpBQ+mp6ua8+hx4+ZTIrmxaO6BHqT9Lu91IA2nVr2N7tS3GS5zflbmTDMw4dkqw04mECv8T7GKhH8YFuCVGEo+lMe/Gdif0j+feEpuz648x2WIPtR3H9sjZszDEDfU0LRSY=
Received: from BY3PR10CA0003.namprd10.prod.outlook.com (2603:10b6:a03:255::8)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 11:12:05 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::1b) by BY3PR10CA0003.outlook.office365.com
 (2603:10b6:a03:255::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.14 via Frontend Transport; Fri,
 19 Jun 2026 11:12:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 11:12:05 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 06:12:01 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@kernel.org>, <imammedo@redhat.com>,
 <mst@redhat.com>, <gourry@gourry.net>, <philmd@mailo.com>
CC: <peterx@redhat.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>,
 fanhuang <FangSheng.Huang@amd.com>
Subject: [PATCH v13 03/10] i386/acpi-build: partition device_memory SRAT
 umbrella for sp-mem
Date: Fri, 19 Jun 2026 19:11:29 +0800
Message-ID: <20260619111136.3481329-4-FangSheng.Huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: d0bc0705-7984-4e44-aea2-08decdf398cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|56012099006|11063799006|6133799003|22082099003|18002099003|43062017;
X-Microsoft-Antispam-Message-Info: elRqE4PZ9C1BNNa7p1j0bcZkGHY1jqC3WL6BdrfYNizsnkWCBEG5ZLlILjSSsW++IRi/5A3WRc79hPl1C0p31SKeEwDYYRhQQSmeIZSQviZHMcDNLAGP3rlrIodgHI4S5v7nOua5InXgYVuzgABIUoQ94FSf/HH8kF2JSA4izM2ihAYKi2r0TbJgtNh/LDW9odJV3lfhkPOsF6WdlP2NmDxsgYJkSvm2NJzffItAnApBJOLA/lCeWO2DpFNjnOUMVP5tL5YAD4zdaskVpsXvAzthpH72U7RvTpl3kHScR+k78AZ0pG5+Su4Oq7vYl3+UEeWpv88GI/oiKavUYCrmDfJGgV+d9XRFyziSd0X3KcJyG/pbFFQILh7SzE0RPGOqricdqSpFDwExcyrN/Tw92A6U26LUHyvudDOVIUQ9Kvt8YAwy8YW+rWvnZgLR1ETj05M+pa01YnWqg2alelXmfhqw2pqS8Ot6PprQRdXqP33U5ZUB4DEZIt3jcPGfo3bsxLZZ6OBShlFxUhom1x3b448EZBHyZEnQo+n3b8S30tphaDssC1X47/rQrXQFdx9Bj8agKFU+R8VtTbBwTkb62H8akAkSgvtDRWG6s5zWS8AtvHNSRiI6SoxZXLXhXIRt7mK0yHlK/zlzAqGXhX6c+fgnH26C3WiVBcU7/srEva4QD6e6mqcFvTRTLZ0xnxR6lItrbpjABwGJ6WWFe/QKMyeYmtEl+6PVdz9Tbmxx6bK5OEib4CvQA/YT54kOYoOc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NyPhLpTzqejYzcPW96kaoH22H3Gk9pyrn/X6K2+MjvE/a4gnK1+IWWU1wSA8Y3Czn7mX/RoWoS9pfPf2NlcYQflW3VgLLXQ5CIJ1TvXMQ2aB3k4vj76ZMg2ziBsvhd4jiLkYp0hgjffu3FmTvQ5D8Vdi38BY9pbrIdUQId01qcwPMnyg70qlTzx1WCVZMN4/TsMCa8awE25AF+mcFecF5MTFqh85e3G1YxQfbWiN+Rsrev2mTl3JCFLYOvcB/Xbz0DCc+BKgOb3PLT+wjmVgrE9wZZCxmyPQVdzVWEqwADzWkk8GDdN4we2BwfXps2fP2M3HD3K0gTQyacnOnLp2npc1dXV91TeRKcx2Llrmn8QV3tE9+ajJYOEJfF26qcOiFQmuRoBtcojTwJcTjyYlSWFXamSwe1NsRSdE2/jh20aG3SKTr0eDdB+D6X6bThpP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 11:12:05.6783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0bc0705-7984-4e44-aea2-08decdf398cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=FangSheng.Huang@amd.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/acpi-build.c | 96 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 4 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 2ee061558c..8837b69687 100644
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
@@ -1351,6 +1352,96 @@ build_tpm_tcpa(GArray *table_data, BIOSLinker *linker, GArray *tcpalog,
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
 
@@ -1487,10 +1578,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
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


