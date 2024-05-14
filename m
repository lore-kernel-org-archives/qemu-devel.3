Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3199C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 11:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6pzl-0003zE-UY; Tue, 14 May 2024 07:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>)
 id 1s6pzl-0003yx-1w; Tue, 14 May 2024 07:06:57 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>)
 id 1s6pzg-0006MU-Dd; Tue, 14 May 2024 07:06:56 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 00B46CE1263;
 Tue, 14 May 2024 11:06:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C305DC2BD10;
 Tue, 14 May 2024 11:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715684796;
 bh=cA/MfzMlBqNsmC+LsU56F9WV+WXJmciXyeIO+zI4kGY=;
 h=From:To:Cc:Subject:Date:From;
 b=LtMOnUnHh8xs6RKE3S2k4drtpnMGHds4BXJ+o0sYShFO3VZ9Ae7MfmVmrYyDdZY4Z
 TbeYSP7Iwms01H1BQZXh7oWi4wvWxDJqGwVfKQfY+TA3LidERJDTSO4BnDLDWi/+7Q
 mMxFVj5FlLtZBKgQ8EKec8oGpoqUIlr0crdbhIYeFHDIEscxfFZc520J155LLcl4pr
 H7lwUkaNWLVp++36XKVmPoylEK3E3qP4qo01evpNGvEhVe36mWa7378znOdwEmS2BS
 XZ4OuxbU3RO5Iwj2trEUf6kopyrtFHQz99aVv5EmYHR28jnzzAir8sQcFfg7Yc5OcK
 e5Hw1etekAMlQ==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Santosh Mamila <santosh.mamila@catalinasystems.io>,
 Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
 Sivakumar Munnangi <siva.munnangi@catalinasystems.io>
Subject: [PATCH] hw/riscv/virt: Add hotplugging and virtio-md-pci support
Date: Tue, 14 May 2024 13:06:15 +0200
Message-Id: <20240514110615.399065-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.73.55; envelope-from=bjorn@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
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

Virtio-based memory devices allows for dynamic resizing of virtual
machine memory, and requires proper hotplugging (add/remove) support
to work.

Enable virtio-md-pci with the corresponding missing hotplugging
callbacks for the RISC-V "virt" machine.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
This is basic support for MHP that works with DT. There some minor
ACPI SRAT plumbing in there as well. Ideally we'd like proper ACPI MHP
support as well. I have a branch [1], where I've applied this patch,
plus ACPI GED/PC-DIMM MHP support on top of Sunil's QEMU branch
(contains some ACPI DSDT additions) [2], for the curious/brave ones.
However, the ACPI MHP support this is not testable on upstream Linux
yet (ACPI AIA support, and ACPI NUMA SRAT series are ongoing).

I'll follow-up with proper ACPI GED/PC-DIMM MHP patches, once the
dependencies land (Linux kernel and QEMU).

I'll post the Linux MHP/virtio-mem v2 patches later this week!


Cheers,
Björn

[1] https://github.com/bjoto/qemu/commits/virtio-mem-pc-dimm-mhp-acpi/
[2] https://lore.kernel.org/linux-riscv/20240501121742.1215792-1-sunilvl@ventanamicro.com/
---
 hw/riscv/Kconfig           |  2 ++
 hw/riscv/virt-acpi-build.c |  7 +++++
 hw/riscv/virt.c            | 64 +++++++++++++++++++++++++++++++++++++-
 hw/virtio/virtio-mem.c     |  2 +-
 4 files changed, 73 insertions(+), 2 deletions(-)

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
diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 0925528160f8..6dc3baa9ec86 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -610,6 +610,13 @@ build_srat(GArray *table_data, BIOSLinker *linker, RISCVVirtState *vms)
         }
     }
 
+    if (ms->device_memory) {
+        build_srat_memory(table_data, ms->device_memory->base,
+                          memory_region_size(&ms->device_memory->mr),
+                          ms->numa_state->num_nodes - 1,
+                          MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
+    }
+
     acpi_table_end(linker, &table);
 }
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 4fdb66052587..16c2bdbfe6b6 100644
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
@@ -1553,6 +1556,25 @@ static void virt_machine_init(MachineState *machine)
     memory_region_add_subregion(system_memory, memmap[VIRT_MROM].base,
                                 mask_rom);
 
+    device_memory_base = ROUND_UP(s->memmap[VIRT_DRAM].base + machine->ram_size,
+                                  GiB);
+    device_memory_size = machine->maxram_size - machine->ram_size;
+
+    if (riscv_is_32bit(&s->soc[0])) {
+        hwaddr memtop = device_memory_base + ROUND_UP(device_memory_size, GiB);
+
+        if (memtop > UINT32_MAX) {
+            error_report("Memory exceeds 32-bit limit by %lu bytes",
+                         memtop - UINT32_MAX);
+            exit(EXIT_FAILURE);
+        }
+    }
+
+    if (device_memory_size > 0) {
+        machine_memory_devices_init(machine, device_memory_base,
+                                    device_memory_size);
+    }
+
     /*
      * Init fw_cfg. Must be done before riscv_load_fdt, otherwise the
      * device tree cannot be altered and we get FDT_ERR_NOSPACE.
@@ -1712,12 +1734,21 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
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
@@ -1735,6 +1766,34 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
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
+        error_setg(errp, "device unplug request for unsupported device type: %s",
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
@@ -1757,7 +1816,10 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
 
+    hc->pre_plug = virt_machine_device_pre_plug_cb;
     hc->plug = virt_machine_device_plug_cb;
+    hc->unplug_request = virt_machine_device_unplug_request_cb;
+    hc->unplug = virt_machine_device_unplug_cb;
 
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
 #ifdef CONFIG_TPM
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index ffd119ebacb7..26c976a3b9b8 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -161,7 +161,7 @@ static bool virtio_mem_has_shared_zeropage(RAMBlock *rb)
  * necessary (as the section size can change). But it's more likely that the
  * section size will rather get smaller and not bigger over time.
  */
-#if defined(TARGET_X86_64) || defined(TARGET_I386)
+#if defined(TARGET_X86_64) || defined(TARGET_I386)  || defined(TARGET_RISCV)
 #define VIRTIO_MEM_USABLE_EXTENT (2 * (128 * MiB))
 #elif defined(TARGET_ARM)
 #define VIRTIO_MEM_USABLE_EXTENT (2 * (512 * MiB))

base-commit: 9360070196789cc8b9404b2efaf319384e64b107
-- 
2.40.1


