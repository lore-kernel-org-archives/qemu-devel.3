Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482F3C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:39:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnuN-0004J7-EN; Sun, 16 Feb 2025 18:18:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntI-0002ej-2Z
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:37 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntE-00062p-9R
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:35 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-220d398bea9so52035405ad.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747850; x=1740352650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jyka5fb/OPj6KKqpwN5UyIc4Ivykz2KAs4lqp3H+uzE=;
 b=yDLdoHU4ro2Pi0dxRjRx2OqV3N0eFuc48Lo6bBFYT9/CaOMILVzeNdJURDYdIYYdtS
 62/hllqwRNJ6TYP2DA9rmv+sj46VbSGAYZn9bTfNpBOO4+N2VtIBHZJQvICTismNMmUS
 4UPJCdkv+n+Au/4LrxyTKJjseEwZIDdlk1Gj50NikS4EkNLHCkLSrTVmEn/F2TurbjP6
 aJEv0UZ1CXrkpvfQtdcjCjbjezkKX8zr30nqaHVg5bXYRIE2exIq6HIUN7yVskyJ6cUB
 FpjA3chx4N7rlxv0U1Ahu6ljVBm7o1gl1NTxYylPTzLVc6X7Nr3ZkLcAty8ikoBMPlP9
 ALgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747850; x=1740352650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jyka5fb/OPj6KKqpwN5UyIc4Ivykz2KAs4lqp3H+uzE=;
 b=iqMqbt6iScWLuugMW53iUSCSDbXbYLsOlFEWTgVU+217HVuDPzT6ayyIvQmUbmX362
 qD3XP+cG1iZYT9G6S410oaMoVCOSiItH+bc7WCJ842/QVxCbOyHtKzcVfXTmHfVaog5Z
 EC9L8O4LADQ/KrI033NoloiEVVnbw15YdFWqkKp/yy1ACWJc4GJxxvymMovf7O04IuH/
 qsrUAd3dNSMW9LnXBemrmbVblyMZ8SGYWV0F7/kqbrK3wVWOfxb5BEz09HcL5zBDl6tH
 PHuJeutC7o7wh/Tp3i8eViCt+HJaiN0WgM510RiOdD4UIFj4bqwv7E2IgMhcJvoo3kOp
 43ZA==
X-Gm-Message-State: AOJu0YxcjBu50/Rq67LYqEE6uxwhikgDRHelHKKGd/r0iHnnJbk24v++
 vLTcEO6g8ix141fJQVoxUjkKEJX1aMNiU+nP+x0/CPZV5mRKh5T9bOy7vTsPjjXJb5gRaKLss43
 b
X-Gm-Gg: ASbGncveLM++glqmZLN4P+6ZBYowcK3p30ZpjAK6b1QtJDHb8Vd2n+hHsQZZQi48qnL
 vcrbljT2C1zEy/gc49VO5Y9sc9wqMsoLaj9WepMNLgXwleoPugnX6h2lT0xLKzLDd7qekpGYDFz
 D7HEJ7OV5slv52i47jcA7yOoG1gSbe1VY17fyaYRkwA3B/8ckwo/3K32NnyiQaLUuPg3z/5UpXX
 JYCefivgs0TK6vWTO7bs43rtAfFFJWK7IdV9tSqoAM9Zqe5T1yNBHVVEPlEUMcnqu5MM0GazIRw
 KxGqktP+eSMv/J54+N/VS6DA0POvQEjrXiefntVdT9OoHBE=
X-Google-Smtp-Source: AGHT+IFHW8OncdxuLiPefceTAdJZEi9lg/hgKfas+hqRedCqI6hIhrFuxx8j3iBLwrQL/oj64FSbzQ==
X-Received: by 2002:a17:903:3d0c:b0:220:d5a4:3ac with SMTP id
 d9443c01a7336-221040d7a6fmr113668125ad.45.1739747849777; 
 Sun, 16 Feb 2025 15:17:29 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2213394d6c8sm5449885ad.181.2025.02.16.15.17.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:17:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 100/162] tcg: Convert deposit to TCGOutOpDeposit
