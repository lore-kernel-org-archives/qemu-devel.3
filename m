Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F7EC25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 10:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9NB5-0000BG-HW; Tue, 21 May 2024 06:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>)
 id 1s9NB3-0000Aa-JV; Tue, 21 May 2024 06:57:05 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>)
 id 1s9NB1-0008JS-4c; Tue, 21 May 2024 06:57:05 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id A4EA2CE0EEE;
 Tue, 21 May 2024 10:56:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43970C2BD11;
 Tue, 21 May 2024 10:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716289018;
 bh=BF0Re7pZITalSThFSxkXg3hVynp1HCvG+nenL0gPfLs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=POL+lhgiVkPpuT0SkNNNyJ0AiFoxQ+rqMX7on4gd076BPxskkfyrihULaAql1sVAM
 1Ah95jMufB+E8z7K0DWZ3N37e7rr2fums6Sn0o4oT4EYA9Gw/D8Kp1pVzuGWXBGpI0
 lhOyRibdd/cxIUglnOGGaYT+o039Xhja6UPDCRrZUrDDG0mTIqWmjG3/GUESzeP1Uq
 lj6TJOB0whFu6xtqw5+NZ0TB8HL3IAG2Lc3typmS4iqcJKlnQ45QE6ovCx9NJ5igOT
 cGByKgGAnkClr0e1k/gKdCfRLwJxgXB0ptKHi/OBqoZdjB2DO/fek0DhAf/cqaQHCu
 nYCWEDmMIdFbA==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Atish Patra <atishp@atishpatra.org>, Atish Patra <atishp@rivosinc.com>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Santosh Mamila <santosh.mamila@catalinasystems.io>,
 Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
 Sivakumar Munnangi <siva.munnangi@catalinasystems.io>
Subject: [PATCH v2 3/3] hw/riscv/virt: Add ACPI GED and PC-DIMM MHP support
Date: Tue, 21 May 2024 12:56:35 +0200
Message-Id: <20240521105635.795211-4-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240521105635.795211-1-bjorn@kernel.org>
References: <20240521105635.795211-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=bjorn@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Björn Töpel <bjorn@rivosinc.com>

Add ACPI GED for the RISC-V "virt" machine, and wire up PC-DIMM memory
hotplugging support. Heavily based/copied from hw/arm/virt.c.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 hw/riscv/Kconfig           |   3 ++
 hw/riscv/virt-acpi-build.c |  16 ++++++
 hw/riscv/virt.c            | 104 ++++++++++++++++++++++++++++++++++++-
 include/hw/riscv/virt.h    |   6 ++-
 4 files changed, 126 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 08f82dbb681a..bebe412f2107 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -56,6 +56,9 @@ config RISCV_VIRT
     select PLATFORM_BUS
     select ACPI
     select ACPI_PCI
+    select MEM_DEVICE
+    select DIMM
+    select ACPI_HW_REDUCED
     select VIRTIO_MEM_SUPPORTED
     select VIRTIO_PMEM_SUPPORTED
 
diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 6dc3baa9ec86..61813abdef3f 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -27,6 +27,8 @@
 #include "hw/acpi/acpi-defs.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
+#include "hw/acpi/memory_hotplug.h"
+#include "hw/acpi/generic_event_device.h"
 #include "hw/acpi/pci.h"
 #include "hw/acpi/utils.h"
 #include "hw/intc/riscv_aclint.h"
@@ -432,6 +434,20 @@ static void build_dsdt(GArray *table_data,
         acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + VIRT_IRQCHIP_NUM_SOURCES * 2);
     }
 
+    if (s->acpi_dev) {
+        uint32_t event = object_property_get_uint(OBJECT(s->acpi_dev),
+                                                  "ged-event", &error_abort);
+
+        build_ged_aml(scope, "\\_SB."GED_DEVICE, HOTPLUG_HANDLER(s->acpi_dev),
+                      GED_IRQ, AML_SYSTEM_MEMORY, memmap[VIRT_ACPI_GED].base);
+
+        if (event & ACPI_GED_MEM_HOTPLUG_EVT) {
+            build_memory_hotplug_aml(scope, ms->ram_slots, "\\_SB", NULL,
+                                     AML_SYSTEM_MEMORY,
+                                     memmap[VIRT_PCDIMM_ACPI].base);
+        }
+    }
+
     aml_append(dsdt, scope);
 
     /* copy AML table into ACPI tables blob and patch header there */
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 443902f919d2..2e35890187f2 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -53,10 +53,13 @@
 #include "hw/pci-host/gpex.h"
 #include "hw/display/ramfb.h"
 #include "hw/acpi/aml-build.h"
+#include "hw/acpi/generic_event_device.h"
+#include "hw/acpi/memory_hotplug.h"
 #include "hw/mem/memory-device.h"
 #include "hw/virtio/virtio-mem-pci.h"
 #include "qapi/qapi-visit-common.h"
 #include "hw/virtio/virtio-iommu.h"
+#include "hw/mem/pc-dimm.h"
 
 /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QEMU. */
 static bool virt_use_kvm_aia(RISCVVirtState *s)
@@ -84,6 +87,8 @@ static const MemMapEntry virt_memmap[] = {
     [VIRT_UART0] =        { 0x10000000,         0x100 },
     [VIRT_VIRTIO] =       { 0x10001000,        0x1000 },
     [VIRT_FW_CFG] =       { 0x10100000,          0x18 },
+    [VIRT_PCDIMM_ACPI] =  { 0x10200000, MEMORY_HOTPLUG_IO_LEN },
+    [VIRT_ACPI_GED] =     { 0x10210000, ACPI_GED_EVT_SEL_LEN },
     [VIRT_FLASH] =        { 0x20000000,     0x4000000 },
     [VIRT_IMSIC_M] =      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
     [VIRT_IMSIC_S] =      { 0x28000000, VIRT_IMSIC_MAX_SIZE },
@@ -1400,6 +1405,28 @@ static void virt_machine_done(Notifier *notifier, void *data)
     }
 }
 
