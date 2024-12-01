Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1980BD49771
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlbF-0003Gu-F1; Sun, 01 Dec 2024 10:11:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlaJ-00080J-Re
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:10:10 -0500
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlaE-00058a-UC
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:10:05 -0500
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5f1ed6ee4d6so1300075eaf.2
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065800; x=1733670600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gP/Gp6RWB62+OxL43ZSrPl3XG8bW9n3m176Xut2w214=;
 b=jHH/s4tS4wdm+FSV0ehQooySdAmu1g7x33wKBmz1nmt6AxWd+yTN3NNnG/euTmTso6
 zW7udjJBFMq/460jxb8mpLI0J2okAZ9uxT00JBhdtaC7LcmKFu7YBaZsJKh3AmOf2wxz
 vqiqUwXTn226mDhvPgPpIpZoZKoGCZR2fpSULqi/bgLgqlEuMqMA9KEYeXRMnr/g1jA5
 dUqf+kdJJqkLN+Sp6W4YUdat7+Afvp0giCPxdZdv94yLH6VY0Ui+t4jGJWx2fQIq8HcH
 fFznXpNO5mSMxgXJverVdhVjYJsKCOgsnpm5gui+7T1E5DoNi1xcioiwYvxuvL33Xt2S
 0wOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065800; x=1733670600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gP/Gp6RWB62+OxL43ZSrPl3XG8bW9n3m176Xut2w214=;
 b=LgDQA/MolM521Mxz7DoRYHL39DIyi+SVPgSVn5pHV+l843/DnhSPo04aCfKbVrv+kY
 Vikw4nkvSuhZ+2i3nGowGJVwxLl5kFD91wqiBSTagQ1UQDs9wXkt5D+dfEpT6NpN3N4F
 PvgJWlCIASz2O+8JMyw1erosR0Vd2WxFxtbOdDy+QLWjWrDbunJg8eivtDZbeUYocDtw
 Ux6vuZqF44yHIJOUnQhoNSASjMKeOdrMTTtQVrN5oq2Jxxvi1/T+InVof1aKC/ANCUDM
 +aeK0rR/lrV7yy77vUkbPK9ltBpZv8bncSY1FfYD/eSNIqRwYuyp8YBK5akfYIbSMvj9
 BR5w==
X-Gm-Message-State: AOJu0YxXrnxTJspBOJwSVKrVZZZH6707LdmD0avlkP4u6T7s/a8bnp+N
 6sj010DkLzRq4XGri08VwqmJ22aq9ehOllEBe1R3OAm4RxvK7FRYxP7BtuEmpMCpfeeATJv4jqn
 nOn4=
X-Gm-Gg: ASbGncsesgMAzulBUM7UkxthxtsakVGly6wE0OxMg/qWLSbsJ39x4zlaFwcgZMN4Zma
 +Qyq9Kz32l5Xaz4+6v8YhhWNbNOkKd/1Jq5gr7ClW84H+14I3/Zi4y+WP4RZaT08BYPAnAZGDtV
 +EvIvYCFPE5U2yrdDLfR8iY9N7UR8zP8O1T045lBOFQFlyHszvmUypfdAaCsM1y7EbHHiSp0+uI
 wM2eAflsEoF3u7D54/+Jsbz45QtKlureYPAkDe+hgfmUbyHVpeprSBNjFmT9AT8yrZx7+X7mQKm
 SvRPjNw3/JgfxiUX1qGfYRgthCM2pOP4JrF4
X-Google-Smtp-Source: AGHT+IGWxTBuetnyeUdxnAqJGqKpDWE742WRDp8hRNCeW+vy3l6BQPzm0sl1R5P836KZLazUrXiv8Q==
X-Received: by 2002:a05:6820:553:b0:5ee:e270:87b with SMTP id
 006d021491bc7-5f20a20f46cmr13842204eaf.8.1733065800294; 
 Sun, 01 Dec 2024 07:10:00 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f21a4cd78fsm1807008eaf.32.2024.12.01.07.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:09:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 45/67] target/arm: Convert handle_2misc_pairwise to decodetree
Date: Sun,  1 Dec 2024 09:05:44 -0600
Message-ID: <20241201150607.12812-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
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

This includes SADDLP, UADDLP, SADALP, UADALP.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64.h    |  2 -
 target/arm/tcg/helper-a64.c    | 18 --------
 target/arm/tcg/translate-a64.c | 84 +++-------------------------------
 target/arm/tcg/a64.decode      |  5 ++
 4 files changed, 11 insertions(+), 98 deletions(-)

diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64.h
index f811bb85dc..ac7ca190fa 100644
--- a/target/arm/tcg/helper-a64.h
+++ b/target/arm/tcg/helper-a64.h
@@ -41,8 +41,6 @@ DEF_HELPER_FLAGS_3(recpsf_f64, TCG_CALL_NO_RWG, f64, f64, f64, ptr)
 DEF_HELPER_FLAGS_3(rsqrtsf_f16, TCG_CALL_NO_RWG, f16, f16, f16, ptr)
 DEF_HELPER_FLAGS_3(rsqrtsf_f32, TCG_CALL_NO_RWG, f32, f32, f32, ptr)
 DEF_HELPER_FLAGS_3(rsqrtsf_f64, TCG_CALL_NO_RWG, f64, f64, f64, ptr)
-DEF_HELPER_FLAGS_1(neon_addlp_u8, TCG_CALL_NO_RWG_SE, i64, i64)
-DEF_HELPER_FLAGS_1(neon_addlp_u16, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_FLAGS_2(frecpx_f64, TCG_CALL_NO_RWG, f64, f64, ptr)
 DEF_HELPER_FLAGS_2(frecpx_f32, TCG_CALL_NO_RWG, f32, f32, ptr)
 DEF_HELPER_FLAGS_2(frecpx_f16, TCG_CALL_NO_RWG, f16, f16, ptr)
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 9b3c407be3..3de564e0fe 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -306,24 +306,6 @@ float64 HELPER(rsqrtsf_f64)(float64 a, float64 b, void *fpstp)
     return float64_muladd(a, b, float64_three, float_muladd_halve_result, fpst);
 }
 
