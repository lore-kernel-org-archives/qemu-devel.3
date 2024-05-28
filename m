Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B23C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 14:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBxUt-0001e0-PZ; Tue, 28 May 2024 10:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUr-0001cP-Q1
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:13 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUn-00074V-Ix
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:13 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-35502a992c9so908610f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 07:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905288; x=1717510088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T9M0UZJDFFcR7IKXfZzYHCl9cYvAnk5miuB+Cg9H1ls=;
 b=HqRSsyZnTe6Yw1QJCKM99VarIps6lv4MhmrqBWph8Lpsl8RStAFQlqZfswCZEBpKOt
 K71+fqZgySX7tE6icClW7gyuiiIvPEhqU1QyL9nqEcyHxwsCRa2ZbRHrLyEpK1A2YTo6
 X67spcNJx/+BwBhKqDjanJHANYTOaeSbyiM4Y1SYhH0wB/luakzhHVQnmkIOo/QKAKcW
 FLHhGA5Pp06ZCANKy8o7XGFy9F7i/r7Pqo7MR86NtOBDbpkuhhwh7qVJhpLbSu0atuxU
 1e27tQGlxbNQ3Ac+e6/0t0kqVZGXcf+ZNSdxlJxNxy6d1W1IxV49d/zdlRoPB2CYMBIC
 EGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905288; x=1717510088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T9M0UZJDFFcR7IKXfZzYHCl9cYvAnk5miuB+Cg9H1ls=;
 b=qSxLUM+09N4BV8I/3kNzpGzAjm0RojpQtQuJrIBl3Q8XZ34lGS2eArJBACWAInNK7R
 F3tYprwj+TO/VT3QeA9TfyDJ9AAEMqidUnHDAD84081c+YiQxfB8O3ZFJA4F40+o1PXV
 53jfb0hYz/Sx3XP++jq2y1gP4XrVspm9Iazh5RSrzJu4eVPLT/CJc+Jo8os8rG/YS27t
 8Mr4Jr9sJG65ca88gYEh71wlmLZ8Sbo8LMP16it1ZKh/LCGEqOpXgJDD6xm2JwVO9uD8
 S5HRs8eKgd9unvVohzGpArnUuVMlAT8QOAn2dfF58I8q4At1+6dh1+oWSWuUaHthIzzm
 rzQw==
X-Gm-Message-State: AOJu0YxIKnz3gEYEun0rfBDeEAgFYrjhCueanIQLGzNGDcAigcThpRAb
 22E71Kx96iUQXdoDjpOA0+J+BovmCFUzwFlFiKUAGp7Useo5hgtcNxIdw947MqMcskNLiZXXw7Z
 1
X-Google-Smtp-Source: AGHT+IEgx6EPpp6gzEu/WS+9dpqWCslDop32pX/HmTYQqnouzrHfVH7pgb0C8y0XXmrIpXDHXy+iOQ==
X-Received: by 2002:a5d:408d:0:b0:355:4cb:5048 with SMTP id
 ffacd0b85a97d-3552fe02949mr10638527f8f.43.1716905288217; 
 Tue, 28 May 2024 07:08:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3564afc3577sm11361473f8f.102.2024.05.28.07.08.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:08:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/42] target/arm: Convert Cryptographic 3-register,
 imm2 to decodetree
Date: Tue, 28 May 2024 15:07:32 +0100
Message-Id: <20240528140753.3620597-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528140753.3620597-1-peter.maydell@linaro.org>
References: <20240528140753.3620597-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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
Message-id: 20240524232121.284515-16-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      | 10 ++++++++
 target/arm/tcg/translate-a64.c | 43 ++++++++++------------------------
 2 files changed, 22 insertions(+), 31 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index ef6902e86a5..1292312a7f9 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -644,3 +644,13 @@ SM4E            1100 1110 110 00000 100001 ..... .....  @r2r_q1e0
 EOR3            1100 1110 000 ..... 0 ..... ..... ..... @rrrr_q1e3
 BCAX            1100 1110 001 ..... 0 ..... ..... ..... @rrrr_q1e3
 SM3SS1          1100 1110 010 ..... 0 ..... ..... ..... @rrrr_q1e3
