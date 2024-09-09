Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14AF1ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 16:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snhAT-0003m2-Kc; Mon, 09 Sep 2024 12:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snhAQ-0003Ta-9z
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:23:06 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snhAO-0007nQ-7W
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:23:06 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-207115e3056so15651885ad.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 09:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725898983; x=1726503783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xqt3o3MAxRoTQwnZ+IGB6Qxvrim2nqRih70a4tZl6QE=;
 b=Q8R2OuB6HWVAgH0/leI5d7aQ3YIwUirfKmaYhdT1qROhdOh3yIn7HzBDXmO0wGCHsI
 /et2VtpErypFQMoWhogG1wUdChsOEZAVcUAkDobyKYVet9ABT3nRl4MvK38mnl5ZDPaF
 1DvnvVmflWJQ1b4Y0l6FDM715K+dyn8behdpfoscrB5s3upP/IhnErWBrYaT+TW2eTT2
 80GbBpBpUQqqQKaitfhB1cYny32KKCp7I2sngDHd5iB9HapClA6KC2yMmEZXIERx2ToR
 dWt1szjXcs6GYUs+Kcqq3197I7LZfhl/WKpgK0zeWgF88hIhu5qF02Z9bGbDe/KiPmb/
 jeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725898983; x=1726503783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xqt3o3MAxRoTQwnZ+IGB6Qxvrim2nqRih70a4tZl6QE=;
 b=csODLnQgEGRaUmj1IucJjb+d9uCALoPlpOYf0hbXoa8aSjdZnJyd1Qn7MtZ9+vZMzF
 q2SZmf6JB43P9YIzKevKwb+q980rujLrbKHADM+Rj6wuYRewh9RNqouajlmri7NqiSwE
 b/fYc7oCiVv4zn9oNXY7hyyNZQwSzmjWjm5lpzrU/NIg9sj+vyhjVnXv5vBF1WTGG0rb
 XzqFJfiMFQ2iF1COLL98JRUEJHqAxY8EIZ1sCk7Rnpn9zVOTQUhEVm2YY3nDne9X8D14
 5B0dQ5FC3DxtpfyQM0xdu4EO37TBIw9BPkHNPC5Cgol5A/Ad+zlNq/sBi98GlPVKiBxe
 gBDQ==
X-Gm-Message-State: AOJu0YwDwArNx2IJO7QNJ8ROFp8f6R6qFAPqLMexT3Bdgsor4Aqs82hO
 tilTq/cf/hXgMx8mcaiwEjTYtDQSS4yL8icuHGU99VQ4KRADD3Po3gbPXoQ9KzBB+sXaFc8wqP7
 p
X-Google-Smtp-Source: AGHT+IEBzT/pd+39WqwcAMsYToGugQmflO5fD+wjJ0fS1JdmqbVFbLSO/lF8KHa0irqa89jF9g3yrA==
X-Received: by 2002:a17:902:e88a:b0:206:96ad:e823 with SMTP id
 d9443c01a7336-206f05e78f8mr121051715ad.39.1725898982886; 
 Mon, 09 Sep 2024 09:23:02 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f35d79sm35753305ad.288.2024.09.09.09.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 09:23:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 23/29] target/arm: Convert handle_scalar_simd_shri to
 decodetree
Date: Mon,  9 Sep 2024 09:22:33 -0700
Message-ID: <20240909162240.647173-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909162240.647173-1-richard.henderson@linaro.org>
References: <20240909162240.647173-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

This includes SSHR, USHR, SSRA, USRA, SRSHR, URSHR,
SRSRA, URSRA, SRI.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 140 ++++++++++++++++-----------------
 target/arm/tcg/a64.decode      |  16 ++++
 2 files changed, 86 insertions(+), 70 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 8871087af0..efd93a7f23 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7035,6 +7035,18 @@ static void gen_ushr_d(TCGv_i64 dst, TCGv_i64 src, int64_t shift)
     }
 }
 
