Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA17C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfIsr-00054h-W4; Thu, 02 Jul 2026 10:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wfIsp-000540-7g
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 10:59:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wfIsm-0004Nq-HN
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 10:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783004355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mLZvHEa88a5t0elI9BFGLNw2Uvrffm/QEBaUYlxF7eo=;
 b=AGvRlzsedT2AZ/O2jU0qLeXnBvJpV8AsBPQnMpoNwDX6i+6iOwDZtuSiWEDTx5ehHF0XaF
 TRG9evXWPhsaRV37jXQsj8DUHj1nxBcup0dBiIFa8lT7YqUfylpv59y/t/geHdB6PWYcRO
 8XWOaL23H1IdTeVg7DXj08bzWPOAQMI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433--vULYZ4CPYyRIggEL6oszw-1; Thu,
 02 Jul 2026 10:59:12 -0400
X-MC-Unique: -vULYZ4CPYyRIggEL6oszw-1
X-Mimecast-MFC-AGG-ID: -vULYZ4CPYyRIggEL6oszw_1783004351
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 371EC1944B10; Thu,  2 Jul 2026 14:59:11 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5F13C1800605; Thu,  2 Jul 2026 14:59:09 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, eauger@redhat.com, peter.maydell@linaro.org,
 shannon.zhaosl@gmail.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org
Subject: [PATCH v4 04/13] arm: virt: create sbsa-gwdt watchdog
Date: Thu,  2 Jul 2026 16:58:47 +0200
Message-ID: <20260702145856.1539572-5-imammedo@redhat.com>
In-Reply-To: <20260702145856.1539572-1-imammedo@redhat.com>
References: <20260702145856.1539572-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=no autolearn_force=no
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

Allow to use SBSA generic watchdog with virt machine type.
(includes conditional generation of corresponding FDT and
ACPI GTDT descriptors)

Use '-device sbsa-gwdt' to command line to enable it.

Instead of using dynamic sysbus infra to wire up MMIO/IRQ/FDT,
statically assign resources in machine's mem/irq maps and wire
them up at device (pre_)plug handlers. It's similar to dynamic
sysbus wiring, modulo resources are nailed down statically,
and wiring is limited to virt machine only.
(Benefit is that tests don't break anymore on rebase due to
address being stable)

Tested with Fedora 43:
  FDT: -M virt,acpi=off -device sbsa-gwdt
  ACPI: -M virt -device sbsa-gwdt

