Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C34C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 15:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPOmA-0000vv-Ol; Thu, 04 Jul 2024 11:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPOm9-0000qV-Cl; Thu, 04 Jul 2024 11:53:37 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPOm6-00027p-Ct; Thu, 04 Jul 2024 11:53:37 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 361B37749C;
 Thu,  4 Jul 2024 18:52:47 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E76EAFEAE7;
 Thu,  4 Jul 2024 18:52:51 +0300 (MSK)
Received: (nullmailer pid 1481712 invoked by uid 1000);
 Thu, 04 Jul 2024 15:52:51 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.6 14/18] target/arm: Fix FJCVTZS vs flush-to-zero
Date: Thu,  4 Jul 2024 18:52:45 +0300
Message-Id: <20240704155251.1481617-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.6-20240704154854@cover.tls.msk.ru>
References: <qemu-stable-8.2.6-20240704154854@cover.tls.msk.ru>
MIME-Version: 1.0
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

Input denormals cause the Javascript inexact bit
(output to Z) to be set.

Cc: qemu-stable@nongnu.org
Fixes: 6c1f6f2733a ("target/arm: Implement ARMv8.3-JSConv")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2375
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240625183536.1672454-4-richard.henderson@linaro.org
[PMM: fixed hardcoded tab in test case]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 7619129f0d4a14d918227c5c47ad7433662e9ccc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 3e5e37abbe..ff59bc5522 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -1121,8 +1121,8 @@ const FloatRoundMode arm_rmode_to_sf_map[] = {
 uint64_t HELPER(fjcvtzs)(float64 value, void *vstatus)
 {
     float_status *status = vstatus;
-    uint32_t inexact, frac;
-    uint32_t e_old, e_new;
+    uint32_t frac, e_old, e_new;
+    bool inexact;
 
     e_old = get_float_exception_flags(status);
     set_float_exception_flags(0, status);
@@ -1130,13 +1130,13 @@ uint64_t HELPER(fjcvtzs)(float64 value, void *vstatus)
     e_new = get_float_exception_flags(status);
     set_float_exception_flags(e_old | e_new, status);
 
-    if (value == float64_chs(float64_zero)) {
-        /* While not inexact for IEEE FP, -0.0 is inexact for JavaScript. */
-        inexact = 1;
-    } else {
-        /* Normal inexact or overflow or NaN */
-        inexact = e_new & (float_flag_inexact | float_flag_invalid);
-    }
+    /* Normal inexact, denormal with flush-to-zero, or overflow or NaN */
+    inexact = e_new & (float_flag_inexact |
+                       float_flag_input_denormal |
+                       float_flag_invalid);
+
+    /* While not inexact for IEEE FP, -0.0 is inexact for JavaScript. */
+    inexact |= value == float64_chs(float64_zero);
 
     /* Pack the result and the env->ZF representation of Z together.  */
     return deposit64(frac, 32, 32, inexact);
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 70d728ae9a..4ecbca6a41 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -41,8 +41,9 @@ endif
 
 # Pauth Tests
 ifneq ($(CROSS_CC_HAS_ARMV8_3),)
-AARCH64_TESTS += pauth-1 pauth-2 pauth-4 pauth-5
+AARCH64_TESTS += pauth-1 pauth-2 pauth-4 pauth-5 test-2375
 pauth-%: CFLAGS += -march=armv8.3-a
+test-2375: CFLAGS += -march=armv8.3-a
 run-pauth-1: QEMU_OPTS += -cpu max
 run-pauth-2: QEMU_OPTS += -cpu max
 # Choose a cpu with FEAT_Pauth but without FEAT_FPAC for pauth-[45].
diff --git a/tests/tcg/aarch64/test-2375.c b/tests/tcg/aarch64/test-2375.c
new file mode 100644
index 0000000000..84c7e7de71
--- /dev/null
+++ b/tests/tcg/aarch64/test-2375.c
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright (c) 2024 Linaro Ltd */
+/* See https://gitlab.com/qemu-project/qemu/-/issues/2375 */
+
+#include <assert.h>
+
+int main(void)
+{
+   int r, z;
+
+   asm("msr fpcr, %2\n\t"
+       "fjcvtzs %w0, %d3\n\t"
+       "cset %1, eq"
+       : "=r"(r), "=r"(z)
+       : "r"(0x01000000L),      /* FZ = 1 */
+         "w"(0xfcff00L));       /* denormal */
+
+    assert(r == 0);
+    assert(z == 0);
+    return 0;
+}
-- 
2.39.2


