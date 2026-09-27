Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02142C98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 07:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAjKB-0003sH-LN; Sun, 27 Sep 2026 03:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAjJC-0001YE-R7; Sun, 27 Sep 2026 03:28:36 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAjJA-0005f1-Mr; Sun, 27 Sep 2026 03:28:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790494014; bh=uARxCeggQJqVMQZaWn6tzN7uNqQPMoOtVAQXF7f5W2w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=UlY3bFgxOTmU+ina35YYO8iGATouVZy3WCn8Ob6UH8RoIAvrT/Y3R+8xTkfzHARQa
 g+Pe2Uptw0TrUVoaimVLhVT2BlcvUCc9oM0DVfeO6enP+JS1Q4dxFhstjcQdNUIYkg
 fxczRqBuFnaaIc1NNof4G1upLuJmGX7EmAdMwtmH/KMKYv3O5QXbrzPtCZLhKvVTT0
 UWwmvbgL1hyYNWWQetOR9b6VFmxNrwh+4Z5CRJxyIKYIyLk+RLCpJWWeqAI7Qiucp4
 FzGWW8tyHI7A2a8QOCp2NLZ4LOuoYttkngatSqDgDdwSK8jG7ydPAeqtCPXJpw2zXP
 BST14ReUw/+qg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1C21E1D8ACA;
 Sun, 27 Sep 2026 10:26:54 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 185E643205C;
 Sun, 27 Sep 2026 10:26:54 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 1B7265E643; Sun, 27 Sep 2026 10:26:53 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Helge Deller <deller@gmx.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.14 v2 72/72] target/sh4: Replace TB_FLAG_GUSA_EXCLUSIVE
 with CF_STEP_ATOMIC
Date: Sun, 27 Sep 2026 10:26:04 +0300
Message-ID: <20260927072622.93656-23-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.14-20260927020824@cover.tls.msk.ru>
References: <qemu-stable-10.0.14-20260927020824@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
(cherry picked from commit 62728f8c932f9572eeea22f91e3ee223978b1c7f)
(Mjt: adjust for 10.0.x across v10.0.0-561-g4759aae43235
 "accel/tcg: Return TCGTBCPUState from cpu_get_tb_cpu_state")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 27f69b1a4a2..3fb880b43f9 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -580,7 +580,8 @@ void cpu_exec_step_atomic(CPUState *cpu)
         /* Execute in a serial context. */
         cflags &= ~CF_PARALLEL;
         /* After 1 insn, return and release the exclusive lock. */
-        cflags |= CF_NO_GOTO_TB | CF_NO_GOTO_PTR | CF_NOIRQ | 1;
+        cflags |= CF_NO_GOTO_TB | CF_NO_GOTO_PTR |
+                    CF_NOIRQ | CF_STEP_ATOMIC | 1;
         /*
          * No need to check_for_breakpoints here.
          * We only arrive in cpu_exec_step_atomic after beginning execution
diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index 3c69bc71a9f..d8f133b41b7 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -80,6 +80,7 @@ struct TranslationBlock {
 #define CF_NOIRQ         0x00010000 /* Generate an uninterruptible TB */
 #define CF_PCREL         0x00020000 /* Opcodes in TB are PC-relative */
 #define CF_BP_PAGE       0x00040000 /* Breakpoint present in code page */
+#define CF_STEP_ATOMIC   0x00080000 /* Running in cpu_exec_step_atomic */
 #define CF_CLUSTER_MASK  0xff000000 /* Top 8 bits are cluster ID */
 #define CF_CLUSTER_SHIFT 24
 
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 2ada25ee004..2cc39bd37a0 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -83,8 +83,7 @@
 #define TB_FLAG_DELAY_SLOT_RTE   (1 << 2)
 #define TB_FLAG_PENDING_MOVCA    (1 << 3)
 #define TB_FLAG_GUSA_SHIFT       4                      /* [11:4] */
-#define TB_FLAG_GUSA_EXCLUSIVE   (1 << 12)
-#define TB_FLAG_UNALIGN          (1 << 13)
+#define TB_FLAG_UNALIGN          (1 << 12)
 #define TB_FLAG_SR_FD            (1 << SR_FD)           /* 15 */
 #define TB_FLAG_FPSCR_PR         FPSCR_PR               /* 19 */
 #define TB_FLAG_FPSCR_SZ         FPSCR_SZ               /* 20 */
@@ -95,8 +94,7 @@
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
index 6286862241e..4af2a9351bf 100644
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
 
 static bool use_goto_tb(DisasContext *ctx, target_ulong dest)
@@ -273,7 +280,8 @@ static void gen_conditional_jump(DisasContext *ctx, target_ulong dest,
     TCGLabel *l1 = gen_new_label();
     TCGCond cond_not_taken = jump_if_true ? TCG_COND_EQ : TCG_COND_NE;
 
-    if (ctx->tbflags & TB_FLAG_GUSA_EXCLUSIVE) {
+#ifdef CONFIG_USER_ONLY
+    if (ctx->in_gusa_exclusive) {
         /* When in an exclusive region, we must continue to the end.
            Therefore, exit the region on a taken branch, but otherwise
            fall through to the next instruction.  */
@@ -286,6 +294,7 @@ static void gen_conditional_jump(DisasContext *ctx, target_ulong dest,
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
@@ -1800,16 +1811,18 @@ static void decode_opc(DisasContext * ctx)
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
@@ -1827,7 +1840,6 @@ static void decode_opc(DisasContext * ctx)
  */
 static void gen_restart_exclusive(DisasContext *ctx)
 {
-    ctx->envflags |= TB_FLAG_GUSA_EXCLUSIVE;
     gen_save_cpu_state(ctx, false);
     gen_helper_exclusive(tcg_env);
     ctx->base.is_jmp = DISAS_NORETURN;
@@ -2215,11 +2227,13 @@ static void sh4_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
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
@@ -2253,7 +2267,7 @@ static void sh4_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 
 #ifdef CONFIG_USER_ONLY
     if (unlikely(ctx->envflags & TB_FLAG_GUSA_MASK)
-        && !(ctx->envflags & TB_FLAG_GUSA_EXCLUSIVE)) {
+        && !ctx->in_gusa_exclusive) {
         /*
          * We're in an gUSA region, and we have not already fallen
          * back on using an exclusive region.  Attempt to parse the
@@ -2283,10 +2297,12 @@ static void sh4_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
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
2.47.3


