Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C25C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RAB-0001gP-Sl; Fri, 25 Apr 2025 18:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7k-0005MU-IV
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:21 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7f-0001Mu-LS
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:19 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-303a66af07eso2170213a91.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618534; x=1746223334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qy4cFgNRGYJfQ4+Eg0MwqDkZ5FnNHwhpdUv6XjVrGUQ=;
 b=PYM/6c/94+xlfd5hQm9EdV+9f3bPYUYEtnGub01VEOfw/S/bxGAeII39bU4WyzJYvB
 W3wQujauSmiG8ZVGJDyubusMvRetwPmfIROLB9Y2ml/x+1hRuG4jaDPoRzfL0/FqzvvI
 GCD8IlXyjPtDjJyY7Mr8oArAoLxfnI8l3Zn1gNg+0gk5ph25ec7//YcON4TkGiCXXZiD
 m6LFJ4OENuL7pR6LO0U8W1USWCxNFSWRDv94vYMmV6ZrqJum0L/quGPObCXMoA92AMUe
 tqpHQmwMvndgPiAATRmgY2nWeF5Ur2snSKj+/HK2UuonJhpV6mmXnc/X7tdXMimYptH0
 i3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618534; x=1746223334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qy4cFgNRGYJfQ4+Eg0MwqDkZ5FnNHwhpdUv6XjVrGUQ=;
 b=dwRG506gjSBALYtdGXGnYLEJzjhJFKvTt2Wyj1wOOG+NZCzFmzrk0C2VDC7tR8MYZP
 MAowqMd81DEiRpEDep1GaQwwDcEGfBtkMFbc0smmhti46z7oVNCBiEyB1oIVmgcDrl0F
 HAUlOxpLMv3yqRdwdMfEbUFbnGckQ91exvmP/rzfUBFtmdyFigOtOYHAZH3sOKhULY4n
 iaJntN/9Wunf/CPiqcR0hHG7QV8QCnbxO/tC3lSVRWsIP4c65MWkz/zcD4B5TNvb0rl3
 KIIKJFWk66d2H3UkD41GkBJfFhQ6ZLpibuaS3mEEDgAHzucf0WAdbtwaAQrkTWjvxy4C
 ouEw==
X-Gm-Message-State: AOJu0Yygy5UPG88nf8CL5k7NrQGpDsKnu2OXk6yIqsY7HJ8dSaU6ehFf
 douVBbLDeOUYoDXZ7ONTZsi81K/ybhDUgQYeE39h7ZMz9czA0SLFB+B8B2wa6WP9nVHQpkt+N4C
 V
X-Gm-Gg: ASbGncugv6TVNDdPS7kAWnbouj3ztqQUQ5e8dzvoT1kRRCxvPvz9zsu+TM1vk5NOS/p
 wFlkPeF3ggm2jCleNP+9qtNQ7YQey8C63gRZjnJAqlAIqOa0Q/zgPJlJtBggKckV1w/6bknJVHv
 SrzMeOoEtf4K1w4TW0v4VP/dC8Ns7xGemBXyoqsx2bDD6hKiXBGelCWcaPi11N+AZtSCvinZsyr
 LZbUqo2kqDHInA99eyEBz7CTFhpSPdGS8Qdu54auZoYMt3O8SJikfvPDVYTmRySTY2HurUYms+H
 4Rv89TT7CTaE4y0pBV2IGss3eb4zY+VdLUaunxBRNVqNZc4ZO8xOXqwQ3spgd5OevpCar638ZvB
 FxWBlzP8+5Q==
X-Google-Smtp-Source: AGHT+IENrCx5L6GNl3cBsZONpJhD4DdLCmxMKSD8feK3o8qYfl1r04akyrMtukdwtgz00Yd8ZvNDxA==
X-Received: by 2002:a17:90b:544e:b0:2ea:a9ac:eee1 with SMTP id
 98e67ed59e1d1-309f7ddca6fmr6223679a91.10.1745618533637; 
 Fri, 25 Apr 2025 15:02:13 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f7765c88sm2212961a91.28.2025.04.25.15.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:02:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 104/159] tcg: Convert extrh_i64_i32 to TCGOutOpUnary
Date: Fri, 25 Apr 2025 14:53:58 -0700
Message-ID: <20250425215454.886111-105-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

