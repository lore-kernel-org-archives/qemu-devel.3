Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39544C98328
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 09:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA2Oc-0000QM-M5; Fri, 25 Sep 2026 05:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xA2OX-0000PK-9U
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 05:39:06 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xA2OV-0006F0-4f
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 05:39:05 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8D48B43802;
 Fri, 25 Sep 2026 09:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74701F000FF;
 Fri, 25 Sep 2026 09:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790329141;
 bh=HFAMBTvxDYiY7scNthZmqVHclWsFzUZKzfvh58Obg3E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=b7alQTylTNfO6M+v9estdWAMYZWSLGH3r2xKL+EjIz+hxL0D7/SWJlKKIBE8CCxxY
 z/yenDAr6vnUUfNoi+L20U5hVaVBnR8J+o4u90xZKoXpLw9FH5j1ltvXf1pZGzVHG+
 jhP/Cc0lahlp4S0t+PyCwPYXzQ2hCbQ9Ad67yBZvFdmKb9yJjcCyWhabuqgWZTt1A8
 TnOdTiiH9rWETh6LY+DKd2nwSR7mNF28PKJY3XnVZmnJiYBdmjVR/Nvua7ZSYjMm/W
 Ssudsa9VV5IGvmKFPpJ9TjmQt/wqbJgEjyj4nboUFQd4ju78K5Vz+/bAc18WFox/MA
 N3dcEGZnfhLlA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 7/8] target/sh4: Replace TB_FLAG_GUSA_EXCLUSIVE with
 CF_STEP_ATOMIC
Date: Fri, 25 Sep 2026 11:38:43 +0200
Message-ID: <20260925093844.5685-8-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925093844.5685-1-deller@kernel.org>
References: <20260925093844.5685-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

There was a complex bug with gUSA wherein:

  * decode_gusa calls gen_restart_exclusive
  * gen_restart_exclusive generates code that sets TB_FLAG_GUSA_EXCLUSIVE
    and generates a call to helper_exclusive

  * when the code is executed, TB_FLAG_GUSA_EXCLUSIVE is set
  * helper_exclusive calls cpu_loop_exit_atomic, this makes cpu_exec exit
    with EXCP_ATOMIC
  * we go to cpu_loop, we execute cpu_exec_step_atomic
  * suppose that exit request is set, cpu_exec_step_atomic does nothing, it
    leaves the CPU in the same state as it was before
  * we go back to cpu_loop
  * suppose that no signal is delivered, so the gUSA is not rewound
  * cpu_loop goes to cpu_exec
  * there is one difference - now, TB_FLAG_GUSA_EXCLUSIVE is set and it was
    clear before - so cpu_exec will not use the TB that calls
    helper_exclusive, it will instead use the TB that performs the atomic
    operation (both of these TBs have the same PC, they only differ in flags)
  * the TB that performs the atomic operation is executed inside cpu_exec
    => race condition

Fix the bug by managing the "are we in cpu_exec_step_atomic" flag
from cpu_exec_step_atomic itself, rather from the translator.

Cc: qemu-stable@nongnu.org
Fixes: 4bfa602bc22 ("target/sh4: Handle user-space atomics")
Reported-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 accel/tcg/cpu-exec.c             |  3 ++-
 include/exec/translation-block.h |  1 +
 target/sh4/cpu.h                 |  6 ++----
 target/sh4/translate.c           | 34 +++++++++++++++++++++++---------
 4 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index f4428e9f7b..5b4bca5084 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -566,7 +566,8 @@ void cpu_exec_step_atomic(CPUState *cpu)
         /* Execute in a serial context. */
         s.cflags &= ~CF_PARALLEL;
         /* After 1 insn, return and release the exclusive lock. */
-        s.cflags |= CF_NO_GOTO_TB | CF_NO_GOTO_PTR | CF_NOIRQ | 1;
+        s.cflags |= CF_NO_GOTO_TB | CF_NO_GOTO_PTR |
+                    CF_NOIRQ | CF_STEP_ATOMIC | 1;
 
         /*
          * No need to check_for_breakpoints here.
diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index 40cc699031..7c42c57cca 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -84,6 +84,7 @@ struct TranslationBlock {
 #define CF_NOIRQ         0x00010000 /* Generate an uninterruptible TB */
 #define CF_PCREL         0x00020000 /* Opcodes in TB are PC-relative */
 #define CF_BP_PAGE       0x00040000 /* Breakpoint present in code page */
