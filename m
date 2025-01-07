Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0FCBE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4b2-00027Z-9W; Tue, 07 Jan 2025 03:05:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aq-00016S-Ly
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:40 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4ag-0003e2-T3
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:40 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2ef87d24c2dso17961885a91.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237129; x=1736841929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=66RjKB4I+Vawrf4bal7Y1tKA6CblprwyrYKDh86iB2o=;
 b=ve0Y9/8NDph773AbeBXqO94LG0h1IgMW8m6lxYdhZQ9QWGxKDRw9LVMpEqTbtLZ1Vt
 otsC2GdOzI4WCwQ4kYKgkoIHFzCixHjDPPUSp4iEJmOjrheaYt4B95niJUdt4zBMR2Mq
 UHxGMcFlgCCCDvv+MtBWWX+h9lkd1z10fGKqToh7v9s0wEOaYPjwOnyU7C411Qyu4Q4t
 1fuKMB7O2W8HTWTR3l9cuX6jaZpt862oBMzsWjcPvdlfWOXYHGfYeHHm08KtWBBsusE2
 WwNdtw+dGBEBfUcnkMcC5nH2T4xz0673bexsWLPjORDQ4SNGWAOckh9BlmjA9xuZsISp
 vXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237129; x=1736841929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=66RjKB4I+Vawrf4bal7Y1tKA6CblprwyrYKDh86iB2o=;
 b=uuUywnvuOfJdBxAEfQfL58G/Q3wmPYnH/S7khNuumPbC2xVej6hXzXCk3oHmUTOLeN
 +oaJz4tOQ4c9DG5oLWyIJPKE/UtPidqRY+ndt9+jceer/yt4x9UMrrxzmdzqnIlO9vYO
 8+eeYB48jK9JSDPfonqwXcJjy5J8Q85aoqH2hD4zXZVBJ03Kl+5KxyeOOJjYsvnQE4+h
 kxMu2esgN+ap8ZOZT95/SDJ92fHByMI6K6wdc3w34Hyov+G7b1UuH9QbMVVML4VLPu9a
 5T5UAp7IYl5sSAJWOvdteXuyUKzYJmNHFlmGUSq68v4DA3qtXPSE/koGIEQGHzsHI3IX
 OTXw==
X-Gm-Message-State: AOJu0Yzh0Gqmzb2wrSu4Ig61ls17tx91koVdl05tiXeqCJWoJkFqO4cH
 77AoMp9HsWDDxGav0Ebvz6CZa2YXlflicI74m6g9OF8ejS4rlvWVkP6cCwVteS1jmVj7/vbTaST
 Q
X-Gm-Gg: ASbGnct3TJjaX/ePSjIYM65Qf3LQoapVjuSgVf5GhC1K+yF+cp5/Xb/5kup9rKHC/Bg
 SA1xBCduT+TCGEWlEjj/fVqn1hUAR5zFLMXN3h/kG7DpCmWVASBQShck843QXYB2L4h0NEd9SND
 0Sp4O0qbmwnKW0AKpa5Fg9u77WKbdwi8TTZp++IT9ZBdc/9Ba9GSb6PTZsLSp2sNdyQyzSzrwk3
 Djd06qQ7bPJ51fqs1z17tuCaSxuXRXNRvYK9JvT8cPrfGydU9nwDHnwM1NEcMSNoO7YFpdD6E5K
 KCuVWnkeV2LUUvLcJg==
X-Google-Smtp-Source: AGHT+IH31C9V28qgnktmSyzGBmT1lRmoLbbF4xFTj97SF0ns18qlGff/SK1YymzPLpE43hsUZplzCg==
X-Received: by 2002:a05:6a00:ac5:b0:726:41e:b310 with SMTP id
 d2e1a72fcca58-72abdec84b4mr77980884b3a.12.1736237129567; 
 Tue, 07 Jan 2025 00:05:29 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 71/81] tcg: Merge INDEX_op_nand_{i32,i64}
Date: Tue,  7 Jan 2025 00:01:02 -0800
Message-ID: <20250107080112.1175095-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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
 include/tcg/tcg-opc.h    | 3 +--
 tcg/optimize.c           | 6 ++++--
 tcg/tcg-op.c             | 8 ++++----
 tcg/tcg.c                | 6 ++----
 tcg/tci.c                | 5 ++---
 tcg/tci/tcg-target.c.inc | 2 +-
 6 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 4df1520186..4c07095eb9 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -43,6 +43,7 @@ DEF(add, 1, 2, 0, TCG_OPF_INT)
 DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
 DEF(eqv, 1, 2, 0, TCG_OPF_INT)
