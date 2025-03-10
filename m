Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A394C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 16:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trfxF-0002uf-IC; Mon, 10 Mar 2025 12:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1trfxD-0002uG-AR; Mon, 10 Mar 2025 12:26:12 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1trfx4-0002Ko-5b; Mon, 10 Mar 2025 12:26:10 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZBMdW5Yq0z6K8L9;
 Tue, 11 Mar 2025 00:23:27 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
 by mail.maildlp.com (Postfix) with ESMTPS id C2FA2140CB9;
 Tue, 11 Mar 2025 00:25:57 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.68.114) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Mar 2025 17:25:56 +0100
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <mst@redhat.com>, <zhao1.liu@intel.com>, <dapeng1.mi@linux.intel.com>,
 <armbru@redhat.com>, <farman@linux.ibm.com>, <peter.maydell@linaro.org>,
 <anisinha@redhat.com>, <shannon.zhaosl@gmail.com>, <imammedo@redhat.com>,
 <mtosatti@redhat.com>, <berrange@redhat.com>, <richard.henderson@linaro.org>, 
 <shameerali.kolothum.thodi@huawei.com>, <jonathan.cameron@huawei.com>,
 <jiangkunkun@huawei.com>, <yangyicong@hisilicon.com>, <linuxarm@huawei.com>
Subject: [PATCH v8 4/6] hw/acpi/aml-build.c: add cache hierarchy to pptt table
Date: Mon, 10 Mar 2025 16:23:35 +0000
Message-ID: <20250310162337.844-5-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310162337.844-1-alireza.sanaee@huawei.com>
References: <20250310162337.844-1-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.47.68.114]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500003.china.huawei.com (7.182.85.28)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Co-developed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 hw/acpi/aml-build.c            | 205 ++++++++++++++++++++++++++++++++-
 hw/arm/virt-acpi-build.c       |   8 +-
 hw/loongarch/virt-acpi-build.c |   2 +-
 include/hw/acpi/aml-build.h    |   4 +-
 include/hw/cpu/core.h          |   1 +
 5 files changed, 212 insertions(+), 8 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index e5401dfdb1a8..e2568522660d 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -2046,6 +2046,107 @@ void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms,
     acpi_table_end(linker, &table);
 }
 
+static void build_cache_nodes(GArray *tbl, PPTTCPUCaches *cache,
+                              uint32_t next_offset, unsigned int id)
+{
+    int val;
+
+    /* Type 1 - cache */
+    build_append_byte(tbl, 1);
+    /* Length */
+    build_append_byte(tbl, 28);
+    /* Reserved */
+    build_append_int_noprefix(tbl, 0, 2);
+    /* Flags - everything except possibly the ID */
+    build_append_int_noprefix(tbl, 0xff, 4);
+    /* Offset of next cache up */
+    build_append_int_noprefix(tbl, next_offset, 4);
+    build_append_int_noprefix(tbl, cache->size, 4);
+    build_append_int_noprefix(tbl, cache->sets, 4);
+    build_append_byte(tbl, cache->associativity);
+    val = 0x3;
+    switch (cache->type) {
+    case INSTRUCTION:
+        val |= (1 << 2);
+        break;
+    case DATA:
+        val |= (0 << 2); /* Data */
+        break;
+    case UNIFIED:
+        val |= (3 << 2); /* Unified */
+        break;
+    }
+    build_append_byte(tbl, val);
+    build_append_int_noprefix(tbl, cache->linesize, 2);
+    build_append_int_noprefix(tbl,
+                              (cache->type << 24) | (cache->level << 16) | id,
+                              4);
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
+                         int num_caches, PPTTCPUCaches *caches,
+                         int base_id,
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
+            case INSTRUCTION:
+                next_offset = next_level_offset_instruction;
+                break;
+            case DATA:
+                next_offset = next_level_offset_data;
+                break;
+            case UNIFIED:
+                /* Either is fine here */
+                next_offset = next_level_offset_instruction;
+                break;
+            }
+            build_cache_nodes(table_data, &caches[c], next_offset, base_id);
+            switch (caches[c].type) {
+            case INSTRUCTION:
+                next_level_offset_instruction = this_offset;
+                break;
+            case DATA:
+                next_level_offset_data = this_offset;
+                break;
+            case UNIFIED:
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
  * 5.2.29.1 Processor hierarchy node structure (Type 0)
@@ -2146,15 +2247,24 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
  * 5.2.29 Processor Properties Topology Table (PPTT)
  */
 void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
-                const char *oem_id, const char *oem_table_id)
+                const char *oem_id, const char *oem_table_id,
+                int num_caches, PPTTCPUCaches *caches)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     CPUArchIdList *cpus = ms->possible_cpus;
+    uint32_t core_data_offset = 0, core_instr_offset = 0;
+    uint32_t cluster_instr_offset = 0, cluster_data_offset = 0;
+    uint32_t node_data_offset = 0, node_instr_offset = 0;
+    int top_node = 3, top_cluster = 3, top_core = 3;
+    int bottom_node = 3, bottom_cluster = 3, bottom_core = 3;
     int64_t socket_id = -1, cluster_id = -1, core_id = -1;
     uint32_t socket_offset = 0, cluster_offset = 0, core_offset = 0;
     uint32_t pptt_start = table_data->len;
     uint32_t root_offset;
     int n;
