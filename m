Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1E2C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 05:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLyPq-00016S-LO; Tue, 25 Jun 2024 01:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLyPp-00014u-76
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:08:25 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLyPl-0001XL-Tw
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:08:24 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f480624d10so42089225ad.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 22:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719292099; x=1719896899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dZZKMigzegy7gdlKoRMc0EyyFAUb+mRaR5AzZiFiSzQ=;
 b=MLRRRuAKSg+XmAfoNTNagwUMoTknnrkGkkzMZ2c8K3aEzi7V2X2boWnOH68d/vG8CK
 mA67sxA638vQeSDERsooK2qYoDtgJBqnnuhEXfJkSBmfREq3cu4D6DJ0Phd2L04OhovM
 haZnb8zw9VPk58T/gEZhZ7197upyDE3Fjn/UWtpZHQgGrhxsW2xghMUZmi9lULW4Wsjl
 LhWmwB2yz3vl4UBVy8SGXYJjP/te0lnEdOyt5eU3sUylPv9ZoOFXxR8Ufmozymk/bSsO
 q9kgtXQ/ZfSOZc3+4a1tTs8CG0mCNjEa2RY9ILEUVk9qP1Lbic2Ru6gW20BknY4mPBAe
 f+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719292099; x=1719896899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dZZKMigzegy7gdlKoRMc0EyyFAUb+mRaR5AzZiFiSzQ=;
 b=dcKVCinhkhWcPIRI9oJswgTY0niGmuykLsn5TnOMq0x/DniK5XSoeiKDLPbZ7Sr4ch
 YwN1VRvWfmqIS5yiN23+ZHi378OsBwafp2lGJULVbrWSl3ohgEgd+zxLKjvdgOs4XsfW
 D3ERKD9WQUwauHdDrX29+nKXG176LEWaZdfu75lEFSEx+5wNW6PpJT1YPI0GLd/m9/6P
 I1dCcJaWaEJseihO8I0LF+nt+ON8gor2UuFpwYZSuhdEzkjAmy2q9uLdhFTKWAl6Ldek
 RvwxafimMYY/QmrPO35baBZwL3uXZBS6XmZNFQOHojZgYMxATlFzzFZonoa848FbUkWF
 1mAw==
X-Gm-Message-State: AOJu0YxFhCHb77VBPg2ha99HrswocHLJvVrbgdteNX2KGRPccSVc7p3i
 Xob6DIDrsmeToPqTxT7BfgA7NKKCqKLIOqYvyu2TS5tFAgpBpOwscNfgGc0V7LGZkqeMhVGkeFl
 N
X-Google-Smtp-Source: AGHT+IEjj6VYw/1xzdSlj5lbUw0u9xsDFpUMxoV5W4HMNVIVZDx1I8OqD7ToegPWqwaTrp5vsK46OA==
X-Received: by 2002:a17:902:e891:b0:1f6:65d3:296 with SMTP id
 d9443c01a7336-1fa1d51e5c2mr97803705ad.29.1719292099308; 
 Mon, 24 Jun 2024 22:08:19 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9ebbc72e9sm70843865ad.296.2024.06.24.22.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 22:08:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 07/13] target/arm: Convert BFDOT to decodetree
Date: Mon, 24 Jun 2024 22:08:04 -0700
Message-Id: <20240625050810.1475643-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625050810.1475643-1-richard.henderson@linaro.org>
References: <20240625050810.1475643-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/a64.decode      |  2 ++
 target/arm/tcg/translate-a64.c | 20 +++++---------------
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 8a0251f83c..6819fd2587 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -950,6 +950,7 @@ SQRDMLSH_v      0.10 1110 ..0 ..... 10001 1 ..... ..... @qrrr_e
 SDOT_v          0.00 1110 100 ..... 10010 1 ..... ..... @qrrr_s
 UDOT_v          0.10 1110 100 ..... 10010 1 ..... ..... @qrrr_s
 USDOT_v         0.00 1110 100 ..... 10011 1 ..... ..... @qrrr_s
+BFDOT_v         0.10 1110 010 ..... 11111 1 ..... ..... @qrrr_s
 
 ### Advanced SIMD scalar x indexed element
 