+DEF(nand, 1, 2, 0, TCG_OPF_INT)
 DEF(or, 1, 2, 0, TCG_OPF_INT)
 DEF(orc, 1, 2, 0, TCG_OPF_INT)
 DEF(xor, 1, 2, 0, TCG_OPF_INT)
@@ -94,7 +95,6 @@ DEF(bswap16_i32, 1, 1, 1, 0)
 DEF(bswap32_i32, 1, 1, 1, 0)
 DEF(not_i32, 1, 1, 0, 0)
 DEF(neg_i32, 1, 1, 0, 0)
-DEF(nand_i32, 1, 2, 0, 0)
 DEF(nor_i32, 1, 2, 0, 0)
 DEF(clz_i32, 1, 2, 0, 0)
 DEF(ctz_i32, 1, 2, 0, 0)
@@ -147,7 +147,6 @@ DEF(bswap32_i64, 1, 1, 1, 0)
 DEF(bswap64_i64, 1, 1, 1, 0)
 DEF(not_i64, 1, 1, 0, 0)
 DEF(neg_i64, 1, 1, 0, 0)
-DEF(nand_i64, 1, 2, 0, 0)
 DEF(nor_i64, 1, 2, 0, 0)
 DEF(clz_i64, 1, 2, 0, 0)
 DEF(ctz_i64, 1, 2, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index eed3d03e65..f80a6d1170 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -481,7 +481,8 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     case INDEX_op_eqv_vec:
         return ~(x ^ y);
 
-    CASE_OP_32_64_VEC(nand):
+    case INDEX_op_nand:
+    case INDEX_op_nand_vec:
         return ~(x & y);
 
     CASE_OP_32_64_VEC(nor):
@@ -2977,7 +2978,8 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(mulu2):
             done = fold_multiply2(&ctx, op);
             break;
-        CASE_OP_32_64_VEC(nand):
+        case INDEX_op_nand:
+        case INDEX_op_nand_vec:
             done = fold_nand(&ctx, op);
             break;
         CASE_OP_32_64(neg):
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 3921bac48d..57782864fa 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -690,8 +690,8 @@ void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (tcg_op_supported(INDEX_op_nand_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_nand_i32, ret, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_nand, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_nand, ret, arg1, arg2);
     } else {
         tcg_gen_and_i32(ret, arg1, arg2);
         tcg_gen_not_i32(ret, ret);
@@ -2292,8 +2292,8 @@ void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_nand_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
         tcg_gen_nand_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
-    } else if (tcg_op_supported(INDEX_op_nand_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_nand_i64, ret, arg1, arg2);
+    } else if (tcg_op_supported(INDEX_op_nand, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_nand, ret, arg1, arg2);
     } else {
         tcg_gen_and_i64(ret, arg1, arg2);
         tcg_gen_not_i64(ret, ret);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index d40f1f2c25..c419cf4a16 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -995,8 +995,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
-    OUTOP(INDEX_op_nand_i32, TCGOutOpBinary, outop_nand),
-    OUTOP(INDEX_op_nand_i64, TCGOutOpBinary, outop_nand),
+    OUTOP(INDEX_op_nand, TCGOutOpBinary, outop_nand),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
@@ -5419,8 +5418,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_eqv:
-    case INDEX_op_nand_i32:
-    case INDEX_op_nand_i64:
+    case INDEX_op_nand:
     case INDEX_op_or:
     case INDEX_op_orc:
     case INDEX_op_xor:
diff --git a/tcg/tci.c b/tcg/tci.c
index 408bf8e574..9d89ca0a6b 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -569,7 +569,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ~(regs[r1] ^ regs[r2]);
             break;
-        CASE_32_64(nand)
+        case INDEX_op_nand:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ~(regs[r1] & regs[r2]);
             break;
@@ -1134,6 +1134,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_eqv:
+    case INDEX_op_nand:
     case INDEX_op_or:
     case INDEX_op_orc:
     case INDEX_op_xor:
@@ -1141,8 +1142,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
-    case INDEX_op_nand_i32:
-    case INDEX_op_nand_i64:
     case INDEX_op_nor_i32:
     case INDEX_op_nor_i64:
     case INDEX_op_div_i32:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 808bb635e2..97f6c12749 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -694,7 +694,7 @@ static const TCGOutOpBinary outop_eqv = {
 static void tgen_nand(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_op_rrr(s, glue(INDEX_op_nand_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+    tcg_out_op_rrr(s, INDEX_op_nand, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_nand = {
-- 
2.43.0


