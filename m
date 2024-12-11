Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42EBE77183
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPiO-0004Sq-N3; Wed, 11 Dec 2024 11:37:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPhx-00023a-DS
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:37:05 -0500
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPhu-0002NI-Sg
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:37:05 -0500
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6d91653e9d7so26364986d6.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733935022; x=1734539822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cRCBV/vxkr7Qx5oWfMmaKCyFFKH0t7hRxCOfnp+rU/M=;
 b=xeyzy9iDw5YW6MJukfjxJKLFXHreLC5UIwGZ+PV9DZpHTyrNv16V9L5LLnx24QDJMM
 xRzFGKWkvhNfjiL2zVdjkQrEtLeXkjIz2JDr9FH7qJ6w6S8pweo1P8UNE9O35q6msAYv
 KQWiVxqzMD9pW59SHHDt1NL6F7OdH4W/K6hTAj65KjB3KndPlM2EU4VrFBQg1fWRk3oO
 P+eouTaoTy/D2AVyIEHPwBJ/PZBhm7iVtQhk6rPaVe3Fen3sIrGq9UYRIprQslUDocAG
 0mIaI7K5bnL35LbqQX1j/D041OPta4Eb4O48/ODP2HpJwJZU25mMAnCCfdu6ztbz1rcU
 SFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733935022; x=1734539822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cRCBV/vxkr7Qx5oWfMmaKCyFFKH0t7hRxCOfnp+rU/M=;
 b=vhWrgA/hBfNbjYVBeeMPCq2hGyXFOGXLEjEgN5RjdaOA+KxePZDEjZBvgJHLMOJdcx
 /9OReBofG17cgpxB8n/Jr0CFDZofkGh8z1x676TvD2Pi/zd4HUkF1WHg6tLOhGxOJjGB
 /OXxf75AQHFjKrxRhJHf5wF5bWXQJQ5y417YZEF7q0H/mb6EFJ+IJyA/3jK9RzzWeHxC
 tp8Ho3NMOT3576+4YZJGF+gmcFlJ+kis7ltD6p95nnKzWFhHIJAO9M4f1YbAFC//O4xC
 +ZVpvnptA1YQ8RGPGt1vckM15pjxyERXbANqCtXmzPo8mVhukVSWzpYdO7DupHIIWW+T
 59jA==
X-Gm-Message-State: AOJu0YwdrEIRuJ5FZVgvNS/FMJ3r9hCxDL1TBAEJ3AnjlZgcCs2oH+5j
 K3b4sZAo4vXC/dT643pasG8nUaASgK+vUqHsIEgiwpArEDBzXUGtSB2dgpf70Aval7MmVyODhtx
 hrdcafoIG
X-Gm-Gg: ASbGnctXJ+ojysBr5EK0pSeY4d+CWQe1VVvbSWetfQpJumanuAq2yiyC+k7/zRKJHSO
 s+UiGIs6ovf4AzMwqgUW1847WJo6Blu3yP7mpMwVlYWemp9CwFaEHILz/7O4zgELhObHyLkuy02
 zNQ/eGGDeWiPpPp9xznop4v/4g4gb13MHzrTsGS63uk7u6LLCuhEiAd3NPf9WYwV3v3rwZPyHbu
 Sb18ysnjI+g3QxAqgdC0FKv0egbiwJc01lfUX2dI6CkEmZ1tRzBR4nj8WCq8w==
X-Google-Smtp-Source: AGHT+IHZ67AbcmA/Ioit3jBr5wAXceJMizLSKztag1JmxY5vqDBJOg0wk2Ym8V4Ep00nUrgYX8Z9DA==
X-Received: by 2002:ad4:5b88:0:b0:6d4:25c4:e772 with SMTP id
 6a1803df08f44-6d934be5282mr53506346d6.36.1733935021863; 
 Wed, 11 Dec 2024 08:37:01 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da675214sm71856276d6.11.2024.12.11.08.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:37:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 65/69] target/arm: Convert handle_2misc_fcmp_zero to
 decodetree
Date: Wed, 11 Dec 2024 10:30:32 -0600
Message-ID: <20241211163036.2297116-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2f.google.com
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

