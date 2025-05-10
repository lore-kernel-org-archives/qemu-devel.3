Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E85C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 06:57:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDe8O-0001kx-RN; Sat, 10 May 2025 02:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcksn@duck.com>) id 1uDbhm-0006D0-Il
 for qemu-devel@nongnu.org; Sat, 10 May 2025 00:20:55 -0400
Received: from smtpa-outbound3.duck.com ([20.13.235.199])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcksn@duck.com>) id 1uDbhj-0004nU-UI
 for qemu-devel@nongnu.org; Sat, 10 May 2025 00:20:54 -0400
Subject: [PATCH 4/6] MAX78000 GCR implementation
References: <20250510042043.2056265-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: R_MISSING_CHARSET(0.5) DMARC_POLICY_ALLOW(-0.5)
 R_DKIM_ALLOW(-0.2) MIME_GOOD(-0.1) R_SPF_ALLOW(-0.2) MID_RHS_MATCH_TO(1)
X-Rspamd-Score: 0.5
X-Rspamd-Action: no action
To: qemu-devel@nongnu.org
Cc: alistair@alistair.me
Received: by smtp-inbound1.duck.com; Sat, 10 May 2025 00:20:50 -0400
Message-ID: <ACFFEE84-30F3-4A74-93C0-5E18B0412D25.1@smtp-inbound1.duck.com>
Date: Sat, 10 May 2025 00:20:50 -0400
From: jcksn@duck.com
Feedback-ID: :isSendReply:isDirect:duckcom
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duck.com;
 h=Feedback-ID: From: Date: Message-ID: Cc: To: Content-Transfer-Encoding:
 MIME-Version: References: Subject; q=dns/txt; s=postal-KpyQVw;
 t=1746850851; bh=xqZsq6zdSYWiA/wWdh5mjbfgLns5YzN1+ZZ+gWGAwRU=;
 b=ArXFq3TJ5asjH7DxTbKo60uPD/poM4amqR5StJEg6krhmtfhVkiNy7q9KAXQKurXeb4j974y1
 CEz+x53ll1/PBUwFqsnMO9FeHqJ/eJL/P2gFgzcPL6fPr/U5C3T1LZGSSlaA7+H47ubm3DV/gI7
 gcijCyyYkB+72yAY6A78blA=
Received-SPF: pass client-ip=20.13.235.199; envelope-from=jcksn@duck.com;
 helo=smtpa-outbound3.duck.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 10 May 2025 02:56:31 -0400
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

This patch implements the Global Control Register for the MAX78000 SOC

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
---
 hw/arm/Kconfig                 |   1 +
 hw/arm/max78000_soc.c          |   9 +-
 hw/misc/Kconfig                |   3 +
 hw/misc/max78000_gcr.c         | 285 +++++++++++++++++++++++++++++++++
 hw/misc/meson.build            |   1 +
 include/hw/arm/max78000_soc.h  |   2 +
 include/hw/misc/max78000_gcr.h | 122 ++++++++++++++
 7 files changed, 422 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/max78000_gcr.c
 create mode 100644 include/hw/misc/max78000_gcr.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 59450dc3cb..211b201629 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -369,6 +369,7 @@ config MAX78000_SOC
     select ARM_V7M
     select MAX78000_ICC
     select MAX78000_UART
+    select MAX78000_GCR
 
 config RASPI
     bool
diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
index 6334d8b49b..7a012c6ef7 100644
--- a/hw/arm/max78000_soc.c
+++ b/hw/arm/max78000_soc.c
@@ -29,6 +29,8 @@ static void max78000_soc_initfn(Object *obj)
 
     object_initialize_child(obj, "armv7m", &s->armv7m, TYPE_ARMV7M);
 
+    object_initialize_child(obj, "gcr", &s->gcr, TYPE_MAX78000_GCR);
+
     for (i = 0; i < MAX78000_NUM_ICC; i++) {
         object_initialize_child(obj, "icc[*]", &s->icc[i], TYPE_MAX78000_ICC);
     }
@@ -104,6 +106,10 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
 
+    dev = DEVICE(&s->gcr);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x40000000);
+
     for (i = 0; i < MAX78000_NUM_ICC; i++) {
         dev = DEVICE(&(s->icc[i]));
         sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), errp);
@@ -116,6 +122,8 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
             return;
         }
+        dev->id = g_strdup_printf("uart%d", i);
+
         busdev = SYS_BUS_DEVICE(dev);
         sysbus_mmio_map(busdev, 0, max78000_uart_addr[i]);
         sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m,
@@ -123,7 +131,6 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
     }
 
 
