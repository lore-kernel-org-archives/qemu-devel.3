Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FF7C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 20:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC3UE-0004Hs-JA; Tue, 28 May 2024 16:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3Tk-00038D-8U
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:31:28 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3TT-0003kL-Ne
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:31:27 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6f8edff35a0so1097705b3a.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 13:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716928270; x=1717533070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ncTcpYIecVC2HKTKO7L+7JLNQzVbrg7OF45HFdmymvU=;
 b=w/+q7Ns7yGFzvcRrRQPtDCTeN2Mx52gQp+a5JvinTcb1udsE/eYZbE1WpyzkYgkvFH
 QYdv7prIdPkaEk7suC+cSqN68N+cMesuJStPeoIWTJrOTSbK46mO1fQ7V80ydWNn9LvQ
 TO4zAZhutxxeok8qTuB/pRxi/2LKuiC2LSmneOH+woWYlX/DzNu9yUTUFQiXTgWfawMi
 inNNDgKp9uhZZ7kbqvR0HwdR4rms7INASjZSK5ceby1E0sIW1VN5nnSOR1ibehB1Ho/B
 1BA+yLAg9CvIW7+xM2u1Vypj1ZGRm7DvXPswC1Puqyo11oPMJKglyLudL6zNtqhmGiKn
 fMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716928270; x=1717533070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ncTcpYIecVC2HKTKO7L+7JLNQzVbrg7OF45HFdmymvU=;
 b=cnFjLo6+Q6lkDvJ8lAp5Cqql37fsvEPxaEO1HC46Mh19JZ8LudC+qXcUzebwsj0c7n
 PWMqeYUs6ly98ScJq/BZG8i67K7k+MKpJuqY/TTDKwgX2wbp/efKuqoUMgol8ie2gfiQ
 BHFmBT5uxf1mSZ//cmDz1K508YDKI9d5SGqS8ZfEbqKNa/Fg+OW04uBJllzdCnb4tWbo
 KD31SNzKOKaqKPa3l+NBqDn1kNLQOlkFo3RK61Q9nZg4CDqq/iI9Et0iCFcdJGZhxJc/
 +6Wrers8DlGBrtbxvOYorFpetBl7KWMer1aX0GTlQo2upfci/D6w6a/OUrM5L1akIlHF
 7Nbg==
X-Gm-Message-State: AOJu0YxLSF4IFPkK7g8Rlv+Zf6B6YT3LE8NfPHsiAITlNhpbFBieQGTn
 XhRFXxaT31au7LydcaUVd+Hjjlqu1QWHJ1+6oIZjkLtioENLC5nvDWM7/mqMb+AgPrtbPceMktJ
 u
X-Google-Smtp-Source: AGHT+IE/H1jiTCC6u/53K2bE4dL7NmcKnF6R6pOsvQzAv/rZ9zkB6LiEL9H0uv46WSOpPxw+FpEyyA==
X-Received: by 2002:a05:6a00:e16:b0:6eb:3d37:ce7a with SMTP id
 d2e1a72fcca58-6f8f392b718mr12796118b3a.21.1716928270400; 
 Tue, 28 May 2024 13:31:10 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbd3dbe9sm7042036b3a.10.2024.05.28.13.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 13:31:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 28/33] target/arm: Convert MUL, PMUL to decodetree
Date: Tue, 28 May 2024 13:30:39 -0700
Message-Id: <20240528203044.612851-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528203044.612851-1-richard.henderson@linaro.org>
References: <20240528203044.612851-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/a64.decode      |  5 ++++
 target/arm/tcg/translate-a64.c | 51 +++++++++++++---------------------
 2 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 07b604ec30..3ea0643370 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -926,6 +926,8 @@ SABD_v          0.00 1110 ..1 ..... 01110 1 ..... ..... @qrrr_e
 UABD_v          0.10 1110 ..1 ..... 01110 1 ..... ..... @qrrr_e
 SABA_v          0.00 1110 ..1 ..... 01111 1 ..... ..... @qrrr_e
 UABA_v          0.10 1110 ..1 ..... 01111 1 ..... ..... @qrrr_e
+MUL_v           0.00 1110 ..1 ..... 10011 1 ..... ..... @qrrr_e
+PMUL_v          0.10 1110 001 ..... 10011 1 ..... ..... @qrrr_b
 
 ### Advanced SIMD scalar x indexed element
 
@@ -967,3 +969,6 @@ FMLAL_vi        0.00 1111 10 .. .... 0000 . 0 ..... .....   @qrrx_h
 FMLSL_vi        0.00 1111 10 .. .... 0100 . 0 ..... .....   @qrrx_h
 FMLAL2_vi       0.10 1111 10 .. .... 1000 . 0 ..... .....   @qrrx_h
 FMLSL2_vi       0.10 1111 10 .. .... 1100 . 0 ..... .....   @qrrx_h
