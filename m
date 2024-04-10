Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B46CD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSPq-00037b-4Q; Wed, 10 Apr 2024 03:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSPZ-0002wR-30; Wed, 10 Apr 2024 03:30:26 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSPW-00055p-FR; Wed, 10 Apr 2024 03:30:23 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DF6835D6BA;
 Wed, 10 Apr 2024 10:25:07 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 84E07B02FA;
 Wed, 10 Apr 2024 10:23:09 +0300 (MSK)
Received: (nullmailer pid 4191873 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 74/87] tcg/optimize: Fix sign_mask for logical
 right-shift
Date: Wed, 10 Apr 2024 10:22:47 +0300
Message-Id: <20240410072303.4191455-74-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

The 'sign' computation is attempting to locate the sign bit that has
been repeated, so that we can test if that bit is known zero.  That
computation can be zero if there are no known sign repetitions.

Cc: qemu-stable@nongnu.org
Fixes: 93a967fbb57 ("tcg/optimize: Propagate sign info for shifting")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2248
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 2911e9b95f3bb03783ae5ca3e2494dc3b44a9161)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/optimize.c b/tcg/optimize.c
index f2d01654c5..6fcdda68ef 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2123,7 +2123,7 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
          * will not reduced the number of input sign repetitions.
          */
         sign = (s_mask & -s_mask) >> 1;
-        if (!(z_mask & sign)) {
+        if (sign && !(z_mask & sign)) {
             ctx->s_mask = s_mask;
         }
         break;
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index ea3e232e65..0efd565f05 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -10,6 +10,7 @@ VPATH 		+= $(AARCH64_SRC)
 
 # Base architecture tests
 AARCH64_TESTS=fcvt pcalign-a64 lse2-fault
+AARCH64_TESTS += test-2248
 
 fcvt: LDFLAGS+=-lm
 
diff --git a/tests/tcg/aarch64/test-2248.c b/tests/tcg/aarch64/test-2248.c
new file mode 100644
index 0000000000..aac2e17836
--- /dev/null
+++ b/tests/tcg/aarch64/test-2248.c
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* See https://gitlab.com/qemu-project/qemu/-/issues/2248 */
+
+#include <assert.h>
+
+__attribute__((noinline))
+long test(long x, long y, long sh)
+{
+    long r;
+    asm("cmp   %1, %2\n\t"
+        "cset  x12, lt\n\t"
+        "and   w11, w12, #0xff\n\t"
+        "cmp   w11, #0\n\t"
+        "csetm x14, ne\n\t"
+        "lsr   x13, x14, %3\n\t"
+        "sxtb  %0, w13"
+        : "=r"(r)
+        : "r"(x), "r"(y), "r"(sh)
+        : "x11", "x12", "x13", "x14");
+    return r;
+}
+
+int main()
+{
+    long r = test(0, 1, 2);
+    assert(r == -1);
+    return 0;
+}
-- 
2.39.2


