Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FC9D2503D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 07:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfC3K-0007u0-3v; Mon, 12 Jan 2026 02:09:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vfC3I-0007sR-SE
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 02:09:24 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vfC3G-0004rD-HS
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 02:09:24 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxVvAfnmRpjMYHAA--.25590S3;
 Mon, 12 Jan 2026 15:09:19 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCx98AdnmRpJKgaAA--.41401S5;
 Mon, 12 Jan 2026 15:09:18 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
Subject: [PULL 09/10] hw/loongarch/virt: Add high MMIO support with GPEX host
Date: Mon, 12 Jan 2026 15:09:03 +0800
Message-Id: <20260112070904.3230440-10-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260112070904.3230440-1-maobibo@loongson.cn>
References: <20260112070904.3230440-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCx98AdnmRpJKgaAA--.41401S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

With high MMIO supported, its base address comes from high end of
physical address space. Also add high MMIO support with GPEX host bridge.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/virt-fdt-build.c | 33 +++++++++++----
 hw/loongarch/virt.c           | 76 ++++++++++++++++++++++++++++++++++-
 2 files changed, 100 insertions(+), 9 deletions(-)

diff --git a/hw/loongarch/virt-fdt-build.c b/hw/loongarch/virt-fdt-build.c
index da73b042ee..4afefc8266 100644
--- a/hw/loongarch/virt-fdt-build.c
+++ b/hw/loongarch/virt-fdt-build.c
@@ -366,8 +366,8 @@ static void fdt_add_pcie_node(const LoongArchVirtMachineState *lvms,
                               uint32_t *pch_msi_phandle)
 {
     char *nodename;
-    hwaddr base_mmio = lvms->gpex.mmio64.base;
-    hwaddr size_mmio = lvms->gpex.mmio64.size;
+    hwaddr base_mmio, base_mmio_high;
+    hwaddr size_mmio, size_mmio_high;
     hwaddr base_pio = lvms->gpex.pio.base;
     hwaddr size_pio = lvms->gpex.pio.size;
     hwaddr base_pcie = lvms->gpex.ecam.base;
@@ -388,11 +388,30 @@ static void fdt_add_pcie_node(const LoongArchVirtMachineState *lvms,
     qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);
     qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
                                  2, base_pcie, 2, size_pcie);
-    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "ranges",
-                                 1, FDT_PCI_RANGE_IOPORT, 2, VIRT_PCI_IO_OFFSET,
-                                 2, base_pio, 2, size_pio,
-                                 1, FDT_PCI_RANGE_MMIO, 2, base_mmio,
-                                 2, base_mmio, 2, size_mmio);
+    if (lvms->highmem_mmio) {
+        base_mmio_high = lvms->gpex.mmio64.base;
+        size_mmio_high = lvms->gpex.mmio64.size;
+        base_mmio = lvms->gpex.mmio32.base;
+        size_mmio = lvms->gpex.mmio32.size;
+        qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "ranges",
+                                     1, FDT_PCI_RANGE_IOPORT,
+                                     2, VIRT_PCI_IO_OFFSET,
+                                     2, base_pio, 2, size_pio,
+                                     1, FDT_PCI_RANGE_MMIO, 2, base_mmio,
+                                     2, base_mmio, 2, size_mmio,
+                                     1, FDT_PCI_RANGE_MMIO_64BIT,
+                                     2, base_mmio_high,
+                                     2, base_mmio_high, 2, size_mmio_high);
+    } else {
+        base_mmio = lvms->gpex.mmio64.base;
+        size_mmio = lvms->gpex.mmio64.size;
+        qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "ranges",
+                                     1, FDT_PCI_RANGE_IOPORT,
+                                     2, VIRT_PCI_IO_OFFSET,
+                                     2, base_pio, 2, size_pio,
+                                     1, FDT_PCI_RANGE_MMIO, 2, base_mmio,
+                                     2, base_mmio, 2, size_mmio);
+    }
     qemu_fdt_setprop_cells(ms->fdt, nodename, "msi-map",
                            0, *pch_msi_phandle, 0, 0x10000);
     fdt_add_pcie_irq_map_node(lvms, nodename, pch_pic_phandle);
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 1e29f93a1f..78e9dd66d1 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -72,6 +72,9 @@ static void virt_set_dmsi(Object *obj, Visitor *v, const char *name,
     }
 }
 
+#define DEFAULT_HIGH_PCIE_MMIO_SIZE_GB 64
+#define DEFAULT_HIGH_PCIE_MMIO_SIZE (DEFAULT_HIGH_PCIE_MMIO_SIZE_GB * GiB)
+
 static void virt_get_veiointc(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
@@ -297,6 +300,54 @@ static DeviceState *create_platform_bus(DeviceState *pch_pic)
     return dev;
 }
 
