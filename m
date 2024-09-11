Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86754EE499E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMGK-0008HE-2O; Wed, 11 Sep 2024 08:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMGD-00080l-8g
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:15:49 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMGA-0007R6-Hb
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:15:48 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a8d2b4a5bf1so267057366b.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726056944; x=1726661744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ld5+s4N2gFpxzgAQK+tVzuINwNRwZ7VY4lSMuZzha4o=;
 b=R5IddsTGZ5VNNPH9pgtyfJEBQLIfnALmdX+5ch1lvT/6s1lMiHZvO9Jc9nUGv5HL7b
 UEQCS5/o66YKqcpB6w4nkKYfA0Jp86i+Y2SDzdKxMMvOVPvtVE58rwmqIjAj1i+b8KgF
 MC8Fy5JdTxlOeTCxNagNoxlpQbKFrOSL4Pd+Dnr3ZAWwOcGMcMSVxwYP743RobQMLMN/
 aSdB+WIP+dsQiQTqj/gtuCiA/PFeH+8FZIetd3rZjztTygwnsoY5ZjhMtu1kgqOlymgI
 sUx6mexsSpZDyjoQdHAg7x36Msc295iX/H0SngAututMsWQHxE4+z5SY5Ebznf0JWsbH
 kkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726056944; x=1726661744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ld5+s4N2gFpxzgAQK+tVzuINwNRwZ7VY4lSMuZzha4o=;
 b=ATdF9HiOf4zqUVFrG46clqOeynodxnisbof47HD3iZwjzlaXKLkqWvqDD1R4PeLWto
 uNjrXGQnmSb0AqsF/SJmiXJ2/psl3syEMjIuX7MhSGfm+QLlPnxnSGSNruDckl6smGNR
 RWojoomaJpJJDxHfw+4x4uDc90R7XRuMhzUH5El6aioKf/w3aQ6TAwWNlVHLZBhHmkF+
 9JxhFtvASXlDJ/N7AjQsQpc5Df0Tsf4iCptsgz9UXa+dd6Zi+P1Xmc2c7X/dq0vIpmJq
 45O+X8zEVoJmCrjKO07aRqRWP1s8V7IfLtyBlk0+x4tm/SsXX2eQsWa0tDygueo9TxC0
 z81g==
X-Gm-Message-State: AOJu0YwB2TIsB3Nz5XCnStWgGNCUD00cUK7adjm/xPZP2+b2ryTcXLMC
 Poksd8S3aWm+AHnWGawj2wLPMDHcKrJmsMmdrIEqYw2M+W9ibeKU1/xLUv7ubq+oS9aoa0NkC3B
 O
X-Google-Smtp-Source: AGHT+IGhrXoPRJz0FZc2HPQWqqpl7M9KAtBnSpqOhDq81g9FgXG5IQ4dckaH0mCipmCYEHTOh2pPeg==
X-Received: by 2002:a17:907:7e97:b0:a8d:592d:f76 with SMTP id
 a640c23a62f3a-a9004a66234mr335281766b.48.1726056944299; 
 Wed, 11 Sep 2024 05:15:44 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c72757sm606208466b.103.2024.09.11.05.15.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:15:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 11/56] hw/cris: Remove the axis-dev88 machine
Date: Wed, 11 Sep 2024 14:13:36 +0200
Message-ID: <20240911121422.52585-12-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This machine was deprecated for the v9.0 release in commit
c7bbef4023 ("docs: mark CRIS support as deprecated").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-ID: <20240904143603.52934-6-philmd@linaro.org>
---
 MAINTAINERS                              |   3 +-
 configs/devices/cris-softmmu/default.mak |   3 -
 hw/cris/axis_dev88.c                     | 351 -----------------------
 hw/cris/Kconfig                          |   8 -
 hw/cris/meson.build                      |   1 -
 5 files changed, 1 insertion(+), 365 deletions(-)
 delete mode 100644 hw/cris/axis_dev88.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d0ddbb6bfb..e64a3206d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1213,10 +1213,9 @@ F: hw/avr/arduino.c
 
 CRIS Machines
 -------------
