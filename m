Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120F7C369BD
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4m0b-0001ob-3V; Tue, 15 Apr 2025 15:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lyH-00051E-Vd
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:29:26 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4ly5-0000pz-As
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:29:18 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2ff85fec403so6613129a91.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745351; x=1745350151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kBCMACfgOuq9l++FYVexmYq+zfjZgP2+R+eQAgS1sCI=;
 b=c0NgIsIwE9DQKpLF1v1VkAlBjpo7go4/c5qSrV/h75hm97AezYqkPLz5U/KZhkU14g
 lMcamAvnK9ixsCTMSJsOFM/KtOwVKrRYZ6czH5uT9ZtT/Z+sUgEwWg/NssiNbi1m1i7a
 gFyxI93/7u6JxAjsig3fK4Pf+nmmpzdGk2RtVcsuPFTOh3V9pq0jVclNDajogaXLWV6B
 aIov0UXFSVTMvlI3xkkKp5r65figHzMJ/M2usj+v24lTPx/Vi+s47oUM1OTobTdOSElh
 43YLQ1DBgtx64wnaJks4CSo3yXswtdhPzwGHPtySdoxAi1Jv6DwDvhohsLFx7d/KeLgs
 LPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745351; x=1745350151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kBCMACfgOuq9l++FYVexmYq+zfjZgP2+R+eQAgS1sCI=;
 b=jsSA9JF7dUYWfSTEvPshRsbi/9rjPfKbg2TKUpki8PQVMGxs3+dmU8gP/UVzAjy6EE
 MSJeyvOE75+IH0v2pT7QxJWyQ3H0rYP1PkeZlMgGd8+UPhXcAs+uF4Ypae0H2v1njA1M
 Gwd/w0OW2t2MLsxTvwmrdsIPsJXAg0IwClOjVPKslrXU0rxlBFPl9n6kDOGbHbP6fDF4
 yHiWi5ORrPqCunqVtw4GVO27o9XFRhC7bCaZAyqPLEqTjtfGJQiaee6j5LTfmXqkWv30
 Zl9olADTMuAN0eE86bXwp/cAH67l+TAdWDzDHs7vHXwY67jdg93A2enwyvp6Uwdnrs7P
 bXbg==
X-Gm-Message-State: AOJu0YzSQmLw002AcIqJT80a83B100f/4FCb9TGk7FM79kyn7uEAzEAb
 GaErd215AhK/ekBeNA7A8SBQz8pLaqhSjyAs1+/j99VX/guza4uyLxDCJphsEOQpUWLjb2TodAj
 l
X-Gm-Gg: ASbGncu15jyPrqxC6sx4WdVoV9QQlHGjhWMP/QV6VrA49k+Q1k82WVklV0I9DUoESEe
 HDmeTkkmh3M1MNuLLmnUUvkPwoeQ0v21J+UeuMoWpYJmSSCp4EqHP0Ygd41DVzNXSDUu3sig00h
 mrV6Otwwcb24Yn/qtxiniQAkSMSqMhCQxZdbEwl3HCYFYLXew1r0C+Iy5OH1Ak3yH0bRusBPG0z
 pjPxTXnBOTtkDXoEninYk1S0bRGJDXVMyjEdzqIf25FaYIcVeH9PzE/dLvUfRMdGbu2G1duP7WU
 dKItArcWQWpjL+cLAGSvep5mPV+8dNHd/nDmlbGI843m0u+6ocNG4UmagoH9YN626Eqo8Vu9v2U
 =
X-Google-Smtp-Source: AGHT+IEH05tiButqfdDxPbFBTulz4q9iuEfuPeUTW1z9XNklvou6LyPdnibOkQzBfBhDHbvEnOwQYw==
X-Received: by 2002:a17:90b:2f04:b0:2f9:d0cd:3403 with SMTP id
 98e67ed59e1d1-3085dfeaa93mr990025a91.16.1744745350998; 
 Tue, 15 Apr 2025 12:29:10 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df06a165sm13534812a91.4.2025.04.15.12.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:29:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 063/163] tcg: Merge INDEX_op_clz_{i32,i64}
