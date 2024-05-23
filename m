Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9D9C25B7D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAATl-0008DZ-Ru; Thu, 23 May 2024 11:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATf-00081w-62
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:35 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATW-0002Up-NH
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:34 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4202ca70287so13792275e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716478518; x=1717083318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MJVWsW19dhGE1qDpgZv5R5jHhLzmpIPemWGWwcF4UMI=;
 b=JB5IqIznHfwZ9j2PtsP74GFOftgXVbaSucxWba16Go5EkjSeMrp8NmcKrLA/rGry2x
 AJo054wgUq0fyMeL5aMN366Q3NQauwejw4b3X61jUlWAKWaHqkiuWpeabUPHszrLQLjx
 bFvfKr0briNhUXVjLNN8oqpPAua8RxmaDF7/J/ZurWSdQbPfYYG2vG2wrUsRnEZqFZ5P
 qMaW9IWzbfo1IbTyNXZHTqlhpJwvcOUm1fK2sHV4WCdIw2uvt2LqE2escl+N7iKCecJg
 Gd5SgskvwFSlMlk0KoQcdP4z2ZPHl9o+UajcAm3SXwC6eI4pktjRRa8GMCOVSKsaUtxf
 lp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716478518; x=1717083318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MJVWsW19dhGE1qDpgZv5R5jHhLzmpIPemWGWwcF4UMI=;
 b=tbhn7Zf1b22wycOadBO320Xx8gc2moq+Y8ZXV8wgMt1+z9eAoBqTzSU2VKhJFZY4mf
 7+79zqfWPcA4UBO0xWkFgU5AZ7NMxqPxgIYPGDbL9Jp0rGV8D8tQfKOGBU4sALgA2y7b
 ZcSDKwTeYcC5USbjPtm+Oib61lpUUnqtSy1COIkqM5YwTyLBan74OoDVRgppekUQLoEe
 trKu08YLYfR1LekerK2//hPWJGeEz9BEUogCmHuWz87VVyLMTfnGpSuiTH7Jo4VyWVzl
 29G53wtTH7EvDSTGEKie5A+PIYBgJdTrz8eLoCblu2BpZWA4IAfxtORjl/uvevezDpDA
 XGNA==
X-Gm-Message-State: AOJu0YzVvxUNGxP0ZHmwTx33Ci6SBbnqNvBfPcBLBQy1KnK9fbEj2sAU
 Uqlz/TJ3snaAd+GBYj1hoxZOVgAWa2pHNLM9sxeOgj2rokrF9FfS77HpTV+0SSrrJktCV4YMMWr
 B
X-Google-Smtp-Source: AGHT+IEQy+7ycjHFKQM/oC4NSKoCF2cLefKP2UWqKhdDvqEDwnxchBSd9YLiyf/OobYQh0lgPzb5IA==
X-Received: by 2002:a05:600c:202:b0:41a:aa6:b59e with SMTP id
 5b1f17b1804b1-420fd2db0d6mr48638745e9.5.1716478517731; 
 Thu, 23 May 2024 08:35:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-354df9b51f7sm3888255f8f.59.2024.05.23.08.35.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:35:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/37] target/arm: Convert FADD, FSUB, FDIV, FMUL to decodetree
Date: Thu, 23 May 2024 16:34:49 +0100
Message-Id: <20240523153505.2900433-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523153505.2900433-1-peter.maydell@linaro.org>
References: <20240523153505.2900433-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240506010403.6204-14-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-a64.h    |   4 +
 target/arm/tcg/translate.h     |   5 +
 target/arm/tcg/a64.decode      |  27 +++++
 target/arm/tcg/translate-a64.c | 205 +++++++++++++++++----------------
 target/arm/tcg/vec_helper.c    |   4 +
 5 files changed, 143 insertions(+), 102 deletions(-)

diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64.h
index b79751a7170..371388f61b5 100644
--- a/target/arm/tcg/helper-a64.h
+++ b/target/arm/tcg/helper-a64.h
@@ -133,6 +133,10 @@ DEF_HELPER_4(cpyfp, void, env, i32, i32, i32)
 DEF_HELPER_4(cpyfm, void, env, i32, i32, i32)
 DEF_HELPER_4(cpyfe, void, env, i32, i32, i32)
 
