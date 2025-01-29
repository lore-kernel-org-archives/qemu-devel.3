Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B89C0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:45:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx2t-0000oL-1z; Tue, 28 Jan 2025 20:39:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2q-0000nN-4i
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:08 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2o-0003V9-Fb
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:07 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2161eb94cceso76106635ad.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738114745; x=1738719545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rv/vufPtN4qZGgCEixmno+0BEOkC6dlLbTtJbkkFI6Y=;
 b=us+qSFQP3V+ux7K2ogNeW/iJM7O43yvUQIyk9Wunci9i5FFT3rc2Nf5ls4zvZnfkC9
 uDxk1DE9CcGX9TYU9s2K9gV3Wn9w2lS6AIFEugbYGmuXparvVOd53+dznxNlqtSRQttL
 2uVB6OrnP9Z7JhKLUzRwTXfSDvcJG2fTFpFiFgWRsWQTPXAp8ENLa+8Hum1qOwFl53Ik
 JCWjxPSsAxFZ7eICZr8bvZ9fjqBklRA3w4ZX8qVK+W0LH5XbSKM74kMaLNBtWNCaSaE8
 RkbNsRtlzavUhB9uuJu3rtu2S9ooSHFz9VGaj6yjmDinYqH3NjLA9A7hln0CXoul48E9
 vROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114745; x=1738719545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rv/vufPtN4qZGgCEixmno+0BEOkC6dlLbTtJbkkFI6Y=;
 b=bhgUbQieAWaIoVKW0lRx98CMOrFeL+gsw/lyXujJIPOlGpOj1GlouBPXL+UZRUXBY2
 qMKIf3Jco6FsP7i2e3g6/xoVDnEkJ9+j3Y/3b+d9SD9OepDu30BqtPWb0DLALna9pZEK
 WV2b6UkeDM8b1KqGfXRqeEOivlij/zvg69k94pDFeYdBBBzQdvbDM5+0jtx4KAqVjR+i
 gOUvGN5HG83kqoJWydTVt76uHj655LksKcLDKCrdAehlE9K1LEARucW61PHIH7H8JX1P
 v/AIIpTUaNKb/gJrYlF1+9oFlZqS2gmU6VnBBqqqYYP3sM2n6PDNSnu3CaCGRQlNqbj0
 U+qQ==
X-Gm-Message-State: AOJu0YwXT7zhoB2qfQ06uiplKm2ii/Wf1q7NV1Kevyp1AHGA/e2olaMw
 nYWb0MRd8EvutYFWpg69MDtF9Abpl8/s9vlqG1LTbNV8ckFT/D3nwXChhpN1y67d6q88OyWN9l/
 j
X-Gm-Gg: ASbGnctQJctbVgds9/WxJbcBXdiUfQC4we9UVng+2upgnxc6Vb/lsA7OIusfSPahdVx
 xWb2Iz1XsFJEHDwJ08bEHFYoqKnaoTp8bVSAiY4Em+UcOSgD3V4QgPKTRK+hN/xSvjz1h53uJoR
 aiUF+c8Ubd6lpji9Xvxm3NzZRt2c23I9U4S+GTZ9XUL0uXFG0/KRKqyA1nk2D/9fcnGqnL03ZOl
 In2wRvwim/ehh1IaRKLNvOSw2TuSKjtyo+QpLhsX1VDaiRTCp65SqWYsnYbCrGeqP7zEwPgsYxY
 NPoxEYA1rxH1JOc9qXveLvj1UEW3hZmDzs+wakpUNevAa94OXg==
X-Google-Smtp-Source: AGHT+IGuwFsPlU0GBAX5OtIsKP6chaj0HAlhtF38KTXcOElk/8VMpq5dMlDRYtlPYojjGDsFhllq4A==
X-Received: by 2002:a17:902:ec92:b0:21d:cd0c:a1b8 with SMTP id
 d9443c01a7336-21dd7c3cf57mr20986515ad.1.1738114745235; 
 Tue, 28 Jan 2025 17:39:05 -0800 (PST)
