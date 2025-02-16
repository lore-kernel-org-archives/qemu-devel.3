Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD3FC021A6
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnmW-0005ZU-RX; Sun, 16 Feb 2025 18:10:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmN-0005Vj-0u
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:27 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmK-0005DG-Sa
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:26 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2211cd4463cso11908045ad.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747422; x=1740352222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W1Kbd8zgxfgwT5ICnud8P9X1uIWtTSLKGQOKL0Tfo10=;
 b=OH7KeO1RgsXZcAIHyd8Y8DwwAXkcN8CaLJ/zv7aar4SzMvxj7tpGhQ0rMlyZCKRCxf
 p1Q1C4cVysRXsON2AlqcpiWKQdQYY0hs1y49S2wFEArH7Vdxe7CHg4SZGHFe36EJRrs+
 pAKq+5rXVW8gevYYrQFEgoY1sMkdKY0mnJWGgEDhUEDupO7uCPkeoctV5Gpn2dLkxuW2
 +RRrmhCBlY3XpXI1lFxQyjE2xQINBCiffA6Nq42nzZCz9TcolfpHbst8NGAjTBtWUFWV
 DC+1mX6YVnd+ZXmDAOsb6sOqr8biLy5jYWM7nUWn8TINnrXGghMlqO3rC825O/fpLUOj
 BGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747422; x=1740352222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W1Kbd8zgxfgwT5ICnud8P9X1uIWtTSLKGQOKL0Tfo10=;
 b=KO9h5L2vKiKd2ztEY74DXDqMWqpzekFxcOvbbRPvYkMIQEjw771Z9+YAjyyHhifZPg
 CivQtXfR53VOJIMlKQRq+oRvfRZybGOvZe1zgFBDh3VG5v6zoYDHL4xBe/rrJ8ZKoY3U
 RiSLmf+KkpcJgIkU8vI6Ljxrgt0M3HP8c+Pe2ggB9v8Mr92JaSRmtd3AYI1jLdsGJM0X
 N7gxAO+4htZDCaox2vlrt09Zk4nYh4k/6AQzXd8RPhv+hnWggJZY+DrFkHsz6XoKtCUv
 ZhOQq1M9y/hwC0CKCaVANsOlThkNm9ks3QRzmFqDW+fOhgNJbmzEOgYaL/mhYD1yDGnE
 Sc1g==
X-Gm-Message-State: AOJu0Ywve5nDr2+Vxcvnw4NDsV6Aapurz58sXMeVJBYZAClF7tdyP4HN
 Skk5SeW3O2V+7RipNnvJ5EO/tdNTA+xVh7AAeQMcKhRtvPKo/XNK3y8Rx9N+wHzlkE7VF/qmJb3
 o
X-Gm-Gg: ASbGncuOmgt6/hQ45iwz+cbSyf+QxuqjmkHdzfzlneRyVSqfXo1SEw4GcIcjcK9CwG5
 6YSsdzK6FETqah8jJoK9Z7zCNKi6ENshPQgE6W5h/3zoWZH+/VNTRLFAQA4ajnIGYU8Nn8RN02B
 lIq6zwWY16SfieyU1y2tGuwWdNTx10ngA2JvPfMe+0EbXzTcLMSVPYtHYB4L/ia01tv7Pyp0X4B
 SMsKongdJ3lE7sv+fqyipoSXuGwgA8kgbShEaaY1zpipPHYIZ2c5oAZs/H6YTv7/o2uFDcYpHQ5
 /PzchFi99TlGhj/vrrq2f/iFgggrqssxYQK3yjI8rjLJI/o=
X-Google-Smtp-Source: AGHT+IEPeRGjN5VafZjiOiKLDhm/VDSClQZzcYaZSH/7OO2rv1hTw0TAOfSn0GBkUEkoenxUCCc09A==
X-Received: by 2002:a17:903:41c3:b0:21f:7821:55b6 with SMTP id
 d9443c01a7336-22104030832mr116584865ad.13.1739747422481; 
 Sun, 16 Feb 2025 15:10:22 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5596115sm60198415ad.258.2025.02.16.15.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:10:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 011/162] tcg: Merge INDEX_op_andc_{i32,i64}
Date: Sun, 16 Feb 2025 15:07:40 -0800
Message-ID: <20250216231012.2808572-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
 include/tcg/tcg-opc.h          | 3 +--
 target/arm/tcg/translate-a64.c | 2 +-
 target/tricore/translate.c     | 2 +-
 tcg/optimize.c                 | 6 ++++--
 tcg/tcg-op.c                   | 8 ++++----
 tcg/tcg.c                      | 6 ++----
 tcg/tci.c                      | 5 ++---
 docs/devel/tcg-ops.rst         | 2 +-
 tcg/tci/tcg-target.c.inc       | 2 +-
 9 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index f45029caa7..9bc511992d 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -41,6 +41,7 @@ DEF(mov, 1, 1, 0, TCG_OPF_INT | TCG_OPF_NOT_PRESENT)
 
 DEF(add, 1, 2, 0, TCG_OPF_INT)
 DEF(and, 1, 2, 0, TCG_OPF_INT)
+DEF(andc, 1, 2, 0, TCG_OPF_INT)
 
 DEF(setcond_i32, 1, 2, 1, 0)
 DEF(negsetcond_i32, 1, 2, 1, 0)
@@ -91,7 +92,6 @@ DEF(bswap16_i32, 1, 1, 1, 0)
 DEF(bswap32_i32, 1, 1, 1, 0)
 DEF(not_i32, 1, 1, 0, 0)
 DEF(neg_i32, 1, 1, 0, 0)
