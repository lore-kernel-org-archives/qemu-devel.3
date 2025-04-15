Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C57C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mD2-0003Cy-AJ; Tue, 15 Apr 2025 15:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m67-0000hO-Ey
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:37:35 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m5O-0004eC-Gz
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:37:29 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-736ad42dfd6so4944576b3a.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745784; x=1745350584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z/4fGcubhXn9FAF1IASy9+U0Qw+A0ts1PZDmJtvIqr4=;
 b=taIe/aUYZs2KYZVBG0ndeSK0DQJClEgJn3Rfv6CqNnh+QJ2v5HHURS2dc6ERciyRr1
 Bg9JEv8A7uGrFIGPhi/KxpNwLl9nVLDdphTbkVfARvOp9lpzmBn3oVs9i3OIkVqYG0Ph
 VDJHlTciZbWFYOCdw53qIfSyWmY+pp6+leL781aOMMDkeaDC3yoTULyWaFzzMxMyRn7A
 jieZ7adoW6G+UX5utcxNOW+1fBOBDxjYOHoW8uEmCeWnDv1hS84ebtlJgYPSbgioUTGC
 KJKj60yXRlzWq249Rzh1AcwMYodhEggYU1WUq4U7/xY+b0Isj+PSOhX2ZutQBAjV+199
 vKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745784; x=1745350584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z/4fGcubhXn9FAF1IASy9+U0Qw+A0ts1PZDmJtvIqr4=;
 b=evhulJNSEqem73O773mH5vcgFAQI69TIRLKjv6VvYeiaiRj9T6+NLMM0YiPe94aPU4
 cJwvi05X4FyXxts4FuFhVc1486JkkD+Ri35PNqoZmjuq6oJUYqfHjdsY2jX6jOX7yB8q
 r//X1bphIW7jgnQplj1rFebZELLuN4mKXgAD01kLDTFj/VAWLNzkw8jfq2TWcCPws2cT
 L+tidhBNZCNcKbHRs/001c377++qhipK1anMB2XRDUk/NBmIlINjXOso5cvVA1eqC4EJ
 DUVVck6DC1EcJsKQiIdry6d59iUvTJpsTPorkfN3iPTaPdiSm87YNwgtM9MrlSYAFE43
 CDfQ==
X-Gm-Message-State: AOJu0Ywl2rT7U0h1rttEUQ+sC0nmnG6YORP/GX7NmSCIhyHJvIPFfb/C
 62ShDDVn15CvIjavNfvwlwD7ad9ebPmSja59P7QQw0UmRcOWTl3/L2Ls5DgZY/MtFOYe7hPevtV
 5
X-Gm-Gg: ASbGncv/euWGHtGqtA/9QweltgILbF8gOIx/DQ14Bt9Be3mIA1zMA/cOwBShElc7lyX
 +tWVa00Com4FbdYWz6axTCFsGGJvZpqoWatTAShs4U696IhD2nlpHNKKC962bkTFPBJ3SW/CFS9
 i7zPdGfyH1/P15OZptnyK5K34dbV3ckMAZIQ+qPDdh/6MZCdIetiReLk+Q1qIHgt32vsvfEaqim
 dE6ipczzQg40EaW4/+0UwKRkr/6ACxAR9FEZ+THYfrDdc3HcfSF3+5dT81mBz9t4yinZuSvMn53
 U7Zx9gYFZypmQgMTjJxhfVvh7OH8LQC51VmVEf5oTss3RnsVlwn1DBWGTLg7LI5sGyQxKi4HBXI
 =
X-Google-Smtp-Source: AGHT+IETzTBOoTT4R3YqCtKOGg2cNOko4PuzJDFIplWmDXzHDLR+gDopUisG4pYxH4jj8xDc1JtiJQ==
X-Received: by 2002:a05:6a00:218d:b0:739:4902:e364 with SMTP id
 d2e1a72fcca58-73c1fb0f700mr1077274b3a.19.1744745783512; 
 Tue, 15 Apr 2025 12:36:23 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e34asm9155603b3a.137.2025.04.15.12.36.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:36:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 154/163] tcg: Convert ld to TCGOutOpLoad
Date: Tue, 15 Apr 2025 12:25:05 -0700
Message-ID: <20250415192515.232910-155-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                        |  46 +++++++++++
 tcg/aarch64/tcg-target.c.inc     | 113 ++++++++++++++++-----------
 tcg/arm/tcg-target.c.inc         | 126 ++++++++++++++++---------------
 tcg/i386/tcg-target.c.inc        | 112 ++++++++++++++++-----------
 tcg/loongarch64/tcg-target.c.inc | 104 +++++++++++++++----------
 tcg/mips/tcg-target.c.inc        | 108 ++++++++++++++++----------
 tcg/ppc/tcg-target.c.inc         | 110 +++++++++++++++++----------
 tcg/riscv/tcg-target.c.inc       | 107 ++++++++++++++++----------
 tcg/s390x/tcg-target.c.inc       | 122 +++++++++++++++++-------------
 tcg/sparc64/tcg-target.c.inc     | 101 ++++++++++++++++---------
 tcg/tci/tcg-target.c.inc         |  91 ++++++++++++++++------
 11 files changed, 721 insertions(+), 419 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 3c80ad086c..5e8e8bf791 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1052,6 +1052,12 @@ typedef struct TCGOutOpExtract2 {
                     TCGReg a2, unsigned shr);
 } TCGOutOpExtract2;
 
