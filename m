Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC7D60A2602
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VvZz/GpD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNSLB-0006jL-I6; Sun, 01 Nov 2026 04:59:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xNSL9-0006iQ-Jk
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 04:59:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xNSL7-0007tR-AD
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 04:59:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793527140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G+13MHGxkLuqyCbEbeMYCXfsI+orEiWeW3Xo6ulnYe8=;
 b=VvZz/GpDZSPp18iXsFeeNczA4/MviBsD9wqGkrqxKDXZ3gjpTFb4H+TNJMWK5oEyS1ZeUI
 8y8dOoLVOs+6o3HFrVA61ujHG4UacKMMr883t6BZqL0JeSRZ5mUwhM9CgLUuLRCZHnzEUG
 JiUZsHr+6kZB13HZCmf4qmLmEo6MMUA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-gpXCOsV7Mcu4y88KNj1V5Q-1; Sun,
 01 Nov 2026 04:58:56 -0500
X-MC-Unique: gpXCOsV7Mcu4y88KNj1V5Q-1
X-Mimecast-MFC-AGG-ID: gpXCOsV7Mcu4y88KNj1V5Q_1793527136
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C1C0E180066E; Sun,  1 Nov 2026 09:58:55 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E00D81800495; Sun,  1 Nov 2026 09:58:54 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jiang Yuxuan <hooyan2024@gmail.com>
Subject: [PULL 01/10] target/i386: raise #DE for INT_MIN / -1 in IDIV helpers
Date: Sun,  1 Nov 2026 10:58:42 +0100
Message-ID: <20261101095851.1557351-2-pbonzini@redhat.com>
In-Reply-To: <20261101095851.1557351-1-pbonzini@redhat.com>
References: <20261101095851.1557351-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
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
---
 target/i386/tcg/int_helper.c        |  4 +-
 tests/tcg/i386/test-idiv-overflow.c | 70 +++++++++++++++++++++++++++++
 tests/tcg/i386/meson.build          |  1 +
 tests/tcg/x86_64/meson.build        |  1 +
 4 files changed, 74 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/i386/test-idiv-overflow.c

diff --git a/target/i386/tcg/int_helper.c b/target/i386/tcg/int_helper.c
index 772e6adcc86..d4fa89166b4 100644
--- a/target/i386/tcg/int_helper.c
+++ b/target/i386/tcg/int_helper.c
@@ -91,7 +91,7 @@ void HELPER(idivw_AX)(CPUX86State *env, target_ulong t0)
 
     num = (env->regs[R_EAX] & 0xffff) | ((env->regs[R_EDX] & 0xffff) << 16);
     den = (int16_t)t0;
-    if (den == 0) {
+    if (den == 0 || (num == INT32_MIN && den == -1)) {
         raise_exception_ra(env, EXCP00_DIVZ, GETPC());
     }
     q = (num / den);
@@ -130,7 +130,7 @@ void HELPER(idivl_EAX)(CPUX86State *env, target_ulong t0)
 
     num = ((uint32_t)env->regs[R_EAX]) | ((uint64_t)((uint32_t)env->regs[R_EDX]) << 32);
     den = t0;
-    if (den == 0) {
+    if (den == 0 || (num == INT64_MIN && den == -1)) {
         raise_exception_ra(env, EXCP00_DIVZ, GETPC());
     }
     q = (num / den);
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
diff --git a/tests/tcg/i386/meson.build b/tests/tcg/i386/meson.build
index e7c30958608..648b516582e 100644
--- a/tests/tcg/i386/meson.build
+++ b/tests/tcg/i386/meson.build
@@ -35,6 +35,7 @@ tests += {
     'cflags': [files('test-i386-code16.S'), files('test-i386-vm86.S'),
                '-lm', '-fno-pie', '-Wl,--no-warn-rwx-segments'],
   },
+  'test-idiv-overflow.c': {},
   '../multiarch/sha512.c': {
      'exe_name': 'sha512-sse',
      'cflags': ['-msse4.1', '-O3'],
diff --git a/tests/tcg/x86_64/meson.build b/tests/tcg/x86_64/meson.build
index ad4d1f558a7..fc7f48e98eb 100644
--- a/tests/tcg/x86_64/meson.build
+++ b/tests/tcg/x86_64/meson.build
@@ -48,6 +48,7 @@ tests += {
   },
   '../i386/test-i386-adcox.c': {'cflags': ['-O2']},
   '../i386/test-i386-bmi2.c': {'cflags': ['-O2', '-fwrapv']},
+  '../i386/test-idiv-overflow.c': {},
 }
 
 tests += {
-- 
2.56.0



