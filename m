Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710E9C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 22:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwRw0-0007zr-Tz; Tue, 18 Aug 2026 18:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinja.p.jankovic@gmail.com>)
 id 1wwRvz-0007z5-Hk
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 18:05:27 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinja.p.jankovic@gmail.com>)
 id 1wwRvw-0001Sc-HH
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 18:05:27 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5b15c6fb864so347638e87.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 15:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787090723; x=1787695523; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NmhfnUaMPIZBmKTT+eKwIc3C6ccvtBCG8iL/VqhJMy4=;
 b=LT1qP9laZSczAFlq5fYlFUa23TFSLe0mb0K46SqXZm4EHv5gLxcg7KBDHpW82rUXIn
 jIjgAbrrW7x9Gwzgpcj/52owswo/xNxVU0ggzcKEX7ngLJPiEq10q1hZf9NtLSEAUXjX
 oyASdesTGWRzOqbuQ88gb6j9L5a/77CQHp1Z/cBywgwb+3966hsj7eyqfW+6lqCmD8tf
 FzIrI9RUBWizh89cu/sqV2cp2sDftzUyaGVfUJ93rhgxq7IZLhiLxNXJ+sp5C/cdcX48
 xlSKiV2L8FxOPceTlSf6CGPozy+gTEr8htj4e759gg6456rmu3wVVgnX9hLgbpgHVp/n
 qE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787090723; x=1787695523;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NmhfnUaMPIZBmKTT+eKwIc3C6ccvtBCG8iL/VqhJMy4=;
 b=H29NW/QhxhSSyeTNibLX4LLc8uUxIXCUz2ybzzXko0ih1XTPt2na6x82lmBwDP0M1x
 4RFnj9gOa4zHRittX9TS2Hvt0mXM/Lio2f6e3/oDTJ5n9JL5hD6cVMaxlUDNK/UekVVU
 Nds4hDYljoZbTfTxfmw/dM6n0BTNSqTC4rt6qU40WTeceprNufFPAcCqrO6zrh8/93C1
 NUTvaLAMCsz/RsuIkecEBCgZRmtE9Z0mk4049cbmW6HPNmYn32ytWkEzGvP7KNCiKNVj
 oP34i57Ok4YmNcVcZjsJKgXeP7N7odiriKrbfcmTyHTApUiLZGhTmV2u6UtgJdVIfSAQ
 aLPA==
X-Gm-Message-State: AOJu0YwiLYVINiNSUmlyyUei3YtrelHjByGrRv+T3QGrFeN+DJmbnC/p
 aAnZ28GNyWOy0i6zv5jD1pwah1wBOnZUqSYEj1sdVZTCLo5+xrml16TN
X-Gm-Gg: AR+sD11hLjEQLL3yi2Mf4XSk/UaWNdtoz37wdsHnx0lIjDoZGcxtVB0LdxOV/malhUR
 GRTqX3Ec314/T+acXlOJ1fSU+wLfwVhDM95zLWXA+lTw0UZb53/R1RQIkLkoKbGfEUDhunXbeEc
 TctDc3erh7aRRbWXS+JyrAlNmq6qnS4ob95doq+JYfX96FAHXOcY/83U4xxwZDKBZIQBDU1WDK8
 EeWw47JuY1WZM9R2heGsSJGCeMbICrpP1kVNPdrYblAW7kzVOJPmUP5JPKR0gshS149ztZhr2TT
 dnfE7pIey/mdX6iKKClDWTc8mQQ1tA0/oAWEZKv3r21d9bm5dKFGkYzbsMoPnKs5ds7ExkU26Bq
 6Bb56yAznfyuiv/FTsGyGAD+PlNJwpCtitFtahIbzzxEZMaWyzU7tVYBe4LBI7NAM4Uwij6YHQC
 2PHW0Zu31aNJzcAUtVd3VjPGx3Px7vdpIli5uRxLrij57xYuL0ogSa/LkSz+Fr1BheHdnb2QBwF
 t4ptF0+En/chazOATK39maFd5z+59deL0hSsmXwgYW2nJ1f
X-Received: by 2002:a05:6512:3985:b0:5b1:5e05:31df with SMTP id
 2adb3069b0e04-5b478bbb206mr10753e87.13.1787090722474; 
 Tue, 18 Aug 2026 15:05:22 -0700 (PDT)
