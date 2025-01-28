Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C51C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcryz-00042U-BP; Tue, 28 Jan 2025 15:14:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxy-0002GN-6W
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:47 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxv-0001db-Si
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:45 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43634b570c1so43361325e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095222; x=1738700022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aOM98GfZJIYZsteVCIrl9Vfj7MhE2RllnDjOWjIYwyY=;
 b=DtFjwRGKYPUOmcmaHm20AXoWuEot8SocuBY+D5q2Kj2eFBHEHncqtr2HWi8Y4Yfxci
 s3wit7Ba36RIcYGrme9KhZ46GY+8FQ/1ERs46g+Z+1zD3TtD0DS7XNd95sw5/VtM3NGS
 +DwktfLDlUHYLRTLPEU6DL4MltYBvKaooDVNCINjPelwJEpFlxShFUbDRSx52akZ9ff/
 4sb4mwzeuEoMSvoEzPYlk2d5+kFR8d/bHOWbt8dlbsB8Eq+Bni+K2odmEbNOLeTry3wA
 bROGzZXW4JlRtERbZ8xtLYDhmkDiSZHkhhfLbhzF+szjD8pA3JB2SBjKoQkoi26PL0Wv
 i7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095222; x=1738700022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aOM98GfZJIYZsteVCIrl9Vfj7MhE2RllnDjOWjIYwyY=;
 b=dluBxIdvBwdTN4jRQsvnnvQf/uFWH7XISx4+8Ip3wSmrqYufRW6E71fuLq8L94teb7
 rJSJ53JXRD36EHCC842y9Kt7mdyMJskpvLSTrYmQdS61H6c1gprfItA3W5ZH1Z5I6k2u
 43U8cXbZlfpkcsnR9RY0nIF8gGFJ/zmgIuqOZRBqEOMFFyCnreUHqdK932vHdaZt1waE
 OXaBav5aepQkEj5D+lAXxELBJMTBxrxUE3yVMbnvwwjbiyvs25HUY9hNYGp8lRWBKl34
 ZewRTTk/stA44KviJ3MqK1KP2df84FRQ2E0aTKjKWm/awJktrVzcni6+44s2Ez7wFjbr
 WLKw==
X-Gm-Message-State: AOJu0Yzi7aPS9MT69LHzfAqhXmnkOFp05K3U4z0mbG8qcBAc43GfWAXe
 +DKSxzqfc63MWKSMxEHhgsAuZPIuVS7bdhm6sas2c5tAaavCh5YBU6s+5RMeCQra1q8EeDSrylJ
 x
X-Gm-Gg: ASbGncvIJjWZ2TwxuxhLx351yA59TQxINT0K6vEA80tp9YUft18QkdEkZH9HSTztykb
 rXK0Yhomkz49tZAj4CXgLQxGNpvzIUrGWCTAiL8fhO5vP8AG4K61Dr/n2AIBoOJrZ8sVgJpFQkO
 OKZmOLSk4akmttLYIYWGGtvhyTOBl0qNNNPC2uElRYoK7JG0sARZknqQmFzKWTiyV/8CIahQLe5
 wM2TPM+Rh1EVU6CS5NRXQ/KokG2SAVYEWaMAB5D5fqdoUzmFR04a/Uv+4im1OHS9WS+fut4SmOW
 oLe5Ir5QPag8NpmU+tjQBg==
X-Google-Smtp-Source: AGHT+IGOeuMf0b4mbVn8f1617p4P9nWl/J98znAtoclk2pNSN4R+D9eOvXNHO8PzeDduqRIPG5O3Zg==
X-Received: by 2002:a05:600c:1554:b0:436:faf1:9da with SMTP id
 5b1f17b1804b1-438dc3a3f9emr2688015e9.2.1738095222412; 
 Tue, 28 Jan 2025 12:13:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/36] target/arm: Define new fp_status_f16_a32 and
 fp_status_f16_a64
Date: Tue, 28 Jan 2025 20:13:03 +0000
Message-Id: <20250128201314.44038-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

