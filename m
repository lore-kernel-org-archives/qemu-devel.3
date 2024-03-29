Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1386DCD1283
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 17:45:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqGIM-0007bU-1j; Fri, 29 Mar 2024 13:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnaud.minier@telecom-paris.fr>)
 id 1rqGIK-0007af-OD; Fri, 29 Mar 2024 13:45:36 -0400
Received: from zproxy4.enst.fr ([2001:660:330f:2::df])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnaud.minier@telecom-paris.fr>)
 id 1rqGIH-0007rb-Qd; Fri, 29 Mar 2024 13:45:35 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id 773FA207B8;
 Fri, 29 Mar 2024 18:45:31 +0100 (CET)
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id uBucKEy-IHeX; Fri, 29 Mar 2024 18:45:30 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id A794620733;
 Fri, 29 Mar 2024 18:45:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy4.enst.fr A794620733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1711734330;
 bh=A69w4We6ob59fjy5QMmlyTnF7BS5WmmxKXyf9k3sCkE=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=TU+t2/rnb7zRElptaTYVxo/ANlXLivjpj/041LhBicKzVnAHHMHnq/PJCjAmvuaf/
 F7XuZuFs3DrT4Ggczo2LN5tUFR+GvN+fNWp8PGTd67PrLVWw2wKvtmUXsUzX/Tx6TT
 QQ618RsCclg0qZ91/6+v5vUOlGhFEUQO+v8BfT2Q=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id JDkrEJzqDL3F; Fri, 29 Mar 2024 18:45:30 +0100 (CET)
Received: from AM-Inspiron-3585.. (unknown [78.209.135.136])
 by zproxy4.enst.fr (Postfix) with ESMTPSA id 69EB3207B2;
 Fri, 29 Mar 2024 18:45:29 +0100 (CET)
From: Arnaud Minier <arnaud.minier@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Laurent Vivier <lvivier@redhat.com>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 4/5] hw/arm: Add the USART to the stm32l4x5 SoC
Date: Fri, 29 Mar 2024 18:44:01 +0100
Message-Id: <20240329174402.60382-5-arnaud.minier@telecom-paris.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329174402.60382-1-arnaud.minier@telecom-paris.fr>
References: <20240329174402.60382-1-arnaud.minier@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:660:330f:2::df;
 envelope-from=arnaud.minier@telecom-paris.fr; helo=zproxy4.enst.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

Add the USART to the SoC and connect it to the other implemented devices.

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/b-l475e-iot01a.rst |  2 +-
 hw/arm/Kconfig                     |  1 +
 hw/arm/stm32l4x5_soc.c             | 82 +++++++++++++++++++++++++++---
 include/hw/arm/stm32l4x5_soc.h     |  7 +++
 4 files changed, 85 insertions(+), 7 deletions(-)

diff --git a/docs/system/arm/b-l475e-iot01a.rst b/docs/system/arm/b-l475e=
-iot01a.rst
index 0afef8e4f4..a76c9976c5 100644
--- a/docs/system/arm/b-l475e-iot01a.rst
+++ b/docs/system/arm/b-l475e-iot01a.rst
@@ -19,13 +19,13 @@ Currently B-L475E-IOT01A machine's only supports the =
following devices:
 - STM32L4x5 SYSCFG (System configuration controller)
 - STM32L4x5 RCC (Reset and clock control)
 - STM32L4x5 GPIOs (General-purpose I/Os)
