Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B3BFF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDLQ-00008j-Gj; Wed, 29 Apr 2026 18:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLM-00007M-Ln
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:20 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLK-0004nm-Vt
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:20 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-35d94f4ee36so127147a91.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501517; x=1778106317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gs1If9ZJokfA4hSDIZvghA/pVNIqspXTSw4VViLR5Xw=;
 b=VJhzmCz5/3Zs5NrCukAr8F5vz5IcDVZAUmJyVgoKyfAgFYH0LSfIQ1oRhszHPf0Xhy
 i0EQBg9l6OYVb7DnoL8a2w/voo+JdLHHTzEaE8+7p5e9s5t+Am5dqOCmiUWqZroMiaE8
 XvwfuH81FmdXQ1xrOrJkVOdZ7rwrYvlW3jqplsorH7vpjkk26WeCpEOxsmsv3TzU3dlS
 t1+AQJsOFris/5ienuQP7rzPNeXSpkIg+29TktrqvxXBv9s9uiLp9fZsYry+7FViZy4h
 7PTMtfaDddeiEBBWje6JXBs6K5On4A36yEET/FLRWHvmiOGUL5HXJRcodAols8qGLyD1
 xs2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501517; x=1778106317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Gs1If9ZJokfA4hSDIZvghA/pVNIqspXTSw4VViLR5Xw=;
 b=stPWpet4Xeo3h9wDIhizajefL5DD2ZXOpc5tcOCP8elc7H+yk8cMphB+6hR51CSf8u
 MchUcT22TvQy2D/OKCSG0vkzpz+kB1dRiSJhdJBVg1LgXqJ43d+893zhzGBb8dR5/Fay
 LuSjC4qHfKkfwXcerqXH53He08qDMD9+JStUq8ov0rSDDL825Z6AzZ84DKNa8xfXaNR3
 sR+dihiM7LtKilNRvC1vjjaM+EvK94Ox8ar7A3GLl64zBdOKNyTuXknLN8BYPxqUMkBK
 9DcGxWzWJk1RkcV0M6eg8QhoArzZAc1NSYDJXA0cCxy8UY1qJiZyYOZlsMQKUcdacA0Y
 UsvA==
X-Gm-Message-State: AOJu0YwLdr3UKqFXoI/ySsnQUK+PBKz71ip05TdSNXjBYGhMv3v2BAo1
 3bMhehuH7RK7UoKPgqIw7zbFZRyiYmFmf3zt2/13gCKVjQaHPHv4xbHAMBxwWm5kgok1EHTv77E
 6IoCWfqU=
X-Gm-Gg: AeBDieuDb5WWjGqjddept2I2YgWHjoTyHVz7gUiGLUebMAiNJ4BUAiYHSrodR1j5heM
 pEBkyS13mqKiZg31UWkWHaPb1wctKzvRpfmDSiKzwn0k/ZehFb+Rxemd3ag8g3SI8Z77gb5EP6i
 7UmhhJQlsYLKW2Ps4G0yAID7wRGP+dM/jJAQCxpeUfSgk+8exNwtLSkYT8+XZ9YQ4DanoJH6CaU
 XxvhZ4CqYGFO0S/E9CdLoqaU3tdtZU7yHKp95iAPNEYp0WNKab6UU5BP1s6ChiaIA1s4Fj14645
 z2EWYxR7tqdL9w+ePwrF5SVhFSqhiwcWGUCSHRDsMFcZyi2f9i43KsPN6FVUoYR5Nf2PWsEvFZs
 pI5CWSBTp0epUDIGsQ4ZZzQTAHt+dVijhZgwpd+Y7kfLVo8Yaal/8TIYF8R7ANiaejahddCT29M
 2iywI67UUV9vtl/kuttWgyUOwYnXsfY89qmmRrM7kC
X-Received: by 2002:a17:90b:2742:b0:35e:5ae3:2993 with SMTP id
 98e67ed59e1d1-364c30e2c5dmr164663a91.15.1777501517295; 
 Wed, 29 Apr 2026 15:25:17 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:25:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/48] fpu: Drop parts_{add,sub}_normal