As the first part of splitting the existing fp_status_f16
into separate float_status fields for AArch32 and AArch64
(so that we can make FEAT_AFP control bits apply only
for AArch64), define the two new fp_status_f16_a32 and
fp_status_f16_a64 fields, but don't use them yet.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250124162836.2332150-14-peter.maydell@linaro.org
---
 target/arm/cpu.h           |  4 ++++
 target/arm/tcg/translate.h | 12 ++++++++++++
 target/arm/cpu.c           |  2 ++
 target/arm/vfp_helper.c    | 14 ++++++++++++++
 4 files changed, 32 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 7b967bbd1d2..be409c5c76e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -636,6 +636,8 @@ typedef struct CPUArchState {
          *  fp_status_a32: is the "normal" fp status for AArch32 insns
          *  fp_status_a64: is the "normal" fp status for AArch64 insns
          *  fp_status_fp16: used for half-precision calculations
+         *  fp_status_fp16_a32: used for AArch32 half-precision calculations
+         *  fp_status_fp16_a64: used for AArch64 half-precision calculations
          *  standard_fp_status : the ARM "Standard FPSCR Value"
          *  standard_fp_status_fp16 : used for half-precision
          *       calculations with the ARM "Standard FPSCR Value"
@@ -662,6 +664,8 @@ typedef struct CPUArchState {
         float_status fp_status_a32;
         float_status fp_status_a64;
         float_status fp_status_f16;
+        float_status fp_status_f16_a32;
+        float_status fp_status_f16_a64;
         float_status standard_fp_status;
         float_status standard_fp_status_f16;
 
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index fca68b7c4c8..d84c6d74aa4 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -673,6 +673,8 @@ typedef enum ARMFPStatusFlavour {
     FPST_A32,
     FPST_A64,
     FPST_FPCR_F16,
+    FPST_A32_F16,
+    FPST_A64_F16,
     FPST_STD,
     FPST_STD_F16,
 } ARMFPStatusFlavour;
@@ -691,6 +693,10 @@ typedef enum ARMFPStatusFlavour {
  *   for AArch64 non-FP16 operations controlled by the FPCR
  * FPST_FPCR_F16
  *   for operations controlled by the FPCR where FPCR.FZ16 is to be used
+ * FPST_A32_F16
+ *   for AArch32 operations controlled by the FPCR where FPCR.FZ16 is to be used
+ * FPST_A64_F16
+ *   for AArch64 operations controlled by the FPCR where FPCR.FZ16 is to be used
  * FPST_STD
  *   for A32/T32 Neon operations using the "standard FPSCR value"
  * FPST_STD_F16
@@ -711,6 +717,12 @@ static inline TCGv_ptr fpstatus_ptr(ARMFPStatusFlavour flavour)
     case FPST_FPCR_F16:
         offset = offsetof(CPUARMState, vfp.fp_status_f16);
         break;
+    case FPST_A32_F16:
+        offset = offsetof(CPUARMState, vfp.fp_status_f16_a32);
+        break;
+    case FPST_A64_F16:
+        offset = offsetof(CPUARMState, vfp.fp_status_f16_a64);
+        break;
     case FPST_STD:
         offset = offsetof(CPUARMState, vfp.standard_fp_status);
         break;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a2b9bd3fb9d..ff8514edc6d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -576,6 +576,8 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     arm_set_default_fp_behaviours(&env->vfp.fp_status_a64);
     arm_set_default_fp_behaviours(&env->vfp.standard_fp_status);
     arm_set_default_fp_behaviours(&env->vfp.fp_status_f16);
+    arm_set_default_fp_behaviours(&env->vfp.fp_status_f16_a32);
+    arm_set_default_fp_behaviours(&env->vfp.fp_status_f16_a64);
     arm_set_default_fp_behaviours(&env->vfp.standard_fp_status_f16);
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 9fee6265f20..45f9dfc8861 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -69,6 +69,10 @@ static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
     /* FZ16 does not generate an input denormal exception.  */
     i |= (get_float_exception_flags(&env->vfp.fp_status_f16)
           & ~float_flag_input_denormal);
+    i |= (get_float_exception_flags(&env->vfp.fp_status_f16_a32)
+          & ~float_flag_input_denormal);
+    i |= (get_float_exception_flags(&env->vfp.fp_status_f16_a64)
+          & ~float_flag_input_denormal);
     i |= (get_float_exception_flags(&env->vfp.standard_fp_status_f16)
           & ~float_flag_input_denormal);
     return vfp_exceptbits_from_host(i);
@@ -84,6 +88,8 @@ static void vfp_clear_float_status_exc_flags(CPUARMState *env)
     set_float_exception_flags(0, &env->vfp.fp_status_a32);
     set_float_exception_flags(0, &env->vfp.fp_status_a64);
     set_float_exception_flags(0, &env->vfp.fp_status_f16);
+    set_float_exception_flags(0, &env->vfp.fp_status_f16_a32);
+    set_float_exception_flags(0, &env->vfp.fp_status_f16_a64);
     set_float_exception_flags(0, &env->vfp.standard_fp_status);
     set_float_exception_flags(0, &env->vfp.standard_fp_status_f16);
 }
@@ -113,12 +119,18 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         set_float_rounding_mode(i, &env->vfp.fp_status_a32);
         set_float_rounding_mode(i, &env->vfp.fp_status_a64);
         set_float_rounding_mode(i, &env->vfp.fp_status_f16);
+        set_float_rounding_mode(i, &env->vfp.fp_status_f16_a32);
+        set_float_rounding_mode(i, &env->vfp.fp_status_f16_a64);
     }
     if (changed & FPCR_FZ16) {
         bool ftz_enabled = val & FPCR_FZ16;
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_f16);
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a32);
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a64);
         set_flush_to_zero(ftz_enabled, &env->vfp.standard_fp_status_f16);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_f16);
+        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a32);
+        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a64);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.standard_fp_status_f16);
     }
     if (changed & FPCR_FZ) {
@@ -133,6 +145,8 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_a32);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_a64);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16);
+        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a32);
+        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a64);
     }
 }
 
-- 
2.34.1