+    uint32_t priv_rsrc[2];
+    uint32_t num_priv = 0;
+
     AcpiTable table = { .sig = "PPTT", .rev = 3,
                         .oem_id = oem_id, .oem_table_id = oem_table_id };
 
@@ -2184,11 +2294,35 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
             socket_id = cpus->cpus[n].props.socket_id;
             cluster_id = -1;
             core_id = -1;
+            bottom_node = top_node;
+            num_priv = 0;
+            if (cache_described_at(ms, CPU_TOPOLOGY_LEVEL_SOCKET) &&
+                find_the_lowest_level_cache_defined_at_level(
+                    ms,
+                    &bottom_node,
+                    CPU_TOPOLOGY_LEVEL_SOCKET))
+            {
+                build_caches(table_data, pptt_start,
+                             num_caches, caches,
+                             n, top_node, bottom_node,
+                             &node_data_offset, &node_instr_offset);
+
+                priv_rsrc[0] = node_instr_offset;
+                priv_rsrc[1] = node_data_offset;
+
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
+                root_offset, socket_id,
+                priv_rsrc, num_priv);
         }
 
         if (mc->smp_props.clusters_supported && mc->smp_props.has_clusters) {
@@ -2196,21 +2330,81 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 assert(cpus->cpus[n].props.cluster_id > cluster_id);
                 cluster_id = cpus->cpus[n].props.cluster_id;
                 core_id = -1;
+                bottom_cluster = top_cluster;
+                num_priv = 0;
+
+                if (cache_described_at(ms, CPU_TOPOLOGY_LEVEL_CLUSTER) &&
+                    find_the_lowest_level_cache_defined_at_level(
+                        ms,
+                        &bottom_cluster,
+                        CPU_TOPOLOGY_LEVEL_CLUSTER))
+                {
+
+                    build_caches(table_data, pptt_start,
+                                 num_caches, caches, n, top_cluster,
+                                 bottom_cluster, &cluster_data_offset,
+                                 &cluster_instr_offset);
+
+                    priv_rsrc[0] = cluster_instr_offset;
+                    priv_rsrc[1] = cluster_data_offset;
+
+                    if (cluster_instr_offset || cluster_data_offset) {
+                        num_priv =
+                        cluster_instr_offset == cluster_data_offset ? 1 : 2;
+                    }
+
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
+                    socket_offset, cluster_id,
+                    priv_rsrc, num_priv);
             }
         } else {
+            if (cache_described_at(ms, CPU_TOPOLOGY_LEVEL_CLUSTER)) {
+                error_setg(&error_fatal, "Not clusters found for the cache");
+                return;
+            }
+
             cluster_offset = socket_offset;
+            top_core = bottom_node - 1; /* there is no cluster */
         }
 
