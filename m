Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DC3C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x78Uk-00048t-Do; Thu, 17 Sep 2026 05:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x78Ug-00046f-98
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:33:26 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x78Ud-00018n-GE
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:33:25 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-39b350c69b4so476131a91.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 02:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789637601; x=1790242401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HGQQ50JsOahOLBW9+5ijBQfjL0p9qJt2JNKmDhmxlVU=;
 b=JmtDSfo+v4NRgFWM9PMWk7DIzqqE7SBUxW5tD+BUZ8s4x3tUt6woZ/mQ6W7y3+0ijm
 JRA2ZPpoDqqtTxQrEDhr4Hqdd3PLpYOaHjXOgjBRo/Gz1oOwtinVPIjvQDsn0zx+QKnj
 HPimNnTn8gCHiIaIprEiBnDULxP4blVrySkMjSkl/c8JxtrpWyZ9wgbgT8+x8gW4Rjj3
 RKtr6+o73ELh6pgLQixSAoPD326BCRGgEbsSYqISqUd7u7E7hmM/5qOqZY0BswIvF68t
 yRFpODUdlD1QjQA2o1o6oWxzTwReM8XQHc/dMQJfa2rlE++JxbAymo2zItl8FYmTUBV4
 jXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789637601; x=1790242401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HGQQ50JsOahOLBW9+5ijBQfjL0p9qJt2JNKmDhmxlVU=;
 b=svnDSq+Wr3Nb5+9fH/om44OG3H1Wu5jBTLFCWD/f+HsCa0VPIu3BUNNA1G3984Hrgm
 OiZlfTd90mTgRUjIr9mOrm/xC5gY3g1ZBbzE6fivkKLXQvNLHtFiFQeBsRg9xULwfVPB
 Iv/36xiESNUjUDVHHWKsc31zzY2uwDIJNvQILTPRsBEeVjSMB4XE/bc7Phpfl/bJzB5j
 p9HqYnO3QDlIf3YbBZBW9XNSYNiQhUUM5PcQyhJue87xyIxZgGUI22pzpxPMO/2V8gc1
 FGDaVcH81levOSelU102N3/M8E1+/g+ZVKyXqjLIIyeGlsHiiRCLyf3nhNdt2QxpPzoG
 vHBA==
X-Gm-Message-State: AFuF++kOKHE+/UXnj20ACV6qlw6VJpDgnyfUv9mTVCyFrwk8SsfqbzvZ
 V3H/v1zvW8Be8Ra8CFBnMx+JTtXJrZW272hzPEBTKPVcgzcIb30E9b8m3CXfDOPqKBqpyyjSR1j
 1x/H7
X-Gm-Gg: AYBFou3PSrkF5mcnwnXq2loG53w5el+4ScycxL3UJ7tirbNOkwTKq6OJVpu7NvIYKMK
 +nTT3mo5NA38O/iOe4TvAbPu4GKsjAo/LxKb1TM2QtJFB/m5PBlJ7F8KMoOlLBQ9rh+wR+z4EqB
 ur/2vst7vz7KqmIGx5YDOrr8nHRXlwTDthi5i3GsCUVoVx/FCisaic8WaOe5jWJ7+LHmU3DDZdK
 kARj5ba6EBOXNAkTYRiHFYfvsq2+YXwfQvXO6ss/5gRZwSXfOONJu69lv9nYjmoNXzOmmITlcak
 E1jd5dNyKMJi71lbNrSXOySWQPUSCUfGwaQJhWx4ZckGI/zsy4LAeZ+7WtHtYsZGWn/wqN5Y2U+
 3yjP3jYZTq178nbIA7uwcA3l6G0aqjJ2hctdSYjhFB3lSwNdemj7L05GhQnj3USBWjuJIptldTa
 y0FtMKc2h/a7A1+n1S0xh327co6Qt/fsNQTMOBTtjvicRTSZLsgRQsUBKvTHln6D7nxivBIeqdY
 71Rlls=
X-Received: by 2002:a17:90b:4f81:b0:39d:febe:7460 with SMTP id
 98e67ed59e1d1-39e1e4e354cmr13224434a91.22.1789637601323; 
 Thu, 17 Sep 2026 02:33:21 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm12494696c88.15.2026.09.17.02.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 02:33:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 10/13] tcg: Add INDEX_op_goto_jc
