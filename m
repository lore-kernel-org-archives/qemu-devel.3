Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D050DEC0463
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 09:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxM1K-0004BS-KE; Tue, 03 Mar 2026 04:26:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vxM1B-00041q-CP
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:26:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vxM19-0004SH-Io
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:26:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772529975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mg3ThAafWCTqWSQBaZM61tCDkORhEPiGIip8dnlp6kk=;
 b=P1L5qZA5Uz8eXtDOnOQ+shEZxVJn4FLHG1B/Af732Evyh/o0xGgwzT746HGu/lfO3xOBZg
 qG5QNHQS1Man8SaplKoG8zp2SuQL/fQw0bBvTy2KswfS3+R7QgY9zrFOhFlagOexw+ljgQ
 XRC5EpfS2PLtkLp1pu3yIR+tystk5Ow=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-eW7UQOz5PKywGtSaCtaheQ-1; Tue,
 03 Mar 2026 04:26:10 -0500
X-MC-Unique: eW7UQOz5PKywGtSaCtaheQ-1
X-Mimecast-MFC-AGG-ID: eW7UQOz5PKywGtSaCtaheQ_1772529969
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F9AC1956096; Tue,  3 Mar 2026 09:26:09 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E1E8330001B9; Tue,  3 Mar 2026 09:26:06 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org
Subject: [PATCH v2 09/21] arm: virt: create sbsa_gwdt watchdog
Date: Tue,  3 Mar 2026 10:25:20 +0100
Message-ID: <20260303092532.2410177-10-imammedo@redhat.com>
In-Reply-To: <20260303092532.2410177-1-imammedo@redhat.com>
References: <20260303092532.2410177-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Allow to use SBSA generic watchdog with virt machine type.
(includes conditional generation of corresponding FDT and
ACPI GTDT descriptors)

Use '-device sbsa_gwdt' to command line to enable it.

Tested with Fedora 43:
  FDT: -M virt,acpi=off -device sbsa_gwdt
  ACPI: -M virt -device sbsa_gwdt

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/arm/Kconfig           |  1 +
 hw/arm/virt-acpi-build.c | 33 +++++++++++++++++++++++++++++++--
 hw/arm/virt.c            |  2 ++
 hw/core/sysbus-fdt.c     | 32 ++++++++++++++++++++++++++++++++
 hw/watchdog/sbsa_gwdt.c  |  1 +
 5 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index c66c452737..1222efadd1 100644
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
index 719d2f994e..9c14b1d4d5 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -64,6 +64,7 @@
 #include "hw/virtio/virtio-acpi.h"
 #include "target/arm/cpu.h"
 #include "target/arm/multiprocessing.h"
+#include "hw/watchdog/sbsa_gwdt.h"
 
 #define ARM_SPI_BASE 32
 
@@ -863,6 +864,8 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     const uint32_t irqflags = 0;  /* Interrupt is Level triggered  */
     AcpiTable table = { .sig = "GTDT", .rev = 3, .oem_id = vms->oem_id,
                         .oem_table_id = vms->oem_table_id };
+    uint32_t gtdt_start = table_data->len;
+    Object *wdt = object_resolve_type_unambiguous(TYPE_WDT_SBSA, NULL);
 
     acpi_table_begin(&table, table_data);
 
@@ -893,10 +896,15 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
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
@@ -906,6 +914,27 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         build_append_int_noprefix(table_data, 0, 4);
         build_append_int_noprefix(table_data, 0, 4);
     }
