Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C26FC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 10:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCGxo-0004hE-Qn; Wed, 29 May 2024 06:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCGxm-0004gC-OZ
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:55:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCGxj-0003Al-Ut
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716980119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0AQXYEtcVI6/Y12JuGhNhZ2X3MyKxepRUo0Y0p+OHaI=;
 b=ECIrlKf2e87LIUQMVPd/h18olTjrOBajbJkezkl9gp/QtYKb9318vP0KI99m7bqZJHRc9j
 BkIPmTxBeZG1o+Jp+cZwB5i5X43sJ6zLfbEljYItG2N92p4+auAZAG+STlA6FwZlkGCtTx
 fOvwLZffBvpMmAqMlBJvzJ5ISHmqMP8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-clv9HW3kOwiRZVwYAIjmxQ-1; Wed, 29 May 2024 06:55:15 -0400
X-MC-Unique: clv9HW3kOwiRZVwYAIjmxQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7276E8008A4;
 Wed, 29 May 2024 10:55:15 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 74DE4105480A;
 Wed, 29 May 2024 10:55:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-s390x@nongnu.org
Subject: [PULL 09/22] target/s390x: Raise exception from helper_per_branch
Date: Wed, 29 May 2024 12:54:41 +0200
Message-ID: <20240529105454.1149225-10-thuth@redhat.com>
In-Reply-To: <20240529105454.1149225-1-thuth@redhat.com>
References: <20240529105454.1149225-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Drop from argument, since gbea has always been updated with
this address.  Add ilen argument for setting int_pgm_ilen.
Use update_cc_op before calling per_branch.

By raising the exception here, we need not call
per_check_exception later, which means we can clean up the
normal non-exception branch path.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240502054417.234340-10-richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
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
index 3f94f71437..974d14703c 100644
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
index 10d5e87bb4..de029185e0 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -341,12 +341,11 @@ static void update_psw_addr(DisasContext *s)
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
@@ -635,9 +634,6 @@ static void gen_op_calc_cc(DisasContext *s)
 
 static bool use_goto_tb(DisasContext *s, uint64_t dest)
 {
-    if (unlikely(s->base.tb->flags & FLAG_MASK_PER_BRANCH)) {
-        return false;
-    }
     return translator_use_goto_tb(&s->base, dest);
 }
 
@@ -1079,37 +1075,38 @@ struct DisasInsn {
 
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
@@ -1143,12 +1140,6 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
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
@@ -1164,13 +1155,11 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
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
@@ -1182,15 +1171,9 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
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
@@ -6372,7 +6355,8 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
     }
 
 #ifndef CONFIG_USER_ONLY
-    if (s->base.tb->flags & FLAG_MASK_PER) {
+    if (s->base.tb->flags & (FLAG_MASK_PER_STORE_REAL |
+                             FLAG_MASK_PER_IFETCH)) {
         TCGv_i64 next_pc = psw_addr;
 
         if (ret == DISAS_NEXT || ret == DISAS_TOO_MANY) {
@@ -6402,7 +6386,7 @@ static void s390x_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 
     dc->cc_op = CC_OP_DYNAMIC;
     dc->ex_value = dc->base.tb->cs_base;
-    dc->exit_to_mainloop = (dc->base.tb->flags & FLAG_MASK_PER) || dc->ex_value;
+    dc->exit_to_mainloop = dc->ex_value;
 }
 
 static void s390x_tr_tb_start(DisasContextBase *db, CPUState *cs)
-- 
2.45.1


