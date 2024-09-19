Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338DCCDD57B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGwk-0006Ea-SQ; Thu, 19 Sep 2024 09:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwV-0005N9-8H
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:32 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwM-00013T-Um
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:28 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2f759688444so6776851fa.1
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 06:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726751481; x=1727356281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HA8GnKY7Cg0oYJJE2cemBK/bV9pLniArQxYNPHVXFRM=;
 b=HJH4yB8nCwcRl7cxt7hvwmCgBNGviAv+qVDTDl8UuDAEV3mVijSY/DifVFqTFFMkws
 eWnIJUM03D8liNAd3lygEV5sutXlV7jIdKDvPvoTZmKdYVyxv2pg+WYbMHh0zD8XAF/O
 cy8cVxfATFhwj7jEQ21HAlswUwQleQQv7IXtC1riv8+E7l8XVHTlrWupZbYjumSzHtD2
 TrzXn1fB9fhWTV2t79N9Wm1ojIkM9sDU3rIZ5knYg2ffRrLmDuiNlAiIsjZXmSSVF4M3
 I8AhWbTQhXtN5WIJRYr44Qt6B2kbgQyZf+2HmesFxJTud2gOtIyWFBygWPi4VrQmRvCC
 aVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751481; x=1727356281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HA8GnKY7Cg0oYJJE2cemBK/bV9pLniArQxYNPHVXFRM=;
 b=v0thx4ui2ZYd+ZLkvHbaovfyTBehP/K2ErGLJXPjfYbZHcSxs5IcF7K1McCFwqcUJy
 PZZxhxiZRNqoys7z1DoJ+VYcLWzMXymgkKv8IK9NKCCGhknLGG3nHuRP1+VMaOY/zpE7
 ShE0DX8kgUh+LkH8e4CQE/1QgsFFIyCwJLEwd8xLm7Sr0bDhkWkU/3QndSJkqv1wGEHl
 P+gfyenycWVj7AFR5qx4+Orf1EGguQ1fxCeiCmcEFDfTcjIZS8pc1bBaue5VGqYq1uD8
 u4kPKmjykwu2PHuJDobYMwBoHsZ7CUjlyAf6GgARlMVMtqmYQv05f3H4xCfCrleJUTy+
 mW8g==
X-Gm-Message-State: AOJu0Yzyq5Dajttm4e2rAQSIb1nfGbWIYj/fV2XtSNpTH9nzw8EIS8zC
 79hGSINS+b6MIFhdmsFHa8Br79hWrYWb0w5WzBm1ZABx7PlXGwow2d/2y9sjD73wadq6QzafW2z
 W
X-Google-Smtp-Source: AGHT+IElSc8FF3buCB0FYQkGXriP1Q3cNYyJeTxRRRLPwoCE/jpdj+xWa5W4Jl2WYqT5qsTqgd404A==
X-Received: by 2002:a05:651c:502:b0:2f1:a19b:d5a4 with SMTP id
 38308e7fff4ca-2f787ed88cbmr138211651fa.22.1726751480549; 
 Thu, 19 Sep 2024 06:11:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754091d3sm21667845e9.10.2024.09.19.06.11.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 06:11:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/38] target/arm: Convert SHRN, RSHRN to decodetree
Date: Thu, 19 Sep 2024 14:10:50 +0100
Message-Id: <20240919131106.3362543-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919131106.3362543-1-peter.maydell@linaro.org>
References: <20240919131106.3362543-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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
Message-id: 20240912024114.1097832-23-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  8 +++
 target/arm/tcg/translate-a64.c | 95 +++++++++++++++++-----------------
 2 files changed, 55 insertions(+), 48 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index bf67f8a357a..164ed575b9f 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1277,3 +1277,11 @@ SSHLL_v         0.00 11110 .... ... 10100 1 ..... .....     @q_shli_s
 USHLL_v         0.10 11110 .... ... 10100 1 ..... .....     @q_shli_b
 USHLL_v         0.10 11110 .... ... 10100 1 ..... .....     @q_shli_h
 USHLL_v         0.10 11110 .... ... 10100 1 ..... .....     @q_shli_s
+
+SHRN_v          0.00 11110 .... ... 10000 1 ..... .....     @q_shri_b
+SHRN_v          0.00 11110 .... ... 10000 1 ..... .....     @q_shri_h
+SHRN_v          0.00 11110 .... ... 10000 1 ..... .....     @q_shri_s
+
+RSHRN_v         0.00 11110 .... ... 10001 1 ..... .....     @q_shri_b
+RSHRN_v         0.00 11110 .... ... 10001 1 ..... .....     @q_shri_h
+RSHRN_v         0.00 11110 .... ... 10001 1 ..... .....     @q_shri_s
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index f4deacd5548..8871087af0a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7091,6 +7091,51 @@ static void gen_urshr_d(TCGv_i64 dst, TCGv_i64 src, int64_t shift)
     }
 }
 
