Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A2DC25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 10:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9NB1-000094-81; Tue, 21 May 2024 06:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>)
 id 1s9NAv-00006R-9z; Tue, 21 May 2024 06:56:57 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>)
 id 1s9NAs-0008In-SM; Tue, 21 May 2024 06:56:57 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 723B1CE0F0B;
 Tue, 21 May 2024 10:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1484DC32786;
 Tue, 21 May 2024 10:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716289010;
 bh=28t7Fg5B6krxDtsXGakeNIyt+SyVFB/V4qTfbcdgegE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=b+kijK/5NwxHq37VHxPk9CnFTZzTKVXAJTF0nlXAHUWo3pDYn0Kv3AzOW4KQ17iCv
 jLT9X90Lqhy/xg3HMyD2vsE0SepnZWtoMpVs0DPfOeSE/MzsS6k2vtoZELb/hBrJ7p
 XrPDXqlXTHWNNO21N7e0vlfpz1B7018EVSayHWoViIwa5Jy+TeAENNwb3AA6PPDAcI
 hOeegx3IY6jK41Bol65ERNckXqyGoVAYSPad88yeKLo2R//4LHrgzRcyc+K2qLSstg
 tNGTEcfKvPxP0HnKSUt0+EN91iga0y97ycp+pXfwWLXa91Ng00AiKs/7uMfBW5A4TA
 pf/NJijogxEmA==
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
Subject: [PATCH v2 1/3] hw/riscv/virt: Add memory hotplugging and
 virtio-md-pci support
Date: Tue, 21 May 2024 12:56:33 +0200
Message-Id: <20240521105635.795211-2-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240521105635.795211-1-bjorn@kernel.org>
References: <20240521105635.795211-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.73.55; envelope-from=bjorn@kernel.org;
 helo=sin.source.kernel.org
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

Virtio-based memory devices (virtio-mem/virtio-pmem) allows for
dynamic resizing of virtual machine memory, and requires proper
hotplugging (add/remove) support to work.

Add device memory support for RISC-V "virt" machine, and enable
virtio-md-pci with the corresponding missing hotplugging callbacks.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 hw/riscv/Kconfig       |  2 +
 hw/riscv/virt.c        | 83 +++++++++++++++++++++++++++++++++++++++++-
 hw/virtio/virtio-mem.c |  5 ++-
 3 files changed, 87 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index a2030e3a6ff0..08f82dbb681a 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -56,6 +56,8 @@ config RISCV_VIRT
     select PLATFORM_BUS
     select ACPI
     select ACPI_PCI
+    select VIRTIO_MEM_SUPPORTED
+    select VIRTIO_PMEM_SUPPORTED
 
 config SHAKTI_C
     bool
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 4fdb66052587..443902f919d2 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -53,6 +53,8 @@
 #include "hw/pci-host/gpex.h"
 #include "hw/display/ramfb.h"
 #include "hw/acpi/aml-build.h"
+#include "hw/mem/memory-device.h"
+#include "hw/virtio/virtio-mem-pci.h"
 #include "qapi/qapi-visit-common.h"
 #include "hw/virtio/virtio-iommu.h"
 
@@ -1407,6 +1409,7 @@ static void virt_machine_init(MachineState *machine)
     DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip;
     int i, base_hartid, hart_count;
     int socket_count = riscv_socket_count(machine);
+    hwaddr device_memory_base, device_memory_size;
 
     /* Check socket count limit */
     if (VIRT_SOCKETS_MAX < socket_count) {
@@ -1420,6 +1423,12 @@ static void virt_machine_init(MachineState *machine)
         exit(1);
     }
 