Date: Thu, 30 Apr 2026 08:24:07 +1000
Message-ID: <20260429222445.26301-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

Drop the forward declarations and the _Generic macros.
Add partsW() for use by muladd_scalbn.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           | 16 ++--------------
 fpu/softfloat-parts.c.inc | 12 ++++++------
 2 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index aa96ac530d..117c335d66 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -779,20 +779,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
                   FloatParts128 *: parts128_##NAME, \
                   FloatParts256 *: parts256_##NAME)
 
-static void parts64_add_normal(FloatParts64 *a, FloatParts64 *b);
-static void parts128_add_normal(FloatParts128 *a, FloatParts128 *b);
-static void parts256_add_normal(FloatParts256 *a, FloatParts256 *b);
-
-#define parts_add_normal(A, B) \
-    PARTS_GENERIC_64_128_256(add_normal, A)(A, B)
-
-static bool parts64_sub_normal(FloatParts64 *a, FloatParts64 *b);
-static bool parts128_sub_normal(FloatParts128 *a, FloatParts128 *b);
-static bool parts256_sub_normal(FloatParts256 *a, FloatParts256 *b);
-
-#define parts_sub_normal(A, B) \
-    PARTS_GENERIC_64_128_256(sub_normal, A)(A, B)
-
 static FloatParts64 *parts64_addsub(FloatParts64 *a, FloatParts64 *b,
                                     float_status *s, bool subtract);
 static FloatParts128 *parts128_addsub(FloatParts128 *a, FloatParts128 *b,
@@ -1635,6 +1621,7 @@ static const uint16_t rsqrt_tab[128] = {
 };
 
 #define partsN(NAME)   glue(glue(glue(parts,N),_),NAME)
+#define partsW(NAME)   glue(glue(glue(parts,W),_),NAME)
 #define FloatPartsN    glue(FloatParts,N)
 #define FloatPartsW    glue(FloatParts,W)
 
@@ -1660,6 +1647,7 @@ static const uint16_t rsqrt_tab[128] = {
 #undef  N
 #undef  W
 #undef  partsN
+#undef  partsW
 #undef  FloatPartsN
 #undef  FloatPartsW
 
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index e1ce2be924..6e1800b117 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -541,7 +541,7 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
     if (a->sign != b_sign) {
         /* Subtraction */
         if (likely(cmask_is_only_normals(ab_mask))) {
-            if (parts_sub_normal(a, b)) {
+            if (partsN(sub_normal)(a, b)) {
                 return a;
             }
             /* Subtract was exact, fall through to set sign. */
@@ -574,7 +574,7 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
     } else {
         /* Addition */
         if (likely(cmask_is_only_normals(ab_mask))) {
-            parts_add_normal(a, b);
+            partsN(add_normal)(a, b);
             return a;
         }
 
@@ -760,8 +760,8 @@ static FloatPartsN *partsN(muladd_scalbn)(FloatPartsN *a, FloatPartsN *b,
         c_widen.exp = c->exp;
 
         if (a->sign == c->sign) {
-            parts_add_normal(&p_widen, &c_widen);
-        } else if (!parts_sub_normal(&p_widen, &c_widen)) {
+            partsW(add_normal)(&p_widen, &c_widen);
+        } else if (!partsW(sub_normal)(&p_widen, &c_widen)) {
             goto return_sub_zero;
         }
     }
@@ -1869,9 +1869,9 @@ static void partsN(log2)(FloatPartsN *a, float_status *s, const FloatFmt *fmt)
     f.exp = f_exp - frac_normalize(&f);
 
     if (a_exp < 0) {
-        parts_sub_normal(a, &f);
+        partsN(sub_normal)(a, &f);
     } else if (a_exp > 0) {
-        parts_add_normal(a, &f);
+        partsN(add_normal)(a, &f);
     } else {
         *a = f;
     }
-- 
2.43.0


