Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A66C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhVEy-00029t-TK; Tue, 05 Mar 2024 08:53:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVE0-0000xR-F6
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:53:09 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVDq-0005y2-GE
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:52:56 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33e17fc5aceso2809900f8f.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709646765; x=1710251565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vOhlpnaKiIrRTqIJyTUzsqtsVnUpM/KK2Ic7nx0Sh9Y=;
 b=yOuA8s/dbp0qDXLV5edxebPSQDbt8GK3tVkoZxqruEFzSoz9n8o8/frg3qa6yAYKSE
 EcerqsSzaDAjJZAzy8AAfASXrhv3q/kiuJqHcptFUTanKjLpMPCLzJ+CIDx5eTEZrTh/
 KEasIy6i5KFGejRfm0TD8nJvD4YjTFrUUOnGUn4ZU4HMmLYzIYRJMbPEzCPDn3OUhfRM
 oQxUMbvj5ChfP83pJ2uKEPeS3wWs89ZAiHN546DuhwYORNvVWK9Cky0v8s/pab4dOlKg
 Upa3z2Ekx9oTdaAAwcL/+zqKx92Q2prHj40wHAdYNK6sw3KrHtyuKSh0fVLUbdjA50+d
 oGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646765; x=1710251565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vOhlpnaKiIrRTqIJyTUzsqtsVnUpM/KK2Ic7nx0Sh9Y=;
 b=ilIxBsQ01+wMoApC5MuVmJlpfmzRRy6iAk/udu9lksGJSSyRU4Ofu8oLjDBbwvRrpE
 eZAOp17Zy39IV5GaWUQGA83jK0o/QAmmbUCyAcQTzp/ks5BVWSUF5Wu3YZroKZV3mP7b
 iiBjXqkNMprXavM71T2Ez7cspsAbeJ6H+FYGohbdqzhAKQB+D68qic/1fNCMFIccZRX0
 3VhMKYsGqz4rJay5mCgeTu6CrFMfN+D/k58kywweVtDQZ683WZGqIIxhyg8k+YG8fLUJ
 3AQ0+W2Sk8VQgqZvcXWZ6cKbGS/mvaphNzDRSicrBbgebhxP+BpUmXkkNEY9RXWtqIEr
 XXzA==
X-Gm-Message-State: AOJu0YyT0f+a8J5t/7f2b/nGNp4+qC+ApqmrTOSaKO7hel/WwjngqTzQ
 HCnW/nCUf+Q4e7bfodN/a72rMZ+OOoH28JFsBm9lurLouQmXH1vSEsiZ3AldyOBUtDLfEx/sTds
 l
X-Google-Smtp-Source: AGHT+IH81vnmpCX1h++MpYkRjnTasMN6vldyHEubxFyBF4bpo7tVC33tkdtResnTJpOCwZTHjBZ0DA==
X-Received: by 2002:adf:9dc9:0:b0:33e:2219:9804 with SMTP id
 q9-20020adf9dc9000000b0033e22199804mr1922498wre.25.1709646764694; 
 Tue, 05 Mar 2024 05:52:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a5d6503000000b0033e206a0a7asm11797532wru.26.2024.03.05.05.52.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 05:52:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/20] tests/qtest/stm32l4x5_rcc-test.c: Add tests for the
 STM32L4x5_RCC
Date: Tue,  5 Mar 2024 13:52:29 +0000
Message-Id: <20240305135237.3111642-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305135237.3111642-1-peter.maydell@linaro.org>
References: <20240305135237.3111642-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

From: Arnaud Minier <arnaud.minier@telecom-paris.fr>

Tests:
- the ability to change the sysclk of the device
- the ability to enable/disable/configure the PLLs
- if the clock multiplexers work
- the register flags and the generation of irqs

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Acked-by: Thomas Huth <thuth@redhat.com>
Message-id: 20240303140643.81957-9-arnaud.minier@telecom-paris.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/stm32l4x5_rcc-test.c | 189 +++++++++++++++++++++++++++++++
 tests/qtest/meson.build          |   3 +-
 2 files changed, 191 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/stm32l4x5_rcc-test.c

