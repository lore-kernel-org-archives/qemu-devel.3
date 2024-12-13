Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922C3E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9YT-0002HT-2p; Fri, 13 Dec 2024 12:34:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xd-0007YV-H1
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:29 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9XY-0001dV-CS
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:29 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4361c705434so14794695e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111202; x=1734716002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d89BbV9A2k7+Tc7rnQBt5e6N0ahmp3Fl8imvF/4J++k=;
 b=SK6DW8PzGKIZMq552B6OFVf9dmLfiWkac/Zvy9ElJRRffnsNIDSAmbQLKqQoVVMDF3
 AIZmGGMt/GIcArGME4rrc+JZaAzBHUc+z+87ZeGqGSBYFDT9clJGgrk3UsyxTWYa3T90
 SiE88eVBW2DnMnVh2ZSUSQGvdzeD3+6fabK4nA++Ke3uX6N0NTvddio42G2N9piE+IJ4
 Cgvu3sdF5QV7p/EalGuaFjrTZGHQyM/gc+sh7oW2Ymu/o5NRV2BszofcqdMdwgdnP6iA
 2xXyiuZSp/6QFXvysIyuMmtl4EY4AufwlGYWuoa5V0kewzaUxGlmQeqr4keVBxe/+fNl
 cM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111202; x=1734716002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d89BbV9A2k7+Tc7rnQBt5e6N0ahmp3Fl8imvF/4J++k=;
 b=hEa3KEOjFD2h7PSP2SYbzInk7L8SF3CmW3msqjWp/t0FHsmA33Vv7jfTwjJuNZtWva
 cMA1mMFDVk0hIHYeKRiVPYYT1eUyt6lFIuISHllcXbOLTUJTaz1VKb5KVd5f2hL4qThb
 j3HwIdvBsRVn9u+i7yjfToMAOu1JS/vs1v2gLNS1j+DpyBHnhceCaSbvact3Rr7bUP7Q
 qV7LI40Dy1cC61ASCgcsZPX1+T6kchpSCjC7ddAGB6g1vccR8/9swaRfISNaFmA9klro
 zEr8JIr7nhhhDBcdH5Fv28xYpfqVH1WDzXf/d6X4TlwYwxZCK+fvo6L8ej5EzUtMRk6s
 ZZxg==
X-Gm-Message-State: AOJu0YzqWnhj0KhiN3uvkTdwMn2Fv7urW7ik0gbBpjfwpQHCCwzR6cFt
 C5ux8EeujE6yBDIBq+veatvU+FqLUPlN85l9pjCJYT/bDXzrvhwTShECB/Wv2m4vBv/BHFEEr1y
 r
X-Gm-Gg: ASbGncurwVYniCSa0xVzchEY48TNZTO0lBg5B82TcFBgLt3SXF+aLDr+0dc84gcySj1
 uWbdDeOWXc82v5231jB7Iz2DkrxslgAj7lgd/hM1VKLXuJ028XSBoaVg310CedFsoAplsing1H4
 Eb5ZMZgoEOQiiLfcrET3CYlce4li5qZxTD1F9UvWYq7LgC534wqoX7+5XNbZaxNzU/HIZy7HxJF
 MvhZA31gvtJqzw4x6Gz1aQRbKS7VsXQ2iMfe5iSOadS2XS8kv9vU6BO2MzZYA==
X-Google-Smtp-Source: AGHT+IHdaPRLUrHFmMPFv21Q31BgIa+EqMipGoAZ1rzD4invne9cPkyxZ2jaxi7Tah+MW+9innNKQw==
X-Received: by 2002:a5d:588f:0:b0:386:3403:7b63 with SMTP id
 ffacd0b85a97d-3888e0b5adamr2858106f8f.36.1734111201669; 
 Fri, 13 Dec 2024 09:33:21 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 46/85] target/arm: Convert handle_2misc_pairwise to decodetree
Date: Fri, 13 Dec 2024 17:31:50 +0000
Message-Id: <20241213173229.3308926-47-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This includes SADDLP, UADDLP, SADALP, UADALP.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-47-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-a64.h    |  2 -
 target/arm/tcg/a64.decode      |  5 ++
 target/arm/tcg/helper-a64.c    | 18 --------
 target/arm/tcg/translate-a64.c | 84 +++-------------------------------
 4 files changed, 11 insertions(+), 98 deletions(-)

diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64.h
index f811bb85dcb..ac7ca190fac 100644
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
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 05f1bc99b52..f3488766b21 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1662,3 +1662,8 @@ CMLT0_v         0.00 1110 ..1 00000 10101 0 ..... .....     @qrr_e
 REV16_v         0.00 1110 001 00000 00011 0 ..... .....     @qrr_b
 REV32_v         0.10 1110 0.1 00000 00001 0 ..... .....     @qrr_bh
 REV64_v         0.00 1110 ..1 00000 00001 0 ..... .....     @qrr_e
+
+SADDLP_v        0.00 1110 ..1 00000 00101 0 ..... .....     @qrr_e
+UADDLP_v        0.10 1110 ..1 00000 00101 0 ..... .....     @qrr_e
+SADALP_v        0.00 1110 ..1 00000 01101 0 ..... .....     @qrr_e
+UADALP_v        0.10 1110 ..1 00000 01101 0 ..... .....     @qrr_e
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 9b3c407be3c..3de564e0fef 100644
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
index f57b5e28556..717d30dd5b9 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8956,6 +8956,10 @@ static bool do_gvec_fn2_bhs(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
 TRANS(CLS_v, do_gvec_fn2_bhs, a, gen_gvec_cls)
 TRANS(CLZ_v, do_gvec_fn2_bhs, a, gen_gvec_clz)
 TRANS(REV64_v, do_gvec_fn2_bhs, a, gen_gvec_rev64)
+TRANS(SADDLP_v, do_gvec_fn2_bhs, a, gen_gvec_saddlp)
+TRANS(UADDLP_v, do_gvec_fn2_bhs, a, gen_gvec_uaddlp)
+TRANS(SADALP_v, do_gvec_fn2_bhs, a, gen_gvec_sadalp)
+TRANS(UADALP_v, do_gvec_fn2_bhs, a, gen_gvec_uadalp)
 
 /* Common vector code for handling integer to FP conversion */
 static void handle_simd_intfp_conv(DisasContext *s, int rd, int rn,
@@ -9885,73 +9889,6 @@ static void handle_2misc_widening(DisasContext *s, int opcode, bool is_q,
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
@@ -10011,17 +9948,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
 
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
@@ -10203,9 +10129,11 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     default:
     case 0x0: /* REV64, REV32 */
     case 0x1: /* REV16 */
+    case 0x2: /* SADDLP, UADDLP */
     case 0x3: /* SUQADD, USQADD */
     case 0x4: /* CLS, CLZ */
     case 0x5: /* CNT, NOT, RBIT */
+    case 0x6: /* SADALP, UADALP */
     case 0x7: /* SQABS, SQNEG */
     case 0x8: /* CMGT, CMGE */
     case 0x9: /* CMEQ, CMLE */
-- 
2.34.1