+#define CF_STEP_ATOMIC   0x00080000 /* Running in cpu_exec_step_atomic */
 #define CF_CLUSTER_MASK  0xff000000 /* Top 8 bits are cluster ID */
 #define CF_CLUSTER_SHIFT 24
 
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 3302702376..6984bb462f 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -84,8 +84,7 @@
 #define TB_FLAG_DELAY_SLOT_RTE   (1 << 2)
 #define TB_FLAG_PENDING_MOVCA    (1 << 3)
 #define TB_FLAG_GUSA_SHIFT       4                      /* [11:4] */
-#define TB_FLAG_GUSA_EXCLUSIVE   (1 << 12)
-#define TB_FLAG_UNALIGN          (1 << 13)
+#define TB_FLAG_UNALIGN          (1 << 12)
 #define TB_FLAG_SR_FD            (1 << SR_FD)           /* 15 */
 #define TB_FLAG_FPSCR_PR         FPSCR_PR               /* 19 */
 #define TB_FLAG_FPSCR_SZ         FPSCR_SZ               /* 20 */
@@ -96,8 +95,7 @@
 #define TB_FLAG_DELAY_SLOT_MASK  (TB_FLAG_DELAY_SLOT |       \
                                   TB_FLAG_DELAY_SLOT_COND |  \
                                   TB_FLAG_DELAY_SLOT_RTE)
-#define TB_FLAG_GUSA_MASK        ((0xff << TB_FLAG_GUSA_SHIFT) | \
-                                  TB_FLAG_GUSA_EXCLUSIVE)
+#define TB_FLAG_GUSA_MASK        (0xff << TB_FLAG_GUSA_SHIFT)
 #define TB_FLAG_FPSCR_MASK       (TB_FLAG_FPSCR_PR | \
                                   TB_FLAG_FPSCR_SZ | \
                                   TB_FLAG_FPSCR_FR)
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 373950fd66..c15c0802f7 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -47,6 +47,9 @@ typedef struct DisasContext {
     uint16_t opcode;
 
     bool has_movcal;
+#ifdef CONFIG_USER_ONLY
+    bool in_gusa_exclusive;
+#endif
 } DisasContext;
 
 #if defined(CONFIG_USER_ONLY)
@@ -220,7 +223,11 @@ static inline void gen_save_cpu_state(DisasContext *ctx, bool save_pc)
 
 static inline bool use_exit_tb(DisasContext *ctx)
 {
-    return (ctx->tbflags & TB_FLAG_GUSA_EXCLUSIVE) != 0;
+#ifdef CONFIG_USER_ONLY
+    return ctx->in_gusa_exclusive;
+#else
+    return false;
+#endif
 }
 
 static bool use_goto_tb(DisasContext *ctx, vaddr dest)
