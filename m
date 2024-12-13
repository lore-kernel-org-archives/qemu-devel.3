Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DFCE77184
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9Xg-0007g9-0S; Fri, 13 Dec 2024 12:33:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9XU-0007EP-Db
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:22 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9XS-0001cC-Gf
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:20 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-385ed7f6605so1059144f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111196; x=1734715996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=keiI1XrwT1F2BdgbQwqF8VW3k075qrpgYZgXkqhkRoc=;
 b=O88QUqQ3UKJKafWN73DLLgWiHYuooUneoDScrSjqtrltsFALfuEvv/gS7ELwnGIczD
 RjvsslSGSC4egQVM5X1bR61ZD2RxhWX3shi+0DI5/IvKgKqX2GWXZtxOQbc8cNc7544N
 Lz0IE5POPDCEjTQgSV31GE3khfbFcfNxbRDbRtM1YslIFFWehxdh61rEgYCE9Omppadl
 zWgpLV5ARoo+JEEOiRM4YwdpUNQfPtjqF1Vcj354CR1t/Kwtw9sa2sjdybyxr/d5b8qv
 WZSlm3t1Hluf4mUxfIwUSJLgETIvfb0OEsuGtVnnmLux20g/NApIXoPMziSwAekfQHGh
 gBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111196; x=1734715996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=keiI1XrwT1F2BdgbQwqF8VW3k075qrpgYZgXkqhkRoc=;
 b=upIiweijRowbjk7tr36MShw8RnBDksefQj1n5sTBxlExRpRM/OjEnECVJGT7Dw/2/G
 cNOCUPooeAYZJKA+VayGujdxW2D3twX6XMdwcKIq1Jrn7s+cXaA/8SuC9mPsJDGRrApa
 FfMZGTLvnjF6G3ouPGYOKoUoenc3ZSmPAm34hTGlFmk8mMrblBz4pL/6iYJ26wrd0vk8
 zJbCsGfdLf4PmigeRq18CBXf2XfPug9MoZXllR81TovHhsfzxowuP7TCAVXWw3QW0eyr
 sebyMjzPTBC48BAJdBLUTyuOKcReNiuOBy36Te2wQUTKIW84EqcMNpk4DyqeqGKK0LEs
 +PeQ==
X-Gm-Message-State: AOJu0YymZuaoX+TsjNp9oB1aTUjWUDdI7Qr2DQT/tWdOa+vkcCI9XYW6
 gyLKQxBwfToclOQsLORdd/T0r8YCF0Y4XlvA2jQWFvnVTHdc9OnqQLpuMhXN6GtNxDEnqREht/v
 N
X-Gm-Gg: ASbGnctuj1xSUo0kJ8akQMOI4h8IbJArwI588knrCcTbATvlvmW1jjQZkszjgBof057
 gxMqJg7M2f3gYtaVR1GR8sP+jKIOFjTwBmv6a9qCOvZRfi2PW6qLOtPV3+3a8ja0L4rTn579ypv
 tj+OVI35SZThFU9WJCtfARfRDf94klUu46YXMcVsz/jGPwjrkOaJjxvXPDtOFQQL96hKjiZ3AA1
 6K6Y4RKjOc2Ixlm+ujf160gMnolxVZ1ideoRVwVP8P/6aMO9fyshSyBe4S2Uw==
X-Google-Smtp-Source: AGHT+IE6KdUTPbKs04bbF1VwQ2BSVHqT7FOh6VpPI1DR8+8foUKv4Vw1fMyhH6WENHnqFyFbH2t0Zw==
X-Received: by 2002:a05:6000:1882:b0:385:e0d6:fb73 with SMTP id
 ffacd0b85a97d-38880ad7765mr2987009f8f.15.1734111195643; 
 Fri, 13 Dec 2024 09:33:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/85] target/arm: Convert CMGT, CMGE, GMLT, GMLE,
 CMEQ (zero) to decodetree
