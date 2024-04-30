Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95179C10F16
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qfU-0003MX-MG; Tue, 30 Apr 2024 12:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qf7-0002Rc-SI
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:49:03 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qf4-0005ei-0o
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:49:01 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-34d91612218so6319f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714495736; x=1715100536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QlwRYENlnBKv1dZPPZHdz+PmWYiGLArapVyIkT3pow0=;
 b=YZndKV0Kiqtk7eb7uOQ3hBNf3DesqG8+Z42Cv+HnRdp1g6koDyhEqPsMoYERrDJhcx
 OETAyvTIxLbcYICNAzaSeKpJpvSw363CY+U9YwYX9XEwcaWpEPYvncDbjYKcztvurtSG
 UTTRADQxzc7u25r/FWW3ncaJiEtrP0jL8LjPGo8VtK0GmyfZg7IKqGQj31TMhzCPkSMj
 8kGShBF9ReRrkXXSDpsRy/Cjs7h9rmRXbnrVpvZiFtti2XRQaP4C+wToM9gZ8jFEbNA2
 b5W4oSc8rlAPVoWDGMz0g3PuMd2w7hXdLu53m9PCyQn2PQqspGb+iH4kktBJJvKluKNO
 sHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495736; x=1715100536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QlwRYENlnBKv1dZPPZHdz+PmWYiGLArapVyIkT3pow0=;
 b=e8XDBFrvt5WfnkV4LQ1VLq4Wv0/j8gzBs9fg2SEkrcuHlks3/G7gVo5IXPc+o/nR0n
 A3YQjVK0I9ip5B+Qx8fLDMGvC+x11KayzJjF9zvWZMNKgWXC5IaIh+yLq+ri3AJEUxJ1
 2VEU3mwabOh6e1ZYirpQ7uggyV+wbi3UQnPDfuHLCielIm1r3KpP7IXyG4S1a11V0/H7
 bb4K+pYCvg6oM7T0Qs5pz8hSGMYbLnQ68k+sKRN+r0ZCk8cHCHbd361lN+rb0pZI6VVk
 dJYJiRtvDHhw4lik7zR1pjRGG6U9r8tOrlUAwQKyC8zPO1W6t3KgWAM2krguV2PW9Fp+
 PaxQ==
X-Gm-Message-State: AOJu0Yxx709vCMjpeSvMrWoMwrNxT/7bicZn3dNyAYZvSfIeNlcbKjp2
 vLs1q0v0bBJrCOSDB82VwuX3P7xhJ7NrLrFTOngpmcqnX4VfrJVRBfgM1OnfnvIVX3TGSfhCA7a
 C
X-Google-Smtp-Source: AGHT+IHONak7zQwqonTsHobX+wpJXBJeiSYYEhiTeBQfq5mhRb7Q6NRjRd9+DfcrWu/Yw+plV2Rnbw==
X-Received: by 2002:adf:eb08:0:b0:343:8485:4edd with SMTP id
 s8-20020adfeb08000000b0034384854eddmr2991837wrn.23.1714495736493; 
 Tue, 30 Apr 2024 09:48:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a05600c4e0600b0041be3383a2fsm12920384wmq.19.2024.04.30.09.48.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:48:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/21] tests/qtest : Add testcase for DM163
Date: Tue, 30 Apr 2024 17:48:42 +0100
Message-Id: <20240430164842.4074734-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430164842.4074734-1-peter.maydell@linaro.org>
References: <20240430164842.4074734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

`test_dm163_bank()`
Checks that the pin "sout" of the DM163 led driver outputs the values
received on pin "sin" with the expected latency (depending on the bank).

`test_dm163_gpio_connection()`
Check that changes to relevant STM32L4x5 GPIO pins are propagated to the
DM163 device.

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240424200929.240921-6-ines.varhol@telecom-paris.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/dm163-test.c | 194 +++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build  |   2 +
 2 files changed, 196 insertions(+)
 create mode 100644 tests/qtest/dm163-test.c

