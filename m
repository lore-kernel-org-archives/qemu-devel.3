Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D169C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 10:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCGxi-0004d1-6T; Wed, 29 May 2024 06:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCGxe-0004b0-E0
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:55:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCGxc-000392-Hx
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716980111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0hGgy6Hp9s9MqVRuTqz+IGZjvh9B+VjQjOFSX8Q6f4I=;
 b=NtJiE1GekRxyoYU/OL+0/poRqY96Put3ue/ny7m8NK0XobfPI9uGdk/g0vG4PR49Yi7qDp
 34Dgx0IGFjhNNHgxl1OGXB7Zw+oMzxWOlbaNh1scyqp0yD/xS+DemU9VOz/iCx8ExKhFVX
 WACu1kr5dsqbiQHRWRgpmMNk8DMwF3U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-NzkeJLNHNN-UBRBq_09Urg-1; Wed, 29 May 2024 06:55:09 -0400
X-MC-Unique: NzkeJLNHNN-UBRBq_09Urg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FBA4857A81;
 Wed, 29 May 2024 10:55:09 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC890105480A;
 Wed, 29 May 2024 10:55:07 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-s390x@nongnu.org,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 07/22] target/s390x: Simplify help_branch
Date: Wed, 29 May 2024 12:54:39 +0200
Message-ID: <20240529105454.1149225-8-thuth@redhat.com>
In-Reply-To: <20240529105454.1149225-1-thuth@redhat.com>
References: <20240529105454.1149225-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

Always use a tcg branch, instead of movcond.  The movcond
was not a bad idea before PER was added, but since then
we have either 2 or 3 actions to perform on each leg of
the branch, and multiple movcond is inefficient.

Reorder the taken branch to be fallthrough of the tcg branch.

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240502054417.234340-8-richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/tcg/translate.c | 152 ++++++++++++-----------------------
 1 file changed, 50 insertions(+), 102 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 7ae928c3b0..78066aaf84 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -353,25 +353,6 @@ static void per_branch(DisasContext *s, bool to_next)
 #endif
 }
 
-static void per_branch_cond(DisasContext *s, TCGCond cond,
-                            TCGv_i64 arg1, TCGv_i64 arg2)
-{
-#ifndef CONFIG_USER_ONLY
-    if (s->base.tb->flags & FLAG_MASK_PER_BRANCH) {
-        TCGLabel *lab = gen_new_label();
-        tcg_gen_brcond_i64(tcg_invert_cond(cond), arg1, arg2, lab);
-
-        tcg_gen_movi_i64(gbea, s->base.pc_next);
-        gen_helper_per_branch(tcg_env, gbea, psw_addr);
-
-        gen_set_label(lab);
-    } else {
-        TCGv_i64 pc = tcg_constant_i64(s->base.pc_next);
-        tcg_gen_movcond_i64(cond, gbea, arg1, arg2, gbea, pc);
-    }
-#endif
-}
-
 static void per_breaking_event(DisasContext *s)
 {
     tcg_gen_movi_i64(gbea, s->base.pc_next);
@@ -1128,14 +1109,12 @@ static DisasJumpType help_goto_indirect(DisasContext *s, TCGv_i64 dest)
 static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
                                  bool is_imm, int imm, TCGv_i64 cdest)
 {
-    DisasJumpType ret;
     uint64_t dest = s->base.pc_next + (int64_t)imm * 2;
-    TCGLabel *lab;
+    TCGLabel *lab, *over;
 
     /* Take care of the special cases first.  */
     if (c->cond == TCG_COND_NEVER) {
-        ret = DISAS_NEXT;
-        goto egress;
+        return DISAS_NEXT;
     }
     if (is_imm) {
         /*
@@ -1145,104 +1124,73 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
         if (c->cond == TCG_COND_ALWAYS
             || (dest == s->pc_tmp &&
                 !(s->base.tb->flags & FLAG_MASK_PER_BRANCH))) {
-            ret = help_goto_direct(s, dest);
-            goto egress;
+            return help_goto_direct(s, dest);
         }
     } else {
         if (!cdest) {
             /* E.g. bcr %r0 -> no branch.  */
-            ret = DISAS_NEXT;
-            goto egress;
+            return DISAS_NEXT;
         }
         if (c->cond == TCG_COND_ALWAYS) {
-            ret = help_goto_indirect(s, cdest);
-            goto egress;
+            return help_goto_indirect(s, cdest);
         }
     }
 
