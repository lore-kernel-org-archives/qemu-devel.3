Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3460CDD573
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGwj-0006A7-Pk; Thu, 19 Sep 2024 09:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwL-0004l9-8f
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:21 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwH-00011V-8Z
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:20 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42cbc38a997so5487695e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 06:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726751475; x=1727356275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NwA8IMlT0sOSRXhOrSBTBleprWAAmzHJ7qrswSkhHtE=;
 b=Fe8hdSTU411BgOUAZIf3gBlLgnt57wOa1JKu6+P631MXj14jPTCy6Rgx2tNaY08Y0f
 XherVE62Y1b1UwxPQnFh8ngcOu2OZSugWn+DMpkYBOhzDxr6w3KkKll2MlBh3mRZeiIj
 lwxVoYYWUQRb2h40K8wBi3/mCAJvwLwwGXQK75n7dvk81CoIn+XLwBH8qPm9U1n01D2y
 0sgDNXQABzb2/QPDs25sX0/MrVYctHHpSzeCQX8+CcBda/aFAjgdI8V8cYUEbR6qFkNP
 SKMxW8QB4y69x8JNenxp//quqJDdtOY1y4EMo8LwKI9uaHZwlRZjiI3alasjdOZgQWl3
 i++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751475; x=1727356275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NwA8IMlT0sOSRXhOrSBTBleprWAAmzHJ7qrswSkhHtE=;
 b=l8Pkj1OwBY9PK53/C60dnAoWYbgm4X2i7vX83BlzrevAkT+VrY+zdmEr0vxyIUgIHj
 J9Fp2Qjq3CaeROcPIM0oWEYA6/321FTrkaowVrBfzwV2JYxnGXWAHsC+Hw/XU6pJB7pV
 MIJm/LBaVcS9sXxJieO1L7goqZVa0/6aIbQLGrYTBXfqdrfmvgm0dVlJTZhu6WbZV/En
 jOOcGY1VLzn5TK3JVgCtCYptSGb6BWx9hmdjjk7AwsjX64h4olZeVsatdDwH4Nave5OH
 mlmGyA8kNVNHK5Tw2LgaAKC8wytd9cphPSH5ut67Dt34EJXqSsPU+hG97p8NlkryBGb1
 FQ9g==
X-Gm-Message-State: AOJu0Yx5vtP/UTpocdWw9R09YiEEXwAxhwOQUMd1i9TK6vE0K4+t/Xsa
 8DNQIxkcZE6hKgxyTMGEg31wLkX+4b9LTBrwZBe0uM+T8xt8rVEPdJZB0ap6TyNJwZfZhTlvgMh
 t
X-Google-Smtp-Source: AGHT+IGlXCwzCl97IssJXVYd3+CWUJTm3KfB1qMwlD+EXMKOS0DWeh8U/bv0ADqh8YgoMwd6ur1tAQ==
X-Received: by 2002:a05:600c:154d:b0:42c:b2a2:af3a with SMTP id
 5b1f17b1804b1-42e744279b1mr21822355e9.9.1726751475005; 
 Thu, 19 Sep 2024 06:11:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754091d3sm21667845e9.10.2024.09.19.06.11.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 06:11:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/38] target/arm: Convert MOVI, FMOV, ORR,
 BIC (vector immediate) to decodetree
Date: Thu, 19 Sep 2024 14:10:41 +0100
Message-Id: <20240919131106.3362543-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919131106.3362543-1-peter.maydell@linaro.org>
References: <20240919131106.3362543-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240912024114.1097832-14-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |   9 +++
 target/arm/tcg/translate-a64.c | 117 ++++++++++++++-------------------
 2 files changed, 59 insertions(+), 67 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index e11e293631b..278d7873c21 100644
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
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 0e290062ef1..53022f4fc08 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6913,6 +6913,52 @@ static bool trans_FMOVI_s(DisasContext *s, arg_FMOVI_s *a)
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
@@ -9092,69 +9138,6 @@ static void disas_data_proc_fp(DisasContext *s, uint32_t insn)
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
@@ -10635,8 +10618,10 @@ static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
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
@@ -11644,8 +11629,6 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
 static const AArch64DecodeTable data_proc_simd[] = {
     /* pattern  ,  mask     ,  fn                        */
     { 0x0e200800, 0x9f3e0c00, disas_simd_two_reg_misc },
-    /* simd_mod_imm decode is a subset of simd_shift_imm, so must precede it */
-    { 0x0f000400, 0x9ff80400, disas_simd_mod_imm },
     { 0x0f000400, 0x9f800400, disas_simd_shift_imm },
     { 0x5e200800, 0xdf3e0c00, disas_simd_scalar_two_reg_misc },
     { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
-- 
2.34.1


