Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23848E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPgB-0007P9-Nw; Thu, 02 Jan 2025 13:12:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPen-0007XJ-07
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:53 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPek-0006I1-Ne
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:52 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21675fd60feso209359405ad.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841449; x=1736446249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pbX6k3rFiZta4qsa6t9fJShFVFcKhT451ZjtY2F/blI=;
 b=Nh4e8Q58Xcwcq+1V48Nt0m838BMxKUmo4pCVn+b8xuqdLxYBYYxFZ64+IHKrORM0SC
 V0b5prWxRSBD/5ad1A1VD893THLK+GhWJyDmwn2Zl6K8oFIhLcu65p9+z8aExzEcxaTP
 MiReBUQhUS5ilX/v1fcOAEV+5ulrs7tKg5RJ9esu4IwFgpe9SkatyJ6bLVMdjFBVH7ua
 VMGNUckq/1O2kjFuxe1+L+AG6UksYKdZIIl3nR6mrYnGMfIQXe5EuqlR3YbxmWRyBczs
 K0ZAG2ntdLSEQAALbQz1/5CH9hKkMel4Ms9+o42KKGKTjuoqRE6LRxXNv+FliVQHZD42
 QXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841449; x=1736446249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pbX6k3rFiZta4qsa6t9fJShFVFcKhT451ZjtY2F/blI=;
 b=mPmWUh4ZornWw2ZY8rhgee9kaB9XMRL6CdsfEvD/0AyyOYEtahcYJD/DUbGmWl4HiR
 YFLSAA5mMuXP5ondVONUevARE41t3lRDHGpwhHG74MU2QFPK+YM7DYTdlneG5ZM8XJxX
 bDaIZfEAjwFx6tZvJ0CNcDzEovpuvhGnG5qqO2XSmHLcZeBorwvMpRptlPbdjpItYlkW
 BcENxHAhO/pUKkbI7gKpr+C3JSmi9XI3emxy7XMPJaQsFjcfKv+8dOXId4mlkDv7KOM7
 8O5XeZwRGjPjhlOkt37J1r9HXd8C71ZMqSjSh36GWS33poHrciqqh3isidbkzzWtC+d1
 fcbw==
X-Gm-Message-State: AOJu0Yz4DvMyAoj/aNuTkK4CNCN0FT9pXUZ0wTOMzygWnVCunelPoHnt
 KJ8md/npFSEGPqrGykI4UU6094s/7MjjZglwojbqlgB4ahLsxkJKX92eRxRMSmNsM/vSHkPwbvC
 Z
X-Gm-Gg: ASbGncuFnqId7Pf4bdoAN6cuOhaqLeD3f8SjOAOfqA8WmwuUz7ntQQosa6Qjb71PVxh
 p9xJiQNv2QVFzUCS5fcu5fB403vNrxqq/WBaPndANr6HfnX/mzsdprqDm5iqQv+j6/Gwv6mMOBF
 2dZ1dyv8Cvb3GNkkUEqk7mNsn78h1Rydm2UWW7ZleSwxDcLWun1v/6hpZWaZZXlyTPQR9vaBGJi
 J9nsBR7BPQndns8qUokaFrNytCboMj+P966gjz3+rm7JawiZGW6I7nBAWyWZQ==
X-Google-Smtp-Source: AGHT+IEifHqlNYccn+BBqqJ+AhVW9W8VuIOIp9ym7wxJisFrQBtP15z2qHElDLl8EQA1bqRUSO9XEg==
X-Received: by 2002:a05:6a21:3116:b0:1e1:f5a:db33 with SMTP id
 adf61e73a8af0-1e5e0801bb4mr57317294637.36.1735841449383; 
 Thu, 02 Jan 2025 10:10:49 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbaf1sm24620827b3a.112.2025.01.02.10.10.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:10:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 69/73] tcg: Merge deposit operations
Date: Thu,  2 Jan 2025 10:06:49 -0800
Message-ID: <20250102180654.1420056-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
 include/tcg/tcg-opc.h            |  3 +--
 tcg/optimize.c                   |  2 +-
 tcg/tcg-op.c                     |  8 ++++----
 tcg/tcg.c                        |  3 +--
 tcg/tci.c                        | 12 ++++--------
 tcg/aarch64/tcg-target.c.inc     |  6 ++----
 tcg/arm/tcg-target.c.inc         |  4 ++--
 tcg/i386/tcg-target.c.inc        |  5 ++---
 tcg/loongarch64/tcg-target.c.inc | 14 +++++++-------
 tcg/mips/tcg-target.c.inc        | 16 ++++++++--------
 tcg/ppc/tcg-target.c.inc         | 23 ++++++++++-------------
 tcg/s390x/tcg-target.c.inc       |  5 ++---
 tcg/tci/tcg-target.c.inc         |  5 ++---
 13 files changed, 46 insertions(+), 60 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index e39788bc14..d390d639ee 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -71,6 +71,7 @@ DEF(rotl, 1, 2, 0, TCG_OPF_INT)
 DEF(rotr, 1, 2, 0, TCG_OPF_INT)
 DEF(extract, 1, 1, 2, TCG_OPF_INT)
 DEF(sextract, 1, 1, 2, TCG_OPF_INT)
