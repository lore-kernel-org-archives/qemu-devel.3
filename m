Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0D7C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 06:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTxr9-0004XG-Mg; Wed, 17 Jul 2024 02:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxqu-0003nh-Hw
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:09:25 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxqs-00031V-It
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:09:24 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70b0d0a7a56so4836768b3a.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 23:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721196561; x=1721801361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x2uOrGaVn9GiD8dOMFplEIoJVLJP1krEvohvtVj4ays=;
 b=ll3pN3EAcUZVZhm3XlvWQo7o6RCT/WOoEbNmdkIOfsVkhd+R8stQXjoZ85QnYs8uj/
 CGe2m15VmdRCfr01c59hZX68+5cMo+9xcmzwJGjUs3JkCbXIylxf9zNV0fY/1O7LXmxS
 cWRBPUxw9GwOCvMkz7LNZyLubH1izZ6tSdTqFMptDPGPBmKCgz/Ou2ABxphbOFARgR72
 YL1WAB1BeDqFqN5ce7PFiwoplGMT5DkYxkMjB9zugNACB32Z23aWKFihvu0dyNk8/Cd1
 OnFzJJuL3C/NSvEyK12ldaDz6mHf4Hvg/nHxmiEzqWeNTeLEvOABeW0W6c5GcufJjRgz
 0evg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721196561; x=1721801361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x2uOrGaVn9GiD8dOMFplEIoJVLJP1krEvohvtVj4ays=;
 b=KNLYbaAWLI1/0vRre3q6HOE7BI2C1nq6ae2dskhJFJRxVUl2AFh9oHD4+aIWOdAKgX
 ZikAkeAvldceeG7OxKYO6Synj4kBsfaUN5ToKqnRArQkOCI//lDWbKTv7EQoAsJW+umD
 CZWAzqeMwh6DZCQDr7nbBekcnLtmqjeNsv8JgiU29txPb/wxsCoLLwFXGWG4aDKYyV3+
 Bglr3K3kTIf/RpAzus7ekt+9IwS6cjdJCawOsAnQ90hXwmo4RRXUXy06rbdGuSa4/Gne
 aq2HQV8GVGeMirmoQvjZUXIWIpD8rReymHSfmi9qQkkjKPeRrMO+Ey/3bIqlOEjHDLcJ
 43pw==
X-Gm-Message-State: AOJu0YxbCNFvNrzJ+OcJ5rfk1dc5ElGzSHx2OdYIGbqPW9uVaBLJz8N3
 Nj1TfLP4ZPR3VEmlWTu7iwZ3iqlyiMx+Tssr9FxTrxPW7hkHGZgWN2IonAF07L7v92P6WN6+/h5
 rCCo=
X-Google-Smtp-Source: AGHT+IE+4Ne+0TGibxZXpuEd8tSrbloHlOSBZ0bv+QYXG11LxF20foz2V+NGh4L5c6VlhFYnGKT5WA==
X-Received: by 2002:a05:6a00:3d0a:b0:706:6bdc:4de5 with SMTP id
 d2e1a72fcca58-70ce4f74756mr748481b3a.7.1721196561051; 
 Tue, 16 Jul 2024 23:09:21 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7ecd603bsm7330404b3a.219.2024.07.16.23.09.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 23:09:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 04/17] target/arm: Convert UZP, TRN, ZIP to decodetree
Date: Wed, 17 Jul 2024 16:08:50 +1000
Message-ID: <20240717060903.205098-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717060903.205098-1-richard.henderson@linaro.org>
References: <20240717060903.205098-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
 target/arm/tcg/translate-a64.c | 158 ++++++++++++++-------------------
 target/arm/tcg/a64.decode      |   9 ++
 2 files changed, 77 insertions(+), 90 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 7e3bde93fe..e0314a1253 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4671,6 +4671,74 @@ static bool trans_TBL_TBX(DisasContext *s, arg_TBL_TBX *a)
     return true;
 }
 
+typedef int simd_permute_idx_fn(int i, int part, int elements);
+
+static bool do_simd_permute(DisasContext *s, arg_qrrr_e *a,
+                            simd_permute_idx_fn *fn, int part)
+{
+    MemOp esz = a->esz;
+    int datasize = a->q ? 16 : 8;
+    int elements = datasize >> esz;
+    TCGv_i64 tcg_res[2], tcg_ele;
+
+    if (esz == MO_64 && !a->q) {
+        return false;
+    }
+    if (!fp_access_check(s)) {
+        return true;
+    }
+
+    tcg_res[0] = tcg_temp_new_i64();
+    tcg_res[1] = a->q ? tcg_temp_new_i64() : NULL;
+    tcg_ele = tcg_temp_new_i64();
+
+    for (int i = 0; i < elements; i++) {
+        int o, w, idx;
+
+        idx = fn(i, part, elements);
+        read_vec_element(s, tcg_ele, (idx & elements ? a->rm : a->rn),
+                         idx & (elements - 1), esz);
+
+        w = (i << (esz + 3)) / 64;
+        o = (i << (esz + 3)) % 64;
+        if (o == 0) {
+            tcg_gen_mov_i64(tcg_res[w], tcg_ele);
+        } else {
+            tcg_gen_deposit_i64(tcg_res[w], tcg_res[w], tcg_ele, o, 8 << esz);
+        }
+    }
+
+    for (int i = a->q; i >= 0; --i) {
+        write_vec_element(s, tcg_res[i], a->rd, i, MO_64);
+    }
+    clear_vec_high(s, a->q, a->rd);
+    return true;
+}
+
+static int permute_load_uzp(int i, int part, int elements)
+{
+    return 2 * i + part;
+}
+
+TRANS(UZP1, do_simd_permute, a, permute_load_uzp, 0)
+TRANS(UZP2, do_simd_permute, a, permute_load_uzp, 1)
+
+static int permute_load_trn(int i, int part, int elements)
+{
+    return (i & 1) * elements + (i & ~1) + part;
+}
+
+TRANS(TRN1, do_simd_permute, a, permute_load_trn, 0)
+TRANS(TRN2, do_simd_permute, a, permute_load_trn, 1)
+
+static int permute_load_zip(int i, int part, int elements)
+{
+    return (i & 1) * elements + ((part * elements + i) >> 1);
+}
+
+TRANS(ZIP1, do_simd_permute, a, permute_load_zip, 0)
+TRANS(ZIP2, do_simd_permute, a, permute_load_zip, 1)
+
 /*
  * Cryptographic AES, SHA, SHA512
  */
