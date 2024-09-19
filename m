Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46FFCDD57A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:18:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGws-0006h5-0O; Thu, 19 Sep 2024 09:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwV-0005N4-7O
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:32 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwR-000149-0H
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:30 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4280ca0791bso7743675e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 06:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726751484; x=1727356284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=peQpqNi3t2MuaFRTBupbSj9HxYEac+jZaNqEA3I02Xc=;
 b=Z+Q0/L+U9Wg8+n0vCztF9WPCGc/fPo2yjwRx5dIB0M4cAdX+VwmaVNRxJylWm8DTV7
 DH6V0W4fAtjXiQVnyJ7B/tGB/OkeXeZTvngdyOP8OoaGLfo7lcFJpJAhptfx9aKgD6Vu
 rjPY5Ve/vGQ+UbBKBlRJXkc/fp0DXrFpfPiZB4MXlxK3u7gC/2ZheWqO2G0s/C9Tg76G
 G0R6GlceYvvSNB88qPSPn20Zh/5G5Gu//heJIBRgei6IbqT3cZn0H8SzEdnyeAeaEU6D
 b0EcN2xFfbc9cRjsk1dkWCJff9FCSQXFCxLV2mY359vZNDFotRxJDd/XA6hmoaAIbQhj
 qcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751484; x=1727356284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=peQpqNi3t2MuaFRTBupbSj9HxYEac+jZaNqEA3I02Xc=;
 b=Bep33Go7qo3+I1mLf/+WLl3HVflUFPyiQr8q8SXiDOVnE6Z/FrBF7e3VhD9LkBngPu
 B0E5/zIJ105NlwLrkvh3t1bInCffqmgU8QszRRf19qrbjxqVhXBlM/AwBHtBjPzwWCGR
 jPN36Ih0/UD5lXUDQmCSFwvxJyouvAZlsRSgWF0U7o0jwzWaGQgoHtq9eRJEvuzxbjNJ
 esdc6F88eyXS4qN/KqZ4aOKKDVaoqO+73n9zXZInicI5SoX7dhB0kM6xIopQzLAR5OGv
 6/MeERUP63RjgcT75raOOt0WixGavY0PfwRUqnKW+hoqtP/XZKYDAKNOacr9mepel40R
 vxSQ==
X-Gm-Message-State: AOJu0YymcxWZt2EFflHNYHdwS5OtisxR2ZPopWIQ31GwkD+IJ/ESiMjm
 PNulpDOLO383pvO+7WojJT40TH6HcoyiJHRIQHe+Y8JzFdfHP23PC8GBUCU+kvPqiTAwhAUBHGu
 T
X-Google-Smtp-Source: AGHT+IGStS7nkFaIwc/iKrDHWYzcIICHJwrWbh3RC/dEZL3khE0CpolzzTpPReIgKZn/bwv0ingQ2g==
X-Received: by 2002:a05:600c:45cf:b0:428:f0c2:ef4a with SMTP id
 5b1f17b1804b1-42cdb531c3dmr237323735e9.13.1726751484330; 
 Thu, 19 Sep 2024 06:11:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754091d3sm21667845e9.10.2024.09.19.06.11.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 06:11:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/38] target/arm: Convert vector [US]QSHRN, [US]QRSHRN,
 SQSHRUN to decodetree
Date: Thu, 19 Sep 2024 14:10:56 +0100
Message-Id: <20240919131106.3362543-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919131106.3362543-1-peter.maydell@linaro.org>
References: <20240919131106.3362543-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240912024114.1097832-29-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  24 +++++
 target/arm/tcg/translate-a64.c | 176 ++++++++++++++++++++++++++++++---
 2 files changed, 186 insertions(+), 14 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 63e04ddfcde..042dc79d88a 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1302,6 +1302,30 @@ SQSHLU_vi       0.10 11110 .... ... 01100 1 ..... .....     @q_shli_h
 SQSHLU_vi       0.10 11110 .... ... 01100 1 ..... .....     @q_shli_s
 SQSHLU_vi       0.10 11110 .... ... 01100 1 ..... .....     @q_shli_d
 
