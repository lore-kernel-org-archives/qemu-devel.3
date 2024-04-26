Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89206C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 09:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0HxM-0005LN-IJ; Fri, 26 Apr 2024 05:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s0Hx1-0005Eo-Gl
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 05:33:03 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s0Hwz-0001LP-BF
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 05:33:03 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Dx_+vAdCtmF2YDAA--.14345S3;
 Fri, 26 Apr 2024 17:32:48 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxU1a2dCtm+yUGAA--.2929S16; 
 Fri, 26 Apr 2024 17:32:48 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org,
	maobibo@loongson.cn
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org, philmd@linaro.org,
 zltjiangshi@gmail.com
Subject: [PATCH v7 14/17] hw/loongarch: fdt adds pcie irq_map node
Date: Fri, 26 Apr 2024 17:15:48 +0800
Message-Id: <20240426091551.2397867-15-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240426091551.2397867-1-gaosong@loongson.cn>
References: <20240426091551.2397867-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxU1a2dCtm+yUGAA--.2929S16
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Message-Id: <20240307164835.300412-15-gaosong@loongson.cn>
---
 hw/loongarch/virt.c | 73 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 69 insertions(+), 4 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 566f86e741..91a55a81b6 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -352,7 +352,62 @@ static void fdt_add_fw_cfg_node(const LoongArchMachineState *lams)
     g_free(nodename);
 }
 
-static void fdt_add_pcie_node(const LoongArchMachineState *lams)
+static void fdt_add_pcie_irq_map_node(const LoongArchMachineState *lams,
+                                      char *nodename,
+                                      uint32_t *pch_pic_phandle)
+{
+    int pin, dev;
+    uint32_t irq_map_stride = 0;
+    uint32_t full_irq_map[GPEX_NUM_IRQS *GPEX_NUM_IRQS * 10] = {};
+    uint32_t *irq_map = full_irq_map;
+    const MachineState *ms = MACHINE(lams);
+
+    /* This code creates a standard swizzle of interrupts such that
+     * each device's first interrupt is based on it's PCI_SLOT number.
+     * (See pci_swizzle_map_irq_fn())
+     *
+     * We only need one entry per interrupt in the table (not one per
+     * possible slot) seeing the interrupt-map-mask will allow the table
+     * to wrap to any number of devices.
+     */
+
+    for (dev = 0; dev < GPEX_NUM_IRQS; dev++) {
+        int devfn = dev * 0x8;
+
+        for (pin = 0; pin  < GPEX_NUM_IRQS; pin++) {
+            int irq_nr = 16 + ((pin + PCI_SLOT(devfn)) % GPEX_NUM_IRQS);
+            int i = 0;
+
+            /* Fill PCI address cells */
+            irq_map[i] = cpu_to_be32(devfn << 8);
+            i += 3;
+
+            /* Fill PCI Interrupt cells */
+            irq_map[i] = cpu_to_be32(pin + 1);
+            i += 1;
+
+            /* Fill interrupt controller phandle and cells */
+            irq_map[i++] = cpu_to_be32(*pch_pic_phandle);
+            irq_map[i++] = cpu_to_be32(irq_nr);
+
+            if (!irq_map_stride) {
+                irq_map_stride = i;
+            }
+            irq_map += irq_map_stride;
+        }
+    }
+
+
+    qemu_fdt_setprop(ms->fdt, nodename, "interrupt-map", full_irq_map,
+                     GPEX_NUM_IRQS * GPEX_NUM_IRQS *
+                     irq_map_stride * sizeof(uint32_t));
+    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupt-map-mask",
+                     0x1800, 0, 0, 0x7);
+}
+
+static void fdt_add_pcie_node(const LoongArchMachineState *lams,
+                              uint32_t *pch_pic_phandle,
+                              uint32_t *pch_msi_phandle)
 {
     char *nodename;
     hwaddr base_mmio = VIRT_PCI_MEM_BASE;
@@ -383,6 +438,11 @@ static void fdt_add_pcie_node(const LoongArchMachineState *lams)
                                  2, base_pio, 2, size_pio,
                                  1, FDT_PCI_RANGE_MMIO, 2, base_mmio,
                                  2, base_mmio, 2, size_mmio);
+    qemu_fdt_setprop_cells(ms->fdt, nodename, "msi-map",
+                           0, *pch_msi_phandle, 0, 0x10000);
+
+    fdt_add_pcie_irq_map_node(lams, nodename, pch_pic_phandle);
+
     g_free(nodename);
 }
 
@@ -542,7 +602,10 @@ static DeviceState *create_platform_bus(DeviceState *pch_pic)
     return dev;
 }
 
-static void loongarch_devices_init(DeviceState *pch_pic, LoongArchMachineState *lams)
+static void loongarch_devices_init(DeviceState *pch_pic,
+                                   LoongArchMachineState *lams,
+                                   uint32_t *pch_pic_phandle,
+                                   uint32_t *pch_msi_phandle)
 {
     MachineClass *mc = MACHINE_GET_CLASS(lams);
     DeviceState *gpex_dev;
@@ -588,6 +651,9 @@ static void loongarch_devices_init(DeviceState *pch_pic, LoongArchMachineState *
         gpex_set_irq_num(GPEX_HOST(gpex_dev), i, 16 + i);
     }
 
+    /* Add pcie node */
+    fdt_add_pcie_node(lams, pch_pic_phandle, pch_msi_phandle);
+
     serial_mm_init(get_system_memory(), VIRT_UART_BASE, 0,
                    qdev_get_gpio_in(pch_pic,
                                     VIRT_UART_IRQ - VIRT_GSI_BASE),
@@ -734,7 +800,7 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
     /* Add PCH MSI node */
     fdt_add_pch_msi_node(lams, &eiointc_phandle, &pch_msi_phandle);
 
-    loongarch_devices_init(pch_pic, lams);
+    loongarch_devices_init(pch_pic, lams, &pch_pic_phandle, &pch_msi_phandle);
 }
 
 static void loongarch_firmware_init(LoongArchMachineState *lams)
@@ -956,7 +1022,6 @@ static void loongarch_init(MachineState *machine)
     lams->powerdown_notifier.notify = virt_powerdown_req;
     qemu_register_powerdown_notifier(&lams->powerdown_notifier);
 
-    fdt_add_pcie_node(lams);
     /*
      * Since lowmem region starts from 0 and Linux kernel legacy start address
      * at 2 MiB, FDT base address is located at 1 MiB to avoid NULL pointer
-- 
2.25.1


