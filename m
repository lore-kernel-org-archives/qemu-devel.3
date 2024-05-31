Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C33C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD0zu-0004UA-EJ; Fri, 31 May 2024 08:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zg-0004Mt-5J
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:24 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zc-0003Rp-5w
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:23 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2ea903cd11bso13042831fa.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717157058; x=1717761858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tBJ+rm1kj5CZUL2Rn5mABZapFHrHm2L5A12g8wLTpXg=;
 b=IXpAC0EpJJ4xUSpI/jD5QQTJRxEyoS9CCwSxM4UaM7NlxCQeBP0CoMiKnFm+hI/6/K
 URXahtNrsObf8Cp3xzskR0z/AcGKx1VY23R2a2jglWHM43WD6ZHEiFLxBlOSBwLbxjyE
 n55b9Bet7vww91i3XZmJP2UFEkyHU01r6gT5e2CZUalZJ4qwMDdwQoPClOBj1QdceFMc
 yuNQJOnSBCRZBs1VFGLoVT4ZTFxXzplHahLgtMZkDxrzIJlZSFVwPyvj4Yj0mve3mUOV
 kaRLv2llfACJLv7BFsPVTaMohHaFJdOpeI2C8ivPQEvuAaVd18/GCpFmHMs28JieUX3F
 6jsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717157058; x=1717761858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tBJ+rm1kj5CZUL2Rn5mABZapFHrHm2L5A12g8wLTpXg=;
 b=iJHDSg+Nz1SnHIhiHzO/pUf+lEjBU/m2Q3AVrLb9fCgckflGy3SW1YbGggV/VYZ7sR
 R1e0+dcel3fRox2nec5RnpMZa1ZmlXVCa4u85nOXFozXSqN6VEi+mM/yxma7xIC273sP
 RVeXb7CCFwXLhafxkWlfkOj0ao4zBA9X4v4uPIPf+rQN5zOY4uV12G+oaAUUpmynoNDO
 2MWqYja5M054VEkP2Qqz4Yrcvs6e217mnS3iLN5R3oqk7D3KNZHkOsLLxqqkfuVIUKsY
 w6V6mep6NNTukhDcdh9KntRk6gne6YMbJUkiQ10geH7mj0DhdSEMFtLK4V6Vo3rwppLI
 vIKA==
X-Gm-Message-State: AOJu0YyPcSlIq+yWyZ4QUceFevYNVFmjjdoDuqHIGXD+NIbTGNO0pLm+
 8RwIIadU5d7BZiVcgDIieabrD3FnfT0naOsH5Pld2Uzdnb6CkXiyE8MJLG8qAuVh6GitcN8dIdG
 T
X-Google-Smtp-Source: AGHT+IF7JtKPBDx8uOrHq7RfrNuunsoFKZtyrI5NtSvbeeiLM2hgz5sWCEnFZp+g3QEESUTxmdyWcQ==
X-Received: by 2002:a2e:7e0d:0:b0:2e9:855b:acb5 with SMTP id
 38308e7fff4ca-2ea9513c9c8mr12783171fa.20.1717157058031; 
 Fri, 31 May 2024 05:04:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm37027685e9.13.2024.05.31.05.04.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:04:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/43] target/arm: Convert SQRSHL, UQRSHL to decodetree
Date: Fri, 31 May 2024 13:03:38 +0100
Message-Id: <20240531120401.394550-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531120401.394550-1-peter.maydell@linaro.org>
References: <20240531120401.394550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22e.google.com
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
Message-id: 20240528203044.612851-16-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  4 +++
 target/arm/tcg/translate-a64.c | 48 ++++++++++++++++------------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 85caf379486..96ce35ad40e 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -762,6 +762,8 @@ SRSHL_s         0101 1110 111 ..... 01010 1 ..... ..... @rrr_d
 URSHL_s         0111 1110 111 ..... 01010 1 ..... ..... @rrr_d
 SQSHL_s         0101 1110 ..1 ..... 01001 1 ..... ..... @rrr_e
 UQSHL_s         0111 1110 ..1 ..... 01001 1 ..... ..... @rrr_e
+SQRSHL_s        0101 1110 ..1 ..... 01011 1 ..... ..... @rrr_e
+UQRSHL_s        0111 1110 ..1 ..... 01011 1 ..... ..... @rrr_e
 
 ### Advanced SIMD scalar pairwise
 
@@ -890,6 +892,8 @@ SRSHL_v         0.00 1110 ..1 ..... 01010 1 ..... ..... @qrrr_e
 URSHL_v         0.10 1110 ..1 ..... 01010 1 ..... ..... @qrrr_e
 SQSHL_v         0.00 1110 ..1 ..... 01001 1 ..... ..... @qrrr_e
 UQSHL_v         0.10 1110 ..1 ..... 01001 1 ..... ..... @qrrr_e
