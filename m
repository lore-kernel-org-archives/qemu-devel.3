Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A116FC369BD
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:52:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4lz8-0007fn-4y; Tue, 15 Apr 2025 15:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lyI-00051W-9s
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:29:26 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4ly7-0000rI-U5
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:29:21 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-301d6cbbd5bso6091741a91.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745352; x=1745350152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6JL+BS2jHjaoewia1H+UinEmgm4/YUzcTH7ueftxXNk=;
 b=DtoguH4bug70e2TxdYp3QydePeol4pbAKH61M3n5JhoN7d7Z+PC+ZDdrroyzxdCAvl
 CQStRDoB5g5yvIKlSV2OSjEe/y9UDyPjZTo7amWTMcyz0BoGPcqX4Bc1Wx6vws6eBe7J
 DGFoiUq4KjIDDiilUP0iYCj+8DmMCu1Ws356KZm5KLweE2l6UA1qZ6CV3HncWGYQVooL
 1cHUA4APH2I2Knwun66GQPdIxvtmulnwVNBqVM1BRllaViGGvHvXqLgqTfH0yJ0URRpC
 W3ui9POQlnkMP+OISn9PoMGNNoctR0hbvvpHxEsF4tWQyLsqc1U2B6dRMHQCN/fO7qCZ
 hSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745352; x=1745350152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6JL+BS2jHjaoewia1H+UinEmgm4/YUzcTH7ueftxXNk=;
 b=veCNUNAmfRQHOzs7/pq/kcq1mQmkt0gcV5KuBjvGD4OIhOOvp/v8xbs9k0G0nIrDlT
 /8Nu/0F/GV4dbDM2+UHtEF0VGnL4VcLQBo1NiYPgKiEShtOjhDutVSsedQe8oiakiAXi
 C9qsYQYTYvz5IlnQ2hfBcj/DRrFPGmA4Rys4tphmbzmueke2pWXjOpZ7KHm2gs4rEs6I
 j+VJNjOLJfRFNu+OeHX6IWTkG97PgWSQLEl4bYiCfH33AzdsJDVzvctcIZtmHdtIxi25
 9wSPAew6QEdHxQHypCpdrHLnSyoO246e3G2lL1ip9U2IREObYuvF7OxDlDfsm5wZNnlv
 ZhCA==
X-Gm-Message-State: AOJu0YwFQpLa9HzIIKhNUFWeQCwfi/aS48h4VzHz1WdCUiO8OVA3V1Wx
 e+SUOIEkWncwKep/ETxhIP2yBni+Abyu/2PTNn95rsq3pzDjLF8FnJ8W0J3DzXzLz0Y0i4qS42C
 b
X-Gm-Gg: ASbGnct7f3MAWUZL+3fN5L7K+LTaV+cmuHvMG5mCdS6RIU7AnTAyA5Jzl6r0KvSEsv/
 mBNBI6PHDcuRXyeW+KUnt1KqPMoeHLDUHBCXNl/jdAGDmG7B+qB0Cvy1H+GzJSnP7SofsSq+S7V
 Byxpy3xEZasOoKirwx3Za4WMn5ysDs6tLqP1ZMti7cZadhbVRHoi2UKQpDENoO+nUahydg7Nsim
 UCkrE7cX/RlP5gvYibXji4iP9uybLpJ4qyYuj73FOZs8g2QN2+Mhhw1OZUHOYKOCf53Fmm+pglr
 DSjzqnpM+TCei2BIsAaJvd1oePEl0TOKZSGBnTRjGLL/DxH8TS08zT4q8igAjgIuBCYh3VJ1axR
 agL1Lrx8e7w==
X-Google-Smtp-Source: AGHT+IEVW1xzjqjGqpgvc+4YSwJ/VgJa0Snr4g/38NqiM0K918kbtjtKrmNRJ6tnwWsA/EYyvUGX3g==
X-Received: by 2002:a17:90b:3d8e:b0:305:2d27:7ca7 with SMTP id
 98e67ed59e1d1-3085eee0400mr675908a91.16.1744745352353; 
 Tue, 15 Apr 2025 12:29:12 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df06a165sm13534812a91.4.2025.04.15.12.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:29:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 065/163] tcg: Merge INDEX_op_ctz_{i32,i64}
