Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0D6CCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 15:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAVBf-0000G9-Rs; Sun, 19 Oct 2025 11:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vAVBd-0008PB-CV
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:19:09 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vAVBa-0003UM-Uh
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:19:09 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 7E87960ACD
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 17:19:05 +0200 (CEST)
Received: (qmail 26144 invoked by uid 990); 19 Oct 2025 15:19:05 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 19 Oct 2025 17:19:01 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v8 22/25] target/xtensa: call plugin trap callbacks
Date: Sun, 19 Oct 2025 17:18:41 +0200
Message-ID: <5edba4fa416c9904a874ff5bee604735c3436f65.1760884672.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1760884672.git.neither@nut.email>
References: <cover.1760884672.git.neither@nut.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ------
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.999999) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1)
X-Rspamd-Score: -6.099999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=E+G7Ee9WEmlRuvyZYhqKemGENWoKiIcB983rZ31V8I8=;
 b=sTG8ltaEsyA5Ht8tAFzMzDr1aJQuqkehAahN8Knapqe8v+L402fogDQShufNtAOq6kmRCiM4VJ
 vfzm4oG7RNBZ5j31Glj2zHZCHo6X17y0PywcEn1BWE9vIzuRKN0JsdpLDddgZJfnew8uICBpG0NT
 YfIVgFSKmyqVUYkI3z9oHXaXMoCgat4xvvjTC46oEG7OplgrNe6tPKHudhxXZmCiKM5a4m3LRrgv
 9dvau3KG1xbqbSLMFbEstwsmb02CGYEYfonYYSPQ8yEVk5JjtFh8OHTnLQGrCXPei9AW/GY8kj2S
 Rfv2l4uA3rdckhbBn7do/Tr3E0X07oKxkvKWYnpb31EJMBgkceuCBpIqTPBaGrxX6ol+XiVvkKLo
 Ip+EsW9oOG0ZqcKxooqFrcuH4R+YhsdZMA+sZZGjqfdLUXmgXx0QZ+MkV9+YhHLjaIvl6PrgbFN/
 D4oJCWglABsGqxf5LWTx3vR/Gm8lTwx8n2BAa7ImHOqsXRD6tZuiuW0IzZ+AAQ36BWMFqBbe6Ild
 33NJfwm7gq6/ptZtsnYISmEKJKsq6JkAtfuumRBmFnWu96LMtZBer+JGNismMaCBNnBRk1GYy0sC
 IrtPLg5P9l6NA5yEMm/va+e25QJbkZ/Rge3hMHA/sy2L0s5qZxNaU6xXyMABBbIPnJZhlqWS5jPH
 I=
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 431c263dc5..9d9c6254a3 100644
--- a/target/xtensa/xtensa-semi.c
+++ b/target/xtensa/xtensa-semi.c
@@ -35,6 +35,7 @@
 #include "system/memory.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
+#include "qemu/plugin.h"
 
 enum {
     TARGET_SYS_exit = 1,
@@ -197,6 +198,7 @@ void HELPER(simcall)(CPUXtensaState *env)
     CPUState *cs = env_cpu(env);
     AddressSpace *as = cs->as;
     uint32_t *regs = env->regs;
+    uint64_t last_pc = env->pc;
 
     switch (regs[2]) {
     case TARGET_SYS_exit:
@@ -433,4 +435,5 @@ void HELPER(simcall)(CPUXtensaState *env)
         regs[3] = TARGET_ENOSYS;
         break;
     }
+    qemu_plugin_vcpu_hostcall_cb(cs, last_pc);
 }
-- 
2.49.1


