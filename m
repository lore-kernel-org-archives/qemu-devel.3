Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BF2C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2024 13:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvzrV-0007d4-6D; Sun, 14 Apr 2024 09:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rvzrS-0007cp-0x
 for qemu-devel@nongnu.org; Sun, 14 Apr 2024 09:25:34 -0400
Received: from zproxy3.enst.fr ([2001:660:330f:2::de])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rvzrN-00029f-Tk
 for qemu-devel@nongnu.org; Sun, 14 Apr 2024 09:25:33 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 7FC77A0697;
 Sun, 14 Apr 2024 15:25:27 +0200 (CEST)
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id hXtfDKFtSn_G; Sun, 14 Apr 2024 15:25:26 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 66E40A0675;
 Sun, 14 Apr 2024 15:25:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy3.enst.fr 66E40A0675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1713101126;
 bh=Zb1J77teVeXIVDf+n62vgXntI9T/gVyBhjzwotC6gl0=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=6tsRq3LvYnrJNvMJGStSNB08t48QEoYRqks9dzp1s+HWJDa7qP+f1xI7zMIt1w2DI
 ytkiPD18980k5hzTS5dQXwc1XXoiL59kDguzBWPIreou5/AHoL/9NNYJu5NpUsVCqv
 oTynCRLun+MWJpo6LVv2x16g8zL8BBv3JTlnXCM4=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id b8WOHQI6Rmqo; Sun, 14 Apr 2024 15:25:26 +0200 (CEST)
Received: from inesv-Inspiron-3501.enst.fr (unknown
 [IPv6:2a04:8ec0:0:124::190c])
 by zproxy3.enst.fr (Postfix) with ESMTPSA id 8C657A056C;
 Sun, 14 Apr 2024 15:25:25 +0200 (CEST)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
Subject: [PATCH] tests/qtest : Use `g_assert_cmphex` instead of
 `g_assert_cmpuint`
Date: Sun, 14 Apr 2024 15:24:41 +0200
Message-ID: <20240414132518.278858-1-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.2
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

The messages for STM32L4x5 tests will be easier to understand with
`g_assert_cmphex` since the comparisions were made with hexadecimal
numbers.

Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 tests/qtest/stm32l4x5_exti-test.c   | 138 ++++++++++++++--------------
 tests/qtest/stm32l4x5_syscfg-test.c |  74 +++++++--------
 2 files changed, 106 insertions(+), 106 deletions(-)

diff --git a/tests/qtest/stm32l4x5_exti-test.c b/tests/qtest/stm32l4x5_ex=
ti-test.c
index 81830be8ae..7092860b9b 100644
--- a/tests/qtest/stm32l4x5_exti-test.c
+++ b/tests/qtest/stm32l4x5_exti-test.c
@@ -70,44 +70,44 @@ static void test_reg_write_read(void)
     /* Test that non-reserved bits in xMR and xTSR can be set and cleare=
d */
=20
     exti_writel(EXTI_IMR1, 0xFFFFFFFF);
-    g_assert_cmpuint(exti_readl(EXTI_IMR1), =3D=3D, 0xFFFFFFFF);
+    g_assert_cmphex(exti_readl(EXTI_IMR1), =3D=3D, 0xFFFFFFFF);
     exti_writel(EXTI_IMR1, 0x00000000);
-    g_assert_cmpuint(exti_readl(EXTI_IMR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_IMR1), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_EMR1, 0xFFFFFFFF);
-    g_assert_cmpuint(exti_readl(EXTI_EMR1), =3D=3D, 0xFFFFFFFF);
+    g_assert_cmphex(exti_readl(EXTI_EMR1), =3D=3D, 0xFFFFFFFF);
     exti_writel(EXTI_EMR1, 0x00000000);
-    g_assert_cmpuint(exti_readl(EXTI_EMR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_EMR1), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_RTSR1, 0xFFFFFFFF);
-    g_assert_cmpuint(exti_readl(EXTI_RTSR1), =3D=3D, 0x007DFFFF);
+    g_assert_cmphex(exti_readl(EXTI_RTSR1), =3D=3D, 0x007DFFFF);
     exti_writel(EXTI_RTSR1, 0x00000000);
-    g_assert_cmpuint(exti_readl(EXTI_RTSR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_RTSR1), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_FTSR1, 0xFFFFFFFF);
-    g_assert_cmpuint(exti_readl(EXTI_FTSR1), =3D=3D, 0x007DFFFF);
+    g_assert_cmphex(exti_readl(EXTI_FTSR1), =3D=3D, 0x007DFFFF);
     exti_writel(EXTI_FTSR1, 0x00000000);
