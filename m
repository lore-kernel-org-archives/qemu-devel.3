Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97CCC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 14:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZWiI-0004ko-JT; Thu, 01 Aug 2024 10:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZWiH-0004hn-Ru
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 10:23:29 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZWiF-0002eI-C6
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 10:23:29 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-428243f928fso35057655e9.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 07:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722522206; x=1723127006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z0Rcx78XVil5biE/RI1myOYEZI1VSLw6RG7NHHvURqE=;
 b=LLi6/PqJ/qf0nTxA32ZhGZAya06+F94xeT+AfYudrDyCk+I9XVbn1EOTKoDngvg0e9
 d+fxT5CdYn/5rUK7gls1I3LZMkEAYBRol0VkeX423yb4abEQgngJytyPiNdEwWDlmJIO
 cW/dX87G4YqUjrCRkQ+HLjm7ZV3ErshEFSGm9NyE1CpElhlU+WtS9M9rc7CIoaaaMsPE
 m8guJRN5En/VzDfDccWqxlMVhAXDBOek2B9+WHkluw0gnfeBB967dcPwLEKETiKPaG2S
 RUhT3d43sWqzhXYRDYndFgsoCv82Qocint+Nv3kqDzc1Kpdx1hnotdJckcLQ4ZI4gD+t
 K+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722522206; x=1723127006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z0Rcx78XVil5biE/RI1myOYEZI1VSLw6RG7NHHvURqE=;
 b=mCqSfdBRBl4UBSe0jbSeOq7d1pDYZeMI2vsW+XJbzzA6hWB45kr2lJL33wJ6ofogGv
 eY31jgI8vPTR+YvQzCizC/NkI696mwfQzNLXqIlxgQV7dn2g1ROFKVK+5cymvV3xKMG+
 IYRfgesHZsWt2IBvHUac0KG6Bp/xMnnhwcNJG2BLRoporGoAylLihTDkWjwo1fblJHcV
 Nh378EimIXNnfCk1f93gOJD3Zdt5HMUg0EVKfZS7YBK/Fdh7/MLKMrSBG8DY7W2uIPO2
 vp4Z+znpak/7+H4UceQNcQujNXvTDQIAUm4eD48N38XPm6GgPB9SEwlU9pGEpiZjGpjh
 l3Yw==
X-Gm-Message-State: AOJu0YwlU72fPPFZi+n274SlEfQopTKCsTVNkynuNoLYZyFLecvSIBqF
 O+SWrshhAymjEBLQDU+zOSlBNS6eCNNU/LNwp1jNca0bxsUAUj5jIl4xv9+1rMmp/WRZcAqRXLP
 h
X-Google-Smtp-Source: AGHT+IFIomiJV9BHIOyA0hIlgZjzPLbP2eJu3c4lTlUKXqDmg7vRtbdTvHuTKKHyzPZuCPQZDPiilA==
X-Received: by 2002:a05:600c:19d4:b0:426:690d:d5b7 with SMTP id
 5b1f17b1804b1-428e6b7e95fmr153595e9.25.1722522205659; 
 Thu, 01 Aug 2024 07:23:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e08012d7sm29657435e9.22.2024.08.01.07.23.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 07:23:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/4] target/arm: Handle denormals correctly for FMOPA (widening)
Date: Thu,  1 Aug 2024 15:23:21 +0100
Message-Id: <20240801142322.3948866-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240801142322.3948866-1-peter.maydell@linaro.org>
References: <20240801142322.3948866-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

The FMOPA (widening) SME instruction takes pairs of half-precision
floating point values, widens them to single-precision, does a
two-way dot product and accumulates the results into a
single-precision destination.  We don't quite correctly handle the
FPCR bits FZ and FZ16 which control flushing of denormal inputs and
outputs.  This is because at the moment we pass a single float_status
value to the helper function, which then uses that configuration for
all the fp operations it does.  However, because the inputs to this
operation are float16 and the outputs are float32 we need to use the
fp_status_f16 for the float16 input widening but the normal fp_status
for everything else.  Otherwise we will apply the flushing control
FPCR.FZ16 to the 32-bit output rather than the FPCR.FZ control, and
incorrectly flush a denormal output to zero when we should not (or
vice-versa).

(In commit 207d30b5fdb5b we tried to fix the FZ handling but
didn't get it right, switching from "use FPCR.FZ for everything" to
"use FPCR.FZ16 for everything".)

Pass the CPU env to the sme_fmopa_h helper instead of an fp_status
pointer, and have the helper pass an extra fp_status into the
f16_dotadd() function so that we can use the right status for the
right parts of this operation.

