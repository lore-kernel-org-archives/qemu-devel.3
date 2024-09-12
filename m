Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12387EE6421
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 02:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soZm2-00039r-1n; Wed, 11 Sep 2024 22:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soZlt-0002ZM-A7
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:41:25 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soZlr-00048i-H8
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:41:25 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-201d5af11a4so5816825ad.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 19:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726108882; x=1726713682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bjTWmYibNX9ocSHJzCOY3s0qFLQcqbQGzAuMMbaGtYs=;
 b=yNjtlxVd2Sj0j+JG49DI4PFfJxhkQUg3nzHuIKac0YUwF6nwNJpDTz157Eoma5GRca
 OsjG+c/3nqzovfSlw05f9vx/xJrJeR6qZQe5XiniLGxaz5nQ1jsMNSgaO1a5sK5Ev1kU
 B9IKDLTWWCuevpa+dZS56BG5cMjl9xIJepKHrcgKPqa1xbSnWu/p1E8iV445lNS4B6CF
 6GvK4Tp/SXbcYmJ5aBGABm5/09BtgmFIHxHJMBF0To0qgHb2SZAMfEBt95SbXWWNlXRh
 vKfeT/oXuAoDbn033A0i9KkB5qH3UYoNYZxF4SkbzwKjgVmkNqfc4XT62Bhy/LxA3GLj
 TL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726108882; x=1726713682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bjTWmYibNX9ocSHJzCOY3s0qFLQcqbQGzAuMMbaGtYs=;
 b=sVqEDD1NrPVp60eI7lopfJNYVPYEhNVeWKkJFfc8rrUJ3lJ0ER3c9sfpvRyucMkKG+
 aGdAgVYF9eGP4jgfnRpoDyUXfkzPAnkWe2RlDIP9WwrAhbC1S62ruGLc99m1vH00ksVv
 tfXWauCTLYrF7lD5blLW3i+9Vw9+xV6OGAbe7WAJLairvjfX0vTyfWou+nT+U/ckrhdJ
 XechKvAl1G7SqGXA3RaZFHljD2FZ+PtNHoimSo1ilHUtzHcto1QaQsVTVfLG6assc0mP
 w6xqrDlP5rbIY38fy63YZpjnhdjgKXBQOYdNpl9LNmqIOH2fj2qbzlyt00+ueBy6rtDP
 3aeA==
X-Gm-Message-State: AOJu0Yx4qpTzdJcGrDyj2ANOhoXWYVGCzmtK4JzsUIMGChpaNMDtlN2O
 /WipizF9fwRkktZP7RL5EOxbhL/MAi258itvf7YAnUAbN7morBIqtDRnc+WTiSYuiiHwdCjjbwQ
 2
X-Google-Smtp-Source: AGHT+IFfHuXgJEcxm9IaT85NJDNuL7JIf2e8+2XP9DJ3fDqSqlgx6NLQB64dZ3Eua+fKFUiMrLrMEw==
X-Received: by 2002:a17:903:230e:b0:206:cfb3:7232 with SMTP id
 d9443c01a7336-2076e3f3ae4mr22978005ad.48.1726108882166; 
 Wed, 11 Sep 2024 19:41:22 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2076afe9c61sm5635915ad.231.2024.09.11.19.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 19:41:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 06/29] target/arm: Convert EXT to decodetree
Date: Wed, 11 Sep 2024 19:40:51 -0700
Message-ID: <20240912024114.1097832-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240912024114.1097832-1-richard.henderson@linaro.org>
References: <20240912024114.1097832-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 121 +++++++++++++--------------------
 target/arm/tcg/a64.decode      |   5 ++
 2 files changed, 53 insertions(+), 73 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1a0b2bb33b..48188d4116 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6582,6 +6582,54 @@ static bool trans_FCSEL(DisasContext *s, arg_FCSEL *a)
     return true;
 }
 
+/*
+ * Advanced SIMD Extract
+ */
+
+static bool trans_EXT_d(DisasContext *s, arg_EXT_d *a)
+{
+    if (fp_access_check(s)) {
+        TCGv_i64 lo = read_fp_dreg(s, a->rn);
+        if (a->imm != 0) {
+            TCGv_i64 hi = read_fp_dreg(s, a->rm);
+            tcg_gen_extract2_i64(lo, lo, hi, a->imm * 8);
+        }
+        write_fp_dreg(s, a->rd, lo);
+    }
+    return true;
+}
+
+static bool trans_EXT_q(DisasContext *s, arg_EXT_q *a)
+{
+    TCGv_i64 lo, hi;
+    int pos = (a->imm & 7) * 8;
+    int elt = a->imm >> 3;
+
+    if (!fp_access_check(s)) {
+        return true;
+    }
+
+    lo = tcg_temp_new_i64();
+    hi = tcg_temp_new_i64();
+
+    read_vec_element(s, lo, a->rn, elt, MO_64);
+    elt++;
+    read_vec_element(s, hi, elt & 2 ? a->rm : a->rn, elt & 1, MO_64);
+    elt++;
+
+    if (pos != 0) {
+        TCGv_i64 hh = tcg_temp_new_i64();
+        tcg_gen_extract2_i64(lo, lo, hi, pos);
+        read_vec_element(s, hh, a->rm, elt & 1, MO_64);
+        tcg_gen_extract2_i64(hi, hi, hh, pos);
+    }
+
+    write_vec_element(s, lo, a->rd, 0, MO_64);
+    write_vec_element(s, hi, a->rd, 1, MO_64);
+    clear_vec_high(s, true, a->rd);
+    return true;
+}
+
 /*
  * Floating-point data-processing (3 source)
  */
