Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF13C43602
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfIsy-0005Au-Sz; Thu, 02 Jul 2026 10:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wfIsw-0005A6-PA
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 10:59:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wfIsv-0004QC-2a
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 10:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783004364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vPtLXtDs1quwQoKW3oUgsV/vU6Ks6Nz7WqQkGI+WJLA=;
 b=BQW1cWgifCjB8vpDVkcR03990JIUlAEEOtzZcHhLretDFdhol0R1QvWyl4KLCGlMvtsW19
 26LH4RjYdzk+SBpOMOzSNJFGCVzVhZH8s1hvDfUOEdXuNAVxnbhq5dY9b/snOQb3x44gEM
 8KMiDJALt/kMCdNqbF2KWZa5yKmIpUU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-8nwYI2MqNF21xdPQY120pA-1; Thu,
 02 Jul 2026 10:59:19 -0400
X-MC-Unique: 8nwYI2MqNF21xdPQY120pA-1
X-Mimecast-MFC-AGG-ID: 8nwYI2MqNF21xdPQY120pA_1783004358
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3437F18333A6; Thu,  2 Jul 2026 14:59:18 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 23281180058D; Thu,  2 Jul 2026 14:59:15 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, eauger@redhat.com, peter.maydell@linaro.org,
 shannon.zhaosl@gmail.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v4 07/13] arm: virt: add support for WDAT based watchdog
Date: Thu,  2 Jul 2026 16:58:50 +0200
Message-ID: <20260702145856.1539572-8-imammedo@redhat.com>
In-Reply-To: <20260702145856.1539572-1-imammedo@redhat.com>
References: <20260702145856.1539572-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=unavailable autolearn_force=no
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

Add WDAT handling for sbsa-gwdt on arm/virt machine.

WDAT mode is enabled by 'wdat' option: ex: "-device sbsa-gwdt,wdat=on"

