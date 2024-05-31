Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC77C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD106-0004Y6-Q4; Fri, 31 May 2024 08:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zi-0004Od-4i
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:28 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zc-0003S1-HU
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:25 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2e95a7545bdso19169331fa.2
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717157059; x=1717761859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hUei9nT4ia2Mkwm2wqjM7KPepv2BdpSDgodhMc/nKDE=;
 b=fR+DoFFkslur8RzhUn2w4n3SSk0hRwUiTfbD9csmJUUvMrJrkpG9JcjvryFBNOIQCe
 azcDbEjKzF9mJeIeWdzleFGBGKtPe67KBc9coNvzHA7EN8qmzM+uPUOsUvBikE6MmkW/
 ivatCGi4WpPWkyVV3CmTWYtlpGTH/Yxx5sKLrVAr1lZrxJ4xGZvizqAkhnr18WXwTbPH
 wMLjiE6L7Z3okr2GePyxwx/NfLg3bCCHY4GB1rp98g49ABjXy19po427DJtFRv+tZ4QB
 CRC8Oss8Lce+EKwPZcITbSuU6cKBBuC8jO2STnNFcMzY//ZLKxajltsbTA6eyExbuSSk
 jP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717157059; x=1717761859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hUei9nT4ia2Mkwm2wqjM7KPepv2BdpSDgodhMc/nKDE=;
 b=ayjr65xduVcF+yAy4vH2ZHg6+SwKzssosds2ftLCWc6sNouOheW8vHXZpRJ/8PBcn+
 P4WS9NSOeYmFvQRp1PdvLEu3kouGbD0nl5INX2oguOiuIp9GlFvvamgAipoNJdWy9daO
 3yXJYu8UEnidp9MllfX4UPHhdq7099MbOEBlZxnB3W2TLCKvCguWJ122oq9ufukD9EJx
 l9WpMUM3/fT6jEGZ40mYtORs3YRTOA4LHrNJL2NUv/HZI+K0CMnllk/kVrMct8jv6rxh
 qrH50PwFZ12cSmFnuT6nFy6RFHVVbp7AOzK9pAHAE0ug43NeZp3+lkf8+U89mONYJSvx
 4rAA==
X-Gm-Message-State: AOJu0YxaBS8HtLs9vwUy0BpfdWQDcaEtsrzIO3OBtRKGAme1p2JOgn5a
 TuDrSLNdWKi+dKpoboW1Q1Km9Sj7DX2F+2sEzmygF02/3ETX7BYWc4dAFE7+5JymaatsyoAXrek
 h
X-Google-Smtp-Source: AGHT+IEoDussIG9PQ6w1U57r/5N95vsSG3gW4QW35tT7GdES5UDUMny4pKFI3s7oD8p358ezxf62HQ==
X-Received: by 2002:a2e:7a04:0:b0:2ea:91cf:a5f0 with SMTP id
 38308e7fff4ca-2ea9512cf12mr11033761fa.19.1717157058729; 
 Fri, 31 May 2024 05:04:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm37027685e9.13.2024.05.31.05.04.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:04:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/43] target/arm: Convert ADD, SUB (vector) to decodetree
Date: Fri, 31 May 2024 13:03:39 +0100
Message-Id: <20240531120401.394550-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531120401.394550-1-peter.maydell@linaro.org>
References: <20240531120401.394550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22f.google.com
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
Message-id: 20240528203044.612851-17-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  6 ++++++
 target/arm/tcg/translate-a64.c | 22 +++++++---------------
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 96ce35ad40e..44383b4fc7c 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -765,6 +765,9 @@ UQSHL_s         0111 1110 ..1 ..... 01001 1 ..... ..... @rrr_e
 SQRSHL_s        0101 1110 ..1 ..... 01011 1 ..... ..... @rrr_e
 UQRSHL_s        0111 1110 ..1 ..... 01011 1 ..... ..... @rrr_e
 
+ADD_s           0101 1110 111 ..... 10000 1 ..... ..... @rrr_d
+SUB_s           0111 1110 111 ..... 10000 1 ..... ..... @rrr_d
+
 ### Advanced SIMD scalar pairwise
 
 FADDP_s         0101 1110 0011 0000 1101 10 ..... ..... @rr_h
