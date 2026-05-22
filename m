Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BDCCD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQY2S-0001DA-P4; Fri, 22 May 2026 18:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQY1L-0006qI-8P
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:07:13 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQY1E-0002hT-TO
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:07:05 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2bd80b3aa13so51854395ad.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487618; x=1780092418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=63SLsAwN+R2/NKJc6wAwfjdhLCbUlj1w/1+4wqYKNRU=;
 b=kfc/E9OE0yPGKtZS8PVVqLnDhPwphIxhwIxM//I7Etcwf3WbDZc1FuwBzSk9Vv5dAS
 HYwBd22pa4a6VWrPGH3phu/vk58gKh0JnI4IEEJFFVk7MuDq+ZClGwMj1dPxV7sxaPUp
 PQSf1AZboenU7axhlzaYciZect6riS9kx8p2or5oS+YuX/izQ3lrisFGGnVH8nv7tlfF
 0ZZYv/131OXzDUAA0i83T1cfe+MFfOlJtMFFNwgrLP+wWhmNYdAMwr4v8Nxtm8YpiAWc
 HXb9K1O68F4jlq3uCMh/cANwEUgnBH9iqNNxiP75+gb3de6g84w6DiPvA1rGXBr7xoJe
 7GeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487618; x=1780092418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=63SLsAwN+R2/NKJc6wAwfjdhLCbUlj1w/1+4wqYKNRU=;
 b=GwD1+8vjwUbnyE/WslAEEUmDIoD3LbKzwoQOTbwY++SobxxHK7R5W00udVJQQmNKTL
 jHEamzxd+YayrfKv4nLfuEIllIDs9PoJDQnYIlct8WAMPIHNmcloUlp/ADYkhBaDz5OV
 JSThPE8Wrn+eyzYtPZxzZlWbMmd7w9jhCmAsJjgz7wwECHfzFiw0iIViuTPE86DpWuwI
 TRV4SkfmdqXX12SDQPDnEU3t8DKir+ONzlLMAsUkn9PnFBdxi2bYDm8FwKQ0Iy7zvaZ7
 b5Qyc2X/eJmcDZJGlXW54XZSDnm07E5d70CQNtiOEj8y1DD9aAdVDZXnZ/C0ghbDf9yG
 /Uyg==
X-Gm-Message-State: AOJu0YxUHHznBmw4JVEEQHj3UlS41MPno16wxKxpLBaVRQRLNZqNMBhQ
 Rymi4cZkdTmHL1aa3QmpUmzhZ3gNnc7VqdWCe+n6vhQAdCyEYfB3p19w+ZFNtR+B3zuqZXLGI/i
 5eRgB
X-Gm-Gg: Acq92OHB/n+i5VRtHQRp7FfXehciBwlQ/QXpALT3656muQe+swD1FdNRdSPvoaSNSle
 g4p9EVbFXP6uNcJJlSaKJALvoiW3WTJ0dDtXe6XYeBebYvKzQn8Pv1FXX9dEJ3WAqlKiqIVQo+i
 x9GblPXLjrVhmEGaRZOK6SMHqurUWhRMSiuKzENgfNFRFl7Uhbta3hNELCVwjg7QTSk9zen7WBN
 Jrlo/5+WWWJpHH0gtb1MFunXzheTXRY4ukBdBaeIVOI8OJqRSPPHWwN1vmeKTrwF5i0eH553xup
 2L4nbCBybBtB/vtBdrNPId8+jKUh3KZfngA+Bh/WYijIOABDt1bRecb9xPSgrRGzFpTBiix6OHz
 HpZ/KB2MBVV8PjJdcOtGZe8BEzZ6ojv86QhsVFVdygqzOwtO2uaHt4R8xtcFf2Rn9+PJzysF21W
 niUDm0CGZzMGdPWUSaXs+roI+i8YrbNNmZN+V4kYk=
X-Received: by 2002:a17:903:46c4:b0:2ae:54b2:27c7 with SMTP id
 d9443c01a7336-2beb085795dmr49064095ad.39.1779487618117; 
 Fri, 22 May 2026 15:06:58 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56b7920sm27835745ad.21.2026.05.22.15.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:06:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v7 53/64] target/arm: Implement FDOT (FP8 to FP32) for AdvSIMD
Date: Fri, 22 May 2026 15:02:55 -0700
Message-ID: <20260522220306.235200-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h        |  5 ++++
 target/arm/tcg/helper-fp8-defs.h |  3 +++
 target/arm/tcg/fp8_helper.c      | 39 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   | 30 ++++++++++++++++++++++++
 target/arm/tcg/a64.decode        |  4 ++++
 5 files changed, 81 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index c0b646415c..fbce0386ef 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1600,6 +1600,11 @@ static inline bool isar_feature_aa64_f8fma(const ARMISARegisters *id)
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
index 2e3eb43799..d1d5b22cbf 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -728,3 +728,42 @@ void HELPER(gvec_fmla_idx_sb)(void *vd, void *vn, void *vm,
 
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
index a9e816fe3e..d2e945a9f5 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7400,6 +7400,36 @@ TRANS_FEAT(FMLAL_hb_vi, aa64_f8fma, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_hb)
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
index ef6d7dfeaa..d78a3d5486 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1213,6 +1213,8 @@ FMLAL_hb_v      0 idxn:1 00 1110 110 rm:5 11111 1 rn:5 rd:5 \
 FMLALL_sb_v     0.00 1110 0.0 rm:5 110001 rn:5 rd:5 \
                 &rxx idxm=0 idxn=%fmlall_idxn
 
+FDOT_sb_v       0.00 1110 000 ..... 11111 1 ..... ..... @qrrr_s
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
@@ -1337,6 +1339,8 @@ FMLAL_hb_vi     0 idxn:1 00 1111 11 ... rm:3 0000 . 0 rn:5 rd:5 \
 FMLALL_sb_vi    0 . 10 1111 0 . ... rm:3 1000 . 0 rn:5 rd:5 \
                 &rxx idxm=%hlm4 idxn=%fmlall_idxn
 
+FDOT_sb_vi      0.00 1111 00 . ..... 0000 . 0 ..... .....   @qrrx_s
+
 # Floating-point conditional select
 
 FCSEL           0001 1110 .. 1 rm:5 cond:4 11 rn:5 rd:5     esz=%esz_hsd
-- 
2.43.0


