Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19DFECE581
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 16:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snhAW-00042e-9g; Mon, 09 Sep 2024 12:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snhAV-0003ur-6G
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:23:11 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snhAS-0007os-VL
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:23:10 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2059204f448so37000425ad.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 09:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725898987; x=1726503787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fEr4gUO/TO6Ga9p70Ie8SnTEEJrfXbq+w9TTE12ZEKI=;
 b=QnJWfV/c5iDqQ9OPIZLg2NyQzAmjnEsd7WLVZ+5ybE9oAOdB4Zv4vUNLW7V9pd4TxC
 wLoEVKvx0wfiIV5SjpxasT3uad5Cqqk+j2CXaemXc0mJN/06ilacdYhpAhARIkWlgq/u
 nJyK+keFa3VyGCGr2bvsGTbJcVbuM28ivVMCRiSonadWadt+6zH9Otv597duuoUFRITq
 Z7NOH0IxLI9LAnotn8EW12xNIT6VTGiAzPWWE7O7HX/prKFPqorIs0aqgsJug+Utnete
 YUW51X1DrFUV6ckK/CqEH5JlOIQsOwPM/tqw6o1lM8LTW5JJ6KzDnNWqe+kPFK3p5pi1
 HSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725898987; x=1726503787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fEr4gUO/TO6Ga9p70Ie8SnTEEJrfXbq+w9TTE12ZEKI=;
 b=hKuJLA5PxTOCsdi17CgCf8X+8FZFD2Elt4zbjrHmK8tKVTHeM9nRtBLj8HD843J8tN
 zFEOeTDwq2qNyqxLgkHMjrP5Oyj9Uz/AwuROoOCC0wzCkGFSIKVPXfolF5yQzYESZxkf
 FpAFrgkxEImdeLz9MZ7t7VvTC7nI2z66ernI7iPiQLGcI3NWJbmyapC0O7Q391Wz/FXv
 a3AJwozTOsK2/t/wHq/WCe7YUwb1Eric7WGJIrfi8ye6nnrLorQdP8y8cX3uCRbMH6HU
 rRVuSGSRf7lDRRoa3Fz5WZMERh/+RUXppi9l1afjj0AiInwbLwveRpqnp+4v789SF86j
 Nd8w==
X-Gm-Message-State: AOJu0YxiA2D7hcOAOpTVjhWX/wIjvk/3MIt+xxVUigCu4rMmyB6035I1
 RuqpsmNJYiE6VSb9iCsJelX1TAEn7m1/sDXlDsZGCSmXlSeOdXj8YFgmP21pXk7/tw9QpggbIpF
 x
X-Google-Smtp-Source: AGHT+IFNrm7KYxJi17YT5Evs9+q1HeycPccEtlMOeXb39UBdxQFtkH4XQjEcYIdmN52uISZIlzNWRQ==
X-Received: by 2002:a17:903:1c5:b0:205:8b9e:964b with SMTP id
 d9443c01a7336-206f0612c09mr143462555ad.39.1725898987367; 
 Mon, 09 Sep 2024 09:23:07 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f35d79sm35753305ad.288.2024.09.09.09.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 09:23:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 28/29] target/arm: Convert vector [US]QSHRN, [US]QRSHRN,
 SQSHRUN to decodetree
Date: Mon,  9 Sep 2024 09:22:38 -0700
Message-ID: <20240909162240.647173-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909162240.647173-1-richard.henderson@linaro.org>
References: <20240909162240.647173-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
 target/arm/tcg/translate-a64.c | 176 ++++++++++++++++++++++++++++++---
 target/arm/tcg/a64.decode      |  24 +++++
 2 files changed, 186 insertions(+), 14 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 77324e0145..e6290e1145 100644
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
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 63e04ddfcd..042dc79d88 100644
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
-- 
2.43.0


