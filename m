Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979F0D4A5F7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgacF-0001Ep-Nf; Thu, 15 Jan 2026 22:35:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgacB-00010H-Of
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:35:11 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgac9-0006As-Nv
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:35:11 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-81f223c70d8so1344675b3a.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534508; x=1769139308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UXwXqWP+qbBtQcQ3awqxzmtTcS0rN/AzxMHqU1weZEg=;
 b=tG7JfE4ZOQOPNyGjcx0AQiCFvEX3ksmgsIXx4WJwvm2si9vE4vmFDyMK45PFEjWa8R
 dUeLey4GqH9ZQKUXNQlRn3dCxq7E0vFMJ37XMhyaC/ZEDV+oqL1/ZfV9ERwj0hrFE28V
 W8MOJy1lp5aIWvX902jPJDrDvdctFnUY6pF59ywesO2H4Ui6Prh12JrfblHXHXMjxzps
 T81pIQgBu85UvDALSXvgb1CAN2+TTpBBc+Ao0BidupkYdNm+MuAhZbYs1rRfPlPrEeCf
 5ez0M6D1D09kLTmxn5aBBUZ9ldOmHA6NsvX7ImDLE4MMA+m/AcI0hgopHB+yuLc0AEUW
 aV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534508; x=1769139308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UXwXqWP+qbBtQcQ3awqxzmtTcS0rN/AzxMHqU1weZEg=;
 b=a8IJ20r5hGUor4PZ9p13WRZ0Fv/OsOk1yUIRKi12wFMSSfGNL9Y3VvgGu6mDLiIi9W
 Vw3Et9BO03ATwBzP0T8FhMA+UFkCg7I8QVFrjpb1MY7kOnOCw8LbxkuMXmXiMt9eSCs3
 YOC8PtHPmtR1Fjc1lW6lbS5EUadd5JyPQ6pugTBslU4n9J7pLtFlk1UJhF3MlyQHj5bo
 GlAy1BsqI4PO7/KJabrcF7iDfULvnJodT/L3QjnjHAL79IhAe+OYKoaEenhmkhtvoH/H
 lenqO37BNSSGCKqiKs8JaX3CpQw6Rq58o97MFMugif8vCRrY51dRIGhWT2l0PGmKJ+Sp
 8o6A==
X-Gm-Message-State: AOJu0YxOFijoS7coszPYSBoGUK9ELmyNY6Rcy+drlUa0scwFTpkSbNpG
 HQh+WOYGTAUAK9AeG0JpQhpbLrrM+ebz07gEE9W93Wif6+7Ambd0KvsctgNCqzNTNE5I1QVlVIT
 BJmiVANKPwQ==
X-Gm-Gg: AY/fxX7pE68MD2Z4fpysWOu6d7vDFmbVq+V5OvV3EhxyA5dC2J05NEWek5MAJA6JMa8
 6wI3TH0ur0WGR3+G9GKOl44K1rIrBZ08f+j9wYiYoPDeH6YTsSc3xzBDpregUdsDWVcgHexz7fi
 Geh9Nw0aH3pT3vAm03y+RRDHjJvcEkzzQt7ruLsGrCbnMV928+cc9oW8eQeB2b/sCqv1aIQBmsH
 jRznSusJ5CcqjGZrTAoDKFomM5bwqZaNKs9j7o0zBi/N5BjS3SuZtlHAqJey2bigFOPiwJ0p5Wq
 bXGG28IfDVrx82uPA/Q5QL3nsXvyFPt1mBKWhb5Z37hm12A4aL9RF3oWevM/YaKOm/tB4RAFr+y
 n1qjPAf1DiEllSFRC8+xEuzeoHlZyrSMsJfOi1UkKEym7N3TEBJgOBxI3ayIGL3CDuwUUdFy2bO
 ViroF7aKCK+yuNsTVi6Q==
X-Received: by 2002:a05:6a00:9286:b0:81f:4708:b477 with SMTP id
 d2e1a72fcca58-81fa1883638mr1177533b3a.60.1768534508303; 
 Thu, 15 Jan 2026 19:35:08 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:35:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 29/58] tcg/tci: Drop TCG_TARGET_REG_BITS tests
Date: Fri, 16 Jan 2026 14:32:35 +1100
Message-ID: <20260116033305.51162-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tci/tcg-target-has.h |  2 --
 tcg/tci.c                | 50 ++-------------------------------------
 tcg/tci/tcg-target.c.inc | 51 ++++++----------------------------------
 3 files changed, 9 insertions(+), 94 deletions(-)

diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index ab07ce1fcb..64742cf0b7 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -7,9 +7,7 @@
 #ifndef TCG_TARGET_HAS_H
 #define TCG_TARGET_HAS_H
 
-#if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#endif /* TCG_TARGET_REG_BITS == 64 */
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
diff --git a/tcg/tci.c b/tcg/tci.c
index 7f3ba9b5da..f71993c287 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -43,19 +43,6 @@
 
 __thread uintptr_t tci_tb_ptr;
 