-    if (use_goto_tb(s, s->pc_tmp)) {
-        if (is_imm && use_goto_tb(s, dest)) {
-            /* Both exits can use goto_tb.  */
-            update_cc_op(s);
-
-            lab = gen_new_label();
-            if (c->is_64) {
-                tcg_gen_brcond_i64(c->cond, c->u.s64.a, c->u.s64.b, lab);
-            } else {
-                tcg_gen_brcond_i32(c->cond, c->u.s32.a, c->u.s32.b, lab);
-            }
-
-            /* Branch not taken.  */
-            tcg_gen_goto_tb(0);
-            tcg_gen_movi_i64(psw_addr, s->pc_tmp);
-            tcg_gen_exit_tb(s->base.tb, 0);
-
-            /* Branch taken.  */
-            gen_set_label(lab);
-            per_breaking_event(s);
-            tcg_gen_goto_tb(1);
-            tcg_gen_movi_i64(psw_addr, dest);
-            tcg_gen_exit_tb(s->base.tb, 1);
+    update_cc_op(s);
 
-            ret = DISAS_NORETURN;
-        } else {
-            /* Fallthru can use goto_tb, but taken branch cannot.  */
-            /* Store taken branch destination before the brcond.  This
-               avoids having to allocate a new local temp to hold it.
-               We'll overwrite this in the not taken case anyway.  */
-            if (!is_imm) {
-                tcg_gen_mov_i64(psw_addr, cdest);
-            }
+    /*
+     * Ensure the taken branch is fall-through of the tcg branch.
+     * This keeps @cdest usage within the extended basic block,
+     * which avoids an otherwise unnecessary spill to the stack.
+     */
+    lab = gen_new_label();
+    if (s->base.tb->flags & FLAG_MASK_PER_BRANCH) {
+        over = gen_new_label();
+    } else {
+        over = NULL;
+    }
 
-            lab = gen_new_label();
-            if (c->is_64) {
-                tcg_gen_brcond_i64(c->cond, c->u.s64.a, c->u.s64.b, lab);
-            } else {
-                tcg_gen_brcond_i32(c->cond, c->u.s32.a, c->u.s32.b, lab);
-            }
+    if (c->is_64) {
+        tcg_gen_brcond_i64(tcg_invert_cond(c->cond),
+                           c->u.s64.a, c->u.s64.b, lab);
+    } else {
+        tcg_gen_brcond_i32(tcg_invert_cond(c->cond),
+                           c->u.s32.a, c->u.s32.b, lab);
+    }
 
-            /* Branch not taken.  */
-            update_cc_op(s);
-            tcg_gen_goto_tb(0);
-            tcg_gen_movi_i64(psw_addr, s->pc_tmp);
-            tcg_gen_exit_tb(s->base.tb, 0);
+    /* Branch taken.  */
+    if (is_imm) {
+        tcg_gen_movi_i64(psw_addr, dest);
+    } else {
+        tcg_gen_mov_i64(psw_addr, cdest);
+    }
+    per_branch(s, false);
 
-            gen_set_label(lab);
-            if (is_imm) {
-                tcg_gen_movi_i64(psw_addr, dest);
-            }
-            per_breaking_event(s);
-            ret = DISAS_PC_UPDATED;
-        }
+    if (is_imm && use_goto_tb(s, dest)) {
+        tcg_gen_goto_tb(0);
+        tcg_gen_exit_tb(s->base.tb, 0);
+    } else if (over) {
+        tcg_gen_br(over);
     } else {
-        /* Fallthru cannot use goto_tb.  This by itself is vanishingly rare.
-           Most commonly we're single-stepping or some other condition that
-           disables all use of goto_tb.  Just update the PC and exit.  */
+        tcg_gen_lookup_and_goto_ptr();
+    }
 
-        TCGv_i64 next = tcg_constant_i64(s->pc_tmp);
-        if (is_imm) {
-            cdest = tcg_constant_i64(dest);
-        }
+    gen_set_label(lab);
 
-        if (c->is_64) {
-            tcg_gen_movcond_i64(c->cond, psw_addr, c->u.s64.a, c->u.s64.b,
-                                cdest, next);
-            per_branch_cond(s, c->cond, c->u.s64.a, c->u.s64.b);
-        } else {
-            TCGv_i32 t0 = tcg_temp_new_i32();
-            TCGv_i64 t1 = tcg_temp_new_i64();
-            TCGv_i64 z = tcg_constant_i64(0);
-            tcg_gen_setcond_i32(c->cond, t0, c->u.s32.a, c->u.s32.b);
-            tcg_gen_extu_i32_i64(t1, t0);
-            tcg_gen_movcond_i64(TCG_COND_NE, psw_addr, t1, z, cdest, next);
-            per_branch_cond(s, TCG_COND_NE, t1, z);
-        }
+    /* Branch not taken.  */
+    tcg_gen_movi_i64(psw_addr, s->pc_tmp);
+    if (use_goto_tb(s, s->pc_tmp)) {
+        tcg_gen_goto_tb(1);
+        tcg_gen_exit_tb(s->base.tb, 1);
+    }
 
-        ret = DISAS_PC_UPDATED;
+    if (over) {
+        gen_set_label(over);
+        return DISAS_PC_UPDATED;
     }
 
- egress:
-    return ret;
+    tcg_gen_lookup_and_goto_ptr();
+    return DISAS_NORETURN;
 }
 
 /* ====================================================================== */
-- 
2.45.1