This includes FCMEQ, FCMGT, FCMGE, FCMLT, FCMLE.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h            |   5 +
 target/arm/tcg/translate-a64.c | 249 +++++++++++++--------------------
 target/arm/tcg/vec_helper.c    |   4 +-
 target/arm/tcg/a64.decode      |  30 ++++
 4 files changed, 138 insertions(+), 150 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 64aa603465..1132a5cab6 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -688,18 +688,23 @@ DEF_HELPER_FLAGS_4(gvec_frsqrte_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(gvec_fcgt0_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_fcgt0_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_fcgt0_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(gvec_fcge0_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_fcge0_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_fcge0_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(gvec_fceq0_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_fceq0_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_fceq0_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(gvec_fcle0_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_fcle0_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_fcle0_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(gvec_fclt0_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_fclt0_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_fclt0_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fadd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fadd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ec1ce44c4b..1776862161 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5250,6 +5250,61 @@ static const FPScalar f_scalar_frsqrts = {
 };
 TRANS(FRSQRTS_s, do_fp3_scalar, a, &f_scalar_frsqrts)
 
+static bool do_fcmp0_s(DisasContext *s, arg_rr_e *a,
+                       const FPScalar *f, bool swap)
+{
+    switch (a->esz) {
+    case MO_64:
+        if (fp_access_check(s)) {
+            TCGv_i64 t0 = read_fp_dreg(s, a->rn);
+            TCGv_i64 t1 = tcg_constant_i64(0);
+            if (swap) {
+                f->gen_d(t0, t1, t0, fpstatus_ptr(FPST_FPCR));
+            } else {
+                f->gen_d(t0, t0, t1, fpstatus_ptr(FPST_FPCR));
+            }
+            write_fp_dreg(s, a->rd, t0);
+        }
+        break;
+    case MO_32:
+        if (fp_access_check(s)) {
+            TCGv_i32 t0 = read_fp_sreg(s, a->rn);
+            TCGv_i32 t1 = tcg_constant_i32(0);
+            if (swap) {
+                f->gen_s(t0, t1, t0, fpstatus_ptr(FPST_FPCR));
+            } else {
+                f->gen_s(t0, t0, t1, fpstatus_ptr(FPST_FPCR));
+            }
+            write_fp_sreg(s, a->rd, t0);
+        }
+        break;
+    case MO_16:
+        if (!dc_isar_feature(aa64_fp16, s)) {
+            return false;
+        }
+        if (fp_access_check(s)) {
+            TCGv_i32 t0 = read_fp_hreg(s, a->rn);
+            TCGv_i32 t1 = tcg_constant_i32(0);
+            if (swap) {
+                f->gen_h(t0, t1, t0, fpstatus_ptr(FPST_FPCR_F16));
+            } else {
+                f->gen_h(t0, t0, t1, fpstatus_ptr(FPST_FPCR_F16));
+            }
+            write_fp_sreg(s, a->rd, t0);
+        }
+        break;
+    default:
+        return false;
+    }
+    return true;
+}
+
+TRANS(FCMEQ0_s, do_fcmp0_s, a, &f_scalar_fcmeq, false)
+TRANS(FCMGT0_s, do_fcmp0_s, a, &f_scalar_fcmgt, false)
+TRANS(FCMGE0_s, do_fcmp0_s, a, &f_scalar_fcmge, false)
+TRANS(FCMLT0_s, do_fcmp0_s, a, &f_scalar_fcmgt, true)
+TRANS(FCMLE0_s, do_fcmp0_s, a, &f_scalar_fcmge, true)
+
 static bool do_satacc_s(DisasContext *s, arg_rrr_e *a,
                 MemOp sgn_n, MemOp sgn_m,
                 void (*gen_bhs)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64, MemOp),
@@ -9381,134 +9436,40 @@ TRANS(FCVTAS_vi, do_gvec_op2_fpst,
 TRANS(FCVTAU_vi, do_gvec_op2_fpst,
       a->esz, a->q, a->rd, a->rn, float_round_ties_away, f_fcvt_u_vi)
 
-static void handle_2misc_fcmp_zero(DisasContext *s, int opcode,
-                                   bool is_scalar, bool is_u, bool is_q,
-                                   int size, int rn, int rd)
-{
-    bool is_double = (size == MO_64);
-    TCGv_ptr fpst;
+static gen_helper_gvec_2_ptr * const f_fceq0[] = {
+    gen_helper_gvec_fceq0_h,
+    gen_helper_gvec_fceq0_s,
+    gen_helper_gvec_fceq0_d,
+};
+TRANS(FCMEQ0_v, do_gvec_op2_fpst, a->esz, a->q, a->rd, a->rn, 0, f_fceq0)
 
-    if (!fp_access_check(s)) {
-        return;
-    }
+static gen_helper_gvec_2_ptr * const f_fcgt0[] = {
+    gen_helper_gvec_fcgt0_h,
+    gen_helper_gvec_fcgt0_s,
+    gen_helper_gvec_fcgt0_d,
+};
+TRANS(FCMGT0_v, do_gvec_op2_fpst, a->esz, a->q, a->rd, a->rn, 0, f_fcgt0)
 
-    fpst = fpstatus_ptr(size == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
+static gen_helper_gvec_2_ptr * const f_fcge0[] = {
+    gen_helper_gvec_fcge0_h,
+    gen_helper_gvec_fcge0_s,
+    gen_helper_gvec_fcge0_d,
+};
+TRANS(FCMGE0_v, do_gvec_op2_fpst, a->esz, a->q, a->rd, a->rn, 0, f_fcge0)
 
-    if (is_double) {
-        TCGv_i64 tcg_op = tcg_temp_new_i64();
-        TCGv_i64 tcg_zero = tcg_constant_i64(0);
-        TCGv_i64 tcg_res = tcg_temp_new_i64();
-        NeonGenTwoDoubleOpFn *genfn;
-        bool swap = false;
-        int pass;
+static gen_helper_gvec_2_ptr * const f_fclt0[] = {
+    gen_helper_gvec_fclt0_h,
+    gen_helper_gvec_fclt0_s,
+    gen_helper_gvec_fclt0_d,
+};
+TRANS(FCMLT0_v, do_gvec_op2_fpst, a->esz, a->q, a->rd, a->rn, 0, f_fclt0)
 
-        switch (opcode) {
-        case 0x2e: /* FCMLT (zero) */
-            swap = true;
-            /* fallthrough */
-        case 0x2c: /* FCMGT (zero) */
-            genfn = gen_helper_neon_cgt_f64;
-            break;
-        case 0x2d: /* FCMEQ (zero) */
-            genfn = gen_helper_neon_ceq_f64;
-            break;
-        case 0x6d: /* FCMLE (zero) */
-            swap = true;
-            /* fall through */
-        case 0x6c: /* FCMGE (zero) */
-            genfn = gen_helper_neon_cge_f64;
-            break;
-        default:
-            g_assert_not_reached();
-        }
-
-        for (pass = 0; pass < (is_scalar ? 1 : 2); pass++) {
-            read_vec_element(s, tcg_op, rn, pass, MO_64);
-            if (swap) {
-                genfn(tcg_res, tcg_zero, tcg_op, fpst);
-            } else {
-                genfn(tcg_res, tcg_op, tcg_zero, fpst);
-            }
-            write_vec_element(s, tcg_res, rd, pass, MO_64);
-        }
-
-        clear_vec_high(s, !is_scalar, rd);
-    } else {
-        TCGv_i32 tcg_op = tcg_temp_new_i32();
-        TCGv_i32 tcg_zero = tcg_constant_i32(0);
-        TCGv_i32 tcg_res = tcg_temp_new_i32();
-        NeonGenTwoSingleOpFn *genfn;
-        bool swap = false;
-        int pass, maxpasses;
-
-        if (size == MO_16) {
-            switch (opcode) {
-            case 0x2e: /* FCMLT (zero) */
-                swap = true;
-                /* fall through */
-            case 0x2c: /* FCMGT (zero) */
-                genfn = gen_helper_advsimd_cgt_f16;
-                break;
-            case 0x2d: /* FCMEQ (zero) */
-                genfn = gen_helper_advsimd_ceq_f16;
-                break;
-            case 0x6d: /* FCMLE (zero) */
-                swap = true;
-                /* fall through */
-            case 0x6c: /* FCMGE (zero) */
-                genfn = gen_helper_advsimd_cge_f16;
-                break;
-            default:
-                g_assert_not_reached();
-            }
-        } else {
-            switch (opcode) {
-            case 0x2e: /* FCMLT (zero) */
-                swap = true;
-                /* fall through */
-            case 0x2c: /* FCMGT (zero) */
-                genfn = gen_helper_neon_cgt_f32;
-                break;
-            case 0x2d: /* FCMEQ (zero) */
-                genfn = gen_helper_neon_ceq_f32;
-                break;
-            case 0x6d: /* FCMLE (zero) */
-                swap = true;
-                /* fall through */
-            case 0x6c: /* FCMGE (zero) */
-                genfn = gen_helper_neon_cge_f32;
-                break;
-            default:
-                g_assert_not_reached();
-            }
-        }
-
-        if (is_scalar) {
-            maxpasses = 1;
-        } else {
-            int vector_size = 8 << is_q;
-            maxpasses = vector_size >> size;
-        }
-
-        for (pass = 0; pass < maxpasses; pass++) {
-            read_vec_element_i32(s, tcg_op, rn, pass, size);
-            if (swap) {
-                genfn(tcg_res, tcg_zero, tcg_op, fpst);
-            } else {
-                genfn(tcg_res, tcg_op, tcg_zero, fpst);
-            }
-            if (is_scalar) {
-                write_fp_sreg(s, rd, tcg_res);
-            } else {
-                write_vec_element_i32(s, tcg_res, rd, pass, size);
-            }
-        }
-
-        if (!is_scalar) {
-            clear_vec_high(s, is_q, rd);
-        }
-    }
-}
+static gen_helper_gvec_2_ptr * const f_fcle0[] = {
+    gen_helper_gvec_fcle0_h,
+    gen_helper_gvec_fcle0_s,
+    gen_helper_gvec_fcle0_d,
+};
+TRANS(FCMLE0_v, do_gvec_op2_fpst, a->esz, a->q, a->rd, a->rn, 0, f_fcle0)
 
 static void handle_2misc_reciprocal(DisasContext *s, int opcode,
                                     bool is_scalar, bool is_u, bool is_q,
@@ -9607,13 +9568,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
         opcode |= (extract32(size, 1, 1) << 5) | (u << 6);
         size = extract32(size, 0, 1) ? 3 : 2;
         switch (opcode) {
-        case 0x2c: /* FCMGT (zero) */
-        case 0x2d: /* FCMEQ (zero) */
-        case 0x2e: /* FCMLT (zero) */
-        case 0x6c: /* FCMGE (zero) */
-        case 0x6d: /* FCMLE (zero) */
-            handle_2misc_fcmp_zero(s, opcode, true, u, true, size, rn, rd);
-            return;
         case 0x3d: /* FRECPE */
         case 0x3f: /* FRECPX */
         case 0x7d: /* FRSQRTE */
@@ -9635,6 +9589,11 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
         case 0x56: /* FCVTXN, FCVTXN2 */
         case 0x1d: /* SCVTF */
         case 0x5d: /* UCVTF */
+        case 0x2c: /* FCMGT (zero) */
+        case 0x2d: /* FCMEQ (zero) */
+        case 0x2e: /* FCMLT (zero) */
+        case 0x6c: /* FCMGE (zero) */
+        case 0x6d: /* FCMLE (zero) */
         default:
             unallocated_encoding(s);
             return;
@@ -9729,17 +9688,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         opcode |= (extract32(size, 1, 1) << 5) | (u << 6);
         size = is_double ? 3 : 2;
         switch (opcode) {
-        case 0x2c: /* FCMGT (zero) */
-        case 0x2d: /* FCMEQ (zero) */
-        case 0x2e: /* FCMLT (zero) */
-        case 0x6c: /* FCMGE (zero) */
-        case 0x6d: /* FCMLE (zero) */
-            if (size == 3 && !is_q) {
-                unallocated_encoding(s);
-                return;
-            }
-            handle_2misc_fcmp_zero(s, opcode, false, u, is_q, size, rn, rd);
-            return;
         case 0x3c: /* URECPE */
             if (size == 3) {
                 unallocated_encoding(s);
@@ -9799,6 +9747,11 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         case 0x7b: /* FCVTZU */
         case 0x5c: /* FCVTAU */
         case 0x1c: /* FCVTAS */
+        case 0x2c: /* FCMGT (zero) */
+        case 0x2d: /* FCMEQ (zero) */
+        case 0x2e: /* FCMLT (zero) */
+        case 0x6c: /* FCMGE (zero) */
+        case 0x6d: /* FCMLE (zero) */
             unallocated_encoding(s);
             return;
         }
@@ -9939,13 +9892,6 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
     fpop = deposit32(fpop, 6, 1, u);
 
     switch (fpop) {
-    case 0x2c: /* FCMGT (zero) */
-    case 0x2d: /* FCMEQ (zero) */
-    case 0x2e: /* FCMLT (zero) */
-    case 0x6c: /* FCMGE (zero) */
-    case 0x6d: /* FCMLE (zero) */
-        handle_2misc_fcmp_zero(s, fpop, is_scalar, 0, is_q, MO_16, rn, rd);
-        return;
     case 0x3d: /* FRECPE */
     case 0x3f: /* FRECPX */
         break;
@@ -9974,6 +9920,11 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
     case 0x5c: /* FCVTAU */
     case 0x7a: /* FCVTPU */
     case 0x7b: /* FCVTZU */
+    case 0x2c: /* FCMGT (zero) */
+    case 0x2d: /* FCMEQ (zero) */
+    case 0x2e: /* FCMLT (zero) */
+    case 0x6c: /* FCMGE (zero) */
+    case 0x6d: /* FCMLE (zero) */
         unallocated_encoding(s);
         return;
     }
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 0aee38a3bc..0f4b5670f3 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1253,8 +1253,10 @@ DO_2OP(gvec_touszh, vfp_touszh, float16)
 #define DO_2OP_CMP0(FN, CMPOP, DIRN)                    \
     WRAP_CMP0_##DIRN(FN, CMPOP, float16)                \
     WRAP_CMP0_##DIRN(FN, CMPOP, float32)                \
+    WRAP_CMP0_##DIRN(FN, CMPOP, float64)                \
     DO_2OP(gvec_f##FN##0_h, float16_##FN##0, float16)   \
-    DO_2OP(gvec_f##FN##0_s, float32_##FN##0, float32)
+    DO_2OP(gvec_f##FN##0_s, float32_##FN##0, float32)   \
+    DO_2OP(gvec_f##FN##0_d, float64_##FN##0, float64)
 
 DO_2OP_CMP0(cgt, cgt, FWD)
 DO_2OP_CMP0(cge, cge, FWD)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 05a0b84416..d1c4a330f2 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1652,6 +1652,21 @@ UQXTN_s         0111 1110 ..1 00001 01001 0 ..... .....     @rr_e
 
 FCVTXN_s        0111 1110 011 00001 01101 0 ..... .....     @rr_s
 
+FCMGT0_s        0101 1110 111 11000 11001 0 ..... .....     @rr_h
+FCMGT0_s        0101 1110 1.1 00000 11001 0 ..... .....     @rr_sd
+
+FCMGE0_s        0111 1110 111 11000 11001 0 ..... .....     @rr_h
+FCMGE0_s        0111 1110 1.1 00000 11001 0 ..... .....     @rr_sd
+
+FCMEQ0_s        0101 1110 111 11000 11011 0 ..... .....     @rr_h
+FCMEQ0_s        0101 1110 1.1 00000 11011 0 ..... .....     @rr_sd
+
+FCMLE0_s        0111 1110 111 11000 11011 0 ..... .....     @rr_h
+FCMLE0_s        0111 1110 1.1 00000 11011 0 ..... .....     @rr_sd
+
+FCMLT0_s        0101 1110 111 11000 11101 0 ..... .....     @rr_h
+FCMLT0_s        0101 1110 1.1 00000 11101 0 ..... .....     @rr_sd
+
 @icvt_h         . ....... .. ...... ...... rn:5 rd:5 \
                 &fcvt sf=0 esz=1 shift=0
 @icvt_sd        . ....... .. ...... ...... rn:5 rd:5 \
@@ -1818,6 +1833,21 @@ FCVTAS_vi       0.00 1110 0.1 00001 11001 0 ..... .....     @qrr_sd
 FCVTAU_vi       0.10 1110 011 11001 11001 0 ..... .....     @qrr_h
 FCVTAU_vi       0.10 1110 0.1 00001 11001 0 ..... .....     @qrr_sd
 
+FCMGT0_v        0.00 1110 111 11000 11001 0 ..... .....     @qrr_h
+FCMGT0_v        0.00 1110 1.1 00000 11001 0 ..... .....     @qrr_sd
+
+FCMGE0_v        0.10 1110 111 11000 11001 0 ..... .....     @qrr_h
+FCMGE0_v        0.10 1110 1.1 00000 11001 0 ..... .....     @qrr_sd
+
+FCMEQ0_v        0.00 1110 111 11000 11011 0 ..... .....     @qrr_h
+FCMEQ0_v        0.00 1110 1.1 00000 11011 0 ..... .....     @qrr_sd
+
+FCMLE0_v        0.10 1110 111 11000 11011 0 ..... .....     @qrr_h
+FCMLE0_v        0.10 1110 1.1 00000 11011 0 ..... .....     @qrr_sd
+
+FCMLT0_v        0.00 1110 111 11000 11101 0 ..... .....     @qrr_h
+FCMLT0_v        0.00 1110 1.1 00000 11101 0 ..... .....     @qrr_sd
+
 &fcvt_q         rd rn esz q shift
 @fcvtq_h        . q:1 . ...... 001 .... ...... rn:5 rd:5    \
                 &fcvt_q esz=1 shift=%fcvt_f_sh_h
-- 
2.43.0


