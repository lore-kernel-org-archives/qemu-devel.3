Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79464C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 13:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE6WD-0006Qm-U9; Sun, 11 May 2025 09:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uE6WC-0006PV-1c
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:15:00 -0400
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uE6W8-0006mF-Fe
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:14:59 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 1F5D0180050
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 15:14:47 +0200 (CEST)
Received: (qmail 25941 invoked by uid 990); 11 May 2025 13:14:47 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 11 May 2025 15:14:46 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 03/23] plugins: add hooks for new discontinuity related
 callbacks
Date: Sun, 11 May 2025 15:13:55 +0200
Message-ID: <de35ba0200017bef2126899f918b6be8830851ea.1746968215.git.neither@nut.email>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746968215.git.neither@nut.email>
References: <cover.1746968215.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ----
X-Rspamd-Report: REPLY(-4) SUSPICIOUS_RECIPS(1.5) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) BAYES_HAM(-3) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -4.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=xnmTchtKkuBxSt7akDwvVFkTIUBDMW6NONxwKe7Ga2g=;
 b=N/eD+7/tY8q2HkeiMTjOxeCdnqowtZMW09CJcmYWm/DeZB+O7TyN3Xbss/jtxHTyEkM0ql/3JF
 AMlX18eR6VOuH0LN7pACMValhUWWgqih3woYYoiL6FnhoEnLu0AXGM95mFUaa/VPcTcgM5jMPRu/
 tsMqrf8KwwrKE94718b82nVZj6+8KUntLDaF4F3Ew/dbBBQRJniQf7n30N/0qCZqOJI/Wt4ES0x3
 T0b+I0D9jjB7nFnVYN8kmvxM8YtnarFTz9EO19+WtdtcRK3KjBsIWMPuq8QWJpf6YK8qSqx5gQku
 U0nikf1TC7kFcCEOPpM/r5UTA0/wx7HYAr2AfdMzywmir7LwQbeDv9t7tfzubP7F2b02gpGjQ3bV
 LFgrggMOSWdXIASofu1wGr86iwvuGYFAgLzztOmkEKHfmKD+L29Ee5GAkcm/3KHGHkt/01SDXSdH
 kyS8HwolI4jGuJVV8HfTd8xASMSd6/BjdEU0dfSa4TMY5nrIDu14U5Q6JPEMMkMEeO8hjQRjnIp4
 rDsU6O4+TZNsGJN26OjhAKFuo+Ox7rwV7ykwFrJ2eaE/GZHYjysx2WNSy2VE/O7j2ocb0MB3JP0q
 y+72d2SIn1Ic++2nNmRnDGeoQzk2Osb6F9nhBjItw1l++0zCzefE1PmgkRWCCziG27gizCl5GSkz
 c=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: Julian Ganz <neither@nut.email>
---
 include/qemu/plugin.h | 12 ++++++++++
 plugins/core.c        | 53 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 27a176b631..3494325039 100644
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
@@ -243,6 +246,15 @@ static inline void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
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
index dc1f5cb4d8..f07813d588 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -104,6 +104,44 @@ static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
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
+                                   uint64_t from)
+{
+    struct qemu_plugin_cb *cb, *next;
+    enum qemu_plugin_event ev;
+    uint64_t to = cpu->cc->get_pc(cpu);
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
@@ -539,6 +577,21 @@ void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
     }
 }
 
+void qemu_plugin_vcpu_interrupt_cb(CPUState *cpu, uint64_t from)
+{
+    plugin_vcpu_cb__discon(cpu, QEMU_PLUGIN_DISCON_INTERRUPT, from);
+}
+
+void qemu_plugin_vcpu_exception_cb(CPUState *cpu, uint64_t from)
+{
+    plugin_vcpu_cb__discon(cpu, QEMU_PLUGIN_DISCON_EXCEPTION, from);
+}
+
+void qemu_plugin_vcpu_hostcall_cb(CPUState *cpu, uint64_t from)
+{
+    plugin_vcpu_cb__discon(cpu, QEMU_PLUGIN_DISCON_HOSTCALL, from);
+}
+
 void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
                                        qemu_plugin_vcpu_simple_cb_t cb)
 {
-- 
2.49.0