+static bool do_vec_shift_imm_narrow(DisasContext *s, arg_qrri_e *a,
+                                    WideShiftImmFn * const fns[3], MemOp sign)
+{
+    TCGv_i64 tcg_rn, tcg_rd;
+    int esz = a->esz;
+    int esize;
+    WideShiftImmFn *fn;
+
+    tcg_debug_assert(esz >= MO_8 && esz <= MO_32);
+
+    if (!fp_access_check(s)) {
+        return true;
+    }
+
+    tcg_rn = tcg_temp_new_i64();
+    tcg_rd = tcg_temp_new_i64();
+    tcg_gen_movi_i64(tcg_rd, 0);
+
+    fn = fns[esz];
+    esize = 8 << esz;
+    for (int i = 0, elements = 8 >> esz; i < elements; i++) {
+        read_vec_element(s, tcg_rn, a->rn, i, (esz + 1) | sign);
+        fn(tcg_rn, tcg_rn, a->imm);
+        tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_rn, esize * i, esize);
+    }
+
+    write_vec_element(s, tcg_rd, a->rd, a->q, MO_64);
+    clear_vec_high(s, a->q, a->rd);
+    return true;
+}
+
+static WideShiftImmFn * const shrn_fns[] = {
+    tcg_gen_shri_i64,
+    tcg_gen_shri_i64,
+    gen_ushr_d,
+};
+TRANS(SHRN_v, do_vec_shift_imm_narrow, a, shrn_fns, 0)
+
+static WideShiftImmFn * const rshrn_fns[] = {
+    gen_urshr_bhs,
+    gen_urshr_bhs,
+    gen_urshr_d,
+};
+TRANS(RSHRN_v, do_vec_shift_imm_narrow, a, rshrn_fns, 0)
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -10496,52 +10541,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
     }
 }
 
-/* SHRN/RSHRN - Shift right with narrowing (and potential rounding) */
-static void handle_vec_simd_shrn(DisasContext *s, bool is_q,
-                                 int immh, int immb, int opcode, int rn, int rd)
-{
-    int immhb = immh << 3 | immb;
-    int size = 32 - clz32(immh) - 1;
-    int dsize = 64;
-    int esize = 8 << size;
-    int elements = dsize/esize;
-    int shift = (2 * esize) - immhb;
-    bool round = extract32(opcode, 0, 1);
-    TCGv_i64 tcg_rn, tcg_rd, tcg_final;
-    int i;
-
-    if (extract32(immh, 3, 1)) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    tcg_rn = tcg_temp_new_i64();
-    tcg_rd = tcg_temp_new_i64();
-    tcg_final = tcg_temp_new_i64();
-    read_vec_element(s, tcg_final, rd, is_q ? 1 : 0, MO_64);
-
-    for (i = 0; i < elements; i++) {
-        read_vec_element(s, tcg_rn, rn, i, size+1);
-        handle_shri_with_rndacc(tcg_rd, tcg_rn, round,
-                                false, true, size+1, shift);
-
-        tcg_gen_deposit_i64(tcg_final, tcg_final, tcg_rd, esize * i, esize);
-    }
-
-    if (!is_q) {
-        write_vec_element(s, tcg_final, rd, 0, MO_64);
-    } else {
-        write_vec_element(s, tcg_final, rd, 1, MO_64);
-    }
-
-    clear_vec_high(s, is_q, rd);
-}
-
-
 /* AdvSIMD shift by immediate
  *  31  30   29 28         23 22  19 18  16 15    11  10 9    5 4    0
  * +---+---+---+-------------+------+------+--------+---+------+------+
@@ -10564,13 +10563,13 @@ static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x10: /* SHRN */
+    case 0x10: /* SHRN / SQSHRUN */
     case 0x11: /* RSHRN / SQRSHRUN */
         if (is_u) {
             handle_vec_simd_sqshrn(s, false, is_q, false, true, immh, immb,
                                    opcode, rn, rd);
         } else {
-            handle_vec_simd_shrn(s, is_q, immh, immb, opcode, rn, rd);
+            unallocated_encoding(s);
         }
         break;
     case 0x12: /* SQSHRN / UQSHRN */
-- 
2.34.1


