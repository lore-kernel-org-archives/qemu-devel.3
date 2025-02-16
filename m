Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60FE3C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnsI-0000AB-Kz; Sun, 16 Feb 2025 18:16:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnqG-0001Iw-Fh
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:14:32 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnq7-0005U6-VU
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:14:28 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-220e989edb6so68617035ad.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747652; x=1740352452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xEBXNPbWvuC/7i9qOxfvFuOMWpxbhcpK3E+NXvrvsYg=;
 b=WtbbWG8fwxjFNpl/azI0wYw58l29fCN59FvBQZtCy1SPMYvgh1R5FLuEgE2VQZs+EV
 MegSe8bZt2lQk32FkQKt4jDq5fTGF7Hlb6X02qkJyZ8glupyGinwH/ZicL++JJ4aGvxb
 F5L0AIL73Z19KHJ+mu19xlImWlzwPF/3014YpLnmddZVpQUYaAqNFx1P8pC3WeWCO5+G
 FBlvH+OH+uVTC7CL/dAFJwB2uPuXERyK1ySTRN28UpjpV8+SFn8p/Wdz2LNo1Df8lWud
 Dgy4tvmNHWzAq12ecLvcVKeEU34k7ew65pw6T8/ziTw5eHgtRqDlEsPL22m3LWzZYMs4
 76YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747652; x=1740352452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xEBXNPbWvuC/7i9qOxfvFuOMWpxbhcpK3E+NXvrvsYg=;
 b=DJhpE9gJby4x0YQiyjk8QUlhmP8Xd0Oh6PdypIjyivbIiaUh7nJ4bITa8xPJf3NlrA
 CvI1ePVQheSwuLESQyu4fFNeIoOg2saJgxQKNCllfCy//3UkwMGUF81hmXKZ4VYYJUVP
 o3v/99s3Q5ArEVIb9KFL32flHoceeyH11IyCuPGT6ZFNRPIV4T5N1EDTZMtB3tmzPqRb
 tanvuQnNz2UN+H7vQUXae9UtLec3QGy2N2EaFReVfKdJ9EGlufbhPPQ214TIPxL0Vn2k
 pwfQGRN++x5wqQCjCFAQXHlqHOH6HTMSmVkN7wweq2OOjMcwNQJAJQUvudqP1Ggfpc+B
 pLnA==
X-Gm-Message-State: AOJu0YxVMMT2+RF+VMgT3QEI+eNZPPhLNBklRvvJdMdeS5Jf4yt5eAve
 lqwfsgbF9WPWaEpBOjRalAVES6BbE+kcs+p6eYAJPEzzln0l4rrWyqykbvq/ZHbiIvSHW4PzkdM
 r
X-Gm-Gg: ASbGncuEPB51zSu1aLjCg9qrmVvXd/X/EpZotF7wyL2bRTKiXCPlMeoD2t3DliY63HO
 Mre8ZxaDOS7VsvTjQTlSvvsMGzSBiVTG55ios1AbNVZHDAKkAnQB9AIQJqXwYvzMALmmh0UjRPZ
 CYIrqrnG9N/4SjhzpiKabE2MVkD6fUXaFJOdLP8KcszhqK8XK9l7Bk93gm61JGvgyuhz4YdgxY8
 QxJw0ZFZSBIA5D1F31XGWfNG4XUcuTcM9EJ8NJd6Co/8YWPCq7aRZNW8mou+JgRgNLf9vL3j9d+
 AN2j1cOZoJC7S+KzBRkcWSboZnwkpKytu6am51nM6ZoY36Q=
X-Google-Smtp-Source: AGHT+IE3mRH6THbYLTYwJHR2YMcbRVUg/AyBINyHudFv0E01IdBZ5zWZWl79RKemfmrrrbeWVRkbQQ==
X-Received: by 2002:a17:903:22c7:b0:21f:1202:f2f5 with SMTP id
 d9443c01a7336-22103efec4fmr92547145ad.8.1739747652356; 
 Sun, 16 Feb 2025 15:14:12 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366882sm60565615ad.95.2025.02.16.15.14.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:14:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 079/162] tcg: Convert movcond to TCGOutOpMovcond