+static void gen_ssra_d(TCGv_i64 dst, TCGv_i64 src, int64_t shift)
+{
+    gen_sshr_d(src, src, shift);
+    tcg_gen_add_i64(dst, dst, src);
+}
+
+static void gen_usra_d(TCGv_i64 dst, TCGv_i64 src, int64_t shift)
+{
+    gen_ushr_d(src, src, shift);
+    tcg_gen_add_i64(dst, dst, src);
+}
+
 static void gen_srshr_bhs(TCGv_i64 dst, TCGv_i64 src, int64_t shift)
 {
     assert(shift >= 0 && shift <= 32);
@@ -7091,6 +7103,27 @@ static void gen_urshr_d(TCGv_i64 dst, TCGv_i64 src, int64_t shift)
     }
 }
 
+static void gen_srsra_d(TCGv_i64 dst, TCGv_i64 src, int64_t shift)
+{
+    gen_srshr_d(src, src, shift);
+    tcg_gen_add_i64(dst, dst, src);
+}
+
+static void gen_ursra_d(TCGv_i64 dst, TCGv_i64 src, int64_t shift)
+{
+    gen_urshr_d(src, src, shift);
+    tcg_gen_add_i64(dst, dst, src);
+}
+
+static void gen_sri_d(TCGv_i64 dst, TCGv_i64 src, int64_t shift)
+{
+    /* If shift is 64, dst is unchanged. */
+    if (shift != 64) {
+        tcg_gen_shri_i64(src, src, shift);
+        tcg_gen_deposit_i64(dst, dst, src, 0, 64 - shift);
+    }
+}
+
 static bool do_vec_shift_imm_narrow(DisasContext *s, arg_qrri_e *a,
                                     WideShiftImmFn * const fns[3], MemOp sign)
 {
@@ -7136,6 +7169,38 @@ static WideShiftImmFn * const rshrn_fns[] = {
 };
 TRANS(RSHRN_v, do_vec_shift_imm_narrow, a, rshrn_fns, 0)
 
+/*
+ * Advanced SIMD Scalar Shift by Immediate
+ */
+
+static bool do_scalar_shift_imm(DisasContext *s, arg_rri_e *a,
+                                WideShiftImmFn *fn, bool accumulate,
+                                MemOp sign)
+{
+    if (fp_access_check(s)) {
+        TCGv_i64 rd = tcg_temp_new_i64();
+        TCGv_i64 rn = tcg_temp_new_i64();
+
+        read_vec_element(s, rn, a->rn, 0, a->esz | sign);
+        if (accumulate) {
+            read_vec_element(s, rd, a->rd, 0, a->esz | sign);
+        }
+        fn(rd, rn, a->imm);
+        write_fp_dreg(s, a->rd, rd);
+    }
+    return true;
+}
+
+TRANS(SSHR_s, do_scalar_shift_imm, a, gen_sshr_d, false, 0)
+TRANS(USHR_s, do_scalar_shift_imm, a, gen_ushr_d, false, 0)
+TRANS(SSRA_s, do_scalar_shift_imm, a, gen_ssra_d, true, 0)
+TRANS(USRA_s, do_scalar_shift_imm, a, gen_usra_d, true, 0)
+TRANS(SRSHR_s, do_scalar_shift_imm, a, gen_srshr_d, false, 0)
+TRANS(URSHR_s, do_scalar_shift_imm, a, gen_urshr_d, false, 0)
+TRANS(SRSRA_s, do_scalar_shift_imm, a, gen_srsra_d, true, 0)
+TRANS(URSRA_s, do_scalar_shift_imm, a, gen_ursra_d, true, 0)
+TRANS(SRI_s, do_scalar_shift_imm, a, gen_sri_d, true, 0)
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -9352,64 +9417,6 @@ static void handle_shri_with_rndacc(TCGv_i64 tcg_res, TCGv_i64 tcg_src,
     }
 }
 
