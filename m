Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E13CC19F4F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWk-0002UU-KV; Thu, 25 Apr 2024 06:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWc-0002IQ-Vl
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:23 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWa-0007G8-Mn
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:22 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4196c62bb4eso6442475e9.2
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041619; x=1714646419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2nRYCIjCuWG0oRIavpGdg9fYE7VNVQ46mPL/bZDIFQQ=;
 b=d2V7NAsXi87tUaRQiWmoLkr0YQPFWhfLXZJhHsREwnJCHfwehDTT4acbLSyfpz4yPz
 rlIjoaTVcPdLkOi9uy9eh0srJqDxWczKlmOY9ijAx7O+jBjjIfzMl0fgrGj+FqsWvmXF
 deykGltdu7THDZfZYsw1gcK6IVXyYKUozaTkmXq6bNeSHD5AXh4JUiT8erkWbC492KpO
 ELbNuT/64xXXjss0qAAVv9p9zDgNPEz4UcJP/J8YfAWP2cvtDNLcRiLL60m9hrED3FMy
 h/Alx+eb5k7Yq8OrSD9MUg5eleUh3dHIKRcfjfk+vBn75Lj30aGQz+PAI7a/06a+6+CM
 GxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041619; x=1714646419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2nRYCIjCuWG0oRIavpGdg9fYE7VNVQ46mPL/bZDIFQQ=;
 b=dCac7gggQBw/8fyUfUE9st0rL1c3CrYQgjsSUIcG/mMBffYXkxOwsdI472SZYxO9Kl
 rA6Hw+J2cp9glrZTEJ8FktxR03fMeOJryqcbSLPVtcHo1P77qiab41A10RALTRk2moGH
 5BZQBzAFTVN2TXUlxWeX4G/m1OlJvr99y+C2lXzM+w95q+cCVIZ/A4TVFgDdYN7r+YcK
 7Yl5v3PHpWLe18DrzSTOatW37iMnOMoSjohBBAUr+V4VBj6yvk/gJ39+DzkSJDp/nuhv
 C/fI+cVbThitfxc77jeYxIebXkXBPeZb9M+yiv9BEzf3OpnINebZbHVhJdRUycLp9JD8
 y5gg==
X-Gm-Message-State: AOJu0Ywj7zKNNcmSYrhVHh9M54vR523J53qcOHb8S+b2s7BtTfrO9Q5d
 afA2Zg3IkA187x2JIgizooDzVj7SaBBY7oytnMNOkvpKZ6X0sIXpGqfcoqW2n3xUGOminXeh4jZ
 c
X-Google-Smtp-Source: AGHT+IE+SwhApnyakaA2eazsLxxYWqK2bNgxAnKwuAK/hQ9k4GjcnsHhvquobdFOLNpMOuYli3z3Cw==
X-Received: by 2002:a5d:6e5d:0:b0:34b:1f34:9c06 with SMTP id
 j29-20020a5d6e5d000000b0034b1f349c06mr3670361wrz.24.1714041619112; 
 Thu, 25 Apr 2024 03:40:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/37] hw/arm: Add the USART to the stm32l4x5 SoC
Date: Thu, 25 Apr 2024 11:39:57 +0100
Message-Id: <20240425103958.3237225-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Arnaud Minier <arnaud.minier@telecom-paris.fr>

Add the USART to the SoC and connect it to the other implemented devices.

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240329174402.60382-5-arnaud.minier@telecom-paris.fr
[PMM: fixed a few checkpatch nits]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/b-l475e-iot01a.rst |  2 +-
 include/hw/arm/stm32l4x5_soc.h     |  7 +++
 hw/arm/stm32l4x5_soc.c             | 83 +++++++++++++++++++++++++++---
 hw/arm/Kconfig                     |  1 +
 4 files changed, 86 insertions(+), 7 deletions(-)

diff --git a/docs/system/arm/b-l475e-iot01a.rst b/docs/system/arm/b-l475e-iot01a.rst
index 0afef8e4f45..a76c9976c50 100644
--- a/docs/system/arm/b-l475e-iot01a.rst
+++ b/docs/system/arm/b-l475e-iot01a.rst
@@ -19,13 +19,13 @@ Currently B-L475E-IOT01A machine's only supports the following devices:
 - STM32L4x5 SYSCFG (System configuration controller)
 - STM32L4x5 RCC (Reset and clock control)
 - STM32L4x5 GPIOs (General-purpose I/Os)