+- STM32L4x5 USARTs, UARTs and LPUART (Serial ports)
=20
 Missing devices
 """""""""""""""
=20
 The B-L475E-IOT01A does *not* support the following devices:
=20
-- Serial ports (UART)
 - Analog to Digital Converter (ADC)
 - SPI controller
 - Timer controller (TIMER)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 893a7bff66..098d043375 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -477,6 +477,7 @@ config STM32L4X5_SOC
     select STM32L4X5_SYSCFG
     select STM32L4X5_RCC
     select STM32L4X5_GPIO
+    select STM32L4X5_USART
=20
 config XLNX_ZYNQMP_ARM
     bool
diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
index 40e294f838..8fc369fff0 100644
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
=20
+static const hwaddr usart_addr[] =3D {
+    0x40013800, /* "USART1", 0x400 */
+    0x40004400, /* "USART2", 0x400 */
+    0x40004800, /* "USART3", 0x400 */
+};
+static const hwaddr uart_addr[] =3D {
+    0x40004C00, /* "UART4" , 0x400 */
+    0x40005000  /* "UART5" , 0x400 */
+};
+
+#define LPUART_BASE_ADDRESS 0x40008000
+
+static const int usart_irq[] =3D { 37, 38, 39 };
+static const int uart_irq[] =3D { 52, 53 };
+#define LPUART_IRQ 70
+
 static void stm32l4x5_soc_initfn(Object *obj)
 {
     Stm32l4x5SocState *s =3D STM32L4X5_SOC(obj);
@@ -132,6 +149,18 @@ static void stm32l4x5_soc_initfn(Object *obj)
         g_autofree char *name =3D g_strdup_printf("gpio%c", 'a' + i);
         object_initialize_child(obj, name, &s->gpio[i], TYPE_STM32L4X5_G=
PIO);
     }
+   =20
+    for (int i =3D 0; i < STM_NUM_USARTS; i++) {
+        object_initialize_child(obj, "usart[*]", &s->usart[i],
+                                TYPE_STM32L4X5_USART);
+    }
+
+    for (int i =3D 0; i < STM_NUM_UARTS; i++) {
+        object_initialize_child(obj, "uart[*]", &s->uart[i],
+                                TYPE_STM32L4X5_UART);
+    }
+    object_initialize_child(obj, "lpuart1", &s->lpuart,
+                            TYPE_STM32L4X5_LPUART);
 }
=20
 static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
@@ -279,6 +308,53 @@ static void stm32l4x5_soc_realize(DeviceState *dev_s=
oc, Error **errp)
     sysbus_mmio_map(busdev, 0, RCC_BASE_ADDRESS);
     sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, RCC_IRQ));
=20
+    /* USART devices */
+    for (int i =3D 0; i < STM_NUM_USARTS; i++) {
+        g_autofree char *name =3D g_strdup_printf("usart%d-out", i + 1);
+        dev =3D DEVICE(&(s->usart[i]));
+        qdev_prop_set_chr(dev, "chardev", serial_hd(i));
+        qdev_connect_clock_in(dev, "clk",
+            qdev_get_clock_out(DEVICE(&(s->rcc)), name));
+        busdev =3D SYS_BUS_DEVICE(dev);
+        if (!sysbus_realize(busdev, errp)) {
+            return;
+        }
+        sysbus_mmio_map(busdev, 0, usart_addr[i]);
+        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, usart_irq=
[i]));
+    }
+
+    /*
+     * TODO: Connect the USARTs, UARTs and LPUART to the EXTI once the E=
XTI
+     * can handle other gpio-in than the gpios. (e.g. Direct Lines for t=
he usarts)
+     */
+
+    /* UART devices */
+    for (int i =3D 0; i < STM_NUM_UARTS; i++) {
+        g_autofree char *name =3D g_strdup_printf("uart%d-out", STM_NUM_=
USARTS + i + 1);
+        dev =3D DEVICE(&(s->uart[i]));
+        qdev_prop_set_chr(dev, "chardev", serial_hd(STM_NUM_USARTS + i))=
;
+        qdev_connect_clock_in(dev, "clk",
+            qdev_get_clock_out(DEVICE(&(s->rcc)), name));
+        busdev =3D SYS_BUS_DEVICE(dev);
+        if (!sysbus_realize(busdev, errp)) {
+            return;
+        }
+        sysbus_mmio_map(busdev, 0, uart_addr[i]);
+        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, uart_irq[=
i]));
+    }
+
+    /* LPUART device*/
+    dev =3D DEVICE(&(s->lpuart));
+    qdev_prop_set_chr(dev, "chardev", serial_hd(STM_NUM_USARTS + STM_NUM=
_UARTS));
+    qdev_connect_clock_in(dev, "clk",
+        qdev_get_clock_out(DEVICE(&(s->rcc)), "lpuart1-out"));
+    busdev =3D SYS_BUS_DEVICE(dev);
+    if (!sysbus_realize(busdev, errp)) {
+        return;
+    }
+    sysbus_mmio_map(busdev, 0, LPUART_BASE_ADDRESS);
+    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, LPUART_IRQ));
+
     /* APB1 BUS */
     create_unimplemented_device("TIM2",      0x40000000, 0x400);
     create_unimplemented_device("TIM3",      0x40000400, 0x400);
@@ -294,10 +370,6 @@ static void stm32l4x5_soc_realize(DeviceState *dev_s=
oc, Error **errp)
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
@@ -308,7 +380,6 @@ static void stm32l4x5_soc_realize(DeviceState *dev_so=
c, Error **errp)
     create_unimplemented_device("DAC1",      0x40007400, 0x400);
     create_unimplemented_device("OPAMP",     0x40007800, 0x400);
     create_unimplemented_device("LPTIM1",    0x40007C00, 0x400);
-    create_unimplemented_device("LPUART1",   0x40008000, 0x400);
     /* RESERVED:    0x40008400, 0x400 */
     create_unimplemented_device("SWPMI1",    0x40008800, 0x400);
     /* RESERVED:    0x40008C00, 0x800 */
@@ -325,7 +396,6 @@ static void stm32l4x5_soc_realize(DeviceState *dev_so=
c, Error **errp)
     create_unimplemented_device("TIM1",      0x40012C00, 0x400);
     create_unimplemented_device("SPI1",      0x40013000, 0x400);
     create_unimplemented_device("TIM8",      0x40013400, 0x400);
-    create_unimplemented_device("USART1",    0x40013800, 0x400);
     /* RESERVED:    0x40013C00, 0x400 */
     create_unimplemented_device("TIM15",     0x40014000, 0x400);
     create_unimplemented_device("TIM16",     0x40014400, 0x400);
diff --git a/include/hw/arm/stm32l4x5_soc.h b/include/hw/arm/stm32l4x5_so=
c.h
index ee5f362405..c243fb0e7f 100644
--- a/include/hw/arm/stm32l4x5_soc.h
+++ b/include/hw/arm/stm32l4x5_soc.h
@@ -31,6 +31,7 @@
 #include "hw/misc/stm32l4x5_exti.h"
 #include "hw/misc/stm32l4x5_rcc.h"
 #include "hw/gpio/stm32l4x5_gpio.h"
+#include "hw/char/stm32l4x5_usart.h"
 #include "qom/object.h"
=20
 #define TYPE_STM32L4X5_SOC "stm32l4x5-soc"
@@ -41,6 +42,9 @@ OBJECT_DECLARE_TYPE(Stm32l4x5SocState, Stm32l4x5SocClas=
s, STM32L4X5_SOC)
=20
 #define NUM_EXTI_OR_GATES 4
=20
+#define STM_NUM_USARTS 3
+#define STM_NUM_UARTS 2
+
 struct Stm32l4x5SocState {
     SysBusDevice parent_obj;
=20
@@ -51,6 +55,9 @@ struct Stm32l4x5SocState {
     Stm32l4x5SyscfgState syscfg;
     Stm32l4x5RccState rcc;
     Stm32l4x5GpioState gpio[NUM_GPIOS];
+    Stm32l4x5UsartBaseState usart[STM_NUM_USARTS];
+    Stm32l4x5UsartBaseState uart[STM_NUM_UARTS];
+    Stm32l4x5UsartBaseState lpuart;
=20
     MemoryRegion sram1;
     MemoryRegion sram2;
--=20
2.34.1


