Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906F7C369BA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4luT-0008Qw-Ue; Tue, 15 Apr 2025 15:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4luP-0008Nk-5S
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:25 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4luL-0007vH-Cm
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:24 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-736b98acaadso5481870b3a.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745120; x=1745349920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wRlAw+0H/Z2Dchk0nljDLE8TGRwzY/TFWWOS3hJHhOs=;
 b=db6rMPWAaezeaTJMKGgTvVLLLhbGMw848ht1BI9lI+5BJDJ3Y87cqoxEWWf2t/6enP
 GGJQqbxKZ1Z+bub0NHOWc1E3P/G8qLGbrYePMP6geFGKo5JFMtdIcCFvt7rrLYJBpA7b
 L6qJ2i7QhWrC2S6hPPKscHHPvmgYodjNWehzdx8hlwvIITF7c5sG6SyZ4MAcA2szfWuB
 YXmzNqaMpTYDddruglVvVDosp6Y1cZ0lUmyl1a93+n8Qt5XA95otYjT2ZNnZh8qwmbas
 NMiYHUhptSeDVPFq5YntV/CqZZs1+4eF0sXXqCSj53MeuQY96n3l46KH6jkIIzXlZTaW
 ndAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745120; x=1745349920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wRlAw+0H/Z2Dchk0nljDLE8TGRwzY/TFWWOS3hJHhOs=;
 b=qP/zNYNSVJ/N7DzKiX0+4k81N/Pk5XUM1RZOl5MtcU8BQCfkRv9Bt3tZt+TYgn/2+A
 zfgfoMdH0CNdfKdeKQJq5gg5MqA0FIO6o2g/0kuzrLNGYMTgB82U24tTNuCXa2FXI8ds
 r2nSUvt0/zNMxWle0VgU6cnUklaTO18P5r8l4quogLnEJQgrvWtpAMN6WtwNDG4PGoJG
 RMWoNvNXua0ojOjXkIoawzgzyYUOuCNaVoo2xVk0FViWHV+JdRLflbx8GOZ5vTVWU7HH
 tyrAlXQ0+cTSe5prSxlTZwu/SqNFZeVXnlX/LE8/ZjvYC9T7h270Bpyy1dg1++5MXdyn
 3fQg==
X-Gm-Message-State: AOJu0YyyPDkGi7M1spitqrcF1hZgnpiakuj5Xi3Z9T+U3/OjPw+Kl1BF
 adlALvWno4LMIwBYdND3+PkzLC2K5bcXiDV18tgsrR7yW8ZUJXRhklqdKjwU7SSmehAzHXV8++D
 P
X-Gm-Gg: ASbGncvBdNW26N2CaiOKJjuAY3oa12VMWZw77StL7iMfneGsEd4Z2oUYepstCF0fbIZ
 ekuY7Bx6lCRuFDgky12a9rNrNrojPxDwyiaw8IHlsS8K06chEX6eyrWQUrkSgS6fTu+PZk2CEqk
 t/47VgnkKvzS4/KJFDFtPiRcaOrumruXyF1oIGDr1TJ6Nmd30kvqS4bnic6PpxdE2AVJu+wID0Q
 Xowh3Xjk4Irl48DT9SNtx5DiZKiezHMFLSyI9vzEh1EErTY2D51pNLwvAp7eVagg+MwQnBG4JBU
 d8lSwL1Algan1CiUbpMNT1XMHEowsGWJEMP8YI81s3XFyespS/Oa7l6tuY6iycFCpTProsun8rU
 =
X-Google-Smtp-Source: AGHT+IFkxj4KJtkuHoFOFQS8ehZAWXyX8ESY4KXpExZXASQoZ0uUZxaSovplOx8UbNja+vgVbrw6+w==
X-Received: by 2002:aa7:9308:0:b0:736:ab48:5b0 with SMTP id
 d2e1a72fcca58-73c1f8c3c9cmr953325b3a.2.1744745119677; 
 Tue, 15 Apr 2025 12:25:19 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f82ebsm9225124b3a.92.2025.04.15.12.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:25:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 004/163] tcg: Merge INDEX_op_mov_{i32,i64}