-static void tci_write_reg64(tcg_target_ulong *regs, uint32_t high_index,
-                            uint32_t low_index, uint64_t value)
-{
-    regs[low_index] = (uint32_t)value;
-    regs[high_index] = value >> 32;
-}
-
-/* Create a 64 bit value from two 32 bit values. */
-static uint64_t tci_uint64(uint32_t high, uint32_t low)
-{
-    return ((uint64_t)high << 32) + low;
-}
-
 /*
  * Load sets of arguments all at once.  The naming convention is:
  *   tci_args_<arguments>
@@ -352,7 +339,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
         TCGCond condition;
         uint8_t pos, len;
         uint32_t tmp32;
-        uint64_t tmp64, taddr;
+        uint64_t taddr;
         MemOpIdx oi;
         int32_t ofs;
         void *ptr;
@@ -400,10 +387,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
                 }
                 break;
             case 2: /* uint64_t */
-                /*
-                 * For TCG_TARGET_REG_BITS == 32, the register pair
-                 * must stay in host memory order.
-                 */
                 memcpy(&regs[TCG_REG_R0], stack, 8);
                 break;
             case 3: /* Int128 */
@@ -586,21 +569,11 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             break;
         case INDEX_op_muls2:
             tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
-#if TCG_TARGET_REG_BITS == 32
-            tmp64 = (int64_t)(int32_t)regs[r2] * (int32_t)regs[r3];
-            tci_write_reg64(regs, r1, r0, tmp64);
-#else
             muls64(&regs[r0], &regs[r1], regs[r2], regs[r3]);
-#endif
             break;
         case INDEX_op_mulu2:
             tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
-#if TCG_TARGET_REG_BITS == 32
-            tmp64 = (uint64_t)(uint32_t)regs[r2] * (uint32_t)regs[r3];
-            tci_write_reg64(regs, r1, r0, tmp64);
-#else
             mulu64(&regs[r0], &regs[r1], regs[r2], regs[r3]);
-#endif
             break;
 
             /* Arithmetic operations (32 bit). */
@@ -690,7 +663,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = bswap32(regs[r1]);
             break;
-#if TCG_TARGET_REG_BITS == 64
+
             /* Load/store operations (64 bit). */
 
         case INDEX_op_ld32u:
@@ -758,7 +731,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = bswap64(regs[r1]);
             break;
-#endif /* TCG_TARGET_REG_BITS == 64 */
 
             /* QEMU specific operations. */
 
@@ -804,24 +776,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_qemu_st(env, taddr, regs[r0], oi, tb_ptr);
             break;
 
-        case INDEX_op_qemu_ld2:
-            tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
-            tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
-            taddr = regs[r2];
-            oi = regs[r3];
-            tmp64 = tci_qemu_ld(env, taddr, oi, tb_ptr);
-            tci_write_reg64(regs, r1, r0, tmp64);
-            break;
-
-        case INDEX_op_qemu_st2:
-            tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
-            tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
-            tmp64 = tci_uint64(regs[r1], regs[r0]);
-            taddr = regs[r2];
-            oi = regs[r3];
-            tci_qemu_st(env, taddr, tmp64, oi, tb_ptr);
-            break;
-
         case INDEX_op_mb:
             /* Ensure ordering for all kinds */
             smp_mb();
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 8bd8db4401..1b22c70616 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -25,15 +25,9 @@
 /* Used for function call generation. */
 #define TCG_TARGET_CALL_STACK_OFFSET    0
 #define TCG_TARGET_STACK_ALIGN          8
-#if TCG_TARGET_REG_BITS == 32
-# define TCG_TARGET_CALL_ARG_I32        TCG_CALL_ARG_EVEN
-# define TCG_TARGET_CALL_ARG_I64        TCG_CALL_ARG_EVEN
-# define TCG_TARGET_CALL_ARG_I128       TCG_CALL_ARG_EVEN
-#else
-# define TCG_TARGET_CALL_ARG_I32        TCG_CALL_ARG_NORMAL
-# define TCG_TARGET_CALL_ARG_I64        TCG_CALL_ARG_NORMAL
-# define TCG_TARGET_CALL_ARG_I128       TCG_CALL_ARG_NORMAL
-#endif
+#define TCG_TARGET_CALL_ARG_I32         TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_ARG_I64         TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_ARG_I128        TCG_CALL_ARG_NORMAL
 #define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_NORMAL
 
 static TCGConstraintSetIndex
