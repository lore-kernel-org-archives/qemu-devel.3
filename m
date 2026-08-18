Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67028C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 22:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwRvx-0007yE-6x; Tue, 18 Aug 2026 18:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinja.p.jankovic@gmail.com>)
 id 1wwRvv-0007xP-Nr
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 18:05:23 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinja.p.jankovic@gmail.com>)
 id 1wwRvs-0001QU-6B
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 18:05:23 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5b021916bd3so525228e87.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 15:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787090718; x=1787695518; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oNnj2fLEMYq5Tz8EcYB6SXjMYDv/P85S0ugsV5A0eZ8=;
 b=nVL2zYt2XWth/4oi5NHEmllq1gsk9PLMb3Qe/HoOZ4OhbkmNLs+PTJfHKYm5lcQchs
 UJgwa19hHpO4YSITPdI0+UpvxPbJR9mVhsJeW6L0MDERROt8ZwqOx27Iy9+wj5HzgPIz
 RhCPM0i6L5zEyElDFhRdiNVho1MIO05NEYauJfuJWykHhYcy3+wcO2vtCL9UGRCIVPEt
 Cr6ldVGFgzEjKmsEGaswzigcjt1LHHTRNTrDcHvqISOTA49/1gLAcl01MkjWsdr2uITF
 QFl2CdPwjteJ6kW5xvQf3C5A3+p8oE3Ncz/7TPQR6OGHqevL8IcVv1RGZ6L476rursOG
 8CHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787090718; x=1787695518;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oNnj2fLEMYq5Tz8EcYB6SXjMYDv/P85S0ugsV5A0eZ8=;
 b=izt6BodUqdO2P2oegQrS68ZPanl4Lpz+SGdm0o/pX7rlNhPUY2sHb279cj+vta0ntT
 qs2lNPzot65wzh6BbIwQceyTaxXVN0j1X+jL0AKe45SNnBWEH8LqVo74fWKJVvceoKWI
 o+6LAPPzMem7/JVXcZxeUNwVAGphoCAuEsSO5wuszsQ5eZ/6VXB2QL7hCXSwzkholPk+
 bLXq4tbiziWfEIXd0wrWaJGP62gvsipXEXK//HrbDY2JEH1Glwjc95O4utP8LSk1yqBZ
 vHJWqCutV51EXnOnldIvxoW4Cn645BeeKxsvQH4kJwjl22XRJ5xR+0C/VAmvhxBbJEVv
 qnJA==
X-Gm-Message-State: AOJu0Yy1ioFsHbkDeoGL85qgYhzcvkgiewAz+XgJAMH6fedWKikfF0W/
 p8A6jdDugoTvnX0D8VgqZZS8Pgn0V34QapHpQhTGnl8AnlfgffFWHYn3FOHue2AC
X-Gm-Gg: AR+sD11NgkH4TS1+pGOzN0YIm4uhX3js1YDNrxKdKLemIY7NXYw3aB7XaHsUE6DrltG
 0ZmvQeA0W9VZp7SbJgODb52Hzrt9ixJ+KA/5UdcVjGye+NvKAO5AKzpUfWaHa109KLLhMwZTfYi
 Pf/esuObu4sSLFN+uemSp7VeYPbJyd7zPJiH4LvQ11GPKNEkVSPHnsJPdBxBqjJ2l9l/IPHEISe
 8HdAZbmweKXTflMFMfvOBz7SiKFhu5lEX59cyjAGAqSfnwhfyXYQDP+zFf/RMKWIP1a3Hpek5ym
 DqcBZecVI4/dMmyzbrbjvZ5VUzQFgajiYyg2y15WF02Km97FIXf56dXxcdibiiTh7qrJCCKn71F
 5fLFOzoJoFsL/VG379ZWzYcd1qnOLUSS7pP2Hw64bV6dVJSh3exHeYBZhTuo46dMCDj7icURe0Q
 dhyLHtI5BlGTaaTXrLMotOG8fAYOiJBYydettoxYRvOxCWaTmOH9WZEJHrvx+Cf00CwByH4NVcW
 GIzLm5mGGpD4YuPLUzXJFi0D2VnVGmKnRQE3gNJFI/1yDXRiycXvE6uy6E=
X-Received: by 2002:a05:6512:3c92:b0:5b4:57a9:7030 with SMTP id
 2adb3069b0e04-5b478bce05bmr9159e87.22.1787090718005; 
 Tue, 18 Aug 2026 15:05:18 -0700 (PDT)
