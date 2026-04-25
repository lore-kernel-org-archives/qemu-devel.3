Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A5BFF885C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 13:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGcuU-0007To-WD; Sat, 25 Apr 2026 09:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wGcuT-0007Sd-3g
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 09:19:01 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wGcuQ-0000Hv-Hp
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 09:19:00 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-82f8cebc935so3831500b3a.0
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2026 06:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777123137; x=1777727937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vALn2gzhdl8xVZ/Nk4kuywsAYoGFx0DePWWWeklTFI0=;
 b=q9znpy1DEx46ckjpZMZEcxZQDxkRSz7OHhSmmQK8YRINzhQQpsgIQLbBXkrhvdedeE
 RZE7Pi+SqEpZSpRKoYGazqHwTW7YWLB/KF1Bzpz7nRNOFJsR9Kmj+L2fP/3X/rDXQEky
 wCQDGxzURtnQ4wLlBwe1uPQfDqAszrv/ac/VsJKFJMzOCdf+HaULMoMBGxlT/GsAEWGZ
 eoFNCuL/p7IIxSnaAptMufoh1mnINS/ggfg3Nf8bHNGqyvPXKBXFnTISF9coqW5h3pJy
 fvUCUWeD1iOub7VeL7VKwFHlL5WcdZqZfbDAkn3570BqberE3DdHjYIvo3RQ21yFhNLj
 hZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777123137; x=1777727937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vALn2gzhdl8xVZ/Nk4kuywsAYoGFx0DePWWWeklTFI0=;
 b=AyV68MobOwcK8Brd+/1BrRBfslQ+cPcfeVLmb+RbLJiNfsZKRcjVwfUUv8zQSt4Sg8
 H4EswNmlg4Jmqa1TNc+daZ3oHRBej75dyOpMPd/D4MoEjDOywAkK4FAltpXSGYVE1qff
 bSQw+aNfyTy7he/TnrLBF8/Nii+vpDNyRwTpQa73NOBDeRbyj8qX//QkX5aYU8oMzDTA
 BCu0cs51KVmJP2DGKJZ0UOMmxQlvGqyNXNh8twWH9vqwGn80esoBP80WTCT/G4rlURDO
 JG9BoNBHKkv9jlkcqXIpvW65gMH1w50o85H49QnlPIhF7V9X5V9M+J5B8oYUrcaN3YR0
 mb8A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/puuqP8ICrc+OfPI/2ts3e+lpiKoMFfQQbyeToTOEvmaaYYiytEacF+y/ReGiLQbl/cEsqG906ZvZV@nongnu.org
X-Gm-Message-State: AOJu0YwVCWIfdRqSvt0zHMlK1BjLdFJ56WVNs6QmjhtuQyX5qNpBLdX/
 OMLM8lc+PmpfRPlmDp1M9AHhtKa43WE9Fdq/phK5egmazsxI7k/S3RSo
X-Gm-Gg: AeBDiev0N87PKM6JV38D7hD8sZak14hzh+/r7J85sxsnTzW6DXLR714WRXMbPhVhfFT
 a2OP/ZQnHbbuaniLQbijGJiKzZsDv1h8W2K7nAe/yop00T3LXPjzWwRXiMknf/5phMf6FNTifaq
 ELaDaBHBq1Hxn90B2j+t2zyqLQ9LMqxAuB41Q4uBoPWEBHKu8BMzOgW+vV6ZAF8eenGIHKpKsG8
 dPclm7+F8U2FouMlZ8srbwBOlZVgTCWrW9dwmKk9TYLlZNAKbgjXHFKoLD+v5D0neeEn/5bGDMe
 A7mtb8TPkNqbVJFlsotp18pq85x7EST+OFgErHos3z1IkEc7tvuYeHmqqxWmjpQbrf/o/Ux7RTY
 fxCoxw77PRrUIo2KTsF8nxplYxkyLlpTBhs20t9OElIH//Hq7tTI/rjnAXufTMw6mo6dW2mqomH
 +gXtVPEX2pZpqlpALKSSLuUh0PLmzP89jA5Vij0NHFODxXDCyxMI4fVhon9yeFld0ozKQS3s7vh
 4xCt1Mc9Hn0DzCugn1kp+iiWG4wbEN7