When WDAT is enabled:
 - Build the WDAT ACPI table instead of the GTDT watchdog entry,
   since they are mutually exclusive due to different timer
   resolution (WDAT uses 1 kHz vs GTDT's system counter frequency).
 - Skip FDT watchdog node creation, as the DT-based Linux driver
   would use the system counter frequency which doesn't match the
   WDAT-mode 1 kHz clock.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
v4:
  (Eric)
    - remove unused 'wdt' parameter from build_gtdt()
    - add Native/WDAT modes documentation to docs/system/arm/virt.rst
v3:
   - Skip FDT watchdog node creation in wdat mode
   (Eric)
     - wiring part of larger '[PATCH v2 11/21] arm: virt: add support for WDAT based watchdog'
---
 docs/system/arm/virt.rst | 15 +++++++++++++++
 hw/arm/virt-acpi-build.c | 34 ++++++++++++++++++++++++++--------
 hw/arm/virt.c            | 12 ++++++++----
 3 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index bf5a9c8f6c..5f6dd17978 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -323,6 +323,21 @@ using ``-device sbsa-gwdt``. It is only supported on the virt machine,
 which wires up statically assigned MMIO regions and IRQs via
 machine-specific plug handlers.
 
+Two modes are available:
+
+Native mode (default)
+  The watchdog is described via the ACPI GTDT table and FDT, using
+  the system counter frequency. Example::
+
+    -device sbsa-gwdt
+
+WDAT mode
+  The watchdog is described via the ACPI WDAT table (no FDT node),
+  using a 1 kHz timer frequency. WDAT and GTDT watchdog entries are
+  mutually exclusive. Example::
+
+    -device sbsa-gwdt,wdat=on
+
 Linux guest kernel configuration
 """"""""""""""""""""""""""""""""
 
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index f5b3b4ce48..f6386088b6 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -65,6 +65,7 @@
 #include "target/arm/cpu.h"
 #include "target/arm/multiprocessing.h"
 #include "hw/watchdog/sbsa_gwdt.h"
+#include "hw/acpi/wdat-gwdt.h"
 
 #include "smmuv3-accel.h"
 #include "tegra241-cmdqv.h"
@@ -859,7 +860,8 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
  * 5.2.25 Generic Timer Description Table (GTDT)
  */
 static void
-build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
+build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms,
+           bool add_watchdog)
 {
     /*
      * Table 5-117 Flag Definitions
@@ -870,7 +872,6 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     AcpiTable table = { .sig = "GTDT", .rev = 3, .oem_id = vms->oem_id,
                         .oem_table_id = vms->oem_table_id };
     uint32_t gtdt_start = table_data->len;
-    Object *wdt = object_resolve_type_unambiguous(TYPE_WDT_SBSA, NULL);
 
     acpi_table_begin(&table, table_data);
 
@@ -903,12 +904,12 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
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
@@ -921,7 +922,7 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     }
 
     /* ACPI 6.5 spec: 5.2.25.2 ARM Generic Watchdog Structure (Table 5-124) */
-    if (wdt) {
+    if (add_watchdog) {
         hwaddr rbase = vms->memmap[VIRT_GWDT_REFRESH].base;
         hwaddr cbase = vms->memmap[VIRT_GWDT_CONTROL].base;
         int irq = ARM_SPI_BASE + vms->irqmap[VIRT_GWDT_WS0];
@@ -1332,13 +1333,19 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     GArray *table_offsets;
     unsigned dsdt, xsdt;
+    bool has_wdat = false;
     GArray *tables_blob = tables->table_data;
     MachineState *ms = MACHINE(vms);
     CPUCoreCaches caches[CPU_MAX_CACHES];
     unsigned int num_caches;
+    Object *wdt = object_resolve_type_unambiguous(TYPE_WDT_SBSA, NULL);
 
     num_caches = virt_get_caches(vms, caches);
 
+    if (wdt) {
+        has_wdat = object_property_get_bool(wdt, "wdat", &error_abort);
+    }
+
     table_offsets = g_array_new(false, true /* clear */,
                                         sizeof(uint32_t));
 
@@ -1357,6 +1364,17 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     acpi_add_table(table_offsets, tables_blob);
     build_madt(tables_blob, tables->linker, vms);
 
+    acpi_add_table(table_offsets, tables_blob);
+    if (wdt && has_wdat) {
+        uint64_t freq = object_property_get_uint(wdt, "clock-frequency",
+                                                 &error_abort);
+        build_gwdt_wdat(tables_blob, tables->linker,
+                        vms->oem_id, vms->oem_table_id,
+                        vms->memmap[VIRT_GWDT_REFRESH].base,
+                        vms->memmap[VIRT_GWDT_CONTROL].base,
+                        freq);
+    }
+
     if (!vmc->no_cpu_topology) {
         acpi_add_table(table_offsets, tables_blob);
         build_pptt(tables_blob, tables->linker, ms, vms->oem_id,
@@ -1364,7 +1382,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     }
 
     acpi_add_table(table_offsets, tables_blob);
-    build_gtdt(tables_blob, tables->linker, vms);
+    build_gtdt(tables_blob, tables->linker, vms, wdt && !has_wdat);
 
     acpi_add_table(table_offsets, tables_blob);
     {
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index eabc5274d5..fb916c341b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3846,10 +3846,12 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
         qdev_prop_set_array(dev, "reserved-regions", reserved_regions);
         g_free(resv_prop_str);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_WDT_SBSA)) {
-        uint64_t cntfrq = object_property_get_int(OBJECT(qemu_get_cpu(0)),
-                                                  "cntfrq", &error_abort);
+        if (!object_property_get_bool(OBJECT(dev), "wdat", &error_abort)) {
+            uint64_t cntfrq = object_property_get_int(OBJECT(qemu_get_cpu(0)),
+                                                      "cntfrq", &error_abort);
 
-        qdev_prop_set_uint64(dev, "clock-frequency", cntfrq);
+            qdev_prop_set_uint64(dev, "clock-frequency", cntfrq);
+        }
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_ARM_SMMUV3)) {
         if (vms->legacy_smmuv3_present || vms->iommu == VIRT_IOMMU_VIRTIO) {
             error_setg(errp, "virt machine already has %s set. "
@@ -3911,7 +3913,9 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
         sysbus_mmio_map(s, 1, cbase);
         sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->gic, irq));
 
-        create_gwdt_dt_bindings(vms);
+        if (!object_property_get_bool(OBJECT(dev), "wdat", &error_abort)) {
+            create_gwdt_dt_bindings(vms);
+        }
     }
 
     if (vms->platform_bus_dev) {
-- 
2.47.3


