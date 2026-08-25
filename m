Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6C8C61DBC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wylGq-0000oS-Lt; Tue, 25 Aug 2026 03:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylGp-0000km-3X; Tue, 25 Aug 2026 03:08:31 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylGn-0006AE-DO; Tue, 25 Aug 2026 03:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787641596; bh=FUky0Z9TsiS5FZAo3nier7DOXzdfCbyLN24PGT3kvDE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=M0iC85DI2RlguPcCgOEWNcTnggXEqiLDs+0fKlifa5vYK+gqSja3XNJcvQG5Nx+qD
 /eyc1Hz/F1fMhH4oAJak2TwQpQrgc30ryC1c5GME2WrfEQplDqXALlbbXEQNrbVlvn
 TRxObfwT+SWscOOj/mswYM6Xp7gOKLmnFjPApa0F+Gtm3J1W7waRkAePHSE6rCN5V8
 jjZzcJHceBSm49Toe3vN3C+PPyq0xTVnDFZVrchCMwovJR+5gHsSdYGVuUowoJVAkg
 zEwPeCQmp7M+ZUaKs3V84z9X1kk43pi+aylo2zV1IMbzwEloUJvrwE4ntIpwSeYJbU
 egtNT6eE/KPDw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 477361CE222;
 Tue, 25 Aug 2026 10:06:36 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0B52D415F9D;
 Tue, 25 Aug 2026 10:07:13 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 9A8DF32424; Tue, 25 Aug 2026 10:06:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.1 v2 61/91] tests/tcg/aarch64: Add regression test for
 whilewr/whilerw
Date: Tue, 25 Aug 2026 10:05:33 +0300
Message-ID: <20260825070619.174584-19-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.1-20260825100540@cover.tls.msk.ru>
References: <qemu-stable-11.1.1-20260825100540@cover.tls.msk.ru>
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260811191540.79882-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 32953700108cc3305f27b591d66b5fb73806266a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 32f26892737..6cc81bf854f 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -203,8 +203,9 @@ endif
 endif
 
 ifneq ($(CROSS_CC_HAS_SVE2),)
-AARCH64_TESTS += test-826
-test-826: CFLAGS += $(CROSS_CC_HAS_SVE2)
+SVE2_TESTS = test-826 sve-while-ptr
+$(SVE2_TESTS): CFLAGS += $(CROSS_CC_HAS_SVE2)
+AARCH64_TESTS += $(SVE2_TESTS)
 endif
 
 TESTS += $(AARCH64_TESTS)
diff --git a/tests/tcg/aarch64/sve-while-ptr.c b/tests/tcg/aarch64/sve-while-ptr.c
new file mode 100644
index 00000000000..7db3b9cc035
--- /dev/null
+++ b/tests/tcg/aarch64/sve-while-ptr.c
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* WHILEWR / WHILERW regression test */
+
+#include <sys/prctl.h>
+#include <assert.h>
+
+int main(int argc, char **argv)
+{
+    unsigned short p;
+    int set_vl_ret;
+
+    set_vl_ret = prctl(PR_SVE_SET_VL, 16, 0, 0, 0, 0);
+    assert(set_vl_ret == 16);
+
+    p = 0xdead;
+    asm("whilewr p0.s, %0, %1\n\t"
+        "str p0, [%2]"
+        : : "r"(8), "r"(11), "r"(&p) : "memory", "p0");
+    assert(p == 0x1111);
+
+    p = 0xdead;
+    asm("whilerw p0.s, %0, %1\n\t"
+        "str p0, [%2]"
+        : : "r"(8), "r"(11), "r"(&p) : "memory", "p0");
+    assert(p == 0x1111);
+
+    return 0;
+}
-- 
2.47.3


