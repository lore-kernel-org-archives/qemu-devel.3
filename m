Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE54EC047D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 09:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxM1N-0004DR-AB; Tue, 03 Mar 2026 04:26:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vxM1I-00049s-V6
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:26:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vxM1G-0004St-Md
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:26:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772529980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7PUVBe2IQNgjcOKWQH4SscP1oEuYAw2PvocIwATZt44=;
 b=d/0Kl1Z6LPlBntwJXRQQFvyQaQp/C8mUSz8ppWueDwHa+8uBwBhmHUYkh4MnSNL8wV2wPL
 iCAuwbqurAkpuo9XD65zbj2POeCbTlHCPpX6VHv2gU2j2Jg6GJ/AKbnZ/rTwMGpHg79tn6
 uD4RlYNRopuJdOMNLOeIvJTJjfbswDk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-Jb34bZShPJ2JuXfl59YZJQ-1; Tue,
 03 Mar 2026 04:26:17 -0500
X-MC-Unique: Jb34bZShPJ2JuXfl59YZJQ-1
X-Mimecast-MFC-AGG-ID: Jb34bZShPJ2JuXfl59YZJQ_1772529975
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C54D1956095; Tue,  3 Mar 2026 09:26:15 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E41A830001B9; Tue,  3 Mar 2026 09:26:12 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org
Subject: [PATCH v2 11/21] arm: virt: add support for WDAT based watchdog
Date: Tue,  3 Mar 2026 10:25:22 +0100
Message-ID: <20260303092532.2410177-12-imammedo@redhat.com>
In-Reply-To: <20260303092532.2410177-1-imammedo@redhat.com>
References: <20260303092532.2410177-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

And generate WDAT table tailored for sbsa_gwdt and disable
watchdog entry in GTDT ACPI table if WDAT is enabled,
since they are mutualy exclusive due to different
timer resolution of sbsa_gwdt.

To enable use "-device sbsa-gwdt,wdat=on" option

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/acpi/wdat-gwdt.h | 19 ++++++++
 hw/acpi/meson.build         |  2 +
 hw/acpi/wdat-gwdt-stub.c    | 16 +++++++
 hw/acpi/wdat-gwdt.c         | 92 +++++++++++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c    | 58 +++++++++++++++++------
 5 files changed, 172 insertions(+), 15 deletions(-)
 create mode 100644 include/hw/acpi/wdat-gwdt.h
 create mode 100644 hw/acpi/wdat-gwdt-stub.c
 create mode 100644 hw/acpi/wdat-gwdt.c

diff --git a/include/hw/acpi/wdat-gwdt.h b/include/hw/acpi/wdat-gwdt.h
new file mode 100644
index 0000000000..42339e031e
--- /dev/null
+++ b/include/hw/acpi/wdat-gwdt.h
@@ -0,0 +1,19 @@
+/*
+ * GWDT Watchdog Action Table (WDAT) definition
+ *
+ * Copyright Red Hat, Inc. 2026
+ * Author(s): Igor Mammedov <imammedo@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef QEMU_HW_ACPI_WDAT_GWDT_H
+#define QEMU_HW_ACPI_WDAT_GWDT_H
+
+#include "hw/acpi/aml-build.h"
+#include "hw/watchdog/sbsa_gwdt.h"
+
+void build_gwdt_wdat(GArray *table_data, BIOSLinker *linker, const char *oem_id,
+                     const char *oem_table_id, uint64_t rbase, uint64_t cbase,
+                     uint64_t freq);
+
+#endif /* QEMU_HW_ACPI_WDAT_GWDT_H */
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index 22290ca835..189bbb0257 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -28,12 +28,14 @@ acpi_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('ich9.c', 'ich9_tco.c', 'ic
 acpi_ss.add(when: 'CONFIG_ACPI_ERST', if_true: files('erst.c'))
 acpi_ss.add(when: 'CONFIG_IPMI', if_true: files('ipmi.c'), if_false: files('ipmi-stub.c'))
 acpi_ss.add(when: 'CONFIG_PC', if_false: files('acpi-x86-stub.c'))
+acpi_ss.add(when: 'CONFIG_WDT_SBSA', if_true: files('wdat-gwdt.c'))
 if have_tpm
   acpi_ss.add(files('tpm.c'))
 endif
 system_ss.add(when: 'CONFIG_ACPI', if_false: files('acpi-stub.c', 'aml-build-stub.c', 'ghes-stub.c', 'acpi_interface.c'))
 system_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_false: files('pci-bridge-stub.c'))
 system_ss.add(when: 'CONFIG_ACPI_ICH9', if_false: files('wdat-ich9-stub.c'))
