Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D95E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4bJ-0003BF-Lv; Tue, 07 Jan 2025 03:06:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4ab-0000Ym-OM
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:27 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aQ-0003Ns-Cz
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:24 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2f44353649aso18090677a91.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237109; x=1736841909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dthU2EiRanqjcb7Xj+PA6DO1bKQnFEDfipisBFRV2Lg=;
 b=Jzitb3KJJgxnU3jXzPSt0+jvlJEiHH8U3Uj7rqRVDV/7WuMxsEe15hy8hDm38Chp+L
 MvqQRUPp541Z9W+u3GOalNr4bFmv+B+KVQJaHhcIutza6INys2d6Pl8giWQmdim6TN6u
 pR1hL3eg8Vy9sJojs8LHgbUFFvanhaIqCmAGFpH9d0SQRYXJFNc+pCx+JzuHaK7goMCO
 O1oCGpStmnK5eObbVjREpgA9OU0V9hYrMxFKFKr6MkQiu+mykR0lHSrQE3nTanCgE7P8
 H6dAPbxZlSCroVTi0MayQaq8cNHBv6fTK01IuKj2VniKF/hIETEq9qKiS9qsCv/j/e4I
 8Wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237109; x=1736841909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dthU2EiRanqjcb7Xj+PA6DO1bKQnFEDfipisBFRV2Lg=;
 b=DUb4jNZ7aHUmQj+ZtOCx4zvXn4uTiYBuyhmL9cn+IXyot+m40UXoKqFDaB+93+pzkq
 MWXzLWwvkk6yVmGgk9wzBlSgfYaly88IYjJMs47Kw99TwWVKdcgZYF7776elNRcYJqtx
 KeXckKxaNsqVbv8IqMOFNTE0BEXvCcVZqke+t7Y3oMxlxpH50FRmqSrdUPHcj5jlqDy+
 wj3/tXl3kOeIfNzOqKT8K7tzus1fnzoZp4ggfsizU64IyZ6Hddyx1C2VA6czb6r8guwf
 SgQaJT+r3O3hwPN0R3nVtLtV16PqEQvuUnxuj6BSsszrAL3Ggr+VoT2RuJkHNUQQVzYs
 F0DQ==
X-Gm-Message-State: AOJu0YxCx5eDLjguaRI5FF6ppKS6JZ9rlkGB0G2gxBOMOePgxtLsQ/rW
 VJEdJBTT/cNQhTcYndkaI2qJl4rRp9WptB1AmL3c1Cv8Kv0jqIvA3GujPhyJLTd3y8YSlmoRERK
 D
X-Gm-Gg: ASbGncsnFi9fXZDwuvQmSQAb/u+PTjwNrxRYLQPZ2G6v4a8RkW8fD8vH3zxZewUZ2Sp
 MNu8ip0OBWRvhmJX5wkBhH30tnvz5ez4Zohq1KyhPkUaM27Vvwg7MkRqXjIF3Wkn/M9SS5uGgk+
 Qdz8B7+Cxv22T3Gf7uM+cCdFLaUgN+Ib/NK84FTf9uaLNzkG2SdX8EDO4MbeYUrp3nZC0h/wWVF
 kr/i0cD1n1CWxlyaLShglf4zqp4a6I5SPnP9dtD4Spy6kJ9Qa7qRRqe1R+BoQijlBUTy2SOsf0F
 LUsWwzpO30kihinSHg==
X-Google-Smtp-Source: AGHT+IF+fXgUwCLqI/3oRwz4MRRYtfimlJxpwXd0dDZPC0MLa2Q33y67yNYpguNw3sjY5hIvTqG+zw==
X-Received: by 2002:a05:6a00:2906:b0:725:b702:af with SMTP id
 d2e1a72fcca58-72abdefda9emr86794892b3a.25.1736237109433; 
 Tue, 07 Jan 2025 00:05:09 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 51/81] tcg: Merge INDEX_op_mov_{i32,i64}
Date: Tue,  7 Jan 2025 00:00:42 -0800
Message-ID: <20250107080112.1175095-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