+DEF(deposit, 1, 2, 2, TCG_OPF_INT)
 
 DEF(brcond, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH | TCG_OPF_INT)
 DEF(setcond, 1, 2, 1, TCG_OPF_INT)
@@ -81,7 +82,6 @@ DEF(movcond, 1, 4, 1, TCG_OPF_INT)
 DEF(ld_i32, 1, 1, 2, 0)
 DEF(st_i32, 0, 2, 2, 0)
 /* shifts/rotates */
-DEF(deposit_i32, 1, 2, 2, 0)
 DEF(extract2_i32, 1, 2, 1, 0)
 
 DEF(brcond2_i32, 0, 4, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
@@ -97,7 +97,6 @@ DEF(ctpop_i32, 1, 1, 0, 0)
 DEF(ld_i64, 1, 1, 2, 0)
 DEF(st_i64, 0, 2, 2, 0)
 /* shifts/rotates */
-DEF(deposit_i64, 1, 2, 2, 0)
 DEF(extract2_i64, 1, 2, 1, 0)
 
 /* size changing ops */
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 0240831343..25ab293a73 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2746,7 +2746,7 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(ctpop):
             done = fold_ctpop(&ctx, op);
             break;
-        CASE_OP_32_64(deposit):
+        case INDEX_op_deposit:
             done = fold_deposit(&ctx, op);
             break;
         case INDEX_op_div:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c9c806b543..65a6031eaf 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -907,7 +907,7 @@ void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
         return;
     }
     if (TCG_TARGET_deposit_valid(TCG_TYPE_I32, ofs, len)) {
-        tcg_gen_op5ii_i32(INDEX_op_deposit_i32, ret, arg1, arg2, ofs, len);
+        tcg_gen_op5ii_i32(INDEX_op_deposit, ret, arg1, arg2, ofs, len);
         return;
     }
 
@@ -953,7 +953,7 @@ void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
         tcg_gen_andi_i32(ret, arg, (1u << len) - 1);
     } else if (TCG_TARGET_deposit_valid(TCG_TYPE_I32, ofs, len)) {
         TCGv_i32 zero = tcg_constant_i32(0);
-        tcg_gen_op5ii_i32(INDEX_op_deposit_i32, ret, zero, arg, ofs, len);
+        tcg_gen_op5ii_i32(INDEX_op_deposit, ret, zero, arg, ofs, len);
     } else {
         /*
          * To help two-operand hosts we prefer to zero-extend first,
@@ -2553,7 +2553,7 @@ void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
 
     if (TCG_TARGET_REG_BITS == 64) {
         if (TCG_TARGET_deposit_valid(TCG_TYPE_I64, ofs, len)) {
-            tcg_gen_op5ii_i64(INDEX_op_deposit_i64, ret, arg1, arg2, ofs, len);
+            tcg_gen_op5ii_i64(INDEX_op_deposit, ret, arg1, arg2, ofs, len);
             return;
         }
         if (TCG_TARGET_HAS_extract2(TCG_TYPE_I64)) {
@@ -2614,7 +2614,7 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
     } else if (TCG_TARGET_REG_BITS == 64 &&
                TCG_TARGET_deposit_valid(TCG_TYPE_I64, ofs, len)) {
         TCGv_i64 zero = tcg_constant_i64(0);
-        tcg_gen_op5ii_i64(INDEX_op_deposit_i64, ret, zero, arg, ofs, len);
+        tcg_gen_op5ii_i64(INDEX_op_deposit, ret, zero, arg, ofs, len);
     } else {
         if (TCG_TARGET_REG_BITS == 32) {
             if (ofs >= 32) {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 72b062e76d..77f28147a1 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2192,6 +2192,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_add:
     case INDEX_op_and:
     case INDEX_op_brcond:
+    case INDEX_op_deposit:
     case INDEX_op_extract:
     case INDEX_op_mov:
     case INDEX_op_movcond:
@@ -2209,7 +2210,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
 
     case INDEX_op_ld_i32:
     case INDEX_op_st_i32:
-    case INDEX_op_deposit_i32:
         return true;
 
     case INDEX_op_add2:
@@ -2269,7 +2269,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
-    case INDEX_op_deposit_i64:
         return TCG_TARGET_REG_BITS == 64;
 
     case INDEX_op_extract2_i64:
diff --git a/tcg/tci.c b/tcg/tci.c
index 063d39adfa..9cc983ca1a 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -38,6 +38,7 @@
 
 #define extract_tr   glue(extract, TCG_TARGET_REG_BITS)
 #define sextract_tr  glue(sextract, TCG_TARGET_REG_BITS)
+#define deposit_tr   glue(deposit, TCG_TARGET_REG_BITS)
 
 __thread uintptr_t tci_tb_ptr;
 
@@ -646,9 +647,9 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
 
             /* Shift/rotate operations (32 bit). */
 
-        case INDEX_op_deposit_i32:
+        case INDEX_op_deposit:
             tci_args_rrrbb(insn, &r0, &r1, &r2, &pos, &len);
-            regs[r0] = deposit32(regs[r1], pos, len, regs[r2]);
+            regs[r0] = deposit_tr(regs[r1], pos, len, regs[r2]);
             break;
         case INDEX_op_extract:
             tci_args_rrbb(insn, &r0, &r1, &pos, &len);
@@ -760,10 +761,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
 
             /* Shift/rotate operations (64 bit). */
 
-        case INDEX_op_deposit_i64:
-            tci_args_rrrbb(insn, &r0, &r1, &r2, &pos, &len);
-            regs[r0] = deposit64(regs[r1], pos, len, regs[r2]);
-            break;
         case INDEX_op_ext_i32_i64:
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = (int32_t)regs[r1];
@@ -1069,8 +1066,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                            op_name, str_r(r0), str_r(r1), str_r(r2));
         break;
 