+
+MUL_vi          0.00 1111 01 .. .... 1000 . 0 ..... .....   @qrrx_h
+MUL_vi          0.00 1111 10 . ..... 1000 . 0 ..... .....   @qrrx_s
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 61afbc434f..1909d1426c 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5468,6 +5468,8 @@ TRANS(SABA_v, do_gvec_fn3_no64, a, gen_gvec_saba)
 TRANS(UABA_v, do_gvec_fn3_no64, a, gen_gvec_uaba)
 TRANS(SABD_v, do_gvec_fn3_no64, a, gen_gvec_sabd)
 TRANS(UABD_v, do_gvec_fn3_no64, a, gen_gvec_uabd)
+TRANS(MUL_v, do_gvec_fn3_no64, a, tcg_gen_gvec_mul)
+TRANS(PMUL_v, do_gvec_op3_ool, a, 0, gen_helper_gvec_pmul_b)
 
 static bool do_cmop_v(DisasContext *s, arg_qrrr_e *a, TCGCond cond)
 {
@@ -5694,6 +5696,22 @@ TRANS_FEAT(FMLSL_vi, aa64_fhm, do_fmlal_idx, a, true, false)
 TRANS_FEAT(FMLAL2_vi, aa64_fhm, do_fmlal_idx, a, false, true)
 TRANS_FEAT(FMLSL2_vi, aa64_fhm, do_fmlal_idx, a, true, true)
 
+static bool do_int3_vector_idx(DisasContext *s, arg_qrrx_e *a,
+                               gen_helper_gvec_3 * const fns[2])
+{
+    assert(a->esz == MO_16 || a->esz == MO_32);
+    if (fp_access_check(s)) {
+        gen_gvec_op3_ool(s, a->q, a->rd, a->rn, a->rm, a->idx, fns[a->esz - 1]);
+    }
+    return true;
+}
+
+static gen_helper_gvec_3 * const f_vector_idx_mul[2] = {
+    gen_helper_gvec_mul_idx_h,
+    gen_helper_gvec_mul_idx_s,
+};
+TRANS(MUL_vi, do_int3_vector_idx, a, f_vector_idx_mul)
+
 /*
  * Advanced SIMD scalar pairwise
  */
@@ -10927,12 +10945,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     int rd = extract32(insn, 0, 5);
 
     switch (opcode) {
-    case 0x13: /* MUL, PMUL */
-        if (u && size != 0) {
-            unallocated_encoding(s);
-            return;
-        }
-        /* fall through */
     case 0x12: /* MLA, MLS */
         if (size == 3) {
             unallocated_encoding(s);
@@ -10969,6 +10981,7 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     case 0x0f: /* SABA, UABA */
     case 0x10: /* ADD, SUB */
     case 0x11: /* CMTST, CMEQ */
+    case 0x13: /* MUL, PMUL */
         unallocated_encoding(s);
         return;
     }
@@ -10978,13 +10991,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x13: /* MUL, PMUL */
-        if (!u) { /* MUL */
-            gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_mul, size);
-        } else {  /* PMUL */
-            gen_gvec_op3_ool(s, is_q, rd, rn, rm, 0, gen_helper_gvec_pmul_b);
-        }
-        return;
     case 0x12: /* MLA, MLS */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_mls, size);
@@ -12198,7 +12204,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     TCGv_ptr fpst;
 
     switch (16 * u + opcode) {
-    case 0x08: /* MUL */
     case 0x10: /* MLA */
     case 0x14: /* MLS */
         if (is_scalar) {
@@ -12285,6 +12290,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     case 0x01: /* FMLA */
     case 0x04: /* FMLSL */
     case 0x05: /* FMLS */
+    case 0x08: /* MUL */
     case 0x09: /* FMUL */
     case 0x18: /* FMLAL2 */
     case 0x19: /* FMULX */
@@ -12407,22 +12413,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
         }
         return;
 
-    case 0x08: /* MUL */
-        if (!is_long && !is_scalar) {
-            static gen_helper_gvec_3 * const fns[3] = {
-                gen_helper_gvec_mul_idx_h,
-                gen_helper_gvec_mul_idx_s,
-                gen_helper_gvec_mul_idx_d,
-            };
-            tcg_gen_gvec_3_ool(vec_full_reg_offset(s, rd),
-                               vec_full_reg_offset(s, rn),
-                               vec_full_reg_offset(s, rm),
-                               is_q ? 16 : 8, vec_full_reg_size(s),
-                               index, fns[size - 1]);
-            return;
-        }
-        break;
-
     case 0x10: /* MLA */
         if (!is_long && !is_scalar) {
             static gen_helper_gvec_4 * const fns[3] = {
@@ -12491,7 +12481,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
             read_vec_element_i32(s, tcg_op, rn, pass, is_scalar ? size : MO_32);
 
             switch (16 * u + opcode) {
-            case 0x08: /* MUL */
             case 0x10: /* MLA */
             case 0x14: /* MLS */
             {
-- 
2.34.1


