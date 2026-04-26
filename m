Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0056FF8864
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzsX-0007eO-J8; Sun, 26 Apr 2026 09:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzs1-000763-W4
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:50:05 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzry-0002sh-1i
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:50:01 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-82f69a286dbso7071144b3a.2
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777211396; x=1777816196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xlytXwevs67gNFcr4ujyMnKHEGjQPMghBz+4SCH2y1E=;
 b=rlYK4HFapxxU61YSLBWquYxKAdV83KqThs1zA2qf4qXthQATjPPzbxRLxZ2Xn0C5Nj
 4cSF65xH2t1xn6/M2/udTyelID7P1czxCBy1N4G2I/SUy5Bh3F6s3Vvm1SjQc3czRgSl
 5u+3xyKYL2EyzT2/BGOpcpDK3lP2s2suECBAI5pK1qk0DmYGzP3uJgZeLf+0dbpvq8sO
 DUld/xedPlDw01OHpSKfG9zj+5h7shi93Cee2otyVudGV4edj36mIC9rh9MLONky4ewl
 tjUU7ItmLbGvGdFRKhJUZ+Z0Y86yUnVIHh53fP3hUfJ+LOWpMYKPgh7aNdwytir7mjxI
 JD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777211396; x=1777816196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xlytXwevs67gNFcr4ujyMnKHEGjQPMghBz+4SCH2y1E=;
 b=frgj9au3ALPriR2kZMbRQxFclBJwcopIG0AxQ97v1zTsrJ6BRpeoVjos9p8Y5AoCk0
 SaolevBG212ABcCeYfLcn/kyLkMXErNhBNKdcTrdQAQ4FAHmMwTWrFSWd6z6UOkV+IZz
 ZJhSNqqcqddudUHNm7RCyFxcN97kDPCNc05hVU6CsEAidb1CMTLmSTqdvf0EFjtXJMfe
 Vf6rx6IEq4FJ1Vi6oUpRf+vABiUl8eTvZ0cAZPj1ln7yj51shI5mv211neLuO2DoNFNU
 GQpPo+Ar7KkCWKfLM1MWc0Sqn6+lVAVh+70/RlKl6hX/+taD0d+MDs746PmOlIKCtLYO
 TAZg==
X-Gm-Message-State: AOJu0Yy+2Mtvn+iVoKnxq/A9UdaZCQ867lXwsN/tQoUzUI4bGlcrI0Pk
 dnLIjOuVoDdumjrtMqhIjTuMlAVtvKNTQf9t+CRGRua64JBE/LYBl7/d6hRiY51R+kR4nh2dMe0
 +GcS5y6s=
X-Gm-Gg: AeBDieu+fOk4ZQFOUMXxBNDI0dUhxDEUhJ28X+NyK5LPwccRJ8IsbuiWcAzRVh34G97
 xs24fJ6+XrAVDKMKsdChvGaj0b8jc3omsQPSdpVAuM3EvW8WFHOYYx6QwgkFW0aUzfm9ofOeo73
 Fn95jOhep57JMO0waRXKa0MZScieu/zQuhG5pF01ZIGRLVy6mx2KMzFVEZByu5qHEMIMK4RJx+y
 qrs0P9ol1q515pGj8iGXx3dp8o7aq7kLS8+G4JNf871UBKYM99UM547rWyLxxQaXH95/fJozThX
 h3527m6foblKeXqJh6MGxlUU7YEX8G1/qvQpCd4s6vgWI00Wdnxj86auWzuxob/ZnTeQuG8bMYq
 pRZPTVuisZGI1untgj5R3+HuI71ZWk3LJ8XuwY8REKgvYj1o3Wyoh0XEhS4X2UYTSn/Tf9U7IxU
 DZwUqiIjbqmSdGn2rb1gUhQD5QTtQEWnZSeQnifnrQ
X-Received: by 2002:a05:6a00:408e:b0:827:2a07:231d with SMTP id
 d2e1a72fcca58-82f8c839c08mr41148041b3a.17.1777211396516; 
 Sun, 26 Apr 2026 06:49:56 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ebba485sm36307102b3a.38.2026.04.26.06.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:49:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 82/84] target/arm: Use FloatParts64 in bfdotadd_ebf
Date: Sun, 26 Apr 2026 23:39:59 +1000
Message-ID: <20260426134002.865628-83-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Use softfloat-parts.h so that we can more naturally
perform the required operations witha single rounding step.
This happens to also simplify the NaN detection step.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_helper.c | 77 +++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 37 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 91e98d28ae..1f305515cf 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -22,6 +22,7 @@
 #include "helper.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
+#include "fpu/softfloat-parts.h"
 #include "qemu/int128.h"
 #include "crypto/clmul.h"
 #include "vec_internal.h"