diff --git a/tests/qtest/stm32l4x5_rcc-test.c b/tests/qtest/stm32l4x5_rcc-test.c
new file mode 100644
index 00000000000..d927c655d13
--- /dev/null
+++ b/tests/qtest/stm32l4x5_rcc-test.c
@@ -0,0 +1,189 @@
+/*
+ * QTest testcase for STM32L4x5_RCC
+ *
+ * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2023 Inès Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/registerfields.h"
+#include "libqtest-single.h"
+#include "hw/misc/stm32l4x5_rcc_internals.h"
+
+#define RCC_BASE_ADDR 0x40021000
+#define NVIC_ISER 0xE000E100
+#define NVIC_ISPR 0xE000E200
+#define NVIC_ICPR 0xE000E280
+#define RCC_IRQ 5
+
+static void enable_nvic_irq(unsigned int n)
+{
+    writel(NVIC_ISER, 1 << n);
+}
+
+static void unpend_nvic_irq(unsigned int n)
+{
+    writel(NVIC_ICPR, 1 << n);
+}
+
+static bool check_nvic_pending(unsigned int n)
+{
+    return readl(NVIC_ISPR) & (1 << n);
+}
+
+static void rcc_writel(unsigned int offset, uint32_t value)
+{
+    writel(RCC_BASE_ADDR + offset, value);
+}
+
+static uint32_t rcc_readl(unsigned int offset)
+{
+    return readl(RCC_BASE_ADDR + offset);
+}
+
+static void test_init_msi(void)
+{
+    /* MSIRANGE can be set only when MSI is OFF or READY */
+    rcc_writel(A_CR, R_CR_MSION_MASK);
+    /* Wait until MSI is stable */
+    g_assert_true((rcc_readl(A_CR) & R_CR_MSIRDY_MASK) == R_CR_MSIRDY_MASK);
+    /* TODO find a way to test MSI value */
+}
+
+static void test_set_msi_as_sysclk(void)
+{
+    /* Clocking from MSI, in case MSI was not the default source */
+    rcc_writel(A_CFGR, 0);
+    /* Wait until MSI is selected and stable */
+    g_assert_true((rcc_readl(A_CFGR) & R_CFGR_SWS_MASK) == 0);
+}
+
+static void test_init_pll(void)
+{
+    uint32_t value;
+
+    /*
+     * Update PLL and set MSI as the source clock.
+     * PLLM = 1 --> 000
+     * PLLN = 40 --> 40
+     * PPLLR = 2 --> 00
+     * PLLDIV = unused, PLLP = unused (SAI3), PLLQ = unused (48M1)
+     * SRC = MSI --> 01
+     */
+    rcc_writel(A_PLLCFGR, R_PLLCFGR_PLLREN_MASK |
+            (40 << R_PLLCFGR_PLLN_SHIFT) |
+            (0b01 << R_PLLCFGR_PLLSRC_SHIFT));
+
+    /* PLL activation */
+    value = rcc_readl(A_CR);
+    rcc_writel(A_CR, value | R_CR_PLLON_MASK);
+
+    /* Waiting for PLL lock. */
+    g_assert_true((rcc_readl(A_CR) & R_CR_PLLRDY_MASK) == R_CR_PLLRDY_MASK);
+
+    /* Switches on the PLL clock source */
+    value = rcc_readl(A_CFGR);
+    rcc_writel(A_CFGR, (value & ~R_CFGR_SW_MASK) |
+        (0b11 << R_CFGR_SW_SHIFT));
+
+    /* Wait until SYSCLK is stable. */
+    g_assert_true((rcc_readl(A_CFGR) & R_CFGR_SWS_MASK) ==
+        (0b11 << R_CFGR_SWS_SHIFT));
+}
+
+static void test_activate_lse(void)
+{
+    /* LSE activation, no LSE Bypass */
+    rcc_writel(A_BDCR, R_BDCR_LSEDRV_MASK | R_BDCR_LSEON_MASK);
+    g_assert_true((rcc_readl(A_BDCR) & R_BDCR_LSERDY_MASK) == R_BDCR_LSERDY_MASK);
+}
+
+static void test_irq(void)
+{
+    enable_nvic_irq(RCC_IRQ);
+
+    rcc_writel(A_CIER, R_CIER_LSIRDYIE_MASK);
+    rcc_writel(A_CSR, R_CSR_LSION_MASK);
+    g_assert_true(check_nvic_pending(RCC_IRQ));
+    rcc_writel(A_CICR, R_CICR_LSIRDYC_MASK);
+    unpend_nvic_irq(RCC_IRQ);
+
+    rcc_writel(A_CIER, R_CIER_LSERDYIE_MASK);
+    rcc_writel(A_BDCR, R_BDCR_LSEON_MASK);
+    g_assert_true(check_nvic_pending(RCC_IRQ));
+    rcc_writel(A_CICR, R_CICR_LSERDYC_MASK);
+    unpend_nvic_irq(RCC_IRQ);
+
+    /*
+     * MSI has been enabled by previous tests,
+     * shouln't generate an interruption.
+     */
+    rcc_writel(A_CIER, R_CIER_MSIRDYIE_MASK);
+    rcc_writel(A_CR, R_CR_MSION_MASK);
+    g_assert_false(check_nvic_pending(RCC_IRQ));
+
+    rcc_writel(A_CIER, R_CIER_HSIRDYIE_MASK);
+    rcc_writel(A_CR, R_CR_HSION_MASK);
+    g_assert_true(check_nvic_pending(RCC_IRQ));
+    rcc_writel(A_CICR, R_CICR_HSIRDYC_MASK);
+    unpend_nvic_irq(RCC_IRQ);
+
+    rcc_writel(A_CIER, R_CIER_HSERDYIE_MASK);
+    rcc_writel(A_CR, R_CR_HSEON_MASK);
+    g_assert_true(check_nvic_pending(RCC_IRQ));
+    rcc_writel(A_CICR, R_CICR_HSERDYC_MASK);
+    unpend_nvic_irq(RCC_IRQ);
+
+    /*
+     * PLL has been enabled by previous tests,
+     * shouln't generate an interruption.
+     */
+    rcc_writel(A_CIER, R_CIER_PLLRDYIE_MASK);
+    rcc_writel(A_CR, R_CR_PLLON_MASK);
+    g_assert_false(check_nvic_pending(RCC_IRQ));
+
+    rcc_writel(A_CIER, R_CIER_PLLSAI1RDYIE_MASK);
+    rcc_writel(A_CR, R_CR_PLLSAI1ON_MASK);
+    g_assert_true(check_nvic_pending(RCC_IRQ));
+    rcc_writel(A_CICR, R_CICR_PLLSAI1RDYC_MASK);
+    unpend_nvic_irq(RCC_IRQ);
+
+    rcc_writel(A_CIER, R_CIER_PLLSAI2RDYIE_MASK);
+    rcc_writel(A_CR, R_CR_PLLSAI2ON_MASK);
+    g_assert_true(check_nvic_pending(RCC_IRQ));
+    rcc_writel(A_CICR, R_CICR_PLLSAI2RDYC_MASK);
+    unpend_nvic_irq(RCC_IRQ);
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+    g_test_set_nonfatal_assertions();
+    /*
+     * These test separately that we can enable the plls, change the sysclk,
+     * and enable different devices.
+     * They are dependent on one another.
+     * We assume that all operations that would take some time to have an effect
+     * (e.g. changing the PLL frequency) are done instantaneously.
+     */
+    qtest_add_func("stm32l4x5/rcc/init_msi", test_init_msi);
+    qtest_add_func("stm32l4x5/rcc/set_msi_as_sysclk",
+        test_set_msi_as_sysclk);
+    qtest_add_func("stm32l4x5/rcc/activate_lse", test_activate_lse);
+    qtest_add_func("stm32l4x5/rcc/init_pll", test_init_pll);
+
+    qtest_add_func("stm32l4x5/rcc/irq", test_irq);
+
+    qtest_start("-machine b-l475e-iot01a");
+    ret = g_test_run();
+    qtest_end();
+
+    return ret;
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index bdc8bba7a98..31b9f4ede47 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -203,7 +203,8 @@ qtests_aspeed = \
 
 qtests_stm32l4x5 = \
   ['stm32l4x5_exti-test',
-   'stm32l4x5_syscfg-test']
+   'stm32l4x5_syscfg-test',
+   'stm32l4x5_rcc-test']
 
 qtests_arm = \
   (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) + \
-- 
2.34.1


