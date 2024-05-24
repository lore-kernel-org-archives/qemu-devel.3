Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD17EC41513
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 23:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAeEU-0006ep-4X; Fri, 24 May 2024 19:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeEK-0006WD-CA
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:45 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeEF-0005mt-F6
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:44 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f44b42d1caso9591295ad.0
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 16:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716592898; x=1717197698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f/oBfdTOXox41YO6PvDaX+L7susLQEDZ8jvwbEvXtZA=;
 b=S8saBvseLsrEn+3GBVTBXND07nrDC3ZDHUzfDjBGcJWLILCeYhBDfUJliApS6flZq/
 pTeX6EhveEpv0KLml5Kq4Rz4zVHxuQZaWRtso28Ul/vG5vVilv/yQufx7DSpuA3HWLKS
 uzJA+U1TsJuGhv3prU7nnCJyt6vCMS+cia11WG89C13OKos4DFnMxRj/6X4Y1x+tylKd
 uOZ8s2ty1XL0LQrdpWgqwRnGw7dSdYDZ+swH5iQv4ScEko96ZNJluV7yrHt8wk/6IWhh
 Ty7mYRjyyjsPn7bKO9Jd3knIVoazNBNgsWscuV9EFsHHcklPO0Gyz5lApVePC8xsFA9N
 nj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716592898; x=1717197698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f/oBfdTOXox41YO6PvDaX+L7susLQEDZ8jvwbEvXtZA=;
 b=g1b1nPn9JLjqBFPLYZSkvvJLZUYA+X6sJBsilNTpArMPYC+5gX2jKPdFiY4rtU4o+i
 RQr+iSAGu1JKYm+ItY30m3BC0LkTtn6nLGv4gSOCW3k4w/b5HdCI0XxjrbAW8ABCOFb/
 /ErL9f/SaK9/aw/ru6htS/qyId85DCRgJFdg8EAQt4V1vHT401rSaNkIs8/T5jj+b/iB
 mbgyOPsUflqejSQJ+W75o7bULM+PFb00EJLOjFsNzA9OjcINyv2gUyJ7dWGN/GPgA1iE
 1c/bDGLv4YHq/P03xtYJTAADY9kg/hGN9iX3ZokSv8jWftx97j9+au+o1gwM6UtZN+cw
 dKpA==
X-Gm-Message-State: AOJu0Ywbk6F9yljwzQhQbAvv68dx8Iq391oMMnKMx4doih287W29zfWB
 LdBX7EsYSLMngjBzHHC6HUGoifRQP3cyYM1wsGNQbnZQ+zNQdpb/aGx0sBYat5o9gztuLhQMTq8
 Y
X-Google-Smtp-Source: AGHT+IFSzYLV/KpoVlTxRMgnqEBKnXmM+Na22OrT0Z7IGorjtLbS3ytL48rpjuMgnHZwWp/YKHEAWw==
X-Received: by 2002:a17:902:f54d:b0:1f3:11bc:20b5 with SMTP id
 d9443c01a7336-1f44874038emr41347385ad.23.1716592897898; 
 Fri, 24 May 2024 16:21:37 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c759ceesm19178305ad.10.2024.05.24.16.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 16:21:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 17/67] target/arm: Convert Advanced SIMD copy to decodetree
Date: Fri, 24 May 2024 16:20:31 -0700
Message-Id: <20240524232121.284515-18-richard.henderson@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/arm/tcg/a64.decode      |  13 +
 target/arm/tcg/translate-a64.c | 426 +++++++++++----------------------
 2 files changed, 152 insertions(+), 287 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 7f354af25d..d5bfeae7a8 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -658,3 +658,16 @@ SM3TT2B         11001110 010 ..... 10 .. 11 ..... ..... @crypto3i
 ### Cryptographic XAR
 
 XAR             1100 1110 100 rm:5 imm:6 rn:5 rd:5
