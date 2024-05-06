Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787B6C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 01:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mmr-0008KV-55; Sun, 05 May 2024 21:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmb-0007re-Rc
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:47 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmG-0002Us-G6
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:45 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2b387e2e355so912664a91.3
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 18:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714957463; x=1715562263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9VCvIsZYrn06ylNAlvpV61yky0eZcDWsjDXgULdmdx4=;
 b=l8FCuuMYlV3qpwzlKZUJ0vb8iLK+PILpq3OC65mN//hdGMWDL6M+vAUutFbWk6UJr0
 GnurEFiXZuBaTz7yEldhHgjAjmDF6vITfLr4dvvb5KOpbqFNLrV4tijcbOYboKulquue
 LHzD6N5q0iuyFKzg5485rhx4A4+fAH5MMN/qKc4VGahHiaFpYmLd1x1W1ZhP5UmPGIpP
 CNs6is7FexZFcTMHy3qoVXHad1bCDoEw3XuLgo+Ryol2+t7VhnWZoR9e/670VIHEAH6s
 30EBgNFqx7Z4XB/wfX94TaESnFsrpGSzhJ7wuikkrCA+nyFT9YTbfueEPaZoacYqug0a
 gbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714957463; x=1715562263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9VCvIsZYrn06ylNAlvpV61yky0eZcDWsjDXgULdmdx4=;
 b=BZWEQhjP4ObqaKJlX8k6JduNppS+CLuYeRhYyr0s4kHupTnKQOG4mzWZ2C3stoZwQi
 1U1Ayzy4kDXfjXlwoD90TBhCBOfxz69vJZf/yQp+KxYg74rFxUO+jz6ZAfSZh74unY6+
 eE0AfO912toC5NohzTxll0T5OXXjVcLzvkVZWXQIGyz4IHpAnd5TPVZuZhuOthf2gSwz
 kEqlUnack2f3KayI3dapdoK88DNoKidjle1um11Q1X7tRB3qOTKJZquI2jp3/na+JYw9
 Idp2uAg5i/+c4YKaO5JltIMVMRhAoLHqjKNH0AEt9NELsLZdMYc6uS9flc7k/rqxpZez
 wxVw==
X-Gm-Message-State: AOJu0Yx34wFx5ox/sEM1ZuSFzhRjWXHVZ0jQ3kxRRQ6x631ijTL+3H3y
 mTOdJdS+SgPr+ta9e6JN0zTW7DvIC1alqI4gTVG+hfIyAaILN3ta7K6OECVzLEte+vQJHWS0Ahj
 Y
X-Google-Smtp-Source: AGHT+IGLuyyCAB4+JvKKaPOml9ea/omZFC1vWCLt4JOa+GxwaySmVYYGlOepLr21SZ0bJcOjkZ0yDA==
X-Received: by 2002:a17:90b:191:b0:2b3:28be:ede3 with SMTP id
 t17-20020a17090b019100b002b328beede3mr7598860pjs.47.1714957462961; 
 Sun, 05 May 2024 18:04:22 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 pv7-20020a17090b3c8700b002a5f44353d2sm8958232pjb.7.2024.05.05.18.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 18:04:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 21/57] target/arm: Convert FADDP to decodetree
Date: Sun,  5 May 2024 18:03:27 -0700
Message-Id: <20240506010403.6204-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506010403.6204-1-richard.henderson@linaro.org>
References: <20240506010403.6204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

