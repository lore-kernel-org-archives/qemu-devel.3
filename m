Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77344E8305A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 07:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnASC-0002Fv-LZ; Tue, 03 Feb 2026 02:04:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vnARy-00020z-4T; Tue, 03 Feb 2026 02:03:51 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vnARv-0003Du-Iw; Tue, 03 Feb 2026 02:03:49 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B4A0541874;
 Tue,  3 Feb 2026 07:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4754BC19425;
 Tue,  3 Feb 2026 07:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770102216;
 bh=wxW16Aj8+WzjRknuFv3nEfcuaZXq+HX7rJ/JER0/6CM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=MawDolkzv19ctlvC0TLxkDaRclaw8oxxAEtE/JJyNL08KZCWJ0F5y2BdNZdtXP9Yk
 5HsFulI+NMi68HUtNZc06WkjSlRGLJ6gu3mJhLW8t+c3E8IioJWT/F0x+iWAkJHe7/
 gJBxzrl6m7j7pVgjWDxugUSVryH3J2GRg9/OQrqExk/UPfvrrsvo0xuGQGSPH5caSO
 3Vy+FwqF8+6Sxx4xjixKniSevIJciDvv9vuzbKY9TlBs7ixBnRs8qjO5DTkDoqR2qR
 idwPBp12+ybS0iuPQxEhOGtKpFABqvtSDJ7L5s+6UNCmhNBINNPQQuXclEqGXUJaGr
 oH+dE4q+gO63A==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 02 Feb 2026 23:01:18 -0800
Subject: [PATCH RFC 2/7] acpi: aml-build: Add cache structure table
 creation for PPTT table
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-riscv-rqsc-v1-2-dcf448a3ed73@kernel.org>
References: <20260202-riscv-rqsc-v1-0-dcf448a3ed73@kernel.org>
In-Reply-To: <20260202-riscv-rqsc-v1-0-dcf448a3ed73@kernel.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Nicolas Pitre <npitre@baylibre.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Atish Kumar Patra <atishp@rivosinc.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, 
 guo.wenjia23@zte.com.cn, liu.qingtao2@zte.com.cn, 
 Sunil V L <sunilvl@ventanamicro.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, qemu-arm@nongnu.org, 
 Drew Fustini <fustini@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8295; i=fustini@kernel.org;
 h=from:subject:message-id; bh=5p3vnkRRKyTkMr0IIO7uoTexFRSKAeuHTrWqcyemBRY=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWQ2zj3W75lzS6DswOUvM2eztO35e5iD5eR/35XimTWt6
 nc2qpU3dZSyMIhxMciKKbJs+pB3YYlX6NcF819sg5nDygQyhIGLUwAmoi3N8M96nkb5k0x1kelH
 hWyqpy3LvmVbrx+27f8S9aZr60KLV0gwMpw2+at7XZmPZ8q6w+uSvv3kWvjw6//bq9lYtE//WiV
 /7gY/AA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010
Received-SPF: pass client-ip=172.234.252.31; envelope-from=fustini@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Sia Jee Heng <jeeheng.sia@starfivetech.com>

Adds cache structure table generation for the Processor Properties
Topology Table (PPTT) to describe cache hierarchy information for
ACPI guests.

A 3-level cache topology is employed here, referring to the type 1 cache
structure according to ACPI spec v6.3. The L1 cache and L2 cache are
private resources for the core, while the L3 cache is the private
resource for the cluster.

In the absence of cluster values in the QEMU command, a 2-layer cache is
expected. The default cache value should be passed in from the
architecture code.

Examples:
3-layer: -smp 4,sockets=1,clusters=2,cores=2,threads=1
2-layer: -smp 4,sockets=1,cores=2,threads=2

Link: https://lore.kernel.org/all/20240129104039.117671-1-jeeheng.sia@starfivetech.com/
Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 hw/acpi/aml-build.c         | 69 +++++++++++++++++++++++++++++++++++++++++----
 include/hw/acpi/aml-build.h | 21 +++++++++++++-
 2 files changed, 84 insertions(+), 6 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index dad4cfcc7d80..742e7a6eb261 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -2140,12 +2140,41 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
     }
     acpi_table_end(linker, &table);
 }
+
+/* ACPI spec, Revision 6.3 Cache type structure (Type 1) */
+static void build_cache_structure(GArray *tbl,
+                                  uint32_t next_level,
+                                  CPUCacheInfo *cache_info)
+{
+    /* Cache type structure */
+    build_append_byte(tbl, 1);
+    /* Length */
+    build_append_byte(tbl, 24);
+    /* Reserved */
+    build_append_int_noprefix(tbl, 0, 2);
+    /* Flags */
+    build_append_int_noprefix(tbl, 0x7f, 4);
+    /* Next level cache */
+    build_append_int_noprefix(tbl, next_level, 4);
+    /* Size */
+    build_append_int_noprefix(tbl, cache_info->size, 4);
+    /* Number of sets */
+    build_append_int_noprefix(tbl, cache_info->sets, 4);
+    /* Associativity */
+    build_append_byte(tbl, cache_info->associativity);
+    /* Attributes */
+    build_append_byte(tbl, cache_info->attributes);
+    /* Line size */
+    build_append_int_noprefix(tbl, cache_info->line_size, 2);
+}
+
 /*
  * ACPI spec, Revision 6.3
  * 5.2.29 Processor Properties Topology Table (PPTT)
  */
 void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
