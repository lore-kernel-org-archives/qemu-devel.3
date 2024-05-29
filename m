Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6555BC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 10:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCGxV-0004Vx-M1; Wed, 29 May 2024 06:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCGxU-0004V2-96
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:55:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCGxR-0002rX-3P
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716980099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jxtqb3KCTt/uxYgnly+d0TkxchgWDpeC0Swp2evxboU=;
 b=TQEayn8DS3UMOwr7pbZLGldlB2BJZhSeoUgzlMzySr+3rc0jlpppfgOAL+F2cXeDfo1T6B
 AqtkgW6wkaDsu+N0x3B1vWCRK0DNzsEZ00mUqkxlr/TdTRvFExYLI46n+HEnGNsYsUpcGd
 HCM01ejiw4vDWIEq1ytM1461uuzKBwg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-WFTVp9yhP3CBz5hE_3Sixw-1; Wed, 29 May 2024 06:54:57 -0400
X-MC-Unique: WFTVp9yhP3CBz5hE_3Sixw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A632101A52C;
 Wed, 29 May 2024 10:54:57 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B63B9105480A;
 Wed, 29 May 2024 10:54:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-s390x@nongnu.org,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 01/22] target/s390x: Do not use unwind for per_check_exception
Date: Wed, 29 May 2024 12:54:33 +0200
Message-ID: <20240529105454.1149225-2-thuth@redhat.com>
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

Using exception unwind via tcg_s390_program_interrupt,
we discard the current value of psw.addr, which discards
the result of a branch.

Pass in the address of the next instruction, which may
not be sequential.  Pass in ilen, which we would have
gotten from unwind and is passed to the exception handler.
Sync cc_op before the call, which we would have gotten
from unwind.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20240502054417.234340-2-richard.henderson@linaro.org>
[thuth: Silence checkpatch.pl errors]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/helper.h          |  2 +-
 target/s390x/tcg/excp_helper.c |  2 +-
 target/s390x/tcg/misc_helper.c | 23 ++++++++++++++++++++---
 target/s390x/tcg/translate.c   | 11 ++++++-----
 4 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index cc1c20e9e3..96ab71e877 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -359,7 +359,7 @@ DEF_HELPER_FLAGS_4(ipte, TCG_CALL_NO_RWG, void, env, i64, i64, i32)
 DEF_HELPER_FLAGS_1(ptlb, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_1(purge, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_3(lra, i64, env, i64, i64)
-DEF_HELPER_1(per_check_exception, void, env)
+DEF_HELPER_FLAGS_3(per_check_exception, TCG_CALL_NO_WG, void, env, i64, i32)
 DEF_HELPER_FLAGS_3(per_branch, TCG_CALL_NO_RWG, void, env, i64, i64)
 DEF_HELPER_FLAGS_2(per_ifetch, TCG_CALL_NO_RWG, void, env, i64)
 DEF_HELPER_FLAGS_1(per_store_real, TCG_CALL_NO_RWG, void, env)
diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index f1c33f7967..4c0b692c9e 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -209,7 +209,7 @@ static void do_program_interrupt(CPUS390XState *env)
 
     switch (env->int_pgm_code) {
     case PGM_PER:
-        advance = !(env->per_perc_atmid & PER_CODE_EVENT_NULLIFICATION);
+        /* advance already handled */
         break;
     case PGM_ASCE_TYPE:
     case PGM_REG_FIRST_TRANS:
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 8764846ce8..7c94468392 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
+#include "qemu/log.h"
 #include "cpu.h"
 #include "s390x-internal.h"
 #include "qemu/host-utils.h"
@@ -590,10 +591,26 @@ void HELPER(chsc)(CPUS390XState *env, uint64_t inst)
 #endif
 
 #ifndef CONFIG_USER_ONLY
-void HELPER(per_check_exception)(CPUS390XState *env)
+static G_NORETURN void per_raise_exception(CPUS390XState *env)
 {
-    if (env->per_perc_atmid) {
-        tcg_s390_program_interrupt(env, PGM_PER, GETPC());
+    trigger_pgm_exception(env, PGM_PER);
+    cpu_loop_exit(env_cpu(env));
+}
+
+static G_NORETURN void per_raise_exception_log(CPUS390XState *env)
+{
+    qemu_log_mask(CPU_LOG_INT, "PER interrupt after 0x%" PRIx64 "\n",
+                  env->per_address);
+    per_raise_exception(env);
+}
+
+void HELPER(per_check_exception)(CPUS390XState *env, uint64_t next_pc,
+                                 uint32_t ilen)
+{
+    if (unlikely(env->per_perc_atmid)) {
+        env->psw.addr = next_pc;
+        env->int_pgm_ilen = ilen;
+        per_raise_exception_log(env);
     }
 }
 
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index ebd96abe6c..4c3ff1931b 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -6424,13 +6424,14 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
 
 #ifndef CONFIG_USER_ONLY
     if (s->base.tb->flags & FLAG_MASK_PER) {
-        /* An exception might be triggered, save PSW if not already done.  */
+        TCGv_i64 next_pc = psw_addr;
+
         if (ret == DISAS_NEXT || ret == DISAS_TOO_MANY) {
-            tcg_gen_movi_i64(psw_addr, s->pc_tmp);
+            next_pc = tcg_constant_i64(s->pc_tmp);
         }
-
-        /* Call the helper to check for a possible PER exception.  */
-        gen_helper_per_check_exception(tcg_env);
+        update_cc_op(s);
+        gen_helper_per_check_exception(tcg_env, next_pc,
+                                       tcg_constant_i32(s->ilen));
     }
 #endif
 
-- 
2.45.1


