Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E583AC27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 10:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNVZy-0000VR-Fv; Sat, 29 Jun 2024 06:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1sNVZv-0000TY-VF
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 06:45:12 -0400
Received: from zproxy4.enst.fr ([2001:660:330f:2::df])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1sNVZt-0005jZ-Gr
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 06:45:11 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id 58066209FE;
 Sat, 29 Jun 2024 12:45:03 +0200 (CEST)
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id zFCZpdyG1B3F; Sat, 29 Jun 2024 12:45:02 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id A3DC1209B3;
 Sat, 29 Jun 2024 12:45:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy4.enst.fr A3DC1209B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1719657902;
 bh=7u9l8fDOYqNCPgJ7I2tfMk4yn2eb2vxdl4GhQ1/oreU=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=X5ZWh1Sf0Z2dnAMh2DpbNEi23JkwQ0XT1Mz8RAu9oInVFjL3z4j5DQJPr9bMEspBV
 toujijot8xPDjFL/iwb51ypH1GemJXIHdgX4N2FR4aB556k6DL1B1MtAnJO9mmMOIL
 lXvgeY26f2n+XsYN7u4+GTjX1gCqRlOx0vlRHKQM=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id F5amyhFnoOGL; Sat, 29 Jun 2024 12:45:02 +0200 (CEST)
Received: from inesv-Inspiron-3501.enst.fr (unknown
 [IPv6:2a04:8ec0:0:124::190c])
 by zproxy4.enst.fr (Postfix) with ESMTPSA id 7FE0620931;
 Sat, 29 Jun 2024 12:45:01 +0200 (CEST)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
Subject: [PATCH] tests/qtest: Fix STM32L4x5 SYSCFG irq line 15 state assumption
Date: Sat, 29 Jun 2024 12:44:49 +0200
Message-ID: <20240629104454.366283-1-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:660:330f:2::df;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy4.enst.fr
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

The QTest `test_irq_pin_multiplexer` makes the assumption that the
reset state of irq line 15 is low, which is false since STM32L4x5 GPIO
was implemented (the reset state of pin GPIOA15 is high because there's
pull-up and it results in the irq line 15 also being high at reset).

It wasn't triggering an error because `test_interrupt` was mistakenly
"resetting" the line low.

This commit corrects these two mistakes by :
- not setting the line low in `test_interrupt`
- using an irq line in `test_irq_pin_multiplexer` which is low at reset

Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 tests/qtest/stm32l4x5_syscfg-test.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/qtest/stm32l4x5_syscfg-test.c b/tests/qtest/stm32l4x5_=
syscfg-test.c
index 506ca08bc2..1cdf8f05c8 100644
--- a/tests/qtest/stm32l4x5_syscfg-test.c
+++ b/tests/qtest/stm32l4x5_syscfg-test.c
@@ -223,7 +223,7 @@ static void test_interrupt(void)
     /* Clean the test */
     syscfg_writel(SYSCFG_EXTICR1, 0x00000000);
     syscfg_set_irq(0, 0);
-    syscfg_set_irq(15, 0);
+    /* irq 15 is high at reset because GPIOA15 is high at reset */
     syscfg_set_irq(17, 0);
 }
=20
@@ -237,21 +237,21 @@ static void test_irq_pin_multiplexer(void)
=20
     syscfg_set_irq(0, 1);
=20
-    /* Check that irq 0 was set and irq 15 wasn't */
+    /* Check that irq 0 was set and irq 2 wasn't */
     g_assert_true(get_irq(0));
-    g_assert_false(get_irq(15));
+    g_assert_false(get_irq(2));
=20
     /* Clean the test */
     syscfg_set_irq(0, 0);
=20
-    syscfg_set_irq(15, 1);
+    syscfg_set_irq(2, 1);
=20
-    /* Check that irq 15 was set and irq 0 wasn't */
-    g_assert_true(get_irq(15));
+    /* Check that irq 2 was set and irq 0 wasn't */
+    g_assert_true(get_irq(2));
     g_assert_false(get_irq(0));
=20
     /* Clean the test */
-    syscfg_set_irq(15, 0);
+    syscfg_set_irq(2, 0);
 }
=20
 static void test_irq_gpio_multiplexer(void)
--=20
2.43.2


