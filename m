Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A7CCCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 09:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8xed-0002Ae-Kx; Wed, 15 Oct 2025 05:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1v8xeY-000288-GZ
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:18:38 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1v8xe0-0007Hj-Pj
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:18:38 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b3c2db014easo349948266b.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 02:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760519875; x=1761124675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hWNACZIj1pBtQqp+PLYZtIRjjmCtzDYzJpN1kKuma04=;
 b=FulrBW1zCNglQoGP6oS53+VBzryhmLQd1vvPCO6+/qq0GGAf/j5cyv8m7To4wRZh4d
 SFYVKb27MTU29te2jFcpaCzEAh0ecUaib1l+kGAKIc/x4EM0zNaPsLFz+wyZMkDxwfHe
 VTT7F9qnEPid0NW32v2Ohf3oVGs0d9dpzC7wmXu3YS+DzT9xUvACPwzoSos78zkZ8a7U
 jCVvOb7Ay+LYdmFOWebjB5TMAA9BUklWpUYe6oVK1zmpYKPaSP3ikKj5efctU0WP4XM1
 3KLRbVnK6G2GH6/WPeVVZjPhYjjHRHQ8los7uUT1es22PMi2jUmohb883vStqjhSRkow
 Bl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519875; x=1761124675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hWNACZIj1pBtQqp+PLYZtIRjjmCtzDYzJpN1kKuma04=;
 b=JTDcAb8aQG6/WYUVAqzGTZ5nV/jhhHPonFRBKvF9mWq4q7B5z+id56w2f/wtdT8h55
 T4THoFkwCCF0CF/Kyt+sfoEHtAz7RoJ9G6jOC1trxBA0yTUEaRfy7lTCzCUSHiJsGht3
 VR6c7jMb97GGZlQpxkp/r4qn2EwTKUuVYTWH+RvyLKJYCXuD15nfrdLNaqe7nifjchFh
 93Zxfu486278WfDe2NOvUKauPmRShQn/gUgRieCxgbAA2PXUK7WTk5Xkcynd5E+KqoLI
 VHo1lyHd8gbbOA24HfeMNXDZWeJUVVXlB4wIaoUotNfvUUUnt106I2cPsONFJK3QlVfz
 nmDQ==
X-Gm-Message-State: AOJu0YwuWdAFlklg+GEKEUi5MndEsAvsBuVpMOzZ2XJVrwj1FqWSMGST
 a0QxK/4vNrVDvSbmmyM6657KlC6fVTZcy4/1sa3H1nkIpiPWYTF/9WFlZYYg5LrHBWU=
X-Gm-Gg: ASbGncvpCZEMbITQd1wq1FlVh6VRNxd4Ar46uhUmVKngEcfScmCl3Mj3o8BFLTUIkha
 XRev5JxJ05ry5yDHsmeye1fmLPuCSM9e47P5KE9b7t31ZPxGmxejTGGWO4SIb+zQZ5N/A0G80vM
 gC47rOXYED5f3tdwAVVJveu26FuHbXwb9GITEvbAUbc73Hh9khZylpLYq3/WN3BJShrmCfLNidh
 UlZm0gVxfB7wJszuseWV9wlZT+vnEFGz0c7Kd5L+lKD0BQO9hJmk7Bxv7y1wtJzSLPV/7aHoZHv
 E2qBN9kzv27Xd6OS+hU1ePn6UZ7zBoZ6Fi3gUTJ7cBxBIJ2z5sLNGhWviBvuS4+ZmXhNWyuLiLi
 HjMcXNH0fIveItWLJtjmXN3xSi4qSgTCPCfS++baFJvM2qjec2qdnqqQKZSyrLA==
X-Google-Smtp-Source: AGHT+IEktc5Azdknhys3dWTggRhjxjJl7osF8Xrc2CIMGynr09FlzBkx5lr578RaBpQIe56jQofBlw==
X-Received: by 2002:a17:907:9407:b0:b2b:3481:93c8 with SMTP id
 a640c23a62f3a-b50aa3921e2mr3042371966b.19.1760519874478; 
 Wed, 15 Oct 2025 02:17:54 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b5cb9e7a23dsm182069966b.23.2025.10.15.02.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 02:17:54 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH v3 13/14] hw/arm: Add new machine based on xilinx-zynq-a9 for
 Beckhoff CX7200
