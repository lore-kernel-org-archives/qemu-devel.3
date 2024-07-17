Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1027FC3DA60
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 06:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTxrq-00080r-NC; Wed, 17 Jul 2024 02:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxrP-0005iA-4h
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:09:55 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxrN-000375-B6
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:09:54 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-70b0e9ee7bcso4786706b3a.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 23:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721196590; x=1721801390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8LtNgDhy4E7cEUJMsKObImZDBL0RRTKw5zfiAHlfw94=;
 b=jY23WuMnSpbeVu0voG4ZEVC+OeX2UZgJfyea/TxmFcSFOiq/O8RyPpakzcveFtqxjZ
 39FXbRVDEAGIZ03RaTJXbo53kwUpUYx4xbNqK+zbzU6b28TmG9DC9PuJOIsoPOH4ctcO
 NGcZBGAow/RFs3AqRX6AYlxFc108Y3mnh2AxWUb7h4ESzCdgHSlRnnI1QH7kt+c0Q1Lt
 ONI/Gc/YFL+suN7hNeErO5pv2Or8h1SchAk9uRp2+zqkkCuq4ws0pDzebbitzR9kVmXQ
 W0jwEi8IGusA/FpxNraWvDfXDyb7FAcHttHGJPJbKBK2oKSDzIBKX+M2uSZL68prt9Hk
 LJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721196590; x=1721801390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8LtNgDhy4E7cEUJMsKObImZDBL0RRTKw5zfiAHlfw94=;
 b=W76q6036xdWDBWTbWBDfYPBSLUSzk1YwAwCts6kz1D6p3pYltUKU605ECkIsgf3Gsf
 Q3TkxK7/4NB1eVLnjU+yObQVCMsj2rdBweZUYQ3sDRmEr4pmOOhVzIKxVRUNpqM7SUHg
 3ORChswdwUWYvJNwkqDdC33o3DPUkF14UhmNLeSs1gXKXdk5t/D8CYjotP6tgX43iIN9
 MHox6EMhU8eZJN21++tkhnKIK71dHud1TyDY7eXC3xzr1T1E0ziDZjVuAo11Mk0/+0ad
 1DCHFZObgpY1qpxApXlZnXhEE4SKlpNMt05+uIjqNfddJ9LqwoqLBTuI3NABNaENIQH0
 YlpA==
X-Gm-Message-State: AOJu0Yw4rcIVp5Flt3NYyx4XgXX5lvIsZWjVO35KwBl5Lwqp6/8bWQrO
 hkdkAvYC1dTas8UVZ9ezUWWcSXhgNzRKGxGAMG1gn74lszi35GvRYeETnln0NFU2RtQ7KlKO3qS
 PAR8=
X-Google-Smtp-Source: AGHT+IFurGtiqOxSqLYRuKiVLuec3GNSC60d8C67RVZI+3SEvUQR1dDApSvPFUStD9C4i826mFbF+w==
X-Received: by 2002:a05:6a00:c94:b0:70a:f38c:74cc with SMTP id
 d2e1a72fcca58-70ce4edc6a1mr867525b3a.8.1721196590494; 
 Tue, 16 Jul 2024 23:09:50 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7ecd603bsm7330404b3a.219.2024.07.16.23.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 23:09:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 16/17] target/arm: Convert SSHLL, USHLL to decodetree
Date: Wed, 17 Jul 2024 16:09:02 +1000
Message-ID: <20240717060903.205098-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717060903.205098-1-richard.henderson@linaro.org>
References: <20240717060903.205098-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 84 ++++++++++++++++------------------
 target/arm/tcg/a64.decode      |  3 ++
 2 files changed, 43 insertions(+), 44 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 627d4311bb..2a9cb3fbe0 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6972,6 +6972,45 @@ TRANS(SRI_v, do_vec_shift_imm, a, gen_gvec_sri)
 TRANS(SHL_v, do_vec_shift_imm, a, tcg_gen_gvec_shli)
 TRANS(SLI_v, do_vec_shift_imm, a, gen_gvec_sli);
 
+static bool do_vec_shift_imm_wide(DisasContext *s, arg_qrri_e *a, bool is_u)
+{
+    TCGv_i64 tcg_rn, tcg_rd;
+    int esz = a->esz;
+    int esize;
+
+    if (esz < 0 || esz >= MO_64) {
+        return false;
+    }
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
@@ -10436,47 +10475,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
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
@@ -10566,9 +10564,6 @@ static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
         handle_vec_simd_sqshrn(s, false, is_q, is_u, is_u, immh, immb,
                                opcode, rn, rd);
         break;
-    case 0x14: /* SSHLL / USHLL */
-        handle_vec_simd_wshli(s, is_q, is_u, immh, immb, opcode, rn, rd);
-        break;
     case 0x1c: /* SCVTF / UCVTF */
         handle_simd_shift_intfp_conv(s, false, is_q, is_u, immh, immb,
                                      opcode, rn, rd);
@@ -10593,6 +10588,7 @@ static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
     case 0x06: /* SRSRA / URSRA (accum + rounding) */
     case 0x08: /* SRI */
     case 0x0a: /* SHL / SLI */
+    case 0x14: /* SSHLL / USHLL */
         unallocated_encoding(s);
         return;
     }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 6aa8a18240..d13d680589 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1218,5 +1218,8 @@ FMOVI_v_h       0 q:1 00 1111 00000 ... 1111 11 ..... rd:5  %abcdefgh
 
     SHL_v       0.00 11110 .... ... 01010 1 ..... .....     @qlshifti
     SLI_v       0.10 11110 .... ... 01010 1 ..... .....     @qlshifti
+
+    SSHLL_v     0.00 11110 .... ... 10100 1 ..... .....     @qlshifti
+    USHLL_v     0.10 11110 .... ... 10100 1 ..... .....     @qlshifti
   ]
 }
-- 
2.43.0


