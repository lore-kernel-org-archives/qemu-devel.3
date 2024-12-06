Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE35E7716E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 03:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJOt4-0006OL-Dz; Thu, 05 Dec 2024 22:20:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJOsq-0006GR-I0
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 22:20:00 -0500
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJOso-0006BH-RA
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 22:20:00 -0500
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5f1e79c2f81so700430eaf.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 19:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733455197; x=1734059997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ibdd8VDkjFPzML8s48eYkRj1V2SiKDJHWaM9nlMLIEk=;
 b=CXzpLHE4G/1lrAVoOtQsNzUiDoAcvUeoM+7c1PcNgw9HIszFPAMxKLjqOTgqAvIaWa
 JRPv01SP3DSfrP4HZhaV8ns/nPuw4RHQPRKshyjmhKCIndWeBJ4xoj8qe72jvQKrvZqa
 v8l/EpKi3HUX49lOpmoSZE0puPlGN2uHfbHnfw/ESg3mkkqTyel6/kXxTNW03SXumDqZ
 7WdLBBjQE57LVzovZJF1M294cnWUG8ZDG3XwhDBOeuR/EN+2fvLkA4vvZO3Fo9AuKrYB
 6On6YDFPSzoftsY9JvuUwCdthHRVnmaen50zPelF4vhl6oCG4+fTfBfmHEegboc9pjDE
 85FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733455197; x=1734059997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ibdd8VDkjFPzML8s48eYkRj1V2SiKDJHWaM9nlMLIEk=;
 b=Zt+mfrj1vlNn0BsstExX0VkpWots9jf9T8TjgTekOYlposdDo4Bej0XyVfBMD10mzP
 Oq4MlCNCoufbZucoevEI2lGmmusgL28DdBsYlBfrLRc2qwNMu6RLHuLfbeT9aDS3aNGX
 BPWQlt+Xh7dZpeu4yB5fz8s/NtggGwWYBgCgbsBTPSdhr5jfwauPlqp965QKfMg93vQF
 r4fsT0bjeL9DD4qLLIKARe1sqm8TOVq05bl4v0ZqT0dOjpyJSQnNCj9lr4xurjTccc4b
 TU08rzdi6qRDcxB9khy6ZdLzwWDtoceKHf+OgDyhY8UPKqvaW/qS/LwkXbrZGdXC8/qv
 0bHw==
X-Gm-Message-State: AOJu0YzZoYT//sVIFedxKgb0waHrqPTX02ZbNtb8HvCdr44EvEGOhh01
 lmEKlZrQnaTfftLSfgffPismWanFotkXTOqLKJvJ1Aur/z6bHwWfTyWWOobtgcHMHcR7PwznvyW
 dqakpbWSp
X-Gm-Gg: ASbGnct7yXJ46GamfrA7o1CfnbtpQxK8uqcnGI0saQQaJFGy2w+it2RGTRJMlVS2LO7
 6mZI5RxJdm+LhxNkmsedGZqJPXe/s5hB5i/wsGKiFKsdfAqWNWrzvO0VVlo03WAsh0d6i4IJAGE
 aASxj1C9hOFAPSwZSGcpnKZ79FMZRFR2lYvue/lndg3xeGHK1+eERVHbF7gaauHBOyRGNhVvqon
 1v+44AgdJeGthE3o4xcZ5XV/YKUQrK1NzZ7pU6zMY66YVrnLvL/MhsvdE/D6eWJXg5cLioYXBgx
 j4rvcHxepNOyq6PNPcFQBBy6b7C6w93F6fIB
X-Google-Smtp-Source: AGHT+IElB311r2BIoQjE0Oi2gGnSQRM0+FXcaVvm+FoRDaS2THuPPNFo2tjEZhMWn4j37ChjJz8OqA==
X-Received: by 2002:a05:6830:2aa5:b0:71d:5604:2084 with SMTP id
 46e09a7af769-71dcf4bead8mr857427a34.5.1733455197709; 
 Thu, 05 Dec 2024 19:19:57 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f2793255bbsm541045eaf.40.2024.12.05.19.19.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 19:19:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 2/2] target/arm: Use float_status in helper_vfp_fcvt{ds,sd}
Date: Thu,  5 Dec 2024 21:19:52 -0600
Message-ID: <20241206031952.78776-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206031952.78776-1-richard.henderson@linaro.org>
References: <20241206031952.78776-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
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

Pass float_status not env to match other functions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h            |  4 ++--
 target/arm/tcg/translate-a64.c | 15 ++++++++++-----
 target/arm/tcg/translate-vfp.c |  4 ++--
 target/arm/vfp_helper.c        |  8 ++++----
 4 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index d4c8ff40a1..6abab5da99 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -147,8 +147,8 @@ DEF_HELPER_3(vfp_cmpeh, void, f16, f16, env)
 DEF_HELPER_3(vfp_cmpes, void, f32, f32, env)
 DEF_HELPER_3(vfp_cmped, void, f64, f64, env)
 