-    g_assert_cmpuint(exti_readl(EXTI_FTSR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_FTSR1), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_IMR2, 0xFFFFFFFF);
-    g_assert_cmpuint(exti_readl(EXTI_IMR2), =3D=3D, 0x000000FF);
+    g_assert_cmphex(exti_readl(EXTI_IMR2), =3D=3D, 0x000000FF);
     exti_writel(EXTI_IMR2, 0x00000000);
-    g_assert_cmpuint(exti_readl(EXTI_IMR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_IMR2), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_EMR2, 0xFFFFFFFF);
-    g_assert_cmpuint(exti_readl(EXTI_EMR2), =3D=3D, 0x000000FF);
+    g_assert_cmphex(exti_readl(EXTI_EMR2), =3D=3D, 0x000000FF);
     exti_writel(EXTI_EMR2, 0x00000000);
-    g_assert_cmpuint(exti_readl(EXTI_EMR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_EMR2), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_RTSR2, 0xFFFFFFFF);
-    g_assert_cmpuint(exti_readl(EXTI_RTSR2), =3D=3D, 0x00000078);
+    g_assert_cmphex(exti_readl(EXTI_RTSR2), =3D=3D, 0x00000078);
     exti_writel(EXTI_RTSR2, 0x00000000);
-    g_assert_cmpuint(exti_readl(EXTI_RTSR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_RTSR2), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_FTSR2, 0xFFFFFFFF);
-    g_assert_cmpuint(exti_readl(EXTI_FTSR2), =3D=3D, 0x00000078);
+    g_assert_cmphex(exti_readl(EXTI_FTSR2), =3D=3D, 0x00000078);
     exti_writel(EXTI_FTSR2, 0x00000000);
-    g_assert_cmpuint(exti_readl(EXTI_FTSR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_FTSR2), =3D=3D, 0x00000000);
 }
=20
 static void test_direct_lines_write(void)
@@ -115,28 +115,28 @@ static void test_direct_lines_write(void)
     /* Test that direct lines reserved bits are not written to */
=20
     exti_writel(EXTI_RTSR1, 0xFF820000);
-    g_assert_cmpuint(exti_readl(EXTI_RTSR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_RTSR1), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_FTSR1, 0xFF820000);
-    g_assert_cmpuint(exti_readl(EXTI_FTSR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_FTSR1), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_SWIER1, 0xFF820000);
-    g_assert_cmpuint(exti_readl(EXTI_SWIER1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_SWIER1), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_PR1, 0xFF820000);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_RTSR2, 0x00000087);
-    g_assert_cmpuint(exti_readl(EXTI_RTSR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_RTSR2), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_FTSR2, 0x00000087);
-    g_assert_cmpuint(exti_readl(EXTI_FTSR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_FTSR2), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_SWIER2, 0x00000087);
-    g_assert_cmpuint(exti_readl(EXTI_SWIER2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_SWIER2), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_PR2, 0x00000087);
-    g_assert_cmpuint(exti_readl(EXTI_PR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR2), =3D=3D, 0x00000000);
 }
=20
 static void test_reserved_bits_write(void)
@@ -144,22 +144,22 @@ static void test_reserved_bits_write(void)
     /* Test that reserved bits stay are not written to */
=20
     exti_writel(EXTI_IMR2, 0xFFFFFF00);
-    g_assert_cmpuint(exti_readl(EXTI_IMR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_IMR2), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_EMR2, 0xFFFFFF00);
-    g_assert_cmpuint(exti_readl(EXTI_EMR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_EMR2), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_RTSR2, 0xFFFFFF00);
-    g_assert_cmpuint(exti_readl(EXTI_RTSR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_RTSR2), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_FTSR2, 0xFFFFFF00);
-    g_assert_cmpuint(exti_readl(EXTI_FTSR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_FTSR2), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_SWIER2, 0xFFFFFF00);
-    g_assert_cmpuint(exti_readl(EXTI_SWIER2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_SWIER2), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_PR2, 0xFFFFFF00);
-    g_assert_cmpuint(exti_readl(EXTI_PR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR2), =3D=3D, 0x00000000);
 }
=20
 static void test_software_interrupt(void)