X-Received: by 2002:a05:6a00:e08:b0:82f:776f:a79a with SMTP id
 d2e1a72fcca58-82f8c8bc107mr37755426b3a.29.1777123136742; 
 Sat, 25 Apr 2026 06:18:56 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9f7735sm26898866b3a.21.2026.04.25.06.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 06:18:55 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v4 10/13] hw/riscv/atlantis: Add PCIe controller
Date: Sat, 25 Apr 2026 23:17:16 +1000
Message-ID: <20260425131721.932250-11-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260425131721.932250-1-joel@jms.id.au>
References: <20260425131721.932250-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

Atlantis has 3 DesignWare PCIe host controllers, however the boot firmware
has not been tested with the QEMU DesignWare model so a generic ECAM
controller is used for the interim. The system bus aperture and PCIe IO
mappings match the hardware configuration. Only a single PCIe controller is
implemented, because the gpex model does not support multiple controllers.

Booting Linux v6.19:

 pci-host-generic 1110000000.pci: host bridge /soc/pci@1110000000 ranges:
 pci-host-generic 1110000000.pci:       IO 0x30011000000..0x300110fffff -> 0x0000000000
 pci-host-generic 1110000000.pci:      MEM 0x30080000000..0x300ffffffff -> 0x0080000000
 pci-host-generic 1110000000.pci:      MEM 0x30100000000..0x3ff7fffffff -> 0x30100000000
 pci-host-generic 1110000000.pci: ECAM at [mem 0x1110000000-0x111fffffff] for [bus 00-ff]
 pci-host-generic 1110000000.pci: PCI host bridge to bus 0000:00
 pci_bus 0000:00: root bus resource [bus 00-ff]
 pci_bus 0000:00: root bus resource [io  0x0000-0xfffff]
 pci_bus 0000:00: root bus resource [mem 0x30080000000-0x300ffffffff] (bus address [0x80000000-0xffffffff])
 pci_bus 0000:00: root bus resource [mem 0x30100000000-0x3ff7fffffff pref]
 pci 0000:00:00.0: [1b36:0008] type 00 class 0x060000 conventional PCI endpoint
 pci 0000:00:01.0: [1af4:1001] type 00 class 0x010000 conventional PCI endpoint
 pci 0000:00:01.0: BAR 0 [io  0x0000-0x007f]
 pci 0000:00:01.0: BAR 1 [mem 0x00000000-0x00000fff]
 pci 0000:00:01.0: BAR 4 [mem 0x00000000-0x00003fff 64bit pref]
 pci 0000:00:01.0: BAR 4 [mem 0x30100000000-0x30100003fff 64bit pref]: assigned
 pci 0000:00:01.0: BAR 1 [mem 0x30080000000-0x30080000fff]: assigned
 pci 0000:00:01.0: BAR 0 [io  0x0080-0x00ff]: assigned
 pci_bus 0000:00: resource 4 [io  0x0000-0xfffff]
 pci_bus 0000:00: resource 5 [mem 0x30080000000-0x300ffffffff]
 pci_bus 0000:00: resource 6 [mem 0x30100000000-0x3ff7fffffff pref]

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v4:
 - Remove select PCI
 - Rework addressing, use a table for describing the map
 - Remove traces of controller 2 and 3; they will be implemented in
   future patches
v3: Avoid leaks in the dt string allocation
---
 include/hw/riscv/tt_atlantis.h |  12 ++
 hw/riscv/tt_atlantis.c         | 234 ++++++++++++++++++++++++++++++++-
 hw/riscv/Kconfig               |   1 +
 3 files changed, 246 insertions(+), 1 deletion(-)

diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index 9fe50d9c9040..070f53eeb450 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -17,6 +17,13 @@
 #define TYPE_TT_ATLANTIS_MACHINE MACHINE_TYPE_NAME("tt-atlantis")
 OBJECT_DECLARE_SIMPLE_TYPE(TTAtlantisState, TT_ATLANTIS_MACHINE)
 
