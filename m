Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDF0CD4F3C
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPKt-0001jm-IF; Sat, 16 May 2026 20:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPKY-0001eg-Qg
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:26:08 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPKX-0002aj-2B
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:26:06 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c70fb6aa323so348370a12.3
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977563; x=1779582363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Pu3TZxm2iTRUBoR9MHlryIG9+4ZyXp6ZsL5bLZgQwto=;
 b=rBtZsPhIPsbz1w2dtwLPNvfct7kC2U43LuGb+N8vsr52bIio/WGtO/zouN/4dJ5/Px
 4yfkLXCYgz15yLjmytc37Ep+pyPKJVeyZEmq+Yd8RJICkWPduplIBSZsZZnz9DTlOA1C
 JFkY9fe+Q6/cZyUwAY5SnqhNqGvTLikb2wixpJxUvM6jW/NhamovEpPX1BHOQTl+wTF+
 ZHY3NN1+vXPqBsCMBlijKwH8Tku2Sb90F5knAIbKOJIyFh5+OCLAYTcJad7JhoIDd4MN
 /52QCVJ9UHr8a4Ucs+UP6NzwHYgsFQCSchNLlmJibGn5ufqr11HWzrLZvqlmz81r5FEz
 Lgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977563; x=1779582363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Pu3TZxm2iTRUBoR9MHlryIG9+4ZyXp6ZsL5bLZgQwto=;
 b=KYEp0wi0lmDprKYQ/ucSFY5/OjkZkCOsAnkeN2y1tpj4DoEbaJnz/8C6Nsir5iefxO
 RnlcfHLH0khMh7pSR/gs7sNFBjTUNXxXgFZBw6x8Nd/cBSYLZaCBZAqiIqLrg1eXZlAZ
 31AFuLyODl2mW1GvZ29CD0koqJVh9TeLrFz0OSLec/IP7yugIGVEMD9RN9acuB39dxU9
 cgsxd0YFPET5lrR5Bzl1auHfSiJqjlWtbCgAviluKFhbp59IAxxP41LnzCMqP/r8qS5X
 3JEPUJV0nPDb4o7UYZArwq/WjIW9qTvgdDS6IWccGMLKUKP3Z1ecu9Eq6rEyBarpvr/u
 Mllw==
X-Gm-Message-State: AOJu0Ywr+WqMgBRdbio1NKvbgHcSxWudRDtOf4cBL8nFHRr8JiKyIneI
 4Px6+EHlx3vdO9uzxotkYx3c8ri3/kHmBrZ3yagfhWxC5RQm9/QRCgs8njZ+ZyW8UOHpcGhJLcB
 fOavL
X-Gm-Gg: Acq92OFxQLShY1PdCzzDN5KJcRBFBQKuQQlRJ9OqonGXLBM8u9x6GnaI8eFn+HVkuYu
 5jPzOaIkybMInSTe9ejU7RCGD0AE7ejDr8vA1QO5jdUBrXd/+UC3W4+BR0LKSvTRk3xBfXEBVl9
 7vfxH88opWR1lH8AT8jAKoFpsbRF1qrFQ6TEfXtNbO57f7BOKr6uv9F9RacatRWMAUMBJcxLUTY
 nFXmbFaIVqt5eFaWM4z92jQ98TV5lblpbs3Y/3nkdwau3uj4hbWXuGuITM5/UNGJ/lpSwIesUQp
 nA4NVhK4SO2Tz+xq+iiW366p3JryA6NIOOWcRL93j4wSxEbxz+zYLKz42jYJPatGYNmzATYUQLW
 UUznxVZ9YDCY20H6Lo2SmL9W2vkKquoueS6fBXB6EF6xmBAxGMUSein75HYRJTBlQDk6th4Gr7M
 0/dOsElytKFtxIPZB4j8se/RWmyBeRQfD9WFwlsgE=
X-Received: by 2002:a05:6a20:3949:b0:3af:91a:ff52 with SMTP id
 adf61e73a8af0-3b22ecb2b45mr10283160637.51.1778977563380; 
 Sat, 16 May 2026 17:26:03 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19c5be71sm9670317b3a.39.2026.05.16.17.26.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:26:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 08/12] target/arm: Use FloatParts64 in bfdotadd_ebf
Date: Sat, 16 May 2026 17:25:45 -0700
Message-ID: <20260517002550.321291-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517002550.321291-1-richard.henderson@linaro.org>
References: <20260517002550.321291-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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


