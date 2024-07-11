Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0607C3DA51
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRthV-0002dD-TI; Thu, 11 Jul 2024 09:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRthD-0001Yj-VZ
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:52 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRth7-00064m-8C
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:51 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2ebe40673d8so12000171fa.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 06:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720703916; x=1721308716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tqdDrlmw8C2RlxaE/satCpNOmycqgA8KmAH5fL1XR4w=;
 b=YRE/lZYPx61KKxr763SCp2SkH+yRekvATff5DE4SGnA8X4L0nZvKOqpYQr8vgC19ET
 sZYjV/zctirvb+oGA3px8cyhBxBmftosvZFZchOc5ZJo8dVcwHH24ZwntyWykWsAMqrz
 mOEZJHSf8ukHN+nkv4Z51nJ2kb2I29KO9kcXvKgtVFmnCxLJlU+jCsxp/0T4dD5kUF0l
 OatquDvo9brAmMMijFjjCSvoxLwpUg5u/7cjMNbctOgzR5+ZLUKt+EBLSCai1MUHn2uM
 Tfhptu08mbDfsKdJ9aVKwtAh5vWjdbAt03GF6ccs2feWeBrxIbL2TtqWrIXJPDkqqEGX
 pxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720703916; x=1721308716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tqdDrlmw8C2RlxaE/satCpNOmycqgA8KmAH5fL1XR4w=;
 b=KbZS6SCPH4tN25UlKAUBMmsVmRW3lvw/5+WAKC/s1g9z1mTtW2wYrdxVM4NhTYXUZ1
 ntU47ZCGcUWNgx6dP1J0cgFNge0RMgByWZIjfeDhqEduWtc3U9nwDnOlRe4HVI5phvwx
 oIIliSiev2wiA7BcHZ1vh+DAwLoeBT1Hp1WkgiW/ZFUZAuT0EIdkVrX5I8oFXz5+k5vJ
 99IOqAeEyYWregu0MhmttraSx2PcXiNkF/P6lckty83pgMV9coMkL+yJfomqjH21xbYq
 WnsxxcpJzmw5FpW4dJVTOIlVHYa55Bw0T5cMirN1M4NsLXR25tn1qrnnDRoHWPgNjHwt
 I1HQ==
X-Gm-Message-State: AOJu0YxgDvY6WtGO8mGzBCxJRK/00wu1vccEofwhtdpcyZ2YIBQVjhtv
 mxjo38UrDlflDSTcRZxnXKRxuB56UPyRzJA5faXBvVum2al9UFMHmDDyrirZYi19R5PJrYPTF5C
 Cay4=
X-Google-Smtp-Source: AGHT+IH1UFRGSb8G1qRjiiVT0fnK/LfuuY4kHEQCT3+ofAGM1Y/CNCE04rOiCKJrz61t9AnSXwukOA==
X-Received: by 2002:a2e:b052:0:b0:2ee:8bc6:6817 with SMTP id
 38308e7fff4ca-2eeb30e511emr56562921fa.16.1720703916266; 
 Thu, 11 Jul 2024 06:18:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f736939sm119412025e9.37.2024.07.11.06.18.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 06:18:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/24] target/arm: Convert ADDHN, SUBHN, RADDHN,
 RSUBHN to decodetree
Date: Thu, 11 Jul 2024 14:18:21 +0100
Message-Id: <20240711131822.3909903-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711131822.3909903-1-peter.maydell@linaro.org>
References: <20240711131822.3909903-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240709000610.382391-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |   5 ++
 target/arm/tcg/translate-a64.c | 127 +++++++++++++++------------------
 2 files changed, 61 insertions(+), 71 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 32e2f3a0d55..afb34a8fd43 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -998,6 +998,11 @@ UADDW           0.10 1110 ..1 ..... 00010 0 ..... ..... @qrrr_e
 SSUBW           0.00 1110 ..1 ..... 00110 0 ..... ..... @qrrr_e
 USUBW           0.10 1110 ..1 ..... 00110 0 ..... ..... @qrrr_e
 
