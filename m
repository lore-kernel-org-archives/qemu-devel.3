Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25128CD4F3C
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPKp-0001iF-Pk; Sat, 16 May 2026 20:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPKR-0001dE-TW
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:26:01 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPKP-0002QL-NB
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:25:59 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-839dc688d6cso394308b3a.2
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977555; x=1779582355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x9rWSaQvjbDXBnfVxCErc01A7AXki6hbY0KLzGZpXR4=;
 b=dFuYeKOj3ej/Ecm582uQwtEFQKMsI+Qyj7WmTZ79vkaqIOBjPjn2nDtxwMuBrlyRtv
 5sQoGfpo4ScQyFlkWWqBb0bQf4SEySEOL6aygi1+GxJFl8m5vfg9GWPPBO8WwUke1sGv
 x11VZcSESZVgAqLWmMrermXGSwNBTK0PSCDwTz7k8XC2XSdkUOIpUwnvIDZgyqVVa4f8
 lAO82gdaCUXACSG6ReCZtp0EZuWx5eQmpfTM4OQEjNoknNBC7RJMHrtfa3KjkLk08CCn
 1taZekhmKNk2kRKQFycjHj011hNHsQ0ibcaBDqHTZhr/KN4xDPmGc1Dd7ujpnapB3VX5
 R53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977555; x=1779582355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=x9rWSaQvjbDXBnfVxCErc01A7AXki6hbY0KLzGZpXR4=;
 b=RIaH+FIZnsszavRH+fLRbQFtRG+VXvAva+cBH2kQMoWZKiyqV3UqA1jC1Fr0a1Wi1R
 h7i3P1oCvRouKNJN1fvZJHjMLUw4HrT6qovfKlLOcd+OZyc+VZlG2DT1dnKRt3GojnWr
 GYuErkFvT3O46zUFxmPSCtJoCHfqGTP2xnkdJR/hEiFyKgF2VEGa77obdBI7yfHBytXp
 PoKN961mVQtcP08bzickApCMYIaDMCE9rY62+wNS+JY2hjADzS7AuMa+wRyAbrDqHen0
 UQCKMjLPJu4/Ss/CLZUIDZH44Ob2xhQ3vujMA+U3mbDU5c/Jg+4zrulhsN4M0kephAoq
 8InA==
X-Gm-Message-State: AOJu0YxON/70rfUML4rvdON4arecAUPwjp2xHzksoBsTbRoAsXwuDsKa
 d3ifqKLnqU+ndDQSTVKNGru0+/owb22IyVOxEumqAk0pSaMqeXlpUzvzh/YdHcvPGmLp88yhDVW
 WK/Ev
X-Gm-Gg: Acq92OHX1x9WItJ36iREY3iHBTmFW3LOGECY7UZ4/L7vED9F9HN5rUefmPELdhZfX68
 Q8/j1HATOT+1eLTrgvXTSXodugn/YC1vNsDWY5i0mKYU58k0wOYvrjgHQRFozH2UCuA1aHGBm8C
 udYoOQ4pCtX5Fq5XZTygGzLaI6X7hwG+WFe3k/6hpnCyon3vDy3OnrX/f6KJEfmkzI17Z0W4BD+
 b7jmhGkiNMhQgx2ulEq/AY+/mI2fKEFzbriBh9FdaAcCcu4sNzYwFRItYKIvM8WmopxEbIIQ1Np
 hyUnTC2XX+WhyGt4+MjeCgI0ncsaCjEm+NE3stz1FrG7GJtpGi0RzqyMFbk6Gpg+L4o4+bqhGQ8
 HJvoaWLs4I92LO8nBlQRH4Gpnr4HceczEL0zV6pHq3nQ1+/15Mfh+Ud9GOwVgqfo//Oj1d+GprY
 qbioDac82UPX5F9K2zjfM/182zoOFa
X-Received: by 2002:a05:6a00:1908:b0:834:df57:9d67 with SMTP id
 d2e1a72fcca58-83f33cf0bddmr10153972b3a.32.1778977554992; 
 Sat, 16 May 2026 17:25:54 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19c5be71sm9670317b3a.39.2026.05.16.17.25.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:25:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 02/12] fpu: Reorganize partsN(muladd)