@@ -180,7 +180,7 @@ static void test_software_interrupt(void)
=20
     enable_nvic_irq(EXTI0_IRQ);
     /* Check that there are no interrupts already pending in PR */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     /* Check that this specific interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
=20
@@ -191,9 +191,9 @@ static void test_software_interrupt(void)
     exti_writel(EXTI_SWIER1, 0x00000001);
=20
     /* Check that the write in SWIER was effective */
-    g_assert_cmpuint(exti_readl(EXTI_SWIER1), =3D=3D, 0x00000001);
+    g_assert_cmphex(exti_readl(EXTI_SWIER1), =3D=3D, 0x00000001);
     /* Check that the corresponding pending bit in PR is set */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000001);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000001);
     /* Check that the corresponding interrupt is pending in the NVIC */
     g_assert_true(check_nvic_pending(EXTI0_IRQ));
=20
@@ -201,9 +201,9 @@ static void test_software_interrupt(void)
     exti_writel(EXTI_PR1, 0x00000001);
=20
     /* Check that the write in PR was effective */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     /* Check that the corresponding bit in SWIER was cleared */
-    g_assert_cmpuint(exti_readl(EXTI_SWIER1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_SWIER1), =3D=3D, 0x00000000);
     /* Check that the interrupt is still pending in the NVIC */
     g_assert_true(check_nvic_pending(EXTI0_IRQ));
=20
@@ -214,7 +214,7 @@ static void test_software_interrupt(void)
=20
     enable_nvic_irq(EXTI35_IRQ);
     /* Check that there are no interrupts already pending */
-    g_assert_cmpuint(exti_readl(EXTI_PR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR2), =3D=3D, 0x00000000);
     g_assert_false(check_nvic_pending(EXTI35_IRQ));
=20
     /* Enable interrupt line EXTI0 */
@@ -224,9 +224,9 @@ static void test_software_interrupt(void)
     exti_writel(EXTI_SWIER2, 0x00000008);
=20
     /* Check that the write in SWIER was effective */
-    g_assert_cmpuint(exti_readl(EXTI_SWIER2), =3D=3D, 0x00000008);
+    g_assert_cmphex(exti_readl(EXTI_SWIER2), =3D=3D, 0x00000008);
     /* Check that the corresponding pending bit in PR is set */
-    g_assert_cmpuint(exti_readl(EXTI_PR2), =3D=3D, 0x00000008);
+    g_assert_cmphex(exti_readl(EXTI_PR2), =3D=3D, 0x00000008);
     /* Check that the corresponding interrupt is pending in the NVIC */
     g_assert_true(check_nvic_pending(EXTI35_IRQ));
=20
@@ -234,9 +234,9 @@ static void test_software_interrupt(void)
     exti_writel(EXTI_PR2, 0x00000008);
=20
     /* Check that the write in PR was effective */
-    g_assert_cmpuint(exti_readl(EXTI_PR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR2), =3D=3D, 0x00000000);
     /* Check that the corresponding bit in SWIER was cleared */
-    g_assert_cmpuint(exti_readl(EXTI_SWIER2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_SWIER2), =3D=3D, 0x00000000);
     /* Check that the interrupt is still pending in the NVIC */
     g_assert_true(check_nvic_pending(EXTI35_IRQ));
=20
@@ -259,16 +259,16 @@ static void test_edge_selector(void)
=20
     /* Test that an irq is raised on rising edge only */
     exti_set_irq(0, 0);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
=20
     exti_set_irq(0, 1);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000001);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000001);
     g_assert_true(check_nvic_pending(EXTI0_IRQ));
=20
     /* Clean the test */
     exti_writel(EXTI_PR1, 0x00000001);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     unpend_nvic_irq(EXTI0_IRQ);
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
=20
@@ -280,16 +280,16 @@ static void test_edge_selector(void)
=20
     /* Test that an irq is raised on falling edge only */
     exti_set_irq(0, 1);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
=20
     exti_set_irq(0, 0);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000001);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000001);
     g_assert_true(check_nvic_pending(EXTI0_IRQ));
=20
     /* Clean the test */
     exti_writel(EXTI_PR1, 0x00000001);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     unpend_nvic_irq(EXTI0_IRQ);
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
=20
@@ -300,23 +300,23 @@ static void test_edge_selector(void)
=20
     /* Test that an irq is raised on rising edge */
     exti_set_irq(0, 1);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000001);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000001);
     g_assert_true(check_nvic_pending(EXTI0_IRQ));