Date: Sun, 16 Feb 2025 15:08:48 -0800
Message-ID: <20250216231012.2808572-80-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
 tcg/loongarch64/tcg-target-con-set.h |  2 +-
 tcg/mips/tcg-target-con-set.h        |  3 ++-
 tcg/s390x/tcg-target-con-set.h       |  1 -
 tcg/sparc64/tcg-target-con-set.h     |  2 +-
 tcg/tcg.c                            | 23 +++++++++++++++++++++++
 tcg/tci.c                            | 12 ++++++------
 tcg/aarch64/tcg-target.c.inc         | 26 +++++++++++++-------------
 tcg/arm/tcg-target.c.inc             | 24 ++++++++++++++----------
 tcg/i386/tcg-target.c.inc            | 23 +++++++++++------------
 tcg/loongarch64/tcg-target.c.inc     | 23 +++++++++--------------
 tcg/mips/tcg-target.c.inc            | 25 ++++++++++++-------------
 tcg/ppc/tcg-target.c.inc             | 24 ++++++++----------------
 tcg/riscv/tcg-target.c.inc           | 26 ++++++++++----------------
 tcg/s390x/tcg-target.c.inc           | 26 ++++++++------------------
 tcg/sparc64/tcg-target.c.inc         | 28 ++++++++++++++++------------
 tcg/tci/tcg-target-opc.h.inc         |  1 +
 tcg/tci/tcg-target.c.inc             | 18 +++++++++++++++---
 17 files changed, 150 insertions(+), 137 deletions(-)

diff --git a/tcg/loongarch64/tcg-target-con-set.h b/tcg/loongarch64/tcg-target-con-set.h
index dfe55c6fe8..fd731c0c0f 100644
--- a/tcg/loongarch64/tcg-target-con-set.h
+++ b/tcg/loongarch64/tcg-target-con-set.h
@@ -33,5 +33,5 @@ C_O1_I2(w, w, w)
 C_O1_I2(w, w, wM)
 C_O1_I2(w, w, wA)
 C_O1_I3(w, w, w, w)
-C_O1_I4(r, rz, rJ, rz, rz)
+C_O1_I4(r, r, rJ, rz, rz)
 C_N2_I1(r, r, r)
diff --git a/tcg/mips/tcg-target-con-set.h b/tcg/mips/tcg-target-con-set.h
index a80630a8b4..f5e4852b56 100644
--- a/tcg/mips/tcg-target-con-set.h
+++ b/tcg/mips/tcg-target-con-set.h
@@ -23,7 +23,8 @@ C_O1_I2(r, r, rIK)
 C_O1_I2(r, r, rJ)
 C_O1_I2(r, r, rz)
 C_O1_I2(r, r, rzW)
-C_O1_I4(r, rz, rz, rz, 0)
+C_O1_I4(r, r, rz, rz, 0)
+C_O1_I4(r, r, rz, rz, rz)
 C_O1_I4(r, rz, rz, rz, rz)
 C_O2_I1(r, r, r)
 C_O2_I2(r, r, r, r)
diff --git a/tcg/s390x/tcg-target-con-set.h b/tcg/s390x/tcg-target-con-set.h
index 86af067965..78f06e3e52 100644
--- a/tcg/s390x/tcg-target-con-set.h
+++ b/tcg/s390x/tcg-target-con-set.h
@@ -38,7 +38,6 @@ C_O1_I2(v, v, v)
 C_O1_I3(v, v, v, v)
 C_O1_I4(v, v, v, vZ, v)
 C_O1_I4(v, v, v, vZM, v)
-C_O1_I4(r, r, ri, rI, r)
 C_O1_I4(r, r, rC, rI, r)
 C_O2_I1(o, m, r)
 C_O2_I2(o, m, 0, r)
diff --git a/tcg/sparc64/tcg-target-con-set.h b/tcg/sparc64/tcg-target-con-set.h
index 9f66e52ec6..8cec396173 100644
--- a/tcg/sparc64/tcg-target-con-set.h
+++ b/tcg/sparc64/tcg-target-con-set.h
@@ -15,6 +15,6 @@ C_O0_I2(r, rJ)
 C_O1_I1(r, r)
 C_O1_I2(r, r, r)
 C_O1_I2(r, r, rJ)
-C_O1_I4(r, rz, rJ, rI, 0)
+C_O1_I4(r, r, rJ, rI, 0)
 C_O2_I2(r, r, r, r)
 C_O2_I4(r, r, rz, rz, rJ, rJ)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 1c6490891f..9a7c73fba2 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1000,6 +1000,13 @@ typedef struct TCGOutOpDivRem {
                       TCGReg a0, TCGReg a1, TCGReg a4);
 } TCGOutOpDivRem;
 