-uint64_t HELPER(neon_addlp_u8)(uint64_t a)
-{
-    uint64_t tmp;
-
-    tmp = a & 0x00ff00ff00ff00ffULL;
-    tmp += (a >> 8) & 0x00ff00ff00ff00ffULL;
-    return tmp;
-}
-
-uint64_t HELPER(neon_addlp_u16)(uint64_t a)
-{
-    uint64_t tmp;
-
-    tmp = a & 0x0000ffff0000ffffULL;
-    tmp += (a >> 16) & 0x0000ffff0000ffffULL;
-    return tmp;
-}
-
 /* Floating-point reciprocal exponent - see FPRecpX in ARM ARM */
 uint32_t HELPER(frecpx_f16)(uint32_t a, void *fpstp)
 {
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 11ccdb2d08..c6cc1c9e09 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8960,6 +8960,10 @@ static bool do_gvec_fn2_bhs(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
 TRANS(CLS_v, do_gvec_fn2_bhs, a, gen_gvec_cls)
 TRANS(CLZ_v, do_gvec_fn2_bhs, a, gen_gvec_clz)
 TRANS(REV64_v, do_gvec_fn2_bhs, a, gen_gvec_rev64)
+TRANS(SADDLP_v, do_gvec_fn2_bhs, a, gen_gvec_saddlp)
+TRANS(UADDLP_v, do_gvec_fn2_bhs, a, gen_gvec_uaddlp)
+TRANS(SADALP_v, do_gvec_fn2_bhs, a, gen_gvec_sadalp)
+TRANS(UADALP_v, do_gvec_fn2_bhs, a, gen_gvec_uadalp)
 
 /* Common vector code for handling integer to FP conversion */
 static void handle_simd_intfp_conv(DisasContext *s, int rd, int rn,
@@ -9889,73 +9893,6 @@ static void handle_2misc_widening(DisasContext *s, int opcode, bool is_q,
     }
 }
 
-static void handle_2misc_pairwise(DisasContext *s, int opcode, bool u,
-                                  bool is_q, int size, int rn, int rd)
-{
-    /* Implement the pairwise operations from 2-misc:
-     * SADDLP, UADDLP, SADALP, UADALP.
-     * These all add pairs of elements in the input to produce a
-     * double-width result element in the output (possibly accumulating).
-     */
-    bool accum = (opcode == 0x6);
-    int maxpass = is_q ? 2 : 1;
-    int pass;
-    TCGv_i64 tcg_res[2];
-
-    if (size == 2) {
-        /* 32 + 32 -> 64 op */
-        MemOp memop = size + (u ? 0 : MO_SIGN);
-
-        for (pass = 0; pass < maxpass; pass++) {
-            TCGv_i64 tcg_op1 = tcg_temp_new_i64();
-            TCGv_i64 tcg_op2 = tcg_temp_new_i64();
-
-            tcg_res[pass] = tcg_temp_new_i64();
-
-            read_vec_element(s, tcg_op1, rn, pass * 2, memop);
-            read_vec_element(s, tcg_op2, rn, pass * 2 + 1, memop);
-            tcg_gen_add_i64(tcg_res[pass], tcg_op1, tcg_op2);
-            if (accum) {
-                read_vec_element(s, tcg_op1, rd, pass, MO_64);
-                tcg_gen_add_i64(tcg_res[pass], tcg_res[pass], tcg_op1);
-            }
-        }
-    } else {
-        for (pass = 0; pass < maxpass; pass++) {
-            TCGv_i64 tcg_op = tcg_temp_new_i64();
-            NeonGenOne64OpFn *genfn;
-            static NeonGenOne64OpFn * const fns[2][2] = {
-                { gen_helper_neon_addlp_s8,  gen_helper_neon_addlp_u8 },
-                { gen_helper_neon_addlp_s16,  gen_helper_neon_addlp_u16 },
-            };
-
-            genfn = fns[size][u];
-
-            tcg_res[pass] = tcg_temp_new_i64();
-
-            read_vec_element(s, tcg_op, rn, pass, MO_64);
-            genfn(tcg_res[pass], tcg_op);
-
-            if (accum) {
-                read_vec_element(s, tcg_op, rd, pass, MO_64);
-                if (size == 0) {
-                    gen_helper_neon_addl_u16(tcg_res[pass],
-                                             tcg_res[pass], tcg_op);
-                } else {
-                    gen_helper_neon_addl_u32(tcg_res[pass],
-                                             tcg_res[pass], tcg_op);
-                }
-            }
-        }
-    }
-    if (!is_q) {
-        tcg_res[1] = tcg_constant_i64(0);
-    }
-    for (pass = 0; pass < 2; pass++) {
-        write_vec_element(s, tcg_res[pass], rd, pass, MO_64);
-    }
-}
-
 static void handle_shll(DisasContext *s, bool is_q, int size, int rn, int rd)
 {
     /* Implement SHLL and SHLL2 */
@@ -10015,17 +9952,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
 
         handle_2misc_narrow(s, false, opcode, u, is_q, size, rn, rd);
         return;
-    case 0x2: /* SADDLP, UADDLP */
-    case 0x6: /* SADALP, UADALP */
-        if (size == 3) {
-            unallocated_encoding(s);
-            return;
-        }
-        if (!fp_access_check(s)) {
-            return;
-        }
-        handle_2misc_pairwise(s, opcode, u, is_q, size, rn, rd);
-        return;
     case 0x13: /* SHLL, SHLL2 */
         if (u == 0 || size == 3) {
             unallocated_encoding(s);
@@ -10207,9 +10133,11 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     default:
     case 0x0: /* REV64 */
     case 0x1: /* REV16, REV32 */
+    case 0x2: /* SADDLP, UADDLP */
     case 0x3: /* SUQADD, USQADD */
     case 0x4: /* CLS, CLZ */
     case 0x5: /* CNT, NOT, RBIT */
+    case 0x6: /* SADALP, UADALP */
     case 0x7: /* SQABS, SQNEG */
     case 0x8: /* CMGT, CMGE */
     case 0x9: /* CMEQ, CMLE */
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 2531809096..77020bb175 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1662,3 +1662,8 @@ CMLT0_v         0.00 1110 ..1 00000 10101 0 ..... .....     @qrr_e
 REV16_v         0.00 1110 001 00000 00011 0 ..... .....     @qrr_b
 REV32_v         0.10 1110 0.1 00000 00011 0 ..... .....     @qrr_bh
 REV64_v         0.00 1110 ..1 00000 00001 0 ..... .....     @qrr_e
+
+SADDLP_v        0.00 1110 ..1 00000 00101 0 ..... .....     @qrr_e
+UADDLP_v        0.10 1110 ..1 00000 00101 0 ..... .....     @qrr_e
+SADALP_v        0.00 1110 ..1 00000 01101 0 ..... .....     @qrr_e
+UADALP_v        0.10 1110 ..1 00000 01101 0 ..... .....     @qrr_e
-- 
2.43.0


