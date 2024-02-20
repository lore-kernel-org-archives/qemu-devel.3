Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E539C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 18:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcV4H-0007vg-3J; Tue, 20 Feb 2024 13:42:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rcV46-0007rH-A4; Tue, 20 Feb 2024 13:42:05 -0500
Received: from zproxy2.enst.fr ([2001:660:330f:2::dd])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rcV44-0007JW-AW; Tue, 20 Feb 2024 13:42:02 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy2.enst.fr (Postfix) with ESMTP id E289980673;
 Tue, 20 Feb 2024 19:41:54 +0100 (CET)
Received: from zproxy2.enst.fr ([IPv6:::1])
 by localhost (zproxy2.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id 9po80ZR-aNkv; Tue, 20 Feb 2024 19:41:54 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy2.enst.fr (Postfix) with ESMTP id 6C9B180682;
 Tue, 20 Feb 2024 19:41:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy2.enst.fr 6C9B180682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1708454514;
 bh=QueERqoWbl+z3zS/6H26qwczTL2+98k7rJBK6el/njs=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=GTR3vhZIioslm5PYaxvOGXWJ+Uat3FkAXIQsmTkNYH/IRvz9DlH1yjy2LxM0tRnQp
 Yoz969+ASJ8PL7dsPU7eSVzyXSGpl4aJ8lg+HDzMBvdFrCq9XrtGlPBuDbtSejaT+Z
 AaK45In4X4Y/yL43CprJxseWCAV3Ov992x8+hm8o=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy2.enst.fr ([IPv6:::1])
 by localhost (zproxy2.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id 3gPawhELsegw; Tue, 20 Feb 2024 19:41:54 +0100 (CET)
Received: from inesv-Inspiron-3501.lan (unknown
 [IPv6:2001:861:4680:b1b0:6f1f:d69d:dd9c:e973])
 by zproxy2.enst.fr (Postfix) with ESMTPSA id 17397805FE;
 Tue, 20 Feb 2024 19:41:54 +0100 (CET)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
Subject: [PATCH v2 2/2] tests/qtest: Check that EXTI fan-in irqs are correctly
 connected
Date: Tue, 20 Feb 2024 19:34:36 +0100
Message-ID: <20240220184145.106107-3-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220184145.106107-1-ines.varhol@telecom-paris.fr>
References: <20240220184145.106107-1-ines.varhol@telecom-paris.fr>
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---

Hello,

I expected this test to fail after switching the two patch commits,
but it didn't.
I'm mentionning it in case it reveals a problem with the test I didn't no=
tice.


 tests/qtest/stm32l4x5_exti-test.c | 37 +++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tests/qtest/stm32l4x5_exti-test.c b/tests/qtest/stm32l4x5_ex=
ti-test.c
index c390077713..81830be8ae 100644
--- a/tests/qtest/stm32l4x5_exti-test.c
+++ b/tests/qtest/stm32l4x5_exti-test.c
@@ -31,6 +31,7 @@
=20
 #define EXTI0_IRQ 6
 #define EXTI1_IRQ 7
+#define EXTI5_9_IRQ 23
 #define EXTI35_IRQ 1
=20
 static void enable_nvic_irq(unsigned int n)
@@ -499,6 +500,40 @@ static void test_interrupt(void)
     g_assert_false(check_nvic_pending(EXTI1_IRQ));
 }
=20
+static void test_orred_interrupts(void)
+{
+    /*
+     * For lines EXTI5..9 (fanned-in to NVIC irq 23),
+     * test that raising the line pends interrupt
+     * 23 in NVIC.
+     */
+    enable_nvic_irq(EXTI5_9_IRQ);
+    /* Check that there are no interrupts already pending in PR */
+    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    /* Check that this specific interrupt isn't pending in NVIC */
+    g_assert_false(check_nvic_pending(EXTI5_9_IRQ));
+
+    /* Enable interrupt lines EXTI[5..9] */
+    exti_writel(EXTI_IMR1, (0x1F << 5));
+
+    /* Configure interrupt on rising edge */
+    exti_writel(EXTI_RTSR1, (0x1F << 5));
+
+    /* Raise GPIO line i, check that the interrupt is pending */
+    for (unsigned i =3D 5; i < 10; i++) {
+        exti_set_irq(i, 1);
+        g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 1 << i);
+        g_assert_true(check_nvic_pending(EXTI5_9_IRQ));
+
+        exti_writel(EXTI_PR1, 1 << i);
+        g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+        g_assert_true(check_nvic_pending(EXTI5_9_IRQ));
+
+        unpend_nvic_irq(EXTI5_9_IRQ);
+        g_assert_false(check_nvic_pending(EXTI5_9_IRQ));
+    }
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -515,6 +550,8 @@ int main(int argc, char **argv)
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
2.43.2