=20
     /* Clean the test */
     exti_writel(EXTI_PR1, 0x00000001);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     unpend_nvic_irq(EXTI0_IRQ);
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
=20
     /* Test that an irq is raised on falling edge */
     exti_set_irq(0, 0);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000001);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000001);
     g_assert_true(check_nvic_pending(EXTI0_IRQ));
=20
     /* Clean the test */
     exti_writel(EXTI_PR1, 0x00000001);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     unpend_nvic_irq(EXTI0_IRQ);
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
=20
@@ -327,11 +327,11 @@ static void test_edge_selector(void)
=20
     /* Test that no irq is raised */
     exti_set_irq(0, 1);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
=20
     exti_set_irq(0, 0);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
 }
=20
@@ -350,7 +350,7 @@ static void test_no_software_interrupt(void)
=20
     enable_nvic_irq(EXTI0_IRQ);
     /* Check that there are no interrupts already pending in PR */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     /* Check that this specific interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
=20
@@ -361,9 +361,9 @@ static void test_no_software_interrupt(void)
     exti_writel(EXTI_SWIER1, 0x00000001);
=20
     /* Check that the write in SWIER was effective */
-    g_assert_cmpuint(exti_readl(EXTI_SWIER1), =3D=3D, 0x00000001);
+    g_assert_cmphex(exti_readl(EXTI_SWIER1), =3D=3D, 0x00000001);
     /* Check that the pending bit in PR wasn't set */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     /* Check that the interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
=20
@@ -371,7 +371,7 @@ static void test_no_software_interrupt(void)
     exti_writel(EXTI_IMR1, 0x00000001);
=20
     /* Check that the pending bit in PR wasn't set */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     /* Check that the interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
=20
@@ -382,7 +382,7 @@ static void test_no_software_interrupt(void)
=20
     enable_nvic_irq(EXTI35_IRQ);
     /* Check that there are no interrupts already pending in PR */
-    g_assert_cmpuint(exti_readl(EXTI_PR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR2), =3D=3D, 0x00000000);
     /* Check that this specific interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI35_IRQ));
=20
@@ -393,9 +393,9 @@ static void test_no_software_interrupt(void)
     exti_writel(EXTI_SWIER2, 0x00000008);
=20
     /* Check that the write in SWIER was effective */
-    g_assert_cmpuint(exti_readl(EXTI_SWIER2), =3D=3D, 0x00000008);
+    g_assert_cmphex(exti_readl(EXTI_SWIER2), =3D=3D, 0x00000008);
     /* Check that the pending bit in PR wasn't set */
-    g_assert_cmpuint(exti_readl(EXTI_PR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR2), =3D=3D, 0x00000000);
     /* Check that the interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI35_IRQ));
=20
@@ -403,7 +403,7 @@ static void test_no_software_interrupt(void)
     exti_writel(EXTI_IMR2, 0x00000008);
=20
     /* Check that the pending bit in PR wasn't set */
-    g_assert_cmpuint(exti_readl(EXTI_PR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR2), =3D=3D, 0x00000000);
     /* Check that the interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI35_IRQ));
 }
@@ -423,7 +423,7 @@ static void test_masked_interrupt(void)
=20
     enable_nvic_irq(EXTI1_IRQ);
     /* Check that there are no interrupts already pending in PR */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     /* Check that this specific interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI1_IRQ));
=20
@@ -437,7 +437,7 @@ static void test_masked_interrupt(void)
     exti_set_irq(1, 1);
=20
     /* Check that the pending bit in PR wasn't set */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     /* Check that the interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI1_IRQ));
=20
@@ -445,7 +445,7 @@ static void test_masked_interrupt(void)
     exti_writel(EXTI_IMR1, 0x00000002);
=20
     /* Check that the pending bit in PR wasn't set */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     /* Check that the interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI1_IRQ));
 }
@@ -469,7 +469,7 @@ static void test_interrupt(void)
=20
     enable_nvic_irq(EXTI1_IRQ);
     /* Check that there are no interrupts already pending in PR */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     /* Check that this specific interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI1_IRQ));
=20
@@ -483,7 +483,7 @@ static void test_interrupt(void)
     exti_set_irq(1, 1);
=20
     /* Check that the pending bit in PR was set */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000002);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000002);
     /* Check that the interrupt is pending in NVIC */
     g_assert_true(check_nvic_pending(EXTI1_IRQ));
=20
@@ -491,7 +491,7 @@ static void test_interrupt(void)
     exti_writel(EXTI_PR1, 0x00000002);
