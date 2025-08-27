Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7402ACA0FF9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 14:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urH5U-0005x5-0V; Wed, 27 Aug 2025 10:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1urH5O-0005iW-8r; Wed, 27 Aug 2025 10:25:15 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1urH5L-00074U-CL; Wed, 27 Aug 2025 10:25:13 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cBmvs6wj9z6K92V;
 Wed, 27 Aug 2025 22:22:49 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
 by mail.maildlp.com (Postfix) with ESMTPS id 86F44140276;
 Wed, 27 Aug 2025 22:25:07 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.126.171.221) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 27 Aug 2025 16:25:06 +0200
To: <qemu-devel@nongnu.org>
CC: <anisinha@redhat.com>, <armbru@redhat.com>, <berrange@redhat.com>,
 <dapeng1.mi@linux.intel.com>, <eric.auger@redhat.com>,
 <farman@linux.ibm.com>, <gustavo.romero@linaro.org>, <imammedo@redhat.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <linuxarm@huawei.com>, <maobibo@loongson.cn>, <mst@redhat.com>,
 <mtosatti@redhat.com>, <peter.maydell@linaro.org>, <philmd@linaro.org>,
 <qemu-arm@nongnu.org>, <richard.henderson@linaro.org>,
 <shannon.zhaosl@gmail.com>, <yangyicong@hisilicon.com>, <zhao1.liu@intel.com>
Subject: [PATCH v16 6/8] hw/acpi: add cache hierarchy to pptt table
Date: Wed, 27 Aug 2025 15:21:50 +0100
Message-ID: <20250827142152.206-7-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827142152.206-1-alireza.sanaee@huawei.com>
References: <20250827142152.206-1-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.171.221]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500003.china.huawei.com (7.182.85.28)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add cache topology to PPTT table. With this patch, both ACPI PPTT table
and device tree will represent the same cache topology given users
input.

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 hw/acpi/aml-build.c      | 200 +++++++++++++++++++++++++++++++++++++--
 hw/arm/virt-acpi-build.c |   8 +-
 include/hw/acpi/cpu.h    |  10 ++
 3 files changed, 209 insertions(+), 9 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index e854f14565..72b6bfdbe9 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -31,6 +31,7 @@
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_bridge.h"
 #include "qemu/cutils.h"
+#include "hw/core/cpu.h"
 
 static GArray *build_alloc_array(void)
 {
@@ -2140,6 +2141,104 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
     }
     acpi_table_end(linker, &table);
 }
