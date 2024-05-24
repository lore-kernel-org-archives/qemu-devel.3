Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC535C25B7A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 23:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAeEY-0006jq-5D; Fri, 24 May 2024 19:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeEQ-0006cG-TV
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:51 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeEK-0005oq-Ff
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:50 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1f44b513017so11716875ad.1
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 16:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716592903; x=1717197703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HW9WJe8c9Y/ZQ8ANeC2v7XTvybTBdbF7wEMJw9YHz1E=;
 b=l+oWcHOc/x9/v1jfbrPcvIHonU9liJ7mkE1sH8fyCq38hHVAhi0SCWGueuDxQWxNfI
 TLK4h1CNgHZLLpeEyWxWzS+dAlzsdWx2xFW/ZEsUGKxuI39pLpg5xZON0Af1HYbVk5nS
 RsNjU4K40z3MxF6mHF0NXiMGJyndfXO4jwrnflrDj8ijCrxu2jYD5TYPSwTeOnFlH5sT
 hkMyuR/epo0t9wzxWib/pZ6rsmm7A0kAbuGRcM47slhPRzuI9UXqb/b8WUvtntTEf7Dm
 hcvSVzbwBvTnC24/yQ877fBqKG+punPIjrxATmspR/lg44rsA2N90o2wOU4btwx9VEin
 UaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716592903; x=1717197703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HW9WJe8c9Y/ZQ8ANeC2v7XTvybTBdbF7wEMJw9YHz1E=;
 b=H0miYslzUbX7x6BwYix7zI9rCaSwn8VfUS33C6Z1AnwwiTy7Ap9kMJq8wHppS6UJ2X
 4MIr9KN3xgStqgs7o+Zu+SU7HPfbz5q455QhqaOS/CO75QMU8gFgAZ0DHrKNSsTmBFjn
 4pASVuo4VS+5dBNAA1uRE38K7E1R6+fov7nlroPXKrWpePIRaSNIolxs3BHskkcxSX8H
 8Fn81YgSGhTxLO8Nrw6tXnkEXPFQWPllSeG4FHOswpX9eBHRmn4kwW4fmFBTwaCKLWBX
 MBFwAPVdFYx96K8JIS9BaA5C/yF10TN80X+0AceGPmiLIxJKC3bYiwVvmVXmtHlJbo2b
 drjQ==
X-Gm-Message-State: AOJu0Yyjgnd2/MsObWpe7Gscr784ROfy6nfHj0cqSZM/9FWdPA9zD+X6
 8Obm2BmmB2RscqUZESsG/O3+PbjyPIIea5em0N4itfusnKl4TX7NMZ4emnbyfibZoLXC88rehl0
 C
X-Google-Smtp-Source: AGHT+IGECIThMFHuEUyoum2thUElTSz0Gwr7NLShFB7e3pxg4XsnvbzTGHLg5jntZrQwbASYPdXqLQ==
X-Received: by 2002:a17:903:2451:b0:1f3:50b5:65bd with SMTP id
 d9443c01a7336-1f44873c138mr39770625ad.33.1716592903173; 
 Fri, 24 May 2024 16:21:43 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c759ceesm19178305ad.10.2024.05.24.16.21.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 16:21:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 23/67] target/arm: Convert FNMUL to decodetree
Date: Fri, 24 May 2024 16:20:37 -0700
Message-Id: <20240524232121.284515-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524232121.284515-1-richard.henderson@linaro.org>
References: <20240524232121.284515-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

This is the last instruction within disas_fp_2src,
so remove that and its subroutines.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/a64.decode      |   1 +
 target/arm/tcg/translate-a64.c | 177 +++++----------------------------
 2 files changed, 27 insertions(+), 151 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index e2678d919e..cde4b86303 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -703,6 +703,7 @@ FADD_s          0001 1110 ..1 ..... 0010 10 ..... ..... @rrr_hsd
 FSUB_s          0001 1110 ..1 ..... 0011 10 ..... ..... @rrr_hsd
 FDIV_s          0001 1110 ..1 ..... 0001 10 ..... ..... @rrr_hsd
 FMUL_s          0001 1110 ..1 ..... 0000 10 ..... ..... @rrr_hsd