+DEF_HELPER_FLAGS_5(gvec_fdiv_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fdiv_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fdiv_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(gvec_fmulx_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fmulx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fmulx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 80e85096a83..ecfa242eef3 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -252,6 +252,11 @@ static inline int shl_12(DisasContext *s, int x)
     return x << 12;
 }
 
+static inline int xor_2(DisasContext *s, int x)
+{
+    return x ^ 2;
+}
+
 static inline int neon_3same_fp_size(DisasContext *s, int x)
 {
     /* Convert 0==fp32, 1==fp16 into a MO_* value */
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 2e0e01be017..82daafbef52 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -21,6 +21,7 @@
 
 %rd             0:5
 %esz_sd         22:1 !function=plus_2
+%esz_hsd        22:2 !function=xor_2
 %hl             11:1 21:1
 %hlm            11:1 20:2
 
@@ -37,6 +38,7 @@
 
 @rrr_h          ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=1
 @rrr_sd         ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=%esz_sd
+@rrr_hsd        ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=%esz_hsd
 
 @rrx_h          ........ .. .. rm:4 .... . . rn:5 rd:5  &rrx_e esz=1 idx=%hlm
 @rrx_s          ........ .. . rm:5  .... . . rn:5 rd:5  &rrx_e esz=2 idx=%hl
@@ -697,22 +699,47 @@ INS_element     0 1   10 1110 000 di:5  0 si:4 1 rn:5 rd:5
 
 ### Advanced SIMD scalar three same
 
+FADD_s          0001 1110 ..1 ..... 0010 10 ..... ..... @rrr_hsd
+FSUB_s          0001 1110 ..1 ..... 0011 10 ..... ..... @rrr_hsd
+FDIV_s          0001 1110 ..1 ..... 0001 10 ..... ..... @rrr_hsd
+FMUL_s          0001 1110 ..1 ..... 0000 10 ..... ..... @rrr_hsd
+
 FMULX_s         0101 1110 010 ..... 00011 1 ..... ..... @rrr_h
 FMULX_s         0101 1110 0.1 ..... 11011 1 ..... ..... @rrr_sd
 
 ### Advanced SIMD three same
 
+FADD_v          0.00 1110 010 ..... 00010 1 ..... ..... @qrrr_h
+FADD_v          0.00 1110 0.1 ..... 11010 1 ..... ..... @qrrr_sd
+
+FSUB_v          0.00 1110 110 ..... 00010 1 ..... ..... @qrrr_h
+FSUB_v          0.00 1110 1.1 ..... 11010 1 ..... ..... @qrrr_sd
+
+FDIV_v          0.10 1110 010 ..... 00111 1 ..... ..... @qrrr_h
+FDIV_v          0.10 1110 0.1 ..... 11111 1 ..... ..... @qrrr_sd
+
+FMUL_v          0.10 1110 010 ..... 00011 1 ..... ..... @qrrr_h
+FMUL_v          0.10 1110 0.1 ..... 11011 1 ..... ..... @qrrr_sd
+
 FMULX_v         0.00 1110 010 ..... 00011 1 ..... ..... @qrrr_h
 FMULX_v         0.00 1110 0.1 ..... 11011 1 ..... ..... @qrrr_sd
 
 ### Advanced SIMD scalar x indexed element
 
+FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
+FMUL_si         0101 1111 10 . ..... 1001 . 0 ..... .....   @rrx_s
+FMUL_si         0101 1111 11 0 ..... 1001 . 0 ..... .....   @rrx_d
+
 FMULX_si        0111 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
 FMULX_si        0111 1111 10 . ..... 1001 . 0 ..... .....   @rrx_s
 FMULX_si        0111 1111 11 0 ..... 1001 . 0 ..... .....   @rrx_d
 
 ### Advanced SIMD vector x indexed element
 
+FMUL_vi         0.00 1111 00 .. .... 1001 . 0 ..... .....   @qrrx_h
+FMUL_vi         0.00 1111 10 . ..... 1001 . 0 ..... .....   @qrrx_s
+FMUL_vi         0.00 1111 11 0 ..... 1001 . 0 ..... .....   @qrrx_d
+
 FMULX_vi        0.10 1111 00 .. .... 1001 . 0 ..... .....   @qrrx_h
 FMULX_vi        0.10 1111 10 . ..... 1001 . 0 ..... .....   @qrrx_s
 FMULX_vi        0.10 1111 11 0 ..... 1001 . 0 ..... .....   @qrrx_d
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 04da374e86d..46976b55826 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4887,6 +4887,34 @@ static bool do_fp3_scalar(DisasContext *s, arg_rrr_e *a, const FPScalar *f)
     return true;
 }
 
+static const FPScalar f_scalar_fadd = {
+    gen_helper_vfp_addh,
+    gen_helper_vfp_adds,
+    gen_helper_vfp_addd,
+};
+TRANS(FADD_s, do_fp3_scalar, a, &f_scalar_fadd)
+
+static const FPScalar f_scalar_fsub = {
+    gen_helper_vfp_subh,
+    gen_helper_vfp_subs,
+    gen_helper_vfp_subd,
+};
+TRANS(FSUB_s, do_fp3_scalar, a, &f_scalar_fsub)
+
+static const FPScalar f_scalar_fdiv = {
+    gen_helper_vfp_divh,
+    gen_helper_vfp_divs,
+    gen_helper_vfp_divd,
+};
+TRANS(FDIV_s, do_fp3_scalar, a, &f_scalar_fdiv)
+
+static const FPScalar f_scalar_fmul = {
+    gen_helper_vfp_mulh,
+    gen_helper_vfp_muls,
+    gen_helper_vfp_muld,
+};
+TRANS(FMUL_s, do_fp3_scalar, a, &f_scalar_fmul)
+
 static const FPScalar f_scalar_fmulx = {
     gen_helper_advsimd_mulxh,
     gen_helper_vfp_mulxs,
@@ -4922,6 +4950,34 @@ static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a,
     return true;
 }
 
+static gen_helper_gvec_3_ptr * const f_vector_fadd[3] = {
+    gen_helper_gvec_fadd_h,
+    gen_helper_gvec_fadd_s,
+    gen_helper_gvec_fadd_d,
+};
+TRANS(FADD_v, do_fp3_vector, a, f_vector_fadd)
+
+static gen_helper_gvec_3_ptr * const f_vector_fsub[3] = {
+    gen_helper_gvec_fsub_h,
+    gen_helper_gvec_fsub_s,
+    gen_helper_gvec_fsub_d,
+};
+TRANS(FSUB_v, do_fp3_vector, a, f_vector_fsub)
+
+static gen_helper_gvec_3_ptr * const f_vector_fdiv[3] = {
+    gen_helper_gvec_fdiv_h,
+    gen_helper_gvec_fdiv_s,
+    gen_helper_gvec_fdiv_d,
+};
+TRANS(FDIV_v, do_fp3_vector, a, f_vector_fdiv)
+
+static gen_helper_gvec_3_ptr * const f_vector_fmul[3] = {
+    gen_helper_gvec_fmul_h,
+    gen_helper_gvec_fmul_s,
+    gen_helper_gvec_fmul_d,
+};
+TRANS(FMUL_v, do_fp3_vector, a, f_vector_fmul)
+
 static gen_helper_gvec_3_ptr * const f_vector_fmulx[3] = {
     gen_helper_gvec_fmulx_h,
     gen_helper_gvec_fmulx_s,
@@ -4975,6 +5031,7 @@ static bool do_fp3_scalar_idx(DisasContext *s, arg_rrx_e *a, const FPScalar *f)
     return true;
 }
 
+TRANS(FMUL_si, do_fp3_scalar_idx, a, &f_scalar_fmul)
 TRANS(FMULX_si, do_fp3_scalar_idx, a, &f_scalar_fmulx)
 
 static bool do_fp3_vector_idx(DisasContext *s, arg_qrrx_e *a,
@@ -5005,6 +5062,13 @@ static bool do_fp3_vector_idx(DisasContext *s, arg_qrrx_e *a,
     return true;
 }
 
+static gen_helper_gvec_3_ptr * const f_vector_idx_fmul[3] = {
+    gen_helper_gvec_fmul_idx_h,
+    gen_helper_gvec_fmul_idx_s,
+    gen_helper_gvec_fmul_idx_d,
+};
+TRANS(FMUL_vi, do_fp3_vector_idx, a, f_vector_idx_fmul)
+
 static gen_helper_gvec_3_ptr * const f_vector_idx_fmulx[3] = {
     gen_helper_gvec_fmulx_idx_h,
     gen_helper_gvec_fmulx_idx_s,
@@ -6827,18 +6891,6 @@ static void handle_fp_2src_single(DisasContext *s, int opcode,
     tcg_op2 = read_fp_sreg(s, rm);
 
     switch (opcode) {
-    case 0x0: /* FMUL */
-        gen_helper_vfp_muls(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
-    case 0x1: /* FDIV */
-        gen_helper_vfp_divs(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
-    case 0x2: /* FADD */
-        gen_helper_vfp_adds(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
-    case 0x3: /* FSUB */
-        gen_helper_vfp_subs(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
     case 0x4: /* FMAX */
         gen_helper_vfp_maxs(tcg_res, tcg_op1, tcg_op2, fpst);
         break;
@@ -6855,6 +6907,12 @@ static void handle_fp_2src_single(DisasContext *s, int opcode,
         gen_helper_vfp_muls(tcg_res, tcg_op1, tcg_op2, fpst);
         gen_helper_vfp_negs(tcg_res, tcg_res);
         break;
+    default:
+    case 0x0: /* FMUL */
+    case 0x1: /* FDIV */
+    case 0x2: /* FADD */
+    case 0x3: /* FSUB */
+        g_assert_not_reached();
     }
 
     write_fp_sreg(s, rd, tcg_res);
@@ -6875,18 +6933,6 @@ static void handle_fp_2src_double(DisasContext *s, int opcode,
     tcg_op2 = read_fp_dreg(s, rm);
 
     switch (opcode) {
-    case 0x0: /* FMUL */
-        gen_helper_vfp_muld(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
-    case 0x1: /* FDIV */
-        gen_helper_vfp_divd(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
-    case 0x2: /* FADD */
-        gen_helper_vfp_addd(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
-    case 0x3: /* FSUB */
-        gen_helper_vfp_subd(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
     case 0x4: /* FMAX */
         gen_helper_vfp_maxd(tcg_res, tcg_op1, tcg_op2, fpst);
         break;
@@ -6903,6 +6949,12 @@ static void handle_fp_2src_double(DisasContext *s, int opcode,
         gen_helper_vfp_muld(tcg_res, tcg_op1, tcg_op2, fpst);
         gen_helper_vfp_negd(tcg_res, tcg_res);
         break;
+    default:
+    case 0x0: /* FMUL */
+    case 0x1: /* FDIV */
+    case 0x2: /* FADD */
+    case 0x3: /* FSUB */
+        g_assert_not_reached();
     }
 
     write_fp_dreg(s, rd, tcg_res);
@@ -6923,18 +6975,6 @@ static void handle_fp_2src_half(DisasContext *s, int opcode,
     tcg_op2 = read_fp_hreg(s, rm);
 
     switch (opcode) {
-    case 0x0: /* FMUL */
-        gen_helper_advsimd_mulh(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
-    case 0x1: /* FDIV */
-        gen_helper_advsimd_divh(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
-    case 0x2: /* FADD */
-        gen_helper_advsimd_addh(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
-    case 0x3: /* FSUB */
-        gen_helper_advsimd_subh(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
     case 0x4: /* FMAX */
         gen_helper_advsimd_maxh(tcg_res, tcg_op1, tcg_op2, fpst);
         break;
@@ -6952,6 +6992,10 @@ static void handle_fp_2src_half(DisasContext *s, int opcode,
         tcg_gen_xori_i32(tcg_res, tcg_res, 0x8000);
         break;
     default:
+    case 0x0: /* FMUL */
+    case 0x1: /* FDIV */
+    case 0x2: /* FADD */
+    case 0x3: /* FSUB */
         g_assert_not_reached();
     }
 
@@ -9173,9 +9217,6 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
             case 0x18: /* FMAXNM */
                 gen_helper_vfp_maxnumd(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x1a: /* FADD */
-                gen_helper_vfp_addd(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x1c: /* FCMEQ */
                 gen_helper_neon_ceq_f64(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
@@ -9188,27 +9229,18 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
             case 0x38: /* FMINNM */
                 gen_helper_vfp_minnumd(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x3a: /* FSUB */
-                gen_helper_vfp_subd(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x3e: /* FMIN */
                 gen_helper_vfp_mind(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x3f: /* FRSQRTS */
                 gen_helper_rsqrtsf_f64(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x5b: /* FMUL */
-                gen_helper_vfp_muld(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x5c: /* FCMGE */
                 gen_helper_neon_cge_f64(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x5d: /* FACGE */
                 gen_helper_neon_acge_f64(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x5f: /* FDIV */
-                gen_helper_vfp_divd(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x7a: /* FABD */
                 gen_helper_vfp_subd(tcg_res, tcg_op1, tcg_op2, fpst);
                 gen_helper_vfp_absd(tcg_res, tcg_res);
@@ -9220,7 +9252,11 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
                 gen_helper_neon_acgt_f64(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             default:
+            case 0x1a: /* FADD */
             case 0x1b: /* FMULX */
+            case 0x3a: /* FSUB */
+            case 0x5b: /* FMUL */
+            case 0x5f: /* FDIV */
                 g_assert_not_reached();
             }
 
@@ -9244,9 +9280,6 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
                 gen_helper_vfp_muladds(tcg_res, tcg_op1, tcg_op2,
                                        tcg_res, fpst);
                 break;
-            case 0x1a: /* FADD */
-                gen_helper_vfp_adds(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x1c: /* FCMEQ */
                 gen_helper_neon_ceq_f32(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
@@ -9262,27 +9295,18 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
             case 0x38: /* FMINNM */
                 gen_helper_vfp_minnums(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x3a: /* FSUB */
-                gen_helper_vfp_subs(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x3e: /* FMIN */
                 gen_helper_vfp_mins(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x3f: /* FRSQRTS */
                 gen_helper_rsqrtsf_f32(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x5b: /* FMUL */
-                gen_helper_vfp_muls(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x5c: /* FCMGE */
                 gen_helper_neon_cge_f32(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x5d: /* FACGE */
                 gen_helper_neon_acge_f32(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x5f: /* FDIV */
-                gen_helper_vfp_divs(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x7a: /* FABD */
                 gen_helper_vfp_subs(tcg_res, tcg_op1, tcg_op2, fpst);
                 gen_helper_vfp_abss(tcg_res, tcg_res);
@@ -9294,7 +9318,11 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
                 gen_helper_neon_acgt_f32(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             default:
+            case 0x1a: /* FADD */
             case 0x1b: /* FMULX */
+            case 0x3a: /* FSUB */
+            case 0x5b: /* FMUL */
+            case 0x5f: /* FDIV */
                 g_assert_not_reached();
             }
 
@@ -11217,15 +11245,11 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
     case 0x19: /* FMLA */
     case 0x39: /* FMLS */
     case 0x18: /* FMAXNM */
-    case 0x1a: /* FADD */
     case 0x1c: /* FCMEQ */
     case 0x1e: /* FMAX */
     case 0x38: /* FMINNM */
-    case 0x3a: /* FSUB */
     case 0x3e: /* FMIN */
-    case 0x5b: /* FMUL */
     case 0x5c: /* FCMGE */
-    case 0x5f: /* FDIV */
     case 0x7a: /* FABD */
     case 0x7c: /* FCMGT */
         if (!fp_access_check(s)) {
@@ -11255,7 +11279,11 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
         return;
 
     default:
+    case 0x1a: /* FADD */
     case 0x1b: /* FMULX */
+    case 0x3a: /* FSUB */
+    case 0x5b: /* FMUL */
+    case 0x5f: /* FDIV */
         unallocated_encoding(s);
         return;
     }
@@ -11599,19 +11627,15 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
     switch (fpopcode) {
     case 0x0: /* FMAXNM */
     case 0x1: /* FMLA */
-    case 0x2: /* FADD */
     case 0x4: /* FCMEQ */
     case 0x6: /* FMAX */
     case 0x7: /* FRECPS */
     case 0x8: /* FMINNM */
     case 0x9: /* FMLS */
-    case 0xa: /* FSUB */
     case 0xe: /* FMIN */
     case 0xf: /* FRSQRTS */
-    case 0x13: /* FMUL */
     case 0x14: /* FCMGE */
     case 0x15: /* FACGE */
-    case 0x17: /* FDIV */
     case 0x1a: /* FABD */
     case 0x1c: /* FCMGT */
     case 0x1d: /* FACGT */
@@ -11625,7 +11649,11 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
         pairwise = true;
         break;
     default:
+    case 0x2: /* FADD */
     case 0x3: /* FMULX */
+    case 0xa: /* FSUB */
+    case 0x13: /* FMUL */
+    case 0x17: /* FDIV */
         unallocated_encoding(s);
         return;
     }
@@ -11699,9 +11727,6 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
                 gen_helper_advsimd_muladdh(tcg_res, tcg_op1, tcg_op2, tcg_res,
                                            fpst);
                 break;
-            case 0x2: /* FADD */
-                gen_helper_advsimd_addh(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x4: /* FCMEQ */
                 gen_helper_advsimd_ceq_f16(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
@@ -11721,27 +11746,18 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
                 gen_helper_advsimd_muladdh(tcg_res, tcg_op1, tcg_op2, tcg_res,
                                            fpst);
                 break;
-            case 0xa: /* FSUB */
-                gen_helper_advsimd_subh(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0xe: /* FMIN */
                 gen_helper_advsimd_minh(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0xf: /* FRSQRTS */
                 gen_helper_rsqrtsf_f16(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x13: /* FMUL */
-                gen_helper_advsimd_mulh(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x14: /* FCMGE */
                 gen_helper_advsimd_cge_f16(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x15: /* FACGE */
                 gen_helper_advsimd_acge_f16(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x17: /* FDIV */
-                gen_helper_advsimd_divh(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x1a: /* FABD */
                 gen_helper_advsimd_subh(tcg_res, tcg_op1, tcg_op2, fpst);
                 tcg_gen_andi_i32(tcg_res, tcg_res, 0x7fff);
@@ -11753,7 +11769,11 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
                 gen_helper_advsimd_acgt_f16(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             default:
+            case 0x2: /* FADD */
             case 0x3: /* FMULX */
+            case 0xa: /* FSUB */
+            case 0x13: /* FMUL */
+            case 0x17: /* FDIV */
                 g_assert_not_reached();
             }
 
@@ -12972,7 +12992,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
         break;
     case 0x01: /* FMLA */
     case 0x05: /* FMLS */
-    case 0x09: /* FMUL */
         is_fp = 1;
         break;
     case 0x1d: /* SQRDMLAH */
@@ -13041,6 +13060,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
         /* is_fp, but we pass tcg_env not fp_status.  */
         break;
     default:
+    case 0x09: /* FMUL */
     case 0x19: /* FMULX */
         unallocated_encoding(s);
         return;
@@ -13262,10 +13282,8 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
                 read_vec_element(s, tcg_res, rd, pass, MO_64);
                 gen_helper_vfp_muladdd(tcg_res, tcg_op, tcg_idx, tcg_res, fpst);
                 break;
-            case 0x09: /* FMUL */
-                gen_helper_vfp_muld(tcg_res, tcg_op, tcg_idx, fpst);
-                break;
             default:
+            case 0x09: /* FMUL */
             case 0x19: /* FMULX */
                 g_assert_not_reached();
             }
@@ -13361,24 +13379,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
                     g_assert_not_reached();
                 }
                 break;
-            case 0x09: /* FMUL */
-                switch (size) {
-                case 1:
-                    if (is_scalar) {
-                        gen_helper_advsimd_mulh(tcg_res, tcg_op,
-                                                tcg_idx, fpst);
-                    } else {
-                        gen_helper_advsimd_mul2h(tcg_res, tcg_op,
-                                                 tcg_idx, fpst);
-                    }
-                    break;
-                case 2:
-                    gen_helper_vfp_muls(tcg_res, tcg_op, tcg_idx, fpst);
-                    break;
-                default:
-                    g_assert_not_reached();
-                }
-                break;
             case 0x0c: /* SQDMULH */
                 if (size == 1) {
                     gen_helper_neon_qdmulh_s16(tcg_res, tcg_env,
@@ -13420,6 +13420,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
                 }
                 break;
             default:
+            case 0x09: /* FMUL */
             case 0x19: /* FMULX */
                 g_assert_not_reached();
             }
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 86845819236..41065363710 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1248,6 +1248,10 @@ DO_3OP(gvec_rsqrts_nf_h, float16_rsqrts_nf, float16)
 DO_3OP(gvec_rsqrts_nf_s, float32_rsqrts_nf, float32)
 
 #ifdef TARGET_AARCH64
+DO_3OP(gvec_fdiv_h, float16_div, float16)
+DO_3OP(gvec_fdiv_s, float32_div, float32)
+DO_3OP(gvec_fdiv_d, float64_div, float64)
+
 DO_3OP(gvec_fmulx_h, helper_advsimd_mulxh, float16)
 DO_3OP(gvec_fmulx_s, helper_vfp_mulxs, float32)
 DO_3OP(gvec_fmulx_d, helper_vfp_mulxd, float64)
-- 
2.34.1