=20
     /* Check that the write in PR was effective */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     /* Check that the interrupt is still pending in the NVIC */
     g_assert_true(check_nvic_pending(EXTI1_IRQ));
=20
@@ -509,7 +509,7 @@ static void test_orred_interrupts(void)
      */
     enable_nvic_irq(EXTI5_9_IRQ);
     /* Check that there are no interrupts already pending in PR */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     /* Check that this specific interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI5_9_IRQ));
=20
@@ -522,11 +522,11 @@ static void test_orred_interrupts(void)
     /* Raise GPIO line i, check that the interrupt is pending */
     for (unsigned i =3D 5; i < 10; i++) {
         exti_set_irq(i, 1);
-        g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 1 << i);
+        g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 1 << i);
         g_assert_true(check_nvic_pending(EXTI5_9_IRQ));
=20
         exti_writel(EXTI_PR1, 1 << i);
-        g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+        g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
         g_assert_true(check_nvic_pending(EXTI5_9_IRQ));
=20
         unpend_nvic_irq(EXTI5_9_IRQ);
diff --git a/tests/qtest/stm32l4x5_syscfg-test.c b/tests/qtest/stm32l4x5_=
syscfg-test.c
index ed4801798d..59bac829b7 100644
--- a/tests/qtest/stm32l4x5_syscfg-test.c
+++ b/tests/qtest/stm32l4x5_syscfg-test.c
@@ -54,27 +54,27 @@ static void test_reset(void)
     /*
      * Test that registers are initialized at the correct values
      */
-    g_assert_cmpuint(syscfg_readl(SYSCFG_MEMRMP), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_MEMRMP), =3D=3D, 0x00000000);
=20
-    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR1), =3D=3D, 0x7C000001);
+    g_assert_cmphex(syscfg_readl(SYSCFG_CFGR1), =3D=3D, 0x7C000001);
=20
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR1), =3D=3D, 0x00000000);
=20
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR2), =3D=3D, 0x00000000);
=20
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR3), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR3), =3D=3D, 0x00000000);
=20
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR4), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR4), =3D=3D, 0x00000000);
=20
-    g_assert_cmpuint(syscfg_readl(SYSCFG_SCSR), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_SCSR), =3D=3D, 0x00000000);
=20
-    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_CFGR2), =3D=3D, 0x00000000);
=20
-    g_assert_cmpuint(syscfg_readl(SYSCFG_SWPR), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_SWPR), =3D=3D, 0x00000000);
=20
-    g_assert_cmpuint(syscfg_readl(SYSCFG_SKR), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_SKR), =3D=3D, 0x00000000);
=20
-    g_assert_cmpuint(syscfg_readl(SYSCFG_SWPR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_SWPR2), =3D=3D, 0x00000000);
 }
=20
 static void test_reserved_bits(void)
@@ -87,25 +87,25 @@ static void test_reserved_bits(void)
      * register is still at reset value
      */
     syscfg_writel(SYSCFG_MEMRMP, 0xFFFFFEF8);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_MEMRMP), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_MEMRMP), =3D=3D, 0x00000000);
=20
     syscfg_writel(SYSCFG_CFGR1, 0x7F00FEFF);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR1), =3D=3D, 0x7C000001);
+    g_assert_cmphex(syscfg_readl(SYSCFG_CFGR1), =3D=3D, 0x7C000001);
=20
     syscfg_writel(SYSCFG_EXTICR1, 0xFFFF0000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR1), =3D=3D, 0x00000000);
=20
     syscfg_writel(SYSCFG_EXTICR2, 0xFFFF0000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR2), =3D=3D, 0x00000000);
=20
     syscfg_writel(SYSCFG_EXTICR3, 0xFFFF0000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR3), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR3), =3D=3D, 0x00000000);
=20
     syscfg_writel(SYSCFG_EXTICR4, 0xFFFF0000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR4), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR4), =3D=3D, 0x00000000);
=20
     syscfg_writel(SYSCFG_SKR, 0xFFFFFF00);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_SKR), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_SKR), =3D=3D, 0x00000000);
 }
=20
 static void test_set_and_clear(void)
@@ -114,40 +114,40 @@ static void test_set_and_clear(void)
      * Test that regular bits can be set and cleared
      */
     syscfg_writel(SYSCFG_MEMRMP, 0x00000107);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_MEMRMP), =3D=3D, 0x00000107);