@@ -8890,78 +8938,6 @@ static void disas_data_proc_fp(DisasContext *s, uint32_t insn)
     }
 }
 
-/* EXT
- *   31  30 29         24 23 22  21 20  16 15  14  11 10  9    5 4    0
- * +---+---+-------------+-----+---+------+---+------+---+------+------+
- * | 0 | Q | 1 0 1 1 1 0 | op2 | 0 |  Rm  | 0 | imm4 | 0 |  Rn  |  Rd  |
- * +---+---+-------------+-----+---+------+---+------+---+------+------+
- */
-static void disas_simd_ext(DisasContext *s, uint32_t insn)
-{
-    int is_q = extract32(insn, 30, 1);
-    int op2 = extract32(insn, 22, 2);
-    int imm4 = extract32(insn, 11, 4);
-    int rm = extract32(insn, 16, 5);
-    int rn = extract32(insn, 5, 5);
-    int rd = extract32(insn, 0, 5);
-    int pos = imm4 << 3;
-    TCGv_i64 tcg_resl, tcg_resh;
-
-    if (op2 != 0 || (!is_q && extract32(imm4, 3, 1))) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    tcg_resh = tcg_temp_new_i64();
-    tcg_resl = tcg_temp_new_i64();
-
-    /* Vd gets bits starting at pos bits into Vm:Vn. This is
-     * either extracting 128 bits from a 128:128 concatenation, or
-     * extracting 64 bits from a 64:64 concatenation.
-     */
-    if (!is_q) {
-        read_vec_element(s, tcg_resl, rn, 0, MO_64);
-        if (pos != 0) {
-            read_vec_element(s, tcg_resh, rm, 0, MO_64);
-            tcg_gen_extract2_i64(tcg_resl, tcg_resl, tcg_resh, pos);
-        }
-    } else {
-        TCGv_i64 tcg_hh;
-        typedef struct {
-            int reg;
-            int elt;
-        } EltPosns;
-        EltPosns eltposns[] = { {rn, 0}, {rn, 1}, {rm, 0}, {rm, 1} };
-        EltPosns *elt = eltposns;
-
-        if (pos >= 64) {
-            elt++;
-            pos -= 64;
-        }
-
-        read_vec_element(s, tcg_resl, elt->reg, elt->elt, MO_64);
-        elt++;
-        read_vec_element(s, tcg_resh, elt->reg, elt->elt, MO_64);
-        elt++;
-        if (pos != 0) {
-            tcg_gen_extract2_i64(tcg_resl, tcg_resl, tcg_resh, pos);
-            tcg_hh = tcg_temp_new_i64();
-            read_vec_element(s, tcg_hh, elt->reg, elt->elt, MO_64);
-            tcg_gen_extract2_i64(tcg_resh, tcg_resh, tcg_hh, pos);
-        }
-    }
-
-    write_vec_element(s, tcg_resl, rd, 0, MO_64);
-    if (is_q) {
-        write_vec_element(s, tcg_resh, rd, 1, MO_64);
-    }
-    clear_vec_high(s, is_q, rd);
-}
-
 /* TBL/TBX
  *   31  30 29         24 23 22  21 20  16 15  14 13  12  11 10 9    5 4    0
  * +---+---+-------------+-----+---+------+---+-----+----+-----+------+------+
@@ -11860,7 +11836,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x0f000400, 0x9f800400, disas_simd_shift_imm },
     { 0x0e000000, 0xbf208c00, disas_simd_tb },
     { 0x0e000800, 0xbf208c00, disas_simd_zip_trn },
-    { 0x2e000000, 0xbf208400, disas_simd_ext },
     { 0x5e200800, 0xdf3e0c00, disas_simd_scalar_two_reg_misc },
     { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
     { 0x0e780800, 0x8f7e0c00, disas_simd_two_reg_misc_fp16 },
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 62df4c4ceb..f72f95865f 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1136,3 +1136,8 @@ FMADD           0001 1111 .. 0 ..... 0 ..... ..... .....    @rrrr_hsd
 FMSUB           0001 1111 .. 0 ..... 1 ..... ..... .....    @rrrr_hsd
 FNMADD          0001 1111 .. 1 ..... 0 ..... ..... .....    @rrrr_hsd
 FNMSUB          0001 1111 .. 1 ..... 1 ..... ..... .....    @rrrr_hsd
+
+# Advanced SIMD Extract
+
+EXT_d           0010 1110 00 0 rm:5 00 imm:3 0 rn:5 rd:5
+EXT_q           0110 1110 00 0 rm:5 0  imm:4 0 rn:5 rd:5
-- 
2.43.0