diff --git a/tests/qtest/dm163-test.c b/tests/qtest/dm163-test.c
new file mode 100644
index 00000000000..3161c9208d8
--- /dev/null
+++ b/tests/qtest/dm163-test.c
@@ -0,0 +1,194 @@
+/*
+ * QTest testcase for DM163
+ *
+ * Copyright (C) 2024 Samuel Tardieu <sam@rfc1149.net>
+ * Copyright (C) 2024 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (C) 2024 Inès Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+enum DM163_INPUTS {
+    SIN = 8,
+    DCK = 9,
+    RST_B = 10,
+    LAT_B = 11,
+    SELBK = 12,
+    EN_B = 13
+};
+
+#define DEVICE_NAME "/machine/dm163"
+#define GPIO_OUT(name, value) qtest_set_irq_in(qts, DEVICE_NAME, NULL, name,   \
+                                               value)
+#define GPIO_PULSE(name)                                                       \
+  do {                                                                         \
+    GPIO_OUT(name, 1);                                                         \
+    GPIO_OUT(name, 0);                                                         \
+  } while (0)
+
+
+static void rise_gpio_pin_dck(QTestState *qts)
+{
+    /* Configure output mode for pin PB1 */
+    qtest_writel(qts, 0x48000400, 0xFFFFFEB7);
+    /* Write 1 in ODR for PB1 */
+    qtest_writel(qts, 0x48000414, 0x00000002);
+}
+
+static void lower_gpio_pin_dck(QTestState *qts)
+{
+    /* Configure output mode for pin PB1 */
+    qtest_writel(qts, 0x48000400, 0xFFFFFEB7);
+    /* Write 0 in ODR for PB1 */
+    qtest_writel(qts, 0x48000414, 0x00000000);
+}
+
+static void rise_gpio_pin_selbk(QTestState *qts)
+{
+    /* Configure output mode for pin PC5 */
+    qtest_writel(qts, 0x48000800, 0xFFFFF7FF);
+    /* Write 1 in ODR for PC5 */
+    qtest_writel(qts, 0x48000814, 0x00000020);
+}
+
+static void lower_gpio_pin_selbk(QTestState *qts)
+{
+    /* Configure output mode for pin PC5 */
+    qtest_writel(qts, 0x48000800, 0xFFFFF7FF);
+    /* Write 0 in ODR for PC5 */
+    qtest_writel(qts, 0x48000814, 0x00000000);
+}
+
+static void rise_gpio_pin_lat_b(QTestState *qts)
+{
+    /* Configure output mode for pin PC4 */
+    qtest_writel(qts, 0x48000800, 0xFFFFFDFF);
+    /* Write 1 in ODR for PC4 */
+    qtest_writel(qts, 0x48000814, 0x00000010);
+}
+
+static void lower_gpio_pin_lat_b(QTestState *qts)
+{
+    /* Configure output mode for pin PC4 */
+    qtest_writel(qts, 0x48000800, 0xFFFFFDFF);
+    /* Write 0 in ODR for PC4 */
+    qtest_writel(qts, 0x48000814, 0x00000000);
+}
+
+static void rise_gpio_pin_rst_b(QTestState *qts)
+{
+    /* Configure output mode for pin PC3 */
+    qtest_writel(qts, 0x48000800, 0xFFFFFF7F);
+    /* Write 1 in ODR for PC3 */
+    qtest_writel(qts, 0x48000814, 0x00000008);
+}
+
+static void lower_gpio_pin_rst_b(QTestState *qts)
+{
+    /* Configure output mode for pin PC3 */
+    qtest_writel(qts, 0x48000800, 0xFFFFFF7F);
+    /* Write 0 in ODR for PC3 */
+    qtest_writel(qts, 0x48000814, 0x00000000);
+}
+
+static void rise_gpio_pin_sin(QTestState *qts)
+{
+    /* Configure output mode for pin PA4 */
+    qtest_writel(qts, 0x48000000, 0xFFFFFDFF);
+    /* Write 1 in ODR for PA4 */
+    qtest_writel(qts, 0x48000014, 0x00000010);
+}
+
+static void lower_gpio_pin_sin(QTestState *qts)
+{
+    /* Configure output mode for pin PA4 */
+    qtest_writel(qts, 0x48000000, 0xFFFFFDFF);
+    /* Write 0 in ODR for PA4 */
+    qtest_writel(qts, 0x48000014, 0x00000000);
+}
+
+static void test_dm163_bank(const void *opaque)
+{
+    const unsigned bank = (uintptr_t) opaque;
+    const int width = bank ? 192 : 144;
+
+    QTestState *qts = qtest_initf("-M b-l475e-iot01a");
+    qtest_irq_intercept_out_named(qts, DEVICE_NAME, "sout");
+    GPIO_OUT(RST_B, 1);
+    GPIO_OUT(EN_B, 0);
+    GPIO_OUT(DCK, 0);
+    GPIO_OUT(SELBK, bank);
+    GPIO_OUT(LAT_B, 1);
+
+    /* Fill bank with zeroes */
+    GPIO_OUT(SIN, 0);
+    for (int i = 0; i < width; i++) {
+        GPIO_PULSE(DCK);
+    }
+    /* Fill bank with ones, check that we get the previous zeroes */
+    GPIO_OUT(SIN, 1);
+    for (int i = 0; i < width; i++) {
+        GPIO_PULSE(DCK);
+        g_assert(!qtest_get_irq(qts, 0));
+    }
+
+    /* Pulse one more bit in the bank, check that we get a one */
+    GPIO_PULSE(DCK);
+    g_assert(qtest_get_irq(qts, 0));
+
+    qtest_quit(qts);
+}
+
+static void test_dm163_gpio_connection(void)
+{
+    QTestState *qts = qtest_init("-M b-l475e-iot01a");
+    qtest_irq_intercept_in(qts, DEVICE_NAME);
+
+    g_assert_false(qtest_get_irq(qts, SIN));
+    g_assert_false(qtest_get_irq(qts, DCK));
+    g_assert_false(qtest_get_irq(qts, RST_B));
+    g_assert_false(qtest_get_irq(qts, LAT_B));
+    g_assert_false(qtest_get_irq(qts, SELBK));
+
+    rise_gpio_pin_dck(qts);
+    g_assert_true(qtest_get_irq(qts, DCK));
+    lower_gpio_pin_dck(qts);
+    g_assert_false(qtest_get_irq(qts, DCK));
+
+    rise_gpio_pin_lat_b(qts);
+    g_assert_true(qtest_get_irq(qts, LAT_B));
+    lower_gpio_pin_lat_b(qts);
+    g_assert_false(qtest_get_irq(qts, LAT_B));
+
+    rise_gpio_pin_selbk(qts);
+    g_assert_true(qtest_get_irq(qts, SELBK));
+    lower_gpio_pin_selbk(qts);
+    g_assert_false(qtest_get_irq(qts, SELBK));
+
+    rise_gpio_pin_rst_b(qts);
+    g_assert_true(qtest_get_irq(qts, RST_B));
+    lower_gpio_pin_rst_b(qts);
+    g_assert_false(qtest_get_irq(qts, RST_B));
+
+    rise_gpio_pin_sin(qts);
+    g_assert_true(qtest_get_irq(qts, SIN));
+    lower_gpio_pin_sin(qts);
+    g_assert_false(qtest_get_irq(qts, SIN));
+
+    g_assert_false(qtest_get_irq(qts, DCK));
+    g_assert_false(qtest_get_irq(qts, LAT_B));
+    g_assert_false(qtest_get_irq(qts, SELBK));
+    g_assert_false(qtest_get_irq(qts, RST_B));
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_data_func("/dm163/bank0", (void *)0, test_dm163_bank);
+    qtest_add_data_func("/dm163/bank1", (void *)1, test_dm163_bank);
+    qtest_add_func("/dm163/gpio_connection", test_dm163_gpio_connection);
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index b128fa5a4bd..6f2f594aceb 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -224,6 +224,8 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) + \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') ? qtests_stm32l4x5 : []) + \
   (config_all_devices.has_key('CONFIG_FSI_APB2OPB_ASPEED') ? ['aspeed_fsi-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') and
+   config_all_devices.has_key('CONFIG_DM163')? ['dm163-test'] : []) + \
   ['arm-cpu-features',
    'boot-serial-test']
 
-- 
2.34.1


