Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E65C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 01:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mml-0007xg-6u; Sun, 05 May 2024 21:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mma-0007rW-Io
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:47 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmF-0002U0-Q1
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:44 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-61f2dc31be4so1272147a12.1
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 18:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714957460; x=1715562260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rHeFdqmSIrKSfhy0XSzjzXa9EfWTAIQsmCyzR/glZxk=;
 b=fER7Dfm+ww3d4b7Q3b0CTKmiUetoT3OuwzFDlt0hPPV6T6hPCanjfw7lwRR0aDn255
 RziGueEr1W4wZJSui8fqcj85FKrilZh9uagbnMhXaMLOyVbbO94gRWowm5g9LmD3C6W5
 n4/IpgJ3gZPA73NiH1jWXe/9ZNjciv+sjGpLgi7DIjPKNhFyrch9l9rvdv0VOBqrBt+3
 iQyn9pdJQsL1J2aUvsMznFZiDZ1SJjt8MWAduIj8i8jOosFM5BMCvUJuePKuxACKW1BP
 maYAR0sQ+VHkbUA++/fZatbClqgIMvoUY6ed2JHG5Oa3X9OWugsblHsT3ALu626x0uCs
 94qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714957460; x=1715562260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rHeFdqmSIrKSfhy0XSzjzXa9EfWTAIQsmCyzR/glZxk=;
 b=Lxcsm5f3gNtG30bmeQ2Rc1hf1txrK+D2ydKkPGaPNQJEuPZrHOfmhM9BYevQjPKDFQ
 QmWB5rG9b9d+ro9qZAzweK4z0xCj1n8OpfzIXUH8pzlZ2vt+psuNspyjt5PZmKoicHjp
 i2JXoiDRLxHxBLb1iXDd9Ng9J7T2Bmi+hwNbwuOdMGTG0uhnED27e7paViyxZUCT8CCv
 JB0AOrVGC9gK/xw19/zneG5fSI/M4HC/QsXmz2Qd1y9PWwnPAEg8sYP1miEpUgizOjXQ
 L85aAQP3SW5/eDneJKtOoNv4udRMTUsRrISjb6rFoYRoTUCxOzijR9KgXMK3Rk8rojCi
 hgGQ==
X-Gm-Message-State: AOJu0YyQo5ZVEvsBJ+Y8eQ+BqGprQXZWq8t7E3eRGbq51UBnKs+56GE6
 dAu/O0z1LBlqm8m3JACunfHjSif5F52Tj4MRXu2+z8M8TqzgDitryseHavhd88AbAvEz7wMjO/u
 m
X-Google-Smtp-Source: AGHT+IEuVz1rViHVu3rNQbO0ZmA2hn8WAncxu6FQ73Oi97ZFaaf85F7RlAfTtDZBPuValX8rg1FC9Q==
X-Received: by 2002:a17:90a:17cb:b0:2a9:e879:c83d with SMTP id
 q69-20020a17090a17cb00b002a9e879c83dmr16486572pja.5.1714957459853; 
 Sun, 05 May 2024 18:04:19 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 pv7-20020a17090b3c8700b002a5f44353d2sm8958232pjb.7.2024.05.05.18.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 18:04:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 17/57] target/arm: Convert FMLA, FMLS to decodetree
