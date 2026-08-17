Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1800C5DF70
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvuqK-0001Dn-U5; Mon, 17 Aug 2026 06:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvuqD-00015j-G0; Mon, 17 Aug 2026 06:45:19 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvuqB-0003xv-8g; Mon, 17 Aug 2026 06:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786963486; bh=wYUETFF1LQO8SvgC6w5ZcuhX3jpAWcfrMpU6PRcjqp8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=WjETkO08Cddv6rqLO3g2ahwINsU/+UKozno0VGBHSYUEa1YHToNFaVBm7ALWkW5eI
 SDyzJMdjfWMrwUPm2ByuYJFjhY1GGot1DruR//EGX3iX8B9KfgQMr8FpflnmG9pJxf
 M/PCaj4TZhndR3Fg9nKV8fubCr/GS1a7vgmj7oZ+3BIkIAJNHeZ85pz8eXZzdvVR2h
 Yy4ayRK7U/MrVAAWEytzuMoR1Bp3x3e7pa8k5YnriAX25EJOJUXV0Zc3Cy6OYwo7/M
 c2XOv0x3KObKyi/yXuDz1epOQpvi7UGg7KWFvmYP/bEtWaGTFCqt+Qfu85BT35QhyI
 03w9fJaQImrBg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 657871CBB6B;
 Mon, 17 Aug 2026 13:44:46 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 66F8840D1FB;
 Mon, 17 Aug 2026 13:45:07 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id F1E6330E4E; Mon, 17 Aug 2026 13:44:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Harald Freudenberger <freude@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 v2 126/161] tests/tcg/s390x: Test PRNO TRNG
 interruptibility
Date: Mon, 17 Aug 2026 13:42:40 +0300
Message-ID: <20260817104344.2047346-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260817125055@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260817125055@cover.tls.msk.ru>
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Add a small test that issues a large PRNO TRNG request while a timer is
running, and checks that the timer interrupts it several times.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260714191948.342204-3-iii@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
(cherry picked from commit abe1d893f41d5fcbdabc22f46ec148069a4ef319)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 0ca030ded01..48cba4cdfa4 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -75,6 +75,7 @@ Z13_TESTS+=vcksm
 Z13_TESTS+=vstl
 Z13_TESTS+=vrep
 Z13_TESTS+=precise-smc-user
+Z13_TESTS+=prno-trng
 $(Z13_TESTS): CFLAGS+=-march=z13 -O2
 TESTS+=$(Z13_TESTS)
 
diff --git a/tests/tcg/s390x/prno-trng.c b/tests/tcg/s390x/prno-trng.c
new file mode 100644
index 00000000000..43eea5db1dc
--- /dev/null
+++ b/tests/tcg/s390x/prno-trng.c
@@ -0,0 +1,67 @@
+/*
+ * Test that PERFORM RANDOM NUMBER OPERATION TRNG is interruptible.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/time.h>
+#include <asm/ucontext.h>
+
+static unsigned char buf1[16 * 1024 * 1024];
+static unsigned char buf2[16 * 1024 * 1024];
+
+static volatile sig_atomic_t interrupted;
+
+static void sigprof_handler(int sig, siginfo_t *info, void *ucontext)
+{
+    struct ucontext *uc = ucontext;
+    unsigned long addr = uc->uc_mcontext.regs.psw.addr;
+
+    if (*(unsigned short *)(addr - 4) == 0xb93c) {
+        interrupted++;
+    }
+}
+
+static void prno_trng(void *b1, unsigned long l1, void *b2, unsigned long l2)
+{
+    register unsigned long r0 asm("r0") = 114;  /* TRNG */
+    register unsigned long r2 asm("r2") = (unsigned long)b1;
+    register unsigned long r3 asm("r3") = l1;
+    register unsigned long r4 asm("r4") = (unsigned long)b2;
+    register unsigned long r5 asm("r5") = l2;
+
+    asm volatile("0: ppno %[r2],%[r4]\n"  /* prno alias for old toolchains */
+                 "   jo 0b"
+                 : [r2] "+r" (r2), [r3] "+r" (r3)
+                 , [r4] "+r" (r4), [r5] "+r" (r5)
+                 : "r" (r0)
+                 : "cc", "memory");
+}
+
+int main(void)
+{
+    struct itimerval it = {
+        .it_interval = { .tv_usec = 10000 },  /* 0.01s */
+        .it_value = { .tv_usec = 10000 },
+    };
+    struct sigaction act = {
+        .sa_sigaction = sigprof_handler,
+        .sa_flags = SA_SIGINFO,
+    };
+    int err;
+
+    err = sigaction(SIGPROF, &act, NULL);
+    assert(err == 0);
+    err = setitimer(ITIMER_PROF, &it, NULL);
+    assert(err == 0);
+
+    prno_trng(buf1, sizeof(buf1), buf2, sizeof(buf2));
+    printf("interrupted %d times\n", interrupted);
+    assert(interrupted >= 3);
+
+    return EXIT_SUCCESS;
+}
-- 
2.47.3


