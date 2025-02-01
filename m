Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203A7C02192
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGZs-0003BW-Dk; Sat, 01 Feb 2025 11:42:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYt-0007X0-VV
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:41 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYs-0001O1-33
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:39 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43634b570c1so21880415e9.0
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428097; x=1739032897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PDNdQU+EgkviaCFFuZsQiiE/KHqlTU7GmFh3tf8FdAg=;
 b=ZHsk9Oa6wJyZif+HA65jgI5XgQwV4CLALSYULp024GBqPNn1mG7qNmUc2bbYP4meYU
 bwp80KFmp8L6KmWUZTs6wqviuQzdT9bXcVvLbKSqehj9lvX8NQaP40zQWJ4n/Tsz2rR0
 rtbfnOZI0u85ca+ryI8sDksLg9RtS+Oa0kCfvZKygfZGenTdm9kuKv6F6KWIwcyFmVn/
 8N+IBPQvus4srvHtxi7j1tcIF4T+w+fqs7T0s1iN16VC0XTu2488BcKiMGXQ2S04XJ20
 8Vr8B8V+DeAyPtAK486Hy5o4zKZMTVaQH/HX+RuR/+evljlnsBfJvOkbbnw+S29gpTni
 AJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428097; x=1739032897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PDNdQU+EgkviaCFFuZsQiiE/KHqlTU7GmFh3tf8FdAg=;
 b=K70H/D3SUzpJNd4+qbFz/eL9HHkH8i4vGr1p4/glrMgWAUUQRm17XRmLI0E4NGxKeo
 FkPhvwJCMHFU9/auysHT0iwgp7IT7X4VdxaTE4/RQNpVinLg2D40Z+5Re7/cOMHHke69
 FjiHyvs7ZvIPZM/RSGJZlUpt07W6j2Iob7DQrG5enVTSlN6klU7EaQMdYWm7z3JXIj+X
 gYfXBrsv59ZgJ3OnHQpUPRZ3gG6uA6dNGZwA06lGcdTcbsooe5hO5sRwVqX1poFTqVaV
 sEH1GeaO+k/H1ZRLRY95nYU020Hlz2As37SW435fJqT+YZJ7mcA6FjBE+tonECIq2Brl
 juwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwGgI/jNSZI6Fhd2qn5aLUX3tzfw9N+lnRvz6El8ksbdZMDhMiNF20Xbn00x3dgA+W8hGCoHIFofmz@nongnu.org
X-Gm-Message-State: AOJu0YycZOFJm/glYtqkuW8JDZiZAOeFrUiXi4GImd8TbAzasxA2SoqZ
 HfLN9TkESzr6MQJiCrirfZtRTq86TqGrmRM+M+2o0PKP7qchZUoauseHLsThA+BHVw15JmIjOgj
 G
X-Gm-Gg: ASbGncvgOJJoCRbgEV0+/9xR9YozbL6PzVlIVK2Rkudx1rnc2RJz5M4OgkV00Yjjvld
 2V68Tv2O/7RL6tQwJZSpyN9ASIUPcy8v8lSxzErx5KNlHM8UTX3HFY7IFORRZhq0vX/h+GJnm4y
 3wfJuzk2UqMyrAcZEFlE7CRdTSIVE3MTf6LhxgmRnzvMM+OGqjyfKYjDr/1wgwZMF9Yv0jLRopT
 HpjKrifCIcMG+5pHz+yq6Nh8npNC92BZFMwT3K6r3I0vHkOCHRT1e3nnveNk/oNMoYL7UcZg+Ar
 enfse30MaIWVoZvtTpWj
X-Google-Smtp-Source: AGHT+IGONyq3a+RWywb2TdBZniB9Ms4mHE2njOALFhwbB49ACMGmcs5nrg4/GYA0u5IiE2aIj3cUiQ==
X-Received: by 2002:a05:600c:1e21:b0:434:fec5:4ef5 with SMTP id
 5b1f17b1804b1-438dc3c3287mr150684505e9.14.1738428096578; 
 Sat, 01 Feb 2025 08:41:36 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:41:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 65/69] target/arm: Remove fp_status_a32
Date: Sat,  1 Feb 2025 16:40:08 +0000
Message-Id: <20250201164012.1660228-66-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