Date: Tue, 15 Apr 2025 12:23:34 -0700
Message-ID: <20250415192515.232910-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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
 include/tcg/tcg-opc.h    |  3 +--
 tcg/optimize.c           | 10 +++++-----
 tcg/tcg-op.c             | 22 ++++++++++------------
 tcg/tcg.c                |  6 ++----
 tcg/tci.c                |  4 ++--
 docs/devel/tcg-ops.rst   |  2 +-
 tcg/tci/tcg-target.c.inc |  2 +-
 7 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 25fd93eb28..ad1d193ef4 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -42,6 +42,7 @@ DEF(mov, 1, 1, 0, TCG_OPF_INT | TCG_OPF_NOT_PRESENT)
 DEF(add, 1, 2, 0, TCG_OPF_INT)
 DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
+DEF(clz, 1, 2, 0, TCG_OPF_INT)
 DEF(divs, 1, 2, 0, TCG_OPF_INT)
 DEF(divs2, 2, 3, 0, TCG_OPF_INT)
 DEF(divu, 1, 2, 0, TCG_OPF_INT)
@@ -95,7 +96,6 @@ DEF(setcond2_i32, 1, 4, 1, 0)
 
 DEF(bswap16_i32, 1, 1, 1, 0)
 DEF(bswap32_i32, 1, 1, 1, 0)
-DEF(clz_i32, 1, 2, 0, 0)
 DEF(ctz_i32, 1, 2, 0, 0)
 DEF(ctpop_i32, 1, 1, 0, 0)
 
@@ -130,7 +130,6 @@ DEF(brcond_i64, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(bswap16_i64, 1, 1, 1, 0)
 DEF(bswap32_i64, 1, 1, 1, 0)
 DEF(bswap64_i64, 1, 1, 1, 0)
-DEF(clz_i64, 1, 2, 0, 0)
 DEF(ctz_i64, 1, 2, 0, 0)
 DEF(ctpop_i64, 1, 1, 0, 0)
 
diff --git a/tcg/optimize.c b/tcg/optimize.c
index d0a1834536..8c7a2f8b30 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -491,10 +491,10 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
     case INDEX_op_nor_vec:
         return ~(x | y);
 
-    case INDEX_op_clz_i32:
-        return (uint32_t)x ? clz32(x) : y;
-
-    case INDEX_op_clz_i64:
+    case INDEX_op_clz:
+        if (type == TCG_TYPE_I32) {
+            return (uint32_t)x ? clz32(x) : y;
+        }
         return x ? clz64(x) : y;
 
     case INDEX_op_ctz_i32:
@@ -2886,7 +2886,7 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_bswap64_i64:
             done = fold_bswap(&ctx, op);
             break;
-        CASE_OP_32_64(clz):
+        case INDEX_op_clz:
         CASE_OP_32_64(ctz):
             done = fold_count_zeros(&ctx, op);
             break;
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index e1e57ff3f8..76e9efc655 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -723,9 +723,9 @@ void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (tcg_op_supported(INDEX_op_clz_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_clz_i32, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_clz_i64, TCG_TYPE_I64, 0)) {
+    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_clz, ret, arg1, arg2);
+    } else if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
         TCGv_i64 t2 = tcg_temp_ebb_new_i64();
         tcg_gen_extu_i32_i64(t1, arg1);
@@ -770,8 +770,7 @@ void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_subi_i32(t, arg1, 1);
         tcg_gen_andc_i32(t, t, arg1);
         tcg_gen_ctpop_i32(t, t);
