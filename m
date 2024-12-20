Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C072E7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 01:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSFC-0006ie-6I; Thu, 19 Dec 2024 20:55:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSF8-0006bn-1w
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:54 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSF5-0004WE-Nb
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:53 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7fd49d85f82so1065011a12.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659750; x=1735264550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DJifk/ZkFF7i5sCtB8O20kVQGuGYmKee7SvG1FKHwC8=;
 b=TVVMfkbEq/BIgLMcSyRdTLMlslKqEucPTZxqAA553C8Alh1y5ib5mJ0w39FOGjA3/S
 sTdFg68tgzBy82c6nWumeZYQ3iE7HKTWd7T6GY0O3AVBysKK8q3BpSBLP7fxqwmZ0C0E
 ASPLYm+o+blFL9+eEKVh3sZocUqK1Uare1cckzLX0lhKhDKOF0Cs0FbTMwUQ5Tnji7AY
 mDebhnSjJOaRpollFMFA94EIQccG3AzOLBzoIs0cxhYbu9yyUSxmbX4Z0DaLz/4FcMLC
 y0EahGdiaBuZtGsj0mpQUa/kdmq3PwvsAiyMW8hKBbNIN8ufLzYB3tgXvfSAamiED9bh
 vgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659750; x=1735264550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DJifk/ZkFF7i5sCtB8O20kVQGuGYmKee7SvG1FKHwC8=;
 b=taUrWrhZlNBJEcP4RXVFxvdwp169ZORFQFuuq/lrdrCtRct2haYo3tm9QgIT1YLK5j
 zvLUjFPLU1nj3AGIBv/qzgC1+TpHCvu8LPMhabHHxghqvG6Fj2oQxZp4gReO5XKNl1AE
 07J76edzhS8fb5f8V81jrB14kp0IYIVwEKd/ui7l57UJ1QCjE373ppp6b1Qg4CCb2nDC
 XJqtMxVNaE4E9QJkbhUW5I6jMxbf2koxwUu+1lWSuKoXzMK5c6EtbGISoAjeYNOb0Fan
 TlNsgTnpKmKktKUPRxGI0Ju+JserxRBnCersiYOC7Lija6Kglte6P+YsdzQCCyV3Isnt
 NHOw==
X-Gm-Message-State: AOJu0YxvxJzIrXlDjZ7xeFzFMKj5eUq7h2XAi8dwdXudJRroxUSPl+Wf
 mLXvWsWzodinL9Piv4vwdty5uOzSNZjY2lw4LtStcoEefVxI6Fqur/ULzFYG
X-Gm-Gg: ASbGncu+H7PlbSj8jlKRQ1zfroYP2BKWAzquZ2FZ9303G4RxQAupyzanHytWKCkuea9
 iGkbHIeoiOjATxlJv6YLCJTNzK6tOfnFdBfmzcdTz8nsQ92F6B4/Y+z4Q+2AEXRti+jUjcyjX6f
 3PNLLr+FIYieC/DGRf6Eh7ncVFZwhJXww1sPeu8f4P9Uzc6SZxPSE01YNqQXdiQjUCUPL9sWl2J
 6YCOQC/3GzvNiQ8gFUu18TGXqq+vuoBOKbNoYzqFGsO40wVsbD6tk3diFFVTVNJIROkx9ocpWno
 JNNuKz3aL8j8beJoZPYltjLR9wJRtVI43l6fQ76GAtSSxdbyR9N+UkVgyNBaFls=
X-Google-Smtp-Source: AGHT+IGNQa4NV2rtQ46Kp4fcUIn+LG2FXdCNUkdiex1CGTqajCHqMKGe0wlXlO2rBn5p+HjaCqoRyw==
X-Received: by 2002:a05:6a21:3a44:b0:1e0:d6d5:39c3 with SMTP id
 adf61e73a8af0-1e5e043f6b3mr2404887637.8.1734659749991; 
 Thu, 19 Dec 2024 17:55:49 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:55:49 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 19/39] hw/riscv: Add Microblaze V generic board
Date: Fri, 20 Dec 2024 11:54:19 +1000
Message-ID: <20241220015441.317236-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>

Add a basic board with interrupt controller (intc), timer, serial
(uartlite), small memory called LMB@0 (128kB) and DDR@0x80000000
(configured via command line eg. -m 2g).
This is basic configuration which matches HW generated out of AMD Vivado
(design tools). But initial configuration is going beyond what it is
configured by default because validation should be done on other
configurations too. That's why wire also additional uart16500, axi
ethernet(with axi dma).
GPIOs, i2c and qspi is also listed for completeness.

