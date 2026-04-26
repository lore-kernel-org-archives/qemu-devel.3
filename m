Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD221FF885C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzji-0008Ez-8h; Sun, 26 Apr 2026 09:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzjg-0008A5-PZ
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:41:24 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzjc-0000C0-Tn
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:41:24 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2b24fdac394so90561695ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777210879; x=1777815679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8iNu5b7hcfu4YD/ZRX99cYS8RApbvbMld9iCuftqu3w=;
 b=dii9JTTsiw0wgIvlg8T1XyPZQ/wjximJ1DgXF2un4Bcycq5zWf+e+G+1z//wIlJCua
 xd76qbcUBe5SB2CECxzitE5ZgXDmJUI3NY4iTcd8en9FK0eZk2IY0+I6EtHVAR/GYY2K
 Y4KMOmMcDIGcr5DWcnW9cqvDPm8DZ1XBXL2O6eX8V76+krLf9D9RALPMHg+3nQK3RKEy
 lZFASnVjq3LRnfJW1LhAsGwqEn/p5TqSEobhXyOK08EpoW9+1svt8dq7ehCSEQUtZxeO
 TuiahrHTAnNt1xKPA2FfswZg5dLCuAVnuVEdT2SBgv4DvgjzDNG6ebDq1PT6NqrdUNiw
 V+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777210879; x=1777815679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8iNu5b7hcfu4YD/ZRX99cYS8RApbvbMld9iCuftqu3w=;
 b=jVx6vVRcwtLGg9KoVhomqcHeKY4yYLN+SvmqKPvOysRav9aWQX9dkDURRsNTRh+tmP
 l44sVbdR4+ERR9Y/ICFtXXCXhruJoAKQVEBwUwMPOfvXAufoKQPmiZ5vSe1vIAc635DF
 SF9O42KLSNei9mlvWF9e+5pcMhEwVGRW4wCTMv67+0fvGhuVIgOPVvtDrGhzs/h3impL
 svuIBx8ul8agThplL6okdGYcnBW7A32RMu7ZzSibJI/FXZjK+KBcTRNRwDxNYYQVyGOk
 rK7XQb3ZkVGbuOFmrxThl9zt0JKA/DXRkttnKpB8IOuPgKW2FPjbwqwLqnHgV5MRZAdr
 HYUw==
X-Gm-Message-State: AOJu0YwGMOzJ9hGtJis/hdpbFjcxIEdxH07jUCFUkXQYOrR9qsjI762C
 OY0z/M0t/wNP6wVJ77yfruS6hvbj4RMAWO3WCIMau41WqTkcnjn7Nz7AS3jYM999fpztT/4WSf6
 39e+sEzs=
X-Gm-Gg: AeBDiev5NPlhI+9jYJj7HwTxW6pooOVilNBqbPQjd4oW5cYwQ98gQMwxi/8rY+Z1Yie
 z8ik4j7AJ4i0K3O+BEaCTBzzc6UlNHJXse8Sw33KD0blCVbJFPVQL9KL9wBLIZvjiFKi8RJU1hB
 fymItIsnfgG30Nm4TGBkcKXraAgVfI62NWk24H+mvg50VjayMNWjG+oX1NZzcXzXqaOaXEKMToV
 hwKYsZTtC0mKpd30NpjKEKEByUKtJQCCbEcy8IX2j0oFpQynGU9X3RAyJ4meNdBOeu/+dUBnoQF
 wcrb0t5CXJBd1SzT0xZixpVCfeSIJs2mgGOBmhDOETQKH4qL5dlBb7kd+YNTNi6Mn5/NTU5+Oos
 wig5pm+bEIg20tjjSfunwedG3OTDHn0zOaj4VDSLBv7bmec7V8GTPdscQLTXgQPwn4Nr5Umjtpd
 W435tCuyaA2s/ZIsMxaMrgjjSl/m2LR05LAX/qmVzm
X-Received: by 2002:a17:903:2ac6:b0:2b2:549f:7d2b with SMTP id
 d9443c01a7336-2b5f9ee2f21mr401121385ad.11.1777210879382; 
 Sun, 26 Apr 2026 06:41:19 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab30f29sm277940375ad.68.2026.04.26.06.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:41:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 27/84] fpu: Drop parts_log2
Date: Sun, 26 Apr 2026 23:39:04 +1000
Message-ID: <20260426134002.865628-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Use parts64_log2 at each call site.

That leaves parts128_log2 unused, so move the whole function back
to softfloat.c and specialize for FloatParts64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           | 133 +++++++++++++++++++++++++++++++++++---
 fpu/softfloat-parts.c.inc | 131 -------------------------------------
 2 files changed, 125 insertions(+), 139 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 3e6f2a152a..6a38d161f7 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -779,12 +779,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
                   FloatParts128 *: parts128_##NAME, \
                   FloatParts256 *: parts256_##NAME)
 