+ADDHN           0.00 1110 ..1 ..... 01000 0 ..... ..... @qrrr_e
+RADDHN          0.10 1110 ..1 ..... 01000 0 ..... ..... @qrrr_e
+SUBHN           0.00 1110 ..1 ..... 01100 0 ..... ..... @qrrr_e
+RSUBHN          0.10 1110 ..1 ..... 01100 0 ..... ..... @qrrr_e
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 264d2eeb27d..3e0dacdd63c 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5949,6 +5949,60 @@ TRANS(UADDW, do_addsub_wide, a, 0, false)
 TRANS(SSUBW, do_addsub_wide, a, MO_SIGN, true)
 TRANS(USUBW, do_addsub_wide, a, 0, true)
 
+static bool do_addsub_highnarrow(DisasContext *s, arg_qrrr_e *a,
+                                 bool sub, bool round)
+{
+    TCGv_i64 tcg_op0, tcg_op1;
+    MemOp esz = a->esz;
+    int half = 8 >> esz;
+    bool top = a->q;
+    int ebits = 8 << esz;
+    uint64_t rbit = 1ull << (ebits - 1);
+    int top_swap, top_half;
+
+    /* There are no 128x128->64 bit operations. */
+    if (esz >= MO_64) {
+        return false;
+    }
+    if (!fp_access_check(s)) {
+        return true;
+    }
+    tcg_op0 = tcg_temp_new_i64();
+    tcg_op1 = tcg_temp_new_i64();
+
+    /*
+     * For top half inputs, iterate backward; forward for bottom half.
+     * This means the store to the destination will not occur until
+     * overlapping input inputs are consumed.
+     */
+    top_swap = top ? half - 1 : 0;
+    top_half = top ? half : 0;
+
+    for (int elt_fwd = 0; elt_fwd < half; ++elt_fwd) {
+        int elt = elt_fwd ^ top_swap;
+
+        read_vec_element(s, tcg_op1, a->rm, elt, esz + 1);
+        read_vec_element(s, tcg_op0, a->rn, elt, esz + 1);
+        if (sub) {
+            tcg_gen_sub_i64(tcg_op0, tcg_op0, tcg_op1);
+        } else {
+            tcg_gen_add_i64(tcg_op0, tcg_op0, tcg_op1);
+        }
+        if (round) {
+            tcg_gen_addi_i64(tcg_op0, tcg_op0, rbit);
+        }
+        tcg_gen_shri_i64(tcg_op0, tcg_op0, ebits);
+        write_vec_element(s, tcg_op0, a->rd, elt + top_half, esz);
+    }
+    clear_vec_high(s, top, a->rd);
+    return true;
+}
+
+TRANS(ADDHN, do_addsub_highnarrow, a, false, false)
+TRANS(SUBHN, do_addsub_highnarrow, a, true, false)
+TRANS(RADDHN, do_addsub_highnarrow, a, false, true)
+TRANS(RSUBHN, do_addsub_highnarrow, a, true, true)
+
 /*
  * Advanced SIMD scalar/vector x indexed element
  */