-    } else if (tcg_op_supported(INDEX_op_clz_i32, TCG_TYPE_I32, 0) ||
-               tcg_op_supported(INDEX_op_clz_i64, TCG_TYPE_I64, 0)) {
+    } else if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_REG, 0)) {
         t = tcg_temp_ebb_new_i32();
         tcg_gen_neg_i32(t, arg1);
         tcg_gen_and_i32(t, t, arg1);
@@ -803,8 +802,7 @@ void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
 
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
-    if (tcg_op_supported(INDEX_op_clz_i32, TCG_TYPE_I32, 0) ||
-        tcg_op_supported(INDEX_op_clz_i64, TCG_TYPE_I64, 0)) {
+    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_REG, 0)) {
         TCGv_i32 t = tcg_temp_ebb_new_i32();
         tcg_gen_sari_i32(t, arg, 31);
         tcg_gen_xor_i32(t, t, arg);
@@ -2340,8 +2338,8 @@ void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 
 void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (tcg_op_supported(INDEX_op_clz_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_clz_i64, ret, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_clz, ret, arg1, arg2);
     } else {
         gen_helper_clz_i64(ret, arg1, arg2);
     }
@@ -2351,7 +2349,7 @@ void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
 {
     if (TCG_TARGET_REG_BITS == 32
         && arg2 <= 0xffffffffu
-        && tcg_op_supported(INDEX_op_clz_i32, TCG_TYPE_I32, 0)) {
+        && tcg_op_supported(INDEX_op_clz, TCG_TYPE_I32, 0)) {
         TCGv_i32 t = tcg_temp_ebb_new_i32();
         tcg_gen_clzi_i32(t, TCGV_LOW(arg1), arg2 - 32);
         tcg_gen_addi_i32(t, t, 32);
@@ -2376,7 +2374,7 @@ void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_subi_i64(t, arg1, 1);
         tcg_gen_andc_i64(t, t, arg1);
         tcg_gen_ctpop_i64(t, t);
-    } else if (tcg_op_supported(INDEX_op_clz_i64, TCG_TYPE_I64, 0)) {
+    } else if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
         t = tcg_temp_ebb_new_i64();
         tcg_gen_neg_i64(t, arg1);
         tcg_gen_and_i64(t, t, arg1);
@@ -2419,7 +2417,7 @@ void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
 
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
-    if (tcg_op_supported(INDEX_op_clz_i64, TCG_TYPE_I64, 0)) {
+    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
         TCGv_i64 t = tcg_temp_ebb_new_i64();
         tcg_gen_sari_i64(t, arg, 63);
         tcg_gen_xor_i64(t, t, arg);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 99f2ea8775..97bdb6241a 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1026,8 +1026,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_add, TCGOutOpBinary, outop_add),
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
-    OUTOP(INDEX_op_clz_i32, TCGOutOpBinary, outop_clz),
-    OUTOP(INDEX_op_clz_i64, TCGOutOpBinary, outop_clz),
+    OUTOP(INDEX_op_clz, TCGOutOpBinary, outop_clz),
     OUTOP(INDEX_op_divs, TCGOutOpBinary, outop_divs),
     OUTOP(INDEX_op_divu, TCGOutOpBinary, outop_divu),
     OUTOP(INDEX_op_divs2, TCGOutOpDivRem, outop_divs2),
@@ -5399,8 +5398,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_add:
     case INDEX_op_and:
     case INDEX_op_andc:
-    case INDEX_op_clz_i32:
-    case INDEX_op_clz_i64:
+    case INDEX_op_clz:
     case INDEX_op_divs:
     case INDEX_op_divu:
     case INDEX_op_eqv:
diff --git a/tcg/tci.c b/tcg/tci.c
index 11b11ce642..7c2f2a524b 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -733,7 +733,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = (uint64_t)regs[r1] % (uint64_t)regs[r2];
             break;
-        case INDEX_op_clz_i64:
+        case INDEX_op_clz:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] ? clz64(regs[r1]) : regs[r2];
             break;
@@ -1052,6 +1052,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_add:
     case INDEX_op_and:
     case INDEX_op_andc:
+    case INDEX_op_clz:
     case INDEX_op_divs:
     case INDEX_op_divu:
     case INDEX_op_eqv:
@@ -1069,7 +1070,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_shr:
     case INDEX_op_sub:
     case INDEX_op_xor:
-    case INDEX_op_clz_i64:
     case INDEX_op_ctz_i32:
     case INDEX_op_ctz_i64:
     case INDEX_op_tci_clz32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index c3a6499d01..22f0432988 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -358,7 +358,7 @@ Logical
 
      - | *t0* = *t1* | ~\ *t2*
 
-   * - clz_i32/i64 *t0*, *t1*, *t2*
+   * - clz *t0*, *t1*, *t2*
 
      - | *t0* = *t1* ? clz(*t1*) : *t2*
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index ee7e6f15eb..0fd1f5510a 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -633,7 +633,7 @@ static void tgen_clz(TCGContext *s, TCGType type,
 {
     TCGOpcode opc = (type == TCG_TYPE_I32
                      ? INDEX_op_tci_clz32
-                     : INDEX_op_clz_i64);
+                     : INDEX_op_clz);
     tcg_out_op_rrr(s, opc, a0, a1, a2);
 }
 
-- 
2.43.0


