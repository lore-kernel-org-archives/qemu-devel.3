Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2309FC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricUZ-0000AG-Bu; Fri, 08 Mar 2024 10:50:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ricUN-0007cz-Ke
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:50:27 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ricUI-0004Si-KE
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:50:27 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33e122c8598so1204266f8f.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 07:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709913021; x=1710517821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4ZUGIJ7Dxq6i5SHXLd7JYUtJZpNzX4uxBVkyL+7w0k8=;
 b=kqmqdEj06CpDcpuuKZG0kcNSmAauPNoBvvPj7oM59jvfUVra5WulwNlZA1bHg7WRUn
 Srio+qgbxTf+nEaa1zxUzrXgxnYMLmebzAqwFvnbtaY4bhXtN6/OYiilcjQ5aP9istng
 YItchuMlQfDdJAlaHKEKDQ9mP6tG7lfyNWfkIOKDSHLF+zmwVwoxqUpsPdekZN5Nh78E
 Ym1nvgdm0ORQA+bKL3b4y4ePyBdLXO5eWNGZqSgx84J5nEfuuDzyfp76CjbnNZOJp2Rz
 TwObtB4Gud4BWh+GdITghd2sUpCNpdF5veMBPP3iYx8MA9cSdAY7BrRpEaALswUJJ3RR
 aBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709913021; x=1710517821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4ZUGIJ7Dxq6i5SHXLd7JYUtJZpNzX4uxBVkyL+7w0k8=;
 b=Y9UtqeYtRevGw40CYaChfkm47sep3Q8DJ5XJCysacdekmA5h2ZdfFrqiURmwpeGtsr
 70+l7FWU8vAAt7WYIbmWBfZqFkVk5l4WPRDheoVYBRmLrjskEQxRGLgg7zCLYv6HIT5B
 QA0NH++WCy0CJ6foh9YapTrSaKrT5otnvfCUH5ZrZrpr/tmTfdX8HMcIXNte4ILZt5aO
 wukQxbygnLAhiTyhObkBForgzKnAHHG1qLhJ4Feu6OEEy57BLRCPVrU7n2CnXZ9oU/KU
 4pAcZnh+w+qWByU4e/fzV0z072HyHB49n5jGvrviPo5ZfBEITpto5Gl1reZ7gsZuufGr
 YB9Q==
X-Gm-Message-State: AOJu0YyBD/ocBcFD4ZMy8eX+b4r0Glj5eYZ8xrjDwdp7fxuMvqPZmxej
 cWaG6tOmbBU/hM67Lnxd9wxvkjtnwRvJD9XWlKKjktgGiUKmHvSRKg5WE0wxlBDQ0ixmOJtP6cv
 V
X-Google-Smtp-Source: AGHT+IHQMscdsa47Vumu5Q0jWEx2iYJDHsp34b0dbpMeU+Pne8GTRy05mYLQATwoAIB2i5F3XoU81A==
X-Received: by 2002:a5d:608b:0:b0:33e:4390:c039 with SMTP id
 w11-20020a5d608b000000b0033e4390c039mr9830898wrt.33.1709913021133; 
 Fri, 08 Mar 2024 07:50:21 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f2-20020adff8c2000000b0033e7a204dc7sm856080wrq.32.2024.03.08.07.50.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 07:50:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/14] hw/arm: Connect STM32L4x5 GPIO to STM32L4x5 SoC
Date: Fri,  8 Mar 2024 15:50:11 +0000
Message-Id: <20240308155015.3637663-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308155015.3637663-1-peter.maydell@linaro.org>
References: <20240308155015.3637663-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Inès Varhol <ines.varhol@telecom-paris.fr>

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20240305210444.310665-3-ines.varhol@telecom-paris.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/stm32l4x5_soc.h     |  2 +
 include/hw/gpio/stm32l4x5_gpio.h   |  1 +
 include/hw/misc/stm32l4x5_syscfg.h |  3 +-
 hw/arm/stm32l4x5_soc.c             | 71 +++++++++++++++++++++++-------
 hw/misc/stm32l4x5_syscfg.c         |  1 +
 hw/arm/Kconfig                     |  3 +-
 6 files changed, 63 insertions(+), 18 deletions(-)

