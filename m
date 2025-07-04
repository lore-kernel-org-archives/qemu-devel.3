Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D630EC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjFC-0002wn-TF; Fri, 04 Jul 2025 12:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEl-0001IO-Mc
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:07 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEj-0006Uv-Kd
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:07 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a6e8b1fa37so821549f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646363; x=1752251163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7v4jkCWkG0HPuInQfXmIRLTRgFPp1Jt2LMIyEze1ir4=;
 b=iLw+cqXA3neYCpsmzlWN4V0a7rXVuXGv2rtgbBHuxv8GeUIiS1YfPRq0WZXq/GYlhy
 sdphkoF+6TnD1OEo9nZopXk5FcupVRw8tizOcBkUJQvV4oL+/zOFhIezWTQiNQ2KsmPB
 ZluAOUYyx6nsIy8x5+01ZNcZgFr14WLXNoJD8vRYmrkmiiYJM0VKqIDDmyrgaxB/a6PV
 F+IzF/gAT35cAn/9MdcadY+109T5uwYoxmyzRp5iwmFCdDX3qZVO3wcHrJD+rGLaPrms
 wTqr9VQwia6IHjRk6F8bMusPlesqTUpTdLM6n8ifS7V+OPJ5ON5Z5b1lIsaquqYN2k4Y
 QmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646363; x=1752251163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7v4jkCWkG0HPuInQfXmIRLTRgFPp1Jt2LMIyEze1ir4=;
 b=m9GFuuaFuXegf0rL5T9JjuMlJMM8xgH+ikkmum6+1uhzwYjh/4QPfacs5IUTJoJHW+
 eYHJV8k7OQV3PQMVXfUBgeTaxs/cYyXda2p7m3aNi8lohgpb1tX/4jZjm2NJ1xDMN/jl
 v3n7K0lvrQZRABc1ChkMr+m1dagAjoEsa2PYb7gGpp3JsNdc/sSVcOpu8wQCAsD5oT9V
 CiGwQ9oJANIxahsKsYKRUYqfzr0pcsXq5qt+HDniW1Gf+QiD89BWUx/3KLSQrc5JyX2l
 sK/MVvX600HTzYfjfm0AG4SIZM0UA8wzlVAxsBctkmF6kEubSSLWIAsEhYV8fLVBKhI5
 nwmw==
X-Gm-Message-State: AOJu0YzHXW4qjAi20CSZusOeI9KGrA3YRrPD42s9z4vyV3vmYeMoG4xn
 NeJ8kHU7QYhemG0cqShna/2fWgfkAwMAJJhlV8YFKU3DyKlMqYXoh9zSXcFAZWO2K8QDt+E9Ur/
 hKE84
X-Gm-Gg: ASbGnct/IThw/+LvZH7N4htiMwwt0vX3Q1xr+ayEFK4i710K0jQb5D23xnMwd7TK6q5
 5ld+Y93APVYbOTfdmVmgHTrmHGRS01lrhVqnk+9Yf7MVExFpyqkiJM56JDRnJRFeXbwtS+wdKoD
 qN2Bg5tgbcg6LlnJ7uO1YeK2UXyzoYqOe3dLOv7xQzXshWyXwB+Bsyqnsz0ipLvxhXVNmTQ9bbI
 cTQ0I9nXBXm9bb/Lpcern7zLU4QKq92yONnsgRQ7u5/zVB/OZ2eEgU1pgbfAd1hk8ySZGvdC0FQ
 AAWKEe1uCa0TATYR11bpq0c/lGFBukV/gB58sDJYJ495FAAbeNaclyqauq7w5fncRKRf
X-Google-Smtp-Source: AGHT+IFVRDceMfL0hbmiRDWap5xvwDQ7UtOZEwbHEfub9HySC6DCQEFaBDWzDe6y4zxDeX9P6J/RTA==
X-Received: by 2002:a05:6000:2308:b0:3b4:b4d:6861 with SMTP id
 ffacd0b85a97d-3b496607b8emr2835239f8f.27.1751646363449; 
 Fri, 04 Jul 2025 09:26:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 064/119] target/arm: Implement SME2 BFCVT, BFCVTN, FCVT, FCVTN