-    create_unimplemented_device("globalControl",    0x40000000, 0x400);
     create_unimplemented_device("systemInterface",  0x40000400, 0x400);
     create_unimplemented_device("functionControl",  0x40000800, 0x3400);
     create_unimplemented_device("watchdogTimer0",   0x40003000, 0x400);
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 781bcf74cc..fde2266b8f 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -47,6 +47,9 @@ config A9SCU
 config ARM11SCU
     bool
 
+config MAX78000_GCR
+    bool
+
 config MAX78000_ICC
     bool
 
diff --git a/hw/misc/max78000_gcr.c b/hw/misc/max78000_gcr.c
new file mode 100644
index 0000000000..657b7fc490
--- /dev/null
+++ b/hw/misc/max78000_gcr.c
@@ -0,0 +1,285 @@
+/*
+ * MAX78000 Global Control Registers
+ *
+ * Copyright (c) 2025 Jackson Donaldson <jcksn@duck.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "trace.h"
+#include "hw/irq.h"
+#include "system/runstate.h"
+#include "migration/vmstate.h"
+#include "hw/misc/max78000_gcr.h"
+
+static void max78000_gcr_reset(DeviceState *dev)
+{
+    Max78000GcrState *s = MAX78000_GCR(dev);
+    s->sysctrl = 0x21002;
+    s->rst0 = 0;
+    /* All clocks are always ready */
+    s->clkctrl = 0x3e140008;
+    s->pm = 0x3f000;
+    s->pclkdiv = 0;
+    s->pclkdis0 = 0xffffffff;
+    s->memctrl = 0x5;
+    s->memz = 0;
+    s->sysst = 0;
+    s->rst1 = 0;
+    s->pckdis1 = 0xffffffff;
+    s->eventen = 0;
+    s->revision = 0xa1;
+    s->sysie = 0;
+    s->eccerr = 0;
+    s->ecced = 0;
+    s->eccie = 0;
+    s->eccaddr = 0;
+}
+
+static uint64_t max78000_gcr_read(void *opaque, hwaddr addr,
+                                     unsigned int size)
+{
+    Max78000GcrState *s = opaque;
+
+    switch (addr) {
+        case SYSCTRL:{
+            return s->sysctrl;
+        }
+        case RST0:{
+            return s->rst0;
+        }
+        case CLKCTRL:{
+            return s->clkctrl;
+        }
+        case PM:{
+            return s->pm;
+        }
+        case PCLKDIV:{
+            return s->pclkdiv;
+        }
+        case PCLKDIS0:{
+            return s->pclkdis0;
+        }
+        case MEMCTRL:{
+            return s->memctrl;
+        }
+        case MEMZ:{
+            return s->memz;
+        }
+        case SYSST:{
+            return s->sysst;
+        }
+        case RST1:{
+            return s->rst1;
+        }
+        case PCKDIS1:{
+            return s->pckdis1;
+        }
+        case EVENTEN:{
+            return s->eventen;
+        }
+        case REVISION:{
+            return s->revision;
+        }
+        case SYSIE:{
+            return s->sysie;
+        }
+        case ECCERR:{
+            return s->eccerr;
+        }
+        case ECCED:{
+            return s->ecced;
+        }
+        case ECCIE:{
+            return s->eccie;
+        }
+        case ECCADDR:{
+            return s->eccaddr;
+        }
+        default:{
+            return 0;
+        }
+    }
+}
+
+static void max78000_gcr_reset_device(const char *device_name)
+{
+    DeviceState *dev = qdev_find_recursive(sysbus_get_default(), device_name);
+    if (dev) {
+        device_cold_reset(dev);
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR, "no device %s for reset\n", device_name);
+    }
+}
+
+static void max78000_gcr_write(void *opaque, hwaddr addr,
+                       uint64_t val64, unsigned int size)
+{
+    Max78000GcrState *s = opaque;
+    uint32_t val = val64;
+    uint8_t zero[0xc000] = {0};
+    switch (addr) {
+        case SYSCTRL:{
+            /* Checksum calculations always pass immediately */
+            s->sysctrl = (val & 0x30000) | 0x1002;
+            break;
+        }
+        case RST0:{
+            if (val & SYSTEM_RESET) {
+                qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+            }
+            if (val & PERIPHERAL_RESET) {
+                /*
+                 * Peripheral reset resets all peripherals. The CPU
+                 * retains its state. The GPIO, watchdog timers, AoD,
+                 * RAM retention, and general control registers (GCR),
+                 * including the clock configuration, are unaffected.
+                 */
+                val = UART2_RESET | UART1_RESET | UART0_RESET |
+                      ADC_RESET | CNN_RESET | TRNG_RESET |
+                      RTC_RESET | I2C0_RESET | SPI1_RESET |
+                      TMR3_RESET | TMR2_RESET | TMR1_RESET |
+                      TMR0_RESET | WDT0_RESET | DMA_RESET;
+            }
+            if (val & SOFT_RESET) {
+                /* Soft reset also resets GPIO */
+                val = UART2_RESET | UART1_RESET | UART0_RESET |
+                      ADC_RESET | CNN_RESET | TRNG_RESET |
+                      RTC_RESET | I2C0_RESET | SPI1_RESET |
+                      TMR3_RESET | TMR2_RESET | TMR1_RESET |
+                      TMR0_RESET | GPIO1_RESET | GPIO0_RESET |
+                      DMA_RESET;
+            }
+            if (val & UART2_RESET) {
+                max78000_gcr_reset_device("uart2");
+            }
+            if (val & UART1_RESET) {
+                max78000_gcr_reset_device("uart1");
+            }
+            if (val & UART0_RESET) {
+                max78000_gcr_reset_device("uart0");
+            }
+            /* TODO: As other devices are implemented, add them here */
+            break;
+        }
+        case CLKCTRL:{
+            s->clkctrl = val | SYSCLK_RDY;
+            break;
+        }
+        case PM:{
+            s->pm = val;
+            break;
+        }
+        case PCLKDIV:{
+            s->pclkdiv = val;
+            break;
+        }
+        case PCLKDIS0:{
+            s->pclkdis0 = val;
+            break;
+        }
+        case MEMCTRL:{
+            s->memctrl = val;
+            break;
+        }
+        case MEMZ:{
+            if (val & ram0) {
+                cpu_physical_memory_write(SYSRAM0_START, zero, 0x8000);
+            }
+            if (val & ram1) {
+                cpu_physical_memory_write(SYSRAM1_START, zero, 0x8000);
+            }
+            if (val & ram2) {
+                cpu_physical_memory_write(SYSRAM2_START, zero, 0xC000);
+            }
+            if (val & ram3) {
+                cpu_physical_memory_write(SYSRAM3_START, zero, 0x4000);
+            }
+            break;
+        }
+        case SYSST:{
+            s->sysst = val;
+            break;
+        }
+        case RST1:{
+            /* TODO: As other devices are implemented, add them here */
+            s->rst1 = val;
+            break;
+        }
+        case PCKDIS1:{
+            s->pckdis1 = val;
+            break;
+        }
+        case EVENTEN:{
+            s->eventen = val;
+            break;
+        }
+        case REVISION:{
+            s->revision = val;
+            break;
+        }
+        case SYSIE:{
+            s->sysie = val;
+            break;
+        }
+        case ECCERR:{
+            s->eccerr = val;
+            break;
+        }
+        case ECCED:{
+            s->ecced = val;
+            break;
+        }
+        case ECCIE:{
+            s->eccie = val;
+            break;
+        }
+        case ECCADDR:{
+            s->eccaddr = val;
+            break;
+        }
+        default:{
+            break;
+        }
+    }
+}
+
+static const MemoryRegionOps max78000_gcr_ops = {
+    .read = max78000_gcr_read,
+    .write = max78000_gcr_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void max78000_gcr_init(Object *obj)
+{
+    Max78000GcrState *s = MAX78000_GCR(obj);
+
+    memory_region_init_io(&s->mmio, obj, &max78000_gcr_ops, s,
+                          TYPE_MAX78000_GCR, 0x400);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+
+}
+
+static void max78000_gcr_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, max78000_gcr_reset);
+}
+
+static const TypeInfo max78000_gcr_info = {
+    .name          = TYPE_MAX78000_GCR,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(Max78000GcrState),
+    .instance_init = max78000_gcr_init,
+    .class_init     = max78000_gcr_class_init,
+};
+
+static void max78000_gcr_register_types(void)
+{
+    type_register_static(&max78000_gcr_info);
+}
+
+type_init(max78000_gcr_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index a21a994ff8..283d06dad4 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -70,6 +70,7 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx_ccm.c',
   'imx_rngc.c',
 ))