Begin to rely on TCGOp.type to discriminate operations,
rather than two different opcodes.  Convert mov first.
Introduce TCG_OPF_INT in order to keep opcode dumps the same.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            |  4 ++--
 include/tcg/tcg.h                |  2 ++
 tcg/optimize.c                   |  7 +++----
 tcg/tcg-op.c                     |  4 ++--
 tcg/tcg.c                        | 32 ++++++++++++++++++--------------
 tcg/tci.c                        |  5 ++---
 tcg/aarch64/tcg-target.c.inc     |  2 --
 tcg/arm/tcg-target.c.inc         |  1 -
 tcg/i386/tcg-target.c.inc        |  2 --
 tcg/loongarch64/tcg-target.c.inc |  2 --
 tcg/mips/tcg-target.c.inc        |  2 --
 tcg/ppc/tcg-target.c.inc         |  2 --
 tcg/riscv/tcg-target.c.inc       |  2 --
 tcg/s390x/tcg-target.c.inc       |  2 --
 tcg/sparc64/tcg-target.c.inc     |  2 --
 tcg/tci/tcg-target.c.inc         | 15 +--------------
 16 files changed, 30 insertions(+), 56 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 42d580ccdd..6b764a4a14 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -37,7 +37,8 @@ DEF(br, 0, 0, 1, TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
 
 DEF(mb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
 
-DEF(mov_i32, 1, 1, 0, TCG_OPF_NOT_PRESENT)
+DEF(mov, 1, 1, 0, TCG_OPF_INT | TCG_OPF_NOT_PRESENT)
+
 DEF(setcond_i32, 1, 2, 1, 0)
 DEF(negsetcond_i32, 1, 2, 1, 0)
 DEF(movcond_i32, 1, 4, 1, 0)
@@ -98,7 +99,6 @@ DEF(clz_i32, 1, 2, 0, 0)
 DEF(ctz_i32, 1, 2, 0, 0)
 DEF(ctpop_i32, 1, 1, 0, 0)
 
-DEF(mov_i64, 1, 1, 0, TCG_OPF_NOT_PRESENT)
 DEF(setcond_i64, 1, 2, 1, 0)
 DEF(negsetcond_i64, 1, 2, 1, 0)
 DEF(movcond_i64, 1, 4, 1, 0)
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index d57cd8a810..332e8622dd 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -699,6 +699,8 @@ enum {
     /* Instruction has side effects: it cannot be removed if its outputs
        are not used, and might trigger exceptions.  */
     TCG_OPF_SIDE_EFFECTS = 0x08,
+    /* Instruction operands may be I32 or I64 */
+    TCG_OPF_INT          = 0x10,
     /* Instruction is optional and not implemented by the host, or insn
        is generic and should not be implemented by the host.  */
     TCG_OPF_NOT_PRESENT  = 0x20,
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 1dbc187069..4acf89d915 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -363,10 +363,8 @@ static bool tcg_opt_gen_mov(OptContext *ctx, TCGOp *op, TCGArg dst, TCGArg src)
 
     switch (ctx->type) {
     case TCG_TYPE_I32:
-        new_op = INDEX_op_mov_i32;
-        break;
     case TCG_TYPE_I64:
-        new_op = INDEX_op_mov_i64;
+        new_op = INDEX_op_mov;
         break;
     case TCG_TYPE_V64:
     case TCG_TYPE_V128:
@@ -2918,7 +2916,8 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_mb:
             done = fold_mb(&ctx, op);
             break;
-        CASE_OP_32_64_VEC(mov):
+        case INDEX_op_mov:
+        case INDEX_op_mov_vec:
             done = fold_mov(&ctx, op);
             break;
         CASE_OP_32_64(movcond):
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 48793ed439..108dc61e9a 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -351,7 +351,7 @@ void tcg_gen_discard_i32(TCGv_i32 arg)
 void tcg_gen_mov_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     if (ret != arg) {
-        tcg_gen_op2_i32(INDEX_op_mov_i32, ret, arg);
+        tcg_gen_op2_i32(INDEX_op_mov, ret, arg);
     }
 }
 
@@ -1411,7 +1411,7 @@ void tcg_gen_mov_i64(TCGv_i64 ret, TCGv_i64 arg)
         return;
     }
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op2_i64(INDEX_op_mov_i64, ret, arg);
+        tcg_gen_op2_i64(INDEX_op_mov, ret, arg);
     } else {
         TCGTemp *ts = tcgv_i64_temp(arg);
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 7effb17b32..f3c8a407d2 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2188,7 +2188,9 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_st_a64_i128:
         return TCG_TARGET_HAS_qemu_ldst_i128;
 
-    case INDEX_op_mov_i32:
+    case INDEX_op_mov:
+        return has_type;
+
     case INDEX_op_setcond_i32:
     case INDEX_op_brcond_i32:
     case INDEX_op_movcond_i32:
@@ -2270,7 +2272,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_setcond2_i32:
         return TCG_TARGET_REG_BITS == 32;
 
-    case INDEX_op_mov_i64:
     case INDEX_op_setcond_i64:
     case INDEX_op_brcond_i64:
     case INDEX_op_movcond_i64:
@@ -2841,18 +2842,23 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
                 col += ne_fprintf(f, ",%s", t);
             }
         } else {
-            col += ne_fprintf(f, " %s ", def->name);
+            if (def->flags & TCG_OPF_INT) {
+                col += ne_fprintf(f, " %s_i%d ",
+                                  def->name,
+                                  8 * tcg_type_size(TCGOP_TYPE(op)));
+            } else if (def->flags & TCG_OPF_VECTOR) {
+                col += ne_fprintf(f, "%s v%d,e%d,",
+                                  def->name,
+                                  8 * tcg_type_size(TCGOP_TYPE(op)),
+                                  8 << TCGOP_VECE(op));
+            } else {
+                col += ne_fprintf(f, " %s ", def->name);
+            }
 
             nb_oargs = def->nb_oargs;
             nb_iargs = def->nb_iargs;
             nb_cargs = def->nb_cargs;
 
-            if (def->flags & TCG_OPF_VECTOR) {
-                col += ne_fprintf(f, "v%d,e%d,",
-                                  8 * tcg_type_size(TCGOP_TYPE(op)),
-                                  8 << TCGOP_VECE(op));
-            }
-
             k = 0;
             for (i = 0; i < nb_oargs; i++) {
                 const char *sep =  k ? "," : "";
@@ -4146,8 +4152,7 @@ liveness_pass_1(TCGContext *s)
 
             /* Incorporate constraints for this operand.  */
             switch (opc) {
-            case INDEX_op_mov_i32:
-            case INDEX_op_mov_i64:
+            case INDEX_op_mov:
                 /* Note that these are TCG_OPF_NOT_PRESENT and do not
                    have proper constraints.  That said, special case
                    moves to propagate preferences backward.  */
@@ -4305,7 +4310,7 @@ liveness_pass_2(TCGContext *s)
         }
 
         /* Outputs become available.  */
-        if (opc == INDEX_op_mov_i32 || opc == INDEX_op_mov_i64) {
+        if (opc == INDEX_op_mov) {
             arg_ts = arg_temp(op->args[0]);
             dir_ts = arg_ts->state_ptr;
             if (dir_ts) {
@@ -6420,8 +6425,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
         TCGOpcode opc = op->opc;
 
         switch (opc) {
-        case INDEX_op_mov_i32:
-        case INDEX_op_mov_i64:
+        case INDEX_op_mov:
         case INDEX_op_mov_vec:
             tcg_reg_alloc_mov(s, op);
             break;
diff --git a/tcg/tci.c b/tcg/tci.c
index 66efe78b9d..d016dc7dc0 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -473,7 +473,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             regs[r0] = regs[tmp32 ? r3 : r4];
             break;
 #endif
-        CASE_32_64(mov)
+        case INDEX_op_mov:
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = regs[r1];
             break;
@@ -1119,8 +1119,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                            op_name, str_r(r0), str_r(r1), s2);
         break;
 
-    case INDEX_op_mov_i32:
-    case INDEX_op_mov_i64:
+    case INDEX_op_mov:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_bswap16_i32:
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index cddb44e193..13b6e2afb7 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2498,8 +2498,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_mb(s, a0);
         break;
 
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 826e3aaed3..241f27e7e1 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2153,7 +2153,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_mb(s, args[0]);
         break;
 
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index d03da4d83f..d9fa588c68 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3106,8 +3106,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_mb:
         tcg_out_mb(s, a0);
         break;
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 5d4b8c9e55..7d0ccf90ec 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1700,8 +1700,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_ldst_i128(s, a0, a1, a2, a3, false);
         break;
 
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 9660aabe2d..27069f1477 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2155,8 +2155,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_mb:
         tcg_out_mb(s, a0);
         break;
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index e63792de16..c0a2737a87 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3542,8 +3542,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_mb(s, args[0]);
         break;
 
-    case INDEX_op_mov_i32:   /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
     case INDEX_op_call:      /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:   /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:   /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 2ba9c33a31..2d8b664dd7 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2381,8 +2381,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index d8e08ae52f..2dad61a971 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2782,8 +2782,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index d063603f9f..eb5c839933 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1519,8 +1519,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_arithi(s, a0, a1, a2, SHIFT_SRA);
         break;
 
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 42b736641e..3a5beded2f 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -505,18 +505,7 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg val, TCGReg base,
 
 static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
 {
-    switch (type) {
-    case TCG_TYPE_I32:
-        tcg_out_op_rr(s, INDEX_op_mov_i32, ret, arg);
-        break;
-#if TCG_TARGET_REG_BITS == 64
-    case TCG_TYPE_I64:
-        tcg_out_op_rr(s, INDEX_op_mov_i64, ret, arg);
-        break;
-#endif
-    default:
-        g_assert_not_reached();
-    }
+    tcg_out_op_rr(s, INDEX_op_mov, ret, arg);
     return true;
 }
 
@@ -829,8 +818,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_op_v(s, opc);
         break;
 
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-- 
2.43.0


