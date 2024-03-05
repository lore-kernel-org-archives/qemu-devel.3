Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D0EC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 21:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhbyI-0004NB-Cl; Tue, 05 Mar 2024 16:05:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rhbyE-0004JU-Qa; Tue, 05 Mar 2024 16:05:06 -0500
Received: from zproxy3.enst.fr ([137.194.2.222])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rhby8-0006f5-KY; Tue, 05 Mar 2024 16:05:06 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id D9AD5A06C6;
 Tue,  5 Mar 2024 22:04:56 +0100 (CET)
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id TXGHiKMniI-9; Tue,  5 Mar 2024 22:04:56 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 1C72EA06B5;
 Tue,  5 Mar 2024 22:04:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy3.enst.fr 1C72EA06B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1709672696;
 bh=qO1SIASaP4ZTeOQxTZkhJrPW3Qux2cU/xKIHLbFzW64=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=TQ3D6F5LoZnQCGTDn8fuaONbkjeUH+W1l3u0r6RyG/ip8C6izyogvsf/N5ya2fBHR
 Ydcf5wQLyFYl0T057w4ZHw7jfV3x3BWKXbRJKGaYe90hG+cm+QoDkiPLOKW+6O4WGi
 TiQIAr6dOAxtFPXq6CpsrAmNJDlvstPbkKaSU3BQ=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id 2F3bYjEmCYMV; Tue,  5 Mar 2024 22:04:56 +0100 (CET)
Received: from localhost.localdomain (74.0.125.80.rev.sfr.net [80.125.0.74])
 by zproxy3.enst.fr (Postfix) with ESMTPSA id 79AB8A06E6;
 Tue,  5 Mar 2024 22:04:55 +0100 (CET)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v7 2/3] hw/arm: Connect STM32L4x5 GPIO to STM32L4x5 SoC
Date: Tue,  5 Mar 2024 22:03:11 +0100
Message-ID: <20240305210444.310665-3-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240305210444.310665-1-ines.varhol@telecom-paris.fr>
References: <20240305210444.310665-1-ines.varhol@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=137.194.2.222;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy3.enst.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/arm/stm32l4x5_soc.h     |  2 +
 include/hw/gpio/stm32l4x5_gpio.h   |  1 +
 include/hw/misc/stm32l4x5_syscfg.h |  3 +-
 hw/arm/stm32l4x5_soc.c             | 71 +++++++++++++++++++++++-------
 hw/misc/stm32l4x5_syscfg.c         |  1 +
 hw/arm/Kconfig                     |  3 +-
 6 files changed, 63 insertions(+), 18 deletions(-)

diff --git a/include/hw/arm/stm32l4x5_soc.h b/include/hw/arm/stm32l4x5_so=
c.h
index af67b089ef..ee5f362405 100644
--- a/include/hw/arm/stm32l4x5_soc.h
+++ b/include/hw/arm/stm32l4x5_soc.h
@@ -30,6 +30,7 @@
 #include "hw/misc/stm32l4x5_syscfg.h"
 #include "hw/misc/stm32l4x5_exti.h"
 #include "hw/misc/stm32l4x5_rcc.h"
+#include "hw/gpio/stm32l4x5_gpio.h"
 #include "qom/object.h"
=20
 #define TYPE_STM32L4X5_SOC "stm32l4x5-soc"
