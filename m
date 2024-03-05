Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EB9C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 21:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhbyI-0004NA-8N; Tue, 05 Mar 2024 16:05:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rhbyE-0004JL-JW; Tue, 05 Mar 2024 16:05:06 -0500
Received: from zproxy3.enst.fr ([2001:660:330f:2::de])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rhby8-0006fC-DT; Tue, 05 Mar 2024 16:05:06 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 1389DA0601;
 Tue,  5 Mar 2024 22:04:58 +0100 (CET)
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id l7xIm-w3K-yg; Tue,  5 Mar 2024 22:04:56 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id B8409A06C0;
 Tue,  5 Mar 2024 22:04:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy3.enst.fr B8409A06C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1709672696;
 bh=2/Yn/r4QkPIEa52osWc29+D056gaXebjouq5wHJdrFo=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=8kM1hq22rrc9uf86VnP/5U+8Ezo/WVLWhtw7wMS3mYiVXmqfSuzzdm9unZngYnPRR
 +jG0JoX8ASpyryKunXlrlwlKE7j1Tsih0PJHZ3akYOKFo+mv+ZKIGph29vEJOkHUfK
 sQ7XQjqTHWFutQZthHcpgUoMwNueFTJWhr7e1uhc=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id dznBXN-AxCKj; Tue,  5 Mar 2024 22:04:56 +0100 (CET)
Received: from localhost.localdomain (74.0.125.80.rev.sfr.net [80.125.0.74])
 by zproxy3.enst.fr (Postfix) with ESMTPSA id 17147A0601;
 Tue,  5 Mar 2024 22:04:56 +0100 (CET)
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
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v7 3/3] tests/qtest: Add STM32L4x5 GPIO QTest testcase
Date: Tue,  5 Mar 2024 22:03:12 +0100
Message-ID: <20240305210444.310665-4-ines.varhol@telecom-paris.fr>
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

The testcase contains :
- `test_idr_reset_value()` :
Checks the reset values of MODER, OTYPER, PUPDR, ODR and IDR.
- `test_gpio_output_mode()` :
Checks that writing a bit in register ODR results in the corresponding
pin rising or lowering, if this pin is configured in output mode.
- `test_gpio_input_mode()` :
Checks that a input pin set high or low externally results
in the pin rising and lowering.
- `test_pull_up_pull_down()` :
Checks that a floating pin in pull-up/down mode is actually high/down.
- `test_push_pull()` :
Checks that a pin set externally is disconnected when configured in
push-pull output mode, and can't be set externally while in this mode.
- `test_open_drain()` :
Checks that a pin set externally high is disconnected when configured
in open-drain output mode, and can't be set high while in this mode.
- `test_bsrr_brr()` :
Checks that writing to BSRR and BRR has the desired result in ODR.
- `test_clock_enable()` :
Checks that GPIO clock is at the right frequency after enabling it.

Acked-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 tests/qtest/stm32l4x5_gpio-test.c | 551 ++++++++++++++++++++++++++++++
 tests/qtest/meson.build           |   3 +-
 2 files changed, 553 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/stm32l4x5_gpio-test.c

