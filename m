Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4EDD1D878
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 07:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR3Iv-0002h2-Rd; Thu, 04 Dec 2025 01:59:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1vR3If-0002cF-RT; Thu, 04 Dec 2025 01:58:51 -0500
Received: from out28-54.mail.aliyun.com ([115.124.28.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1vR3IZ-0005dL-Qz; Thu, 04 Dec 2025 01:58:49 -0500
Received: from ZEVORN-PC(mailfrom:chao.liu@zevorn.cn
 fp:SMTPD_---.fcgSBEN_1764831510 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 04 Dec 2025 14:58:31 +0800
From: Chao Liu <chao.liu@zevorn.cn>
To: pbonzini@redhat.com, dbarboza@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 hust-os-kernel-patches@googlegroups.com, Chao Liu <chao.liu@zevorn.cn>
Subject: [PATCH v2 2/5] hw/riscv: add k230 board initial support
Date: Thu,  4 Dec 2025 14:58:23 +0800
Message-ID: <536ecfcc74efce999e183425035c1580278383f8.1764830405.git.chao.liu@zevorn.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1764830405.git.chao.liu@zevorn.cn>
References: <cover.1764830405.git.chao.liu@zevorn.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.54; envelope-from=chao.liu@zevorn.cn;
 helo=out28-54.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

K230 Board Compatible with kendryte K230 SDK.

Preliminarily supports the C908 small core, which can
run the U-Boot and Linux kernel compiled by the K230 SDK.

Signed-off-by: Chao Liu <chao.liu@zevorn.cn>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 MAINTAINERS             |   6 +
 hw/riscv/Kconfig        |  10 +
 hw/riscv/k230.c         | 483 ++++++++++++++++++++++++++++++++++++++++
 hw/riscv/meson.build    |   2 +-
 include/hw/riscv/k230.h | 149 +++++++++++++
 5 files changed, 649 insertions(+), 1 deletion(-)
 create mode 100644 hw/riscv/k230.c
 create mode 100644 include/hw/riscv/k230.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a07086ed76..bc802caad0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1710,6 +1710,12 @@ F: docs/system/riscv/xiangshan-kunminghu.rst
 F: hw/riscv/xiangshan_kmh.c
 F: include/hw/riscv/xiangshan_kmh.h
 
+K230 Machines
+M: Chao Liu <chao.liu@zevorn.cn>
+S: Maintained
+F: hw/riscv/k230.c
+F: include/hw/riscv/k230.h
+
 RX Machines
 -----------
 rx-gdbsim
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index fc9c35bd98..624f166244 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -128,3 +128,13 @@ config XIANGSHAN_KUNMINGHU
     select RISCV_APLIC
     select RISCV_IMSIC
     select SERIAL_MM
+
+config K230
+    bool
+    default y
+    depends on RISCV64
+    select RISCV_ACLINT
+    select RISCV_APLIC
+    select RISCV_IMSIC
+    select SERIAL_MM
+    select UNIMP
\ No newline at end of file
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
new file mode 100644
index 0000000000..f41e9b7002
--- /dev/null
+++ b/hw/riscv/k230.c
@@ -0,0 +1,483 @@
+/*
+ * QEMU RISC-V Virt Board Compatible with Kendryte K230 SDK
+ *
+ * Copyright (c) 2025 Chao Liu <chao.liu@zevorn.cn>
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Provides a board compatible with the Kendryte K230 SDK
+ *
+ * Documentation: K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ *
+ * For more information, see <https://www.kendryte.com/en/proDetail/230>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu-qom.h"
+#include "qemu/cutils.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "system/system.h"
+#include "system/memory.h"
+#include "target/riscv/cpu.h"
+#include "chardev/char.h"
+#include "hw/loader.h"
+#include "hw/sysbus.h"
+#include "hw/riscv/k230.h"
+#include "hw/riscv/boot.h"
+#include "hw/intc/riscv_aclint.h"
+#include "hw/intc/sifive_plic.h"
+#include "hw/char/serial-mm.h"
+#include "hw/misc/unimp.h"
+
+static const MemMapEntry memmap[] = {
+    [K230_DEV_DDRC] =         { 0x00000000, 0x80000000 },
+    [K230_DEV_KPU_L2_CACHE] = { 0x80000000, 0x00200000 },
+    [K230_DEV_SRAM] =         { 0x80200000, 0x00200000 },
+    [K230_DEV_KPU_CFG] =      { 0x80400000, 0x00000800 },
+    [K230_DEV_FFT] =          { 0x80400800, 0x00000400 },
+    [K230_DEV_AI_2D_ENGINE] = { 0x80400C00, 0x00000800 },
+    [K230_DEV_GSDMA] =        { 0x80800000, 0x00004000 },
+    [K230_DEV_DMA] =          { 0x80804000, 0x00004000 },
+    [K230_DEV_DECOMP_GZIP] =  { 0x80808000, 0x00004000 },
+    [K230_DEV_NON_AI_2D] =    { 0x8080C000, 0x00004000 },
+    [K230_DEV_ISP] =          { 0x90000000, 0x00008000 },
+    [K230_DEV_DEWARP] =       { 0x90008000, 0x00001000 },
+    [K230_DEV_RX_CSI] =       { 0x90009000, 0x00002000 },
+    [K230_DEV_H264] =         { 0x90400000, 0x00010000 },
+    [K230_DEV_2P5D] =         { 0x90800000, 0x00040000 },
+    [K230_DEV_VO] =           { 0x90840000, 0x00010000 },
+    [K230_DEV_VO_CFG] =       { 0x90850000, 0x00001000 },
+    [K230_DEV_3D_ENGINE] =    { 0x90A00000, 0x00000800 },
+    [K230_DEV_PMU] =          { 0x91000000, 0x00000C00 },
+    [K230_DEV_RTC] =          { 0x91000C00, 0x00000400 },
+    [K230_DEV_CMU] =          { 0x91100000, 0x00001000 },
+    [K230_DEV_RMU] =          { 0x91101000, 0x00001000 },
+    [K230_DEV_BOOT] =         { 0x91102000, 0x00001000 },
+    [K230_DEV_PWR] =          { 0x91103000, 0x00001000 },
+    [K230_DEV_MAILBOX] =      { 0x91104000, 0x00001000 },
+    [K230_DEV_IOMUX] =        { 0x91105000, 0x00000800 },
+    [K230_DEV_TIMER] =        { 0x91105800, 0x00000800 },
+    [K230_DEV_WDT0] =         { 0x91106000, 0x00000800 },
+    [K230_DEV_WDT1] =         { 0x91106800, 0x00000800 },
+    [K230_DEV_TS] =           { 0x91107000, 0x00000800 },
+    [K230_DEV_HDI] =          { 0x91107800, 0x00000800 },
+    [K230_DEV_STC] =          { 0x91108000, 0x00000800 },
+    [K230_DEV_BOOTROM] =      { 0x91200000, 0x00010000 },
+    [K230_DEV_SECURITY] =     { 0x91210000, 0x00008000 },
+    [K230_DEV_UART0] =        { 0x91400000, 0x00001000 },
+    [K230_DEV_UART1] =        { 0x91401000, 0x00001000 },
+    [K230_DEV_UART2] =        { 0x91402000, 0x00001000 },
+    [K230_DEV_UART3] =        { 0x91403000, 0x00001000 },
+    [K230_DEV_UART4] =        { 0x91404000, 0x00001000 },
+    [K230_DEV_I2C0] =         { 0x91405000, 0x00001000 },
+    [K230_DEV_I2C1] =         { 0x91406000, 0x00001000 },
+    [K230_DEV_I2C2] =         { 0x91407000, 0x00001000 },
+    [K230_DEV_I2C3] =         { 0x91408000, 0x00001000 },
+    [K230_DEV_I2C4] =         { 0x91409000, 0x00001000 },
+    [K230_DEV_PWM] =          { 0x9140A000, 0x00001000 },
+    [K230_DEV_GPIO0] =        { 0x9140B000, 0x00001000 },
+    [K230_DEV_GPIO1] =        { 0x9140C000, 0x00001000 },
+    [K230_DEV_ADC] =          { 0x9140D000, 0x00001000 },
+    [K230_DEV_CODEC] =        { 0x9140E000, 0x00001000 },
+    [K230_DEV_I2S] =          { 0x9140F000, 0x00001000 },
+    [K230_DEV_USB0] =         { 0x91500000, 0x00010000 },
+    [K230_DEV_USB1] =         { 0x91540000, 0x00010000 },
+    [K230_DEV_SD0] =          { 0x91580000, 0x00001000 },
+    [K230_DEV_SD1] =          { 0x91581000, 0x00001000 },
+    [K230_DEV_QSPI0] =        { 0x91582000, 0x00001000 },
+    [K230_DEV_QSPI1] =        { 0x91583000, 0x00001000 },
+    [K230_DEV_SPI] =          { 0x91584000, 0x00001000 },
+    [K230_DEV_HI_SYS_CFG] =   { 0x91585000, 0x00000400 },
+    [K230_DEV_DDRC_CFG] =     { 0x98000000, 0x02000000 },
+    [K230_DEV_FLASH] =        { 0xC0000000, 0x08000000 },
+    [K230_DEV_PLIC] =         { 0xF0000000, 0x00400000 },
+    [K230_DEV_CLINT] =        { 0xF0400000, 0x00400000 },
+};
+
+static void k230_soc_init(Object *obj)
+{
+    K230SoCState *s = RISCV_K230_SOC(obj);
+    RISCVHartArrayState *cpu0 = &s->c908_cpu;
+
+    object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
+    qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
+    qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
+    qdev_prop_set_uint64(DEVICE(cpu0), "resetvec",
+                         memmap[K230_DEV_BOOTROM].base);
+}
+
+static DeviceState *k230_create_plic(int base_hartid, int hartid_count)
+{
+    g_autofree char *plic_hart_config = NULL;
+
+    /* Per-socket PLIC hart topology configuration string */
+    plic_hart_config = riscv_plic_hart_config_string(hartid_count);
+
+    /* Per-socket PLIC */
+    return sifive_plic_create(memmap[K230_DEV_PLIC].base,
+                              plic_hart_config, hartid_count, base_hartid,
+                              K230_PLIC_NUM_SOURCES,
+                              K230_PLIC_NUM_PRIORITIES,
+                              K230_PLIC_PRIORITY_BASE, K230_PLIC_PENDING_BASE,
+                              K230_PLIC_ENABLE_BASE, K230_PLIC_ENABLE_STRIDE,
+                              K230_PLIC_CONTEXT_BASE,
+                              K230_PLIC_CONTEXT_STRIDE,
+                              memmap[K230_DEV_PLIC].size);
+}
+
+static void k230_soc_realize(DeviceState *dev, Error **errp)
+{
+    K230SoCState *s = RISCV_K230_SOC(dev);
+    MemoryRegion *sys_mem = get_system_memory();
+    int c908_cpus;
+
+    sysbus_realize(SYS_BUS_DEVICE(&s->c908_cpu), &error_fatal);
+
+    c908_cpus = s->c908_cpu.num_harts;
+
+    /* SRAM */
+    memory_region_init_ram(&s->sram, OBJECT(dev), "sram",
+                           memmap[K230_DEV_SRAM].size, &error_fatal);
+    memory_region_add_subregion(sys_mem, memmap[K230_DEV_SRAM].base,
+                                &s->sram);
+
+    /* BootROM */
+    memory_region_init_rom(&s->bootrom, OBJECT(dev), "bootrom",
+                           memmap[K230_DEV_BOOTROM].size, &error_fatal);
+    memory_region_add_subregion(sys_mem, memmap[K230_DEV_BOOTROM].base,
+                                &s->bootrom);
+
+    /* PLIC */
+    s->c908_plic = k230_create_plic(C908_CPU_HARTID, c908_cpus);
+
+    /* CLINT */
+    riscv_aclint_swi_create(memmap[K230_DEV_CLINT].base,
+                            C908_CPU_HARTID, c908_cpus, false);
+    riscv_aclint_mtimer_create(memmap[K230_DEV_CLINT].base + 0x4000,
+                               RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
+                               C908_CPU_HARTID, c908_cpus,
+                               RISCV_ACLINT_DEFAULT_MTIMECMP,
+                               RISCV_ACLINT_DEFAULT_MTIME,
+                               RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
+
+    /* UART */
+    serial_mm_init(sys_mem, memmap[K230_DEV_UART0].base, 2,
+                   qdev_get_gpio_in(DEVICE(s->c908_plic), K230_UART0_IRQ),
+                   399193, serial_hd(0), DEVICE_LITTLE_ENDIAN);
+    serial_mm_init(sys_mem, memmap[K230_DEV_UART1].base, 2,
+                   qdev_get_gpio_in(DEVICE(s->c908_plic), K230_UART1_IRQ),
+                   399193, serial_hd(1), DEVICE_LITTLE_ENDIAN);
+    serial_mm_init(sys_mem, memmap[K230_DEV_UART2].base, 2,
+                   qdev_get_gpio_in(DEVICE(s->c908_plic), K230_UART2_IRQ),
+                   399193, serial_hd(2), DEVICE_LITTLE_ENDIAN);
+    serial_mm_init(sys_mem, memmap[K230_DEV_UART3].base, 2,
+                   qdev_get_gpio_in(DEVICE(s->c908_plic), K230_UART3_IRQ),
+                   399193, serial_hd(3), DEVICE_LITTLE_ENDIAN);
+    serial_mm_init(sys_mem, memmap[K230_DEV_UART4].base, 2,
+                   qdev_get_gpio_in(DEVICE(s->c908_plic), K230_UART4_IRQ),
+                   399193, serial_hd(4), DEVICE_LITTLE_ENDIAN);
+
+    /* unimplemented devices */
+    create_unimplemented_device("kpu.l2-cache",
+                                memmap[K230_DEV_KPU_L2_CACHE].base,
+                                memmap[K230_DEV_KPU_L2_CACHE].size);
+
+    create_unimplemented_device("kpu_cfg", memmap[K230_DEV_KPU_CFG].base,
+                                memmap[K230_DEV_KPU_CFG].size);
+
+    create_unimplemented_device("fft", memmap[K230_DEV_FFT].base,
+                                memmap[K230_DEV_FFT].size);
+
+    create_unimplemented_device("2d-engine.ai",
+                                memmap[K230_DEV_AI_2D_ENGINE].base,
+                                memmap[K230_DEV_AI_2D_ENGINE].size);
+
+    create_unimplemented_device("gsdma", memmap[K230_DEV_GSDMA].base,
+                                memmap[K230_DEV_GSDMA].size);
+
+    create_unimplemented_device("dma", memmap[K230_DEV_DMA].base,
+                                memmap[K230_DEV_DMA].size);
+
+    create_unimplemented_device("decomp-gzip",
+                                memmap[K230_DEV_DECOMP_GZIP].base,
+                                memmap[K230_DEV_DECOMP_GZIP].size);
+
+    create_unimplemented_device("2d-engine.non-ai",
+                                memmap[K230_DEV_NON_AI_2D].base,
+                                memmap[K230_DEV_NON_AI_2D].size);
+
+    create_unimplemented_device("isp", memmap[K230_DEV_ISP].base,
+                                memmap[K230_DEV_ISP].size);
+
+    create_unimplemented_device("dewarp", memmap[K230_DEV_DEWARP].base,
+                                memmap[K230_DEV_DEWARP].size);
+
+    create_unimplemented_device("rx-csi", memmap[K230_DEV_RX_CSI].base,
+                                memmap[K230_DEV_RX_CSI].size);
+
+    create_unimplemented_device("vpu", memmap[K230_DEV_H264].base,
+                                memmap[K230_DEV_H264].size);
+
+    create_unimplemented_device("gpu", memmap[K230_DEV_2P5D].base,
+                                memmap[K230_DEV_2P5D].size);
+
+    create_unimplemented_device("vo", memmap[K230_DEV_VO].base,
+                                memmap[K230_DEV_VO].size);
+
+    create_unimplemented_device("vo_cfg", memmap[K230_DEV_VO_CFG].base,
+                                memmap[K230_DEV_VO_CFG].size);
+
+    create_unimplemented_device("3d-engine", memmap[K230_DEV_3D_ENGINE].base,
+                                memmap[K230_DEV_3D_ENGINE].size);
+
+    create_unimplemented_device("pmu", memmap[K230_DEV_PMU].base,
+                                memmap[K230_DEV_PMU].size);
+
+    create_unimplemented_device("rtc", memmap[K230_DEV_RTC].base,
+                                memmap[K230_DEV_RTC].size);
+
+    create_unimplemented_device("cmu", memmap[K230_DEV_CMU].base,
+                                memmap[K230_DEV_CMU].size);
+
+    create_unimplemented_device("rmu", memmap[K230_DEV_RMU].base,
+                                memmap[K230_DEV_RMU].size);
+
+    create_unimplemented_device("boot", memmap[K230_DEV_BOOT].base,
+                                memmap[K230_DEV_BOOT].size);
+
+    create_unimplemented_device("pwr", memmap[K230_DEV_PWR].base,
+                                memmap[K230_DEV_PWR].size);
+
+    create_unimplemented_device("ipcm", memmap[K230_DEV_MAILBOX].base,
+                                memmap[K230_DEV_MAILBOX].size);
+
+    create_unimplemented_device("iomux", memmap[K230_DEV_IOMUX].base,
+                                memmap[K230_DEV_IOMUX].size);
+
+    create_unimplemented_device("timer", memmap[K230_DEV_TIMER].base,
+                                memmap[K230_DEV_TIMER].size);
+
+    create_unimplemented_device("wdt0", memmap[K230_DEV_WDT0].base,
+                                memmap[K230_DEV_WDT0].size);
+
+    create_unimplemented_device("wdt1", memmap[K230_DEV_WDT1].base,
+                                memmap[K230_DEV_WDT1].size);
+
+    create_unimplemented_device("ts", memmap[K230_DEV_TS].base,
+                                memmap[K230_DEV_TS].size);
+
+    create_unimplemented_device("hdi", memmap[K230_DEV_HDI].base,
+                                memmap[K230_DEV_HDI].size);
+
+    create_unimplemented_device("stc", memmap[K230_DEV_STC].base,
+                                memmap[K230_DEV_STC].size);
+
+    create_unimplemented_device("security", memmap[K230_DEV_SECURITY].base,
+                                memmap[K230_DEV_SECURITY].size);
+
+    create_unimplemented_device("i2c0", memmap[K230_DEV_I2C0].base,
+                                memmap[K230_DEV_I2C0].size);
+
+    create_unimplemented_device("i2c1", memmap[K230_DEV_I2C1].base,
+                                memmap[K230_DEV_I2C1].size);
+
+    create_unimplemented_device("i2c2", memmap[K230_DEV_I2C2].base,
+                                memmap[K230_DEV_I2C2].size);
+
+    create_unimplemented_device("i2c3", memmap[K230_DEV_I2C3].base,
+                                memmap[K230_DEV_I2C3].size);
+
+    create_unimplemented_device("i2c4", memmap[K230_DEV_I2C4].base,
+                                memmap[K230_DEV_I2C4].size);
+
+    create_unimplemented_device("pwm", memmap[K230_DEV_PWM].base,
+                                memmap[K230_DEV_PWM].size);
+
+    create_unimplemented_device("gpio0", memmap[K230_DEV_GPIO0].base,
+                                memmap[K230_DEV_GPIO0].size);
+
+    create_unimplemented_device("gpio1", memmap[K230_DEV_GPIO1].base,
+                                memmap[K230_DEV_GPIO1].size);
+
+    create_unimplemented_device("adc", memmap[K230_DEV_ADC].base,
+                                memmap[K230_DEV_ADC].size);
+
+    create_unimplemented_device("codec", memmap[K230_DEV_CODEC].base,
+                                memmap[K230_DEV_CODEC].size);
+
+    create_unimplemented_device("i2s", memmap[K230_DEV_I2S].base,
+                                memmap[K230_DEV_I2S].size);
+
+    create_unimplemented_device("usb0", memmap[K230_DEV_USB0].base,
+                                memmap[K230_DEV_USB0].size);
+
+    create_unimplemented_device("usb1", memmap[K230_DEV_USB1].base,
+                                memmap[K230_DEV_USB1].size);
+
+    create_unimplemented_device("sd0", memmap[K230_DEV_SD0].base,
+                                memmap[K230_DEV_SD0].size);
+
+    create_unimplemented_device("sd1", memmap[K230_DEV_SD1].base,
+                                memmap[K230_DEV_SD1].size);
+
+    create_unimplemented_device("qspi0", memmap[K230_DEV_QSPI0].base,
+                                memmap[K230_DEV_QSPI0].size);
+
+    create_unimplemented_device("qspi1", memmap[K230_DEV_QSPI1].base,
+                                memmap[K230_DEV_QSPI1].size);
+
+    create_unimplemented_device("spi", memmap[K230_DEV_SPI].base,
+                                memmap[K230_DEV_SPI].size);
+
+    create_unimplemented_device("hi_sys_cfg", memmap[K230_DEV_HI_SYS_CFG].base,
+                                memmap[K230_DEV_HI_SYS_CFG].size);
+
+    create_unimplemented_device("ddrc_cfg", memmap[K230_DEV_DDRC_CFG].base,
+                                memmap[K230_DEV_DDRC_CFG].size);
+
+    create_unimplemented_device("flash", memmap[K230_DEV_FLASH].base,
+                                memmap[K230_DEV_FLASH].size);
+}
+
+static void k230_soc_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = k230_soc_realize;
+}
+
+static const TypeInfo k230_soc_type_info = {
+    .name = TYPE_RISCV_K230_SOC,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(K230SoCState),
+    .instance_init = k230_soc_init,
+    .class_init = k230_soc_class_init,
+};
+
+static void k230_soc_register_types(void)
+{
+    type_register_static(&k230_soc_type_info);
+}
+
+type_init(k230_soc_register_types)
+
+static void k230_machine_done(Notifier *notifier, void *data)
+{
+    K230MachineState *s = container_of(notifier, K230MachineState,
+                                     machine_done);
+    MachineState *machine = MACHINE(s);
+    hwaddr start_addr = memmap[K230_DEV_DDRC].base;
+    target_ulong firmware_end_addr, kernel_start_addr;
+    const char *firmware_name = riscv_default_firmware_name(&s->soc.c908_cpu);
+    uint64_t kernel_entry = 0;
+    RISCVBootInfo boot_info;
+
+    firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
+                                                     &start_addr, NULL);
+
+    /* Mask ROM reset vector */
+    uint32_t reset_vec[] = {
+        /* 0x91200000: auipc  t0, 0x0              */ 0x00000297,
+        /* 0x91200004: addi   t0, t0, 36 # <trap>  */ 0x02428293,
+        /* 0x91200008: csrw   mtvec, t0            */ 0x30529073,
+        /* 0x9120000C: csrr   a0, misa             */ 0x301012F3,
+        /* 0x91200010: lui    t0, 0x1              */ 0x000012B7,
+        /* 0x91200014: slli   t0, t0, 1            */ 0x00129293,
+        /* 0x91200018: and    t0, a0, t0           */ 0x005572B3,
+        /* 0x9120001C: bnez   t0, loop             */ 0x00511063,
+        /* entry:                                  */
+        /* 0x91200020: addiw  t0, zero, 1          */ 0x0010029b,
+        /* 0x91200024: slli   t0, t0, 0x1b         */ 0x01b29293,
+        /* 0x91200028: jr     t0 # uboot 0x8000000 */ 0x00028067,
+        /* loop:                                   */
+        /* 0x9120002C: j      0x9120002C # <loop>  */ 0x0000006f,
+        /* trap:                                   */
+        /* 0x91200030: j      0x91200030 # <trap>  */ 0x0000006f,
+    };
+
+    /* copy in the reset vector in little_endian byte order */
+    for (int i = 0; i < sizeof(reset_vec) >> 2; i++) {
+        reset_vec[i] = cpu_to_le32(reset_vec[i]);
+    }
+    rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
+                          memmap[K230_DEV_BOOTROM].base, &address_space_memory);
+
+    riscv_boot_info_init(&boot_info, &s->soc.c908_cpu);
+
+    if (machine->kernel_filename && !kernel_entry) {
+        kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
+                                                         firmware_end_addr);
+        riscv_load_kernel(machine, &boot_info, kernel_start_addr,
+                          true, NULL);
+        kernel_entry = boot_info.image_low_addr;
+    }
+}
+
+static void k230_machine_init(MachineState *machine)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+
+    K230MachineState *s = RISCV_K230_MACHINE(machine);
+    MemoryRegion *sys_mem = get_system_memory();
+
+    if (machine->ram_size < mc->default_ram_size) {
+        char *sz = size_to_str(mc->default_ram_size);
+        error_report("Invalid RAM size, should be %s", sz);
+        g_free(sz);
+        exit(EXIT_FAILURE);
+    }
+
+    /* Initialize SoC */
+    object_initialize_child(OBJECT(machine), "soc", &s->soc,
+                            TYPE_RISCV_K230_SOC);
+    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
+
+    /* Data Memory */
+    memory_region_add_subregion(sys_mem, memmap[K230_DEV_DDRC].base,
+                                machine->ram);
+
+    s->machine_done.notify = k230_machine_done;
+    qemu_add_machine_init_done_notifier(&s->machine_done);
+}
+
+static void k230_machine_instance_init(Object *obj)
+{
+}
+
+static void k230_machine_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "RISC-V Board compatible with Kendryte K230 SDK";
+    mc->init = k230_machine_init;
+    mc->default_cpus = 2;
+    mc->default_ram_id = "riscv.K230.ram"; /* DDR */
+    mc->default_ram_size = memmap[K230_DEV_DDRC].size;
+}
+
+static const TypeInfo k230_machine_typeinfo = {
+    .name       = TYPE_RISCV_K230_MACHINE,
+    .parent     = TYPE_MACHINE,
+    .class_init = k230_machine_class_init,
+    .instance_init = k230_machine_instance_init,
+    .instance_size = sizeof(K230MachineState),
+};
+
+static void k230_machine_init_register_types(void)
+{
+    type_register_static(&k230_machine_typeinfo);
+}
+
+type_init(k230_machine_init_register_types)
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 2a8d5b136c..1e5ce511d4 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -14,5 +14,5 @@ riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
 	'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv-iommu-hpm.c'))
 riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c'))
 riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan_kmh.c'))
