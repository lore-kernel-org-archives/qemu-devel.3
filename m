Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B33C54E58
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 21:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhbyH-0004Ma-Ay; Tue, 05 Mar 2024 16:05:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rhbyF-0004K0-Ry; Tue, 05 Mar 2024 16:05:07 -0500
Received: from zproxy3.enst.fr ([2001:660:330f:2::de])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rhby8-0006f3-Hp; Tue, 05 Mar 2024 16:05:07 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id A65CCA0652;
 Tue,  5 Mar 2024 22:04:56 +0100 (CET)
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id f__H0eawRPGn; Tue,  5 Mar 2024 22:04:55 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 85AF0A0737;
 Tue,  5 Mar 2024 22:04:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy3.enst.fr 85AF0A0737
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1709672695;
 bh=crmHHl9jEb0Orycbp3ScPHNe39Ak64Iu0wNql0JLY5E=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=rn7G1kIpEBoZtPg/CRAYm6fiugL2CyCbIAGP3gGo+myfVr/xcRIbxw2I8AMX6TIir
 FoqHEybA4Yu9/p/WHPCaIKXxdEd7Eb2xdXsNT0dDUUAiMq3/I2uGaWKQD+p5gHKKnj
 svAPHjaSOjEwSfhVyLirgGbMfHU2FVrCEXh2nJ90=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id 99329uZ1eKCk; Tue,  5 Mar 2024 22:04:55 +0100 (CET)
Received: from localhost.localdomain (74.0.125.80.rev.sfr.net [80.125.0.74])
 by zproxy3.enst.fr (Postfix) with ESMTPSA id A8E33A0643;
 Tue,  5 Mar 2024 22:04:54 +0100 (CET)
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
Subject: [PATCH v7 1/3] hw/gpio: Implement STM32L4x5 GPIO
Date: Tue,  5 Mar 2024 22:03:10 +0100
Message-ID: <20240305210444.310665-2-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240305210444.310665-1-ines.varhol@telecom-paris.fr>
References: <20240305210444.310665-1-ines.varhol@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:660:330f:2::de;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy3.enst.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

Features supported :
- the 8 STM32L4x5 GPIOs are initialized with their reset values
    (except IDR, see below)
- input mode : setting a pin in input mode "externally" (using input
    irqs) results in an out irq (transmitted to SYSCFG)
- output mode : setting a bit in ODR sets the corresponding out irq
    (if this line is configured in output mode)
- pull-up, pull-down
- push-pull, open-drain

Difference with the real GPIOs :
- Alternate Function and Analog mode aren't implemented :
    pins in AF/Analog behave like pins in input mode
- floating pins stay at their last value
- register IDR reset values differ from the real one :
    values are coherent with the other registers reset values
    and the fact that AF/Analog modes aren't implemented
- setting I/O output speed isn't supported
- locking port bits isn't supported
- ADC function isn't supported
- GPIOH has 16 pins instead of 2 pins
- writing to registers LCKR, AFRL, AFRH and ASCR is ineffective

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS                        |   1 +
 docs/system/arm/b-l475e-iot01a.rst |   2 +-
 include/hw/gpio/stm32l4x5_gpio.h   |  70 +++++
 hw/gpio/stm32l4x5_gpio.c           | 477 +++++++++++++++++++++++++++++
 hw/gpio/Kconfig                    |   3 +
 hw/gpio/meson.build                |   1 +
 hw/gpio/trace-events               |   6 +
 7 files changed, 559 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/gpio/stm32l4x5_gpio.h
 create mode 100644 hw/gpio/stm32l4x5_gpio.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4183f2f3ab..4d96f855de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1133,6 +1133,7 @@ F: hw/arm/stm32l4x5_soc.c
 F: hw/misc/stm32l4x5_exti.c
 F: hw/misc/stm32l4x5_syscfg.c
 F: hw/misc/stm32l4x5_rcc.c