Date: Tue, 15 Apr 2025 12:22:35 -0700
Message-ID: <20250415192515.232910-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
 docs/devel/tcg-ops.rst           |  4 ++--
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
 17 files changed, 32 insertions(+), 58 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index c26cffaa3f..766fd00d99 100644
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
index 84d99508b6..c6b50b5226 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -741,6 +741,8 @@ enum {
     /* Instruction has side effects: it cannot be removed if its outputs
        are not used, and might trigger exceptions.  */
     TCG_OPF_SIDE_EFFECTS = 0x08,
+    /* Instruction operands may be I32 or I64 */
+    TCG_OPF_INT          = 0x10,
     /* Instruction is optional and not implemented by the host, or insn
        is generic and should not be implemented by the host.  */
     TCG_OPF_NOT_PRESENT  = 0x20,
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 250bc7de2b..a36283cd35 100644
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
@@ -2921,7 +2919,8 @@ void tcg_optimize(TCGContext *s)
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
index b2441da3ab..9d502d1c03 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2187,7 +2187,9 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_st_i128:
         return TCG_TARGET_HAS_qemu_ldst_i128;
 
-    case INDEX_op_mov_i32:
+    case INDEX_op_mov:
+        return has_type;
+
     case INDEX_op_setcond_i32:
     case INDEX_op_brcond_i32:
     case INDEX_op_movcond_i32:
@@ -2269,7 +2271,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_setcond2_i32:
         return TCG_TARGET_REG_BITS == 32;
 
-    case INDEX_op_mov_i64:
     case INDEX_op_setcond_i64:
     case INDEX_op_brcond_i64:
     case INDEX_op_movcond_i64:
@@ -2840,18 +2841,23 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
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
@@ -4144,8 +4150,7 @@ liveness_pass_1(TCGContext *s)
 
             /* Incorporate constraints for this operand.  */
             switch (opc) {
-            case INDEX_op_mov_i32:
-            case INDEX_op_mov_i64:
+            case INDEX_op_mov:
                 /* Note that these are TCG_OPF_NOT_PRESENT and do not
                    have proper constraints.  That said, special case
                    moves to propagate preferences backward.  */
@@ -4303,7 +4308,7 @@ liveness_pass_2(TCGContext *s)
         }
 
         /* Outputs become available.  */
-        if (opc == INDEX_op_mov_i32 || opc == INDEX_op_mov_i64) {
+        if (opc == INDEX_op_mov) {
             arg_ts = arg_temp(op->args[0]);
             dir_ts = arg_ts->state_ptr;
             if (dir_ts) {
@@ -6432,8 +6437,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
         TCGOpcode opc = op->opc;
 
         switch (opc) {
-        case INDEX_op_mov_i32:
-        case INDEX_op_mov_i64:
+        case INDEX_op_mov:
         case INDEX_op_mov_vec:
             tcg_reg_alloc_mov(s, op);
             break;
diff --git a/tcg/tci.c b/tcg/tci.c
index 531cd83aae..78183ea47d 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -463,7 +463,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             regs[r0] = regs[tmp32 ? r3 : r4];
             break;
 #endif
-        CASE_32_64(mov)
+        case INDEX_op_mov:
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = regs[r1];
             break;
@@ -1063,8 +1063,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                            op_name, str_r(r0), str_r(r1), s2);
         break;
 
-    case INDEX_op_mov_i32:
-    case INDEX_op_mov_i64:
+    case INDEX_op_mov:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_bswap16_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 3db7b81637..e6ccc78fa1 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -391,10 +391,10 @@ Misc
 
 .. list-table::
 
-   * - mov_i32/i64 *t0*, *t1*
+   * - mov *t0*, *t1*
 
      - | *t0* = *t1*
-       | Move *t1* to *t0* (both operands must have the same type).
+       | Move *t1* to *t0*.
 
    * - bswap16_i32/i64 *t0*, *t1*, *flags*
 
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index b8b26c1c93..466042a577 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2488,8 +2488,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_mb(s, a0);
         break;
 
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 0e48f790f9..0fafe97230 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2109,7 +2109,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_mb(s, args[0]);
         break;
 
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 02024018cb..75c8665d74 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3011,8 +3011,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_mb:
         tcg_out_mb(s, a0);
         break;
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index c15314e1c8..a0f050ff9c 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1690,8 +1690,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_ldst_i128(s, a0, a1, a2, a3, false);
         break;
 
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index f77159bdc7..4d52e0bde0 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2101,8 +2101,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_mb:
         tcg_out_mb(s, a0);
         break;
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index e10c1c5162..11dcfe66f3 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3468,8 +3468,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_mb(s, args[0]);
         break;
 
-    case INDEX_op_mov_i32:   /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
     case INDEX_op_call:      /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:   /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:   /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index d525df4e1d..6f9d87df48 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2380,8 +2380,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 8421320928..30fa26e884 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2776,8 +2776,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 787e0d896c..cb5e8d554d 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1512,8 +1512,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_arithi(s, a0, a1, a2, SHIFT_SRA);
         break;
 
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 6f8f1dd8ae..9a5d3c2875 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -483,18 +483,7 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg val, TCGReg base,
 
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
 
@@ -799,8 +788,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_op_v(s, opc);
         break;
 
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-- 
2.43.0