Replace with fp_status[FPST_A32].  As this was the last of the
old structures, we can remove the anonymous union and struct.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250129013857.135256-15-richard.henderson@linaro.org
[PMM: tweak to account for change to is_ebf()]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h            |  7 +------
 target/arm/cpu.c            |  2 +-
 target/arm/tcg/vec_helper.c |  2 +-
 target/arm/vfp_helper.c     | 18 +++++++++---------
 4 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 05a58de0451..e6513ef1e5d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -687,12 +687,7 @@ typedef struct CPUArchState {
         uint32_t scratch[8];
 
         /* There are a number of distinct float control structures. */
-        union {
-            float_status fp_status[FPST_COUNT];
-            struct {
-                float_status fp_status_a32;
-            };
-        };
+        float_status fp_status[FPST_COUNT];
 
         uint64_t zcr_el[4];   /* ZCR_EL[1-3] */
         uint64_t smcr_el[4];  /* SMCR_EL[1-3] */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 777e5f5dd80..180e11c5d7a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -550,7 +550,7 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     set_flush_inputs_to_zero(1, &env->vfp.fp_status[FPST_STD]);
     set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD]);
     set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD_F16]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status_a32);
+    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A32]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A32_F16]);
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 215affc2711..2da44ae7102 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2951,7 +2951,7 @@ bool is_ebf(CPUARMState *env, float_status *statusp, float_status *oddstatusp)
      */
     bool ebf = is_a64(env) && env->vfp.fpcr & FPCR_EBF;
 
-    *statusp = is_a64(env) ? env->vfp.fp_status[FPST_A64] : env->vfp.fp_status_a32;
+    *statusp = env->vfp.fp_status[is_a64(env) ? FPST_A64 : FPST_A32];
     set_default_nan_mode(true, statusp);
 
     if (ebf) {
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index fcbe36ecdc3..dd3f868a16e 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -117,7 +117,7 @@ static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
 {
     uint32_t a32_flags = 0, a64_flags = 0;
 
-    a32_flags |= get_float_exception_flags(&env->vfp.fp_status_a32);
+    a32_flags |= get_float_exception_flags(&env->vfp.fp_status[FPST_A32]);
     a32_flags |= get_float_exception_flags(&env->vfp.fp_status[FPST_STD]);
     /* FZ16 does not generate an input denormal exception.  */
     a32_flags |= (get_float_exception_flags(&env->vfp.fp_status[FPST_A32_F16])
@@ -155,7 +155,7 @@ static void vfp_clear_float_status_exc_flags(CPUARMState *env)
      * values. The caller should have arranged for env->vfp.fpsr to
      * be the architecturally up-to-date exception flag information first.
      */
-    set_float_exception_flags(0, &env->vfp.fp_status_a32);
+    set_float_exception_flags(0, &env->vfp.fp_status[FPST_A32]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_A64]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_A32_F16]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_A64_F16]);
@@ -198,7 +198,7 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
             i = float_round_to_zero;
             break;
         }
-        set_float_rounding_mode(i, &env->vfp.fp_status_a32);
+        set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A32]);
         set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A64]);
         set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A32_F16]);
         set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A64_F16]);
@@ -216,10 +216,10 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
     }
     if (changed & FPCR_FZ) {
         bool ftz_enabled = val & FPCR_FZ;
-        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_a32);
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A32]);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A64]);
         /* FIZ is A64 only so FZ always makes A32 code flush inputs to zero */
-        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_a32);
+        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A32]);
     }
     if (changed & (FPCR_FZ | FPCR_AH | FPCR_FIZ)) {
         /*
@@ -232,7 +232,7 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
     }
     if (changed & FPCR_DN) {
         bool dnan_enabled = val & FPCR_DN;
-        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_a32);
+        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A32]);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A64]);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A32_F16]);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A64_F16]);
@@ -497,8 +497,8 @@ void VFP_HELPER(cmpe, P)(ARGTYPE a, ARGTYPE b, CPUARMState *env) \
         FLOATTYPE ## _compare(a, b, &env->vfp.FPST)); \
 }
 DO_VFP_cmp(h, float16, dh_ctype_f16, fp_status[FPST_A32_F16])
-DO_VFP_cmp(s, float32, float32, fp_status_a32)
-DO_VFP_cmp(d, float64, float64, fp_status_a32)
+DO_VFP_cmp(s, float32, float32, fp_status[FPST_A32])
+DO_VFP_cmp(d, float64, float64, fp_status[FPST_A32])
 #undef DO_VFP_cmp
 
 /* Integer to float and float to integer conversions */
@@ -1385,7 +1385,7 @@ uint64_t HELPER(fjcvtzs)(float64 value, float_status *status)
 
 uint32_t HELPER(vjcvt)(float64 value, CPUARMState *env)
 {
-    uint64_t pair = HELPER(fjcvtzs)(value, &env->vfp.fp_status_a32);
+    uint64_t pair = HELPER(fjcvtzs)(value, &env->vfp.fp_status[FPST_A32]);
     uint32_t result = pair;
     uint32_t z = (pair >> 32) == 0;
 
-- 
2.34.1


