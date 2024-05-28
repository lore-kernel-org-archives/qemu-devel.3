Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE8BC25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 14:10:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBxUx-0001h4-BT; Tue, 28 May 2024 10:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUu-0001eZ-GN
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:16 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUq-00075H-4Y
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:16 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-420180b58c5so6691415e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 07:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905291; x=1717510091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aHiht3qjK9nTz/BmiDNiUp/VCOepZ4hbiSkB0EhpyPY=;
 b=fX77is8sQSXww2TGufqujIVc3IvdqeOvFpQJknp5mf6R5kgNdOWONJqCXZgfRwHh5i
 yUsVwC71ZZGCofZtlImlzw5nHKxmx19dr3BCE95p0CFDmuxsMDPVraaJ8XDVazP+0F5G
 6LHMA63NIi3wz9WgOrEvLoXZb7bfikQtowz43dwJ6g5UJ7K1ggEU+p3vHlBu5E6wnv3D
 4s264/2qKQ+JKOEdl+F9S6CYp6HjS3TMnX1qBRWO/PkBWn7+p0qdumHwrZvYGc+tdEnJ
 ztJFyl+wS4QhfJLenRQu+j8a06apaM2aedJxb40j6Ym/vmYaYvqofYAF0Jk4nk00Hgmx
 yQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905291; x=1717510091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aHiht3qjK9nTz/BmiDNiUp/VCOepZ4hbiSkB0EhpyPY=;
 b=ev9kdpnnum6syr8jbsyD8McYxF3d3KbJFffa1oezMDU7HUuP5+NJwXSpBh2MiM8fMP
 RsLySTnHofljuEk2jXwKqeTiEFSAOVi+HKKgKtob+xYwcHLh7BNHLrU6NLH1Ymqv9dkC
 juKRmhKpFG1DTEglPmtbo4r+6q+963tmQxOkJskxcIXFk7x40+X6ozPNpckRa8mVN/Lo
 sKfu0Tw7UIg/sQVprSOiGSisu5SR+pBAF0NMObdNfkyncxOZzfO6+SY6e+fj/9hg5j1T
 I6ZQjE/BFsAMfGx06dOy51RpIisam+wEfNMWR4VLvS9QrDi9Qs2hM+Omntu905JvHM3s
 SlTA==
X-Gm-Message-State: AOJu0YygQlLxx+kfIoF4Xn8IElkOThxEq9DAbbq0YY/kjbs39ZYR7c+G
 /Yq7Xa+3OITO7lH6v+V4v3Jr+dKHauHh139eD2dOBmxHJgD2X4qSZjvoB2wIGjxTg7JtDdMNHKt
 6
X-Google-Smtp-Source: AGHT+IEmF7MCZSpjfpv+ZzqS/PDEn3xIxBR41JP1+4oIVuDOMWKNnaTaFALHGpsj/MaGHmv1Vhotmg==
X-Received: by 2002:a05:600c:4506:b0:421:205f:52de with SMTP id
 5b1f17b1804b1-421205f543bmr13251625e9.26.1716905290756; 
 Tue, 28 May 2024 07:08:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3564afc3577sm11361473f8f.102.2024.05.28.07.08.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:08:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/42] target/arm: Convert FMAX, FMIN, FMAXNM,
 FMINNM to decodetree
