Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B94C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 15:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH2IS-00070M-CR; Mon, 19 May 2025 11:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uH2IQ-0006zk-9Q
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:20:54 -0400
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uH2IN-0005VR-6M
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:20:53 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 82A53180EB0
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 17:20:28 +0200 (CEST)
Received: (qmail 1668 invoked by uid 990); 19 May 2025 15:20:28 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 19 May 2025 17:20:28 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v5 22/25] target/xtensa: call plugin trap callbacks
Date: Mon, 19 May 2025 17:20:02 +0200
Message-ID: <27ecbe19c5e2c39166f050754a30249de573d635.1747666625.git.neither@nut.email>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747666625.git.neither@nut.email>
References: <cover.1747666625.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.999597) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.599597
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=pn68r0uYyRci5PiYa0KzEBE+m3ljCBB7beZPQsIx0i0=;
 b=ERg8TJe9nvxmUtb8eEihO5XkBTRiEbsrRZ00Z1JmqEYeEbIrRdlnW1wMnIeVhWhOms66jNr/bV
 21aMNJk6n/Wd5HT6RTCYBZxYwLF2Pf0S3tGyJKHM2LZinCUr5yG8nK2NFB0qBumQSvo0AZliw/h5
 7NROapPWov64AnRb1jk0R+U82qJwvwV1SZL28QNEBv0IjP7R+ONDtgW/mUQYDSXcRqCdj8SsXu6W
 iW0X0mPN5bbvOhDSGUyKmeu/u5QKecjXDnaAJapxRMoUqUtoP4ddAmnvtf0ymASicoUApX/rV0Pw
 czzevzTqYNrSaGLqa0QgHuEpT5qok2F2yAFuKAoKq3sC/Exgors/vNMkVqMwNYn7/qaorTvR3PIA
 m0oqn4zpv2Zz9yHf4x3DLF0nDOK24df4Zt9xWAeaz0kifr8wHeG1APk5lRMg2s6QqO1LGWOcl0wr
 RljBVCcSAmEVSJ+zZvLulL2XhEwg0Q1v9A4oO+kWcbBS5WdjeIgF2X/q1CO6vVt5Hp0toyX0SWA/
 BUvGWHNE+OUCnTGJM+rrzt8XQO+c6IQ6INdqTrNc3bZSbkRuDnVtJJRVTvU2XgR3nau8xUnjomWM
 hzWXbJXCuFcovyvsRdsTbwIZAH7t0dquCRmrdzmCPxE7KwVrIqV8cfi5QBk2Jh21LPtO5RATDNFO
 Q=
Received-SPF: pass client-ip=2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4;
 envelope-from=neither@nut.email; helo=mailgate02.uberspace.is
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

This change places hooks for xtensa targets.

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/xtensa/exc_helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
index b611c9bf97..fdc522698d 100644
--- a/target/xtensa/exc_helper.c
+++ b/target/xtensa/exc_helper.c
@@ -32,6 +32,7 @@
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
 #include "qemu/atomic.h"
+#include "qemu/plugin.h"
 
 void HELPER(exception)(CPUXtensaState *env, uint32_t excp)
 {
@@ -207,6 +208,8 @@ void xtensa_cpu_do_interrupt(CPUState *cs)
     CPUXtensaState *env = cpu_env(cs);
 
     if (cs->exception_index == EXC_IRQ) {
+        uint64_t last_pc = env->pc;
+
         qemu_log_mask(CPU_LOG_INT,
                       "%s(EXC_IRQ) level = %d, cintlevel = %d, "
                       "pc = %08x, a0 = %08x, ps = %08x, "
@@ -218,6 +221,7 @@ void xtensa_cpu_do_interrupt(CPUState *cs)
                       env->sregs[INTSET], env->sregs[INTENABLE],
                       env->sregs[CCOUNT]);
         handle_interrupt(env);
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
     }
 
     switch (cs->exception_index) {
@@ -238,9 +242,11 @@ void xtensa_cpu_do_interrupt(CPUState *cs)
                       env->sregs[CCOUNT]);
         if (env->config->exception_vector[cs->exception_index]) {
             uint32_t vector;
+            uint64_t last_pc = env->pc;
 
             vector = env->config->exception_vector[cs->exception_index];
             env->pc = relocated_vector(env, vector);
+            qemu_plugin_vcpu_exception_cb(cs, last_pc);
         } else {
             qemu_log_mask(CPU_LOG_INT,
                           "%s(pc = %08x) bad exception_index: %d\n",
-- 
2.49.0