Date: Sun, 16 Feb 2025 15:09:09 -0800
Message-ID: <20250216231012.2808572-101-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
 tcg/tcg.c                        | 33 ++++++++++++++
 tcg/tci.c                        |  8 ++--
 tcg/aarch64/tcg-target.c.inc     | 30 +++++--------
 tcg/arm/tcg-target.c.inc         | 29 ++++++------
 tcg/i386/tcg-target.c.inc        | 76 ++++++++++++++++----------------
 tcg/loongarch64/tcg-target.c.inc | 27 +++++++-----
 tcg/mips/tcg-target.c.inc        | 27 +++++++-----
 tcg/ppc/tcg-target.c.inc         | 44 +++++++++---------
 tcg/riscv/tcg-target.c.inc       |  4 ++
 tcg/s390x/tcg-target.c.inc       | 60 +++++++++++++------------
 tcg/sparc64/tcg-target.c.inc     |  4 ++
 tcg/tci/tcg-target.c.inc         | 19 ++++----
 12 files changed, 206 insertions(+), 155 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index eb5b39dc36..f45d7374b6 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1007,6 +1007,16 @@ typedef struct TCGOutOpBswap {
                    TCGReg a0, TCGReg a1, unsigned flags);
 } TCGOutOpBswap;
 
+typedef struct TCGOutOpDeposit {
+    TCGOutOp base;
+    void (*out_rrr)(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                    TCGReg a2, unsigned ofs, unsigned len);
+    void (*out_rri)(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                    tcg_target_long a2, unsigned ofs, unsigned len);
+    void (*out_rzr)(TCGContext *s, TCGType type, TCGReg a0,
+                    TCGReg a2, unsigned ofs, unsigned len);
+} TCGOutOpDeposit;
+
 typedef struct TCGOutOpDivRem {
     TCGOutOp base;
     void (*out_rr01r)(TCGContext *s, TCGType type,
@@ -1123,6 +1133,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_clz, TCGOutOpBinary, outop_clz),
     OUTOP(INDEX_op_ctpop, TCGOutOpUnary, outop_ctpop),
     OUTOP(INDEX_op_ctz, TCGOutOpBinary, outop_ctz),
+    OUTOP(INDEX_op_deposit_i32, TCGOutOpDeposit, outop_deposit),
+    OUTOP(INDEX_op_deposit_i64, TCGOutOpDeposit, outop_deposit),
     OUTOP(INDEX_op_divs, TCGOutOpBinary, outop_divs),
     OUTOP(INDEX_op_divu, TCGOutOpBinary, outop_divu),
     OUTOP(INDEX_op_divs2, TCGOutOpDivRem, outop_divs2),
@@ -5525,6 +5537,27 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
+    case INDEX_op_deposit_i32:
+    case INDEX_op_deposit_i64:
+        {
+            const TCGOutOpDeposit *out = &outop_deposit;
+
+            if (const_args[2]) {
+                tcg_debug_assert(!const_args[1]);
+                out->out_rri(s, type, new_args[0], new_args[1],
+                             new_args[2], new_args[3], new_args[4]);
+            } else if (const_args[1]) {
+                tcg_debug_assert(new_args[1] == 0);
+                tcg_debug_assert(!const_args[2]);
+                out->out_rzr(s, type, new_args[0], new_args[2],
+                             new_args[3], new_args[4]);
+            } else {
+                out->out_rrr(s, type, new_args[0], new_args[1],
+                             new_args[2], new_args[3], new_args[4]);
+            }
+        }
+        break;
+
     case INDEX_op_divs2:
     case INDEX_op_divu2:
         {
diff --git a/tcg/tci.c b/tcg/tci.c
index 5a07d65db8..595416a192 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -27,6 +27,7 @@
 
 
 #define ctpop_tr    glue(ctpop, TCG_TARGET_REG_BITS)
+#define deposit_tr  glue(deposit, TCG_TARGET_REG_BITS)
 #define extract_tr  glue(extract, TCG_TARGET_REG_BITS)
 #define sextract_tr glue(sextract, TCG_TARGET_REG_BITS)
 
@@ -655,8 +656,9 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             regs[r0] = ror32(regs[r1], regs[r2] & 31);
             break;
         case INDEX_op_deposit_i32:
+        case INDEX_op_deposit_i64:
             tci_args_rrrbb(insn, &r0, &r1, &r2, &pos, &len);
-            regs[r0] = deposit32(regs[r1], pos, len, regs[r2]);
+            regs[r0] = deposit_tr(regs[r1], pos, len, regs[r2]);
             break;
         case INDEX_op_extract:
             tci_args_rrbb(insn, &r0, &r1, &pos, &len);
@@ -770,10 +772,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ror64(regs[r1], regs[r2] & 63);
             break;
-        case INDEX_op_deposit_i64:
-            tci_args_rrrbb(insn, &r0, &r1, &r2, &pos, &len);
-            regs[r0] = deposit64(regs[r1], pos, len, regs[r2]);
-            break;
         case INDEX_op_ext_i32_i64:
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = (int32_t)regs[r1];
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 4ea1aebc5e..62b045c222 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1347,15 +1347,6 @@ static inline void tcg_out_extr(TCGContext *s, TCGType ext, TCGReg rd,
     tcg_out_insn(s, 3403, EXTR, ext, rd, rn, rm, a);
 }
 
-static inline void tcg_out_dep(TCGContext *s, TCGType ext, TCGReg rd,
-                               TCGReg rn, unsigned lsb, unsigned width)
-{
-    unsigned size = ext ? 64 : 32;
-    unsigned a = (size - lsb) & (size - 1);
-    unsigned b = width - 1;
-    tcg_out_bfm(s, ext, rd, rn, a, b);
-}
-
 static void tgen_cmp(TCGContext *s, TCGType ext, TCGCond cond,
                      TCGReg a, TCGReg b)
 {
@@ -2577,6 +2568,18 @@ static const TCGOutOpMovcond outop_movcond = {
     .out = tgen_movcond,
 };
 
+static void tgen_deposit(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                         TCGReg a2, unsigned ofs, unsigned len)
+{
+    unsigned mask = type == TCG_TYPE_I32 ? 31 : 63;
+    tcg_out_bfm(s, type, a0, a2, -ofs & mask, len - 1);
+}
+
+static const TCGOutOpDeposit outop_deposit = {
+    .base.static_constraint = C_O1_I2(r, 0, rz),
+    .out_rrr = tgen_deposit,
+};
+
 static void tgen_extract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
                          unsigned ofs, unsigned len)
 {
@@ -2684,11 +2687,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_qemu_ldst_i128(s, a0, a1, a2, args[3], false);
         break;
 
-    case INDEX_op_deposit_i64:
-    case INDEX_op_deposit_i32:
-        tcg_out_dep(s, ext, a0, a2, args[3], args[4]);
-        break;
-
     case INDEX_op_extract2_i64:
     case INDEX_op_extract2_i32:
         tcg_out_extr(s, ext, a0, a2, a1, args[3]);
@@ -3206,10 +3204,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_st_i128:
         return C_O0_I3(rz, rz, r);
 
-    case INDEX_op_deposit_i32:
-    case INDEX_op_deposit_i64:
-        return C_O1_I2(r, 0, rz);
-
     case INDEX_op_extract2_i32:
     case INDEX_op_extract2_i64:
         return C_O1_I2(r, rz, rz);
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 0e1fe275c3..b3c74c2c1b 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -975,18 +975,27 @@ static void tcg_out_extrl_i64_i32(TCGContext *s, TCGReg rd, TCGReg rn)
     g_assert_not_reached();
 }
 
-static void tcg_out_deposit(TCGContext *s, ARMCond cond, TCGReg rd,
-                            TCGArg a1, int ofs, int len, bool const_a1)
+static void tgen_deposit(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                         TCGReg a2, unsigned ofs, unsigned len)
 {
-    if (const_a1) {
-        /* bfi becomes bfc with rn == 15.  */
-        a1 = 15;
-    }
     /* bfi/bfc */
-    tcg_out32(s, 0x07c00010 | (cond << 28) | (rd << 12) | a1
+    tcg_out32(s, 0x07c00010 | (COND_AL << 28) | (a0 << 12) | a1
               | (ofs << 7) | ((ofs + len - 1) << 16));
 }
 
+static void tgen_depositi(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                          tcg_target_long a2, unsigned ofs, unsigned len)
+{
+    /* bfi becomes bfc with rn == 15.  */
+    tgen_deposit(s, type, a0, a1, 15, ofs, len);
+}
+
+static const TCGOutOpDeposit outop_deposit = {
+    .base.static_constraint = C_O1_I2(r, 0, rZ),
+    .out_rrr = tgen_deposit,
+    .out_rri = tgen_depositi,
+};
+
 static void tgen_extract(TCGContext *s, TCGType type, TCGReg rd, TCGReg rn,
                          unsigned ofs, unsigned len)
 {
@@ -2408,10 +2417,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_st(s, args[0], args[1], args[2], args[3], TCG_TYPE_I64);
         break;
 
-    case INDEX_op_deposit_i32:
-        tcg_out_deposit(s, COND_AL, args[0], args[2],
-                        args[3], args[4], const_args[2]);
-        break;
     case INDEX_op_extract2_i32:
         /* ??? These optimization vs zero should be generic.  */
         /* ??? But we can't substitute 2 for 1 in the opcode stream yet.  */
@@ -2465,8 +2470,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i32:
         return C_O0_I2(r, r);
 
-    case INDEX_op_deposit_i32:
-        return C_O1_I2(r, 0, rZ);
     case INDEX_op_extract2_i32:
         return C_O1_I2(r, rZ, rZ);
     case INDEX_op_add2_i32:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index a932550b2d..328e3deb74 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3150,6 +3150,43 @@ static const TCGOutOpUnary outop_not = {
     .out_rr = tgen_not,
 };
 
+static void tgen_deposit(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                         TCGReg a2, unsigned ofs, unsigned len)
+{
+    if (ofs == 0 && len == 8) {
+        tcg_out_modrm(s, OPC_MOVB_EvGv | P_REXB_R | P_REXB_RM, a2, a0);
+    } else if (ofs == 0 && len == 16) {
+        tcg_out_modrm(s, OPC_MOVL_EvGv | P_DATA16, a2, a0);
+    } else if (TCG_TARGET_REG_BITS == 32 && ofs == 8 && len == 8) {
+        tcg_out_modrm(s, OPC_MOVB_EvGv, a2, a0 + 4);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
+static void tgen_depositi(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                          tcg_target_long a2, unsigned ofs, unsigned len)
+{
+    if (ofs == 0 && len == 8) {
+        tcg_out_opc(s, OPC_MOVB_Ib | P_REXB_RM | LOWREGMASK(a0), 0, a0, 0);
+        tcg_out8(s, a2);
+    } else if (ofs == 0 && len == 16) {
+        tcg_out_opc(s, OPC_MOVL_Iv | P_DATA16 | LOWREGMASK(a0), 0, a0, 0);
+        tcg_out16(s, a2);
+    } else if (TCG_TARGET_REG_BITS == 32 && ofs == 8 && len == 8) {
+        tcg_out8(s, OPC_MOVB_Ib + a0 + 4);
+        tcg_out8(s, a2);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
+static const TCGOutOpDeposit outop_deposit = {
+    .base.static_constraint = C_O1_I2(q, 0, qi),
+    .out_rrr = tgen_deposit,
+    .out_rri = tgen_depositi,
+};
+
 static void tgen_extract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
                          unsigned ofs, unsigned len)
 {
@@ -3230,7 +3267,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const int const_args[TCG_MAX_OP_ARGS])
 {
     TCGArg a0, a1, a2;
-    int const_a2, rexw;
+    int rexw;
 
 #if TCG_TARGET_REG_BITS == 64
 # define OP_32_64(x) \
@@ -3245,7 +3282,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     a0 = args[0];
     a1 = args[1];
     a2 = args[2];
-    const_a2 = const_args[2];
     rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
 
     switch (opc) {
@@ -3378,38 +3414,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
 #endif
 
-    OP_32_64(deposit):
-        if (args[3] == 0 && args[4] == 8) {
-            /* load bits 0..7 */
-            if (const_a2) {
-                tcg_out_opc(s, OPC_MOVB_Ib | P_REXB_RM | LOWREGMASK(a0),
-                            0, a0, 0);
-                tcg_out8(s, a2);
-            } else {
-                tcg_out_modrm(s, OPC_MOVB_EvGv | P_REXB_R | P_REXB_RM, a2, a0);
-            }
-        } else if (TCG_TARGET_REG_BITS == 32 && args[3] == 8 && args[4] == 8) {
-            /* load bits 8..15 */
-            if (const_a2) {
-                tcg_out8(s, OPC_MOVB_Ib + a0 + 4);
-                tcg_out8(s, a2);
-            } else {
-                tcg_out_modrm(s, OPC_MOVB_EvGv, a2, a0 + 4);
-            }
-        } else if (args[3] == 0 && args[4] == 16) {
-            /* load bits 0..15 */
-            if (const_a2) {
-                tcg_out_opc(s, OPC_MOVL_Iv | P_DATA16 | LOWREGMASK(a0),
-                            0, a0, 0);
-                tcg_out16(s, a2);
-            } else {
-                tcg_out_modrm(s, OPC_MOVL_EvGv | P_DATA16, a2, a0);
-            }
-        } else {
-            g_assert_not_reached();
-        }
-        break;
-
     OP_32_64(extract2):
         /* Note that SHRD outputs to the r/m operand.  */
         tcg_out_modrm(s, OPC_SHRD_Ib + rexw, a2, a0);
@@ -4008,10 +4012,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extract2_i64:
         return C_O1_I2(r, 0, r);
 
-    case INDEX_op_deposit_i32:
-    case INDEX_op_deposit_i64:
-        return C_O1_I2(q, 0, qi);
-
     case INDEX_op_add2_i32:
     case INDEX_op_add2_i64:
     case INDEX_op_sub2_i32:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index fdeed82df0..fcede3dd9f 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1797,6 +1797,21 @@ static const TCGOutOpUnary outop_not = {
     .out_rr = tgen_not,
 };
 
+static void tgen_deposit(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                         TCGReg a2, unsigned ofs, unsigned len)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_opc_bstrins_w(s, a0, a2, ofs, ofs + len - 1);
+    } else {
+        tcg_out_opc_bstrins_d(s, a0, a2, ofs, ofs + len - 1);
+    }
+}
+
+static const TCGOutOpDeposit outop_deposit = {
+    .base.static_constraint = C_O1_I2(r, 0, rz),
+    .out_rrr = tgen_deposit,
+};
+
 static void tgen_extract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
                          unsigned ofs, unsigned len)
 {
@@ -1865,13 +1880,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_b(s, 0);
         break;
 
-    case INDEX_op_deposit_i32:
-        tcg_out_opc_bstrins_w(s, a0, a2, args[3], args[3] + args[4] - 1);
-        break;
-    case INDEX_op_deposit_i64:
-        tcg_out_opc_bstrins_d(s, a0, a2, args[3], args[3] + args[4] - 1);
-        break;
-
     case INDEX_op_ld8s_i32:
     case INDEX_op_ld8s_i64:
         tcg_out_ldst(s, OPC_LD_B, a0, a1, a2);
@@ -2478,11 +2486,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_ld_i64:
         return C_O1_I1(r, r);
 
-    case INDEX_op_deposit_i32:
-    case INDEX_op_deposit_i64:
-        /* Must deposit into the same register as input */
-        return C_O1_I2(r, 0, rz);
-
     case INDEX_op_ld_vec:
     case INDEX_op_dupm_vec:
     case INDEX_op_dup_vec:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 0050de8fe9..fb32dac80d 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2221,6 +2221,22 @@ static const TCGOutOpUnary outop_not = {
     .out_rr = tgen_not,
 };
 
+static void tgen_deposit(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                         TCGReg a2, unsigned ofs, unsigned len)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_opc_bf(s, OPC_INS, a0, a2, ofs + len - 1, ofs);
+    } else {
+        tcg_out_opc_bf64(s, OPC_DINS, OPC_DINSM, OPC_DINSU, a0, a2,
+                         ofs + len - 1, ofs);
+    }
+}
+
+static const TCGOutOpDeposit outop_deposit = {
+    .base.static_constraint = C_O1_I2(r, 0, rz),
+    .out_rrr = tgen_deposit,
+};
+
 static void tgen_extract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
                          unsigned ofs, unsigned len)
 {
@@ -2333,14 +2349,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, i1, a0, a1, a2);
         break;
 
-    case INDEX_op_deposit_i32:
-        tcg_out_opc_bf(s, OPC_INS, a0, a2, args[3] + args[4] - 1, args[3]);
-        break;
-    case INDEX_op_deposit_i64:
-        tcg_out_opc_bf64(s, OPC_DINS, OPC_DINSM, OPC_DINSU, a0, a2,
-                         args[3] + args[4] - 1, args[3]);
-        break;
-
     case INDEX_op_qemu_ld_i32:
         tcg_out_qemu_ld(s, a0, 0, a1, a2, TCG_TYPE_I32);
         break;
@@ -2413,9 +2421,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_deposit_i32:
-    case INDEX_op_deposit_i64:
-        return C_O1_I2(r, 0, rz);
     case INDEX_op_add2_i32:
     case INDEX_op_sub2_i32:
         return C_O2_I4(r, r, rz, rz, rN, rN);
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index ba6d7556f7..fc92a4896d 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3429,6 +3429,28 @@ static const TCGOutOpUnary outop_not = {
     .out_rr = tgen_not,
 };
 
+static void tgen_deposit(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                         TCGReg a2, unsigned ofs, unsigned len)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_rlw(s, RLWIMI, a0, a2, ofs, 32 - ofs - len, 31 - ofs);
+    } else {
+        tcg_out_rld(s, RLDIMI, a0, a2, ofs, 64 - ofs - len);
+    }
+}
+
+static void tgen_depositi(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                          tcg_target_long a2, unsigned ofs, unsigned len)
+{
+    tgen_andi(s, type, a0, a1, ~MAKE_64BIT_MASK(ofs, len));
+}
+
+static const TCGOutOpDeposit outop_deposit = {
+    .base.static_constraint = C_O1_I2(r, 0, rZ),
+    .out_rrr = tgen_deposit,
+    .out_rri = tgen_depositi,
+};
+
 static void tgen_extract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
                          unsigned ofs, unsigned len)
 {
@@ -3575,25 +3597,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], false);
         break;
 
