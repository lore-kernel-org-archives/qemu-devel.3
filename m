Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BC0C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 06:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfa9Q-0003Yl-LG; Thu, 29 Feb 2024 01:44:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rfa9M-0003US-7e
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 01:44:13 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rfa9J-0005ON-Oi
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 01:44:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709189049; x=1740725049;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KznjdvH3kuXEv/1tkBP3lz4cJ1FU6WY/9gVj9V1KPcg=;
 b=PydihxZI29E9192UTAGD14Yv848opckdFkQsC1qMi9NnC86JLtwmJsMI
 5gYjZhMA8G4GGUT+VTmgGzX3MvQ33veqd3C0S2ltyB4ATWbzxsohQ/KK0
 qx45CC/8xR+TCfBclf3OM5s657stnU1IkHb5GrAQNU2TNB1Ir+QFORrqV
 JrPqmWqyaIvURXN4mCxRjeNEa0He9EcR4oXrAHWVqX+nt9tiMhhlorIWh
 T64j5RROMmr61rKxIbso1sy97SLfkarH3oKn+ZM2p81hEcVFc9zN9l4c6
 BzotuLD4CPLiovoDFVJQhrk4jEW/HeK+ibiObrXni+vtLAAgpcJUS0Hhd g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3803275"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="3803275"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 22:44:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="8076477"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa007.jf.intel.com with ESMTP; 28 Feb 2024 22:44:01 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, xiaoyao.li@intel.com
Subject: [PATCH v5 60/65] hw/i386: add option to forcibly report edge trigger
 in acpi tables
Date: Thu, 29 Feb 2024 01:37:21 -0500
Message-Id: <20240229063726.610065-61-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229063726.610065-1-xiaoyao.li@intel.com>
References: <20240229063726.610065-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.596, HK_RANDOM_FROM=0.999, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Isaku Yamahata <isaku.yamahata@intel.com>

When level trigger isn't supported on x86 platform,
forcibly report edge trigger in acpi tables.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/acpi-build.c  | 99 ++++++++++++++++++++++++++++---------------
 hw/i386/acpi-common.c | 45 +++++++++++++++-----
 2 files changed, 101 insertions(+), 43 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 15242b9096b5..8b493a2e9605 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -964,7 +964,8 @@ static void build_dbg_aml(Aml *table)
     aml_append(table, scope);
 }
 