Date: Wed, 16 Sep 2026 23:33:04 -1000
Message-ID: <20260917093307.1092084-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917093307.1092084-1-richard.henderson@linaro.org>
References: <20260917093307.1092084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Allow goto_jc to be implemented in the backend.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/devel/tcg-ops.rst           | 11 +++++
 include/tcg/tcg-opc.h            |  1 +
 tcg/tcg-op.c                     | 73 ++++++++++++++++++++------------
 tcg/tcg.c                        | 22 ++++++++++
 tcg/aarch64/tcg-target.c.inc     |  4 ++
 tcg/loongarch64/tcg-target.c.inc |  4 ++
 tcg/ppc64/tcg-target.c.inc       |  4 ++
 tcg/riscv64/tcg-target.c.inc     |  4 ++
 tcg/s390x/tcg-target.c.inc       |  4 ++
 tcg/sparc64/tcg-target.c.inc     |  4 ++
 tcg/tci/tcg-target.c.inc         |  4 ++
 tcg/x86_64/tcg-target.c.inc      |  4 ++
 12 files changed, 111 insertions(+), 28 deletions(-)

diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 51fa183e911..ca640610b42 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -752,6 +752,17 @@ QEMU specific operations
        | This operation is optional. If the TCG backend does not implement the
          goto_ptr opcode, emitting this op is equivalent to emitting exit_tb(0).
 
+   * - goto_jc *jc*, *pc*, *cs_base*, *flags*, *label*
+
+     - | *jc* is a CPUJumpCache pointer.  Generate code for:
+       |
+       | if (jc->pc != pc) goto label;
+       | tb = jc->tb;
+       | if (tb == NULL) goto label;
+       | if (tb->flags != flags) goto label;
+       | if (tb->cs_base != cs_base) goto label;
+       | goto tb->tc.ptr;
+
    * - qemu_ld_i32/i64/i128 *t0*, *t1*, *flags*, *memidx*
 
        qemu_st_i32/i64/i128 *t0*, *t1*, *flags*, *memidx*
diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 884345afe56..ce7703d5830 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -122,6 +122,7 @@ DEF(insn_start, 0, 0, INSN_START_WORDS, TCG_OPF_NOT_PRESENT)
 DEF(exit_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
 DEF(goto_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
 DEF(goto_ptr, 0, 1, 0, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
+DEF(goto_jc, 0, 4, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
 
 DEF(plugin_cb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(plugin_mem_cb, 0, 1, 1, TCG_OPF_NOT_PRESENT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index cd10a00bf9e..0c609f8b38e 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -158,6 +158,14 @@ static TCGOp *gen_op_ttttt(TCGOpcode opc, TCGType type,
                        temp_arg(t3), temp_arg(t4));
 }
 
+static TCGOp *gen_op_tttti(TCGOpcode opc, TCGType type,
+                           TCGTemp *t0, TCGTemp *t1, TCGTemp *t2,
+                           TCGTemp *t3, TCGArg a4)
+{
+    return tcg_gen_op5(opc, type, temp_arg(t0), temp_arg(t1),
+                       temp_arg(t2), temp_arg(t3), a4);
+}
+
 static TCGOp *gen_op_ttttti(TCGOpcode opc, TCGType type,
                             TCGTemp *t0, TCGTemp *t1, TCGTemp *t2,
                             TCGTemp *t3, TCGTemp *t4, TCGArg a5)
@@ -1997,7 +2005,13 @@ static void gen_jc_probe(TCGTemp *pc, TCGTemp *cs_base, uint32_t flags)
 {
     const TranslationBlock *tb = tcg_ctx->gen_tb;
     TCGLabel *slow = gen_new_label();
-    uint64_t fpair;
+    /*
+     * flags and cflags are adjacent uint32_t, so one aligned 64-bit load
+     * and compare covers both.
+     */
+    uint64_t fpair = (HOST_BIG_ENDIAN
+                      ? deposit64(tb->cflags, 32, 32, flags)
+                      : deposit64(flags, 32, 32, tb->cflags));
 
     QEMU_BUILD_BUG_ON(sizeof_field(CPUJumpCache, array[0]) != 16);
     QEMU_BUILD_BUG_ON(offsetof(CPUJumpCache, array[0].pc) % 8 != 0);
@@ -2018,37 +2032,40 @@ static void gen_jc_probe(TCGTemp *pc, TCGTemp *cs_base, uint32_t flags)
                    offsetof(CPUState, tb_jmp_cache) - sizeof(CPUState));
         gen_lea(TCG_TYPE_I64, p, t, h, 4, 0);
 
-        /*
-         * The pc first: on a hash miss it is the field most likely to differ,
-         * and an entry whose tb is NULL has a zero pc that only pc 0 matches.
-         */
-        gen_ld(TCG_TYPE_I64, t, p, offsetof(CPUJumpCache, array[0].pc));
-        gen_brcond(TCG_TYPE_I64, TCG_COND_NE, t, pc, slow);
+        if (tcg_op_supported(INDEX_op_goto_jc, TCG_TYPE_PTR, 0)) {
+            TCGOp *op = gen_op_tttti(INDEX_op_goto_jc, TCG_TYPE_PTR,
+                                     p, pc, cs_base,
+                                     tcg_constant_internal(TCG_TYPE_I64, fpair),
+                                     label_arg(slow));
+            add_as_label_use(slow, op);
+        } else {
+            /*
+             * The pc first: on a hash miss it is the field most likely
+             * to differ, and an entry whose tb is NULL has a zero pc
+             * that only pc 0 matches.
+             */
+            gen_ld(TCG_TYPE_I64, t, p, offsetof(CPUJumpCache, array[0].pc));
+            gen_brcond(TCG_TYPE_I64, TCG_COND_NE, t, pc, slow);
 
-        gen_ld(TCG_TYPE_PTR, p, p, offsetof(CPUJumpCache, array[0].tb));
-        gen_brcond(TCG_TYPE_PTR, TCG_COND_EQ,
-                   p, tcg_constant_internal(TCG_TYPE_PTR, 0), slow);
+            gen_ld(TCG_TYPE_PTR, p, p, offsetof(CPUJumpCache, array[0].tb));
+            gen_brcond(TCG_TYPE_PTR, TCG_COND_EQ,
+                       p, tcg_constant_internal(TCG_TYPE_PTR, 0), slow);
 
-        /*
-         * flags and cflags are adjacent uint32_t, so one aligned 64-bit load
-         * and compare covers both.
-         */
-        fpair = (HOST_BIG_ENDIAN
-                 ? deposit64(tb->cflags, 32, 32, flags)
-                 : deposit64(flags, 32, 32, tb->cflags));
-        gen_ld(TCG_TYPE_I64, t, p, offsetof(TranslationBlock, flags));
-        gen_brcond(TCG_TYPE_I64, TCG_COND_NE,
-                   t, tcg_constant_internal(TCG_TYPE_I64, fpair), slow);
+            gen_ld(TCG_TYPE_I64, t, p, offsetof(TranslationBlock, flags));
+            gen_brcond(TCG_TYPE_I64, TCG_COND_NE,
+                       t, tcg_constant_internal(TCG_TYPE_I64, fpair), slow);
 
-        /*
-         * cs_base is a second word of target-specific flags despite the name,
-         * and the pc alone does not imply it on a target that uses it.
-         */
-        gen_ld(TCG_TYPE_I64, t, p, offsetof(TranslationBlock, cs_base));
-        gen_brcond(TCG_TYPE_I64, TCG_COND_NE, t, cs_base, slow);
+            /*
+             * cs_base is a second word of target-specific flags despite
+             * the name, and the pc alone does not imply it on a target
+             * that uses it.
+             */
+            gen_ld(TCG_TYPE_I64, t, p, offsetof(TranslationBlock, cs_base));
+            gen_brcond(TCG_TYPE_I64, TCG_COND_NE, t, cs_base, slow);
 
-        gen_ld(TCG_TYPE_PTR, p, p, offsetof(TranslationBlock, tc.ptr));
-        gen_goto_ptr(p);
+            gen_ld(TCG_TYPE_PTR, p, p, offsetof(TranslationBlock, tc.ptr));
+            gen_goto_ptr(p);
+        }
     }
 
     /*
diff --git a/tcg/tcg.c b/tcg/tcg.c
index b88ee847039..a08e83f3954 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1101,6 +1101,12 @@ typedef struct TCGOutOpLea {
                 TCGReg a2, unsigned sh, tcg_target_long imm);
 } TCGOutOpLea;
 
+typedef struct TCGOutOpGotoJC {
+    TCGOutOp base;
+    void (*out)(TCGContext *s, TCGReg jc, TCGReg pc, TCGArg cs, bool const_cs,
+                TCGArg fl, bool const_fl, TCGLabel *l);
+} TCGOutOpGotoJC;
+
 #include "tcg-target.c.inc"
 
 #ifndef CONFIG_TCG_INTERPRETER
@@ -1190,6 +1196,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_extrh_i64_i32, TCGOutOpUnary, outop_extrh_i64_i32),
     OUTOP(INDEX_op_extrl_i64_i32, TCGOutOpUnary, outop_extrl_i64_i32),
     OUTOP(INDEX_op_extu_i32_i64, TCGOutOpUnary, outop_extu_i32_i64),
+    OUTOP(INDEX_op_goto_jc, TCGOutOpGotoJC, outop_goto_jc),
     OUTOP(INDEX_op_ld, TCGOutOpLoad, outop_ld),
     OUTOP(INDEX_op_ld8s, TCGOutOpLoad, outop_ld8s),
     OUTOP(INDEX_op_ld8u, TCGOutOpLoad, outop_ld8u),
@@ -3009,6 +3016,7 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
             case INDEX_op_set_label:
             case INDEX_op_br:
             case INDEX_op_brcond:
+            case INDEX_op_goto_jc:
                 col += ne_fprintf(f, "%s$L%d", k ? "," : "",
                                   arg_label(op->args[k])->id);
                 i++, k++;
@@ -3478,6 +3486,9 @@ void tcg_op_remove(TCGContext *s, TCGOp *op)
     case INDEX_op_brcond:
         remove_label_use(op, 3);
         break;
+    case INDEX_op_goto_jc:
+        remove_label_use(op, 4);
+        break;
     default:
         break;
     }
@@ -3576,6 +3587,9 @@ static void move_label_uses(TCGLabel *to, TCGLabel *from)
         case INDEX_op_brcond:
             op->args[3] = label_arg(to);
             break;
+        case INDEX_op_goto_jc:
+            op->args[4] = label_arg(to);
+            break;
         default:
             g_assert_not_reached();
         }
@@ -3650,6 +3664,7 @@ reachable_code_pass(TCGContext *s)
         case INDEX_op_br:
         case INDEX_op_exit_tb:
         case INDEX_op_goto_ptr:
+        case INDEX_op_goto_jc:
             /* Unconditional branches; everything following is dead.  */
             dead = true;
             break;
@@ -6017,6 +6032,13 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         tcg_out_goto_ptr(s, new_args[0]);
         break;
 
+    case INDEX_op_goto_jc:
+        tcg_debug_assert(!const_args[0]);
+        tcg_debug_assert(!const_args[1]);
+        outop_goto_jc.out(s, new_args[0], new_args[1], new_args[2], const_args[2],
+                          new_args[3], const_args[3], arg_label(new_args[4]));
+        break;
+
     default:
         tcg_debug_assert(def->flags & TCG_OPF_VECTOR);
         tcg_out_vec_op(s, op->opc, type - TCG_TYPE_V64,
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 6836c0dd94f..a0f23914224 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2008,6 +2008,10 @@ static const TCGOutOpQemuLdSt2 outop_qemu_st2 = {
     .out = tgen_qemu_st2,
 };
 
+static const TCGOutOpGotoJC outop_goto_jc = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static const tcg_insn_unit *tb_ret_addr;
 
 static void tcg_out_exit_tb(TCGContext *s, uintptr_t a0)
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 377cd9ec08d..733cce516e0 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -2113,6 +2113,10 @@ static const TCGOutOpLea outop_lea = {
     .out = tgen_lea,
 };
 
+static const TCGOutOpGotoJC outop_goto_jc = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg rd, TCGReg rs)
 {
diff --git a/tcg/ppc64/tcg-target.c.inc b/tcg/ppc64/tcg-target.c.inc
index 99f4469f4b9..466ae836d5a 100644
--- a/tcg/ppc64/tcg-target.c.inc
+++ b/tcg/ppc64/tcg-target.c.inc
@@ -3637,6 +3637,10 @@ static const TCGOutOpLea outop_lea = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static const TCGOutOpGotoJC outop_goto_jc = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
 {
     switch (opc) {
diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index ba7aab9246c..effa9d7a1ac 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -2743,6 +2743,10 @@ static const TCGOutOpLea outop_lea = {
     .out = tgen_lea,
 };
 
+static const TCGOutOpGotoJC outop_goto_jc = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                            unsigned vecl, unsigned vece,
                            const TCGArg args[TCG_MAX_OP_ARGS],
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index db3b2fc3c92..3b63383315d 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -3202,6 +3202,10 @@ static const TCGOutOpLea outop_lea = {
     .out = tgen_lea,
 };
 
+static const TCGOutOpGotoJC outop_goto_jc = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg dst, TCGReg src)
 {
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index cb457453ff9..0582dc8bdd3 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -2124,6 +2124,10 @@ static const TCGOutOpLea outop_lea = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static const TCGOutOpGotoJC outop_goto_jc = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 6942fdbb4e0..5d8892abc44 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -1224,6 +1224,10 @@ static const TCGOutOpLea outop_lea = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static const TCGOutOpGotoJC outop_goto_jc = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 /* Test if a constant matches the constraint. */
 static bool tcg_target_const_match(int64_t val, int ct,
                                    TCGType type, TCGCond cond, int vece)
diff --git a/tcg/x86_64/tcg-target.c.inc b/tcg/x86_64/tcg-target.c.inc
index a41252782e1..08dec0dace8 100644
--- a/tcg/x86_64/tcg-target.c.inc
+++ b/tcg/x86_64/tcg-target.c.inc
@@ -3344,6 +3344,10 @@ static const TCGOutOpLea outop_lea = {
     .out = tgen_lea,
 };
 
+static const TCGOutOpGotoJC outop_goto_jc = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static int const umin_insn[4] = {
     OPC_PMINUB, OPC_PMINUW, OPC_PMINUD, OPC_VPMINUQ
 };
-- 
2.53.0


