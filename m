Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA1BE77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2xa-0004Ve-7p; Tue, 10 Dec 2024 11:19:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2xJ-0003Ft-Ia
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:19:25 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2xH-0006VE-Kp
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:19:25 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-53ffaaeeb76so3063501e87.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847562; x=1734452362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N1zXLXupdpoNpc9DfQSmYSFNMct53t/YHwICpvsaTEU=;
 b=mZpsuu2J1gQLgEskcJVYIE1EtR/TvcLPHhlQ10LJlaqFONViw4R1mf72LGuAlIH1ab
 i90zgBj9o2U7zRMqphpZoIiirVm2OHv8T7n0INJBN5WVQP9S/AAHi+9NhkzeBRhD9YR/
 dvIP9VwdlGl/fN3caZCj9owK6PouUBmP8Tq5p/1E5ggAETarKIU5p59dYz+ky7jP3Oaf
 5lbW2551SV4QfGEl4fH+8fldVpvHKkbdNCRcYFiLIMjlchZQQ+/HT1DTlD/KlQw9sK5g
 bn5i0c8YEYCYak1GLOq8rA450WbwRymh1VUJujOEQYMgX3TAk7ikGvA8ZPp9US39cA15
 jZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847562; x=1734452362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N1zXLXupdpoNpc9DfQSmYSFNMct53t/YHwICpvsaTEU=;
 b=LG6SxmBnS1Jw/UfciCwKkqD7KuN2+DH/BHUPaanPJt1czkHGJl9Azrt3Io+pnP2TuP
 8+Hw7GSR0LwokZEu+YEBYECXTvTc5qRhAo2YZmFzQ5tScC73c39EUmEKiJjiSDKwN0ze
 ROXtgy27yY2PTkOdLcCcDts0nVKbAD9Kc8ZpJKU1UucPYILE0B1iX6c93DB85RPQEjbd
 ljkA1Y2kOCC5JM+NAoiUG1hin/9npUvzTnpMlZsviuckiiSDXYyJLqZVB37EJVWBR4xN
 Nh3gtmvzWs3rAjmXkbGHmU6lKFLumifgTvbmFkkYxBkWtQ8F4vnMRFQRsNp8J1qonH3/
 C5pA==
X-Gm-Message-State: AOJu0YxydgsJ4EMZXKWwslYgDPFd+HfyDEYzF5rR+kaFd/xUIVHiCtVk
 gc7tdhwQz6EbJoLGvFaQVsrYun9tNitrVvhG+wv/LEmogSZO2DQnO96GGOWRNpLSeHzZEC7yEBM
 aasjiCFfj
X-Gm-Gg: ASbGncsPGNV4lELBTFQennP1lzscrdfpVWeuv65Xk17DnmIPO3X0TQBPyaUA/0qNn9C
 XLaz19Jk+tU8RghDAuuR1L5w94UF/7gwMxZQLm7uvTjP//oYUljIRJ3BbRw3TYaBvBWjRq4WgD4
 A5GqhHimpqvYonQNIraToG0M7IlMAMVBsoS0DNXfOkFDwmzPDKirPG6e7tXgwxBCEUU7n0Ihw5e
 98EENw8WpPTi+VS5WDqvOocrON1TIbpohX9HwMwYHuUGTwA7kbZt7gCIj0=
X-Google-Smtp-Source: AGHT+IEGX3SlBwBVOcK4axXcYxdGLLIgxEoP1uuz2wWHZmvYfycqnGLkRFIHuaEr1VYgT4huUw6Tlw==
X-Received: by 2002:a05:6512:3d21:b0:540:1d2b:c47f with SMTP id
 2adb3069b0e04-5401d2bc4e4mr3481034e87.49.1733847561954; 
 Tue, 10 Dec 2024 08:19:21 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53f93377eefsm1026343e87.67.2024.12.10.08.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:19:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 25/69] target/arm: Pass fpstatus to vfp_sqrt*
Date: Tue, 10 Dec 2024 10:16:49 -0600
Message-ID: <20241210161733.1830573-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12d.google.com
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

Pass fpstatus not env, like most other fp helpers.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h            |  6 +++---
 target/arm/tcg/translate-a64.c | 15 +++++++--------
 target/arm/tcg/translate-vfp.c |  6 +++---
 target/arm/vfp_helper.c        | 12 ++++++------
 4 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 58919b670e..0a697e752b 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -133,9 +133,9 @@ DEF_HELPER_3(vfp_maxnumd, f64, f64, f64, ptr)
 DEF_HELPER_3(vfp_minnumh, f16, f16, f16, ptr)
 DEF_HELPER_3(vfp_minnums, f32, f32, f32, ptr)
 DEF_HELPER_3(vfp_minnumd, f64, f64, f64, ptr)