-DEF_HELPER_2(vfp_fcvtds, f64, f32, env)
-DEF_HELPER_2(vfp_fcvtsd, f32, f64, env)
+DEF_HELPER_2(vfp_fcvtds, f64, f32, fpst)
+DEF_HELPER_2(vfp_fcvtsd, f32, f64, fpst)
 DEF_HELPER_FLAGS_2(bfcvt, TCG_CALL_NO_RWG, i32, f32, fpst)
 DEF_HELPER_FLAGS_2(bfcvt_pair, TCG_CALL_NO_RWG, i32, i64, fpst)
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 6286e4fda3..f0d5ce123e 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8502,8 +8502,9 @@ static bool trans_FCVT_s_ds(DisasContext *s, arg_rr *a)
     if (fp_access_check(s)) {
         TCGv_i32 tcg_rn = read_fp_sreg(s, a->rn);
         TCGv_i64 tcg_rd = tcg_temp_new_i64();
+        TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
 
-        gen_helper_vfp_fcvtds(tcg_rd, tcg_rn, tcg_env);
+        gen_helper_vfp_fcvtds(tcg_rd, tcg_rn, fpst);
         write_fp_dreg(s, a->rd, tcg_rd);
     }
     return true;
@@ -8528,8 +8529,9 @@ static bool trans_FCVT_s_sd(DisasContext *s, arg_rr *a)
     if (fp_access_check(s)) {
         TCGv_i64 tcg_rn = read_fp_dreg(s, a->rn);
         TCGv_i32 tcg_rd = tcg_temp_new_i32();
+        TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
 
-        gen_helper_vfp_fcvtsd(tcg_rd, tcg_rn, tcg_env);
+        gen_helper_vfp_fcvtsd(tcg_rd, tcg_rn, fpst);
         write_fp_sreg(s, a->rd, tcg_rd);
     }
     return true;
@@ -9208,7 +9210,9 @@ static void gen_fcvtn_hs(TCGv_i64 d, TCGv_i64 n)
 static void gen_fcvtn_sd(TCGv_i64 d, TCGv_i64 n)
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
-    gen_helper_vfp_fcvtsd(tmp, n, tcg_env);
+    TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
+
+    gen_helper_vfp_fcvtsd(tmp, n, fpst);
     tcg_gen_extu_i32_i64(d, tmp);
 }
 
@@ -9498,11 +9502,13 @@ static bool trans_FCVTL_v(DisasContext *s, arg_qrr_e *a)
      * The only instruction like this is FCVTL.
      */
     int pass;
+    TCGv_ptr fpst;
 
     if (!fp_access_check(s)) {
         return true;
     }
 
+    fpst = fpstatus_ptr(FPST_FPCR);
     if (a->esz == MO_64) {
         /* 32 -> 64 bit fp conversion */
         TCGv_i64 tcg_res[2];
@@ -9512,7 +9518,7 @@ static bool trans_FCVTL_v(DisasContext *s, arg_qrr_e *a)
         for (pass = 0; pass < 2; pass++) {
             tcg_res[pass] = tcg_temp_new_i64();
             read_vec_element_i32(s, tcg_op, a->rn, srcelt + pass, MO_32);
-            gen_helper_vfp_fcvtds(tcg_res[pass], tcg_op, tcg_env);
+            gen_helper_vfp_fcvtds(tcg_res[pass], tcg_op, fpst);
         }
         for (pass = 0; pass < 2; pass++) {
             write_vec_element(s, tcg_res[pass], a->rd, pass, MO_64);
@@ -9521,7 +9527,6 @@ static bool trans_FCVTL_v(DisasContext *s, arg_qrr_e *a)
         /* 16 -> 32 bit fp conversion */
         int srcelt = a->q ? 4 : 0;
         TCGv_i32 tcg_res[4];
-        TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
         TCGv_i32 ahp = get_ahp_flag();
 
         for (pass = 0; pass < 4; pass++) {
diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index c160a86e70..3cbe9a7418 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -2937,7 +2937,7 @@ static bool trans_VCVT_sp(DisasContext *s, arg_VCVT_sp *a)
     vm = tcg_temp_new_i32();
     vd = tcg_temp_new_i64();
     vfp_load_reg32(vm, a->vm);
-    gen_helper_vfp_fcvtds(vd, vm, tcg_env);
+    gen_helper_vfp_fcvtds(vd, vm, fpstatus_ptr(FPST_FPCR));
     vfp_store_reg64(vd, a->vd);
     return true;
 }
@@ -2963,7 +2963,7 @@ static bool trans_VCVT_dp(DisasContext *s, arg_VCVT_dp *a)
     vd = tcg_temp_new_i32();
     vm = tcg_temp_new_i64();
     vfp_load_reg64(vm, a->vm);
-    gen_helper_vfp_fcvtsd(vd, vm, tcg_env);
+    gen_helper_vfp_fcvtsd(vd, vm, fpstatus_ptr(FPST_FPCR));
     vfp_store_reg32(vd, a->vd);
     return true;
 }
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 26a52852fc..40c13f3685 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -400,14 +400,14 @@ FLOAT_CONVS(ui, d, float64, 64, u)
 #undef FLOAT_CONVS
 
 /* floating point conversion */
-float64 VFP_HELPER(fcvtd, s)(float32 x, CPUARMState *env)
+float64 VFP_HELPER(fcvtd, s)(float32 x, float_status *status)
 {
-    return float32_to_float64(x, &env->vfp.fp_status);
+    return float32_to_float64(x, status);
 }
 
-float32 VFP_HELPER(fcvts, d)(float64 x, CPUARMState *env)
+float32 VFP_HELPER(fcvts, d)(float64 x, float_status *status)
 {
-    return float64_to_float32(x, &env->vfp.fp_status);
+    return float64_to_float32(x, status);
 }
 
 uint32_t HELPER(bfcvt)(float32 x, float_status *status)
-- 
2.43.0