Date: Fri, 13 Dec 2024 17:31:45 +0000
Message-Id: <20241213173229.3308926-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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
Message-id: 20241211163036.2297116-42-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      | 10 ++++
 target/arm/tcg/translate-a64.c | 94 +++++++++++-----------------------
 2 files changed, 40 insertions(+), 64 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index bac81eec7e6..247d3a7bda4 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1635,6 +1635,11 @@ SQABS_s         0101 1110 ..1 00000 01111 0 ..... .....     @rr_e
 SQNEG_s         0111 1110 ..1 00000 01111 0 ..... .....     @rr_e
 ABS_s           0101 1110 111 00000 10111 0 ..... .....     @rr
 NEG_s           0111 1110 111 00000 10111 0 ..... .....     @rr
+CMGT0_s         0101 1110 111 00000 10001 0 ..... .....     @rr
+CMGE0_s         0111 1110 111 00000 10001 0 ..... .....     @rr
+CMEQ0_s         0101 1110 111 00000 10011 0 ..... .....     @rr
+CMLE0_s         0111 1110 111 00000 10011 0 ..... .....     @rr
+CMLT0_s         0101 1110 111 00000 10101 0 ..... .....     @rr
 
 # Advanced SIMD two-register miscellaneous
 
@@ -1647,3 +1652,8 @@ CLZ_v           0.10 1110 ..1 00000 01001 0 ..... .....     @qrr_e
 CNT_v           0.00 1110 001 00000 01011 0 ..... .....     @qrr_b
 NOT_v           0.10 1110 001 00000 01011 0 ..... .....     @qrr_b
 RBIT_v          0.10 1110 011 00000 01011 0 ..... .....     @qrr_b
+CMGT0_v         0.00 1110 ..1 00000 10001 0 ..... .....     @qrr_e
+CMGE0_v         0.10 1110 ..1 00000 10001 0 ..... .....     @qrr_e
+CMEQ0_v         0.00 1110 ..1 00000 10011 0 ..... .....     @qrr_e
+CMLE0_v         0.10 1110 ..1 00000 10011 0 ..... .....     @qrr_e
+CMLT0_v         0.00 1110 ..1 00000 10101 0 ..... .....     @qrr_e
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index aff1984a224..547c6dc5cc0 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8902,6 +8902,22 @@ static bool do_scalar1_d(DisasContext *s, arg_rr *a, ArithOneOp *f)
 TRANS(ABS_s, do_scalar1_d, a, tcg_gen_abs_i64)
 TRANS(NEG_s, do_scalar1_d, a, tcg_gen_neg_i64)
 