+SQRSHL_v        0.00 1110 ..1 ..... 01011 1 ..... ..... @qrrr_e
+UQRSHL_v        0.10 1110 ..1 ..... 01011 1 ..... ..... @qrrr_e
 
 ### Advanced SIMD scalar x indexed element
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index b9d577f6206..2424c6d314a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5162,6 +5162,22 @@ static const ENVScalar2 f_scalar_uqshl = {
 };
 TRANS(UQSHL_s, do_env_scalar2, a, &f_scalar_uqshl)
 
+static const ENVScalar2 f_scalar_sqrshl = {
+    { gen_helper_neon_qrshl_s8,
+      gen_helper_neon_qrshl_s16,
+      gen_helper_neon_qrshl_s32 },
+    gen_helper_neon_qrshl_s64,
+};
+TRANS(SQRSHL_s, do_env_scalar2, a, &f_scalar_sqrshl)
+
+static const ENVScalar2 f_scalar_uqrshl = {
+    { gen_helper_neon_qrshl_u8,
+      gen_helper_neon_qrshl_u16,
+      gen_helper_neon_qrshl_u32 },
+    gen_helper_neon_qrshl_u64,
+};
+TRANS(UQRSHL_s, do_env_scalar2, a, &f_scalar_uqrshl)
+
 static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a,
                           gen_helper_gvec_3_ptr * const fns[3])
 {
@@ -5413,6 +5429,8 @@ TRANS(SRSHL_v, do_gvec_fn3, a, gen_gvec_srshl)
 TRANS(URSHL_v, do_gvec_fn3, a, gen_gvec_urshl)
 TRANS(SQSHL_v, do_gvec_fn3, a, gen_neon_sqshl)
 TRANS(UQSHL_v, do_gvec_fn3, a, gen_neon_uqshl)
+TRANS(SQRSHL_v, do_gvec_fn3, a, gen_neon_sqrshl)
+TRANS(UQRSHL_v, do_gvec_fn3, a, gen_neon_uqrshl)
 
 
 /*
@@ -9426,13 +9444,6 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
         }
         gen_cmtst_i64(tcg_rd, tcg_rn, tcg_rm);
         break;
-    case 0xb: /* SQRSHL, UQRSHL */
-        if (u) {
-            gen_helper_neon_qrshl_u64(tcg_rd, tcg_env, tcg_rn, tcg_rm);
-        } else {
-            gen_helper_neon_qrshl_s64(tcg_rd, tcg_env, tcg_rn, tcg_rm);
-        }
-        break;
     case 0x10: /* ADD, SUB */
         if (u) {
             tcg_gen_sub_i64(tcg_rd, tcg_rn, tcg_rm);
@@ -9446,6 +9457,7 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
     case 0x8: /* SSHL, USHL */
     case 0x9: /* SQSHL, UQSHL */
     case 0xa: /* SRSHL, URSHL */
+    case 0xb: /* SQRSHL, UQRSHL */
         g_assert_not_reached();
     }
 }
@@ -9467,8 +9479,6 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
     TCGv_i64 tcg_rd;
 
     switch (opcode) {
-    case 0xb: /* SQRSHL, UQRSHL */
-        break;
     case 0x6: /* CMGT, CMHI */
     case 0x7: /* CMGE, CMHS */
     case 0x11: /* CMTST, CMEQ */
@@ -9490,6 +9500,7 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
     case 0x8: /* SSHL, USHL */
     case 0x9: /* SQSHL, UQSHL */
     case 0xa: /* SRSHL, URSHL */
+    case 0xb: /* SQRSHL, UQRSHL */
         unallocated_encoding(s);
         return;
     }
@@ -9516,16 +9527,6 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
         void (*genfn)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64, MemOp) = NULL;
 
         switch (opcode) {
-        case 0xb: /* SQRSHL, UQRSHL */
-        {
-            static NeonGenTwoOpEnvFn * const fns[3][2] = {
-                { gen_helper_neon_qrshl_s8, gen_helper_neon_qrshl_u8 },
-                { gen_helper_neon_qrshl_s16, gen_helper_neon_qrshl_u16 },
-                { gen_helper_neon_qrshl_s32, gen_helper_neon_qrshl_u32 },
-            };
-            genenvfn = fns[size][u];
-            break;
-        }
         case 0x16: /* SQDMULH, SQRDMULH */
         {
             static NeonGenTwoOpEnvFn * const fns[2][2] = {
@@ -9540,6 +9541,7 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
         case 0x1: /* SQADD, UQADD */
         case 0x5: /* SQSUB, UQSUB */
         case 0x9: /* SQSHL, UQSHL */
+        case 0xb: /* SQRSHL, UQRSHL */
             g_assert_not_reached();
         }
 
@@ -10959,6 +10961,7 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     case 0x08: /* SSHL, USHL */
     case 0x09: /* SQSHL, UQSHL */
     case 0x0a: /* SRSHL, URSHL */
+    case 0x0b: /* SQRSHL, UQRSHL */
         unallocated_encoding(s);
         return;
     }
@@ -10968,13 +10971,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x0b: /* SQRSHL, UQRSHL */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_neon_uqrshl, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_neon_sqrshl, size);
-        }
-        return;
     case 0x0c: /* SMAX, UMAX */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umax, size);
-- 
2.34.1


