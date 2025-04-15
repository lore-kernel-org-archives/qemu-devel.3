Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFDFC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4lv6-0000AG-SB; Tue, 15 Apr 2025 15:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4luh-00005W-85
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:43 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4luc-00080x-HU
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:41 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-736c062b1f5so5052010b3a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745137; x=1745349937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J31OOvGJ00JVHnDauaRRxyD29Nta/krZ9PmWwqbY4rM=;
 b=ZIwYQtxVPpIXFNkEqOZY+q1ioC6pTwsX5w7vHuXE43U1LLIK6hsDqFvwXvBYFEAkNM
 3zcS9fggWktv617reMZ8V/NzJ7v4iugacQm+wiP7XkcLOrWZs/lltRkFW+lMmzH5KyXt
 obxuoIfAQoEXu50cKqejNRVTLPFdweFEzNj1AEidmAUKwi+mhnuBlS6U6Xk6aonuswnY
 jmX3Wx/O6MX5XsivRbIIxiR9Gd2x2OSprAH7B7FVIEewzRlte+jBzO/07PBhp52Y/H5y
 8+gIy06j/+8W4KLR6RqHz8cocf3wfb8rB4AusdDBZzDgbllcH8qj8Z4Brtn3tstjDpUm
 Apzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745137; x=1745349937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J31OOvGJ00JVHnDauaRRxyD29Nta/krZ9PmWwqbY4rM=;
 b=dM6dKfkaowRfXtL390QLzBsJmmFhbOUwsGcP0Es4hwTbVN4llPbVQl9cIgnIIWI1u+
 ibCG2bBDzL16Y0lxPPVyhs0LxlBRI/2KfQkJccOa0qo/lbA3cV9v8O4SnBZRTg+VpkJi
 uoCY7+CMqWA9WwOMCgjsv1WL+Bf6nHjFOxKuQORqWbbYyIi7HVyFsxdl6aPnv2R4KnA2
 MlQloh1zHak5SWqdukgr8nEnstLNuCvwbk5Zd4nyDr4P4HS8pjdGZ0oL81lIOAqPEIYv
 shebrG7NoMxIs5uFn/AgNsqsMk6OockeCWM92f+CX/Rn/1ZGDJ5pqL39BtE+adnrqEo3
 jkoQ==
X-Gm-Message-State: AOJu0YxoVoFemvCgpkZ5SUr/ZRa/Z4Fwtl0x/76XuXtgg1AymQMcXo9O
 aLdKxwccRBygYbo9LCixa/GC/EHQkNxawcdPBq+hC7V2m1PnIhyvtmqli/qRV2JPPWJvlmkPtxv
 d
X-Gm-Gg: ASbGnctK25rFTIyB+Yu+2bRvvwSmGEwUG/b6nr1OImzGeFGZP6l+UMCP6tr2dztonA8
 XNP0BGBE0W2tZNUDjneMoOYjCcS/edpRqEqVIaHKVXIE4861sNE/W++gU09r7g+/AY34bfgLqpo
 HYIHDcpmeQIw69/hbrXxIC7TAJeu2q0wzM/zRGesLXk77OL+KesTdlLeLlxjHGuYDXjbZp74p/M
 a2VYjBTgAF8wjzBIY86LjhcdxVH5uus5hHizQK/lkITfOJl76789VmaBJzQ93pZofh1GMdSqtef
 A08qk2TEQ2l4bWOGosAZ82qU3OI9cXoKnmS/Mh4drMtnWFx5A4blZQXMD7B5atWEwgGO1SVeGas
 =
X-Google-Smtp-Source: AGHT+IFFFs4YB9PN8ZB2XfCK4qMC0bgF8HpogBEv0psutEVes7igb7alcz5m49mofsoLfzji5U0ebQ==
X-Received: by 2002:a05:6a00:1144:b0:736:32d2:aa82 with SMTP id
 d2e1a72fcca58-73c1fb5cc51mr787576b3a.23.1744745136595; 
 Tue, 15 Apr 2025 12:25:36 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f82ebsm9225124b3a.92.2025.04.15.12.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:25:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 022/163] tcg: Merge INDEX_op_eqv_{i32,i64}
Date: Tue, 15 Apr 2025 12:22:53 -0700
Message-ID: <20250415192515.232910-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    | 3 +--
 tcg/optimize.c           | 6 ++++--
 tcg/tcg-op.c             | 8 ++++----
 tcg/tcg.c                | 6 ++----
 tcg/tci.c                | 5 ++---
 docs/devel/tcg-ops.rst   | 2 +-
 tcg/tci/tcg-target.c.inc | 2 +-
 7 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 8f6115bedb..c6869de244 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -42,6 +42,7 @@ DEF(mov, 1, 1, 0, TCG_OPF_INT | TCG_OPF_NOT_PRESENT)
 DEF(add, 1, 2, 0, TCG_OPF_INT)
 DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