Date: Fri,  4 Jul 2025 17:24:04 +0100
Message-ID: <20250704162501.249138-65-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-53-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme.h    |  5 +++
 target/arm/tcg/vec_internal.h  |  2 +
 target/arm/tcg/sme.decode      | 12 ++++++
 target/arm/tcg/sme_helper.c    | 74 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/sve_helper.c    |  2 +-
 target/arm/tcg/translate-sme.c | 25 ++++++++++++
 6 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 0bb8af194b3..97e70959e8a 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -212,3 +212,8 @@ DEF_HELPER_FLAGS_5(sme2_umlsll_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr,
 DEF_HELPER_FLAGS_5(sme2_umlsll_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sme2_usmlall_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sme2_sumlall_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sme2_bfcvt, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(sme2_bfcvtn, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(sme2_fcvt_n, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(sme2_fcvtn, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index 64a7249d017..c8199a3ef8e 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -306,4 +306,6 @@ static inline float64 float64_maybe_ah_chs(float64 a, bool fpcr_ah)
 bfloat16 helper_sme2_ah_fmax_b16(bfloat16 a, bfloat16 b, float_status *fpst);
 bfloat16 helper_sme2_ah_fmin_b16(bfloat16 a, bfloat16 b, float_status *fpst);
 
+float16 sve_f32_to_f16(float32 f, float_status *fpst);
+
 #endif /* TARGET_ARM_VEC_INTERNAL_H */
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 22e2a68b1b9..831179c0eed 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -720,3 +720,15 @@ SUB_aaz_s       11000001 101 000000 .. 111 ....0 11 ...     @az_2x2_o3
 SUB_aaz_s       11000001 101 000010 .. 111 ...00 11 ...     @az_4x4_o3
 SUB_aaz_d       11000001 111 000000 .. 111 ....0 11 ...     @az_2x2_o3
 SUB_aaz_d       11000001 111 000010 .. 111 ...00 11 ...     @az_4x4_o3
+
+### SME2 Multi-vector SVE Constructive Unary
+
+&zz_n           zd zn n
+@zz_1x2         ........ ... ..... ...... ..... zd:5        \
+                &zz_n n=1 zn=%zn_ax2
+
+BFCVT           11000001 011 00000 111000 ....0 .....       @zz_1x2
+BFCVTN          11000001 011 00000 111000 ....1 .....       @zz_1x2
+
+FCVT_n          11000001 001 00000 111000 ....0 .....       @zz_1x2
+FCVTN           11000001 001 00000 111000 ....1 .....       @zz_1x2
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 0f79d7cb6e3..d97afdb69cf 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1517,3 +1517,77 @@ DO_MLALL_IDX(sme2_usmlall_idx_s, uint32_t, uint8_t, int8_t, H4, H1, +)
 DO_MLALL_IDX(sme2_sumlall_idx_s, uint32_t, int8_t, uint8_t, H4, H1, +)
 
 #undef DO_MLALL_IDX
+
+/* Convert and compress */
+void HELPER(sme2_bfcvt)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+{
+    ARMVectorReg scratch;
+    size_t oprsz = simd_oprsz(desc);
+    size_t i, n = oprsz / 4;
+    float32 *s0 = vs;
+    float32 *s1 = vs + sizeof(ARMVectorReg);
+    bfloat16 *d = vd;
+
+    if (vd == s1) {
+        s1 = memcpy(&scratch, s1, oprsz);
+    }
+
+    for (i = 0; i < n; ++i) {
+        d[H2(i)] = float32_to_bfloat16(s0[H4(i)], fpst);
+    }
+    for (i = 0; i < n; ++i) {
+        d[H2(i) + n] = float32_to_bfloat16(s1[H4(i)], fpst);
+    }
+}
+
+void HELPER(sme2_fcvt_n)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+{
+    ARMVectorReg scratch;
+    size_t oprsz = simd_oprsz(desc);
+    size_t i, n = oprsz / 4;
+    float32 *s0 = vs;
+    float32 *s1 = vs + sizeof(ARMVectorReg);
+    float16 *d = vd;
+
+    if (vd == s1) {
+        s1 = memcpy(&scratch, s1, oprsz);
+    }
+
+    for (i = 0; i < n; ++i) {
+        d[H2(i)] = sve_f32_to_f16(s0[H4(i)], fpst);
+    }
+    for (i = 0; i < n; ++i) {
+        d[H2(i) + n] = sve_f32_to_f16(s1[H4(i)], fpst);
+    }
+}
+
+/* Convert and interleave */
+void HELPER(sme2_bfcvtn)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+{
+    size_t i, n = simd_oprsz(desc) / 4;
+    float32 *s0 = vs;
+    float32 *s1 = vs + sizeof(ARMVectorReg);
+    bfloat16 *d = vd;
+
+    for (i = 0; i < n; ++i) {
+        bfloat16 d0 = float32_to_bfloat16(s0[H4(i)], fpst);
+        bfloat16 d1 = float32_to_bfloat16(s1[H4(i)], fpst);
+        d[H2(i * 2 + 0)] = d0;
+        d[H2(i * 2 + 1)] = d1;
+    }
+}
+
+void HELPER(sme2_fcvtn)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+{
+    size_t i, n = simd_oprsz(desc) / 4;
+    float32 *s0 = vs;
+    float32 *s1 = vs + sizeof(ARMVectorReg);
+    bfloat16 *d = vd;
+
+    for (i = 0; i < n; ++i) {
+        bfloat16 d0 = sve_f32_to_f16(s0[H4(i)], fpst);
+        bfloat16 d1 = sve_f32_to_f16(s1[H4(i)], fpst);
+        d[H2(i * 2 + 0)] = d0;
+        d[H2(i * 2 + 1)] = d1;
+    }
+}
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index a2c363a4e17..b522ddaf7cb 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4576,7 +4576,7 @@ static inline float64 sve_f16_to_f64(float16 f, float_status *fpst)
     return ret;
 }
 
-static inline float16 sve_f32_to_f16(float32 f, float_status *fpst)
+float16 sve_f32_to_f16(float32 f, float_status *fpst)
 {
     bool save = get_flush_to_zero(fpst);
     float16 ret;
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 4c3b9aa7d6c..10e5b77040e 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1335,3 +1335,28 @@ TRANS_FEAT(SMLALL_nx_d, aa64_sme2_i16i64, do_smlall_nx, a, gen_helper_sme2_smlal
 TRANS_FEAT(SMLSLL_nx_d, aa64_sme2_i16i64, do_smlall_nx, a, gen_helper_sme2_smlsll_idx_d)
 TRANS_FEAT(UMLALL_nx_d, aa64_sme2_i16i64, do_smlall_nx, a, gen_helper_sme2_umlall_idx_d)
 TRANS_FEAT(UMLSLL_nx_d, aa64_sme2_i16i64, do_smlall_nx, a, gen_helper_sme2_umlsll_idx_d)
+
+static bool do_zz_fpst(DisasContext *s, arg_zz_n *a, int data,
+                       ARMFPStatusFlavour type, gen_helper_gvec_2_ptr *fn)
+{
+    if (sme_sm_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        TCGv_ptr fpst = fpstatus_ptr(type);
+
+        for (int i = 0, n = a->n; i < n; ++i) {
+            tcg_gen_gvec_2_ptr(vec_full_reg_offset(s, a->zd + i),
+                               vec_full_reg_offset(s, a->zn + i),
+                               fpst, svl, svl, data, fn);
+        }
+    }
+    return true;
+}
+
+TRANS_FEAT(BFCVT, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_sme2_bfcvt)
+TRANS_FEAT(BFCVTN, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_sme2_bfcvtn)
+TRANS_FEAT(FCVT_n, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_sme2_fcvt_n)
+TRANS_FEAT(FCVTN, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_sme2_fcvtn)
-- 
2.43.0