+    if (machine->ram_slots > ACPI_MAX_RAM_SLOTS) {
+        error_report("unsupported amount of memory slots: %"PRIu64,
+                     machine->ram_slots);
+        exit(EXIT_FAILURE);
+    }
+
     /* Initialize sockets */
     mmio_irqchip = virtio_irqchip = pcie_irqchip = NULL;
     for (i = 0; i < socket_count; i++) {
@@ -1553,6 +1562,37 @@ static void virt_machine_init(MachineState *machine)
     memory_region_add_subregion(system_memory, memmap[VIRT_MROM].base,
                                 mask_rom);
 
+    /* device memory */
+    device_memory_base = ROUND_UP(s->memmap[VIRT_DRAM].base + machine->ram_size,
+                                  GiB);
+    device_memory_size = machine->maxram_size - machine->ram_size;
+    if (device_memory_size > 0) {
+        /*
+         * Each DIMM is aligned based on the backend's alignment value.
+         * Assume max 1G hugepage alignment per slot.
+         */
+        device_memory_size += machine->ram_slots * GiB;
+
+        if (riscv_is_32bit(&s->soc[0])) {
+            hwaddr memtop = device_memory_base + ROUND_UP(device_memory_size,
+                                                          GiB);
+
+            if (memtop > UINT32_MAX) {
+                error_report("memory exceeds 32-bit limit by %lu bytes",
+                             memtop - UINT32_MAX);
+                exit(EXIT_FAILURE);
+            }
+        }
+
+        if (device_memory_base + device_memory_size < device_memory_size) {
+            error_report("unsupported amount of device memory");
+            exit(EXIT_FAILURE);
+        }
+
+        machine_memory_devices_init(machine, device_memory_base,
+                                    device_memory_size);
+    }
+
     /*
      * Init fw_cfg. Must be done before riscv_load_fdt, otherwise the
      * device tree cannot be altered and we get FDT_ERR_NOSPACE.
@@ -1712,12 +1752,21 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
     MachineClass *mc = MACHINE_GET_CLASS(machine);
 
     if (device_is_dynamic_sysbus(mc, dev) ||
-        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
+        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
         return HOTPLUG_HANDLER(machine);
     }
     return NULL;
 }
 
+static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
+                                            DeviceState *dev, Error **errp)
+{
+    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
+        virtio_md_pci_pre_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
+    }
+}
+
 static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
                                         DeviceState *dev, Error **errp)
 {
@@ -1735,6 +1784,35 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
     if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
         create_fdt_virtio_iommu(s, pci_get_bdf(PCI_DEVICE(dev)));
     }
+
+    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
+        virtio_md_pci_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
+    }
+}
+
+static void virt_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
+                                                  DeviceState *dev,
+                                                  Error **errp)
+{
+    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
+        virtio_md_pci_unplug_request(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev),
+                                     errp);
+    } else {
+        error_setg(errp,
+                   "device unplug request for unsupported device type: %s",
+                   object_get_typename(OBJECT(dev)));
+    }
+}
+
+static void virt_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
+                                          DeviceState *dev, Error **errp)
+{
+    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
+        virtio_md_pci_unplug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
+    } else {
+        error_setg(errp, "virt: device unplug for unsupported device"
+                   " type: %s", object_get_typename(OBJECT(dev)));
+    }
 }
 
 static void virt_machine_class_init(ObjectClass *oc, void *data)
@@ -1757,7 +1835,10 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
 
+    hc->pre_plug = virt_machine_device_pre_plug_cb;
     hc->plug = virt_machine_device_plug_cb;
+    hc->unplug_request = virt_machine_device_unplug_request_cb;
+    hc->unplug = virt_machine_device_unplug_cb;
 
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
 #ifdef CONFIG_TPM
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index ffd119ebacb7..6636e5e1089c 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -51,7 +51,8 @@ static uint32_t virtio_mem_default_thp_size(void)
 {
     uint32_t default_thp_size = VIRTIO_MEM_MIN_BLOCK_SIZE;
 
-#if defined(__x86_64__) || defined(__arm__) || defined(__powerpc64__)
+#if defined(__x86_64__) || defined(__arm__) || defined(__powerpc64__) \
+    || defined(__riscv__)
     default_thp_size = 2 * MiB;
 #elif defined(__aarch64__)
     if (qemu_real_host_page_size() == 4 * KiB) {
@@ -161,7 +162,7 @@ static bool virtio_mem_has_shared_zeropage(RAMBlock *rb)
  * necessary (as the section size can change). But it's more likely that the
  * section size will rather get smaller and not bigger over time.
  */
-#if defined(TARGET_X86_64) || defined(TARGET_I386)
+#if defined(TARGET_X86_64) || defined(TARGET_I386)  || defined(TARGET_RISCV)
 #define VIRTIO_MEM_USABLE_EXTENT (2 * (128 * MiB))
 #elif defined(TARGET_ARM)
 #define VIRTIO_MEM_USABLE_EXTENT (2 * (512 * MiB))
-- 
2.40.1


