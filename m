Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A345FC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMYn-0004th-AN; Fri, 24 Jan 2025 11:29:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYN-0003t2-53
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:08 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYI-0005TH-4o
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:04 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso15346535e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736140; x=1738340940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9M2O1KEVojOtqpm5b8dMJlhsf6kXCrNVO2nLRJ4F4OM=;
 b=YzZ66sCunxTOwsAmD0Gp0q47o7oxWtQ4ZEsiiBNSTOCz6e+0AwgssE0cfy+2wQKf0D
 GazWwp+bj6+/5ipVO0bdHTdn3YqiCoEb5EKzncAYoYMw3A0TeF6pa88UR1HZ8sTxYlEL
 yU5Z87MmqC8oa/p7R53OUpeUMFzL1L8JgtN9R5zomI0Wf05378cnE3disXTsclP6eaUg
 wYlwt2IzXQ+TMr4VNTbsgGbDjupHQi6Zi1lIuJamgyX1zaC+Hb1hih3grV7LsONFWgqT
 zMVBrcPwdQluwXLIdIYVoems4p33mhGDKMn8Aw3vMeKS4E3VlnLRZ7uu5MZtccUfumPc
 JcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736140; x=1738340940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9M2O1KEVojOtqpm5b8dMJlhsf6kXCrNVO2nLRJ4F4OM=;
 b=ckNlzqbQoOF2fmG9dPImCpzd5Z7rfMoNxTNQv6YgL7c30TObxnKsj88RSOkilD6361
 YX7m4oZSk70sp9YowBMvrK8lVApVW/kdvTPx1Lopnh57Yj3aNcbzLaAXF+FQlv6eG7Rj
 eCoc1dwpCRm+bpFj/uV/moSslW2k68u5sNM9t43gAB+VEIPVfyLVDalkxJ2/EzbfFqjT
 w1bnXkrkZKLt6mRnr8DvcrCaEBz/yDrdxWp3PBaYM5NwG7Bq/1kTbMraiQL9skeoNO1b
 wSp6LM7GISvifypJmInYF99qtJRtD1R+dC0Mm18ipR5L0fZTsYSE7J/c9gAPHizOTAcU
 7l+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwQnyN6hFtv/Y+zYbVPw91a7r9Ice3BFFfItUeuvV697uFuyaMUm7X2TlseyPHIL7VqkuXHyyl8ryA@nongnu.org
X-Gm-Message-State: AOJu0Yxz/HfS0v5vKxGYCvI1Ev1NsGdEtkHTnZz4lbk1+I8BvurC8U5j
 FI08fOHcA3a2SB7Q+FngoCaOQyfwnwlk1w0O4WXU4cJmCVz1dLOeuNOMPWppLLyTZzdt73QX0Fo
 3
X-Gm-Gg: ASbGnctu0rguTqFnmD89fiKFeZuT79M653jOIDHTLUI2yP7OqJR4cFNMRn8lqYXyuyA
 98LjE11fphqbWb8fACJAzSGC89g5oP9V9/osH3PLmnijw4qN9IWEx7AyB72aZs0gCN5EF8BucgV
 MEqRyQvBpbgQU3nciT7ybtj2wjqXTsm0MW2pStzhs51iW+lsdjvd+NOqE3tfgJu29azJbT2CAlW
 quP5JzkWX3SJpeJ8x+Yq3Mz5TvgxnUq0z+QVS2Y83PmkLKKrd0Vvbm8cVsWgTyLhhmzf+hWefxL
 97D6RKOMbOI=
X-Google-Smtp-Source: AGHT+IFU5h1L/vyUMxCtwFJsd6x+U6DjoJPuu8l4aRU8KAtqfcinVTzbmKcQJ1ekInOs1p7hY4IU7Q==
X-Received: by 2002:a05:600c:4712:b0:436:e69a:7341 with SMTP id
 5b1f17b1804b1-438b8841d69mr79410825e9.3.1737736140212; 
 Fri, 24 Jan 2025 08:29:00 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:28:58 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 18/76] target/arm: Remove now-unused vfp.fp_status_f16 and
 FPST_FPCR_F16