This fixes a bug in which scalar half-precision did not
diagnose sz == 1 as UNDEFINED.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h            |  4 ++
 target/arm/tcg/a64.decode      | 12 +++++
 target/arm/tcg/translate-a64.c | 87 ++++++++++++++++++++++++++--------
 target/arm/tcg/vec_helper.c    | 23 +++++++++
 4 files changed, 105 insertions(+), 21 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index ff6e3094f4..8441b49d1f 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -1048,6 +1048,10 @@ DEF_HELPER_FLAGS_5(gvec_uclamp_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_uclamp_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(gvec_faddp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_faddp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_faddp_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "tcg/helper-a64.h"
 #include "tcg/helper-sve.h"
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 8d0a6a147e..9d28cb5894 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -29,6 +29,7 @@
 &ri             rd imm
 &rri_sf         rd rn imm sf
 &i              imm
+&rr_e           rd rn esz
 &rrr_e          rd rn rm esz
 &rrx_e          rd rn rm idx esz
 &qrr_e          q rd rn esz
@@ -36,6 +37,9 @@
 &qrrx_e         q rd rn rm idx esz
 &qrrrr_e        q rd rn rm ra esz
 
+@rr_h           ........ ... ..... ...... rn:5 rd:5     &rr_e esz=1
+@rr_sd          ........ ... ..... ...... rn:5 rd:5     &rr_e esz=%esz_sd
+
 @rrr_h          ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=1
 @rrr_sd         ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=%esz_sd
 @rrr_hsd        ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=%esz_hsd
@@ -737,6 +741,11 @@ FRECPS_s        0101 1110 0.1 ..... 11111 1 ..... ..... @rrr_sd
 FRSQRTS_s       0101 1110 110 ..... 00111 1 ..... ..... @rrr_h
 FRSQRTS_s       0101 1110 1.1 ..... 11111 1 ..... ..... @rrr_sd
 
+### Advanced SIMD scalar pairwise
+
+FADDP_s         0101 1110 0011 0000 1101 10 ..... ..... @rr_h
+FADDP_s         0111 1110 0.11 0000 1101 10 ..... ..... @rr_sd
+
 ### Advanced SIMD three same
 
 FADD_v          0.00 1110 010 ..... 00010 1 ..... ..... @qrrr_h
@@ -796,6 +805,9 @@ FRECPS_v        0.00 1110 0.1 ..... 11111 1 ..... ..... @qrrr_sd
 FRSQRTS_v       0.00 1110 110 ..... 00111 1 ..... ..... @qrrr_h
 FRSQRTS_v       0.00 1110 1.1 ..... 11111 1 ..... ..... @qrrr_sd
 
+FADDP_v         0.10 1110 010 ..... 00010 1 ..... ..... @qrrr_h
+FADDP_v         0.10 1110 0.1 ..... 11010 1 ..... ..... @qrrr_sd
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d5828ba8df..f5ee6145b1 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5211,6 +5211,13 @@ static gen_helper_gvec_3_ptr * const f_vector_frsqrts[3] = {
 };
 TRANS(FRSQRTS_v, do_fp3_vector, a, f_vector_frsqrts)
 
+static gen_helper_gvec_3_ptr * const f_vector_faddp[3] = {
+    gen_helper_gvec_faddp_h,
+    gen_helper_gvec_faddp_s,
+    gen_helper_gvec_faddp_d,
+};
+TRANS(FADDP_v, do_fp3_vector, a, f_vector_faddp)
+
 /*
  * Advanced SIMD scalar/vector x indexed element
  */
@@ -5396,6 +5403,56 @@ static bool do_fmla_vector_idx(DisasContext *s, arg_qrrx_e *a, bool neg)
 TRANS(FMLA_vi, do_fmla_vector_idx, a, false)
 TRANS(FMLS_vi, do_fmla_vector_idx, a, true)
 
+/*
+ * Advanced SIMD scalar pairwise
+ */
+
+static bool do_fp3_scalar_pair(DisasContext *s, arg_rr_e *a, const FPScalar *f)
+{
+    switch (a->esz) {
+    case MO_64:
+        if (fp_access_check(s)) {
+            TCGv_i64 t0 = tcg_temp_new_i64();
+            TCGv_i64 t1 = tcg_temp_new_i64();
+
+            read_vec_element(s, t0, a->rn, 0, MO_64);
+            read_vec_element(s, t1, a->rn, 1, MO_64);
+            f->gen_d(t0, t0, t1, fpstatus_ptr(FPST_FPCR));
+            write_fp_dreg(s, a->rd, t0);
+        }
+        break;
+    case MO_32:
+        if (fp_access_check(s)) {
+            TCGv_i32 t0 = tcg_temp_new_i32();
+            TCGv_i32 t1 = tcg_temp_new_i32();
+
+            read_vec_element_i32(s, t0, a->rn, 0, MO_32);
+            read_vec_element_i32(s, t1, a->rn, 1, MO_32);
+            f->gen_s(t0, t0, t1, fpstatus_ptr(FPST_FPCR));
+            write_fp_sreg(s, a->rd, t0);
+        }
+        break;
+    case MO_16:
+        if (!dc_isar_feature(aa64_fp16, s)) {
+            return false;
+        }
+        if (fp_access_check(s)) {
+            TCGv_i32 t0 = tcg_temp_new_i32();
+            TCGv_i32 t1 = tcg_temp_new_i32();
+
+            read_vec_element_i32(s, t0, a->rn, 0, MO_16);
+            read_vec_element_i32(s, t1, a->rn, 1, MO_16);
+            f->gen_h(t0, t0, t1, fpstatus_ptr(FPST_FPCR_F16));
+            write_fp_sreg(s, a->rd, t0);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return true;
+}
+
+TRANS(FADDP_s, do_fp3_scalar_pair, a, &f_scalar_fadd)
 
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
@@ -8354,7 +8411,6 @@ static void disas_simd_scalar_pairwise(DisasContext *s, uint32_t insn)
         fpst = NULL;
         break;
     case 0xc: /* FMAXNMP */
-    case 0xd: /* FADDP */
     case 0xf: /* FMAXP */
     case 0x2c: /* FMINNMP */
     case 0x2f: /* FMINP */
@@ -8377,6 +8433,7 @@ static void disas_simd_scalar_pairwise(DisasContext *s, uint32_t insn)
         fpst = fpstatus_ptr(size == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
         break;
     default:
+    case 0xd: /* FADDP */
         unallocated_encoding(s);
         return;
     }
@@ -8396,9 +8453,6 @@ static void disas_simd_scalar_pairwise(DisasContext *s, uint32_t insn)
         case 0xc: /* FMAXNMP */
             gen_helper_vfp_maxnumd(tcg_res, tcg_op1, tcg_op2, fpst);
             break;
-        case 0xd: /* FADDP */
-            gen_helper_vfp_addd(tcg_res, tcg_op1, tcg_op2, fpst);
-            break;
         case 0xf: /* FMAXP */
             gen_helper_vfp_maxd(tcg_res, tcg_op1, tcg_op2, fpst);
             break;
@@ -8409,6 +8463,7 @@ static void disas_simd_scalar_pairwise(DisasContext *s, uint32_t insn)
             gen_helper_vfp_mind(tcg_res, tcg_op1, tcg_op2, fpst);
             break;
         default:
+        case 0xd: /* FADDP */
             g_assert_not_reached();
         }
 
@@ -8426,9 +8481,6 @@ static void disas_simd_scalar_pairwise(DisasContext *s, uint32_t insn)
             case 0xc: /* FMAXNMP */
                 gen_helper_advsimd_maxnumh(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0xd: /* FADDP */
-                gen_helper_advsimd_addh(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0xf: /* FMAXP */
                 gen_helper_advsimd_maxh(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
@@ -8439,6 +8491,7 @@ static void disas_simd_scalar_pairwise(DisasContext *s, uint32_t insn)
                 gen_helper_advsimd_minh(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             default:
+            case 0xd: /* FADDP */
                 g_assert_not_reached();
             }
         } else {
@@ -8446,9 +8499,6 @@ static void disas_simd_scalar_pairwise(DisasContext *s, uint32_t insn)
             case 0xc: /* FMAXNMP */
                 gen_helper_vfp_maxnums(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0xd: /* FADDP */
-                gen_helper_vfp_adds(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0xf: /* FMAXP */
                 gen_helper_vfp_maxs(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
@@ -8459,6 +8509,7 @@ static void disas_simd_scalar_pairwise(DisasContext *s, uint32_t insn)
                 gen_helper_vfp_mins(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             default:
+            case 0xd: /* FADDP */
                 g_assert_not_reached();
             }
         }
@@ -10976,9 +11027,6 @@ static void handle_simd_3same_pair(DisasContext *s, int is_q, int u, int opcode,
             case 0x58: /* FMAXNMP */
                 gen_helper_vfp_maxnumd(tcg_res[pass], tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x5a: /* FADDP */
-                gen_helper_vfp_addd(tcg_res[pass], tcg_op1, tcg_op2, fpst);
-                break;
             case 0x5e: /* FMAXP */
                 gen_helper_vfp_maxd(tcg_res[pass], tcg_op1, tcg_op2, fpst);
                 break;
@@ -10989,6 +11037,7 @@ static void handle_simd_3same_pair(DisasContext *s, int is_q, int u, int opcode,
                 gen_helper_vfp_mind(tcg_res[pass], tcg_op1, tcg_op2, fpst);
                 break;
             default:
+            case 0x5a: /* FADDP */
                 g_assert_not_reached();
             }
         }
@@ -11046,9 +11095,6 @@ static void handle_simd_3same_pair(DisasContext *s, int is_q, int u, int opcode,
             case 0x58: /* FMAXNMP */
                 gen_helper_vfp_maxnums(tcg_res[pass], tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x5a: /* FADDP */
-                gen_helper_vfp_adds(tcg_res[pass], tcg_op1, tcg_op2, fpst);
-                break;
             case 0x5e: /* FMAXP */
                 gen_helper_vfp_maxs(tcg_res[pass], tcg_op1, tcg_op2, fpst);
                 break;
@@ -11059,6 +11105,7 @@ static void handle_simd_3same_pair(DisasContext *s, int is_q, int u, int opcode,
                 gen_helper_vfp_mins(tcg_res[pass], tcg_op1, tcg_op2, fpst);
                 break;
             default:
+            case 0x5a: /* FADDP */
                 g_assert_not_reached();
             }
 
@@ -11098,7 +11145,6 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
 
     switch (fpopcode) {
     case 0x58: /* FMAXNMP */
-    case 0x5a: /* FADDP */
     case 0x5e: /* FMAXP */
     case 0x78: /* FMINNMP */
     case 0x7e: /* FMINP */
@@ -11143,6 +11189,7 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
     case 0x3a: /* FSUB */
     case 0x3e: /* FMIN */
     case 0x3f: /* FRSQRTS */
+    case 0x5a: /* FADDP */
     case 0x5b: /* FMUL */
     case 0x5c: /* FCMGE */
     case 0x5d: /* FACGE */
@@ -11490,7 +11537,6 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
 
     switch (fpopcode) {
     case 0x10: /* FMAXNMP */
-    case 0x12: /* FADDP */
     case 0x16: /* FMAXP */
     case 0x18: /* FMINNMP */
     case 0x1e: /* FMINP */
@@ -11509,6 +11555,7 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
     case 0xa: /* FSUB */
     case 0xe: /* FMIN */
     case 0xf: /* FRSQRTS */
+    case 0x12: /* FADDP */
     case 0x13: /* FMUL */
     case 0x14: /* FCMGE */
     case 0x15: /* FACGE */
@@ -11550,9 +11597,6 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
                 gen_helper_advsimd_maxnumh(tcg_res[pass], tcg_op1, tcg_op2,
                                            fpst);
                 break;
-            case 0x12: /* FADDP */
-                gen_helper_advsimd_addh(tcg_res[pass], tcg_op1, tcg_op2, fpst);
-                break;
             case 0x16: /* FMAXP */
                 gen_helper_advsimd_maxh(tcg_res[pass], tcg_op1, tcg_op2, fpst);
                 break;
@@ -11564,6 +11608,7 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
                 gen_helper_advsimd_minh(tcg_res[pass], tcg_op1, tcg_op2, fpst);
                 break;
             default:
+            case 0x12: /* FADDP */
                 g_assert_not_reached();
             }
         }
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index e9d7922f30..28989c7d7a 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2237,6 +2237,29 @@ DO_NEON_PAIRWISE(neon_pmin, min)
 
 #undef DO_NEON_PAIRWISE
 
+#define DO_3OP_PAIR(NAME, FUNC, TYPE, H) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
+{                                                                          \
+    ARMVectorReg scratch;                                                  \
+    intptr_t oprsz = simd_oprsz(desc);                                     \
+    intptr_t half = oprsz / sizeof(TYPE) / 2;                              \
+    TYPE *d = vd, *n = vn, *m = vm;                                        \
+    if (unlikely(d == m)) {                                                \
+        m = memcpy(&scratch, m, oprsz);                                    \
+    }                                                                      \
+    for (intptr_t i = 0; i < half; ++i) {                                  \
+        d[H(i)] = FUNC(n[H(i * 2)], n[H(i * 2 + 1)], stat);                \
+    }                                                                      \
+    for (intptr_t i = 0; i < half; ++i) {                                  \
+        d[H(i + half)] = FUNC(m[H(i * 2)], m[H(i * 2 + 1)], stat);         \
+    }                                                                      \
+    clear_tail(d, oprsz, simd_maxsz(desc));                                \
+}
+
+DO_3OP_PAIR(gvec_faddp_h, float16_add, float16, H2)
+DO_3OP_PAIR(gvec_faddp_s, float32_add, float32, H4)
+DO_3OP_PAIR(gvec_faddp_d, float64_add, float64, )
+
 #define DO_VCVT_FIXED(NAME, FUNC, TYPE)                                 \
     void HELPER(NAME)(void *vd, void *vn, void *stat, uint32_t desc)    \
     {                                                                   \
-- 
2.34.1


