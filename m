Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77461C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJaA-0003v0-Bz; Mon, 01 Jul 2024 12:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZE-0000pK-KT
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:50 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ7-0005Sa-Gi
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:48 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52cdf4bc083so4731173e87.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719850059; x=1720454859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M2I7ELGzNQpMmc24W8H+5tkTCIyVn6DUcVu3sM63/1Q=;
 b=gBOowIL8WE998zAyeaZgGs0eY/49USojmQBb6uJz1ODQN6/RSj34w5uNZGYxjdsevP
 /CU1dr0jRS6ND/BvlZoGnW+xb0aXkcGVy1Ts8CJ5De0LyhipRUsvJ1wDjef3MfEH9qAF
 38bodtYs7jnz58aU27tzO0RzBfC9MUzWLTgQvnUEeMB5x0s+pvHVtJ9LrOV6OOCyDEf9
 lmUfft2wTKLAIWqGhpManaR1kEVVv3G8ThPQPXw6NZRL2VV48K+6JYwubGW8EdOq0l7j
 v/KwGXRdX3JTs4trHCdWOD7dnMyrFeiGeqfFYT8jcVa4wczTxUb1JcZr1HxjfIS0ZQyN
 dOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719850059; x=1720454859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M2I7ELGzNQpMmc24W8H+5tkTCIyVn6DUcVu3sM63/1Q=;
 b=hKXw9JqgL2ekggQECjiWgaF9caTcAC6MucxtTQQJWDibwQP9v+6JmzYPeMfaRakKgW
 MRUN6BxhEb15OVLXZRf/my9Hys/z34ClPiJ1hi86vJTCf1hdpVeMu8fCtonMZH7GkNlg
 J96abF5SmHvmhgZObXvepEZS51tZcUOuIO1fQ2AUmWGmqF/Clc1bNa9QZ2hmMo+Japap
 nD8A46G4tngnBuUF5cMNKbetVCpS0Lk+YtRXJTR8THZqAhIoZ3Kf9apYJ8mvZSlAe/CY
 h9h1WDiDA8VCQXPr8UpFfvVkT6wOAjKdJ5E25TCBLPajcDWwhmQ9UyaluWQYszgpdRYa
 taXQ==
X-Gm-Message-State: AOJu0YwXPDF5OfctCQni289hAylQpVp6cB/YWcPVXlEj4sIeNIE2nkAP
 byaOSJTferf+/88A7ehs2oueO2QyZXZd7DG18Ccf44kpM+iNS7y35frkcA9jOH/YnFtFOt8yAhy
 oFHs=
X-Google-Smtp-Source: AGHT+IG6KXzpfMA2iJC5YqUetgtgzsyv+smhrDJnnLEWNhZDxKtZOIPqPyFDZKoWvzgW6DY/8f2row==
X-Received: by 2002:a05:6512:b11:b0:52c:7f12:61d1 with SMTP id
 2adb3069b0e04-52e82643bdemr4871424e87.1.1719850059518; 
 Mon, 01 Jul 2024 09:07:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af557fesm161952135e9.11.2024.07.01.09.07.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 09:07:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/29] target/arm: Convert FCMLA to decodetree
Date: Mon,  1 Jul 2024 17:07:18 +0100
Message-Id: <20240701160729.1910763-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701160729.1910763-1-peter.maydell@linaro.org>
References: <20240701160729.1910763-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240625183536.1672454-13-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |   6 +
 target/arm/tcg/translate-a64.c | 238 ++++++++++-----------------------
 2 files changed, 74 insertions(+), 170 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index f330919851b..223eac3cac2 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -960,6 +960,8 @@ USMMLA          0100 1110 100 ..... 10101 1 ..... ..... @rrr_q1e0
 FCADD_90        0.10 1110 ..0 ..... 11100 1 ..... ..... @qrrr_e
 FCADD_270       0.10 1110 ..0 ..... 11110 1 ..... ..... @qrrr_e
 
