Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1F5F99364
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqtW-0006LV-5B; Thu, 23 Apr 2026 06:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtN-0006Iz-I6
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:41 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtL-0001yV-79
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:41 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so61713995e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938558; x=1777543358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bnsQpKZvADX/dBQKWgM/oupAzTN5HN3FPlw++ZOMvzY=;
 b=AemfDpnTi7w8zX90hkohYlEe80hxfZuqBrKdNsMgA4SJqF5X64kw+lF0meKge0deOb
 KGIpG6PeIQWQJA/qUAtwVBtX7ncQSFckoyZkKPTJENC340WJXl3QmkWLJSYpD1Af/qeM
 Sh9SQvOHfYRkKsPBo5eu2tCrZoCftTdD0CLf4qk5YvkA8l2IokH4ttQOBdM05ao6QZ3p
 KG8IGw+jM5EZdZHmcJ3oHZy30JqA2YdqniPVIxmBqekM1JnbBt/L0AxiHbAyuEgpZZqV
 t/bcHhLWJ8smdMK1GFYuKPM+626kEZlfeaWCxUT00UUjpGeUp3YSLD59J1m77pxyCM7X
 i3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938558; x=1777543358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bnsQpKZvADX/dBQKWgM/oupAzTN5HN3FPlw++ZOMvzY=;
 b=W9O+9z5N269XuwprnMVGuypbE1/qGSivrniRUz7xMfauDK1oAx32hv6sGGyrPEQBxk
 k5SZR1KAxjNE4H7PFv208aEOHFSVFjff/+DCfQslEXKjY4owQUANzul87jk7GiVQ/fbM
 KN78oV+trZXNwmKhGbrNN0fJni9mR7kJ7uovqQhSjhpZ68C6XA+utL9gy746Q6XhDyLS
 mtpi5ppqeJAsSUHsb9+Bo/dSB42g7om4P4Zz44Nyan8OJlsnhTRaFME8Cdgd++jvDh8v
 BfpApxYum+jp4YBtLnqkejdeilbCDr6AyGe4bL3jnY9RR6ZjsJAudHVcsP406izwv9ze
 KEIg==
X-Gm-Message-State: AOJu0YyMuuNWuORsmfBLebjz7X5XL1fXPE8DDkRkpW1MBCpBAMOIq5kJ
 is5rjG2EmNZLF+l5pRM4Z0wZVoFE/OGpfU88hRYkABdJjltxuccEIAnhJg/dGgosurEX0MvgDTO
 0JQOq
X-Gm-Gg: AeBDieth3pIgVLlk3TXn6J0tVj3K9eRwWWF01VhFteScS7zG+xShDmzLWdiKQbuZNdY
 8GsZE/QPXUGy67AhgIoj4Bu2XqunbvZnNkVkmlRToXF6Z7phkiluv0vs/SDOqFBEmVXIf0l1Zjr
 kLaU+u4HJ3xOwLyljE76wgjhBpzSg4sWp6qPiR0suulEqY2jBH6CvqdLx+tmH+/xxt1NxG6pUJt
 8hfu/dVovyFfIegpyml3NE9JQOW7wyCJDpl77pob5ldpO2sAcYaVeln/x+FIqbpV7CxjI0AVZqZ
 uTnESlIQHZLgEK2DLsu+6CSWjmPcIkky4cNeHHrVGvgyztJa2/p4vrVcQ7mT51v5N9ZWn83lXT/
 z6psGpSf4Ts35RZIQhca6rfWSTA6SBX15L+JQEnLTEj+sgNyF2iLCE/tTVh3eV/jg8hLMqddbgg
 Al6JJhs0VVltyxa2xGY4T7cpsfkvddlERmME+adX/HWOWq/bMtAVRWDDFIdXNtHJAqsnjc2G/Uh
 xIw0Kd8k14BEauKkDHnNF3N92FOd9nXHM1m4iahg2F4WPyMUY2l
X-Received: by 2002:a05:600c:c4ab:b0:487:1fb4:7e1 with SMTP id
 5b1f17b1804b1-488fb7864c3mr376640535e9.22.1776938557555; 
 Thu, 23 Apr 2026 03:02:37 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.02.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:02:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/59] hw/acpi: add cache hierarchy to pptt table
Date: Thu, 23 Apr 2026 11:01:36 +0100
Message-ID: <20260423100229.2941820-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Alireza Sanaee <alireza.sanaee@huawei.com>

Add cache topology to PPTT table.

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-id: 20260311160609.358-7-alireza.sanaee@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/acpi/aml-build.c      | 200 +++++++++++++++++++++++++++++++++++++--
 hw/arm/virt-acpi-build.c |   8 +-
 include/hw/acpi/cpu.h    |  10 ++
 3 files changed, 209 insertions(+), 9 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index b0ea8a5d5d..7edc8aed42 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -34,6 +34,7 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/acpi/acpi_aml_interface.h"
 #include "qemu/cutils.h"