+F: hw/gpio/stm32l4x5_gpio.c
 F: include/hw/*/stm32l4x5_*.h
=20
 B-L475E-IOT01A IoT Node
diff --git a/docs/system/arm/b-l475e-iot01a.rst b/docs/system/arm/b-l475e=
-iot01a.rst
index b857a56ca4..0afef8e4f4 100644
--- a/docs/system/arm/b-l475e-iot01a.rst
+++ b/docs/system/arm/b-l475e-iot01a.rst
@@ -18,6 +18,7 @@ Currently B-L475E-IOT01A machine's only supports the fo=
llowing devices:
 - STM32L4x5 EXTI (Extended interrupts and events controller)
 - STM32L4x5 SYSCFG (System configuration controller)
 - STM32L4x5 RCC (Reset and clock control)
+- STM32L4x5 GPIOs (General-purpose I/Os)
=20
 Missing devices
 """""""""""""""
@@ -25,7 +26,6 @@ Missing devices
 The B-L475E-IOT01A does *not* support the following devices:
=20
 - Serial ports (UART)
-- General-purpose I/Os (GPIO)
 - Analog to Digital Converter (ADC)
 - SPI controller
 - Timer controller (TIMER)
diff --git a/include/hw/gpio/stm32l4x5_gpio.h b/include/hw/gpio/stm32l4x5=
_gpio.h
new file mode 100644
index 0000000000..0d361f3410
--- /dev/null
+++ b/include/hw/gpio/stm32l4x5_gpio.h
@@ -0,0 +1,70 @@
+/*
+ * STM32L4x5 GPIO (General Purpose Input/Ouput)
+ *
+ * Copyright (c) 2024 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2024 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+/*
+ * The reference used is the STMicroElectronics RM0351 Reference manual
+ * for STM32L4x5 and STM32L4x6 advanced Arm =C2=AE -based 32-bit MCUs.
+ * https://www.st.com/en/microcontrollers-microprocessors/stm32l4x5/docu=
mentation.html
+ */
+
+#ifndef HW_STM32L4X5_GPIO_H
+#define HW_STM32L4X5_GPIO_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_STM32L4X5_GPIO "stm32l4x5-gpio"
+OBJECT_DECLARE_SIMPLE_TYPE(Stm32l4x5GpioState, STM32L4X5_GPIO)
+
+#define GPIO_NUM_PINS 16
+
+struct Stm32l4x5GpioState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+
+    /* GPIO registers */
+    uint32_t moder;
+    uint32_t otyper;
+    uint32_t ospeedr;
+    uint32_t pupdr;
+    uint32_t idr;
+    uint32_t odr;
+    uint32_t lckr;
+    uint32_t afrl;
+    uint32_t afrh;
+    uint32_t ascr;
+
+    /* GPIO registers reset values */
+    uint32_t moder_reset;
+    uint32_t ospeedr_reset;
+    uint32_t pupdr_reset;
+
+    /*
+     * External driving of pins.
+     * The pins can be set externally through the device
+     * anonymous input GPIOs lines under certain conditions.
+     * The pin must not be in push-pull output mode,
+     * and can't be set high in open-drain mode.
+     * Pins driven externally and configured to
+     * output mode will in general be "disconnected"
+     * (see `get_gpio_pinmask_to_disconnect()`)
+     */
+    uint16_t disconnected_pins;
+    uint16_t pins_connected_high;
+
+    char *name;
+    Clock *clk;
+    qemu_irq pin[GPIO_NUM_PINS];
+};
+
+#endif
diff --git a/hw/gpio/stm32l4x5_gpio.c b/hw/gpio/stm32l4x5_gpio.c
new file mode 100644
index 0000000000..63b8763e9d
--- /dev/null
+++ b/hw/gpio/stm32l4x5_gpio.c
@@ -0,0 +1,477 @@
+/*
+ * STM32L4x5 GPIO (General Purpose Input/Ouput)
+ *
+ * Copyright (c) 2024 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2024 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+/*
+ * The reference used is the STMicroElectronics RM0351 Reference manual
+ * for STM32L4x5 and STM32L4x6 advanced Arm =C2=AE -based 32-bit MCUs.
+ * https://www.st.com/en/microcontrollers-microprocessors/stm32l4x5/docu=
mentation.html
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/gpio/stm32l4x5_gpio.h"
+#include "hw/irq.h"
+#include "hw/qdev-clock.h"
+#include "hw/qdev-properties.h"
+#include "qapi/visitor.h"
+#include "qapi/error.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+#define GPIO_MODER 0x00
+#define GPIO_OTYPER 0x04
+#define GPIO_OSPEEDR 0x08
+#define GPIO_PUPDR 0x0C
+#define GPIO_IDR 0x10
+#define GPIO_ODR 0x14
+#define GPIO_BSRR 0x18
+#define GPIO_LCKR 0x1C
+#define GPIO_AFRL 0x20
+#define GPIO_AFRH 0x24
+#define GPIO_BRR 0x28
+#define GPIO_ASCR 0x2C
+
+/* 0b11111111_11111111_00000000_00000000 */
+#define RESERVED_BITS_MASK 0xFFFF0000
+
+static void update_gpio_idr(Stm32l4x5GpioState *s);
+
+static bool is_pull_up(Stm32l4x5GpioState *s, unsigned pin)
+{
+    return extract32(s->pupdr, 2 * pin, 2) =3D=3D 1;
+}
+
+static bool is_pull_down(Stm32l4x5GpioState *s, unsigned pin)
+{
+    return extract32(s->pupdr, 2 * pin, 2) =3D=3D 2;
+}
+
+static bool is_output(Stm32l4x5GpioState *s, unsigned pin)
+{
+    return extract32(s->moder, 2 * pin, 2) =3D=3D 1;
+}
+
+static bool is_open_drain(Stm32l4x5GpioState *s, unsigned pin)
+{
+    return extract32(s->otyper, pin, 1) =3D=3D 1;
+}
+
+static bool is_push_pull(Stm32l4x5GpioState *s, unsigned pin)
+{
+    return extract32(s->otyper, pin, 1) =3D=3D 0;
+}
+
+static void stm32l4x5_gpio_reset_hold(Object *obj)
+{
+    Stm32l4x5GpioState *s =3D STM32L4X5_GPIO(obj);
+
+    s->moder =3D s->moder_reset;
+    s->otyper =3D 0x00000000;
+    s->ospeedr =3D s->ospeedr_reset;
+    s->pupdr =3D s->pupdr_reset;
+    s->idr =3D 0x00000000;
+    s->odr =3D 0x00000000;
+    s->lckr =3D 0x00000000;
+    s->afrl =3D 0x00000000;
+    s->afrh =3D 0x00000000;
+    s->ascr =3D 0x00000000;
+
+    s->disconnected_pins =3D 0xFFFF;
+    s->pins_connected_high =3D 0x0000;
+    update_gpio_idr(s);
+}
+
+static void stm32l4x5_gpio_set(void *opaque, int line, int level)
+{
+    Stm32l4x5GpioState *s =3D opaque;
+    /*
+     * The pin isn't set if line is configured in output mode
+     * except if level is 0 and the output is open-drain.
+     * This way there will be no short-circuit prone situations.
+     */
+    if (is_output(s, line) && !(is_open_drain(s, line) && (level =3D=3D =
0))) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Line %d can't be driven external=
ly\n",
+                      line);
+        return;
+    }
+
+    s->disconnected_pins &=3D ~(1 << line);
+    if (level) {
+        s->pins_connected_high |=3D (1 << line);
+    } else {
+        s->pins_connected_high &=3D ~(1 << line);
+    }
+    trace_stm32l4x5_gpio_pins(s->name, s->disconnected_pins,
+                              s->pins_connected_high);
+    update_gpio_idr(s);
+}
+
+
+static void update_gpio_idr(Stm32l4x5GpioState *s)
+{
+    uint32_t new_idr_mask =3D 0;
+    uint32_t new_idr =3D s->odr;
+    uint32_t old_idr =3D s->idr;
+    int new_pin_state, old_pin_state;
+
+    for (int i =3D 0; i < GPIO_NUM_PINS; i++) {
+        if (is_output(s, i)) {
+            if (is_push_pull(s, i)) {
+                new_idr_mask |=3D (1 << i);
+            } else if (!(s->odr & (1 << i))) {
+                /* open-drain ODR 0 */
+                new_idr_mask |=3D (1 << i);
+            /* open-drain ODR 1 */
+            } else if (!(s->disconnected_pins & (1 << i)) &&
+                       !(s->pins_connected_high & (1 << i))) {
+                /* open-drain ODR 1 with pin connected low */
+                new_idr_mask |=3D (1 << i);
+                new_idr &=3D ~(1 << i);
+            /* open-drain ODR 1 with unactive pin */
+            } else if (is_pull_up(s, i)) {
+                new_idr_mask |=3D (1 << i);
+            } else if (is_pull_down(s, i)) {
+                new_idr_mask |=3D (1 << i);
+                new_idr &=3D ~(1 << i);
+            }
+            /*
+             * The only case left is for open-drain ODR 1
+             * with unactive pin without pull-up or pull-down :
+             * the value is floating.
+             */
+        /* input or analog mode with connected pin */
+        } else if (!(s->disconnected_pins & (1 << i))) {
+            if (s->pins_connected_high & (1 << i)) {
+                /* pin high */
+                new_idr_mask |=3D (1 << i);
+                new_idr |=3D (1 << i);
+            } else {
+                /* pin low */
+                new_idr_mask |=3D (1 << i);
+                new_idr &=3D ~(1 << i);
+            }
+        /* input or analog mode with disconnected pin */
+        } else {
+            if (is_pull_up(s, i)) {
+                /* pull-up */
+                new_idr_mask |=3D (1 << i);
+                new_idr |=3D (1 << i);
+            } else if (is_pull_down(s, i)) {
+                /* pull-down */
+                new_idr_mask |=3D (1 << i);
+                new_idr &=3D ~(1 << i);
+            }
+            /*
+             * The only case left is for a disconnected pin
+             * without pull-up or pull-down :
+             * the value is floating.
+             */
+        }
+    }
+
+    s->idr =3D (old_idr & ~new_idr_mask) | (new_idr & new_idr_mask);
+    trace_stm32l4x5_gpio_update_idr(s->name, old_idr, s->idr);
+
+    for (int i =3D 0; i < GPIO_NUM_PINS; i++) {
+        if (new_idr_mask & (1 << i)) {
+            new_pin_state =3D (new_idr & (1 << i)) > 0;
+            old_pin_state =3D (old_idr & (1 << i)) > 0;
+            if (new_pin_state > old_pin_state) {
+                qemu_irq_raise(s->pin[i]);
+            } else if (new_pin_state < old_pin_state) {
+                qemu_irq_lower(s->pin[i]);
+            }
+        }
+    }
+}
+
+/*
+ * Return mask of pins that are both configured in output
+ * mode and externally driven (except pins in open-drain
+ * mode externally set to 0).
+ */
+static uint32_t get_gpio_pinmask_to_disconnect(Stm32l4x5GpioState *s)
+{
+    uint32_t pins_to_disconnect =3D 0;
+    for (int i =3D 0; i < GPIO_NUM_PINS; i++) {
+        /* for each connected pin in output mode */
+        if (!(s->disconnected_pins & (1 << i)) && is_output(s, i)) {
+            /* if either push-pull or high level */
+            if (is_push_pull(s, i) || s->pins_connected_high & (1 << i))=
 {
+                pins_to_disconnect |=3D (1 << i);
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "Line %d can't be driven externally\n",
+                              i);
+            }
+        }
+    }
+    return pins_to_disconnect;
+}
+
+/*
+ * Set field `disconnected_pins` and call `update_gpio_idr()`
+ */
+static void disconnect_gpio_pins(Stm32l4x5GpioState *s, uint16_t lines)
+{
+    s->disconnected_pins |=3D lines;
+    trace_stm32l4x5_gpio_pins(s->name, s->disconnected_pins,
+                              s->pins_connected_high);
+    update_gpio_idr(s);
+}
+
+static void disconnected_pins_set(Object *obj, Visitor *v,
+    const char *name, void *opaque, Error **errp)
+{
+    Stm32l4x5GpioState *s =3D STM32L4X5_GPIO(obj);
+    uint16_t value;
+    if (!visit_type_uint16(v, name, &value, errp)) {
+        return;
+    }
+    disconnect_gpio_pins(s, value);
+}
+
+static void disconnected_pins_get(Object *obj, Visitor *v,
+    const char *name, void *opaque, Error **errp)
+{
+    visit_type_uint16(v, name, (uint16_t *)opaque, errp);
+}
+
+static void clock_freq_get(Object *obj, Visitor *v,
+    const char *name, void *opaque, Error **errp)
+{
+    Stm32l4x5GpioState *s =3D STM32L4X5_GPIO(obj);
+    uint32_t clock_freq_hz =3D clock_get_hz(s->clk);
+    visit_type_uint32(v, name, &clock_freq_hz, errp);
+}
+
+static void stm32l4x5_gpio_write(void *opaque, hwaddr addr,
+                                 uint64_t val64, unsigned int size)
+{
+    Stm32l4x5GpioState *s =3D opaque;
+
+    uint32_t value =3D val64;
+    trace_stm32l4x5_gpio_write(s->name, addr, val64);
+
+    switch (addr) {
+    case GPIO_MODER:
+        s->moder =3D value;
+        disconnect_gpio_pins(s, get_gpio_pinmask_to_disconnect(s));
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Analog and AF modes aren't supported\n\
+                       Analog and AF mode behave like input mode\n",
+                      __func__);
+        return;
+    case GPIO_OTYPER:
+        s->otyper =3D value & ~RESERVED_BITS_MASK;
+        disconnect_gpio_pins(s, get_gpio_pinmask_to_disconnect(s));
+        return;
+    case GPIO_OSPEEDR:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Changing I/O output speed isn't supported\n\
+                       I/O speed is already maximal\n",
+                      __func__);
+        s->ospeedr =3D value;
+        return;
+    case GPIO_PUPDR:
+        s->pupdr =3D value;
+        update_gpio_idr(s);
+        return;
+    case GPIO_IDR:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: GPIO->IDR is read-only\n",
+                      __func__);
+        return;
+    case GPIO_ODR:
+        s->odr =3D value & ~RESERVED_BITS_MASK;
+        update_gpio_idr(s);
+        return;
+    case GPIO_BSRR: {
+        uint32_t bits_to_reset =3D (value & RESERVED_BITS_MASK) >> GPIO_=
NUM_PINS;
+        uint32_t bits_to_set =3D value & ~RESERVED_BITS_MASK;
+        /* If both BSx and BRx are set, BSx has priority.*/
+        s->odr &=3D ~bits_to_reset;
+        s->odr |=3D bits_to_set;
+        update_gpio_idr(s);
+        return;
+    }
+    case GPIO_LCKR:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Locking port bits configuration isn't support=
ed\n",
+                      __func__);
+        s->lckr =3D value & ~RESERVED_BITS_MASK;
+        return;
+    case GPIO_AFRL:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Alternate functions aren't supported\n",
+                      __func__);
+        s->afrl =3D value;
+        return;
+    case GPIO_AFRH:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Alternate functions aren't supported\n",
+                      __func__);
+        s->afrh =3D value;
+        return;
+    case GPIO_BRR: {
+        uint32_t bits_to_reset =3D value & ~RESERVED_BITS_MASK;
+        s->odr &=3D ~bits_to_reset;
+        update_gpio_idr(s);
+        return;
+    }
+    case GPIO_ASCR:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: ADC function isn't supported\n",
+                      __func__);
+        s->ascr =3D value & ~RESERVED_BITS_MASK;
+        return;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset 0x%" HWADDR_PRIx "\n", __func__, a=
ddr);
+    }
+}
+
+static uint64_t stm32l4x5_gpio_read(void *opaque, hwaddr addr,
+                                    unsigned int size)
+{
+    Stm32l4x5GpioState *s =3D opaque;
+
+    trace_stm32l4x5_gpio_read(s->name, addr);
+
+    switch (addr) {
+    case GPIO_MODER:
+        return s->moder;
+    case GPIO_OTYPER:
+        return s->otyper;
+    case GPIO_OSPEEDR:
+        return s->ospeedr;
+    case GPIO_PUPDR:
+        return s->pupdr;
+    case GPIO_IDR:
+        return s->idr;
+    case GPIO_ODR:
+        return s->odr;
+    case GPIO_BSRR:
+        return 0;
+    case GPIO_LCKR:
+        return s->lckr;
+    case GPIO_AFRL:
+        return s->afrl;
+    case GPIO_AFRH:
+        return s->afrh;
+    case GPIO_BRR:
+        return 0;
+    case GPIO_ASCR:
+        return s->ascr;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset 0x%" HWADDR_PRIx "\n", __func__, a=
ddr);
+        return 0;
+    }
+}
+
+static const MemoryRegionOps stm32l4x5_gpio_ops =3D {
+    .read =3D stm32l4x5_gpio_read,
+    .write =3D stm32l4x5_gpio_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .impl =3D {
+        .min_access_size =3D 4,
+        .max_access_size =3D 4,
+        .unaligned =3D false,
+    },
+    .valid =3D {
+        .min_access_size =3D 4,
+        .max_access_size =3D 4,
+        .unaligned =3D false,
+    },
+};
+
+static void stm32l4x5_gpio_init(Object *obj)
+{
+    Stm32l4x5GpioState *s =3D STM32L4X5_GPIO(obj);
+
+    memory_region_init_io(&s->mmio, obj, &stm32l4x5_gpio_ops, s,
+                          TYPE_STM32L4X5_GPIO, 0x400);
+
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+
+    qdev_init_gpio_out(DEVICE(obj), s->pin, GPIO_NUM_PINS);
+    qdev_init_gpio_in(DEVICE(obj), stm32l4x5_gpio_set, GPIO_NUM_PINS);
+
+    s->clk =3D qdev_init_clock_in(DEVICE(s), "clk", NULL, s, 0);
+
+    object_property_add(obj, "disconnected-pins", "uint16",
+                        disconnected_pins_get, disconnected_pins_set,
+                        NULL, &s->disconnected_pins);
+    object_property_add(obj, "clock-freq-hz", "uint32",
+                        clock_freq_get, NULL, NULL, NULL);
+}
+
+static void stm32l4x5_gpio_realize(DeviceState *dev, Error **errp)
+{
+    Stm32l4x5GpioState *s =3D STM32L4X5_GPIO(dev);
+    if (!clock_has_source(s->clk)) {
+        error_setg(errp, "GPIO: clk input must be connected");
+        return;
+    }
+}
+
+static const VMStateDescription vmstate_stm32l4x5_gpio =3D {
+    .name =3D TYPE_STM32L4X5_GPIO,
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]){
+        VMSTATE_UINT32(moder, Stm32l4x5GpioState),
+        VMSTATE_UINT32(otyper, Stm32l4x5GpioState),
+        VMSTATE_UINT32(ospeedr, Stm32l4x5GpioState),
+        VMSTATE_UINT32(pupdr, Stm32l4x5GpioState),
+        VMSTATE_UINT32(idr, Stm32l4x5GpioState),
+        VMSTATE_UINT32(odr, Stm32l4x5GpioState),
+        VMSTATE_UINT32(lckr, Stm32l4x5GpioState),
+        VMSTATE_UINT32(afrl, Stm32l4x5GpioState),
+        VMSTATE_UINT32(afrh, Stm32l4x5GpioState),
+        VMSTATE_UINT32(ascr, Stm32l4x5GpioState),
+        VMSTATE_UINT16(disconnected_pins, Stm32l4x5GpioState),
+        VMSTATE_UINT16(pins_connected_high, Stm32l4x5GpioState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property stm32l4x5_gpio_properties[] =3D {
+    DEFINE_PROP_STRING("name", Stm32l4x5GpioState, name),
+    DEFINE_PROP_UINT32("mode-reset", Stm32l4x5GpioState, moder_reset, 0)=
,
+    DEFINE_PROP_UINT32("ospeed-reset", Stm32l4x5GpioState, ospeedr_reset=
, 0),
+    DEFINE_PROP_UINT32("pupd-reset", Stm32l4x5GpioState, pupdr_reset, 0)=
,
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void stm32l4x5_gpio_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
+
+    device_class_set_props(dc, stm32l4x5_gpio_properties);
+    dc->vmsd =3D &vmstate_stm32l4x5_gpio;
+    dc->realize =3D stm32l4x5_gpio_realize;
+    rc->phases.hold =3D stm32l4x5_gpio_reset_hold;
+}
+
+static const TypeInfo stm32l4x5_gpio_types[] =3D {
+    {
+        .name =3D TYPE_STM32L4X5_GPIO,
+        .parent =3D TYPE_SYS_BUS_DEVICE,
+        .instance_size =3D sizeof(Stm32l4x5GpioState),
+        .instance_init =3D stm32l4x5_gpio_init,
+        .class_init =3D stm32l4x5_gpio_class_init,
+    },
+};
+
+DEFINE_TYPES(stm32l4x5_gpio_types)
diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index d2cf3accc8..712940b8e0 100644
--- a/hw/gpio/Kconfig
+++ b/hw/gpio/Kconfig
@@ -16,3 +16,6 @@ config GPIO_PWR
=20
 config SIFIVE_GPIO
     bool
+
+config STM32L4X5_GPIO
+    bool
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index 8a8d03d885..3454b503ae 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -13,5 +13,6 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
     'bcm2835_gpio.c',
     'bcm2838_gpio.c'
 ))
