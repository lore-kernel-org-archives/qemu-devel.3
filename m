Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB34EC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 19:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMBJj-0004z6-Kl; Tue, 25 Jun 2024 14:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMBAL-0002Ql-JN
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 14:45:37 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMB9b-00078s-Vn
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 14:45:01 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4405e343dd8so24501651cf.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 11:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719341024; x=1719945824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CMjhGlcExekQf+5VSLIRvctS+6B2uJGjUo3v3Mg5lsk=;
 b=ariL5+NdldnEt2ECqz0DXmP2RFuPl3JdlVk3spA8c/DABHrlDOKj5x1Xf8mYtGCg6m
 JnCEchI1uxXlWnMSfeb9raMYjk1tN8E6inUqXlZ/QPRkpBYHF/bJoKyW97/th3ZiyiPr
 YwlAExcVUoEWjT5OrN4Q1/zPU/VY2LfTnlrQeDKMbHssFyCezMNpseVmRS5Zqe8aSitq
 wWxHc8RbD4J1NJdcHGSHe1VRS06cAzP1ajOQy3ZvIlYlHCmKNKDGoJOMmRVkQ9kWyD7k
 zCGqwZ+6R6SVGROEc/y4nPO5mSEddNvhmdLDOCDiLBmnbxVlJZRNjNFCVsEH+hDE/iG7
 6NOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719341024; x=1719945824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CMjhGlcExekQf+5VSLIRvctS+6B2uJGjUo3v3Mg5lsk=;
 b=BeldFcJul9n64E6i62/w6SZ/V4E8ptu3LggjRQdftJlpIvX/dIRYOnyYbDbniuMSon
 r96VualNjDo06gQlwQhf15zewGnIocBb5VSmpJjqeXvSH8yiqvK+j7R42nu+EzJPIHDW
 OP8XwxlJ70umC1LpJjFl6ecFwXOx7VGq28kEGazBRww2VyuzRtNosvQexMaWv+vhFZ7+
 THlhT8ZsVApikZ8ZOzauyGPdZZJxRfEkIQdhsPbQob4fB1kphQWdZyREXho5Smmiya0w
 1olzWkCZ37+nxiRkf/p0Njpl/0SRIKWBonDD6dUB35qUTdfluERtiLbT3ODVT9sUVyT/
 IrzQ==
X-Gm-Message-State: AOJu0YxQPa+7ABaOPDx7801IcU+4qC00+eVmAe8ROMSfjudoA4UBLB6l
 benLPKRbeHVZn3BwKaQXUZK73t3Q1RN+kwx3cVkUM7nR/Cp66LVyCnLwE8yIbNiAvG4sHnZWfQc
 C
X-Google-Smtp-Source: AGHT+IFeMMKYcZXRzdeQDN8zTw8EhlztVceHIlwe0SjXLlW/mXBavKsYoeO1y0NcimQ3YD0u7ZROdw==
X-Received: by 2002:a17:902:e846:b0:1f6:87c:6f with SMTP id
 d9443c01a7336-1fa23f36020mr81750205ad.62.1719340548123; 
 Tue, 25 Jun 2024 11:35:48 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb3c6027sm84693235ad.133.2024.06.25.11.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 11:35:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 11/13] target/arm: Convert FCADD to decodetree
Date: Tue, 25 Jun 2024 11:35:34 -0700
Message-Id: <20240625183536.1672454-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625183536.1672454-1-richard.henderson@linaro.org>
References: <20240625183536.1672454-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x834.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
 target/arm/tcg/a64.decode      |  3 +++
 target/arm/tcg/translate-a64.c | 33 ++++++++++-----------------------
 2 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index b2c7e36969..f330919851 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -957,6 +957,9 @@ SMMLA           0100 1110 100 ..... 10100 1 ..... ..... @rrr_q1e0
 UMMLA           0110 1110 100 ..... 10100 1 ..... ..... @rrr_q1e0
 USMMLA          0100 1110 100 ..... 10101 1 ..... ..... @rrr_q1e0
 
+FCADD_90        0.10 1110 ..0 ..... 11100 1 ..... ..... @qrrr_e
+FCADD_270       0.10 1110 ..0 ..... 11110 1 ..... ..... @qrrr_e
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 57cdde008e..a1b338263f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5623,6 +5623,14 @@ static bool trans_BFMLAL_v(DisasContext *s, arg_qrrr_e *a)
     return true;
 }
 
+static gen_helper_gvec_3_ptr * const f_vector_fcadd[3] = {
+    gen_helper_gvec_fcaddh,
+    gen_helper_gvec_fcadds,
+    gen_helper_gvec_fcaddd,
+};
+TRANS_FEAT(FCADD_90, aa64_fcma, do_fp3_vector, a, 0, f_vector_fcadd)
+TRANS_FEAT(FCADD_270, aa64_fcma, do_fp3_vector, a, 1, f_vector_fcadd)
+
 /*
  * Advanced SIMD scalar/vector x indexed element
  */
@@ -10957,8 +10965,6 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
     case 0x19: /* FCMLA, #90 */
     case 0x1a: /* FCMLA, #180 */
     case 0x1b: /* FCMLA, #270 */
-    case 0x1c: /* FCADD, #90 */
-    case 0x1e: /* FCADD, #270 */
         if (size == 0
             || (size == 1 && !dc_isar_feature(aa64_fp16, s))
             || (size == 3 && !is_q)) {
@@ -10976,7 +10982,9 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
     case 0x11: /* SQRDMLSH (vector) */
     case 0x12: /* UDOT (vector) */
     case 0x14: /* UMMLA */
+    case 0x1c: /* FCADD, #90 */
     case 0x1d: /* BFMMLA */
+    case 0x1e: /* FCADD, #270 */
     case 0x1f: /* BFDOT / BFMLAL */
         unallocated_encoding(s);
         return;
@@ -11013,27 +11021,6 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
         }
         return;
 
-    case 0xc: /* FCADD, #90 */
-    case 0xe: /* FCADD, #270 */
-        rot = extract32(opcode, 1, 1);
-        switch (size) {
-        case 1:
-            gen_gvec_op3_fpst(s, is_q, rd, rn, rm, size == 1, rot,
-                              gen_helper_gvec_fcaddh);
-            break;
-        case 2:
-            gen_gvec_op3_fpst(s, is_q, rd, rn, rm, size == 1, rot,
-                              gen_helper_gvec_fcadds);
-            break;
-        case 3:
-            gen_gvec_op3_fpst(s, is_q, rd, rn, rm, size == 1, rot,
-                              gen_helper_gvec_fcaddd);
-            break;
-        default:
-            g_assert_not_reached();
-        }
-        return;
-
     default:
         g_assert_not_reached();
     }
-- 
2.34.1


