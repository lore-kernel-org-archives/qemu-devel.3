Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C51E7FDC7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 19:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmzwL-0005xF-Ug; Mon, 02 Feb 2026 14:50:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vmzvn-0005G7-DB; Mon, 02 Feb 2026 14:50:02 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vmzvl-0003bS-LB; Mon, 02 Feb 2026 14:49:55 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A67D41850B8;
 Mon, 02 Feb 2026 22:46:05 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 57E8835B29A;
 Mon, 02 Feb 2026 22:46:47 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Xianglai Li <lixianglai@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.8 38/69] hw/loongarch/virt: Fix irq allocation failure
 with pci device from fdt
Date: Mon,  2 Feb 2026 22:46:01 +0300
Message-ID: <20260202194638.939438-38-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.8-20260202173053@cover.tls.msk.ru>
References: <qemu-stable-10.0.8-20260202173053@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

From: Xianglai Li <lixianglai@loongson.cn>

When we use the -kernel parameter to start an elf format kernel relying on
fdt, we get the following error:

pcieport 0000:00:01.0: of_irq_parse_pci: failed with rc=-22
pcieport 0000:00:01.0: enabling device (0000 -> 0003)
pcieport 0000:00:01.0: PME: Signaling with IRQ 19
pcieport 0000:00:01.0: AER: enabled with IRQ 19
pcieport 0000:00:01.1: of_irq_parse_pci: failed with rc=-22
pcieport 0000:00:01.1: enabling device (0000 -> 0003)
pcieport 0000:00:01.1: PME: Signaling with IRQ 20
pcieport 0000:00:01.1: AER: enabled with IRQ 20
pcieport 0000:00:01.2: of_irq_parse_pci: failed with rc=-22
pcieport 0000:00:01.2: enabling device (0000 -> 0003)
pcieport 0000:00:01.2: PME: Signaling with IRQ 21
pcieport 0000:00:01.2: AER: enabled with IRQ 21
pcieport 0000:00:01.3: of_irq_parse_pci: failed with rc=-22
pcieport 0000:00:01.3: enabling device (0000 -> 0003)
pcieport 0000:00:01.3: PME: Signaling with IRQ 22
pcieport 0000:00:01.3: AER: enabled with IRQ 22
pcieport 0000:00:01.4: of_irq_parse_pci: failed with rc=-22

This is because  the description of interrupt-cell is missing in the pcie
irq map.  And there is a lack of a description of the interrupt trigger
type.  Now it is corrected and the correct interrupt-cell is added in the
pcie irq map.

Refer to the implementation in arm and add some comments.

Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
(cherry picked from commit ff54394eed148c642f83b45753c7898acdbd5ddb)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/loongarch/virt-fdt-build.c b/hw/loongarch/virt-fdt-build.c
index d00e974d4e..b61977808a 100644
--- a/hw/loongarch/virt-fdt-build.c
+++ b/hw/loongarch/virt-fdt-build.c
@@ -322,6 +322,8 @@ static void fdt_add_pcie_irq_map_node(const LoongArchVirtMachineState *lvms,
     uint32_t full_irq_map[PCI_NUM_PINS * PCI_NUM_PINS * 10] = {};
     uint32_t *irq_map = full_irq_map;
     const MachineState *ms = MACHINE(lvms);
+    uint32_t pin_mask;
+    uint32_t devfn_mask;
 
     /*
      * This code creates a standard swizzle of interrupts such that
@@ -334,37 +336,45 @@ static void fdt_add_pcie_irq_map_node(const LoongArchVirtMachineState *lvms,
      */
 
     for (dev = 0; dev < PCI_NUM_PINS; dev++) {
-        int devfn = dev * 0x8;
+        int devfn = PCI_DEVFN(dev, 0);
 
         for (pin = 0; pin < PCI_NUM_PINS; pin++) {
-            int irq_nr = 16 + ((pin + PCI_SLOT(devfn)) % PCI_NUM_PINS);
+            int irq_nr = VIRT_DEVICE_IRQS + \
+                         ((pin + PCI_SLOT(devfn)) % PCI_NUM_PINS);
             int i = 0;
 
-            /* Fill PCI address cells */
-            irq_map[i] = cpu_to_be32(devfn << 8);
-            i += 3;
-
-            /* Fill PCI Interrupt cells */
-            irq_map[i] = cpu_to_be32(pin + 1);
-            i += 1;
-
-            /* Fill interrupt controller phandle and cells */
-            irq_map[i++] = cpu_to_be32(*pch_pic_phandle);
-            irq_map[i++] = cpu_to_be32(irq_nr);
+            uint32_t map[] = {
+                devfn << 8, 0, 0,             /* devfn */
+                pin + 1,                      /* PCI pin */
+                *pch_pic_phandle,             /* interrupt controller handle */
+                irq_nr,                       /* irq number */
+                FDT_IRQ_TYPE_LEVEL_HIGH };    /* irq trigger level */
 
             if (!irq_map_stride) {
-                irq_map_stride = i;
+                irq_map_stride = sizeof(map) / sizeof(uint32_t);
             }
+
+            /* Convert map to big endian */
+            for (i = 0; i < irq_map_stride; i++) {
+                irq_map[i] = cpu_to_be32(map[i]);
+            }
+
             irq_map += irq_map_stride;
         }
     }
 
-
     qemu_fdt_setprop(ms->fdt, nodename, "interrupt-map", full_irq_map,
                      PCI_NUM_PINS * PCI_NUM_PINS *
                      irq_map_stride * sizeof(uint32_t));
+
+    /* Only need to match the pci slot bit */
+    devfn_mask = PCI_DEVFN((PCI_NUM_PINS - 1), 0) << 8;
+    /* The pci interrupt only needs to match the specified low bit */
+    pin_mask = (1 << ((PCI_NUM_PINS - 1))) - 1;
+
     qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupt-map-mask",
-                     0x1800, 0, 0, 0x7);
+                           devfn_mask, 0, 0,  /* address cells */
+                           pin_mask);
 }
 
 static void fdt_add_pcie_node(const LoongArchVirtMachineState *lvms,
@@ -401,6 +411,8 @@ static void fdt_add_pcie_node(const LoongArchVirtMachineState *lvms,
                                  2, base_mmio, 2, size_mmio);
     qemu_fdt_setprop_cells(ms->fdt, nodename, "msi-map",
                            0, *pch_msi_phandle, 0, 0x10000);
+
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "#interrupt-cells", 1);
     fdt_add_pcie_irq_map_node(lvms, nodename, pch_pic_phandle);
     g_free(nodename);
 }
-- 
2.47.3


