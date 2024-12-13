Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0E6E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9aJ-0000II-Oe; Fri, 13 Dec 2024 12:36:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Y3-0008Hj-Mq
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:57 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xr-0001iA-Od
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:54 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-385de9f789cso1544552f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111221; x=1734716021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g1PAJ+d8UdzvWmvOdM++O7RIAodxM1LV8e64w1h0QTA=;
 b=GOiBtpAiezYkW5w+8xBUnryyqrmVzfty066Qo5e6e4mnr6soTkHqgNWYmvcWuMzrgD
 21ZIzvmem1Wpu/VMC2EbcierfXejnxIYbTWBT/d5/rE7UgaUXbpzR/TFo1CzfczPNXO6
 sSzHu8NEhbmpNIO9uNfwNvIkb4+/p5O8GLZm8TOchpgnp/SMRgotqgB6bji+XXDp8+4m
 EPcx87lMCaVThJ5lEzT5P7iHenEZHr3kWCjVp1IS28MT68J/Rj7UfuzuPs1TVfcuXLjK
 ljypWHF6moT4SwFYrFCFWa9CJPhZiXB98sSHu7Vt2rFeL0qmQaKIshDu23vDo8lNNhlo
 vyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111221; x=1734716021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g1PAJ+d8UdzvWmvOdM++O7RIAodxM1LV8e64w1h0QTA=;
 b=RHFvk4f3m/PeGJoNObrZVEoZxN1w+1rW5EWnEso+wRxuN4mtpcyFC8zlNnEUcuIpf1
 OGrmApxLRbmtjRaLedhx4Tt44wXqmV5OqsOoYUitayb31PkvhJKlPNvCRrwHEvJ//r/e
 68m1pkVkX3+6OboF4onrLJex/SRH5Fq1Z4TKnhCtOwbazt2uD4AxzRsKlVJ7d8k2oqaL
 ggcU2XPYB5Lx4/XjxMGptKPTZq6kBLaJ6TDkR8Nscl5lMfaynx+bFngwRnNX6L9+UMiF
 Rj08cWvbvUDHEeAxdjg22FtHHEaFXLXnTmEzgrLUCBI8AUIftoUhft4ClRlpdwI05wKL
 Moqg==
X-Gm-Message-State: AOJu0YwSY6DH9ny8YLF5wrmxzIQs0xk5wx1cjGgyNpzNIf/t+yyQ6mMM
 ZvpLKLc/lcW3qaLCsmQNeWS3nhHoxkmiTiADR7QyUjMIcfB7ArML2TWye2rSKxegmFF34Tbk5/k
 w
X-Gm-Gg: ASbGncuRmBrA7g2F0lOTyaGjExpyzDhf08gSQWK1JAPBQTPrLO/UqMoboP0uX0VuIFh
 zWnAfeptwZURA0xd7ssj7uOi0b9qecO4mQQdOXColqRorKb1w/a+BIR8p5OOQ2nQQhoqn70pBug
 FUcq1nrIiZhppTm1IcRQ6ObUIHcQ/9xK5QaFyIYMMGh8i3ilmJsP8iA4od6sGAYM0CZdGAj6wk4
 +jogXgx1kGNJzoFOjmm6wuRvlQqgp3erWUzflCC+SkTge/u4VllNUfEvxw+nQ==
X-Google-Smtp-Source: AGHT+IEl/hg0bh3FoDV1t5pmmIBMWoUNDa5JUcvlaQTf8U3rL8mZSRou58167xOYup+bjMiGyGjmhA==
X-Received: by 2002:a5d:59af:0:b0:385:efc7:932d with SMTP id
 ffacd0b85a97d-3888e0f47femr2817485f8f.46.1734111220850; 
 Fri, 13 Dec 2024 09:33:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 65/85] target/arm: Convert handle_2misc_fcmp_zero to decodetree
Date: Fri, 13 Dec 2024 17:32:09 +0000
Message-Id: <20241213173229.3308926-66-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This includes FCMEQ, FCMGT, FCMGE, FCMLT, FCMLE.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-66-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h            |   5 +
 target/arm/tcg/a64.decode      |  30 ++++
 target/arm/tcg/translate-a64.c | 249 +++++++++++++--------------------
 target/arm/tcg/vec_helper.c    |   4 +-
 4 files changed, 138 insertions(+), 150 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 64aa6034655..1132a5cab61 100644
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
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 05a0b844161..d1c4a330f2d 100644
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
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ec1ce44c4b3..1776862161a 100644
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
index bc752ff988b..ee847745173 100644
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
-- 
2.34.1


