Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EA2C982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 16:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7bdA-0003Ut-9f; Fri, 18 Sep 2026 12:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1x7bbs-0003Fb-9K; Fri, 18 Sep 2026 12:38:53 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1x7bbl-0002gu-8P; Fri, 18 Sep 2026 12:38:46 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2F9F0601EF;
 Fri, 18 Sep 2026 16:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42831F000FF;
 Fri, 18 Sep 2026 16:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789749518;
 bh=5O+/PRbJzzGFw9iphMcokzo5Gqr6sF1QivbA4bJcFUc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ObvQvXIsEQPuNDcgRjc4+/TX46JvgHwmujxC8WLAorOcbMjhm3lTQQLK/WniW3F7g
 mn2vFQnmt8Uz9/iJKJHLhT7clVnigPPFXvgrc1U0TR6EWiMzCxPMpYxm4tbUaqaGWC
 D9MkoU5XoaLNC45hbRyHd6jMb6zmGKj+l+/BcU/uIXMJizdlEzvaKp/CAGsE/EEUaV
 3qCVfB2oi4UFIpNs8Bf2c1dox1QlXJTj6FV7TYqQidyOArpbUG71q+ZegTYXN3Swp5
 OSWUyVQnZpZpWaGhU3moqCOQOvexgy6X2k/IAAtc1iTXbmRZfkG53HGRIAhDZ5zL9H
 VYFiIOIl10ocg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Helge Deller <deller@gmx.de>, "Denis V. Lunev" <den@openvz.org>,
 Abizer Lokhandwala <abizerlokhandwalastd10@gmail.com>
Subject: [PULL 2/7] hw/isa/pc87560: Add main isa code for NS 87560 SuperIO chip
Date: Fri, 18 Sep 2026 18:38:23 +0200
Message-ID: <20260918163829.2917-3-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260918163829.2917-1-deller@kernel.org>
References: <20260918163829.2917-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Abizer Lokhandwala <abizerlokhandwalastd10@gmail.com>

Add emulation of the core components (PCI function 1 aka I/O
Peripherals) of the National Semiconductor SuperIO chip which was
commonly used in HP PA-RISC B- and C-class workstations. This includes
the PIC interrupt controller, the floppy controller, serial and parallel
ports.

Signed-off-by: Abizer Lokhandwala <abizerlokhandwalastd10@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 MAINTAINERS              |   2 +
 hw/isa/Kconfig           |  11 +
 hw/isa/pc87560.c         | 510 +++++++++++++++++++++++++++++++++++++++
 include/hw/isa/pc87560.h |  96 ++++++++
 4 files changed, 619 insertions(+)
 create mode 100644 hw/isa/pc87560.c
 create mode 100644 include/hw/isa/pc87560.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e9b68c51f1..e3b1e80ad6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1355,6 +1355,8 @@ F: include/hw/pci-host/dino.h
 F: pc-bios/hppa-firmware.img
 F: roms/seabios-hppa/
 F: tests/functional/hppa/
+F: hw/isa/pc87560.c
+F: include/hw/isa/pc87560.h
 
 Hexagon Machines
 ----------------
diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index 73c6470805..23d327e88c 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -67,6 +67,17 @@ config SMC37C669
     bool
     select ISA_SUPERIO
 
+config PC87560
+    bool
+    default y if PCI_DEVICES
+    depends on PCI
+    depends on HPPA
+    select ISA_BUS
+    select FDC_ISA
+    select SERIAL_ISA
+    select IDE_PCI
+    select USB_OHCI
+
 config LPC_ICH9
     bool
     # For historical reasons, SuperIO devices are created in the board