-static Aml *build_link_dev(const char *name, uint8_t uid, Aml *reg)
+static Aml *build_link_dev(const char *name, uint8_t uid, Aml *reg,
+                           bool level_trigger_unsupported)
 {
     Aml *dev;
     Aml *crs;
@@ -976,7 +977,10 @@ static Aml *build_link_dev(const char *name, uint8_t uid, Aml *reg)
     aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
 
     crs = aml_resource_template();
-    aml_append(crs, aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
+    aml_append(crs, aml_interrupt(AML_CONSUMER,
+                                  level_trigger_unsupported ?
+                                  AML_EDGE : AML_LEVEL,
+                                  AML_ACTIVE_HIGH,
                                   AML_SHARED, irqs, ARRAY_SIZE(irqs)));
     aml_append(dev, aml_name_decl("_PRS", crs));
 
@@ -1000,7 +1004,8 @@ static Aml *build_link_dev(const char *name, uint8_t uid, Aml *reg)
     return dev;
  }
 
-static Aml *build_gsi_link_dev(const char *name, uint8_t uid, uint8_t gsi)
+static Aml *build_gsi_link_dev(const char *name, uint8_t uid,
+                               uint8_t gsi, bool level_trigger_unsupported)
 {
     Aml *dev;
     Aml *crs;
@@ -1013,7 +1018,10 @@ static Aml *build_gsi_link_dev(const char *name, uint8_t uid, uint8_t gsi)
 
     crs = aml_resource_template();
     irqs = gsi;
-    aml_append(crs, aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
+    aml_append(crs, aml_interrupt(AML_CONSUMER,
+                                  level_trigger_unsupported ?
+                                  AML_EDGE : AML_LEVEL,
+                                  AML_ACTIVE_HIGH,
                                   AML_SHARED, &irqs, 1));
     aml_append(dev, aml_name_decl("_PRS", crs));
 
@@ -1032,7 +1040,7 @@ static Aml *build_gsi_link_dev(const char *name, uint8_t uid, uint8_t gsi)
 }
 
 /* _CRS method - get current settings */
-static Aml *build_iqcr_method(bool is_piix4)
+static Aml *build_iqcr_method(bool is_piix4, bool level_trigger_unsupported)
 {
     Aml *if_ctx;
     uint32_t irqs;
@@ -1040,7 +1048,9 @@ static Aml *build_iqcr_method(bool is_piix4)
     Aml *crs = aml_resource_template();
 
     irqs = 0;
-    aml_append(crs, aml_interrupt(AML_CONSUMER, AML_LEVEL,
+    aml_append(crs, aml_interrupt(AML_CONSUMER,
+                                  level_trigger_unsupported ?
+                                  AML_EDGE : AML_LEVEL,
                                   AML_ACTIVE_HIGH, AML_SHARED, &irqs, 1));
     aml_append(method, aml_name_decl("PRR0", crs));
 
@@ -1074,7 +1084,7 @@ static Aml *build_irq_status_method(void)
     return method;
 }
 
-static void build_piix4_pci0_int(Aml *table)
+static void build_piix4_pci0_int(Aml *table, bool level_trigger_unsupported)
 {
     Aml *dev;
     Aml *crs;
@@ -1087,12 +1097,16 @@ static void build_piix4_pci0_int(Aml *table)
     aml_append(sb_scope, pci0_scope);
 
     aml_append(sb_scope, build_irq_status_method());
-    aml_append(sb_scope, build_iqcr_method(true));
+    aml_append(sb_scope, build_iqcr_method(true, level_trigger_unsupported));
 
-    aml_append(sb_scope, build_link_dev("LNKA", 0, aml_name("PRQ0")));
-    aml_append(sb_scope, build_link_dev("LNKB", 1, aml_name("PRQ1")));
-    aml_append(sb_scope, build_link_dev("LNKC", 2, aml_name("PRQ2")));
-    aml_append(sb_scope, build_link_dev("LNKD", 3, aml_name("PRQ3")));
+    aml_append(sb_scope, build_link_dev("LNKA", 0, aml_name("PRQ0"),
+                                        level_trigger_unsupported));
+    aml_append(sb_scope, build_link_dev("LNKB", 1, aml_name("PRQ1"),
+                                        level_trigger_unsupported));
+    aml_append(sb_scope, build_link_dev("LNKC", 2, aml_name("PRQ2"),
+                                        level_trigger_unsupported));
+    aml_append(sb_scope, build_link_dev("LNKD", 3, aml_name("PRQ3"),
+                                        level_trigger_unsupported));
 
     dev = aml_device("LNKS");
     {
@@ -1101,7 +1115,9 @@ static void build_piix4_pci0_int(Aml *table)
 
         crs = aml_resource_template();
         irqs = 9;
-        aml_append(crs, aml_interrupt(AML_CONSUMER, AML_LEVEL,
+        aml_append(crs, aml_interrupt(AML_CONSUMER,
+                                      level_trigger_unsupported ?
+                                      AML_EDGE : AML_LEVEL,
                                       AML_ACTIVE_HIGH, AML_SHARED,
                                       &irqs, 1));
         aml_append(dev, aml_name_decl("_PRS", crs));
@@ -1187,7 +1203,7 @@ static Aml *build_q35_routing_table(const char *str)
     return pkg;
 }
 
-static void build_q35_pci0_int(Aml *table)
+static void build_q35_pci0_int(Aml *table, bool level_trigger_unsupported)
 {
     Aml *method;
     Aml *sb_scope = aml_scope("_SB");
@@ -1226,25 +1242,41 @@ static void build_q35_pci0_int(Aml *table)
     aml_append(sb_scope, pci0_scope);
 
     aml_append(sb_scope, build_irq_status_method());
-    aml_append(sb_scope, build_iqcr_method(false));
+    aml_append(sb_scope, build_iqcr_method(false, level_trigger_unsupported));
 
-    aml_append(sb_scope, build_link_dev("LNKA", 0, aml_name("PRQA")));
-    aml_append(sb_scope, build_link_dev("LNKB", 1, aml_name("PRQB")));
-    aml_append(sb_scope, build_link_dev("LNKC", 2, aml_name("PRQC")));
-    aml_append(sb_scope, build_link_dev("LNKD", 3, aml_name("PRQD")));
-    aml_append(sb_scope, build_link_dev("LNKE", 4, aml_name("PRQE")));
-    aml_append(sb_scope, build_link_dev("LNKF", 5, aml_name("PRQF")));
-    aml_append(sb_scope, build_link_dev("LNKG", 6, aml_name("PRQG")));
-    aml_append(sb_scope, build_link_dev("LNKH", 7, aml_name("PRQH")));
+    aml_append(sb_scope, build_link_dev("LNKA", 0, aml_name("PRQA"),
+                                        level_trigger_unsupported));
+    aml_append(sb_scope, build_link_dev("LNKB", 1, aml_name("PRQB"),
+                                        level_trigger_unsupported));
+    aml_append(sb_scope, build_link_dev("LNKC", 2, aml_name("PRQC"),
+                                        level_trigger_unsupported));
+    aml_append(sb_scope, build_link_dev("LNKD", 3, aml_name("PRQD"),
+                                        level_trigger_unsupported));
+    aml_append(sb_scope, build_link_dev("LNKE", 4, aml_name("PRQE"),
+                                        level_trigger_unsupported));
+    aml_append(sb_scope, build_link_dev("LNKF", 5, aml_name("PRQF"),
+                                        level_trigger_unsupported));
+    aml_append(sb_scope, build_link_dev("LNKG", 6, aml_name("PRQG"),
+                                        level_trigger_unsupported));
+    aml_append(sb_scope, build_link_dev("LNKH", 7, aml_name("PRQH"),
+                                        level_trigger_unsupported));
 
-    aml_append(sb_scope, build_gsi_link_dev("GSIA", 0x10, 0x10));
-    aml_append(sb_scope, build_gsi_link_dev("GSIB", 0x11, 0x11));
-    aml_append(sb_scope, build_gsi_link_dev("GSIC", 0x12, 0x12));
-    aml_append(sb_scope, build_gsi_link_dev("GSID", 0x13, 0x13));
-    aml_append(sb_scope, build_gsi_link_dev("GSIE", 0x14, 0x14));
-    aml_append(sb_scope, build_gsi_link_dev("GSIF", 0x15, 0x15));
-    aml_append(sb_scope, build_gsi_link_dev("GSIG", 0x16, 0x16));
-    aml_append(sb_scope, build_gsi_link_dev("GSIH", 0x17, 0x17));
+    aml_append(sb_scope, build_gsi_link_dev("GSIA", 0x10, 0x10,
+                                            level_trigger_unsupported));
+    aml_append(sb_scope, build_gsi_link_dev("GSIB", 0x11, 0x11,
+                                            level_trigger_unsupported));
+    aml_append(sb_scope, build_gsi_link_dev("GSIC", 0x12, 0x12,
+                                            level_trigger_unsupported));
+    aml_append(sb_scope, build_gsi_link_dev("GSID", 0x13, 0x13,
+                                            level_trigger_unsupported));
+    aml_append(sb_scope, build_gsi_link_dev("GSIE", 0x14, 0x14,
+                                            level_trigger_unsupported));
+    aml_append(sb_scope, build_gsi_link_dev("GSIF", 0x15, 0x15,
+                                            level_trigger_unsupported));
+    aml_append(sb_scope, build_gsi_link_dev("GSIG", 0x16, 0x16,
+                                            level_trigger_unsupported));
+    aml_append(sb_scope, build_gsi_link_dev("GSIH", 0x17, 0x17,
+                                            level_trigger_unsupported));
 
     aml_append(table, sb_scope);
 }
@@ -1426,6 +1458,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     PCMachineState *pcms = PC_MACHINE(machine);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(machine);
     X86MachineState *x86ms = X86_MACHINE(machine);
+    bool level_trigger_unsupported = x86ms->eoi_intercept_unsupported;
     AcpiMcfgInfo mcfg;
     bool mcfg_valid = !!acpi_get_mcfg(&mcfg);
     uint32_t nr_mem = machine->ram_slots;
@@ -1458,7 +1491,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         if (pm->pcihp_bridge_en || pm->pcihp_root_en) {
             build_x86_acpi_pci_hotplug(dsdt, pm->pcihp_io_base);
         }
-        build_piix4_pci0_int(dsdt);
+        build_piix4_pci0_int(dsdt, level_trigger_unsupported);
     } else if (q35) {
         sb_scope = aml_scope("_SB");
         dev = aml_device("PCI0");
@@ -1502,7 +1535,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         if (pm->pcihp_bridge_en) {
             build_x86_acpi_pci_hotplug(dsdt, pm->pcihp_io_base);
         }
-        build_q35_pci0_int(dsdt);
+        build_q35_pci0_int(dsdt, level_trigger_unsupported);
     }
 
     if (misc->has_hpet) {
diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
index 20f19269da40..d93281b13758 100644
--- a/hw/i386/acpi-common.c
+++ b/hw/i386/acpi-common.c
@@ -103,6 +103,7 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
     const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(MACHINE(x86ms));
     AcpiTable table = { .sig = "APIC", .rev = 3, .oem_id = oem_id,
                         .oem_table_id = oem_table_id };
+    bool level_trigger_unsupported = x86ms->eoi_intercept_unsupported;
 
     acpi_table_begin(&table, table_data);
     /* Local APIC Address */
@@ -122,18 +123,42 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
                      IO_APIC_SECONDARY_ADDRESS, IO_APIC_SECONDARY_IRQBASE);
     }
 
-    if (x86mc->apic_xrupt_override) {
-        build_xrupt_override(table_data, 0, 2,
-            0 /* Flags: Conforms to the specifications of the bus */);
-    }
+    if (level_trigger_unsupported) {
+        /* Force edge trigger */
+        if (x86mc->apic_xrupt_override) {
+            build_xrupt_override(table_data, 0, 2,
+                                 /* Flags: active high, edge triggered */
+                                 1 | (1 << 2));
+        }
+
+        for (i = x86mc->apic_xrupt_override ? 1 : 0; i < 16; i++) {
+            build_xrupt_override(table_data, i, i,
+                                 /* Flags: active high, edge triggered */
+                                 1 | (1 << 2));
+        }
+
+        if (x86ms->ioapic2) {
+            for (i = 0; i < 16; i++) {
+                build_xrupt_override(table_data, IO_APIC_SECONDARY_IRQBASE + i,
+                                     IO_APIC_SECONDARY_IRQBASE + i,
+                                     /* Flags: active high, edge triggered */
+                                     1 | (1 << 2));
+            }
+        }
+    } else {
+        if (x86mc->apic_xrupt_override) {
+            build_xrupt_override(table_data, 0, 2,
+                    0 /* Flags: Conforms to the specifications of the bus */);
+        }
 
-    for (i = 1; i < 16; i++) {
-        if (!(x86ms->pci_irq_mask & (1 << i))) {
-            /* No need for a INT source override structure. */
-            continue;
+        for (i = 1; i < 16; i++) {
+            if (!(x86ms->pci_irq_mask & (1 << i))) {
+                /* No need for a INT source override structure. */
+                continue;
+            }
+            build_xrupt_override(table_data, i, i,
+                0xd /* Flags: Active high, Level Triggered */);
         }
-        build_xrupt_override(table_data, i, i,
-            0xd /* Flags: Active high, Level Triggered */);
     }
 
     if (x2apic_mode) {
-- 
2.34.1