+- STM32L4x5 USARTs, UARTs and LPUART (Serial ports)
 
 Missing devices
 """""""""""""""
 
 The B-L475E-IOT01A does *not* support the following devices:
 
-- Serial ports (UART)
 - Analog to Digital Converter (ADC)
 - SPI controller
 - Timer controller (TIMER)
diff --git a/include/hw/arm/stm32l4x5_soc.h b/include/hw/arm/stm32l4x5_soc.h
index ee5f3624055..c243fb0e7f9 100644
--- a/include/hw/arm/stm32l4x5_soc.h
+++ b/include/hw/arm/stm32l4x5_soc.h
@@ -31,6 +31,7 @@
 #include "hw/misc/stm32l4x5_exti.h"
 #include "hw/misc/stm32l4x5_rcc.h"
 #include "hw/gpio/stm32l4x5_gpio.h"
+#include "hw/char/stm32l4x5_usart.h"
 #include "qom/object.h"
 
 #define TYPE_STM32L4X5_SOC "stm32l4x5-soc"
@@ -41,6 +42,9 @@ OBJECT_DECLARE_TYPE(Stm32l4x5SocState, Stm32l4x5SocClass, STM32L4X5_SOC)
 
 #define NUM_EXTI_OR_GATES 4
 
+#define STM_NUM_USARTS 3
+#define STM_NUM_UARTS 2
+
 struct Stm32l4x5SocState {
     SysBusDevice parent_obj;
 
@@ -51,6 +55,9 @@ struct Stm32l4x5SocState {
     Stm32l4x5SyscfgState syscfg;
     Stm32l4x5RccState rcc;
     Stm32l4x5GpioState gpio[NUM_GPIOS];
+    Stm32l4x5UsartBaseState usart[STM_NUM_USARTS];
+    Stm32l4x5UsartBaseState uart[STM_NUM_UARTS];
+    Stm32l4x5UsartBaseState lpuart;
 
     MemoryRegion sram1;
     MemoryRegion sram2;
diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
index 40e294f838f..39924822f3d 100644
--- a/hw/arm/stm32l4x5_soc.c
+++ b/hw/arm/stm32l4x5_soc.c
@@ -28,6 +28,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/or-irq.h"
 #include "hw/arm/stm32l4x5_soc.h"
+#include "hw/char/stm32l4x5_usart.h"
 #include "hw/gpio/stm32l4x5_gpio.h"
 #include "hw/qdev-clock.h"
 #include "hw/misc/unimp.h"
@@ -116,6 +117,22 @@ static const struct {
     { 0x48001C00, 0x0000000F, 0x00000000, 0x00000000 },
 };
 
+static const hwaddr usart_addr[] = {
+    0x40013800, /* "USART1", 0x400 */
+    0x40004400, /* "USART2", 0x400 */
+    0x40004800, /* "USART3", 0x400 */
+};
+static const hwaddr uart_addr[] = {
+    0x40004C00, /* "UART4" , 0x400 */
+    0x40005000  /* "UART5" , 0x400 */
+};
+
+#define LPUART_BASE_ADDRESS 0x40008000
+
+static const int usart_irq[] = { 37, 38, 39 };
+static const int uart_irq[] = { 52, 53 };
+#define LPUART_IRQ 70
+
 static void stm32l4x5_soc_initfn(Object *obj)
 {
     Stm32l4x5SocState *s = STM32L4X5_SOC(obj);
@@ -132,6 +149,18 @@ static void stm32l4x5_soc_initfn(Object *obj)
         g_autofree char *name = g_strdup_printf("gpio%c", 'a' + i);
         object_initialize_child(obj, name, &s->gpio[i], TYPE_STM32L4X5_GPIO);
     }
+
+    for (int i = 0; i < STM_NUM_USARTS; i++) {
+        object_initialize_child(obj, "usart[*]", &s->usart[i],
+                                TYPE_STM32L4X5_USART);
+    }
+
+    for (int i = 0; i < STM_NUM_UARTS; i++) {
+        object_initialize_child(obj, "uart[*]", &s->uart[i],
+                                TYPE_STM32L4X5_UART);
+    }
+    object_initialize_child(obj, "lpuart1", &s->lpuart,
+                            TYPE_STM32L4X5_LPUART);
 }
 
 static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
@@ -279,6 +308,54 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
     sysbus_mmio_map(busdev, 0, RCC_BASE_ADDRESS);
     sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, RCC_IRQ));
 
+    /* USART devices */
+    for (int i = 0; i < STM_NUM_USARTS; i++) {
+        g_autofree char *name = g_strdup_printf("usart%d-out", i + 1);
+        dev = DEVICE(&(s->usart[i]));
+        qdev_prop_set_chr(dev, "chardev", serial_hd(i));
+        qdev_connect_clock_in(dev, "clk",
+            qdev_get_clock_out(DEVICE(&(s->rcc)), name));
+        busdev = SYS_BUS_DEVICE(dev);
+        if (!sysbus_realize(busdev, errp)) {
+            return;
+        }
+        sysbus_mmio_map(busdev, 0, usart_addr[i]);
+        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, usart_irq[i]));
+    }
+
+    /*
+     * TODO: Connect the USARTs, UARTs and LPUART to the EXTI once the EXTI
+     * can handle other gpio-in than the gpios. (e.g. Direct Lines for the
+     * usarts)
+     */
+
+    /* UART devices */
+    for (int i = 0; i < STM_NUM_UARTS; i++) {
+        g_autofree char *name = g_strdup_printf("uart%d-out", STM_NUM_USARTS + i + 1);
+        dev = DEVICE(&(s->uart[i]));
+        qdev_prop_set_chr(dev, "chardev", serial_hd(STM_NUM_USARTS + i));
+        qdev_connect_clock_in(dev, "clk",
+            qdev_get_clock_out(DEVICE(&(s->rcc)), name));
+        busdev = SYS_BUS_DEVICE(dev);
+        if (!sysbus_realize(busdev, errp)) {
+            return;
+        }
+        sysbus_mmio_map(busdev, 0, uart_addr[i]);
+        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, uart_irq[i]));
+    }
+
+    /* LPUART device*/
+    dev = DEVICE(&(s->lpuart));
+    qdev_prop_set_chr(dev, "chardev", serial_hd(STM_NUM_USARTS + STM_NUM_UARTS));
+    qdev_connect_clock_in(dev, "clk",
+        qdev_get_clock_out(DEVICE(&(s->rcc)), "lpuart1-out"));
+    busdev = SYS_BUS_DEVICE(dev);
+    if (!sysbus_realize(busdev, errp)) {
+        return;
+    }
+    sysbus_mmio_map(busdev, 0, LPUART_BASE_ADDRESS);
+    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, LPUART_IRQ));
+
     /* APB1 BUS */
     create_unimplemented_device("TIM2",      0x40000000, 0x400);
     create_unimplemented_device("TIM3",      0x40000400, 0x400);
@@ -294,10 +371,6 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("SPI2",      0x40003800, 0x400);
     create_unimplemented_device("SPI3",      0x40003C00, 0x400);
     /* RESERVED:    0x40004000, 0x400 */
-    create_unimplemented_device("USART2",    0x40004400, 0x400);
-    create_unimplemented_device("USART3",    0x40004800, 0x400);
-    create_unimplemented_device("UART4",     0x40004C00, 0x400);
-    create_unimplemented_device("UART5",     0x40005000, 0x400);
     create_unimplemented_device("I2C1",      0x40005400, 0x400);
     create_unimplemented_device("I2C2",      0x40005800, 0x400);
     create_unimplemented_device("I2C3",      0x40005C00, 0x400);
@@ -308,7 +381,6 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("DAC1",      0x40007400, 0x400);
     create_unimplemented_device("OPAMP",     0x40007800, 0x400);
     create_unimplemented_device("LPTIM1",    0x40007C00, 0x400);
-    create_unimplemented_device("LPUART1",   0x40008000, 0x400);
     /* RESERVED:    0x40008400, 0x400 */
     create_unimplemented_device("SWPMI1",    0x40008800, 0x400);
     /* RESERVED:    0x40008C00, 0x800 */
@@ -325,7 +397,6 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("TIM1",      0x40012C00, 0x400);
     create_unimplemented_device("SPI1",      0x40013000, 0x400);
     create_unimplemented_device("TIM8",      0x40013400, 0x400);
-    create_unimplemented_device("USART1",    0x40013800, 0x400);
     /* RESERVED:    0x40013C00, 0x400 */
     create_unimplemented_device("TIM15",     0x40014000, 0x400);
     create_unimplemented_device("TIM16",     0x40014400, 0x400);
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 893a7bff66b..098d0433753 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -477,6 +477,7 @@ config STM32L4X5_SOC
     select STM32L4X5_SYSCFG
     select STM32L4X5_RCC
     select STM32L4X5_GPIO
+    select STM32L4X5_USART
 
 config XLNX_ZYNQMP_ARM
     bool
-- 
2.34.1


