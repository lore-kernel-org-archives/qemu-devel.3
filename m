Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A0BC0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx2u-0000pA-56; Tue, 28 Jan 2025 20:39:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2r-0000o5-D9
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:09 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2p-0003VQ-8V
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:08 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21680814d42so103414485ad.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738114746; x=1738719546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZfZtm3bb0qleKGnPCMaYzFO4MuQ+NRuP+QrpJs1NXm0=;
 b=kEj6vwDWFb1FkPcetntCOyYCpCd5/qj+17FdIOb/ZaGV7UMDge7LFO5OHyVcjyYzD/
 fyr58/qSnNp7q/cHRZ3ZrrTJCbU8MUlJ9ebMmydg5jP6Tm2CJpQ+UpF/yAvN+R6ZvLnV
 OIk7p8Mf0H2Vy7VS274t+PgA7p+CId0ZYX0ZnVgCJ3bmtih9zPhj603VKrPj4GBKbhxO
 HnzRlJ1ZDazzpJ/NoumGCKTyHvyQOtc5A/Un010LqAw5X1w4Q+dXhrmanjF1Fl19LJ8U
 xN/ZpoNw2hoPAkEUZIoRRE1N/FEXJZ86CHhC1FfZTDDU0UZc8okny+fPjbDsQuxeB9JU
 xgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114746; x=1738719546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZfZtm3bb0qleKGnPCMaYzFO4MuQ+NRuP+QrpJs1NXm0=;
 b=iFZcMI6x6PBUZeHSzMgECIgNUJFPPP+rruFAJrmdSZXc/acL3IR8qWt0YxKbSieXyr
 /fxdh4fKzSQfezRo1BkOPuhUAGcu8uM+OIGqCRmV2eJZ46iE4QODPzMrHhuMTnZEJeQc
 vYZnQGu4KJ/njpHEJeC66fmSM0RleMDBXPTAP2UqfXfa0KCIvl0k724/vxv879k/DOP2
 h1xDX19UnRE/9a5ciGDj4U+KkKclzPhOJPk3HaIqBRmMk8W6UpLUCXJWH/8w5KFLqETn
 SgZLnEQ5dll6fMUQZmkxZ8cr6lo54RebTz02qpqJQHCUqy2rqHaVs76ZLShDXSDNUh+Z
 E5lg==
X-Gm-Message-State: AOJu0YxzNNLh9YsD3hnEAbfjmDMVQOvHoyJSLPZFz7b7JJrLNHcXh/t5
 cR2zV/BTo+gWtpnqkrvLucfC6TEcm1wY3lTncMeIC7xtBlDVAC2ugqueOFTY6LMrs9A8rxBobZF
 9
X-Gm-Gg: ASbGncuIuUjUTC++nRZUsecsCVoF+a+KLRK5hESEI9IsQQ0jeh8PFqBeXZN2VX3/XN0
 4xXLlUarZDpeHEMWamsgn4Px64JxX7Gum+DVUUyYqUnUKad9HiTjkX8epU0hTorttqitT1EtlYM
 pAWKTJClLALrtpmgEeQxB+5AugbXZfW+52WGVCxHFYmTDvNy8zF+njivNuNtGIfC1PCeylYle2r
 +t41HjZmgblSUV/FBWcSQDXa63oTy9V8hyt4aiOfWPIRVwY8XwMayDGizC2PVAr63U0PEHNjDWt
 WvpwcU93JNjlvmn5PqDQq73EOsqZcWf/EH8UvlDvakmCkH22tQ==
X-Google-Smtp-Source: AGHT+IF4u2YBJ3FvUNoaTrx4VeBB65Bf/mpJOPEUdX/kvgajJLh5BeiqUHvpa0eLvrERkf/nK4iJXw==
X-Received: by 2002:a17:902:d4c5:b0:216:5cbd:5449 with SMTP id
 d9443c01a7336-21dd7c638bemr15607895ad.13.1738114745988; 
 Tue, 28 Jan 2025 17:39:05 -0800 (PST)
Received: from stoup.. (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea4200sm89341745ad.88.2025.01.28.17.39.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 17:39:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 10/34] target/arm: Remove ah_fp_status
Date: Tue, 28 Jan 2025 17:38:33 -0800
Message-ID: <20250129013857.135256-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129013857.135256-1-richard.henderson@linaro.org>
References: <20250129013857.135256-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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


