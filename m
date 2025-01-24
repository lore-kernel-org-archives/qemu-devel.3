Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFCDC0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMYc-0004DW-Pl; Fri, 24 Jan 2025 11:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYH-0003nX-2Q
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:01 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYC-0005Oz-PH
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:00 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43635796b48so15503435e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736130; x=1738340930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QIlQY0ATcG2mPnShBCA6UPBVn+UDLQMzHJbHdp60Tp8=;
 b=Y+rJorE19Ea/GHXwuCpsOoPfPuYdC5qQ8MxVSKf39kwK+Kryf2ZAFXul4m2IPfxS/m
 /ldf2ZfQIx8tcwXJxbnPUbag3ZlWbHI/FpE8cTntJIWsZLlJmI1+vkfCNwNHqqxgjXxh
 oFixjWQ6gkdlSFBPQBriIKeWhUXeE0nDYfdEO5iws4M6vZYNSY/nrl3w/21MFjyyoIHH
 O+RlNaDx4Lbzk/M5AqFBS/mrUozCDXvWi3nvcBEgQwo1XcAPv5VF8L7Lc/slZyEqxok2
 ICczKE/QK1eP4S0KbNRHW6QGluIx8oB6fjodYv+b43AWxEQI06PDVgsSJqJfLFQkwyKC
 PLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736130; x=1738340930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QIlQY0ATcG2mPnShBCA6UPBVn+UDLQMzHJbHdp60Tp8=;
 b=X9kqUjX5UYlLHRzscXzpBsnSaTviouqCdZeMhu6DL+2BK0ww4kLHrwStpse6mumxUP
 viLp8c9xlplJwh4EZBKPVZWIL3UWbZMdjoTf7eVIz15xPM/Mk6OqdTvSQaZiZkkJQwU3
 rYv/Qe2ljgYLZjz7cy6Kw6vAnkGuH8mVO2E7T8uNaFXUUKzDQ1/w+wJNNKzGlrSh2z/T
 U3qdYKsMpazC2nFjj0dmmu/koZ2ivg+gVAG2wb9sQrbMC+Pnr0pxRzAhomCnLsSFKUA4
 ULDVxqBH+I9OIf+i4PXm9Wr8YEvUCEUwIBiYu3G2A1wR2c7GUax1satPqA8ThN+u1s8k
 UQyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQmMj9DIobP6s6yViBz0zcNZacB1+2+pSoBH7+RpbaXFoE7NJQ1Ja//7G00WPyp5j3zI37keZJA3DB@nongnu.org
X-Gm-Message-State: AOJu0Yx4Kf/3d0wnzzb9uVtvhDgsYu8qPkF+MgQOHEkUA+iEoqiV7ubr
 9zMnNKIidplndtgQsVZO0CW2vSQuVbOGz/x9+y/M+cLVhsVOoNN1NL3yZv+7tLhQE2K2MzSS1cl
 T
X-Gm-Gg: ASbGncs6ul4l18tnpHmiHkE5hhE5aPX3WrRdKUzqBaARzddaLq7ybvNpg/oDKV7c2kK
 hHqfYOQMAUzOquXAaHGNc92GE+dxPj7DrfMOn15WaTcVfERwVa6x8ORuLmPZXrSeE/D0MjKngMo
 zYOONcWD8WK+ePVBMoMfJZTdRGHf+rX/n7IRcHKcEOEd0AbCxAp1ouW7xIT2sInkF759BZyotfB
 ajcfXNCm0mVFZK9JnlRshyXWACAvIYT85pdiMlT6IDZ9QlaRQna/LA4yboybur+7eVF18Hjd4Dw
 01xNZuLjmCg=