Cc: qemu-stable@nongnu.org
Fixes: 207d30b5fdb5 ("target/arm: Use FPST_F16 for SME FMOPA (widening)")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2373
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme.h    |  2 +-
 target/arm/tcg/sme_helper.c    | 39 +++++++++++++++++++++++-----------
 target/arm/tcg/translate-sme.c | 25 ++++++++++++++++++++--
 3 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 27eef49a11e..d22bf9d21b0 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -121,7 +121,7 @@ DEF_HELPER_FLAGS_5(sme_addha_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sme_addva_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_7(sme_fmopa_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_7(sme_fmopa_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_7(sme_fmopa_d, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 3ba826a6ceb..02106809ce1 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -992,12 +992,23 @@ static inline uint32_t f16mop_adj_pair(uint32_t pair, uint32_t pg, uint32_t neg)
 }
 
 static float32 f16_dotadd(float32 sum, uint32_t e1, uint32_t e2,
-                          float_status *s_std, float_status *s_odd)
+                          float_status *s_f16, float_status *s_std,
+                          float_status *s_odd)
 {
-    float64 e1r = float16_to_float64(e1 & 0xffff, true, s_std);
-    float64 e1c = float16_to_float64(e1 >> 16, true, s_std);
-    float64 e2r = float16_to_float64(e2 & 0xffff, true, s_std);
-    float64 e2c = float16_to_float64(e2 >> 16, true, s_std);
+    /*
+     * We need three different float_status for different parts of this
+     * operation:
+     *  - the input conversion of the float16 values must use the
+     *    f16-specific float_status, so that the FPCR.FZ16 control is applied
+     *  - operations on float32 including the final accumulation must use
+     *    the normal float_status, so that FPCR.FZ is applied
+     *  - we have pre-set-up copy of s_std which is set to round-to-odd,
+     *    for the multiply (see below)
+     */
+    float64 e1r = float16_to_float64(e1 & 0xffff, true, s_f16);
+    float64 e1c = float16_to_float64(e1 >> 16, true, s_f16);
+    float64 e2r = float16_to_float64(e2 & 0xffff, true, s_f16);
+    float64 e2c = float16_to_float64(e2 >> 16, true, s_f16);
     float64 t64;
     float32 t32;
 
@@ -1019,20 +1030,23 @@ static float32 f16_dotadd(float32 sum, uint32_t e1, uint32_t e2,
 }
 
 void HELPER(sme_fmopa_h)(void *vza, void *vzn, void *vzm, void *vpn,
-                         void *vpm, void *vst, uint32_t desc)
+                         void *vpm, CPUARMState *env, uint32_t desc)
 {
     intptr_t row, col, oprsz = simd_maxsz(desc);
     uint32_t neg = simd_data(desc) * 0x80008000u;
     uint16_t *pn = vpn, *pm = vpm;
-    float_status fpst_odd, fpst_std;
+    float_status fpst_odd, fpst_std, fpst_f16;
 
     /*
-     * Make a copy of float_status because this operation does not
-     * update the cumulative fp exception status.  It also produces
-     * default nans.  Make a second copy with round-to-odd -- see above.
+     * Make copies of fp_status and fp_status_f16, because this operation
+     * does not update the cumulative fp exception status.  It also
+     * produces default NaNs. We also need a second copy of fp_status with
+     * round-to-odd -- see above.
      */
-    fpst_std = *(float_status *)vst;
+    fpst_f16 = env->vfp.fp_status_f16;
+    fpst_std = env->vfp.fp_status;
     set_default_nan_mode(true, &fpst_std);
+    set_default_nan_mode(true, &fpst_f16);
     fpst_odd = fpst_std;
     set_float_rounding_mode(float_round_to_odd, &fpst_odd);
 
@@ -1052,7 +1066,8 @@ void HELPER(sme_fmopa_h)(void *vza, void *vzn, void *vzm, void *vpn,
                         uint32_t m = *(uint32_t *)(vzm + H1_4(col));
 
                         m = f16mop_adj_pair(m, pcol, 0);
-                        *a = f16_dotadd(*a, n, m, &fpst_std, &fpst_odd);
+                        *a = f16_dotadd(*a, n, m,
+                                        &fpst_f16, &fpst_std, &fpst_odd);
                     }
                     col += 4;
                     pcol >>= 4;
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index a50a419af27..ae42ddef7b3 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -334,8 +334,29 @@ static bool do_outprod_fpst(DisasContext *s, arg_op *a, MemOp esz,
     return true;
 }
 
-TRANS_FEAT(FMOPA_h, aa64_sme, do_outprod_fpst, a,
-           MO_32, FPST_FPCR_F16, gen_helper_sme_fmopa_h)
+static bool do_outprod_env(DisasContext *s, arg_op *a, MemOp esz,
+                           gen_helper_gvec_5_ptr *fn)
+{
+    int svl = streaming_vec_reg_size(s);
+    uint32_t desc = simd_desc(svl, svl, a->sub);
+    TCGv_ptr za, zn, zm, pn, pm;
+
+    if (!sme_smza_enabled_check(s)) {
+        return true;
+    }
+
+    za = get_tile(s, esz, a->zad);
+    zn = vec_full_reg_ptr(s, a->zn);
+    zm = vec_full_reg_ptr(s, a->zm);
+    pn = pred_full_reg_ptr(s, a->pn);
+    pm = pred_full_reg_ptr(s, a->pm);
+
+    fn(za, zn, zm, pn, pm, tcg_env, tcg_constant_i32(desc));
+    return true;
+}
+
+TRANS_FEAT(FMOPA_h, aa64_sme, do_outprod_env, a,
+           MO_32, gen_helper_sme_fmopa_h)
 TRANS_FEAT(FMOPA_s, aa64_sme, do_outprod_fpst, a,
            MO_32, FPST_FPCR, gen_helper_sme_fmopa_s)
 TRANS_FEAT(FMOPA_d, aa64_sme_f64f64, do_outprod_fpst, a,
-- 
2.34.1