-
+riscv_ss.add(when: 'CONFIG_K230', if_true: files('k230.c'))
 hw_arch += {'riscv': riscv_ss}
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
new file mode 100644
index 0000000000..3158381e8f
--- /dev/null
+++ b/include/hw/riscv/k230.h
@@ -0,0 +1,149 @@
+/*
+ * QEMU RISC-V Virt Board Compatible with kendryte K230 SDK
+ *
+ * Copyright (c) 2025 Chao Liu <chao.liu@zevorn.cn>
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Provides a board compatible with the kendryte K230 SDK
+ *
+ * Documentation: K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ *
+ * For more information, see <https://www.kendryte.com/en/proDetail/230>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef HW_K230_H
+#define HW_K230_H
+
+#include "hw/boards.h"
+#include "hw/riscv/riscv_hart.h"
+
+#define C908_CPU_HARTID   (0)
+
+#define TYPE_RISCV_K230_SOC "riscv.k230.soc"
+#define RISCV_K230_SOC(obj) \
+    OBJECT_CHECK(K230SoCState, (obj), TYPE_RISCV_K230_SOC)
+
+typedef struct K230SoCState {
+    /*< private >*/
+    DeviceState parent_obj;
+
+    /*< public >*/
+    RISCVHartArrayState c908_cpu; /* Small core */
+
+    MemoryRegion sram;
+    MemoryRegion bootrom;
+
+    DeviceState *c908_plic;
+} K230SoCState;
+
+#define TYPE_RISCV_K230_MACHINE MACHINE_TYPE_NAME("k230")
+#define RISCV_K230_MACHINE(obj) \
+    OBJECT_CHECK(K230MachineState, (obj), TYPE_RISCV_K230_MACHINE)
+
+typedef struct K230MachineState {
+    /*< private >*/
+    MachineState parent_obj;
+
+    /*< public >*/
+    K230SoCState soc;
+    Notifier machine_done;
+} K230MachineState;
+
+enum {
+    K230_DEV_DDRC,
+    K230_DEV_KPU_L2_CACHE,
+    K230_DEV_SRAM,
+    K230_DEV_KPU_CFG,
+    K230_DEV_FFT,
+    K230_DEV_AI_2D_ENGINE,
+    K230_DEV_GSDMA,
+    K230_DEV_DMA,
+    K230_DEV_DECOMP_GZIP,
+    K230_DEV_NON_AI_2D,
+    K230_DEV_ISP,
+    K230_DEV_DEWARP,
+    K230_DEV_RX_CSI,
+    K230_DEV_H264,
+    K230_DEV_2P5D,
+    K230_DEV_VO,
+    K230_DEV_VO_CFG,
+    K230_DEV_3D_ENGINE,
+    K230_DEV_PMU,
+    K230_DEV_RTC,
+    K230_DEV_CMU,
+    K230_DEV_RMU,
+    K230_DEV_BOOT,
+    K230_DEV_PWR,
+    K230_DEV_MAILBOX,
+    K230_DEV_IOMUX,
+    K230_DEV_TIMER,
+    K230_DEV_WDT0,
+    K230_DEV_WDT1,
+    K230_DEV_TS,
+    K230_DEV_HDI,
+    K230_DEV_STC,
+    K230_DEV_BOOTROM,
+    K230_DEV_SECURITY,
+    K230_DEV_UART0,
+    K230_DEV_UART1,
+    K230_DEV_UART2,
+    K230_DEV_UART3,
+    K230_DEV_UART4,
+    K230_DEV_I2C0,
+    K230_DEV_I2C1,
+    K230_DEV_I2C2,
+    K230_DEV_I2C3,
+    K230_DEV_I2C4,
+    K230_DEV_PWM,
+    K230_DEV_GPIO0,
+    K230_DEV_GPIO1,
+    K230_DEV_ADC,
+    K230_DEV_CODEC,
+    K230_DEV_I2S,
+    K230_DEV_USB0,
+    K230_DEV_USB1,
+    K230_DEV_SD0,
+    K230_DEV_SD1,
+    K230_DEV_QSPI0,
+    K230_DEV_QSPI1,
+    K230_DEV_SPI,
+    K230_DEV_HI_SYS_CFG,
+    K230_DEV_DDRC_CFG,
+    K230_DEV_FLASH,
+    K230_DEV_PLIC,
+    K230_DEV_CLINT,
+};
+
+enum {
+    K230_UART0_IRQ  = 16,
+    K230_UART1_IRQ  = 17,
+    K230_UART2_IRQ  = 18,
+    K230_UART3_IRQ  = 19,
+    K230_UART4_IRQ  = 20,
+};
+
+/*
+ * Integrates with the interrupt controller (PLIC),
+ * which can process 208 interrupt external sources
+ */
+#define K230_PLIC_NUM_SOURCES 208
+#define K230_PLIC_NUM_PRIORITIES 7
+#define K230_PLIC_PRIORITY_BASE 0x00
+#define K230_PLIC_PENDING_BASE 0x1000
+#define K230_PLIC_ENABLE_BASE 0x2000
+#define K230_PLIC_ENABLE_STRIDE 0x80
+#define K230_PLIC_CONTEXT_BASE 0x200000
+#define K230_PLIC_CONTEXT_STRIDE 0x1000
+
+#endif
-- 
2.51.0


