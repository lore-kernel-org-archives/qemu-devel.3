Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AE8CCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 15:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAV9W-00023Q-S0; Sun, 19 Oct 2025 11:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vAV9V-000239-CA
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:16:57 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vAV9T-0003ES-RA
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:16:57 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id BC7F260A7F
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 17:16:54 +0200 (CEST)
Received: (qmail 23595 invoked by uid 990); 19 Oct 2025 15:16:54 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 19 Oct 2025 17:16:50 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PATCH v8 17/25] target/rx: call plugin trap callbacks
Date: Sun, 19 Oct 2025 17:15:06 +0200
Message-ID: <b3333ba5003a4cbe023278e8692168daa5f544c2.1760884672.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1760884672.git.neither@nut.email>
References: <cover.1760884672.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.999977) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.599977
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=uI/BjTYdC7z/7F5A6PPEG9j6lzk7xU/k4iG6aZX+MLQ=;
 b=VIH2n6lFopsUPggJtOA7KLPXmNmXnbq3OvKyu3JN13U3jWpYMZKf8EOVy6ktvwVDp/L63e/Pvl
 iDrczrz7QUtIIOQlvUtNI/4LpS7F0ExjQVS6jCOynZzSfeUL7N4usv6lgmRAg27XFG6/VowOLpog
 38fHZgoDSfPU3+mO5fu86e4NbwMylcKWRLYlsgIIdrDFSQyOB91qu41CdEzw46jUcU4GoMusVpj0
 R7EOEwttU5fIGj3JY0Fk4WJ66QACZR7+sCcxfrAlIevyhEnoiEED4bNruPkJwANtqWrmQYy2MhGv
 F6VcNMX5YAfYvyvgHCbecktJlFGVCnZiQvccKW+XyHrIHoArT8Sdm6NlSPO4cI7eAkDR58k4QMRM
 JOOUu0CF4JUmTVFUKxthm6Uk1uc/NpcJfxr34LVCws3BBasD/aGVNiLzHTXArLMa+e+0WMv3KfDY
 19+Uko7r1h3thJ7Q1FdTjmyxW2vw3EaZOJVAt2B6E+/24WMh8r9cUfW9m0sZghdMCLa73432lICN
 38eAhpqWVGTL0C2GBJ6IXnlc9gWfD4g/fjQWvwgOzkEZMlf/7Mil3E6Dr9ip6aIhIp7XFYVOrFwL
 ry4wshvF0dPoEg0sIsxMmMrSFAVXuofaE4g/OhyVAIoPVE1ytffx0REpHIEPLqQu1PIh/z02PsW9
 o=
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

This change places hooks for Renesas Xtreme targets.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Yoshinori Sato <yoshinori.sato@nifty.com>
Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/rx/helper.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/rx/helper.c b/target/rx/helper.c
index 41c9606fd1..ef47e32add 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -22,6 +22,7 @@
 #include "exec/log.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "hw/irq.h"
+#include "qemu/plugin.h"
 
 void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw, int rte)
 {
@@ -46,6 +47,7 @@ void rx_cpu_do_interrupt(CPUState *cs)
     CPURXState *env = cpu_env(cs);
     int do_irq = cpu_test_interrupt(cs, INT_FLAGS);
     uint32_t save_psw;
+    uint64_t last_pc = env->pc;
 
     env->in_sleep = 0;
 
@@ -65,6 +67,7 @@ void rx_cpu_do_interrupt(CPUState *cs)
             env->psw_ipl = 15;
             cpu_reset_interrupt(cs, CPU_INTERRUPT_FIR);
             qemu_set_irq(env->ack, env->ack_irq);
+            qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
             qemu_log_mask(CPU_LOG_INT, "fast interrupt raised\n");
         } else if (do_irq & CPU_INTERRUPT_HARD) {
             env->isp -= 4;
@@ -75,6 +78,7 @@ void rx_cpu_do_interrupt(CPUState *cs)
             env->psw_ipl = env->ack_ipl;
             cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
             qemu_set_irq(env->ack, env->ack_irq);
+            qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
             qemu_log_mask(CPU_LOG_INT,
                           "interrupt 0x%02x raised\n", env->ack_irq);
         }
@@ -92,6 +96,14 @@ void rx_cpu_do_interrupt(CPUState *cs)
         } else {
             env->pc = cpu_ldl_data(env, env->intb + (vec & 0xff) * 4);
         }
+
+        if (vec == 30) {
+            /* Non-maskable interrupt */
+            qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
+        } else {
+            qemu_plugin_vcpu_exception_cb(cs, last_pc);
+        }
+
         switch (vec) {
         case 20:
             expname = "privilege violation";
-- 
2.49.1