+typedef struct {
+    hwaddr pcie_addr; /* Device side address */
+    hwaddr window_offset; /* Host side offset */
+    hwaddr size;
+    uint32_t flags;
+} PciMapEntry;
+
 struct TTAtlantisState {
     /*< private >*/
     MachineState parent;
@@ -25,9 +32,11 @@ struct TTAtlantisState {
     Notifier machine_done;
     FWCfgState *fw_cfg;
     const MemMapEntry *memmap;
+    const PciMapEntry *pcimap;
 
     RISCVHartArrayState soc;
     DeviceState *irqchip;
+    GPEXHost gpex_host;
 
     int fdt_size;
 };
@@ -39,6 +48,7 @@ enum {
     TT_ATL_UART2_IRQ = 40,
     TT_ATL_UART3_IRQ = 41,
     TT_ATL_UART4_IRQ = 42,
+    TT_ATL_PCIE0_INTA_IRQ = 96,
 };
 
 enum {
@@ -50,6 +60,8 @@ enum {
     TT_ATL_I2C0,
     TT_ATL_MAPLIC,
     TT_ATL_MIMSIC,
+    TT_ATL_PCIE_ECAM0,
+    TT_ATL_PCIE_MMIO0,
     TT_ATL_SAPLIC,
     TT_ATL_SIMSIC,
     TT_ATL_SYSCON,
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 5b66d7e95bb9..1eb473907ad7 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -27,6 +27,7 @@
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/riscv_aplic.h"
 #include "hw/misc/pvpanic.h"
+#include "hw/pci-host/gpex.h"
 
 #include "system/system.h"
 #include "system/device_tree.h"
@@ -51,6 +52,13 @@
 #define TT_ACLINT_MTIMECMP      0x8000
 #define TT_ACLINT_TIMEBASE_FREQ 1000000000
 
+
+enum {
+    PCIE0_PIO,
+    PCIE0_MMIO_32,
+    PCIE0_MMIO_64,
+};
+
 static const MemMapEntry tt_atlantis_memmap[] = {
     /* Keep sorted with :'<,'>!sort -g -k 4 */
     [TT_ATL_DDR_LO] =           { 0x00000000,    0x80000000 },
@@ -66,6 +74,19 @@ static const MemMapEntry tt_atlantis_memmap[] = {
     [TT_ATL_MAPLIC] =           { 0xcc000000,     0x4000000 },
     [TT_ATL_SAPLIC] =           { 0xe8000000,     0x4000000 },
     [TT_ATL_DDR_HI] =          { 0x100000000,  0x1000000000 },
+    [TT_ATL_PCIE_ECAM0] =    { 0x01110000000,    0x10000000 },
+    [TT_ATL_PCIE_MMIO0] =    { 0x30000000000, 0x10000000000 },
+};
+
+static const PciMapEntry tt_atlantis_pci_map[]  = {
+    /* pcie_addr    window_offset         size   flags */
+    {           0x0,  0x11000000,       1 * MiB, FDT_PCI_RANGE_IOPORT |
+                                                  FDT_PCI_RANGE_RELOCATABLE },
+    {    0x80000000,  0x80000000,       2 * GiB, FDT_PCI_RANGE_MMIO |
+                                                  FDT_PCI_RANGE_RELOCATABLE },
+    { 0x30100000000, 0x100000000,    1018 * GiB, FDT_PCI_RANGE_MMIO_64BIT |
+                                                  FDT_PCI_RANGE_RELOCATABLE |
+                                                  FDT_PCI_RANGE_PREFETCHABLE },
 };
 
 static uint32_t next_phandle(void)
@@ -74,6 +95,59 @@ static uint32_t next_phandle(void)
     return phandle++;
 }
 
+static void create_pcie_irq_map(void *fdt, char *nodename, int legacy_irq,
+                                uint32_t irqchip_phandle)
+{
+    int pin, dev;
+    uint32_t irq_map_stride = 0;
+    uint32_t full_irq_map[PCI_NUM_PINS * PCI_NUM_PINS *
+                          FDT_MAX_INT_MAP_WIDTH] = {};
+    uint32_t *irq_map = full_irq_map;
+
+    /*
+     * This code creates a standard swizzle of interrupts such that
+     * each device's first interrupt is based on it's PCI_SLOT number.
+     * (See pci_swizzle_map_irq_fn())
+     *
+     * We only need one entry per interrupt in the table (not one per
+     * possible slot) seeing the interrupt-map-mask will allow the table
+     * to wrap to any number of devices.
+     */
+    for (dev = 0; dev < PCI_NUM_PINS; dev++) {
+        int devfn = dev * 0x8;
+
+        for (pin = 0; pin < PCI_NUM_PINS; pin++) {
+            int irq_nr = legacy_irq + ((pin + PCI_SLOT(devfn)) % PCI_NUM_PINS);
+            int i = 0;
+
+            /* Fill PCI address cells */
+            irq_map[i] = cpu_to_be32(devfn << 8);
+            i += FDT_PCI_ADDR_CELLS;
+
+            /* Fill PCI Interrupt cells */
+            irq_map[i] = cpu_to_be32(pin + 1);
+            i += FDT_PCI_INT_CELLS;
+
+            /* Fill interrupt controller phandle and cells */
+            irq_map[i++] = cpu_to_be32(irqchip_phandle);
+            irq_map[i++] = cpu_to_be32(irq_nr);
+            irq_map[i++] = cpu_to_be32(0x4);
+
+            if (!irq_map_stride) {
+                irq_map_stride = i;
+            }
+            irq_map += irq_map_stride;
+        }
+    }
+
+    qemu_fdt_setprop(fdt, nodename, "interrupt-map", full_irq_map,
+                     PCI_NUM_PINS * PCI_NUM_PINS *
+                     irq_map_stride * sizeof(uint32_t));
+
+    qemu_fdt_setprop_cells(fdt, nodename, "interrupt-map-mask",
+                           0x1800, 0, 0, 0x7);
+}
+
 static void create_fdt_cpus(TTAtlantisState *s, uint32_t *intc_phandles)
 {
     uint32_t cpu_phandle;
@@ -314,6 +388,52 @@ static void create_fdt_cpu(TTAtlantisState *s, const MemMapEntry *memmap,
                          IRQ_S_EXT, s->soc.num_harts);
 }
 
+static void create_fdt_pcie(void *fdt,
+                            const MemMapEntry *ecam_mem,
+                            const MemMapEntry *pcie_mem,
+                            const PciMapEntry *pio,
+                            const PciMapEntry *mmio32,
+                            const PciMapEntry *mmio64,
+                            int legacy_irq,
+                            uint32_t aplic_s_phandle,
+                            uint32_t imsic_s_phandle)
+{
+    g_autofree char *name = g_strdup_printf("/soc/pci@%"HWADDR_PRIX,
+                                            ecam_mem->base);
+
+    qemu_fdt_setprop_cell(fdt, name, "#address-cells", FDT_PCI_ADDR_CELLS);
+    qemu_fdt_setprop_cell(fdt, name, "#interrupt-cells", FDT_PCI_INT_CELLS);
+    qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0x2);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "pci-host-ecam-generic");
+    qemu_fdt_setprop_string(fdt, name, "device_type", "pci");
+    qemu_fdt_setprop_cells(fdt, name, "bus-range", 0,
+                           ecam_mem->size / PCIE_MMCFG_SIZE_MIN - 1);
+    qemu_fdt_setprop(fdt, name, "dma-coherent", NULL, 0);
+    qemu_fdt_setprop_cell(fdt, name, "msi-parent", imsic_s_phandle);
+
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
+                                 2, ecam_mem->base,
+                                 2, ecam_mem->size);
+
+    qemu_fdt_setprop_sized_cells(fdt, name, "ranges",
+                                 1, pio->flags,
+                                 2, pio->pcie_addr,
+                                 2, pio->window_offset + pcie_mem->base,
+                                 2, pio->size,
+
+                                 1, mmio32->flags,
+                                 2, mmio32->pcie_addr,
+                                 2, mmio32->window_offset + pcie_mem->base,
+                                 2, mmio32->size,
+
+                                 1, mmio64->flags,
+                                 2, mmio64->pcie_addr,
+                                 2, mmio64->window_offset + pcie_mem->base,
+                                 2, mmio64->size);
+
+    create_pcie_irq_map(fdt, name, legacy_irq, aplic_s_phandle);
+}
+
 static void create_fdt_reset(void *fdt, const MemMapEntry *mem)
 {
     uint32_t syscon_phandle = next_phandle();
@@ -379,6 +499,15 @@ static void finalize_fdt(TTAtlantisState *s)
      *                       aplic_s_phandle);
      */
 
