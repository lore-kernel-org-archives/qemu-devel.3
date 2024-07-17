Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8C5C3DA60
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 06:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTxr4-0004AY-0c; Wed, 17 Jul 2024 02:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxqp-0003ec-DN
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:09:20 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxqn-00030J-GM
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:09:19 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3d92d1a5222so3818868b6e.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 23:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721196556; x=1721801356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f2RBO2LUzalMayDyUmUonTOmlQcuZjzRHo/lvECYNRo=;
 b=vWtC2H25NXyYECW+9mQtMomdlMIfNIsnNRxSNn3UNFrb8CQ+bWy0H7DqRNJBLbrW3I
 GQFPzFN3P2Nc+a7r/tbHJWVWhdW7sj2dNKGdo7qyg+nLd96jNYKN+UT2vGBnbMuKnMkU
 vPf8s/cTZhHploHIvm3OAr8wkOhyhm8oD19pxS/mCAFgKPJa21oo9dzCAAOQnAF5L5wm
 Ksw3/uGNcuQHto8GUW5Rxme04GwPMS3ESTmZXJjnzZi+gqRUDT9mLX9lsfmU+po5wUso
 uF4edj7BQSokc06jl9/OfeYB/Pcc84CI/+upTG2zyPaOtk/IPi7smB1z6adAgOQ1ebgW
 8gew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721196556; x=1721801356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f2RBO2LUzalMayDyUmUonTOmlQcuZjzRHo/lvECYNRo=;
 b=D6MLVqWXEz9lusKhW4LSD+OM9/bK8eEvG2n7borPzekXEhdUzskGoZeT9tsZTqhJDa
 jr634xf4Imp4hA79YoQd9az1eSxlRwv3lzfwlLq+MzkfRwrZ6Ot8xTVjT6tOBMzEx3ZE
 KO8PCsLm5Rdf94bDReZ6Cha0WkZuqwHvhSgDvJms3v8frqmlayURFoq6hjC8TrCtPZVk
 DF76Yj6Aa490BPGPQ+MuDRCot+Zr46nRihaAUZ6ove9AFM/yZbmwgQMC5bUYjOEI7/8h
 0/K8A4A9nb3/0OM9xqI2Nr3gV1Vdln2t3WQ8arFO4dSfVjsMZTdhllqQSlLLeYhYMEEy
 ARGw==
X-Gm-Message-State: AOJu0Yz34lTN73GXki94U3lmg0aW92ay+Vuk9gC8hZbFfHH4wSeXQHBZ
 DFExJdj8Gl9Br8tpSuXDEgjIZQf9juLFXWwF1TS7BZoQCZYG8ATFTDgQI/5FYAhtqYNKnUSKDTD
 If8k=
X-Google-Smtp-Source: AGHT+IErn86g8LvF0rU3MJBgaqD9phV1VMJgjdNToPQyboie7pkup7VciXN52y7llZs7uJDO5rqhCA==
X-Received: by 2002:a05:6808:1509:b0:3d9:e1d1:1580 with SMTP id
 5614622812f47-3dad1f494a2mr825077b6e.21.1721196556031; 
 Tue, 16 Jul 2024 23:09:16 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7ecd603bsm7330404b3a.219.2024.07.16.23.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 23:09:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 02/17] target/arm: Convert EXT to decodetree
Date: Wed, 17 Jul 2024 16:08:48 +1000
Message-ID: <20240717060903.205098-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717060903.205098-1-richard.henderson@linaro.org>
References: <20240717060903.205098-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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
 target/arm/tcg/translate-a64.c | 121 +++++++++++++--------------------
 target/arm/tcg/a64.decode      |   5 ++
 2 files changed, 53 insertions(+), 73 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index e4c8a20f39..6ca24d9842 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6541,6 +6541,54 @@ static bool trans_FCSEL(DisasContext *s, arg_FCSEL *a)
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
@@ -8849,78 +8897,6 @@ static void disas_data_proc_fp(DisasContext *s, uint32_t insn)
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
@@ -11818,7 +11794,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x0f000400, 0x9f800400, disas_simd_shift_imm },
     { 0x0e000000, 0xbf208c00, disas_simd_tb },
     { 0x0e000800, 0xbf208c00, disas_simd_zip_trn },
-    { 0x2e000000, 0xbf208400, disas_simd_ext },
     { 0x5e200800, 0xdf3e0c00, disas_simd_scalar_two_reg_misc },
     { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
     { 0x0e780800, 0x8f7e0c00, disas_simd_two_reg_misc_fp16 },
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 2922de700c..05927fade6 100644
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


