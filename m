Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79FFC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 06:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTxrI-0005D7-25; Wed, 17 Jul 2024 02:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxr6-0004Pp-92
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:09:37 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxr4-00033o-Im
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:09:36 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3dab2bb288aso2341416b6e.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 23:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721196573; x=1721801373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=91Gzd3eqh7/yDhre1ZyA2JmYLoJ2jcB1JHF4mrb/Guk=;
 b=tzAuwcLt6Td+L1vHIaSXXpnetGsVjz/VarJSLaD4CXAwedCER9ZfogpVG8gK4WMurm
 p0r1s1Bywsab3wE27QpFsH2VwMt78yl0QToTtuhfeJS7VWLrJlSnP1H7iIO5Uoh6cerN
 TqBFC0A+82XRQRa3ynr1futaDK7fmmCbYQ84qgLL72J84snMCxWtYv89q5Qqxs1TeZ8+
 GAAaxTYSv3qN2EiJh6MBzEiIjKqo22bIPEiiiiAqXfBVFvrIrDuXtwAAqpw0jXoOsVP5
 8xlBOCJSnYBon3L0Y0Hc58AktctixKEnYjpiXwU7rdems2WsPE9ExkZVhhF1aDW1YbvS
 EWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721196573; x=1721801373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=91Gzd3eqh7/yDhre1ZyA2JmYLoJ2jcB1JHF4mrb/Guk=;
 b=a87mQG7n86e4AyQyZvwfWg6EE/O9xhHJ+MEcU3VLutyciOum8quXx4fSUS+VxPlRKH
 bZ/8X21SnA+mAWnEW58MtDkWYryPqz/RtycsqwuffJAdSy+lYZy3u/FJPEThcXRTJ54X
 nKoywjMzccr4pR1bzT1p/DtwGbZq2WekgB6vUFDbkLjCo/ns/s/4aNldjU4IM7SLlxhN
 o+zuzHEPl26cbanLvqg6xvI6fhx2RCBvsCeXRZEBOOBsyplRdFGngQbOu3Y2VR3L2jeE
 l5w+tgzb0Hh0YPBVVhIfUBjtNW3Lbk0YFsKILiDXK6ROTzcPCazbLklj/s0hMXioypae
 ADPw==
X-Gm-Message-State: AOJu0YyOf03SvBKlpuvB/y51dMEGH5zbHKV4Rj7lPycnkrj6MuRXdACp
 nZcLwscDmEzutAqaKjfTiGVuyE+AUey41anh7WoK/wi7tGAJhPWOZ6iHFJfFd26K4P5tKX8hzAR
 trv8=
X-Google-Smtp-Source: AGHT+IH+cvFzsi8Omt3NcRgHbw+viGu5xFU4Eyc17//k7my4yITdy1B3rTnN0Zy3ycU2bHzadMNzlA==
X-Received: by 2002:a05:6808:2227:b0:3d2:2aa8:3b2c with SMTP id
 5614622812f47-3dad1f52425mr1097701b6e.33.1721196573391; 
 Tue, 16 Jul 2024 23:09:33 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7ecd603bsm7330404b3a.219.2024.07.16.23.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 23:09:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 09/17] target/arm: Convert MOVI, FMOV, ORR,
 BIC (vector immediate) to decodetree
Date: Wed, 17 Jul 2024 16:08:55 +1000
Message-ID: <20240717060903.205098-10-richard.henderson@linaro.org>
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
 target/arm/tcg/translate-a64.c | 117 ++++++++++++++-------------------
 target/arm/tcg/a64.decode      |   9 +++
 2 files changed, 59 insertions(+), 67 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 6582816e4e..1fa9dc3172 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6872,6 +6872,52 @@ static bool trans_FMOVI_s(DisasContext *s, arg_FMOVI_s *a)
     return true;
 }
 
+/*
+ * Advanced SIMD Modified Immediate
+ */
+
+static bool trans_FMOVI_v_h(DisasContext *s, arg_FMOVI_v_h *a)
+{
+    if (!dc_isar_feature(aa64_fp16, s)) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        tcg_gen_gvec_dup_imm(MO_16, vec_full_reg_offset(s, a->rd),
+                             a->q ? 16 : 8, vec_full_reg_size(s),
+                             vfp_expand_imm(MO_16, a->abcdefgh));
+    }
+    return true;
+}
+
+static void gen_movi(unsigned vece, uint32_t dofs, uint32_t aofs,
+                     int64_t c, uint32_t oprsz, uint32_t maxsz)
+{
+    tcg_gen_gvec_dup_imm(MO_64, dofs, oprsz, maxsz, c);
+}
+
+static bool trans_Vimm(DisasContext *s, arg_Vimm *a)
+{
+    GVecGen2iFn *fn;
+
+    /* Handle decode of cmode/op here between ORR/BIC/MOVI */
+    if ((a->cmode & 1) && a->cmode < 12) {
+        /* For op=1, the imm will be inverted, so BIC becomes AND. */
+        fn = a->op ? tcg_gen_gvec_andi : tcg_gen_gvec_ori;
+    } else {
+        /* There is one unallocated cmode/op combination in this space */
+        if (a->cmode == 15 && a->op == 1 && a->q == 0) {
+            return false;
+        }
+        fn = gen_movi;
+    }
+
+    if (fp_access_check(s)) {
+        uint64_t imm = asimd_imm_const(a->abcdefgh, a->cmode, a->op);
+        gen_gvec_fn2i(s, a->q, a->rd, a->rd, imm, fn, MO_64);
+    }
+    return true;
+}
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -9051,69 +9097,6 @@ static void disas_data_proc_fp(DisasContext *s, uint32_t insn)
     }
 }
 
