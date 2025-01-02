Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9926FE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:18:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPfE-00023b-MR; Thu, 02 Jan 2025 13:11:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPek-0007Wi-0j
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:53 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeg-0006Gt-UO
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:49 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso160704545ad.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841446; x=1736446246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hiFmTIUCfwBUCYArXD4dRS/psBJoOMs//ZphMPMObEk=;
 b=WHzxs8ihe9bmxzTh76BtZAEmSR0cdg4zWTA25ykoUJ3K43sKIPYQ9gJe2jaOjMldhJ
 GrRKnpiLlK6S+Ul81s/MlbKIJ4c8DqTydlYM8b5P/DvwCRamxvoMDxnuOYrJn+X9H70F
 RlwGZdbaZqQ9QFA8SNxPlNPHKk+1I5RxaaAbecTGQ3GGri7OAW7acF+8UpVzTvNVWwyn
 IMHCdr5nBNV0FHCYhtcPcmKyLo2WjWTkFIvcHaa14Hb3flMdRiJKbp7mG1uQvnVxaakh
 iSoXJlsZjfHaOmQiaRXHQBt2vWI4vgP2GTTK7Ndjaf5Dd5dkyZbrKsonC20zNgT5HeIb
 At4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841446; x=1736446246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hiFmTIUCfwBUCYArXD4dRS/psBJoOMs//ZphMPMObEk=;
 b=J4DVEVBXaf7vKGqNjEeVYrgAV9U6IOv18VkwxlpStFFSZKWGbyQ7QIMaAfqpVfyLGO
 buwG0YjUkjdwe6dWVpse25WgWxV5uUdkX8N27+1sNHTSSDgp9yzjVLNAnoQV1YXaMM74
 3qsRepCp7MEoodZr0aBJ4LC1e1YXNYnf0Zc/dFZbINo2D5wVDrWiKazww0RSfcjr00uw
 e7wAph2F1sdARYjYVtr9e2XmEE0lVGrrZD/PHKCsLJk9EKYEedNfIljKZefwDqMuhAhO
 ysJvg5HRdHWQIVlxpXH3Zoj6pIrmFMbgpNOvxjb0ktXHtv1Cz9JfOR7a09F0jY1DRqM7
 CxIw==
X-Gm-Message-State: AOJu0YwD4o7tTs7Sie1jXVjrDjzCepMXO7Vrlqz3wfY4Xf+XvS8Hp7bs
 SWLgszRead/l/G90ErH22fQizj/SvyB3Cg7eirUDc/lHe/nG7P9zBEtVxoSLG36xlotkrx/zGMA
 E
X-Gm-Gg: ASbGncsKWajISxsuSD4orF9w5DGpT9GT1mzyMbknG4RxbI4OIDFfPnEtIaMMdIAZnFq
 H8cnyWznOczygDecnz3XixJD1XzcSSGAQqjiS/WiGndJKC5saD/5kryvqBfkDW0HJ8gvGcgYZCi
 L8yU222jILDHgHIXbVlNPdMqgTdcN+sBT4ImuEeDmk9deEivzRXEQRudY3iY0rwnb0YSDwa26sT
 B15boaXRtQmjFeOsvQDWXtfvl1vqnMJrVMO07Qcemm9mlfo8voH3llFyV7yjw==
X-Google-Smtp-Source: AGHT+IFZUIfdE72UMqmcweyvIAeInkOu4gnO0XKHeWr0w/hb0wpwmY6ltmq5pMOFRodpQ1U6Isvmwg==
X-Received: by 2002:a05:6a00:6f0b:b0:72a:bc6a:3a87 with SMTP id
 d2e1a72fcca58-72abdbd6e05mr60852360b3a.0.1735841445475; 
 Thu, 02 Jan 2025 10:10:45 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbaf1sm24620827b3a.112.2025.01.02.10.10.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:10:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 64/73] tcg: Merge integer add2, sub2 operations
Date: Thu,  2 Jan 2025 10:06:44 -0800
Message-ID: <20250102180654.1420056-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