+static bool do_cmop0_d(DisasContext *s, arg_rr *a, TCGCond cond)
+{
+    if (fp_access_check(s)) {
+        TCGv_i64 t = read_fp_dreg(s, a->rn);
+        tcg_gen_negsetcond_i64(cond, t, t, tcg_constant_i64(0));
+        write_fp_dreg(s, a->rd, t);
+    }
+    return true;
+}
+
+TRANS(CMGT0_s, do_cmop0_d, a, TCG_COND_GT)
+TRANS(CMGE0_s, do_cmop0_d, a, TCG_COND_GE)
+TRANS(CMLE0_s, do_cmop0_d, a, TCG_COND_LE)
+TRANS(CMLT0_s, do_cmop0_d, a, TCG_COND_LT)
+TRANS(CMEQ0_s, do_cmop0_d, a, TCG_COND_EQ)
+
 static bool do_gvec_fn2(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
 {
     if (!a->q && a->esz == MO_64) {
@@ -8918,6 +8934,11 @@ TRANS(NEG_v, do_gvec_fn2, a, tcg_gen_gvec_neg)
 TRANS(NOT_v, do_gvec_fn2, a, tcg_gen_gvec_not)
 TRANS(CNT_v, do_gvec_fn2, a, gen_gvec_cnt)
 TRANS(RBIT_v, do_gvec_fn2, a, gen_gvec_rbit)
+TRANS(CMGT0_v, do_gvec_fn2, a, gen_gvec_cgt0)
+TRANS(CMGE0_v, do_gvec_fn2, a, gen_gvec_cge0)
+TRANS(CMLT0_v, do_gvec_fn2, a, gen_gvec_clt0)
+TRANS(CMLE0_v, do_gvec_fn2, a, gen_gvec_cle0)
+TRANS(CMEQ0_v, do_gvec_fn2, a, gen_gvec_ceq0)
 
 static bool do_gvec_fn2_bhs(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
 {
@@ -9229,21 +9250,7 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
      * The caller only need provide tcg_rmode and tcg_fpstatus if the op
      * requires them.
      */
-    TCGCond cond;
-
     switch (opcode) {
-    case 0xa: /* CMLT */
-        cond = TCG_COND_LT;
-    do_cmop:
-        /* 64 bit integer comparison against zero, result is test ? -1 : 0. */
-        tcg_gen_negsetcond_i64(cond, tcg_rd, tcg_rn, tcg_constant_i64(0));
-        break;
-    case 0x8: /* CMGT, CMGE */
-        cond = u ? TCG_COND_GE : TCG_COND_GT;
-        goto do_cmop;
-    case 0x9: /* CMEQ, CMLE */
-        cond = u ? TCG_COND_LE : TCG_COND_EQ;
-        goto do_cmop;
     case 0x2f: /* FABS */
         gen_vfp_absd(tcg_rd, tcg_rn);
         break;
@@ -9290,6 +9297,9 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
     case 0x4: /* CLS, CLZ */
     case 0x5: /* NOT */
     case 0x7: /* SQABS, SQNEG */
+    case 0x8: /* CMGT, CMGE */
+    case 0x9: /* CMEQ, CMLE */
+    case 0xa: /* CMLT */
     case 0xb: /* ABS, NEG */
         g_assert_not_reached();
     }
@@ -9633,19 +9643,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
     TCGv_ptr tcg_fpstatus;
 
     switch (opcode) {
-    case 0xa: /* CMLT */
-        if (u) {
-            unallocated_encoding(s);
-            return;
-        }
-        /* fall through */
-    case 0x8: /* CMGT, CMGE */
-    case 0x9: /* CMEQ, CMLE */
-        if (size != 3) {
-            unallocated_encoding(s);
-            return;
-        }
-        break;
     case 0x12: /* SQXTUN */
         if (!u) {
             unallocated_encoding(s);
@@ -9731,6 +9728,9 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
     default:
     case 0x3: /* USQADD / SUQADD */
     case 0x7: /* SQABS / SQNEG */
+    case 0x8: /* CMGT, CMGE */
+    case 0x9: /* CMEQ, CMLE */
+    case 0xa: /* CMLT */
     case 0xb: /* ABS, NEG */
         unallocated_encoding(s);
         return;
@@ -10103,19 +10103,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         }
         handle_shll(s, is_q, size, rn, rd);
         return;
-    case 0xa: /* CMLT */
-        if (u == 1) {
-            unallocated_encoding(s);
-            return;
-        }
-        /* fall through */
-    case 0x8: /* CMGT, CMGE */
-    case 0x9: /* CMEQ, CMLE */
-        if (size == 3 && !is_q) {
-            unallocated_encoding(s);
-            return;
-        }
-        break;
     case 0xc ... 0xf:
     case 0x16 ... 0x1f:
     {
@@ -10289,6 +10276,9 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     case 0x4: /* CLS, CLZ */
     case 0x5: /* CNT, NOT, RBIT */
     case 0x7: /* SQABS, SQNEG */
+    case 0x8: /* CMGT, CMGE */
+    case 0x9: /* CMEQ, CMLE */
+    case 0xa: /* CMLT */
     case 0xb: /* ABS, NEG */
         unallocated_encoding(s);
         return;
@@ -10309,30 +10299,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         tcg_rmode = NULL;
     }
 
-    switch (opcode) {
-    case 0x8: /* CMGT, CMGE */
-        if (u) {
-            gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_cge0, size);
-        } else {
-            gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_cgt0, size);
-        }
-        return;
-    case 0x9: /* CMEQ, CMLE */
-        if (u) {
-            gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_cle0, size);
-        } else {
-            gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_ceq0, size);
-        }
-        return;
-    case 0xa: /* CMLT */
-        gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_clt0, size);
-        return;
-    case 0x4: /* CLZ, CLS */
-    case 0x5: /* CNT, NOT, RBIT */
-    case 0xb:
-        g_assert_not_reached();
-    }
-
     if (size == 3) {
         /* All 64-bit element operations can be shared with scalar 2misc */
         int pass;
-- 
2.34.1


