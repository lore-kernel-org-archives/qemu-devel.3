Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A14C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 21:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Uxs-0004GU-7W; Wed, 23 Sep 2026 17:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <manueleconti@Manueles-MacBook-Pro.local>)
 id 1x9Um1-0001a8-20; Wed, 23 Sep 2026 17:45:06 -0400
Received: from [2a01:7d0:d20e:1100:ed13:e0b7:e950:9bd7]
 (helo=Manueles-MacBook-Pro.local)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <manueleconti@Manueles-MacBook-Pro.local>)
 id 1x9Uly-0003bT-8I; Wed, 23 Sep 2026 17:45:04 -0400
Received: by Manueles-MacBook-Pro.local (Postfix, from userid 501)
 id BDC00998E85B; Wed, 23 Sep 2026 23:44:58 +0200 (CEST)
From: Manuele Conti <manuele.conti@archimede-energia.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manuele Conti <manuele.conti@archimede-energia.com>
Subject: [PATCH 2/2] hw/misc/stm32_rcc: mirror oscillator ready and system
 clock status
Date: Wed, 23 Sep 2026 23:44:53 +0200
Message-ID: <20260923214453.45335-3-manuele.conti@archimede-energia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20260923214453.45335-1-manuele.conti@archimede-energia.com>
References: <20260923214453.45335-1-manuele.conti@archimede-energia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for
 2a01:7d0:d20e:1100:ed13:e0b7:e950:9bd7 (failed)
Received-SPF: none client-ip=2a01:7d0:d20e:1100:ed13:e0b7:e950:9bd7;
 envelope-from=manueleconti@Manueles-MacBook-Pro.local;
 helo=Manueles-MacBook-Pro.local
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NO_DNS_FOR_FROM=0.001, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 23 Sep 2026 17:56:36 -0400
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

RM0090 7.3.1/7.3.3: HSERDY follows HSEON, PLLRDY follows PLLON and
SWS follows SW. Upstream stored raw values, so firmware polling for
ready or checking SWS never saw the expected state.

Mirror enable bits into ready bits on CR writes and SW into SWS on
CFGR writes. Clock switching is instantaneous in QEMU. No oscillator
startup or PLL lock delay is modelled.

Add qtest writing HSEON/PLLON/SW and checking HSERDY/PLLRDY/SWS,
including clearing again on HSEOFF/PLLOFF.

Signed-off-by: Manuele Conti <manuele.conti@archimede-energia.com>
---
 hw/misc/stm32_rcc.c              | 18 ++++++++++
 tests/qtest/meson.build          |  3 +-
 tests/qtest/stm32f405-rcc-test.c | 57 ++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/stm32f405-rcc-test.c

diff --git a/hw/misc/stm32_rcc.c b/hw/misc/stm32_rcc.c
index 5cfb39e560..ba64a87bdd 100644
--- a/hw/misc/stm32_rcc.c
+++ b/hw/misc/stm32_rcc.c
@@ -90,6 +90,24 @@ static void stm32_rcc_write(void *opaque, hwaddr addr,
     }
 
     switch (addr) {
+    case STM32_RCC_CR:
+        /*
+         * Oscillators become ready immediately in QEMU.
+         * Mirror enable bits into ready bits: HSEON->HSERDY,
+         * PLLON->PLLRDY. See RM0090 7.3.1.
+         */
+        value = deposit32(value, 17, 1, extract32(value, 16, 1));
+        value = deposit32(value, 25, 1, extract32(value, 24, 1));
+        s->regs[addr >> 2] = value;
+        return;
+    case STM32_RCC_CFGR:
+        /*
+         * System clock switch is instantaneous in QEMU.
+         * Mirror SW[1:0] into SWS[3:2]. See RM0090 7.3.3.
+         */
+        value = deposit32(value, 2, 2, extract32(value, 0, 2));
+        s->regs[addr >> 2] = value;
+        return;
     case STM32_RCC_AHB1_RSTR ... STM32_RCC_AHB3_RSTR:
     case STM32_RCC_APB1_RSTR ... STM32_RCC_APB2_RSTR:
         prev_value = s->regs[addr / 4];
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 51dbe63411..c26e510b0b 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -250,7 +250,8 @@ qtests_stm32l4x5 = \
    'stm32l4x5_usart-test']
 
 qtests_stm32f405 = \
-  ['stm32f405-timer-test']
+  ['stm32f405-timer-test',
+   'stm32f405-rcc-test']
 
 qtests_arm = \
   (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) + \
diff --git a/tests/qtest/stm32f405-rcc-test.c b/tests/qtest/stm32f405-rcc-test.c
new file mode 100644
index 0000000000..75c0291ed1
--- /dev/null
+++ b/tests/qtest/stm32f405-rcc-test.c
@@ -0,0 +1,57 @@
+/*
+ * QTest for STM32 RCC clock-ready mirroring (STM32F405 SoC).
+ *
+ * RM0090 7.3.1/7.3.3: HSEON->HSERDY, PLLON->PLLRDY, SW->SWS.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+#define RCC_BASE 0x40023800ULL
+#define RCC_CR   0x00
+#define RCC_CFGR 0x08
+
+#define RCC_CR_HSEON  (1U << 16)
+#define RCC_CR_HSERDY (1U << 17)
+#define RCC_CR_PLLON  (1U << 24)
+#define RCC_CR_PLLRDY (1U << 25)
+
+static void test_ready(void)
+{
+    QTestState *qts = qtest_init("-M netduinoplus2");
+    uint32_t val;
+
+    val = qtest_readl(qts, RCC_BASE + RCC_CR);
+    qtest_writel(qts, RCC_BASE + RCC_CR, val | RCC_CR_HSEON);
+    g_assert_true(qtest_readl(qts, RCC_BASE + RCC_CR) & RCC_CR_HSERDY);
+
+    val = qtest_readl(qts, RCC_BASE + RCC_CR);
+    qtest_writel(qts, RCC_BASE + RCC_CR, val & ~RCC_CR_HSEON);
+    g_assert_false(qtest_readl(qts, RCC_BASE + RCC_CR) & RCC_CR_HSERDY);
+
+    val = qtest_readl(qts, RCC_BASE + RCC_CR);
+    qtest_writel(qts, RCC_BASE + RCC_CR, val | RCC_CR_PLLON);
+    g_assert_true(qtest_readl(qts, RCC_BASE + RCC_CR) & RCC_CR_PLLRDY);
+
+    val = qtest_readl(qts, RCC_BASE + RCC_CR);
+    qtest_writel(qts, RCC_BASE + RCC_CR, val & ~RCC_CR_PLLON);
+    g_assert_false(qtest_readl(qts, RCC_BASE + RCC_CR) & RCC_CR_PLLRDY);
+
+    qtest_writel(qts, RCC_BASE + RCC_CFGR, 0x2);
+    g_assert_cmpuint((qtest_readl(qts, RCC_BASE + RCC_CFGR) >> 2) & 0x3,
+                     ==, 0x2);
+    qtest_writel(qts, RCC_BASE + RCC_CFGR, 0x1);
+    g_assert_cmpuint((qtest_readl(qts, RCC_BASE + RCC_CFGR) >> 2) & 0x3,
+                     ==, 0x1);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("stm32f405/rcc/ready", test_ready);
+    return g_test_run();
+}
-- 
2.41.0