+FCMLA_v         0 q:1 10 1110 esz:2 0 rm:5 110 rot:2 1 rn:5 rd:5
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
@@ -1041,6 +1043,10 @@ USDOT_vi        0.00 1111 10 .. .... 1111 . 0 ..... .....   @qrrx_s
 BFDOT_vi        0.00 1111 01 .. .... 1111 . 0 ..... .....   @qrrx_s
 BFMLAL_vi       0.00 1111 11 .. .... 1111 . 0 ..... .....   @qrrx_h
 
+FCMLA_vi        0 0 10 1111 01 idx:1 rm:5 0 rot:2 1 0 0 rn:5 rd:5 esz=1 q=0
+FCMLA_vi        0 1 10 1111 01 . rm:5 0 rot:2 1 . 0 rn:5 rd:5 esz=1 idx=%hl q=1
+FCMLA_vi        0 1 10 1111 10 0 rm:5 0 rot:2 1 idx:1 0 rn:5 rd:5 esz=2 q=1
+
 # Floating-point conditional select
 
 FCSEL           0001 1110 .. 1 rm:5 cond:4 11 rn:5 rd:5     esz=%esz_hsd
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index a1b338263ff..161fa2659c4 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5631,6 +5631,39 @@ static gen_helper_gvec_3_ptr * const f_vector_fcadd[3] = {
 TRANS_FEAT(FCADD_90, aa64_fcma, do_fp3_vector, a, 0, f_vector_fcadd)
 TRANS_FEAT(FCADD_270, aa64_fcma, do_fp3_vector, a, 1, f_vector_fcadd)
 
+static bool trans_FCMLA_v(DisasContext *s, arg_FCMLA_v *a)
+{
+    gen_helper_gvec_4_ptr *fn;
+
+    if (!dc_isar_feature(aa64_fcma, s)) {
+        return false;
+    }
+    switch (a->esz) {
+    case MO_64:
+        if (!a->q) {
+            return false;
+        }
+        fn = gen_helper_gvec_fcmlad;
+        break;
+    case MO_32:
+        fn = gen_helper_gvec_fcmlas;
+        break;
+    case MO_16:
+        if (!dc_isar_feature(aa64_fp16, s)) {
+            return false;
+        }
+        fn = gen_helper_gvec_fcmlah;
+        break;
+    default:
+        return false;
+    }
+    if (fp_access_check(s)) {
+        gen_gvec_op4_fpst(s, a->q, a->rd, a->rn, a->rm, a->rd,
+                          a->esz == MO_16, a->rot, fn);
+    }
+    return true;
+}
+
 /*
  * Advanced SIMD scalar/vector x indexed element
  */
@@ -5985,6 +6018,33 @@ static bool trans_BFMLAL_vi(DisasContext *s, arg_qrrx_e *a)
     return true;
 }
 
+static bool trans_FCMLA_vi(DisasContext *s, arg_FCMLA_vi *a)
+{
+    gen_helper_gvec_4_ptr *fn;
+
+    if (!dc_isar_feature(aa64_fcma, s)) {
+        return false;
+    }
+    switch (a->esz) {
+    case MO_16:
+        if (!dc_isar_feature(aa64_fp16, s)) {
+            return false;
+        }
+        fn = gen_helper_gvec_fcmlah_idx;
+        break;
+    case MO_32:
+        fn = gen_helper_gvec_fcmlas_idx;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    if (fp_access_check(s)) {
+        gen_gvec_op4_fpst(s, a->q, a->rd, a->rn, a->rm, a->rd,
+                          a->esz == MO_16, (a->idx << 2) | a->rot, fn);
+    }
+    return true;
+}
+
 /*
  * Advanced SIMD scalar pairwise
  */
@@ -10942,90 +11002,6 @@ static void disas_simd_three_reg_diff(DisasContext *s, uint32_t insn)
     }
 }
 