At the same time, make extrh_i64_i32 mandatory.  This closes a hole
in which move arguments could be cast between TCGv_i32 and TCGv_i64.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c                     |  7 +------
 tcg/tcg.c                        |  5 +++--
 tcg/aarch64/tcg-target.c.inc     | 10 ++++++++++
 tcg/i386/tcg-target.c.inc        | 20 +++++++++++++-------
 tcg/loongarch64/tcg-target.c.inc | 15 ++++++++++-----
 tcg/mips/tcg-target.c.inc        | 17 ++++++++++++-----
 tcg/ppc/tcg-target.c.inc         | 12 ++++++++++++
 tcg/riscv/tcg-target.c.inc       | 15 ++++++++++-----
 tcg/s390x/tcg-target.c.inc       | 10 ++++++++++
 tcg/sparc64/tcg-target.c.inc     | 10 ++++++++++
 tcg/tci/tcg-target.c.inc         | 12 ++++++++++++
 11 files changed, 103 insertions(+), 30 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 7ecd1f6c8f..b88f411ece 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2972,14 +2972,9 @@ void tcg_gen_extrh_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
 {
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_mov_i32(ret, TCGV_HIGH(arg));
-    } else if (TCG_TARGET_HAS_extr_i64_i32) {
+    } else {
         tcg_gen_op2(INDEX_op_extrh_i64_i32, TCG_TYPE_I32,
                     tcgv_i32_arg(ret), tcgv_i64_arg(arg));
-    } else {
-        TCGv_i64 t = tcg_temp_ebb_new_i64();
-        tcg_gen_shri_i64(t, arg, 32);
-        tcg_gen_mov_i32(ret, (TCGv_i32)t);
-        tcg_temp_free_i64(t);
     }
 }
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 8fcaf54d32..ce583b824c 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1162,6 +1162,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_ext_i32_i64, TCGOutOpUnary, outop_exts_i32_i64),
     OUTOP(INDEX_op_extu_i32_i64, TCGOutOpUnary, outop_extu_i32_i64),
     OUTOP(INDEX_op_extrl_i64_i32, TCGOutOpUnary, outop_extrl_i64_i32),
+    OUTOP(INDEX_op_extrh_i64_i32, TCGOutOpUnary, outop_extrh_i64_i32),
 #endif
 };
 
@@ -2412,13 +2413,12 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
+    case INDEX_op_extrh_i64_i32:
     case INDEX_op_deposit_i64:
         return TCG_TARGET_REG_BITS == 64;
 
     case INDEX_op_extract2_i64:
         return TCG_TARGET_HAS_extract2_i64;
-    case INDEX_op_extrh_i64_i32:
-        return TCG_TARGET_HAS_extr_i64_i32;
     case INDEX_op_add2_i64:
         return TCG_TARGET_HAS_add2_i64;
     case INDEX_op_sub2_i64:
@@ -5510,6 +5510,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
+    case INDEX_op_extrh_i64_i32:
         assert(TCG_TARGET_REG_BITS == 64);
         /* fall through */
     case INDEX_op_ctpop:
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 8abc5f26da..4ea1aebc5e 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2220,6 +2220,16 @@ static const TCGOutOpBinary outop_eqv = {
     .out_rrr = tgen_eqv,
 };
 
+static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
+{
+    tcg_out_ubfm(s, TCG_TYPE_I64, a0, a1, 32, 63);
+}
+
+static const TCGOutOpUnary outop_extrh_i64_i32 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_extrh_i64_i32,
+};
+
 static void tgen_mul(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 9bae60d3b6..63c9aae26e 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2794,6 +2794,18 @@ static const TCGOutOpBinary outop_eqv = {
     .base.static_constraint = C_NotImplemented,
 };
 
+#if TCG_TARGET_REG_BITS == 64
+static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
+{
+    tcg_out_shifti(s, SHIFT_SHR + P_REXW, a0, 32);
+}
+
+static const TCGOutOpUnary outop_extrh_i64_i32 = {
+    .base.static_constraint = C_O1_I1(r, 0),
+    .out_rr = tgen_extrh_i64_i32,
+};
+#endif /* TCG_TARGET_REG_BITS == 64 */
+
 static void tgen_mul(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -3212,6 +3224,7 @@ static const TCGOutOpExtract outop_sextract = {
     .out_rr = tgen_sextract,
 };
 
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -3363,10 +3376,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
             tcg_out_st(s, TCG_TYPE_I64, a0, a1, a2);
         }
         break;
-
-    case INDEX_op_extrh_i64_i32:
-        tcg_out_shifti(s, SHIFT_SHR + P_REXW, a0, 32);
-        break;
 #endif
 
     OP_32_64(deposit):
@@ -3995,9 +4004,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(re, r);
 
-    case INDEX_op_extrh_i64_i32:
-        return C_O1_I1(r, 0);
-
     case INDEX_op_extract2_i32:
     case INDEX_op_extract2_i64:
         return C_O1_I2(r, 0, r);
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index fae1a58c94..1062eb1883 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1467,6 +1467,16 @@ static const TCGOutOpBinary outop_eqv = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
+{
+    tcg_out_opc_srai_d(s, a0, a1, 32);
+}
+
+static const TCGOutOpUnary outop_extrh_i64_i32 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_extrh_i64_i32,
+};
+
 static void tgen_mul(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -1867,10 +1877,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_b(s, 0);
         break;
 
-    case INDEX_op_extrh_i64_i32:
-        tcg_out_opc_srai_d(s, a0, a1, 32);
-        break;
-
     case INDEX_op_deposit_i32:
         tcg_out_opc_bstrins_w(s, a0, a2, args[3], args[3] + args[4] - 1);
         break;
@@ -2462,7 +2468,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_st_i128:
         return C_O0_I3(r, r, r);
 
-    case INDEX_op_extrh_i64_i32:
     case INDEX_op_ld8s_i32:
     case INDEX_op_ld8s_i64:
     case INDEX_op_ld8u_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 095eb8f672..ad0482902d 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1793,6 +1793,18 @@ static const TCGOutOpBinary outop_eqv = {
     .base.static_constraint = C_NotImplemented,
 };
 
+#if TCG_TARGET_REG_BITS == 64
+static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
+{
+    tcg_out_dsra(s, a0, a1, 32);
+}
+
+static const TCGOutOpUnary outop_extrh_i64_i32 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_extrh_i64_i32,
+};
+#endif
+
 static void tgen_mul(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2315,10 +2327,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, i1, a0, a1, a2);
         break;
 
