Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA23C25B7E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD108-0004ZC-7r; Fri, 31 May 2024 08:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zp-0004Ri-PD
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:34 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zl-0003VB-4F
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:33 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ea9afcb22aso2654841fa.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717157067; x=1717761867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lp+/X88V1cN3DiJPh+4GRBximLqT07dhOX8IzJHhHVM=;
 b=YFBSFGgCVhLYyblZW97SFHZHoCKVjOmjy/m9Ij9P0eDsfed91jvNcUKz1WowGT1/DV
 rFpfHqv7pPKmX+ZM8IZCZAqGD2yq6V3Mu9aR2oYQLAgR006OKCMgHdXgW2yj1x93uCXC
 mFfEOr/57+QZw+fFwOgWHSB9l+vsOr8Ab/sp/81kKShbybgq3Jvd8Ei9a3nMZ8cKtft5
 WKbXeID2Uf4i/Y+ALCEraGq7ZkO5iMn6L2FOrRbkq045hfJBNv1oiHWQbq5+HkgPxzOj
 uN23JzGPkSYE6JAL8oEZX4WhAhVsLJVEB7I6wqZTRXAfIa+KakRp8Z/vo/QTTESgJeXE
 KFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717157067; x=1717761867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lp+/X88V1cN3DiJPh+4GRBximLqT07dhOX8IzJHhHVM=;
 b=tWNyXGaQWckRbO70iKHEAisKOW8/vEWBjOt1UC+tgGo49FvhU6PIFmqeyo8NJxG0pX
 B0X8ZUUACfXgc/SS8NOXQQdYwuZ2Q07+/NT/1MmYuR1gdgc9NsnTo7G0hye+cJMObI2Q
 lVNxjos8h+X7hDf9DRajNdgm+ZDIu0yxfsifM4uYl7GIvSc9OKcp7zfqSj8pVM2m+GZW
 km2VWcqBXaR18FXae7xJO0kB+hKLYxLEArvy2DU5hdFCxEK2usFmUT6DmS2nehQbh6Rk
 rESpmX/Ahd8XUibNT344MnPLGIwKqFVQF7OCLk7p2PGlkcAvTxpwkNR0UOns+vmsevSa
 K0ag==
X-Gm-Message-State: AOJu0YzRVjepMnM+C7Yua2onWahogzk1V6s9ONEXIO705dKGf58EpxjB
 5v/+cLSokFJXRvUcpfjwv6nL3fPkj7mV67xfhOirpdT370YQxVBbzXInPtsINOYhJFiqbiPSJpP
 O
X-Google-Smtp-Source: AGHT+IEfKj4YHX/FIJgmFsFum/UsrgeDrLj0Tv7Zmmi4IagAYZDkzNjqtnXJvVPfvcxdvUet4ecLOA==
X-Received: by 2002:a05:651c:2c6:b0:2e0:2ef4:a985 with SMTP id
 38308e7fff4ca-2ea951a9e8dmr10572531fa.35.1717157066613; 
 Fri, 31 May 2024 05:04:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm37027685e9.13.2024.05.31.05.04.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:04:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/43] target/arm: Convert MLA, MLS to decodetree
Date: Fri, 31 May 2024 13:03:52 +0100
Message-Id: <20240531120401.394550-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531120401.394550-1-peter.maydell@linaro.org>
References: <20240531120401.394550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
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
Message-id: 20240528203044.612851-30-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  8 ++++
 target/arm/tcg/translate-a64.c | 77 ++++++++++------------------------
 2 files changed, 31 insertions(+), 54 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 3ea06433701..2dea68a0a9d 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -928,6 +928,8 @@ SABA_v          0.00 1110 ..1 ..... 01111 1 ..... ..... @qrrr_e
 UABA_v          0.10 1110 ..1 ..... 01111 1 ..... ..... @qrrr_e
 MUL_v           0.00 1110 ..1 ..... 10011 1 ..... ..... @qrrr_e
 PMUL_v          0.10 1110 001 ..... 10011 1 ..... ..... @qrrr_b
+MLA_v           0.00 1110 ..1 ..... 10010 1 ..... ..... @qrrr_e
+MLS_v           0.10 1110 ..1 ..... 10010 1 ..... ..... @qrrr_e
 
 ### Advanced SIMD scalar x indexed element
 
@@ -972,3 +974,9 @@ FMLSL2_vi       0.10 1111 10 .. .... 1100 . 0 ..... .....   @qrrx_h
 
 MUL_vi          0.00 1111 01 .. .... 1000 . 0 ..... .....   @qrrx_h
 MUL_vi          0.00 1111 10 . ..... 1000 . 0 ..... .....   @qrrx_s
+
+MLA_vi          0.10 1111 01 .. .... 0000 . 0 ..... .....   @qrrx_h
+MLA_vi          0.10 1111 10 . ..... 0000 . 0 ..... .....   @qrrx_s
+
+MLS_vi          0.10 1111 01 .. .... 0100 . 0 ..... .....   @qrrx_h
+MLS_vi          0.10 1111 10 . ..... 0100 . 0 ..... .....   @qrrx_s
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1909d1426c4..c4601cde2f7 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5470,6 +5470,8 @@ TRANS(SABD_v, do_gvec_fn3_no64, a, gen_gvec_sabd)
 TRANS(UABD_v, do_gvec_fn3_no64, a, gen_gvec_uabd)
 TRANS(MUL_v, do_gvec_fn3_no64, a, tcg_gen_gvec_mul)
 TRANS(PMUL_v, do_gvec_op3_ool, a, 0, gen_helper_gvec_pmul_b)