-/* AdvSIMD three same extra
- *  31   30  29 28       24 23  22  21 20  16  15 14    11  10 9  5 4  0
- * +---+---+---+-----------+------+---+------+---+--------+---+----+----+
- * | 0 | Q | U | 0 1 1 1 0 | size | 0 |  Rm  | 1 | opcode | 1 | Rn | Rd |
- * +---+---+---+-----------+------+---+------+---+--------+---+----+----+
- */
-static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
-{
-    int rd = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int opcode = extract32(insn, 11, 4);
-    int rm = extract32(insn, 16, 5);
-    int size = extract32(insn, 22, 2);
-    bool u = extract32(insn, 29, 1);
-    bool is_q = extract32(insn, 30, 1);
-    bool feature;
-    int rot;
-
-    switch (u * 16 + opcode) {
-    case 0x18: /* FCMLA, #0 */
-    case 0x19: /* FCMLA, #90 */
-    case 0x1a: /* FCMLA, #180 */
-    case 0x1b: /* FCMLA, #270 */
-        if (size == 0
-            || (size == 1 && !dc_isar_feature(aa64_fp16, s))
-            || (size == 3 && !is_q)) {
-            unallocated_encoding(s);
-            return;
-        }
-        feature = dc_isar_feature(aa64_fcma, s);
-        break;
-    default:
-    case 0x02: /* SDOT (vector) */
-    case 0x03: /* USDOT */
-    case 0x04: /* SMMLA */
-    case 0x05: /* USMMLA */
-    case 0x10: /* SQRDMLAH (vector) */
-    case 0x11: /* SQRDMLSH (vector) */
-    case 0x12: /* UDOT (vector) */
-    case 0x14: /* UMMLA */
-    case 0x1c: /* FCADD, #90 */
-    case 0x1d: /* BFMMLA */
-    case 0x1e: /* FCADD, #270 */
-    case 0x1f: /* BFDOT / BFMLAL */
-        unallocated_encoding(s);
-        return;
-    }
-    if (!feature) {
-        unallocated_encoding(s);
-        return;
-    }
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    switch (opcode) {
-    case 0x8: /* FCMLA, #0 */
-    case 0x9: /* FCMLA, #90 */
-    case 0xa: /* FCMLA, #180 */
-    case 0xb: /* FCMLA, #270 */
-        rot = extract32(opcode, 0, 2);
-        switch (size) {
-        case 1:
-            gen_gvec_op4_fpst(s, is_q, rd, rn, rm, rd, true, rot,
-                              gen_helper_gvec_fcmlah);
-            break;
-        case 2:
-            gen_gvec_op4_fpst(s, is_q, rd, rn, rm, rd, false, rot,
-                              gen_helper_gvec_fcmlas);
-            break;
-        case 3:
-            gen_gvec_op4_fpst(s, is_q, rd, rn, rm, rd, false, rot,
-                              gen_helper_gvec_fcmlad);
-            break;
-        default:
-            g_assert_not_reached();
-        }
-        return;
-
-    default:
-        g_assert_not_reached();
-    }
-}
-
 static void handle_2misc_widening(DisasContext *s, int opcode, bool is_q,
                                   int size, int rn, int rd)
 {
@@ -12001,10 +11977,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
     bool is_long = false;
-    int is_fp = 0;
-    bool is_fp16 = false;
     int index;
-    TCGv_ptr fpst;
 
     switch (16 * u + opcode) {
     case 0x02: /* SMLAL, SMLAL2 */
@@ -12024,16 +11997,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     case 0x0b: /* SQDMULL, SQDMULL2 */
         is_long = true;
         break;
-    case 0x11: /* FCMLA #0 */
-    case 0x13: /* FCMLA #90 */
-    case 0x15: /* FCMLA #180 */
-    case 0x17: /* FCMLA #270 */
-        if (is_scalar || !dc_isar_feature(aa64_fcma, s)) {
-            unallocated_encoding(s);
-            return;
-        }
-        is_fp = 2;
-        break;
     default:
     case 0x00: /* FMLAL */
     case 0x01: /* FMLA */
@@ -12046,7 +12009,11 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     case 0x0e: /* SDOT */
     case 0x0f: /* SUDOT / BFDOT / USDOT / BFMLAL */
     case 0x10: /* MLA */
+    case 0x11: /* FCMLA #0 */
+    case 0x13: /* FCMLA #90 */
     case 0x14: /* MLS */
+    case 0x15: /* FCMLA #180 */
+    case 0x17: /* FCMLA #270 */
     case 0x18: /* FMLAL2 */
     case 0x19: /* FMULX */
     case 0x1c: /* FMLSL2 */
@@ -12057,46 +12024,12 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
         return;
     }
 
-    switch (is_fp) {
-    case 1: /* normal fp */
-        unallocated_encoding(s); /* in decodetree */
-        return;
-
-    case 2: /* complex fp */
-        /* Each indexable element is a complex pair.  */
-        size += 1;
-        switch (size) {
-        case MO_32:
-            if (h && !is_q) {
-                unallocated_encoding(s);
-                return;
-            }
-            is_fp16 = true;
-            break;
-        case MO_64:
-            break;
-        default:
-            unallocated_encoding(s);
-            return;
-        }
-        break;
-
-    default: /* integer */
-        switch (size) {
-        case MO_8:
-        case MO_64:
-            unallocated_encoding(s);
-            return;
-        }
-        break;
-    }
-    if (is_fp16 && !dc_isar_feature(aa64_fp16, s)) {
-        unallocated_encoding(s);
-        return;
-    }
-
     /* Given MemOp size, adjust register and indexing.  */
     switch (size) {
+    case MO_8:
+    case MO_64:
+        unallocated_encoding(s);
+        return;
     case MO_16:
         index = h << 2 | l << 1 | m;
         break;
@@ -12104,14 +12037,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
         index = h << 1 | l;
         rm |= m << 4;
         break;
-    case MO_64:
-        if (l || !is_q) {
-            unallocated_encoding(s);
-            return;
-        }
-        index = h;
-        rm |= m << 4;
-        break;
     default:
         g_assert_not_reached();
     }
@@ -12120,32 +12045,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
         return;
     }
 