-static void parts64_log2(FloatParts64 *a, float_status *s, const FloatFmt *f);
-static void parts128_log2(FloatParts128 *a, float_status *s, const FloatFmt *f);
-
-#define parts_log2(A, S, F) \
-    PARTS_GENERIC_64_128(log2, A)(A, S, F)
-
 /*
  * Helper functions for softfloat-parts.c.inc, per-size operations.
  */
@@ -4851,12 +4845,135 @@ floatx80 floatx80_sqrt(floatx80 a, float_status *s)
 /*
  * log2
  */
+
+static void parts64_log2(FloatParts64 *a, float_status *s, const FloatFmt *fmt)
+{
+    uint64_t a0, a1, r, t, ign;
+    int i, n, a_exp, f_exp;
+
+    if (unlikely(a->cls != float_class_normal)) {
+        switch (a->cls) {
+        case float_class_denormal:
+            if (!a->sign) {
+                /* -ve denormal will be InvalidOperation */
+                float_raise(float_flag_input_denormal_used, s);
+            }
+            break;
+        case float_class_snan:
+        case float_class_qnan:
+            parts64_return_nan(a, s);
+            return;
+        case float_class_zero:
+            float_raise(float_flag_divbyzero, s);
+            /* log2(0) = -inf */
+            a->cls = float_class_inf;
+            a->sign = 1;
+            return;
+        case float_class_inf:
+            if (unlikely(a->sign)) {
+                goto d_nan;
+            }
+            return;
+        default:
+            g_assert_not_reached();
+        }
+    }
+    if (unlikely(a->sign)) {
+        goto d_nan;
+    }
+
+    a_exp = a->exp;
+    f_exp = -1;
+
+    r = 0;
+    t = DECOMPOSED_IMPLICIT_BIT;
+    a0 = a->frac_hi;
+    a1 = 0;
+
+    n = fmt->frac_size + 2;
+    if (unlikely(a_exp == -1)) {
+        /*
+         * When a_exp == -1, we're computing the log2 of a value [0.5,1.0).
+         * When the value is very close to 1.0, there are lots of 1's in
+         * the msb parts of the fraction.  At the end, when we subtract
+         * this value from -1.0, we can see a catastrophic loss of precision,
+         * as 0x800..000 - 0x7ff..ffx becomes 0x000..00y, leaving only the
+         * bits of y in the final result.  To minimize this, compute as many
+         * digits as we can.
+         * ??? This case needs another algorithm to avoid this.
+         */
+        n = fmt->frac_size * 2 + 2;
+        /* Don't compute a value overlapping the sticky bit */
+        n = MIN(n, 62);
+    }
+
+    for (i = 0; i < n; i++) {
+        if (a1) {
+            mul128To256(a0, a1, a0, a1, &a0, &a1, &ign, &ign);
+        } else if (a0 & 0xffffffffull) {
+            mul64To128(a0, a0, &a0, &a1);
+        } else if (a0 & ~DECOMPOSED_IMPLICIT_BIT) {
+            a0 >>= 32;
+            a0 *= a0;
+        } else {
+            goto exact;
+        }
+
+        if (a0 & DECOMPOSED_IMPLICIT_BIT) {
+            if (unlikely(a_exp == 0 && r == 0)) {
+                /*
+                 * When a_exp == 0, we're computing the log2 of a value
+                 * [1.0,2.0).  When the value is very close to 1.0, there
+                 * are lots of 0's in the msb parts of the fraction.
+                 * We need to compute more digits to produce a correct
+                 * result -- restart at the top of the fraction.
+                 * ??? This is likely to lose precision quickly, as for
+                 * float128; we may need another method.
+                 */
+                f_exp -= i;
+                t = r = DECOMPOSED_IMPLICIT_BIT;
+                i = 0;
+            } else {
+                r |= t;
+            }
+        } else {
+            add128(a0, a1, a0, a1, &a0, &a1);
+        }
+        t >>= 1;
+    }
+
+    /* Set sticky for inexact. */
+    r |= (a1 || a0 & ~DECOMPOSED_IMPLICIT_BIT);
+
+ exact:
+    parts64_sint_to_float(a, a_exp, 0, s);
+    if (r != 0) {
+        FloatParts64 f = {
+            .cls = float_class_normal, .frac = r
+        };
+        f.exp = f_exp - frac_normalize(&f);
+
+        if (a_exp < 0) {
+            parts64_sub_normal(a, &f);
+        } else if (a_exp > 0) {
+            parts64_add_normal(a, &f);
+        } else {
+            *a = f;
+        }
+    }
+    return;
+
+ d_nan:
+    float_raise(float_flag_invalid, s);
+    parts64_default_nan(a, s);
+}
+
 float32 float32_log2(float32 a, float_status *status)
 {
     FloatParts64 p;
 
     float32_unpack_canonical(&p, a, status);
-    parts_log2(&p, status, &float32_params);
+    parts64_log2(&p, status, &float32_params);
     return float32_round_pack_canonical(&p, status);
 }
 
