Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26708CCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB5i-0006QH-19; Sat, 17 Oct 2026 16:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB4Y-00046v-Nf; Sat, 17 Oct 2026 16:32:12 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB4X-0004ZB-3S; Sat, 17 Oct 2026 16:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268882; bh=TWBxVKz82Up+sx4uZne6YUeNc6ojmMAxAlQXgNEi9Ds=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=g4Iej4Qt/Th8oLhSfcN2jG84H8CUPU811covLqSmiPBMJXmlL143qXPT09a8uYMDz
 0IHfG+Y77zxEpOcupjObLKDIBwag3WNq9UoZGKTw6tsvdYECk2PSojj0VorAZn3w44
 ysbv3ULyBZYdPmrbz1XgzKa0/lJuZ67F09G2viOilKotS+uzdRSmazyJ+riDOKhjNB
 51A0uqxii3fniqr6IgQsS9bmNT4H+XJa6ZSFrptP9gs7P+pvNytkuFV39oDon0PC1K
 wlQSmWvPYY8h+/kA3vaLP1bJ6vKg0WRW1sflmwRivHH5WfJQqgcWodCYcgCiqlmCNx
 mSpXsXuj8MNFA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D0CA91DE774;
 Sat, 17 Oct 2026 23:28:02 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id CA556443448;
 Sat, 17 Oct 2026 23:28:01 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Dominic P <gcc@gcc.dp11.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 54/73] tests/tcg: Add tests for sign extension after
 rotate
Date: Sat, 17 Oct 2026 23:26:12 +0300
Message-ID: <20261017202638.728621-54-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Dominic P <gcc@gcc.dp11.uk>

Cover the rotr_i32 (ARM ror) and rotl_i32 (i386 roll) forms fixed by
the previous patch.  Both tests fail without it.

Signed-off-by: Dominic P <gcc@gcc.dp11.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260930185124.3036980-3-gcc@gcc.dp11.uk>
(cherry picked from commit f9ca6b19acb1b935e7abc920410c993b059a8b4d)
(Mjt: back-port across Makefile=>meson conversion for tests)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index 51a3ed76a8..1e5b32ccfe 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -34,6 +34,9 @@ pcalign-a32: CFLAGS+=-marm
 
 ARM_TESTS += issue4448
 
+ARM_TESTS += test-arm-opt-ror
+test-arm-opt-ror: CFLAGS+=-marm
+
 ifeq ($(CONFIG_ARM_COMPATIBLE_SEMIHOSTING),y)
 
 # Semihosting smoke test for linux-user
diff --git a/tests/tcg/arm/test-arm-opt-ror.c b/tests/tcg/arm/test-arm-opt-ror.c
new file mode 100644
index 0000000000..2579168a13
--- /dev/null
+++ b/tests/tcg/arm/test-arm-opt-ror.c
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Regression test for tcg optimize vs sign bit repetitions after rotate. */
+
+#include <assert.h>
+
+int main(void)
+{
+    /* Load from memory so that TCG does not see a constant. */
+    volatile int v = 3;
+    int x = v, gt;
+
+    asm("sxtb %1, %1\n\t"
+        "ror %1, %1, #1\n\t"
+        "sxtb %1, %1\n\t"
+        "cmp %1, #0\n\t"
+        "movle %0, #0\n\t"
+        "movgt %0, #1"
+        : "=r"(gt), "+r"(x) : : "cc");
+    assert(gt);
+    return 0;
+}
diff --git a/tests/tcg/i386/test-i386-opt-rol.c b/tests/tcg/i386/test-i386-opt-rol.c
new file mode 100644
index 0000000000..e0393147e1
--- /dev/null
+++ b/tests/tcg/i386/test-i386-opt-rol.c
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Regression test for tcg optimize vs sign bit repetitions after rotate. */
+
+#include <assert.h>
+
+int main(void)
+{
+    /* Load from memory so that TCG does not see a constant. */
+    volatile int v = 3;
+    int x = v;
+    char test;
+
+    asm("movsbl %b1, %1\n\t"
+        "roll $31, %1\n\t"
+        "movsbl %b1, %1\n\t"
+        "testl %1, %1\n\t"
+        "setg %0"
+        : "=q"(test), "+q"(x));
+    assert(test);
+    return 0;
+}
-- 
2.47.3