For TCI, we're losing type information from the interpreter.
Limit the opcodes to the host register size; on 64-bit host
it's just as easy to reconstruct 64-bit operands for normal add/sub.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h        |  6 +--
 tcg/tci/tcg-target-has.h     |  4 +-
 target/arm/tcg/translate.c   |  2 +-
 tcg/optimize.c               |  7 ++-
 tcg/tcg-op.c                 |  8 ++--
 tcg/tcg.c                    | 18 +++-----
 tcg/tci.c                    | 50 +++++++++++-----------
 tcg/aarch64/tcg-target.c.inc | 26 ++++-------
 tcg/arm/tcg-target.c.inc     |  8 ++--
 tcg/i386/tcg-target.c.inc    | 10 ++---
 tcg/mips/tcg-target.c.inc    | 10 +++--
 tcg/ppc/tcg-target.c.inc     | 20 +++------
 tcg/riscv/tcg-target.c.inc   | 24 ++++-------
 tcg/s390x/tcg-target.c.inc   | 83 ++++++++++++++++++------------------
 tcg/sparc64/tcg-target.c.inc | 40 ++++++++---------
 tcg/tci/tcg-target.c.inc     | 10 ++---
 16 files changed, 143 insertions(+), 183 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 54d43ace2c..8d733462f6 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -50,6 +50,8 @@ DEF(not, 1, 1, 0, TCG_OPF_INT)
 DEF(add, 1, 2, 0, TCG_OPF_INT)
 DEF(sub, 1, 2, 0, TCG_OPF_INT)
 DEF(neg, 1, 1, 0, TCG_OPF_INT)
+DEF(add2, 2, 4, 0, TCG_OPF_INT)
+DEF(sub2, 2, 4, 0, TCG_OPF_INT)
 
 DEF(setcond_i32, 1, 2, 1, 0)
 DEF(negsetcond_i32, 1, 2, 1, 0)
