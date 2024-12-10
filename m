Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F81E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL33B-0001el-O8; Tue, 10 Dec 2024 11:25:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL32h-0000Bh-GJ
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:24:59 -0500
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL32d-0007de-Dg
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:24:59 -0500
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-3022c61557cso17047831fa.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847893; x=1734452693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R5bEIdy5EcFEcDttJZgVYPiO4o+GM3mQeqtfWkezW2M=;
 b=EnBzFTaIRFuZD8z2fvb7NfqUjvxoOTJnJrdeBT2wO3qMa6fV1WMpwlQjSsVk4Swplp
 5eVGzGa2SXItNkniNkS/8BKK/YKJ9g/Z/+17iJswyH5xjdJN6gnkbD6AyLF7E+5/GNo1
 dfDq7aSGgaE/Rf2c1oDSUFc3/Q383/s3SSkvcX8t2HZWQF4jt1YgN8QPq9FkOvHZJUXI
 ayfqjkmHZoOv1IaLo/QUCY10IqaJ+4lX6A390Eq4J6jFW1VkWAuH+TrBd9uDUIuSIPIV
 6nStCFnBcFcG8hQ7RNa0hk6vPMg/T9PnnWojFO3SNgzO3EJDFMO/4S0XplMn1YsALf4Z
 ChSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847893; x=1734452693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R5bEIdy5EcFEcDttJZgVYPiO4o+GM3mQeqtfWkezW2M=;
 b=VzsDm57iXj1bWG3Ic+yknPgjUlM08V32oxIl/Iqa/0eCar8tS4ll4ZFXvepb/QWfrX
 dEyBIKBDt1jWhixnZ4auwxE22aOH6wKKczinS3SfQuIZZRmqs9JT0aODHItqgWdMqBnC
 fpgEXcaNB+hrBPQ4ig+UT27KlIVQxkfQrlkaMFRugd2srmbDlWqEwfIImC/6H25q/jqa
 dDUPhURmOt+SIkHIo76j/5SdhnhAhVUhgcYQEL+TAPoRVE+p2MsGuaDLwB9oVL8PiCRq
 ez3jRxhruYbKdM7OUdZEmDihaTEBBsgV8z836jV149C47cj1biNSA9CJzMvHYP9Sd8f1
 ZxGQ==
X-Gm-Message-State: AOJu0YxGPsvrkFpFeHNWd+VP1ZKx5T6WXCZbOqj0b7zvMXi5EqAbowi0
 W7gc8Uehm8s8oqyKsn8bbx30csPMZhuCGGYuBaSV/4tsGWFWiLWFVOaLXb5nmkG5PQs4QLYf+Zi
 GyjI/kHdR
X-Gm-Gg: ASbGncuDm4xs3d/rvFEP+mqcNBzpHJcc2KKeEsCN/C0QghxkEqCHr04XxYhdAOKdmnT
 8vsrhC5k2HiHyDyzHyFcejK1U3TMzbDL0e2IArIZuBJ/oEcK9nnPGVENXjUEAEjJYqoRbdgy6qh
 N0Z1MeS4EJY64vHpm6D3KhllYQYHpfN/VhNEmWoRy0k0BjXV3nFiZeDdEbCkRs+WUoSajKJ/kyc
 8YpW3Qt6f0lVjBzNsBhOtkUmbDyOl46IiLE4eH3g3Q4QG3S11UCmGmnQSg=
X-Google-Smtp-Source: AGHT+IHR8pEt9OxipV4vujgDcdzzKJx+ZuN2AVQQucFi6eBtvN0ZpZCYvmPWfemX8eyBFfSPj1yCcQ==
X-Received: by 2002:a05:6512:3b20:b0:540:1f67:6895 with SMTP id
 2adb3069b0e04-540240c9721mr1932023e87.18.1733847892819; 
 Tue, 10 Dec 2024 08:24:52 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5402960b0absm26024e87.102.2024.12.10.08.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:24:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 62/69] target/arm: Convert [US]CVTF (vector) to decodetree
Date: Tue, 10 Dec 2024 10:17:26 -0600
Message-ID: <20241210161733.1830573-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22f.google.com
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