+
+### Advanced SIMD scalar copy
+
+DUP_element_s   0101 1110 000 imm:5 0 0000 1 rn:5 rd:5
+
+### Advanced SIMD copy
+
+DUP_element_v   0 q:1 00 1110 000 imm:5 0 0000 1 rn:5 rd:5
+DUP_general     0 q:1 00 1110 000 imm:5 0 0001 1 rn:5 rd:5
+INS_general     0 1   00 1110 000 imm:5 0 0011 1 rn:5 rd:5
+SMOV            0 q:1 00 1110 000 imm:5 0 0101 1 rn:5 rd:5
+UMOV            0 q:1 00 1110 000 imm:5 0 0111 1 rn:5 rd:5
+INS_element     0 1   10 1110 000 di:5  0 si:4 1 rn:5 rd:5
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 75f1e6a7b9..1a12bf22fd 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4702,6 +4702,145 @@ static bool trans_XAR(DisasContext *s, arg_XAR *a)
     return true;
 }
 
+/*
+ * Advanced SIMD copy
+ */
+
+static bool decode_esz_idx(int imm, MemOp *pesz, unsigned *pidx)
+{
+    unsigned esz = ctz32(imm);
+    if (esz <= MO_64) {
+        *pesz = esz;
+        *pidx = imm >> (esz + 1);
+        return true;
+    }
+    return false;
+}
+
+static bool trans_DUP_element_s(DisasContext *s, arg_DUP_element_s *a)
+{
+    MemOp esz;
+    unsigned idx;
+
+    if (!decode_esz_idx(a->imm, &esz, &idx)) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        /*
+         * This instruction just extracts the specified element and
+         * zero-extends it into the bottom of the destination register.
+         */
+        TCGv_i64 tmp = tcg_temp_new_i64();
+        read_vec_element(s, tmp, a->rn, idx, esz);
+        write_fp_dreg(s, a->rd, tmp);
+    }
+    return true;
+}
+
+static bool trans_DUP_element_v(DisasContext *s, arg_DUP_element_v *a)
+{
+    MemOp esz;
+    unsigned idx;
+
+    if (!decode_esz_idx(a->imm, &esz, &idx)) {
+        return false;
+    }
+    if (esz == MO_64 && !a->q) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        tcg_gen_gvec_dup_mem(esz, vec_full_reg_offset(s, a->rd),
+                             vec_reg_offset(s, a->rn, idx, esz),
+                             a->q ? 16 : 8, vec_full_reg_size(s));
+    }
+    return true;
+}
+
+static bool trans_DUP_general(DisasContext *s, arg_DUP_general *a)
+{
+    MemOp esz;
+    unsigned idx;
+
+    if (!decode_esz_idx(a->imm, &esz, &idx)) {
+        return false;
+    }
+    if (esz == MO_64 && !a->q) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        tcg_gen_gvec_dup_i64(esz, vec_full_reg_offset(s, a->rd),
+                             a->q ? 16 : 8, vec_full_reg_size(s),
+                             cpu_reg(s, a->rn));
+    }
+    return true;
+}
+
+static bool do_smov_umov(DisasContext *s, arg_SMOV *a, MemOp is_signed)
+{
+    MemOp esz;
+    unsigned idx;
+
+    if (!decode_esz_idx(a->imm, &esz, &idx)) {
+        return false;
+    }
+    if (is_signed) {
+        if (esz == MO_64 || (esz == MO_32 && !a->q)) {
+            return false;
+        }
+    } else {
+        if (esz == MO_64 ? !a->q : a->q) {
+            return false;
+        }
+    }
+    if (fp_access_check(s)) {
+        TCGv_i64 tcg_rd = cpu_reg(s, a->rd);
+        read_vec_element(s, tcg_rd, a->rn, idx, esz | is_signed);
+        if (is_signed && !a->q) {
+            tcg_gen_ext32u_i64(tcg_rd, tcg_rd);
+        }
+    }
+    return true;
+}
+
+TRANS(SMOV, do_smov_umov, a, MO_SIGN)
+TRANS(UMOV, do_smov_umov, a, 0)
+
+static bool trans_INS_general(DisasContext *s, arg_INS_general *a)
+{
+    MemOp esz;
+    unsigned idx;
+
+    if (!decode_esz_idx(a->imm, &esz, &idx)) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        write_vec_element(s, cpu_reg(s, a->rn), a->rd, idx, esz);
+        clear_vec_high(s, true, a->rd);
+    }
+    return true;
+}
+
+static bool trans_INS_element(DisasContext *s, arg_INS_element *a)
+{
+    MemOp esz;
+    unsigned didx, sidx;
+
+    if (!decode_esz_idx(a->di, &esz, &didx)) {
+        return false;
+    }
+    sidx = a->si >> esz;
+    if (fp_access_check(s)) {
+        TCGv_i64 tmp = tcg_temp_new_i64();
+
+        read_vec_element(s, tmp, a->rn, sidx, esz);
+        write_vec_element(s, tmp, a->rd, didx, esz);
+
+        /* INS is considered a 128-bit write for SVE. */
+        clear_vec_high(s, true, a->rd);
+    }
+    return true;
+}
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -7760,268 +7899,6 @@ static void disas_simd_across_lanes(DisasContext *s, uint32_t insn)
     write_fp_dreg(s, rd, tcg_res);
 }
 