@@ -10813,65 +10867,6 @@ static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Generate code to do a "long" addition or subtraction, ie one done in
- * TCGv_i64 on vector lanes twice the width specified by size.
- */
-static void gen_neon_addl(int size, bool is_sub, TCGv_i64 tcg_res,
-                          TCGv_i64 tcg_op1, TCGv_i64 tcg_op2)
-{
-    static NeonGenTwo64OpFn * const fns[3][2] = {
-        { gen_helper_neon_addl_u16, gen_helper_neon_subl_u16 },
-        { gen_helper_neon_addl_u32, gen_helper_neon_subl_u32 },
-        { tcg_gen_add_i64, tcg_gen_sub_i64 },
-    };
-    NeonGenTwo64OpFn *genfn;
-    assert(size < 3);
-
-    genfn = fns[size][is_sub];
-    genfn(tcg_res, tcg_op1, tcg_op2);
-}
-
-static void do_narrow_round_high_u32(TCGv_i32 res, TCGv_i64 in)
-{
-    tcg_gen_addi_i64(in, in, 1U << 31);
-    tcg_gen_extrh_i64_i32(res, in);
-}
-
-static void handle_3rd_narrowing(DisasContext *s, int is_q, int is_u, int size,
-                                 int opcode, int rd, int rn, int rm)
-{
-    TCGv_i32 tcg_res[2];
-    int part = is_q ? 2 : 0;
-    int pass;
-
-    for (pass = 0; pass < 2; pass++) {
-        TCGv_i64 tcg_op1 = tcg_temp_new_i64();
-        TCGv_i64 tcg_op2 = tcg_temp_new_i64();
-        TCGv_i64 tcg_wideres = tcg_temp_new_i64();
-        static NeonGenNarrowFn * const narrowfns[3][2] = {
-            { gen_helper_neon_narrow_high_u8,
-              gen_helper_neon_narrow_round_high_u8 },
-            { gen_helper_neon_narrow_high_u16,
-              gen_helper_neon_narrow_round_high_u16 },
-            { tcg_gen_extrh_i64_i32, do_narrow_round_high_u32 },
-        };
-        NeonGenNarrowFn *gennarrow = narrowfns[size][is_u];
-
-        read_vec_element(s, tcg_op1, rn, pass, MO_64);
-        read_vec_element(s, tcg_op2, rm, pass, MO_64);
-
-        gen_neon_addl(size, (opcode == 6), tcg_wideres, tcg_op1, tcg_op2);
-
-        tcg_res[pass] = tcg_temp_new_i32();
-        gennarrow(tcg_res[pass], tcg_wideres);
-    }
-
-    for (pass = 0; pass < 2; pass++) {
-        write_vec_element_i32(s, tcg_res[pass], rd, pass + part, MO_32);
-    }
-    clear_vec_high(s, is_q, rd);
-}
-
 /* AdvSIMD three different
  *   31  30  29 28       24 23  22  21 20  16 15    12 11 10 9    5 4    0
  * +---+---+---+-----------+------+---+------+--------+-----+------+------+
@@ -10899,18 +10894,6 @@ static void disas_simd_three_reg_diff(DisasContext *s, uint32_t insn)
     int rd = extract32(insn, 0, 5);
 
     switch (opcode) {
-    case 4: /* ADDHN, ADDHN2, RADDHN, RADDHN2 */
-    case 6: /* SUBHN, SUBHN2, RSUBHN, RSUBHN2 */
-        /* 128 x 128 -> 64 */
-        if (size == 3) {
-            unallocated_encoding(s);
-            return;
-        }
-        if (!fp_access_check(s)) {
-            return;
-        }
-        handle_3rd_narrowing(s, is_q, is_u, size, opcode, rd, rn, rm);
-        break;
     case 14: /* PMULL, PMULL2 */
         if (is_u) {
             unallocated_encoding(s);
@@ -10949,7 +10932,9 @@ static void disas_simd_three_reg_diff(DisasContext *s, uint32_t insn)
     case 1: /* SADDW, SADDW2, UADDW, UADDW2 */
     case 2: /* SSUBL, SSUBL2, USUBL, USUBL2 */
     case 3: /* SSUBW, SSUBW2, USUBW, USUBW2 */
+    case 4: /* ADDHN, ADDHN2, RADDHN, RADDHN2 */
     case 5: /* SABAL, SABAL2, UABAL, UABAL2 */
+    case 6: /* SUBHN, SUBHN2, RSUBHN, RSUBHN2 */
     case 7: /* SABDL, SABDL2, UABDL, UABDL2 */
     case 8: /* SMLAL, SMLAL2, UMLAL, UMLAL2 */
     case 9: /* SQDMLAL, SQDMLAL2 */
-- 
2.34.1