Received: from stoup.. (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea4200sm89341745ad.88.2025.01.28.17.39.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 17:39:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 09/34] target/arm: Remove ah_fp_status_f16
Date: Tue, 28 Jan 2025 17:38:32 -0800
Message-ID: <20250129013857.135256-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129013857.135256-1-richard.henderson@linaro.org>
References: <20250129013857.135256-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Replace with fp_status[FPST_AH_F16].

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h        |  3 +--
 target/arm/cpu.c        |  2 +-
 target/arm/vfp_helper.c | 10 +++++-----
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 18afff8509..0f7d5d5430 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -237,7 +237,7 @@ typedef struct NVICState NVICState;
  * behaviour when FPCR.AH == 1: they don't update cumulative
  * exception flags, they act like FPCR.{FZ,FIZ} = {1,1} and
  * they ignore FPCR.RMode. But they don't ignore FPCR.FZ16,
- * which means we need an ah_fp_status_f16 as well.
+ * which means we need an FPST_AH_F16 as well.
  *
  * To avoid having to transfer exception bits around, we simply
  * say that the FPSCR cumulative exception flags are the logical
@@ -695,7 +695,6 @@ typedef struct CPUArchState {
                 float_status fp_status_f16_a32;
                 float_status fp_status_f16_a64;
                 float_status ah_fp_status;
-                float_status ah_fp_status_f16;
             };
         };
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 26e3465a4b..ffb2151de5 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -559,7 +559,7 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     arm_set_ah_fp_behaviours(&env->vfp.ah_fp_status);
     set_flush_to_zero(1, &env->vfp.ah_fp_status);
     set_flush_inputs_to_zero(1, &env->vfp.ah_fp_status);
-    arm_set_ah_fp_behaviours(&env->vfp.ah_fp_status_f16);
+    arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_AH_F16]);
 
 #ifndef CONFIG_USER_ONLY
     if (kvm_enabled()) {
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 93db713a40..d8dc58098b 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -129,7 +129,7 @@ static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
     a64_flags |= (get_float_exception_flags(&env->vfp.fp_status_f16_a64)
           & ~(float_flag_input_denormal_flushed | float_flag_input_denormal_used));
     /*
-     * We do not merge in flags from ah_fp_status or ah_fp_status_f16, because
+     * We do not merge in flags from ah_fp_status or FPST_AH_F16, because
      * they are used for insns that must not set the cumulative exception bits.
      */
 
@@ -160,7 +160,7 @@ static void vfp_clear_float_status_exc_flags(CPUARMState *env)
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD_F16]);
     set_float_exception_flags(0, &env->vfp.ah_fp_status);
-    set_float_exception_flags(0, &env->vfp.ah_fp_status_f16);
+    set_float_exception_flags(0, &env->vfp.fp_status[FPST_AH_F16]);
 }
 
 static void vfp_sync_and_clear_float_status_exc_flags(CPUARMState *env)
@@ -206,11 +206,11 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a32);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a64);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_STD_F16]);
-        set_flush_to_zero(ftz_enabled, &env->vfp.ah_fp_status_f16);
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_AH_F16]);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a32);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a64);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_STD_F16]);
-        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.ah_fp_status_f16);
+        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_AH_F16]);
     }
     if (changed & FPCR_FZ) {
         bool ftz_enabled = val & FPCR_FZ;
@@ -235,7 +235,7 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a32);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a64);
         set_default_nan_mode(dnan_enabled, &env->vfp.ah_fp_status);
-        set_default_nan_mode(dnan_enabled, &env->vfp.ah_fp_status_f16);
+        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_AH_F16]);
     }
     if (changed & FPCR_AH) {
         bool ah_enabled = val & FPCR_AH;
-- 
2.43.0


