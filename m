Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470C9E77194
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPfT-0003tg-MT; Thu, 02 Jan 2025 13:11:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeg-0007Qi-NC
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:47 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPee-0006Fu-4i
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:46 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2166651f752so183472955ad.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841443; x=1736446243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3iq3hkHQE2Qj65gvi8szbWs3hxviEW4opK6ggqKmyBc=;
 b=p51a05CM0m8B12Ee7RGsFeXEqo4C75elUuMIi+LJB+KZX8yZrp6ZiTUXY5cVY5GaKi
 VKsrJnVAPLUCfp6rdvtjkg3T9lG8eHylrD3SfHdHtOHpRCFqkqvuzk5kQR+WC9rbpSno
 8GcfWtjQG6p7sw/SsltkUT0dTFvIssBOnybtVxrBrMUxuXXAD/aRcG0E6jgs23fsrEqH
 WpGuPa7Z31hGCPP52dOtzEWdOE03hdnEfjoj/yeQgl8/3V3eYUjVHMiM6Pf8kE/LJ1RS
 OvSgvlHPGOE38tlYVC1LHkW6yT5YBp0JMiD3rsr2ksKkjzxUziLTQHfzNVsefNSmPtdP
 qcyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841443; x=1736446243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3iq3hkHQE2Qj65gvi8szbWs3hxviEW4opK6ggqKmyBc=;
 b=W5V4jni1cEx5+AX3j/uKpSpFQHlkjfsdD61q/IHayhILo76IfUsoidTsz1CslRe/0j
 ASs0QIjE6USDP+fAADyRStunjEjrzu4D2gFx5bP9UtPw+aOdQWqaW7q5d1SE9Q0yDri2
 Ccq7Q3qC06xa7GNo71NiUvxR/+RjK1/YNZLAhVGjlAdCVKVi/3KbKDiLlCFfsB1a+Fqu
 ZNgD3UfxoNCCvKPRlM54DFPktMNa0JeLjP157Qo15AhPpahMakjytZNz6v2/uyH+/vJ3
 QfBE/98xWYv3AtqBub+PEVCUzXhfAMNMIlDOAxX5zpj/HSeHuEJYYsyZg755vYXy5e53
 TWaA==
X-Gm-Message-State: AOJu0YwJIF7XblY7Uc5ps/qabtSe1Wnmrq4Lr/0FWqgF7s/MEfPt6k/c
 LdLPFCaqyVzo4ZLSl+zg+bzyeigkvNNYPD30i5o6YywIBVJp7qLLtQH/yIERyhcl548nwVKWDg+
 T
X-Gm-Gg: ASbGnctwqN2hXL8/p1JiWQkOFkdmKQdrFyd9qnjppr9kiwk/zWYZ6AsvskLdWEd9AJR
 KYUsTvGfbd6wWxrSI5pKAdI4bpFV4bvtSsg0XXfHaA2eaGoEvC/DoC18nrLBq94A2MGCjsoHeEO
 wN2kU8PZcSTLSEnjxzR4LV1+5JfyxjBRNChTW4pYLOD85ajIN62SnKUP3Sg7+JaY31I73Qwnubx
 ptHjuIFfGIKlT4RqnFnR3+5HWH6S+vwmW9JBJNBsFnSZzLYLWvBaZ8jC6ZsXA==
X-Google-Smtp-Source: AGHT+IGXsJ7L15xJeWyEpV7+N/+um3Nw6yXRf9aMz03ay7bDGLIUU57xUe5Q/Xh6vcldpW8Zc8a7sQ==
X-Received: by 2002:a05:6a20:db0a:b0:1e1:b153:4dc9 with SMTP id
 adf61e73a8af0-1e5e049f0a5mr71210985637.19.1735841442654; 
 Thu, 02 Jan 2025 10:10:42 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbaf1sm24620827b3a.112.2025.01.02.10.10.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:10:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 61/73] tcg: Merge INDEX_op_mov_{i32,i64}
