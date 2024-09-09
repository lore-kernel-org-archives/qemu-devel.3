Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43904ECE584
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 16:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snhAD-0002S7-OF; Mon, 09 Sep 2024 12:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snhAB-0002IU-Fm
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:22:51 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snhA9-0007h6-J0
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:22:51 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-205659dc63aso44146855ad.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 09:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725898968; x=1726503768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TxUalOXw9n+uC96rS0q/9moXfxvPKQHG/XFL6uhEm9M=;
 b=JXWOPddfnpxGR7zbd5PfeNtlIm66XFYyi9TpHygdL6WbsPMyFBjkkcZtAqAoPkYAEl
 nwxPaOx8bfrWmFjgwZ11KY5caHuGyjTyOTOSyr18XbDkYAr9cjN56bY/iqtbfsCPlR0Q
 hq6+6TWawxxm7UWwBH0CXdRJozZlOkhs9RPJXXrGKMxHw34x8IGXDE3aRzCwVF9RM7Y7
 jSnSummd+gA2krilK05e7W2EDx3poiKZWXlOZoTA++Ezxv9IvGl0v7hYNDAOFwGQqnZ/
 Fv1mZ4zGuMfz5RCB00jTzHuWFdq4P8bg3A/hLzEdtTe3z8Ub9/psJM+bnUAGdPV70FWF
 XLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725898968; x=1726503768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TxUalOXw9n+uC96rS0q/9moXfxvPKQHG/XFL6uhEm9M=;
 b=ptkXfPQERIKGTQ/9mvZdjGx6daP8hhhKaNB340uV7umrE3nDhwr8lb203t1csaGoMR
 nALfCCcUX5CG5kIuqKAbKPOTi/9sKkVE394nwhHkQpeq/qxj8w0ktU22//3XRjcAK36A
 LAKHUKIehtR1dhxi4ds9f3arAZEnGw4p2xFv+uKrZ1REB6KjYjGcWUqHmgXt9BeYKfLy
 gslw281FliH6s3DRl5x3h6omgMnMxde+hN7ULaUZQfpV36xlBEj9C7b8ty8zOZjNkKCo
 ERsErYXzQOOV2C6H+bY7q8zAU4LKiEoTRmsvlpSZahuV70TFmYJTitpb4AVx0QUma9qm
 csbQ==
X-Gm-Message-State: AOJu0YxPpPIHBrUhZeR0LdjcipmyiCpHNCkEM74GBgg9B9MY5LfC7O26
 tuidbfDNHfyhHcf/25J0mokGsPpQEiX2qcyFFTWlQPWlTSh5pQ6g3PFFoJFjbYNVMGxUNrf0HpM
 W
X-Google-Smtp-Source: AGHT+IGeJOu6lbozByqNe1yCaWSsxL6A3Jc/FYowYb7ByJRJnUqQxAGuC0QVNQWbR8ckDhCkrDsqlA==
X-Received: by 2002:a17:902:e550:b0:1fc:57b7:995c with SMTP id
 d9443c01a7336-206f04c7693mr156354215ad.7.1725898967924; 
 Mon, 09 Sep 2024 09:22:47 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f35d79sm35753305ad.288.2024.09.09.09.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 09:22:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 06/29] target/arm: Convert EXT to decodetree
Date: Mon,  9 Sep 2024 09:22:16 -0700
Message-ID: <20240909162240.647173-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909162240.647173-1-richard.henderson@linaro.org>
References: <20240909162240.647173-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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