+
+### Cryptographic three-register, imm2
+
+&crypto3i       rd rn rm imm
+@crypto3i       ........ ... rm:5 .. imm:2 .. rn:5 rd:5 &crypto3i
+
+SM3TT1A         11001110 010 ..... 10 .. 00 ..... ..... @crypto3i
+SM3TT1B         11001110 010 ..... 10 .. 01 ..... ..... @crypto3i
+SM3TT2A         11001110 010 ..... 10 .. 10 ..... ..... @crypto3i
+SM3TT2B         11001110 010 ..... 10 .. 11 ..... ..... @crypto3i
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 2951e7eb59e..cf3a7dfa99f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4676,6 +4676,18 @@ static bool trans_SM3SS1(DisasContext *s, arg_SM3SS1 *a)
     return true;
 }
 
+static bool do_crypto3i(DisasContext *s, arg_crypto3i *a, gen_helper_gvec_3 *fn)
+{
+    if (fp_access_check(s)) {
+        gen_gvec_op3_ool(s, true, a->rd, a->rn, a->rm, a->imm, fn);
+    }
+    return true;
+}
+TRANS_FEAT(SM3TT1A, aa64_sm3, do_crypto3i, a, gen_helper_crypto_sm3tt1a)
+TRANS_FEAT(SM3TT1B, aa64_sm3, do_crypto3i, a, gen_helper_crypto_sm3tt1b)
+TRANS_FEAT(SM3TT2A, aa64_sm3, do_crypto3i, a, gen_helper_crypto_sm3tt2a)
+TRANS_FEAT(SM3TT2B, aa64_sm3, do_crypto3i, a, gen_helper_crypto_sm3tt2b)
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -13604,36 +13616,6 @@ static void disas_crypto_xar(DisasContext *s, uint32_t insn)
                  vec_full_reg_size(s));
 }
 
-/* Crypto three-reg imm2
- *  31                   21 20  16 15  14 13 12  11  10  9    5 4    0
- * +-----------------------+------+-----+------+--------+------+------+
- * | 1 1 0 0 1 1 1 0 0 1 0 |  Rm  | 1 0 | imm2 | opcode |  Rn  |  Rd  |
- * +-----------------------+------+-----+------+--------+------+------+
- */
-static void disas_crypto_three_reg_imm2(DisasContext *s, uint32_t insn)
-{
-    static gen_helper_gvec_3 * const fns[4] = {
-        gen_helper_crypto_sm3tt1a, gen_helper_crypto_sm3tt1b,
-        gen_helper_crypto_sm3tt2a, gen_helper_crypto_sm3tt2b,
-    };
-    int opcode = extract32(insn, 10, 2);
-    int imm2 = extract32(insn, 12, 2);
-    int rm = extract32(insn, 16, 5);
-    int rn = extract32(insn, 5, 5);
-    int rd = extract32(insn, 0, 5);
-
-    if (!dc_isar_feature(aa64_sm3, s)) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    gen_gvec_op3_ool(s, true, rd, rn, rm, imm2, fns[opcode]);
-}
-
 /* C3.6 Data processing - SIMD, inc Crypto
  *
  * As the decode gets a little complex we are using a table based
@@ -13663,7 +13645,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x5f000000, 0xdf000400, disas_simd_indexed }, /* scalar indexed */
     { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
     { 0xce800000, 0xffe00000, disas_crypto_xar },
-    { 0xce408000, 0xffe0c000, disas_crypto_three_reg_imm2 },
     { 0x0e400400, 0x9f60c400, disas_simd_three_reg_same_fp16 },
     { 0x0e780800, 0x8f7e0c00, disas_simd_two_reg_misc_fp16 },
     { 0x5e400400, 0xdf60c400, disas_simd_scalar_three_reg_same_fp16 },
-- 
2.34.1


