Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18854CDD578
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGwp-0006Ws-Gy; Thu, 19 Sep 2024 09:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwQ-00056n-TA
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:26 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwL-00012q-0B
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:24 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42cb58d810eso12322495e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 06:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726751479; x=1727356279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H9QwZiNqYLltMuDoQvmE1DmwxE5VRVv3eEWgjc3dK6I=;
 b=nsR13Wuqlz3rQkBRgJMXIpZmaq0k1nDZTNyZzpdXWRAC1WBi1doSYfllJdvu7AeZuQ
 J4MvSOKhd1C086v6XtP11JME/6r7EvIE5CNDQtCR2UaZnYAPo5Hsi01PNKVJ4smG+5LW
 nqJnhFEogYToN9wgwwdYyELvpYikW3Jug9mF1/f+HnY0XWMeU8BqXRCl62ueUxTG/RIi
 R6PvUc5i1FvJlbaojEQC2FvqEUyKu2fOp1lTyLVG464dydeXQnpNlvi9gHKvbSbPaJ/o
 t/WGYaFKHxkAB/1KjeP7no9Bo9Avp8T3GLQrUqS17TCAZ8O/bwtkdA4WR9ffSynkFMlP
 ywJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751479; x=1727356279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H9QwZiNqYLltMuDoQvmE1DmwxE5VRVv3eEWgjc3dK6I=;
 b=O1afxa0ywJ6sRyqJgDIRdGkbP6IYqNHNhOCG02ZUu9X6dVsnFS7lNcgZyvqJ0TOOtE
 u3A1Z/WZ0gMjcQfeBokW7hOjrZQntw0SD5+TA4E/728iV0VbhZusJF2xmO+Db1w37wHi
 zNVJbtRasW/26KRgB7gHC5laGFnnkts/e44GtWj9TxS2STIpXH9ob4DFQs11hGHkPOAI
 NneXE1xzSz9xDDpdNL9o2zqgXUdCxlil7acpd/xiHPDkfngLvoK3KwgY065DHukjerr0
 05nyEAGRS2BW4WqAPxoeWzaED1fXherg6ckQviHyLv0IuDPNK3O+kuK8/qPO7pOFvJuo
 eMCQ==
X-Gm-Message-State: AOJu0YybdEMbPFwoE4QokoL7Z0TPfi1gUhPaLM0LMwSbEy6lhyVyE2oX
 gqrD+N0dy/aS/ulJEwY4usuiGN/m5krCEULO2fdXDxN2n+M+wdVx5cjYBddXNlQYCyjyIW5NXg7
 h
X-Google-Smtp-Source: AGHT+IGwPrDmvpGpZDz2daz9nVySSVpDgOoZZ9/miIJCxjpWCLX4uWq374MDCNVNeY0jlSEssRdTbg==
X-Received: by 2002:a05:600c:4592:b0:42c:bd4d:e8d6 with SMTP id
 5b1f17b1804b1-42e743f8850mr19522425e9.3.1726751478906; 
 Thu, 19 Sep 2024 06:11:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754091d3sm21667845e9.10.2024.09.19.06.11.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 06:11:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/38] target/arm: Convert SSHLL, USHLL to decodetree
Date: Thu, 19 Sep 2024 14:10:47 +0100
Message-Id: <20240919131106.3362543-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919131106.3362543-1-peter.maydell@linaro.org>
References: <20240919131106.3362543-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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
Message-id: 20240912024114.1097832-20-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  8 ++++
 target/arm/tcg/translate-a64.c | 81 ++++++++++++++++------------------
 2 files changed, 45 insertions(+), 44 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 77b860a3f2c..bf67f8a357a 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1269,3 +1269,11 @@ SLI_v           0.10 11110 .... ... 01010 1 ..... .....     @q_shli_b
 SLI_v           0.10 11110 .... ... 01010 1 ..... .....     @q_shli_h
 SLI_v           0.10 11110 .... ... 01010 1 ..... .....     @q_shli_s
 SLI_v           0.10 11110 .... ... 01010 1 ..... .....     @q_shli_d
+
+SSHLL_v         0.00 11110 .... ... 10100 1 ..... .....     @q_shli_b
+SSHLL_v         0.00 11110 .... ... 10100 1 ..... .....     @q_shli_h
+SSHLL_v         0.00 11110 .... ... 10100 1 ..... .....     @q_shli_s
+
+USHLL_v         0.10 11110 .... ... 10100 1 ..... .....     @q_shli_b
+USHLL_v         0.10 11110 .... ... 10100 1 ..... .....     @q_shli_h
+USHLL_v         0.10 11110 .... ... 10100 1 ..... .....     @q_shli_s
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 740620074ad..e00d7fbf484 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6983,6 +6983,42 @@ TRANS(SRI_v, do_vec_shift_imm, a, gen_gvec_sri)
 TRANS(SHL_v, do_vec_shift_imm, a, tcg_gen_gvec_shli)
 TRANS(SLI_v, do_vec_shift_imm, a, gen_gvec_sli);
 