diff --git a/tests/qtest/stm32l4x5_gpio-test.c b/tests/qtest/stm32l4x5_gp=
io-test.c
new file mode 100644
index 0000000000..cc56be2031
--- /dev/null
+++ b/tests/qtest/stm32l4x5_gpio-test.c
@@ -0,0 +1,551 @@
+/*
+ * QTest testcase for STM32L4x5_GPIO
+ *
+ * Copyright (c) 2024 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2024 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+
+#define GPIO_BASE_ADDR 0x48000000
+#define GPIO_SIZE      0x400
+#define NUM_GPIOS      8
+#define NUM_GPIO_PINS  16
+
+#define GPIO_A 0x48000000
+#define GPIO_B 0x48000400
+#define GPIO_C 0x48000800
+#define GPIO_D 0x48000C00
+#define GPIO_E 0x48001000
+#define GPIO_F 0x48001400
+#define GPIO_G 0x48001800
+#define GPIO_H 0x48001C00
+
+#define MODER 0x00
+#define OTYPER 0x04
+#define PUPDR 0x0C
+#define IDR 0x10
+#define ODR 0x14
+#define BSRR 0x18
+#define BRR 0x28
+
+#define MODER_INPUT 0
+#define MODER_OUTPUT 1
+
+#define PUPDR_NONE 0
+#define PUPDR_PULLUP 1
+#define PUPDR_PULLDOWN 2
+
+#define OTYPER_PUSH_PULL 0
+#define OTYPER_OPEN_DRAIN 1
+
+const uint32_t moder_reset[NUM_GPIOS] =3D {
+    0xABFFFFFF,
+    0xFFFFFEBF,
+    0xFFFFFFFF,
+    0xFFFFFFFF,
+    0xFFFFFFFF,
+    0xFFFFFFFF,
+    0xFFFFFFFF,
+    0x0000000F
+};
+
+const uint32_t pupdr_reset[NUM_GPIOS] =3D {
+    0x64000000,
+    0x00000100,
+    0x00000000,
+    0x00000000,
+    0x00000000,
+    0x00000000,
+    0x00000000,
+    0x00000000
+};
+
+const uint32_t idr_reset[NUM_GPIOS] =3D {
+    0x0000A000,
+    0x00000010,
+    0x00000000,
+    0x00000000,
+    0x00000000,
+    0x00000000,
+    0x00000000,
+    0x00000000
+};
+
+static uint32_t gpio_readl(unsigned int gpio, unsigned int offset)
+{
+    return readl(gpio + offset);
+}
+
+static void gpio_writel(unsigned int gpio, unsigned int offset, uint32_t=
 value)
+{
+    writel(gpio + offset, value);
+}
+
+static void gpio_set_bit(unsigned int gpio, unsigned int reg,
+                         unsigned int pin, uint32_t value)
+{
+    uint32_t mask =3D 0xFFFFFFFF & ~(0x1 << pin);
+    gpio_writel(gpio, reg, (gpio_readl(gpio, reg) & mask) | value << pin=
);
+}
+
+static void gpio_set_2bits(unsigned int gpio, unsigned int reg,
+                           unsigned int pin, uint32_t value)
+{
+    uint32_t offset =3D 2 * pin;
+    uint32_t mask =3D 0xFFFFFFFF & ~(0x3 << offset);
+    gpio_writel(gpio, reg, (gpio_readl(gpio, reg) & mask) | value << off=
set);
+}
+
+static unsigned int get_gpio_id(uint32_t gpio_addr)
+{
+    return (gpio_addr - GPIO_BASE_ADDR) / GPIO_SIZE;
+}
+
+static void gpio_set_irq(unsigned int gpio, int num, int level)
+{
+    g_autofree char *name =3D g_strdup_printf("/machine/soc/gpio%c",
+                                            get_gpio_id(gpio) + 'a');
+    qtest_set_irq_in(global_qtest, name, NULL, num, level);
+}
+
+static void disconnect_all_pins(unsigned int gpio)
+{
+    g_autofree char *path =3D g_strdup_printf("/machine/soc/gpio%c",
+                                            get_gpio_id(gpio) + 'a');
+    QDict *r;
+
+    r =3D qtest_qmp(global_qtest, "{ 'execute': 'qom-set', 'arguments': =
"
+        "{ 'path': %s, 'property': 'disconnected-pins', 'value': %d } }"=
,
+        path, 0xFFFF);
+    g_assert_false(qdict_haskey(r, "error"));
+    qobject_unref(r);
+}
+
+static uint32_t get_disconnected_pins(unsigned int gpio)
+{
+    g_autofree char *path =3D g_strdup_printf("/machine/soc/gpio%c",
+                                            get_gpio_id(gpio) + 'a');
+    uint32_t disconnected_pins =3D 0;
+    QDict *r;
+
+    r =3D qtest_qmp(global_qtest, "{ 'execute': 'qom-get', 'arguments':"
+        " { 'path': %s, 'property': 'disconnected-pins'} }", path);
+    g_assert_false(qdict_haskey(r, "error"));
+    disconnected_pins =3D qdict_get_int(r, "return");
+    qobject_unref(r);
+    return disconnected_pins;
+}
+
+static uint32_t reset(uint32_t gpio, unsigned int offset)
+{
+    switch (offset) {
+    case MODER:
+        return moder_reset[get_gpio_id(gpio)];
+    case PUPDR:
+        return pupdr_reset[get_gpio_id(gpio)];
+    case IDR:
+        return idr_reset[get_gpio_id(gpio)];
+    }
+    return 0x0;
+}
+
+static void system_reset(void)
+{
+    QDict *r;
+    r =3D qtest_qmp(global_qtest, "{'execute': 'system_reset'}");
+    g_assert_false(qdict_haskey(r, "error"));
+    qobject_unref(r);
+}
+
+static void test_idr_reset_value(void)
+{
+    /*
+     * Checks that the values in MODER, OTYPER, PUPDR and ODR
+     * after reset are correct, and that the value in IDR is
+     * coherent.
+     * Since AF and analog modes aren't implemented, IDR reset
+     * values aren't the same as with a real board.
+     *
+     * Register IDR contains the actual values of all GPIO pins.
+     * Its value depends on the pins' configuration
+     * (intput/output/analog : register MODER, push-pull/open-drain :
+     * register OTYPER, pull-up/pull-down/none : register PUPDR)
+     * and on the values stored in register ODR
+     * (in case the pin is in output mode).
+     */
+
+    gpio_writel(GPIO_A, MODER, 0xDEADBEEF);
+    gpio_writel(GPIO_A, ODR, 0xDEADBEEF);
+    gpio_writel(GPIO_A, OTYPER, 0xDEADBEEF);
+    gpio_writel(GPIO_A, PUPDR, 0xDEADBEEF);
+
+    gpio_writel(GPIO_B, MODER, 0xDEADBEEF);
+    gpio_writel(GPIO_B, ODR, 0xDEADBEEF);
+    gpio_writel(GPIO_B, OTYPER, 0xDEADBEEF);
+    gpio_writel(GPIO_B, PUPDR, 0xDEADBEEF);
+
+    gpio_writel(GPIO_C, MODER, 0xDEADBEEF);
+    gpio_writel(GPIO_C, ODR, 0xDEADBEEF);
+    gpio_writel(GPIO_C, OTYPER, 0xDEADBEEF);
+    gpio_writel(GPIO_C, PUPDR, 0xDEADBEEF);
+
+    gpio_writel(GPIO_H, MODER, 0xDEADBEEF);
+    gpio_writel(GPIO_H, ODR, 0xDEADBEEF);
+    gpio_writel(GPIO_H, OTYPER, 0xDEADBEEF);
+    gpio_writel(GPIO_H, PUPDR, 0xDEADBEEF);
+
+    system_reset();
+
+    uint32_t moder =3D gpio_readl(GPIO_A, MODER);
+    uint32_t odr =3D gpio_readl(GPIO_A, ODR);
+    uint32_t otyper =3D gpio_readl(GPIO_A, OTYPER);
+    uint32_t pupdr =3D gpio_readl(GPIO_A, PUPDR);
+    uint32_t idr =3D gpio_readl(GPIO_A, IDR);
+    /* 15: AF, 14: AF, 13: AF, 12: Analog ... */
+    /* here AF is the same as Analog and Input mode */
+    g_assert_cmphex(moder, =3D=3D, reset(GPIO_A, MODER));
+    g_assert_cmphex(odr, =3D=3D, reset(GPIO_A, ODR));
+    g_assert_cmphex(otyper, =3D=3D, reset(GPIO_A, OTYPER));
+    /* 15: pull-up, 14: pull-down, 13: pull-up, 12: neither ... */
+    g_assert_cmphex(pupdr, =3D=3D, reset(GPIO_A, PUPDR));
+    /* 15 : 1, 14: 0, 13: 1, 12 : reset value ... */
+    g_assert_cmphex(idr, =3D=3D, reset(GPIO_A, IDR));
+
+    moder =3D gpio_readl(GPIO_B, MODER);
+    odr =3D gpio_readl(GPIO_B, ODR);
+    otyper =3D gpio_readl(GPIO_B, OTYPER);
+    pupdr =3D gpio_readl(GPIO_B, PUPDR);
+    idr =3D gpio_readl(GPIO_B, IDR);
+    /* ... 5: Analog, 4: AF, 3: AF, 2: Analog ... */
+    /* here AF is the same as Analog and Input mode */
+    g_assert_cmphex(moder, =3D=3D, reset(GPIO_B, MODER));
+    g_assert_cmphex(odr, =3D=3D, reset(GPIO_B, ODR));
+    g_assert_cmphex(otyper, =3D=3D, reset(GPIO_B, OTYPER));
+    /* ... 5: neither, 4: pull-up, 3: neither ... */
+    g_assert_cmphex(pupdr, =3D=3D, reset(GPIO_B, PUPDR));
+    /* ... 5 : reset value, 4 : 1, 3 : reset value ... */
+    g_assert_cmphex(idr, =3D=3D, reset(GPIO_B, IDR));
+
+    moder =3D gpio_readl(GPIO_C, MODER);
+    odr =3D gpio_readl(GPIO_C, ODR);
+    otyper =3D gpio_readl(GPIO_C, OTYPER);
+    pupdr =3D gpio_readl(GPIO_C, PUPDR);
+    idr =3D gpio_readl(GPIO_C, IDR);
+    /* Analog, same as Input mode*/
+    g_assert_cmphex(moder, =3D=3D, reset(GPIO_C, MODER));
+    g_assert_cmphex(odr, =3D=3D, reset(GPIO_C, ODR));
+    g_assert_cmphex(otyper, =3D=3D, reset(GPIO_C, OTYPER));
+    /* no pull-up or pull-down */
+    g_assert_cmphex(pupdr, =3D=3D, reset(GPIO_C, PUPDR));
+    /* reset value */
+    g_assert_cmphex(idr, =3D=3D, reset(GPIO_C, IDR));
+
+    moder =3D gpio_readl(GPIO_H, MODER);
+    odr =3D gpio_readl(GPIO_H, ODR);
+    otyper =3D gpio_readl(GPIO_H, OTYPER);
+    pupdr =3D gpio_readl(GPIO_H, PUPDR);
+    idr =3D gpio_readl(GPIO_H, IDR);
+    /* Analog, same as Input mode */
+    g_assert_cmphex(moder, =3D=3D, reset(GPIO_H, MODER));
+    g_assert_cmphex(odr, =3D=3D, reset(GPIO_H, ODR));
+    g_assert_cmphex(otyper, =3D=3D, reset(GPIO_H, OTYPER));
+    /* no pull-up or pull-down */
+    g_assert_cmphex(pupdr, =3D=3D, reset(GPIO_H, PUPDR));
+    /* reset value */
+    g_assert_cmphex(idr, =3D=3D, reset(GPIO_H, IDR));
+}
+
+static void test_gpio_output_mode(const void *data)
+{
+    /*
+     * Checks that setting a bit in ODR sets the corresponding
+     * GPIO line high : it should set the right bit in IDR
+     * and send an irq to syscfg.
+     * Additionally, it checks that values written to ODR
+     * when not in output mode are stored and not discarded.
+     */
+    unsigned int pin =3D ((uint64_t)data) & 0xF;
+    uint32_t gpio =3D ((uint64_t)data) >> 32;
+    unsigned int gpio_id =3D get_gpio_id(gpio);
+
+    qtest_irq_intercept_in(global_qtest, "/machine/soc/syscfg");
+
+    /* Set a bit in ODR and check nothing happens */
+    gpio_set_bit(gpio, ODR, pin, 1);
+    g_assert_cmphex(gpio_readl(gpio, IDR), =3D=3D, reset(gpio, IDR));
+    g_assert_false(get_irq(gpio_id * NUM_GPIO_PINS + pin));
+
+    /* Configure the relevant line as output and check the pin is high *=
/
+    gpio_set_2bits(gpio, MODER, pin, MODER_OUTPUT);
+    g_assert_cmphex(gpio_readl(gpio, IDR), =3D=3D, reset(gpio, IDR) | (1=
 << pin));
+    g_assert_true(get_irq(gpio_id * NUM_GPIO_PINS + pin));
+
+    /* Reset the bit in ODR and check the pin is low */
+    gpio_set_bit(gpio, ODR, pin, 0);
+    g_assert_cmphex(gpio_readl(gpio, IDR), =3D=3D, reset(gpio, IDR) & ~(=
1 << pin));
+    g_assert_false(get_irq(gpio_id * NUM_GPIO_PINS + pin));
+
+    /* Clean the test */
+    gpio_writel(gpio, ODR, reset(gpio, ODR));
+    gpio_writel(gpio, MODER, reset(gpio, MODER));
+    g_assert_cmphex(gpio_readl(gpio, IDR), =3D=3D, reset(gpio, IDR));
+    g_assert_false(get_irq(gpio_id * NUM_GPIO_PINS + pin));
+}
+
+static void test_gpio_input_mode(const void *data)
+{
+    /*
+     * Test that setting a line high/low externally sets the
+     * corresponding GPIO line high/low : it should set the
+     * right bit in IDR and send an irq to syscfg.
+     */
+    unsigned int pin =3D ((uint64_t)data) & 0xF;
+    uint32_t gpio =3D ((uint64_t)data) >> 32;
+    unsigned int gpio_id =3D get_gpio_id(gpio);
+
+    qtest_irq_intercept_in(global_qtest, "/machine/soc/syscfg");
+
+    /* Configure a line as input, raise it, and check that the pin is hi=
gh */
+    gpio_set_2bits(gpio, MODER, pin, MODER_INPUT);
+    gpio_set_irq(gpio, pin, 1);
+    g_assert_cmphex(gpio_readl(gpio, IDR), =3D=3D, reset(gpio, IDR) | (1=
 << pin));
+    g_assert_true(get_irq(gpio_id * NUM_GPIO_PINS + pin));
+
+    /* Lower the line and check that the pin is low */
+    gpio_set_irq(gpio, pin, 0);
+    g_assert_cmphex(gpio_readl(gpio, IDR), =3D=3D, reset(gpio, IDR) & ~(=
1 << pin));
+    g_assert_false(get_irq(gpio_id * NUM_GPIO_PINS + pin));
+
+    /* Clean the test */
+    gpio_writel(gpio, MODER, reset(gpio, MODER));
+    disconnect_all_pins(gpio);
+    g_assert_cmphex(gpio_readl(gpio, IDR), =3D=3D, reset(gpio, IDR));
+}
+
+static void test_pull_up_pull_down(const void *data)
+{
+    /*
+     * Test that a floating pin with pull-up sets the pin
+     * high and vice-versa.
+     */
+    unsigned int pin =3D ((uint64_t)data) & 0xF;
+    uint32_t gpio =3D ((uint64_t)data) >> 32;
+    unsigned int gpio_id =3D get_gpio_id(gpio);
+
+    qtest_irq_intercept_in(global_qtest, "/machine/soc/syscfg");
+
+    /* Configure a line as input with pull-up, check the line is set hig=
h */
+    gpio_set_2bits(gpio, MODER, pin, MODER_INPUT);
+    gpio_set_2bits(gpio, PUPDR, pin, PUPDR_PULLUP);
+    g_assert_cmphex(gpio_readl(gpio, IDR), =3D=3D, reset(gpio, IDR) | (1=
 << pin));
+    g_assert_true(get_irq(gpio_id * NUM_GPIO_PINS + pin));
+
+    /* Configure the line with pull-down, check the line is low */
+    gpio_set_2bits(gpio, PUPDR, pin, PUPDR_PULLDOWN);
+    g_assert_cmphex(gpio_readl(gpio, IDR), =3D=3D, reset(gpio, IDR) & ~(=
1 << pin));
+    g_assert_false(get_irq(gpio_id * NUM_GPIO_PINS + pin));
+
+    /* Clean the test */
+    gpio_writel(gpio, MODER, reset(gpio, MODER));
+    gpio_writel(gpio, PUPDR, reset(gpio, PUPDR));
+    g_assert_cmphex(gpio_readl(gpio, IDR), =3D=3D, reset(gpio, IDR));
+}
+
+static void test_push_pull(const void *data)
+{
+    /*
+     * Test that configuring a line in push-pull output mode
+     * disconnects the pin, that the pin can't be set or reset
+     * externally afterwards.
+     */
+    unsigned int pin =3D ((uint64_t)data) & 0xF;
+    uint32_t gpio =3D ((uint64_t)data) >> 32;
+    uint32_t gpio2 =3D GPIO_BASE_ADDR + (GPIO_H - gpio);
+
+    qtest_irq_intercept_in(global_qtest, "/machine/soc/syscfg");
+
+    /* Setting a line high externally, configuring it in push-pull outpu=
t */
+    /* And checking the pin was disconnected */
+    gpio_set_irq(gpio, pin, 1);
+    gpio_set_2bits(gpio, MODER, pin, MODER_OUTPUT);
+    g_assert_cmphex(get_disconnected_pins(gpio), =3D=3D, 0xFFFF);
+    g_assert_cmphex(gpio_readl(gpio, IDR), =3D=3D, reset(gpio, IDR) & ~(=
1 << pin));
+
+    /* Setting a line low externally, configuring it in push-pull output=
 */
+    /* And checking the pin was disconnected */
+    gpio_set_irq(gpio2, pin, 0);
+    gpio_set_bit(gpio2, ODR, pin, 1);
+    gpio_set_2bits(gpio2, MODER, pin, MODER_OUTPUT);
+    g_assert_cmphex(get_disconnected_pins(gpio2), =3D=3D, 0xFFFF);
+    g_assert_cmphex(gpio_readl(gpio2, IDR), =3D=3D, reset(gpio2, IDR) | =
(1 << pin));
+
+    /* Trying to set a push-pull output pin, checking it doesn't work */
+    gpio_set_irq(gpio, pin, 1);
+    g_assert_cmphex(get_disconnected_pins(gpio), =3D=3D, 0xFFFF);
+    g_assert_cmphex(gpio_readl(gpio, IDR), =3D=3D, reset(gpio, IDR) & ~(=
1 << pin));
+
+    /* Trying to reset a push-pull output pin, checking it doesn't work =
*/
+    gpio_set_irq(gpio2, pin, 0);
+    g_assert_cmphex(get_disconnected_pins(gpio2), =3D=3D, 0xFFFF);
+    g_assert_cmphex(gpio_readl(gpio2, IDR), =3D=3D, reset(gpio2, IDR) | =
(1 << pin));
+
+    /* Clean the test */
+    gpio_writel(gpio, MODER, reset(gpio, MODER));
+    gpio_writel(gpio2, ODR, reset(gpio2, ODR));
+    gpio_writel(gpio2, MODER, reset(gpio2, MODER));
+}
+
+static void test_open_drain(const void *data)
+{
+    /*
+     * Test that configuring a line in open-drain output mode
+     * disconnects a pin set high externally and that the pin
+     * can't be set high externally while configured in open-drain.
+     *
+     * However a pin set low externally shouldn't be disconnected,
+     * and it can be set low externally when in open-drain mode.
+     */
+    unsigned int pin =3D ((uint64_t)data) & 0xF;
+    uint32_t gpio =3D ((uint64_t)data) >> 32;
+    uint32_t gpio2 =3D GPIO_BASE_ADDR + (GPIO_H - gpio);
+
+    qtest_irq_intercept_in(global_qtest, "/machine/soc/syscfg");
+
+    /* Setting a line high externally, configuring it in open-drain outp=
ut */
+    /* And checking the pin was disconnected */
+    gpio_set_irq(gpio, pin, 1);
+    gpio_set_bit(gpio, OTYPER, pin, OTYPER_OPEN_DRAIN);
+    gpio_set_2bits(gpio, MODER, pin, MODER_OUTPUT);
+    g_assert_cmphex(get_disconnected_pins(gpio), =3D=3D, 0xFFFF);
+    g_assert_cmphex(gpio_readl(gpio, IDR), =3D=3D, reset(gpio, IDR) & ~(=
1 << pin));
+
+    /* Setting a line low externally, configuring it in open-drain outpu=
t */
+    /* And checking the pin wasn't disconnected */
+    gpio_set_irq(gpio2, pin, 0);
+    gpio_set_bit(gpio2, ODR, pin, 1);
+    gpio_set_bit(gpio2, OTYPER, pin, OTYPER_OPEN_DRAIN);
+    gpio_set_2bits(gpio2, MODER, pin, MODER_OUTPUT);
+    g_assert_cmphex(get_disconnected_pins(gpio2), =3D=3D, 0xFFFF & ~(1 <=
< pin));
+    g_assert_cmphex(gpio_readl(gpio2, IDR), =3D=3D,
+                               reset(gpio2, IDR) & ~(1 << pin));
+
+    /* Trying to set a open-drain output pin, checking it doesn't work *=
/
+    gpio_set_irq(gpio, pin, 1);
+    g_assert_cmphex(get_disconnected_pins(gpio), =3D=3D, 0xFFFF);
+    g_assert_cmphex(gpio_readl(gpio, IDR), =3D=3D, reset(gpio, IDR) & ~(=
1 << pin));
+
+    /* Trying to reset a open-drain output pin, checking it works */
+    gpio_set_bit(gpio, ODR, pin, 1);
+    gpio_set_irq(gpio, pin, 0);
+    g_assert_cmphex(get_disconnected_pins(gpio2), =3D=3D, 0xFFFF & ~(1 <=
< pin));
+    g_assert_cmphex(gpio_readl(gpio2, IDR), =3D=3D,
+                               reset(gpio2, IDR) & ~(1 << pin));
+
+    /* Clean the test */
+    disconnect_all_pins(gpio2);
+    gpio_writel(gpio2, OTYPER, reset(gpio2, OTYPER));
+    gpio_writel(gpio2, ODR, reset(gpio2, ODR));
+    gpio_writel(gpio2, MODER, reset(gpio2, MODER));
+    g_assert_cmphex(gpio_readl(gpio2, IDR), =3D=3D, reset(gpio2, IDR));
+    disconnect_all_pins(gpio);
+    gpio_writel(gpio, OTYPER, reset(gpio, OTYPER));
+    gpio_writel(gpio, ODR, reset(gpio, ODR));
+    gpio_writel(gpio, MODER, reset(gpio, MODER));
+    g_assert_cmphex(gpio_readl(gpio, IDR), =3D=3D, reset(gpio, IDR));
+}
+
+static void test_bsrr_brr(const void *data)
+{
+    /*
+     * Test that writing a '1' in BSS and BSRR
+     * has the desired effect on ODR.
+     * In BSRR, BSx has priority over BRx.
+     */
+    unsigned int pin =3D ((uint64_t)data) & 0xF;
+    uint32_t gpio =3D ((uint64_t)data) >> 32;
+
+    gpio_writel(gpio, BSRR, (1 << pin));
+    g_assert_cmphex(gpio_readl(gpio, ODR), =3D=3D, reset(gpio, ODR) | (1=
 << pin));
+
+    gpio_writel(gpio, BSRR, (1 << (pin + NUM_GPIO_PINS)));
+    g_assert_cmphex(gpio_readl(gpio, ODR), =3D=3D, reset(gpio, ODR));
+
+    gpio_writel(gpio, BSRR, (1 << pin));
+    g_assert_cmphex(gpio_readl(gpio, ODR), =3D=3D, reset(gpio, ODR) | (1=
 << pin));
+
+    gpio_writel(gpio, BRR, (1 << pin));
+    g_assert_cmphex(gpio_readl(gpio, ODR), =3D=3D, reset(gpio, ODR));
+
+    /* BSx should have priority over BRx */
+    gpio_writel(gpio, BSRR, (1 << pin) | (1 << (pin + NUM_GPIO_PINS)));
+    g_assert_cmphex(gpio_readl(gpio, ODR), =3D=3D, reset(gpio, ODR) | (1=
 << pin));
+
+    gpio_writel(gpio, BRR, (1 << pin));
+    g_assert_cmphex(gpio_readl(gpio, ODR), =3D=3D, reset(gpio, ODR));
+
+    gpio_writel(gpio, ODR, reset(gpio, ODR));
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+    g_test_set_nonfatal_assertions();
+    qtest_add_func("stm32l4x5/gpio/test_idr_reset_value",
+                   test_idr_reset_value);
+    /*
+     * The inputs for the tests (gpio and pin) can be changed,
+     * but the tests don't work for pins that are high at reset
+     * (GPIOA15, GPIO13 and GPIOB5).
+     * Specifically, rising the pin then checking `get_irq()`
+     * is problematic since the pin was already high.
+     */
+    qtest_add_data_func("stm32l4x5/gpio/test_gpioc5_output_mode",
+                        (void *)((uint64_t)GPIO_C << 32 | 5),
+                        test_gpio_output_mode);
+    qtest_add_data_func("stm32l4x5/gpio/test_gpioh3_output_mode",
+                        (void *)((uint64_t)GPIO_H << 32 | 3),
+                        test_gpio_output_mode);
+    qtest_add_data_func("stm32l4x5/gpio/test_gpio_input_mode1",
+                        (void *)((uint64_t)GPIO_D << 32 | 6),
+                        test_gpio_input_mode);
+    qtest_add_data_func("stm32l4x5/gpio/test_gpio_input_mode2",
+                        (void *)((uint64_t)GPIO_C << 32 | 10),
+                        test_gpio_input_mode);
+    qtest_add_data_func("stm32l4x5/gpio/test_gpio_pull_up_pull_down1",
+                        (void *)((uint64_t)GPIO_B << 32 | 5),
+                        test_pull_up_pull_down);
+    qtest_add_data_func("stm32l4x5/gpio/test_gpio_pull_up_pull_down2",
+                        (void *)((uint64_t)GPIO_F << 32 | 1),
+                        test_pull_up_pull_down);
+    qtest_add_data_func("stm32l4x5/gpio/test_gpio_push_pull1",
+                        (void *)((uint64_t)GPIO_G << 32 | 6),
+                        test_push_pull);
+    qtest_add_data_func("stm32l4x5/gpio/test_gpio_push_pull2",
+                        (void *)((uint64_t)GPIO_H << 32 | 3),
+                        test_push_pull);
+    qtest_add_data_func("stm32l4x5/gpio/test_gpio_open_drain1",
+                        (void *)((uint64_t)GPIO_C << 32 | 4),
+                        test_open_drain);
+    qtest_add_data_func("stm32l4x5/gpio/test_gpio_open_drain2",
+                        (void *)((uint64_t)GPIO_E << 32 | 11),
+                        test_open_drain);
+    qtest_add_data_func("stm32l4x5/gpio/test_bsrr_brr1",
+                        (void *)((uint64_t)GPIO_A << 32 | 12),
+                        test_bsrr_brr);
+    qtest_add_data_func("stm32l4x5/gpio/test_bsrr_brr2",
+                        (void *)((uint64_t)GPIO_D << 32 | 0),
+                        test_bsrr_brr);
+
+    qtest_start("-machine b-l475e-iot01a");
+    ret =3D g_test_run();
+    qtest_end();
+
+    return ret;
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 31b9f4ede4..36c5c13a7b 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -204,7 +204,8 @@ qtests_aspeed =3D \
 qtests_stm32l4x5 =3D \
   ['stm32l4x5_exti-test',
    'stm32l4x5_syscfg-test',
-   'stm32l4x5_rcc-test']
+   'stm32l4x5_rcc-test',
+   'stm32l4x5_gpio-test']
=20
 qtests_arm =3D \
   (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) =
+ \
--=20
2.43.2


