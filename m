Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750C3606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 05:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=J5tZV1vh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWoyb-0003RK-Lb; Fri, 27 Nov 2026 00:58:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWoyO-0003Kw-7C; Fri, 27 Nov 2026 00:58:16 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWoyM-0002SL-6V; Fri, 27 Nov 2026 00:58:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758877; bh=agkk0UFdPttvsVFMl2PQXrXnrWTB0RZErp1LFU/Obck=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=J5tZV1vh+eATJkLoJ3jK/2G6dhkfhUtTp+GMz8+6HtEwit+L+sE8SfZ0xKYI2A0u0
 kGABqOotqQ3ko21vHx4L/cNA6EIYslYohjZIYV5+ipn61ToZch3bFs9n79glWhaCVv
 aVMnX9uDF0E8HiBg30OBryGGLJ593ELPQA5lX2CdQobe9kJYWDCW7b5sYbW+A40t3e
 ZI7yftOqN6+lIL5+Kgtj2upQ3IiFXWdI44HOAQTnyUvFXYyzLH1X9G/AY5LWxZ524H
 j9pRsm4uPeKBPrQ/KEzNvdB5Dmbo/X2PFQetZPgIzI8eFz9lDK58tUrP2zs7Ah9/yq
 +TuFQfn2JKXzw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BBF131EA2EF;
 Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B994E46992A;
 Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 9F1FCCF260; Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jiang Yuxuan <hooyan2024@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 101/140] target/i386: raise #DE for INT_MIN / -1
 in IDIV helpers
Date: Fri, 27 Nov 2026 08:53:27 +0300
Message-ID: <20261127055421.39015-42-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jiang Yuxuan <hooyan2024@gmail.com>

helper_idivw_AX() and helper_idivl_EAX() perform the division before
checking whether the quotient fits in the destination.  If the dividend
is the minimum value and the divisor is -1, the division overflows in
the host: INT32_MIN / -1 and INT64_MIN / -1 are undefined behaviour in C
and trap with SIGFPE on x86 hosts.  QEMU then dies of a host SIGFPE
instead of raising #DE in the guest, taking down the emulator (or the
whole VM under TCG).

Reject the two overflowing cases before dividing.  The 8-bit form is not
affected (it widens the dividend to int), and the 64-bit form already
checks first.

Add a regression test for both the 16-bit and 32-bit forms, run by the
i386 and x86_64 linux-user test suites.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4687
Signed-off-by: fujo <hooyan2024@gmail.com>
Link: https://lore.kernel.org/r/CAAt7E3+jVR+YHZC3996kdC_Xrh9aVJ4YLy8X7+1HyjvOQk09Ug@mail.gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 4e61c4bb175d97f85f252977ac867f98c0ba8268)
(Mjt: back-port tests across make->meson conversion)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/int_helper.c b/target/i386/tcg/int_helper.c
index 1a02e9d8434..b570fbf34e8 100644
--- a/target/i386/tcg/int_helper.c
+++ b/target/i386/tcg/int_helper.c
@@ -92,7 +92,7 @@ void helper_idivw_AX(CPUX86State *env, target_ulong t0)
 
     num = (env->regs[R_EAX] & 0xffff) | ((env->regs[R_EDX] & 0xffff) << 16);
     den = (int16_t)t0;