Remove handle_simd_intfp_conv and handle_simd_shift_intfp_conv
as these were the last insns decoded by those functions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h            |   3 +
 target/arm/tcg/translate-a64.c | 201 ++++++---------------------------
 target/arm/tcg/vec_helper.c    |   7 +-
 target/arm/tcg/a64.decode      |  22 ++++
 4 files changed, 66 insertions(+), 167 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index f2cfee40de..b227ac54d9 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -658,6 +658,9 @@ DEF_HELPER_FLAGS_4(gvec_vcvt_uh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_vcvt_rz_hs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_vcvt_rz_hu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(gvec_vcvt_sd, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_ud, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(gvec_vcvt_rm_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_vcvt_rm_us, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_vcvt_rm_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 08f24908a4..0f94fa4fdc 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9293,141 +9293,44 @@ TRANS_FEAT(FRINT64Z_v, aa64_frint, do_fp1_vector, a,
            &f_scalar_frint64, FPROUNDING_ZERO)
 TRANS_FEAT(FRINT64X_v, aa64_frint, do_fp1_vector, a, &f_scalar_frint64, -1)
 
-/* Common vector code for handling integer to FP conversion */
-static void handle_simd_intfp_conv(DisasContext *s, int rd, int rn,
-                                   int elements, int is_signed,
-                                   int fracbits, int size)
+static bool do_gvec_op2_fpst(DisasContext *s, MemOp esz, bool is_q,
+                             int rd, int rn, int data,
+                             gen_helper_gvec_2_ptr * const fns[3])
 {
-    TCGv_ptr tcg_fpst = fpstatus_ptr(size == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
-    TCGv_i32 tcg_shift = NULL;
+    int check = fp_access_check_vector_hsd(s, is_q, esz);
+    TCGv_ptr fpst;
 
-    MemOp mop = size | (is_signed ? MO_SIGN : 0);
-    int pass;
-
-    if (fracbits || size == MO_64) {
-        tcg_shift = tcg_constant_i32(fracbits);
+    if (check <= 0) {
+        return check == 0;
     }
 
-    if (size == MO_64) {
-        TCGv_i64 tcg_int64 = tcg_temp_new_i64();
-        TCGv_i64 tcg_double = tcg_temp_new_i64();
-
-        for (pass = 0; pass < elements; pass++) {
-            read_vec_element(s, tcg_int64, rn, pass, mop);
-
-            if (is_signed) {
-                gen_helper_vfp_sqtod(tcg_double, tcg_int64,
-                                     tcg_shift, tcg_fpst);
-            } else {
-                gen_helper_vfp_uqtod(tcg_double, tcg_int64,
-                                     tcg_shift, tcg_fpst);
-            }
-            if (elements == 1) {
-                write_fp_dreg(s, rd, tcg_double);
-            } else {
-                write_vec_element(s, tcg_double, rd, pass, MO_64);
-            }
-        }
-    } else {
-        TCGv_i32 tcg_int32 = tcg_temp_new_i32();
-        TCGv_i32 tcg_float = tcg_temp_new_i32();
-
-        for (pass = 0; pass < elements; pass++) {
-            read_vec_element_i32(s, tcg_int32, rn, pass, mop);
-
-            switch (size) {
-            case MO_32:
-                if (fracbits) {
-                    if (is_signed) {
-                        gen_helper_vfp_sltos(tcg_float, tcg_int32,
-                                             tcg_shift, tcg_fpst);
-                    } else {
-                        gen_helper_vfp_ultos(tcg_float, tcg_int32,
-                                             tcg_shift, tcg_fpst);
-                    }
-                } else {
-                    if (is_signed) {
-                        gen_helper_vfp_sitos(tcg_float, tcg_int32, tcg_fpst);
-                    } else {
-                        gen_helper_vfp_uitos(tcg_float, tcg_int32, tcg_fpst);
-                    }
-                }
-                break;
-            case MO_16:
-                if (fracbits) {
-                    if (is_signed) {
-                        gen_helper_vfp_sltoh(tcg_float, tcg_int32,
-                                             tcg_shift, tcg_fpst);
-                    } else {
-                        gen_helper_vfp_ultoh(tcg_float, tcg_int32,
-                                             tcg_shift, tcg_fpst);
-                    }
-                } else {
-                    if (is_signed) {
-                        gen_helper_vfp_sitoh(tcg_float, tcg_int32, tcg_fpst);
-                    } else {
-                        gen_helper_vfp_uitoh(tcg_float, tcg_int32, tcg_fpst);
-                    }
-                }
-                break;
-            default:
-                g_assert_not_reached();
-            }
-
-            if (elements == 1) {
-                write_fp_sreg(s, rd, tcg_float);
-            } else {
-                write_vec_element_i32(s, tcg_float, rd, pass, size);
-            }
-        }
-    }
-
-    clear_vec_high(s, elements << size == 16, rd);
+    fpst = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
+    tcg_gen_gvec_2_ptr(vec_full_reg_offset(s, rd),
+                       vec_full_reg_offset(s, rn), fpst,
+                       is_q ? 16 : 8, vec_full_reg_size(s),
+                       data, fns[esz - 1]);
+    return true;
 }
 
-/* UCVTF/SCVTF - Integer to FP conversion */
-static void handle_simd_shift_intfp_conv(DisasContext *s, bool is_scalar,
-                                         bool is_q, bool is_u,
-                                         int immh, int immb, int opcode,
-                                         int rn, int rd)
-{
-    int size, elements, fracbits;
-    int immhb = immh << 3 | immb;
+static gen_helper_gvec_2_ptr * const f_scvtf_v[] = {
+    gen_helper_gvec_vcvt_sh,
+    gen_helper_gvec_vcvt_sf,
+    gen_helper_gvec_vcvt_sd,
+};
+TRANS(SCVTF_vi, do_gvec_op2_fpst,
+      a->esz, a->q, a->rd, a->rn, 0, f_scvtf_v)
+TRANS(SCVTF_vf, do_gvec_op2_fpst,
+      a->esz, a->q, a->rd, a->rn, a->shift, f_scvtf_v)
 
-    if (immh & 8) {
-        size = MO_64;
-        if (!is_scalar && !is_q) {
-            unallocated_encoding(s);
-            return;
-        }
-    } else if (immh & 4) {
-        size = MO_32;
-    } else if (immh & 2) {
-        size = MO_16;
-        if (!dc_isar_feature(aa64_fp16, s)) {
-            unallocated_encoding(s);
-            return;
-        }
-    } else {
-        /* immh == 0 would be a failure of the decode logic */
-        g_assert(immh == 1);
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (is_scalar) {
-        elements = 1;
-    } else {
-        elements = (8 << is_q) >> size;
-    }
-    fracbits = (16 << size) - immhb;
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    handle_simd_intfp_conv(s, rd, rn, elements, !is_u, fracbits, size);
-}
+static gen_helper_gvec_2_ptr * const f_ucvtf_v[] = {
+    gen_helper_gvec_vcvt_uh,
+    gen_helper_gvec_vcvt_uf,
+    gen_helper_gvec_vcvt_ud,
+};
+TRANS(UCVTF_vi, do_gvec_op2_fpst,
+      a->esz, a->q, a->rd, a->rn, 0, f_ucvtf_v)
+TRANS(UCVTF_vf, do_gvec_op2_fpst,
+      a->esz, a->q, a->rd, a->rn, a->shift, f_ucvtf_v)
 
 /* FCVTZS, FVCVTZU - FP to fixedpoint conversion */
 static void handle_simd_shift_fpint_conv(DisasContext *s, bool is_scalar,
@@ -9878,10 +9781,6 @@ static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x1c: /* SCVTF / UCVTF */
-        handle_simd_shift_intfp_conv(s, false, is_q, is_u, immh, immb,
-                                     opcode, rn, rd);
-        break;
     case 0x1f: /* FCVTZS/ FCVTZU */
         handle_simd_shift_fpint_conv(s, false, is_q, is_u, immh, immb, rn, rd);
         return;
@@ -9899,6 +9798,7 @@ static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
     case 0x12: /* SQSHRN / UQSHRN */
     case 0x13: /* SQRSHRN / UQRSHRN */
     case 0x14: /* SSHLL / USHLL */
+    case 0x1c: /* SCVTF / UCVTF */
         unallocated_encoding(s);
         return;
     }
@@ -9978,21 +9878,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         opcode |= (extract32(size, 1, 1) << 5) | (u << 6);
         size = is_double ? 3 : 2;
         switch (opcode) {
-        case 0x1d: /* SCVTF */
-        case 0x5d: /* UCVTF */
-        {
-            bool is_signed = (opcode == 0x1d) ? true : false;
-            int elements = is_double ? 2 : is_q ? 4 : 2;
-            if (is_double && !is_q) {
-                unallocated_encoding(s);
-                return;
-            }
-            if (!fp_access_check(s)) {
-                return;
-            }
-            handle_simd_intfp_conv(s, rd, rn, elements, is_signed, 0, size);
-            return;
-        }
         case 0x2c: /* FCMGT (zero) */
         case 0x2d: /* FCMEQ (zero) */
         case 0x2e: /* FCMLT (zero) */
@@ -10075,6 +9960,8 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         case 0x1f: /* FRINT64Z */
         case 0x5e: /* FRINT32X */
         case 0x5f: /* FRINT64X */
+        case 0x1d: /* SCVTF */
+        case 0x5d: /* UCVTF */
             unallocated_encoding(s);
             return;
         }
@@ -10240,24 +10127,6 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
     fpop = deposit32(fpop, 6, 1, u);
 
     switch (fpop) {
-    case 0x1d: /* SCVTF */
-    case 0x5d: /* UCVTF */
-    {
-        int elements;
-
-        if (is_scalar) {
-            elements = 1;
-        } else {
-            elements = (is_q ? 8 : 4);
-        }
-
-        if (!fp_access_check(s)) {
-            return;
-        }
-        handle_simd_intfp_conv(s, rd, rn, elements, !u, 0, MO_16);
-        return;
-    }
-    break;
     case 0x2c: /* FCMGT (zero) */
     case 0x2d: /* FCMEQ (zero) */
     case 0x2e: /* FCMLT (zero) */
@@ -10311,6 +10180,8 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
     case 0x58: /* FRINTA */
     case 0x59: /* FRINTX */
     case 0x79: /* FRINTI */
+    case 0x1d: /* SCVTF */
+    case 0x5d: /* UCVTF */
         unallocated_encoding(s);
         return;
     }
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 282dba4bfd..aa85cea0ca 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2505,12 +2505,15 @@ DO_3OP_PAIR(gvec_uminp_s, MIN, uint32_t, H4)
         clear_tail(d, oprsz, simd_maxsz(desc));                         \
     }
 
+DO_VCVT_FIXED(gvec_vcvt_sd, helper_vfp_sqtod, uint64_t)
+DO_VCVT_FIXED(gvec_vcvt_ud, helper_vfp_uqtod, uint64_t)
 DO_VCVT_FIXED(gvec_vcvt_sf, helper_vfp_sltos, uint32_t)
 DO_VCVT_FIXED(gvec_vcvt_uf, helper_vfp_ultos, uint32_t)
-DO_VCVT_FIXED(gvec_vcvt_rz_fs, helper_vfp_tosls_round_to_zero, uint32_t)
-DO_VCVT_FIXED(gvec_vcvt_rz_fu, helper_vfp_touls_round_to_zero, uint32_t)
 DO_VCVT_FIXED(gvec_vcvt_sh, helper_vfp_shtoh, uint16_t)
 DO_VCVT_FIXED(gvec_vcvt_uh, helper_vfp_uhtoh, uint16_t)
+
+DO_VCVT_FIXED(gvec_vcvt_rz_fs, helper_vfp_tosls_round_to_zero, uint32_t)
+DO_VCVT_FIXED(gvec_vcvt_rz_fu, helper_vfp_touls_round_to_zero, uint32_t)
 DO_VCVT_FIXED(gvec_vcvt_rz_hs, helper_vfp_toshh_round_to_zero, uint16_t)
 DO_VCVT_FIXED(gvec_vcvt_rz_hu, helper_vfp_touhh_round_to_zero, uint16_t)
 
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 30e1834d99..4f832e7a4c 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1786,3 +1786,25 @@ FRINT32Z_v      0.00 1110 0.1 00001 11101 0 ..... .....     @qrr_sd
 FRINT32X_v      0.10 1110 0.1 00001 11101 0 ..... .....     @qrr_sd
 FRINT64Z_v      0.00 1110 0.1 00001 11111 0 ..... .....     @qrr_sd
 FRINT64X_v      0.10 1110 0.1 00001 11111 0 ..... .....     @qrr_sd
+
+SCVTF_vi        0.00 1110 011 11001 11011 0 ..... .....     @qrr_h
+SCVTF_vi        0.00 1110 0.1 00001 11011 0 ..... .....     @qrr_sd
+
+UCVTF_vi        0.10 1110 011 11001 11011 0 ..... .....     @qrr_h
+UCVTF_vi        0.10 1110 0.1 00001 11011 0 ..... .....     @qrr_sd
+
+&fcvt_q         rd rn esz q shift
+@fcvtq_h        . q:1 . ...... 001 .... ...... rn:5 rd:5    \
+                &fcvt_q esz=1 shift=%fcvt_f_sh_h
+@fcvtq_s        . q:1 . ...... 01 ..... ...... rn:5 rd:5    \
+                &fcvt_q esz=2 shift=%fcvt_f_sh_s
+@fcvtq_d        . q:1 . ...... 1 ...... ...... rn:5 rd:5    \
+                &fcvt_q esz=3 shift=%fcvt_f_sh_d
+
+SCVTF_vf        0.00 11110 ....... 111001 ..... .....       @fcvtq_h
+SCVTF_vf        0.00 11110 ....... 111001 ..... .....       @fcvtq_s
+SCVTF_vf        0.00 11110 ....... 111001 ..... .....       @fcvtq_d
+
+UCVTF_vf        0.10 11110 ....... 111001 ..... .....       @fcvtq_h
+UCVTF_vf        0.10 11110 ....... 111001 ..... .....       @fcvtq_s
+UCVTF_vf        0.10 11110 ....... 111001 ..... .....       @fcvtq_d
-- 
2.43.0


