Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E1ACD98C8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX25T-0006D3-FC; Tue, 09 Jun 2026 15:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21k-0003VM-Hv
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:26 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21e-00049F-8F
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:19 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2c0c1e0b0faso41207275ad.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781032898; x=1781637698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8pwLFcnZ7d3fCEHvFHXc27y8yTNSsxyZLMTlEOY4XGE=;
 b=x/rDiE8OxYtaOSuBYrgId85ZJEjF5qEB1kha+eWcJLKV9feA53rm8C9wY2cqWT+pPB
 lNHw/3bU6YRcUgdVW6MQ+Ad1nbwOaLnSF04GROVz5Xg2EvQPzXcRycDMT+PPREIoKGt/
 AqFarwiuLWOLh/NS+/Un3lFZgXK7MHS3UNAaPcFf3jGxwTyYV1KJlSwLwnnLz/mhuJpe
 HjHyz9f3ibNiUvfdeQ7msMcAqnP28bDCapGV2RwPVaCWG0Zx4nnI0vDnjkc8zAXmJuvm
 LsabNQlmT7xz0qTVFP4vTmuaCbwqlrRlM2PWHZg8e/2F1hy1jT0v8Mvb/N0oJpvLZZ0b
 kgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032898; x=1781637698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8pwLFcnZ7d3fCEHvFHXc27y8yTNSsxyZLMTlEOY4XGE=;
 b=LlWBLEuGATpCwZrBMo7fA9zLCNfddYIrJQGwt5vp5rf/9qHyrFbLW73BlakqvwpXUd
 nv8wHFyXUXkmOZPwvfDLBdjg4trTuI4IM7ChDGAk6DhhocmBs0wc/6ETTidK8zEP9N9z
 VCsD5bFWOM3SqM08M/l7Dm+jxpL+V4qKKX15oAGOArpyqBe6eczo2cJtTTzoxHWneAuV
 7KHoXhZU+uBEQjJE/NkVm6NtQXIN4KpV1LGZiHn9B2/gZOhn3AWcBvifQVjoaKyRYjAE
 hcCQGY1yjjJ2CB6zai57VL7nUT8Ty+D8LYv2GJEWuYyIzV3SJKkg/I69hdOijunBnBFl
 WqNw==
X-Gm-Message-State: AOJu0YyLj0sclLPvc5ObOomtkKnb981PQC260n0zVfnLg1zR0KqUfGyW
 sySTLgsx5tB3ZFV3WlvNc6oycmwUoxkFJ71yTlYHOA+szrN7SSS2H8Ef1iZ92hsmVblqDN122D/
 tylwMKfY=
X-Gm-Gg: Acq92OEA4FGeAvjjgBCXPP8oX9kn1H0xZ/HYnyv+/4jG+7Yul3Ia/XkofL/y6+MMmiZ
 cJZ4RaZkrw5XWEMhIEiqbopxrmwvTPyL1bInqERZyzWkVYpwRJ6A67MFxXQujTfNY68cyfx1ikU
 TP5OzvZjTK6jn0Gl0bDwkV23k1n5FOMOd1tq1NAT0zJrsT1Bia/nq77kOd+IUrKAEINrf9ed41q
 A6qjWblBBaehFDvvSpk6kDMTqp2X7CN0BDlzXueNB+tJPTd9lopU6xLpOYiNfIOB0x93UGeBSdM
 awCAwTTtL2cJ/qLFpYRykRKlA2MuFlxlx5122EHhbrhssoVHQdg3u2/6SFWEuelcrLDpXgvLvEA
 gBm6hrWWxXl91Gj0N06PLrmWNEytsz3pzqVkDOF5KoqTK/e/985pKMDXTo81j4eihPhYT4BIxvU
 97zvnWkmg51fTk5maFl5x/xiaoTUddfITou0kSvHs=
X-Received: by 2002:a17:902:ea09:b0:2bc:8f9a:3642 with SMTP id
 d9443c01a7336-2c1e7e6eee0mr242104835ad.16.1781032897681; 
 Tue, 09 Jun 2026 12:21:37 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f88473sm240806095ad.25.2026.06.09.12.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:21:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v10 34/45] target/arm: Implement FDOT (FP8 to FP32) for AdvSIMD
Date: Tue,  9 Jun 2026 12:20:58 -0700
Message-ID: <20260609192110.752384-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609192110.752384-1-richard.henderson@linaro.org>
References: <20260609192110.752384-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h        |  5 ++++
 target/arm/tcg/helper-fp8-defs.h |  3 +++
 target/arm/tcg/fp8_helper.c      | 39 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   | 30 ++++++++++++++++++++++++
 target/arm/tcg/a64.decode        |  4 ++++
 5 files changed, 81 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 5e9eb3405b..4342a2461e 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1610,6 +1610,11 @@ static inline bool isar_feature_aa64_f8fma(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8FMA);
 }
 