+static void virt_set_highmmio(LoongArchVirtMachineState *lvms)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(first_cpu);
+    CPULoongArchState *env = &cpu->env;
+    struct GPEXConfig *gpex;
+    int vaddr_bits, phys_bits;
+
+    vaddr_bits = FIELD_EX32(env->cpucfg[1], CPUCFG1, VALEN) + 1;
+    phys_bits  = FIELD_EX32(env->cpucfg[1], CPUCFG1, PALEN) + 1;
+    if (phys_bits <= 32) {
+        return;
+    }
+
+    gpex = &lvms->gpex;
+    if (gpex->mmio64.size == 0) {
+        gpex->mmio64.size = DEFAULT_HIGH_PCIE_MMIO_SIZE;
+    }
+
+    /*
+     * UEFI BIOS uses 1:1 identified mapping PCI high mmio space, and
+     * virtual address space is low end through PGDL page table.
+     *
+     * Max physical address bit cannot exceed vaddr_bits - 1
+     */
+    if (phys_bits > (vaddr_bits - 1)) {
+        phys_bits = vaddr_bits - 1;
+    }
+
+    /*
+     * GPEX base address starts from end of physical address
+     */
+    gpex->mmio64.base = BIT_ULL(phys_bits) - BIT_ULL(phys_bits - 3);
+    if (gpex->mmio64.base + gpex->mmio64.size > BIT_ULL(phys_bits)) {
+        error_report("GPEX region base %" PRIu64 " size %" PRIu64
+                     " exceeds %d physical bits",
+                     gpex->mmio64.base, gpex->mmio64.size,
+                     phys_bits);
+        exit(EXIT_FAILURE);
+    }
+
+    if (lvms->ram_end > gpex->mmio64.base) {
+        error_report("DRAM end address %" PRIu64
+                     " exceeds GPEX region base %" PRIu64,
+                     lvms->ram_end, gpex->mmio64.base);
+        exit(EXIT_FAILURE);
+    }
+}
+
 static void virt_devices_init(DeviceState *pch_pic,
                                    LoongArchVirtMachineState *lvms)
 {
@@ -313,8 +364,6 @@ static void virt_devices_init(DeviceState *pch_pic,
     d = SYS_BUS_DEVICE(gpex_dev);
     sysbus_realize_and_unref(d, &error_fatal);
     pci_bus = PCI_HOST_BRIDGE(gpex_dev)->bus;
-    lvms->gpex.mmio64.base = VIRT_PCI_MEM_BASE;
-    lvms->gpex.mmio64.size = VIRT_PCI_MEM_SIZE;
     lvms->gpex.pio.base = VIRT_PCI_IO_BASE;
     lvms->gpex.pio.size = VIRT_PCI_IO_SIZE;
     lvms->gpex.ecam.base = VIRT_PCI_CFG_BASE;
@@ -323,6 +372,18 @@ static void virt_devices_init(DeviceState *pch_pic,
     lvms->gpex.bus = pci_bus;
     mmio_base = lvms->gpex.mmio64.base;
     mmio_size = lvms->gpex.mmio64.size;
+    if (lvms->highmem_mmio) {
+        virt_set_highmmio(lvms);
+        lvms->gpex.mmio32.base = VIRT_PCI_MEM_BASE;
+        lvms->gpex.mmio32.size = VIRT_PCI_MEM_SIZE;
+        mmio_base = lvms->gpex.mmio32.base;
+        mmio_size = lvms->gpex.mmio32.size;
+    } else {
+        lvms->gpex.mmio64.base = VIRT_PCI_MEM_BASE;
+        lvms->gpex.mmio64.size = VIRT_PCI_MEM_SIZE;
+        mmio_base = lvms->gpex.mmio64.base;
+        mmio_size = lvms->gpex.mmio64.size;
+    }
 
     /* Map only part size_ecam bytes of ECAM space */
     ecam_alias = g_new0(MemoryRegion, 1);
@@ -338,6 +399,17 @@ static void virt_devices_init(DeviceState *pch_pic,
     memory_region_init_alias(mmio_alias, OBJECT(gpex_dev), "pcie-mmio",
                              mmio_reg, mmio_base, mmio_size);
     memory_region_add_subregion(get_system_memory(), mmio_base, mmio_alias);
+    if (lvms->highmem_mmio) {
+        /* Map high MMIO space */
+        mmio_alias = g_new0(MemoryRegion, 1);
+        mmio_base = lvms->gpex.mmio64.base;
+        mmio_size = lvms->gpex.mmio64.size;
+        memory_region_init_alias(mmio_alias, OBJECT(gpex_dev),
+                                 "pcie-mmio-high", mmio_reg,
+                                 mmio_base, mmio_size);
+        memory_region_add_subregion(get_system_memory(), mmio_base,
+                                    mmio_alias);
+    }
 
     /* Map PCI IO port space. */
     pio_alias = g_new0(MemoryRegion, 1);
-- 
2.52.0