+system_ss.add(when: 'CONFIG_MAX78000_GCR', if_true: files('max78000_gcr.c'))
 system_ss.add(when: 'CONFIG_MAX78000_ICC', if_true: files('max78000_icc.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files(
   'npcm_clk.c',
diff --git a/include/hw/arm/max78000_soc.h b/include/hw/arm/max78000_soc.h
index 1ee280b894..8b9e3052cd 100644
--- a/include/hw/arm/max78000_soc.h
+++ b/include/hw/arm/max78000_soc.h
@@ -11,6 +11,7 @@
 
 #include "hw/or-irq.h"
 #include "hw/arm/armv7m.h"
+#include "hw/misc/max78000_gcr.h"
 #include "hw/misc/max78000_icc.h"
 #include "hw/char/max78000_uart.h"
 #include "qom/object.h"
@@ -35,6 +36,7 @@ struct MAX78000State {
     MemoryRegion sram;
     MemoryRegion flash;
 
+    Max78000GcrState gcr;
     Max78000IccState icc[MAX78000_NUM_ICC];
     Max78000UartState uart[MAX78000_NUM_UART];
 
diff --git a/include/hw/misc/max78000_gcr.h b/include/hw/misc/max78000_gcr.h
new file mode 100644
index 0000000000..128f9b8a99
--- /dev/null
+++ b/include/hw/misc/max78000_gcr.h
@@ -0,0 +1,122 @@
+/*
+ * MAX78000 Global Control Register
+ *
+ * Copyright (c) 2025 Jackson Donaldson <jcksn@duck.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_MAX78000_GCR_H
+#define HW_MAX78000_GCR_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_MAX78000_GCR "max78000-gcr"
+OBJECT_DECLARE_SIMPLE_TYPE(Max78000GcrState, MAX78000_GCR)
+
+#define SYSCTRL     0x0
+#define RST0        0x4
+#define CLKCTRL     0x8
+#define PM          0xc
+#define PCLKDIV     0x18
+#define PCLKDIS0    0x24
+#define MEMCTRL     0x28
+#define MEMZ        0x2c
+#define SYSST       0x40
+#define RST1        0x44
+#define PCKDIS1     0x48
+#define EVENTEN     0x4c
+#define REVISION    0x50
+#define SYSIE       0x54
+#define ECCERR      0x64
+#define ECCED       0x68
+#define ECCIE       0x6c
+#define ECCADDR     0x70
+
+/* RST0 */
+#define SYSTEM_RESET (1 << 31)
+#define PERIPHERAL_RESET (1 << 30)
+#define SOFT_RESET (1 << 29)
+#define UART2_RESET (1 << 28)
+
+#define ADC_RESET (1 << 26)
+#define CNN_RESET (1 << 25)
+#define TRNG_RESET (1 << 24)
+
+#define RTC_RESET (1 << 17)
+#define I2C0_RESET (1 << 16)
+
+#define SPI1_RESET (1 << 13)
+#define UART1_RESET (1 << 12)
+#define UART0_RESET (1 << 11)
+
+#define TMR3_RESET (1 << 8)
+#define TMR2_RESET (1 << 7)
+#define TMR1_RESET (1 << 6)
+#define TMR0_RESET (1 << 5)
+
+#define GPIO1_RESET (1 << 3)
+#define GPIO0_RESET (1 << 2)
+#define WDT0_RESET (1 << 1)
+#define DMA_RESET (1 << 0)
+
+/* CLKCTRL */
+#define SYSCLK_RDY (1 << 13)
+
+/* MEMZ */
+#define ram0 (1 << 0)
+#define ram1 (1 << 1)
+#define ram2 (1 << 2)
+#define ram3 (1 << 3)
+
+/* RST1 */
+#define CPU1_RESET (1 << 31)
+
+#define SIMO_RESET (1 << 25)
+#define DVS_RESET (1 << 24)
+
+#define I2C2_RESET (1 << 20)
+#define I2S_RESET (1 << 19)
+
+#define SMPHR_RESET (1 << 16)
+
+#define SPI0_RESET (1 << 11)
+#define AES_RESET (1 << 10)
+#define CRC_RESET (1 << 9)
+
+#define PT_RESET (1 << 1)
+#define I2C1_RESET (1 << 0)
+
+
+#define SYSRAM0_START 0x20000000
+#define SYSRAM1_START 0x20008000
+#define SYSRAM2_START 0x20010000
+#define SYSRAM3_START 0x2001C000
+
+struct Max78000GcrState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+
+    uint32_t sysctrl;
+    uint32_t rst0;
+    uint32_t clkctrl;
+    uint32_t pm;
+    uint32_t pclkdiv;
+    uint32_t pclkdis0;
+    uint32_t memctrl;
+    uint32_t memz;
+    uint32_t sysst;
+    uint32_t rst1;
+    uint32_t pckdis1;
+    uint32_t eventen;
+    uint32_t revision;
+    uint32_t sysie;
+    uint32_t eccerr;
+    uint32_t ecced;
+    uint32_t eccie;
+    uint32_t eccaddr;
+
+};
+
+#endif
-- 
2.34.1