+typedef struct TCGOutOpLoad {
+    TCGOutOp base;
+    void (*out)(TCGContext *s, TCGType type, TCGReg dest,
+                TCGReg base, intptr_t offset);
+} TCGOutOpLoad;
+
 typedef struct TCGOutOpMovcond {
     TCGOutOp base;
     void (*out)(TCGContext *s, TCGType type, TCGCond cond,
@@ -1142,6 +1148,11 @@ static const TCGOutOp outop_goto_ptr = {
     .static_constraint = C_O0_I1(r),
 };
 
+static const TCGOutOpLoad outop_ld = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tcg_out_ld,
+};
+
 /*
  * Register V as the TCGOutOp for O.
  * This verifies that V is of type T, otherwise give a nice compiler error.
@@ -1173,6 +1184,16 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_extract, TCGOutOpExtract, outop_extract),
     OUTOP(INDEX_op_extract2, TCGOutOpExtract2, outop_extract2),
+    OUTOP(INDEX_op_ld8u_i32, TCGOutOpLoad, outop_ld8u),
+    OUTOP(INDEX_op_ld8u_i64, TCGOutOpLoad, outop_ld8u),
+    OUTOP(INDEX_op_ld8s_i32, TCGOutOpLoad, outop_ld8s),
+    OUTOP(INDEX_op_ld8s_i64, TCGOutOpLoad, outop_ld8s),
+    OUTOP(INDEX_op_ld16u_i32, TCGOutOpLoad, outop_ld16u),
+    OUTOP(INDEX_op_ld16u_i64, TCGOutOpLoad, outop_ld16u),
+    OUTOP(INDEX_op_ld16s_i32, TCGOutOpLoad, outop_ld16s),
+    OUTOP(INDEX_op_ld16s_i64, TCGOutOpLoad, outop_ld16s),
+    OUTOP(INDEX_op_ld_i32, TCGOutOpLoad, outop_ld),
+    OUTOP(INDEX_op_ld_i64, TCGOutOpLoad, outop_ld),
     OUTOP(INDEX_op_movcond, TCGOutOpMovcond, outop_movcond),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
     OUTOP(INDEX_op_muls2, TCGOutOpMul2, outop_muls2),
@@ -1214,6 +1235,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_extu_i32_i64, TCGOutOpUnary, outop_extu_i32_i64),
     OUTOP(INDEX_op_extrl_i64_i32, TCGOutOpUnary, outop_extrl_i64_i32),
     OUTOP(INDEX_op_extrh_i64_i32, TCGOutOpUnary, outop_extrh_i64_i32),
+    OUTOP(INDEX_op_ld32u_i64, TCGOutOpLoad, outop_ld32u),
+    OUTOP(INDEX_op_ld32s_i64, TCGOutOpLoad, outop_ld32s),
 #endif
 };
 
@@ -5738,6 +5761,29 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
+    case INDEX_op_ld32u_i64:
+    case INDEX_op_ld32s_i64:
+        tcg_debug_assert(type == TCG_TYPE_I64);
+        /* fall through */
+    case INDEX_op_ld8u_i32:
+    case INDEX_op_ld8u_i64:
+    case INDEX_op_ld8s_i32:
+    case INDEX_op_ld8s_i64:
+    case INDEX_op_ld16u_i32:
+    case INDEX_op_ld16u_i64:
+    case INDEX_op_ld16s_i32:
+    case INDEX_op_ld16s_i64:
+    case INDEX_op_ld_i32:
+    case INDEX_op_ld_i64:
+        {
+            const TCGOutOpLoad *out =
+                container_of(all_outop[op->opc], TCGOutOpLoad, base);
+
+            tcg_debug_assert(!const_args[1]);
+            out->out(s, type, new_args[0], new_args[1], new_args[2]);
+        }
+        break;
+
     case INDEX_op_muls2:
     case INDEX_op_mulu2:
         {
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 2678e1f176..903a95ad7e 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2770,6 +2770,74 @@ static const TCGOutOpExtract2 outop_extract2 = {
     .out_rrr = tgen_extract2,
 };
 
+static void tgen_ld8u(TCGContext *s, TCGType type, TCGReg dest,
+                      TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, I3312_LDRB, dest, base, offset, 0);
+}
+
+static const TCGOutOpLoad outop_ld8u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld8u,
+};
+
+static void tgen_ld8s(TCGContext *s, TCGType type, TCGReg dest,
+                      TCGReg base, ptrdiff_t offset)
+{
+    AArch64Insn insn = type == TCG_TYPE_I32 ? I3312_LDRSBW : I3312_LDRSBX;
+    tcg_out_ldst(s, insn, dest, base, offset, 0);
+}
+
+static const TCGOutOpLoad outop_ld8s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld8s,
+};
+
+static void tgen_ld16u(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, I3312_LDRH, dest, base, offset, 1);
+}
+
+static const TCGOutOpLoad outop_ld16u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld16u,
+};
+
+static void tgen_ld16s(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    AArch64Insn insn = type == TCG_TYPE_I32 ? I3312_LDRSHW : I3312_LDRSHX;
+    tcg_out_ldst(s, insn, dest, base, offset, 1);
+}
+
+static const TCGOutOpLoad outop_ld16s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld16s,
+};
+
+static void tgen_ld32u(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, I3312_LDRW, dest, base, offset, 2);
+}
+
+static const TCGOutOpLoad outop_ld32u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld32u,
+};
+
+static void tgen_ld32s(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, I3312_LDRSWX, dest, base, offset, 2);
+}
+
+static const TCGOutOpLoad outop_ld32s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld32s,
+};
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -2780,37 +2848,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
     TCGArg a2 = args[2];
 
     switch (opc) {
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8u_i64:
-        tcg_out_ldst(s, I3312_LDRB, a0, a1, a2, 0);
-        break;
-    case INDEX_op_ld8s_i32:
-        tcg_out_ldst(s, I3312_LDRSBW, a0, a1, a2, 0);
-        break;
-    case INDEX_op_ld8s_i64:
-        tcg_out_ldst(s, I3312_LDRSBX, a0, a1, a2, 0);
-        break;
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16u_i64:
-        tcg_out_ldst(s, I3312_LDRH, a0, a1, a2, 1);
-        break;
-    case INDEX_op_ld16s_i32:
-        tcg_out_ldst(s, I3312_LDRSHW, a0, a1, a2, 1);
-        break;
-    case INDEX_op_ld16s_i64:
-        tcg_out_ldst(s, I3312_LDRSHX, a0, a1, a2, 1);
-        break;
-    case INDEX_op_ld_i32:
-    case INDEX_op_ld32u_i64:
-        tcg_out_ldst(s, I3312_LDRW, a0, a1, a2, 2);
-        break;
-    case INDEX_op_ld32s_i64:
-        tcg_out_ldst(s, I3312_LDRSWX, a0, a1, a2, 2);
-        break;
-    case INDEX_op_ld_i64:
-        tcg_out_ldst(s, I3312_LDRX, a0, a1, a2, 3);
-        break;
-
     case INDEX_op_st8_i32:
     case INDEX_op_st8_i64:
         tcg_out_ldst(s, I3312_STRB, a0, a1, a2, 0);
@@ -3294,20 +3331,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8s_i32:
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16s_i32:
-    case INDEX_op_ld_i32:
-    case INDEX_op_ld8u_i64:
-    case INDEX_op_ld8s_i64:
-    case INDEX_op_ld16u_i64:
-    case INDEX_op_ld16s_i64:
-    case INDEX_op_ld32u_i64:
-    case INDEX_op_ld32s_i64:
-    case INDEX_op_ld_i64:
-        return C_O1_I1(r, r);
-
     case INDEX_op_st8_i32:
     case INDEX_op_st16_i32:
     case INDEX_op_st_i32:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 64be0a7e6d..2079dd3bdc 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1084,26 +1084,6 @@ static void tcg_out_st32(TCGContext *s, ARMCond cond,
         tcg_out_st32_12(s, cond, rd, rn, offset);
 }
 
-static void tcg_out_ld16u(TCGContext *s, ARMCond cond,
-                          TCGReg rd, TCGReg rn, int32_t offset)
-{
-    if (offset > 0xff || offset < -0xff) {
-        tcg_out_movi32(s, cond, TCG_REG_TMP, offset);
-        tcg_out_ld16u_r(s, cond, rd, rn, TCG_REG_TMP);
-    } else
-        tcg_out_ld16u_8(s, cond, rd, rn, offset);
-}
-
-static void tcg_out_ld16s(TCGContext *s, ARMCond cond,
-                          TCGReg rd, TCGReg rn, int32_t offset)
-{
-    if (offset > 0xff || offset < -0xff) {
-        tcg_out_movi32(s, cond, TCG_REG_TMP, offset);
-        tcg_out_ld16s_r(s, cond, rd, rn, TCG_REG_TMP);
-    } else
-        tcg_out_ld16s_8(s, cond, rd, rn, offset);
-}
-
 static void tcg_out_st16(TCGContext *s, ARMCond cond,
                          TCGReg rd, TCGReg rn, int32_t offset)
 {
@@ -1114,26 +1094,6 @@ static void tcg_out_st16(TCGContext *s, ARMCond cond,
         tcg_out_st16_8(s, cond, rd, rn, offset);
 }
 
-static void tcg_out_ld8u(TCGContext *s, ARMCond cond,
-                         TCGReg rd, TCGReg rn, int32_t offset)
-{
-    if (offset > 0xfff || offset < -0xfff) {
-        tcg_out_movi32(s, cond, TCG_REG_TMP, offset);
-        tcg_out_ld8_r(s, cond, rd, rn, TCG_REG_TMP);
-    } else
-        tcg_out_ld8_12(s, cond, rd, rn, offset);
-}
-
-static void tcg_out_ld8s(TCGContext *s, ARMCond cond,
-                         TCGReg rd, TCGReg rn, int32_t offset)
-{
-    if (offset > 0xff || offset < -0xff) {
-        tcg_out_movi32(s, cond, TCG_REG_TMP, offset);
-        tcg_out_ld8s_r(s, cond, rd, rn, TCG_REG_TMP);
-    } else
-        tcg_out_ld8s_8(s, cond, rd, rn, offset);
-}
-
 static void tcg_out_st8(TCGContext *s, ARMCond cond,
                         TCGReg rd, TCGReg rn, int32_t offset)
 {
@@ -2524,26 +2484,75 @@ static const TCGOutOpExtract2 outop_extract2 = {
     .out_rrr = tgen_extract2,
 };
 
+static void tgen_ld8u(TCGContext *s, TCGType type, TCGReg rd,
+                      TCGReg rn, ptrdiff_t offset)
+{
+    if (offset > 0xfff || offset < -0xfff) {
+        tcg_out_movi32(s, COND_AL, TCG_REG_TMP, offset);
+        tcg_out_ld8_r(s, COND_AL, rd, rn, TCG_REG_TMP);
+    } else {
+        tcg_out_ld8_12(s, COND_AL, rd, rn, offset);
+    }
+}
+
+static const TCGOutOpLoad outop_ld8u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld8u,
+};
+
+static void tgen_ld8s(TCGContext *s, TCGType type, TCGReg rd,
+                      TCGReg rn, ptrdiff_t offset)
+{
+    if (offset > 0xff || offset < -0xff) {
+        tcg_out_movi32(s, COND_AL, TCG_REG_TMP, offset);
+        tcg_out_ld8s_r(s, COND_AL, rd, rn, TCG_REG_TMP);
+    } else {
+        tcg_out_ld8s_8(s, COND_AL, rd, rn, offset);
+    }
+}
+
+static const TCGOutOpLoad outop_ld8s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld8s,
+};
+
+static void tgen_ld16u(TCGContext *s, TCGType type, TCGReg rd,
+                       TCGReg rn, ptrdiff_t offset)
+{
+    if (offset > 0xff || offset < -0xff) {
+        tcg_out_movi32(s, COND_AL, TCG_REG_TMP, offset);
+        tcg_out_ld16u_r(s, COND_AL, rd, rn, TCG_REG_TMP);
+    } else {
+        tcg_out_ld16u_8(s, COND_AL, rd, rn, offset);
+    }
+}
+
+static const TCGOutOpLoad outop_ld16u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld16u,
+};
+
+static void tgen_ld16s(TCGContext *s, TCGType type, TCGReg rd,
+                       TCGReg rn, ptrdiff_t offset)
+{
+    if (offset > 0xff || offset < -0xff) {
+        tcg_out_movi32(s, COND_AL, TCG_REG_TMP, offset);
+        tcg_out_ld16s_r(s, COND_AL, rd, rn, TCG_REG_TMP);
+    } else {
+        tcg_out_ld16s_8(s, COND_AL, rd, rn, offset);
+    }
+}
+
+static const TCGOutOpLoad outop_ld16s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld16s,
+};
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
     switch (opc) {
-    case INDEX_op_ld8u_i32:
-        tcg_out_ld8u(s, COND_AL, args[0], args[1], args[2]);
-        break;
-    case INDEX_op_ld8s_i32:
-        tcg_out_ld8s(s, COND_AL, args[0], args[1], args[2]);
-        break;
-    case INDEX_op_ld16u_i32:
-        tcg_out_ld16u(s, COND_AL, args[0], args[1], args[2]);
-        break;
-    case INDEX_op_ld16s_i32:
-        tcg_out_ld16s(s, COND_AL, args[0], args[1], args[2]);
-        break;
-    case INDEX_op_ld_i32:
-        tcg_out_ld32u(s, COND_AL, args[0], args[1], args[2]);
-        break;
     case INDEX_op_st8_i32:
         tcg_out_st8(s, COND_AL, args[0], args[1], args[2]);
         break;
@@ -2580,13 +2589,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8s_i32:
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16s_i32:
-    case INDEX_op_ld_i32:
-        return C_O1_I1(r, r);
-
     case INDEX_op_st8_i32:
     case INDEX_op_st16_i32:
     case INDEX_op_st_i32:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 5ea4a44264..d16ddcb940 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3419,13 +3419,81 @@ static const TCGOutOpExtract2 outop_extract2 = {
     .out_rrr = tgen_extract2,
 };
 
+static void tgen_ld8u(TCGContext *s, TCGType type, TCGReg dest,
+                      TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_modrm_offset(s, OPC_MOVZBL, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld8u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld8u,
+};
+
+static void tgen_ld8s(TCGContext *s, TCGType type, TCGReg dest,
+                      TCGReg base, ptrdiff_t offset)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tcg_out_modrm_offset(s, OPC_MOVSBL + rexw, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld8s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld8s,
+};
+
+static void tgen_ld16u(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_modrm_offset(s, OPC_MOVZWL, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld16u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld16u,
+};
+
+static void tgen_ld16s(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tcg_out_modrm_offset(s, OPC_MOVSWL + rexw, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld16s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld16s,
+};
+
+#if TCG_TARGET_REG_BITS == 64
+static void tgen_ld32u(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_modrm_offset(s, OPC_MOVL_GvEv, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld32u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld32u,
+};
+
+static void tgen_ld32s(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_modrm_offset(s, OPC_MOVSLQ, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld32s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld32s,
+};
+#endif
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
     TCGArg a0, a1, a2;
-    int rexw;
 
 #if TCG_TARGET_REG_BITS == 64
 # define OP_32_64(x) \
@@ -3440,30 +3508,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     a0 = args[0];
     a1 = args[1];
     a2 = args[2];
-    rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
 
     switch (opc) {
-    OP_32_64(ld8u):
-        /* Note that we can ignore REXW for the zero-extend to 64-bit.  */
-        tcg_out_modrm_offset(s, OPC_MOVZBL, a0, a1, a2);
-        break;
-    OP_32_64(ld8s):
-        tcg_out_modrm_offset(s, OPC_MOVSBL + rexw, a0, a1, a2);
-        break;
-    OP_32_64(ld16u):
-        /* Note that we can ignore REXW for the zero-extend to 64-bit.  */
-        tcg_out_modrm_offset(s, OPC_MOVZWL, a0, a1, a2);
-        break;
-    OP_32_64(ld16s):
-        tcg_out_modrm_offset(s, OPC_MOVSWL + rexw, a0, a1, a2);
-        break;
-#if TCG_TARGET_REG_BITS == 64
-    case INDEX_op_ld32u_i64:
-#endif
-    case INDEX_op_ld_i32:
-        tcg_out_ld(s, TCG_TYPE_I32, a0, a1, a2);
-        break;
-
     OP_32_64(st8):
         if (const_args[0]) {
             tcg_out_modrm_offset(s, OPC_MOVB_EvIz, 0, a1, a2);
@@ -3524,12 +3570,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
 
 #if TCG_TARGET_REG_BITS == 64
-    case INDEX_op_ld32s_i64:
-        tcg_out_modrm_offset(s, OPC_MOVSLQ, a0, a1, a2);
-        break;
-    case INDEX_op_ld_i64:
-        tcg_out_ld(s, TCG_TYPE_I64, a0, a1, a2);
-        break;
     case INDEX_op_st_i64:
         if (const_args[0]) {
             tcg_out_modrm_offset(s, OPC_MOVL_EvIz | P_REXW, 0, a1, a2);
@@ -4095,20 +4135,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8u_i64:
-    case INDEX_op_ld8s_i32:
-    case INDEX_op_ld8s_i64:
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16u_i64:
-    case INDEX_op_ld16s_i32:
-    case INDEX_op_ld16s_i64:
-    case INDEX_op_ld_i32:
-    case INDEX_op_ld32u_i64:
-    case INDEX_op_ld32s_i64:
-    case INDEX_op_ld_i64:
-        return C_O1_I1(r, r);
-
     case INDEX_op_st8_i32:
     case INDEX_op_st8_i64:
         return C_O0_I2(qi, r);
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 1bdce25cf4..250556b137 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1905,6 +1905,71 @@ static const TCGOutOpExtract2 outop_extract2 = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_ld8u(TCGContext *s, TCGType type, TCGReg dest,
+                      TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, OPC_LD_BU, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld8u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld8u,
+};
+
+static void tgen_ld8s(TCGContext *s, TCGType type, TCGReg dest,
+                      TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, OPC_LD_B, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld8s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld8s,
+};
+
+static void tgen_ld16u(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, OPC_LD_HU, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld16u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld16u,
+};
+
+static void tgen_ld16s(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, OPC_LD_H, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld16s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld16s,
+};
+
+static void tgen_ld32u(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, OPC_LD_WU, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld32u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld32u,
+};
+
+static void tgen_ld32s(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, OPC_LD_W, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld32s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld32s,
+};
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1916,33 +1981,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     TCGArg a3 = args[3];
 
     switch (opc) {
-    case INDEX_op_ld8s_i32:
-    case INDEX_op_ld8s_i64:
-        tcg_out_ldst(s, OPC_LD_B, a0, a1, a2);
-        break;
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8u_i64:
-        tcg_out_ldst(s, OPC_LD_BU, a0, a1, a2);
-        break;
-    case INDEX_op_ld16s_i32:
-    case INDEX_op_ld16s_i64:
-        tcg_out_ldst(s, OPC_LD_H, a0, a1, a2);
-        break;
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16u_i64:
-        tcg_out_ldst(s, OPC_LD_HU, a0, a1, a2);
-        break;
-    case INDEX_op_ld_i32:
-    case INDEX_op_ld32s_i64:
-        tcg_out_ldst(s, OPC_LD_W, a0, a1, a2);
-        break;
-    case INDEX_op_ld32u_i64:
-        tcg_out_ldst(s, OPC_LD_WU, a0, a1, a2);
-        break;
-    case INDEX_op_ld_i64:
-        tcg_out_ldst(s, OPC_LD_D, a0, a1, a2);
-        break;
-
     case INDEX_op_st8_i32:
     case INDEX_op_st8_i64:
         tcg_out_ldst(s, OPC_ST_B, a0, a1, a2);
@@ -2503,18 +2541,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_st_i128:
         return C_O0_I3(r, r, r);
 
-    case INDEX_op_ld8s_i32:
-    case INDEX_op_ld8s_i64:
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8u_i64:
-    case INDEX_op_ld16s_i32:
-    case INDEX_op_ld16s_i64:
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16u_i64:
-    case INDEX_op_ld32s_i64:
-    case INDEX_op_ld32u_i64:
-    case INDEX_op_ld_i32:
-    case INDEX_op_ld_i64:
     case INDEX_op_qemu_ld_i32:
     case INDEX_op_qemu_ld_i64:
         return C_O1_I1(r, r);
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 9455a0a17b..21ed11b78d 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2274,6 +2274,74 @@ static const TCGOutOpExtract2 outop_extract2 = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_ld8u(TCGContext *s, TCGType type, TCGReg dest,
+                      TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, OPC_LBU, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld8u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld8u,
+};
+
+static void tgen_ld8s(TCGContext *s, TCGType type, TCGReg dest,
+                      TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, OPC_LB, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld8s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld8s,
+};
+
+static void tgen_ld16u(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, OPC_LHU, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld16u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld16u,
+};
+
+static void tgen_ld16s(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, OPC_LH, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld16s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld16s,
+};
+
+#if TCG_TARGET_REG_BITS == 64
+static void tgen_ld32u(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, OPC_LWU, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld32u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld32u,
+};
+
+static void tgen_ld32s(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, OPC_LW, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld32s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld32s,
+};
+#endif
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2287,32 +2355,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     a2 = args[2];
 
     switch (opc) {
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8u_i64:
-        i1 = OPC_LBU;
-        goto do_ldst;
-    case INDEX_op_ld8s_i32:
-    case INDEX_op_ld8s_i64:
-        i1 = OPC_LB;
-        goto do_ldst;
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16u_i64:
-        i1 = OPC_LHU;
-        goto do_ldst;
-    case INDEX_op_ld16s_i32:
-    case INDEX_op_ld16s_i64:
-        i1 = OPC_LH;
-        goto do_ldst;
-    case INDEX_op_ld_i32:
-    case INDEX_op_ld32s_i64:
-        i1 = OPC_LW;
-        goto do_ldst;
-    case INDEX_op_ld32u_i64:
-        i1 = OPC_LWU;
-        goto do_ldst;
-    case INDEX_op_ld_i64:
-        i1 = OPC_LD;
-        goto do_ldst;
     case INDEX_op_st8_i32:
     case INDEX_op_st8_i64:
         i1 = OPC_SB;
@@ -2365,20 +2407,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8s_i32:
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16s_i32:
-    case INDEX_op_ld_i32:
-    case INDEX_op_ld8u_i64:
-    case INDEX_op_ld8s_i64:
-    case INDEX_op_ld16u_i64:
-    case INDEX_op_ld16s_i64:
-    case INDEX_op_ld32s_i64:
-    case INDEX_op_ld32u_i64:
-    case INDEX_op_ld_i64:
-        return C_O1_I1(r, r);
-
     case INDEX_op_st8_i32:
     case INDEX_op_st16_i32:
     case INDEX_op_st_i32:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index a2a5b1e570..275c5a90a5 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3677,39 +3677,81 @@ static const TCGOutOpExtract2 outop_extract2 = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_ld8u(TCGContext *s, TCGType type, TCGReg dest,
+                      TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_mem_long(s, LBZ, LBZX, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld8u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld8u,
+};
+
+static void tgen_ld8s(TCGContext *s, TCGType type, TCGReg dest,
+                      TCGReg base, ptrdiff_t offset)
+{
+    tgen_ld8u(s, type, dest, base, offset);
+    tcg_out_ext8s(s, type, dest, dest);
+}
+
+static const TCGOutOpLoad outop_ld8s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld8s,
+};
+
+static void tgen_ld16u(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_mem_long(s, LHZ, LHZX, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld16u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld16u,
+};
+
+static void tgen_ld16s(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_mem_long(s, LHA, LHAX, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld16s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld16s,
+};
+
+#if TCG_TARGET_REG_BITS == 64
+static void tgen_ld32u(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_mem_long(s, LWZ, LWZX, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld32u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld32u,
+};
+
+static void tgen_ld32s(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_mem_long(s, LWA, LWAX, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld32s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld32s,
+};
+#endif
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
     switch (opc) {
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8u_i64:
-        tcg_out_mem_long(s, LBZ, LBZX, args[0], args[1], args[2]);
-        break;
-    case INDEX_op_ld8s_i32:
-    case INDEX_op_ld8s_i64:
-        tcg_out_mem_long(s, LBZ, LBZX, args[0], args[1], args[2]);
-        tcg_out_ext8s(s, TCG_TYPE_REG, args[0], args[0]);
-        break;
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16u_i64:
-        tcg_out_mem_long(s, LHZ, LHZX, args[0], args[1], args[2]);
-        break;
-    case INDEX_op_ld16s_i32:
-    case INDEX_op_ld16s_i64:
-        tcg_out_mem_long(s, LHA, LHAX, args[0], args[1], args[2]);
-        break;
-    case INDEX_op_ld_i32:
-    case INDEX_op_ld32u_i64:
-        tcg_out_mem_long(s, LWZ, LWZX, args[0], args[1], args[2]);
-        break;
-    case INDEX_op_ld32s_i64:
-        tcg_out_mem_long(s, LWA, LWAX, args[0], args[1], args[2]);
-        break;
-    case INDEX_op_ld_i64:
-        tcg_out_mem_long(s, LD, LDX, args[0], args[1], args[2]);
-        break;
     case INDEX_op_st8_i32:
     case INDEX_op_st8_i64:
         tcg_out_mem_long(s, STB, STBX, args[0], args[1], args[2]);
@@ -4373,20 +4415,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8s_i32:
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16s_i32:
-    case INDEX_op_ld_i32:
-    case INDEX_op_ld8u_i64:
-    case INDEX_op_ld8s_i64:
-    case INDEX_op_ld16u_i64:
-    case INDEX_op_ld16s_i64:
-    case INDEX_op_ld32u_i64:
-    case INDEX_op_ld32s_i64:
-    case INDEX_op_ld_i64:
-        return C_O1_I1(r, r);
-
     case INDEX_op_st8_i32:
     case INDEX_op_st16_i32:
     case INDEX_op_st_i32:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index c1bfd93569..5b987c930f 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2530,6 +2530,72 @@ static const TCGOutOpExtract2 outop_extract2 = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_ld8u(TCGContext *s, TCGType type, TCGReg dest,
+                      TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, OPC_LBU, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld8u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld8u,
+};
+
+static void tgen_ld8s(TCGContext *s, TCGType type, TCGReg dest,
+                      TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, OPC_LB, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld8s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld8s,
+};
+
+static void tgen_ld16u(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, OPC_LHU, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld16u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld16u,
+};
+
+static void tgen_ld16s(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, OPC_LH, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld16s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld16s,
+};
+
+static void tgen_ld32u(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, OPC_LWU, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld32u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld32u,
+};
+
+static void tgen_ld32s(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, OPC_LW, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld32s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld32s,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2540,33 +2606,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     TCGArg a2 = args[2];
 
     switch (opc) {
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8u_i64:
-        tcg_out_ldst(s, OPC_LBU, a0, a1, a2);
-        break;
-    case INDEX_op_ld8s_i32:
-    case INDEX_op_ld8s_i64:
-        tcg_out_ldst(s, OPC_LB, a0, a1, a2);
-        break;
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16u_i64:
-        tcg_out_ldst(s, OPC_LHU, a0, a1, a2);
-        break;
-    case INDEX_op_ld16s_i32:
-    case INDEX_op_ld16s_i64:
-        tcg_out_ldst(s, OPC_LH, a0, a1, a2);
-        break;
-    case INDEX_op_ld32u_i64:
-        tcg_out_ldst(s, OPC_LWU, a0, a1, a2);
-        break;
-    case INDEX_op_ld_i32:
-    case INDEX_op_ld32s_i64:
-        tcg_out_ldst(s, OPC_LW, a0, a1, a2);
-        break;
-    case INDEX_op_ld_i64:
-        tcg_out_ldst(s, OPC_LD, a0, a1, a2);
-        break;
-
     case INDEX_op_st8_i32:
     case INDEX_op_st8_i64:
         tcg_out_ldst(s, OPC_SB, a0, a1, a2);
@@ -2825,20 +2864,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8s_i32:
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16s_i32:
-    case INDEX_op_ld_i32:
-    case INDEX_op_ld8u_i64:
-    case INDEX_op_ld8s_i64:
-    case INDEX_op_ld16u_i64:
-    case INDEX_op_ld16s_i64:
-    case INDEX_op_ld32s_i64:
-    case INDEX_op_ld32u_i64:
-    case INDEX_op_ld_i64:
-        return C_O1_I1(r, r);
-
     case INDEX_op_st8_i32:
     case INDEX_op_st16_i32:
     case INDEX_op_st_i32:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 2b2e00c609..fe7665b21d 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -3030,6 +3030,76 @@ static void tcg_out_mb(TCGContext *s, unsigned a0)
     }
 }
 
+static void tgen_ld8u(TCGContext *s, TCGType type, TCGReg dest,
+                      TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_mem(s, 0, RXY_LLGC, dest, base, TCG_REG_NONE, offset);
+}
+
+static const TCGOutOpLoad outop_ld8u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld8u,
+};
+
+static void tgen_ld8s(TCGContext *s, TCGType type, TCGReg dest,
+                      TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_mem(s, 0, RXY_LGB, dest, base, TCG_REG_NONE, offset);
+}
+
+static const TCGOutOpLoad outop_ld8s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld8s,
+};
+
+static void tgen_ld16u(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_mem(s, 0, RXY_LLGH, dest, base, TCG_REG_NONE, offset);
+}
+
+static const TCGOutOpLoad outop_ld16u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld16u,
+};
+
+static void tgen_ld16s(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_mem(s, RX_LH, RXY_LHY, dest, base, TCG_REG_NONE, offset);
+    } else {
+        tcg_out_mem(s, 0, RXY_LGH, dest, base, TCG_REG_NONE, offset);
+    }
+}
+
+static const TCGOutOpLoad outop_ld16s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld16s,
+};
+
+static void tgen_ld32u(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_mem(s, 0, RXY_LLGF, dest, base, TCG_REG_NONE, offset);
+}
+
+static const TCGOutOpLoad outop_ld32u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld32u,
+};
+
+static void tgen_ld32s(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_mem(s, 0, RXY_LGF, dest, base, TCG_REG_NONE, offset);
+}
+
+static const TCGOutOpLoad outop_ld32s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld32s,
+};
+
 # define OP_32_64(x) \
         case glue(glue(INDEX_op_,x),_i32): \
         case glue(glue(INDEX_op_,x),_i64)
@@ -3039,31 +3109,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const int const_args[TCG_MAX_OP_ARGS])
 {
     switch (opc) {
-    OP_32_64(ld8u):
-        /* ??? LLC (RXY format) is only present with the extended-immediate
-           facility, whereas LLGC is always present.  */
-        tcg_out_mem(s, 0, RXY_LLGC, args[0], args[1], TCG_REG_NONE, args[2]);
-        break;
-
-    OP_32_64(ld8s):
-        /* ??? LB is no smaller than LGB, so no point to using it.  */
-        tcg_out_mem(s, 0, RXY_LGB, args[0], args[1], TCG_REG_NONE, args[2]);
-        break;
-
-    OP_32_64(ld16u):
-        /* ??? LLH (RXY format) is only present with the extended-immediate
-           facility, whereas LLGH is always present.  */
-        tcg_out_mem(s, 0, RXY_LLGH, args[0], args[1], TCG_REG_NONE, args[2]);
-        break;
-
-    case INDEX_op_ld16s_i32:
-        tcg_out_mem(s, RX_LH, RXY_LHY, args[0], args[1], TCG_REG_NONE, args[2]);
-        break;
-
-    case INDEX_op_ld_i32:
-        tcg_out_ld(s, TCG_TYPE_I32, args[0], args[1], args[2]);
-        break;
-
     OP_32_64(st8):
         tcg_out_mem(s, RX_STC, RXY_STCY, args[0], args[1],
                     TCG_REG_NONE, args[2]);
@@ -3097,19 +3142,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], false);
         break;
 
-    case INDEX_op_ld16s_i64:
-        tcg_out_mem(s, 0, RXY_LGH, args[0], args[1], TCG_REG_NONE, args[2]);
-        break;
-    case INDEX_op_ld32u_i64:
-        tcg_out_mem(s, 0, RXY_LLGF, args[0], args[1], TCG_REG_NONE, args[2]);
-        break;
-    case INDEX_op_ld32s_i64:
-        tcg_out_mem(s, 0, RXY_LGF, args[0], args[1], TCG_REG_NONE, args[2]);
-        break;
-    case INDEX_op_ld_i64:
-        tcg_out_ld(s, TCG_TYPE_I64, args[0], args[1], args[2]);
-        break;
-
     case INDEX_op_st32_i64:
         tcg_out_st(s, TCG_TYPE_I32, args[0], args[1], args[2]);
         break;
@@ -3565,20 +3597,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8u_i64:
-    case INDEX_op_ld8s_i32:
-    case INDEX_op_ld8s_i64:
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16u_i64:
-    case INDEX_op_ld16s_i32:
-    case INDEX_op_ld16s_i64:
-    case INDEX_op_ld_i32:
-    case INDEX_op_ld32u_i64:
-    case INDEX_op_ld32s_i64:
-    case INDEX_op_ld_i64:
-        return C_O1_I1(r, r);
-
     case INDEX_op_st8_i32:
     case INDEX_op_st8_i64:
     case INDEX_op_st16_i32:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index bb83279e2c..a6bc4cd85a 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1957,6 +1957,73 @@ static const TCGOutOpExtract2 outop_extract2 = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_ld8u(TCGContext *s, TCGType type, TCGReg dest,
+                      TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, dest, base, offset, LDUB);
+}
+
+static const TCGOutOpLoad outop_ld8u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld8u,
+};
+
+static void tgen_ld8s(TCGContext *s, TCGType type, TCGReg dest,
+                      TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, dest, base, offset, LDSB);
+}
+
+static const TCGOutOpLoad outop_ld8s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld8s,
+};
+
+static void tgen_ld16u(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, dest, base, offset, LDUH);
+}
+
+static const TCGOutOpLoad outop_ld16u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld16u,
+};
+
+static void tgen_ld16s(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, dest, base, offset, LDSH);
+}
+
+static const TCGOutOpLoad outop_ld16s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld16s,
+};
+
+static void tgen_ld32u(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, dest, base, offset, LDUW);
+}
+
+static const TCGOutOpLoad outop_ld32u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld32u,
+};
+
+static void tgen_ld32s(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, dest, base, offset, LDSW);
+}
+
+static const TCGOutOpLoad outop_ld32s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld32s,
+};
+
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -1973,22 +2040,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         glue(glue(case INDEX_op_, x), _i32):    \
         glue(glue(case INDEX_op_, x), _i64)
 