@@ -8911,95 +8979,6 @@ static void disas_data_proc_fp(DisasContext *s, uint32_t insn)
     }
 }
 
-/* ZIP/UZP/TRN
- *   31  30 29         24 23  22  21 20   16 15 14 12 11 10 9    5 4    0
- * +---+---+-------------+------+---+------+---+------------------+------+
- * | 0 | Q | 0 0 1 1 1 0 | size | 0 |  Rm  | 0 | opc | 1 0 |  Rn  |  Rd  |
- * +---+---+-------------+------+---+------+---+------------------+------+
- */
-static void disas_simd_zip_trn(DisasContext *s, uint32_t insn)
-{
-    int rd = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int rm = extract32(insn, 16, 5);
-    int size = extract32(insn, 22, 2);
-    /* opc field bits [1:0] indicate ZIP/UZP/TRN;
-     * bit 2 indicates 1 vs 2 variant of the insn.
-     */
-    int opcode = extract32(insn, 12, 2);
-    bool part = extract32(insn, 14, 1);
-    bool is_q = extract32(insn, 30, 1);
-    int esize = 8 << size;
-    int i;
-    int datasize = is_q ? 128 : 64;
-    int elements = datasize / esize;
-    TCGv_i64 tcg_res[2], tcg_ele;
-
-    if (opcode == 0 || (size == 3 && !is_q)) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    tcg_res[0] = tcg_temp_new_i64();
-    tcg_res[1] = is_q ? tcg_temp_new_i64() : NULL;
-    tcg_ele = tcg_temp_new_i64();
-
-    for (i = 0; i < elements; i++) {
-        int o, w;
-
-        switch (opcode) {
-        case 1: /* UZP1/2 */
-        {
-            int midpoint = elements / 2;
-            if (i < midpoint) {
-                read_vec_element(s, tcg_ele, rn, 2 * i + part, size);
-            } else {
-                read_vec_element(s, tcg_ele, rm,
-                                 2 * (i - midpoint) + part, size);
-            }
-            break;
-        }
-        case 2: /* TRN1/2 */
-            if (i & 1) {
-                read_vec_element(s, tcg_ele, rm, (i & ~1) + part, size);
-            } else {
-                read_vec_element(s, tcg_ele, rn, (i & ~1) + part, size);
-            }
-            break;
-        case 3: /* ZIP1/2 */
-        {
-            int base = part * elements / 2;
-            if (i & 1) {
-                read_vec_element(s, tcg_ele, rm, base + (i >> 1), size);
-            } else {
-                read_vec_element(s, tcg_ele, rn, base + (i >> 1), size);
-            }
-            break;
-        }
-        default:
-            g_assert_not_reached();
-        }
-
-        w = (i * esize) / 64;
-        o = (i * esize) % 64;
-        if (o == 0) {
-            tcg_gen_mov_i64(tcg_res[w], tcg_ele);
-        } else {
-            tcg_gen_shli_i64(tcg_ele, tcg_ele, o);
-            tcg_gen_or_i64(tcg_res[w], tcg_res[w], tcg_ele);
-        }
-    }
-
-    for (i = 0; i <= is_q; ++i) {
-        write_vec_element(s, tcg_res[i], rd, i, MO_64);
-    }
-    clear_vec_high(s, is_q, rd);
-}
-
 /*
  * do_reduction_op helper
  *
@@ -11774,7 +11753,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     /* simd_mod_imm decode is a subset of simd_shift_imm, so must precede it */
     { 0x0f000400, 0x9ff80400, disas_simd_mod_imm },
     { 0x0f000400, 0x9f800400, disas_simd_shift_imm },
-    { 0x0e000800, 0xbf208c00, disas_simd_zip_trn },
     { 0x5e200800, 0xdf3e0c00, disas_simd_scalar_two_reg_misc },
     { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
     { 0x0e780800, 0x8f7e0c00, disas_simd_two_reg_misc_fp16 },
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 45896902d5..5bd5603cd0 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1145,3 +1145,12 @@ EXT_q           0110 1110 00 0 rm:5 0  imm:4 0 rn:5 rd:5
 # Advanced SIMD Table Lookup
 
 TBL_TBX         0 q:1 00 1110 000 rm:5 0 len:2 tbx:1 00 rn:5 rd:5
+
+# Advanced SIMD Permute
+
+UZP1            0.00 1110 .. 0 ..... 0 001 10 ..... .....   @qrrr_e
+UZP2            0.00 1110 .. 0 ..... 0 101 10 ..... .....   @qrrr_e
+TRN1            0.00 1110 .. 0 ..... 0 010 10 ..... .....   @qrrr_e
+TRN2            0.00 1110 .. 0 ..... 0 110 10 ..... .....   @qrrr_e
+ZIP1            0.00 1110 .. 0 ..... 0 011 10 ..... .....   @qrrr_e
+ZIP2            0.00 1110 .. 0 ..... 0 111 10 ..... .....   @qrrr_e
-- 
2.43.0