+
+static void build_cache_nodes(GArray *tbl, CPUCoreCaches *cache,
+                              uint32_t next_offset)
+{
+    int val;
+
+    /* Type 1 - cache */
+    build_append_byte(tbl, 1);
+    /* Length */
+    build_append_byte(tbl, 24);
+    /* Reserved */
+    build_append_int_noprefix(tbl, 0, 2);
+    /* Flags */
+    build_append_int_noprefix(tbl, 0x7f, 4);
+    /* Offset of next cache up */
+    build_append_int_noprefix(tbl, next_offset, 4);
+    build_append_int_noprefix(tbl, cache->size, 4);
+    build_append_int_noprefix(tbl, cache->sets, 4);
+    build_append_byte(tbl, cache->associativity);
+    val = 0x3;
+    switch (cache->type) {
+    case INSTRUCTION_CACHE:
+        val |= (1 << 2);
+        break;
+    case DATA_CACHE:
+        val |= (0 << 2); /* Data */
+        break;
+    case UNIFIED_CACHE:
+        val |= (3 << 2); /* Unified */
+        break;
+    }
+    build_append_byte(tbl, val);
+    build_append_int_noprefix(tbl, cache->linesize, 2);
+}
+
+/*
+ * builds caches from the top level (`level_high` parameter) to the bottom
+ * level (`level_low` parameter).  It searches for caches found in
+ * systems' registers, and fills up the table. Then it updates the
+ * `data_offset` and `instr_offset` parameters with the offset of the data
+ * and instruction caches of the lowest level, respectively.
+ */
+static bool build_caches(GArray *table_data, uint32_t pptt_start,
+                         int num_caches, CPUCoreCaches *caches,
+                         uint8_t level_high, /* Inclusive */
+                         uint8_t level_low,  /* Inclusive */
+                         uint32_t *data_offset,
+                         uint32_t *instr_offset)
+{
+    uint32_t next_level_offset_data = 0, next_level_offset_instruction = 0;
+    uint32_t this_offset, next_offset = 0;
+    int c, level;
+    bool found_cache = false;
+
+    /* Walk caches from top to bottom */
+    for (level = level_high; level >= level_low; level--) {
+        for (c = 0; c < num_caches; c++) {
+            if (caches[c].level != level) {
+                continue;
+            }
+
+            /* Assume only unified above l1 for now */
+            this_offset = table_data->len - pptt_start;
+            switch (caches[c].type) {
+            case INSTRUCTION_CACHE:
+                next_offset = next_level_offset_instruction;
+                break;
+            case DATA_CACHE:
+                next_offset = next_level_offset_data;
+                break;
+            case UNIFIED_CACHE:
+                /* Either is fine here */
+                next_offset = next_level_offset_instruction;
+                break;
+            }
+            build_cache_nodes(table_data, &caches[c], next_offset);
+            switch (caches[c].type) {
+            case INSTRUCTION_CACHE:
+                next_level_offset_instruction = this_offset;
+                break;
+            case DATA_CACHE:
+                next_level_offset_data = this_offset;
+                break;
+            case UNIFIED_CACHE:
+                next_level_offset_instruction = this_offset;
+                next_level_offset_data = this_offset;
+                break;
+            }
+            *data_offset = next_level_offset_data;
+            *instr_offset = next_level_offset_instruction;
+
+            found_cache = true;
+        }
+    }
+
+    return found_cache;
+}
+
 /*
  * ACPI spec, Revision 6.3
  * 5.2.29 Processor Properties Topology Table (PPTT)
@@ -2150,11 +2249,32 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     CPUArchIdList *cpus = ms->possible_cpus;
-    int64_t socket_id = -1, cluster_id = -1, core_id = -1;
-    uint32_t socket_offset = 0, cluster_offset = 0, core_offset = 0;
+    uint32_t core_data_offset = 0;
+    uint32_t core_instr_offset = 0;
+    uint32_t cluster_instr_offset = 0;
+    uint32_t cluster_data_offset = 0;
+    uint32_t node_data_offset = 0;
+    uint32_t node_instr_offset = 0;
+    int top_node = 3;
+    int top_cluster = 3;
+    int top_core = 3;
+    int bottom_node = 3;
+    int bottom_cluster = 3;
+    int bottom_core = 3;
+    int64_t socket_id = -1;
+    int64_t cluster_id = -1;
+    int64_t core_id = -1;
+    uint32_t socket_offset = 0;
+    uint32_t cluster_offset = 0;
+    uint32_t core_offset = 0;
     uint32_t pptt_start = table_data->len;
     uint32_t root_offset;
     int n;
+    uint32_t priv_rsrc[2];
+    uint32_t num_priv = 0;
+    bool cache_available;
+    bool llevel;
+
     AcpiTable table = { .sig = "PPTT", .rev = 2,
                         .oem_id = oem_id, .oem_table_id = oem_table_id };
 
@@ -2184,11 +2304,30 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
             socket_id = cpus->cpus[n].props.socket_id;
             cluster_id = -1;
             core_id = -1;
+            bottom_node = top_node;
+            num_priv = 0;
+            cache_available = machine_defines_cache_at_topo_level(
+                ms, CPU_TOPOLOGY_LEVEL_SOCKET);
+            llevel = machine_find_lowest_level_cache_at_topo_level(
+                ms, &bottom_node, CPU_TOPOLOGY_LEVEL_SOCKET);
+            if (cache_available && llevel) {
+                build_caches(table_data, pptt_start, num_caches, caches,
+                             top_node, bottom_node, &node_data_offset,
+                             &node_instr_offset);
+                priv_rsrc[0] = node_instr_offset;
+                priv_rsrc[1] = node_data_offset;
+                if (node_instr_offset || node_data_offset) {
+                    num_priv = node_instr_offset == node_data_offset ? 1 : 2;
+                }
+
+                top_cluster = bottom_node - 1;
+            }
+
             socket_offset = table_data->len - pptt_start;
             build_processor_hierarchy_node(table_data,
                 (1 << 0) | /* Physical package */
                 (1 << 4), /* Identical Implementation */