X-Google-Smtp-Source: AGHT+IHz3jTI18IfaYNnJT9kpUsM2M/dFZJxBlByFHNH5BURB6SVa0lr9rPuORmx4OuqI+4xX2gXaw==
X-Received: by 2002:a05:600c:1e8e:b0:434:e65e:457b with SMTP id
 5b1f17b1804b1-438bd67f134mr35054145e9.3.1737736130314; 
 Fri, 24 Jan 2025 08:28:50 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:28:49 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 10/76] target/arm: Use FPST_FPCR_A32 in A32 decoder
Date: Fri, 24 Jan 2025 16:27:30 +0000
Message-Id: <20250124162836.2332150-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

In the A32 decoder, use FPST_FPCR_A32 rather than FPST_FPCR.  By
doing an automated conversion of the whole file we avoid possibly
using more than one fpst value in a set_rmode/op/restore_rmode
sequence.

Patch created with
  perl -p -i -e 's/FPST_FPCR(?!_)/FPST_FPCR_A32/g' target/arm/tcg/translate-vfp.c

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-vfp.c | 54 +++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index 3cbe9a7418d..e1b8243c5d9 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -462,7 +462,7 @@ static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
     if (sz == 1) {
         fpst = fpstatus_ptr(FPST_FPCR_F16);
     } else {
-        fpst = fpstatus_ptr(FPST_FPCR);
+        fpst = fpstatus_ptr(FPST_FPCR_A32);
     }
 
     tcg_rmode = gen_set_rmode(rounding, fpst);
@@ -529,7 +529,7 @@ static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
     if (sz == 1) {
         fpst = fpstatus_ptr(FPST_FPCR_F16);
     } else {
-        fpst = fpstatus_ptr(FPST_FPCR);
+        fpst = fpstatus_ptr(FPST_FPCR_A32);
     }
 
     tcg_shift = tcg_constant_i32(0);
@@ -1398,7 +1398,7 @@ static bool do_vfp_3op_sp(DisasContext *s, VFPGen3OpSPFn *fn,
     f0 = tcg_temp_new_i32();
     f1 = tcg_temp_new_i32();
     fd = tcg_temp_new_i32();
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_FPCR_A32);
 
     vfp_load_reg32(f0, vn);
     vfp_load_reg32(f1, vm);
@@ -1517,7 +1517,7 @@ static bool do_vfp_3op_dp(DisasContext *s, VFPGen3OpDPFn *fn,
     f0 = tcg_temp_new_i64();
     f1 = tcg_temp_new_i64();
     fd = tcg_temp_new_i64();
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_FPCR_A32);
 
     vfp_load_reg64(f0, vn);
     vfp_load_reg64(f1, vm);
@@ -2181,7 +2181,7 @@ static bool do_vfm_sp(DisasContext *s, arg_VFMA_sp *a, bool neg_n, bool neg_d)
         /* VFNMA, VFNMS */
         gen_vfp_negs(vd, vd);
     }
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_FPCR_A32);
     gen_helper_vfp_muladds(vd, vn, vm, vd, fpst);
     vfp_store_reg32(vd, a->vd);
     return true;
@@ -2246,7 +2246,7 @@ static bool do_vfm_dp(DisasContext *s, arg_VFMA_dp *a, bool neg_n, bool neg_d)
         /* VFNMA, VFNMS */
         gen_vfp_negd(vd, vd);
     }
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_FPCR_A32);
     gen_helper_vfp_muladdd(vd, vn, vm, vd, fpst);
     vfp_store_reg64(vd, a->vd);
     return true;
@@ -2429,12 +2429,12 @@ static void gen_VSQRT_hp(TCGv_i32 vd, TCGv_i32 vm)
 
 static void gen_VSQRT_sp(TCGv_i32 vd, TCGv_i32 vm)
 {
-    gen_helper_vfp_sqrts(vd, vm, fpstatus_ptr(FPST_FPCR));
+    gen_helper_vfp_sqrts(vd, vm, fpstatus_ptr(FPST_FPCR_A32));
 }
 
 static void gen_VSQRT_dp(TCGv_i64 vd, TCGv_i64 vm)
 {
-    gen_helper_vfp_sqrtd(vd, vm, fpstatus_ptr(FPST_FPCR));
+    gen_helper_vfp_sqrtd(vd, vm, fpstatus_ptr(FPST_FPCR_A32));
 }
 
 DO_VFP_2OP(VSQRT, hp, gen_VSQRT_hp, aa32_fp16_arith)