-    case INDEX_op_deposit_i32:
-        if (const_args[2]) {
-            uint32_t mask = ((2u << (args[4] - 1)) - 1) << args[3];
-            tcg_out_andi32(s, args[0], args[0], ~mask);
-        } else {
-            tcg_out_rlw(s, RLWIMI, args[0], args[2], args[3],
-                        32 - args[3] - args[4], 31 - args[3]);
-        }
-        break;
-    case INDEX_op_deposit_i64:
-        if (const_args[2]) {
-            uint64_t mask = ((2ull << (args[4] - 1)) - 1) << args[3];
-            tcg_out_andi64(s, args[0], args[0], ~mask);
-        } else {
-            tcg_out_rld(s, RLDIMI, args[0], args[2], args[3],
-                        64 - args[3] - args[4]);
-        }
-        break;
-
 #if TCG_TARGET_REG_BITS == 64
     case INDEX_op_add2_i64:
 #else
@@ -4290,9 +4293,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_deposit_i32:
-    case INDEX_op_deposit_i64:
-        return C_O1_I2(r, 0, rZ);
     case INDEX_op_add2_i64:
     case INDEX_op_add2_i32:
         return C_O2_I4(r, r, r, r, rI, rZM);
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 46b4e1167c..371e0c24c8 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2482,6 +2482,10 @@ static const TCGOutOpUnary outop_not = {
     .out_rr = tgen_not,
 };
 
