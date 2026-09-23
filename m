Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440FCC98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9V7H-0007Rq-07; Wed, 23 Sep 2026 18:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9V7G-0007RQ-3a
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 18:07:02 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9V7D-0005nF-Ko
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 18:07:01 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccdaea76so653248a91.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 15:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790201218; x=1790806018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jIJSx8eVwK44OkARebMcKW855hARnx67VTeEo6/YBh8=;
 b=grCGfURFhQ18NoSouUjbN5DRDlFAJmN+vqdw8dIweJDyQ7p+GOeMkXdANloEB5FgXt
 2r3Z8jX4Y6m3alK0trINg12jcm1zCiyJrKEjoDR9hjEcB3f86sBw4p4eT1Yf5HKpG9Zo
 roA98n47rCFhn65xnSrUNmKBjvS+2FiuFglFWEoY3gPt6uBah+Wn5yIU82dA0uOZWBZZ
 Ch/VS/o/+UwfhRlznXSpIiU9IoJBrQIBi7w0gBDXZrxD7snw2MDornVXW9fw0rllLVIG
 Suuofaan+6aQuT1tHGV300IDG8PTlDPQY8lMD1UYWbXWoZ9mwbdYmcVcL5gUSEgitBdt
 nbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790201218; x=1790806018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jIJSx8eVwK44OkARebMcKW855hARnx67VTeEo6/YBh8=;
 b=MO546UmtyfO02bJ2RV90678phTGinbk8iyhggP/bffCI3gF8wmZp94spoKAyeNhORb
 kqLwJmVziuyjosBaDjDDDdfasADytcp2CGb1uK7poiickp0UqU80+liH+DNFOgBflcMR
 sLn28a3086cg/otxc+Nyu29zBBOrQ+OptvmBVx/Ag0uobM/nSxIplqjKQ5x3csE1SXMq
 1UH1XASnEVt/tJi3Bh06tS7sRet9WXTjQ/Ubo0QDklkwfqyr/h6e/fqpoDhrlqFYn7I7
 widjSeRD+q72yCO7kzy/Z6Dn9SE1nuveZ7Pzn5ASRpiuxdweA6veELG5PH1ZGCBAyzwx
 ta1A==
X-Gm-Message-State: AFuF++kR6wUBju6kmlyOxMgk++kvYyxDexHfEarItbKzUou/GQ4k50Q3
 BOUTHDaaaXIVeUVml8H7L44ZYpWSM+8qhkmz/c1rlyQnQSlxiTGXMlJICD0bTUpOVyusB2ck04z
 yILEc
X-Gm-Gg: AYBFou1ZKWcb7vOSxKtgiGGYKr6fG+zMgUsceIYSIupAGZdFYcEMoLIgPO5k6WsLs0h
 X3yB1090dtMEFDWUTVuiUS5kmK4FxDE7BREDz2EeyXozCuYlOGn/ZEwl0wlwgzh9JX4W0xvrfN8
 n66fNyvDq6Ht35yXIKhzi3RNQzQ1160P9HACSsH3b3qcndUl2qpAumud98bH+BAi/NX3srFDpqn
 6/0ugbTWlX1O6+xlaD/gMFsJr9Lb4WOZeyaHtGFR2dhobt6cS5aVDnDcAnxKWGi+GDp/vTFQutm
 gSn//OyuVfxuMUsjTpp2TZBd9RB5x7bTAq3qIy4zosenavN2OARuQGmojla1JiTe7Ec8r9oY+76
 DP2ffYUcvlfn4YAX4zXRYMPJg+fGmDOHtimxxijliABVqlt9FqFv0uZaus2CH222jOK9raJP6q5
 p7BXh9tqkVQzu+7rdFy2+vPcXpmFoIRqT1LliT6IpFMfe2RY9maR4sY0qTTdkKuk7dsQ4PGuJsB
 19aEGJrp4/x/das8RlvIO29iIdUrA==
X-Received: by 2002:a17:90b:5343:b0:39e:6c68:fd8b with SMTP id
 98e67ed59e1d1-3a098b235a8mr287886a91.32.1790201217967; 
 Wed, 23 Sep 2026 15:06:57 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0976ca5f9sm998322a91.14.2026.09.23.15.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 15:06:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mpatocka@redhat.com,
	qemu-stable@nongnu.org
Subject: [PATCH v4 2/3] target/sh4: Replace TB_FLAG_GUSA_EXCLUSIVE with
 CF_STEP_ATOMIC
Date: Wed, 23 Sep 2026 15:06:53 -0700
Message-ID: <20260923220654.127167-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923220654.127167-1-richard.henderson@linaro.org>
References: <20260923220654.127167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
---
 include/exec/translation-block.h |  1 +
 target/sh4/cpu.h                 |  6 ++----
 accel/tcg/cpu-exec.c             |  3 ++-
 target/sh4/translate.c           | 34 +++++++++++++++++++++++---------
 4 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index 40cc6990318..7c42c57cca6 100644
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
index 33027023763..6984bb462fb 100644
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
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index f4428e9f7b7..5b4bca5084f 100644
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
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 373950fd662..c15c0802f78 100644
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
2.53.0


