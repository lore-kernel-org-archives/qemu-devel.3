Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA0CCD6E74
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 10:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVS4Z-00027d-EO; Fri, 05 Jun 2026 06:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wVS4X-00023r-PN
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 06:46:41 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wVS4V-0004Tf-Sn
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 06:46:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3MD61W7G/5xJoh5ixZTCAuC3GXZi8jDQDea0P3sOHr2D6JkYZjZwDWQ51tUk67lFuJFU0aUFTgU2rfRy3e7kNamYMI029i0jfYCvNBCTUykmKAxFHu3+HTQJZOgy6ChdFqr5rNR/kQx3pmGJdAVC8v1zAi5Me3DBLYELDhiF0MhWqx4KrWk89sajW6NMhqImI24dTob8oV7BjfpizAtp0QjylIEa7VpfYNuKTBgDYVhDK3G4eKMG3H/g8x1HFtFXsuPLYcSmFV/rLpeuRyrOII02Z+fB19EN5+sE0JhVNQRkVCpADlCoooy+Z+BlwCc/GHV7pLrggwbdK3nxd0vmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPzE6w7Yh0e0kM2aJ6EH/P0Er9uDL6auYqDUmwh74ps=;
 b=aU0SAMavBWnyJPmwHSYl+pR1eha/DxeM7GggzTqk+ZuZ02Iex3OPA33TT4OGqQGzLh1pB7FrQKBRpAAeIzrWxUzyuuZfLR2kLo8lnD8ZHVnbnRMafCzJ+4dNPCyi+QROR8FGY/gjYRR3ab8zSMIMKwC6vcKwC/SzO5DJuB31DVx5Zk+raAjcnpp0chdCUL/g6xfCy0k34pVTh1h4JXhcsLwBlXY9bsoBTwO5htLFdTEmCmA0RBBW6qDJWMIp4QZD0nSoNljpMduYMjQ4PpjJR/z+ejpKhCEcIcB6jhRbscK0b+09Kt7RgtgML/4NpxkVIu3vOLfld3nesSN25UIK3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPzE6w7Yh0e0kM2aJ6EH/P0Er9uDL6auYqDUmwh74ps=;
 b=LqbnBw94GGD9HECa/yr67TMe/ze1CaNGJRWfApu1EFCQyuz4EZUdaCgkMBCZgarTf5UyvGX7keb5Ito6OrmlGz1o+Jw7cPGhzPRWhvKV7jd+EYFw5ZWA2lE8UjKCgkJ4aC6MQK/sWcnbxt1mIicdWKfqgMvqFv5pUVvikaUa2So=
Received: from BY1P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::7)
 by CY5PR12MB6648.namprd12.prod.outlook.com (2603:10b6:930:3e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 10:46:34 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::29) by BY1P220CA0020.outlook.office365.com
 (2603:10b6:a03:5c3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Fri, 5
 Jun 2026 10:46:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 10:46:34 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 05:46:31 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@kernel.org>, <imammedo@redhat.com>,
 <gourry@gourry.net>, <philmd@mailo.com>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH v10 2/4] i386/acpi-build: partition device_memory SRAT
 umbrella for sp-mem
