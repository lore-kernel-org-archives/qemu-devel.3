Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B504C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 18:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdaSu-0001I2-0T; Fri, 23 Feb 2024 13:40:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rdaC4-0007f8-VD; Fri, 23 Feb 2024 13:22:47 -0500
Received: from zproxy4.enst.fr ([137.194.2.223])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rdaC0-0002RR-Pg; Fri, 23 Feb 2024 13:22:43 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id D12F72073A;
 Fri, 23 Feb 2024 19:22:36 +0100 (CET)
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id Y8DQF0uJQi9b; Fri, 23 Feb 2024 19:22:36 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id CEA102073B;
 Fri, 23 Feb 2024 19:22:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy4.enst.fr CEA102073B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1708712556;
 bh=soufNybeqfp7LNZQqr4fzJVhOSJfytnoaS7ehmO0D0c=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=ZWGlpvwZRB6EGg9IybyHBT3nsRUEbj6mMT05NmajXqkS13PdjxcIjZ2dYDzlZUcQD
 vGMIgem/0hH8nNax+0ztcc+0xylBKuarcYC498yjCTYK/DXNKrWgDLSJLECGOq9xGC
 IV+FcZB84fJCwZhiOltAPr8FReeo+1J0XSY1U1m0=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id WHX7ADKIIips; Fri, 23 Feb 2024 19:22:35 +0100 (CET)
Received: from inesv-Inspiron-3501.lan (unknown
 [IPv6:2001:861:4680:b1b0:946f:f726:4968:ea36])
 by zproxy4.enst.fr (Postfix) with ESMTPSA id 267972073C;
 Fri, 23 Feb 2024 19:22:35 +0100 (CET)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Laurent Vivier <lvivier@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v5 2/3] hw/arm: Connect STM32L4x5 GPIO to STM32L4x5 SoC
Date: Fri, 23 Feb 2024 19:22:05 +0100
Message-ID: <20240223182229.293802-3-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240223182229.293802-1-ines.varhol@telecom-paris.fr>
References: <20240223182229.293802-1-ines.varhol@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=137.194.2.223;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy4.enst.fr
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
---
 include/hw/arm/stm32l4x5_soc.h |  2 +
 hw/arm/stm32l4x5_soc.c         | 68 +++++++++++++++++++++++++++-------
 hw/arm/Kconfig                 |  3 +-
 3 files changed, 58 insertions(+), 15 deletions(-)

diff --git a/include/hw/arm/stm32l4x5_soc.h b/include/hw/arm/stm32l4x5_so=
c.h
index 1f71298b45..cb4da08629 100644
--- a/include/hw/arm/stm32l4x5_soc.h
+++ b/include/hw/arm/stm32l4x5_soc.h
@@ -29,6 +29,7 @@
 #include "hw/misc/stm32l4x5_syscfg.h"
 #include "hw/misc/stm32l4x5_exti.h"
 #include "hw/misc/stm32l4x5_rcc.h"
+#include "hw/gpio/stm32l4x5_gpio.h"
 #include "qom/object.h"
=20
 #define TYPE_STM32L4X5_SOC "stm32l4x5-soc"
@@ -45,6 +46,7 @@ struct Stm32l4x5SocState {
     Stm32l4x5ExtiState exti;
     Stm32l4x5SyscfgState syscfg;
     Stm32l4x5RccState rcc;
+    Stm32l4x5GpioState gpio[NUM_GPIOS];
=20
     MemoryRegion sram1;
     MemoryRegion sram2;
diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
index 347a5377e5..be0f11dc1b 100644
--- a/hw/arm/stm32l4x5_soc.c
+++ b/hw/arm/stm32l4x5_soc.c
@@ -78,6 +78,22 @@ static const int exti_irq[NUM_EXTI_IRQ] =3D {
 #define RCC_BASE_ADDRESS 0x40021000
 #define RCC_IRQ 5
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
@@ -85,6 +101,11 @@ static void stm32l4x5_soc_initfn(Object *obj)
     object_initialize_child(obj, "exti", &s->exti, TYPE_STM32L4X5_EXTI);
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
@@ -93,8 +114,9 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc=
, Error **errp)
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
@@ -135,17 +157,43 @@ static void stm32l4x5_soc_realize(DeviceState *dev_=
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
@@ -242,14 +290,6 @@ static void stm32l4x5_soc_realize(DeviceState *dev_s=
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
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 92b72d56dc..5776dbb19f 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -463,9 +463,10 @@ config STM32L4X5_SOC
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