@@ -273,7 +280,8 @@ static void gen_conditional_jump(DisasContext *ctx, vaddr dest,
     TCGLabel *l1 = gen_new_label();
     TCGCond cond_not_taken = jump_if_true ? TCG_COND_EQ : TCG_COND_NE;
 
-    if (ctx->tbflags & TB_FLAG_GUSA_EXCLUSIVE) {
+#ifdef CONFIG_USER_ONLY
+    if (ctx->in_gusa_exclusive) {
         /* When in an exclusive region, we must continue to the end.
            Therefore, exit the region on a taken branch, but otherwise
            fall through to the next instruction.  */
@@ -286,6 +294,7 @@ static void gen_conditional_jump(DisasContext *ctx, vaddr dest,
         ctx->base.is_jmp = DISAS_NEXT;
         return;
     }
+#endif
 
     gen_save_cpu_state(ctx, false);
     tcg_gen_brcondi_i32(cond_not_taken, cpu_sr_t, 0, l1);
@@ -304,7 +313,8 @@ static void gen_delayed_conditional_jump(DisasContext * ctx)
     tcg_gen_mov_i32(ds, cpu_delayed_cond);
     tcg_gen_discard_i32(cpu_delayed_cond);
 
-    if (ctx->tbflags & TB_FLAG_GUSA_EXCLUSIVE) {
+#ifdef CONFIG_USER_ONLY
+    if (ctx->in_gusa_exclusive) {
         /* When in an exclusive region, we must continue to the end.
            Therefore, exit the region on a taken branch, but otherwise
            fall through to the next instruction.  */
@@ -318,6 +328,7 @@ static void gen_delayed_conditional_jump(DisasContext * ctx)
         ctx->base.is_jmp = DISAS_NEXT;
         return;
     }
+#endif
 
     tcg_gen_brcondi_i32(TCG_COND_NE, ds, 0, l1);
     gen_goto_tb(ctx, 1, ctx->base.pc_next + 2);
@@ -1793,16 +1804,18 @@ static void decode_opc(DisasContext * ctx)
         /* go out of the delay slot */
         ctx->envflags &= ~TB_FLAG_DELAY_SLOT_MASK;
 
+#ifdef CONFIG_USER_ONLY
         /* When in an exclusive region, we must continue to the end
            for conditional branches.  */
-        if (ctx->tbflags & TB_FLAG_GUSA_EXCLUSIVE
-            && old_flags & TB_FLAG_DELAY_SLOT_COND) {
+        if (ctx->in_gusa_exclusive && old_flags & TB_FLAG_DELAY_SLOT_COND) {
             gen_delayed_conditional_jump(ctx);
             return;
         }
+
         /* Otherwise this is probably an invalid gUSA region.
            Drop the GUSA bits so the next TB doesn't see them.  */
         ctx->envflags &= ~TB_FLAG_GUSA_MASK;
+#endif
 
         tcg_gen_movi_i32(cpu_flags, ctx->envflags);
         if (old_flags & TB_FLAG_DELAY_SLOT_COND) {
@@ -1820,7 +1833,6 @@ static void decode_opc(DisasContext * ctx)
  */
 static void gen_restart_exclusive(DisasContext *ctx)
 {
-    ctx->envflags |= TB_FLAG_GUSA_EXCLUSIVE;
     gen_save_cpu_state(ctx, false);
     gen_helper_exclusive(tcg_env);
     ctx->base.is_jmp = DISAS_NORETURN;
@@ -2208,11 +2220,13 @@ static void sh4_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
         int backup = sextract32(ctx->tbflags, TB_FLAG_GUSA_SHIFT, 8);
         int max_insns = (pc_end - pc) / 2;
 
+        ctx->in_gusa_exclusive = ctx->base.tb->cflags & CF_STEP_ATOMIC;
+
         if (pc != pc_end + backup || max_insns < 2) {
             /* This is a malformed gUSA region.  Don't do anything special,
                since the interpreter is likely to get confused.  */
             ctx->envflags &= ~TB_FLAG_GUSA_MASK;
-        } else if (tbflags & TB_FLAG_GUSA_EXCLUSIVE) {
+        } else if (ctx->in_gusa_exclusive) {
             /* Regardless of single-stepping or the end of the page,
                we must complete execution of the gUSA region while
                holding the exclusive lock.  */
@@ -2246,7 +2260,7 @@ static void sh4_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 
 #ifdef CONFIG_USER_ONLY
     if (unlikely(ctx->envflags & TB_FLAG_GUSA_MASK)
-        && !(ctx->envflags & TB_FLAG_GUSA_EXCLUSIVE)) {
+        && !ctx->in_gusa_exclusive) {
         /*
          * We're in an gUSA region, and we have not already fallen
          * back on using an exclusive region.  Attempt to parse the
@@ -2276,10 +2290,12 @@ static void sh4_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-    if (ctx->tbflags & TB_FLAG_GUSA_EXCLUSIVE) {
+#ifdef CONFIG_USER_ONLY
+    if (ctx->in_gusa_exclusive) {
         /* Ending the region of exclusivity.  Clear the bits.  */
         ctx->envflags &= ~TB_FLAG_GUSA_MASK;
     }
+#endif
 
     switch (ctx->base.is_jmp) {
     case DISAS_STOP:
-- 
2.54.0