Date: Tue, 28 May 2024 15:07:37 +0100
Message-Id: <20240528140753.3620597-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528140753.3620597-1-peter.maydell@linaro.org>
References: <20240528140753.3620597-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Message-id: 20240524232121.284515-21-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h            |   4 +
 target/arm/tcg/a64.decode      |  17 ++++
 target/arm/tcg/translate-a64.c | 168 +++++++++++++++++----------------
 target/arm/tcg/vec_helper.c    |   4 +
 4 files changed, 113 insertions(+), 80 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 2b027333053..7ee15b96512 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -748,15 +748,19 @@ DEF_HELPER_FLAGS_5(gvec_facgt_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fmax_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fmax_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmax_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fmin_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fmin_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmin_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fmaxnum_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fmaxnum_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmaxnum_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fminnum_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fminnum_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fminnum_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_recps_nf_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_recps_nf_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 82daafbef52..e2678d919e5 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -704,6 +704,11 @@ FSUB_s          0001 1110 ..1 ..... 0011 10 ..... ..... @rrr_hsd
 FDIV_s          0001 1110 ..1 ..... 0001 10 ..... ..... @rrr_hsd
 FMUL_s          0001 1110 ..1 ..... 0000 10 ..... ..... @rrr_hsd
 
+FMAX_s          0001 1110 ..1 ..... 0100 10 ..... ..... @rrr_hsd
+FMIN_s          0001 1110 ..1 ..... 0101 10 ..... ..... @rrr_hsd
+FMAXNM_s        0001 1110 ..1 ..... 0110 10 ..... ..... @rrr_hsd
+FMINNM_s        0001 1110 ..1 ..... 0111 10 ..... ..... @rrr_hsd
+
 FMULX_s         0101 1110 010 ..... 00011 1 ..... ..... @rrr_h
 FMULX_s         0101 1110 0.1 ..... 11011 1 ..... ..... @rrr_sd
 
@@ -721,6 +726,18 @@ FDIV_v          0.10 1110 0.1 ..... 11111 1 ..... ..... @qrrr_sd
 FMUL_v          0.10 1110 010 ..... 00011 1 ..... ..... @qrrr_h
 FMUL_v          0.10 1110 0.1 ..... 11011 1 ..... ..... @qrrr_sd
 
+FMAX_v          0.00 1110 010 ..... 00110 1 ..... ..... @qrrr_h
+FMAX_v          0.00 1110 0.1 ..... 11110 1 ..... ..... @qrrr_sd
+
+FMIN_v          0.00 1110 110 ..... 00110 1 ..... ..... @qrrr_h
+FMIN_v          0.00 1110 1.1 ..... 11110 1 ..... ..... @qrrr_sd
+
+FMAXNM_v        0.00 1110 010 ..... 00000 1 ..... ..... @qrrr_h
+FMAXNM_v        0.00 1110 0.1 ..... 11000 1 ..... ..... @qrrr_sd
+
+FMINNM_v        0.00 1110 110 ..... 00000 1 ..... ..... @qrrr_h
+FMINNM_v        0.00 1110 1.1 ..... 11000 1 ..... ..... @qrrr_sd
+
 FMULX_v         0.00 1110 010 ..... 00011 1 ..... ..... @qrrr_h
 FMULX_v         0.00 1110 0.1 ..... 11011 1 ..... ..... @qrrr_sd
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 97c3d758d62..6f8207d842b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4915,6 +4915,34 @@ static const FPScalar f_scalar_fmul = {
 };
 TRANS(FMUL_s, do_fp3_scalar, a, &f_scalar_fmul)
 
+static const FPScalar f_scalar_fmax = {
+    gen_helper_advsimd_maxh,
+    gen_helper_vfp_maxs,
+    gen_helper_vfp_maxd,
+};
+TRANS(FMAX_s, do_fp3_scalar, a, &f_scalar_fmax)
+
+static const FPScalar f_scalar_fmin = {
+    gen_helper_advsimd_minh,
+    gen_helper_vfp_mins,
+    gen_helper_vfp_mind,
+};
+TRANS(FMIN_s, do_fp3_scalar, a, &f_scalar_fmin)
+
+static const FPScalar f_scalar_fmaxnm = {
+    gen_helper_advsimd_maxnumh,
+    gen_helper_vfp_maxnums,
+    gen_helper_vfp_maxnumd,
+};
+TRANS(FMAXNM_s, do_fp3_scalar, a, &f_scalar_fmaxnm)
+
+static const FPScalar f_scalar_fminnm = {
+    gen_helper_advsimd_minnumh,
+    gen_helper_vfp_minnums,
+    gen_helper_vfp_minnumd,
+};
+TRANS(FMINNM_s, do_fp3_scalar, a, &f_scalar_fminnm)
+
 static const FPScalar f_scalar_fmulx = {
     gen_helper_advsimd_mulxh,
     gen_helper_vfp_mulxs,
@@ -4978,6 +5006,34 @@ static gen_helper_gvec_3_ptr * const f_vector_fmul[3] = {
 };
 TRANS(FMUL_v, do_fp3_vector, a, f_vector_fmul)
 
+static gen_helper_gvec_3_ptr * const f_vector_fmax[3] = {
+    gen_helper_gvec_fmax_h,
+    gen_helper_gvec_fmax_s,
+    gen_helper_gvec_fmax_d,
+};
+TRANS(FMAX_v, do_fp3_vector, a, f_vector_fmax)
+
+static gen_helper_gvec_3_ptr * const f_vector_fmin[3] = {
+    gen_helper_gvec_fmin_h,
+    gen_helper_gvec_fmin_s,
+    gen_helper_gvec_fmin_d,
+};
+TRANS(FMIN_v, do_fp3_vector, a, f_vector_fmin)
+
+static gen_helper_gvec_3_ptr * const f_vector_fmaxnm[3] = {
+    gen_helper_gvec_fmaxnum_h,
+    gen_helper_gvec_fmaxnum_s,
+    gen_helper_gvec_fmaxnum_d,
+};
+TRANS(FMAXNM_v, do_fp3_vector, a, f_vector_fmaxnm)
+
+static gen_helper_gvec_3_ptr * const f_vector_fminnm[3] = {
+    gen_helper_gvec_fminnum_h,
+    gen_helper_gvec_fminnum_s,
+    gen_helper_gvec_fminnum_d,
+};
+TRANS(FMINNM_v, do_fp3_vector, a, f_vector_fminnm)
+
 static gen_helper_gvec_3_ptr * const f_vector_fmulx[3] = {
     gen_helper_gvec_fmulx_h,
     gen_helper_gvec_fmulx_s,
@@ -6891,18 +6947,6 @@ static void handle_fp_2src_single(DisasContext *s, int opcode,
     tcg_op2 = read_fp_sreg(s, rm);
 
     switch (opcode) {
-    case 0x4: /* FMAX */
-        gen_helper_vfp_maxs(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
-    case 0x5: /* FMIN */
-        gen_helper_vfp_mins(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
-    case 0x6: /* FMAXNM */
-        gen_helper_vfp_maxnums(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
-    case 0x7: /* FMINNM */
-        gen_helper_vfp_minnums(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
     case 0x8: /* FNMUL */
         gen_helper_vfp_muls(tcg_res, tcg_op1, tcg_op2, fpst);
         gen_helper_vfp_negs(tcg_res, tcg_res);
@@ -6912,6 +6956,10 @@ static void handle_fp_2src_single(DisasContext *s, int opcode,
     case 0x1: /* FDIV */
     case 0x2: /* FADD */
     case 0x3: /* FSUB */
+    case 0x4: /* FMAX */
+    case 0x5: /* FMIN */
+    case 0x6: /* FMAXNM */
+    case 0x7: /* FMINNM */
         g_assert_not_reached();
     }
 
@@ -6933,18 +6981,6 @@ static void handle_fp_2src_double(DisasContext *s, int opcode,
     tcg_op2 = read_fp_dreg(s, rm);
 
     switch (opcode) {
-    case 0x4: /* FMAX */
-        gen_helper_vfp_maxd(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
-    case 0x5: /* FMIN */
-        gen_helper_vfp_mind(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
-    case 0x6: /* FMAXNM */
-        gen_helper_vfp_maxnumd(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
-    case 0x7: /* FMINNM */
-        gen_helper_vfp_minnumd(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
     case 0x8: /* FNMUL */
         gen_helper_vfp_muld(tcg_res, tcg_op1, tcg_op2, fpst);
         gen_helper_vfp_negd(tcg_res, tcg_res);
@@ -6954,6 +6990,10 @@ static void handle_fp_2src_double(DisasContext *s, int opcode,
     case 0x1: /* FDIV */
     case 0x2: /* FADD */
     case 0x3: /* FSUB */
+    case 0x4: /* FMAX */
+    case 0x5: /* FMIN */
+    case 0x6: /* FMAXNM */
+    case 0x7: /* FMINNM */
         g_assert_not_reached();
     }
 
@@ -6975,18 +7015,6 @@ static void handle_fp_2src_half(DisasContext *s, int opcode,
     tcg_op2 = read_fp_hreg(s, rm);
 
     switch (opcode) {
-    case 0x4: /* FMAX */
-        gen_helper_advsimd_maxh(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
-    case 0x5: /* FMIN */
-        gen_helper_advsimd_minh(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
-    case 0x6: /* FMAXNM */
-        gen_helper_advsimd_maxnumh(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
-    case 0x7: /* FMINNM */
-        gen_helper_advsimd_minnumh(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
     case 0x8: /* FNMUL */
         gen_helper_advsimd_mulh(tcg_res, tcg_op1, tcg_op2, fpst);
         tcg_gen_xori_i32(tcg_res, tcg_res, 0x8000);
@@ -6996,6 +7024,10 @@ static void handle_fp_2src_half(DisasContext *s, int opcode,
     case 0x1: /* FDIV */
     case 0x2: /* FADD */
     case 0x3: /* FSUB */
+    case 0x4: /* FMAX */
+    case 0x5: /* FMIN */
+    case 0x6: /* FMAXNM */
+    case 0x7: /* FMINNM */
         g_assert_not_reached();
     }
 
@@ -9221,24 +9253,12 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
                 gen_helper_vfp_muladdd(tcg_res, tcg_op1, tcg_op2,
                                        tcg_res, fpst);
                 break;
-            case 0x18: /* FMAXNM */
-                gen_helper_vfp_maxnumd(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x1c: /* FCMEQ */
                 gen_helper_neon_ceq_f64(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x1e: /* FMAX */
-                gen_helper_vfp_maxd(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x1f: /* FRECPS */
                 gen_helper_recpsf_f64(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x38: /* FMINNM */
-                gen_helper_vfp_minnumd(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
-            case 0x3e: /* FMIN */
-                gen_helper_vfp_mind(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x3f: /* FRSQRTS */
                 gen_helper_rsqrtsf_f64(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
@@ -9259,9 +9279,13 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
                 gen_helper_neon_acgt_f64(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             default:
+            case 0x18: /* FMAXNM */
             case 0x1a: /* FADD */
             case 0x1b: /* FMULX */
+            case 0x1e: /* FMAX */
+            case 0x38: /* FMINNM */
             case 0x3a: /* FSUB */
+            case 0x3e: /* FMIN */
             case 0x5b: /* FMUL */
             case 0x5f: /* FDIV */
                 g_assert_not_reached();
@@ -9290,21 +9314,9 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
             case 0x1c: /* FCMEQ */
                 gen_helper_neon_ceq_f32(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x1e: /* FMAX */
-                gen_helper_vfp_maxs(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x1f: /* FRECPS */
                 gen_helper_recpsf_f32(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x18: /* FMAXNM */
-                gen_helper_vfp_maxnums(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
-            case 0x38: /* FMINNM */
-                gen_helper_vfp_minnums(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
-            case 0x3e: /* FMIN */
-                gen_helper_vfp_mins(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x3f: /* FRSQRTS */
                 gen_helper_rsqrtsf_f32(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
@@ -9325,9 +9337,13 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
                 gen_helper_neon_acgt_f32(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             default:
+            case 0x18: /* FMAXNM */
             case 0x1a: /* FADD */
             case 0x1b: /* FMULX */
+            case 0x1e: /* FMAX */
+            case 0x38: /* FMINNM */
             case 0x3a: /* FSUB */
+            case 0x3e: /* FMIN */
             case 0x5b: /* FMUL */
             case 0x5f: /* FDIV */
                 g_assert_not_reached();
@@ -11251,11 +11267,7 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
     case 0x7d: /* FACGT */
     case 0x19: /* FMLA */
     case 0x39: /* FMLS */
-    case 0x18: /* FMAXNM */
     case 0x1c: /* FCMEQ */
-    case 0x1e: /* FMAX */
-    case 0x38: /* FMINNM */
-    case 0x3e: /* FMIN */
     case 0x5c: /* FCMGE */
     case 0x7a: /* FABD */
     case 0x7c: /* FCMGT */
@@ -11286,9 +11298,13 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
         return;
 
     default:
+    case 0x18: /* FMAXNM */
     case 0x1a: /* FADD */
     case 0x1b: /* FMULX */
+    case 0x1e: /* FMAX */
+    case 0x38: /* FMINNM */
     case 0x3a: /* FSUB */
+    case 0x3e: /* FMIN */
     case 0x5b: /* FMUL */
     case 0x5f: /* FDIV */
         unallocated_encoding(s);
@@ -11632,14 +11648,10 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
     int pass;
 
     switch (fpopcode) {
-    case 0x0: /* FMAXNM */
     case 0x1: /* FMLA */
     case 0x4: /* FCMEQ */
-    case 0x6: /* FMAX */
     case 0x7: /* FRECPS */
-    case 0x8: /* FMINNM */
     case 0x9: /* FMLS */
-    case 0xe: /* FMIN */
     case 0xf: /* FRSQRTS */
     case 0x14: /* FCMGE */
     case 0x15: /* FACGE */
@@ -11656,9 +11668,13 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
         pairwise = true;
         break;
     default:
+    case 0x0: /* FMAXNM */
     case 0x2: /* FADD */
     case 0x3: /* FMULX */
+    case 0x6: /* FMAX */
+    case 0x8: /* FMINNM */
     case 0xa: /* FSUB */
+    case 0xe: /* FMIN */
     case 0x13: /* FMUL */
     case 0x17: /* FDIV */
         unallocated_encoding(s);
@@ -11726,9 +11742,6 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
             read_vec_element_i32(s, tcg_op2, rm, pass, MO_16);
 
             switch (fpopcode) {
-            case 0x0: /* FMAXNM */
-                gen_helper_advsimd_maxnumh(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x1: /* FMLA */
                 read_vec_element_i32(s, tcg_res, rd, pass, MO_16);
                 gen_helper_advsimd_muladdh(tcg_res, tcg_op1, tcg_op2, tcg_res,
@@ -11737,15 +11750,9 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
             case 0x4: /* FCMEQ */
                 gen_helper_advsimd_ceq_f16(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x6: /* FMAX */
-                gen_helper_advsimd_maxh(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x7: /* FRECPS */
                 gen_helper_recpsf_f16(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x8: /* FMINNM */
-                gen_helper_advsimd_minnumh(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x9: /* FMLS */
                 /* As usual for ARM, separate negation for fused multiply-add */
                 tcg_gen_xori_i32(tcg_op1, tcg_op1, 0x8000);
@@ -11753,9 +11760,6 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
                 gen_helper_advsimd_muladdh(tcg_res, tcg_op1, tcg_op2, tcg_res,
                                            fpst);
                 break;
-            case 0xe: /* FMIN */
-                gen_helper_advsimd_minh(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0xf: /* FRSQRTS */
                 gen_helper_rsqrtsf_f16(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
@@ -11776,9 +11780,13 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
                 gen_helper_advsimd_acgt_f16(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             default:
+            case 0x0: /* FMAXNM */
             case 0x2: /* FADD */
             case 0x3: /* FMULX */
+            case 0x6: /* FMAX */
+            case 0x8: /* FMINNM */
             case 0xa: /* FSUB */
+            case 0xe: /* FMIN */
             case 0x13: /* FMUL */
             case 0x17: /* FDIV */
                 g_assert_not_reached();
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 41065363710..99ef6760719 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1231,15 +1231,19 @@ DO_3OP(gvec_facgt_s, float32_acgt, float32)
 
 DO_3OP(gvec_fmax_h, float16_max, float16)
 DO_3OP(gvec_fmax_s, float32_max, float32)
+DO_3OP(gvec_fmax_d, float64_max, float64)
 
 DO_3OP(gvec_fmin_h, float16_min, float16)
 DO_3OP(gvec_fmin_s, float32_min, float32)
+DO_3OP(gvec_fmin_d, float64_min, float64)
 
 DO_3OP(gvec_fmaxnum_h, float16_maxnum, float16)
 DO_3OP(gvec_fmaxnum_s, float32_maxnum, float32)
+DO_3OP(gvec_fmaxnum_d, float64_maxnum, float64)
 
 DO_3OP(gvec_fminnum_h, float16_minnum, float16)
 DO_3OP(gvec_fminnum_s, float32_minnum, float32)
+DO_3OP(gvec_fminnum_d, float64_minnum, float64)
 
 DO_3OP(gvec_recps_nf_h, float16_recps_nf, float16)
 DO_3OP(gvec_recps_nf_s, float32_recps_nf, float32)
-- 
2.34.1


