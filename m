Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28067CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:19:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLYG-00022v-Iq; Wed, 10 Jun 2026 12:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLY8-0001ZQ-3E
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:04 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLY6-0005iG-0p
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:03 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-45eedc94d37so3607589f8f.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107980; x=1781712780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xIcw2j+jYbwZvS5SD+V7MBy9w8jFI43T6DkM9/xs82E=;
 b=iMu4uclG5HFO1SBxmgbMmYix4VdaqLACnTEfaAgLakkp8ENeNldVJfn5KZlSqBKZTa
 sHBBCetiTQ88M8m/zDYKWHRTg9qOCxU2g4r5eMlnTcoWAFxoEhp9t5gjgOBZdvXZL4xe
 yJbjPU/pOcv/sG4xk5cAWwHu7Hf3tRhsepG2ouCOKCPzUp/WMaTcv5KPbr1Hxub6f5TR
 9JBskvABQJunC4RgngptHX8f+DXTv35GeWiVKoGXgZiARdYoxyr0zPMBvIufXHnDUNIz
 49g6uvEtq/uZ7tVSM45pFBBo8i7L46KDjLIPpLAs0TrI4IP5VZ8ele0WHcio6rloTXn8
 6+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107980; x=1781712780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xIcw2j+jYbwZvS5SD+V7MBy9w8jFI43T6DkM9/xs82E=;
 b=ZgI+MnaBBgBCY8Lovr8wGwA/PalXGJ7NBdclFx60xz2nl6vmxFvqdvMZxtyWIbQLOD
 uJwCUJPMLbP3o4+75TlwazRHTxxJ0be3Hwfc3JqQq8L77bEWxzu91VgmyUT5OhpNMYTn
 GBOIpfkmsGx2QkPeNTmBsiJHw3g4nbKHUjyaV00WH+xiBMwUYEzOJ9c5gbePpeXzoaCz
 DJKhinyn1jY/t8p3eyz13WqrNolKPHpSXwwnLA96Vp9xgl7dRPVWm0+kfu/SjQAHozUz
 wWe1qq2IQCOn1Uh6RJM13fBIh8etw7C91qycfHAlGwmlQfjmKjqlLVS7saE5zoIK+BT+
 7S2Q==
X-Gm-Message-State: AOJu0Yx94HoTFGxXOskjczwDr5C4jUNzj2iawdM4im/mzQhDdQSDB9sE
 W7LaCpLMlJIDXMX+fPrS8SHUvjca+6KY0N50SZuNyCSKB407Z1nvjBNeSUKja0gRra0fATzglPT
 6w9DB
X-Gm-Gg: Acq92OEMZZPRqqhf3/skjbvf6suTAEo2giMDCbRd9Xz4UV5P9zEnxSiKY5fAou1D7Ck
 JREe6rlOo3jIMYidkt2DoLvmX32E9FEOSIIT4myxEtO/orEZUpry8nDWNPSCvqowcqlnBbd76hb
 B7rtBjp14YXK+dhb3lgpEMbQF6wCm4ZODj4vcx0TF6i6tiUcLytujnWRG8LBJgSCdffLQth1GIK
 dA5qziwtD0y9z82eaLkDn4PWbh39GTAdHtqJucxY/sB8FsUc1wjunX3HtDRCoWF8LR6THkeFam6
 xg4/0Kzae44a1TZIDPcvIXrd8o+jjtkd4Mucyo6nKR+KwTDMQHYUXO/8hpbV2Vlo0MnSgaRkrAb
 kdY6C1jXwt1D75Ws0qmDKbnavdIkveSn7hfFP7G0CdpgT4x+laQRY5wvCxktJ1DRvAD+GpaC4ZR
 ohfnbN3z0VXDlB0CEjCRbZ92NIVe4aXi97OiQ/Uwj9wN1Z8CTMncrkXwSlLbmt8uL0tNFoddCTb
 YHPPGYOi/PlKi7HYNmpyFksJA49qK8bKKlTmToWwbU=
X-Received: by 2002:a05:6000:2912:b0:45e:e44b:3147 with SMTP id
 ffacd0b85a97d-46056680a66mr10480134f8f.5.1781107980470; 
 Wed, 10 Jun 2026 09:13:00 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/71] target/arm: Implement FCVTN (16- to 8-bit fp) for AdvSIMD