Date: Fri, 5 Jun 2026 18:46:07 +0800
Message-ID: <20260605104609.1739911-3-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605104609.1739911-1-FangSheng.Huang@amd.com>
References: <20260605104609.1739911-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|CY5PR12MB6648:EE_
X-MS-Office365-Filtering-Correlation-Id: b07e61d2-c6d2-4426-a09c-08dec2efb63a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|11063799006|56012099006|3023799007|6133799003|18002099003|22082099003|43062017;
X-Microsoft-Antispam-Message-Info: Sr3VDQGiLhBOXAjxRmJrps2tGgd5ZykaGgbLdIKtUJOjEWDHqTyTrqo8ThpFkXmWdVINcQOeC4qq1ZWTlu7afxov8cM0Xd3pm4cRcoWcIKrVmx+t0JwwSiBeN27sSExsshiJDYcpCPFnOcAkbQZEEpisMeysR7Xa/aXX55V89VUZXTuOvkSraesRZvN1/QmRwFRqV+idmJwr4ZmbddxogCARsbXxWDZ6/+RiGiJ+MxRr31vCi2tOUVwN2H9jKDXXnVfzjXGJnu+nleL8fWnmkeJYaBnVI3uY6Y9wyP/8WiOHbeNToivQkbEPra8oOeZmLvpecrrlQ+KjTZSQBalRmLgQIkFqRZIdbsyFx/61qh1mVQ9TDgF6zqMZPednR1CJ8501ov3Cg3zQ+HtkNjcJ8NxCKsQVkMdefaMYsns2s7v2eYu2MYV1g76WZbAOs7okj206W49saB5w0kZXFDUVIIV9PW53KKm5HgGeemyG2nYVK3t8yvPRbiSQvfddBBOf0IEs+zif6AljjJ5FYRfsWf10AFdSF83SBP1exD30anvgArUb9ykn2iIcdMf38Cvf9gzDfBiM5UCsTgfbH5TwkF33l52pyRf6wOU3EE/T4ljqZp4B5/A2uJj43SLifs+JZalv6Zr3BRRiGqjkaWrAnX/rS1Rn8srC6iv83RtIJUACDIDL/e7+4Gzdans7wVz2AsMlDasRwZXvDa6913dptBCPWxELHqbPQ8fza1fI7+aBG+HTQ8BHeVyMzg/cascrOdaITEdyWELmQ+o4Z2n+gse5ZhJV9UqhmiC1qcrm4OA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(11063799006)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EUdn5BF1jAMHhjbcPtX+q3i54rPKLJGBsiZvejMtpFNCEJ6o6asIxE1TnTKgNMk7+F64VxmfZgG5VQ9cZlIBvDHt5Ms1fO+P0H3QmKyuBiBq8TkPQIyq/vpzox6xrGmH7qefIY/KkQotI4NeX47JiEt5lM4KIj1yka1QNIirUG9MUZxtynnlbFsD5bN90dEnNqBOW5DsJxU3x4jDKjDb3XY7tAhyijSh7lANVnT5m+nuPW1IaJl6CoXaWXoIRWMxpPqieC43WiSXX43jU8h8LAARyXfrzfiDnJgl7hXpFk0yvGKAJ7PHtYqJ6WJsnAq0sjt1dfP6WtQiEwFbwcYRfTFjcsHy9W2OylKxu/WkL8w6wQpQwSW5iPvhR6wdo643WUDr4xeQuBiAOARyHC/o72dh5/4T904n2R6Ad/TDSVx6NnTs4wuA6ZV1QCUPsr+j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 10:46:34.2705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b07e61d2-c6d2-4426-a09c-08dec2efb63a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6648
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=FangSheng.Huang@amd.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
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

Restructure the device_memory SRAT umbrella entry into a per-kind
partition: each TYPE_SP_MEM device gets an ENABLED entry at its own
proximity_domain; the remaining sub-ranges get HOTPLUGGABLE | ENABLED
placeholders at the highest PXM, preserving the existing umbrella
convention.

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
---
 hw/i386/acpi-build.c | 98 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 92 insertions(+), 6 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 0d7c83d5e9..76efa83808 100644
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
+static int collect_sp_mem_ranges_cb(Object *obj, void *opaque)
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
+                                   collect_sp_mem_ranges_cb, ranges);
+    g_array_sort(ranges, sp_mem_range_compare);
+
+    for (i = 0; i < ranges->len; i++) {
+        SpMemRange *r = &g_array_index(ranges, SpMemRange, i);
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
 
@@ -1481,12 +1572,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
      * Memory devices may override proximity set by this entry,
      * providing _PXM method if necessary.
      */
-    if (machine->device_memory) {
-        build_srat_memory(table_data, machine->device_memory->base,
-                          memory_region_size(&machine->device_memory->mr),
-                          nb_numa_nodes - 1,
-                          MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
-    }
+    build_srat_device_memory(table_data, machine);
 
     acpi_table_end(linker, &table);
 }
-- 
2.34.1


