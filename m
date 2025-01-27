Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22604C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 23:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcYV0-0006ZK-It; Mon, 27 Jan 2025 18:26:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcYUk-0006N8-KD
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 18:26:19 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcYUg-0005ZB-Jl
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 18:26:18 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ee9a780de4so6691225a91.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 15:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738020373; x=1738625173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZfZtm3bb0qleKGnPCMaYzFO4MuQ+NRuP+QrpJs1NXm0=;
 b=se4WTDzixwYFq9X0Dx1zk6qbiOBrMhYZI5taW8j6VWTvoPi3bVr9XSih6vMCNXf5ds
 jXZeadKstR/VIJIFP5/gwlauhWFJG/oCx+3R1JANRXkcqg0AvyIUEc6ytykJFgnWvyyR
 3XuuNv1U7HHtp97otMyaIwRQqwm8NPRGzDLthvZdbf9hCucuGKMEd79m/9l92BscSuYy
 TZ/fIhkYP3lh06N/3vYsOl7ens6qgCCgFO3xlXAECu33JUMslTUJffPbip95NFaVrfyR
 YFJ0igDkrwbS1dFMehfhv4YU9AY32P9G00Yhxrvs6bcNmSxj6MQtn4CNOlypZNHE9+ZI
 VxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738020373; x=1738625173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZfZtm3bb0qleKGnPCMaYzFO4MuQ+NRuP+QrpJs1NXm0=;
 b=JTI+uLmGGNMk6wbc+9nw6B3Dle579rG7pH3ajJn9BuH969Y4RbxUNaJ05awSF5y4dd
 XQYmh+Gsm2vXJCqGXcj+14uohl6sfvEuSnEnQIOvo4RCAPkJPBNa3PqeyTX95vUmOCML
 5GRs8Q9WtZMxigx2izOp5sxrBjozDw0d79MCCOAgjfF98FMY39QOkzGAQ3FiLWOXEhXy
 f+5gSrmDY+kIIXKQM3qAMFSQnxxdIizZsSMQEhcFXFvRzVywDmMuCh7MP0+eN/bRziDq
 bEDeACoXXjdbuVHLsMRnlpStQ8J/cIzaYZwzVgvHKDU2QGO5YEVKdH589CoZVaowZgVd
 fkhw==
X-Gm-Message-State: AOJu0Yxy98gJV/E7jwIuYEB6CkNrlOaQoOsK0DTWRtFjRvDkAzCd8DG2
 rxce8ErKSVli4Z9qs7r2eTlT2CoaGuZ96PTu2wDXR85glSSupnfwd8H8p/gF8sAjJTBLMKz5Fhr
 Y
X-Gm-Gg: ASbGncs6JufnTY8uxibg1tkcu4vf/Gd+AwSWTUEnAs3mGIHIt+zg1eGJDvdfaKlLZSQ
 Bqu7DeXmRHE4N/J/MQmR46mIl1bBV4TteiTfXXWzpX2dvxgrVoXABcXgwU1x3PkJoVNYcX54CHD
 t6Am+7aMgWRcV+p2Efgj3/wOAADsTxGFw2o/shauKO0oNWUJUSyyKnODtPyxK+HydWGFc2gSC22
 5StkO6TUwH00uylaKSDVJaerbBEwyaWUpD8+VTTABkma4qh0/jmDCkcthKcqjMU0MLjgPq7DcRZ
 4i7K9J8C85m7mF7UsBbQ2dsKsf3dNplSDqODZQ8=
X-Google-Smtp-Source: AGHT+IF8l/c64VwSOu3pEFnKOaLvLLCD/4i4q1Lsrql/85MFTtGiCksLJw2omhD8bM8d4JgYi+dFmA==
X-Received: by 2002:a17:90b:2c84:b0:2ef:31a9:95c6 with SMTP id
 98e67ed59e1d1-2f782c7de14mr69490958a91.14.1738020373329; 
 Mon, 27 Jan 2025 15:26:13 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffb1b31esm7833000a91.47.2025.01.27.15.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 15:26:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	qemu-arm@nongnu.org
Subject: [PATCH 10/22] target/arm: Remove ah_fp_status
Date: Mon, 27 Jan 2025 15:25:52 -0800
Message-ID: <20250127232604.20386-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250127232604.20386-1-richard.henderson@linaro.org>
References: <20250127232604.20386-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Replace with fp_status[FPST_AH].

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h        | 3 +--
 target/arm/cpu.c        | 6 +++---
 target/arm/vfp_helper.c | 6 +++---
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0f7d5d5430..5e3d952588 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -233,7 +233,7 @@ typedef struct NVICState NVICState;
  * the "standard FPSCR" tracks the FPSCR.FZ16 bit rather than
  * using a fixed value for it.
  *
- * The ah_fp_status is needed because some insns have different
+ * FPST_AH is needed because some insns have different
  * behaviour when FPCR.AH == 1: they don't update cumulative
  * exception flags, they act like FPCR.{FZ,FIZ} = {1,1} and
  * they ignore FPCR.RMode. But they don't ignore FPCR.FZ16,
@@ -694,7 +694,6 @@ typedef struct CPUArchState {
                 float_status fp_status_a64;
                 float_status fp_status_f16_a32;
                 float_status fp_status_f16_a64;
-                float_status ah_fp_status;
             };
         };
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ffb2151de5..01a0428c6e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -556,9 +556,9 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     arm_set_default_fp_behaviours(&env->vfp.fp_status_f16_a32);
     arm_set_default_fp_behaviours(&env->vfp.fp_status_f16_a64);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD_F16]);
-    arm_set_ah_fp_behaviours(&env->vfp.ah_fp_status);
-    set_flush_to_zero(1, &env->vfp.ah_fp_status);
-    set_flush_inputs_to_zero(1, &env->vfp.ah_fp_status);
+    arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_AH]);
+    set_flush_to_zero(1, &env->vfp.fp_status[FPST_AH]);
+    set_flush_inputs_to_zero(1, &env->vfp.fp_status[FPST_AH]);
     arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_AH_F16]);
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index d8dc58098b..78be434caf 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -129,7 +129,7 @@ static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
     a64_flags |= (get_float_exception_flags(&env->vfp.fp_status_f16_a64)
           & ~(float_flag_input_denormal_flushed | float_flag_input_denormal_used));
     /*
-     * We do not merge in flags from ah_fp_status or FPST_AH_F16, because
+     * We do not merge in flags from FPST_AH or FPST_AH_F16, because
      * they are used for insns that must not set the cumulative exception bits.
      */
 
@@ -159,7 +159,7 @@ static void vfp_clear_float_status_exc_flags(CPUARMState *env)
     set_float_exception_flags(0, &env->vfp.fp_status_f16_a64);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD_F16]);
-    set_float_exception_flags(0, &env->vfp.ah_fp_status);
+    set_float_exception_flags(0, &env->vfp.fp_status[FPST_AH]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_AH_F16]);
 }
 
@@ -234,7 +234,7 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_a64);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a32);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a64);
-        set_default_nan_mode(dnan_enabled, &env->vfp.ah_fp_status);
+        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_AH]);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_AH_F16]);
     }
     if (changed & FPCR_AH) {
-- 
2.43.0