-                const char *oem_id, const char *oem_table_id)
+                const char *oem_id, const char *oem_table_id,
+                const CPUCaches *CPUCaches)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     CPUArchIdList *cpus = ms->possible_cpus;
@@ -2153,6 +2182,8 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
     uint32_t socket_offset = 0, cluster_offset = 0, core_offset = 0;
     uint32_t pptt_start = table_data->len;
     uint32_t root_offset;
+    uint32_t l3_offset = 0, priv_num = 0;
+    uint32_t priv_rsrc[3] = {0};
     int n;
     AcpiTable table = { .sig = "PPTT", .rev = 2,
                         .oem_id = oem_id, .oem_table_id = oem_table_id };
@@ -2183,11 +2214,15 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
             socket_id = cpus->cpus[n].props.socket_id;
             cluster_id = -1;
             core_id = -1;
+            priv_num = 0;
             socket_offset = table_data->len - pptt_start;
             build_processor_hierarchy_node(table_data,
                 (1 << 0) | /* Physical package */
                 (1 << 4), /* Identical Implementation */
-                root_offset, socket_id, NULL, 0);
+                root_offset,
+                socket_id,
+                NULL,
+                priv_num);
         }
 
         if (mc->smp_props.clusters_supported && mc->smp_props.has_clusters) {
@@ -2195,21 +2230,45 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 assert(cpus->cpus[n].props.cluster_id > cluster_id);
                 cluster_id = cpus->cpus[n].props.cluster_id;
                 core_id = -1;
+                priv_num = 0;
+                l3_offset = table_data->len - pptt_start;
+                /* L3 cache type structure */
+                if (CPUCaches && CPUCaches->l3_cache) {
+                    priv_num = 1;
+                    build_cache_structure(table_data, 0, CPUCaches->l3_cache);
+                }
                 cluster_offset = table_data->len - pptt_start;
                 build_processor_hierarchy_node(table_data,
                     (0 << 0) | /* Not a physical package */
                     (1 << 4), /* Identical Implementation */
-                    socket_offset, cluster_id, NULL, 0);
+                    socket_offset, cluster_id, &l3_offset, priv_num);
             }
         } else {
             cluster_offset = socket_offset;
         }
 
+        if (CPUCaches) {
+            /* L2 cache type structure */
+            priv_rsrc[0] = table_data->len - pptt_start;
+            build_cache_structure(table_data, 0, CPUCaches->l2_cache);
+
+            /* L1d cache type structure */
+            priv_rsrc[1] = table_data->len - pptt_start;
+            build_cache_structure(table_data, priv_rsrc[0],
+                                  CPUCaches->l1d_cache);
+
+            /* L1i cache type structure */
+            priv_rsrc[2] = table_data->len - pptt_start;
+            build_cache_structure(table_data, priv_rsrc[0],
+                                  CPUCaches->l1i_cache);
+
+            priv_num = 3;
+        }
         if (ms->smp.threads == 1) {
             build_processor_hierarchy_node(table_data,
                 (1 << 1) | /* ACPI Processor ID valid */
                 (1 << 3),  /* Node is a Leaf */
-                cluster_offset, n, NULL, 0);
+                cluster_offset, n, priv_rsrc, priv_num);
         } else {
             if (cpus->cpus[n].props.core_id != core_id) {
                 assert(cpus->cpus[n].props.core_id > core_id);
@@ -2225,7 +2284,7 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 (1 << 1) | /* ACPI Processor ID valid */
                 (1 << 2) | /* Processor is a Thread */
                 (1 << 3),  /* Node is a Leaf */
-                core_offset, n, NULL, 0);
+                core_offset, n, priv_rsrc, priv_num);
         }
     }
 
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index f38e12971932..33b303fc833b 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -3,6 +3,7 @@
 
 #include "hw/acpi/acpi-defs.h"
 #include "hw/acpi/bios-linker-loader.h"
+#include "include/hw/core/cpu.h"
 
 #define ACPI_BUILD_APPNAME6 "BOCHS "
 #define ACPI_BUILD_APPNAME8 "BXPC    "
@@ -234,6 +235,23 @@ struct CrsRangeSet {
     GPtrArray *mem_64bit_ranges;
 } CrsRangeSet;
 
+typedef
+struct CPUCacheInfo {
+    enum CacheType type;      /* Cache Type*/
+    uint32_t size;            /* Size of the cache in bytes */
+    uint32_t sets;            /* Number of sets in the cache */
+    uint8_t associativity;    /* Cache associativity */
+    uint8_t attributes;       /* Cache attributes */
+    uint16_t line_size;       /* Line size in bytes */
+} CPUCacheInfo;
+
+typedef
+struct CPUCaches {
+        CPUCacheInfo *l1d_cache;
+        CPUCacheInfo *l1i_cache;
+        CPUCacheInfo *l2_cache;
+        CPUCacheInfo *l3_cache;
+} CPUCaches;
 
 /*
  * ACPI 5.0: 6.4.3.8.2 Serial Bus Connection Descriptors
@@ -499,7 +517,8 @@ void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 const char *oem_id, const char *oem_table_id);
 
 void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
-                const char *oem_id, const char *oem_table_id);
+                const char *oem_id, const char *oem_table_id,
+                const CPUCaches *CPUCaches);
 
 void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
                 const char *oem_id, const char *oem_table_id);

-- 
2.43.0