+static bool do_vec_shift_imm_wide(DisasContext *s, arg_qrri_e *a, bool is_u)
+{
+    TCGv_i64 tcg_rn, tcg_rd;
+    int esz = a->esz;
+    int esize;
+
+    if (!fp_access_check(s)) {
+        return true;
+    }
+
+    /*
+     * For the LL variants the store is larger than the load,
+     * so if rd == rn we would overwrite parts of our input.
+     * So load everything right now and use shifts in the main loop.
+     */
+    tcg_rd = tcg_temp_new_i64();
+    tcg_rn = tcg_temp_new_i64();
+    read_vec_element(s, tcg_rn, a->rn, a->q, MO_64);
+
+    esize = 8 << esz;
+    for (int i = 0, elements = 8 >> esz; i < elements; i++) {
+        if (is_u) {
+            tcg_gen_extract_i64(tcg_rd, tcg_rn, i * esize, esize);
+        } else {
+            tcg_gen_sextract_i64(tcg_rd, tcg_rn, i * esize, esize);
+        }
+        tcg_gen_shli_i64(tcg_rd, tcg_rd, a->imm);
+        write_vec_element(s, tcg_rd, a->rd, i, esz + 1);
+    }
+    clear_vec_high(s, true, a->rd);
+    return true;
+}
+
+TRANS(SSHLL_v, do_vec_shift_imm_wide, a, false)
+TRANS(USHLL_v, do_vec_shift_imm_wide, a, true)
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -10447,47 +10483,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
     }
 }
 
-/* USHLL/SHLL - Vector shift left with widening */
-static void handle_vec_simd_wshli(DisasContext *s, bool is_q, bool is_u,
-                                 int immh, int immb, int opcode, int rn, int rd)
-{
-    int size = 32 - clz32(immh) - 1;
-    int immhb = immh << 3 | immb;
-    int shift = immhb - (8 << size);
-    int dsize = 64;
-    int esize = 8 << size;
-    int elements = dsize/esize;
-    TCGv_i64 tcg_rn = tcg_temp_new_i64();
-    TCGv_i64 tcg_rd = tcg_temp_new_i64();
-    int i;
-
-    if (size >= 3) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    /* For the LL variants the store is larger than the load,
-     * so if rd == rn we would overwrite parts of our input.
-     * So load everything right now and use shifts in the main loop.
-     */
-    read_vec_element(s, tcg_rn, rn, is_q ? 1 : 0, MO_64);
-
-    for (i = 0; i < elements; i++) {
-        if (is_u) {
-            tcg_gen_extract_i64(tcg_rd, tcg_rn, i * esize, esize);
-        } else {
-            tcg_gen_sextract_i64(tcg_rd, tcg_rn, i * esize, esize);
-        }
-        tcg_gen_shli_i64(tcg_rd, tcg_rd, shift);
-        write_vec_element(s, tcg_rd, rd, i, size + 1);
-    }
-    clear_vec_high(s, true, rd);
-}
-
 /* SHRN/RSHRN - Shift right with narrowing (and potential rounding) */
 static void handle_vec_simd_shrn(DisasContext *s, bool is_q,
                                  int immh, int immb, int opcode, int rn, int rd)
@@ -10577,9 +10572,6 @@ static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
         handle_vec_simd_sqshrn(s, false, is_q, is_u, is_u, immh, immb,
                                opcode, rn, rd);
         break;
-    case 0x14: /* SSHLL / USHLL */
-        handle_vec_simd_wshli(s, is_q, is_u, immh, immb, opcode, rn, rd);
-        break;
     case 0x1c: /* SCVTF / UCVTF */
         handle_simd_shift_intfp_conv(s, false, is_q, is_u, immh, immb,
                                      opcode, rn, rd);
@@ -10604,6 +10596,7 @@ static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
     case 0x06: /* SRSRA / URSRA (accum + rounding) */
     case 0x08: /* SRI */
     case 0x0a: /* SHL / SLI */
+    case 0x14: /* SSHLL / USHLL */
         unallocated_encoding(s);
         return;
     }
-- 
2.34.1