+system_ss.add(when: 'CONFIG_WDT_SBSA', if_false: files('wdat-gwdt-stub.c'))
 system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
 system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
 system_ss.add(when: 'CONFIG_GHES_CPER', if_false: files('ghes_cper_stub.c'))
diff --git a/hw/acpi/wdat-gwdt-stub.c b/hw/acpi/wdat-gwdt-stub.c
new file mode 100644
index 0000000000..4d43783f70
--- /dev/null
+++ b/hw/acpi/wdat-gwdt-stub.c
@@ -0,0 +1,16 @@
+/*
+ * Copyright Red Hat, Inc. 2026
+ * Author(s): Igor Mammedov <imammedo@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/acpi/wdat-gwdt.h"
+
+void build_gwdt_wdat(GArray *table_data, BIOSLinker *linker, const char *oem_id,
+                     const char *oem_table_id, uint64_t rbase, uint64_t cbase,
+                     uint64_t freq)
+{
+    g_assert_not_reached();
+}
diff --git a/hw/acpi/wdat-gwdt.c b/hw/acpi/wdat-gwdt.c
new file mode 100644
index 0000000000..226ba3f01e
--- /dev/null
+++ b/hw/acpi/wdat-gwdt.c
@@ -0,0 +1,92 @@
+/*
+ * SBSA GWDT Watchdog Action Table (WDAT)
+ *
+ * Copyright Red Hat, Inc. 2026
+ * Author(s): Igor Mammedov <imammedo@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/acpi/aml-build.h"
+#include "hw/acpi/wdat-gwdt.h"
+#include "hw/acpi/wdat.h"
+#include "hw/watchdog/sbsa_gwdt.h"
+
+#define GWDT_REG(base, reg_offset, reg_width) { \
+                 .space_id = AML_AS_SYSTEM_MEMORY, \
+                 .address = base + reg_offset, .bit_width = reg_width, \
+                 .access_width = AML_DWORD_ACC };
+
+/*
+ *   "Hardware Watchdog Timers Design Specification"
+ *       https://uefi.org/acpi 'Watchdog Action Table (WDAT)'
+ */
+void build_gwdt_wdat(GArray *table_data, BIOSLinker *linker, const char *oem_id,
+                     const char *oem_table_id, uint64_t rbase, uint64_t cbase,
+                     uint64_t freq)
+{
+    AcpiTable table = { .sig = "WDAT", .rev = 1, .oem_id = oem_id,
+                        .oem_table_id = oem_table_id };
+
+    struct AcpiGenericAddress wrr =  GWDT_REG(rbase, 0x0, 32);
+    struct AcpiGenericAddress wor_l =  GWDT_REG(cbase, SBSA_GWDT_WOR, 32);
+    struct AcpiGenericAddress wcs =  GWDT_REG(cbase, SBSA_GWDT_WCS, 32);
+
+    acpi_table_begin(&table, table_data);
+    build_append_int_noprefix(table_data, 0x20, 4); /* Watchdog Header Length */
+    build_append_int_noprefix(table_data, 0xff, 2); /* PCI Segment */
+    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Bus Number */
+    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Device Number */
+    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Function Number */
+    build_append_int_noprefix(table_data, 0, 3);    /* Reserved */
+    /*
+     * WDAT spec suports only 1KHz or more coarse watchdog timer,
+     * Set resolution to minimum supported 1ms.
+     * Before starting watchdog Windows set countdown value to 5min.
+     */
+    g_assert(freq <= 1000);
+    build_append_int_noprefix(table_data, 1, 4);/* Timer Period, ms */
+    /*
+     * Needs to be more than 4min, otherwise Windows 11 won't start watchdog.
+     * Set max to limits to arbitrary max 10min and min to 5sec.
+     */
+    build_append_int_noprefix(table_data, 600 * freq, 4);/* Maximum Count */
+    build_append_int_noprefix(table_data, 5 * freq, 4);  /* Minimum Count */
+    /*
+     * WATCHDOG_ENABLED
+     */
+    build_append_int_noprefix(table_data, 0x81, 1); /* Watchdog Flags */
+    build_append_int_noprefix(table_data, 0, 3);    /* Reserved */
+    /*
+     * watchdog instruction entries
+     */
+    build_append_int_noprefix(table_data, 8, 4);
+    /* Action table */
+    build_append_wdat_ins(table_data, WDAT_ACTION_QUERY_RUNNING_STATE,
+        WDAT_INS_READ_VALUE,
+        wcs, 0x1, 0x1);
+    build_append_wdat_ins(table_data, WDAT_ACTION_RESET,
+        WDAT_INS_WRITE_VALUE,
+        wrr, 0x1, 0x7);
+    build_append_wdat_ins(table_data, WDAT_ACTION_SET_COUNTDOWN_PERIOD,
+        WDAT_INS_WRITE_COUNTDOWN,
+        wor_l, 0, 0xffffffff);
+    build_append_wdat_ins(table_data, WDAT_ACTION_SET_RUNNING_STATE,
+        WDAT_INS_WRITE_VALUE | WDAT_INS_PRESERVE_REGISTER,
+        wcs, 1, 0x00000001);
+    build_append_wdat_ins(table_data, WDAT_ACTION_QUERY_STOPPED_STATE,
+        WDAT_INS_READ_VALUE,
+        wcs, 0x0, 0x00000001);
+    build_append_wdat_ins(table_data, WDAT_ACTION_SET_STOPPED_STATE,
+        WDAT_INS_WRITE_VALUE | WDAT_INS_PRESERVE_REGISTER,
+        wcs, 0x0, 0x00000001);
+    build_append_wdat_ins(table_data, WDAT_ACTION_QUERY_WATCHDOG_STATUS,
+        WDAT_INS_READ_VALUE,
+        wcs, 0x4, 0x00000004);
+    build_append_wdat_ins(table_data, WDAT_ACTION_SET_WATCHDOG_STATUS,
+        WDAT_INS_WRITE_VALUE | WDAT_INS_PRESERVE_REGISTER,
+        wrr, 0x4, 0x4);
+
+    acpi_table_end(linker, &table);
+}
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 9c14b1d4d5..e9670b1a2b 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -65,6 +65,7 @@
 #include "target/arm/cpu.h"
 #include "target/arm/multiprocessing.h"
 #include "hw/watchdog/sbsa_gwdt.h"