@@ -49,6 +50,7 @@ struct Stm32l4x5SocState {
     OrIRQState exti_or_gates[NUM_EXTI_OR_GATES];
     Stm32l4x5SyscfgState syscfg;
     Stm32l4x5RccState rcc;
+    Stm32l4x5GpioState gpio[NUM_GPIOS];
=20
     MemoryRegion sram1;
     MemoryRegion sram2;
diff --git a/include/hw/gpio/stm32l4x5_gpio.h b/include/hw/gpio/stm32l4x5=
_gpio.h
index 0d361f3410..878bd19fc9 100644
--- a/include/hw/gpio/stm32l4x5_gpio.h
+++ b/include/hw/gpio/stm32l4x5_gpio.h
@@ -25,6 +25,7 @@
 #define TYPE_STM32L4X5_GPIO "stm32l4x5-gpio"
 OBJECT_DECLARE_SIMPLE_TYPE(Stm32l4x5GpioState, STM32L4X5_GPIO)
=20
+#define NUM_GPIOS 8
 #define GPIO_NUM_PINS 16
=20
 struct Stm32l4x5GpioState {
diff --git a/include/hw/misc/stm32l4x5_syscfg.h b/include/hw/misc/stm32l4=
x5_syscfg.h
index 29c3522f9d..23bb564150 100644
--- a/include/hw/misc/stm32l4x5_syscfg.h
+++ b/include/hw/misc/stm32l4x5_syscfg.h
@@ -26,12 +26,11 @@
=20
 #include "hw/sysbus.h"
 #include "qom/object.h"
+#include "hw/gpio/stm32l4x5_gpio.h"
=20
 #define TYPE_STM32L4X5_SYSCFG "stm32l4x5-syscfg"
 OBJECT_DECLARE_SIMPLE_TYPE(Stm32l4x5SyscfgState, STM32L4X5_SYSCFG)
=20
-#define NUM_GPIOS 8
-#define GPIO_NUM_PINS 16
 #define SYSCFG_NUM_EXTICR 4
=20
 struct Stm32l4x5SyscfgState {
diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
index bf9926057b..40e294f838 100644
--- a/hw/arm/stm32l4x5_soc.c
+++ b/hw/arm/stm32l4x5_soc.c
@@ -28,6 +28,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/or-irq.h"
 #include "hw/arm/stm32l4x5_soc.h"
+#include "hw/gpio/stm32l4x5_gpio.h"
 #include "hw/qdev-clock.h"
 #include "hw/misc/unimp.h"
=20
@@ -99,6 +100,22 @@ static const int exti_or_gate1_lines_in[EXTI_OR_GATE1=
_NUM_LINES_IN] =3D {
     16, 35, 36, 37, 38,
 };
=20
+static const struct {
+    uint32_t addr;
+    uint32_t moder_reset;
+    uint32_t ospeedr_reset;
+    uint32_t pupdr_reset;
+} stm32l4x5_gpio_cfg[NUM_GPIOS] =3D {
+    { 0x48000000, 0xABFFFFFF, 0x0C000000, 0x64000000 },
+    { 0x48000400, 0xFFFFFEBF, 0x00000000, 0x00000100 },
+    { 0x48000800, 0xFFFFFFFF, 0x00000000, 0x00000000 },
+    { 0x48000C00, 0xFFFFFFFF, 0x00000000, 0x00000000 },
+    { 0x48001000, 0xFFFFFFFF, 0x00000000, 0x00000000 },
+    { 0x48001400, 0xFFFFFFFF, 0x00000000, 0x00000000 },
+    { 0x48001800, 0xFFFFFFFF, 0x00000000, 0x00000000 },
+    { 0x48001C00, 0x0000000F, 0x00000000, 0x00000000 },
+};
+
 static void stm32l4x5_soc_initfn(Object *obj)
 {
     Stm32l4x5SocState *s =3D STM32L4X5_SOC(obj);
@@ -110,6 +127,11 @@ static void stm32l4x5_soc_initfn(Object *obj)
     }
     object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_STM32L4X5_SY=
SCFG);
     object_initialize_child(obj, "rcc", &s->rcc, TYPE_STM32L4X5_RCC);
+
+    for (unsigned i =3D 0; i < NUM_GPIOS; i++) {
+        g_autofree char *name =3D g_strdup_printf("gpio%c", 'a' + i);
+        object_initialize_child(obj, name, &s->gpio[i], TYPE_STM32L4X5_G=
PIO);
+    }
 }
=20
 static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
@@ -118,8 +140,9 @@ static void stm32l4x5_soc_realize(DeviceState *dev_so=
c, Error **errp)
     Stm32l4x5SocState *s =3D STM32L4X5_SOC(dev_soc);
     const Stm32l4x5SocClass *sc =3D STM32L4X5_SOC_GET_CLASS(dev_soc);
     MemoryRegion *system_memory =3D get_system_memory();
-    DeviceState *armv7m;
+    DeviceState *armv7m, *dev;
     SysBusDevice *busdev;
+    uint32_t pin_index;
=20
     if (!memory_region_init_rom(&s->flash, OBJECT(dev_soc), "flash",
                                 sc->flash_size, errp)) {
@@ -160,17 +183,43 @@ static void stm32l4x5_soc_realize(DeviceState *dev_=
soc, Error **errp)
         return;
     }
=20
+    /* GPIOs */
+    for (unsigned i =3D 0; i < NUM_GPIOS; i++) {
+        g_autofree char *name =3D g_strdup_printf("%c", 'A' + i);
+        dev =3D DEVICE(&s->gpio[i]);
+        qdev_prop_set_string(dev, "name", name);
+        qdev_prop_set_uint32(dev, "mode-reset",
+                             stm32l4x5_gpio_cfg[i].moder_reset);
+        qdev_prop_set_uint32(dev, "ospeed-reset",
+                             stm32l4x5_gpio_cfg[i].ospeedr_reset);
+        qdev_prop_set_uint32(dev, "pupd-reset",
+                            stm32l4x5_gpio_cfg[i].pupdr_reset);
+        busdev =3D SYS_BUS_DEVICE(&s->gpio[i]);
+        g_free(name);
+        name =3D g_strdup_printf("gpio%c-out", 'a' + i);
+        qdev_connect_clock_in(DEVICE(&s->gpio[i]), "clk",
+            qdev_get_clock_out(DEVICE(&(s->rcc)), name));
+        if (!sysbus_realize(busdev, errp)) {
+            return;
+        }
+        sysbus_mmio_map(busdev, 0, stm32l4x5_gpio_cfg[i].addr);
+    }
+
     /* System configuration controller */
     busdev =3D SYS_BUS_DEVICE(&s->syscfg);
     if (!sysbus_realize(busdev, errp)) {
         return;
     }
     sysbus_mmio_map(busdev, 0, SYSCFG_ADDR);
-    /*
-     * TODO: when the GPIO device is implemented, connect it
-     * to SYCFG using `qdev_connect_gpio_out`, NUM_GPIOS and
-     * GPIO_NUM_PINS.
-     */
+
+    for (unsigned i =3D 0; i < NUM_GPIOS; i++) {
+        for (unsigned j =3D 0; j < GPIO_NUM_PINS; j++) {
+            pin_index =3D GPIO_NUM_PINS * i + j;
+            qdev_connect_gpio_out(DEVICE(&s->gpio[i]), j,
+                                  qdev_get_gpio_in(DEVICE(&s->syscfg),
+                                  pin_index));
+        }
+    }
=20
     /* EXTI device */
     busdev =3D SYS_BUS_DEVICE(&s->exti);
@@ -217,7 +266,7 @@ static void stm32l4x5_soc_realize(DeviceState *dev_so=
c, Error **errp)
         }
     }