Date: Thu,  2 Jan 2025 10:06:41 -0800
Message-ID: <20250102180654.1420056-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            |  4 ++--
 include/tcg/tcg.h                |  2 ++
 tcg/optimize.c                   |  7 +++----
 tcg/tcg-op.c                     |  4 ++--
 tcg/tcg.c                        | 32 ++++++++++++++++++--------------
 tcg/tci.c                        |  5 ++---
 tcg/aarch64/tcg-target.c.inc     |  3 +--
 tcg/arm/tcg-target.c.inc         |  2 +-
 tcg/i386/tcg-target.c.inc        |  3 +--
 tcg/loongarch64/tcg-target.c.inc |  3 +--
 tcg/mips/tcg-target.c.inc        |  3 +--
 tcg/ppc/tcg-target.c.inc         |  3 +--
 tcg/riscv/tcg-target.c.inc       |  3 +--
 tcg/s390x/tcg-target.c.inc       |  3 +--
 tcg/sparc64/tcg-target.c.inc     |  3 +--
 tcg/tci/tcg-target.c.inc         | 16 ++--------------
 16 files changed, 40 insertions(+), 56 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 561ddbc016..26b1144e4e 100644
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
@@ -92,7 +93,6 @@ DEF(clz_i32, 1, 2, 0, 0)
 DEF(ctz_i32, 1, 2, 0, 0)
 DEF(ctpop_i32, 1, 1, 0, 0)
 
