Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE29FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEwL-0001L4-Bn; Wed, 29 Apr 2026 20:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEvE-0007sW-PW
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:30 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEvC-0001sm-Sz
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:28 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-82d0b68837aso184920b3a.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507585; x=1778112385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ufTVgbdGLWNTrUsYza5RsHlQnemu/cr0uM1Uo8UApo=;
 b=gRVLtQQOnuFa+vH+rU1Z3/FHa9tk0ObLSznN59xHEPCrA/vRPrvyLR14de9akv2+B3
 FVz3p817k9gGZH7B2cqd/sQjjYDzQme0DHyhWwtMLbj7s5DCReX2LHf2XdyFqCdQf0fo
 UP06eT+4W0nQPkqS9l2sUpvxpHseT8T9DIsFGCZuR0BaXSZSupwxQH+GjThAjEWvqw8D
 nIpNiOW2gCHCYY+0KqJ0X7MgH8KN9yHaUsCerj7FPt9cRvpbf0VEojP45lypqGSalScT
 4iIkGngZDnCgBs6Phj/TZwtZPX5pakIH9yWZ212mjXyrHdowFT+0Xo0zhRnzuEf/s4FG
 IXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507585; x=1778112385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5ufTVgbdGLWNTrUsYza5RsHlQnemu/cr0uM1Uo8UApo=;
 b=TIXEIUpwLtZ24HS2aDVJ9DEBB39CqzFXfM4oQB5fTU822Xu9JHsm4KUMuynckKAFn/
 HvJKM5MW80BMwL9a2sItq9H5oUKc6ei9k/OcvMbnm/gbqByzCKx0yflOdkVUKDqD8SMa
 C8llxR9K/b+LD3O8OR+NMk57bKAACBzZ/GhHc6d5C+6E0u4inIXXMZldp2EuVfADB2SV
 YURakZVBkB5GXjNQgajIi+N9PMzu7UsZa2/kaWoa3i21omktqVEA5rWwM1cvzNkkUi47
 /XANX5PnkNjqgwqtVM4ctEeJp1xU1Kwq6jLyDLNCxzXHsHOXbGIbe5HjjMWfi/0yw+gS
 Y/kw==
X-Gm-Message-State: AOJu0YwFkt+6cu4QAofQmh7cWiQoeD0aVJNz+spNWMiVWr6Cq54TcLCS
 cjw1xUtCvZ8QsOdsudXqO4PJtovMqLpZ01Eu9Dchfmd3Y3k1ll9r9vpywqNEEWGTaNLstW6qFuC
 J0AssqwU=
X-Gm-Gg: AeBDietJ8pP4lxgW5r9xuaaB3BTNU2L5hyAWZLb8o1TcEmxCTCgb2y7VKK+sCFf3ZQH
 zn5BVGjCu6zj6ZR0NilO6PvB24tE/3lqRRDcA+LHNB3azHIxa7PZzDQYUZVJivj2DEg5ojh/0Q5
 w8cer45B/RdiG8YK7l3H2MEJU6VKwXFctLjAXWB2cfNUGTU3N+COvYvnSGiVQRd62KLu5VgVdJH
 VGLzwBlwf+DqWJr+4/xSpR/UaqwpDt+CrU1pJronh+xutc4jnij+OOB68DUwbbRJDnYTyjbcIfN
 +hoONg1Yonb3PzHu29qwsiP6LsPEdjdAM1vUpteOFKC+Cme80LeuzSlQ1i6Gl68/4ip31vXGYhL
 6D41RLON8k42DLuCcGxkZu4UcVSUqMD0PhSmx3Go/8zZIHTSS3vUu6dhPTUJOEj5MMHI50XCTA2
 NIFgYt0l8K714N3GMNUjaFMjOtXeixB3FFvxyffRHl
X-Received: by 2002:a05:6a00:2998:b0:82c:9897:70ef with SMTP id
 d2e1a72fcca58-834fdbd1668mr776079b3a.27.1777507585421; 
 Wed, 29 Apr 2026 17:06:25 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:06:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 25/40] fpu: Reorganize partsN(muladd)
Date: Thu, 30 Apr 2026 10:05:08 +1000
Message-ID: <20260430000524.56046-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
 fpu/softfloat-parts.c.inc | 155 +++++++++++++++++---------------------
 1 file changed, 70 insertions(+), 85 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index b8baaf1e76..77465cce6e 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -683,11 +683,47 @@ static FloatPartsN *partsN(muladd)(FloatPartsN *a, FloatPartsN *b,
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
@@ -700,97 +736,46 @@ static FloatPartsN *partsN(muladd)(FloatPartsN *a, FloatPartsN *b,
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
+    /* Only remaining case is zero product. */
+    assert(ab_mask & float_cmask_zero);
+
+    /*
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


