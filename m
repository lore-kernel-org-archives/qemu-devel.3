Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED06BCCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 15:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAV9b-0002Bu-Q5; Sun, 19 Oct 2025 11:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vAV9a-00028o-Bs
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:17:02 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vAV9Y-0003Eq-Io
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:17:02 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 7BF9060A7F
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 17:16:59 +0200 (CEST)
Received: (qmail 23740 invoked by uid 990); 19 Oct 2025 15:16:59 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 19 Oct 2025 17:16:54 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs)
Subject: [PATCH v8 18/25] target/s390x: call plugin trap callbacks
Date: Sun, 19 Oct 2025 17:15:07 +0200
Message-ID: <50a092042a41f7d679df2b6577edcba1d9316829.1760884672.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1760884672.git.neither@nut.email>
References: <cover.1760884672.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.999997) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.599997
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=MB5bvnHFgmS+fBJ+/9N5X6Ag5ih3ShqfcmYaYHxgf6k=;
 b=WKGxSwP5lmDVTVv+oDe62cZpTtbrxBYLeMlg2QqhaeBk9llk3//uOfhxpqI/Uee1ovidGXoce5
 l6S2i/GQLNcibbInkREuxz8RI7I0AVUHqA/V+NCZtohcegYrGqZtxAKRFQxpZ7tJsDSENJzqLnII
 Gs3z3Z77sxXfV6olvAnyTEspHbjeEobsmKLy2XQFlfFj9P3H7oSk4uRucl5ad/gSPyyCDE20Cpuu
 JPb1ROlhS3rTLhycbnflglPYMZmK4cz0xUik3/VMYp+bQOedpzq4EAyD1DL5JYIM595RmiuBEjQE
 wbzIGeJpMq5lm6aLkUpb/4DQn055Wi64oTXP4K63bVOijisvmKvE4HHdlvxnk1uetc99cruQcnC1
 iWNCpb+pISensAk3E6f+XFW8kTTqpWEx84N1llC+HHAwdZIEVedkjkpyAhlyzL/SzkeyK4Dpvj0q
 HHBugGNxUC2VAIOZlYLxb+lc9/qSvSQvmRsRhl8JKhhRsumwCaH8/frq4z6hAE6HW7bIMGih5xlS
 C7Vz0OtpEVdrvn31V4OHwTYak+0MB4U7NsiOMAi+TLURZNepI1xHqcN3b5qbU1LuLJktCl6j1Qp5
 RVUKQGOTgy4dyELZUrWqXYdqcFLxQijzypXGxqo2f7WkTxlzpTgFcooSXNvtiDWBzN5XkFCk2nkN
 8=
Received-SPF: pass client-ip=2001:1a50:11:0:c83f:a8ff:fea6:c8da;
 envelope-from=neither@nut.email; helo=mailgate01.uberspace.is
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

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places hooks for IBM System/390 targets. We treat "program
interrupts" and service calls as exceptions. We treat external and io
"exceptions" as well as resets as interrupts.

Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/s390x/tcg/excp_helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index 0ae4e26606..c6641280bc 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -35,6 +35,7 @@
 #include "hw/s390x/s390_flic.h"
 #include "hw/boards.h"
 #endif
+#include "qemu/plugin.h"
 
 G_NORETURN void tcg_s390_program_interrupt(CPUS390XState *env,
                                            uint32_t code, uintptr_t ra)
@@ -502,6 +503,7 @@ void s390_cpu_do_interrupt(CPUState *cs)
     S390CPU *cpu = S390_CPU(cs);
     CPUS390XState *env = &cpu->env;
     bool stopped = false;
+    uint64_t last_pc = cpu->env.psw.addr;
 
     qemu_log_mask(CPU_LOG_INT, "%s: %d at psw=%" PRIx64 ":%" PRIx64 "\n",
                   __func__, cs->exception_index, env->psw.mask, env->psw.addr);
@@ -531,21 +533,27 @@ try_deliver:
     switch (cs->exception_index) {
     case EXCP_PGM:
         do_program_interrupt(env);
+        qemu_plugin_vcpu_exception_cb(cs, last_pc);
         break;
     case EXCP_SVC:
         do_svc_interrupt(env);
+        qemu_plugin_vcpu_exception_cb(cs, last_pc);
         break;
     case EXCP_EXT:
         do_ext_interrupt(env);
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
         break;
     case EXCP_IO:
         do_io_interrupt(env);
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
         break;
     case EXCP_MCHK:
         do_mchk_interrupt(env);
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
         break;
     case EXCP_RESTART:
         do_restart_interrupt(env);
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
         break;
     case EXCP_STOP:
         do_stop_interrupt(env);
-- 
2.49.1