-Axis Dev88
+Etrax hardware
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
-F: hw/cris/axis_dev88.c
 F: hw/*/etraxfs_*.c
 
 HP-PARISC Machines
diff --git a/configs/devices/cris-softmmu/default.mak b/configs/devices/cris-softmmu/default.mak
index ff73cd4084..3726699370 100644
--- a/configs/devices/cris-softmmu/default.mak
+++ b/configs/devices/cris-softmmu/default.mak
@@ -1,4 +1 @@
 # Default configuration for cris-softmmu
-
-# Boards are selected by default, uncomment to keep out of the build.
-# CONFIG_AXIS=n
diff --git a/hw/cris/axis_dev88.c b/hw/cris/axis_dev88.c
deleted file mode 100644
index 5556634921..0000000000
--- a/hw/cris/axis_dev88.c
+++ /dev/null
@@ -1,351 +0,0 @@
-/*
- * QEMU model for the AXIS devboard 88.
- *
- * Copyright (c) 2009 Edgar E. Iglesias, Axis Communications AB.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#include "qemu/osdep.h"
-#include "qemu/units.h"
-#include "qapi/error.h"
-#include "cpu.h"
-#include "hw/sysbus.h"
-#include "net/net.h"
-#include "hw/block/flash.h"
-#include "hw/boards.h"
-#include "hw/cris/etraxfs.h"
-#include "hw/loader.h"
-#include "elf.h"
-#include "boot.h"
-#include "sysemu/qtest.h"
-#include "sysemu/sysemu.h"
-
-#define D(x)
-#define DNAND(x)
-
-struct nand_state_t
-{
-    DeviceState *nand;
-    MemoryRegion iomem;
-    unsigned int rdy:1;
-    unsigned int ale:1;
-    unsigned int cle:1;
-    unsigned int ce:1;
-};
-
-static struct nand_state_t nand_state;
-static uint64_t nand_read(void *opaque, hwaddr addr, unsigned size)
-{
-    struct nand_state_t *s = opaque;
-    uint32_t r;
-    int rdy;
-
-    r = nand_getio(s->nand);
-    nand_getpins(s->nand, &rdy);
-    s->rdy = rdy;
-
-    DNAND(printf("%s addr=%x r=%x\n", __func__, addr, r));
-    return r;
-}
-
-static void
-nand_write(void *opaque, hwaddr addr, uint64_t value,
-           unsigned size)
-{
-    struct nand_state_t *s = opaque;
-    int rdy;
-
-    DNAND(printf("%s addr=%x v=%x\n", __func__, addr, (unsigned)value));
-    nand_setpins(s->nand, s->cle, s->ale, s->ce, 1, 0);
-    nand_setio(s->nand, value);
-    nand_getpins(s->nand, &rdy);
-    s->rdy = rdy;
-}
-
-static const MemoryRegionOps nand_ops = {
-    .read = nand_read,
-    .write = nand_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
-struct tempsensor_t
-{
-    unsigned int shiftreg;
-    unsigned int count;
-    enum {
-        ST_OUT, ST_IN, ST_Z
-    } state;
-
-    uint16_t regs[3];
-};
-
-static void tempsensor_clkedge(struct tempsensor_t *s,
-                               unsigned int clk, unsigned int data_in)
-{
-    D(printf("%s clk=%d state=%d sr=%x\n", __func__,
-             clk, s->state, s->shiftreg));
-    if (s->count == 0) {
-        s->count = 16;
-        s->state = ST_OUT;
-    }
-    switch (s->state) {
-        case ST_OUT:
-            /* Output reg is clocked at negedge.  */
-            if (!clk) {
-                s->count--;
-                s->shiftreg <<= 1;
-                if (s->count == 0) {
-                    s->shiftreg = 0;
-                    s->state = ST_IN;
-                    s->count = 16;
-                }
-            }
-            break;
-        case ST_Z:
-            if (clk) {
-                s->count--;
-                if (s->count == 0) {
-                    s->shiftreg = 0;
-                    s->state = ST_OUT;
-                    s->count = 16;
-                }
-            }
-            break;
-        case ST_IN:
-            /* Indata is sampled at posedge.  */
-            if (clk) {
-                s->count--;
-                s->shiftreg <<= 1;
-                s->shiftreg |= data_in & 1;
-                if (s->count == 0) {
-                    D(printf("%s cfgreg=%x\n", __func__, s->shiftreg));
-                    s->regs[0] = s->shiftreg;
-                    s->state = ST_OUT;
-                    s->count = 16;
-
-                    if ((s->regs[0] & 0xff) == 0) {
-                        /* 25 degrees celsius.  */
-                        s->shiftreg = 0x0b9f;
-                    } else if ((s->regs[0] & 0xff) == 0xff) {
-                        /* Sensor ID, 0x8100 LM70.  */
-                        s->shiftreg = 0x8100;
-                    } else
-                        printf("Invalid tempsens state %x\n", s->regs[0]);
-                }
-            }
-            break;
-    }
-}
-
-
-#define RW_PA_DOUT    0x00
-#define R_PA_DIN      0x01
-#define RW_PA_OE      0x02
-#define RW_PD_DOUT    0x10
-#define R_PD_DIN      0x11
-#define RW_PD_OE      0x12
-
-static struct gpio_state_t
-{
-    MemoryRegion iomem;
-    struct nand_state_t *nand;
-    struct tempsensor_t tempsensor;
-    uint32_t regs[0x5c / 4];
-} gpio_state;
-
-static uint64_t gpio_read(void *opaque, hwaddr addr, unsigned size)
-{
-    struct gpio_state_t *s = opaque;
-    uint32_t r = 0;
-
-    addr >>= 2;
-    switch (addr)
-    {
-        case R_PA_DIN:
-            r = s->regs[RW_PA_DOUT] & s->regs[RW_PA_OE];
-
-            /* Encode pins from the nand.  */
-            r |= s->nand->rdy << 7;
-            break;
-        case R_PD_DIN:
-            r = s->regs[RW_PD_DOUT] & s->regs[RW_PD_OE];
-
-            /* Encode temp sensor pins.  */
-            r |= (!!(s->tempsensor.shiftreg & 0x10000)) << 4;
-            break;
-
-        default:
-            r = s->regs[addr];
-            break;
-    }
-    return r;
-    D(printf("%s %x=%x\n", __func__, addr, r));
-}
-
-static void gpio_write(void *opaque, hwaddr addr, uint64_t value,
-                       unsigned size)
-{
-    struct gpio_state_t *s = opaque;
-    D(printf("%s %x=%x\n", __func__, addr, (unsigned)value));
-
-    addr >>= 2;
-    switch (addr)
-    {
-        case RW_PA_DOUT:
-            /* Decode nand pins.  */
-            s->nand->ale = !!(value & (1 << 6));
-            s->nand->cle = !!(value & (1 << 5));
-            s->nand->ce  = !!(value & (1 << 4));
-
-            s->regs[addr] = value;
-            break;
-
-        case RW_PD_DOUT:
-            /* Temp sensor clk.  */
-            if ((s->regs[addr] ^ value) & 2)
-                tempsensor_clkedge(&s->tempsensor, !!(value & 2),
-                                   !!(value & 16));
-            s->regs[addr] = value;
-            break;
-
-        default:
-            s->regs[addr] = value;
-            break;
-    }
-}
-
-static const MemoryRegionOps gpio_ops = {
-    .read = gpio_read,
-    .write = gpio_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-    .valid = {
-        .min_access_size = 4,
-        .max_access_size = 4,
-    },
-};
-
-#define INTMEM_SIZE (128 * KiB)
-
-static struct cris_load_info li;
-
-static
-void axisdev88_init(MachineState *machine)
-{
-    const char *kernel_filename = machine->kernel_filename;
-    const char *kernel_cmdline = machine->kernel_cmdline;
-    CRISCPU *cpu;
-    DeviceState *dev;
-    SysBusDevice *s;
-    DriveInfo *nand;
-    qemu_irq irq[30], nmi[2];
-    void *etraxfs_dmac;
-    struct etraxfs_dma_client *dma_eth;
-    int i;
-    MemoryRegion *address_space_mem = get_system_memory();
-    MemoryRegion *phys_intmem = g_new(MemoryRegion, 1);
-
-    /* init CPUs */
-    cpu = CRIS_CPU(cpu_create(machine->cpu_type));
-
-    memory_region_add_subregion(address_space_mem, 0x40000000, machine->ram);
-
-    /* The ETRAX-FS has 128Kb on chip ram, the docs refer to it as the 
-       internal memory.  */
-    memory_region_init_ram(phys_intmem, NULL, "axisdev88.chipram",
-                           INTMEM_SIZE, &error_fatal);
-    memory_region_add_subregion(address_space_mem, 0x38000000, phys_intmem);
-
-      /* Attach a NAND flash to CS1.  */
-    nand = drive_get(IF_MTD, 0, 0);
-    nand_state.nand = nand_init(nand ? blk_by_legacy_dinfo(nand) : NULL,
-                                NAND_MFR_STMICRO, 0x39);
-    memory_region_init_io(&nand_state.iomem, NULL, &nand_ops, &nand_state,
-                          "nand", 0x05000000);
-    memory_region_add_subregion(address_space_mem, 0x10000000,
-                                &nand_state.iomem);
-
-    gpio_state.nand = &nand_state;
-    memory_region_init_io(&gpio_state.iomem, NULL, &gpio_ops, &gpio_state,
-                          "gpio", 0x5c);
-    memory_region_add_subregion(address_space_mem, 0x3001a000,
-                                &gpio_state.iomem);
-
-
-    dev = qdev_new("etraxfs-pic");
-    s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
-    sysbus_mmio_map(s, 0, 0x3001c000);
-    sysbus_connect_irq(s, 0, qdev_get_gpio_in(DEVICE(cpu), CRIS_CPU_IRQ));
-    sysbus_connect_irq(s, 1, qdev_get_gpio_in(DEVICE(cpu), CRIS_CPU_NMI));
-    for (i = 0; i < 30; i++) {
-        irq[i] = qdev_get_gpio_in(dev, i);
-    }
-    nmi[0] = qdev_get_gpio_in(dev, 30);
-    nmi[1] = qdev_get_gpio_in(dev, 31);
-
-    etraxfs_dmac = etraxfs_dmac_init(0x30000000, 10);
-    for (i = 0; i < 10; i++) {
-        /* On ETRAX, odd numbered channels are inputs.  */
-        etraxfs_dmac_connect(etraxfs_dmac, i, irq + 7 + i, i & 1);
-    }
-
-    /* Add the two ethernet blocks.  */
-    dma_eth = g_malloc0(sizeof dma_eth[0] * 4); /* Allocate 4 channels.  */
-
-    etraxfs_eth_init(0x30034000, 1, &dma_eth[0], &dma_eth[1]);
-    /* The DMA Connector block is missing, hardwire things for now.  */
-    etraxfs_dmac_connect_client(etraxfs_dmac, 0, &dma_eth[0]);
-    etraxfs_dmac_connect_client(etraxfs_dmac, 1, &dma_eth[1]);
-
-    if (qemu_find_nic_info("etraxfs-eth", true, "fseth")) {
-        etraxfs_eth_init(0x30036000, 2, &dma_eth[2], &dma_eth[3]);
-        etraxfs_dmac_connect_client(etraxfs_dmac, 6, &dma_eth[2]);
-        etraxfs_dmac_connect_client(etraxfs_dmac, 7, &dma_eth[3]);
-    }
-
-    /* 2 timers.  */
-    sysbus_create_varargs("etraxfs-timer", 0x3001e000, irq[0x1b], nmi[1], NULL);
-    sysbus_create_varargs("etraxfs-timer", 0x3005e000, irq[0x1b], nmi[1], NULL);
-
-    for (i = 0; i < 4; i++) {
-        etraxfs_ser_create(0x30026000 + i * 0x2000, irq[0x14 + i], serial_hd(i));
-    }
-
-    if (kernel_filename) {
-        li.image_filename = kernel_filename;
-        li.cmdline = kernel_cmdline;
-        li.ram_size = machine->ram_size;
-        cris_load_image(cpu, &li);
-    } else if (!qtest_enabled()) {
-        fprintf(stderr, "Kernel image must be specified\n");
-        exit(1);
-    }
-}
-
-static void axisdev88_machine_init(MachineClass *mc)
-{
-    mc->desc = "AXIS devboard 88";
-    mc->init = axisdev88_init;
-    mc->is_default = true;
-    mc->default_cpu_type = CRIS_CPU_TYPE_NAME("crisv32");
-    mc->default_ram_id = "axisdev88.ram";
-}
-
-DEFINE_MACHINE("axis-dev88", axisdev88_machine_init)
diff --git a/hw/cris/Kconfig b/hw/cris/Kconfig
index 26c7eef743..3f0680cf09 100644
--- a/hw/cris/Kconfig
+++ b/hw/cris/Kconfig
@@ -1,11 +1,3 @@
-config AXIS
-    bool
-    default y
-    depends on CRIS
-    select ETRAXFS
-    select PFLASH_CFI02
-    select NAND
-
 config ETRAXFS
    bool
    select PTIMER
diff --git a/hw/cris/meson.build b/hw/cris/meson.build
index dc808a4e0f..dc43251667 100644
--- a/hw/cris/meson.build
+++ b/hw/cris/meson.build
@@ -1,5 +1,4 @@
 cris_ss = ss.source_set()
 cris_ss.add(files('boot.c'))
-cris_ss.add(when: 'CONFIG_AXIS', if_true: files('axis_dev88.c'))
 
 hw_arch += {'cris': cris_ss}
-- 
2.45.2