+        if (cpus->cpus[n].props.core_id != core_id) {
+            bottom_core = top_core;
+            num_priv = 0;
+
+            if (cache_described_at(ms, CPU_TOPOLOGY_LEVEL_CORE) &&
+                find_the_lowest_level_cache_defined_at_level(
+                    ms,
+                    &bottom_core,
+                    CPU_TOPOLOGY_LEVEL_CORE))
+            {
+                build_caches(table_data, pptt_start,
+                             num_caches, caches,
+                             n, top_core, bottom_core,
+                             &core_data_offset, &core_instr_offset);
+
+                priv_rsrc[0] = core_instr_offset;
+                priv_rsrc[1] = core_data_offset;
+
+                num_priv = core_instr_offset == core_data_offset ? 1 : 2;
+            }
+        }
+
+
         if (ms->smp.threads == 1) {
             build_processor_hierarchy_node(table_data,
                 (1 << 1) | /* ACPI Processor ID valid */
                 (1 << 3),  /* Node is a Leaf */
-                cluster_offset, n, NULL, 0);
+                cluster_offset, n,
+                priv_rsrc, num_priv);
         } else {
             if (cpus->cpus[n].props.core_id != core_id) {
                 assert(cpus->cpus[n].props.core_id > core_id);
@@ -2219,7 +2413,8 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 build_processor_hierarchy_node(table_data,
                     (0 << 0) | /* Not a physical package */
                     (1 << 4), /* Identical Implementation */
-                    cluster_offset, core_id, NULL, 0);
+                    cluster_offset, core_id,
+                    priv_rsrc, num_priv);
             }
 
             build_processor_hierarchy_node(table_data,
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 3ac8f8e17861..9c17d6b579af 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -902,6 +902,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     GArray *tables_blob = tables->table_data;
     MachineState *ms = MACHINE(vms);
 
+    PPTTCPUCaches caches[CPU_MAX_CACHES]; /* Can select up to 16 */
+    unsigned int num_caches;
+
+    num_caches = virt_get_caches(vms, caches);
+
     table_offsets = g_array_new(false, true /* clear */,
                                         sizeof(uint32_t));
 
@@ -923,7 +928,8 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     if (!vmc->no_cpu_topology) {
         acpi_add_table(table_offsets, tables_blob);
         build_pptt(tables_blob, tables->linker, ms,
-                   vms->oem_id, vms->oem_table_id);
+                   vms->oem_id, vms->oem_table_id,
+                   num_caches, caches);
     }
 
     acpi_add_table(table_offsets, tables_blob);
diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index fced6c445ac6..68ccab2dd214 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -552,7 +552,7 @@ static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
 
     acpi_add_table(table_offsets, tables_blob);
     build_pptt(tables_blob, tables->linker, machine,
-               lvms->oem_id, lvms->oem_table_id);
+               lvms->oem_id, lvms->oem_table_id, 0, NULL);
 
     acpi_add_table(table_offsets, tables_blob);
     build_srat(tables_blob, tables->linker, machine);
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index c18f68134246..e0fb51238204 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -3,6 +3,7 @@
 
 #include "hw/acpi/acpi-defs.h"
 #include "hw/acpi/bios-linker-loader.h"
+#include "hw/cpu/core.h"
 
 #define ACPI_BUILD_APPNAME6 "BOCHS "
 #define ACPI_BUILD_APPNAME8 "BXPC    "
@@ -497,7 +498,8 @@ void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 const char *oem_id, const char *oem_table_id);
 
 void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
-                const char *oem_id, const char *oem_table_id);
+                const char *oem_id, const char *oem_table_id,
+                int num_caches, PPTTCPUCaches *caches);
 
 void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
                 const char *oem_id, const char *oem_table_id);
diff --git a/include/hw/cpu/core.h b/include/hw/cpu/core.h
index 4746732b4f1c..cebf7007edc1 100644
--- a/include/hw/cpu/core.h
+++ b/include/hw/cpu/core.h
@@ -11,6 +11,7 @@
 
 #include "hw/qdev-core.h"
 #include "qom/object.h"
+#include "qapi/qapi-types-machine-common.h"
 
 #define TYPE_CPU_CORE "cpu-core"
 
-- 
2.34.1