@@ -78,8 +80,6 @@ DEF(extract2_i32, 1, 2, 1, 0)
 
 DEF(brcond_i32, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 
-DEF(add2_i32, 2, 4, 0, 0)
-DEF(sub2_i32, 2, 4, 0, 0)
 DEF(mulu2_i32, 2, 2, 0, 0)
 DEF(muls2_i32, 2, 2, 0, 0)
 DEF(muluh_i32, 1, 2, 0, 0)
@@ -132,8 +132,6 @@ DEF(clz_i64, 1, 2, 0, 0)
 DEF(ctz_i64, 1, 2, 0, 0)
 DEF(ctpop_i64, 1, 1, 0, 0)
 
-DEF(add2_i64, 2, 4, 0, 0)
-DEF(sub2_i64, 2, 4, 0, 0)
 DEF(mulu2_i64, 2, 2, 0, 0)
 DEF(muls2_i64, 2, 2, 0, 0)
 DEF(muluh_i64, 1, 2, 0, 0)
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 3df463521d..8534081daa 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -8,7 +8,7 @@
 #define TCG_TARGET_HAS_H
 
 /* optional integer instructions */
-#define TCG_TARGET_HAS_add2(T)          1
+#define TCG_TARGET_HAS_add2(T)          (T == TCG_TYPE_REG)
 #define TCG_TARGET_HAS_bswap(T)         1
 #define TCG_TARGET_HAS_clz(T)           1
 #define TCG_TARGET_HAS_ctpop(T)         1
@@ -21,7 +21,7 @@
 #define TCG_TARGET_HAS_negsetcond(T)    0
 #define TCG_TARGET_HAS_rem(T)           1
 #define TCG_TARGET_HAS_rot(T)           1
-#define TCG_TARGET_HAS_sub2(T)          1
+#define TCG_TARGET_HAS_sub2(T)          (T == TCG_TYPE_REG)
 #define TCG_TARGET_HAS_extract2(T)      0
 
 /* optional integer and vector instructions */
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 1b5bddcad1..1e324dd1a4 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -493,7 +493,7 @@ static void gen_add_CC(TCGv_i32 dest, TCGv_i32 t0, TCGv_i32 t1)
 static void gen_adc_CC(TCGv_i32 dest, TCGv_i32 t0, TCGv_i32 t1)
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
-    if (tcg_op_supported(INDEX_op_add2_i32, TCG_TYPE_I32)) {
+    if (tcg_op_supported(INDEX_op_add2, TCG_TYPE_I32)) {
         tcg_gen_movi_i32(tmp, 0);
         tcg_gen_add2_i32(cpu_NF, cpu_CF, t0, tmp, cpu_CF, tmp);
         tcg_gen_add2_i32(cpu_NF, cpu_CF, cpu_NF, cpu_CF, t1, tmp);
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 08f090edae..9bd737e2b0 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1266,8 +1266,7 @@ static bool fold_addsub2(OptContext *ctx, TCGOp *op, bool add)
         bl = -bl;
         bh = ~bh + !bl;
 
-        op->opc = (op->type == TCG_TYPE_I32
-                   ? INDEX_op_add2_i32 : INDEX_op_add2_i64);
+        op->opc = INDEX_op_add2;
         op->args[4] = arg_new_constant(ctx, op->type, bl);
         op->args[5] = arg_new_constant(ctx, op->type, bh);
     }
@@ -2754,7 +2753,7 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_add_vec:
             done = fold_add_vec(&ctx, op);
             break;
-        CASE_OP_32_64(add2):
+        case INDEX_op_add2:
             done = fold_add2(&ctx, op);
             break;
         case INDEX_op_and:
@@ -2929,7 +2928,7 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_sub_vec:
             done = fold_sub_vec(&ctx, op);
             break;
-        CASE_OP_32_64(sub2):
+        case INDEX_op_sub2:
             done = fold_sub2(&ctx, op);
             break;
         case INDEX_op_xor:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c5554ea948..81b18762fa 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1095,7 +1095,7 @@ void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
 {
     if (TCG_TARGET_HAS_add2(TCG_TYPE_I32)) {
-        tcg_gen_op6_i32(INDEX_op_add2_i32, rl, rh, al, ah, bl, bh);
+        tcg_gen_op6_i32(INDEX_op_add2, rl, rh, al, ah, bl, bh);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
@@ -1112,7 +1112,7 @@ void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
 {
     if (TCG_TARGET_HAS_sub2(TCG_TYPE_I32)) {
-        tcg_gen_op6_i32(INDEX_op_sub2_i32, rl, rh, al, ah, bl, bh);
+        tcg_gen_op6_i32(INDEX_op_sub2, rl, rh, al, ah, bl, bh);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
@@ -2842,7 +2842,7 @@ void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
 {
     if (TCG_TARGET_REG_BITS == 64 &&
         TCG_TARGET_HAS_add2(TCG_TYPE_I64)) {
-        tcg_gen_op6_i64(INDEX_op_add2_i64, rl, rh, al, ah, bl, bh);
+        tcg_gen_op6_i64(INDEX_op_add2, rl, rh, al, ah, bl, bh);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
@@ -2861,7 +2861,7 @@ void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
 {
     if (TCG_TARGET_REG_BITS == 64 &&
         TCG_TARGET_HAS_sub2(TCG_TYPE_I64)) {
-        tcg_gen_op6_i64(INDEX_op_sub2_i64, rl, rh, al, ah, bl, bh);
+        tcg_gen_op6_i64(INDEX_op_sub2, rl, rh, al, ah, bl, bh);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 160b711ee0..6d19399c9b 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2208,6 +2208,8 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_deposit_i32:
         return true;
 
+    case INDEX_op_add2:
+        return has_type && TCG_TARGET_HAS_add2(type);
     case INDEX_op_andc:
         return has_type && TCG_TARGET_HAS_andc(type);
     case INDEX_op_eqv:
@@ -2220,6 +2222,8 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
         return has_type && TCG_TARGET_HAS_not(type);
     case INDEX_op_orc:
         return has_type && TCG_TARGET_HAS_orc(type);
+    case INDEX_op_sub2:
+        return has_type && TCG_TARGET_HAS_sub2(type);
 
     case INDEX_op_negsetcond_i32:
         return TCG_TARGET_HAS_negsetcond(TCG_TYPE_I32);
@@ -2237,10 +2241,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
         return TCG_TARGET_HAS_rot(TCG_TYPE_I32);
     case INDEX_op_extract2_i32:
         return TCG_TARGET_HAS_extract2(TCG_TYPE_I32);
-    case INDEX_op_add2_i32:
-        return TCG_TARGET_HAS_add2(TCG_TYPE_I32);
-    case INDEX_op_sub2_i32:
-        return TCG_TARGET_HAS_sub2(TCG_TYPE_I32);
     case INDEX_op_mulu2_i32:
         return TCG_TARGET_HAS_mulu2(TCG_TYPE_I32);
     case INDEX_op_muls2_i32:
@@ -2307,10 +2307,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
         return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_ctz(TCG_TYPE_I64);
     case INDEX_op_ctpop_i64:
         return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_ctpop(TCG_TYPE_I64);
-    case INDEX_op_add2_i64:
-        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_add2(TCG_TYPE_I64);
-    case INDEX_op_sub2_i64:
-        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_sub2(TCG_TYPE_I64);
     case INDEX_op_mulu2_i64:
         return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_mulu2(TCG_TYPE_I64);
     case INDEX_op_muls2_i64:
@@ -3951,12 +3947,10 @@ liveness_pass_1(TCGContext *s)
             la_reset_pref(ts);
             break;
 
-        case INDEX_op_add2_i32:
-        case INDEX_op_add2_i64:
+        case INDEX_op_add2:
             opc_new = INDEX_op_add;
             goto do_addsub2;
-        case INDEX_op_sub2_i32:
-        case INDEX_op_sub2_i64:
+        case INDEX_op_sub2:
             opc_new = INDEX_op_sub;
         do_addsub2:
             nb_iargs = 4;
diff --git a/tcg/tci.c b/tcg/tci.c
index 568b00f35e..b9c9bc27f7 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -649,17 +649,31 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
                 tb_ptr = ptr;
             }
             break;
-        case INDEX_op_add2_i32:
+        case INDEX_op_add2:
             tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
-            T1 = tci_uint64(regs[r3], regs[r2]);
-            T2 = tci_uint64(regs[r5], regs[r4]);
-            tci_write_reg64(regs, r1, r0, T1 + T2);
+            if (TCG_TARGET_REG_BITS == 32) {
+                T1 = tci_uint64(regs[r3], regs[r2]);
+                T2 = tci_uint64(regs[r5], regs[r4]);
+                tci_write_reg64(regs, r1, r0, T1 + T2);
+            } else {
+                T1 = regs[r2] + regs[r4];
+                T2 = regs[r3] + regs[r5] + (T1 < regs[r2]);
+                regs[r0] = T1;
+                regs[r1] = T2;
+            }
             break;
-        case INDEX_op_sub2_i32:
+        case INDEX_op_sub2:
             tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
-            T1 = tci_uint64(regs[r3], regs[r2]);
-            T2 = tci_uint64(regs[r5], regs[r4]);
-            tci_write_reg64(regs, r1, r0, T1 - T2);
+            if (TCG_TARGET_REG_BITS == 32) {
+                T1 = tci_uint64(regs[r3], regs[r2]);
+                T2 = tci_uint64(regs[r5], regs[r4]);
+                tci_write_reg64(regs, r1, r0, T1 - T2);
+            } else {
+                T1 = regs[r2] - regs[r4];
+                T2 = regs[r3] - regs[r5] - (regs[r2] < regs[r4]);
+                regs[r0] = T1;
+                regs[r1] = T2;
+            }
             break;
         case INDEX_op_mulu2_i32:
             tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
@@ -744,20 +758,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
             muls64(&regs[r0], &regs[r1], regs[r2], regs[r3]);
             break;
-        case INDEX_op_add2_i64:
-            tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
-            T1 = regs[r2] + regs[r4];
-            T2 = regs[r3] + regs[r5] + (T1 < regs[r2]);
-            regs[r0] = T1;
-            regs[r1] = T2;
-            break;
-        case INDEX_op_sub2_i64:
-            tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
-            T1 = regs[r2] - regs[r4];
-            T2 = regs[r3] - regs[r5] - (regs[r2] < regs[r4]);
-            regs[r0] = T1;
-            regs[r1] = T2;
-            break;
 
             /* Shift/rotate operations (64 bit). */
 
@@ -1150,10 +1150,8 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                            str_r(r2), str_r(r3));
         break;
 
-    case INDEX_op_add2_i32:
-    case INDEX_op_add2_i64:
-    case INDEX_op_sub2_i32:
-    case INDEX_op_sub2_i64:
+    case INDEX_op_add2:
+    case INDEX_op_sub2:
         tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
         info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %s, %s, %s",
                            op_name, str_r(r0), str_r(r1), str_r(r2),
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 3a4d878e14..af3b9ad542 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2456,24 +2456,16 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_extr(s, ext, a0, REG0(2), REG0(1), args[3]);
         break;
 
-    case INDEX_op_add2_i32:
-        tcg_out_addsub2(s, TCG_TYPE_I32, a0, a1, REG0(2), REG0(3),
-                        (int32_t)args[4], args[5], const_args[4],
+    case INDEX_op_add2:
+        tcg_out_addsub2(s, ext, a0, a1, REG0(2), REG0(3),
+                        args[4], args[5], const_args[4],
                         const_args[5], false);
         break;
-    case INDEX_op_add2_i64:
-        tcg_out_addsub2(s, TCG_TYPE_I64, a0, a1, REG0(2), REG0(3), args[4],
-                        args[5], const_args[4], const_args[5], false);
-        break;
-    case INDEX_op_sub2_i32:
-        tcg_out_addsub2(s, TCG_TYPE_I32, a0, a1, REG0(2), REG0(3),
-                        (int32_t)args[4], args[5], const_args[4],
+    case INDEX_op_sub2:
+        tcg_out_addsub2(s, ext, a0, a1, REG0(2), REG0(3),
+                        args[4], args[5], const_args[4],
                         const_args[5], true);
         break;
-    case INDEX_op_sub2_i64:
-        tcg_out_addsub2(s, TCG_TYPE_I64, a0, a1, REG0(2), REG0(3), args[4],
-                        args[5], const_args[4], const_args[5], true);
-        break;
 
     case INDEX_op_muluh_i64:
         tcg_out_insn(s, 3508, UMULH, TCG_TYPE_I64, a0, a1, a2);
@@ -3052,10 +3044,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_extract2_i64:
         return C_O1_I2(r, rZ, rZ);
 
-    case INDEX_op_add2_i32:
-    case INDEX_op_add2_i64:
-    case INDEX_op_sub2_i32:
-    case INDEX_op_sub2_i64:
+    case INDEX_op_add2:
+    case INDEX_op_sub2:
         return C_O2_I4(r, r, rZ, rZ, rA, rMZ);
 
     case INDEX_op_add_vec:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 03069148e1..d2014008a2 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1942,7 +1942,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     gen_arith:
         tcg_out_dat_rI(s, COND_AL, c, args[0], args[1], args[2], const_args[2]);
         break;
-    case INDEX_op_add2_i32:
+    case INDEX_op_add2:
         a0 = args[0], a1 = args[1], a2 = args[2];
         a3 = args[3], a4 = args[4], a5 = args[5];
         if (a0 == a3 || (a0 == a5 && !const_args[5])) {
@@ -1954,7 +1954,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                         a1, a3, a5, const_args[5]);
         tcg_out_mov_reg(s, COND_AL, args[0], a0);
         break;
-    case INDEX_op_sub2_i32:
+    case INDEX_op_sub2:
         a0 = args[0], a1 = args[1], a2 = args[2];
         a3 = args[3], a4 = args[4], a5 = args[5];
         if ((a0 == a3 && !const_args[3]) || (a0 == a5 && !const_args[5])) {
@@ -2233,9 +2233,9 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
         return C_O1_I2(r, rZ, rZ);
     case INDEX_op_movcond_i32:
         return C_O1_I4(r, r, rIN, rIK, 0);
-    case INDEX_op_add2_i32:
+    case INDEX_op_add2:
         return C_O2_I4(r, r, r, r, rIN, rIK);
-    case INDEX_op_sub2_i32:
+    case INDEX_op_sub2:
         return C_O2_I4(r, r, rI, rI, rIN, rIK);
     case INDEX_op_brcond2_i32:
         return C_O0_I4(r, r, rI, rI);
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index afe62d8067..456e93ad4f 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2969,7 +2969,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     OP_32_64(muls2):
         tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_IMUL, args[3]);
         break;
-    OP_32_64(add2):
+    case INDEX_op_add2:
         if (const_args[4]) {
             tgen_arithi(s, ARITH_ADD + rexw, a0, args[4], 1);
         } else {
@@ -2981,7 +2981,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
             tgen_arithr(s, ARITH_ADC + rexw, a1, args[5]);
         }
         break;
-    OP_32_64(sub2):
+    case INDEX_op_sub2:
         if (const_args[4]) {
             tgen_arithi(s, ARITH_SUB + rexw, a0, args[4], 1);
         } else {
@@ -3777,10 +3777,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_muls2_i64:
         return C_O2_I2(a, d, a, r);
 
-    case INDEX_op_add2_i32:
-    case INDEX_op_add2_i64:
-    case INDEX_op_sub2_i32:
-    case INDEX_op_sub2_i64:
+    case INDEX_op_add2:
+    case INDEX_op_sub2:
         return C_N1_O1_I4(r, r, 0, 1, re, re);
 
     case INDEX_op_ctz_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 34284441ed..ad60304098 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2141,11 +2141,13 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_add2_i32:
+    case INDEX_op_add2:
+        tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
         tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
                         const_args[4], const_args[5], false);
         break;
-    case INDEX_op_sub2_i32:
+    case INDEX_op_sub2:
+        tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
         tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
                         const_args[4], const_args[5], true);
         break;
@@ -2252,8 +2254,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
         return (use_mips32r6_instructions
                 ? C_O1_I4(r, rZ, rZ, rZ, rZ)
                 : C_O1_I4(r, rZ, rZ, rZ, 0));
-    case INDEX_op_add2_i32:
-    case INDEX_op_sub2_i32:
+    case INDEX_op_add2:
+    case INDEX_op_sub2:
         return C_O2_I4(r, r, rZ, rZ, rN, rN);
     case INDEX_op_setcond2_i32:
         return C_O1_I4(r, rZ, rZ, rZ, rZ);
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index c984bb24d3..b74802dd01 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3439,14 +3439,11 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                         args[3], args[4], const_args[2]);
         break;
 
-#if TCG_TARGET_REG_BITS == 64
-    case INDEX_op_add2_i64:
-#else
-    case INDEX_op_add2_i32:
-#endif
+    case INDEX_op_add2:
         /* Note that the CA bit is defined based on the word size of the
            environment.  So in 64-bit mode it's always carry-out of bit 63.
            The fallback code using deposit works just as well for 32-bit.  */
+        tcg_debug_assert(type == TCG_TYPE_REG);
         a0 = args[0], a1 = args[1];
         if (a0 == args[3] || (!const_args[5] && a0 == args[5])) {
             a0 = TCG_REG_R0;
@@ -3466,11 +3463,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-#if TCG_TARGET_REG_BITS == 64
-    case INDEX_op_sub2_i64:
-#else
-    case INDEX_op_sub2_i32:
-#endif
+    case INDEX_op_sub2:
+        tcg_debug_assert(type == TCG_TYPE_REG);
         a0 = args[0], a1 = args[1];
         if (a0 == args[5] || (!const_args[3] && a0 == args[3])) {
             a0 = TCG_REG_R0;
@@ -4229,11 +4223,9 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
         return C_O0_I4(r, r, ri, ri);
     case INDEX_op_setcond2_i32:
         return C_O1_I4(r, r, r, ri, ri);
-    case INDEX_op_add2_i64:
-    case INDEX_op_add2_i32:
+    case INDEX_op_add2:
         return C_O2_I4(r, r, r, r, rI, rZM);
-    case INDEX_op_sub2_i64:
-    case INDEX_op_sub2_i32:
+    case INDEX_op_sub2:
         return C_O2_I4(r, r, rI, rZM, r, r);
 
     case INDEX_op_qemu_ld_a32_i32:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 1d008278d2..f87cb3e880 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2261,21 +2261,15 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_cltz(s, TCG_TYPE_I64, OPC_CTZ, a0, a1, a2, c2);
         break;
 
-    case INDEX_op_add2_i32:
+    case INDEX_op_add2:
         tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
-                        const_args[4], const_args[5], false, true);
+                        const_args[4], const_args[5], false,
+                        type == TCG_TYPE_I32);
         break;
-    case INDEX_op_add2_i64:
+    case INDEX_op_sub2:
         tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
-                        const_args[4], const_args[5], false, false);
-        break;
-    case INDEX_op_sub2_i32:
-        tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
-                        const_args[4], const_args[5], true, true);
-        break;
-    case INDEX_op_sub2_i64:
-        tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
-                        const_args[4], const_args[5], true, false);
+                        const_args[4], const_args[5], true,
+                        type == TCG_TYPE_I32);
         break;
 
     case INDEX_op_brcond_i32:
@@ -2692,10 +2686,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_movcond_i64:
         return C_O1_I4(r, r, rI, rM, rM);
 
-    case INDEX_op_add2_i32:
-    case INDEX_op_add2_i64:
-    case INDEX_op_sub2_i32:
-    case INDEX_op_sub2_i64:
+    case INDEX_op_add2:
+    case INDEX_op_sub2:
         return C_O2_I4(r, r, rZ, rZ, rM, rM);
 
     case INDEX_op_qemu_ld_a32_i32:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 38338e316c..dce96b5ba6 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2497,21 +2497,47 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_add2_i32:
-        if (const_args[4]) {
-            tcg_out_insn(s, RIL, ALFI, args[0], args[4]);
+    case INDEX_op_add2:
+        if (type == TCG_TYPE_I32) {
+            if (const_args[4]) {
+                tcg_out_insn(s, RIL, ALFI, args[0], args[4]);
+            } else {
+                tcg_out_insn(s, RR, ALR, args[0], args[4]);
+            }
+            tcg_out_insn(s, RRE, ALCR, args[1], args[5]);
         } else {
-            tcg_out_insn(s, RR, ALR, args[0], args[4]);
+            if (const_args[4]) {
+                if ((int64_t)args[4] >= 0) {
+                    tcg_out_insn(s, RIL, ALGFI, args[0], args[4]);
+                } else {
+                    tcg_out_insn(s, RIL, SLGFI, args[0], -args[4]);
+                }
+            } else {
+                tcg_out_insn(s, RRE, ALGR, args[0], args[4]);
+            }
+            tcg_out_insn(s, RRE, ALCGR, args[1], args[5]);
         }
-        tcg_out_insn(s, RRE, ALCR, args[1], args[5]);
         break;
-    case INDEX_op_sub2_i32:
-        if (const_args[4]) {
-            tcg_out_insn(s, RIL, SLFI, args[0], args[4]);
+    case INDEX_op_sub2:
+        if (type == TCG_TYPE_I32) {
+            if (const_args[4]) {
+                tcg_out_insn(s, RIL, SLFI, args[0], args[4]);
+            } else {
+                tcg_out_insn(s, RR, SLR, args[0], args[4]);
+            }
+            tcg_out_insn(s, RRE, SLBR, args[1], args[5]);
         } else {
-            tcg_out_insn(s, RR, SLR, args[0], args[4]);
+            if (const_args[4]) {
+                if ((int64_t)args[4] >= 0) {
+                    tcg_out_insn(s, RIL, SLGFI, args[0], args[4]);
+                } else {
+                    tcg_out_insn(s, RIL, ALGFI, args[0], -args[4]);
+                }
+            } else {
+                tcg_out_insn(s, RRE, SLGR, args[0], args[4]);
+            }
+            tcg_out_insn(s, RRE, SLBGR, args[1], args[5]);
         }
-        tcg_out_insn(s, RRE, SLBR, args[1], args[5]);
         break;
 
     case INDEX_op_br:
@@ -2651,31 +2677,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_add2_i64:
-        if (const_args[4]) {
-            if ((int64_t)args[4] >= 0) {
-                tcg_out_insn(s, RIL, ALGFI, args[0], args[4]);
-            } else {
-                tcg_out_insn(s, RIL, SLGFI, args[0], -args[4]);
-            }
-        } else {
-            tcg_out_insn(s, RRE, ALGR, args[0], args[4]);
-        }
-        tcg_out_insn(s, RRE, ALCGR, args[1], args[5]);
-        break;
-    case INDEX_op_sub2_i64:
-        if (const_args[4]) {
-            if ((int64_t)args[4] >= 0) {
-                tcg_out_insn(s, RIL, SLGFI, args[0], args[4]);
-            } else {
-                tcg_out_insn(s, RIL, ALGFI, args[0], -args[4]);
-            }
-        } else {
-            tcg_out_insn(s, RRE, SLGR, args[0], args[4]);
-        }
-        tcg_out_insn(s, RRE, SLBGR, args[1], args[5]);
-        break;
-
     case INDEX_op_brcond_i64:
         tgen_brcond(s, TCG_TYPE_I64, args[2], args[0],
                     args[1], const_args[1], arg_label(args[3]));
@@ -3316,13 +3317,11 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_muls2_i64:
         return C_O2_I2(o, m, r, r);
 
-    case INDEX_op_add2_i32:
-    case INDEX_op_sub2_i32:
-        return C_N1_O1_I4(r, r, 0, 1, ri, r);
-
-    case INDEX_op_add2_i64:
-    case INDEX_op_sub2_i64:
-        return C_N1_O1_I4(r, r, 0, 1, rJU, r);
+    case INDEX_op_add2:
+    case INDEX_op_sub2:
+        return (op->type == TCG_TYPE_I32
+                ? C_N1_O1_I4(r, r, 0, 1, ri, r)
+                : C_N1_O1_I4(r, r, 0, 1, rJU, r));
 
     case INDEX_op_st_vec:
         return C_O0_I2(v, r);
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 0134898c8a..fffd203c03 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1426,15 +1426,25 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_movcond_i32(s, args[5], a0, a1, a2, c2, args[3], const_args[3]);
         break;
 
-    case INDEX_op_add2_i32:
-        tcg_out_addsub2_i32(s, args[0], args[1], args[2], args[3],
-                            args[4], const_args[4], args[5], const_args[5],
-                            ARITH_ADDCC, ARITH_ADDC);
+    case INDEX_op_add2:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_addsub2_i32(s, args[0], args[1], args[2], args[3],
+                                args[4], const_args[4], args[5], const_args[5],
+                                ARITH_ADDCC, ARITH_ADDC);
+        } else {
+            tcg_out_addsub2_i64(s, args[0], args[1], args[2], args[3], args[4],
+                                const_args[4], args[5], const_args[5], false);
+        }
         break;
-    case INDEX_op_sub2_i32:
-        tcg_out_addsub2_i32(s, args[0], args[1], args[2], args[3],
-                            args[4], const_args[4], args[5], const_args[5],
-                            ARITH_SUBCC, ARITH_SUBC);
+    case INDEX_op_sub2:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_addsub2_i32(s, args[0], args[1], args[2], args[3],
+                                args[4], const_args[4], args[5], const_args[5],
+                                ARITH_SUBCC, ARITH_SUBC);
+        } else {
+            tcg_out_addsub2_i64(s, args[0], args[1], args[2], args[3], args[4],
+                                const_args[4], args[5], const_args[5], true);
+        }
         break;
     case INDEX_op_mulu2_i32:
         c = ARITH_UMUL;
@@ -1498,14 +1508,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_movcond_i64:
         tcg_out_movcond_i64(s, args[5], a0, a1, a2, c2, args[3], const_args[3]);
         break;
-    case INDEX_op_add2_i64:
-        tcg_out_addsub2_i64(s, args[0], args[1], args[2], args[3], args[4],
-                            const_args[4], args[5], const_args[5], false);
-        break;
-    case INDEX_op_sub2_i64:
-        tcg_out_addsub2_i64(s, args[0], args[1], args[2], args[3], args[4],
-                            const_args[4], args[5], const_args[5], true);
-        break;
     case INDEX_op_muluh_i64:
         tcg_out_arith(s, args[0], args[1], args[2], ARITH_UMULXHI);
         break;
@@ -1607,10 +1609,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
         return C_O1_I4(r, rZ, rJ, rI, 0);
-    case INDEX_op_add2_i32:
-    case INDEX_op_add2_i64:
-    case INDEX_op_sub2_i32:
-    case INDEX_op_sub2_i64:
+    case INDEX_op_add2:
+    case INDEX_op_sub2:
         return C_O2_I4(r, r, rZ, rZ, rJ, rJ);
     case INDEX_op_mulu2_i32:
     case INDEX_op_muls2_i32:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 2268e1ff6d..04f35cecfa 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -111,10 +111,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_brcond_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_add2_i32:
-    case INDEX_op_add2_i64:
-    case INDEX_op_sub2_i32:
-    case INDEX_op_sub2_i64:
+    case INDEX_op_add2:
+    case INDEX_op_sub2:
         return C_O2_I4(r, r, r, r, r, r);
 
 #if TCG_TARGET_REG_BITS == 32
@@ -779,8 +777,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    CASE_32_64(add2)
-    CASE_32_64(sub2)
+    case INDEX_op_add2:
+    case INDEX_op_sub2:
         tcg_out_op_rrrrrr(s, opc, args[0], args[1], args[2],
                           args[3], args[4], args[5]);
         break;
-- 
2.43.0


