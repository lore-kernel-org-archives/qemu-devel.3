Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27EC2C0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx2w-0000qr-0e; Tue, 28 Jan 2025 20:39:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2t-0000oR-8F
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:11 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2r-0003Vy-5U
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:10 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21670dce0a7so132276945ad.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738114747; x=1738719547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+sflSr/TdauAR3s9EgE90A0mkYRYsheBOwJCWqm7/4c=;
 b=VzPpIcZ223uPYSKJLB27jb1GsivFDNn6y4A/BmRLMa7rkZFmzuEmSbVecsn4jqodV2
 gQn1NDSUDB8o8wXI0cqyGQcKKKSXjeUbJNMMwGjBllRIaAOnlNaovVPWwtGZY0icwlur
 XgQuTeddr+nDZwFjHEnKik1MSeQGOBhLRZ1zyT8ItO78Bzqr32NdUs2ypBMlSNRluiHm
 xUijb+lClS84Lc6u9h/N8wMV1PdLc4J9lkqffVeluZ5JS9TrYNwkzRbR1blFggLZuuk7
 eu2m10oT8bvnmZDmga4nT3uS629U9SR125iFlnKuPRLBxNypRpl6jetwPp4y/eD7r4Hv
 XwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114747; x=1738719547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+sflSr/TdauAR3s9EgE90A0mkYRYsheBOwJCWqm7/4c=;
 b=SIAzvd1VRKX1Kd5MxvvJYLLzXbbka5ja33vLpOSRjBha2WAAFlFIlKo06BBh8ttRMi
 rg5fv1r9XedhGpap/sPUBOUFie6oepgkCfyR2aiL19JvGTYrKWA3AmrRCR1sC8qHKulB
 jV1UBhaefionDnaGcbzQhpvSsOTWcpV7L+raNMeUkp7q+J7BxDB/X7FTQrD4SG2WRCLs
 Si+YjcBpVfoayNuZFIWUZuSSyBgvaOFR6w31W1dQ6Z91+3M6axdU2BMjK1FPsGOHGTn+
 0GvcCRQQU1xi5xSblYT+ZltREG+kVl/EBGDzllYUKjCj+1wjBA8A21mq3V2f4SO3TIto
 /+lA==
X-Gm-Message-State: AOJu0YxO0FM0BVcRAbcb+AyuglPfdU41nD7DX7BPBssRcAkXc4gpG0Ku
 7ZzO1nTavUXqJaoh0rt4eplYLE1bUfb+i1CwFJ1aOFQQ0akfHgx8sx/nf4oEsZRToWdGL6sIS5n
 h
X-Gm-Gg: ASbGncvqHQGfwv2/USHGNM5BRIm+t6QDAcw+Nf3TTzymDK8joSnQAyRIlW6b4LxoCgG
 Ri6vwvml6bLYzpaIc7wm/5sT0OafpJ1OKsN87nGgrDFnLxqOt9VtoUoSny8Ew09rHVWvaDyFRiG
 8mmVqsVeAHlWmR7EkIa2WdY31xXlomwvTVGva6EwoCh/uFcbovRpIRALyXyQxTGrdSC9aPf3xdf
 spfB1Yr65W7fdojAjI/u8Aucd9gTcHT9+lDILEWm7Y0UXNxbwGhVVz2tFWgL3JD9K873Q+u07qu
 vMuEqbt2U8xC8GQ0/T8sy8KkjV2Ax0L5n4J7+Kz4yAf+OMZV6A==
X-Google-Smtp-Source: AGHT+IGGOjCQYrxwlWDfbCEdkONZ/FSi/xzp+LrGolD4VV3euDcIWHULzNnBOF8WbAROcwlyRa8yxA==
X-Received: by 2002:a17:902:7c93:b0:21b:bc95:e8d4 with SMTP id
 d9443c01a7336-21dd7dcb1e7mr18258585ad.35.1738114747393; 
 Tue, 28 Jan 2025 17:39:07 -0800 (PST)