+
+    /* ACPI 6.5 spec: 5.2.25.2 ARM Generic Watchdog Structure (Table 5-124) */
+    if (wdt) {
+        PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
+        SysBusDevice *sd = SYS_BUS_DEVICE(wdt);
+        hwaddr mmio_base = vms->memmap[VIRT_PLATFORM_BUS].base;
+        hwaddr rbase = mmio_base + platform_bus_get_mmio_addr(pbus, sd, 0);
+        hwaddr cbase = mmio_base + platform_bus_get_mmio_addr(pbus, sd, 1);
+        int irq = ARM_SPI_BASE + vms->irqmap[VIRT_PLATFORM_BUS] +
+                  platform_bus_get_irqn(pbus, sd, 0);
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
index cab2e21e8a..a87991b591 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -95,6 +95,7 @@
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_host.h"
 #include "qemu/guest-random.h"
+#include "hw/watchdog/sbsa_gwdt.h"
 
 static GlobalProperty arm_virt_compat_defaults[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
@@ -3474,6 +3475,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_UEFI_VARS_SYSBUS);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ARM_SMMUV3);
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_WDT_SBSA);
 #ifdef CONFIG_TPM
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
 #endif
diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
index 89d0c46445..76aa1bc579 100644
--- a/hw/core/sysbus-fdt.c
+++ b/hw/core/sysbus-fdt.c
@@ -36,6 +36,7 @@
 #include "hw/display/ramfb.h"
 #include "hw/uefi/var-service-api.h"
 #include "hw/arm/fdt.h"
+#include "hw/watchdog/sbsa_gwdt.h"
 
 /*
  * internal struct that contains the information to create dynamic
@@ -118,6 +119,36 @@ static int add_uefi_vars_node(SysBusDevice *sbdev, void *opaque)
     return 0;
 }
 
+static int add_sbsa_gwdt_node(SysBusDevice *sbdev, void *opaque)
+{
+    PlatformBusFDTData *data = opaque;
+    PlatformBusDevice *pbus = data->pbus;
+    const char *parent_node = data->pbus_node_name;
+    void *fdt = data->fdt;
+    uint64_t cbase, rbase;
+    char *nodename;
+    int irq;
+
+    cbase = platform_bus_get_mmio_addr(pbus, sbdev, 1);  /* control frame */
+    rbase = platform_bus_get_mmio_addr(pbus, sbdev, 0);  /* refresh frame */
+    irq = platform_bus_get_irqn(pbus, sbdev, 0);
+
+    nodename = g_strdup_printf("%s/watchdog@%" PRIx64, parent_node, cbase);
+    qemu_fdt_add_subnode(fdt, nodename);
+
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "arm,sbsa-gwdt");
+    qemu_fdt_setprop_cells(fdt, nodename, "reg",
+                           cbase, SBSA_GWDT_CMMIO_SIZE,
+                           rbase, SBSA_GWDT_RMMIO_SIZE);
+    qemu_fdt_setprop_cells(fdt, nodename, "interrupts",
+                           GIC_FDT_IRQ_TYPE_SPI, data->irq_start + irq,
+                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+    qemu_fdt_setprop_cell(fdt, nodename, "timeout-sec", 30);
+
+    g_free(nodename);
+    return 0;
+}
+
 static int no_fdt_node(SysBusDevice *sbdev, void *opaque)
 {
     return 0;
@@ -140,6 +171,7 @@ static const BindingEntry bindings[] = {
     TYPE_BINDING(TYPE_ARM_SMMUV3, no_fdt_node),
     TYPE_BINDING(TYPE_RAMFB_DEVICE, no_fdt_node),
     TYPE_BINDING(TYPE_UEFI_VARS_SYSBUS, add_uefi_vars_node),
+    TYPE_BINDING(TYPE_WDT_SBSA, add_sbsa_gwdt_node),
     TYPE_BINDING("", NULL), /* last element */
 };
 
diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index acb970e8b3..c4dd8005b7 100644
--- a/hw/watchdog/sbsa_gwdt.c
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -285,6 +285,7 @@ static void wdt_sbsa_gwdt_class_init(ObjectClass *klass, const void *data)
     dc->realize = wdt_sbsa_gwdt_realize;
     device_class_set_legacy_reset(dc, wdt_sbsa_gwdt_reset);
     dc->hotpluggable = false;
+    dc->user_creatable = true;
     set_bit(DEVICE_CATEGORY_WATCHDOG, dc->categories);
     dc->vmsd = &vmstate_sbsa_gwdt;
     dc->desc = "SBSA-compliant generic watchdog device";
-- 
2.47.3