-    case INDEX_op_extrh_i64_i32:
-        tcg_out_dsra(s, a0, a1, 32);
-        break;
-
     case INDEX_op_deposit_i32:
         tcg_out_opc_bf(s, OPC_INS, a0, a2, args[3] + args[4] - 1, args[3]);
         break;
@@ -2388,7 +2396,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_extrh_i64_i32:
         return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index bb03efe055..ba6d7556f7 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2965,6 +2965,18 @@ static void tgen_eqv(TCGContext *s, TCGType type,
     tcg_out32(s, EQV | SAB(a1, a0, a2));
 }
 
+#if TCG_TARGET_REG_BITS == 64
+static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
+{
+    tcg_out_shri64(s, a0, a1, 32);
+}
+
+static const TCGOutOpUnary outop_extrh_i64_i32 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_extrh_i64_i32,
+};
+#endif
+
 static void tgen_divs(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 76ad2df410..46b4e1167c 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2151,6 +2151,16 @@ static const TCGOutOpBinary outop_eqv = {
     .out_rrr = tgen_eqv,
 };
 
+static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
+{
+    tcg_out_opc_imm(s, OPC_SRAI, a0, a1, 32);
+}
+
+static const TCGOutOpUnary outop_extrh_i64_i32 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_extrh_i64_i32,
+};
+
 static void tgen_mul(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2619,10 +2629,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_st(s, a0, a1, a2, TCG_TYPE_I64);
         break;
 
-    case INDEX_op_extrh_i64_i32:
-        tcg_out_opc_imm(s, OPC_SRAI, a0, a1, 32);
-        break;
-
     case INDEX_op_mb:
         tcg_out_mb(s, a0);
         break;
@@ -2871,7 +2877,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_extrh_i64_i32:
         return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 1ea041c75f..3b3749efd3 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2409,6 +2409,16 @@ static const TCGOutOpBinary outop_eqv = {
     .out_rrr = tgen_eqv,
 };
 
+static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
+{
+    tcg_out_sh64(s, RSY_SRLG, a0, a1, TCG_REG_NONE, 32);
+}
+
+static const TCGOutOpUnary outop_extrh_i64_i32 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_extrh_i64_i32,
+};
+
 static void tgen_mul(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index d52907f7e3..c1cce7c196 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1501,6 +1501,16 @@ static const TCGOutOpBinary outop_eqv = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
+{
+    tcg_out_arithi(s, a0, a1, 32, SHIFT_SRLX);
+}
+
+static const TCGOutOpUnary outop_extrh_i64_i32 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_extrh_i64_i32,
+};
+
 static void tgen_mul(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index e9b46d5e66..d84d01e098 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -670,6 +670,18 @@ static const TCGOutOpBinary outop_eqv = {
     .out_rrr = tgen_eqv,
 };
 
+#if TCG_TARGET_REG_BITS == 64
+static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
+{
+    tcg_out_extract(s, TCG_TYPE_I64, a0, a1, 32, 32);
+}
+
+static const TCGOutOpUnary outop_extrh_i64_i32 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_extrh_i64_i32,
+};
+#endif
+
 static void tgen_mul(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-- 
2.43.0