@@ -2565,7 +2565,7 @@ static bool trans_VCVT_f32_f16(DisasContext *s, arg_VCVT_f32_f16 *a)
         return true;
     }
 
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_FPCR_A32);
     ahp_mode = get_ahp_flag();
     tmp = tcg_temp_new_i32();
     /* The T bit tells us if we want the low or high 16 bits of Vm */
@@ -2599,7 +2599,7 @@ static bool trans_VCVT_f64_f16(DisasContext *s, arg_VCVT_f64_f16 *a)
         return true;
     }
 
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_FPCR_A32);
     ahp_mode = get_ahp_flag();
     tmp = tcg_temp_new_i32();
     /* The T bit tells us if we want the low or high 16 bits of Vm */
@@ -2623,7 +2623,7 @@ static bool trans_VCVT_b16_f32(DisasContext *s, arg_VCVT_b16_f32 *a)
         return true;
     }
 
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_FPCR_A32);
     tmp = tcg_temp_new_i32();
 
     vfp_load_reg32(tmp, a->vm);
@@ -2646,7 +2646,7 @@ static bool trans_VCVT_f16_f32(DisasContext *s, arg_VCVT_f16_f32 *a)
         return true;
     }
 
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_FPCR_A32);
     ahp_mode = get_ahp_flag();
     tmp = tcg_temp_new_i32();
 
@@ -2680,7 +2680,7 @@ static bool trans_VCVT_f16_f64(DisasContext *s, arg_VCVT_f16_f64 *a)
         return true;
     }
 
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_FPCR_A32);
     ahp_mode = get_ahp_flag();
     tmp = tcg_temp_new_i32();
     vm = tcg_temp_new_i64();
@@ -2727,7 +2727,7 @@ static bool trans_VRINTR_sp(DisasContext *s, arg_VRINTR_sp *a)
 
     tmp = tcg_temp_new_i32();
     vfp_load_reg32(tmp, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_FPCR_A32);
     gen_helper_rints(tmp, tmp, fpst);
     vfp_store_reg32(tmp, a->vd);
     return true;
@@ -2757,7 +2757,7 @@ static bool trans_VRINTR_dp(DisasContext *s, arg_VRINTR_dp *a)
 
     tmp = tcg_temp_new_i64();
     vfp_load_reg64(tmp, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_FPCR_A32);
     gen_helper_rintd(tmp, tmp, fpst);
     vfp_store_reg64(tmp, a->vd);
     return true;
@@ -2803,7 +2803,7 @@ static bool trans_VRINTZ_sp(DisasContext *s, arg_VRINTZ_sp *a)
 
     tmp = tcg_temp_new_i32();
     vfp_load_reg32(tmp, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_FPCR_A32);
     tcg_rmode = gen_set_rmode(FPROUNDING_ZERO, fpst);
     gen_helper_rints(tmp, tmp, fpst);
     gen_restore_rmode(tcg_rmode, fpst);
@@ -2836,7 +2836,7 @@ static bool trans_VRINTZ_dp(DisasContext *s, arg_VRINTZ_dp *a)
 
     tmp = tcg_temp_new_i64();
     vfp_load_reg64(tmp, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_FPCR_A32);
     tcg_rmode = gen_set_rmode(FPROUNDING_ZERO, fpst);
     gen_helper_rintd(tmp, tmp, fpst);
     gen_restore_rmode(tcg_rmode, fpst);
@@ -2880,7 +2880,7 @@ static bool trans_VRINTX_sp(DisasContext *s, arg_VRINTX_sp *a)
 
     tmp = tcg_temp_new_i32();
     vfp_load_reg32(tmp, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_FPCR_A32);
     gen_helper_rints_exact(tmp, tmp, fpst);
     vfp_store_reg32(tmp, a->vd);
     return true;