Date: Sat, 16 May 2026 17:25:39 -0700
Message-ID: <20260517002550.321291-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517002550.321291-1-richard.henderson@linaro.org>
References: <20260517002550.321291-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Check the likely case of normal product and normal or
zero addend first; shift NaN and infinity detection down;
end with zero product + addend.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 156 +++++++++++++++++---------------------
 1 file changed, 71 insertions(+), 85 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 3a9c2748cd..ca2d7a15c9 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -681,11 +681,47 @@ static FloatPartsN *partsN(muladd)(FloatPartsN *a, FloatPartsN *b,
                                    FloatPartsN *c,
                                    int flags, float_status *s)
 {
-    int ab_mask, abc_mask;
-    FloatPartsW p_widen, c_widen;
+    int ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
+    int c_mask = float_cmask(c->cls);
+    int abc_mask = ab_mask | c_mask;
+    bool c_sign = c->sign ^ !!(flags & float_muladd_negate_c);
+    bool p_sign = a->sign ^ b->sign ^ !!(flags & float_muladd_negate_product);
 
-    ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
-    abc_mask = float_cmask(c->cls) | ab_mask;
+    /*
+     * The "likely" case is A and B normal, so that the product is normal,
+     * and C normal or zero so that the result is normal.
+     */
+    int likely_mask = ab_mask | (c_mask & ~float_cmask_zero);
+    if (likely(cmask_is_only_normals(likely_mask))) {
+        record_denormals_used(abc_mask, s);
+
+        /* Perform the multiplication step. */
+        FloatPartsW p_widen = { .sign = p_sign, .exp = a->exp + b->exp + 1 };
+        fracN(mulw)(&p_widen, a, b);
+        if (!(p_widen.frac_hi & DECOMPOSED_IMPLICIT_BIT)) {
+            fracW(add)(&p_widen, &p_widen, &p_widen);
+            p_widen.exp -= 1;
+        }
+
+        /* Perform the addition step. */
+        if (!(c_mask & float_cmask_zero)) {
+            /* Zero-extend C to less significant bits. */
+            FloatPartsW c_widen = { .sign = c_sign, .exp = c->exp };
+            fracN(widen)(&c_widen, c);
+
+            if (p_sign == c_sign) {
+                partsW(add_normal)(&p_widen, &c_widen);
+            } else if (!partsW(sub_normal)(&p_widen, &c_widen)) {
+                goto return_sub_zero;
+            }
+        }
+
+        /* Narrow with sticky bit, for proper rounding later. */
+        fracN(truncjam)(a, &p_widen);
+        a->sign = p_widen.sign;
+        a->exp = p_widen.exp;
+        return a;
+    }
 
     /*
      * It is implementation-defined whether the cases of (0,inf,qnan)
@@ -698,97 +734,47 @@ static FloatPartsN *partsN(muladd)(FloatPartsN *a, FloatPartsN *b,
         return a;
     }
 
-    if (flags & float_muladd_negate_c) {
-        c->sign ^= 1;
+    if (unlikely(ab_mask == float_cmask_infzero)) {
+        /* Inf * Zero == NaN */
+        float_raise(float_flag_invalid | float_flag_invalid_imz, s);
+        goto d_nan;
     }
 
-    /* Compute the sign of the product into A. */
-    a->sign ^= b->sign;
-    if (flags & float_muladd_negate_product) {
-        a->sign ^= 1;
-    }
-
-    if (unlikely(!cmask_is_only_normals(ab_mask))) {
-        if (unlikely(ab_mask == float_cmask_infzero)) {
-            float_raise(float_flag_invalid | float_flag_invalid_imz, s);
+    if (unlikely(ab_mask & float_cmask_inf)) {
+        if ((c_mask & float_cmask_inf) && p_sign != c_sign) {
+            /* Inf - Inf == NaN */
+            float_raise(float_flag_invalid | float_flag_invalid_isi, s);
             goto d_nan;
         }
-
-        if (ab_mask & float_cmask_inf) {
-            if (c->cls == float_class_inf && a->sign != c->sign) {
-                float_raise(float_flag_invalid | float_flag_invalid_isi, s);
-                goto d_nan;
-            }
-            goto return_inf;
-        }
-
-        g_assert(ab_mask & float_cmask_zero);
-        if (is_anynorm(c->cls)) {
-            *a = *c;
-            goto finish_sign;
-        }
-        if (c->cls == float_class_zero) {
-            if (flags & float_muladd_suppress_add_product_zero) {
-                a->sign = c->sign;
-            } else if (a->sign != c->sign) {
-                goto return_sub_zero;
-            }
-            goto return_zero;
-        }
-        g_assert(c->cls == float_class_inf);
+        /* Inf + C == Inf */
+        record_denormals_used(abc_mask, s);
+        a->sign = p_sign;
+        a->cls = float_class_inf;
+        return a;
     }
-
-    if (unlikely(c->cls == float_class_inf)) {
-        a->sign = c->sign;
-        goto return_inf;
-    }
-
-    /* Perform the multiplication step. */
-    p_widen.sign = a->sign;
-    p_widen.exp = a->exp + b->exp + 1;
-    fracN(mulw)(&p_widen, a, b);
-    if (!(p_widen.frac_hi & DECOMPOSED_IMPLICIT_BIT)) {
-        fracW(add)(&p_widen, &p_widen, &p_widen);
-        p_widen.exp -= 1;
-    }
-
-    /* Perform the addition step. */
-    if (c->cls != float_class_zero) {
-        /* Zero-extend C to less significant bits. */
-        fracN(widen)(&c_widen, c);
-        c_widen.exp = c->exp;
-
-        if (a->sign == c->sign) {
-            partsW(add_normal)(&p_widen, &c_widen);
-        } else if (!partsW(sub_normal)(&p_widen, &c_widen)) {
-            goto return_sub_zero;
-        }
-    }
-
-    /* Narrow with sticky bit, for proper rounding later. */
-    fracN(truncjam)(a, &p_widen);
-    a->sign = p_widen.sign;
-    a->exp = p_widen.exp;
-
- finish_sign:
-    /*
-     * All result types except for "return the default NaN
-     * because this is an Invalid Operation" go through here;
-     * this matches the set of cases where we consumed a
-     * denormal input.
-     */
     record_denormals_used(abc_mask, s);
-    return a;
+
+    /* Only remaining cases are zero product or inf addend. */
+    assert((ab_mask & float_cmask_zero) | (c_mask & float_cmask_inf));
+
+    /*
+     * P + Inf == Inf, or
+     * 0 + C == C,
+     * except for 0 - 0, which needs special rounding,
+     * except for when we want to suppress this addition step.
+     */
+    if (!(c_mask & float_cmask_zero)
+        || p_sign == c_sign
+        || (flags & float_muladd_suppress_add_product_zero)) {
+        c->sign = c_sign;
+        return c;
+    }
 
  return_sub_zero:
+    /* 0 - 0 == -0 for round_down, +0 otherwise. */
     a->sign = s->float_rounding_mode == float_round_down;
- return_zero:
     a->cls = float_class_zero;
-    goto finish_sign;
-
- return_inf:
-    a->cls = float_class_inf;
-    goto finish_sign;
+    return a;
 
  d_nan:
     *a = partsN(default_nan)(s);
-- 
2.43.0