diff --git a/hw/isa/pc87560.c b/hw/isa/pc87560.c
new file mode 100644
index 0000000000..c13c54deb2
--- /dev/null
+++ b/hw/isa/pc87560.c
@@ -0,0 +1,510 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * NS PC87560 SuperI/O — ISA emulation
+ *
+ * Copyright (c) 2026 Abizer abizerlokhandwalastd10@gmail.com
+ */
+#include "qemu/osdep.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_device.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "migration/vmstate.h"
+#include "qemu/module.h"
+#include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/qdev-properties-system.h"
+#include "hw/char/serial.h"
+#include "hw/char/parallel.h"
+#include "hw/block/fdc-internal.h"
+#include "hw/isa/pc87560.h"
+
+static uint64_t pc87560_pp_read(void *opaque, hwaddr addr, unsigned size)
+{
+    ParallelState *s = opaque;
+    switch (addr) {
+    case 0: return s->datar;
+    case 1: return s->status;
+    case 2: return s->control;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "pc87560-pp: read  offset 0x%" HWADDR_PRIx "\n", addr);
+        return 0xFF;
+    }
+}
+
+static int pic_highest_priority(int priority_base, uint8_t mask)
+{
+    int i;
+    for (i = 1; i <= 8; i++) {
+        int irq = (priority_base + i) & 7;
+        if (mask & (1 << irq)) {
+            return irq;
+        }
+    }
+    return -1;
+}
+
+static void pic_update_irq(PC87560SuperioState *s)
+{
+    int base = s->pic.priority_base;
+    int first_irr = pic_highest_priority(base, s->pic.irr & ~s->pic.imr);
+    int first_isr = pic_highest_priority(base, s->pic.isr);
+    int pending = 0;
+
+    if (first_irr != -1) {
+        if (first_isr == -1) {
+            pending = 1;
+        } else if (first_irr != first_isr) {
+            int irr_lvl = (first_irr - s->pic.priority_base - 1) & 7;
+            int isr_lvl = (first_isr - s->pic.priority_base - 1) & 7;
+            if (irr_lvl < isr_lvl) {
+                pending = 1;
+            }
+        }
+    }
+
+    if (pending != s->pic.irq_level) {
+        s->pic.irq_level = pending;
+        qemu_set_irq(s->parent_irq, pending);
+    }
+}
+
+static uint64_t pic1_read(void *opaque, hwaddr addr, unsigned size)
+{
+    PC87560SuperioState *s = opaque;
+    if (addr == 0) {
+        if (s->pic.poll_mode) {
+            s->pic.poll_mode = false;
+            uint8_t pending_mask = s->pic.irr & ~s->pic.imr;
+            int irq = pic_highest_priority(s->pic.priority_base, pending_mask);
+            if (irq == -1) {
+                pic_update_irq(s);
+                return 0x00;
+            }
+            s->pic.isr |= (1 << irq);
+            pic_update_irq(s);
+            return 0x80 | irq;
+        }
+        return s->pic.read_isr ? s->pic.isr : s->pic.irr;
+    }
+    return s->pic.imr;
+}
+
+static void pic1_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    PC87560SuperioState *s = opaque;
+    uint8_t v = (uint8_t)val;
+
+    if (addr == 1) {
+        if (s->pic.init_phase > 0) {
+            if (s->pic.init_phase == 3) {
+                s->pic.init_phase = 0;
+            } else {
+                s->pic.init_phase++;
+            }
+        } else {
+            s->pic.imr = v;
+            pic_update_irq(s);
+        }
+        return;
+    }
+
+    if (v & 0x10) {
+        s->pic.init_phase = 1;
+        s->pic.imr = 0xFF;
+        s->pic.irr = 0;
+        s->pic.isr = 0;
+        s->pic.poll_mode = false;
+        s->pic.priority_base = 7;
+    } else if (v & 0x08) {
+        if (v & 0x04) {
+            s->pic.poll_mode = true;
+        }
+        if (v & 0x02) {
+            s->pic.read_isr = (v & 0x01);
+        }
+    } else {
+        uint8_t cmd = (v >> 5) & 0x07;
+        uint8_t irq = v & 0x07;
+        switch (cmd) {
+        case 1:
+        case 5: {
+            int serviced = pic_highest_priority(s->pic.priority_base,
+                                                 s->pic.isr);
+            if (serviced != -1) {
+                s->pic.isr &= ~(1 << serviced);
+                if (cmd == 5) {
+                    s->pic.priority_base = serviced;
+                }
+            }
+            break;
+        }
+        case 3:
+        case 7:
+            s->pic.isr &= ~(1 << irq);
+            if (cmd == 7) {
+                s->pic.priority_base = irq;
+            }
+            break;
+        case 6:
+            s->pic.priority_base = irq;
+            break;
+        }
+        pic_update_irq(s);
+    }
+}
+
+static const MemoryRegionOps pc87560_pic1_ops = {
+    .read  = pic1_read,
+    .write = pic1_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 1,
+};
+
+static void pc87560_pic_irq_in(void *opaque, int irq_n, int level)
+{
+    PC87560SuperioState *s = opaque;
+    if (level) {
+        s->pic.irr |=  (1 << irq_n);
+    } else {
+        s->pic.irr &= ~(1 << irq_n);
+    }
+    pic_update_irq(s);
+}
+
+
+static void pc87560_pp_write(void *opaque, hwaddr addr, uint64_t val,
+                             unsigned size)
+{
+    ParallelState *s = opaque;
+    switch (addr) {
+    case 0:
+        s->dataw = (uint8_t)val;
+        if (qemu_chr_fe_backend_connected(&s->chr)) {
+            unsigned char ch = (uint8_t)val;
+            qemu_chr_fe_write_all(&s->chr, &ch, 1);
+        }
+        break;
+    case 2:
+        s->control = (uint8_t)(val & 0x1F);
+        if (!(s->control & 0x10)) {
+            qemu_irq_lower(s->irq);
+        }
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+            "pc87560-pp: write offset 0x%" HWADDR_PRIx "\n", addr);
+    }
+}
+static const MemoryRegionOps pc87560_pp_ops = {
+    .read  = pc87560_pp_read,
+    .write = pc87560_pp_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 1,
+};
+
+/*
+ * Some features on the chip are disabled by default. If a guest
+ * reads or writes one of those registers, respond via this stub
+ * instead of faulting.
+ */
+static uint64_t pc87560_stub_read(void *opaque, hwaddr addr, unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP,
+                  "pc87560-superio: stub read  0x%" HWADDR_PRIx "\n", addr);
+    return 0xFF;
+}
+static void pc87560_stub_write(void *opaque, hwaddr addr, uint64_t val,
+                               unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP,
+                  "pc87560-superio: stub write 0x%" HWADDR_PRIx
+                  " = 0x%" PRIx64 "\n", addr, val);
+}
+
+static const MemoryRegionOps pc87560_stub_ops = {
+    .read = pc87560_stub_read,
+    .write = pc87560_stub_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+
+static uint64_t pc87560_fdc_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return fdctrl_read(opaque, (uint32_t)addr);
+}
+
+static void pc87560_fdc_write(void *opaque, hwaddr addr, uint64_t val,
+                              unsigned size)
+{
+    fdctrl_write(opaque, (uint32_t)addr, (uint32_t)val);
+}
+
+static const MemoryRegionOps pc87560_fdc_ops = {
+    .read  = pc87560_fdc_read,
+    .write = pc87560_fdc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 1,
+};
+
+static void pc87560_map_region(PC87560SuperioState *s, MemoryRegion *mr,
+                               bool *mapped, hwaddr base)
+{
+    MemoryRegion *io = pci_address_space_io(PCI_DEVICE(s));
+    if (*mapped) {
+        memory_region_del_subregion(io, mr);
+        *mapped = false;
+    }
+    if (base) {
+        memory_region_add_subregion(io, base, mr);
+        *mapped = true;
+    }
+}
+
+static void pc87560_apply_funcen(PC87560SuperioState *s)
+{
+    PCIDevice *pci = PCI_DEVICE(s);
+    uint16_t en = pci_get_word(pci->config + REG_FUNCEN);
+
+    pc87560_map_region(s, &s->fdc_io, &s->fdc_mapped, (en & FUNCEN_FDC)
+            ? (pci_get_long(pci->config + REG_FDCBAR) & ~(hwaddr)0x7) : 0);
+
+    pc87560_map_region(s, &s->sp1_io, &s->sp1_mapped, (en & FUNCEN_SP1)
+            ? (pci_get_long(pci->config + REG_SP1BAR) & ~(hwaddr)0x7) : 0);
+
+    pc87560_map_region(s, &s->sp2_io, &s->sp2_mapped, (en & FUNCEN_SP2)
+            ? (pci_get_long(pci->config + REG_SP2BAR) & ~(hwaddr)0x7) : 0);
+
+    pc87560_map_region(s, &s->pp_io, &s->pp_mapped,   (en & FUNCEN_PP)
+            ? (pci_get_long(pci->config + REG_PPBAR) & ~(hwaddr)0x7) : 0);
+
+    pc87560_map_region(s, &s->kbc_io, &s->kbc_mapped, (en & FUNCEN_KBC)
+            ? (pci_get_long(pci->config + REG_KBCBAR) & ~(hwaddr)0x7) : 0);
+}
+
+static void pc87560_superio_config_write(PCIDevice *pci,
+                                         uint32_t addr, uint32_t val, int len)
+{
+    PC87560SuperioState *s = PC87560_Superio(pci);
+    uint16_t funcen;
+
+    pci_default_write_config(pci, addr, val, len);
+    funcen = pci_get_word(pci->config + REG_FUNCEN);
+
+    if (ranges_overlap(addr, len, REG_FUNCEN, 2)) {
+        pc87560_apply_funcen(s);
+    }
+
+    if (ranges_overlap(addr, len, REG_FDCBAR, 4)) {
+        if (funcen & FUNCEN_FDC) {
+            pc87560_map_region(s, &s->fdc_io, &s->fdc_mapped,
+               pci_get_long(pci->config + REG_FDCBAR) & ~(hwaddr)0x7);
+        }
+    }
+
+    if (ranges_overlap(addr, len, REG_SP1BAR, 4)) {
+        if (funcen & FUNCEN_SP1) {
+            pc87560_map_region(s, &s->sp1_io, &s->sp1_mapped,
+               pci_get_long(pci->config + REG_SP1BAR) & ~(hwaddr)0x7);
+        }
+    }
+
+    if (ranges_overlap(addr, len, REG_SP2BAR, 4)) {
+        if (funcen & FUNCEN_SP2) {
+            pc87560_map_region(s, &s->sp2_io, &s->sp2_mapped,
+               pci_get_long(pci->config + REG_SP2BAR) & ~(hwaddr)0x7);
+        }
+    }
+
+    if (ranges_overlap(addr, len, REG_PPBAR, 4)) {
+        if (funcen & FUNCEN_PP) {
+            pc87560_map_region(s, &s->pp_io, &s->pp_mapped,
+               pci_get_long(pci->config + REG_PPBAR) & ~(hwaddr)0x7);
+        }
+    }
+
+    if (ranges_overlap(addr, len, REG_KBCBAR, 4)) {
+        if (funcen & FUNCEN_KBC) {
+            pc87560_map_region(s, &s->kbc_io, &s->kbc_mapped,
+               pci_get_long(pci->config + REG_KBCBAR) & ~(hwaddr)0x7);
+        }
+    }
+
+    if (ranges_overlap(addr, len, REG_ACPIBAR, 4)) {
+        uint32_t ab = pci_get_long(pci->config + REG_ACPIBAR);
+        pc87560_map_region(s, &s->acpi_io, &s->acpi_mapped,
+                           (ab & 1) ? (ab & ~(hwaddr)0x1F) : 0);
+    }
+
+    if (ranges_overlap(addr, len, REG_PMBAR, 4)) {
+        uint32_t pb = pci_get_long(pci->config + REG_PMBAR);
+        pc87560_map_region(s, &s->pm_io, &s->pm_mapped,
+                           (pb & 1) ? (pb & ~(hwaddr)0xFF) : 0);
+    }
+
+    if (ranges_overlap(addr, len, REG_RSVD_CFG, 1)) {
+        if ((pci->config[REG_RSVD_CFG] & 0x0F) != 0x01) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                  "pc87560-superio: offset 0x7E bits[3:0] must be 0x01\n");
+        }
+    }
+}
+
+static void pc87560_superio_realize(PCIDevice *pci, Error **errp)
+{
+    PC87560SuperioState *s = PC87560_Superio(pci);
+    MemoryRegion   *io = pci_address_space_io(pci);
+
+    pci_set_word(pci->config + REG_FUNCEN,  FUNCEN_DEFAULT);
+    pci->config[REG_RSVD_CFG]   = 0x01;
+    pci->config[REG_DMA_ROUTE1] = 0x67;
+    pci->config[REG_PPDID]      = 0x10;
+
+    pci_set_long(pci->config + REG_KBCBAR,  0x00000060); /* not usable */
+    pci_set_long(pci->config + REG_ACPIBAR, 0x00004001);
+    pci_set_long(pci->config + REG_PMBAR,   0xFFFFFF01);
+    pci_set_long(pci->config + REG_FDCBAR,  0x000003F0); /* not usable */
+    pci_set_long(pci->config + REG_SP1BAR,  0x000003F8);
+    pci_set_long(pci->config + REG_SP2BAR,  0x000002F8);
+    pci_set_long(pci->config + REG_PPBAR,   0x00000378);
+
+
+    pci_set_long(pci->wmask + REG_KBCBAR,  0xFFFFFFF8); /* not usable */
+    pci_set_long(pci->wmask + REG_ACPIBAR, 0xFFFFFFE1);
+    pci_set_long(pci->wmask + REG_PMBAR,   0xFFFFFF01);
+    pci_set_long(pci->wmask + REG_FDCBAR,  0xFFFFFFF8); /* not usable */
+    pci_set_long(pci->wmask + REG_SP1BAR,  0xFFFFFFF8);
+    pci_set_long(pci->wmask + REG_SP2BAR,  0xFFFFFFF8);
+    pci_set_long(pci->wmask + REG_PPBAR,   0xFFFFFFF8);
+
+    pci->config[PCI_INTERRUPT_PIN] = 0x01;
+
+    qdev_init_gpio_out_named(DEVICE(pci), &s->parent_irq, "pic-out", 1);
+    qdev_init_gpio_in_named(DEVICE(pci), pc87560_pic_irq_in, "pic-irq", 8);
+
+    memory_region_init_io(&s->pic1_io, OBJECT(s), &pc87560_pic1_ops,
+                          s, "pc87560-pic1", 2);
+    memory_region_add_subregion(io, IC_PIC1, &s->pic1_io);
+
+    s->serial[0].irq = qemu_allocate_irq(pc87560_pic_irq_in, s, 3);
+    if (!qdev_realize(DEVICE(&s->serial[0]), NULL, errp)) {
+        return;
+    }
+    memory_region_init_io(&s->sp1_io, OBJECT(s), &serial_io_ops,
+                          &s->serial[0], "pc87560-sp1", 8);
+    memory_region_add_subregion(io, 0x3F8, &s->sp1_io);
+    s->sp1_mapped = true;
+
+    s->serial[1].irq = qemu_allocate_irq(pc87560_pic_irq_in, s, 4);
+    if (!qdev_realize(DEVICE(&s->serial[1]), NULL, errp)) {
+        return;
+    }
+    memory_region_init_io(&s->sp2_io, OBJECT(s), &serial_io_ops,
+                          &s->serial[1], "pc87560-sp2", 8);
+    memory_region_add_subregion(io, 0x2F8, &s->sp2_io);
+    s->sp2_mapped = true;
+
+    s->pp.irq        = qemu_allocate_irq(pc87560_pic_irq_in, s, 5);
+    memory_region_init_io(&s->pp_io, OBJECT(s), &pc87560_pp_ops,
+                          &s->pp, "pc87560-pp", 8);
+    memory_region_add_subregion(io, 0x378, &s->pp_io);
+    s->pp_mapped = true;
+    s->pic.irq_level = -1;
+    s->pic.priority_base = 7;
+    s->fdc.irq       = qemu_allocate_irq(pc87560_pic_irq_in, s, 6);
+    s->fdc.dma_chann = -1;
+    s->fdc.dma       = NULL;
+    s->fdc.fallback  = FLOPPY_DRIVE_TYPE_144;
+    fdctrl_realize_common(DEVICE(pci), &s->fdc, errp);
+    if (*errp) {
+        return;
+    }
+    memory_region_init_io(&s->fdc_io, OBJECT(s), &pc87560_fdc_ops,
+                          &s->fdc, "pc87560-fdc", 8);
+    memory_region_add_subregion(io, 0x3F0, &s->fdc_io);
+    s->fdc_mapped = true;
+
+    memory_region_init_io(&s->kbc_io, OBJECT(s), &pc87560_stub_ops,
+                          s, "pc87560-kbc", 8);
+    memory_region_add_subregion(io, 0x60, &s->kbc_io);
+    s->kbc_mapped = true;
+
+    memory_region_init_io(&s->acpi_io, OBJECT(s), &pc87560_stub_ops,
+                          s, "pc87560-acpi", 32);
+    memory_region_add_subregion(io, 0x4000, &s->acpi_io);
+    s->acpi_mapped = true;
+
+    memory_region_init_io(&s->pm_io, OBJECT(s), &pc87560_stub_ops,
+                          s, "pc87560-pm", 256);
+}
+
+static void pc87560_superio_instance_init(Object *obj)
+{
+    PC87560SuperioState *s = PC87560_Superio(obj);
+
+    object_initialize_child(obj, "serial[*]", &s->serial[0], TYPE_SERIAL);
+    object_initialize_child(obj, "serial[*]", &s->serial[1], TYPE_SERIAL);
+}
+
+static const VMStateDescription vmstate_pc87560_superio = {
+    .name               = "pc87560-superio",
+    .version_id         = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_PCI_DEVICE(parent_obj, PC87560SuperioState),
+        VMSTATE_STRUCT_ARRAY(serial, PC87560SuperioState, 2, 0,
+                             vmstate_serial, SerialState),
+        VMSTATE_STRUCT(fdc, PC87560SuperioState, 0, vmstate_fdc, FDCtrl),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const Property pc87560_superio_properties[] = {
+    DEFINE_PROP_CHR("serial0",  PC87560SuperioState, serial[0].chr),
+    DEFINE_PROP_CHR("serial1",  PC87560SuperioState, serial[1].chr),
+    DEFINE_PROP_CHR("parallel", PC87560SuperioState, pp.chr),
+};
+
+static void pc87560_superio_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass    *dc = DEVICE_CLASS(oc);
+    PCIDeviceClass *k  = PCI_DEVICE_CLASS(oc);
+
+    k->realize       = pc87560_superio_realize;
+    k->config_write  = pc87560_superio_config_write;
+    k->vendor_id     = PCI_VENDOR_ID_NS;
+    k->device_id     = PCI_DEVICE_ID_NS_87560_LIO;
+    k->class_id      = 0x0680;
+    k->revision      = 0x01;
+    k->subsystem_vendor_id = PCI_VENDOR_ID_HP;
+    k->subsystem_id  = 0x10A7;
+
+    dc->desc           = "NS PC87560 SuperI/O Function 1 (I/O Peripherals)";
+    dc->vmsd           = &vmstate_pc87560_superio;
+    dc->user_creatable = false;
+    device_class_set_props(dc, pc87560_superio_properties);
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+}
+
+static const TypeInfo pc87560_superio_info = {
+    .name          = TYPE_PC87560_Superio,
+    .parent        = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(PC87560SuperioState),
+    .instance_init = pc87560_superio_instance_init,
+    .class_init    = pc87560_superio_class_init,
+    .interfaces    = (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
+};
+
+static void pc87560_superio_register_types(void)
+{
+    type_register_static(&pc87560_superio_info);
+}
+
+type_init(pc87560_superio_register_types)
diff --git a/include/hw/isa/pc87560.h b/include/hw/isa/pc87560.h
new file mode 100644
index 0000000000..72e317cc7b
--- /dev/null
+++ b/include/hw/isa/pc87560.h
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#ifndef HW_ISA_PC87560_H
+#define HW_ISA_PC87560_H
+
+#define TYPE_PC87560_Superio  "pc87560-superio"
+OBJECT_DECLARE_SIMPLE_TYPE(PC87560SuperioState, PC87560_Superio)
+
+#define REG_FXBAR0      0x40
+#define REG_FXBAR1      0x44
+#define REG_FXBAR2      0x48
+#define REG_DDMA_BAR    0x4C
+#define REG_FIR_BAR     0x50
+#define REG_SYSCFG      0x58
+#define REG_FUNCEN      0x5A
+#define REG_SIOCFG      0x5C
+#define REG_SPECFEN     0x5D
+#define REG_PPDID       0x5E
+#define REG_PPMODE      0x5F
+#define REG_DMA_ROUTE4  0x61
+#define REG_ROMCFG      0x62
+#define REG_DMA_ROUTE1  0x63
+#define REG_DMA_ROUTE2  0x64
+#define REG_DMA_ROUTE3  0x65
+#define REG_DMA_CHAN    0x66
+#define REG_IRQ_TRIG    0x67
+#define REG_IRQ_ROUTE1  0x69
+#define REG_ARBCTL      0x72
+#define REG_FX_MASK2    0x74
+#define REG_FX_TIMING   0x76
+#define REG_FXCTL       0x78
+#define REG_GPIO_CFG    0x79
+#define REG_GPIO_DIR    0x7A
+#define REG_SIRQ_CTL    0x7B
+#define REG_SIRQ_EN     0x7C
+#define REG_RSVD_CFG    0x7E
+#define REG_AUDIOCS_EN  0x7F
+#define REG_FXMEM_CTL1  0x80
+#define REG_KBCBAR      0x84
+#define REG_ACPIBAR     0x88
+#define REG_PMBAR       0x8C
+#define REG_FDCBAR      0x90
+#define REG_SP1BAR      0x94
+#define REG_SP2BAR      0x98
+#define REG_PPBAR       0x9C
+#define REG_TEST_CTL    0xFF
+
+#define FUNCEN_FDC  (1 << 0)
+#define FUNCEN_SP1  (1 << 1)
+#define FUNCEN_SP2  (1 << 3)
+#define FUNCEN_PP   (1 << 5)
+#define FUNCEN_KBC  (1 << 13)
+
+#define FUNCEN_DEFAULT  0xFFBF
+
+#define IC_PIC1  0x20
+
+typedef struct {
+    uint8_t imr;       /* interrupt mask register (OCW1) */
+    uint8_t irr;       /* interrupt request register    */
+    uint8_t isr;       /* in-service register           */
+    bool    poll_mode; /* OCW3 POLL bit set             */
+    bool    read_isr;  /* OCW3: true=ISR, false=IRR     */
+    int     init_phase;/* 0=normal, 1-3=ICW2/3/4 expected */
+    int     priority_base;
+    int     irq_level;
+} Pic8259;
+
+struct PC87560SuperioState {
+    PCIDevice parent_obj;
+
+    qemu_irq parent_irq;
+
+    SerialState   serial[2];
+    ParallelState pp;
+    FDCtrl        fdc;
+
+    MemoryRegion fdc_io;
+    MemoryRegion sp1_io;
+    MemoryRegion sp2_io;
+    MemoryRegion pp_io;
+    MemoryRegion kbc_io;
+    MemoryRegion acpi_io;
+    MemoryRegion pm_io;
+    MemoryRegion pic1_io;
+
+    bool fdc_mapped;
+    bool sp1_mapped;
+    bool sp2_mapped;
+    bool pp_mapped;
+    bool kbc_mapped;
+    bool acpi_mapped;
+    bool pm_mapped;
+    Pic8259 pic;
+};
+
+#endif
-- 
2.54.0


