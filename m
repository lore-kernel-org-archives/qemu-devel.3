Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32E8C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD0zg-0004Ns-LF; Fri, 31 May 2024 08:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0ze-0004Lo-8m
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:22 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zZ-0003R3-Ld
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:21 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-35dc7d0387cso2100295f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717157056; x=1717761856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KSWIlxp4porqEPWPZVcIhNw+//PjX8zaBEMgqZxjFrU=;
 b=Z9QAMOlPLa//F4Vs0GxZ4epL8YZpGPSWFVHIyWPANF/COHrhAjcEv0votCk1Op9HtK
 NEXNEYdGo5lP8PbpAexmvklHp/VWlTNxQJJvoMSeF9kYlGINANZy38UjtbM9nDZauVK0
 FM8eGflA03AK8hmR+3Gv1i90/BiEn5A/qzogvmf6WYOIFdTObkxUqszW5HJQnY4NQ0QO
 EUKmPEYgQ3+zA7jB9Dh8fAWoaaT8XYdWbhpA89xO3wyNXUMF/gYo4QlW9EFuYFVcBThe
 kO+1IsiFmJpL11GUHo4++fd+ChX3wmtth3fqM44jqhqyyX9TGq9aFUgQZhRIi5ZSU/r8
 mAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717157056; x=1717761856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KSWIlxp4porqEPWPZVcIhNw+//PjX8zaBEMgqZxjFrU=;
 b=uV0aGscsmyE2HadWS94Q0TX4RIu1oZDIIxwZPsnKohpNPvusgTpMHGw7dwk9kbjiYs
 9TlI4DClIAyDjF4/aqs3q0s4+2uaDLbguV/CO0tVBcozzjHOqDb7xMGDdvyCJpW5R5Ct
 TCnDxf08kdD3Piuubd9vCtjVvYaXWfqpISlAozyH+0zuDqpaZg2+388G3csKpz3a6rQJ
 g99n++R/PGxWKk8GkIMSF2DYP06cwnZ0WBvovUkzxuVhnzk/bneWgGxl2ozZzRxPvv4n
 gpIQQN4iBS4LsGl6zQFY9kKw8qgSYIa4OcEVGbXGHg+abi0P2LMp1DtBzDRt1vpv71NO
 x3MA==
X-Gm-Message-State: AOJu0Yxovh4qcWR/SP05GcuRBOAxq3XdpIcGd3Qecr6GeVspTOdmRXM+
 3Y2s/MrM6WLIoL13Z/2S56+yLK/TzPcBMnQRFaaC+RdTQfQuMRDAtu8AZMetrm7SRRvOJccD3cR
 f
X-Google-Smtp-Source: AGHT+IFVZseXFchC9Ek15/mJvPlAJEVo36HUHIA105ZFlts25vbX9Z+NY+jqPIST7RVHZ6B9riCNbg==
X-Received: by 2002:adf:e265:0:b0:35d:c9e1:18c3 with SMTP id
 ffacd0b85a97d-35e0f268626mr1337609f8f.22.1717157055731; 
 Fri, 31 May 2024 05:04:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm37027685e9.13.2024.05.31.05.04.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:04:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/43] target/arm: Convert SRSHL, URSHL to decodetree
Date: Fri, 31 May 2024 13:03:34 +0100
Message-Id: <20240531120401.394550-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531120401.394550-1-peter.maydell@linaro.org>
References: <20240531120401.394550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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
Message-id: 20240528203044.612851-12-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  4 ++++
 target/arm/tcg/translate-a64.c | 22 +++++++---------------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index ea897d6732c..9e027760367 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -758,6 +758,8 @@ USQADD_s        0111 1110 ..1 00000 00111 0 ..... ..... @r2r_e
 
 SSHL_s          0101 1110 111 ..... 01000 1 ..... ..... @rrr_d
 USHL_s          0111 1110 111 ..... 01000 1 ..... ..... @rrr_d
+SRSHL_s         0101 1110 111 ..... 01010 1 ..... ..... @rrr_d
+URSHL_s         0111 1110 111 ..... 01010 1 ..... ..... @rrr_d
 
 ### Advanced SIMD scalar pairwise
 