-    if (den == 0) {
+    if (den == 0 || (num == INT32_MIN && den == -1)) {
         raise_exception_ra(env, EXCP00_DIVZ, GETPC());
     }
     q = (num / den);
@@ -131,7 +131,7 @@ void helper_idivl_EAX(CPUX86State *env, target_ulong t0)
 
     num = ((uint32_t)env->regs[R_EAX]) | ((uint64_t)((uint32_t)env->regs[R_EDX]) << 32);
     den = t0;
-    if (den == 0) {
+    if (den == 0 || (num == INT64_MIN && den == -1)) {
         raise_exception_ra(env, EXCP00_DIVZ, GETPC());
     }
     q = (num / den);
diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
index f1df40411b0..886a9767751 100644
--- a/tests/tcg/i386/Makefile.target
+++ b/tests/tcg/i386/Makefile.target
@@ -14,7 +14,7 @@ config-cc.mak: Makefile
 I386_SRCS=$(notdir $(wildcard $(I386_SRC)/*.c))
 ALL_X86_TESTS=$(I386_SRCS:.c=)
 SKIP_I386_TESTS=test-i386-ssse3 test-avx test-3dnow test-mmx test-flags
-X86_64_TESTS:=$(filter test-i386-adcox test-i386-bmi2 $(SKIP_I386_TESTS), $(ALL_X86_TESTS))
+X86_64_TESTS:=$(filter test-i386-adcox test-i386-bmi2 test-idiv-overflow $(SKIP_I386_TESTS), $(ALL_X86_TESTS))
 
 test-i386-sse-exceptions: CFLAGS += -msse4.1 -mfpmath=sse
 run-test-i386-sse-exceptions: QEMU_OPTS += -cpu max
diff --git a/tests/tcg/i386/test-idiv-overflow.c b/tests/tcg/i386/test-idiv-overflow.c
new file mode 100644
index 00000000000..e8fc55a0481
--- /dev/null
+++ b/tests/tcg/i386/test-idiv-overflow.c
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Test that IDIV of the minimum dividend by -1 raises #DE, which Linux
+ * delivers to the guest as SIGFPE with si_code == FPE_INTDIV.
+ */
+#define _GNU_SOURCE
+#include <setjmp.h>
+#include <signal.h>
+#include <stdio.h>
+#include <string.h>
+
+static sigjmp_buf idiv_jmp;
+static volatile sig_atomic_t idiv_si_code;
+
+static void idiv_sig_handler(int sig, siginfo_t *info, void *puc)
+{
+    (void)sig;
+    (void)puc;
+    idiv_si_code = info->si_code;
+    siglongjmp(idiv_jmp, 1);
+}
+
+static int check_idiv_overflow(int width)
+{
+    struct sigaction sa, old;
+    int ret = 1;
+
+    memset(&sa, 0, sizeof(sa));
+    sa.sa_sigaction = idiv_sig_handler;
+    sa.sa_flags = SA_SIGINFO | SA_NODEFER;
+    sigemptyset(&sa.sa_mask);
+    sigaction(SIGFPE, &sa, &old);
+
+    idiv_si_code = 0;
+    if (sigsetjmp(idiv_jmp, 1) == 0) {
+        if (width == 16) {
+            /* DX:AX = 0x8000:0x0000, divisor -1 */
+            __asm__ volatile ("movl $0x8000, %%edx\n\t"
+                              "xorl %%eax, %%eax\n\t"
+                              "movl $-1, %%ecx\n\t"
+                              "idivw %%cx"
+                              : : : "eax", "ecx", "edx", "cc");
+        } else {
+            /* EDX:EAX = 0x80000000:0x00000000, divisor -1 */
+            __asm__ volatile ("movl $0x80000000, %%edx\n\t"
+                              "xorl %%eax, %%eax\n\t"
+                              "movl $-1, %%ecx\n\t"
+                              "idivl %%ecx"
+                              : : : "eax", "ecx", "edx", "cc");
+        }
+        printf("FAIL: idiv%d did not raise #DE\n", width);
+    } else if (idiv_si_code != FPE_INTDIV) {
+        printf("FAIL: idiv%d raised SIGFPE with si_code %d\n",
+               width, (int)idiv_si_code);
+    } else {
+        ret = 0;
+    }
+
+    sigaction(SIGFPE, &old, NULL);
+    return ret;
+}
+
+int main(void)
+{
+    int ret = 0;
+
+    ret |= check_idiv_overflow(16);
+    ret |= check_idiv_overflow(32);
+    return ret;
+}
-- 
2.47.3