Date: Wed, 15 Oct 2025 11:17:28 +0200
Message-ID: <20251015091729.33761-14-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251015091729.33761-1-corvin.koehne@gmail.com>
References: <20251015091729.33761-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: YannickV <Y.Vossen@beckhoff.com>

This commit introduces a new machine, derived from xilinx-zynq-a9.
While retaining the foundational architecture, unnecessary peripherals
have been removed and the remaining peripherals have been adapted to
match the CX7200's hardware layout and behavior.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
---
 hw/arm/Kconfig           |  18 ++
 hw/arm/beckhoff_CX7200.c | 443 +++++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build       |   1 +
 3 files changed, 462 insertions(+)
 create mode 100644 hw/arm/beckhoff_CX7200.c

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index b44b85f436..ac1b660c66 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -307,6 +307,24 @@ config ZYNQ
     select XILINX_SPIPS
     select ZYNQ_DEVCFG
 
+config BECKHOFF_CX7200
+    bool
+    default y
+    depends on TCG && ARM
+    select A9MPCORE
+    select CADENCE # UART
+    select PFLASH_CFI02
+    select PL310 # cache controller
+    select PL330
+    select SDHCI
+    select SSI_M25P80
+    select XILINX # UART
+    select XILINX_AXI
+    select XILINX_SPI
+    select XILINX_SPIPS
+    select ZYNQ_DEVCFG
+    select BECKHOFF_CCAT
+
 config ARM_V7M
     bool
     # currently v7M must be included in a TCG build due to translate.c