Date: Sun,  5 May 2024 18:03:23 -0700
Message-Id: <20240506010403.6204-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506010403.6204-1-richard.henderson@linaro.org>
References: <20240506010403.6204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h            |   2 +
 target/arm/tcg/a64.decode      |  22 +++
 target/arm/tcg/translate-a64.c | 241 +++++++++++++++++----------------
 target/arm/tcg/vec_helper.c    |  14 ++
 4 files changed, 163 insertions(+), 116 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 0fd01c9c52..e021c18517 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -770,9 +770,11 @@ DEF_HELPER_FLAGS_5(gvec_fmls_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_vfma_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_vfma_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vfma_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_vfms_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_vfms_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vfms_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_ftsmul_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index dbfdfd80f9..cb84a8685f 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -742,12 +742,26 @@ FMINNM_v        0.00 1110 1.1 ..... 11000 1 ..... ..... @qrrr_sd
 FMULX_v         0.00 0111 010 ..... 00011 1 ..... ..... @qrrr_h
 FMULX_v         0.00 1110 0.1 ..... 11011 1 ..... ..... @qrrr_sd
 
+FMLA_v          0.00 1110 010 ..... 00001 1 ..... ..... @qrrr_h
+FMLA_v          0.00 1110 0.1 ..... 11001 1 ..... ..... @qrrr_sd
+
+FMLS_v          0.00 1110 110 ..... 00001 1 ..... ..... @qrrr_h
+FMLS_v          0.00 1110 1.1 ..... 11001 1 ..... ..... @qrrr_sd
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
 FMUL_si         0101 1111 10 . ..... 1001 . 0 ..... .....   @rrx_s
 FMUL_si         0101 1111 11 0 ..... 1001 . 0 ..... .....   @rrx_d
 
+FMLA_si         0101 1111 00 .. .... 0001 . 0 ..... .....   @rrx_h
+FMLA_si         0101 1111 10 .. .... 0001 . 0 ..... .....   @rrx_s
+FMLA_si         0101 1111 11 0. .... 0001 . 0 ..... .....   @rrx_d
+
+FMLS_si         0101 1111 00 .. .... 0101 . 0 ..... .....   @rrx_h
+FMLS_si         0101 1111 10 .. .... 0101 . 0 ..... .....   @rrx_s
+FMLS_si         0101 1111 11 0. .... 0101 . 0 ..... .....   @rrx_d
+
 FMULX_si        0111 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
 FMULX_si        0111 1111 10 . ..... 1001 . 0 ..... .....   @rrx_s
 FMULX_si        0111 1111 11 0 ..... 1001 . 0 ..... .....   @rrx_d
@@ -758,6 +772,14 @@ FMUL_vi         0.00 1111 00 .. .... 1001 . 0 ..... .....   @qrrx_h
 FMUL_vi         0.00 1111 10 . ..... 1001 . 0 ..... .....   @qrrx_s
 FMUL_vi         0.00 1111 11 0 ..... 1001 . 0 ..... .....   @qrrx_d
 
+FMLA_vi         0.00 1111 00 .. .... 0001 . 0 ..... .....   @qrrx_h
+FMLA_vi         0.00 1111 10 . ..... 0001 . 0 ..... .....   @qrrx_s
+FMLA_vi         0.00 1111 11 0 ..... 0001 . 0 ..... .....   @qrrx_d
+
+FMLS_vi         0.00 1111 00 .. .... 0101 . 0 ..... .....   @qrrx_h
+FMLS_vi         0.00 1111 10 . ..... 0101 . 0 ..... .....   @qrrx_s
+FMLS_vi         0.00 1111 11 0 ..... 0101 . 0 ..... .....   @qrrx_d
+
 FMULX_vi        0.10 1111 00 .. .... 1001 . 0 ..... .....   @qrrx_h
 FMULX_vi        0.10 1111 10 . ..... 1001 . 0 ..... .....   @qrrx_s
 FMULX_vi        0.10 1111 11 0 ..... 1001 . 0 ..... .....   @qrrx_d
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index caf4d8154d..36aae079da 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5067,6 +5067,20 @@ static gen_helper_gvec_3_ptr * const f_vector_fmulx[3] = {
 };
 TRANS(FMULX_v, do_fp3_vector, a, f_vector_fmulx)
 
+static gen_helper_gvec_3_ptr * const f_vector_fmla[3] = {
+    gen_helper_gvec_vfma_h,
+    gen_helper_gvec_vfma_s,
+    gen_helper_gvec_vfma_d,
+};
+TRANS(FMLA_v, do_fp3_vector, a, f_vector_fmla)
+
+static gen_helper_gvec_3_ptr * const f_vector_fmls[3] = {
+    gen_helper_gvec_vfms_h,
+    gen_helper_gvec_vfms_s,
+    gen_helper_gvec_vfms_d,
+};
+TRANS(FMLS_v, do_fp3_vector, a, f_vector_fmls)
+
 /*
  * Advanced SIMD scalar/vector x indexed element
  */
@@ -5116,6 +5130,64 @@ static bool do_fp3_scalar_idx(DisasContext *s, arg_rrx_e *a, const FPScalar *f)
 TRANS(FMUL_si, do_fp3_scalar_idx, a, &f_scalar_fmul)
 TRANS(FMULX_si, do_fp3_scalar_idx, a, &f_scalar_fmulx)
 
+static bool do_fmla_scalar_idx(DisasContext *s, arg_rrx_e *a, bool neg)
+{
+    switch (a->esz) {
+    case MO_64:
+        if (fp_access_check(s)) {
+            TCGv_i64 t0 = read_fp_dreg(s, a->rd);
+            TCGv_i64 t1 = read_fp_dreg(s, a->rn);
+            TCGv_i64 t2 = tcg_temp_new_i64();
+
+            read_vec_element(s, t2, a->rm, a->idx, MO_64);
+            if (neg) {
+                gen_vfp_negd(t1, t1);
+            }
+            gen_helper_vfp_muladdd(t0, t1, t2, t0, fpstatus_ptr(FPST_FPCR));
+            write_fp_dreg(s, a->rd, t0);
+        }
+        break;
+    case MO_32:
+        if (fp_access_check(s)) {
+            TCGv_i32 t0 = read_fp_sreg(s, a->rd);
+            TCGv_i32 t1 = read_fp_sreg(s, a->rn);
+            TCGv_i32 t2 = tcg_temp_new_i32();
+
+            read_vec_element_i32(s, t2, a->rm, a->idx, MO_32);
+            if (neg) {
+                gen_vfp_negs(t1, t1);
+            }
+            gen_helper_vfp_muladds(t0, t1, t2, t0, fpstatus_ptr(FPST_FPCR));
+            write_fp_sreg(s, a->rd, t0);
+        }
+        break;
+    case MO_16:
+        if (!dc_isar_feature(aa64_fp16, s)) {
+            return false;
+        }
+        if (fp_access_check(s)) {
+            TCGv_i32 t0 = read_fp_hreg(s, a->rd);
+            TCGv_i32 t1 = read_fp_hreg(s, a->rn);
+            TCGv_i32 t2 = tcg_temp_new_i32();
+
+            read_vec_element_i32(s, t2, a->rm, a->idx, MO_16);
+            if (neg) {
+                gen_vfp_negh(t1, t1);
+            }
+            gen_helper_advsimd_muladdh(t0, t1, t2, t0,
+                                       fpstatus_ptr(FPST_FPCR_F16));
+            write_fp_sreg(s, a->rd, t0);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return true;
+}
+
+TRANS(FMLA_si, do_fmla_scalar_idx, a, false)
+TRANS(FMLS_si, do_fmla_scalar_idx, a, true)
+
 static bool do_fp3_vector_idx(DisasContext *s, arg_qrrx_e *a,
                               gen_helper_gvec_3_ptr * const fns[3])
 {
@@ -5158,6 +5230,42 @@ static gen_helper_gvec_3_ptr * const f_vector_idx_fmulx[3] = {
 };
 TRANS(FMULX_vi, do_fp3_vector_idx, a, f_vector_idx_fmulx)
 
+static bool do_fmla_vector_idx(DisasContext *s, arg_qrrx_e *a, bool neg)
+{
+    static gen_helper_gvec_4_ptr * const fns[3] = {
+        gen_helper_gvec_fmla_idx_h,
+        gen_helper_gvec_fmla_idx_s,
+        gen_helper_gvec_fmla_idx_d,
+    };
+    MemOp esz = a->esz;
+
+    switch (esz) {
+    case MO_64:
+        if (!a->q) {
+            return false;
+        }
+        break;
+    case MO_32:
+        break;
+    case MO_16:
+        if (!dc_isar_feature(aa64_fp16, s)) {
+            return false;
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    if (fp_access_check(s)) {
+        gen_gvec_op4_fpst(s, a->q, a->rd, a->rn, a->rm, a->rd,
+                          esz == MO_16, (a->idx << 1) | neg,
+                          fns[esz - 1]);
+    }
+    return true;
+}
+
+TRANS(FMLA_vi, do_fmla_vector_idx, a, false)
+TRANS(FMLS_vi, do_fmla_vector_idx, a, true)
+
 
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
@@ -9113,15 +9221,6 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
             read_vec_element(s, tcg_op2, rm, pass, MO_64);
 
             switch (fpopcode) {
-            case 0x39: /* FMLS */
-                /* As usual for ARM, separate negation for fused multiply-add */
-                gen_vfp_negd(tcg_op1, tcg_op1);
-                /* fall through */
-            case 0x19: /* FMLA */
-                read_vec_element(s, tcg_res, rd, pass, MO_64);
-                gen_helper_vfp_muladdd(tcg_res, tcg_op1, tcg_op2,
-                                       tcg_res, fpst);
-                break;
             case 0x1c: /* FCMEQ */
                 gen_helper_neon_ceq_f64(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
@@ -9149,10 +9248,12 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
                 break;
             default:
             case 0x18: /* FMAXNM */
+            case 0x19: /* FMLA */
             case 0x1a: /* FADD */
             case 0x1b: /* FMULX */
             case 0x1e: /* FMAX */
             case 0x38: /* FMINNM */
+            case 0x39: /* FMLS */
             case 0x3a: /* FSUB */
             case 0x3e: /* FMIN */
             case 0x5b: /* FMUL */
@@ -9171,15 +9272,6 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
             read_vec_element_i32(s, tcg_op2, rm, pass, MO_32);
 
             switch (fpopcode) {
-            case 0x39: /* FMLS */
-                /* As usual for ARM, separate negation for fused multiply-add */
-                gen_vfp_negs(tcg_op1, tcg_op1);
-                /* fall through */
-            case 0x19: /* FMLA */
-                read_vec_element_i32(s, tcg_res, rd, pass, MO_32);
-                gen_helper_vfp_muladds(tcg_res, tcg_op1, tcg_op2,
-                                       tcg_res, fpst);
-                break;
             case 0x1c: /* FCMEQ */
                 gen_helper_neon_ceq_f32(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
@@ -9207,10 +9299,12 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
                 break;
             default:
             case 0x18: /* FMAXNM */
+            case 0x19: /* FMLA */
             case 0x1a: /* FADD */
             case 0x1b: /* FMULX */
             case 0x1e: /* FMAX */
             case 0x38: /* FMINNM */
+            case 0x39: /* FMLS */
             case 0x3a: /* FSUB */
             case 0x3e: /* FMIN */
             case 0x5b: /* FMUL */
@@ -11134,8 +11228,6 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
     case 0x3f: /* FRSQRTS */
     case 0x5d: /* FACGE */
     case 0x7d: /* FACGT */
-    case 0x19: /* FMLA */
-    case 0x39: /* FMLS */
     case 0x1c: /* FCMEQ */
     case 0x5c: /* FCMGE */
     case 0x7a: /* FABD */
@@ -11168,10 +11260,12 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
 
     default:
     case 0x18: /* FMAXNM */
+    case 0x19: /* FMLA */
     case 0x1a: /* FADD */
     case 0x1b: /* FMULX */
     case 0x1e: /* FMAX */
     case 0x38: /* FMINNM */
+    case 0x39: /* FMLS */
     case 0x3a: /* FSUB */
     case 0x3e: /* FMIN */
     case 0x5b: /* FMUL */
@@ -11517,10 +11611,8 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
     int pass;
 
     switch (fpopcode) {
-    case 0x1: /* FMLA */
     case 0x4: /* FCMEQ */
     case 0x7: /* FRECPS */
-    case 0x9: /* FMLS */
     case 0xf: /* FRSQRTS */
     case 0x14: /* FCMGE */
     case 0x15: /* FACGE */
@@ -11538,10 +11630,12 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
         break;
     default:
     case 0x0: /* FMAXNM */
+    case 0x1: /* FMLA */
     case 0x2: /* FADD */
     case 0x3: /* FMULX */
     case 0x6: /* FMAX */
     case 0x8: /* FMINNM */
+    case 0x9: /* FMLS */
     case 0xa: /* FSUB */
     case 0xe: /* FMIN */
     case 0x13: /* FMUL */
@@ -11611,24 +11705,12 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
             read_vec_element_i32(s, tcg_op2, rm, pass, MO_16);
 
             switch (fpopcode) {
-            case 0x1: /* FMLA */
-                read_vec_element_i32(s, tcg_res, rd, pass, MO_16);
-                gen_helper_advsimd_muladdh(tcg_res, tcg_op1, tcg_op2, tcg_res,
-                                           fpst);
-                break;
             case 0x4: /* FCMEQ */
                 gen_helper_advsimd_ceq_f16(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x7: /* FRECPS */
                 gen_helper_recpsf_f16(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x9: /* FMLS */
-                /* As usual for ARM, separate negation for fused multiply-add */
-                tcg_gen_xori_i32(tcg_op1, tcg_op1, 0x8000);
-                read_vec_element_i32(s, tcg_res, rd, pass, MO_16);
-                gen_helper_advsimd_muladdh(tcg_res, tcg_op1, tcg_op2, tcg_res,
-                                           fpst);
-                break;
             case 0xf: /* FRSQRTS */
                 gen_helper_rsqrtsf_f16(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
@@ -11650,10 +11732,12 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
                 break;
             default:
             case 0x0: /* FMAXNM */
+            case 0x1: /* FMLA */
             case 0x2: /* FADD */
             case 0x3: /* FMULX */
             case 0x6: /* FMAX */
             case 0x8: /* FMINNM */
+            case 0x9: /* FMLS */
             case 0xa: /* FSUB */
             case 0xe: /* FMIN */
             case 0x13: /* FMUL */
@@ -12874,10 +12958,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     case 0x0c: /* SQDMULH */
     case 0x0d: /* SQRDMULH */
         break;
-    case 0x01: /* FMLA */
-    case 0x05: /* FMLS */
-        is_fp = 1;
-        break;
     case 0x1d: /* SQRDMLAH */
     case 0x1f: /* SQRDMLSH */
         if (!dc_isar_feature(aa64_rdm, s)) {
@@ -12944,6 +13024,8 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
         /* is_fp, but we pass tcg_env not fp_status.  */
         break;
     default:
+    case 0x01: /* FMLA */
+    case 0x05: /* FMLS */
     case 0x09: /* FMUL */
     case 0x19: /* FMULX */
         unallocated_encoding(s);
@@ -12952,20 +13034,8 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
 
     switch (is_fp) {
     case 1: /* normal fp */
-        /* convert insn encoded size to MemOp size */
-        switch (size) {
-        case 0: /* half-precision */
-            size = MO_16;
-            is_fp16 = true;
-            break;
-        case MO_32: /* single precision */
-        case MO_64: /* double precision */
-            break;
-        default:
-            unallocated_encoding(s);
-            return;
-        }
-        break;
+        unallocated_encoding(s); /* in decodetree */
+        return;
 
     case 2: /* complex fp */
         /* Each indexable element is a complex pair.  */
@@ -13144,38 +13214,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     }
 
     if (size == 3) {
-        TCGv_i64 tcg_idx = tcg_temp_new_i64();
-        int pass;
-
-        assert(is_fp && is_q && !is_long);
-
-        read_vec_element(s, tcg_idx, rm, index, MO_64);
-
-        for (pass = 0; pass < (is_scalar ? 1 : 2); pass++) {
-            TCGv_i64 tcg_op = tcg_temp_new_i64();
-            TCGv_i64 tcg_res = tcg_temp_new_i64();
-
-            read_vec_element(s, tcg_op, rn, pass, MO_64);
-
-            switch (16 * u + opcode) {
-            case 0x05: /* FMLS */
-                /* As usual for ARM, separate negation for fused multiply-add */
-                gen_vfp_negd(tcg_op, tcg_op);
-                /* fall through */
-            case 0x01: /* FMLA */
-                read_vec_element(s, tcg_res, rd, pass, MO_64);
-                gen_helper_vfp_muladdd(tcg_res, tcg_op, tcg_idx, tcg_res, fpst);
-                break;
-            default:
-            case 0x09: /* FMUL */
-            case 0x19: /* FMULX */
-                g_assert_not_reached();
-            }
-
-            write_vec_element(s, tcg_res, rd, pass, MO_64);
-        }
-
-        clear_vec_high(s, !is_scalar, rd);
+        g_assert_not_reached();
     } else if (!is_long) {
         /* 32 bit floating point, or 16 or 32 bit integer.
          * For the 16 bit scalar case we use the usual Neon helpers and
@@ -13231,38 +13270,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
                 genfn(tcg_res, tcg_op, tcg_res);
                 break;
             }
-            case 0x05: /* FMLS */
-            case 0x01: /* FMLA */
-                read_vec_element_i32(s, tcg_res, rd, pass,
-                                     is_scalar ? size : MO_32);
-                switch (size) {
-                case 1:
-                    if (opcode == 0x5) {
-                        /* As usual for ARM, separate negation for fused
-                         * multiply-add */
-                        tcg_gen_xori_i32(tcg_op, tcg_op, 0x80008000);
-                    }
-                    if (is_scalar) {
-                        gen_helper_advsimd_muladdh(tcg_res, tcg_op, tcg_idx,
-                                                   tcg_res, fpst);
-                    } else {
-                        gen_helper_advsimd_muladd2h(tcg_res, tcg_op, tcg_idx,
-                                                    tcg_res, fpst);
-                    }
-                    break;
-                case 2:
-                    if (opcode == 0x5) {
-                        /* As usual for ARM, separate negation for
-                         * fused multiply-add */
-                        tcg_gen_xori_i32(tcg_op, tcg_op, 0x80000000);
-                    }
-                    gen_helper_vfp_muladds(tcg_res, tcg_op, tcg_idx,
-                                           tcg_res, fpst);
-                    break;
-                default:
-                    g_assert_not_reached();
-                }
-                break;
             case 0x0c: /* SQDMULH */
                 if (size == 1) {
                     gen_helper_neon_qdmulh_s16(tcg_res, tcg_env,
@@ -13304,6 +13311,8 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
                 }
                 break;
             default:
+            case 0x01: /* FMLA */
+            case 0x05: /* FMLS */
             case 0x09: /* FMUL */
             case 0x19: /* FMULX */
                 g_assert_not_reached();
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 99ef676071..b925b9f21b 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1309,6 +1309,12 @@ static float32 float32_muladd_f(float32 dest, float32 op1, float32 op2,
     return float32_muladd(op1, op2, dest, 0, stat);
 }
 
+static float64 float64_muladd_f(float64 dest, float64 op1, float64 op2,
+                                 float_status *stat)
+{
+    return float64_muladd(op1, op2, dest, 0, stat);
+}
+
 static float16 float16_mulsub_f(float16 dest, float16 op1, float16 op2,
                                  float_status *stat)
 {
@@ -1321,6 +1327,12 @@ static float32 float32_mulsub_f(float32 dest, float32 op1, float32 op2,
     return float32_muladd(float32_chs(op1), op2, dest, 0, stat);
 }
 
+static float64 float64_mulsub_f(float64 dest, float64 op1, float64 op2,
+                                 float_status *stat)
+{
+    return float64_muladd(float64_chs(op1), op2, dest, 0, stat);
+}
+
 #define DO_MULADD(NAME, FUNC, TYPE)                                     \
 void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
 {                                                                          \
@@ -1340,9 +1352,11 @@ DO_MULADD(gvec_fmls_s, float32_mulsub_nf, float32)
 
 DO_MULADD(gvec_vfma_h, float16_muladd_f, float16)
 DO_MULADD(gvec_vfma_s, float32_muladd_f, float32)
+DO_MULADD(gvec_vfma_d, float64_muladd_f, float64)
 
 DO_MULADD(gvec_vfms_h, float16_mulsub_f, float16)
 DO_MULADD(gvec_vfms_s, float32_mulsub_f, float32)
+DO_MULADD(gvec_vfms_d, float64_mulsub_f, float64)
 
 /* For the indexed ops, SVE applies the index per 128-bit vector segment.
  * For AdvSIMD, there is of course only one such vector segment.
-- 
2.34.1