-DEF(mov_i64, 1, 1, 0, TCG_OPF_NOT_PRESENT)
 DEF(setcond_i64, 1, 2, 1, 0)
 DEF(negsetcond_i64, 1, 2, 1, 0)
 DEF(movcond_i64, 1, 4, 1, 0)
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 90e5e4dfb8..62e57b0229 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -695,6 +695,8 @@ enum {
     /* Instruction has side effects: it cannot be removed if its outputs
        are not used, and might trigger exceptions.  */
     TCG_OPF_SIDE_EFFECTS = 0x08,
+    /* Instruction operands may be I32 or I64 */
+    TCG_OPF_INT          = 0x10,
     /* Instruction is optional and not implemented by the host, or insn
        is generic and should not be implemented by the host.  */
     TCG_OPF_NOT_PRESENT  = 0x20,
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 75c37d1148..3264cab75b 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -359,10 +359,8 @@ static bool tcg_opt_gen_mov(OptContext *ctx, TCGOp *op, TCGArg dst, TCGArg src)
 
     switch (op->type) {
     case TCG_TYPE_I32:
-        new_op = INDEX_op_mov_i32;
-        break;
     case TCG_TYPE_I64:
-        new_op = INDEX_op_mov_i64;
+        new_op = INDEX_op_mov;
         break;
     case TCG_TYPE_V64:
     case TCG_TYPE_V128:
@@ -2851,7 +2849,8 @@ void tcg_optimize(TCGContext *s)
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
index 92d8678211..113a7633db 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -345,7 +345,7 @@ void tcg_gen_discard_i32(TCGv_i32 arg)
 void tcg_gen_mov_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     if (ret != arg) {
-        tcg_gen_op2_i32(INDEX_op_mov_i32, ret, arg);
+        tcg_gen_op2_i32(INDEX_op_mov, ret, arg);
     }
 }
 
@@ -1409,7 +1409,7 @@ void tcg_gen_mov_i64(TCGv_i64 ret, TCGv_i64 arg)
         return;
     }
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op2_i64(INDEX_op_mov_i64, ret, arg);
+        tcg_gen_op2_i64(INDEX_op_mov, ret, arg);
     } else {
         TCGTemp *ts = tcgv_i64_temp(arg);
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 3d641d6d00..14e1045bef 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2185,7 +2185,9 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_qemu_st_a64_i128:
         return TCG_TARGET_HAS_qemu_ldst_i128;
 
-    case INDEX_op_mov_i32:
+    case INDEX_op_mov:
+        return has_type;
+
     case INDEX_op_setcond_i32:
     case INDEX_op_brcond_i32:
     case INDEX_op_movcond_i32:
@@ -2260,7 +2262,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_setcond2_i32:
         return TCG_TARGET_REG_BITS == 32;
 
-    case INDEX_op_mov_i64:
     case INDEX_op_setcond_i64:
     case INDEX_op_brcond_i64:
     case INDEX_op_movcond_i64:
@@ -2806,18 +2807,23 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
                 col += ne_fprintf(f, ",%s", t);
             }
         } else {
-            col += ne_fprintf(f, " %s ", def->name);
+            if (def->flags & TCG_OPF_INT) {
+                col += ne_fprintf(f, " %s_i%d ",
+                                  def->name,
+                                  8 * tcg_type_size(op->type));
+            } else if (def->flags & TCG_OPF_VECTOR) {
+                col += ne_fprintf(f, "%s v%d,e%d,",
+                                  def->name,
+                                  8 * tcg_type_size(op->type),
+                                  8 << TCGOP_VECE(op));
+            } else {
+                col += ne_fprintf(f, " %s ", def->name);
+            }
 
             nb_oargs = def->nb_oargs;
             nb_iargs = def->nb_iargs;
             nb_cargs = def->nb_cargs;
 
-            if (def->flags & TCG_OPF_VECTOR) {
-                col += ne_fprintf(f, "v%d,e%d,",
-                                  8 * tcg_type_size(op->type),
-                                  8 << TCGOP_VECE(op));
-            }
-
             k = 0;
             for (i = 0; i < nb_oargs; i++) {
                 const char *sep =  k ? "," : "";
@@ -4117,8 +4123,7 @@ liveness_pass_1(TCGContext *s)
 
             /* Incorporate constraints for this operand.  */
             switch (opc) {
-            case INDEX_op_mov_i32:
-            case INDEX_op_mov_i64:
+            case INDEX_op_mov:
                 /* Note that these are TCG_OPF_NOT_PRESENT and do not
                    have proper constraints.  That said, special case
                    moves to propagate preferences backward.  */
@@ -4278,7 +4283,7 @@ liveness_pass_2(TCGContext *s)
         }
 
         /* Outputs become available.  */
-        if (opc == INDEX_op_mov_i32 || opc == INDEX_op_mov_i64) {
+        if (opc == INDEX_op_mov) {
             arg_ts = arg_temp(op->args[0]);
             dir_ts = arg_ts->state_ptr;
             if (dir_ts) {
@@ -6397,8 +6402,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
         TCGOpcode opc = op->opc;
 
         switch (opc) {
-        case INDEX_op_mov_i32:
-        case INDEX_op_mov_i64:
+        case INDEX_op_mov:
         case INDEX_op_mov_vec:
             tcg_reg_alloc_mov(s, op);
             break;
diff --git a/tcg/tci.c b/tcg/tci.c
index d7fa1bac2a..23011a9dd5 100644
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
@@ -1059,8 +1059,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                            op_name, str_r(r0), str_r(r1), s2);
         break;
 
-    case INDEX_op_mov_i32:
-    case INDEX_op_mov_i64:
+    case INDEX_op_mov:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_bswap16_i32:
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 4fd42fc00e..79265d1c1c 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2512,8 +2512,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_mb(s, a0);
         break;
 
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
+    case INDEX_op_mov:      /* Always emitted via tcg_out_mov.  */
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 3098491f75..7d8d75465c 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2166,7 +2166,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_mb(s, args[0]);
         break;
 
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
+    case INDEX_op_mov:      /* Always emitted via tcg_out_mov.  */
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 3ca6bfda73..4a9ca6aafd 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3114,8 +3114,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_mb:
         tcg_out_mb(s, a0);
         break;
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
+    case INDEX_op_mov:      /* Always emitted via tcg_out_mov.  */
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index a8ffc479de..9d8bfdd8a1 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1709,8 +1709,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_ldst_i128(s, a0, a1, a2, a3, false);
         break;
 
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
+    case INDEX_op_mov:      /* Always emitted via tcg_out_mov.  */
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 52c71b0506..af8e485a73 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2163,8 +2163,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_mb:
         tcg_out_mb(s, a0);
         break;
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
+    case INDEX_op_mov:      /* Always emitted via tcg_out_mov.  */
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index e1e78b9c60..538ffe9763 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3553,8 +3553,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_mb(s, args[0]);
         break;
 
-    case INDEX_op_mov_i32:   /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
+    case INDEX_op_mov:       /* Always emitted via tcg_out_mov.  */
     case INDEX_op_call:      /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:   /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:   /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 067b4c1108..72b06866c6 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2390,8 +2390,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
+    case INDEX_op_mov:      /* Always emitted via tcg_out_mov.  */
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 8465111a20..f4a95b0c4f 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2782,8 +2782,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
+    case INDEX_op_mov:      /* Always emitted via tcg_out_mov.  */
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 430e07511c..51def25f43 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1534,8 +1534,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_arithc(s, a0, a1, 32, true, SHIFT_SRLX);
         break;
 
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
+    case INDEX_op_mov:      /* Always emitted via tcg_out_mov.  */
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index c541ee7dff..793b00cf8f 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -491,18 +491,7 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg val, TCGReg base,
 
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
 
@@ -853,8 +842,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_op_v(s, opc);
         break;
 
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
+    case INDEX_op_mov:      /* Always emitted via tcg_out_mov.  */
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-- 
2.43.0


