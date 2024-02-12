Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3FA9C4829C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 16:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZZGv-0001pn-8X; Mon, 12 Feb 2024 11:35:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rZZGs-0001oO-61; Mon, 12 Feb 2024 11:35:06 -0500
Received: from zproxy3.enst.fr ([137.194.2.222])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rZZGo-0005QE-H1; Mon, 12 Feb 2024 11:35:04 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id BFA8CA05A3;
 Mon, 12 Feb 2024 17:34:58 +0100 (CET)
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id WgX8N4b8V3_B; Mon, 12 Feb 2024 17:34:58 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 475CAA056F;
 Mon, 12 Feb 2024 17:34:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy3.enst.fr 475CAA056F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1707755698;
 bh=tDuvgN94LTs349m7HZdr3iifrkazFs5Y7mCnx8rIHEM=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=1UQXaI3Qi9wXzHTvqSwS7PA9CrfzfO6faiPzZcpruVnZqzFwVOYrqpraVG2JBFcKi
 DHeOkAnGTH8hR66QRgAb88BBvosI3Eb6uI/yTk8jYNYUs0s4zIOCw1Oe9ua/5SvodD
 pF5NkW62MvwnxiFydVgABpQJWFvA8xfPcVYUd/XM=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id OQacUv1X5wql; Mon, 12 Feb 2024 17:34:58 +0100 (CET)
Received: from localhost.localdomain (74.0.125.80.rev.sfr.net [80.125.0.74])
 by zproxy3.enst.fr (Postfix) with ESMTPSA id 094FFA0562;
 Mon, 12 Feb 2024 17:34:58 +0100 (CET)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
Subject: [PATCH 2/2] tests/qtest: Check that EXTI fan-in irqs are correctly
 connected
Date: Mon, 12 Feb 2024 17:31:19 +0100
Message-ID: <20240212163446.227802-3-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212163446.227802-1-ines.varhol@telecom-paris.fr>
References: <20240212163446.227802-1-ines.varhol@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=137.194.2.222;
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

This commit adds a QTest that verifies each input line of a specific
EXTI OR gate can influence the output line.

Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 tests/qtest/stm32l4x5_exti-test.c | 97 +++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/tests/qtest/stm32l4x5_exti-test.c b/tests/qtest/stm32l4x5_ex=
ti-test.c
index c390077713..276b7adc7a 100644
--- a/tests/qtest/stm32l4x5_exti-test.c
+++ b/tests/qtest/stm32l4x5_exti-test.c
@@ -31,6 +31,11 @@
=20
 #define EXTI0_IRQ 6
 #define EXTI1_IRQ 7
+#define EXTI5_IRQ 23
+#define EXTI6_IRQ 23
+#define EXTI7_IRQ 23
+#define EXTI8_IRQ 23
+#define EXTI9_IRQ 23
 #define EXTI35_IRQ 1
=20
 static void enable_nvic_irq(unsigned int n)
@@ -499,6 +504,96 @@ static void test_interrupt(void)
     g_assert_false(check_nvic_pending(EXTI1_IRQ));
 }
=20
+static void test_orred_interrupts(void)
+{
+    /*
+     * For lines EXTI5..9 (fanned-in to NVIC irq 23),
+     * test that rising the line pends interrupt
+     * 23 in NVIC.
+     */
+    enable_nvic_irq(EXTI5_IRQ);
+    /* Check that there are no interrupts already pending in PR */
+    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    /* Check that this specific interrupt isn't pending in NVIC */
+    g_assert_false(check_nvic_pending(EXTI5_IRQ));
+
+    /* Enable interrupt lines EXTI[5..9] */
+    exti_writel(EXTI_IMR1, (0x1F << 5));
+
+    /* Configure interrupt on rising edge */
+    exti_writel(EXTI_RTSR1, (0x1F << 5));
+
+    /* Simulate rising edge from GPIO line 7 */
+    exti_set_irq(7, 1);
+    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 1 << 7);
+    g_assert_true(check_nvic_pending(EXTI7_IRQ));
+
+    /* Clear the pending bit in PR */
+    exti_writel(EXTI_PR1, 1 << 7);
+    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_true(check_nvic_pending(EXTI7_IRQ));
+
+    /* Clean NVIC */
+    unpend_nvic_irq(EXTI7_IRQ);
+    g_assert_false(check_nvic_pending(EXTI7_IRQ));
+
+    /* Simulate rising edge from GPIO line 6 */
+    exti_set_irq(6, 1);
+    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 1 << 6);
+    g_assert_true(check_nvic_pending(EXTI6_IRQ));
+
+    /* Clear the pending bit in PR */
+    exti_writel(EXTI_PR1, 1 << 6);
+    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_true(check_nvic_pending(EXTI6_IRQ));
+
+    /* Clean NVIC */
+    unpend_nvic_irq(EXTI6_IRQ);
+    g_assert_false(check_nvic_pending(EXTI6_IRQ));
+
+    /* Simulate rising edge from GPIO line 5 */
+    exti_set_irq(5, 1);
+    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 1 << 5);
+    g_assert_true(check_nvic_pending(EXTI5_IRQ));
+
+    /* Clear the pending bit in PR */
+    exti_writel(EXTI_PR1, 1 << 5);
+    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_true(check_nvic_pending(EXTI5_IRQ));
+
+    /* Clean NVIC */
+    unpend_nvic_irq(EXTI5_IRQ);
+    g_assert_false(check_nvic_pending(EXTI5_IRQ));
+
+    /* Simulate rising edge from GPIO line 8 */
+    exti_set_irq(8, 1);
+    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 1 << 8);
+    g_assert_true(check_nvic_pending(EXTI8_IRQ));
+
+    /* Clear the pending bit in PR */
+    exti_writel(EXTI_PR1, 1 << 8);
+    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_true(check_nvic_pending(EXTI8_IRQ));
+
+    /* Clean NVIC */
+    unpend_nvic_irq(EXTI8_IRQ);
+    g_assert_false(check_nvic_pending(EXTI8_IRQ));
+
+    /* Simulate rising edge from GPIO line 9 */
+    exti_set_irq(9, 1);
+    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 1 << 9);
+    g_assert_true(check_nvic_pending(EXTI9_IRQ));
+
+    /* Clear the pending bit in PR */
+    exti_writel(EXTI_PR1, 1 << 9);
+    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_true(check_nvic_pending(EXTI9_IRQ));
+
+    /* Clean NVIC */
+    unpend_nvic_irq(EXTI9_IRQ);
+    g_assert_false(check_nvic_pending(EXTI9_IRQ));
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -515,6 +610,8 @@ int main(int argc, char **argv)
     qtest_add_func("stm32l4x5/exti/masked_interrupt", test_masked_interr=
upt);
     qtest_add_func("stm32l4x5/exti/interrupt", test_interrupt);
     qtest_add_func("stm32l4x5/exti/test_edge_selector", test_edge_select=
or);
+    qtest_add_func("stm32l4x5/exti/test_orred_interrupts",
+                   test_orred_interrupts);
=20
     qtest_start("-machine b-l475e-iot01a");
     ret =3D g_test_run();
--=20
2.43.0