@@ -320,7 +314,7 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg val, TCGReg base,
 {
     TCGOpcode op = INDEX_op_ld;
 
-    if (TCG_TARGET_REG_BITS == 64 && type == TCG_TYPE_I32) {
+    if (type == TCG_TYPE_I32) {
         op = INDEX_op_ld32u;
     }
     tcg_out_ldst(s, op, val, base, offset);
@@ -337,11 +331,9 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
 {
     switch (type) {
     case TCG_TYPE_I32:
-#if TCG_TARGET_REG_BITS == 64
         arg = (int32_t)arg;
         /* fall through */
     case TCG_TYPE_I64:
-#endif
         break;
     default:
         g_assert_not_reached();
@@ -407,13 +399,11 @@ static void tcg_out_ext16u(TCGContext *s, TCGReg rd, TCGReg rs)
 
 static void tcg_out_ext32s(TCGContext *s, TCGReg rd, TCGReg rs)
 {
-    tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
     tcg_out_sextract(s, TCG_TYPE_I64, rd, rs, 0, 32);
 }
 
 static void tcg_out_ext32u(TCGContext *s, TCGReg rd, TCGReg rs)
 {
-    tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
     tcg_out_extract(s, TCG_TYPE_I64, rd, rs, 0, 32);
 }
 
@@ -429,7 +419,6 @@ static void tcg_out_extu_i32_i64(TCGContext *s, TCGReg rd, TCGReg rs)
 
 static void tcg_out_extrl_i64_i32(TCGContext *s, TCGReg rd, TCGReg rs)
 {
-    tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
     tcg_out_mov(s, TCG_TYPE_I32, rd, rs);
 }
 
@@ -654,7 +643,6 @@ static const TCGOutOpBinary outop_eqv = {
     .out_rrr = tgen_eqv,
 };
 
-#if TCG_TARGET_REG_BITS == 64
 static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
 {
     tcg_out_extract(s, TCG_TYPE_I64, a0, a1, 32, 32);
@@ -664,7 +652,6 @@ static const TCGOutOpUnary outop_extrh_i64_i32 = {
     .base.static_constraint = C_O1_I1(r, r),
     .out_rr = tgen_extrh_i64_i32,
 };
-#endif
 
 static void tgen_mul(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
@@ -962,7 +949,6 @@ static const TCGOutOpBswap outop_bswap32 = {
     .out_rr = tgen_bswap32,
 };
 
-#if TCG_TARGET_REG_BITS == 64
 static void tgen_bswap64(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tcg_out_op_rr(s, INDEX_op_bswap64, a0, a1);
@@ -972,7 +958,6 @@ static const TCGOutOpUnary outop_bswap64 = {
     .base.static_constraint = C_O1_I1(r, r),
     .out_rr = tgen_bswap64,
 };
-#endif
 
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
@@ -1101,7 +1086,6 @@ static const TCGOutOpLoad outop_ld16s = {
     .out = tgen_ld16s,
 };
 
-#if TCG_TARGET_REG_BITS == 64
 static void tgen_ld32u(TCGContext *s, TCGType type, TCGReg dest,
                        TCGReg base, ptrdiff_t offset)
 {
@@ -1123,7 +1107,6 @@ static const TCGOutOpLoad outop_ld32s = {
     .base.static_constraint = C_O1_I1(r, r),
     .out = tgen_ld32s,
 };
-#endif
 
 static void tgen_st8(TCGContext *s, TCGType type, TCGReg data,
                      TCGReg base, ptrdiff_t offset)
@@ -1168,18 +1151,8 @@ static const TCGOutOpQemuLdSt outop_qemu_ld = {
     .out = tgen_qemu_ld,
 };
 
-static void tgen_qemu_ld2(TCGContext *s, TCGType type, TCGReg datalo,
-                          TCGReg datahi, TCGReg addr, MemOpIdx oi)
-{
-    tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, oi);
-    tcg_out_op_rrrr(s, INDEX_op_qemu_ld2, datalo, datahi, addr, TCG_REG_TMP);
-}
-
 static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
-    .base.static_constraint =
-        TCG_TARGET_REG_BITS == 64 ? C_NotImplemented : C_O2_I1(r, r, r),
-    .out =
-        TCG_TARGET_REG_BITS == 64 ? NULL : tgen_qemu_ld2,
+    .base.static_constraint = C_NotImplemented,
 };
 
 static void tgen_qemu_st(TCGContext *s, TCGType type, TCGReg data,
@@ -1198,18 +1171,8 @@ static const TCGOutOpQemuLdSt outop_qemu_st = {
     .out = tgen_qemu_st,
 };
 
-static void tgen_qemu_st2(TCGContext *s, TCGType type, TCGReg datalo,
-                          TCGReg datahi, TCGReg addr, MemOpIdx oi)
-{
-    tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, oi);
-    tcg_out_op_rrrr(s, INDEX_op_qemu_st2, datalo, datahi, addr, TCG_REG_TMP);
-}
-
 static const TCGOutOpQemuLdSt2 outop_qemu_st2 = {
-    .base.static_constraint =
-        TCG_TARGET_REG_BITS == 64 ? C_NotImplemented : C_O0_I3(r, r, r),
-    .out =
-        TCG_TARGET_REG_BITS == 64 ? NULL : tgen_qemu_st2,
+    .base.static_constraint = C_NotImplemented,
 };
 
 static void tcg_out_st(TCGContext *s, TCGType type, TCGReg val, TCGReg base,
@@ -1217,7 +1180,7 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg val, TCGReg base,
 {
     TCGOpcode op = INDEX_op_st;
 
-    if (TCG_TARGET_REG_BITS == 64 && type == TCG_TYPE_I32) {
+    if (type == TCG_TYPE_I32) {
         op = INDEX_op_st32;
     }
     tcg_out_ldst(s, op, val, base, offset);
-- 
2.43.0