-    case INDEX_op_deposit_i32:
-    case INDEX_op_deposit_i64:
+    case INDEX_op_deposit:
         tci_args_rrrbb(insn, &r0, &r1, &r2, &pos, &len);
         info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %d, %d",
                            op_name, str_r(r0), str_r(r1), str_r(r2), pos, len);
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index bc695aa760..57f4e05b5c 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2409,8 +2409,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         }
         break;
 
-    case INDEX_op_deposit_i64:
-    case INDEX_op_deposit_i32:
+    case INDEX_op_deposit:
         tcg_out_dep(s, ext, a0, REG0(2), args[3], args[4]);
         break;
 
@@ -2996,8 +2995,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_qemu_st_a64_i128:
         return C_O0_I3(rZ, rZ, r);
 
-    case INDEX_op_deposit_i32:
-    case INDEX_op_deposit_i64:
+    case INDEX_op_deposit:
         return C_O1_I2(r, 0, rZ);
 
     case INDEX_op_extract2_i32:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 3b89a6c60e..1bf020ed67 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2123,7 +2123,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_bswap32(s, COND_AL, args[0], args[1]);
         break;
 
-    case INDEX_op_deposit_i32:
+    case INDEX_op_deposit:
         tcg_out_deposit(s, COND_AL, args[0], args[2],
                         args[3], args[4], const_args[2]);
         break;
@@ -2227,7 +2227,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
 
     case INDEX_op_brcond:
         return C_O0_I2(r, rIN);
-    case INDEX_op_deposit_i32:
+    case INDEX_op_deposit:
         return C_O1_I2(r, 0, rZ);
     case INDEX_op_extract2_i32:
         return C_O1_I2(r, rZ, rZ);
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 75a3b4641a..917775b7f6 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3010,7 +3010,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
 #endif
 