+FNMUL_s         0001 1110 ..1 ..... 1000 10 ..... ..... @rrr_hsd
 
 FMAX_s          0001 1110 ..1 ..... 0100 10 ..... ..... @rrr_hsd
 FMIN_s          0001 1110 ..1 ..... 0101 10 ..... ..... @rrr_hsd
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 878f83298f..5ba30ba7c8 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4950,6 +4950,31 @@ static const FPScalar f_scalar_fmulx = {
 };
 TRANS(FMULX_s, do_fp3_scalar, a, &f_scalar_fmulx)
 
+static void gen_fnmul_h(TCGv_i32 d, TCGv_i32 n, TCGv_i32 m, TCGv_ptr s)
+{
+    gen_helper_vfp_mulh(d, n, m, s);
+    gen_vfp_negh(d, d);
+}
+
+static void gen_fnmul_s(TCGv_i32 d, TCGv_i32 n, TCGv_i32 m, TCGv_ptr s)
+{
+    gen_helper_vfp_muls(d, n, m, s);
+    gen_vfp_negs(d, d);
+}
+
+static void gen_fnmul_d(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_ptr s)
+{
+    gen_helper_vfp_muld(d, n, m, s);
+    gen_vfp_negd(d, d);
+}
+
+static const FPScalar f_scalar_fnmul = {
+    gen_fnmul_h,
+    gen_fnmul_s,
+    gen_fnmul_d,
+};
+TRANS(FNMUL_s, do_fp3_scalar, a, &f_scalar_fnmul)
+
 static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a,
                           gen_helper_gvec_3_ptr * const fns[3])
 {
@@ -6932,156 +6957,6 @@ static void disas_fp_1src(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Floating-point data-processing (2 source) - single precision */
-static void handle_fp_2src_single(DisasContext *s, int opcode,
-                                  int rd, int rn, int rm)
-{
-    TCGv_i32 tcg_op1;
-    TCGv_i32 tcg_op2;
-    TCGv_i32 tcg_res;
-    TCGv_ptr fpst;
-
-    tcg_res = tcg_temp_new_i32();
-    fpst = fpstatus_ptr(FPST_FPCR);
-    tcg_op1 = read_fp_sreg(s, rn);
-    tcg_op2 = read_fp_sreg(s, rm);
-
-    switch (opcode) {
-    case 0x8: /* FNMUL */
-        gen_helper_vfp_muls(tcg_res, tcg_op1, tcg_op2, fpst);
-        gen_vfp_negs(tcg_res, tcg_res);
-        break;
-    default:
-    case 0x0: /* FMUL */
-    case 0x1: /* FDIV */
-    case 0x2: /* FADD */
-    case 0x3: /* FSUB */
-    case 0x4: /* FMAX */
-    case 0x5: /* FMIN */
-    case 0x6: /* FMAXNM */
-    case 0x7: /* FMINNM */
-        g_assert_not_reached();
-    }
-
-    write_fp_sreg(s, rd, tcg_res);
-}
-
-/* Floating-point data-processing (2 source) - double precision */
-static void handle_fp_2src_double(DisasContext *s, int opcode,
-                                  int rd, int rn, int rm)
-{
-    TCGv_i64 tcg_op1;
-    TCGv_i64 tcg_op2;
-    TCGv_i64 tcg_res;
-    TCGv_ptr fpst;
-
-    tcg_res = tcg_temp_new_i64();
-    fpst = fpstatus_ptr(FPST_FPCR);
-    tcg_op1 = read_fp_dreg(s, rn);
-    tcg_op2 = read_fp_dreg(s, rm);
-
-    switch (opcode) {
-    case 0x8: /* FNMUL */
-        gen_helper_vfp_muld(tcg_res, tcg_op1, tcg_op2, fpst);
-        gen_vfp_negd(tcg_res, tcg_res);
-        break;
-    default:
-    case 0x0: /* FMUL */
-    case 0x1: /* FDIV */
-    case 0x2: /* FADD */
-    case 0x3: /* FSUB */
-    case 0x4: /* FMAX */
-    case 0x5: /* FMIN */
-    case 0x6: /* FMAXNM */
-    case 0x7: /* FMINNM */
-        g_assert_not_reached();
-    }
-
-    write_fp_dreg(s, rd, tcg_res);
-}
-
-/* Floating-point data-processing (2 source) - half precision */
-static void handle_fp_2src_half(DisasContext *s, int opcode,
-                                int rd, int rn, int rm)
-{
-    TCGv_i32 tcg_op1;
-    TCGv_i32 tcg_op2;
-    TCGv_i32 tcg_res;
-    TCGv_ptr fpst;
-
-    tcg_res = tcg_temp_new_i32();
-    fpst = fpstatus_ptr(FPST_FPCR_F16);
-    tcg_op1 = read_fp_hreg(s, rn);
-    tcg_op2 = read_fp_hreg(s, rm);
-
-    switch (opcode) {
-    case 0x8: /* FNMUL */
-        gen_helper_advsimd_mulh(tcg_res, tcg_op1, tcg_op2, fpst);
-        gen_vfp_negh(tcg_res, tcg_res);
-        break;
-    default:
-    case 0x0: /* FMUL */
-    case 0x1: /* FDIV */
-    case 0x2: /* FADD */
-    case 0x3: /* FSUB */
-    case 0x4: /* FMAX */
-    case 0x5: /* FMIN */
-    case 0x6: /* FMAXNM */
-    case 0x7: /* FMINNM */
-        g_assert_not_reached();
-    }
-
-    write_fp_sreg(s, rd, tcg_res);
-}
-
-/* Floating point data-processing (2 source)
- *   31  30  29 28       24 23  22  21 20  16 15    12 11 10 9    5 4    0
- * +---+---+---+-----------+------+---+------+--------+-----+------+------+
- * | M | 0 | S | 1 1 1 1 0 | type | 1 |  Rm  | opcode | 1 0 |  Rn  |  Rd  |
- * +---+---+---+-----------+------+---+------+--------+-----+------+------+
- */
-static void disas_fp_2src(DisasContext *s, uint32_t insn)
-{
-    int mos = extract32(insn, 29, 3);
-    int type = extract32(insn, 22, 2);
-    int rd = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int rm = extract32(insn, 16, 5);
-    int opcode = extract32(insn, 12, 4);
-
-    if (opcode > 8 || mos) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    switch (type) {
-    case 0:
-        if (!fp_access_check(s)) {
-            return;
-        }
-        handle_fp_2src_single(s, opcode, rd, rn, rm);
-        break;
-    case 1:
-        if (!fp_access_check(s)) {
-            return;
-        }
-        handle_fp_2src_double(s, opcode, rd, rn, rm);
-        break;
-    case 3:
-        if (!dc_isar_feature(aa64_fp16, s)) {
-            unallocated_encoding(s);
-            return;
-        }
-        if (!fp_access_check(s)) {
-            return;
-        }
-        handle_fp_2src_half(s, opcode, rd, rn, rm);
-        break;
-    default:
-        unallocated_encoding(s);
-    }
-}
-
 /* Floating-point data-processing (3 source) - single precision */
 static void handle_fp_3src_single(DisasContext *s, bool o0, bool o1,
                                   int rd, int rn, int rm, int ra)
@@ -7685,7 +7560,7 @@ static void disas_data_proc_fp(DisasContext *s, uint32_t insn)
             break;
         case 2:
             /* Floating point data-processing (2 source) */
-            disas_fp_2src(s, insn);
+            unallocated_encoding(s); /* in decodetree */
             break;
         case 3:
             /* Floating point conditional select */
-- 
2.34.1


