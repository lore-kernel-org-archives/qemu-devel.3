Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D8EC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 20:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaKhl-0007hg-FR; Fri, 11 Jul 2025 16:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uaKee-0003ca-ES; Fri, 11 Jul 2025 16:47:37 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uaKec-0003wu-Il; Fri, 11 Jul 2025 16:47:36 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 221BA135D0E;
 Fri, 11 Jul 2025 23:46:05 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0052223FF48;
 Fri, 11 Jul 2025 23:46:32 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.19 15/15] target/arm: Fix f16_dotadd vs nan selection
Date: Fri, 11 Jul 2025 23:46:30 +0300
Message-ID: <20250711204632.1804872-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-7.2.19-20250711111933@cover.tls.msk.ru>
References: <qemu-stable-7.2.19-20250711111933@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Implement FPProcessNaNs4 within f16_dotadd, rather than
simply letting NaNs propagate through the function.

Cc: qemu-stable@nongnu.org
Fixes: 3916841ac75 ("target/arm: Implement FMOPA, FMOPS (widening)")
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit cfc688c00ade84f6b32c7814b52c217f1d3b5eb1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/sme_helper.c b/target/arm/sme_helper.c
index fd5625c87e..e8b4ca38ff 100644
--- a/target/arm/sme_helper.c
+++ b/target/arm/sme_helper.c
@@ -1022,25 +1022,55 @@ static float32 f16_dotadd(float32 sum, uint32_t e1, uint32_t e2,
      *  - we have pre-set-up copy of s_std which is set to round-to-odd,
      *    for the multiply (see below)
      */
-    float64 e1r = float16_to_float64(e1 & 0xffff, true, s_f16);
-    float64 e1c = float16_to_float64(e1 >> 16, true, s_f16);
-    float64 e2r = float16_to_float64(e2 & 0xffff, true, s_f16);
-    float64 e2c = float16_to_float64(e2 >> 16, true, s_f16);
-    float64 t64;
+    float16 h1r = e1 & 0xffff;
+    float16 h1c = e1 >> 16;
+    float16 h2r = e2 & 0xffff;
+    float16 h2c = e2 >> 16;
     float32 t32;
 
-    /*
-     * The ARM pseudocode function FPDot performs both multiplies
-     * and the add with a single rounding operation.  Emulate this
-     * by performing the first multiply in round-to-odd, then doing
-     * the second multiply as fused multiply-add, and rounding to
-     * float32 all in one step.
-     */
-    t64 = float64_mul(e1r, e2r, s_odd);
-    t64 = float64r32_muladd(e1c, e2c, t64, 0, s_std);
+    /* C.f. FPProcessNaNs4 */
+    if (float16_is_any_nan(h1r) || float16_is_any_nan(h1c) ||
+        float16_is_any_nan(h2r) || float16_is_any_nan(h2c)) {
+        float16 t16;
+
+        if (float16_is_signaling_nan(h1r, s_f16)) {
+            t16 = h1r;
+        } else if (float16_is_signaling_nan(h1c, s_f16)) {
+            t16 = h1c;
+        } else if (float16_is_signaling_nan(h2r, s_f16)) {
+            t16 = h2r;
+        } else if (float16_is_signaling_nan(h2c, s_f16)) {
+            t16 = h2c;
+        } else if (float16_is_any_nan(h1r)) {
+            t16 = h1r;
+        } else if (float16_is_any_nan(h1c)) {
+            t16 = h1c;
+        } else if (float16_is_any_nan(h2r)) {
+            t16 = h2r;
+        } else {
+            t16 = h2c;
+        }
+        t32 = float16_to_float32(t16, true, s_f16);
+    } else {
+        float64 e1r = float16_to_float64(h1r, true, s_f16);
+        float64 e1c = float16_to_float64(h1c, true, s_f16);
+        float64 e2r = float16_to_float64(h2r, true, s_f16);
+        float64 e2c = float16_to_float64(h2c, true, s_f16);
+        float64 t64;
 
-    /* This conversion is exact, because we've already rounded. */
-    t32 = float64_to_float32(t64, s_std);
+        /*
+         * The ARM pseudocode function FPDot performs both multiplies
+         * and the add with a single rounding operation.  Emulate this
+         * by performing the first multiply in round-to-odd, then doing
+         * the second multiply as fused multiply-add, and rounding to
+         * float32 all in one step.
+         */
+        t64 = float64_mul(e1r, e2r, s_odd);
+        t64 = float64r32_muladd(e1c, e2c, t64, 0, s_std);
+
+        /* This conversion is exact, because we've already rounded. */
+        t32 = float64_to_float32(t64, s_std);
+    }
 
     /* The final accumulation step is not fused. */
     return float32_add(sum, t32, s_std);
-- 
2.47.2