-DEF_HELPER_2(vfp_sqrth, f16, f16, env)
-DEF_HELPER_2(vfp_sqrts, f32, f32, env)
-DEF_HELPER_2(vfp_sqrtd, f64, f64, env)
+DEF_HELPER_2(vfp_sqrth, f16, f16, ptr)
+DEF_HELPER_2(vfp_sqrts, f32, f32, ptr)
+DEF_HELPER_2(vfp_sqrtd, f64, f64, ptr)
 DEF_HELPER_3(vfp_cmph, void, f16, f16, env)
 DEF_HELPER_3(vfp_cmps, void, f32, f32, env)
 DEF_HELPER_3(vfp_cmpd, void, f64, f64, env)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 383ee7f3f0..e278c0d87b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8401,8 +8401,8 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
 
     switch (opcode) {
     case 0x3: /* FSQRT */
-        gen_helper_vfp_sqrts(tcg_res, tcg_op, tcg_env);
-        goto done;
+        gen_fpst = gen_helper_vfp_sqrts;
+        break;
     case 0x6: /* BFCVT */
         gen_fpst = gen_helper_bfcvt;
         break;
@@ -8450,7 +8450,6 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
         gen_fpst(tcg_res, tcg_op, fpst);
     }
 
- done:
     write_fp_sreg(s, rd, tcg_res);
 }
 
@@ -8467,8 +8466,8 @@ static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
 
     switch (opcode) {
     case 0x3: /* FSQRT */
-        gen_helper_vfp_sqrtd(tcg_res, tcg_op, tcg_env);
-        goto done;
+        gen_fpst = gen_helper_vfp_sqrtd;
+        break;
     case 0x8: /* FRINTN */
     case 0x9: /* FRINTP */
     case 0xa: /* FRINTM */
@@ -8513,7 +8512,6 @@ static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
         gen_fpst(tcg_res, tcg_op, fpst);
     }
 
- done:
     write_fp_dreg(s, rd, tcg_res);
 }
 
@@ -9459,7 +9457,7 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
         gen_vfp_negd(tcg_rd, tcg_rn);
         break;
     case 0x7f: /* FSQRT */
-        gen_helper_vfp_sqrtd(tcg_rd, tcg_rn, tcg_env);
+        gen_helper_vfp_sqrtd(tcg_rd, tcg_rn, tcg_fpstatus);
         break;
     case 0x1a: /* FCVTNS */
     case 0x1b: /* FCVTMS */
@@ -10402,6 +10400,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
             handle_2misc_fcmp_zero(s, opcode, false, u, is_q, size, rn, rd);
             return;
         case 0x7f: /* FSQRT */
+            need_fpstatus = true;
             if (size == 3 && !is_q) {
                 unallocated_encoding(s);
                 return;
@@ -10631,7 +10630,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                     gen_vfp_negs(tcg_res, tcg_op);
                     break;
                 case 0x7f: /* FSQRT */
-                    gen_helper_vfp_sqrts(tcg_res, tcg_op, tcg_env);
+                    gen_helper_vfp_sqrts(tcg_res, tcg_op, tcg_fpstatus);
                     break;
                 case 0x1a: /* FCVTNS */
                 case 0x1b: /* FCVTMS */
diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index b6fa28a7bf..c160a86e70 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -2424,17 +2424,17 @@ DO_VFP_2OP(VNEG, dp, gen_vfp_negd, aa32_fpdp_v2)
 
 static void gen_VSQRT_hp(TCGv_i32 vd, TCGv_i32 vm)
 {
-    gen_helper_vfp_sqrth(vd, vm, tcg_env);
+    gen_helper_vfp_sqrth(vd, vm, fpstatus_ptr(FPST_FPCR_F16));
 }
 
 static void gen_VSQRT_sp(TCGv_i32 vd, TCGv_i32 vm)
 {
-    gen_helper_vfp_sqrts(vd, vm, tcg_env);
+    gen_helper_vfp_sqrts(vd, vm, fpstatus_ptr(FPST_FPCR));
 }
 
 static void gen_VSQRT_dp(TCGv_i64 vd, TCGv_i64 vm)
 {
-    gen_helper_vfp_sqrtd(vd, vm, tcg_env);
+    gen_helper_vfp_sqrtd(vd, vm, fpstatus_ptr(FPST_FPCR));
 }
 
 DO_VFP_2OP(VSQRT, hp, gen_VSQRT_hp, aa32_fp16_arith)
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 62638d2b1f..f24992c798 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -314,19 +314,19 @@ VFP_BINOP(minnum)
 VFP_BINOP(maxnum)
 #undef VFP_BINOP
 
-dh_ctype_f16 VFP_HELPER(sqrt, h)(dh_ctype_f16 a, CPUARMState *env)
+dh_ctype_f16 VFP_HELPER(sqrt, h)(dh_ctype_f16 a, void *fpstp)
 {
-    return float16_sqrt(a, &env->vfp.fp_status_f16);
+    return float16_sqrt(a, fpstp);
 }
 
-float32 VFP_HELPER(sqrt, s)(float32 a, CPUARMState *env)
+float32 VFP_HELPER(sqrt, s)(float32 a, void *fpstp)
 {
-    return float32_sqrt(a, &env->vfp.fp_status);
+    return float32_sqrt(a, fpstp);
 }
 
-float64 VFP_HELPER(sqrt, d)(float64 a, CPUARMState *env)
+float64 VFP_HELPER(sqrt, d)(float64 a, void *fpstp)
 {
-    return float64_sqrt(a, &env->vfp.fp_status);
+    return float64_sqrt(a, fpstp);
 }
 
 static void softfloat_to_vfp_compare(CPUARMState *env, FloatRelation cmp)
-- 
2.43.0