+    g_assert_cmphex(syscfg_readl(SYSCFG_MEMRMP), =3D=3D, 0x00000107);
     syscfg_writel(SYSCFG_MEMRMP, 0x00000000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_MEMRMP), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_MEMRMP), =3D=3D, 0x00000000);
=20
     /* cfgr1 bit 0 is clear only so we keep it set */
     syscfg_writel(SYSCFG_CFGR1, 0xFCFF0101);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR1), =3D=3D, 0xFCFF0101);
+    g_assert_cmphex(syscfg_readl(SYSCFG_CFGR1), =3D=3D, 0xFCFF0101);
     syscfg_writel(SYSCFG_CFGR1, 0x00000001);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR1), =3D=3D, 0x00000001);
+    g_assert_cmphex(syscfg_readl(SYSCFG_CFGR1), =3D=3D, 0x00000001);
=20
     syscfg_writel(SYSCFG_EXTICR1, 0x0000FFFF);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR1), =3D=3D, 0x0000FFFF);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR1), =3D=3D, 0x0000FFFF);
     syscfg_writel(SYSCFG_EXTICR1, 0x00000000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR1), =3D=3D, 0x00000000);
=20
     syscfg_writel(SYSCFG_EXTICR2, 0x0000FFFF);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR2), =3D=3D, 0x0000FFFF);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR2), =3D=3D, 0x0000FFFF);
     syscfg_writel(SYSCFG_EXTICR2, 0x00000000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR2), =3D=3D, 0x00000000);
=20
     syscfg_writel(SYSCFG_EXTICR3, 0x0000FFFF);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR3), =3D=3D, 0x0000FFFF);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR3), =3D=3D, 0x0000FFFF);
     syscfg_writel(SYSCFG_EXTICR3, 0x00000000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR3), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR3), =3D=3D, 0x00000000);
=20
     syscfg_writel(SYSCFG_EXTICR4, 0x0000FFFF);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR4), =3D=3D, 0x0000FFFF);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR4), =3D=3D, 0x0000FFFF);
     syscfg_writel(SYSCFG_EXTICR4, 0x00000000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR4), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR4), =3D=3D, 0x00000000);
=20
     syscfg_writel(SYSCFG_SKR, 0x000000FF);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_SKR), =3D=3D, 0x000000FF);
+    g_assert_cmphex(syscfg_readl(SYSCFG_SKR), =3D=3D, 0x000000FF);
     syscfg_writel(SYSCFG_SKR, 0x00000000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_SKR), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_SKR), =3D=3D, 0x00000000);
 }
=20
 static void test_clear_by_writing_1(void)
@@ -156,7 +156,7 @@ static void test_clear_by_writing_1(void)
      * Test that writing '1' doesn't set the bit
      */
     syscfg_writel(SYSCFG_CFGR2, 0x00000100);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_CFGR2), =3D=3D, 0x00000000);
 }
=20
 static void test_set_only_bits(void)
@@ -166,15 +166,15 @@ static void test_set_only_bits(void)
      */
     syscfg_writel(SYSCFG_CFGR2, 0x0000000F);
     syscfg_writel(SYSCFG_CFGR2, 0x00000000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR2), =3D=3D, 0x0000000F);
+    g_assert_cmphex(syscfg_readl(SYSCFG_CFGR2), =3D=3D, 0x0000000F);
=20
     syscfg_writel(SYSCFG_SWPR, 0xFFFFFFFF);
     syscfg_writel(SYSCFG_SWPR, 0x00000000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_SWPR), =3D=3D, 0xFFFFFFFF);
+    g_assert_cmphex(syscfg_readl(SYSCFG_SWPR), =3D=3D, 0xFFFFFFFF);
=20
     syscfg_writel(SYSCFG_SWPR2, 0xFFFFFFFF);
     syscfg_writel(SYSCFG_SWPR2, 0x00000000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_SWPR2), =3D=3D, 0xFFFFFFFF);
+    g_assert_cmphex(syscfg_readl(SYSCFG_SWPR2), =3D=3D, 0xFFFFFFFF);
=20
     system_reset();
 }
@@ -186,7 +186,7 @@ static void test_clear_only_bits(void)
      */
     syscfg_writel(SYSCFG_CFGR1, 0x00000000);
     syscfg_writel(SYSCFG_CFGR1, 0x00000001);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_CFGR1), =3D=3D, 0x00000000);
=20
     system_reset();
 }
--=20
2.43.2