+static DeviceState *create_acpi_ged(RISCVVirtState *s)
+{
+    DeviceState *dev;
+    MachineState *ms = MACHINE(s);
+    uint32_t event = 0;
+
+    if (ms->ram_slots) {
+        event |= ACPI_GED_MEM_HOTPLUG_EVT;
+    }
+
+    dev = qdev_new(TYPE_ACPI_GED);
+    qdev_prop_set_uint32(dev, "ged-event", event);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, s->memmap[VIRT_ACPI_GED].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, s->memmap[VIRT_PCDIMM_ACPI].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(s->irqchip[0],
+                                                                GED_IRQ));
+
+    return dev;
+}
+
 static void virt_machine_init(MachineState *machine)
 {
     const MemMapEntry *memmap = virt_memmap;
@@ -1612,6 +1639,10 @@ static void virt_machine_init(MachineState *machine)
 
     gpex_pcie_init(system_memory, pcie_irqchip, s);
 
+    if (virt_is_acpi_enabled(s)) {
+        s->acpi_dev = create_acpi_ged(s);
+    }
+
     create_platform_bus(s, mmio_irqchip);
 
     serial_mm_init(system_memory, memmap[VIRT_UART0].base,
@@ -1752,6 +1783,7 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
     MachineClass *mc = MACHINE_GET_CLASS(machine);
 
     if (device_is_dynamic_sysbus(mc, dev) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
         object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI) ||
         object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
         return HOTPLUG_HANDLER(machine);
@@ -1759,14 +1791,42 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
     return NULL;
 }
 
+static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
+                                 Error **errp)
+{
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(hotplug_dev);
+
+    if (!s->acpi_dev) {
+        error_setg(errp,
+                   "memory hotplug is not enabled: missing acpi-ged device");
+        return;
+    }
+
+    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
+}
+
 static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
                                             DeviceState *dev, Error **errp)
 {
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+        virt_memory_pre_plug(hotplug_dev, dev, errp);
+    }
+
     if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
         virtio_md_pci_pre_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
     }
 }
 
+static void virt_memory_plug(HotplugHandler *hotplug_dev,
+                             DeviceState *dev, Error **errp)
+{
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(hotplug_dev);
+
+    pc_dimm_plug(PC_DIMM(dev), MACHINE(s));
+
+    hotplug_handler_plug(HOTPLUG_HANDLER(s->acpi_dev), dev, &error_abort);
+}
+
 static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
                                         DeviceState *dev, Error **errp)
 {
@@ -1785,16 +1845,36 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
         create_fdt_virtio_iommu(s, pci_get_bdf(PCI_DEVICE(dev)));
     }
 
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+        virt_memory_plug(hotplug_dev, dev, errp);
+    }
+
     if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
         virtio_md_pci_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
     }
 }
 
+static void virt_dimm_unplug_request(HotplugHandler *hotplug_dev,
+                                     DeviceState *dev, Error **errp)
+{
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(hotplug_dev);
+
+    if (!s->acpi_dev) {
+        error_setg(errp,
+                   "memory hotplug is not enabled: missing acpi-ged device");
+        return;
+    }
+
+    hotplug_handler_unplug_request(HOTPLUG_HANDLER(s->acpi_dev), dev, errp);
+}
+
 static void virt_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
                                                   DeviceState *dev,
                                                   Error **errp)
 {
-    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+        virt_dimm_unplug_request(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
         virtio_md_pci_unplug_request(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev),
                                      errp);
     } else {
@@ -1804,10 +1884,30 @@ static void virt_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
     }
 }
 
+static void virt_dimm_unplug(HotplugHandler *hotplug_dev,
+                             DeviceState *dev, Error **errp)
+{
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(hotplug_dev);
+    Error *local_err = NULL;
+
+    hotplug_handler_unplug(HOTPLUG_HANDLER(s->acpi_dev), dev, &local_err);
+    if (local_err) {
+        goto out;
+    }
+
+    pc_dimm_unplug(PC_DIMM(dev), MACHINE(s));
+    qdev_unrealize(dev);
+
+out:
+    error_propagate(errp, local_err);
+}
+
 static void virt_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
                                           DeviceState *dev, Error **errp)
 {
-    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+        virt_dimm_unplug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
         virtio_md_pci_unplug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
     } else {
         error_setg(errp, "virt: device unplug for unsupported device"
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 3db839160f95..adf460a4021e 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -62,6 +62,7 @@ struct RISCVVirtState {
     OnOffAuto acpi;
     const MemMapEntry *memmap;
     struct GPEXHost *gpex_host;
+    DeviceState *acpi_dev;
 };
 
 enum {
@@ -84,12 +85,15 @@ enum {
     VIRT_PCIE_MMIO,
     VIRT_PCIE_PIO,
     VIRT_PLATFORM_BUS,
-    VIRT_PCIE_ECAM
+    VIRT_PCIE_ECAM,
+    VIRT_PCDIMM_ACPI,
+    VIRT_ACPI_GED,
 };
 
 enum {
     UART0_IRQ = 10,
     RTC_IRQ = 11,
+    GED_IRQ = 12,
     VIRTIO_IRQ = 1, /* 1 to 8 */
     VIRTIO_COUNT = 8,
     PCIE_IRQ = 0x20, /* 32 to 35 */
-- 
2.40.1