@@ -4865,7 +4982,7 @@ float64 float64_log2(float64 a, float_status *status)
     FloatParts64 p;
 
     float64_unpack_canonical(&p, a, status);
-    parts_log2(&p, status, &float64_params);
+    parts64_log2(&p, status, &float64_params);
     return float64_round_pack_canonical(&p, status);
 }
 
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 8405cf29cd..5f27efd288 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -1671,134 +1671,3 @@ static void partsN(scalbn)(FloatPartsN *a, int n, float_status *s)
         g_assert_not_reached();
     }
 }
-
-/*
- * Return log2(A)
- */
-static void partsN(log2)(FloatPartsN *a, float_status *s, const FloatFmt *fmt)
-{
-    uint64_t a0, a1, r, t, ign;
-    FloatPartsN f;
-    int i, n, a_exp, f_exp;
-
-    if (unlikely(a->cls != float_class_normal)) {
-        switch (a->cls) {
-        case float_class_denormal:
-            if (!a->sign) {
-                /* -ve denormal will be InvalidOperation */
-                float_raise(float_flag_input_denormal_used, s);
-            }
-            break;
-        case float_class_snan:
-        case float_class_qnan:
-            partsN(return_nan)(a, s);
-            return;
-        case float_class_zero:
-            float_raise(float_flag_divbyzero, s);
-            /* log2(0) = -inf */
-            a->cls = float_class_inf;
-            a->sign = 1;
-            return;
-        case float_class_inf:
-            if (unlikely(a->sign)) {
-                goto d_nan;
-            }
-            return;
-        default:
-            g_assert_not_reached();
-        }
-    }
-    if (unlikely(a->sign)) {
-        goto d_nan;
-    }
-
-    /* TODO: This algorithm looses bits too quickly for float128. */
-    g_assert(N == 64);
-
-    a_exp = a->exp;
-    f_exp = -1;
-
-    r = 0;
-    t = DECOMPOSED_IMPLICIT_BIT;
-    a0 = a->frac_hi;
-    a1 = 0;
-
-    n = fmt->frac_size + 2;
-    if (unlikely(a_exp == -1)) {
-        /*
-         * When a_exp == -1, we're computing the log2 of a value [0.5,1.0).
-         * When the value is very close to 1.0, there are lots of 1's in
-         * the msb parts of the fraction.  At the end, when we subtract
-         * this value from -1.0, we can see a catastrophic loss of precision,
-         * as 0x800..000 - 0x7ff..ffx becomes 0x000..00y, leaving only the
-         * bits of y in the final result.  To minimize this, compute as many
-         * digits as we can.
-         * ??? This case needs another algorithm to avoid this.
-         */
-        n = fmt->frac_size * 2 + 2;
-        /* Don't compute a value overlapping the sticky bit */
-        n = MIN(n, 62);
-    }
-
-    for (i = 0; i < n; i++) {
-        if (a1) {
-            mul128To256(a0, a1, a0, a1, &a0, &a1, &ign, &ign);
-        } else if (a0 & 0xffffffffull) {
-            mul64To128(a0, a0, &a0, &a1);
-        } else if (a0 & ~DECOMPOSED_IMPLICIT_BIT) {
-            a0 >>= 32;
-            a0 *= a0;
-        } else {
-            goto exact;
-        }
-
-        if (a0 & DECOMPOSED_IMPLICIT_BIT) {
-            if (unlikely(a_exp == 0 && r == 0)) {
-                /*
-                 * When a_exp == 0, we're computing the log2 of a value
-                 * [1.0,2.0).  When the value is very close to 1.0, there
-                 * are lots of 0's in the msb parts of the fraction.
-                 * We need to compute more digits to produce a correct
-                 * result -- restart at the top of the fraction.
-                 * ??? This is likely to lose precision quickly, as for
-                 * float128; we may need another method.
-                 */
-                f_exp -= i;
-                t = r = DECOMPOSED_IMPLICIT_BIT;
-                i = 0;
-            } else {
-                r |= t;
-            }
-        } else {
-            add128(a0, a1, a0, a1, &a0, &a1);
-        }
-        t >>= 1;
-    }
-
-    /* Set sticky for inexact. */
-    r |= (a1 || a0 & ~DECOMPOSED_IMPLICIT_BIT);
-
- exact:
-    partsN(sint_to_float)(a, a_exp, 0, s);
-    if (r == 0) {
-        return;
-    }
-
-    memset(&f, 0, sizeof(f));
-    f.cls = float_class_normal;
-    f.frac_hi = r;
-    f.exp = f_exp - frac_normalize(&f);
-
-    if (a_exp < 0) {
-        partsN(sub_normal)(a, &f);
-    } else if (a_exp > 0) {
-        partsN(add_normal)(a, &f);
-    } else {
-        *a = f;
-    }
-    return;
-
- d_nan:
-    float_raise(float_flag_invalid, s);
-    partsN(default_nan)(a, s);
-}
-- 
2.43.0