Received: from [192.168.31.141] (213-65-111-204-no600.tbcn.telia.com.
 [213.65.111.204]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b478853ae5sm21836e87.17.2026.08.18.15.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 15:05:16 -0700 (PDT)
From: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Date: Wed, 19 Aug 2026 00:04:51 +0200
Subject: [PATCH 1/3] hw/gpio: Allwinner A10 GPIO emulation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-allwinner-gpio-v1-1-2a64866dff11@gmail.com>
References: <20260819-allwinner-gpio-v1-0-2a64866dff11@gmail.com>
In-Reply-To: <20260819-allwinner-gpio-v1-0-2a64866dff11@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=strahinja.p.jankovic@gmail.com; helo=mail-lf1-x132.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch implements Allwinner A10 GPIO peripheral emulation.

The emulation focuses on input/output and interrupt functionality,
whereas the drive and pull up/down functionality is not emulated.

Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
---
 MAINTAINERS                           |   2 +
 hw/gpio/Kconfig                       |   3 +
 hw/gpio/allwinner-gpio.c              | 465 ++++++++++++++++++++++++++++++++++
 hw/gpio/meson.build                   |   1 +
 hw/gpio/trace-events                  |   6 +
 include/hw/gpio/allwinner-gpio-regs.h | 228 +++++++++++++++++
 include/hw/gpio/allwinner-gpio.h      |  41 +++
 7 files changed, 746 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b51f5c3e60..6cefdde70b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -743,6 +743,8 @@ F: include/hw/*/allwinner*
 F: hw/arm/cubieboard.c
 F: docs/system/arm/cubieboard.rst
 F: hw/misc/axp2xx.c
+F: hw/gpio/allwinner-gpio.c
+F: include/hw/gpio/allwinner-gpio*
 F: tests/functional/arm/test_cubieboard.py
 
 Allwinner-h3
diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index fcc7c70bd5..ea0fb72b40 100644
--- a/hw/gpio/Kconfig
+++ b/hw/gpio/Kconfig
@@ -33,3 +33,6 @@ config ZAURUS_SCOOP
 
 config CADENCE_GPIO
     bool
+
+config ALLWINNER_GPIO
+    bool
diff --git a/hw/gpio/allwinner-gpio.c b/hw/gpio/allwinner-gpio.c
new file mode 100644
index 0000000000..fb0f3f7ca1
--- /dev/null
+++ b/hw/gpio/allwinner-gpio.c
@@ -0,0 +1,465 @@
+/*
+ *  Allwinner GPIO Emulation
+ *
+ *  Copyright (C) 2026 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/gpio/allwinner-gpio.h"
+#include "hw/gpio/allwinner-gpio-regs.h"
+#include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "trace.h"
+
+#define REG_INDEX(offset)         (offset / sizeof(uint32_t))
+
+#define AW_GPIO_SET(port) \
+    static inline void allwinner_gpio_set_##port(void *opaque, \
+                                                 int line, \
+                                                 int level) { \
+        allwinner_gpio_set(opaque, port, line, level); \
+    }
+
+static void allwinner_gpio_set(void *opaque, int port, int line, int level);
+
+AW_GPIO_SET(GPIO_PA);
+AW_GPIO_SET(GPIO_PB);
+AW_GPIO_SET(GPIO_PC);
+AW_GPIO_SET(GPIO_PD);
+AW_GPIO_SET(GPIO_PE);
+AW_GPIO_SET(GPIO_PF);
+AW_GPIO_SET(GPIO_PG);
+AW_GPIO_SET(GPIO_PH);
+AW_GPIO_SET(GPIO_PI);
+
+static void (*AW_GPIO_IN_HANDLER[AW_GPIO_PORTS_NUM]) (void *opaque,
+                                                      int line,
+                                                      int level) = {
+    allwinner_gpio_set_GPIO_PA,
+    allwinner_gpio_set_GPIO_PB,
+    allwinner_gpio_set_GPIO_PC,
+    allwinner_gpio_set_GPIO_PD,
+    allwinner_gpio_set_GPIO_PE,
+    allwinner_gpio_set_GPIO_PF,
+    allwinner_gpio_set_GPIO_PG,
+    allwinner_gpio_set_GPIO_PH,
+    allwinner_gpio_set_GPIO_PI,
+};
+
+static char *allwinner_gpio_get_regname(unsigned offset)
+{
+    switch (offset) {
+    case 0 ... GPIO_Pn_PUL1(GPIO_PI):
+    {
+        const char *regname = "?";
+        switch (offset % PORT_STRIDE) {
+        case CFG0:
+            regname = "CFG0";
+            break;
+        case CFG1:
+            regname = "CFG1";
+            break;
+        case CFG2:
+            regname = "CFG2";
+            break;
+        case CFG3:
+            regname = "CFG3";
+            break;
+        case DAT:
+            regname = "DAT";
+            break;
+        case DRV0:
+            regname = "DRV0";
+            break;
+        case DRV1:
+            regname = "DRV1";
+            break;
+        case PUL0:
+            regname = "PUL0";
+            break;
+        case PUL1:
+            regname = "PUL1";
+            break;
+        }
+        return g_strdup_printf("%s:%s",
+                               portname(offset / PORT_STRIDE),
+                               regname);
+    }
+    case GPIO_INT_CFG0:
+        return g_strdup("INT_CFG0");
+    case GPIO_INT_CFG1:
+        return g_strdup("INT_CFG1");
+    case GPIO_INT_CFG2:
+        return g_strdup("INT_CFG2");
+    case GPIO_INT_CFG3:
+        return g_strdup("INT_CFG3");
+    case GPIO_INT_CTL:
+        return g_strdup("INT_CTL");
+    case GPIO_INT_STA:
+        return g_strdup("INT_STA");
+    case GPIO_INT_DEB:
+        return g_strdup("INT_DEB");
+    default:
+        return g_strdup("[?]");
+    }
+}
+
+static bool gpio_is_input(AWPortMap *port, uint32_t pin);
+static int int_ctl_cfg(AWGPIOState *s, int irq_line);
+
+static inline void allwinner_gpio_update_int(AWGPIOState *s)
+{
+    qemu_set_irq(
+        s->irq,
+        !!(s->regs[REG_INDEX(GPIO_INT_CTL)] & s->regs[REG_INDEX(GPIO_INT_STA)])
+    );
+}
+
+static void allwinner_gpio_set_int_line(AWGPIOState *s, int port,
+                                        int line, AWGPIOLevel level)
+{
+    AWPortsOverlay *o = (AWPortsOverlay *)s->regs;
+    int irq_line = irq_nr(port, line);
+    bool raise_irq = false;
+    unsigned input_val;
+    int int_cfg;
+
+    /* Check if pin can actually trigger an interrupt */
+    if (irq_line == -1) {
+        return;
+    }
+
+    /* if this signal isn't configured as an input signal, nothing to do */
+    if (!gpio_is_input(&o->ports[port], line)) {
+        return;
+    }
+
+    /* Get current input value */
+    input_val = extract32(o->ports[port].dat, line, 1);
+    int_cfg = int_ctl_cfg(s, irq_line);
+
+    switch (int_cfg) {
+    case AW_GPIO_IRQ_CFG_RISING_EDGE:
+        if (!input_val && level) {
+            raise_irq = true;
+        }
+        break;
+    case AW_GPIO_IRQ_CFG_FALLING_EDGE:
+        if (input_val && !level) {
+            raise_irq = true;
+        }
+        break;
+    case AW_GPIO_IRQ_CFG_HIGH_LEVEL:
+        if (level) {
+            raise_irq = true;
+        }
+        break;
+    case AW_GPIO_IRQ_CFG_LOW_LEVEL:
+        if (!level) {
+            raise_irq = true;
+        }
+        break;
+    case AW_GPIO_IRQ_CFG_BOTH_EDGE:
+        if (input_val != level) {
+            raise_irq = true;
+        }
+        break;
+    default:
+        /* Unexpected */
+        break;
+    }
+
+    if (raise_irq) {
+        s->regs[REG_INDEX(GPIO_INT_STA)] |= 1u << irq_line;
+    }
+}
+
+static void port_set_all_int_lines(AWGPIOState *s, int port)
+{
+    AWPortsOverlay *o = (AWPortsOverlay *)s->regs;
+    int i;
+
+    for (i = 0; i < AW_PINS_PER_PORT[port]; i++) {
+        AWGPIOLevel aw_level = extract32(o->ports[port].dat, i, 1);
+        allwinner_gpio_set_int_line(s, port, i, aw_level);
+    }
+
+    allwinner_gpio_update_int(s);
+}
+
+static void allwinner_set_all_int_lines(AWGPIOState *s)
+{
+    int i;
+
+    for (i = 0; i < AW_GPIO_PORTS_NUM; i++) {
+        port_set_all_int_lines(s, i);
+    }
+}
+
+static void allwinner_gpio_set(void *opaque, int port, int line, int level)
+{
+    AWGPIOState *s = AW_GPIO(opaque);
+    AWPortsOverlay *o = (AWPortsOverlay *)s->regs;
+    AWGPIOLevel aw_level = level ? AW_GPIO_LEVEL_HIGH : AW_GPIO_LEVEL_LOW;
+
+    if (gpio_is_input(&o->ports[port], line)) {
+
+        trace_allwinner_gpio_set(portname(port), line, aw_level);
+
+        allwinner_gpio_set_int_line(s, port, line, aw_level);
+
+        o->ports[port].dat = (o->ports[port].dat & ~(1u << line)) |
+                             (aw_level << line);
+    }
+    allwinner_gpio_update_int(s);
+}
+
+
+static inline bool gpio_is_output(AWPortMap *port, uint32_t pin)
+{
+    uint32_t cfg_n = pin / CFG_PINS_PER_REG;
+    uint32_t pin_shift = (pin % CFG_PINS_PER_REG) * CFG_PIN_STRIDE;
+    return (extract32(port->cfg[cfg_n], pin_shift, CFG_PIN_STRIDE - 1) ==
+        CFG_OUTPUT_MASK);
+}
+
+static inline bool gpio_is_input(AWPortMap *port, uint32_t pin)
+{
+    uint32_t cfg_n = pin / CFG_PINS_PER_REG;
+    uint32_t pin_shift = (pin % CFG_PINS_PER_REG) * CFG_PIN_STRIDE;
+    return (extract32(port->cfg[cfg_n], pin_shift, CFG_PIN_STRIDE - 1) ==
+        CFG_INPUT_MASK);
+}
+
+static inline int int_ctl_cfg(AWGPIOState *s, int irq_line)
+{
+    unsigned int_cfg_n = s->regs[REG_INDEX(GPIO_INT_CFG0) + irq_line / 8];
+    return extract32(int_cfg_n,
+                     (irq_line % INT_CFG_IRQ_PER_REG) * INT_CFG_IRQ_STRIDE,
+                     INT_CFG_IRQ_STRIDE - 1);
+}
+
+static inline void port_update_output_lines(AWGPIOState *s, uint32_t port)
+{
+    AWPortsOverlay *o = (AWPortsOverlay *)s->regs;
+    int pin;
+
+    for (pin = 0; pin < AW_PINS_PER_PORT[port]; pin++) {
+        if (gpio_is_output(&o->ports[port], pin)) {
+            qemu_set_irq(s->output[port][pin],
+                         !!(o->ports[port].dat & BIT_MASK(pin)));
+            trace_allwinner_gpio_out_pin(
+                portname(port), pin,
+                !!(o->ports[port].dat & BIT_MASK(pin)));
+         }
+        else if (gpio_is_input(&o->ports[port], pin)) {
+            qemu_irq_lower(s->output[port][pin]);
+        }
+    }
+}
+
+static inline void allwinner_gpio_update_all_output_lines(AWGPIOState *s)
+{
+    for (int port = 0; port < AW_GPIO_PORTS_NUM; port++) {
+        port_update_output_lines(s, port);
+    }
+}
+
+
+static uint64_t allwinner_gpio_read(void *opaque, hwaddr offset, unsigned size)
+{
+    AWGPIOState *s = AW_GPIO(opaque);
+    uint32_t reg_value = 0;
+    g_autofree char *regname = allwinner_gpio_get_regname(offset);
+
+    switch (offset) {
+    case 0 ... GPIO_Pn_PUL1(GPIO_PI):
+    case GPIO_INT_CFG0:
+    case GPIO_INT_CFG1:
+    case GPIO_INT_CFG2:
+    case GPIO_INT_CFG3:
+    case GPIO_INT_CTL:
+    case GPIO_INT_STA:
+    case GPIO_INT_DEB:
+        reg_value = s->regs[REG_INDEX(offset)];
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Bad register at offset 0x%"
+                      HWADDR_PRIx "\n", TYPE_AW_GPIO, __func__, offset);
+        break;
+    }
+
+    trace_allwinner_gpio_read(regname, reg_value);
+
+    return reg_value;
+}
+
+/* update output values */
+/* update interrupts */
+static void allwinner_port_write(AWGPIOState *s, hwaddr offset, uint64_t value)
+{
+    AWPortsOverlay *o = (AWPortsOverlay *)s->regs;
+    uint32_t port = offset / PORT_STRIDE;
+    uint32_t reg = offset % PORT_STRIDE;
+
+    switch (reg) {
+    case CFG0:
+        o->ports[port].cfg[0] =
+            value & GPIO_CFG0_PINS_MASK(AW_PINS_PER_PORT[port]);
+        break;
+    case CFG1:
+        o->ports[port].cfg[1] =
+            value & GPIO_CFG1_PINS_MASK(AW_PINS_PER_PORT[port]);
+        break;
+    case CFG2:
+        o->ports[port].cfg[2] =
+            value & GPIO_CFG2_PINS_MASK(AW_PINS_PER_PORT[port]);
+        break;
+    case CFG3:
+        o->ports[port].cfg[3] =
+            value & GPIO_CFG3_PINS_MASK(AW_PINS_PER_PORT[port]);
+        break;
+    case DAT:
+        o->ports[port].dat =
+            value & GPIO_DAT_PINS_MASK(AW_PINS_PER_PORT[port]);
+        break;
+    case DRV0:
+        o->ports[port].drv[0] =
+            value & GPIO_DRV0_PINS_MASK(AW_PINS_PER_PORT[port]);
+        break;
+    case DRV1:
+        o->ports[port].drv[1] =
+            value & GPIO_DRV1_PINS_MASK(AW_PINS_PER_PORT[port]);
+        break;
+    case PUL0:
+        o->ports[port].pul[0] =
+            value & GPIO_PUL0_PINS_MASK(AW_PINS_PER_PORT[port]);
+        break;
+    case PUL1:
+        o->ports[port].pul[1] =
+            value & GPIO_PUL1_PINS_MASK(AW_PINS_PER_PORT[port]);
+        break;
+    }
+    port_update_output_lines(s, port);
+    port_set_all_int_lines(s, port);
+}
+
+static void allwinner_gpio_write(void *opaque, hwaddr offset, uint64_t value,
+                           unsigned size)
+{
+    AWGPIOState *s = AW_GPIO(opaque);
+    g_autofree char *regname = allwinner_gpio_get_regname(offset);
+
+    trace_allwinner_gpio_write(regname, value);
+
+    switch (offset) {
+    case 0 ... GPIO_Pn_PUL1(GPIO_PI):
+        allwinner_port_write(s, offset, value);
+        break;
+    case GPIO_INT_CFG0:
+    case GPIO_INT_CFG1:
+    case GPIO_INT_CFG2:
+    case GPIO_INT_CFG3:
+    case GPIO_INT_CTL:
+    case GPIO_INT_DEB:
+        s->regs[REG_INDEX(offset)] = value;
+        /* update interrupts */
+        allwinner_set_all_int_lines(s);
+        break;
+    case GPIO_INT_STA:
+        /* W1C */
+        s->regs[REG_INDEX(offset)] &= ~value;
+        allwinner_set_all_int_lines(s);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Bad register at offset 0x%"
+                      HWADDR_PRIx "\n", TYPE_AW_GPIO, __func__, offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps allwinner_gpio_ops = {
+    .read = allwinner_gpio_read,
+    .write = allwinner_gpio_write,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static const VMStateDescription vmstate_allwinner_gpio = {
+    .name = TYPE_AW_GPIO,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, AWGPIOState, AW_GPIO_REGS_NUM),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void allwinner_gpio_reset(DeviceState *dev)
+{
+    AWGPIOState *s = AW_GPIO(dev);
+    AWPortsOverlay *o = (AWPortsOverlay *)s->regs;
+    int port = 0;
+
+    memset(s->regs, 0, AW_GPIO_IOSIZE);
+
+    for (port = 0; port < AW_GPIO_PORTS_NUM; port++) {
+        o->ports[port].drv[0] = aw_gpio_port_reset[port].drv[0];
+        o->ports[port].drv[1] = aw_gpio_port_reset[port].drv[1];
+        o->ports[port].pul[0] = aw_gpio_port_reset[port].pul[0];
+        o->ports[port].pul[1] = aw_gpio_port_reset[port].pul[1];
+    }
+
+    allwinner_gpio_update_all_output_lines(s);
+    allwinner_gpio_update_int(s);
+}
+
+static void allwinner_gpio_realize(DeviceState *dev, Error **errp)
+{
+    AWGPIOState *s = AW_GPIO(dev);
+    int port;
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &allwinner_gpio_ops, s,
+                          TYPE_AW_GPIO, AW_GPIO_IOSIZE);
+
+    for (port = 0; port < AW_GPIO_PORTS_NUM; port++) {
+        g_autofree char *in_name = portname_in(port);
+        g_autofree char *out_name = portname_out(port);
+        qdev_init_gpio_in_named(dev, AW_GPIO_IN_HANDLER[port],
+                                in_name, AW_PINS_PER_PORT[port]);
+        qdev_init_gpio_out_named(dev, s->output[port],
+                                 out_name, AW_PINS_PER_PORT[port]);
+    }
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
+}
+
+static void allwinner_gpio_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = allwinner_gpio_realize;
+    device_class_set_legacy_reset(dc, allwinner_gpio_reset);
+    dc->vmsd = &vmstate_allwinner_gpio;
+    dc->desc = "Allwinner GPIO controller";
+}
+
+static const TypeInfo allwinner_gpio_info = {
+    .name = TYPE_AW_GPIO,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(AWGPIOState),
+    .class_init = allwinner_gpio_class_init,
+};
+
+static void allwinner_gpio_register_types(void)
+{
+    type_register_static(&allwinner_gpio_info);
+}
+
+type_init(allwinner_gpio_register_types)
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index 0555f44b6a..8ede5e88ae 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -20,3 +20,4 @@ system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_sgpio.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio.c'))
 system_ss.add(when: 'CONFIG_PCF8574', if_true: files('pcf8574.c'))
 system_ss.add(when: 'CONFIG_CADENCE_GPIO', if_true: files('cadence_gpio.c'))
+system_ss.add(when: 'CONFIG_ALLWINNER_GPIO', if_true: files('allwinner-gpio.c'))
diff --git a/hw/gpio/trace-events b/hw/gpio/trace-events
index 80ca783a03..5ef3e0b8fd 100644
--- a/hw/gpio/trace-events
+++ b/hw/gpio/trace-events
@@ -51,3 +51,9 @@ stm32l4x5_gpio_pins(char *gpio, uint16_t disconnected, uint16_t high) "GPIO%s di
 cdns_gpio_read(const char *path, uint64_t offset, uint32_t value) "%s:reg[0x%04" PRIx64 "] -> 0x%" PRIx32
 cdns_gpio_write(const char *path, uint64_t offset, uint64_t value) "%s:reg[0x%04" PRIx64 "] <- 0x%04" PRIx64
 cdns_gpio_set(const char *path, int line, int level) "%s:[%d] <- %d"
+
+# allwinner_gpio.c
+allwinner_gpio_set(const char *port, int line, int level) "[%s:%d] <- %d"
+allwinner_gpio_read(const char *reg, uint32_t value) "[%s] -> 0x%" PRIx32
+allwinner_gpio_write(const char *reg, uint32_t value) "[%s] <- 0x%" PRIx32
+allwinner_gpio_out_pin(const char *reg, uint32_t pin, uint32_t value) "[%s.%d] <- 0x%" PRIx32
diff --git a/include/hw/gpio/allwinner-gpio-regs.h b/include/hw/gpio/allwinner-gpio-regs.h
new file mode 100644
index 0000000000..52d72c0f25
--- /dev/null
+++ b/include/hw/gpio/allwinner-gpio-regs.h
@@ -0,0 +1,228 @@
+/*
+ *  Allwinner GPIO registers definition
+ *
+ *  Copyright (C) 2026 Strahinja Jankovic. <strahinja.p.jankovic@gmail.com>
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef ALLWINNER_GPIO_REGS_H
+#define ALLWINNER_GPIO_REGS_H
+
+/* GPIO ports index (n) */
+#define GPIO_PA     0
+#define GPIO_PB     1
+#define GPIO_PC     2
+#define GPIO_PD     3
+#define GPIO_PE     4
+#define GPIO_PF     5
+#define GPIO_PG     6
+#define GPIO_PH     7
+#define GPIO_PI     8
+
+#ifndef AW_GPIO_PORTS_NUM
+#define AW_GPIO_PORTS_NUM 9
+#endif
+
+#ifndef AW_GPIO_PIN_COUNT
+#define AW_GPIO_PIN_COUNT 32
+#endif
+
+typedef struct AWPortMap {
+    uint32_t cfg[4];
+    uint32_t dat;
+    uint32_t drv[2];
+    uint32_t pul[2];
+} AWPortMap;
+
+typedef struct AWPortsOverlay {
+    AWPortMap ports[AW_GPIO_PORTS_NUM];
+} AWPortsOverlay;
+
+static const uint32_t AW_PINS_PER_PORT[AW_GPIO_PORTS_NUM] = {
+    18,
+    24,
+    25,
+    28,
+    12,
+    6,
+    12,
+    28,
+    22
+};
+
+typedef struct {
+    uint32_t drv[2];
+    uint32_t pul[2];
+} AWPortResetVals;
+
+static const AWPortResetVals aw_gpio_port_reset[] = {
+    [GPIO_PA] = { .drv = { 0x55555555, 0x00000005 } },
+    [GPIO_PB] = { .drv = { 0x55555555, 0x00005555 } },
+    [GPIO_PC] = { .drv = { 0x55555555, 0x00015555 },
+                  .pul = { 0x00005140, 0x00004016 } },
+    [GPIO_PD] = { .drv = { 0x55555555, 0x00555555 } },
+    [GPIO_PE] = { .drv = { 0x00555555, 0x0 } },
+    [GPIO_PF] = { .drv = { 0x00000555, 0x0 } },
+    [GPIO_PG] = { .drv = { 0x05555555, 0x0 } },
+    [GPIO_PH] = { .drv = { 0x55555555, 0x00555555 } },
+    [GPIO_PI] = { .drv = { 0x55555555, 0x00000555 } },
+};
+
+#define DEFAULT_CFG_MASK    0x77777777
+#define DEFAULT_DRV_MASK    0xffffffff
+#define DEFAULT_PUL_MASK    0xffffffff
+
+#define CFG_INPUT_MASK      0x0
+#define CFG_OUTPUT_MASK     0x1
+#define CFG_IO_MASK         0x1
+#define CFG_PIN_STRIDE      4
+#define CFG_PINS_PER_REG    (AW_GPIO_PIN_COUNT / CFG_PIN_STRIDE)
+
+#define AW_INT_GPIO_COUNT   32
+#define INT_CFG_IRQ_STRIDE  4
+#define INT_CFG_IRQ_PER_REG (AW_INT_GPIO_COUNT / INT_CFG_IRQ_STRIDE)
+
+/* GPIO masks per number of pins */
+#define GPIO_CFG0_PINS_MASK(pins) \
+    ((pins >= CFG_PINS_PER_REG) ? DEFAULT_CFG_MASK : \
+    ((1 << (pins * CFG_PIN_STRIDE)) - 1) & DEFAULT_CFG_MASK)
+
+#define GPIO_CFG1_PINS_MASK(pins) \
+    ((pins >= 16) ? DEFAULT_CFG_MASK : \
+    ((pins > 8) ? ((1 << ((pins - 8) * 4)) - 1) & DEFAULT_CFG_MASK : 0))
+
+#define GPIO_CFG2_PINS_MASK(pins) \
+    ((pins >= 24) ? DEFAULT_CFG_MASK : \
+    ((pins > 16) ? ((1 << ((pins - 16) * 4)) - 1) & DEFAULT_CFG_MASK : 0))
+
+#define GPIO_CFG3_PINS_MASK(pins) \
+    ((pins > 24) ? ((1 << ((pins - 24) * 4)) - 1) & DEFAULT_CFG_MASK : 0)
+
+#define GPIO_DAT_PINS_MASK(pins)    ((1 << pins) - 1)
+
+#define GPIO_DRV0_PINS_MASK(pins) \
+    ((pins > 16) ? DEFAULT_DRV_MASK : ((1 << (pins * 2)) - 1))
+
+#define GPIO_DRV1_PINS_MASK(pins) \
+    ((pins > 16) ? ((1 << ((pins - 16) * 2)) - 1) : 0)
+
+#define GPIO_PUL0_PINS_MASK(pins) \
+    ((pins > 16) ? DEFAULT_PUL_MASK : ((1 << (pins * 2)) - 1))
+
+#define GPIO_PUL1_PINS_MASK(pins) \
+    ((pins > 16) ? ((1 << ((pins - 16) * 2)) - 1) : 0)
+
+
+#define PORT_STRIDE     0x24
+
+/* Allwinner GPIO memory map */
+#define CFG0    0x00 /* Configure register 0 */
+#define CFG1    0x04 /* Configure register 1 */
+#define CFG2    0x08 /* Configure register 2 */
+#define CFG3    0x0c /* Configure register 3 */
+#define DAT     0x10 /* Data register */
+#define DRV0    0x14 /* Multi-driving register 0 */
+#define DRV1    0x18 /* Multi-driving register 1 */
+#define PUL0    0x1c /* Pull register 0 */
+#define PUL1    0x20 /* Pull register 1 */
+
+/* Port n configure register 0 */
+#define GPIO_Pn_CFG0(n)   (n*PORT_STRIDE + CFG0)
+/* Port n configure register 1 */
+#define GPIO_Pn_CFG1(n)   (n*PORT_STRIDE + CFG1)
+/* Port n configure register 2 */
+#define GPIO_Pn_CFG2(n)   (n*PORT_STRIDE + CFG2)
+/* Port n configure register 3 */
+#define GPIO_Pn_CFG3(n)   (n*PORT_STRIDE + CFG3)
+/* Port n data register */
+#define GPIO_Pn_DAT(n)    (n*PORT_STRIDE + DAT)
+/* Port n Multi-driving register 0 */
+#define GPIO_Pn_DRV0(n)   (n*PORT_STRIDE + DRV0)
+/* Port n Multi-driving register 1 */
+#define GPIO_Pn_DRV1(n)   (n*PORT_STRIDE + DRV1)
+/* Port n Pull register 0 */
+#define GPIO_Pn_PUL0(n)   (n*PORT_STRIDE + PUL0)
+/* Port n Pull register 1 */
+#define GPIO_Pn_PUL1(n)   (n*PORT_STRIDE + PUL1)
+/* PIO interrupt configure register 0 */
+#define GPIO_INT_CFG0       0x200
+/* PIO interrupt configure register 1 */
+#define GPIO_INT_CFG1       0x204
+/* PIO interrupt configure register 2 */
+#define GPIO_INT_CFG2       0x208
+/* PIO interrupt configure register 3 */
+#define GPIO_INT_CFG3       0x20c
+/* PIO interrupt control register */
+#define GPIO_INT_CTL        0x210
+/* PIO interrupt status register */
+#define GPIO_INT_STA        0x214
+/* PIO interrupt debounce register */
+#define GPIO_INT_DEB        0x218
+/* SDRAM Pad Multi-driving register */
+#define SDR_PAD_DRV         0x220
+/* SDRAM Pad Pull register */
+#define SDR_PAD_PUL         0x224
+
+typedef enum AWGPIOLevel {
+    AW_GPIO_LEVEL_LOW = 0,
+    AW_GPIO_LEVEL_HIGH = 1,
+} AWGPIOLevel;
+
+typedef enum AWGPIOCfg {
+    AW_GPIO_CFG_IN = 0,
+    AW_GPIO_CFG_OUT = 1,
+    AW_GPIO_CFG_FUN = 2,
+    /* Use only fun for testing */
+} AWGPIOCfg;
+
+typedef enum AWGPIOIrqCfg {
+    AW_GPIO_IRQ_CFG_RISING_EDGE = 0,
+    AW_GPIO_IRQ_CFG_FALLING_EDGE = 1,
+    AW_GPIO_IRQ_CFG_HIGH_LEVEL = 2,
+    AW_GPIO_IRQ_CFG_LOW_LEVEL = 3,
+    AW_GPIO_IRQ_CFG_BOTH_EDGE = 4
+} AWGPIOIrqCfg;
+
+static const char *const port_name_table[] = {
+    "PA", "PB", "PC", "PD", "PE", "PF", "PG", "PH", "PI"
+};
+
+static const char *portname(unsigned index)
+{
+    return index < AW_GPIO_PORTS_NUM ? port_name_table[index] : "?";
+}
+
+static inline char *portname_in(int port)
+{
+    return g_strconcat(portname(port), "_IN", NULL);
+}
+
+static inline char *portname_out(int port)
+{
+    return g_strconcat(portname(port), "_OUT", NULL);
+}
+
+static int irq_nr(int port, int line)
+{
+    int irq = -1;
+
+    switch (port) {
+    case GPIO_PH:
+        if (line <= 21) {
+            irq = line;
+        }
+        break;
+    case GPIO_PI:
+        if ((line >= 10) && (line <= 19)) {
+            irq = line + 12;
+        }
+        break;
+    default:
+        break;
+    }
+    return irq;
+}
+
+
+#endif /* ALLWINNER_GPIO_REGS_H */
diff --git a/include/hw/gpio/allwinner-gpio.h b/include/hw/gpio/allwinner-gpio.h
new file mode 100644
index 0000000000..f6778d1893
--- /dev/null
+++ b/include/hw/gpio/allwinner-gpio.h
@@ -0,0 +1,41 @@
+/*
+ *  Allwinner GPIO registers definition
+ *
+ *  Copyright (C) 2026 Strahinja Jankovic. <strahinja.p.jankovic@gmail.com>
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef ALLWINNER_GPIO_H
+#define ALLWINNER_GPIO_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+/** Size of register I/O address space used by GPIO device */
+#define AW_GPIO_IOSIZE (0x400)
+
+/** Total number of known registers */
+#define AW_GPIO_REGS_NUM    (AW_GPIO_IOSIZE / sizeof(uint32_t))
+
+/** Max number of ports */
+#define AW_GPIO_PORTS_NUM   9
+/** Max number of pins per ports */
+#define AW_GPIO_PIN_COUNT 32
+
+#define TYPE_AW_GPIO        "allwinner.gpio"
+OBJECT_DECLARE_SIMPLE_TYPE(AWGPIOState, AW_GPIO)
+
+struct AWGPIOState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion iomem;
+    qemu_irq irq;
+    qemu_irq output[AW_GPIO_PORTS_NUM][AW_GPIO_PIN_COUNT];
+
+    uint32_t regs[AW_GPIO_REGS_NUM];
+};
+
+#endif /* ALLWINNER_GPIO_H */

-- 
2.55.0