Date: Wed, 10 Jun 2026 17:11:32 +0100
Message-ID: <20260610161202.2235298-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260609192110.752384-16-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode        |  2 ++
 target/arm/tcg/fp8_helper.c      | 37 ++++++++++++++++++++++++++++++++
 target/arm/tcg/helper-fp8-defs.h |  2 ++
 target/arm/tcg/translate-a64.c   | 15 +++++++++++++
 4 files changed, 56 insertions(+)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 3c806259f9..b08895d917 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1212,6 +1212,8 @@ FAMIN           0.10 1110 1.1 ..... 11011 1 ..... ..... @qrrr_sd
 FSCALE          0.10 1110 110 ..... 00111 1 ..... ..... @qrrr_h
 FSCALE          0.10 1110 1.1 ..... 11111 1 ..... ..... @qrrr_sd
 
+FCVTN_bh        0.00 1110 010 ..... 11110 1 ..... ..... @qrrr_h
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index ffeaf02f97..8e7982a888 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -180,6 +180,13 @@ static uint8_t fcvt_b16_to_fp8(bfloat16 x, fcvt_fp8_output_fn *f8fmt,
     return f8fmt(&p, scale, saturate, s);
 }
 
+static uint8_t fcvt_f16_to_fp8(float16 x, fcvt_fp8_output_fn *f8fmt,
+                               int scale, bool saturate, float_status *s)
+{
+    FloatParts64 p = float16_unpack_canonical(x, s);
+    return f8fmt(&p, scale, saturate, s);
+}
+
 void HELPER(advsimd_bfcvtl)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 {
     FP8Context ctx = fp8_src_start(env, desc, 0x3f);
@@ -369,3 +376,33 @@ void HELPER(sve2_bfcvtn_bh)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 
     fp8_cvt_finish(env, &ctx);
 }
+
+void HELPER(gvec_fcvt_bh)(void *vd, void *vn, void *vm,
+                          CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_dst_start(env, desc, true);
+    fcvt_fp8_output_fn *output_fmt = fcvt_fp8_output_fmt[ctx.f8fmt];
+    uint16_t *n = vn;
+    uint16_t *m = vm;
+    uint8_t *d = vd;
+    bool osc = FIELD_EX64(env->vfp.fpmr, FPMR, OSC);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 2;
+    ARMVectorReg scratch;
+
+    if (vd == vm) {
+        m = memcpy(&scratch, vm, oprsz);
+    }
+
+    for (size_t i = 0; i < nelem; ++i) {
+        d[H1(i)] = fcvt_f16_to_fp8(n[H2(i)], output_fmt,
+                                   ctx.scale, osc, &ctx.stat);
+    }
+    for (size_t i = 0; i < nelem; ++i) {
+        d[H1(i) + nelem] = fcvt_f16_to_fp8(m[H2(i)], output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+    }
+
+    fp8_cvt_finish(env, &ctx);
+    clear_tail(vd, oprsz, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index bbc8d69e28..6530d1a6da 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -14,3 +14,5 @@ DEF_HELPER_FLAGS_4(sme2_fcvt_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_4(sve2_bfcvtn_bh, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fcvt_bh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 439a405064..538b318415 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6619,6 +6619,21 @@ static gen_helper_gvec_3_ptr * const f_vector_fscale[3] = {
 };
 TRANS_FEAT(FSCALE, aa64_f8cvt, do_fp3_vector, a, 0, f_vector_fscale)
 
+static bool trans_FCVTN_bh(DisasContext *s, arg_qrrr_e *a)
+{
+    if (!dc_isar_feature(aa64_f8cvt, s)) {
+        return false;
+    }
+    if (fpmr_access_check(s) && fp_access_check(s)) {
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           tcg_env, a->q ? 16 : 8, vec_full_reg_size(s),
+                           FPST_A64 << 2, gen_helper_gvec_fcvt_bh);
+    }
+    return true;
+}
+
 static bool do_fmlal(DisasContext *s, arg_qrrr_e *a, bool is_s, bool is_2)
 {
     if (fp_access_check(s)) {
-- 
2.43.0