+static const TCGOutOpDeposit outop_deposit = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_extract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
                          unsigned ofs, unsigned len)
 {
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 3b3749efd3..d72393315d 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -1555,14 +1555,40 @@ static const TCGOutOpMovcond outop_movcond = {
     .out = tgen_movcond,
 };
 
-static void tgen_deposit(TCGContext *s, TCGReg dest, TCGReg src,
-                         int ofs, int len, int z)
+static void tgen_deposit(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                         TCGReg a2, unsigned ofs, unsigned len)
 {
-    int lsb = (63 - ofs);
-    int msb = lsb - (len - 1);
-    tcg_out_risbg(s, dest, src, msb, lsb, ofs, z);
+    unsigned lsb = (63 - ofs);
+    unsigned msb = lsb - (len - 1);
+
+    /*
+     * Since we can't support "0Z" as a constraint, we allow a1 in
+     * any register.  Fix things up as if a matching constraint.
+     */
+    if (a0 != a1) {
+        if (a0 == a2) {
+            tcg_out_mov(s, type, TCG_TMP0, a2);
+            a2 = TCG_TMP0;
+        }
+        tcg_out_mov(s, type, a0, a1);
+    }
+    tcg_out_risbg(s, a0, a2, msb, lsb, ofs, false);
 }
 
+static void tgen_depositz(TCGContext *s, TCGType type, TCGReg a0, TCGReg a2,
+                          unsigned ofs, unsigned len)
+{
+    unsigned lsb = (63 - ofs);
+    unsigned msb = lsb - (len - 1);
+    tcg_out_risbg(s, a0, a2, msb, lsb, ofs, true);
+}
+
+static const TCGOutOpDeposit outop_deposit = {
+    .base.static_constraint = C_O1_I2(r, rZ, r),
+    .out_rrr = tgen_deposit,
+    .out_rzr = tgen_depositz,
+};
+
 static void tgen_extract(TCGContext *s, TCGType type, TCGReg dest,
                          TCGReg src, unsigned ofs, unsigned len)
 {
@@ -2845,7 +2871,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
-    TCGArg a0, a1, a2;
+    TCGArg a0;
 
     switch (opc) {
     case INDEX_op_goto_ptr:
@@ -2977,24 +3003,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_insn(s, RRE, SLBGR, args[1], args[5]);
         break;
 
-    OP_32_64(deposit):
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[1]) {
-            tgen_deposit(s, a0, a2, args[3], args[4], 1);
-        } else {
-            /* Since we can't support "0Z" as a constraint, we allow a1 in
-               any register.  Fix things up as if a matching constraint.  */
-            if (a0 != a1) {
-                if (a0 == a2) {
-                    tcg_out_mov(s, type, TCG_TMP0, a2);
-                    a2 = TCG_TMP0;
-                }
-                tcg_out_mov(s, type, a0, a1);
-            }
-            tgen_deposit(s, a0, a2, args[3], args[4], 0);
-        }
-        break;
-
     case INDEX_op_mb:
         /* The host memory model is quite strong, we simply need to
            serialize the instruction stream.  */
@@ -3489,10 +3497,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_st_i128:
         return C_O0_I3(o, m, r);
 
-    case INDEX_op_deposit_i32:
-    case INDEX_op_deposit_i64:
-        return C_O1_I2(r, rZ, r);
-
     case INDEX_op_add2_i32:
     case INDEX_op_sub2_i32:
         return C_N1_O1_I4(r, r, 0, 1, ri, r);
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index c1cce7c196..741de260e9 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1767,6 +1767,10 @@ static const TCGOutOpUnary outop_not = {
     .out_rr = tgen_not,
 };
 
+static const TCGOutOpDeposit outop_deposit = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_extract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
                          unsigned ofs, unsigned len)
 {
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index d84d01e098..566c2fb0d0 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -66,10 +66,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_deposit_i32:
-    case INDEX_op_deposit_i64:
-        return C_O1_I2(r, r, r);
-
     case INDEX_op_add2_i32:
     case INDEX_op_add2_i64:
     case INDEX_op_sub2_i32:
@@ -623,6 +619,17 @@ static const TCGOutOpBinary outop_ctz = {
     .out_rrr = tgen_ctz,
 };
 
+static void tgen_deposit(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                         TCGReg a2, unsigned ofs, unsigned len)
+{
+    tcg_out_op_rrrbb(s, INDEX_op_deposit_i64, a0, a1, a2, ofs, len);
+}
+
+static const TCGOutOpDeposit outop_deposit = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_deposit,
+};
+
 static void tgen_divs(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -1084,10 +1091,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, opc, args[0], args[1], args[2]);
         break;
 
-    CASE_32_64(deposit)
-        tcg_out_op_rrrbb(s, opc, args[0], args[1], args[2], args[3], args[4]);
-        break;
-
     CASE_32_64(add2)
     CASE_32_64(sub2)
         tcg_out_op_rrrrrr(s, opc, args[0], args[1], args[2],
-- 
2.43.0


