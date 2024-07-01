Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3323C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJa3-0002tX-43; Mon, 01 Jul 2024 12:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ9-0000jF-8t
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:43 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ7-0005SS-F9
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:43 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42563a9fa58so23271845e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719850059; x=1720454859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=umdxzDnNtxvX2vzuW8yZcnHx92cHpebXW3DiyrvU1yg=;
 b=C+cfErdmnIzMV6ooNwOFhD4BwkkwOCTsmaEed5nzlKMoGDMvKaHc4cE9dDFLB80jPj
 8ZWvYts1kuhy8+BMGptp2/P4TM7Nm23zLVXi09HPbz5mULpeot52sYCdH0cUvKLSwZw3
 wHlo7/90jGqKtRxCkUSQPy5PqNHP3uUWEDfz0yYL+AvOp5hia/BeEx10xO88hl0ETQBr
 oUGuXzodazyhSPRoVeQBqI0fg5uO/YoCJA0qUyRJTF8tdrtgolRGlFgVpZYTeOUP0zcz
 jC4QHIYw2Rbug4uoTf6blliROeJ3pF1vTF4Iv0MvCDg2Zv1tyqaquffF+d+UslaHYQgA
 cpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719850059; x=1720454859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=umdxzDnNtxvX2vzuW8yZcnHx92cHpebXW3DiyrvU1yg=;
 b=tWTMj6roZ6RtsxQqN7Nwir7BfYHY1+pV5vaLZD49FTLKGjLZlsJTDkgbOGztuY10H4
 81kgUy4G1ZGFmDRPCnhsM/OpIUh0mRrjMqNDkSA1BtgJietP5dlXXxxLBjrxbkq9MAi1
 kHlGmrrO2vlC0FNsAuELlzN5a0HYAb9DwpjjXU3OyFp9CYE/sCtiRnOhz813ketnacW/
 zDMpT+jZ5bBVWEOW7JVyiGszz/yCJtiJbKwzNVlqSuwcPPy2ieIULtqt1XHq0s9qZlZt
 hOjI7TEE5Ey82lom1NQ6kq5xjvhcVgTxFD4eu071BikPsl3Q/YakyQEq1boyDbUV17Po
 RTYg==
X-Gm-Message-State: AOJu0Yyz+DInx/Ix1ITniIiqUYyzLC39db+L8dpl4pCz3EeHMPFc8u5g
 koOOhq57w2KEUYwwGpMNroBBP80LmJ0eVLhUl/yHkCTo49vqcSPUVct+KH/JX4Dst+Yzw1BrQdz
 DRis=
X-Google-Smtp-Source: AGHT+IHV413vlYQW00WafvXq9mqtPHHCCMD7HeGdB9dujRQ0qiqWHw8yN7qrkxddytJakpxFOPkYJQ==
X-Received: by 2002:a05:600c:2157:b0:425:5eff:7182 with SMTP id
 5b1f17b1804b1-4257a02ce71mr42028755e9.31.1719850059075; 
 Mon, 01 Jul 2024 09:07:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af557fesm161952135e9.11.2024.07.01.09.07.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 09:07:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/29] target/arm: Convert FCADD to decodetree
Date: Mon,  1 Jul 2024 17:07:17 +0100
Message-Id: <20240701160729.1910763-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701160729.1910763-1-peter.maydell@linaro.org>
References: <20240701160729.1910763-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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
Message-id: 20240625183536.1672454-12-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  3 +++
 target/arm/tcg/translate-a64.c | 33 ++++++++++-----------------------
 2 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index b2c7e36969e..f330919851b 100644
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
index 57cdde008ef..a1b338263ff 100644
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