-    OP_32_64(ld8u):
-        tcg_out_ldst(s, a0, a1, a2, LDUB);
-        break;
-    OP_32_64(ld8s):
-        tcg_out_ldst(s, a0, a1, a2, LDSB);
-        break;
-    OP_32_64(ld16u):
-        tcg_out_ldst(s, a0, a1, a2, LDUH);
-        break;
-    OP_32_64(ld16s):
-        tcg_out_ldst(s, a0, a1, a2, LDSH);
-        break;
-    case INDEX_op_ld_i32:
-    case INDEX_op_ld32u_i64:
-        tcg_out_ldst(s, a0, a1, a2, LDUW);
-        break;
     OP_32_64(st8):
         tcg_out_ldst(s, a0, a1, a2, STB);
         break;
@@ -2013,12 +2064,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_st(s, a0, a1, a2, TCG_TYPE_I64);
         break;
 
-    case INDEX_op_ld32s_i64:
-        tcg_out_ldst(s, a0, a1, a2, LDSW);
-        break;
-    case INDEX_op_ld_i64:
-        tcg_out_ldst(s, a0, a1, a2, LDX);
-        break;
     case INDEX_op_st_i64:
         tcg_out_ldst(s, a0, a1, a2, STX);
         break;
@@ -2035,18 +2080,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8u_i64:
-    case INDEX_op_ld8s_i32:
-    case INDEX_op_ld8s_i64:
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16u_i64:
-    case INDEX_op_ld16s_i32:
-    case INDEX_op_ld16s_i64:
-    case INDEX_op_ld_i32:
-    case INDEX_op_ld32u_i64:
-    case INDEX_op_ld32s_i64:
-    case INDEX_op_ld_i64:
     case INDEX_op_qemu_ld_i32:
     case INDEX_op_qemu_ld_i64:
         return C_O1_I1(r, r);
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index d9cd62ed3d..2dcd561b77 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -40,20 +40,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8s_i32:
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16s_i32:
-    case INDEX_op_ld_i32:
-    case INDEX_op_ld8u_i64:
-    case INDEX_op_ld8s_i64:
-    case INDEX_op_ld16u_i64:
-    case INDEX_op_ld16s_i64:
-    case INDEX_op_ld32u_i64:
-    case INDEX_op_ld32s_i64:
-    case INDEX_op_ld_i64:
-        return C_O1_I1(r, r);
-
     case INDEX_op_st8_i32:
     case INDEX_op_st16_i32:
     case INDEX_op_st_i32:
@@ -1143,19 +1129,80 @@ static void tcg_out_br(TCGContext *s, TCGLabel *l)
     tcg_out_op_l(s, INDEX_op_br, l);
 }
 
+static void tgen_ld8u(TCGContext *s, TCGType type, TCGReg dest,
+                      TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, INDEX_op_ld8u_i32, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld8u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld8u,
+};
+
+static void tgen_ld8s(TCGContext *s, TCGType type, TCGReg dest,
+                      TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, INDEX_op_ld8s_i32, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld8s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld8s,
+};
+
+static void tgen_ld16u(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, INDEX_op_ld16u_i32, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld16u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld16u,
+};
+
+static void tgen_ld16s(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, INDEX_op_ld16s_i32, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld16s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld16s,
+};
+
+#if TCG_TARGET_REG_BITS == 64
+static void tgen_ld32u(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, INDEX_op_ld32u_i64, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld32u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld32u,
+};
+
+static void tgen_ld32s(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, INDEX_op_ld32s_i64, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld32s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld32s,
+};
+#endif
+
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
     switch (opc) {
-    CASE_32_64(ld8u)
-    CASE_32_64(ld8s)
-    CASE_32_64(ld16u)
-    CASE_32_64(ld16s)
-    case INDEX_op_ld_i32:
-    CASE_64(ld32u)
-    CASE_64(ld32s)
-    CASE_64(ld)
     CASE_32_64(st8)
     CASE_32_64(st16)
     case INDEX_op_st_i32:
-- 
2.43.0


