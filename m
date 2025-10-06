Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF1ACCA471
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 10:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5i0u-00023J-7S; Mon, 06 Oct 2025 06:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v5i0P-0001WB-Rz
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 05:59:46 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v5i0N-000412-Qn
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 05:59:45 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 3DD6060B8E
 for <qemu-devel@nongnu.org>; Mon,  6 Oct 2025 11:59:42 +0200 (CEST)
Received: (qmail 20993 invoked by uid 990); 6 Oct 2025 09:59:42 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 06 Oct 2025 11:59:42 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v7 22/25] target/xtensa: call plugin trap callbacks
Date: Mon,  6 Oct 2025 11:59:17 +0200
Message-ID: <1ea18c5c484ca0c1fc11738a3033cdacff3296e3.1759744337.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1759744337.git.neither@nut.email>
References: <cover.1759744337.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.999997) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.599997
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=4qMKxbL61NUaVuIspdY/J81NXPxh6lWuOHZ6cGQg8/w=;
 b=oe6i21s71975NDLuIwPvsELwPmDgk7DbtCxZimmROzXHgDeoDa/mJFfCWrgE6L81cLiVqAgtpB
 zFbWIuib7HVXvg1aCkc18jnSsWDpWPJEXgEoSI5NWKYqEu844xUs+dEiCief8kpNQfevvWAYPc67
 LxOaFq+T1mmvf4coqwxyimSubWfQuoTTF2WK1MoKD/vW5K0kGExiBZprWfrPRRN4wFuIpBNSosu0
 3bmiIbJ98nHaexUYNa5hTz6laK2h6RKJ2juUA+Cw0S3e+VUALYb7ygbgamqJmcm/UrvdejFZRPd1
 H88gb66AP0Fcv6hBQnlmprB73b/VUqZlALFk4kLRn1j2JMR5sK7mgCLrSLLNkSjZcPm/mYUSDA2w
 4vpYTzOs7lh4z/WnmNXkzrtBVD+bevJsHFKikUboGMbvJkT7T/KKPkuaw67yzZBIxxP3hoXajv1u
 uUHlQEobQsGULH41GGLgiWnICkuPW4Mb9C447Aia10Kt5jt+ex1g2l2FvIHJU+XWcDp/Tg6nBG1b
 zJdFOTf+BZH9gnx7CFuo6qqPOEJuyd1eQO2iWElwsIdTMVB2Co4vSPKM3ZaHfYxx97zZc7geLdbA
 +MYvrPu1f1xevIUfFOx/p8G9btgVojyaDN3o0SnxVbJQj+zhr3wUD3ft5gX4NWvePHbWhsQ+F8NT
 w=
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

This change places hooks for xtensa targets.

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/xtensa/exc_helper.c  | 6 ++++++
 target/xtensa/xtensa-semi.c | 3 +++
 2 files changed, 9 insertions(+)

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
diff --git a/target/xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
index 636f421da2..129749c92d 100644
--- a/target/xtensa/xtensa-semi.c
+++ b/target/xtensa/xtensa-semi.c
@@ -34,6 +34,7 @@
 #include "semihosting/uaccess.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
+#include "qemu/plugin.h"
 
 enum {
     TARGET_SYS_exit = 1,
@@ -194,6 +195,7 @@ void HELPER(simcall)(CPUXtensaState *env)
 {
     CPUState *cs = env_cpu(env);
     uint32_t *regs = env->regs;
+    uint64_t last_pc = env->pc;
 
     switch (regs[2]) {
     case TARGET_SYS_exit:
@@ -430,4 +432,5 @@ void HELPER(simcall)(CPUXtensaState *env)
         regs[3] = TARGET_ENOSYS;
         break;
     }
+    qemu_plugin_vcpu_hostcall_cb(cs, last_pc);
 }
-- 
2.49.1