Received: from stoup.. (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea4200sm89341745ad.88.2025.01.28.17.39.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 17:39:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 12/34] target/arm: Remove fp_status_f16_a32
Date: Tue, 28 Jan 2025 17:38:35 -0800
Message-ID: <20250129013857.135256-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129013857.135256-1-richard.henderson@linaro.org>
References: <20250129013857.135256-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Replace with fp_status[FPST_A32_F16].

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h            |  1 -
 target/arm/cpu.c            |  2 +-
 target/arm/tcg/vec_helper.c |  4 ++--
 target/arm/vfp_helper.c     | 14 +++++++-------
 4 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9e39c8d0d3..06dbee5725 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -692,7 +692,6 @@ typedef struct CPUArchState {
             struct {
                 float_status fp_status_a32;
                 float_status fp_status_a64;
-                float_status fp_status_f16_a32;
             };
         };
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 4fc1d00d60..ceb2dcb3fb 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -553,7 +553,7 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     arm_set_default_fp_behaviours(&env->vfp.fp_status_a32);
     arm_set_default_fp_behaviours(&env->vfp.fp_status_a64);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status_f16_a32);
+    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A32_F16]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64_F16]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD_F16]);
     arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_AH]);
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 927dece4c1..61f268efad 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2178,7 +2178,7 @@ void HELPER(gvec_fmlal_a32)(void *vd, void *vn, void *vm,
                             CPUARMState *env, uint32_t desc)
 {
     do_fmlal(vd, vn, vm, &env->vfp.fp_status[FPST_STD], desc,
-             get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a32));
+             get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A32_F16]));
 }
 
 void HELPER(gvec_fmlal_a64)(void *vd, void *vn, void *vm,
@@ -2240,7 +2240,7 @@ void HELPER(gvec_fmlal_idx_a32)(void *vd, void *vn, void *vm,
                                 CPUARMState *env, uint32_t desc)
 {
     do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status[FPST_STD], desc,
-                 get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a32));
+                 get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A32_F16]));
 }
 
 void HELPER(gvec_fmlal_idx_a64)(void *vd, void *vn, void *vm,
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index bcb05d7ff9..6a6eb48530 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -120,7 +120,7 @@ static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
     a32_flags |= get_float_exception_flags(&env->vfp.fp_status_a32);
     a32_flags |= get_float_exception_flags(&env->vfp.fp_status[FPST_STD]);
     /* FZ16 does not generate an input denormal exception.  */
-    a32_flags |= (get_float_exception_flags(&env->vfp.fp_status_f16_a32)
+    a32_flags |= (get_float_exception_flags(&env->vfp.fp_status[FPST_A32_F16])
           & ~float_flag_input_denormal_flushed);
     a32_flags |= (get_float_exception_flags(&env->vfp.fp_status[FPST_STD_F16])
           & ~float_flag_input_denormal_flushed);
@@ -155,7 +155,7 @@ static void vfp_clear_float_status_exc_flags(CPUARMState *env)
      */
     set_float_exception_flags(0, &env->vfp.fp_status_a32);
     set_float_exception_flags(0, &env->vfp.fp_status_a64);
-    set_float_exception_flags(0, &env->vfp.fp_status_f16_a32);
+    set_float_exception_flags(0, &env->vfp.fp_status[FPST_A32_F16]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_A64_F16]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD_F16]);
@@ -198,16 +198,16 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         }
         set_float_rounding_mode(i, &env->vfp.fp_status_a32);
         set_float_rounding_mode(i, &env->vfp.fp_status_a64);
-        set_float_rounding_mode(i, &env->vfp.fp_status_f16_a32);
+        set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A32_F16]);
         set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A64_F16]);
     }
     if (changed & FPCR_FZ16) {
         bool ftz_enabled = val & FPCR_FZ16;
-        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a32);
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A32_F16]);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A64_F16]);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_STD_F16]);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_AH_F16]);
-        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a32);
+        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A32_F16]);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A64_F16]);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_STD_F16]);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_AH_F16]);
@@ -232,7 +232,7 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         bool dnan_enabled = val & FPCR_DN;
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_a32);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_a64);
-        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a32);
+        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A32_F16]);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A64_F16]);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_AH]);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_AH_F16]);
@@ -494,7 +494,7 @@ void VFP_HELPER(cmpe, P)(ARGTYPE a, ARGTYPE b, CPUARMState *env) \
     softfloat_to_vfp_compare(env, \
         FLOATTYPE ## _compare(a, b, &env->vfp.FPST)); \
 }
-DO_VFP_cmp(h, float16, dh_ctype_f16, fp_status_f16_a32)
+DO_VFP_cmp(h, float16, dh_ctype_f16, fp_status[FPST_A32_F16])
 DO_VFP_cmp(s, float32, float32, fp_status_a32)
 DO_VFP_cmp(d, float64, float64, fp_status_a32)
 #undef DO_VFP_cmp
-- 
2.43.0