Date: Fri, 24 Jan 2025 16:27:38 +0000
Message-Id: <20250124162836.2332150-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Now we have moved all the uses of vfp.fp_status_f16 and FPST_FPCR_F16
to the new A32 or A64 fields, we can remove these.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h           | 2 --
 target/arm/tcg/translate.h | 6 ------
 target/arm/cpu.c           | 1 -
 target/arm/vfp_helper.c    | 7 -------
 4 files changed, 16 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index be409c5c76e..2213c277348 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -635,7 +635,6 @@ typedef struct CPUArchState {
          *
          *  fp_status_a32: is the "normal" fp status for AArch32 insns
          *  fp_status_a64: is the "normal" fp status for AArch64 insns
-         *  fp_status_fp16: used for half-precision calculations
          *  fp_status_fp16_a32: used for AArch32 half-precision calculations
          *  fp_status_fp16_a64: used for AArch64 half-precision calculations
          *  standard_fp_status : the ARM "Standard FPSCR Value"
@@ -663,7 +662,6 @@ typedef struct CPUArchState {
          */
         float_status fp_status_a32;
         float_status fp_status_a64;
-        float_status fp_status_f16;
         float_status fp_status_f16_a32;
         float_status fp_status_f16_a64;
         float_status standard_fp_status;
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 57e5d92cd60..ec4c0cf03fc 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -672,7 +672,6 @@ static inline CPUARMTBFlags arm_tbflags_from_tb(const TranslationBlock *tb)
 typedef enum ARMFPStatusFlavour {
     FPST_FPCR_A32,
     FPST_FPCR_A64,
-    FPST_FPCR_F16,
     FPST_FPCR_F16_A32,
     FPST_FPCR_F16_A64,
     FPST_STD,
@@ -691,8 +690,6 @@ typedef enum ARMFPStatusFlavour {
  *   for AArch32 non-FP16 operations controlled by the FPCR
  * FPST_FPCR_A64
  *   for AArch64 non-FP16 operations controlled by the FPCR
- * FPST_FPCR_F16
- *   for operations controlled by the FPCR where FPCR.FZ16 is to be used
  * FPST_FPCR_F16_A32
  *   for AArch32 operations controlled by the FPCR where FPCR.FZ16 is to be used
  * FPST_FPCR_F16_A64
@@ -714,9 +711,6 @@ static inline TCGv_ptr fpstatus_ptr(ARMFPStatusFlavour flavour)
     case FPST_FPCR_A64:
         offset = offsetof(CPUARMState, vfp.fp_status_a64);
         break;
-    case FPST_FPCR_F16:
-        offset = offsetof(CPUARMState, vfp.fp_status_f16);
-        break;
     case FPST_FPCR_F16_A32:
         offset = offsetof(CPUARMState, vfp.fp_status_f16_a32);
         break;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ff8514edc6d..7a83b9ee34f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -575,7 +575,6 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     arm_set_default_fp_behaviours(&env->vfp.fp_status_a32);
     arm_set_default_fp_behaviours(&env->vfp.fp_status_a64);
     arm_set_default_fp_behaviours(&env->vfp.standard_fp_status);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status_f16);
     arm_set_default_fp_behaviours(&env->vfp.fp_status_f16_a32);
     arm_set_default_fp_behaviours(&env->vfp.fp_status_f16_a64);
     arm_set_default_fp_behaviours(&env->vfp.standard_fp_status_f16);
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index f3aa80bbfb6..3ed69d73698 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -67,8 +67,6 @@ static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
     i |= get_float_exception_flags(&env->vfp.fp_status_a64);
     i |= get_float_exception_flags(&env->vfp.standard_fp_status);
     /* FZ16 does not generate an input denormal exception.  */
-    i |= (get_float_exception_flags(&env->vfp.fp_status_f16)
-          & ~float_flag_input_denormal);
     i |= (get_float_exception_flags(&env->vfp.fp_status_f16_a32)
           & ~float_flag_input_denormal);
     i |= (get_float_exception_flags(&env->vfp.fp_status_f16_a64)
@@ -87,7 +85,6 @@ static void vfp_clear_float_status_exc_flags(CPUARMState *env)
      */
     set_float_exception_flags(0, &env->vfp.fp_status_a32);
     set_float_exception_flags(0, &env->vfp.fp_status_a64);
-    set_float_exception_flags(0, &env->vfp.fp_status_f16);
     set_float_exception_flags(0, &env->vfp.fp_status_f16_a32);
     set_float_exception_flags(0, &env->vfp.fp_status_f16_a64);
     set_float_exception_flags(0, &env->vfp.standard_fp_status);
@@ -118,17 +115,14 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         }
         set_float_rounding_mode(i, &env->vfp.fp_status_a32);
         set_float_rounding_mode(i, &env->vfp.fp_status_a64);
-        set_float_rounding_mode(i, &env->vfp.fp_status_f16);
         set_float_rounding_mode(i, &env->vfp.fp_status_f16_a32);
         set_float_rounding_mode(i, &env->vfp.fp_status_f16_a64);
     }
     if (changed & FPCR_FZ16) {
         bool ftz_enabled = val & FPCR_FZ16;
-        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_f16);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a32);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a64);
         set_flush_to_zero(ftz_enabled, &env->vfp.standard_fp_status_f16);
-        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_f16);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a32);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a64);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.standard_fp_status_f16);
@@ -144,7 +138,6 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         bool dnan_enabled = val & FPCR_DN;
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_a32);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_a64);
-        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a32);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a64);
     }
-- 
2.34.1