IRQ map is: (addr)
0 - timer (0x41c00000)
1 - uartlite (0x40600000)
2 - i2c (0x40800000)
3 - qspi (0x44a00000)
4 - uart16550 (0x44a10000)
5 - emaclite (0x40e00000)
6 - timer2 (0x41c10000)
7 - axi emac (0x40c00000)
8 - axi dma (0x41e00000)
9 - axi dma
10 - gpio (0x40000000)
11 - gpio2 (0x40010000)
12 - gpio3 (0x40020000)

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241125134739.18189-1-sai.pavan.boddu@amd.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS                                |   6 +
 docs/system/riscv/microblaze-v-generic.rst |  42 +++++
 docs/system/target-riscv.rst               |   1 +
 hw/riscv/microblaze-v-generic.c            | 184 +++++++++++++++++++++
 hw/riscv/Kconfig                           |   8 +
 hw/riscv/meson.build                       |   1 +
 6 files changed, 242 insertions(+)
 create mode 100644 docs/system/riscv/microblaze-v-generic.rst
 create mode 100644 hw/riscv/microblaze-v-generic.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 430a0f4f8c..fb6a66f1f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1626,6 +1626,12 @@ F: docs/system/riscv/sifive_u.rst
 F: hw/*/*sifive*.c
 F: include/hw/*/*sifive*.h
 
+AMD Microblaze-V Generic Board
+M: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
+S: Maintained
+F: hw/riscv/microblaze-v-generic.c
+F: docs/system/riscv/microblaze-v-generic.rst
+
 RX Machines
 -----------
 rx-gdbsim
diff --git a/docs/system/riscv/microblaze-v-generic.rst b/docs/system/riscv/microblaze-v-generic.rst
new file mode 100644
index 0000000000..5606f88d57
--- /dev/null
+++ b/docs/system/riscv/microblaze-v-generic.rst
@@ -0,0 +1,42 @@
+Microblaze-V generic board (``amd-microblaze-v-generic``)
+=========================================================
+The AMD MicroBlaze™ V processor is a soft-core RISC-V processor IP for AMD
+adaptive SoCs and FPGAs. The MicroBlaze™ V processor is based on the 32-bit (or
+64-bit) RISC-V instruction set architecture (ISA) and contains interfaces
+compatible with the classic MicroBlaze™ V processor (i.e it is a drop in
+replacement for the classic MicroBlaze™ processor in existing RTL designs).
+More information can be found in below document.
+
+https://docs.amd.com/r/en-US/ug1629-microblaze-v-user-guide/MicroBlaze-V-Architecture
+
+The MicroBlaze™ V generic board in QEMU has following supported devices:
+
+    - timer
+    - uartlite
+    - uart16550
+    - emaclite
+    - timer2
+    - axi emac
+    - axi dma
+
+The MicroBlaze™ V core in QEMU has the following configuration:
+
+    - RV32I base integer instruction set
+    - "Zicsr" Control and Status register instructions
+    - "Zifencei" instruction-fetch
+    - Extensions: m, a, f, c
+
+Running
+"""""""
+Below is an example command line for launching mainline U-boot
+(xilinx_mbv32_defconfig) on the Microblaze-V generic board.
+
+.. code-block:: bash
+
+   $ qemu-system-riscv32 -M amd-microblaze-v-generic \
+     -display none \
+     -device loader,addr=0x80000000,file=u-boot-spl.bin,cpu-num=0 \
+     -device loader,addr=0x80200000,file=u-boot.img \
+     -serial mon:stdio \
+     -device loader,addr=0x83000000,file=system.dtb \
+     -m 2g
diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index ba195f1518..95457af130 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -66,6 +66,7 @@ undocumented; you can get a complete list by running
 .. toctree::
    :maxdepth: 1
 
+   riscv/microblaze-v-generic
    riscv/microchip-icicle-kit
    riscv/shakti-c
    riscv/sifive_u
diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
new file mode 100644
index 0000000000..427e3baca7
--- /dev/null
+++ b/hw/riscv/microblaze-v-generic.c
@@ -0,0 +1,184 @@
+/*
+ * QEMU model of Microblaze V generic board.
+ *
+ * based on hw/microblaze/petalogix_ml605_mmu.c
+ *
+ * Copyright (c) 2011 Michal Simek <monstr@monstr.eu>
+ * Copyright (c) 2011 PetaLogix
+ * Copyright (c) 2009 Edgar E. Iglesias.
+ * Copyright (C) 2024, Advanced Micro Devices, Inc.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Written by Sai Pavan Boddu <sai.pavan.boddu@amd.com
+ *     and by Michal Simek <michal.simek@amd.com>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "hw/sysbus.h"
+#include "sysemu/sysemu.h"
+#include "net/net.h"
+#include "hw/boards.h"
+#include "hw/char/serial-mm.h"
+#include "exec/address-spaces.h"
+#include "hw/char/xilinx_uartlite.h"
+#include "hw/misc/unimp.h"
+
+#define LMB_BRAM_SIZE (128 * KiB)
+#define MEMORY_BASEADDR 0x80000000
+#define INTC_BASEADDR 0x41200000
+#define TIMER_BASEADDR 0x41c00000
+#define TIMER_BASEADDR2 0x41c10000
+#define UARTLITE_BASEADDR 0x40600000
+#define ETHLITE_BASEADDR 0x40e00000
+#define UART16550_BASEADDR 0x44a10000
+#define AXIENET_BASEADDR 0x40c00000
+#define AXIDMA_BASEADDR 0x41e00000
+#define GPIO_BASEADDR 0x40000000
+#define GPIO_BASEADDR2 0x40010000
+#define GPIO_BASEADDR3 0x40020000
+#define I2C_BASEADDR 0x40800000
+#define QSPI_BASEADDR 0x44a00000
+
+#define TIMER_IRQ           0
+#define UARTLITE_IRQ        1
+#define UART16550_IRQ       4
+#define ETHLITE_IRQ         5
+#define TIMER_IRQ2          6
+#define AXIENET_IRQ         7
+#define AXIDMA_IRQ1         8
+#define AXIDMA_IRQ0         9
+
+static void mb_v_generic_init(MachineState *machine)
+{
+    ram_addr_t ram_size = machine->ram_size;
+    DeviceState *dev, *dma, *eth0;
+    Object *ds, *cs;
+    int i;
+    RISCVCPU *cpu;
+    hwaddr ddr_base = MEMORY_BASEADDR;
+    MemoryRegion *phys_lmb_bram = g_new(MemoryRegion, 1);
+    MemoryRegion *phys_ram = g_new(MemoryRegion, 1);
+    qemu_irq irq[32];
+    MemoryRegion *sysmem = get_system_memory();
+
+    cpu = RISCV_CPU(object_new(machine->cpu_type));
+    object_property_set_bool(OBJECT(cpu), "h", false, NULL);
+    object_property_set_bool(OBJECT(cpu), "d", false, NULL);
+    qdev_realize(DEVICE(cpu), NULL, &error_abort);
+    /* Attach emulated BRAM through the LMB.  */
+    memory_region_init_ram(phys_lmb_bram, NULL,
+                           "mb_v.lmb_bram", LMB_BRAM_SIZE,
+                           &error_fatal);
+    memory_region_add_subregion(sysmem, 0x00000000, phys_lmb_bram);
+
+    memory_region_init_ram(phys_ram, NULL, "mb_v.ram",
+                           ram_size, &error_fatal);
+    memory_region_add_subregion(sysmem, ddr_base, phys_ram);
+
+    dev = qdev_new("xlnx.xps-intc");
+    qdev_prop_set_uint32(dev, "kind-of-intr",
+                         1 << UARTLITE_IRQ);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, INTC_BASEADDR);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+                       qdev_get_gpio_in(DEVICE(cpu), 11));
+    for (i = 0; i < 32; i++) {
+        irq[i] = qdev_get_gpio_in(dev, i);
+    }
+
+    /* Uartlite */
+    dev = qdev_new(TYPE_XILINX_UARTLITE);
+    qdev_prop_set_chr(dev, "chardev", serial_hd(0));
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, UARTLITE_BASEADDR);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[UARTLITE_IRQ]);
+
+    /* Full uart */
+    serial_mm_init(sysmem, UART16550_BASEADDR + 0x1000, 2,
+                   irq[UART16550_IRQ], 115200, serial_hd(1),
+                   DEVICE_LITTLE_ENDIAN);
+
+    /* 2 timers at irq 0 @ 100 Mhz.  */
+    dev = qdev_new("xlnx.xps-timer");
+    qdev_prop_set_uint32(dev, "one-timer-only", 0);
+    qdev_prop_set_uint32(dev, "clock-frequency", 100000000);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, TIMER_BASEADDR);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ]);
+
+    /* 2 timers at irq 3 @ 100 Mhz.  */
+    dev = qdev_new("xlnx.xps-timer");
+    qdev_prop_set_uint32(dev, "one-timer-only", 0);
+    qdev_prop_set_uint32(dev, "clock-frequency", 100000000);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, TIMER_BASEADDR2);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ2]);
+
+    /* Emaclite */
+    dev = qdev_new("xlnx.xps-ethernetlite");
+    qemu_configure_nic_device(dev, true, NULL);
+    qdev_prop_set_uint32(dev, "tx-ping-pong", 0);
+    qdev_prop_set_uint32(dev, "rx-ping-pong", 0);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, ETHLITE_BASEADDR);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[ETHLITE_IRQ]);
+
+    /* axi ethernet and dma initialization. */
+    eth0 = qdev_new("xlnx.axi-ethernet");
+    dma = qdev_new("xlnx.axi-dma");
+
+    /* FIXME: attach to the sysbus instead */
+    object_property_add_child(qdev_get_machine(), "xilinx-eth", OBJECT(eth0));
+    object_property_add_child(qdev_get_machine(), "xilinx-dma", OBJECT(dma));
+
+    ds = object_property_get_link(OBJECT(dma),
+                                  "axistream-connected-target", NULL);
+    cs = object_property_get_link(OBJECT(dma),
+                                  "axistream-control-connected-target", NULL);
+    qemu_configure_nic_device(eth0, true, NULL);
+    qdev_prop_set_uint32(eth0, "rxmem", 0x1000);
+    qdev_prop_set_uint32(eth0, "txmem", 0x1000);
+    object_property_set_link(OBJECT(eth0), "axistream-connected", ds,
+                             &error_abort);
+    object_property_set_link(OBJECT(eth0), "axistream-control-connected", cs,
+                             &error_abort);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(eth0), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(eth0), 0, AXIENET_BASEADDR);
+    sysbus_connect_irq(SYS_BUS_DEVICE(eth0), 0, irq[AXIENET_IRQ]);
+
+    ds = object_property_get_link(OBJECT(eth0),
+                                  "axistream-connected-target", NULL);
+    cs = object_property_get_link(OBJECT(eth0),
+                                  "axistream-control-connected-target", NULL);
+    qdev_prop_set_uint32(dma, "freqhz", 100000000);
+    object_property_set_link(OBJECT(dma), "axistream-connected", ds,
+                             &error_abort);
+    object_property_set_link(OBJECT(dma), "axistream-control-connected", cs,
+                             &error_abort);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dma), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dma), 0, AXIDMA_BASEADDR);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dma), 0, irq[AXIDMA_IRQ0]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dma), 1, irq[AXIDMA_IRQ1]);
+
+    /* unimplemented devices */
+    create_unimplemented_device("gpio", GPIO_BASEADDR, 0x10000);
+    create_unimplemented_device("gpio2", GPIO_BASEADDR2, 0x10000);
+    create_unimplemented_device("gpio3", GPIO_BASEADDR3, 0x10000);
+    create_unimplemented_device("i2c", I2C_BASEADDR, 0x10000);
+    create_unimplemented_device("qspi", QSPI_BASEADDR, 0x10000);
+}
+
+static void mb_v_generic_machine_init(MachineClass *mc)
+{
+    mc->desc = "AMD Microblaze-V generic platform";
+    mc->init = mb_v_generic_init;
+    mc->min_cpus = 1;
+    mc->max_cpus = 1;
+    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
+    mc->default_cpus = 1;
+}
+
+DEFINE_MACHINE("amd-microblaze-v-generic", mb_v_generic_machine_init)
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 2e88467c4a..e6a0ac1fa1 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -25,6 +25,14 @@ config MICROCHIP_PFSOC
     select SIFIVE_PLIC
     select UNIMP
 
+config MICROBLAZE_V
+    bool
+    default y
+    depends on RISCV32 || RISCV64
+    select XILINX
+    select XILINX_AXI
+    select XILINX_ETHLITE
+
 config OPENTITAN
     bool
     default y
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 3be13d7774..3c7e083aca 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -11,5 +11,6 @@ riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
 riscv_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true: files('microchip_pfsoc.c'))
 riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files('riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c'))
+riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c'))
 
 hw_arch += {'riscv': riscv_ss}
-- 
2.47.1