-/* SSHR[RA]/USHR[RA] - Scalar shift right (optional rounding/accumulate) */
-static void handle_scalar_simd_shri(DisasContext *s,
-                                    bool is_u, int immh, int immb,
-                                    int opcode, int rn, int rd)
-{
-    const int size = 3;
-    int immhb = immh << 3 | immb;
-    int shift = 2 * (8 << size) - immhb;
-    bool accumulate = false;
-    bool round = false;
-    bool insert = false;
-    TCGv_i64 tcg_rn;
-    TCGv_i64 tcg_rd;
-
-    if (!extract32(immh, 3, 1)) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    switch (opcode) {
-    case 0x02: /* SSRA / USRA (accumulate) */
-        accumulate = true;
-        break;
-    case 0x04: /* SRSHR / URSHR (rounding) */
-        round = true;
-        break;
-    case 0x06: /* SRSRA / URSRA (accum + rounding) */
-        accumulate = round = true;
-        break;
-    case 0x08: /* SRI */
-        insert = true;
-        break;
-    }
-
-    tcg_rn = read_fp_dreg(s, rn);
-    tcg_rd = (accumulate || insert) ? read_fp_dreg(s, rd) : tcg_temp_new_i64();
-
-    if (insert) {
-        /* shift count same as element size is valid but does nothing;
-         * special case to avoid potential shift by 64.
-         */
-        int esize = 8 << size;
-        if (shift != esize) {
-            tcg_gen_shri_i64(tcg_rn, tcg_rn, shift);
-            tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_rn, 0, esize - shift);
-        }
-    } else {
-        handle_shri_with_rndacc(tcg_rd, tcg_rn, round,
-                                accumulate, is_u, size, shift);
-    }
-
-    write_fp_dreg(s, rd, tcg_rd);
-}
-
 /* SHL/SLI - Scalar shift left */
 static void handle_scalar_simd_shli(DisasContext *s, bool insert,
                                     int immh, int immb, int opcode,
@@ -9893,18 +9900,6 @@ static void disas_simd_scalar_shift_imm(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x08: /* SRI */
-        if (!is_u) {
-            unallocated_encoding(s);
-            return;
-        }
-        /* fall through */
-    case 0x00: /* SSHR / USHR */
-    case 0x02: /* SSRA / USRA */
-    case 0x04: /* SRSHR / URSHR */
-    case 0x06: /* SRSRA / URSRA */
-        handle_scalar_simd_shri(s, is_u, immh, immb, opcode, rn, rd);
-        break;
     case 0x0a: /* SHL / SLI */
         handle_scalar_simd_shli(s, is_u, immh, immb, opcode, rn, rd);
         break;
@@ -9940,6 +9935,11 @@ static void disas_simd_scalar_shift_imm(DisasContext *s, uint32_t insn)
         handle_simd_shift_fpint_conv(s, true, false, is_u, immh, immb, rn, rd);
         break;
     default:
+    case 0x00: /* SSHR / USHR */
+    case 0x02: /* SSRA / USRA */
+    case 0x04: /* SRSHR / URSHR */
+    case 0x06: /* SRSRA / URSRA */
+    case 0x08: /* SRI */
         unallocated_encoding(s);
         break;
     }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 164ed575b9..6c2362b3bb 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -30,6 +30,7 @@
 &rri_sf         rd rn imm sf
 &i              imm
 &rr_e           rd rn esz
+&rri_e          rd rn imm esz
 &rrr_e          rd rn rm esz
 &rrx_e          rd rn rm idx esz
 &rrrr_e         rd rn rm ra esz
@@ -1285,3 +1286,18 @@ SHRN_v          0.00 11110 .... ... 10000 1 ..... .....     @q_shri_s
 RSHRN_v         0.00 11110 .... ... 10001 1 ..... .....     @q_shri_b
 RSHRN_v         0.00 11110 .... ... 10001 1 ..... .....     @q_shri_h
 RSHRN_v         0.00 11110 .... ... 10001 1 ..... .....     @q_shri_s
+
+# Advanced SIMD scalar shift by immediate
+
+@shri_d         .... ..... 1 ...... ..... . rn:5 rd:5   \
+                &rri_e esz=3 imm=%neon_rshift_i6
+
+SSHR_s          0101 11110 .... ... 00000 1 ..... .....     @shri_d
+USHR_s          0111 11110 .... ... 00000 1 ..... .....     @shri_d
+SSRA_s          0101 11110 .... ... 00010 1 ..... .....     @shri_d
+USRA_s          0111 11110 .... ... 00010 1 ..... .....     @shri_d
+SRSHR_s         0101 11110 .... ... 00100 1 ..... .....     @shri_d
+URSHR_s         0111 11110 .... ... 00100 1 ..... .....     @shri_d
+SRSRA_s         0101 11110 .... ... 00110 1 ..... .....     @shri_d
+URSRA_s         0111 11110 .... ... 00110 1 ..... .....     @shri_d
+SRI_s           0111 11110 .... ... 01000 1 ..... .....     @shri_d
-- 
2.43.0