-DEF(andc_i32, 1, 2, 0, 0)
 DEF(orc_i32, 1, 2, 0, 0)
 DEF(eqv_i32, 1, 2, 0, 0)
 DEF(nand_i32, 1, 2, 0, 0)
@@ -149,7 +149,6 @@ DEF(bswap32_i64, 1, 1, 1, 0)
 DEF(bswap64_i64, 1, 1, 1, 0)
 DEF(not_i64, 1, 1, 0, 0)
 DEF(neg_i64, 1, 1, 0, 0)
-DEF(andc_i64, 1, 2, 0, 0)
 DEF(orc_i64, 1, 2, 0, 0)
 DEF(eqv_i64, 1, 2, 0, 0)
 DEF(nand_i64, 1, 2, 0, 0)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 8bef391bb0..7587cad923 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8599,7 +8599,7 @@ static bool trans_CCMP(DisasContext *s, arg_CCMP *a)
     tcg_gen_subi_i32(tcg_t2, tcg_t0, 1);
 
     nzcv = a->nzcv;
-    has_andc = tcg_op_supported(INDEX_op_andc_i32, TCG_TYPE_I32, 0);
+    has_andc = tcg_op_supported(INDEX_op_andc, TCG_TYPE_I32, 0);
     if (nzcv & 8) { /* N */
         tcg_gen_or_i32(cpu_NF, cpu_NF, tcg_t1);
     } else {
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 6819b77668..1f8b3e6d91 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -3980,7 +3980,7 @@ static void decode_bit_andacc(DisasContext *ctx)
                     pos1, pos2, &tcg_gen_andc_tl, &tcg_gen_and_tl);
         break;
     case OPC2_32_BIT_AND_NOR_T:
-        if (tcg_op_supported(INDEX_op_andc_i32, TCG_TYPE_I32, 0)) {
+        if (tcg_op_supported(INDEX_op_andc, TCG_TYPE_I32, 0)) {
             gen_bit_2op(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2],
                         pos1, pos2, &tcg_gen_or_tl, &tcg_gen_andc_tl);
         } else {
diff --git a/tcg/optimize.c b/tcg/optimize.c
index f0aeb10d07..6dfc1da1b6 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -467,7 +467,8 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     CASE_OP_32_64(neg):
         return -x;
 
-    CASE_OP_32_64_VEC(andc):
+    case INDEX_op_andc:
+    case INDEX_op_andc_vec:
         return x & ~y;
 
     CASE_OP_32_64_VEC(orc):
@@ -2840,7 +2841,8 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_and_vec:
             done = fold_and(&ctx, op);
             break;
-        CASE_OP_32_64_VEC(andc):
+        case INDEX_op_andc:
+        case INDEX_op_andc_vec:
             done = fold_andc(&ctx, op);
             break;
         CASE_OP_32_64(brcond):
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 68818cbb0c..d87bd13375 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -668,8 +668,8 @@ void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (tcg_op_supported(INDEX_op_andc_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_andc_i32, ret, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_andc, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_andc, ret, arg1, arg2);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         tcg_gen_not_i32(t0, arg2);
@@ -2264,8 +2264,8 @@ void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_andc_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
         tcg_gen_andc_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
-    } else if (tcg_op_supported(INDEX_op_andc_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_andc_i64, ret, arg1, arg2);
+    } else if (tcg_op_supported(INDEX_op_andc, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_andc, ret, arg1, arg2);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         tcg_gen_not_i64(t0, arg2);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index fcea415550..7f164ca3e4 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1006,8 +1006,7 @@ QEMU_BUILD_BUG_ON((int)(offsetof(CPUNegativeOffsetState, tlb.f[0]) -
 static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_add, TCGOutOpBinary, outop_add),
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
-    OUTOP(INDEX_op_andc_i32, TCGOutOpBinary, outop_andc),
-    OUTOP(INDEX_op_andc_i64, TCGOutOpBinary, outop_andc),
+    OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
 };
 
 #undef OUTOP
@@ -5435,8 +5434,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
 
     case INDEX_op_add:
     case INDEX_op_and:
-    case INDEX_op_andc_i32:
-    case INDEX_op_andc_i64:
+    case INDEX_op_andc:
         {
             const TCGOutOpBinary *out =
                 container_of(all_outop[op->opc], TCGOutOpBinary, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index 95a61e9df1..e4a0408fec 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -547,7 +547,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] ^ regs[r2];
             break;
-        CASE_32_64(andc)
+        case INDEX_op_andc:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] & ~regs[r2];
             break;
@@ -1082,6 +1082,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
 
     case INDEX_op_add:
     case INDEX_op_and:
+    case INDEX_op_andc:
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
@@ -1090,8 +1091,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_or_i64:
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
-    case INDEX_op_andc_i32:
-    case INDEX_op_andc_i64:
     case INDEX_op_orc_i32:
     case INDEX_op_orc_i64:
     case INDEX_op_eqv_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 6a8025c0bf..116a0438b1 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -319,7 +319,7 @@ Logical
 
      - | *t0* = ~\ *t1*
 
-   * - andc_i32/i64 *t0*, *t1*, *t2*
+   * - andc *t0*, *t1*, *t2*
 
      - | *t0* = *t1* & ~\ *t2*
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index fb7c648b63..92c588305a 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -660,7 +660,7 @@ static const TCGOutOpBinary outop_and = {
 static void tgen_andc(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_op_rrr(s, glue(INDEX_op_andc_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+    tcg_out_op_rrr(s, INDEX_op_andc, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_andc = {
-- 
2.43.0