diff --git a/hw/arm/beckhoff_CX7200.c b/hw/arm/beckhoff_CX7200.c
new file mode 100644
index 0000000000..b99e022931
--- /dev/null
+++ b/hw/arm/beckhoff_CX7200.c
@@ -0,0 +1,443 @@
+/*
+ * Modified Xilinx Zynq Baseboard System emulation for Beckhoff CX7200.
+ *
+ * Copyright (c) 2024 Beckhoff Automation GmbH & Co. KG
+ *
+ * Based on /hw/arm/xilinx_zynq.c:
+ * Copyright (c) 2010 Xilinx.
+ * Copyright (c) 2012 Peter A.G. Crosthwaite (peter.croshtwaite@petalogix.com)
+ * Copyright (c) 2012 Petalogix Pty Ltd.
+ * Original code by Haibing Ma.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "hw/arm/boot.h"
+#include "net/net.h"
+#include "system/system.h"
+#include "hw/boards.h"
+#include "hw/block/flash.h"
+#include "hw/loader.h"
+#include "hw/adc/zynq-xadc.h"
+#include "hw/ssi/ssi.h"
+#include "qemu/error-report.h"
+#include "hw/sd/sdhci.h"
+#include "hw/char/cadence_uart.h"
+#include "hw/net/cadence_gem.h"
+#include "hw/cpu/a9mpcore.h"
+#include "hw/qdev-clock.h"
+#include "hw/misc/unimp.h"
+#include "system/reset.h"
+#include "qom/object.h"
+#include "exec/tswap.h"
+#include "target/arm/cpu-qom.h"
+#include "qapi/visitor.h"
+#include "system/block-backend.h"
+
+
+#define TYPE_CX7200_MACHINE MACHINE_TYPE_NAME("beckhoff-cx7200")
+OBJECT_DECLARE_SIMPLE_TYPE(CX7200MachineState, CX7200_MACHINE)
+
+/* board base frequency: 33.333333 MHz */
+#define PS_CLK_FREQUENCY (100 * 1000 * 1000 / 3)
+
+#define PERIPHCLK_DIVIDER 2
+#define PS7_CPU_CLK_FREQUENCY 720000000
+
+#define NUM_SPI_FLASHES 0
+#define NUM_QSPI_FLASHES 1
+#define NUM_QSPI_BUSSES 1
+
+#define IRQ_OFFSET 32 /* pic interrupts start from index 32 */
+
+#define MPCORE_PERIPHBASE 0xF8F00000
+#define ZYNQ_BOARD_MIDR 0x413FC090
+
+static const int dma_irqs[8] = {
+    46, 47, 48, 49, 72, 73, 74, 75
+};
+
+#define BOARD_SETUP_ADDR        0x100
+
+#define SLCR_LOCK_OFFSET        0x004
+#define SLCR_UNLOCK_OFFSET      0x008
+#define SLCR_ARM_PLL_OFFSET     0x100
+
+#define SLCR_XILINX_UNLOCK_KEY  0xdf0d
+#define SLCR_XILINX_LOCK_KEY    0x767b
+
+#define ZYNQ_SDHCI_CAPABILITIES 0x69ec0080  /* Datasheet: UG585 (v1.12.1) */
+
+#define ARMV7_IMM16(x) (extract32((x),  0, 12) | \
+                        extract32((x), 12,  4) << 16)
+
+/*
+ * Write immediate val to address r0 + addr. r0 should contain base offset
+ * of the SLCR block. Clobbers r1.
+ */
+
+#define SLCR_WRITE(addr, val) \
+    0xe3001000 + ARMV7_IMM16(extract32((val),  0, 16)), /* movw r1 ... */ \
+    0xe3401000 + ARMV7_IMM16(extract32((val), 16, 16)), /* movt r1 ... */ \
+    0xe5801000 + (addr)
+
+#define ZYNQ_MAX_CPUS 2
+
+struct CX7200MachineState {
+    MachineState parent;
+    Clock *ps_clk;
+    ARMCPU *cpu[ZYNQ_MAX_CPUS];
+    uint8_t boot_mode;
+};
+
+static void beckhoff_cx7200_write_board_setup(ARMCPU *cpu,
+                                   const struct arm_boot_info *info)
+{
+    int n;
+    uint32_t board_setup_blob[] = {
+        0xe3a004f8, /* mov r0, #0xf8000000 */
+        SLCR_WRITE(SLCR_UNLOCK_OFFSET, SLCR_XILINX_UNLOCK_KEY),
+        SLCR_WRITE(SLCR_ARM_PLL_OFFSET, 0x00014008),
+        SLCR_WRITE(SLCR_LOCK_OFFSET, SLCR_XILINX_LOCK_KEY),
+        0xe12fff1e, /* bx lr */
+    };
+    for (n = 0; n < ARRAY_SIZE(board_setup_blob); n++) {
+        board_setup_blob[n] = tswap32(board_setup_blob[n]);
+    }
+    rom_add_blob_fixed("board-setup", board_setup_blob,
+                       sizeof(board_setup_blob), BOARD_SETUP_ADDR);
+}
+
+static struct arm_boot_info beckhoff_cx7200_binfo = {};
+
+static void gem_init(uint32_t base, qemu_irq irq)
+{
+    DeviceState *dev;
+    SysBusDevice *s;
+
+    dev = qdev_new(TYPE_CADENCE_GEM);
+    qemu_configure_nic_device(dev, true, NULL);
+    object_property_set_int(OBJECT(dev), "phy-addr", 7, &error_abort);
+    s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_mmio_map(s, 0, base);
+    sysbus_connect_irq(s, 0, irq);
+}
+
+static void ccat_init(uint32_t base, BlockBackend *eeprom_blk)
+{
+    DeviceState *dev;
+    SysBusDevice *busdev;
+
+    dev = qdev_new("beckhoff-ccat");
+    if (eeprom_blk) {
+        qdev_prop_set_drive_err(dev, "eeprom", eeprom_blk, &error_fatal);
+    }
+    busdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_mmio_map(busdev, 0, base);
+}
+
+static void ddr_ctrl_init(uint32_t base)
+{
+    DeviceState *dev;
+    SysBusDevice *busdev;
+
+    dev = qdev_new("zynq.ddr-ctlr");
+    busdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_mmio_map(busdev, 0, base);
+}
+
+static inline int beckhoff_cx7200_init_spi_flashes(uint32_t base_addr,
+                                        qemu_irq irq, bool is_qspi, int unit0)
+{
+    int unit = unit0;
+    DeviceState *dev;
+    SysBusDevice *busdev;
+    SSIBus *spi;
+    DeviceState *flash_dev;
+    int i, j;
+    int num_busses =  is_qspi ? NUM_QSPI_BUSSES : 1;
+    int num_ss = is_qspi ? NUM_QSPI_FLASHES : NUM_SPI_FLASHES;
+
+    dev = qdev_new(is_qspi ? "xlnx.ps7-qspi" : "xlnx.ps7-spi");
+    qdev_prop_set_uint8(dev, "num-txrx-bytes", is_qspi ? 4 : 1);
+    qdev_prop_set_uint8(dev, "num-ss-bits", num_ss);
+    qdev_prop_set_uint8(dev, "num-busses", num_busses);
+    busdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_mmio_map(busdev, 0, base_addr);
+    if (is_qspi) {
+        sysbus_mmio_map(busdev, 1, 0xFC000000);
+    }
+    sysbus_connect_irq(busdev, 0, irq);
+
+    for (i = 0; i < num_busses; ++i) {
+        char bus_name[16];
+        qemu_irq cs_line;
+
+        snprintf(bus_name, 16, "spi%d", i);
+        spi = (SSIBus *)qdev_get_child_bus(dev, bus_name);
+
+        for (j = 0; j < num_ss; ++j) {
+            DriveInfo *dinfo = drive_get(IF_MTD, 0, unit++);
+            flash_dev = qdev_new("is25lp016d");
+            if (dinfo) {
+                qdev_prop_set_drive_err(flash_dev, "drive",
+                                        blk_by_legacy_dinfo(dinfo),
+                                        &error_fatal);
+            }
+            qdev_prop_set_uint8(flash_dev, "cs", j);
+            qdev_realize_and_unref(flash_dev, BUS(spi), &error_fatal);
+
+            cs_line = qdev_get_gpio_in_named(flash_dev, SSI_GPIO_CS, 0);
+            sysbus_connect_irq(busdev, i * num_ss + j + 1, cs_line);
+        }
+    }
+
+    return unit;
+}
+
+static void beckhoff_cx7200_set_boot_mode(Object *obj, const char *str,
+                                               Error **errp)
+{
+    CX7200MachineState *m = CX7200_MACHINE(obj);
+    uint8_t mode = 0;
+
+    if (!strncasecmp(str, "qspi", 4)) {
+        mode = 1;
+    } else if (!strncasecmp(str, "sd", 2)) {
+        mode = 5;
+    } else if (!strncasecmp(str, "nor", 3)) {
+        mode = 2;
+    } else if (!strncasecmp(str, "jtag", 4)) {
+        mode = 0;
+    } else {
+        error_setg(errp, "%s boot mode not supported", str);
+        return;
+    }
+    m->boot_mode = mode;
+}
+
+static void beckhoff_cx7200_init(MachineState *machine)
+{
+    CX7200MachineState *cx7200_machine = CX7200_MACHINE(machine);
+    MemoryRegion *address_space_mem = get_system_memory();
+    MemoryRegion *ocm_ram = g_new(MemoryRegion, 1);
+    DeviceState *carddev, *dev, *slcr;
+    SysBusDevice *busdev;
+    qemu_irq pic[64];
+    int n;
+    unsigned int smp_cpus = machine->smp.cpus;
+    DriveInfo *di;
+    BlockBackend *blk;
+
+    /* max 2GB ram */
+    if (machine->ram_size > 2 * GiB) {
+        error_report("RAM size more than 2 GiB is not supported");
+        exit(EXIT_FAILURE);
+    }
+
+    for (n = 0; n < smp_cpus; n++) {
+        Object *cpuobj = object_new(machine->cpu_type);
+
+        object_property_set_int(cpuobj, "midr", ZYNQ_BOARD_MIDR,
+                                &error_fatal);
+        object_property_set_int(cpuobj, "reset-cbar", MPCORE_PERIPHBASE,
+                                &error_fatal);
+
+        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
+
+        cx7200_machine->cpu[n] = ARM_CPU(cpuobj);
+    }
+
+    /* DDR remapped to address zero.  */
+    memory_region_add_subregion(address_space_mem, 0, machine->ram);
+
+    /* 256K of on-chip memory */
+    memory_region_init_ram(ocm_ram, NULL, "zynq.ocm_ram", 256 * KiB,
+                           &error_fatal);
+    memory_region_add_subregion(address_space_mem, 0xFFFC0000, ocm_ram);
+
+    /* Create the main clock source, and feed slcr with it */
+    cx7200_machine->ps_clk = CLOCK(object_new(TYPE_CLOCK));
+    object_property_add_child(OBJECT(cx7200_machine), "ps_clk",
+                              OBJECT(cx7200_machine->ps_clk));
+    object_unref(OBJECT(cx7200_machine->ps_clk));
+    clock_set_hz(cx7200_machine->ps_clk, PS_CLK_FREQUENCY);
+
+    /* Create slcr, keep a pointer to connect clocks */
+    slcr = qdev_new("xilinx-zynq_slcr");
+    qdev_connect_clock_in(slcr, "ps_clk", cx7200_machine->ps_clk);
+    qdev_prop_set_uint8(slcr, "boot-mode", cx7200_machine->boot_mode);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(slcr), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(slcr), 0, 0xF8000000);
+
+    dev = qdev_new(TYPE_A9MPCORE_PRIV);
+    qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
+    A9MPPrivState *a9mp_priv_state = A9MPCORE_PRIV(dev);
+    a9mp_priv_state->gtimer.freq_hz = PS7_CPU_CLK_FREQUENCY;
+    a9mp_priv_state->gtimer.periphclk_divider = PERIPHCLK_DIVIDER;
+    a9mp_priv_state->mptimer.freq_hz = PS7_CPU_CLK_FREQUENCY;
+    a9mp_priv_state->mptimer.periphclk_divider = PERIPHCLK_DIVIDER;
+    a9mp_priv_state->wdt.freq_hz = PS7_CPU_CLK_FREQUENCY;
+    a9mp_priv_state->wdt.periphclk_divider = PERIPHCLK_DIVIDER;
+    busdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_mmio_map(busdev, 0, MPCORE_PERIPHBASE);
+    beckhoff_cx7200_binfo.gic_cpu_if_addr = MPCORE_PERIPHBASE + 0x100;
+    sysbus_create_varargs("l2x0", MPCORE_PERIPHBASE + 0x2000, NULL);
+    for (n = 0; n < smp_cpus; n++) {
+        /* See "hw/intc/arm_gic.h" for the IRQ line association */
+        DeviceState *cpudev = DEVICE(cx7200_machine->cpu[n]);
+        sysbus_connect_irq(busdev, n,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
+        sysbus_connect_irq(busdev, smp_cpus + n,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
+    }
+
+    for (n = 0; n < 64; n++) {
+        pic[n] = qdev_get_gpio_in(dev, n);
+    }
+
+    n = beckhoff_cx7200_init_spi_flashes(0xE0006000, pic[58 - IRQ_OFFSET],
+                                         false, 0);
+    n = beckhoff_cx7200_init_spi_flashes(0xE0007000, pic[81 - IRQ_OFFSET],
+                                         false, n);
+    n = beckhoff_cx7200_init_spi_flashes(0xE000D000, pic[51 - IRQ_OFFSET],
+                                         true, n);
+
+    dev = qdev_new(TYPE_CADENCE_UART);
+    busdev = SYS_BUS_DEVICE(dev);
+    qdev_prop_set_chr(dev, "chardev", serial_hd(0));
+    qdev_connect_clock_in(dev, "refclk",
+                          qdev_get_clock_out(slcr, "uart0_ref_clk"));
+    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_mmio_map(busdev, 0, 0xE0000000);
+    sysbus_connect_irq(busdev, 0, pic[59 - IRQ_OFFSET]);
+    dev = qdev_new(TYPE_CADENCE_UART);
+    busdev = SYS_BUS_DEVICE(dev);
+    qdev_prop_set_chr(dev, "chardev", serial_hd(1));
+    qdev_connect_clock_in(dev, "refclk",
+                          qdev_get_clock_out(slcr, "uart1_ref_clk"));
+    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_mmio_map(busdev, 0, 0xE0001000);
+    sysbus_connect_irq(busdev, 0, pic[82 - IRQ_OFFSET]);
+
+    sysbus_create_varargs("cadence_ttc", 0xF8001000, pic[42 - IRQ_OFFSET],
+                          pic[43 - IRQ_OFFSET], pic[44 - IRQ_OFFSET], NULL);
+    sysbus_create_varargs("cadence_ttc", 0xF8002000, pic[69 - IRQ_OFFSET],
+                          pic[70 - IRQ_OFFSET], pic[71 - IRQ_OFFSET], NULL);
+
+    gem_init(0xE000C000, pic[77 - IRQ_OFFSET]);
+
+    di = drive_get(IF_NONE, 0, 0);
+    blk = di ? blk_by_legacy_dinfo(di) : NULL;
+    ccat_init(0x40000000, blk);
+
+    ddr_ctrl_init(0xF8006000);
+
+    /*
+     * Compatible with:
+     * - SD Host Controller Specification Version 2.0 Part A2
+     * - SDIO Specification Version 2.0
+     * - MMC Specification Version 3.31
+     */
+    dev = qdev_new(TYPE_SYSBUS_SDHCI);
+    qdev_prop_set_uint8(dev, "sd-spec-version", 2);
+    qdev_prop_set_uint64(dev, "capareg", ZYNQ_SDHCI_CAPABILITIES);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xE0101000);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[79 - IRQ_OFFSET]);
+
+    di = drive_get(IF_SD, 0, 0);
+    blk = di ? blk_by_legacy_dinfo(di) : NULL;
+    carddev = qdev_new(TYPE_SD_CARD);
+    qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
+    qdev_realize_and_unref(carddev, qdev_get_child_bus(dev, "sd-bus"),
+                       &error_fatal);
+
+    dev = qdev_new(TYPE_ZYNQ_XADC);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xF8007100);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[39 - IRQ_OFFSET]);
+
+    dev = qdev_new("pl330");
+    object_property_set_link(OBJECT(dev), "memory",
+                             OBJECT(address_space_mem),
+                             &error_fatal);
+    qdev_prop_set_uint8(dev, "num_chnls",  8);
+    qdev_prop_set_uint8(dev, "num_periph_req",  4);
+    qdev_prop_set_uint8(dev, "num_events",  16);
+
+    qdev_prop_set_uint8(dev, "data_width",  64);
+    qdev_prop_set_uint8(dev, "wr_cap",  8);
+    qdev_prop_set_uint8(dev, "wr_q_dep",  16);
+    qdev_prop_set_uint8(dev, "rd_cap",  8);
+    qdev_prop_set_uint8(dev, "rd_q_dep",  16);
+    qdev_prop_set_uint16(dev, "data_buffer_dep",  256);
+
+    busdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_mmio_map(busdev, 0, 0xF8003000);
+    sysbus_connect_irq(busdev, 0, pic[45 - IRQ_OFFSET]); /* abort irq line */
+    for (n = 0; n < ARRAY_SIZE(dma_irqs); ++n) { /* event irqs */
+        sysbus_connect_irq(busdev, n + 1, pic[dma_irqs[n] - IRQ_OFFSET]);
+    }
+
+    dev = qdev_new("xlnx.ps7-dev-cfg");
+    busdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_connect_irq(busdev, 0, pic[40 - IRQ_OFFSET]);
+    sysbus_mmio_map(busdev, 0, 0xF8007000);
+
+    beckhoff_cx7200_binfo.ram_size = machine->ram_size;
+    beckhoff_cx7200_binfo.board_id = 0xd32;
+    beckhoff_cx7200_binfo.loader_start = 0;
+    beckhoff_cx7200_binfo.board_setup_addr = BOARD_SETUP_ADDR;
+    beckhoff_cx7200_binfo.write_board_setup = beckhoff_cx7200_write_board_setup;
+
+    arm_load_kernel(cx7200_machine->cpu[0], machine, &beckhoff_cx7200_binfo);
+}
+
+static void beckhoff_cx7200_machine_class_init(ObjectClass *oc, void *data)
+{
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-a9"),
+        NULL
+    };
+    MachineClass *mc = MACHINE_CLASS(oc);
+    ObjectProperty *prop;
+    mc->desc = "Beckhoff IPC based on the Xilinx Zynq Platform Baseboard";
+    mc->init = beckhoff_cx7200_init;
+    mc->max_cpus = ZYNQ_MAX_CPUS;
+    mc->no_sdcard = 1;
+    mc->ignore_memory_transaction_failures = true;
+    mc->valid_cpu_types = valid_cpu_types;
+    mc->default_ram_id = "zynq.ext_ram";
+    prop = object_class_property_add_str(oc, "boot-mode", NULL,
+                                         beckhoff_cx7200_set_boot_mode);
+    object_class_property_set_description(oc, "boot-mode",
+                                          "Supported boot modes:"
+                                          " jtag qspi sd nor");
+    object_property_set_default_str(prop, "qspi");
+}
+
+static const TypeInfo beckhoff_cx7200_machine_type = {
+    .name = TYPE_CX7200_MACHINE,
+    .parent = TYPE_MACHINE,
+    .class_init = beckhoff_cx7200_machine_class_init,
+    .instance_size = sizeof(CX7200MachineState),
+};
+
+static void beckhoff_cx7200_machine_register_types(void)
+{
+    type_register_static(&beckhoff_cx7200_machine_type);
+}
+
+type_init(beckhoff_cx7200_machine_register_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index b88b5b06d7..3d87ded71f 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -2,6 +2,7 @@ arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
 arm_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
+arm_common_ss.add(when: 'CONFIG_BECKHOFF_CX7200', if_true: files('beckhoff_CX7200.c'))
 arm_common_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic_boards.c'))
 arm_common_ss.add(when: 'CONFIG_EMCRAFT_SF2', if_true: files('msf2-som.c'))
 arm_common_ss.add(when: 'CONFIG_HIGHBANK', if_true: files('highbank.c'))
-- 
2.47.3


