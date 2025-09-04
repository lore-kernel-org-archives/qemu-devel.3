Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D006CA1012
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 20:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuGrr-0003QD-HN; Thu, 04 Sep 2025 16:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uuGrn-0003Ow-NZ
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 16:47:35 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uuGrj-0000gh-57
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 16:47:35 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 2ECF560BFE
 for <qemu-devel@nongnu.org>; Thu,  4 Sep 2025 22:47:20 +0200 (CEST)
Received: (qmail 32546 invoked by uid 990); 4 Sep 2025 20:47:20 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Thu, 04 Sep 2025 22:47:19 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 03/25] plugins: add hooks for new discontinuity related
 callbacks
Date: Thu,  4 Sep 2025 22:46:40 +0200
Message-ID: <03eab59217365665b60ac169723ab689d2a97be4.1757018626.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1757018626.git.neither@nut.email>
References: <cover.1757018626.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ----
X-Rspamd-Report: REPLY(-4) SUSPICIOUS_RECIPS(1.5) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) BAYES_HAM(-3) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -4.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=QGe1FS2XIyc0299hmaYlTYKuPdF+LQBEF6sscTzNBNA=;
 b=jdQwTJr5jMOWIG7sc+ZEZXWIJTMaLAs3/w6luwzxkTdKUXDg8HlMrcEOvsZ5LCmYTubLPvmQme
 9C0u+eOU9oAXW9ZTMj5YgfVBb9S6FPHZZ84gzGSxCdJUCLyoAV7HaRhnIHcGSk+tFnx+fc+gr2e7
 q1OwJd9VWTPTxSCaP5X9QI0lFscxMchV6XnCErd95yRTJXYI6AANkzeKllajOJc/glA2H3w8sXDF
 q9fZLosLKYt8ibPxSHQo7Eo/3RPsYVyFIRhGvda+m4EmxWdj8l1dH9A1/tkgaV7YZ7KFc1ejXulI
 swzK52QB+fxH7Vdi/MDJJBTrXZEW+gtPRCihgHpWQ93rHYDON1qSl4YaL4gNI4iSNgQOzOFaW6aZ
 ICZFg3uraygTxHZ2WqHP7olIn1h5GP9jO7U2tPSBqXMm9U37CaJTcM/f8kBh1IwaX3ytcjq/Z8v6
 SEnjukOSJ9ql2shwvZYCMXXLzD0J7y7bSPfTvLvtTW2ySYfQTQsH89NyJBIye1xOPZGQhNVL0WzY
 QgSh3UJtIp4zFLx+z3KQo1Qcq04cQLBSUtNJwvVj/mH0OG2tfie6zZKng9twSMdWoRlbptW0mjOj
 Vj2m+cY35QTE+RKg/G2q/y+h+oqdfePanO4Na/t3WgYhDMqKNH/tJedwtCg4SDQ1KpimVtKj2/8t
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

The plugin API allows registration of callbacks for a variety of VCPU
related events, such as VCPU reset, idle and resume. In addition, we
recently introduced API for registering callbacks for discontinuity
events, specifically for interrupts, exceptions and host calls.

This change introduces the corresponding hooks called from target
specific code inside qemu.

Signed-off-by: Julian Ganz <neither@nut.email>
---
 include/qemu/plugin.h | 12 ++++++++++++
 plugins/core.c        | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 8cf20cd96f..cea0a68858 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -161,6 +161,9 @@ void qemu_plugin_vcpu_exit_hook(CPUState *cpu);
 void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb);
 void qemu_plugin_vcpu_idle_cb(CPUState *cpu);
 void qemu_plugin_vcpu_resume_cb(CPUState *cpu);
+void qemu_plugin_vcpu_interrupt_cb(CPUState *cpu, uint64_t from);
+void qemu_plugin_vcpu_exception_cb(CPUState *cpu, uint64_t from);
+void qemu_plugin_vcpu_hostcall_cb(CPUState *cpu, uint64_t from);
 void
 qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1,
                          uint64_t a2, uint64_t a3, uint64_t a4, uint64_t a5,
@@ -258,6 +261,15 @@ static inline void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
 static inline void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
 { }
 
+static inline void qemu_plugin_vcpu_interrupt_cb(CPUState *cpu, uint64_t from)
+{ }
+
+static inline void qemu_plugin_vcpu_exception_cb(CPUState *cpu, uint64_t from)
+{ }
+
+static inline void qemu_plugin_vcpu_hostcall_cb(CPUState *cpu, uint64_t from)
+{ }
+
 static inline void
 qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
                          uint64_t a3, uint64_t a4, uint64_t a5, uint64_t a6,
diff --git a/plugins/core.c b/plugins/core.c
index a04cb2392d..1f0ddebcbf 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -105,6 +105,30 @@ static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
     }
 }
 
+/*
+ * Disable CFI checks.
+ * The callback function has been loaded from an external library so we do not
+ * have type information
+ */
+QEMU_DISABLE_CFI
+static void plugin_vcpu_cb__discon(CPUState *cpu,
+                                   enum qemu_plugin_event ev,
+                                   enum qemu_plugin_discon_type type,
+                                   uint64_t from)
+{
+    struct qemu_plugin_cb *cb, *next;
+    uint64_t to = cpu->cc->get_pc(cpu);
+
+    if (cpu->cpu_index < plugin.num_vcpus) {
+        /* iterate safely; plugins might uninstall themselves at any time */
+        QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
+            qemu_plugin_vcpu_discon_cb_t func = cb->f.vcpu_discon;
+
+            func(cb->ctx->id, cpu->cpu_index, type, from, to);
+        }
+    }
+}
+
 /*
  * Disable CFI checks.
  * The callback function has been loaded from an external library so we do not
@@ -557,6 +581,24 @@ void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
     }
 }
 
+void qemu_plugin_vcpu_interrupt_cb(CPUState *cpu, uint64_t from)
+{
+    plugin_vcpu_cb__discon(cpu, QEMU_PLUGIN_EV_VCPU_INTERRUPT,
+                           QEMU_PLUGIN_DISCON_INTERRUPT, from);
+}
+
+void qemu_plugin_vcpu_exception_cb(CPUState *cpu, uint64_t from)
+{
+    plugin_vcpu_cb__discon(cpu, QEMU_PLUGIN_EV_VCPU_EXCEPTION,
+                           QEMU_PLUGIN_DISCON_EXCEPTION, from);
+}
+
+void qemu_plugin_vcpu_hostcall_cb(CPUState *cpu, uint64_t from)
+{
+    plugin_vcpu_cb__discon(cpu, QEMU_PLUGIN_EV_VCPU_HOSTCALL,
+                           QEMU_PLUGIN_DISCON_HOSTCALL, from);
+}
+
 void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
                                        qemu_plugin_vcpu_simple_cb_t cb)
 {
-- 
2.49.1