-    OP_32_64(deposit):
+    case INDEX_op_deposit:
         if (args[3] == 0 && args[4] == 8) {
             /* load bits 0..7 */
             if (const_a2) {
@@ -3730,8 +3730,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_extract2_i64:
         return C_O1_I2(r, 0, r);
 
-    case INDEX_op_deposit_i32:
-    case INDEX_op_deposit_i64:
+    case INDEX_op_deposit:
         return C_O1_I2(q, 0, qi);
 
     case INDEX_op_setcond:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index d22223bb45..563299381a 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1392,11 +1392,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_deposit_i32:
-        tcg_out_opc_bstrins_w(s, a0, a2, args[3], args[3] + args[4] - 1);
-        break;
-    case INDEX_op_deposit_i64:
-        tcg_out_opc_bstrins_d(s, a0, a2, args[3], args[3] + args[4] - 1);
+    case INDEX_op_deposit:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_opc_bstrins_w(s, a0, a2, args[3], args[3] + args[4] - 1);
+        } else {
+            tcg_out_opc_bstrins_d(s, a0, a2, args[3], args[3] + args[4] - 1);
+        }
         break;
 
     case INDEX_op_bswap16_i32:
@@ -2283,8 +2284,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_ctz_i64:
         return C_O1_I2(r, r, rW);
 
-    case INDEX_op_deposit_i32:
-    case INDEX_op_deposit_i64:
+    case INDEX_op_deposit:
         /* Must deposit into the same register as input */
         return C_O1_I2(r, 0, rZ);
 
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 143348ab2e..d74bcdb96f 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2014,12 +2014,13 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_clz(s, OPC_DCLZ, OPC_DCLZ_R6, 64, a0, a1, a2);
         break;
 
-    case INDEX_op_deposit_i32:
-        tcg_out_opc_bf(s, OPC_INS, a0, a2, args[3] + args[4] - 1, args[3]);
-        break;
-    case INDEX_op_deposit_i64:
-        tcg_out_opc_bf64(s, OPC_DINS, OPC_DINSM, OPC_DINSU, a0, a2,
-                         args[3] + args[4] - 1, args[3]);
+    case INDEX_op_deposit:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_opc_bf(s, OPC_INS, a0, a2, args[3] + args[4] - 1, args[3]);
+        } else {
+            tcg_out_opc_bf64(s, OPC_DINS, OPC_DINSM, OPC_DINSU, a0, a2,
+                             args[3] + args[4] - 1, args[3]);
+        }
         break;
 
     case INDEX_op_extract:
@@ -2196,8 +2197,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_clz_i64:
         return C_O1_I2(r, r, rWZ);
 
-    case INDEX_op_deposit_i32:
-    case INDEX_op_deposit_i64:
+    case INDEX_op_deposit:
         return C_O1_I2(r, 0, rZ);
     case INDEX_op_brcond:
         return C_O0_I2(rZ, rZ);
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index c2b53c79f7..c501b1a205 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3353,19 +3353,17 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_bswap64(s, args[0], args[1]);
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
+    case INDEX_op_deposit:
         if (const_args[2]) {
             uint64_t mask = ((2ull << (args[4] - 1)) - 1) << args[3];
-            tcg_out_andi64(s, args[0], args[0], ~mask);
+            if (type == TCG_TYPE_I32) {
+                tcg_out_andi32(s, args[0], args[0], ~mask);
+            } else {
+                tcg_out_andi64(s, args[0], args[0], ~mask);
+            }
+        } else if (type == TCG_TYPE_I32) {
+            tcg_out_rlw(s, RLWIMI, args[0], args[2], args[3],
+                        32 - args[3] - args[4], 31 - args[3]);
         } else {
             tcg_out_rld(s, RLDIMI, args[0], args[2], args[3],
                         64 - args[3] - args[4]);
@@ -4166,8 +4164,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_movcond:
         return C_O1_I4(r, r, rC, rZ, rZ);
 
-    case INDEX_op_deposit_i32:
-    case INDEX_op_deposit_i64:
+    case INDEX_op_deposit:
         return C_O1_I2(r, 0, rZ);
     case INDEX_op_brcond2_i32:
         return C_O0_I4(r, r, ri, ri);
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index ac7af3f854..3ee364b27f 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2655,7 +2655,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_sh64(s, RSY_SRLG, args[0], args[1], TCG_REG_NONE, 32);
         break;
 
-    OP_32_64(deposit):
+    case INDEX_op_deposit:
         a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[1]) {
             tgen_deposit(s, a0, a2, args[3], args[4], 1);
@@ -3248,8 +3248,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_qemu_st_a64_i128:
         return C_O0_I3(o, m, r);
 
-    case INDEX_op_deposit_i32:
-    case INDEX_op_deposit_i64:
+    case INDEX_op_deposit:
         return C_O1_I2(r, rZ, r);
 
     case INDEX_op_movcond:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index e4f227fb4b..3a3fef8679 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -86,8 +86,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_rotl:
     case INDEX_op_rotr:
     case INDEX_op_setcond:
-    case INDEX_op_deposit_i32:
-    case INDEX_op_deposit_i64:
+    case INDEX_op_deposit:
     case INDEX_op_clz_i32:
     case INDEX_op_clz_i64:
     case INDEX_op_ctz_i32:
@@ -749,7 +748,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    CASE_32_64(deposit)  /* Optional (TCG_TARGET_HAS_deposit_*). */
+    case INDEX_op_deposit:
         tcg_out_op_rrrbb(s, opc, args[0], args[1], args[2], args[3], args[4]);
         break;
 
-- 
2.43.0