+SQSHRN_v        0.00 11110 .... ... 10010 1 ..... .....     @q_shri_b
+SQSHRN_v        0.00 11110 .... ... 10010 1 ..... .....     @q_shri_h
+SQSHRN_v        0.00 11110 .... ... 10010 1 ..... .....     @q_shri_s
+
+UQSHRN_v        0.10 11110 .... ... 10010 1 ..... .....     @q_shri_b
+UQSHRN_v        0.10 11110 .... ... 10010 1 ..... .....     @q_shri_h
+UQSHRN_v        0.10 11110 .... ... 10010 1 ..... .....     @q_shri_s
+
+SQSHRUN_v       0.10 11110 .... ... 10000 1 ..... .....     @q_shri_b
+SQSHRUN_v       0.10 11110 .... ... 10000 1 ..... .....     @q_shri_h
+SQSHRUN_v       0.10 11110 .... ... 10000 1 ..... .....     @q_shri_s
+
+SQRSHRN_v       0.00 11110 .... ... 10011 1 ..... .....     @q_shri_b
+SQRSHRN_v       0.00 11110 .... ... 10011 1 ..... .....     @q_shri_h
+SQRSHRN_v       0.00 11110 .... ... 10011 1 ..... .....     @q_shri_s
+
+UQRSHRN_v       0.10 11110 .... ... 10011 1 ..... .....     @q_shri_b
+UQRSHRN_v       0.10 11110 .... ... 10011 1 ..... .....     @q_shri_h
+UQRSHRN_v       0.10 11110 .... ... 10011 1 ..... .....     @q_shri_s
+
+SQRSHRUN_v      0.10 11110 .... ... 10001 1 ..... .....     @q_shri_b
+SQRSHRUN_v      0.10 11110 .... ... 10001 1 ..... .....     @q_shri_h
+SQRSHRUN_v      0.10 11110 .... ... 10001 1 ..... .....     @q_shri_s
+
 # Advanced SIMD scalar shift by immediate
 
 @shri_d         .... ..... 1 ...... ..... . rn:5 rd:5   \
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 77324e0145f..e6290e11453 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7163,6 +7163,122 @@ static bool do_vec_shift_imm_narrow(DisasContext *s, arg_qrri_e *a,
     return true;
 }
 