@@ -895,6 +898,9 @@ UQSHL_v         0.10 1110 ..1 ..... 01001 1 ..... ..... @qrrr_e
 SQRSHL_v        0.00 1110 ..1 ..... 01011 1 ..... ..... @qrrr_e
 UQRSHL_v        0.10 1110 ..1 ..... 01011 1 ..... ..... @qrrr_e
 
+ADD_v           0.00 1110 ..1 ..... 10000 1 ..... ..... @qrrr_e
+SUB_v           0.10 1110 ..1 ..... 10000 1 ..... ..... @qrrr_e
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 2424c6d314a..77a64923e7f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5118,6 +5118,8 @@ TRANS(SSHL_s, do_int3_scalar_d, a, gen_sshl_i64)
 TRANS(USHL_s, do_int3_scalar_d, a, gen_ushl_i64)
 TRANS(SRSHL_s, do_int3_scalar_d, a, gen_helper_neon_rshl_s64)
 TRANS(URSHL_s, do_int3_scalar_d, a, gen_helper_neon_rshl_u64)
+TRANS(ADD_s, do_int3_scalar_d, a, tcg_gen_add_i64)
+TRANS(SUB_s, do_int3_scalar_d, a, tcg_gen_sub_i64)
 
 typedef struct ENVScalar2 {
     NeonGenTwoOpEnvFn *gen_bhs[3];
@@ -5432,6 +5434,8 @@ TRANS(UQSHL_v, do_gvec_fn3, a, gen_neon_uqshl)
 TRANS(SQRSHL_v, do_gvec_fn3, a, gen_neon_sqrshl)
 TRANS(UQRSHL_v, do_gvec_fn3, a, gen_neon_uqrshl)
 
+TRANS(ADD_v, do_gvec_fn3, a, tcg_gen_gvec_add)
+TRANS(SUB_v, do_gvec_fn3, a, tcg_gen_gvec_sub)
 
 /*
  * Advanced SIMD scalar/vector x indexed element
@@ -9444,13 +9448,6 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
         }
         gen_cmtst_i64(tcg_rd, tcg_rn, tcg_rm);
         break;
-    case 0x10: /* ADD, SUB */
-        if (u) {
-            tcg_gen_sub_i64(tcg_rd, tcg_rn, tcg_rm);
-        } else {
-            tcg_gen_add_i64(tcg_rd, tcg_rn, tcg_rm);
-        }
-        break;
     default:
     case 0x1: /* SQADD / UQADD */
     case 0x5: /* SQSUB / UQSUB */
@@ -9458,6 +9455,7 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
     case 0x9: /* SQSHL, UQSHL */
     case 0xa: /* SRSHL, URSHL */
     case 0xb: /* SQRSHL, UQRSHL */
+    case 0x10: /* ADD, SUB */
         g_assert_not_reached();
     }
 }
@@ -9482,7 +9480,6 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
     case 0x6: /* CMGT, CMHI */
     case 0x7: /* CMGE, CMHS */
     case 0x11: /* CMTST, CMEQ */
-    case 0x10: /* ADD, SUB (vector) */
         if (size != 3) {
             unallocated_encoding(s);
             return;
@@ -9501,6 +9498,7 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
     case 0x9: /* SQSHL, UQSHL */
     case 0xa: /* SRSHL, URSHL */
     case 0xb: /* SQRSHL, UQRSHL */
+    case 0x10: /* ADD, SUB (vector) */
         unallocated_encoding(s);
         return;
     }
@@ -10962,6 +10960,7 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     case 0x09: /* SQSHL, UQSHL */
     case 0x0a: /* SRSHL, URSHL */
     case 0x0b: /* SQRSHL, UQRSHL */
+    case 0x10: /* ADD, SUB */
         unallocated_encoding(s);
         return;
     }
@@ -10999,13 +10998,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
             gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_saba, size);
         }
         return;
-    case 0x10: /* ADD, SUB */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_sub, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_add, size);
-        }
-        return;
     case 0x13: /* MUL, PMUL */
         if (!u) { /* MUL */
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_mul, size);
-- 
2.34.1


