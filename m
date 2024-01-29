Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2A3C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 14:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUSFm-00011F-EU; Mon, 29 Jan 2024 09:04:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo1.xu@intel.com>)
 id 1rUNw6-00087t-QR; Mon, 29 Jan 2024 04:28:15 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo1.xu@intel.com>)
 id 1rUNw0-0007NE-5t; Mon, 29 Jan 2024 04:28:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706520488; x=1738056488;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=P0od7KrtXOjgFAeXN0i4CO+aUPPI2sDYN+O69zbwubM=;
 b=M1ZA+YDKJP80NBvdx2Ip8sJKds8dENWbAnSMhtFiq7LMxmvHc9kxU8d6
 /POKKr+RkOlKOr2F9SjfUwpstNgED2r4TOIijM8aWqClQLHpkLZjagUCY
 nyZWNtit9DiyY4stS31vp556gWG9h+Ugsev2sN9MEQwwrtlrWhJ7if04M
 YJPyNOLw1H25s/DBkIdrBNtW7tbt5B8xdurlAC0jjzgACvaNpWpeJyvA5
 KME1j09UVi+gmkcPDsuUsrG+YwG2TXjhtG2kF5w7TS/xNh7Zh9CwM++cr
 sa3RZv/EUaVkP7ataDkaQvxZ3IEp/BnqsgD9zDB+CeQfCwqfuZ2q+WQ7G Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="2729846"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="2729846"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2024 01:28:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="878008122"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; d="scan'208";a="878008122"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2024 01:28:00 -0800
From: Haibo Xu <haibo1.xu@intel.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, xiaobo55x@gmail.com,
 Haibo Xu <haibo1.xu@intel.com>
Subject: [PATCH] hw/riscv/virt-acpi-build.c: Add SRAT and SLIT ACPI tables
Date: Mon, 29 Jan 2024 17:42:00 +0800
Message-Id: <20240129094200.3581037-1-haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=haibo1.xu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.485,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 29 Jan 2024 09:04:47 -0500
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

Enable ACPI NUMA support by adding the following 2 ACPI tables:
SRAT: provides the association for memory/Harts and Proximity Domains
SLIT: provides the relative distance between Proximity Domains

The SRAT RINTC Affinity Structure definition[1] was based on the recently
approved ACPI CodeFirst ECR[2].

[1] https://github.com/riscv-non-isa/riscv-acpi/issues/25
[2] https://mantis.uefi.org/mantis/view.php?id=2433

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 hw/riscv/virt-acpi-build.c | 60 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 26c7e4482d..f0a6b61747 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -528,11 +528,61 @@ static void build_madt(GArray *table_data,
     acpi_table_end(linker, &table);
 }
 
+/*
+ * ACPI spec, Revision 6.5+
+ * 5.2.16 System Resource Affinity Table (SRAT)
+ * REF: https://github.com/riscv-non-isa/riscv-acpi/issues/25
+ *      https://drive.google.com/file/d/1YTdDx2IPm5IeZjAW932EYU-tUtgS08tX/view
+ */
+static void
+build_srat(GArray *table_data, BIOSLinker *linker, RISCVVirtState *vms)
+{
+    int i;
+    uint64_t mem_base;
+    MachineClass *mc = MACHINE_GET_CLASS(vms);
+    MachineState *ms = MACHINE(vms);
+    const CPUArchIdList *cpu_list = mc->possible_cpu_arch_ids(ms);
+    AcpiTable table = { .sig = "SRAT", .rev = 3, .oem_id = vms->oem_id,
+                        .oem_table_id = vms->oem_table_id };
+
+    acpi_table_begin(&table, table_data);
+    build_append_int_noprefix(table_data, 1, 4); /* Reserved */
+    build_append_int_noprefix(table_data, 0, 8); /* Reserved */
+
+    for (i = 0; i < cpu_list->len; ++i) {
+        uint32_t nodeid = cpu_list->cpus[i].props.node_id;
+        /*
+         * 5.2.16.8 RINTC Affinity Structure
+         */
+        build_append_int_noprefix(table_data, 7, 1);      /* Type */
+        build_append_int_noprefix(table_data, 20, 1);     /* Length */
+        build_append_int_noprefix(table_data, 0, 2);        /* Reserved */
+        build_append_int_noprefix(table_data, nodeid, 4); /* Proximity Domain */
+        build_append_int_noprefix(table_data, i, 4); /* ACPI Processor UID */
+        /* Flags, Table 5-70 */
+        build_append_int_noprefix(table_data, 1 /* Flags: Enabled */, 4);
+        build_append_int_noprefix(table_data, 0, 4); /* Clock Domain */
+    }
+
+    mem_base = vms->memmap[VIRT_DRAM].base;
+    for (i = 0; i < ms->numa_state->num_nodes; ++i) {
+        if (ms->numa_state->nodes[i].node_mem > 0) {
+            build_srat_memory(table_data, mem_base,
+                              ms->numa_state->nodes[i].node_mem, i,
+                              MEM_AFFINITY_ENABLED);
+            mem_base += ms->numa_state->nodes[i].node_mem;
+        }
+    }
+
+    acpi_table_end(linker, &table);
+}
+
 static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
 {
     GArray *table_offsets;
     unsigned dsdt, xsdt;
     GArray *tables_blob = tables->table_data;
+    MachineState *ms = MACHINE(s);
 
     table_offsets = g_array_new(false, true,
                                 sizeof(uint32_t));
@@ -565,6 +615,16 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
                    s->oem_table_id);
     }
 
+    if (ms->numa_state->num_nodes > 0) {
+        acpi_add_table(table_offsets, tables_blob);
+        build_srat(tables_blob, tables->linker, s);
+        if (ms->numa_state->have_numa_distance) {
+            acpi_add_table(table_offsets, tables_blob);
+            build_slit(tables_blob, tables->linker, ms, s->oem_id,
+                       s->oem_table_id);
+        }
+    }
+
     /* XSDT is pointed to by RSDP */
     xsdt = tables_blob->len;
     build_xsdt(tables_blob, tables->linker, table_offsets, s->oem_id,
-- 
2.34.1