-/* DUP (Element, Vector)
- *
- *  31  30   29              21 20    16 15        10  9    5 4    0
- * +---+---+-------------------+--------+-------------+------+------+
- * | 0 | Q | 0 0 1 1 1 0 0 0 0 |  imm5  | 0 0 0 0 0 1 |  Rn  |  Rd  |
- * +---+---+-------------------+--------+-------------+------+------+
- *
- * size: encoded in imm5 (see ARM ARM LowestSetBit())
- */
-static void handle_simd_dupe(DisasContext *s, int is_q, int rd, int rn,
-                             int imm5)
-{
-    int size = ctz32(imm5);
-    int index;
-
-    if (size > 3 || (size == 3 && !is_q)) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    index = imm5 >> (size + 1);
-    tcg_gen_gvec_dup_mem(size, vec_full_reg_offset(s, rd),
-                         vec_reg_offset(s, rn, index, size),
-                         is_q ? 16 : 8, vec_full_reg_size(s));
-}
-
-/* DUP (element, scalar)
- *  31                   21 20    16 15        10  9    5 4    0
- * +-----------------------+--------+-------------+------+------+
- * | 0 1 0 1 1 1 1 0 0 0 0 |  imm5  | 0 0 0 0 0 1 |  Rn  |  Rd  |
- * +-----------------------+--------+-------------+------+------+
- */
-static void handle_simd_dupes(DisasContext *s, int rd, int rn,
-                              int imm5)
-{
-    int size = ctz32(imm5);
-    int index;
-    TCGv_i64 tmp;
-
-    if (size > 3) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    index = imm5 >> (size + 1);
-
-    /* This instruction just extracts the specified element and
-     * zero-extends it into the bottom of the destination register.
-     */
-    tmp = tcg_temp_new_i64();
-    read_vec_element(s, tmp, rn, index, size);
-    write_fp_dreg(s, rd, tmp);
-}
-
-/* DUP (General)
- *
- *  31  30   29              21 20    16 15        10  9    5 4    0
- * +---+---+-------------------+--------+-------------+------+------+
- * | 0 | Q | 0 0 1 1 1 0 0 0 0 |  imm5  | 0 0 0 0 1 1 |  Rn  |  Rd  |
- * +---+---+-------------------+--------+-------------+------+------+
- *
- * size: encoded in imm5 (see ARM ARM LowestSetBit())
- */
-static void handle_simd_dupg(DisasContext *s, int is_q, int rd, int rn,
-                             int imm5)
-{
-    int size = ctz32(imm5);
-    uint32_t dofs, oprsz, maxsz;
-
-    if (size > 3 || ((size == 3) && !is_q)) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    dofs = vec_full_reg_offset(s, rd);
-    oprsz = is_q ? 16 : 8;
-    maxsz = vec_full_reg_size(s);
-
-    tcg_gen_gvec_dup_i64(size, dofs, oprsz, maxsz, cpu_reg(s, rn));
-}
-
-/* INS (Element)
- *
- *  31                   21 20    16 15  14    11  10 9    5 4    0
- * +-----------------------+--------+------------+---+------+------+
- * | 0 1 1 0 1 1 1 0 0 0 0 |  imm5  | 0 |  imm4  | 1 |  Rn  |  Rd  |
- * +-----------------------+--------+------------+---+------+------+
- *
- * size: encoded in imm5 (see ARM ARM LowestSetBit())
- * index: encoded in imm5<4:size+1>
- */
-static void handle_simd_inse(DisasContext *s, int rd, int rn,
-                             int imm4, int imm5)
-{
-    int size = ctz32(imm5);
-    int src_index, dst_index;
-    TCGv_i64 tmp;
-
-    if (size > 3) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    dst_index = extract32(imm5, 1+size, 5);
-    src_index = extract32(imm4, size, 4);
-
-    tmp = tcg_temp_new_i64();
-
-    read_vec_element(s, tmp, rn, src_index, size);
-    write_vec_element(s, tmp, rd, dst_index, size);
-
-    /* INS is considered a 128-bit write for SVE. */
-    clear_vec_high(s, true, rd);
-}
-
-
-/* INS (General)
- *
- *  31                   21 20    16 15        10  9    5 4    0
- * +-----------------------+--------+-------------+------+------+
- * | 0 1 0 0 1 1 1 0 0 0 0 |  imm5  | 0 0 0 1 1 1 |  Rn  |  Rd  |
- * +-----------------------+--------+-------------+------+------+
- *
- * size: encoded in imm5 (see ARM ARM LowestSetBit())
- * index: encoded in imm5<4:size+1>
- */
-static void handle_simd_insg(DisasContext *s, int rd, int rn, int imm5)
-{
-    int size = ctz32(imm5);
-    int idx;
-
-    if (size > 3) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    idx = extract32(imm5, 1 + size, 4 - size);
-    write_vec_element(s, cpu_reg(s, rn), rd, idx, size);
-
-    /* INS is considered a 128-bit write for SVE. */
-    clear_vec_high(s, true, rd);
-}
-
-/*
- * UMOV (General)
- * SMOV (General)
- *
- *  31  30   29              21 20    16 15    12   10 9    5 4    0
- * +---+---+-------------------+--------+-------------+------+------+
- * | 0 | Q | 0 0 1 1 1 0 0 0 0 |  imm5  | 0 0 1 U 1 1 |  Rn  |  Rd  |
- * +---+---+-------------------+--------+-------------+------+------+
- *
- * U: unsigned when set
- * size: encoded in imm5 (see ARM ARM LowestSetBit())
- */
-static void handle_simd_umov_smov(DisasContext *s, int is_q, int is_signed,
-                                  int rn, int rd, int imm5)
-{
-    int size = ctz32(imm5);
-    int element;
-    TCGv_i64 tcg_rd;
-
-    /* Check for UnallocatedEncodings */
-    if (is_signed) {
-        if (size > 2 || (size == 2 && !is_q)) {
-            unallocated_encoding(s);
-            return;
-        }
-    } else {
-        if (size > 3
-            || (size < 3 && is_q)
-            || (size == 3 && !is_q)) {
-            unallocated_encoding(s);
-            return;
-        }
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    element = extract32(imm5, 1+size, 4);
-
-    tcg_rd = cpu_reg(s, rd);
-    read_vec_element(s, tcg_rd, rn, element, size | (is_signed ? MO_SIGN : 0));
-    if (is_signed && !is_q) {
-        tcg_gen_ext32u_i64(tcg_rd, tcg_rd);
-    }
-}
-
-/* AdvSIMD copy
- *   31  30  29  28             21 20  16 15  14  11 10  9    5 4    0
- * +---+---+----+-----------------+------+---+------+---+------+------+
- * | 0 | Q | op | 0 1 1 1 0 0 0 0 | imm5 | 0 | imm4 | 1 |  Rn  |  Rd  |
- * +---+---+----+-----------------+------+---+------+---+------+------+
- */
-static void disas_simd_copy(DisasContext *s, uint32_t insn)
-{
-    int rd = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int imm4 = extract32(insn, 11, 4);
-    int op = extract32(insn, 29, 1);
-    int is_q = extract32(insn, 30, 1);
-    int imm5 = extract32(insn, 16, 5);
-
-    if (op) {
-        if (is_q) {
-            /* INS (element) */
-            handle_simd_inse(s, rd, rn, imm4, imm5);
-        } else {
-            unallocated_encoding(s);
-        }
-    } else {
-        switch (imm4) {
-        case 0:
-            /* DUP (element - vector) */
-            handle_simd_dupe(s, is_q, rd, rn, imm5);
-            break;
-        case 1:
-            /* DUP (general) */
-            handle_simd_dupg(s, is_q, rd, rn, imm5);
-            break;
-        case 3:
-            if (is_q) {
-                /* INS (general) */
-                handle_simd_insg(s, rd, rn, imm5);
-            } else {
-                unallocated_encoding(s);
-            }
-            break;
-        case 5:
-        case 7:
-            /* UMOV/SMOV (is_q indicates 32/64; imm4 indicates signedness) */
-            handle_simd_umov_smov(s, is_q, (imm4 == 5), rn, rd, imm5);
-            break;
-        default:
-            unallocated_encoding(s);
-            break;
-        }
-    }
-}
-
 /* AdvSIMD modified immediate
  *  31  30   29  28                 19 18 16 15   12  11  10  9     5 4    0
  * +---+---+----+---------------------+-----+-------+----+---+-------+------+
@@ -8085,29 +7962,6 @@ static void disas_simd_mod_imm(DisasContext *s, uint32_t insn)
     }
 }
 
-/* AdvSIMD scalar copy
- *  31 30  29  28             21 20  16 15  14  11 10  9    5 4    0
- * +-----+----+-----------------+------+---+------+---+------+------+
- * | 0 1 | op | 1 1 1 1 0 0 0 0 | imm5 | 0 | imm4 | 1 |  Rn  |  Rd  |
- * +-----+----+-----------------+------+---+------+---+------+------+
- */
-static void disas_simd_scalar_copy(DisasContext *s, uint32_t insn)
-{
-    int rd = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int imm4 = extract32(insn, 11, 4);
-    int imm5 = extract32(insn, 16, 5);
-    int op = extract32(insn, 29, 1);
-
-    if (op != 0 || imm4 != 0) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    /* DUP (element, scalar) */
-    handle_simd_dupes(s, rd, rn, imm5);
-}
-
 /* AdvSIMD scalar pairwise
  *  31 30  29 28       24 23  22 21       17 16    12 11 10 9    5 4    0
  * +-----+---+-----------+------+-----------+--------+-----+------+------+
@@ -13614,7 +13468,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x0e200000, 0x9f200c00, disas_simd_three_reg_diff },
     { 0x0e200800, 0x9f3e0c00, disas_simd_two_reg_misc },
     { 0x0e300800, 0x9f3e0c00, disas_simd_across_lanes },
-    { 0x0e000400, 0x9fe08400, disas_simd_copy },
     { 0x0f000000, 0x9f000400, disas_simd_indexed }, /* vector indexed */
     /* simd_mod_imm decode is a subset of simd_shift_imm, so must precede it */
     { 0x0f000400, 0x9ff80400, disas_simd_mod_imm },
@@ -13627,7 +13480,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x5e200000, 0xdf200c00, disas_simd_scalar_three_reg_diff },
     { 0x5e200800, 0xdf3e0c00, disas_simd_scalar_two_reg_misc },
     { 0x5e300800, 0xdf3e0c00, disas_simd_scalar_pairwise },
-    { 0x5e000400, 0xdfe08400, disas_simd_scalar_copy },
     { 0x5f000000, 0xdf000400, disas_simd_indexed }, /* scalar indexed */
     { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
     { 0x0e400400, 0x9f60c400, disas_simd_three_reg_same_fp16 },
-- 
2.34.1


