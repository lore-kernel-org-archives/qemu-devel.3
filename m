Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49ECC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvxWE-0004Jv-Ci; Mon, 17 Aug 2026 09:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvxW6-0004E2-PY; Mon, 17 Aug 2026 09:36:42 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvxW2-0007Qi-Pe; Mon, 17 Aug 2026 09:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786973727; bh=auui/cjvOi9HU+1/WhOB3jz6kcr7EoQpfLfmv5n7Iqs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OKmTMLJnqrO8uogwQVnz94PV3P/doxMdR6Wdtzhhq0opamVBUWc1h90IL+SJR+raf
 oCWG0nY0i3zWevMOr8Myj5i4Jjk8gmD2SgypQ3lHY+bhlV3L3cGVHJm6NVuwuiU5C+
 HTtyvt0+92B2rF2Op2XFxBkfcWdR36cSHE8jpyNUgQZql+Y5HZ898bHB+HjOX9pN/S
 FPWHqDgbIghjIlLwgLrdM/PP8Bmd/DB9ubYgNPCUUFbyPobyVFWKNABHBMmZlCFXLa
 dEvjhaGcG4McgABZPf8S+rOqeJuWA5cRx11WGXrTiXbkRc7V29c7shg1lD0x8NjeNI
 om37TXfb/3UZA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 48D501CBCC5;
 Mon, 17 Aug 2026 16:35:27 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 840BA40D422;
 Mon, 17 Aug 2026 16:35:48 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B5A2530F94; Mon, 17 Aug 2026 16:35:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 v2 118/135] tests/tcg/s390x: Test STCKF condition
 code on a faulting store
Date: Mon, 17 Aug 2026 16:34:28 +0300
Message-ID: <20260817133451.2384630-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260817151855@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260817151855@cover.tls.msk.ru>
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

Add a small test to prevent regressions.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260714203206.363028-3-iii@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
(cherry picked from commit e79ea4472691fd7f7b3436dafbabd17c78fc8bf4)
(Mjt: context fix in tests/tcg/s390x/Makefile.target)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index e5fa30da845..ff165f05eb1 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -49,6 +49,7 @@ TESTS+=cvd
 TESTS+=cvb
 TESTS+=ts
 TESTS+=ex-smc
+TESTS+=stckf
 
 cdsg: CFLAGS+=-pthread
 cdsg: LDFLAGS+=-pthread
diff --git a/tests/tcg/s390x/stckf.c b/tests/tcg/s390x/stckf.c
new file mode 100644
index 00000000000..51c8c9df9f8
--- /dev/null
+++ b/tests/tcg/s390x/stckf.c
@@ -0,0 +1,44 @@
+/*
+ * Test that a faulting STORE CLOCK FAST does not clobber the condition code.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+static void handle_sigsegv(int sig, siginfo_t *info, void *ucontext)
+{
+    mcontext_t *mcontext = &((ucontext_t *)ucontext)->uc_mcontext;
+
+    /* The condition code must be the one set by SLGR, not garbage. */
+    _exit(((mcontext->psw.mask >> 44) & 3) == 3 ? EXIT_SUCCESS : EXIT_FAILURE);
+}
+
+int main(void)
+{
+    struct sigaction act = {
+        .sa_sigaction = handle_sigsegv,
+        .sa_flags = SA_SIGINFO,
+    };
+    int err;
+
+    err = sigaction(SIGSEGV, &act, NULL);
+    assert(err == 0);
+
+    asm volatile(
+        "lghi %%r1,100\n"
+        "lghi %%r2,0\n"
+        "clgr %%r1,%%r2\n"  /* CC_OP_LTUGTU_64 */
+                            /* cc_src=100 is not valid for CC_OP_SUBU */
+        "ipm %%r0\n"        /* force cc_src to env */
+        "lghi %%r3,5\n"
+        "lghi %%r4,3\n"
+        "slgr %%r3,%%r4\n"  /* CC_OP_SUBU, cc=3 */
+        "lghi %%r5,0\n"
+        "stckf 0(%%r5)\n"   /* faults; cc must stay 3 */
+        : : : "r0", "r1", "r2", "r3", "r4", "r5", "cc", "memory");
+
+    return EXIT_FAILURE;
+}
-- 
2.47.3