=20
-    for (unsigned i =3D 0; i < 16; i++) {
+    for (unsigned i =3D 0; i < GPIO_NUM_PINS; i++) {
         qdev_connect_gpio_out(DEVICE(&s->syscfg), i,
                               qdev_get_gpio_in(DEVICE(&s->exti), i));
     }
@@ -302,14 +351,6 @@ static void stm32l4x5_soc_realize(DeviceState *dev_s=
oc, Error **errp)
     /* RESERVED:    0x40024400, 0x7FDBC00 */
=20
     /* AHB2 BUS */
-    create_unimplemented_device("GPIOA",     0x48000000, 0x400);
-    create_unimplemented_device("GPIOB",     0x48000400, 0x400);
-    create_unimplemented_device("GPIOC",     0x48000800, 0x400);
-    create_unimplemented_device("GPIOD",     0x48000C00, 0x400);
-    create_unimplemented_device("GPIOE",     0x48001000, 0x400);
-    create_unimplemented_device("GPIOF",     0x48001400, 0x400);
-    create_unimplemented_device("GPIOG",     0x48001800, 0x400);
-    create_unimplemented_device("GPIOH",     0x48001C00, 0x400);
     /* RESERVED:    0x48002000, 0x7FDBC00 */
     create_unimplemented_device("OTG_FS",    0x50000000, 0x40000);
     create_unimplemented_device("ADC",       0x50040000, 0x400);
diff --git a/hw/misc/stm32l4x5_syscfg.c b/hw/misc/stm32l4x5_syscfg.c
index fd68cb800b..3dafc00b49 100644
--- a/hw/misc/stm32l4x5_syscfg.c
+++ b/hw/misc/stm32l4x5_syscfg.c
@@ -27,6 +27,7 @@
 #include "hw/irq.h"
 #include "migration/vmstate.h"
 #include "hw/misc/stm32l4x5_syscfg.h"
+#include "hw/gpio/stm32l4x5_gpio.h"
=20
 #define SYSCFG_MEMRMP 0x00
 #define SYSCFG_CFGR1 0x04
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index d58d820788..893a7bff66 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -473,9 +473,10 @@ config STM32L4X5_SOC
     bool
     select ARM_V7M
     select OR_IRQ
-    select STM32L4X5_SYSCFG
     select STM32L4X5_EXTI
+    select STM32L4X5_SYSCFG
     select STM32L4X5_RCC
+    select STM32L4X5_GPIO
=20
 config XLNX_ZYNQMP_ARM
     bool
--=20
2.43.2