+#include "hw/core/cpu.h"
 
 static GArray *build_alloc_array(void)
 {
@@ -2150,6 +2151,108 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
     }
     acpi_table_end(linker, &table);
 }
+
+/*
+ * ACPI spec, Revision 6.3
+ * 5.2.29.2 Cache Type Structure (Type 1)
+ */
+static void build_cache_nodes(GArray *tbl, CPUCoreCaches *cache,
+                              uint32_t next_offset)
+{
+    const uint8_t node_length = 24;
+    int start_len = tbl->len;
+    int val;
+
+    build_append_byte(tbl, 1);                         /* Type 1 - cache */
+    build_append_byte(tbl, node_length);               /* Length */
+    build_append_int_noprefix(tbl, 0, 2);              /* Reserved */
+    build_append_int_noprefix(tbl, 0x7f, 4);           /* Flags */
+    build_append_int_noprefix(tbl, next_offset, 4);    /* Next Level of Cache */
+    build_append_int_noprefix(tbl, cache->size, 4);    /* Size */
+    build_append_int_noprefix(tbl, cache->sets, 4);    /* Number of sets */
+    build_append_byte(tbl, cache->associativity);      /* Associativity */
+    val = 0x3;
+    switch (cache->type) {
+    case INSTRUCTION_CACHE:
+        val |= (1 << 2); /* Instruction Cache */
+        break;
+    case DATA_CACHE:
+        val |= (0 << 2); /* Data Cache */
+        break;
+    case UNIFIED_CACHE:
+        val |= (3 << 2); /* Unified */
+        break;
+    }
+    build_append_byte(tbl, val);                        /* Attributes */
+    build_append_int_noprefix(tbl, cache->linesize, 2); /* Line size */
+    g_assert(tbl->len == start_len + node_length);
+}
+
+/*
+ * Build PPTT Cache Type structures (Type 1) from cache level `level_high`
+ * down to `level_low` (both inclusive), appending them to the PPTT table.
+ *
+ * On output, `data_offset` and `instr_offset` hold the PPTT offsets of the
+ * lowest-level data and instruction cache nodes respectively.  These offsets
+ * are referenced as private resources in the Processor Hierarchy Node (Type 0)
+ * that owns the caches.
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
@@ -2160,11 +2263,31 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
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
+    bool cache_at_topo_level;
+
     AcpiTable table = { .sig = "PPTT", .rev = 2,
                         .oem_id = oem_id, .oem_table_id = oem_table_id };
 
@@ -2194,11 +2317,29 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
             socket_id = cpus->cpus[n].props.socket_id;
             cluster_id = -1;
             core_id = -1;
+            bottom_node = top_node;
+            num_priv = 0;
+            cache_at_topo_level =
+                machine_find_lowest_level_cache_at_topo_level(
+                    ms, &bottom_node, CPU_TOPOLOGY_LEVEL_SOCKET);
+            if (cache_at_topo_level) {
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
@@ -2206,21 +2347,66 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 assert(cpus->cpus[n].props.cluster_id > cluster_id);
                 cluster_id = cpus->cpus[n].props.cluster_id;
                 core_id = -1;
+                bottom_cluster = top_cluster;
+                num_priv = 0;
+                cache_at_topo_level =
+                    machine_find_lowest_level_cache_at_topo_level(
+                        ms, &bottom_cluster, CPU_TOPOLOGY_LEVEL_CLUSTER);
+
+                if (cache_at_topo_level) {
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
+            cache_at_topo_level =
+                machine_find_lowest_level_cache_at_topo_level(
+                    ms, &bottom_core, CPU_TOPOLOGY_LEVEL_CORE);
+            if (cache_at_topo_level) {
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
@@ -2229,7 +2415,7 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 build_processor_hierarchy_node(table_data,
                     (0 << 0) | /* Not a physical package */
                     (1 << 4), /* Identical Implementation */
-                    cluster_offset, core_id, NULL, 0);
+                    cluster_offset, core_id, priv_rsrc, num_priv);
             }
 
             build_processor_hierarchy_node(table_data,
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index cd0700416e..41ca0bab08 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -1255,6 +1255,10 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     unsigned dsdt, xsdt;
     GArray *tables_blob = tables->table_data;
     MachineState *ms = MACHINE(vms);
+    CPUCoreCaches caches[CPU_MAX_CACHES];
+    unsigned int num_caches;
+
+    num_caches = virt_get_caches(vms, caches);
 
     table_offsets = g_array_new(false, true /* clear */,
                                         sizeof(uint32_t));
@@ -1276,8 +1280,8 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 
     if (!vmc->no_cpu_topology) {
         acpi_add_table(table_offsets, tables_blob);
-        build_pptt(tables_blob, tables->linker, ms,
-                   vms->oem_id, vms->oem_table_id, 0, NULL);
+        build_pptt(tables_blob, tables->linker, ms, vms->oem_id,
+                   vms->oem_table_id, num_caches, caches);
     }
 
     acpi_add_table(table_offsets, tables_blob);
diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index 2809dd8a91..04c821d2b9 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -69,6 +69,16 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
 
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


