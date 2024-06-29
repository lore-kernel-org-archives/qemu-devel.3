Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DE8C30658
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 11:09:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNVwO-0004QV-9O; Sat, 29 Jun 2024 07:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1sNVwG-0004Nu-IO; Sat, 29 Jun 2024 07:08:16 -0400
Received: from zproxy2.enst.fr ([2001:660:330f:2::dd])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1sNVwC-0002pJ-Ow; Sat, 29 Jun 2024 07:08:15 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy2.enst.fr (Postfix) with ESMTP id 3B4408081A;
 Sat, 29 Jun 2024 13:08:10 +0200 (CEST)
Received: from zproxy2.enst.fr ([IPv6:::1])
 by localhost (zproxy2.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id F6RQNX61oObN; Sat, 29 Jun 2024 13:08:09 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
 by zproxy2.enst.fr (Postfix) with ESMTP id AD7A580772;
 Sat, 29 Jun 2024 13:08:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy2.enst.fr AD7A580772
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1719659289;
 bh=a4lyEnz8S5Ks+qhrfm0yaPbBY/U7UZNaNG1eZqCWQHU=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=Som4UKXoEHW2FPBlgJtwi2q3CKJjQqmF7Rvm73Sb8hWOb9/NpPIY/AZRHEDJrufra
 RQK8jxEcqU8r8emeBpUXyThRpLXNgHGm1EKQn/cQh972gjSgqvgYIunAnJHlxLe8Uk
 wYWNpA8+U0w5V7A2Mz8myWLzZmyWmhy2gb+22364=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy2.enst.fr ([IPv6:::1])
 by localhost (zproxy2.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id 8Up9xm3hiUYH; Sat, 29 Jun 2024 13:08:09 +0200 (CEST)
Received: from inesv-Inspiron-3501.. (unknown
 [IPv6:2a02:1808:284:73f9:f191:56:9ba9:96d9])
 by zproxy2.enst.fr (Postfix) with ESMTPSA id B7EEB80878;
 Sat, 29 Jun 2024 13:08:08 +0200 (CEST)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 2/2] tests/qtest: Ensure STM32L4x5 EXTI state is correct at
 the end of QTests
Date: Sat, 29 Jun 2024 13:07:09 +0200
Message-ID: <20240629110800.539969-3-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240629110800.539969-1-ines.varhol@telecom-paris.fr>
References: <20240629110800.539969-1-ines.varhol@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:660:330f:2::dd;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy2.enst.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

EXTI's new field `irq_levels` tracks irq levels between tests when using
`global_qtest`.
This happens in `stm32l4x5_exti-test.c`, `stm32l4x5_syscfg-test.c` and
`stm32l4x5_gpio-test.c` (`dm163.c` doesn't use `global_qtest`).

To ensure that `irq_levels` has the same value before and after each
QTest, this commit toggles back the irq lines that were changed at the
end of each problematic test. Most QTests were already doing this.

Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 tests/qtest/stm32l4x5_exti-test.c   | 8 ++++++++
 tests/qtest/stm32l4x5_syscfg-test.c | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/stm32l4x5_exti-test.c b/tests/qtest/stm32l4x5_ex=
ti-test.c
index 7092860b9b..7e39c992fd 100644
--- a/tests/qtest/stm32l4x5_exti-test.c
+++ b/tests/qtest/stm32l4x5_exti-test.c
@@ -448,6 +448,9 @@ static void test_masked_interrupt(void)
     g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     /* Check that the interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI1_IRQ));
+
+    /* Clean EXTI */
+    exti_set_irq(1, 0);
 }
=20
 static void test_interrupt(void)
@@ -498,6 +501,9 @@ static void test_interrupt(void)
     /* Clean NVIC */
     unpend_nvic_irq(EXTI1_IRQ);
     g_assert_false(check_nvic_pending(EXTI1_IRQ));
+
+    /* Clean EXTI */
+    exti_set_irq(1, 0);
 }
=20
 static void test_orred_interrupts(void)
@@ -531,6 +537,8 @@ static void test_orred_interrupts(void)
=20
         unpend_nvic_irq(EXTI5_9_IRQ);
         g_assert_false(check_nvic_pending(EXTI5_9_IRQ));
+
+        exti_set_irq(i, 0);
     }
 }
=20
diff --git a/tests/qtest/stm32l4x5_syscfg-test.c b/tests/qtest/stm32l4x5_=
syscfg-test.c
index 506ca08bc2..4416959b4a 100644
--- a/tests/qtest/stm32l4x5_syscfg-test.c
+++ b/tests/qtest/stm32l4x5_syscfg-test.c
@@ -221,10 +221,10 @@ static void test_interrupt(void)
     g_assert_true(get_irq(1));
=20
     /* Clean the test */
-    syscfg_writel(SYSCFG_EXTICR1, 0x00000000);
     syscfg_set_irq(0, 0);
     syscfg_set_irq(15, 0);
     syscfg_set_irq(17, 0);
+    syscfg_writel(SYSCFG_EXTICR1, 0x00000000);
 }
=20
 static void test_irq_pin_multiplexer(void)
--=20
2.43.2


