Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9E6C02192
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcryy-0003sv-7W; Tue, 28 Jan 2025 15:14:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcry5-0002QD-CQ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:58 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcry1-0001er-MA
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:52 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43618283dedso64255945e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095228; x=1738700028; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3HBfsF9TIBy11pmxUsWepe2W3o3J2UJiBXe+3Q6QjXw=;
 b=VN3Q2G1Ro+XhWetb2Nkq1jkrznSaMwFnSzEJUUXazsznlgUhkLsnWIYyvtgFhdZG7e
 4c/khffUZNvfzBy7biicUBsiCjWtesqswJmNXJFSHto1fiC5TGX0B9rIcr52sQs5AZCc
 jOMO4hJ3XbnkKrc4pXKPqCEIpVVVS2izTATYc/ZXp/PgRLbXAa/OTWuIEy73ctM2qox3
 xstdgF5GnQlg9k31G3YBdu8hEtmJ8ghLMcHw7ZWIIr/3fxFwd17hj1HS9rEHig/sww5m
 k1UK6wd87M2hwx31CPhuxD+FAWGRjwLbLLannm2P6GmyG6Tf3dPev8bVUNlVbStk6sfp
 Y3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095228; x=1738700028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3HBfsF9TIBy11pmxUsWepe2W3o3J2UJiBXe+3Q6QjXw=;
 b=OVPbf3bnHAUvByn2JGySPsRdB9zNEKsoji3ort8SA2PZiW7qIo+eKRE+JyGFQnq8oU
 i7VYu5PmCy9jxzbtXQVrVT+7DbYAL0aIvn/dfcwCQPVLiXITgbQK5kVRqeUzTO+8fEEH
 ShAYi1tCdZQGLqqkN07o9xR8Jkqi54rzCiwm55fbokRQjMloAL1EpxbSsWIyTWEHup6s
 7QprOV3tLaAEHG1/KHd0SHC7dPXlRnfk7NDYZxiQJuVQxO5otXMn7NbyNbLcyeTSA1+c
 Pj5irSkliboHJtPkuwIEDx0zrmaGsg4YKZ+WJR/cv6/0SqlW0M2Zwnf5SsBJA90fq9tU
 lOyQ==
X-Gm-Message-State: AOJu0Yw1HHdUgxHiyHJyOHPVCd0uG3OKqYUsHTeS2pVq/e1CMo+N3gSf
 GJqaini0BRgsHL0w1TijDb/WmXDAvAR1Av2P6FB7qmg3CCNXBQ9WjCqiDJWjgXZtUmX84pSisg2
 Y
X-Gm-Gg: ASbGncvFs4kRVjxilNX34mSR1AzaNZR3RG2716egwAInfdtDTvX7dJdEagixxqK1ADv
 Ii5cEq3BBQX96ZMbBc65c7zloghEb0IArecsEt+PBNs5hO1qnuiT16n/O1IWBBjIHMnC49mpMm8
 OocAFTBQhQyfuZ5aUn77LQFk7KhDP9cA4CqClfmPix+te/+wJ+YSWiqXzY4nIwbujE333enmKgv
 Fhz2Zi2w2VNOWoeZCto80wvGKn3+cuz7SyR6JYyWzplo4tH9gYxIAmNnPDsEl5t4T0Ne/YGXfyr
 8uMpzrTxKDPJNfn1gAYMnQ==
X-Google-Smtp-Source: AGHT+IERidu1vSB3VTIJn+gi9vWrEtzOEnOorHmRk2zBfelMezxxXZZYb69Pwlp9u16hgX4SzPL1Yg==
X-Received: by 2002:a05:600c:1d1e:b0:434:a90b:94fe with SMTP id
 5b1f17b1804b1-438dc3c2608mr2759975e9.10.1738095228295; 
 Tue, 28 Jan 2025 12:13:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/36] target/arm: Remove now-unused vfp.fp_status_f16 and
 FPST_FPCR_F16
Date: Tue, 28 Jan 2025 20:13:08 +0000
Message-Id: <20250128201314.44038-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250124162836.2332150-19-peter.maydell@linaro.org
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
index d84c6d74aa4..084ee63d990 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -672,7 +672,6 @@ static inline CPUARMTBFlags arm_tbflags_from_tb(const TranslationBlock *tb)
 typedef enum ARMFPStatusFlavour {
     FPST_A32,
     FPST_A64,
-    FPST_FPCR_F16,
     FPST_A32_F16,
     FPST_A64_F16,
     FPST_STD,
@@ -691,8 +690,6 @@ typedef enum ARMFPStatusFlavour {
  *   for AArch32 non-FP16 operations controlled by the FPCR
  * FPST_A64
  *   for AArch64 non-FP16 operations controlled by the FPCR
- * FPST_FPCR_F16
- *   for operations controlled by the FPCR where FPCR.FZ16 is to be used
  * FPST_A32_F16
  *   for AArch32 operations controlled by the FPCR where FPCR.FZ16 is to be used
  * FPST_A64_F16
@@ -714,9 +711,6 @@ static inline TCGv_ptr fpstatus_ptr(ARMFPStatusFlavour flavour)
     case FPST_A64:
         offset = offsetof(CPUARMState, vfp.fp_status_a64);
         break;
-    case FPST_FPCR_F16:
-        offset = offsetof(CPUARMState, vfp.fp_status_f16);
-        break;
     case FPST_A32_F16:
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