-    if (is_fp) {
-        fpst = fpstatus_ptr(is_fp16 ? FPST_FPCR_F16 : FPST_FPCR);
-    } else {
-        fpst = NULL;
-    }
-
-    switch (16 * u + opcode) {
-    case 0x11: /* FCMLA #0 */
-    case 0x13: /* FCMLA #90 */
-    case 0x15: /* FCMLA #180 */
-    case 0x17: /* FCMLA #270 */
-        {
-            int rot = extract32(insn, 13, 2);
-            int data = (index << 2) | rot;
-            tcg_gen_gvec_4_ptr(vec_full_reg_offset(s, rd),
-                               vec_full_reg_offset(s, rn),
-                               vec_full_reg_offset(s, rm),
-                               vec_full_reg_offset(s, rd), fpst,
-                               is_q ? 16 : 8, vec_full_reg_size(s), data,
-                               size == MO_64
-                               ? gen_helper_gvec_fcmlas_idx
-                               : gen_helper_gvec_fcmlah_idx);
-        }
-        return;
-    }
-
     if (size == 3) {
         g_assert_not_reached();
     } else if (!is_long) {
@@ -12407,7 +12306,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
  */
 static const AArch64DecodeTable data_proc_simd[] = {
     /* pattern  ,  mask     ,  fn                        */
-    { 0x0e008400, 0x9f208400, disas_simd_three_reg_same_extra },
     { 0x0e200000, 0x9f200c00, disas_simd_three_reg_diff },
     { 0x0e200800, 0x9f3e0c00, disas_simd_two_reg_misc },
     { 0x0e300800, 0x9f3e0c00, disas_simd_across_lanes },
-- 
2.34.1


