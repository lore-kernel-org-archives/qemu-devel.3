Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9592CE69E81
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 19:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIC4x-0005jj-V5; Mon, 02 Dec 2024 14:27:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tIC4p-0005iQ-EU
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 14:27:24 -0500
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tIC4n-0001vZ-Kk
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 14:27:23 -0500
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 32F41180BF2
 for <qemu-devel@nongnu.org>; Mon,  2 Dec 2024 20:27:13 +0100 (CET)
Received: (qmail 7132 invoked by uid 990); 2 Dec 2024 19:27:13 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 02 Dec 2024 20:27:13 +0100
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH v3 03/11] plugins: add hooks for new discontinuity related
 callbacks
Date: Mon,  2 Dec 2024 20:26:44 +0100
Message-ID: <18b8687e6310a68283b8b3ed72ad38479114bc51.1733063076.git.neither@nut.email>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733063076.git.neither@nut.email>
References: <cover.1733063076.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ----
X-Rspamd-Report: REPLY(-4) SUSPICIOUS_RECIPS(1.5) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) BAYES_HAM(-3) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -4.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=874xBqS2kmQpv4fNE2Ynkwrhjf+s677m67u0HdCGqsQ=;
 b=Avdp6UkyEukb5eg1TMLBI/t3qK05CHk5uzBoeJF1El4LScuY6taO+w/JXIkJUEGwsrcSkjHjRH
 K/gdIXdEQyTj+U01JwXdLfSCVPt/8V29qC++H/x3hPgEPlBTCWBscD4zSKkkVBclWmC9yim5Nv6p
 WHYmQ9U1kbRvbkV23oBnXFI3fztfLkIc+fB096cjHQAtZ4Xfb/emLFB1nIoO49udXR9ESO2fvkqx
 yGzyJJhQ6LQDBtVlMMfy7dEgwpauALLJIvPZ7N2tUKwywb6n7pS1s1KxfW7Hk+eE1VOxf+F0wWUd
 HlVPH3I3VQTRXzBxJMcvBjj0PF27XsuxAiN9swv1NlDqi05DSV87n9mSlJrXRZw7TgDH/bjHz6yS
 SMEL7l3NEO11ZYZGpGeVAP+JNpD1KzNlXPmrhauY2t7yP5Gkj+5jRNeTiH+Cs92fdD6WmBARlr3g
 ZIy3M8SaKaNG2ez/6Rx/5brTW9GTKdHl+nipcVadxSOzYTWfIf1L2KMzROMLYTwjlWGV0G6u+XoA
 ycoqtzczR81/TBX8y1RDvNu0jOM97TbN1UkvytVhktV5cho3Ema1sJjToem/9TnrTTiHPjz7Fpsv
 K2uDi5TOq/2gLDLmfwPGNmNaIb501Bdi0DhyKPOHfOupiocibb674ANcJUk7JfuprLrMvsnQE5rC
 0=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
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

The plugin API allows registration of callbacks for a variety of VCPU
related events, such as VCPU reset, idle and resume. In addition, we
recently introduced API for registering callbacks for discontinuity
events, specifically for interrupts, exceptions and host calls.

This change introduces the corresponding hooks called from target
specific code inside qemu.
---
 include/qemu/plugin.h | 12 ++++++++++
 plugins/core.c        | 52 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 27a176b631..3de9cb3fe4 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -161,6 +161,9 @@ void qemu_plugin_vcpu_exit_hook(CPUState *cpu);
 void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb);
 void qemu_plugin_vcpu_idle_cb(CPUState *cpu);
 void qemu_plugin_vcpu_resume_cb(CPUState *cpu);
+void qemu_plugin_vcpu_interrupt_cb(CPUState *cpu, uint64_t from, uint64_t to);
+void qemu_plugin_vcpu_exception_cb(CPUState *cpu, uint64_t from, uint64_t to);
+void qemu_plugin_vcpu_hostcall_cb(CPUState *cpu, uint64_t from, uint64_t to);
 void
 qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1,
                          uint64_t a2, uint64_t a3, uint64_t a4, uint64_t a5,
@@ -243,6 +246,15 @@ static inline void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
 static inline void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
 { }
 
+void qemu_plugin_vcpu_interrupt_cb(CPUState *cpu, uint64_t from, uint64_t to)
+{ }
+
+void qemu_plugin_vcpu_exception_cb(CPUState *cpu, uint64_t from, uint64_t to)
+{ }
+
+void qemu_plugin_vcpu_hostcall_cb(CPUState *cpu, uint64_t from, uint64_t to)
+{ }
+
 static inline void
 qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
                          uint64_t a3, uint64_t a4, uint64_t a5, uint64_t a6,
diff --git a/plugins/core.c b/plugins/core.c
index a89a4a0315..2c9637334f 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -112,6 +112,43 @@ static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
     }
 }
 
+/*
+ * Disable CFI checks.
+ * The callback function has been loaded from an external library so we do not
+ * have type information
+ */
+QEMU_DISABLE_CFI
+static void plugin_vcpu_cb__discon(CPUState *cpu,
+                                   enum qemu_plugin_discon_type type,
+                                   uint64_t from, uint64_t to)
+{
+    struct qemu_plugin_cb *cb, *next;
+    enum qemu_plugin_event ev;
+
+    if (cpu->cpu_index < plugin.num_vcpus) {
+        switch (type) {
+        case QEMU_PLUGIN_DISCON_INTERRUPT:
+            ev = QEMU_PLUGIN_EV_VCPU_INTERRUPT;
+            break;
+        case QEMU_PLUGIN_DISCON_EXCEPTION:
+            ev = QEMU_PLUGIN_EV_VCPU_EXCEPTION;
+            break;
+        case QEMU_PLUGIN_DISCON_HOSTCALL:
+            ev = QEMU_PLUGIN_EV_VCPU_HOSTCALL;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+
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
@@ -547,6 +584,21 @@ void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
     }
 }
 
+void qemu_plugin_vcpu_interrupt_cb(CPUState *cpu, uint64_t from, uint64_t to)
+{
+    plugin_vcpu_cb__discon(cpu, QEMU_PLUGIN_DISCON_INTERRUPT, from, to);
+}
+
+void qemu_plugin_vcpu_exception_cb(CPUState *cpu, uint64_t from, uint64_t to)
+{
+    plugin_vcpu_cb__discon(cpu, QEMU_PLUGIN_DISCON_EXCEPTION, from, to);
+}
+
+void qemu_plugin_vcpu_hostcall_cb(CPUState *cpu, uint64_t from, uint64_t to)
+{
+    plugin_vcpu_cb__discon(cpu, QEMU_PLUGIN_DISCON_HOSTCALL, from, to);
+}
+
 void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
                                        qemu_plugin_vcpu_simple_cb_t cb)
 {
-- 
2.45.2


