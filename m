Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01428C27C43
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 10:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCGxt-0004jg-21; Wed, 29 May 2024 06:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCGxr-0004ix-D8
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:55:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCGxp-0003Fw-Jw
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716980124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ivIpsfOlJxFdI0h0TITtXjCjV49diKYNRKwCuXImVts=;
 b=ecWy6084i+p9MPPDe92eS18UQ7HhgcmjdHWfEXMTBgyeEazl6e4Vwj17lnKptH5D0xY0y+
 mv4fMjBO9CXj6/r6Mb56NNlO+fkhz8KYeyCeii5TyFN1CLktRuletb+igguK1C2aCr3PYk
 odryJpYtdOLyagYVTK5fkco7CJoWBoA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-6IvZQDQQM9yfccyyo_oMbg-1; Wed, 29 May 2024 06:55:21 -0400
X-MC-Unique: 6IvZQDQQM9yfccyyo_oMbg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA19B800169;
 Wed, 29 May 2024 10:55:20 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 44BFE105480A;
 Wed, 29 May 2024 10:55:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-s390x@nongnu.org
Subject: [PULL 12/22] target/s390x: Simplify per_ifetch, per_check_exception
Date: Wed, 29 May 2024 12:54:44 +0200
Message-ID: <20240529105454.1149225-13-thuth@redhat.com>
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
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Set per_address and ilen in per_ifetch; this is valid for
all PER exceptions and will last until the end of the
instruction.  Therefore we don't need to give the same
data to per_check_exception.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240502054417.234340-13-richard.henderson@linaro.org>
[thuth: Silence checkpatch.pl errors]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/helper.h          |  4 ++--
 target/s390x/tcg/misc_helper.c | 23 +++++++++--------------
 target/s390x/tcg/translate.c   | 20 ++++++++++++--------
 3 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 31bd193322..1a8a76abb9 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -359,9 +359,9 @@ DEF_HELPER_FLAGS_4(ipte, TCG_CALL_NO_RWG, void, env, i64, i64, i32)
 DEF_HELPER_FLAGS_1(ptlb, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_1(purge, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_3(lra, i64, env, i64, i64)
-DEF_HELPER_FLAGS_3(per_check_exception, TCG_CALL_NO_WG, void, env, i64, i32)
+DEF_HELPER_FLAGS_1(per_check_exception, TCG_CALL_NO_WG, void, env)
 DEF_HELPER_FLAGS_3(per_branch, TCG_CALL_NO_WG, void, env, i64, i32)
-DEF_HELPER_FLAGS_2(per_ifetch, TCG_CALL_NO_WG, void, env, i64)
+DEF_HELPER_FLAGS_2(per_ifetch, TCG_CALL_NO_WG, void, env, i32)
 DEF_HELPER_FLAGS_2(per_store_real, TCG_CALL_NO_WG, noreturn, env, i32)
 DEF_HELPER_FLAGS_1(stfl, TCG_CALL_NO_RWG, void, env)
 
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 43cacc448f..303f86d363 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -604,12 +604,10 @@ static G_NORETURN void per_raise_exception_log(CPUS390XState *env)
     per_raise_exception(env);
 }
 
-void HELPER(per_check_exception)(CPUS390XState *env, uint64_t next_pc,
-                                 uint32_t ilen)
+void HELPER(per_check_exception)(CPUS390XState *env)
 {
+    /* psw_addr, per_address and int_pgm_ilen are already set. */
     if (unlikely(env->per_perc_atmid)) {
-        env->psw.addr = next_pc;
-        env->int_pgm_ilen = ilen;
         per_raise_exception_log(env);
     }
 }
@@ -639,23 +637,20 @@ void HELPER(per_branch)(CPUS390XState *env, uint64_t dest, uint32_t ilen)
     per_raise_exception_log(env);
 }
 
-void HELPER(per_ifetch)(CPUS390XState *env, uint64_t addr)
+void HELPER(per_ifetch)(CPUS390XState *env, uint32_t ilen)
 {
-    if (get_per_in_range(env, addr)) {
-        env->per_address = addr;
+    if (get_per_in_range(env, env->psw.addr)) {
+        env->per_address = env->psw.addr;
+        env->int_pgm_ilen = ilen;
         env->per_perc_atmid = PER_CODE_EVENT_IFETCH | get_per_atmid(env);
 
         /* If the instruction has to be nullified, trigger the
            exception immediately. */
         if (env->cregs[9] & PER_CR9_EVENT_IFETCH_NULLIFICATION) {
-            CPUState *cs = env_cpu(env);
-
             env->per_perc_atmid |= PER_CODE_EVENT_NULLIFICATION;
-            env->int_pgm_code = PGM_PER;
-            env->int_pgm_ilen = get_ilen(cpu_ldub_code(env, addr));
-
-            cs->exception_index = EXCP_PGM;
-            cpu_loop_exit(cs);
+            qemu_log_mask(CPU_LOG_INT, "PER interrupt before 0x%" PRIx64 "\n",
+                          env->per_address);
+            per_raise_exception(env);
         }
     }
 }
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 5bb15a46e0..c9a5a1687e 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -6258,8 +6258,8 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
 
 #ifndef CONFIG_USER_ONLY
     if (s->base.tb->flags & FLAG_MASK_PER_IFETCH) {
-        TCGv_i64 addr = tcg_constant_i64(s->base.pc_next);
-        gen_helper_per_ifetch(tcg_env, addr);
+        /* With ifetch set, psw_addr and cc_op are always up-to-date. */
+        gen_helper_per_ifetch(tcg_env, tcg_constant_i32(s->ilen));
     }
 #endif
 
@@ -6358,14 +6358,18 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
 
 #ifndef CONFIG_USER_ONLY
     if (s->base.tb->flags & FLAG_MASK_PER_IFETCH) {
-        TCGv_i64 next_pc = psw_addr;
-
-        if (ret == DISAS_NEXT || ret == DISAS_TOO_MANY) {
-            next_pc = tcg_constant_i64(s->pc_tmp);
+        switch (ret) {
+        case DISAS_TOO_MANY:
+            s->base.is_jmp = DISAS_PC_CC_UPDATED;
+            /* fall through */
+        case DISAS_NEXT:
+            tcg_gen_movi_i64(psw_addr, s->pc_tmp);
+            break;
+        default:
+            break;
         }
         update_cc_op(s);
-        gen_helper_per_check_exception(tcg_env, next_pc,
-                                       tcg_constant_i32(s->ilen));
+        gen_helper_per_check_exception(tcg_env);
     }
 #endif
 
-- 
2.45.1


