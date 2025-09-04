Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997FECA1012
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 20:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuGsK-0003bA-Gq; Thu, 04 Sep 2025 16:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uuGsH-0003ae-DU
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 16:48:05 -0400
Received: from mailgate01.uberspace.is ([95.143.172.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uuGsA-0000l6-En
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 16:48:05 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 8074F60C1D
 for <qemu-devel@nongnu.org>; Thu,  4 Sep 2025 22:47:24 +0200 (CEST)
Received: (qmail 306 invoked by uid 990); 4 Sep 2025 20:47:24 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Thu, 04 Sep 2025 22:47:24 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs)
Subject: [PATCH v6 18/25] target/s390x: call plugin trap callbacks
Date: Thu,  4 Sep 2025 22:46:55 +0200
Message-ID: <f62e2f79a77662adfd698cc18e77df25f3f42e40.1757018626.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1757018626.git.neither@nut.email>
References: <cover.1757018626.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.988624) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.588624
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=1hZaVZ2wXGmnvpC0qbaET9P8RsuJHC7UzYbRbJo3OJU=;
 b=ce4KNFJpWfQiC6c9EqRrT1qlxqxnZ0NyHSIVf5S/BwZzetN7vncfmwU57jo20SbAMo6pCy4rjd
 QSRVeNZH6NecRtcH5ZW/DTTpugZHFRIaIYdrA3kKyybJG8u5nO3mqxP8sW7tDyAzkIpb5c+13Mmd
 X42V1TM441UKXGqsIysjYCwuJj7jdC6p/irSPPxuDrA0UIKP7G27VMvqWRtMA0GK6LcCXY7UuJqT
 Oa/nZw0z3Z7XllC+TbrWIiQvC/dKS/PDdLLAB9nFVbHlszkvegUXVPM7yCydDr4Q+wSjq/lo6KHO
 Mr/CNLACIpYOVcqmDZn5p3tGCUJGpVUu+70ouV9U7VaIOGeD8Mw6m+ZnG7U2xHU4f2SCdi8hiiQ3
 KA9GvSZ9ZywLAp4zGQ2G/Fjc59EnUhhSIVIL4XMnSu7npQZN6YzUswNX6dIoG96FRcYe5FmJ0xPu
 9SxOytwbTLG8xQbay/eFbk6mJVMY3Htf9UQn+SSX10utCksbmtjbod6lF6JVgmE1Y9jSStKDaBRs
 zwGbCxDH+YZwnO06iSprOK1N2bwphMCce/Ldsx6+7dAT0MjXhbQCxpNsPeSWqogm3Wg0cAypiDxz
 afUX1sK5L7Z7xFp4nZ0f702kSTh8unxAhwzuKziQOmh07lnchpl5d8z4+OlR0/U9kf+cFzPYOqKf
 k=
Received-SPF: pass client-ip=95.143.172.20; envelope-from=neither@nut.email;
 helo=mailgate01.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index e4c75d0ce0..b7e7a4deff 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -34,6 +34,7 @@
 #include "hw/s390x/s390_flic.h"
 #include "hw/boards.h"
 #endif
+#include "qemu/plugin.h"
 
 G_NORETURN void tcg_s390_program_interrupt(CPUS390XState *env,
                                            uint32_t code, uintptr_t ra)
@@ -499,6 +500,7 @@ void s390_cpu_do_interrupt(CPUState *cs)
     S390CPU *cpu = S390_CPU(cs);
     CPUS390XState *env = &cpu->env;
     bool stopped = false;
+    uint64_t last_pc = cpu->env.psw.addr;
 
     qemu_log_mask(CPU_LOG_INT, "%s: %d at psw=%" PRIx64 ":%" PRIx64 "\n",
                   __func__, cs->exception_index, env->psw.mask, env->psw.addr);
@@ -528,21 +530,27 @@ try_deliver:
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