+#include "hw/acpi/wdat-gwdt.h"
 
 #define ARM_SPI_BASE 32
 
@@ -849,12 +850,25 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     acpi_table_end(linker, &table);
 }
 
+static void virt_get_wdt_options(VirtMachineState *vms, Object *wdt,
+                                 hwaddr *rbase, hwaddr *cbase, int *irq)
+{
+    PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
+    SysBusDevice *sd = SYS_BUS_DEVICE(wdt);
+    hwaddr mmio_base = vms->memmap[VIRT_PLATFORM_BUS].base;
+    *rbase = mmio_base + platform_bus_get_mmio_addr(pbus, sd, 0);
+    *cbase = mmio_base + platform_bus_get_mmio_addr(pbus, sd, 1);
+    *irq = ARM_SPI_BASE + vms->irqmap[VIRT_PLATFORM_BUS] +
+           platform_bus_get_irqn(pbus, sd, 0);
+}
+
 /*
  * ACPI spec, Revision 6.5
  * 5.2.25 Generic Timer Description Table (GTDT)
  */
 static void
-build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
+build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms,
+           Object *wdt, bool add_watchdog)
 {
     /*
      * Table 5-117 Flag Definitions
@@ -865,7 +879,6 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     AcpiTable table = { .sig = "GTDT", .rev = 3, .oem_id = vms->oem_id,
                         .oem_table_id = vms->oem_table_id };
     uint32_t gtdt_start = table_data->len;
-    Object *wdt = object_resolve_type_unambiguous(TYPE_WDT_SBSA, NULL);
 
     acpi_table_begin(&table, table_data);
 
@@ -898,12 +911,12 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, 0xFFFFFFFFFFFFFFFF, 8);
 
     /* Platform Timer Count */
-    build_append_int_noprefix(table_data,  wdt ? 1 : 0, 4);
+    build_append_int_noprefix(table_data,  add_watchdog ? 1 : 0, 4);
     /* Platform Timer Offset */
     build_append_int_noprefix(table_data,
-        wdt ? (table_data->len - gtdt_start) +
-              4 + 4 + 4 /* len of this & following 2 fields to skip */
-            : 0, 4);
+        add_watchdog ? (table_data->len - gtdt_start) +
+                       4 + 4 + 4 /* len of this & following 2 fields to skip */
+                     : 0, 4);
 
     if (vms->ns_el2_virt_timer_irq) {
         /* Virtual EL2 Timer GSIV */
@@ -916,14 +929,10 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     }
 
     /* ACPI 6.5 spec: 5.2.25.2 ARM Generic Watchdog Structure (Table 5-124) */