Received: from [192.168.31.141] (213-65-111-204-no600.tbcn.telia.com.
 [213.65.111.204]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b478853ae5sm21836e87.17.2026.08.18.15.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 15:05:21 -0700 (PDT)
From: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Date: Wed, 19 Aug 2026 00:04:53 +0200
Subject: [PATCH 3/3] tests/qtest: Allwinner GPIO tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-allwinner-gpio-v1-3-2a64866dff11@gmail.com>
References: <20260819-allwinner-gpio-v1-0-2a64866dff11@gmail.com>
In-Reply-To: <20260819-allwinner-gpio-v1-0-2a64866dff11@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=strahinja.p.jankovic@gmail.com; helo=mail-lf1-x130.google.com
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

Add Allwinner GPIO set of qtests to validate functionality.
Tests cover input and output port setting, as well as interrupt
functionality.

Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
---
 MAINTAINERS                       |   1 +
 tests/qtest/allwinner-gpio-test.c | 474 ++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build           |   3 +-
 3 files changed, 477 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6cefdde70b..2691796557 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -746,6 +746,7 @@ F: hw/misc/axp2xx.c
 F: hw/gpio/allwinner-gpio.c
 F: include/hw/gpio/allwinner-gpio*
 F: tests/functional/arm/test_cubieboard.py
+F: tests/qtest/allwinner-gpio-test.c
 
 Allwinner-h3
 M: Niek Linnenbank <nieklinnenbank@gmail.com>
diff --git a/tests/qtest/allwinner-gpio-test.c b/tests/qtest/allwinner-gpio-test.c
new file mode 100644
index 0000000000..e1ad2289e9
--- /dev/null
+++ b/tests/qtest/allwinner-gpio-test.c
@@ -0,0 +1,474 @@
+/*
+ *  Allwinner GPIO Tests
+ *
+ *  Copyright (C) 2026 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "libqtest-single.h"
+
+#include "include/hw/gpio/allwinner-gpio-regs.h"
+
+#define AW_A10_GPIO_BASE 0x01c20800
+#define AW_A10_IRQ_LINE 28
+
+/* Port n configure register 0 */
+#define GPIO_Pn_CFG0_ADDR(n)   (AW_A10_GPIO_BASE + GPIO_Pn_CFG0(n))
+/* Port n configure register 1 */
+#define GPIO_Pn_CFG1_ADDR(n)   (AW_A10_GPIO_BASE + GPIO_Pn_CFG1(n))
+/* Port n configure register 2 */
+#define GPIO_Pn_CFG2_ADDR(n)   (AW_A10_GPIO_BASE + GPIO_Pn_CFG2(n))
+/* Port n configure register 3 */
+#define GPIO_Pn_CFG3_ADDR(n)   (AW_A10_GPIO_BASE + GPIO_Pn_CFG3(n))
+/* Port n data register */
+#define GPIO_Pn_DAT_ADDR(n)    (AW_A10_GPIO_BASE + GPIO_Pn_DAT(n))
+/* Port n Multi-driving register 0 */
+#define GPIO_Pn_DRV0_ADDR(n)   (AW_A10_GPIO_BASE + GPIO_Pn_DRV0(n))
+/* Port n Multi-driving register 1 */
+#define GPIO_Pn_DRV1_ADDR(n)   (AW_A10_GPIO_BASE + GPIO_Pn_DRV1(n))
+/* Port n Pull register 0 */
+#define GPIO_Pn_PUL0_ADDR(n)   (AW_A10_GPIO_BASE + GPIO_Pn_PUL0(n))
+/* Port n Pull register 1 */
+#define GPIO_Pn_PUL1_ADDR(n)   (AW_A10_GPIO_BASE + GPIO_Pn_PUL1(n))
+/* PIO interrupt configure register 0 */
+#define GPIO_INT_CFG0_ADDR     (AW_A10_GPIO_BASE + GPIO_INT_CFG0)
+/* PIO interrupt configure register 1 */
+#define GPIO_INT_CFG1_ADDR     (AW_A10_GPIO_BASE + GPIO_INT_CFG1)
+/* PIO interrupt configure register 2 */
+#define GPIO_INT_CFG2_ADDR     (AW_A10_GPIO_BASE + GPIO_INT_CFG2)
+/* PIO interrupt configure register 3 */
+#define GPIO_INT_CFG3_ADDR     (AW_A10_GPIO_BASE + GPIO_INT_CFG3)
+/* PIO interrupt control register */
+#define GPIO_INT_CTL_ADDR      (AW_A10_GPIO_BASE + GPIO_INT_CTL)
+/* PIO interrupt status register */
+#define GPIO_INT_STA_ADDR      (AW_A10_GPIO_BASE + GPIO_INT_STA)
+/* PIO interrupt debounce register */
+#define GPIO_INT_DEB_ADDR      (AW_A10_GPIO_BASE + GPIO_INT_DEB)
+/* SDRAM Pad Multi-driving register */
+#define SDR_PAD_DRV_ADDR       (AW_A10_GPIO_BASE + SDR_PAD_DRV)
+/* SDRAM Pad Pull register */
+#define SDR_PAD_PUL_ADDR       (AW_A10_GPIO_BASE + SDR_PAD_PUL)
+
+static inline uint32_t read_cfg_addr(QTestState *s, int port, int pin)
+{
+    uint32_t addr = 0;
+
+    if (pin >= 24) {
+        addr = GPIO_Pn_CFG3_ADDR(port);
+    } else if (pin >= 16) {
+        addr = GPIO_Pn_CFG2_ADDR(port);
+    } else if (pin >= 8) {
+        addr = GPIO_Pn_CFG1_ADDR(port);
+    } else {
+        addr = GPIO_Pn_CFG0_ADDR(port);
+    }
+    return addr;
+}
+
+static inline uint32_t read_int_cfg_addr(QTestState *s, int irq)
+{
+    uint32_t addr = 0;
+
+    if (irq >= 24) {
+        addr = GPIO_INT_CFG3_ADDR;
+    } else if (irq >= 16) {
+        addr = GPIO_INT_CFG2_ADDR;
+    } else if (irq >= 8) {
+        addr = GPIO_INT_CFG1_ADDR;
+    } else {
+        addr = GPIO_INT_CFG0_ADDR;
+    }
+    return addr;
+}
+
+static void update_cfg_reg(QTestState *s, int port, int pin, AWGPIOCfg val)
+{
+    uint32_t addr = read_cfg_addr(s, port, pin);
+    uint32_t cfg = qtest_readl(s, addr);
+    uint32_t offset = (pin % CFG_PINS_PER_REG) * CFG_PIN_STRIDE;
+
+    cfg = deposit32(cfg, offset, CFG_PIN_STRIDE - 1, val);
+    qtest_writel(s, addr, cfg);
+}
+
+static void assert_cfg_regval(QTestState *s, int port, int pin,
+                              AWGPIOCfg pin_choice)
+{
+    uint32_t addr = read_cfg_addr(s, port, pin);
+    uint32_t cfg = qtest_readl(s, addr);
+    uint32_t offset = (pin % CFG_PINS_PER_REG) * CFG_PIN_STRIDE;
+
+    g_assert_cmphex(
+        extract32(cfg, offset, CFG_PIN_STRIDE - 1), ==, pin_choice);
+}
+
+static void update_data_reg(QTestState *s, int port, int pin, int val)
+{
+    uint32_t addr = GPIO_Pn_DAT_ADDR(port);
+    uint32_t data = qtest_readl(s, addr);
+
+    data = deposit32(data, pin, 1, val);
+    qtest_writel(s, addr, data);
+}
+
+static void assert_data_reg(QTestState *s, int port, int pin, int val)
+{
+    uint32_t addr = GPIO_Pn_DAT_ADDR(port);
+    uint32_t data = qtest_readl(s, addr);
+
+    g_assert_cmphex(extract32(data, pin, 1), ==, val);
+}
+
+static void update_int_cfg_reg(QTestState *s, int irq, AWGPIOIrqCfg val)
+{
+    uint32_t addr = read_int_cfg_addr(s, irq);
+    uint32_t cfg = qtest_readl(s, addr);
+    uint32_t offset = (irq % INT_CFG_IRQ_PER_REG) * INT_CFG_IRQ_STRIDE;
+
+    cfg = deposit32(cfg, offset, INT_CFG_IRQ_STRIDE - 1, val);
+    qtest_writel(s, addr, cfg);
+}
+
+static void assert_int_cfg_regval(QTestState *s, int irq, AWGPIOIrqCfg irq_cfg)
+{
+    uint32_t addr = read_int_cfg_addr(s, irq);
+    uint32_t cfg = qtest_readl(s, addr);
+    uint32_t offset = (irq % INT_CFG_IRQ_PER_REG) * INT_CFG_IRQ_STRIDE;
+
+    g_assert_cmphex(
+        extract32(cfg, offset, INT_CFG_IRQ_STRIDE - 1), ==, irq_cfg);
+}
+
+static void test_reset_values(void)
+{
+    QTestState *s = qtest_init("-machine cubieboard");
+
+    for (int port = 0; port < AW_GPIO_PORTS_NUM; port++) {
+        g_assert_cmphex(
+            qtest_readl(s, GPIO_Pn_DRV0_ADDR(port)), ==,
+            aw_gpio_port_reset[port].drv[0]);
+        g_assert_cmphex(
+            qtest_readl(s, GPIO_Pn_DRV1_ADDR(port)), ==,
+            aw_gpio_port_reset[port].drv[1]);
+        g_assert_cmphex(
+            qtest_readl(s, GPIO_Pn_PUL0_ADDR(port)), ==,
+            aw_gpio_port_reset[port].pul[0]);
+        g_assert_cmphex(
+            qtest_readl(s, GPIO_Pn_PUL1_ADDR(port)), ==,
+            aw_gpio_port_reset[port].pul[1]);
+    }
+
+    qtest_quit(s);
+}
+
+typedef struct {
+    int port;
+    int pin;
+} PortPinTestParam;
+
+const PortPinTestParam in_out_test_parameters[] = {
+    { GPIO_PA, 0 },
+    { GPIO_PA, 17 },
+    { GPIO_PB, 19 },
+    { GPIO_PC, 23 },
+    { GPIO_PD, 26 },
+    { GPIO_PE, 11 },
+    { GPIO_PF, 5 },
+    { GPIO_PG, 10 },
+    { GPIO_PH, 16 },
+    { GPIO_PI, 21 },
+};
+
+const PortPinTestParam irq_test_parameters[] = {
+    { GPIO_PH, 1 },
+    { GPIO_PH, 10 },
+    { GPIO_PH, 21 },
+    { GPIO_PI, 10 },
+    { GPIO_PI, 19 },
+};
+
+/* Set pin to output, check that it propagates */
+static void test_set_output_pins(const void *data)
+{
+    PortPinTestParam *param = (PortPinTestParam *)data;
+    g_autofree char *out_name = portname_out(param->port);
+
+    QTestState *s = qtest_init("-machine cubieboard");
+    qtest_irq_intercept_out_named(s, "/machine/soc/gpio", out_name);
+
+    /* Configure pin as output */
+    update_cfg_reg(s, param->port, param->pin, AW_GPIO_CFG_OUT);
+    /* Set value in register */
+    update_data_reg(s, param->port, param->pin, AW_GPIO_LEVEL_HIGH);
+
+    /* Check that the output pin is high */
+    g_assert_true(qtest_get_irq(s, param->pin));
+
+    /* Cleanup */
+    /* Set value in register */
+    update_data_reg(s, param->port, param->pin, AW_GPIO_LEVEL_LOW);
+    /* Configure pin as input */
+    update_cfg_reg(s, param->port, param->pin, AW_GPIO_CFG_IN);
+
+    qtest_quit(s);
+}
+
+/*
+ * Set pin to input, check that the value is written but it does not propagate
+ */
+static void test_set_input_pins(const void *data)
+{
+    PortPinTestParam *param = (PortPinTestParam *)data;
+    g_autofree char *out_name = portname_out(param->port);
+
+    QTestState *s = qtest_init("-machine cubieboard");
+
+    qtest_irq_intercept_out_named(s, "/machine/soc/gpio", out_name);
+
+    /* Configure pin as input */
+    update_cfg_reg(s, param->port, param->pin, AW_GPIO_CFG_IN);
+    /* Set value in register */
+    update_data_reg(s, param->port, param->pin, AW_GPIO_LEVEL_HIGH);
+    /* Check that the output pin is still low */
+    g_assert_false(qtest_get_irq(s, param->pin));
+
+    qtest_quit(s);
+}
+
+/* Test rising edge interrupt */
+static void test_irq_pin_rising(const void *data)
+{
+    PortPinTestParam *param = (PortPinTestParam *)data;
+    QTestState *s = qtest_init("-machine cubieboard");
+    const int gpio_port = param->port;
+    const int port_pin = param->pin;
+    g_autofree char *in_name = portname_in(gpio_port);
+    int irq_pin = irq_nr(gpio_port, port_pin);
+    unsigned int irq_mask = 1u << irq_pin;
+
+    qtest_irq_intercept_in(s, "/machine/soc");
+
+    /* Configure as input and set pin low */
+    update_cfg_reg(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
+    assert_cfg_regval(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
+    qtest_set_irq_in(
+        s, "/machine/soc/gpio", in_name, port_pin, AW_GPIO_LEVEL_LOW);
+
+    /* Enable interrupt */
+    update_int_cfg_reg(s, irq_pin, AW_GPIO_IRQ_CFG_RISING_EDGE);
+    assert_int_cfg_regval(s, irq_pin, AW_GPIO_IRQ_CFG_RISING_EDGE);
+    qtest_writel(s, GPIO_INT_CTL_ADDR, irq_mask);
+
+    /* Raise interrupt */
+    qtest_set_irq_in(
+        s, "/machine/soc/gpio", in_name, port_pin, AW_GPIO_LEVEL_HIGH);
+    /* Check that value is written */
+    assert_data_reg(s, gpio_port, port_pin, AW_GPIO_LEVEL_HIGH);
+    /* Check interrupt status */
+    g_assert_cmphex(qtest_readl(s, GPIO_INT_STA_ADDR), ==, irq_mask);
+    g_assert_true(qtest_get_irq(s, AW_A10_IRQ_LINE));
+
+    /* Clear interrupt */
+    qtest_writel(s, GPIO_INT_STA_ADDR, irq_mask);
+
+    /* Check that IRQ line is low */
+    g_assert_cmphex(qtest_readl(s, GPIO_INT_STA_ADDR) & irq_mask, ==, 0);
+    g_assert_false(qtest_get_irq(s, AW_A10_IRQ_LINE));
+
+    qtest_quit(s);
+}
+
+/* Test falling edge interrupt 2 */
+static void test_irq_pin_falling(const void *data)
+{
+    PortPinTestParam *param = (PortPinTestParam *)data;
+    QTestState *s = qtest_init("-machine cubieboard");
+    const int gpio_port = param->port;
+    const int port_pin = param->pin;
+    g_autofree char *in_name = portname_in(gpio_port);
+    int irq_pin = irq_nr(gpio_port, port_pin);
+    unsigned int irq_mask = 1u << irq_pin;
+
+    qtest_irq_intercept_in(s, "/machine/soc");
+
+    /* Configure as input and set pin high */
+    update_cfg_reg(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
+    assert_cfg_regval(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
+    qtest_set_irq_in(
+        s, "/machine/soc/gpio", in_name, port_pin, AW_GPIO_LEVEL_HIGH);
+
+    /* Enable interrupt */
+    update_int_cfg_reg(s, irq_pin, AW_GPIO_IRQ_CFG_FALLING_EDGE);
+    assert_int_cfg_regval(s, irq_pin, AW_GPIO_IRQ_CFG_FALLING_EDGE);
+    qtest_writel(s, GPIO_INT_CTL_ADDR, irq_mask);
+
+    /* Raise interrupt */
+    qtest_set_irq_in(
+        s, "/machine/soc/gpio", in_name, port_pin, AW_GPIO_LEVEL_LOW);
+    /* Check that value is written */
+    assert_data_reg(s, gpio_port, port_pin, AW_GPIO_LEVEL_LOW);
+    /* Check interrupt status */
+    g_assert_cmphex(qtest_readl(s, GPIO_INT_STA_ADDR), ==, irq_mask);
+    g_assert_true(qtest_get_irq(s, AW_A10_IRQ_LINE));
+
+    /* Clear interrupt */
+    qtest_writel(s, GPIO_INT_STA_ADDR, irq_mask);
+
+    /* Check that IRQ line is low */
+    g_assert_cmphex(qtest_readl(s, GPIO_INT_STA_ADDR) & irq_mask, ==, 0);
+    g_assert_false(qtest_get_irq(s, AW_A10_IRQ_LINE));
+
+    qtest_quit(s);
+}
+
+/* Test high level interrupt */
+static void test_irq_pin_high_level(const void *data)
+{
+    PortPinTestParam *param = (PortPinTestParam *)data;
+    QTestState *s = qtest_init("-machine cubieboard");
+    const int gpio_port = param->port;
+    const int port_pin = param->pin;
+    g_autofree char *in_name = portname_in(gpio_port);
+    int irq_pin = irq_nr(gpio_port, port_pin);
+    unsigned int irq_mask = 1u << irq_pin;
+
+    qtest_irq_intercept_in(s, "/machine/soc");
+
+    /* Configure as input and set pin low */
+    update_cfg_reg(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
+    assert_cfg_regval(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
+    qtest_set_irq_in(
+        s, "/machine/soc/gpio", in_name, port_pin, AW_GPIO_LEVEL_LOW);
+
+    /* Enable interrupt */
+    update_int_cfg_reg(s, irq_pin, AW_GPIO_IRQ_CFG_HIGH_LEVEL);
+    assert_int_cfg_regval(s, irq_pin, AW_GPIO_IRQ_CFG_HIGH_LEVEL);
+    qtest_writel(s, GPIO_INT_CTL_ADDR, irq_mask);
+
+    /* Raise interrupt */
+    qtest_set_irq_in(
+        s, "/machine/soc/gpio", in_name, port_pin, AW_GPIO_LEVEL_HIGH);
+    /* Check that value is written */
+    assert_data_reg(s, gpio_port, port_pin, AW_GPIO_LEVEL_HIGH);
+    /* Check interrupt status */
+    g_assert_cmphex(qtest_readl(s, GPIO_INT_STA_ADDR), ==, irq_mask);
+    g_assert_true(qtest_get_irq(s, AW_A10_IRQ_LINE));
+
+    /* Try clearing interrupt, it should still be asserted */
+    qtest_writel(s, GPIO_INT_STA_ADDR, irq_mask);
+    g_assert_cmphex(qtest_readl(s, GPIO_INT_STA_ADDR), ==, irq_mask);
+    g_assert_true(qtest_get_irq(s, AW_A10_IRQ_LINE));
+
+    /* Set line low and clear interrupt, it should be cleared now */
+    qtest_set_irq_in(
+        s, "/machine/soc/gpio", in_name, port_pin, AW_GPIO_LEVEL_LOW);
+    qtest_writel(s, GPIO_INT_STA_ADDR, irq_mask);
+
+    /* Check that IRQ line is low */
+    g_assert_cmphex(qtest_readl(s, GPIO_INT_STA_ADDR) & irq_mask, ==, 0);
+    g_assert_false(qtest_get_irq(s, AW_A10_IRQ_LINE));
+
+    qtest_quit(s);
+}
+
+/* Test low level interrupt */
+static void test_irq_pin_low_level(const void *data)
+{
+    PortPinTestParam *param = (PortPinTestParam *)data;
+    QTestState *s = qtest_init("-machine cubieboard");
+    const int gpio_port = param->port;
+    const int port_pin = param->pin;
+    g_autofree char *in_name = portname_in(gpio_port);
+    int irq_pin = irq_nr(gpio_port, port_pin);
+    unsigned int irq_mask = 1u << irq_pin;
+
+    qtest_irq_intercept_in(s, "/machine/soc");
+
+    /* Configure as input and set pin high */
+    update_cfg_reg(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
+    assert_cfg_regval(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
+    qtest_set_irq_in(
+        s, "/machine/soc/gpio", in_name, port_pin, AW_GPIO_LEVEL_HIGH);
+
+    /* Enable interrupt */
+    update_int_cfg_reg(s, irq_pin, AW_GPIO_IRQ_CFG_LOW_LEVEL);
+    assert_int_cfg_regval(s, irq_pin, AW_GPIO_IRQ_CFG_LOW_LEVEL);
+    qtest_writel(s, GPIO_INT_CTL_ADDR, irq_mask);
+
+    /* Raise interrupt */
+    qtest_set_irq_in(
+        s, "/machine/soc/gpio", in_name, port_pin, AW_GPIO_LEVEL_LOW);
+    /* Check that value is written */
+    assert_data_reg(s, gpio_port, port_pin, AW_GPIO_LEVEL_LOW);
+    /* Check interrupt status */
+    g_assert_cmphex(qtest_readl(s, GPIO_INT_STA_ADDR), ==, irq_mask);
+    g_assert_true(qtest_get_irq(s, AW_A10_IRQ_LINE));
+
+    /* Try clearing interrupt, it should still be asserted */
+    qtest_writel(s, GPIO_INT_STA_ADDR, irq_mask);
+    g_assert_cmphex(qtest_readl(s, GPIO_INT_STA_ADDR), ==, irq_mask);
+    g_assert_true(qtest_get_irq(s, AW_A10_IRQ_LINE));
+
+    /* Set line high and clear interrupt, it should be cleared now */
+    qtest_set_irq_in(
+        s, "/machine/soc/gpio", in_name, port_pin, AW_GPIO_LEVEL_HIGH);
+    qtest_writel(s, GPIO_INT_STA_ADDR, irq_mask);
+
+    /* Check that IRQ line is low */
+    g_assert_cmphex(qtest_readl(s, GPIO_INT_STA_ADDR) & irq_mask, ==, 0);
+    g_assert_false(qtest_get_irq(s, AW_A10_IRQ_LINE));
+
+    qtest_quit(s);
+}
+
+
+int main(int argc, char **argv)
+{
+  int r;
+
+  g_test_init(&argc, &argv, NULL);
+
+  for (int i = 0; i < G_N_ELEMENTS(in_out_test_parameters); i++) {
+    g_autofree char *out_name = g_strdup_printf(
+    "/allwinner-cubieboard/gpio/set_output_pins/%s%d",
+    portname(in_out_test_parameters[i].port), in_out_test_parameters[i].pin);
+    g_autofree char *in_name = g_strdup_printf(
+    "/allwinner-cubieboard/gpio/set_input_pins/%s%d",
+    portname(in_out_test_parameters[i].port), in_out_test_parameters[i].pin);
+    qtest_add_data_func(out_name, &in_out_test_parameters[i],
+                        test_set_output_pins);
+    qtest_add_data_func(in_name, &in_out_test_parameters[i],
+                        test_set_input_pins);
+  }
+  qtest_add_func("/allwinner-cubieboard/gpio/reset_values",
+                      test_reset_values);
+  for (int i = 0; i < G_N_ELEMENTS(irq_test_parameters); i++) {
+    g_autofree char *rising_edge_name = g_strdup_printf(
+    "/allwinner-cubieboard/gpio/irq_pin_rising/%s%d",
+    portname(irq_test_parameters[i].port), irq_test_parameters[i].pin);
+    qtest_add_data_func(
+            rising_edge_name, &irq_test_parameters[i], test_irq_pin_rising);
+    g_autofree char *falling_edge_name = g_strdup_printf(
+    "/allwinner-cubieboard/gpio/irq_pin_falling/%s%d",
+    portname(irq_test_parameters[i].port), irq_test_parameters[i].pin);
+    qtest_add_data_func(
+            falling_edge_name, &irq_test_parameters[i], test_irq_pin_falling);
+    g_autofree char *high_level_name = g_strdup_printf(
+    "/allwinner-cubieboard/gpio/irq_pin_high_level/%s%d",
+    portname(irq_test_parameters[i].port), irq_test_parameters[i].pin);
+    qtest_add_data_func(
+            high_level_name, &irq_test_parameters[i], test_irq_pin_high_level);
+    g_autofree char *low_level_name = g_strdup_printf(
+    "/allwinner-cubieboard/gpio/irq_pin_low_level/%s%d",
+    portname(irq_test_parameters[i].port), irq_test_parameters[i].pin);
+    qtest_add_data_func(
+            low_level_name, &irq_test_parameters[i], test_irq_pin_low_level);
+
+  }
+  r = g_test_run();
+
+  return r;
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index f7c7d06620..853f7a9c4c 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -257,7 +257,8 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') and
    config_all_devices.has_key('CONFIG_DM163')? ['dm163-test'] : []) + \
   ['arm-cpu-features',
-   'boot-serial-test']
+   'boot-serial-test'] + \
+  (config_all_devices.has_key('CONFIG_ALLWINNER_A10')? ['allwinner-gpio-test'] : [])
 
 # TODO: once aarch64 TCG is fixed on ARM 32 bit host, make bios-tables-test unconditional
 qtests_aarch64 = \

-- 
2.55.0