+TRANS(MLA_v, do_gvec_fn3_no64, a, gen_gvec_mla)
+TRANS(MLS_v, do_gvec_fn3_no64, a, gen_gvec_mls)
 
 static bool do_cmop_v(DisasContext *s, arg_qrrr_e *a, TCGCond cond)
 {
@@ -5712,6 +5714,24 @@ static gen_helper_gvec_3 * const f_vector_idx_mul[2] = {
 };
 TRANS(MUL_vi, do_int3_vector_idx, a, f_vector_idx_mul)
 
+static bool do_mla_vector_idx(DisasContext *s, arg_qrrx_e *a, bool sub)
+{
+    static gen_helper_gvec_4 * const fns[2][2] = {
+        { gen_helper_gvec_mla_idx_h, gen_helper_gvec_mls_idx_h },
+        { gen_helper_gvec_mla_idx_s, gen_helper_gvec_mls_idx_s },
+    };
+
+    assert(a->esz == MO_16 || a->esz == MO_32);
+    if (fp_access_check(s)) {
+        gen_gvec_op4_ool(s, a->q, a->rd, a->rn, a->rm, a->rd,
+                         a->idx, fns[a->esz - 1][sub]);
+    }
+    return true;
+}
+
+TRANS(MLA_vi, do_mla_vector_idx, a, false)
+TRANS(MLS_vi, do_mla_vector_idx, a, true)
+
 /*
  * Advanced SIMD scalar pairwise
  */
@@ -10945,12 +10965,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     int rd = extract32(insn, 0, 5);
 
     switch (opcode) {
-    case 0x12: /* MLA, MLS */
-        if (size == 3) {
-            unallocated_encoding(s);
-            return;
-        }
-        break;
     case 0x16: /* SQDMULH, SQRDMULH */
         if (size == 0 || size == 3) {
             unallocated_encoding(s);
@@ -10981,6 +10995,7 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     case 0x0f: /* SABA, UABA */
     case 0x10: /* ADD, SUB */
     case 0x11: /* CMTST, CMEQ */
+    case 0x12: /* MLA, MLS */
     case 0x13: /* MUL, PMUL */
         unallocated_encoding(s);
         return;
@@ -10991,13 +11006,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x12: /* MLA, MLS */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_mls, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_mla, size);
-        }
-        return;
     case 0x16: /* SQDMULH, SQRDMULH */
         {
             static gen_helper_gvec_3_ptr * const fns[2][2] = {
@@ -12204,13 +12212,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     TCGv_ptr fpst;
 
     switch (16 * u + opcode) {
-    case 0x10: /* MLA */
-    case 0x14: /* MLS */
-        if (is_scalar) {
-            unallocated_encoding(s);
-            return;
-        }
-        break;
     case 0x02: /* SMLAL, SMLAL2 */
     case 0x12: /* UMLAL, UMLAL2 */
     case 0x06: /* SMLSL, SMLSL2 */
@@ -12292,6 +12293,8 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     case 0x05: /* FMLS */
     case 0x08: /* MUL */
     case 0x09: /* FMUL */
+    case 0x10: /* MLA */
+    case 0x14: /* MLS */
     case 0x18: /* FMLAL2 */
     case 0x19: /* FMULX */
     case 0x1c: /* FMLSL2 */
@@ -12412,40 +12415,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
                                : gen_helper_gvec_fcmlah_idx);
         }
         return;
-
-    case 0x10: /* MLA */
-        if (!is_long && !is_scalar) {
-            static gen_helper_gvec_4 * const fns[3] = {
-                gen_helper_gvec_mla_idx_h,
-                gen_helper_gvec_mla_idx_s,
-                gen_helper_gvec_mla_idx_d,
-            };
-            tcg_gen_gvec_4_ool(vec_full_reg_offset(s, rd),
-                               vec_full_reg_offset(s, rn),
-                               vec_full_reg_offset(s, rm),
-                               vec_full_reg_offset(s, rd),
-                               is_q ? 16 : 8, vec_full_reg_size(s),
-                               index, fns[size - 1]);
-            return;
-        }
-        break;
-
-    case 0x14: /* MLS */
-        if (!is_long && !is_scalar) {
-            static gen_helper_gvec_4 * const fns[3] = {
-                gen_helper_gvec_mls_idx_h,
-                gen_helper_gvec_mls_idx_s,
-                gen_helper_gvec_mls_idx_d,
-            };
-            tcg_gen_gvec_4_ool(vec_full_reg_offset(s, rd),
-                               vec_full_reg_offset(s, rn),
-                               vec_full_reg_offset(s, rm),
-                               vec_full_reg_offset(s, rd),
-                               is_q ? 16 : 8, vec_full_reg_size(s),
-                               index, fns[size - 1]);
-            return;
-        }
-        break;
     }
 
     if (size == 3) {
-- 
2.34.1