Date: Tue, 15 Apr 2025 12:23:36 -0700
Message-ID: <20250415192515.232910-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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
 tcg/tcg-op.c             | 16 ++++++++--------
 tcg/tcg.c                |  6 ++----
 tcg/tci.c                |  4 ++--
 docs/devel/tcg-ops.rst   |  2 +-
 tcg/tci/tcg-target.c.inc |  2 +-
 7 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index ad1d193ef4..4dfd8708a5 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -43,6 +43,7 @@ DEF(add, 1, 2, 0, TCG_OPF_INT)
 DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
 DEF(clz, 1, 2, 0, TCG_OPF_INT)
+DEF(ctz, 1, 2, 0, TCG_OPF_INT)
 DEF(divs, 1, 2, 0, TCG_OPF_INT)
 DEF(divs2, 2, 3, 0, TCG_OPF_INT)
 DEF(divu, 1, 2, 0, TCG_OPF_INT)
@@ -96,7 +97,6 @@ DEF(setcond2_i32, 1, 4, 1, 0)
 
 DEF(bswap16_i32, 1, 1, 1, 0)
 DEF(bswap32_i32, 1, 1, 1, 0)
-DEF(ctz_i32, 1, 2, 0, 0)
 DEF(ctpop_i32, 1, 1, 0, 0)
 
 DEF(setcond_i64, 1, 2, 1, 0)