@@ -882,6 +884,8 @@ USQADD_v        0.10 1110 ..1 00000 00111 0 ..... ..... @qr2r_e
 
 SSHL_v          0.00 1110 ..1 ..... 01000 1 ..... ..... @qrrr_e
 USHL_v          0.10 1110 ..1 ..... 01000 1 ..... ..... @qrrr_e
+SRSHL_v         0.00 1110 ..1 ..... 01010 1 ..... ..... @qrrr_e
+URSHL_v         0.10 1110 ..1 ..... 01010 1 ..... ..... @qrrr_e
 
 ### Advanced SIMD scalar x indexed element
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 7e981f8d011..c751da78ef0 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5116,6 +5116,8 @@ static bool do_int3_scalar_d(DisasContext *s, arg_rrr_e *a,
 
 TRANS(SSHL_s, do_int3_scalar_d, a, gen_sshl_i64)
 TRANS(USHL_s, do_int3_scalar_d, a, gen_ushl_i64)
+TRANS(SRSHL_s, do_int3_scalar_d, a, gen_helper_neon_rshl_s64)
+TRANS(URSHL_s, do_int3_scalar_d, a, gen_helper_neon_rshl_u64)
 
 static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a,
                           gen_helper_gvec_3_ptr * const fns[3])
@@ -5364,6 +5366,8 @@ TRANS(USQADD_v, do_gvec_fn3, a, gen_gvec_usqadd_qc)
 
 TRANS(SSHL_v, do_gvec_fn3, a, gen_gvec_sshl)
 TRANS(USHL_v, do_gvec_fn3, a, gen_gvec_ushl)
+TRANS(SRSHL_v, do_gvec_fn3, a, gen_gvec_srshl)
+TRANS(URSHL_v, do_gvec_fn3, a, gen_gvec_urshl)
 
 
 /*
@@ -9384,13 +9388,6 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
             gen_helper_neon_qshl_s64(tcg_rd, tcg_env, tcg_rn, tcg_rm);
         }
         break;
-    case 0xa: /* SRSHL, URSHL */
-        if (u) {
-            gen_helper_neon_rshl_u64(tcg_rd, tcg_rn, tcg_rm);
-        } else {
-            gen_helper_neon_rshl_s64(tcg_rd, tcg_rn, tcg_rm);
-        }
-        break;
     case 0xb: /* SQRSHL, UQRSHL */
         if (u) {
             gen_helper_neon_qrshl_u64(tcg_rd, tcg_env, tcg_rn, tcg_rm);
@@ -9409,6 +9406,7 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
     case 0x1: /* SQADD / UQADD */
     case 0x5: /* SQSUB / UQSUB */
     case 0x8: /* SSHL, USHL */
+    case 0xa: /* SRSHL, URSHL */
         g_assert_not_reached();
     }
 }
@@ -9433,7 +9431,6 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
     case 0x9: /* SQSHL, UQSHL */
     case 0xb: /* SQRSHL, UQRSHL */
         break;
-    case 0xa: /* SRSHL, URSHL */
     case 0x6: /* CMGT, CMHI */
     case 0x7: /* CMGE, CMHS */
     case 0x11: /* CMTST, CMEQ */
@@ -9453,6 +9450,7 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
     case 0x1: /* SQADD, UQADD */
     case 0x5: /* SQSUB, UQSUB */
     case 0x8: /* SSHL, USHL */
+    case 0xa: /* SRSHL, URSHL */
         unallocated_encoding(s);
         return;
     }
@@ -10929,6 +10927,7 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     case 0x01: /* SQADD, UQADD */
     case 0x05: /* SQSUB, UQSUB */
     case 0x08: /* SSHL, USHL */
+    case 0x0a: /* SRSHL, URSHL */
         unallocated_encoding(s);
         return;
     }
@@ -10938,13 +10937,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x0a: /* SRSHL, URSHL */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_urshl, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_srshl, size);
-        }
-        return;
     case 0x0c: /* SMAX, UMAX */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umax, size);
-- 
2.34.1