@@ -2910,7 +2910,7 @@ static bool trans_VRINTX_dp(DisasContext *s, arg_VRINTX_dp *a)
 
     tmp = tcg_temp_new_i64();
     vfp_load_reg64(tmp, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_FPCR_A32);
     gen_helper_rintd_exact(tmp, tmp, fpst);
     vfp_store_reg64(tmp, a->vd);
     return true;
@@ -2937,7 +2937,7 @@ static bool trans_VCVT_sp(DisasContext *s, arg_VCVT_sp *a)
     vm = tcg_temp_new_i32();
     vd = tcg_temp_new_i64();
     vfp_load_reg32(vm, a->vm);
-    gen_helper_vfp_fcvtds(vd, vm, fpstatus_ptr(FPST_FPCR));
+    gen_helper_vfp_fcvtds(vd, vm, fpstatus_ptr(FPST_FPCR_A32));
     vfp_store_reg64(vd, a->vd);
     return true;
 }
@@ -2963,7 +2963,7 @@ static bool trans_VCVT_dp(DisasContext *s, arg_VCVT_dp *a)
     vd = tcg_temp_new_i32();
     vm = tcg_temp_new_i64();
     vfp_load_reg64(vm, a->vm);
-    gen_helper_vfp_fcvtsd(vd, vm, fpstatus_ptr(FPST_FPCR));
+    gen_helper_vfp_fcvtsd(vd, vm, fpstatus_ptr(FPST_FPCR_A32));
     vfp_store_reg32(vd, a->vd);
     return true;
 }
@@ -3010,7 +3010,7 @@ static bool trans_VCVT_int_sp(DisasContext *s, arg_VCVT_int_sp *a)
 
     vm = tcg_temp_new_i32();
     vfp_load_reg32(vm, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_FPCR_A32);
     if (a->s) {
         /* i32 -> f32 */
         gen_helper_vfp_sitos(vm, vm, fpst);
@@ -3044,7 +3044,7 @@ static bool trans_VCVT_int_dp(DisasContext *s, arg_VCVT_int_dp *a)
     vm = tcg_temp_new_i32();
     vd = tcg_temp_new_i64();
     vfp_load_reg32(vm, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_FPCR_A32);
     if (a->s) {
         /* i32 -> f64 */
         gen_helper_vfp_sitod(vd, vm, fpst);
@@ -3161,7 +3161,7 @@ static bool trans_VCVT_fix_sp(DisasContext *s, arg_VCVT_fix_sp *a)
     vd = tcg_temp_new_i32();
     vfp_load_reg32(vd, a->vd);
 
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_FPCR_A32);
     shift = tcg_constant_i32(frac_bits);
 
     /* Switch on op:U:sx bits */
@@ -3223,7 +3223,7 @@ static bool trans_VCVT_fix_dp(DisasContext *s, arg_VCVT_fix_dp *a)
     vd = tcg_temp_new_i64();
     vfp_load_reg64(vd, a->vd);
 
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_FPCR_A32);
     shift = tcg_constant_i32(frac_bits);
 
     /* Switch on op:U:sx bits */
@@ -3307,7 +3307,7 @@ static bool trans_VCVT_sp_int(DisasContext *s, arg_VCVT_sp_int *a)
         return true;
     }
 
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_FPCR_A32);
     vm = tcg_temp_new_i32();
     vfp_load_reg32(vm, a->vm);
 
@@ -3347,7 +3347,7 @@ static bool trans_VCVT_dp_int(DisasContext *s, arg_VCVT_dp_int *a)
         return true;
     }
 
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_FPCR_A32);
     vm = tcg_temp_new_i64();
     vd = tcg_temp_new_i32();
     vfp_load_reg64(vm, a->vm);
-- 
2.34.1