-    if (wdt) {
-        PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
-        SysBusDevice *sd = SYS_BUS_DEVICE(wdt);
-        hwaddr mmio_base = vms->memmap[VIRT_PLATFORM_BUS].base;
-        hwaddr rbase = mmio_base + platform_bus_get_mmio_addr(pbus, sd, 0);
-        hwaddr cbase = mmio_base + platform_bus_get_mmio_addr(pbus, sd, 1);
-        int irq = ARM_SPI_BASE + vms->irqmap[VIRT_PLATFORM_BUS] +
-                  platform_bus_get_irqn(pbus, sd, 0);
+    if (add_watchdog) {
+        int irq;
+        hwaddr rbase, cbase;
+        virt_get_wdt_options(vms, wdt, &rbase, &cbase, &irq);
 
         build_append_int_noprefix(table_data, 1 /* Type: Watchdog GT */, 1);
         build_append_int_noprefix(table_data, 28 /* Length */, 2);
@@ -1282,8 +1291,14 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     GArray *table_offsets;
     unsigned dsdt, xsdt;
+    bool has_wdat = false;
     GArray *tables_blob = tables->table_data;
     MachineState *ms = MACHINE(vms);
+    Object *wdt = object_resolve_type_unambiguous(TYPE_WDT_SBSA, NULL);
+
+    if (wdt) {
+        has_wdat = object_property_get_bool(wdt, "wdat", &error_abort);
+    }
 
     table_offsets = g_array_new(false, true /* clear */,
                                         sizeof(uint32_t));
@@ -1303,6 +1318,19 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     acpi_add_table(table_offsets, tables_blob);
     build_madt(tables_blob, tables->linker, vms);
 
+    acpi_add_table(table_offsets, tables_blob);
+    if (wdt && has_wdat) {
+        int irq;
+        hwaddr rbase, cbase;
+        uint64_t freq = object_property_get_uint(wdt, "clock-frequency",
+                                                 &error_abort);
+        virt_get_wdt_options(vms, wdt, &rbase, &cbase, &irq);
+
+        build_gwdt_wdat(tables_blob, tables->linker,
+                        vms->oem_id, vms->oem_table_id,
+                        rbase, cbase, freq);
+    }
+
     if (!vmc->no_cpu_topology) {
         acpi_add_table(table_offsets, tables_blob);
         build_pptt(tables_blob, tables->linker, ms,
@@ -1310,7 +1338,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     }
 
     acpi_add_table(table_offsets, tables_blob);
-    build_gtdt(tables_blob, tables->linker, vms);
+    build_gtdt(tables_blob, tables->linker, vms, wdt, wdt && !has_wdat);
 
     acpi_add_table(table_offsets, tables_blob);
     {
-- 
2.47.3