-/* AdvSIMD modified immediate
- *  31  30   29  28                 19 18 16 15   12  11  10  9     5 4    0
- * +---+---+----+---------------------+-----+-------+----+---+-------+------+
- * | 0 | Q | op | 0 1 1 1 1 0 0 0 0 0 | abc | cmode | o2 | 1 | defgh |  Rd  |
- * +---+---+----+---------------------+-----+-------+----+---+-------+------+
- *
- * There are a number of operations that can be carried out here:
- *   MOVI - move (shifted) imm into register
- *   MVNI - move inverted (shifted) imm into register
- *   ORR  - bitwise OR of (shifted) imm with register
- *   BIC  - bitwise clear of (shifted) imm with register
- * With ARMv8.2 we also have:
- *   FMOV half-precision
- */
-static void disas_simd_mod_imm(DisasContext *s, uint32_t insn)
-{
-    int rd = extract32(insn, 0, 5);
-    int cmode = extract32(insn, 12, 4);
-    int o2 = extract32(insn, 11, 1);
-    uint64_t abcdefgh = extract32(insn, 5, 5) | (extract32(insn, 16, 3) << 5);
-    bool is_neg = extract32(insn, 29, 1);
-    bool is_q = extract32(insn, 30, 1);
-    uint64_t imm = 0;
-
-    if (o2) {
-        if (cmode != 0xf || is_neg) {
-            unallocated_encoding(s);
-            return;
-        }
-        /* FMOV (vector, immediate) - half-precision */
-        if (!dc_isar_feature(aa64_fp16, s)) {
-            unallocated_encoding(s);
-            return;
-        }
-        imm = vfp_expand_imm(MO_16, abcdefgh);
-        /* now duplicate across the lanes */
-        imm = dup_const(MO_16, imm);
-    } else {
-        if (cmode == 0xf && is_neg && !is_q) {
-            unallocated_encoding(s);
-            return;
-        }
-        imm = asimd_imm_const(abcdefgh, cmode, is_neg);
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    if (!((cmode & 0x9) == 0x1 || (cmode & 0xd) == 0x9)) {
-        /* MOVI or MVNI, with MVNI negation handled above.  */
-        tcg_gen_gvec_dup_imm(MO_64, vec_full_reg_offset(s, rd), is_q ? 16 : 8,
-                             vec_full_reg_size(s), imm);
-    } else {
-        /* ORR or BIC, with BIC negation to AND handled above.  */
-        if (is_neg) {
-            gen_gvec_fn2i(s, is_q, rd, rd, imm, tcg_gen_gvec_andi, MO_64);
-        } else {
-            gen_gvec_fn2i(s, is_q, rd, rd, imm, tcg_gen_gvec_ori, MO_64);
-        }
-    }
-}
-
 /*
  * Common SSHR[RA]/USHR[RA] - Shift right (optional rounding/accumulate)
  *
@@ -10593,8 +10576,10 @@ static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
     bool is_u = extract32(insn, 29, 1);
     bool is_q = extract32(insn, 30, 1);
 
-    /* data_proc_simd[] has sent immh == 0 to disas_simd_mod_imm. */
-    assert(immh != 0);
+    if (immh == 0) {
+        unallocated_encoding(s);
+        return;
+    }
 
     switch (opcode) {
     case 0x08: /* SRI */
@@ -11602,8 +11587,6 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
 static const AArch64DecodeTable data_proc_simd[] = {
     /* pattern  ,  mask     ,  fn                        */
     { 0x0e200800, 0x9f3e0c00, disas_simd_two_reg_misc },
-    /* simd_mod_imm decode is a subset of simd_shift_imm, so must precede it */
-    { 0x0f000400, 0x9ff80400, disas_simd_mod_imm },
     { 0x0f000400, 0x9f800400, disas_simd_shift_imm },
     { 0x5e200800, 0xdf3e0c00, disas_simd_scalar_two_reg_misc },
     { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index de763d3f12..d4dfc5f772 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1184,3 +1184,12 @@ FMINV_s         0110 1110 10 11000 01111 10 ..... .....     @rr_q1e2
 # Floating-point Immediate
 
 FMOVI_s         0001 1110 .. 1 imm:8 100 00000 rd:5         esz=%esz_hsd
+
+# Advanced SIMD Modified Immediate
+
+%abcdefgh       16:3 5:5
+
+FMOVI_v_h       0 q:1 00 1111 00000 ... 1111 11 ..... rd:5  %abcdefgh
+
+# MOVI, MVNI, ORR, BIC, FMOV are all intermixed via cmode.
+Vimm            0 q:1 op:1 0 1111 00000 ... cmode:4 01 ..... rd:5 %abcdefgh
-- 
2.43.0