-                root_offset, socket_id, NULL, 0);
+                root_offset, socket_id, priv_rsrc, num_priv);
         }
 
         if (mc->smp_props.clusters_supported && mc->smp_props.has_clusters) {
@@ -2196,21 +2335,68 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 assert(cpus->cpus[n].props.cluster_id > cluster_id);
                 cluster_id = cpus->cpus[n].props.cluster_id;
                 core_id = -1;
+                bottom_cluster = top_cluster;
+                num_priv = 0;
+                cache_available = machine_defines_cache_at_topo_level(
+                    ms, CPU_TOPOLOGY_LEVEL_CLUSTER);
+                llevel = machine_find_lowest_level_cache_at_topo_level(
+                    ms, &bottom_cluster, CPU_TOPOLOGY_LEVEL_CLUSTER);
+
+                if (cache_available && llevel) {
+                    build_caches(table_data, pptt_start, num_caches, caches,
+                                 top_cluster, bottom_cluster,
+                                 &cluster_data_offset, &cluster_instr_offset);
+                    priv_rsrc[0] = cluster_instr_offset;
+                    priv_rsrc[1] = cluster_data_offset;
+                    if (cluster_instr_offset || cluster_data_offset) {
+                        num_priv =
+                            cluster_instr_offset == cluster_data_offset ? 1 : 2;
+                    }
+                    top_core = bottom_cluster - 1;
+                } else if (top_cluster == bottom_node - 1) {
+                    /* socket cache but no cluster cache */
+                    top_core = bottom_node - 1;
+                }
+
                 cluster_offset = table_data->len - pptt_start;
                 build_processor_hierarchy_node(table_data,
                     (0 << 0) | /* Not a physical package */
                     (1 << 4), /* Identical Implementation */
-                    socket_offset, cluster_id, NULL, 0);
+                    socket_offset, cluster_id, priv_rsrc, num_priv);
             }
         } else {
+            if (machine_defines_cache_at_topo_level(
+                    ms, CPU_TOPOLOGY_LEVEL_CLUSTER)) {
+                error_setg(&error_fatal, "Not clusters found for the cache");
+                return;
+            }
+
             cluster_offset = socket_offset;
+            top_core = bottom_node - 1; /* there is no cluster */
+        }
+
+        if (cpus->cpus[n].props.core_id != core_id) {
+            bottom_core = top_core;
+            num_priv = 0;
+            cache_available = machine_defines_cache_at_topo_level(
+                ms, CPU_TOPOLOGY_LEVEL_CORE);
+            llevel = machine_find_lowest_level_cache_at_topo_level(
+                ms, &bottom_core, CPU_TOPOLOGY_LEVEL_CORE);
+            if (cache_available && llevel) {
+                build_caches(table_data, pptt_start, num_caches, caches,
+                             top_core, bottom_core, &core_data_offset,
+                             &core_instr_offset);
+                priv_rsrc[0] = core_instr_offset;
+                priv_rsrc[1] = core_data_offset;
+                num_priv = core_instr_offset == core_data_offset ? 1 : 2;
+            }
         }
 
         if (ms->smp.threads == 1) {
             build_processor_hierarchy_node(table_data,
                 (1 << 1) | /* ACPI Processor ID valid */
-                (1 << 3),  /* Node is a Leaf */
-                cluster_offset, n, NULL, 0);
+                (1 << 3), /* Node is a Leaf */
+                cluster_offset, n, priv_rsrc, num_priv);
         } else {
             if (cpus->cpus[n].props.core_id != core_id) {
                 assert(cpus->cpus[n].props.core_id > core_id);
@@ -2219,7 +2405,7 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 build_processor_hierarchy_node(table_data,
                     (0 << 0) | /* Not a physical package */
                     (1 << 4), /* Identical Implementation */
-                    cluster_offset, core_id, NULL, 0);
+                    cluster_offset, core_id, priv_rsrc, num_priv);
             }
 
             build_processor_hierarchy_node(table_data,
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index a6115f2f80..5fca69fcb2 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -1022,6 +1022,10 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     unsigned dsdt, xsdt;
     GArray *tables_blob = tables->table_data;
     MachineState *ms = MACHINE(vms);
+    CPUCoreCaches caches[CPU_MAX_CACHES];
+    unsigned int num_caches;
+
+    num_caches = virt_get_caches(vms, caches);
 
     table_offsets = g_array_new(false, true /* clear */,
                                         sizeof(uint32_t));
@@ -1043,8 +1047,8 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 
     if (!vmc->no_cpu_topology) {
         acpi_add_table(table_offsets, tables_blob);
-        build_pptt(tables_blob, tables->linker, ms,
-                   vms->oem_id, vms->oem_table_id, 0, NULL);
+        build_pptt(tables_blob, tables->linker, ms, vms->oem_id,
+                   vms->oem_table_id, num_caches, caches);
     }
 
     acpi_add_table(table_offsets, tables_blob);
diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index 32654dc274..a4027a2a76 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -70,6 +70,16 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
 
 void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***list);
 
+struct CPUPPTTCaches {
+    enum CacheType type;
+    uint32_t sets;
+    uint32_t size;
+    uint32_t level;
+    uint16_t linesize;
+    uint8_t attributes; /* write policy: 0x0 write back, 0x1 write through */
+    uint8_t associativity;
+};
+
 extern const VMStateDescription vmstate_cpu_hotplug;
 #define VMSTATE_CPU_HOTPLUG(cpuhp, state) \
     VMSTATE_STRUCT(cpuhp, state, 1, \
-- 
2.43.0