+typedef struct TCGOutOpMovcond {
+    TCGOutOp base;
+    void (*out)(TCGContext *s, TCGType type, TCGCond cond,
+                TCGReg ret, TCGReg c1, TCGArg c2, bool const_c2,
+                TCGArg vt, bool const_vt, TCGArg vf, bool consf_vf);
+} TCGOutOpMovcond;
+
 typedef struct TCGOutOpMul2 {
     TCGOutOp base;
     void (*out_rrrr)(TCGContext *s, TCGType type,
@@ -1057,6 +1064,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_divs2, TCGOutOpDivRem, outop_divs2),
     OUTOP(INDEX_op_divu2, TCGOutOpDivRem, outop_divu2),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
+    OUTOP(INDEX_op_movcond_i32, TCGOutOpMovcond, outop_movcond),
+    OUTOP(INDEX_op_movcond_i64, TCGOutOpMovcond, outop_movcond),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
     OUTOP(INDEX_op_muls2, TCGOutOpMul2, outop_muls2),
     OUTOP(INDEX_op_mulsh, TCGOutOpBinary, outop_mulsh),
@@ -5492,6 +5501,20 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
+    case INDEX_op_movcond_i32:
+    case INDEX_op_movcond_i64:
+        {
+            const TCGOutOpMovcond *out = &outop_movcond;
+            TCGCond cond = new_args[5];
+
+            tcg_debug_assert(!const_args[1]);
+            out->out(s, type, cond, new_args[0],
+                     new_args[1], new_args[2], const_args[2],
+                     new_args[3], const_args[3],
+                     new_args[4], const_args[4]);
+        }
+        break;
+
     case INDEX_op_setcond:
     case INDEX_op_negsetcond:
         {
diff --git a/tcg/tci.c b/tcg/tci.c
index 4c5dc16ecb..aef0023dc6 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -438,11 +438,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_l(insn, tb_ptr, &ptr);
             tb_ptr = ptr;
             continue;
-        case INDEX_op_movcond_i32:
-            tci_args_rrrrrc(insn, &r0, &r1, &r2, &r3, &r4, &condition);
-            tmp32 = tci_compare32(regs[r1], regs[r2], condition);
-            regs[r0] = regs[tmp32 ? r3 : r4];
-            break;
 #if TCG_TARGET_REG_BITS == 32
         case INDEX_op_setcond2_i32:
             tci_args_rrrrrc(insn, &r0, &r1, &r2, &r3, &r4, &condition);
@@ -628,6 +623,11 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrrc(insn, &r0, &r1, &r2, &condition);
             regs[r0] = tci_compare32(regs[r1], regs[r2], condition);
             break;
+        case INDEX_op_tci_movcond32:
+            tci_args_rrrrrc(insn, &r0, &r1, &r2, &r3, &r4, &condition);
+            tmp32 = tci_compare32(regs[r1], regs[r2], condition);
+            regs[r0] = regs[tmp32 ? r3 : r4];
+            break;
 
             /* Shift/rotate operations. */
 
@@ -1074,7 +1074,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                            op_name, str_r(r0), str_r(r1), pos, len);
         break;
 
-    case INDEX_op_movcond_i32:
+    case INDEX_op_tci_movcond32:
     case INDEX_op_movcond_i64:
     case INDEX_op_setcond2_i32:
         tci_args_rrrrrc(insn, &r0, &r1, &r2, &r3, &r4, &c);
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index e3d8e9090f..ee45e7e244 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2513,6 +2513,19 @@ static const TCGOutOpSetcond outop_negsetcond = {
     .out_rri = tgen_negsetcondi,
 };
 
+static void tgen_movcond(TCGContext *s, TCGType type, TCGCond cond,
+                         TCGReg ret, TCGReg c1, TCGArg c2, bool const_c2,
+                         TCGArg vt, bool const_vt, TCGArg vf, bool const_vf)
+{
+    tcg_out_cmp(s, type, cond, c1, c2, const_c2);
+    tcg_out_insn(s, 3506, CSEL, type, ret, vt, vf, cond);
+}
+
+static const TCGOutOpMovcond outop_movcond = {
+    .base.static_constraint = C_O1_I4(r, r, rC, rz, rz),
+    .out = tgen_movcond,
+};
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -2521,7 +2534,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
     TCGArg a0 = args[0];
     TCGArg a1 = args[1];
     TCGArg a2 = args[2];
-    int c2 = const_args[2];
 
     switch (opc) {
     case INDEX_op_goto_ptr:
@@ -2579,14 +2591,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_ldst(s, I3312_STRX, a0, a1, a2, 3);
         break;
 
-    case INDEX_op_movcond_i32:
-        a2 = (int32_t)a2;
-        /* FALLTHRU */
-    case INDEX_op_movcond_i64:
-        tcg_out_cmp(s, ext, args[5], a1, a2, c2);
-        tcg_out_insn(s, 3506, CSEL, ext, a0, args[3], args[4], args[5]);
-        break;
-
     case INDEX_op_qemu_ld_i32:
     case INDEX_op_qemu_ld_i64:
         tcg_out_qemu_ld(s, a0, a1, a2, ext);
@@ -3166,10 +3170,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_movcond_i32:
-    case INDEX_op_movcond_i64:
-        return C_O1_I4(r, r, rC, rz, rz);
-
     case INDEX_op_qemu_ld_i32:
     case INDEX_op_qemu_ld_i64:
         return C_O1_I1(r, r);
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index a97bd1e877..a5c1325805 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2253,6 +2253,20 @@ static const TCGOutOpSetcond outop_negsetcond = {
     .out_rri = tgen_negsetcondi,
 };
 
+static void tgen_movcond(TCGContext *s, TCGType type, TCGCond cond,
+                         TCGReg ret, TCGReg c1, TCGArg c2, bool const_c2,
+                         TCGArg vt, bool const_vt, TCGArg vf, bool consf_vf)
+{
+    cond = tcg_out_cmp(s, cond, c1, c2, const_c2);
+    tcg_out_dat_rIK(s, tcg_cond_to_arm_cond[cond], ARITH_MOV, ARITH_MVN,
+                    ret, 0, vt, const_vt);
+}
+
+static const TCGOutOpMovcond outop_movcond = {
+    .base.static_constraint = C_O1_I4(r, r, rIN, rIK, 0),
+    .out = tgen_movcond,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2294,14 +2308,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st32(s, COND_AL, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_movcond_i32:
-        /* Constraints mean that v2 is always in the same register as dest,
-         * so we only need to do "if condition passed, move v1 to dest".
-         */
-        c = tcg_out_cmp(s, args[5], args[1], args[2], const_args[2]);
-        tcg_out_dat_rIK(s, tcg_cond_to_arm_cond[c], ARITH_MOV,
-                        ARITH_MVN, args[0], 0, args[3], const_args[3]);
-        break;
     case INDEX_op_add2_i32:
         a0 = args[0], a1 = args[1], a2 = args[2];
         a3 = args[3], a4 = args[4], a5 = args[5];
@@ -2446,8 +2452,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
         return C_O1_I2(r, 0, rZ);
     case INDEX_op_extract2_i32:
         return C_O1_I2(r, rZ, rZ);
-    case INDEX_op_movcond_i32:
-        return C_O1_I4(r, r, rIN, rIK, 0);
     case INDEX_op_add2_i32:
         return C_O2_I4(r, r, r, r, rIN, rIK);
     case INDEX_op_sub2_i32:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index abe3aa2a62..465f03e864 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1900,14 +1900,21 @@ static void tcg_out_cmov(TCGContext *s, int jcc, int rexw,
     tcg_out_modrm(s, OPC_CMOVCC | jcc | rexw, dest, v1);
 }
 
-static void tcg_out_movcond(TCGContext *s, int rexw, TCGCond cond,
-                            TCGReg dest, TCGReg c1, TCGArg c2, int const_c2,
-                            TCGReg v1)
+static void tgen_movcond(TCGContext *s, TCGType type, TCGCond cond,
+                         TCGReg dest, TCGReg c1, TCGArg c2, bool const_c2,
+                         TCGArg vt, bool const_vt,
+                         TCGArg vf, bool consf_vf)
 {
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
     int jcc = tcg_out_cmp(s, cond, c1, c2, const_c2, rexw);
-    tcg_out_cmov(s, jcc, rexw, dest, v1);
+    tcg_out_cmov(s, jcc, rexw, dest, vt);
 }
 
+static const TCGOutOpMovcond outop_movcond = {
+    .base.static_constraint = C_O1_I4(r, r, reT, r, 0),
+    .out = tgen_movcond,
+};
+
 static void tcg_out_branch(TCGContext *s, int call, const tcg_insn_unit *dest)
 {
     intptr_t disp = tcg_pcrel_diff(s, dest) - 5;
@@ -3144,10 +3151,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(movcond):
-        tcg_out_movcond(s, rexw, args[5], a0, a1, a2, const_a2, args[3]);
-        break;
-
     OP_32_64(bswap16):
         if (a2 & TCG_BSWAP_OS) {
             /* Output must be sign-extended. */
@@ -3977,10 +3980,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_deposit_i64:
         return C_O1_I2(q, 0, qi);
 
-    case INDEX_op_movcond_i32:
-    case INDEX_op_movcond_i64:
-        return C_O1_I4(r, r, reT, r, 0);
-
     case INDEX_op_add2_i32:
     case INDEX_op_add2_i64:
     case INDEX_op_sub2_i32:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 4b07165e87..6f0c241cf9 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -711,11 +711,11 @@ static const TCGOutOpSetcond outop_negsetcond = {
     .out_rri = tgen_negsetcondi,
 };
 
-static void tcg_out_movcond(TCGContext *s, TCGCond cond, TCGReg ret,
-                            TCGReg c1, tcg_target_long c2, bool const2,
-                            TCGReg v1, TCGReg v2)
+static void tgen_movcond(TCGContext *s, TCGType type, TCGCond cond,
+                         TCGReg ret, TCGReg c1, TCGArg c2, bool const_c2,
+                         TCGArg v1, bool const_v1, TCGArg v2, bool const_v2)
 {
-    int tmpflags = tcg_out_setcond_int(s, cond, TCG_REG_TMP0, c1, c2, const2);
+    int tmpflags = tcg_out_setcond_int(s, cond, TCG_REG_TMP0, c1, c2, const_c2);
     TCGReg t;
 
     /* Standardize the test below to t != 0. */
@@ -735,6 +735,11 @@ static void tcg_out_movcond(TCGContext *s, TCGCond cond, TCGReg ret,
     }
 }
 
+static const TCGOutOpMovcond outop_movcond = {
+    .base.static_constraint = C_O1_I4(r, r, rJ, rz, rz),
+    .out = tgen_movcond,
+};
+
 /*
  * Branch helpers
  */
@@ -1747,7 +1752,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     TCGArg a1 = args[1];
     TCGArg a2 = args[2];
     TCGArg a3 = args[3];
-    int c2 = const_args[2];
 
     switch (opc) {
     case INDEX_op_mb:
@@ -1837,11 +1841,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_revb_d(s, a0, a1);
         break;
 
-    case INDEX_op_movcond_i32:
-    case INDEX_op_movcond_i64:
-        tcg_out_movcond(s, args[5], a0, a1, a2, c2, args[3], args[4]);
-        break;
-
     case INDEX_op_ld8s_i32:
     case INDEX_op_ld8s_i64:
         tcg_out_ldst(s, OPC_LD_B, a0, a1, a2);
@@ -2469,10 +2468,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
         /* Must deposit into the same register as input */
         return C_O1_I2(r, 0, rz);
 
-    case INDEX_op_movcond_i32:
-    case INDEX_op_movcond_i64:
-        return C_O1_I4(r, rz, rJ, rz, rz);
-
     case INDEX_op_ld_vec:
     case INDEX_op_dupm_vec:
     case INDEX_op_dup_vec:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 71b54ba235..2b48a0b3bf 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1086,8 +1086,9 @@ static void tcg_out_brcond2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
     tcg_out_nop(s);
 }
 
-static void tcg_out_movcond(TCGContext *s, TCGCond cond, TCGReg ret,
-                            TCGReg c1, TCGReg c2, TCGReg v1, TCGReg v2)
+static void tgen_movcond(TCGContext *s, TCGType type, TCGCond cond,
+                         TCGReg ret, TCGReg c1, TCGArg c2, bool const_c2,
+                         TCGArg v1, bool const_v1, TCGArg v2, bool const_v2)
 {
     int tmpflags;
     bool eqz;
@@ -1133,6 +1134,13 @@ static void tcg_out_movcond(TCGContext *s, TCGCond cond, TCGReg ret,
     }
 }
 
+static const TCGOutOpMovcond outop_movcond = {
+    .base.static_constraint = (use_mips32r6_instructions
+                               ? C_O1_I4(r, r, rz, rz, rz)
+                               : C_O1_I4(r, r, rz, rz, 0)),
+    .out = tgen_movcond,
+};
+
 static void tcg_out_call_int(TCGContext *s, const tcg_insn_unit *arg, bool tail)
 {
     /*
@@ -1726,7 +1734,8 @@ static void tgen_clz(TCGContext *s, TCGType type,
     if (use_mips32r6_instructions) {
         MIPSInsn opcv6 = type == TCG_TYPE_I32 ? OPC_CLZ_R6 : OPC_DCLZ_R6;
         tcg_out_opc_reg(s, opcv6, TCG_TMP0, a1, 0);
-        tcg_out_movcond(s, TCG_COND_EQ, a0, a1, 0, a2, TCG_TMP0);
+        tgen_movcond(s, TCG_TYPE_REG, TCG_COND_EQ, a0, a1, a2, false,
+                     TCG_TMP0, false, TCG_REG_ZERO, false);
     } else {
         MIPSInsn opcv2 = type == TCG_TYPE_I32 ? OPC_CLZ : OPC_DCLZ;
         if (a0 == a2) {
@@ -2298,11 +2307,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_brcond2(s, args[4], a0, a1, a2, args[3], arg_label(args[5]));
         break;
 
-    case INDEX_op_movcond_i32:
-    case INDEX_op_movcond_i64:
-        tcg_out_movcond(s, args[5], a0, a1, a2, args[3], args[4]);
-        break;
-
     case INDEX_op_setcond2_i32:
         tcg_out_setcond2(s, args[5], a0, a1, a2, args[3], args[4]);
         break;
@@ -2398,11 +2402,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
         return C_O1_I2(r, 0, rz);
-    case INDEX_op_movcond_i32:
-    case INDEX_op_movcond_i64:
-        return (use_mips32r6_instructions
-                ? C_O1_I4(r, rz, rz, rz, rz)
-                : C_O1_I4(r, rz, rz, rz, 0));
     case INDEX_op_add2_i32:
     case INDEX_op_sub2_i32:
         return C_O2_I4(r, r, rz, rz, rN, rN);
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 819abdc906..339b3a0904 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2144,9 +2144,9 @@ static const TCGOutOpBrcond outop_brcond = {
     .out_ri = tgen_brcondi,
 };
 
-static void tcg_out_movcond(TCGContext *s, TCGType type, TCGCond cond,
-                            TCGArg dest, TCGArg c1, TCGArg c2, TCGArg v1,
-                            TCGArg v2, bool const_c2)
+static void tgen_movcond(TCGContext *s, TCGType type, TCGCond cond,
+                         TCGReg dest, TCGReg c1, TCGArg c2, bool const_c2,
+                         TCGArg v1, bool const_v1, TCGArg v2, bool const_v2)
 {
     /* If for some reason both inputs are zero, don't produce bad code.  */
     if (v1 == 0 && v2 == 0) {
@@ -2192,6 +2192,11 @@ static void tcg_out_movcond(TCGContext *s, TCGType type, TCGCond cond,
     }
 }
 
+static const TCGOutOpMovcond outop_movcond = {
+    .base.static_constraint = C_O1_I4(r, r, rC, rZ, rZ),
+    .out = tgen_movcond,
+};
+
 static void tcg_out_cntxz(TCGContext *s, TCGType type, uint32_t opc,
                           TCGArg a0, TCGArg a1, TCGArg a2, bool const_a2)
 {
@@ -3578,15 +3583,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_movcond_i32:
-        tcg_out_movcond(s, TCG_TYPE_I32, args[5], args[0], args[1], args[2],
-                        args[3], args[4], const_args[2]);
-        break;
-    case INDEX_op_movcond_i64:
-        tcg_out_movcond(s, TCG_TYPE_I64, args[5], args[0], args[1], args[2],
-                        args[3], args[4], const_args[2]);
-        break;
-
 #if TCG_TARGET_REG_BITS == 64
     case INDEX_op_add2_i64:
 #else
@@ -4297,10 +4293,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_movcond_i32:
-    case INDEX_op_movcond_i64:
-        return C_O1_I4(r, r, rC, rZ, rZ);
-
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
         return C_O1_I2(r, 0, rZ);
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 1d7194e883..8d106d7f28 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1501,10 +1501,10 @@ static void tcg_out_movcond_br2(TCGContext *s, TCGCond cond, TCGReg ret,
     tcg_out_mov(s, TCG_TYPE_REG, ret, tmp);
 }
 
-static void tcg_out_movcond(TCGContext *s, TCGCond cond, TCGReg ret,
-                            TCGReg cmp1, int cmp2, bool c_cmp2,
-                            TCGReg val1, bool c_val1,
-                            TCGReg val2, bool c_val2)
+static void tcg_out_movcond(TCGContext *s, TCGType type, TCGCond cond,
+                            TCGReg ret, TCGReg cmp1, TCGArg cmp2, bool c_cmp2,
+                            TCGArg val1, bool c_val1,
+                            TCGArg val2, bool c_val2)
 {
     int tmpflags;
     TCGReg t;
@@ -1531,6 +1531,11 @@ static void tcg_out_movcond(TCGContext *s, TCGCond cond, TCGReg ret,
     }
 }
 
+static const TCGOutOpMovcond outop_movcond = {
+    .base.static_constraint = C_O1_I4(r, r, rI, rM, rM),
+    .out = tcg_out_movcond,
+};
+
 static void tcg_out_cltz(TCGContext *s, TCGType type, RISCVInsn insn,
                          TCGReg ret, TCGReg src1, int src2, bool c_src2)
 {
@@ -1542,7 +1547,7 @@ static void tcg_out_cltz(TCGContext *s, TCGType type, RISCVInsn insn,
          * Note that constraints put 'ret' in a new register, so the
          * computation above did not clobber either 'src1' or 'src2'.
          */
-        tcg_out_movcond(s, TCG_COND_EQ, ret, src1, 0, true,
+        tcg_out_movcond(s, type, TCG_COND_EQ, ret, src1, 0, true,
                         src2, c_src2, ret, false);
     }
 }
@@ -2425,7 +2430,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     TCGArg a0 = args[0];
     TCGArg a1 = args[1];
     TCGArg a2 = args[2];
-    int c2 = const_args[2];
 
     switch (opc) {
     case INDEX_op_goto_ptr:
@@ -2521,12 +2525,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                         const_args[4], const_args[5], true, false);
         break;
 
-    case INDEX_op_movcond_i32:
-    case INDEX_op_movcond_i64:
-        tcg_out_movcond(s, args[5], a0, a1, a2, c2,
-                        args[3], const_args[3], args[4], const_args[4]);
-        break;
-
     case INDEX_op_qemu_ld_i32:
         tcg_out_qemu_ld(s, a0, a1, a2, TCG_TYPE_I32);
         break;
@@ -2863,10 +2861,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_movcond_i32:
-    case INDEX_op_movcond_i64:
-        return C_O1_I4(r, r, rI, rM, rM);
-
     case INDEX_op_add2_i32:
     case INDEX_op_add2_i64:
     case INDEX_op_sub2_i32:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index d3650636aa..fbf39ca529 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -1540,9 +1540,9 @@ static void tgen_movcond_int(TCGContext *s, TCGType type, TCGReg dest,
     tcg_out_insn(s, RRFc, LOCGR, dest, src, cc);
 }
 
-static void tgen_movcond(TCGContext *s, TCGType type, TCGCond c, TCGReg dest,
-                         TCGReg c1, TCGArg c2, int c2const,
-                         TCGArg v3, int v3const, TCGReg v4)
+static void tgen_movcond(TCGContext *s, TCGType type, TCGCond c,
+                         TCGReg dest, TCGReg c1, TCGArg c2, bool c2const,
+                         TCGArg v3, bool v3const, TCGArg v4, bool v4const)
 {
     int cc, inv_cc;
 
@@ -1550,6 +1550,11 @@ static void tgen_movcond(TCGContext *s, TCGType type, TCGCond c, TCGReg dest,
     tgen_movcond_int(s, type, dest, v3, v3const, v4, cc, inv_cc);
 }
 
+static const TCGOutOpMovcond outop_movcond = {
+    .base.static_constraint = C_O1_I4(r, r, rC, rI, r),
+    .out = tgen_movcond,
+};
+
 static void tgen_deposit(TCGContext *s, TCGReg dest, TCGReg src,
                          int ofs, int len, int z)
 {
@@ -2875,11 +2880,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tgen_branch(s, S390_CC_ALWAYS, arg_label(args[0]));
         break;
 
-    case INDEX_op_movcond_i32:
-        tgen_movcond(s, TCG_TYPE_I32, args[5], args[0], args[1],
-                     args[2], const_args[2], args[3], const_args[3], args[4]);
-        break;
-
     case INDEX_op_qemu_ld_i32:
         tcg_out_qemu_ld(s, args[0], args[1], args[2], TCG_TYPE_I32);
         break;
@@ -2948,11 +2948,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_insn(s, RRE, SLBGR, args[1], args[5]);
         break;
 
-    case INDEX_op_movcond_i64:
-        tgen_movcond(s, TCG_TYPE_I64, args[5], args[0], args[1],
-                     args[2], const_args[2], args[3], const_args[3], args[4]);
-        break;
-
     OP_32_64(deposit):
         a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[1]) {
@@ -3492,11 +3487,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_deposit_i64:
         return C_O1_I2(r, rZ, r);
 
-    case INDEX_op_movcond_i32:
-        return C_O1_I4(r, r, ri, rI, r);
-    case INDEX_op_movcond_i64:
-        return C_O1_I4(r, r, rC, rI, r);
-
     case INDEX_op_add2_i32:
     case INDEX_op_sub2_i32:
         return C_N1_O1_I4(r, r, 0, 1, ri, r);
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 68f38b7d71..d99b9e42ce 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -898,6 +898,22 @@ static const TCGOutOpSetcond outop_negsetcond = {
     .out_rri = tgen_negsetcondi,
 };
 
+static void tgen_movcond(TCGContext *s, TCGType type, TCGCond cond,
+                         TCGReg ret, TCGReg c1, TCGArg c2, bool c2const,
+                         TCGArg v1, bool v1const, TCGArg v2, bool v2consf)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_movcond_i32(s, cond, ret, c1, c2, c2const, v1, v1const);
+    } else {
+        tcg_out_movcond_i64(s, cond, ret, c1, c2, c2const, v1, v1const);
+    }
+}
+
+static const TCGOutOpMovcond outop_movcond = {
+    .base.static_constraint = C_O1_I4(r, r, rJ, rI, 0),
+    .out = tgen_movcond,
+};
+
 static void tcg_out_addsub2_i32(TCGContext *s, TCGReg rl, TCGReg rh,
                                 TCGReg al, TCGReg ah, int32_t bl, int blconst,
                                 int32_t bh, int bhconst, int opl, int oph)
@@ -1735,13 +1751,11 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const int const_args[TCG_MAX_OP_ARGS])
 {
     TCGArg a0, a1, a2;
-    int c2;
 
     /* Hoist the loads of the most common arguments.  */
     a0 = args[0];
     a1 = args[1];
     a2 = args[2];
-    c2 = const_args[2];
 
     switch (opc) {
     case INDEX_op_goto_ptr:
@@ -1784,10 +1798,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, a0, a1, a2, STW);
         break;
 
-    case INDEX_op_movcond_i32:
-        tcg_out_movcond_i32(s, args[5], a0, a1, a2, c2, args[3], const_args[3]);
-        break;
-
     case INDEX_op_add2_i32:
         tcg_out_addsub2_i32(s, args[0], args[1], args[2], args[3],
                             args[4], const_args[4], args[5], const_args[5],
@@ -1822,9 +1832,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, a0, a1, a2, STX);
         break;
 
-    case INDEX_op_movcond_i64:
-        tcg_out_movcond_i64(s, args[5], a0, a1, a2, c2, args[3], const_args[3]);
-        break;
     case INDEX_op_add2_i64:
         tcg_out_addsub2_i64(s, args[0], args[1], args[2], args[3], args[4],
                             const_args[4], args[5], const_args[5], false);
@@ -1895,9 +1902,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_movcond_i32:
-    case INDEX_op_movcond_i64:
-        return C_O1_I4(r, rz, rJ, rI, 0);
     case INDEX_op_add2_i32:
     case INDEX_op_add2_i64:
     case INDEX_op_sub2_i32:
diff --git a/tcg/tci/tcg-target-opc.h.inc b/tcg/tci/tcg-target-opc.h.inc
index 27b4574e4f..672d9b7323 100644
--- a/tcg/tci/tcg-target-opc.h.inc
+++ b/tcg/tci/tcg-target-opc.h.inc
@@ -11,3 +11,4 @@ DEF(tci_remu32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_rotl32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_rotr32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_setcond32, 1, 2, 1, TCG_OPF_NOT_PRESENT)
+DEF(tci_movcond32, 1, 2, 1, TCG_OPF_NOT_PRESENT)
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 18628b957a..79f9219187 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -92,8 +92,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
         return C_O0_I4(r, r, r, r);
 #endif
 
-    case INDEX_op_movcond_i32:
-    case INDEX_op_movcond_i64:
     case INDEX_op_setcond2_i32:
         return C_O1_I4(r, r, r, r, r);
 
@@ -972,6 +970,21 @@ static const TCGOutOpBrcond outop_brcond = {
     .out_rr = tgen_brcond,
 };
 
+static void tgen_movcond(TCGContext *s, TCGType type, TCGCond cond,
+                         TCGReg ret, TCGReg c1, TCGArg c2, bool const_c2,
+                         TCGArg vt, bool const_vt, TCGArg vf, bool consf_vf)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_movcond32
+                     : INDEX_op_movcond_i64);
+    tcg_out_op_rrrrrc(s, opc, ret, c1, c2, vt, vf, cond);
+}
+
+static const TCGOutOpMovcond outop_movcond = {
+    .base.static_constraint = C_O1_I4(r, r, r, r, r),
+    .out = tgen_movcond,
+};
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -987,7 +1000,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_op_l(s, opc, arg_label(args[0]));
         break;
 
-    CASE_32_64(movcond)
     case INDEX_op_setcond2_i32:
         tcg_out_op_rrrrrc(s, opc, args[0], args[1], args[2],
                           args[3], args[4], args[5]);
-- 
2.43.0


