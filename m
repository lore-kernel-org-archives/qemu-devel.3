Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19B9C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 23:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAeEV-0006g1-5f; Fri, 24 May 2024 19:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeEK-0006WB-5d
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:44 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeEF-0005mY-Ej
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:42 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f3310a21d8so24797425ad.1
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 16:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716592897; x=1717197697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fODOcCWj61ck2RRtz0vPUUYcMqJTXdEitBsSudVvQlM=;
 b=zckZDexIZnIMhteJHeMv6SXcThm+k4R05hytQHjIJJ81z5BAkBohV7H3qbypxnzv6e
 uZtUkahl7P9fYxS0eckxt/T2QFBRoLMF81whubiQ4qPURia3umCGUbnHcr3k60tqt99U
 99gCzx/LgMFTfkDukC9cCVC87RIhTO3FRlHIriWDyThxHXDnu3daRKk6pNaFCG6y0kYh
 x8hltqzk/44j16jlJxK6AUMcpLiIyM6UQiyaiYRJ1k8DNfygH61aA+K4EPnuJsWrjTr/
 R1+lvQXvFgeC99z6Aw4Pv9Ji3RHZqVtDhFwpZb03d6mmv5Szr3laR6GWc1juoEnZ266L
 I1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716592897; x=1717197697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fODOcCWj61ck2RRtz0vPUUYcMqJTXdEitBsSudVvQlM=;
 b=poTKG6MLe0ezQflL0Sw0RtX6yot2gHqpDJVWAeTV4ZGsvpjdRi6IgFg8JipaV8GAHc
 G3kVO8EEHKF++/LDFRWRTvfRjq0/m0OpPet5xlNjD90xtau9a/MZW50/7MezTy8VtT68
 cKqSIxHyxCxnl8IDXuIB2jLM6NCw+1x0OKJU275otlrPgCNljKDXFEhv8g9m5q7LZmov
 eKSfuWY+Esepd9AFGyMCEbqPpOqZnEnB2mwjsONiuRYLDCEipzNR6N6oOBMtdE8/Pc96
 kM/a4bBl99RsaC9ag+1mhnNX3i2aXYQiiT2N0AfQ+KVM6XIsDnv53qk3UDUjrBWAppge
 ZIcQ==
X-Gm-Message-State: AOJu0YxBsrBa2se+NRDWILbkpTKXGgrCQmQ0AMOFfgDpHmVLUBropcfh
 mb2W808wfK1VjZckKM4oAAtNJ+sgM2f3I0HeU1ZZMnjtGreKZ5jZ8GMz0JaDDd9kOgDgT6jyGP8
 h
X-Google-Smtp-Source: AGHT+IFivj0xz3vXxVxFdEk8rIgXYw3qZtsQi8t8zU42Wj9tlABp730jHDdfyGlBMwoINmCeScJu7w==
X-Received: by 2002:a17:902:d486:b0:1f3:1cb9:47a0 with SMTP id
 d9443c01a7336-1f44870a07cmr44675365ad.27.1716592896932; 
 Fri, 24 May 2024 16:21:36 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c759ceesm19178305ad.10.2024.05.24.16.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 16:21:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 16/67] target/arm: Convert XAR to decodetree
Date: Fri, 24 May 2024 16:20:30 -0700
Message-Id: <20240524232121.284515-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524232121.284515-1-richard.henderson@linaro.org>
References: <20240524232121.284515-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/a64.decode      |  4 ++++
 target/arm/tcg/translate-a64.c | 43 +++++++++++-----------------------
 2 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 1292312a7f..7f354af25d 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -654,3 +654,7 @@ SM3TT1A         11001110 010 ..... 10 .. 00 ..... ..... @crypto3i
 SM3TT1B         11001110 010 ..... 10 .. 01 ..... ..... @crypto3i
 SM3TT2A         11001110 010 ..... 10 .. 10 ..... ..... @crypto3i
 SM3TT2B         11001110 010 ..... 10 .. 11 ..... ..... @crypto3i
+
+### Cryptographic XAR
+
+XAR             1100 1110 100 rm:5 imm:6 rn:5 rd:5
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index cf3a7dfa99..75f1e6a7b9 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4688,6 +4688,20 @@ TRANS_FEAT(SM3TT1B, aa64_sm3, do_crypto3i, a, gen_helper_crypto_sm3tt1b)
 TRANS_FEAT(SM3TT2A, aa64_sm3, do_crypto3i, a, gen_helper_crypto_sm3tt2a)
 TRANS_FEAT(SM3TT2B, aa64_sm3, do_crypto3i, a, gen_helper_crypto_sm3tt2b)
 
+static bool trans_XAR(DisasContext *s, arg_XAR *a)
+{
+    if (!dc_isar_feature(aa64_sha3, s)) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        gen_gvec_xar(MO_64, vec_full_reg_offset(s, a->rd),
+                     vec_full_reg_offset(s, a->rn),
+                     vec_full_reg_offset(s, a->rm), a->imm, 16,
+                     vec_full_reg_size(s));
+    }
+    return true;
+}
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -13588,34 +13602,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Crypto XAR
- *  31                   21 20  16 15    10 9    5 4    0
- * +-----------------------+------+--------+------+------+
- * | 1 1 0 0 1 1 1 0 1 0 0 |  Rm  |  imm6  |  Rn  |  Rd  |
- * +-----------------------+------+--------+------+------+
- */
-static void disas_crypto_xar(DisasContext *s, uint32_t insn)
-{
-    int rm = extract32(insn, 16, 5);
-    int imm6 = extract32(insn, 10, 6);
-    int rn = extract32(insn, 5, 5);
-    int rd = extract32(insn, 0, 5);
-
-    if (!dc_isar_feature(aa64_sha3, s)) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    gen_gvec_xar(MO_64, vec_full_reg_offset(s, rd),
-                 vec_full_reg_offset(s, rn),
-                 vec_full_reg_offset(s, rm), imm6, 16,
-                 vec_full_reg_size(s));
-}
-
 /* C3.6 Data processing - SIMD, inc Crypto
  *
  * As the decode gets a little complex we are using a table based
@@ -13644,7 +13630,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x5e000400, 0xdfe08400, disas_simd_scalar_copy },
     { 0x5f000000, 0xdf000400, disas_simd_indexed }, /* scalar indexed */
     { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
-    { 0xce800000, 0xffe00000, disas_crypto_xar },
     { 0x0e400400, 0x9f60c400, disas_simd_three_reg_same_fp16 },
     { 0x0e780800, 0x8f7e0c00, disas_simd_two_reg_misc_fp16 },
     { 0x5e400400, 0xdf60c400, disas_simd_scalar_three_reg_same_fp16 },
-- 
2.34.1