@@ -2895,61 +2896,63 @@ float32 bfdotadd(float32 sum, uint32_t e1, uint32_t e2, float_status *fpst)
 float32 bfdotadd_ebf(float32 sum, uint32_t e1, uint32_t e2,
                      float_status *fpst, float_status *fpst_odd)
 {
+    /* Unpack two BFloat16 into two Float32, trivially. */
     float32 s1r = e1 << 16;
     float32 s1c = e1 & 0xffff0000u;
     float32 s2r = e2 << 16;
     float32 s2c = e2 & 0xffff0000u;
     float32 t32;
 
+    /*
+     * Compare f16_dotadd() in sme_helper.c, but here we have
+     * bfloat16 inputs. In particular that means that we do not
+     * want the FPCR.FZ16 flush semantics, so we use the normal
+     * float_status for the input handling here.
+     */
+    FloatParts64 p1r = float32_unpack_canonical(s1r, fpst);
+    FloatParts64 p1c = float32_unpack_canonical(s1c, fpst);
+    FloatParts64 p2r = float32_unpack_canonical(s2r, fpst);
+    FloatParts64 p2c = float32_unpack_canonical(s2c, fpst);
+
+    int all_mask = (float_cmask(p1r.cls) | float_cmask(p1c.cls) |
+                    float_cmask(p1r.cls) | float_cmask(p1c.cls));
+
     /* C.f. FPProcessNaNs4 */
-    if (float32_is_any_nan(s1r) || float32_is_any_nan(s1c) ||
-        float32_is_any_nan(s2r) || float32_is_any_nan(s2c)) {
-        if (float32_is_signaling_nan(s1r, fpst)) {
-            t32 = s1r;
-        } else if (float32_is_signaling_nan(s1c, fpst)) {
-            t32 = s1c;
-        } else if (float32_is_signaling_nan(s2r, fpst)) {
-            t32 = s2r;
-        } else if (float32_is_signaling_nan(s2c, fpst)) {
-            t32 = s2c;
-        } else if (float32_is_any_nan(s1r)) {
-            t32 = s1r;
-        } else if (float32_is_any_nan(s1c)) {
-            t32 = s1c;
-        } else if (float32_is_any_nan(s2r)) {
-            t32 = s2r;
+    if (unlikely(all_mask & float_cmask_anynan)) {
+        if (unlikely(all_mask & float_cmask_snan)) {
+            if (p1r.cls == float_class_snan) {
+                t32 = s1r;
+            } else if (p1c.cls == float_class_snan) {
+                t32 = s1c;
+            } else if (p2r.cls == float_class_snan) {
+                t32 = s2r;
+            } else {
+                t32 = s2c;
+            }
         } else {
-            t32 = s2c;
+            if (p1r.cls == float_class_qnan) {
+                t32 = s1r;
+            } else if (p1c.cls == float_class_qnan) {
+                t32 = s1c;
+            } else if (p2r.cls == float_class_qnan) {
+                t32 = s2r;
+            } else {
+                t32 = s2c;
+            }
         }
         /*
          * FPConvertNaN(FPProcessNaN(t32)) will be done as part
          * of the final addition below.
          */
     } else {
-        /*
-         * Compare f16_dotadd() in sme_helper.c, but here we have
-         * bfloat16 inputs. In particular that means that we do not
-         * want the FPCR.FZ16 flush semantics, so we use the normal
-         * float_status for the input handling here.
-         */
-        float64 e1r = float32_to_float64(s1r, fpst);
-        float64 e1c = float32_to_float64(s1c, fpst);
-        float64 e2r = float32_to_float64(s2r, fpst);
-        float64 e2c = float32_to_float64(s2c, fpst);
-        float64 t64;
-
         /*
          * The ARM pseudocode function FPDot performs both multiplies
-         * and the add with a single rounding operation.  Emulate this
-         * by performing the first multiply in round-to-odd, then doing
-         * the second multiply as fused multiply-add, and rounding to
-         * float32 all in one step.
+         * and the add with a single rounding operation.
          */
-        t64 = float64_mul(e1r, e2r, fpst_odd);
-        t64 = float64r32_muladd(e1c, e2c, t64, 0, fpst);
+        FloatParts64 tmp = parts64_mul(&p1r, &p2r, fpst);
+        tmp = parts64_muladd_scalbn(&p1c, &p2c, &tmp, 0, 0, fpst);
 
-        /* This conversion is exact, because we've already rounded. */
-        t32 = float64_to_float32(t64, fpst);
+        t32 = float32_round_pack_canonical(&tmp, fpst);
     }
 
     /* The final accumulation step is not fused. */
-- 
2.43.0


