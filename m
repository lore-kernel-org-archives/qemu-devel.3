Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579CAC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht8m-00078n-B1; Tue, 11 Feb 2025 11:29:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht6O-0007AT-LR
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:27:13 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht6H-0003hK-F9
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:27:08 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so40531775e9.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291223; x=1739896023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0HZn+lA/3QK6V9nAt4Z7tzwLTmDhEfAS7cpqC5pJp9g=;
 b=SwTJd51vDoe6P03Bz5GZTwTv+XwwsBcRsuj1bOUiGdeua0RKa7dOWOC1tva0pU6ZQJ
 rzxJX2PGRzPzRhI4QdopSp+2tI3Fc5U8J4nJ+Bxx8kYKsnykOwvHzCtA+bI0W1y9S82v
 h07oPwHwd2RXAZ8dOUxk6JUZWUuYDeqycnEoncGu8oJsrtmGZve/xz6FNAOvEmaCA2Bl
 HeLR47Peco3SAfzf8s5yZ4eXyu6ilkaTPEpHb+Qc1giz25kZZ92ifxM1iU3HSe/gdJXt
 LQOaa9rgrTIY4FF7oMfa6CtE+omp4Et2beSu5qzd9gO74+x7AuRMLqutqDIzfDeKHxvV
 edpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291223; x=1739896023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0HZn+lA/3QK6V9nAt4Z7tzwLTmDhEfAS7cpqC5pJp9g=;
 b=RViR76BY2974C4RjWUVJ7GF73rnDihBEouBPjXU6kAqrAOUuPItswm1B/k8cArLSlh
 ADdN9d+mCmXVRnU265QsoBf7uzMxFZ20azEmiJKsPWZkKefMm8xpVTCYovTMXM/ZUEPF
 xNs7Tq9bJvZpAtYvUnPWu6cl8ezx0llBNOyr0t0u7jgOP+mtRI5mNWD4+AjHsSCK5k/K
 Ha54dIbnVpE+/P7f0gXSONUU0XL31WUMxS8D6tubbjWA/jo7QhOgFznwyoFskVpep8kO
 MEZofMpDvhqjL7SuAmRPj+vhQ3LdiuFW0UM0Lzhnmg1QD9z47xqG0EFzDTRabcXY77Zk
 HO6w==
X-Gm-Message-State: AOJu0Yz/rxaZmiDGG9zs/CpyVkgpZPsOqWD9WtF2/wfayEFQty8VlkLt
 kO8jA2N5yZQmNBjFBt5McKnB7wnZUY57YKVWOFHHZF9dNwqjhEB5C4N1Hy3C6CUXxR2JvAtJ7XE
 R
X-Gm-Gg: ASbGncsqMFV+dmyII4+lRhDqeahKPP5a621uXGJ1oYYyNmvZKNlQv77mFIeM0zQcgQq
 lZGzVH/kpCyGYMaoGg1PlgLkZct/xR40djZ9oFK3r5jgpO4RxaivqA6AVoeu/lirDGBbm7/QL0B
 aBAioub4OghxEMekNzQZswsX0sk40juKlZSQu2FuTtgyjD3AOpi5B/kVuGkyhBbuu0FSK7qXNmd
 pdyYeJrZSEGgblZzarnWQgwGQgQ0SqzX5gGGlJanMmgSPxtiulm6wGOf9b9+Jx8gxIW5QH9NNqZ
 Sb7zs5tGPQ/alpmC9yox
X-Google-Smtp-Source: AGHT+IFsBsAozWKgM3CFueL8jCFHcuDpmx1/OkmWTpEg1VYJooimJGKhs1N+e+pwuk3+wL5n6JNApQ==
X-Received: by 2002:a05:600c:1da4:b0:439:564a:6503 with SMTP id
 5b1f17b1804b1-439564a66e7mr18200715e9.18.1739291223276; 
 Tue, 11 Feb 2025 08:27:03 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.27.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:27:02 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 65/68] target/arm: Simplify fp_status indexing in mve_helper.c
Date: Tue, 11 Feb 2025 16:25:51 +0000
Message-Id: <20250211162554.4135349-66-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Select on index instead of pointer.
No functional change.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250129013857.135256-16-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/mve_helper.c | 40 +++++++++++++------------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 3763d71e20b..274003e2e5b 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -2814,8 +2814,7 @@ DO_VMAXMINA(vminaw, 4, int32_t, uint32_t, DO_MIN)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE)) == 0) {              \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -2888,8 +2887,7 @@ DO_2OP_FP_ALL(vminnma, minnuma)
                 r[e] = 0;                                               \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(tm & 1)) {                                            \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -2926,8 +2924,7 @@ DO_VCADD_FP(vfcadd270s, 4, float32, float32_add, float32_sub)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE)) == 0) {              \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -2964,8 +2961,7 @@ DO_VFMA(vfmss, 4, float32, true)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE * 2)) == 0) {          \
                 continue;                                               \
             }                                                           \
-            fpst0 = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :  \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst0 = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             fpst1 = fpst0;                                              \
             if (!(mask & 1)) {                                          \
                 scratch_fpst = *fpst0;                                  \
@@ -3049,8 +3045,7 @@ DO_VCMLA(vcmla270s, 4, float32, 3, DO_VCMLAS)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE)) == 0) {              \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -3084,8 +3079,7 @@ DO_2OP_FP_SCALAR_ALL(vfmul_scalar, mul)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE)) == 0) {              \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -3116,9 +3110,8 @@ DO_2OP_FP_ACC_SCALAR(vfmas_scalars, 4, float32, DO_VFMAS_SCALARS)
         unsigned e;                                             \
         TYPE *m = vm;                                           \
         TYPE ra = (TYPE)ra_in;                                  \
-        float_status *fpst = (ESIZE == 2) ?                     \
-            &env->vfp.fp_status[FPST_STD_F16] :                 \
-            &env->vfp.fp_status[FPST_STD];                       \
+        float_status *fpst =                                    \
+            &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
         for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE) {      \
             if (mask & 1) {                                     \
                 TYPE v = m[H##ESIZE(e)];                        \
@@ -3168,8 +3161,7 @@ DO_FP_VMAXMINV(vminnmavs, 4, float32, true, float32_minnum)
             if ((mask & emask) == 0) {                                  \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(mask & (1 << (e * ESIZE)))) {                         \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -3202,8 +3194,7 @@ DO_FP_VMAXMINV(vminnmavs, 4, float32, true, float32_minnum)
             if ((mask & emask) == 0) {                                  \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(mask & (1 << (e * ESIZE)))) {                         \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -3267,8 +3258,7 @@ DO_VCMP_FP_BOTH(vfcmples, vfcmple_scalars, 4, float32, !DO_GT32)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE)) == 0) {              \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -3300,9 +3290,8 @@ DO_VCVT_FIXED(vcvt_fu, 4, uint32_t, helper_vfp_touls_round_to_zero)
         unsigned e;                                                     \
         float_status *fpst;                                             \
         float_status scratch_fpst;                                      \
-        float_status *base_fpst = (ESIZE == 2) ?                        \
-            &env->vfp.fp_status[FPST_STD_F16] :                         \
-            &env->vfp.fp_status[FPST_STD];                               \
+        float_status *base_fpst =                                       \
+            &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD];  \
         uint32_t prev_rmode = get_float_rounding_mode(base_fpst);       \
         set_float_rounding_mode(rmode, base_fpst);                      \
         for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE) {              \
@@ -3427,8 +3416,7 @@ void HELPER(mve_vcvtt_hs)(CPUARMState *env, void *vd, void *vm)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE)) == 0) {              \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
-- 
2.34.1


