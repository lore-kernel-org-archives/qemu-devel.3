Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B751FC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 05:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2PFO-00004s-FS; Thu, 02 May 2024 01:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2PFI-0008Ql-ES
 for qemu-devel@nongnu.org; Thu, 02 May 2024 01:44:40 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2PF9-0002dp-J1
 for qemu-devel@nongnu.org; Thu, 02 May 2024 01:44:39 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3c70d8bb618so3399322b6e.2
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 22:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714628669; x=1715233469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V/inWHR1OelJkN3zbarItqFQdu7gu0A59SAvE6t91DA=;
 b=E9pnStMZ4MvFyqz0sFaDjDfbtd0jtNa9jIw69B4sF7kyIlXsnTSaRupHTwG+qnmuTv
 2QknMtpZ9nE2UX1XPupYKlYLTEGrhxQT24StmbqU8S4OPfqPNEgDOPUrlILGHRpae8TM
 iRBu1q1l5Em+VeXnXATB60Ntqqd/8cvnv++/q4tLk63vFL7+vSfy5wlvwnE7vw2Uy2OP
 3639XJnk3tGA0gPtzLe3l+37dolGXowYr7HSGVj1C2W++ZVPnczjebnspxWD8YO9XJKf
 TljdfiE/k2UeHevDxCpcS4pWACpessff9grxOipQQTwzgEmGuvEmR1dU92RnW4phmQ07
 XLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714628669; x=1715233469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V/inWHR1OelJkN3zbarItqFQdu7gu0A59SAvE6t91DA=;
 b=jBr+dmhTL8D6xDQ8lAlnIIcIwoSyRwna0Ms2/HF2mHSzIljX1PkBJ7jJ+Npw4mU6K6
 j8BDjbyvTrvw/keXJ2WccsZxghZUbrKTaLSBCVewxXRiHSw0KzOw/PQNzxDQkwhulccy
 5aZlc6IKWHb/6nVXIeH4FGUfAARazY8SK8JgkcOQTZ0EEVNX0OZ79+oGpGvxiZ4PLAyg
 lcLl6S+HQGzTPE7QAjNslh1gN3RdFCij2Pl7ZNOSWS7eBgLUHsKMscfAX12wVp2iDoWF
 7sq+lZ022fwv1Jz1QmC3W063QmchHN95MN829R/yqA54dJ2nxn0JpBbq8I1pKJmTuudK
 Z4IA==
X-Gm-Message-State: AOJu0YyTXmY4Pc8I6OgnzEmuXPnTG5dne9e9EN0MPoHHHQBSmmfa/XCE
 AgJiUVMFFwqbdC1oPnNBwl6BbSJ3fU717jUcJQC2t/nYdr/I6qfAIO8Qy8HOZMoCjDDJuFOHh3L
 w
X-Google-Smtp-Source: AGHT+IEG94bJAftX39lUFmP0M7K6TfhRxnLotrSwKkeNHwGomIvAXIfrnlz30aN76RqxZMTCEWjSqg==
X-Received: by 2002:a05:6870:d108:b0:238:f93f:66b6 with SMTP id
 e8-20020a056870d10800b00238f93f66b6mr1581763oac.29.1714628669008; 
 Wed, 01 May 2024 22:44:29 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e18-20020a656492000000b006089cf2cde5sm294401pgv.26.2024.05.01.22.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 22:44:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, iii@linux.ibm.com, david@redhat.com,
 thuth@redhat.com
Subject: [PATCH 09/14] target/s390x: Raise exception from helper_per_branch
Date: Wed,  1 May 2024 22:44:12 -0700
Message-Id: <20240502054417.234340-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502054417.234340-1-richard.henderson@linaro.org>
References: <20240502054417.234340-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Drop from argument, since gbea has always been updated with
this address.  Add ilen argument for setting int_pgm_ilen.
Use update_cc_op before calling per_branch.

