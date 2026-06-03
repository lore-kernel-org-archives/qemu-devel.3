Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBB8CD6E6A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 03:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcHw-0006Ww-5G; Tue, 02 Jun 2026 23:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcHu-0006VS-3Q
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:29:02 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcHr-0003YL-2x
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:29:01 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-842319576d5so1742661b3a.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 20:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780457337; x=1781062137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LCz/+vquVi3LZZj/w2HRkJcZNB7l8GXrNjqQYumcxd0=;
 b=RusUH4Ra+tflBATMFPut4WxZOV56LOQ3JmfXEOOX+8IGR8B8PsFPN7jUHmDUImnPuw
 soRbRkmGH4dL/+nAWVeFE4qYJ3raT9bYL8WxD82MuQ/E7UPeMtN/0D0jV3y2izX//Ojk
 cmMfYhs/nXKSxqgEnmLdz5ym2/loSaNADoiFoOaYq7I7uuUlR427S2J05ACyiMUzMNz5
 tOw5JhiRiV9GPAA10DWZRkHfDTxU9c6wb7/0+lw1s6V8qnDRrhj6D8g6bSnPhqQW8WkK
 dRRRmjreT+sJzOiEkXNNZJHcJa7RzfKD7ggQPdUTtmPdyNa1DsIh+f4fgot1tw/mTfc3
 6qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780457337; x=1781062137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LCz/+vquVi3LZZj/w2HRkJcZNB7l8GXrNjqQYumcxd0=;
 b=DaYAG/ITWg2625Q6nCjQTDkDfjFj+JPGTFtTteq10N37H+ggeKKrBmioXgyrlJOcFY
 PpquzKEFHCv7nQ6sVHGwq8D34MVetExC8ZRnd2na/R7xlmEETGqzsY8e9UlqOvXI8ihV
 a3zsbLsP4S27TtK3BpV4UyP8toj8ENgcsPGLF6aPe9gPXfYE8nWp/cRPxl6Ih6MuBwOM
 R0s6Rmg4ibLwfZNNQ+Cn47q02Ac/NZ7Sf3oWlnLMUfdXXUUkmLyPIua4RSxOjverAY+F
 GJYrRi8gh5u/KvfLJycVPgGwCaVhwnheDSuuA4u5appw8ICdjDabIa4tGtiJ1qJWiTHj
 x5Nw==
X-Gm-Message-State: AOJu0Yxmv9WQK6BtJOa+0qTaUUe0YiT5GdDe+8PXUNaqIq6xjYdlGyCT
 qoD9ziMhulqO6xf50a4OY1twC99thaGjPOURgDUmC2xnPxrDR0ksiay0KjjGyNwbnlg8US8gk5O
 VPHd1A3c=
X-Gm-Gg: Acq92OFyJ6ajBVDai1mEgTVKWExu0jRoedNjRMGgWdTLu5sKmIbUSAE7pPSJUjHLJjh
 +fXGjSBeYeuOk4IDKTceuM9ADZCzf0SvNe2cCV8puSw9ZJ+2B0EanX+l5B+lDrBWYMZb8d+eSjk
 +a5PRZpCssIXyoj5KmTm0SqyiogF566NUAv7kjKvONHd7Fr4OIXHXhiuyyAPllALhpM0fQhTvEE
 MxGK+48ptOdQ1oAKFmWfLEvfQTphQZKNgtUJ7ltKwuLH7VZrk8zeydnmLcmDzuVTJ9AykhhmqSn
 f7Ncps4eBxcSuCZ2utBXVr3xJk7RK1wUdjrnT3oxw2mcAXSqb952zTbW42FY6m27vYK7/9qQHQ5
 ZT6oMBNz+t+sjvKBNsU59xPGsNnf2Re9TuOA2dV18i96WT6qUagaVN1cxTpFUMpLe2WPYBiuS1G
 amj74oSJ/cV4IY9eoXgK6hOAPNE8am9Mluad3jMPxZ7VvhCFbsuA==
X-Received: by 2002:a05:6a00:3c95:b0:842:80c5:c420 with SMTP id
 d2e1a72fcca58-84284f40b57mr1555696b3a.40.1780457337261; 
 Tue, 02 Jun 2026 20:28:57 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8428222263dsm1477831b3a.2.2026.06.02.20.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 20:28:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v9 01/45] target/arm: Use FloatParts64 in bfdotadd_ebf
Date: Tue,  2 Jun 2026 20:28:10 -0700
Message-ID: <20260603032855.106930-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603032855.106930-1-richard.henderson@linaro.org>
References: <20260603032855.106930-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20260517002550.321291-9-richard.henderson@linaro.org>
---
 target/arm/tcg/vec_helper.c | 77 +++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 37 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 91e98d28ae..85bcaac3d1 100644
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
+        tmp = parts64_muladd(&p1c, &p2c, &tmp, 0, fpst);
 
-        /* This conversion is exact, because we've already rounded. */
-        t32 = float64_to_float32(t64, fpst);
+        t32 = float32_round_pack_canonical(&tmp, fpst);
     }
 
     /* The final accumulation step is not fused. */
-- 
2.43.0


