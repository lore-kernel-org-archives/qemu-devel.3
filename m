Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830ECC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R17-0007b8-CF; Fri, 25 Apr 2025 17:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0x-0007UH-8b
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:19 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0v-0000Ye-4O
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:18 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-736a7e126c7so2699229b3a.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618116; x=1746222916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Qdj3l3+8vI4sBBW9d78BcoNoUGEH3+s9xLslUg1o04=;
 b=jcrtOl8bdv0rOaRXEG9j4DX3pdB7O6G5f6xjMAaFRPp99t1DON+o7ukk1t/iyHbAxR
 B4FomQn0qpPwAGtHpIVUJVZg89ishvOqpbl6bJzd1ap2BWany4/2qeBF1mY2KGw5mVMR
 2SeiPcGGIw33dvjYXk9Wmq3bULsXwU0wDvIIcU23gFEBocj8QT3iGOpXOL6VhvQ1D4dx
 jWSkAT1rQJctNl1xQanrY2/KlB3LkML1k8+hITZqdF25prawxM4cD+8c80JDM0O9vTaO
 RJm+cPY6/YVexTMJCXJ35h5DzuuRzWBFLy0DuxnG+8pOVAOd7d7Kn0gqsYAplllSSxJo
 ky2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618116; x=1746222916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Qdj3l3+8vI4sBBW9d78BcoNoUGEH3+s9xLslUg1o04=;
 b=rqMJ/dafGIPNHZnJYa1n+79O9snD7Mh32JqIac+Tu6mDkiCGv/3H22myxgL1TncGwh
 MVWMChkoJvEsv/WG2gwhvjHBiN5fyEi+X7m6BiC6Kh5I02cUaYyqgljx+rmwDwRs/iqY
 rD3PLB/sRX3/ERNph/5EJzrtUAPpo/ff+QMLcX5HnCHw7vc/n/KtVHLOBmEDyZa3D7iy
 1Z/sLR0JUKrwVoHGBEPywx2PppQV8yBbh2Uhf2E10EYEHc39YsoL84EPH5h5nXJXPJ9r
 zvZg3qkJss+8mDiwztBVKLzy/SEHxRkHYnmgqBMnJq2/p7m98HWu71f5by/DoHfXrVNQ
 Gilw==
X-Gm-Message-State: AOJu0YxHv49gq7WGzY43O5R53YIcHNg5OZbQErayhbdUOaYlkDvDOqqB
 NVQZdx3WeYLDGckTbbsVjmMj8QThz/Fh1q5y3tauRqpChqJieI3tg2tPd5k3VryarkvX2w/H2VX
 n
X-Gm-Gg: ASbGncvwLxn3usuMGA3bzPmlCrrLxfRlZfvf+Q30nJXvuYzIwGLn3umt0M+jDbK8w0R
 a6rKvbq8qMUl8swIIfhtWu5QFrIhagdv06GhKpCZjsZZduTUT0Vsq2XRA0LRAeoguvbjSgplEVL
 8gg87ElV1bs6RUwHd/2OFmrso/6vf8XlYbn1g0WO09846zuJrYaOvQadVVG5r3+I8QUzZaPq27A
 +QxUNYKx8M08sCCYf3DZDQ9ySyHbdqv8W/RLcKYypnQ6YgF3QTzughFhtfLSlR+2ANU2EOWSI4+
 Pqp3ecCldCrDiyk7wIQkY7u8ZhRZM218O4QVdNxMmX21h+JisEG74zzTKq0ct0x+/12ulbd2qC0
 =
X-Google-Smtp-Source: AGHT+IGLtTiBi0dVpporOInO/pj3KDI8/tCNXcZz8oQhO6bkr7I7xhJLDOLANqsJA60nMEzCMsNM9A==
X-Received: by 2002:aa7:88d2:0:b0:736:ab1e:b1ab with SMTP id
 d2e1a72fcca58-73ff70ccfc2mr1495270b3a.0.1745618115850; 
 Fri, 25 Apr 2025 14:55:15 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e259414b0sm3664392b3a.48.2025.04.25.14.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:55:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 028/159] tcg: Merge INDEX_op_nand_{i32,i64}
Date: Fri, 25 Apr 2025 14:52:42 -0700
Message-ID: <20250425215454.886111-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
index c6869de244..1acdd7cfda 100644
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
index 47898b7086..e8e6a0c2ce 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -493,7 +493,8 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     case INDEX_op_eqv_vec:
         return ~(x ^ y);
 
-    CASE_OP_32_64_VEC(nand):
+    case INDEX_op_nand:
+    case INDEX_op_nand_vec:
         return ~(x & y);
 
     CASE_OP_32_64_VEC(nor):
@@ -2992,7 +2993,8 @@ void tcg_optimize(TCGContext *s)
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
index 50361864aa..72e9175d06 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1008,8 +1008,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
-    OUTOP(INDEX_op_nand_i32, TCGOutOpBinary, outop_nand),
-    OUTOP(INDEX_op_nand_i64, TCGOutOpBinary, outop_nand),
+    OUTOP(INDEX_op_nand, TCGOutOpBinary, outop_nand),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
@@ -5434,8 +5433,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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
index 8be59a0193..9886ddf001 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -559,7 +559,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ~(regs[r1] ^ regs[r2]);
             break;
-        CASE_32_64(nand)
+        case INDEX_op_nand:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ~(regs[r1] & regs[r2]);
             break;
@@ -1078,6 +1078,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_eqv:
+    case INDEX_op_nand:
     case INDEX_op_or:
     case INDEX_op_orc:
     case INDEX_op_xor:
@@ -1085,8 +1086,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
-    case INDEX_op_nand_i32:
-    case INDEX_op_nand_i64:
     case INDEX_op_nor_i32:
     case INDEX_op_nor_i64:
     case INDEX_op_div_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index fe149e012d..7703dfbc51 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -327,7 +327,7 @@ Logical
 
      - | *t0* = ~(*t1* ^ *t2*), or equivalently, *t0* = *t1* ^ ~\ *t2*
 
-   * - nand_i32/i64 *t0*, *t1*, *t2*
+   * - nand *t0*, *t1*, *t2*
 
      - | *t0* = ~(*t1* & *t2*)
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 2a5c72705d..34a44a7674 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -672,7 +672,7 @@ static const TCGOutOpBinary outop_eqv = {
 static void tgen_nand(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_op_rrr(s, glue(INDEX_op_nand_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+    tcg_out_op_rrr(s, INDEX_op_nand, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_nand = {
-- 
2.43.0


