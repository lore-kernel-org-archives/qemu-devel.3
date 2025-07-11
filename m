Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54656C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 08:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua99h-0003iG-2t; Fri, 11 Jul 2025 04:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua90e-0001y0-NP; Fri, 11 Jul 2025 04:21:34 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua90c-0004lo-Lg; Fri, 11 Jul 2025 04:21:32 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DDEC61356F2;
 Fri, 11 Jul 2025 11:17:20 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D63B823FA67;
 Fri, 11 Jul 2025 11:17:47 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 39/39] target/arm: Fix bfdotadd_ebf vs nan selection
Date: Fri, 11 Jul 2025 11:16:35 +0300
Message-ID: <20250711081745.1785806-39-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
References: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Implement FPProcessNaNs4 within bfdotadd_ebf, rather than
simply letting NaNs propagate through the function.

Cc: qemu-stable@nongnu.org
Fixes: 0e1850182a1 ("target/arm: Implement FPCR.EBF=1 semantics for bfdotadd()")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250704142112.1018902-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit bf020eaa6741711902a425016e2c7585f222562d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 986eaf8ffa..3b7f308803 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2989,31 +2989,62 @@ float32 bfdotadd(float32 sum, uint32_t e1, uint32_t e2, float_status *fpst)
 float32 bfdotadd_ebf(float32 sum, uint32_t e1, uint32_t e2,
                      float_status *fpst, float_status *fpst_odd)
 {
-    /*
-     * Compare f16_dotadd() in sme_helper.c, but here we have
-     * bfloat16 inputs. In particular that means that we do not
-     * want the FPCR.FZ16 flush semantics, so we use the normal
-     * float_status for the input handling here.
-     */
-    float64 e1r = float32_to_float64(e1 << 16, fpst);
-    float64 e1c = float32_to_float64(e1 & 0xffff0000u, fpst);
-    float64 e2r = float32_to_float64(e2 << 16, fpst);
-    float64 e2c = float32_to_float64(e2 & 0xffff0000u, fpst);
-    float64 t64;
+    float32 s1r = e1 << 16;
+    float32 s1c = e1 & 0xffff0000u;
+    float32 s2r = e2 << 16;
+    float32 s2c = e2 & 0xffff0000u;
     float32 t32;
 
-    /*
-     * The ARM pseudocode function FPDot performs both multiplies
-     * and the add with a single rounding operation.  Emulate this
-     * by performing the first multiply in round-to-odd, then doing
-     * the second multiply as fused multiply-add, and rounding to
-     * float32 all in one step.
-     */
-    t64 = float64_mul(e1r, e2r, fpst_odd);
-    t64 = float64r32_muladd(e1c, e2c, t64, 0, fpst);
+    /* C.f. FPProcessNaNs4 */
+    if (float32_is_any_nan(s1r) || float32_is_any_nan(s1c) ||
+        float32_is_any_nan(s2r) || float32_is_any_nan(s2c)) {
+        if (float32_is_signaling_nan(s1r, fpst)) {
+            t32 = s1r;
+        } else if (float32_is_signaling_nan(s1c, fpst)) {
+            t32 = s1c;
+        } else if (float32_is_signaling_nan(s2r, fpst)) {
+            t32 = s2r;
+        } else if (float32_is_signaling_nan(s2c, fpst)) {
+            t32 = s2c;
+        } else if (float32_is_any_nan(s1r)) {
+            t32 = s1r;
+        } else if (float32_is_any_nan(s1c)) {
+            t32 = s1c;
+        } else if (float32_is_any_nan(s2r)) {
+            t32 = s2r;
+        } else {
+            t32 = s2c;
+        }
+        /*
+         * FPConvertNaN(FPProcessNaN(t32)) will be done as part
+         * of the final addition below.
+         */
+    } else {
+        /*
+         * Compare f16_dotadd() in sme_helper.c, but here we have
+         * bfloat16 inputs. In particular that means that we do not
+         * want the FPCR.FZ16 flush semantics, so we use the normal
+         * float_status for the input handling here.
+         */
+        float64 e1r = float32_to_float64(s1r, fpst);
+        float64 e1c = float32_to_float64(s1c, fpst);
+        float64 e2r = float32_to_float64(s2r, fpst);
+        float64 e2c = float32_to_float64(s2c, fpst);
+        float64 t64;
 
-    /* This conversion is exact, because we've already rounded. */
-    t32 = float64_to_float32(t64, fpst);
+        /*
+         * The ARM pseudocode function FPDot performs both multiplies
+         * and the add with a single rounding operation.  Emulate this
+         * by performing the first multiply in round-to-odd, then doing
+         * the second multiply as fused multiply-add, and rounding to
+         * float32 all in one step.
+         */
+        t64 = float64_mul(e1r, e2r, fpst_odd);
+        t64 = float64r32_muladd(e1c, e2c, t64, 0, fpst);
+
+        /* This conversion is exact, because we've already rounded. */
+        t32 = float64_to_float32(t64, fpst);
+    }
 
     /* The final accumulation step is not fused. */
     return float32_add(sum, t32, fpst);
-- 
2.47.2