@@ -1029,6 +1030,7 @@ SDOT_vi         0.00 1111 10 .. .... 1110 . 0 ..... .....   @qrrx_s
 UDOT_vi         0.10 1111 10 .. .... 1110 . 0 ..... .....   @qrrx_s
 SUDOT_vi        0.00 1111 00 .. .... 1111 . 0 ..... .....   @qrrx_s
 USDOT_vi        0.00 1111 10 .. .... 1111 . 0 ..... .....   @qrrx_s
+BFDOT_vi        0.00 1111 01 .. .... 1111 . 0 ..... .....   @qrrx_s
 
 # Floating-point conditional select
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 9a658ca876..0f44cd5aee 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5604,6 +5604,7 @@ static bool do_dot_vector(DisasContext *s, arg_qrrr_e *a,
 TRANS_FEAT(SDOT_v, aa64_dp, do_dot_vector, a, gen_helper_gvec_sdot_b)
 TRANS_FEAT(UDOT_v, aa64_dp, do_dot_vector, a, gen_helper_gvec_udot_b)
 TRANS_FEAT(USDOT_v, aa64_i8mm, do_dot_vector, a, gen_helper_gvec_usdot_b)
+TRANS_FEAT(BFDOT_v, aa64_bf16, do_dot_vector, a, gen_helper_gvec_bfdot)
 
 /*
  * Advanced SIMD scalar/vector x indexed element
@@ -5942,6 +5943,8 @@ TRANS_FEAT(SUDOT_vi, aa64_i8mm, do_dot_vector_idx, a,
            gen_helper_gvec_sudot_idx_b)
 TRANS_FEAT(USDOT_vi, aa64_i8mm, do_dot_vector_idx, a,
            gen_helper_gvec_usdot_idx_b)
+TRANS_FEAT(BFDOT_vi, aa64_bf16, do_dot_vector_idx, a,
+           gen_helper_gvec_bfdot_idx)
 
 /*
  * Advanced SIMD scalar pairwise
@@ -10951,11 +10954,11 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
         break;
     case 0x1f:
         switch (size) {
-        case 1: /* BFDOT */
         case 3: /* BFMLAL{B,T} */
             feature = dc_isar_feature(aa64_bf16, s);
             break;
         default:
+        case 1: /* BFDOT */
             unallocated_encoding(s);
             return;
         }
@@ -11036,9 +11039,6 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
         return;
     case 0xf:
         switch (size) {
-        case 1: /* BFDOT */
-            gen_gvec_op4_ool(s, is_q, rd, rn, rm, rd, 0, gen_helper_gvec_bfdot);
-            break;
         case 3: /* BFMLAL{B,T} */
             gen_gvec_op4_fpst(s, 1, rd, rn, rm, rd, false, is_q,
                               gen_helper_gvec_bfmlal);
@@ -12053,13 +12053,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
         break;
     case 0x0f:
         switch (size) {
-        case 1: /* BFDOT */
-            if (is_scalar || !dc_isar_feature(aa64_bf16, s)) {
-                unallocated_encoding(s);
-                return;
-            }
-            size = MO_32;
-            break;
         case 3: /* BFMLAL{B,T} */
             if (is_scalar || !dc_isar_feature(aa64_bf16, s)) {
                 unallocated_encoding(s);
@@ -12070,6 +12063,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
             break;
         default:
         case 0: /* SUDOT */
+        case 1: /* BFDOT */
         case 2: /* USDOT */
             unallocated_encoding(s);
             return;
@@ -12179,10 +12173,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     switch (16 * u + opcode) {
     case 0x0f:
         switch (extract32(insn, 22, 2)) {
-        case 1: /* BFDOT */
-            gen_gvec_op4_ool(s, is_q, rd, rn, rm, rd, index,
-                             gen_helper_gvec_bfdot_idx);
-            return;
         case 3: /* BFMLAL{B,T} */
             gen_gvec_op4_fpst(s, 1, rd, rn, rm, rd, 0, (index << 1) | is_q,
                               gen_helper_gvec_bfmlal_idx);
-- 
2.34.1