By raising the exception here, we need not call
per_check_exception later, which means we can clean up the
normal non-exception branch path.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/helper.h          |  2 +-
 target/s390x/tcg/misc_helper.c | 15 +++++++----
 target/s390x/tcg/translate.c   | 48 ++++++++++++----------------------
 3 files changed, 27 insertions(+), 38 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 96ab71e877..061b379065 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -360,7 +360,7 @@ DEF_HELPER_FLAGS_1(ptlb, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_1(purge, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_3(lra, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(per_check_exception, TCG_CALL_NO_WG, void, env, i64, i32)
-DEF_HELPER_FLAGS_3(per_branch, TCG_CALL_NO_RWG, void, env, i64, i64)
+DEF_HELPER_FLAGS_3(per_branch, TCG_CALL_NO_WG, void, env, i64, i32)
 DEF_HELPER_FLAGS_2(per_ifetch, TCG_CALL_NO_RWG, void, env, i64)
 DEF_HELPER_FLAGS_1(per_store_real, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_1(stfl, TCG_CALL_NO_RWG, void, env)
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index b7100c06c0..5b1c512367 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -625,13 +625,18 @@ static inline bool get_per_in_range(CPUS390XState *env, uint64_t addr)
     }
 }
 
-void HELPER(per_branch)(CPUS390XState *env, uint64_t from, uint64_t to)
+void HELPER(per_branch)(CPUS390XState *env, uint64_t dest, uint32_t ilen)
 {
-    if (!(env->cregs[9] & PER_CR9_CONTROL_BRANCH_ADDRESS)
-        || get_per_in_range(env, to)) {
-        env->per_address = from;
-        env->per_perc_atmid = PER_CODE_EVENT_BRANCH | get_per_atmid(env);
+    if ((env->cregs[9] & PER_CR9_CONTROL_BRANCH_ADDRESS)
+        && !get_per_in_range(env, dest)) {
+        return;
     }
+
+    env->psw.addr = dest;
+    env->int_pgm_ilen = ilen;
+    env->per_address = env->gbea;
+    env->per_perc_atmid = PER_CODE_EVENT_BRANCH | get_per_atmid(env);
+    per_raise_exception_log(env);
 }
 
 void HELPER(per_ifetch)(CPUS390XState *env, uint64_t addr)
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index a384192d15..4a6ef144b7 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -343,12 +343,11 @@ static void update_psw_addr(DisasContext *s)
     tcg_gen_movi_i64(psw_addr, s->base.pc_next);
 }
 
-static void per_branch(DisasContext *s, bool to_next)
+static void per_branch(DisasContext *s, TCGv_i64 dest)
 {
 #ifndef CONFIG_USER_ONLY
     if (s->base.tb->flags & FLAG_MASK_PER_BRANCH) {
-        TCGv_i64 next_pc = to_next ? tcg_constant_i64(s->pc_tmp) : psw_addr;
-        gen_helper_per_branch(tcg_env, gbea, next_pc);
+        gen_helper_per_branch(tcg_env, dest, tcg_constant_i32(s->ilen));
     }
 #endif
 }
@@ -637,9 +636,6 @@ static void gen_op_calc_cc(DisasContext *s)
 
 static bool use_goto_tb(DisasContext *s, uint64_t dest)
 {
-    if (unlikely(s->base.tb->flags & FLAG_MASK_PER_BRANCH)) {
-        return false;
-    }
     return translator_use_goto_tb(&s->base, dest);
 }
 
@@ -1081,37 +1077,38 @@ struct DisasInsn {
 
 static DisasJumpType help_goto_direct(DisasContext *s, uint64_t dest)
 {
+    update_cc_op(s);
     per_breaking_event(s);
+    per_branch(s, tcg_constant_i64(dest));
+
     if (dest == s->pc_tmp) {
-        per_branch(s, true);
         return DISAS_NEXT;
     }
     if (use_goto_tb(s, dest)) {
-        update_cc_op(s);
         tcg_gen_goto_tb(0);
         tcg_gen_movi_i64(psw_addr, dest);
         tcg_gen_exit_tb(s->base.tb, 0);
         return DISAS_NORETURN;
     } else {
         tcg_gen_movi_i64(psw_addr, dest);
-        per_branch(s, false);
-        return DISAS_PC_UPDATED;
+        return DISAS_PC_CC_UPDATED;
     }
 }
 
 static DisasJumpType help_goto_indirect(DisasContext *s, TCGv_i64 dest)
 {
+    update_cc_op(s);
     per_breaking_event(s);
     tcg_gen_mov_i64(psw_addr, dest);
-    per_branch(s, false);
-    return DISAS_PC_UPDATED;
+    per_branch(s, psw_addr);
+    return DISAS_PC_CC_UPDATED;
 }
 
 static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
                                  bool is_imm, int imm, TCGv_i64 cdest)
 {
     uint64_t dest = s->base.pc_next + (int64_t)imm * 2;
-    TCGLabel *lab, *over;
+    TCGLabel *lab;
 
     /* Take care of the special cases first.  */
     if (c->cond == TCG_COND_NEVER) {
@@ -1145,12 +1142,6 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
      * which avoids an otherwise unnecessary spill to the stack.
      */
     lab = gen_new_label();
-    if (s->base.tb->flags & FLAG_MASK_PER_BRANCH) {
-        over = gen_new_label();
-    } else {
-        over = NULL;
-    }
-
     if (c->is_64) {
         tcg_gen_brcond_i64(tcg_invert_cond(c->cond),
                            c->u.s64.a, c->u.s64.b, lab);
@@ -1166,13 +1157,11 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
     } else {
         tcg_gen_mov_i64(psw_addr, cdest);
     }
-    per_branch(s, false);
+    per_branch(s, psw_addr);
 
     if (is_imm && use_goto_tb(s, dest)) {
         tcg_gen_goto_tb(0);
         tcg_gen_exit_tb(s->base.tb, 0);
-    } else if (over) {
-        tcg_gen_br(over);
     } else {
         tcg_gen_lookup_and_goto_ptr();
     }
@@ -1184,15 +1173,9 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
     if (use_goto_tb(s, s->pc_tmp)) {
         tcg_gen_goto_tb(1);
         tcg_gen_exit_tb(s->base.tb, 1);
+        return DISAS_NORETURN;
     }
-
-    if (over) {
-        gen_set_label(over);
-        return DISAS_PC_UPDATED;
-    }
-
-    tcg_gen_lookup_and_goto_ptr();
-    return DISAS_NORETURN;
+    return DISAS_PC_CC_UPDATED;
 }
 
 /* ====================================================================== */
@@ -6374,7 +6357,8 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
     }
 
 #ifndef CONFIG_USER_ONLY
-    if (s->base.tb->flags & FLAG_MASK_PER) {
+    if (s->base.tb->flags & (FLAG_MASK_PER_STORE_REAL |
+                             FLAG_MASK_PER_IFETCH)) {
         TCGv_i64 next_pc = psw_addr;
 
         if (ret == DISAS_NEXT || ret == DISAS_TOO_MANY) {
@@ -6404,7 +6388,7 @@ static void s390x_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 
     dc->cc_op = CC_OP_DYNAMIC;
     dc->ex_value = dc->base.tb->cs_base;
-    dc->exit_to_mainloop = (dc->base.tb->flags & FLAG_MASK_PER) || dc->ex_value;
+    dc->exit_to_mainloop = dc->ex_value;
 }
 
 static void s390x_tr_tb_start(DisasContextBase *db, CPUState *cs)
-- 
2.34.1


