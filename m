Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010CDE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 17:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNbEw-0007z7-Ol; Tue, 17 Dec 2024 12:20:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEs-0007y9-GV
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:20:06 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEg-0006Cx-Ej
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:20:06 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-385e06af753so2924998f8f.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 09:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734455991; x=1735060791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kSHkonPMo/xeP7+hFx6JjMhGHF4bAjMCndaPu3X0s8E=;
 b=x19Fykt9zxGuWGwsEElIbF6eWsPW2hvvggP16q91PbzoD7QOAKavbJv8mfmtIGQUWT
 +NV5mxzsrRrcs7tqUeVn7vKkksNPvr3GilIfeS3ojQRJ/kuRAeXq/bVrSim5GeWu9m3U
 aeEP9QZDjz5aSjgKqgKYwIiGY00LJHch1jUCEvIIi11K2y5Ms6fJkRaD1ZmlYuQy0aXI
 YKCabd4SBoCsuJGB8wBZ3M1ugc10x/WnX9Jvk6ezbpGe5hZnrDdveDDKkdeiGoobXErp
 XSWPHHc6eWq9JmG6TlR58vePQydGN2aic/8GSGmTmzPrKG+haUI293U7+ERbrGoCWWmx
 0IwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734455991; x=1735060791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kSHkonPMo/xeP7+hFx6JjMhGHF4bAjMCndaPu3X0s8E=;
 b=SsEU7LGxVXWMf99wesqA9pSe8Yd35L3Arf765JOQVhgOCaT+mSouX5DTaXybGJXCsW
 0ihMIX3BfCWHRReB3hk2rCZSik0qaWdW302gKntx6bYZOF1N99VGN6glkJ/YGd5QdyfT
 /jFcE1tIQG4A+4ZGTlzGZdzADgthi34l4CuB1W9cgpu8dni2cxGxlpoZKFO82U4J3mtC
 KJq8ymMKc2qnHAb74VJZG/nwNQZwp2e1yRXz1hWPXfOdlMGU1PmIs5g1+9dDJQWVAgLZ
 FNoksqqYQED2qI8/wr2pDOUFeNEK6DdGNzYxusZCw0befexR89nbGVQx2DCZzWpj/S9j
 LMNQ==
X-Gm-Message-State: AOJu0YyvxT7TWprFSvE6grWr0LdQvpFdo4Ngr15qzWpQQaaELfEgesWR
 q282QnwOn2hpxogucdwHoLiuN7IG/tC+x2nqrBIt3vuD/j7VHnbQTJjdFzy7+0OgeXMJ2VaYNpc
 /
X-Gm-Gg: ASbGncuzibSI6FCP0MN7jOpO0QTCWGBmGELHXcqhfxNIrLiV9QeVsIlx/M4VPHaaaUv
 G0Z9culfx6x/hI1yJQl65AnYJnch0MBneWeU7mfJNFLsomykWqBFjGNxN4lhXinFFE8UNTgazIb
 ZHYJdtINAf8x0f91VGvD5QT9Ag8xptXd+8icNk52s8JodooGkz49UlJ4dATgMGgfdCu8SeY2r5r
 NFjgq3J+kH9m98ub9LSgsR1XBuxwlg/jFGoXPH/Vs8vHe9YTi0qpoumSNbi2YU=
X-Google-Smtp-Source: AGHT+IGgPum3ZPeYTXVwsCbIv8oR7loYTmr+yOFIS2VwApJr6bjUOq+Eo2l/zofJU4+4sSgzV7RS8A==
X-Received: by 2002:a05:6000:186c:b0:385:e105:d884 with SMTP id
 ffacd0b85a97d-388e4664e22mr31029f8f.46.1734455991119; 
 Tue, 17 Dec 2024 09:19:51 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8016389sm11569728f8f.32.2024.12.17.09.19.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 09:19:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/19] target/arm: Use float_status in helper_vfp_fcvt{ds,sd}
Date: Tue, 17 Dec 2024 17:19:29 +0000
Message-Id: <20241217171937.3899947-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217171937.3899947-1-peter.maydell@linaro.org>
References: <20241217171937.3899947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Pass float_status not env to match other functions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20241206031952.78776-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h            |  4 ++--
 target/arm/tcg/translate-a64.c | 15 ++++++++++-----
 target/arm/tcg/translate-vfp.c |  4 ++--
 target/arm/vfp_helper.c        |  8 ++++----
 4 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 707a8daabb0..15bad0773c0 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -143,8 +143,8 @@ DEF_HELPER_3(vfp_cmpeh, void, f16, f16, env)
 DEF_HELPER_3(vfp_cmpes, void, f32, f32, env)
 DEF_HELPER_3(vfp_cmped, void, f64, f64, env)
 
-DEF_HELPER_2(vfp_fcvtds, f64, f32, env)
-DEF_HELPER_2(vfp_fcvtsd, f32, f64, env)
+DEF_HELPER_2(vfp_fcvtds, f64, f32, fpst)
+DEF_HELPER_2(vfp_fcvtsd, f32, f64, fpst)
 DEF_HELPER_FLAGS_2(bfcvt, TCG_CALL_NO_RWG, i32, f32, fpst)
 DEF_HELPER_FLAGS_2(bfcvt_pair, TCG_CALL_NO_RWG, i32, i64, fpst)
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index fda1176b3f4..ecbc46ba55f 100644
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
 
@@ -9490,11 +9494,13 @@ static bool trans_FCVTL_v(DisasContext *s, arg_qrr_e *a)
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
@@ -9504,7 +9510,7 @@ static bool trans_FCVTL_v(DisasContext *s, arg_qrr_e *a)
         for (pass = 0; pass < 2; pass++) {
             tcg_res[pass] = tcg_temp_new_i64();
             read_vec_element_i32(s, tcg_op, a->rn, srcelt + pass, MO_32);
-            gen_helper_vfp_fcvtds(tcg_res[pass], tcg_op, tcg_env);
+            gen_helper_vfp_fcvtds(tcg_res[pass], tcg_op, fpst);
         }
         for (pass = 0; pass < 2; pass++) {
             write_vec_element(s, tcg_res[pass], a->rd, pass, MO_64);
@@ -9513,7 +9519,6 @@ static bool trans_FCVTL_v(DisasContext *s, arg_qrr_e *a)
         /* 16 -> 32 bit fp conversion */
         int srcelt = a->q ? 4 : 0;
         TCGv_i32 tcg_res[4];
-        TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
         TCGv_i32 ahp = get_ahp_flag();
 
         for (pass = 0; pass < 4; pass++) {
diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index c160a86e703..3cbe9a7418d 100644
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
index 8a56936751b..fc20a567530 100644
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
2.34.1