+DEF(eqv, 1, 2, 0, TCG_OPF_INT)
 DEF(or, 1, 2, 0, TCG_OPF_INT)
 DEF(orc, 1, 2, 0, TCG_OPF_INT)
 DEF(xor, 1, 2, 0, TCG_OPF_INT)
@@ -93,7 +94,6 @@ DEF(bswap16_i32, 1, 1, 1, 0)
 DEF(bswap32_i32, 1, 1, 1, 0)
 DEF(not_i32, 1, 1, 0, 0)
 DEF(neg_i32, 1, 1, 0, 0)
-DEF(eqv_i32, 1, 2, 0, 0)
 DEF(nand_i32, 1, 2, 0, 0)
 DEF(nor_i32, 1, 2, 0, 0)
 DEF(clz_i32, 1, 2, 0, 0)
@@ -147,7 +147,6 @@ DEF(bswap32_i64, 1, 1, 1, 0)
 DEF(bswap64_i64, 1, 1, 1, 0)
 DEF(not_i64, 1, 1, 0, 0)
 DEF(neg_i64, 1, 1, 0, 0)
-DEF(eqv_i64, 1, 2, 0, 0)
 DEF(nand_i64, 1, 2, 0, 0)
 DEF(nor_i64, 1, 2, 0, 0)
 DEF(clz_i64, 1, 2, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index a49d51f0d7..4efd6a1b2c 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -477,7 +477,8 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     case INDEX_op_orc_vec:
         return x | ~y;
 
-    CASE_OP_32_64_VEC(eqv):
+    case INDEX_op_eqv:
+    case INDEX_op_eqv_vec:
         return ~(x ^ y);
 
     CASE_OP_32_64_VEC(nand):
@@ -2917,7 +2918,8 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_dup2_vec:
             done = fold_dup2(&ctx, op);
             break;
-        CASE_OP_32_64_VEC(eqv):
+        case INDEX_op_eqv:
+        case INDEX_op_eqv_vec:
             done = fold_eqv(&ctx, op);
             break;
         CASE_OP_32_64(extract):
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8008b0d3e0..2520a60cee 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -680,8 +680,8 @@ void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (tcg_op_supported(INDEX_op_eqv_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_eqv_i32, ret, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_eqv, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_eqv, ret, arg1, arg2);
     } else {
         tcg_gen_xor_i32(ret, arg1, arg2);
         tcg_gen_not_i32(ret, ret);
@@ -2279,8 +2279,8 @@ void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_eqv_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
         tcg_gen_eqv_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
-    } else if (tcg_op_supported(INDEX_op_eqv_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_eqv_i64, ret, arg1, arg2);
+    } else if (tcg_op_supported(INDEX_op_eqv, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_eqv, ret, arg1, arg2);
     } else {
         tcg_gen_xor_i64(ret, arg1, arg2);
         tcg_gen_not_i64(ret, ret);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 771d3d520f..8812295f17 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1007,8 +1007,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_add, TCGOutOpBinary, outop_add),
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
-    OUTOP(INDEX_op_eqv_i32, TCGOutOpBinary, outop_eqv),
-    OUTOP(INDEX_op_eqv_i64, TCGOutOpBinary, outop_eqv),
+    OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
@@ -5433,8 +5432,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_add:
     case INDEX_op_and:
     case INDEX_op_andc:
-    case INDEX_op_eqv_i32:
-    case INDEX_op_eqv_i64:
+    case INDEX_op_eqv:
     case INDEX_op_or:
     case INDEX_op_orc:
     case INDEX_op_xor:
diff --git a/tcg/tci.c b/tcg/tci.c
index 26a271e71f..d2baa8d3fc 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -555,7 +555,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] | ~regs[r2];
             break;
-        CASE_32_64(eqv)
+        case INDEX_op_eqv:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ~(regs[r1] ^ regs[r2]);
             break;
@@ -1079,6 +1079,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_add:
     case INDEX_op_and:
     case INDEX_op_andc:
+    case INDEX_op_eqv:
     case INDEX_op_or:
     case INDEX_op_orc:
     case INDEX_op_xor:
@@ -1086,8 +1087,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
-    case INDEX_op_eqv_i32:
-    case INDEX_op_eqv_i64:
     case INDEX_op_nand_i32:
     case INDEX_op_nand_i64:
     case INDEX_op_nor_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index a4aa4f8824..fe149e012d 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -323,7 +323,7 @@ Logical
 
      - | *t0* = *t1* & ~\ *t2*
 
-   * - eqv_i32/i64 *t0*, *t1*, *t2*
+   * - eqv *t0*, *t1*, *t2*
 
      - | *t0* = ~(*t1* ^ *t2*), or equivalently, *t0* = *t1* ^ ~\ *t2*
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 4c9e055614..fe3450373e 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -663,7 +663,7 @@ static const TCGOutOpBinary outop_andc = {
 static void tgen_eqv(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_op_rrr(s, glue(INDEX_op_eqv_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+    tcg_out_op_rrr(s, INDEX_op_eqv, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_eqv = {
-- 
2.43.0