diff --git a/include/hw/arm/stm32l4x5_soc.h b/include/hw/arm/stm32l4x5_soc.h
index af67b089efc..ee5f3624055 100644
--- a/include/hw/arm/stm32l4x5_soc.h
+++ b/include/hw/arm/stm32l4x5_soc.h
@@ -30,6 +30,7 @@
 #include "hw/misc/stm32l4x5_syscfg.h"
 #include "hw/misc/stm32l4x5_exti.h"
 #include "hw/misc/stm32l4x5_rcc.h"
+#include "hw/gpio/stm32l4x5_gpio.h"
 #include "qom/object.h"
 
 #define TYPE_STM32L4X5_SOC "stm32l4x5-soc"
@@ -49,6 +50,7 @@ struct Stm32l4x5SocState {
     OrIRQState exti_or_gates[NUM_EXTI_OR_GATES];
     Stm32l4x5SyscfgState syscfg;
     Stm32l4x5RccState rcc;
+    Stm32l4x5GpioState gpio[NUM_GPIOS];
 
     MemoryRegion sram1;
     MemoryRegion sram2;
diff --git a/include/hw/gpio/stm32l4x5_gpio.h b/include/hw/gpio/stm32l4x5_gpio.h
index 0d361f34105..878bd19fc9b 100644
--- a/include/hw/gpio/stm32l4x5_gpio.h
+++ b/include/hw/gpio/stm32l4x5_gpio.h
@@ -25,6 +25,7 @@
 #define TYPE_STM32L4X5_GPIO "stm32l4x5-gpio"
 OBJECT_DECLARE_SIMPLE_TYPE(Stm32l4x5GpioState, STM32L4X5_GPIO)
 
+#define NUM_GPIOS 8
 #define GPIO_NUM_PINS 16
 
 struct Stm32l4x5GpioState {
diff --git a/include/hw/misc/stm32l4x5_syscfg.h b/include/hw/misc/stm32l4x5_syscfg.h
index 29c3522f9dd..23bb5641507 100644
--- a/include/hw/misc/stm32l4x5_syscfg.h
+++ b/include/hw/misc/stm32l4x5_syscfg.h
@@ -26,12 +26,11 @@
 
 #include "hw/sysbus.h"
 #include "qom/object.h"
+#include "hw/gpio/stm32l4x5_gpio.h"
 
 #define TYPE_STM32L4X5_SYSCFG "stm32l4x5-syscfg"
 OBJECT_DECLARE_SIMPLE_TYPE(Stm32l4x5SyscfgState, STM32L4X5_SYSCFG)
 
-#define NUM_GPIOS 8
-#define GPIO_NUM_PINS 16
 #define SYSCFG_NUM_EXTICR 4
 
 struct Stm32l4x5SyscfgState {
diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
index bf9926057be..40e294f838f 100644
--- a/hw/arm/stm32l4x5_soc.c
+++ b/hw/arm/stm32l4x5_soc.c
@@ -28,6 +28,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/or-irq.h"
 #include "hw/arm/stm32l4x5_soc.h"
+#include "hw/gpio/stm32l4x5_gpio.h"
 #include "hw/qdev-clock.h"
 #include "hw/misc/unimp.h"
 
@@ -99,6 +100,22 @@ static const int exti_or_gate1_lines_in[EXTI_OR_GATE1_NUM_LINES_IN] = {
     16, 35, 36, 37, 38,
 };
 
+static const struct {
+    uint32_t addr;
+    uint32_t moder_reset;
+    uint32_t ospeedr_reset;
+    uint32_t pupdr_reset;
+} stm32l4x5_gpio_cfg[NUM_GPIOS] = {
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
     Stm32l4x5SocState *s = STM32L4X5_SOC(obj);
@@ -110,6 +127,11 @@ static void stm32l4x5_soc_initfn(Object *obj)
     }
     object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_STM32L4X5_SYSCFG);
     object_initialize_child(obj, "rcc", &s->rcc, TYPE_STM32L4X5_RCC);
+
+    for (unsigned i = 0; i < NUM_GPIOS; i++) {
+        g_autofree char *name = g_strdup_printf("gpio%c", 'a' + i);
+        object_initialize_child(obj, name, &s->gpio[i], TYPE_STM32L4X5_GPIO);
+    }
 }
 
 static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
@@ -118,8 +140,9 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
     Stm32l4x5SocState *s = STM32L4X5_SOC(dev_soc);
     const Stm32l4x5SocClass *sc = STM32L4X5_SOC_GET_CLASS(dev_soc);
     MemoryRegion *system_memory = get_system_memory();
-    DeviceState *armv7m;
+    DeviceState *armv7m, *dev;
     SysBusDevice *busdev;
+    uint32_t pin_index;
 
     if (!memory_region_init_rom(&s->flash, OBJECT(dev_soc), "flash",
                                 sc->flash_size, errp)) {
@@ -160,17 +183,43 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
 
+    /* GPIOs */
+    for (unsigned i = 0; i < NUM_GPIOS; i++) {
+        g_autofree char *name = g_strdup_printf("%c", 'A' + i);
+        dev = DEVICE(&s->gpio[i]);
+        qdev_prop_set_string(dev, "name", name);
+        qdev_prop_set_uint32(dev, "mode-reset",
+                             stm32l4x5_gpio_cfg[i].moder_reset);
+        qdev_prop_set_uint32(dev, "ospeed-reset",
+                             stm32l4x5_gpio_cfg[i].ospeedr_reset);
+        qdev_prop_set_uint32(dev, "pupd-reset",
+                            stm32l4x5_gpio_cfg[i].pupdr_reset);
+        busdev = SYS_BUS_DEVICE(&s->gpio[i]);
+        g_free(name);
+        name = g_strdup_printf("gpio%c-out", 'a' + i);
+        qdev_connect_clock_in(DEVICE(&s->gpio[i]), "clk",
+            qdev_get_clock_out(DEVICE(&(s->rcc)), name));
+        if (!sysbus_realize(busdev, errp)) {
+            return;
+        }
+        sysbus_mmio_map(busdev, 0, stm32l4x5_gpio_cfg[i].addr);
+    }
+
     /* System configuration controller */
     busdev = SYS_BUS_DEVICE(&s->syscfg);
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
+    for (unsigned i = 0; i < NUM_GPIOS; i++) {
+        for (unsigned j = 0; j < GPIO_NUM_PINS; j++) {
+            pin_index = GPIO_NUM_PINS * i + j;
+            qdev_connect_gpio_out(DEVICE(&s->gpio[i]), j,
+                                  qdev_get_gpio_in(DEVICE(&s->syscfg),
+                                  pin_index));
+        }
+    }
 
     /* EXTI device */
     busdev = SYS_BUS_DEVICE(&s->exti);
@@ -217,7 +266,7 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
         }
     }
 
-    for (unsigned i = 0; i < 16; i++) {
+    for (unsigned i = 0; i < GPIO_NUM_PINS; i++) {
         qdev_connect_gpio_out(DEVICE(&s->syscfg), i,
                               qdev_get_gpio_in(DEVICE(&s->exti), i));
     }
@@ -302,14 +351,6 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
     /* RESERVED:    0x40024400, 0x7FDBC00 */
 
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
index fd68cb800bb..3dafc00b49d 100644
--- a/hw/misc/stm32l4x5_syscfg.c
+++ b/hw/misc/stm32l4x5_syscfg.c
@@ -27,6 +27,7 @@
 #include "hw/irq.h"
 #include "migration/vmstate.h"
 #include "hw/misc/stm32l4x5_syscfg.h"
+#include "hw/gpio/stm32l4x5_gpio.h"
 
 #define SYSCFG_MEMRMP 0x00
 #define SYSCFG_CFGR1 0x04
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index d58d820788c..893a7bff66b 100644
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
 
 config XLNX_ZYNQMP_ARM
     bool
-- 
2.34.1