+system_ss.add(when: 'CONFIG_STM32L4X5_SOC', if_true: files('stm32l4x5_gp=
io.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c')=
)
 system_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio.c'=
))
diff --git a/hw/gpio/trace-events b/hw/gpio/trace-events
index 9736b362ac..9331f4289d 100644
--- a/hw/gpio/trace-events
+++ b/hw/gpio/trace-events
@@ -31,3 +31,9 @@ sifive_gpio_update_output_irq(int64_t line, int64_t val=
ue) "line %" PRIi64 " val
 # aspeed_gpio.c
 aspeed_gpio_read(uint64_t offset, uint64_t value) "offset: 0x%" PRIx64 "=
 value 0x%" PRIx64
 aspeed_gpio_write(uint64_t offset, uint64_t value) "offset: 0x%" PRIx64 =
" value 0x%" PRIx64
+
+# stm32l4x5_gpio.c
+stm32l4x5_gpio_read(char *gpio, uint64_t addr) "GPIO%s addr: 0x%" PRIx64=
 " "
+stm32l4x5_gpio_write(char *gpio, uint64_t addr, uint64_t data) "GPIO%s a=
ddr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
+stm32l4x5_gpio_update_idr(char *gpio, uint32_t old_idr, uint32_t new_idr=
) "GPIO%s from: 0x%x to: 0x%x"
+stm32l4x5_gpio_pins(char *gpio, uint16_t disconnected, uint16_t high) "G=
PIO%s disconnected pins: 0x%x levels: 0x%x"
--=20
2.43.2