+static void gen_sqshrn_b(TCGv_i64 d, TCGv_i64 s, int64_t i)
+{
+    tcg_gen_sari_i64(d, s, i);
+    tcg_gen_ext16u_i64(d, d);
+    gen_helper_neon_narrow_sat_s8(d, tcg_env, d);
+}
+
+static void gen_sqshrn_h(TCGv_i64 d, TCGv_i64 s, int64_t i)
+{
+    tcg_gen_sari_i64(d, s, i);
+    tcg_gen_ext32u_i64(d, d);
+    gen_helper_neon_narrow_sat_s16(d, tcg_env, d);
+}
+
+static void gen_sqshrn_s(TCGv_i64 d, TCGv_i64 s, int64_t i)
+{
+    gen_sshr_d(d, s, i);
+    gen_helper_neon_narrow_sat_s32(d, tcg_env, d);
+}
+
+static void gen_uqshrn_b(TCGv_i64 d, TCGv_i64 s, int64_t i)
+{
+    tcg_gen_shri_i64(d, s, i);
+    gen_helper_neon_narrow_sat_u8(d, tcg_env, d);
+}
+
+static void gen_uqshrn_h(TCGv_i64 d, TCGv_i64 s, int64_t i)
+{
+    tcg_gen_shri_i64(d, s, i);
+    gen_helper_neon_narrow_sat_u16(d, tcg_env, d);
+}
+
+static void gen_uqshrn_s(TCGv_i64 d, TCGv_i64 s, int64_t i)
+{
+    gen_ushr_d(d, s, i);
+    gen_helper_neon_narrow_sat_u32(d, tcg_env, d);
+}
+
+static void gen_sqshrun_b(TCGv_i64 d, TCGv_i64 s, int64_t i)
+{
+    tcg_gen_sari_i64(d, s, i);
+    tcg_gen_ext16u_i64(d, d);
+    gen_helper_neon_unarrow_sat8(d, tcg_env, d);
+}
+
+static void gen_sqshrun_h(TCGv_i64 d, TCGv_i64 s, int64_t i)
+{
+    tcg_gen_sari_i64(d, s, i);
+    tcg_gen_ext32u_i64(d, d);
+    gen_helper_neon_unarrow_sat16(d, tcg_env, d);
+}
+
+static void gen_sqshrun_s(TCGv_i64 d, TCGv_i64 s, int64_t i)
+{
+    gen_sshr_d(d, s, i);
+    gen_helper_neon_unarrow_sat32(d, tcg_env, d);
+}
+
+static void gen_sqrshrn_b(TCGv_i64 d, TCGv_i64 s, int64_t i)
+{
+    gen_srshr_bhs(d, s, i);
+    tcg_gen_ext16u_i64(d, d);
+    gen_helper_neon_narrow_sat_s8(d, tcg_env, d);
+}
+
+static void gen_sqrshrn_h(TCGv_i64 d, TCGv_i64 s, int64_t i)
+{
+    gen_srshr_bhs(d, s, i);
+    tcg_gen_ext32u_i64(d, d);
+    gen_helper_neon_narrow_sat_s16(d, tcg_env, d);
+}
+
+static void gen_sqrshrn_s(TCGv_i64 d, TCGv_i64 s, int64_t i)
+{
+    gen_srshr_d(d, s, i);
+    gen_helper_neon_narrow_sat_s32(d, tcg_env, d);
+}
+
+static void gen_uqrshrn_b(TCGv_i64 d, TCGv_i64 s, int64_t i)
+{
+    gen_urshr_bhs(d, s, i);
+    gen_helper_neon_narrow_sat_u8(d, tcg_env, d);
+}
+
+static void gen_uqrshrn_h(TCGv_i64 d, TCGv_i64 s, int64_t i)
+{
+    gen_urshr_bhs(d, s, i);
+    gen_helper_neon_narrow_sat_u16(d, tcg_env, d);
+}
+
+static void gen_uqrshrn_s(TCGv_i64 d, TCGv_i64 s, int64_t i)
+{
+    gen_urshr_d(d, s, i);
+    gen_helper_neon_narrow_sat_u32(d, tcg_env, d);
+}
+
+static void gen_sqrshrun_b(TCGv_i64 d, TCGv_i64 s, int64_t i)
+{
+    gen_srshr_bhs(d, s, i);
+    tcg_gen_ext16u_i64(d, d);
+    gen_helper_neon_unarrow_sat8(d, tcg_env, d);
+}
+
+static void gen_sqrshrun_h(TCGv_i64 d, TCGv_i64 s, int64_t i)
+{
+    gen_srshr_bhs(d, s, i);
+    tcg_gen_ext32u_i64(d, d);
+    gen_helper_neon_unarrow_sat16(d, tcg_env, d);
+}
+
+static void gen_sqrshrun_s(TCGv_i64 d, TCGv_i64 s, int64_t i)
+{
+    gen_srshr_d(d, s, i);
+    gen_helper_neon_unarrow_sat32(d, tcg_env, d);
+}
+
 static WideShiftImmFn * const shrn_fns[] = {
     tcg_gen_shri_i64,
     tcg_gen_shri_i64,
@@ -7177,6 +7293,48 @@ static WideShiftImmFn * const rshrn_fns[] = {
 };
 TRANS(RSHRN_v, do_vec_shift_imm_narrow, a, rshrn_fns, 0)
 
+static WideShiftImmFn * const sqshrn_fns[] = {
+    gen_sqshrn_b,
+    gen_sqshrn_h,
+    gen_sqshrn_s,
+};
+TRANS(SQSHRN_v, do_vec_shift_imm_narrow, a, sqshrn_fns, MO_SIGN)
+
+static WideShiftImmFn * const uqshrn_fns[] = {
+    gen_uqshrn_b,
+    gen_uqshrn_h,
+    gen_uqshrn_s,
+};
+TRANS(UQSHRN_v, do_vec_shift_imm_narrow, a, uqshrn_fns, 0)
+
+static WideShiftImmFn * const sqshrun_fns[] = {
+    gen_sqshrun_b,
+    gen_sqshrun_h,
+    gen_sqshrun_s,
+};
+TRANS(SQSHRUN_v, do_vec_shift_imm_narrow, a, sqshrun_fns, MO_SIGN)
+
+static WideShiftImmFn * const sqrshrn_fns[] = {
+    gen_sqrshrn_b,
+    gen_sqrshrn_h,
+    gen_sqrshrn_s,
+};
+TRANS(SQRSHRN_v, do_vec_shift_imm_narrow, a, sqrshrn_fns, MO_SIGN)
+
+static WideShiftImmFn * const uqrshrn_fns[] = {
+    gen_uqrshrn_b,
+    gen_uqrshrn_h,
+    gen_uqrshrn_s,
+};
+TRANS(UQRSHRN_v, do_vec_shift_imm_narrow, a, uqrshrn_fns, 0)
+
+static WideShiftImmFn * const sqrshrun_fns[] = {
+    gen_sqrshrun_b,
+    gen_sqrshrun_h,
+    gen_sqrshrun_s,
+};
+TRANS(SQRSHRUN_v, do_vec_shift_imm_narrow, a, sqrshrun_fns, MO_SIGN)
+
 /*
  * Advanced SIMD Scalar Shift by Immediate
  */
@@ -10514,20 +10672,6 @@ static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x10: /* SHRN / SQSHRUN */
-    case 0x11: /* RSHRN / SQRSHRUN */
-        if (is_u) {
-            handle_vec_simd_sqshrn(s, false, is_q, false, true, immh, immb,
-                                   opcode, rn, rd);
-        } else {
-            unallocated_encoding(s);
-        }
-        break;
-    case 0x12: /* SQSHRN / UQSHRN */
-    case 0x13: /* SQRSHRN / UQRSHRN */
-        handle_vec_simd_sqshrn(s, false, is_q, is_u, is_u, immh, immb,
-                               opcode, rn, rd);
-        break;
     case 0x1c: /* SCVTF / UCVTF */
         handle_simd_shift_intfp_conv(s, false, is_q, is_u, immh, immb,
                                      opcode, rn, rd);
@@ -10544,6 +10688,10 @@ static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
     case 0x0a: /* SHL / SLI */
     case 0x0c: /* SQSHLU */
     case 0x0e: /* SQSHL, UQSHL */
+    case 0x10: /* SHRN / SQSHRUN */
+    case 0x11: /* RSHRN / SQRSHRUN */
+    case 0x12: /* SQSHRN / UQSHRN */
+    case 0x13: /* SQRSHRN / UQRSHRN */
     case 0x14: /* SSHLL / USHLL */
         unallocated_encoding(s);
         return;
-- 
2.34.1


