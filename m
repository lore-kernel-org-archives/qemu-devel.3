Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123AAE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:46:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPgk-0005nM-SW; Wed, 11 Dec 2024 11:35:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPgg-0005ct-6z
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:35:47 -0500
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPgd-00021m-Th
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:35:45 -0500
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6d87fea84cdso52633926d6.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934942; x=1734539742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zGUcFMFJgnGkbao9QRde+lHu2cieqfVPGxCYTjWnKHI=;
 b=rqJ3JK8DjXO329/tOksrZccOjx5sYg4fak9ydF0fGi7zRV+qKdZ3abeBCtyNwyUznw
 IcS/U5OvvfsiZPwwM++yIZHAeWeyGIuHNXzw6sEgy3MyckBAzWbHnPb3lKXEjF+yHsJp
 hSE7PwYk3Z8WTp/yOmoCVMcM4wo1rSZ5M8CKZgGoNV9Ea4zz9NSJWMKzIV3jV8yij7k/
 Oo4kMEJhd48f28pbffZ98vRyIY4gEGGyuc0FubXHKK5obfqBWBID85UAgHWuDEKM7DZ8
 SMVnThdVESJYRCKib8RIBrzdiTwd+awbneUZCqqLwsw1/21te3EwD7kn/lhQhnJ5Xhp2
 q7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934942; x=1734539742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zGUcFMFJgnGkbao9QRde+lHu2cieqfVPGxCYTjWnKHI=;
 b=V76o2hBAV9f7aWLAKUgxnmsPc7qxIAJIOgTU4trb9bcbAwFacBj21cPonyFsJIHEET
 7Y06Tv2Z0UeZD/jQDZexaQKom/nehjxuP7kT8Fe52P1Bmc1Ndv8RCm0sFwWwT+BomY/e
 FsiUrNOQahKmotRm7E7f/eyR3kaBVakGxBa5/IQOxFXQcgFPnQBUUbSWJWRo7aAYWMHu
 bjf05aoJXTNNExSwsdUV4tUJaXtXLg8cmk3uCz7BY7vErlz+lKtntWPmM1y+VuI2NzR1
 ain3lJu8aCbrIM4HHfaMgAtt3vS1ELZeCGseGycfZ4JEf2yckE+cZ6D8rJWnUoN7yC9M
 9jvQ==
X-Gm-Message-State: AOJu0YxbNxGRdZVZsR0SccIwEGkyPFGijDNRzRVDb9tASFl4gC5f21sM
 w7qHbgUTlyaAy0MCmzIh9ILVDV9xOIRaWh5uUxjhdgYezWqjvtzW38X2iNajXIgCO96UELATE8x
 U+DWFdQVm
X-Gm-Gg: ASbGncsj8I+H7XsW9C0HOZDrT3DMzEYaG+t7RF/zxBbmyxJP9FVjuxmAYfVpKKgvQuC
 1dsx47L14yte2jQBGmqmes+fEOYEgngp4TGU3zKnjVCbXDIBoQs8+kJYcLZqV9kWFqUiTd44Ew7
 f0TkW2sHH5HanW43nRW55vIjj7E5+QrqsGRcep/YUo12+7Menhs3HVzdGS1uw+pNFwunT5Rkgh5
 ixvd/D5wb9ETi0LKSHG70MdJimO2eL+8OKdsMEyMJQF+/27azFOikK24eFH7g==
X-Google-Smtp-Source: AGHT+IGdDom7pJoMAKNgr5GmG+6xkJZjqyTwtD5aANd+pAJD43Azcm0E3y7obbJ5UAJOVBJSwUjHwQ==
X-Received: by 2002:a05:6214:27eb:b0:6d9:3566:7611 with SMTP id
 6a1803df08f44-6dae29f7d41mr4919686d6.14.1733934942395; 
 Wed, 11 Dec 2024 08:35:42 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da675214sm71856276d6.11.2024.12.11.08.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:35:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 41/69] target/arm: Convert CMGT, CMGE, GMLT, GMLE,
 CMEQ (zero) to decodetree
Date: Wed, 11 Dec 2024 10:30:08 -0600
Message-ID: <20241211163036.2297116-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf33.google.com
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
 target/arm/tcg/translate-a64.c | 94 +++++++++++-----------------------
 target/arm/tcg/a64.decode      | 10 ++++
 2 files changed, 40 insertions(+), 64 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index aff1984a22..547c6dc5cc 100644
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
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index bac81eec7e..247d3a7bda 100644
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
-- 
2.43.0