+static inline bool isar_feature_aa64_f8dp4(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8DP4);
+}
+
 /*
  * Combinations of feature tests, for ease of use with TRANS_FEAT.
  */
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 802a3b430e..ee6f2e9236 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -29,3 +29,6 @@ DEF_HELPER_FLAGS_5(gvec_fmla_idx_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env,
 
 DEF_HELPER_FLAGS_5(gvec_fmla_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_fmla_idx_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fdot_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_fdot_idx_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index ceeb96b9cc..f54acb03f3 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -729,3 +729,42 @@ void HELPER(gvec_fmla_idx_sb)(void *vd, void *vn, void *vm,
 
     clear_tail(vd, oprsz, simd_maxsz(desc));
 }
+
+void HELPER(gvec_fdot_sb)(void *vd, void *vn, void *vm,
+                          CPUARMState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, -1);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 4;
+    uint32_t *n = vn;
+    uint32_t *m = vm;
+    float32 *d = vd;
+
+    for (size_t i = 0; i < nelem; i++) {
+        d[i] = f8dotadd_s(n[i], m[i], 4, d[i], &ctx);
+    }
+
+    clear_tail(vd, oprsz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_fdot_idx_sb)(void *vd, void *vn, void *vm,
+                              CPUARMState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, -1);
+    size_t idx = simd_data(desc);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 4;
+    uint32_t *n = vn;
+    uint32_t *m = vm;
+    float32 *d = vd;
+    size_t i = 0;
+
+    do {
+        uint32_t e1 = m[i + H4(idx)];
+        do {
+            d[i] = f8dotadd_s(n[i], e1, 4, d[i], &ctx);
+        } while (++i % 4 != 0);
+    } while (i < nelem);
+
+    clear_tail(vd, oprsz, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index b58a55895b..960de1aa86 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7486,6 +7486,36 @@ TRANS_FEAT(FMLAL_hb_vi, aa64_f8fma, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_hb)
 TRANS_FEAT(FMLALL_sb_v, aa64_f8fma, do_fmla_fp8, a, gen_helper_gvec_fmla_sb)
 TRANS_FEAT(FMLALL_sb_vi, aa64_f8fma, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_sb)
 
+static bool do_f8dot(DisasContext *s, arg_qrrr_e *a,
+                     gen_helper_gvec_3_ptr *fn)
+{
+    if (fpmr_access_check(s) && fp_access_check(s)) {
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           tcg_env, a->q ? 16 : 8, vec_full_reg_size(s),
+                           0, fn);
+    }
+    return true;
+}
+
+TRANS_FEAT(FDOT_sb_v, aa64_f8dp4, do_f8dot, a, gen_helper_gvec_fdot_sb)
+
+static bool do_f8dot_idx(DisasContext *s, arg_qrrx_e *a,
+                         gen_helper_gvec_3_ptr *fn)
+{
+    if (fpmr_access_check(s) && fp_access_check(s)) {
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           tcg_env, a->q ? 16 : 8, vec_full_reg_size(s),
+                           a->idx, fn);
+    }
+    return true;
+}
+
+TRANS_FEAT(FDOT_sb_vi, aa64_f8dp4, do_f8dot_idx, a, gen_helper_gvec_fdot_idx_sb)
+
 static bool do_int3_vector_idx(DisasContext *s, arg_qrrx_e *a,
                                gen_helper_gvec_3 * const fns[2])
 {
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index ee7391a13c..08c493c11e 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1224,6 +1224,8 @@ FMLAL_hb_v      0 idxn:1 00 1110 110 rm:5 11111 1 rn:5 rd:5 \
 FMLALL_sb_v     0.00 1110 0.0 rm:5 110001 rn:5 rd:5 \
                 &rxx idxm=0 idxn=%fmlall_idxn
 
+FDOT_sb_v       0.00 1110 000 ..... 11111 1 ..... ..... @qrrr_s
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
@@ -1348,6 +1350,8 @@ FMLAL_hb_vi     0 idxn:1 00 1111 11 ... rm:3 0000 . 0 rn:5 rd:5 \
 FMLALL_sb_vi    0 . 10 1111 0 . ... rm:3 1000 . 0 rn:5 rd:5 \
                 &rxx idxm=%hlm4 idxn=%fmlall_idxn
 
+FDOT_sb_vi      0.00 1111 00 . ..... 0000 . 0 ..... .....   @qrrx_s
+
 # Floating-point conditional select
 
 FCSEL           0001 1110 .. 1 rm:5 cond:4 11 rn:5 rd:5     esz=%esz_hsd
-- 
2.43.0