+    create_fdt_pcie(fdt,
+                    &s->memmap[TT_ATL_PCIE_ECAM0],
+                    &s->memmap[TT_ATL_PCIE_MMIO0],
+                    &s->pcimap[PCIE0_PIO],
+                    &s->pcimap[PCIE0_MMIO_32],
+                    &s->pcimap[PCIE0_MMIO_64],
+                    TT_ATL_PCIE0_INTA_IRQ,
+                    aplic_s_phandle, imsic_s_phandle);
+
     create_fdt_reset(fdt, &s->memmap[TT_ATL_SYSCON]);
 
     create_fdt_uart(fdt, &s->memmap[TT_ATL_UART0], TT_ATL_UART0_IRQ,
@@ -389,7 +518,7 @@ static void create_fdt(TTAtlantisState *s)
 {
     MachineState *ms = MACHINE(s);
     uint8_t rng_seed[32];
-    g_autofree char *name = NULL;
+    char *name;
     void *fdt;
 
     fdt = create_device_tree(&s->fdt_size);
@@ -411,6 +540,15 @@ static void create_fdt(TTAtlantisState *s)
     qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
     qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
 
+    /*
+     * The "/soc/pci@..." node is needed for PCIE hotplugs
+     * that might happen before finalize_fdt().
+     */
+    name = g_strdup_printf("/soc/pci@%"HWADDR_PRIX,
+                           s->memmap[TT_ATL_PCIE_ECAM0].base);
+    qemu_fdt_add_subnode(fdt, name);
+    g_free(name);
+
     qemu_fdt_add_subnode(fdt, "/chosen");
 
     /* Pass seed to RNG */
@@ -423,6 +561,95 @@ static void create_fdt(TTAtlantisState *s)
     create_fdt_pmu(s);
 }
 
+static void gpex_pcie_init_one(TTAtlantisState *s, GPEXHost *gpex_host,
+                               MemoryRegion *mr,
+                               const MemMapEntry *ecam_mem,
+                               const MemMapEntry *pcie_mem,
+                               const PciMapEntry *mem_pio,
+                               const PciMapEntry *mem_mmio32,
+                               const PciMapEntry *mem_mmio64,
+                               int legacy_irq)
+{
+    DeviceState *dev;
+    Object *obj;
+    MemoryRegion *ecam_alias, *ecam_reg;
+    MemoryRegion *mmio32_alias, *mmio64_alias, *mmio_reg;
+    hwaddr ecam_base = ecam_mem->base;
+    hwaddr ecam_size = ecam_mem->size;
+    hwaddr pio_base = mem_pio->window_offset + pcie_mem->base;
+    hwaddr pio_size = mem_pio->size;
+    hwaddr mmio32_base = mem_mmio32->window_offset + pcie_mem->base;
+    hwaddr mmio32_size = mem_mmio32->size;
+    hwaddr mmio64_base = mem_mmio64->window_offset + pcie_mem->base;
+    hwaddr mmio64_size = mem_mmio64->size;
+    qemu_irq irq;
+    char name[16];
+    int i;
+
+    snprintf(name, sizeof(name), "pcie");
+    object_initialize_child(OBJECT(s), name, gpex_host, TYPE_GPEX_HOST);
+    dev = DEVICE(gpex_host);
+    obj = OBJECT(dev);
+
+    object_property_set_uint(obj, PCI_HOST_ECAM_BASE, ecam_base, &error_abort);
+    object_property_set_int(obj, PCI_HOST_ECAM_SIZE, ecam_size, &error_abort);
+    object_property_set_uint(obj, PCI_HOST_BELOW_4G_MMIO_BASE, mmio32_base,
+                             &error_abort);
+    object_property_set_int(obj, PCI_HOST_BELOW_4G_MMIO_SIZE, mmio32_size,
+                            &error_abort);
+    object_property_set_uint(obj, PCI_HOST_ABOVE_4G_MMIO_BASE, mmio64_base,
+                             &error_abort);
+    object_property_set_int(obj, PCI_HOST_ABOVE_4G_MMIO_SIZE, mmio64_size,
+                            &error_abort);
+    object_property_set_uint(obj, PCI_HOST_PIO_BASE, pio_base, &error_abort);
+    object_property_set_int(obj, PCI_HOST_PIO_SIZE, pio_size, &error_abort);
+
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    ecam_alias = g_new0(MemoryRegion, 1);
+    ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    snprintf(name, sizeof(name), "pcie.ecam");
+    memory_region_init_alias(ecam_alias, obj, name,
+                             ecam_reg, 0, ecam_size);
+    memory_region_add_subregion(mr, ecam_base, ecam_alias);
+
+    mmio_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
+
+    mmio32_alias = g_new0(MemoryRegion, 1);
+    snprintf(name, sizeof(name), "pcie.mmio32");
+    memory_region_init_alias(mmio32_alias, obj, name,
+                             mmio_reg, mmio32_base & 0xffffffffUL, mmio32_size);
+    memory_region_add_subregion(mr, mmio32_base, mmio32_alias);
+
+    mmio64_alias = g_new0(MemoryRegion, 1);
+    snprintf(name, sizeof(name), "pcie.mmio64");
+    memory_region_init_alias(mmio64_alias, obj, name,
+                             mmio_reg, mmio64_base, mmio64_size);
+    memory_region_add_subregion(mr, mmio64_base, mmio64_alias);
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, pio_base);
+
+    for (i = 0; i < PCI_NUM_PINS; i++) {
+        irq = qdev_get_gpio_in(s->irqchip, legacy_irq + i);
+
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
+        gpex_set_irq_num(GPEX_HOST(dev), i, legacy_irq + i);
+    }
+
+    gpex_host->gpex_cfg.bus = PCI_HOST_BRIDGE(dev)->bus;
+}
+
+static void gpex_pcie_init(TTAtlantisState *s, MemoryRegion *mr)
+{
+    gpex_pcie_init_one(s, &s->gpex_host, mr,
+                       &s->memmap[TT_ATL_PCIE_ECAM0],
+                       &s->memmap[TT_ATL_PCIE_MMIO0],
+                       &s->pcimap[PCIE0_PIO],
+                       &s->pcimap[PCIE0_MMIO_32],
+                       &s->pcimap[PCIE0_MMIO_64],
+                       TT_ATL_PCIE0_INTA_IRQ);
+}
+
 static DeviceState *create_reboot_device(const MemMapEntry *mem)
 {
     DeviceState *dev = qdev_new(TYPE_PVPANIC_MMIO_DEVICE);
@@ -517,6 +744,7 @@ static void tt_atlantis_machine_init(MachineState *machine)
     int base_hartid = 0;
 
     s->memmap = tt_atlantis_memmap;
+    s->pcimap = tt_atlantis_pci_map;
 
     object_initialize_child(OBJECT(machine), "soc", &s->soc,
                             TYPE_RISCV_HART_ARRAY);
@@ -582,6 +810,9 @@ static void tt_atlantis_machine_init(MachineState *machine)
     s->fw_cfg = create_fw_cfg(&s->memmap[TT_ATL_FW_CFG], machine->smp.cpus);
     rom_set_fw(s->fw_cfg);
 
+    /* PCIe */
+    gpex_pcie_init(s, system_memory);
+
     /* Reboot and exit */
     create_reboot_device(&s->memmap[TT_ATL_SYSCON]);
 
@@ -617,6 +848,7 @@ static void tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
     mc->default_cpu_type = TYPE_RISCV_CPU_TT_ASCALON;
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
+    mc->pci_allow_0_address = true;
     mc->default_ram_id = "tt_atlantis.ram";
 }
 
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 0601ae1a7494..f13a05c7b1d1 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -129,6 +129,7 @@ config TENSTORRENT
     select DEVICE_TREE
     select RISCV_NUMA
     select PVPANIC_MMIO
+    select PCI_EXPRESS_GENERIC_BRIDGE
     select SERIAL_MM
     select RISCV_ACLINT
     select RISCV_APLIC
-- 
2.47.3