@@ -130,7 +130,6 @@ DEF(brcond_i64, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(bswap16_i64, 1, 1, 1, 0)
 DEF(bswap32_i64, 1, 1, 1, 0)
 DEF(bswap64_i64, 1, 1, 1, 0)
-DEF(ctz_i64, 1, 2, 0, 0)
 DEF(ctpop_i64, 1, 1, 0, 0)
 
 DEF(add2_i64, 2, 4, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 8c7a2f8b30..2dbc0e45b4 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -497,10 +497,10 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
         }
         return x ? clz64(x) : y;
 
-    case INDEX_op_ctz_i32:
-        return (uint32_t)x ? ctz32(x) : y;
-
-    case INDEX_op_ctz_i64:
+    case INDEX_op_ctz:
+        if (type == TCG_TYPE_I32) {
+            return (uint32_t)x ? ctz32(x) : y;
+        }
         return x ? ctz64(x) : y;
 
     case INDEX_op_ctpop_i32:
@@ -2887,7 +2887,7 @@ void tcg_optimize(TCGContext *s)
             done = fold_bswap(&ctx, op);
             break;
         case INDEX_op_clz:
-        CASE_OP_32_64(ctz):
+        case INDEX_op_ctz:
             done = fold_count_zeros(&ctx, op);
             break;
         CASE_OP_32_64(ctpop):
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b117a59f05..7bf7de1213 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -750,11 +750,11 @@ void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     TCGv_i32 z, t;
 
-    if (tcg_op_supported(INDEX_op_ctz_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_ctz_i32, ret, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_ctz, ret, arg1, arg2);
         return;
     }
-    if (tcg_op_supported(INDEX_op_ctz_i64, TCG_TYPE_I64, 0)) {
+    if (tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I64, 0)) {
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
         TCGv_i64 t2 = tcg_temp_ebb_new_i64();
         tcg_gen_extu_i32_i64(t1, arg1);
@@ -788,7 +788,7 @@ void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
 {
-    if (!tcg_op_supported(INDEX_op_ctz_i32, TCG_TYPE_I32, 0)
+    if (!tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I32, 0)
         && TCG_TARGET_HAS_ctpop_i32 && arg2 == 32) {
         /* This equivalence has the advantage of not requiring a fixup.  */
         TCGv_i32 t = tcg_temp_ebb_new_i32();
@@ -2366,8 +2366,8 @@ void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     TCGv_i64 z, t;
 
-    if (tcg_op_supported(INDEX_op_ctz_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_ctz_i64, ret, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_ctz, ret, arg1, arg2);
         return;
     }
     if (TCG_TARGET_HAS_ctpop_i64) {
@@ -2395,7 +2395,7 @@ void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
 {
     if (TCG_TARGET_REG_BITS == 32
         && arg2 <= 0xffffffffu
-        && tcg_op_supported(INDEX_op_ctz_i32, TCG_TYPE_I32, 0)) {
+        && tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I32, 0)) {
         TCGv_i32 t32 = tcg_temp_ebb_new_i32();
         tcg_gen_ctzi_i32(t32, TCGV_HIGH(arg1), arg2 - 32);
         tcg_gen_addi_i32(t32, t32, 32);
@@ -2403,7 +2403,7 @@ void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
         tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
         tcg_temp_free_i32(t32);
     } else if (arg2 == 64
-               && !tcg_op_supported(INDEX_op_ctz_i64, TCG_TYPE_I64, 0)
+               && !tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I64, 0)
                && TCG_TARGET_HAS_ctpop_i64) {
         /* This equivalence has the advantage of not requiring a fixup.  */
         TCGv_i64 t = tcg_temp_ebb_new_i64();
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 5b939c6a33..4029b01bee 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1027,8 +1027,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_clz, TCGOutOpBinary, outop_clz),
-    OUTOP(INDEX_op_ctz_i32, TCGOutOpBinary, outop_ctz),
-    OUTOP(INDEX_op_ctz_i64, TCGOutOpBinary, outop_ctz),
+    OUTOP(INDEX_op_ctz, TCGOutOpBinary, outop_ctz),
     OUTOP(INDEX_op_divs, TCGOutOpBinary, outop_divs),
     OUTOP(INDEX_op_divu, TCGOutOpBinary, outop_divu),
     OUTOP(INDEX_op_divs2, TCGOutOpDivRem, outop_divs2),
@@ -5397,8 +5396,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_clz:
-    case INDEX_op_ctz_i32:
-    case INDEX_op_ctz_i64:
+    case INDEX_op_ctz:
     case INDEX_op_divs:
     case INDEX_op_divu:
     case INDEX_op_eqv:
diff --git a/tcg/tci.c b/tcg/tci.c
index b505944b10..550f2014a8 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -735,7 +735,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] ? clz64(regs[r1]) : regs[r2];
             break;
-        case INDEX_op_ctz_i64:
+        case INDEX_op_ctz:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] ? ctz64(regs[r1]) : regs[r2];
             break;
@@ -1049,6 +1049,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_clz:
+    case INDEX_op_ctz:
     case INDEX_op_divs:
     case INDEX_op_divu:
     case INDEX_op_eqv:
@@ -1066,7 +1067,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_shr:
     case INDEX_op_sub:
     case INDEX_op_xor:
-    case INDEX_op_ctz_i64:
     case INDEX_op_tci_ctz32:
     case INDEX_op_tci_clz32:
     case INDEX_op_tci_divs32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 22f0432988..92344b8786 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -362,7 +362,7 @@ Logical
 
      - | *t0* = *t1* ? clz(*t1*) : *t2*
 
-   * - ctz_i32/i64 *t0*, *t1*, *t2*
+   * - ctz *t0*, *t1*, *t2*
 
      - | *t0* = *t1* ? ctz(*t1*) : *t2*
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 47bdec5f44..d8d45e2c4b 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -645,7 +645,7 @@ static void tgen_ctz(TCGContext *s, TCGType type,
 {
     TCGOpcode opc = (type == TCG_TYPE_I32
                      ? INDEX_op_tci_ctz32
-                     : INDEX_op_ctz_i64);
+                     : INDEX_op_ctz);
     tcg_out_op_rrr(s, opc, a0, a1, a2);
 }
 
-- 
2.43.0