Note:
Windows sees GTDT, initializes watchdog but instead pinging WRR
it sets/advances WOR to way too large value, so it's never going
to trigger watchdog reboot (it's Windows driver issue though).

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v4:
  (Eric)
    - reorder [VIRT_GWDT_WS0] in irqmap after [VIRT_ACPI_GED]
    - add missing blank line in pre_plug handler
    - extract FDT node creation into create_gwdt_dt_bindings() helper
    - add watchdog documentation to docs/system/arm/virt.rst
    - add comment above dc->user_creatable about requiring
      machine-specific wiring
v3:
  - (Eric) assign MMIO/IRQ statically and abandon most of
     dynamic sysbus machinery.
  - (Peter) set watchdog freq to system clock explicitly,
    machine version compat won't work in case host is not runing
    1GHz clock. (Tested on Jetson machine)
---
 include/hw/arm/virt.h    |  3 +++
 docs/system/arm/virt.rst |  9 ++++++++
 hw/arm/Kconfig           |  1 +
 hw/arm/virt-acpi-build.c | 29 ++++++++++++++++++++++++--
 hw/arm/virt.c            | 44 ++++++++++++++++++++++++++++++++++++++++
 hw/core/sysbus-fdt.c     |  2 ++
 hw/watchdog/sbsa_gwdt.c  |  2 ++
 7 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 171d44c644..22e66d1a11 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -97,6 +97,9 @@ enum {
     VIRT_NVDIMM_ACPI,
     VIRT_PVTIME,
     VIRT_ACPI_PCIHP,
+    VIRT_GWDT_WS0,
+    VIRT_GWDT_REFRESH,
+    VIRT_GWDT_CONTROL,
     VIRT_LOWMEMMAP_LAST,
 };
 
diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index ae0be35d57..bf5a9c8f6c 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -39,6 +39,7 @@ The virt board supports:
 - A PL061 GPIO controller
 - An optional machine-wide SMMUv3 IOMMU
 - User-creatable SMMUv3 devices (see below for example)
+- An optional SBSA Generic Watchdog Timer (see below)
 - hotpluggable DIMMs
 - hotpluggable NVDIMMs
 - An MSI controller (GICv2m or ITS).
@@ -314,6 +315,14 @@ User-creatable SMMUv3 devices
   bypassing QEMU and improving throughput for workloads that issue many
   invalidations. Without it, every invalidation command traps into QEMU.
 
+SBSA Generic Watchdog
+"""""""""""""""""""""
+
+The SBSA Generic Watchdog Timer (GWDT) can be added to the virt machine
+using ``-device sbsa-gwdt``. It is only supported on the virt machine,
+which wires up statically assigned MMIO regions and IRQs via
+machine-specific plug handlers.
+
 Linux guest kernel configuration
 """"""""""""""""""""""""""""""""
 
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 5f5c4899ad..f9a225c19b 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -36,6 +36,7 @@ config ARM_VIRT
     select VIRTIO_MEM_SUPPORTED
     select ACPI_CXL
     select ACPI_HMAT
+    select WDT_SBSA
 
 config CUBIEBOARD
     bool
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 99490aa7b1..f5b3b4ce48 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -64,6 +64,7 @@
 #include "hw/virtio/virtio-acpi.h"
 #include "target/arm/cpu.h"
 #include "target/arm/multiprocessing.h"
+#include "hw/watchdog/sbsa_gwdt.h"
 
 #include "smmuv3-accel.h"
 #include "tegra241-cmdqv.h"
@@ -868,6 +869,8 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     const uint32_t irqflags = 0;  /* Interrupt is Level triggered  */
     AcpiTable table = { .sig = "GTDT", .rev = 3, .oem_id = vms->oem_id,
                         .oem_table_id = vms->oem_table_id };
+    uint32_t gtdt_start = table_data->len;
+    Object *wdt = object_resolve_type_unambiguous(TYPE_WDT_SBSA, NULL);
 
     acpi_table_begin(&table, table_data);
 
@@ -898,10 +901,15 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, irqflags, 4);
     /* CntReadBase Physical address */
     build_append_int_noprefix(table_data, 0xFFFFFFFFFFFFFFFF, 8);
+
     /* Platform Timer Count */
-    build_append_int_noprefix(table_data, 0, 4);
+    build_append_int_noprefix(table_data,  wdt ? 1 : 0, 4);
     /* Platform Timer Offset */
-    build_append_int_noprefix(table_data, 0, 4);
+    build_append_int_noprefix(table_data,
+        wdt ? (table_data->len - gtdt_start) +
+              4 + 4 + 4 /* len of this & following 2 fields to skip */
+            : 0, 4);
+
     if (vms->ns_el2_virt_timer_irq) {
         /* Virtual EL2 Timer GSIV */
         build_append_int_noprefix(table_data, ARCH_TIMER_NS_EL2_VIRT_IRQ, 4);
@@ -911,6 +919,23 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         build_append_int_noprefix(table_data, 0, 4);
         build_append_int_noprefix(table_data, 0, 4);
     }
+
+    /* ACPI 6.5 spec: 5.2.25.2 ARM Generic Watchdog Structure (Table 5-124) */
+    if (wdt) {
+        hwaddr rbase = vms->memmap[VIRT_GWDT_REFRESH].base;
+        hwaddr cbase = vms->memmap[VIRT_GWDT_CONTROL].base;
+        int irq = ARM_SPI_BASE + vms->irqmap[VIRT_GWDT_WS0];
+
+        build_append_int_noprefix(table_data, 1 /* Type: Watchdog GT */, 1);
+        build_append_int_noprefix(table_data, 28 /* Length */, 2);
+        build_append_int_noprefix(table_data, 0, 1);  /* Reserved */
+        /* RefreshFrame Physical Address */
+        build_append_int_noprefix(table_data, rbase, 8);
+        /* WatchdogControlFrame Physical Address */
+        build_append_int_noprefix(table_data, cbase, 8);
+        build_append_int_noprefix(table_data, irq, 4); /* Watchdog Timer GSIV */
+        build_append_int_noprefix(table_data, 0, 4); /* Watchdog Timer Flags */
+    }
     acpi_table_end(linker, &table);
 }
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d8d27f2ef6..eabc5274d5 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -95,6 +95,7 @@
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_host.h"
 #include "qemu/guest-random.h"
+#include "hw/watchdog/sbsa_gwdt.h"
 
 static GlobalProperty arm_virt_compat_defaults[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
@@ -214,6 +215,8 @@ static const MemMapEntry base_memmap[] = {
     /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
     [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
     [VIRT_SECURE_MEM] =         { 0x0e000000, 0x01000000 },
+    [VIRT_GWDT_REFRESH] =       { 0x0f000000, 0x00001000 },
+    [VIRT_GWDT_CONTROL] =       { 0x0f001000, 0x00001000 },
     [VIRT_PCIE_MMIO] =          { 0x10000000, 0x2eff0000 },
     [VIRT_PCIE_PIO] =           { 0x3eff0000, 0x00010000 },
     [VIRT_PCIE_ECAM] =          { 0x3f000000, 0x01000000 },
@@ -264,6 +267,7 @@ static const int a15irqmap[] = {
     [VIRT_GPIO] = 7,
     [VIRT_UART1] = 8,
     [VIRT_ACPI_GED] = 9,
+    [VIRT_GWDT_WS0] = 10,
     [VIRT_MMIO] = 16, /* ...to 16 + NUM_VIRTIO_TRANSPORTS - 1 */
     [VIRT_GIC_V2M] = 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
     [VIRT_SMMU] = 74,    /* ...to 74 + NUM_SMMU_IRQS - 1 */
@@ -2085,6 +2089,27 @@ static void create_smmu(const VirtMachineState *vms, PCIBus *bus)
     create_smmuv3_dt_bindings(vms, base, size, irq);
 }
 
+static void create_gwdt_dt_bindings(VirtMachineState *vms)
+{
+    MachineState *ms = MACHINE(vms);
+    hwaddr rbase = vms->memmap[VIRT_GWDT_REFRESH].base;
+    hwaddr cbase = vms->memmap[VIRT_GWDT_CONTROL].base;
+    int irq = vms->irqmap[VIRT_GWDT_WS0];
+    char *nodename = g_strdup_printf("/watchdog@%" PRIx64, cbase);
+
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+    qemu_fdt_setprop_string(ms->fdt, nodename,
+                            "compatible", "arm,sbsa-gwdt");
+    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
+                                 2, cbase, 2, SBSA_GWDT_CMMIO_SIZE,
+                                 2, rbase, 2, SBSA_GWDT_RMMIO_SIZE);
+    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
+                           GIC_FDT_IRQ_TYPE_SPI, irq,
+                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "timeout-sec", 30);
+    g_free(nodename);
+}
+
 static void create_virtio_iommu_dt_bindings(VirtMachineState *vms)
 {
     const char compat[] = "virtio,pci-iommu\0pci1af4,1057";
@@ -3820,6 +3845,11 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
         qlist_append_str(reserved_regions, resv_prop_str);
         qdev_prop_set_array(dev, "reserved-regions", reserved_regions);
         g_free(resv_prop_str);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_WDT_SBSA)) {
+        uint64_t cntfrq = object_property_get_int(OBJECT(qemu_get_cpu(0)),
+                                                  "cntfrq", &error_abort);
+
+        qdev_prop_set_uint64(dev, "clock-frequency", cntfrq);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_ARM_SMMUV3)) {
         if (vms->legacy_smmuv3_present || vms->iommu == VIRT_IOMMU_VIRTIO) {
             error_setg(errp, "virt machine already has %s set. "
@@ -3871,6 +3901,19 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
 {
     VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
 
+    if (object_dynamic_cast(OBJECT(dev), TYPE_WDT_SBSA)) {
+        SysBusDevice *s = SYS_BUS_DEVICE(dev);
+        hwaddr rbase = vms->memmap[VIRT_GWDT_REFRESH].base;
+        hwaddr cbase = vms->memmap[VIRT_GWDT_CONTROL].base;
+        int irq = vms->irqmap[VIRT_GWDT_WS0];
+
+        sysbus_mmio_map(s, 0, rbase);
+        sysbus_mmio_map(s, 1, cbase);
+        sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->gic, irq));
+
+        create_gwdt_dt_bindings(vms);
+    }
+
     if (vms->platform_bus_dev) {
         MachineClass *mc = MACHINE_GET_CLASS(vms);
 
@@ -4123,6 +4166,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_UEFI_VARS_SYSBUS);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ARM_SMMUV3);
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_WDT_SBSA);
 #ifdef CONFIG_TPM
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
 #endif
diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
index 89d0c46445..12238570b5 100644
--- a/hw/core/sysbus-fdt.c
+++ b/hw/core/sysbus-fdt.c
@@ -36,6 +36,7 @@
 #include "hw/display/ramfb.h"
 #include "hw/uefi/var-service-api.h"
 #include "hw/arm/fdt.h"
+#include "hw/watchdog/sbsa_gwdt.h"
 
 /*
  * internal struct that contains the information to create dynamic
@@ -140,6 +141,7 @@ static const BindingEntry bindings[] = {
     TYPE_BINDING(TYPE_ARM_SMMUV3, no_fdt_node),
     TYPE_BINDING(TYPE_RAMFB_DEVICE, no_fdt_node),
     TYPE_BINDING(TYPE_UEFI_VARS_SYSBUS, add_uefi_vars_node),
+    TYPE_BINDING(TYPE_WDT_SBSA, no_fdt_node),
     TYPE_BINDING("", NULL), /* last element */
 };
 
diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index acb970e8b3..49fdd723c2 100644
--- a/hw/watchdog/sbsa_gwdt.c
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -285,6 +285,8 @@ static void wdt_sbsa_gwdt_class_init(ObjectClass *klass, const void *data)
     dc->realize = wdt_sbsa_gwdt_realize;
     device_class_set_legacy_reset(dc, wdt_sbsa_gwdt_reset);
     dc->hotpluggable = false;
+    /* requires machine-specific wiring (MMIO/IRQ/FDT) at plug time */
+    dc->user_creatable = true;
     set_bit(DEVICE_CATEGORY_WATCHDOG, dc->categories);
     dc->vmsd = &vmstate_sbsa_gwdt;
     dc->desc = "SBSA-compliant generic watchdog device";
-- 
2.47.3


