Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 662ECD3C921
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2024 16:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2CUw-0001zV-KZ; Sat, 19 Oct 2024 12:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1t2CUs-0001vZ-V0
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 12:40:10 -0400
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1t2CUp-0003gn-QT
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 12:40:10 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id DCBB917F958
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2024 18:39:57 +0200 (CEST)
Received: (qmail 9712 invoked by uid 990); 19 Oct 2024 16:39:57 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sat, 19 Oct 2024 18:39:57 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH v2 1/7] plugins: add API for registering trap related
 callbacks
Date: Sat, 19 Oct 2024 18:39:34 +0200
Message-ID: <6ea9b0df866ca507e478df7df06899e69766503a.1729355735.git.neither@nut.email>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729355735.git.neither@nut.email>
References: <20231021122502.26746-1-neither@nut.email>
 <cover.1729355735.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -
X-Rspamd-Report: REPLY(-4) SUSPICIOUS_RECIPS(1.5) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -1.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=fToHVCbrDVMfJHC3vsVfVl6MiANqzWoRCaSP8NGsL2o=;
 b=eM41ZrHU44PVfOUc3E7AqL8oiAkix+Z3NURtJ2/2INCktvl1FsQmxvoFYouk6KJH1QasVfFSsc
 Dac+r7WAne/jPQ2p6RvzMUy3BM+IeKJEJATfWCguGzDwu05rPoSiDkrE93vwZn4/ZfNNcZ8py9U5
 RD7pn/iwBQh1+e9JAu+xCsLpXFKStAXr7/eY5Vm5tLDQZYNBFVHSFsU0GLUBSj4J5+aQ6LdAz0fr
 dsulecS0jsJbtU3T5ZGJvy2fuQjTIJa2zqT97CeU/9EuR6ctHpRNFChJoYiPdUzN/adMg53YPNbX
 YGpaUHB/a6STU2cNgykhmlEx171VBT38ijmlNf4vlorTHYHsKnqdTxNJobnk0A2RwixiAGrVu749
 6zh4cnDUWELmzpjrS4Bm0XtZ70GzE2h13nwquLq10LYm02mRiE7bI0ZqkTqrcVBlVJTfGaCWWX/h
 i8SEBHYsLk3Z67K+/TxBEhhJQJ7SeONaXy+l2DMH/ZADgk8GJkiGCDkc7hL8b+I97kKSl0hcEQ44
 QfXaVm1Lj42ZOaSzWpyxfA5FNwt6MhBHWdBK9HzsYYD0QaHW/KVRYxEZvOl27HCKVvck9y03yye6
 Vu4kXYO7gxf2wUdye9PWJQvXamJcpjEC4chlxWEMzdWX7LQdmoE3VlnKBsAv6I6jBkrlpR7fK39b
 w=
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

The plugin API allows registration of callbacks for a variety of VCPU
related events, such as VCPU reset, idle and resume. However, traps of
any kind, i.e. interrupts or exceptions, were previously not covered.
These kinds of events are arguably quite significant and usually go hand
in hand with a PC discontinuity and, on most platforms, a transition
from some "mode" to another. Thus, plugins for the analysis of
(virtualized) embedded systems may benefit from or even require the
possiblity to perform work on the occurance of an interrupt or
exception.

This change introduces an interface for the registration of trap related
callbacks. Specifically we (loosely) define interrupts, exceptions and
semihosting events across all platforms and introduce one callback for
each type of event. Because possible modes and concepts for enumeration
of traps vary greatly between different architectures the callbacks are
`qemu_plugin_vcpu_simple_cb_t`. That is, they only receive the VCPU id
and may need to call other API functions for retrieving additional
information.

Signed-off-by: Julian Ganz <neither@nut.email>
---
 include/qemu/plugin-event.h  |  3 +++
 include/qemu/qemu-plugin.h   | 45 ++++++++++++++++++++++++++++++++++++
 plugins/core.c               | 18 +++++++++++++++
 plugins/qemu-plugins.symbols |  3 +++
 4 files changed, 69 insertions(+)

diff --git a/include/qemu/plugin-event.h b/include/qemu/plugin-event.h
index 7056d8427b..2b69a3821b 100644
--- a/include/qemu/plugin-event.h
+++ b/include/qemu/plugin-event.h
@@ -20,6 +20,9 @@ enum qemu_plugin_event {
     QEMU_PLUGIN_EV_VCPU_SYSCALL_RET,
     QEMU_PLUGIN_EV_FLUSH,
     QEMU_PLUGIN_EV_ATEXIT,
+    QEMU_PLUGIN_EV_VCPU_INTERRUPT,
+    QEMU_PLUGIN_EV_VCPU_EXCEPTION,
+    QEMU_PLUGIN_EV_VCPU_SEMIHOSTING,
     QEMU_PLUGIN_EV_MAX, /* total number of plugin events we support */
 };
 
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 622c9a0232..94c3ccd496 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -230,6 +230,51 @@ QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
                                          qemu_plugin_vcpu_simple_cb_t cb);
 
+/**
+ * qemu_plugin_register_vcpu_interrupt_cb() - register a vCPU interrupt callback
+ * @id: plugin ID
+ * @cb: callback function
+ *
+ * The @cb function is called every time a vCPU receives an interrupt, after the
+ * vCPU was prepared to handle the interrupt. An interrupt, in this context and
+ * across all architectures, is defined as an asynchronous event, usually
+ * originating from outside the CPU. Preparation usually entails updating the PC
+ * to some interrupt handler or trap vector entry.
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_register_vcpu_interrupt_cb(qemu_plugin_id_t id,
+                                            qemu_plugin_vcpu_simple_cb_t cb);
+
+/**
+ * qemu_plugin_register_vcpu_exception_cb() - register a vCPU exception callback
+ * @id: plugin ID
+ * @cb: callback function
+ *
+ * The @cb function is called every time a vCPU receives an exception (excluding
+ * semihosting events), after the vCPU was prepared to handle the expection. An
+ * exception, in this context and across all architectures, is defined as a
+ * synchronous event in response to a specific instruction being executed.
+ * Preparation usually entails updating the PC to some exception handler or trap
+ * vector entry.
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_register_vcpu_exception_cb(qemu_plugin_id_t id,
+                                            qemu_plugin_vcpu_simple_cb_t cb);
+
+/**
+ * qemu_plugin_register_vcpu_semihosting_cb() - register a vCPU semihosting cb
+ * @id: plugin ID
+ * @cb: callback function
+ *
+ * The @cb function is called every time a vCPU encounters a semihosting event,
+ * after the event was handled. A semihosting event can be thought of as a
+ * special kind of exception that is not handled by code run by the vCPU but
+ * machinery outside the vCPU.
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_register_vcpu_semihosting_cb(qemu_plugin_id_t id,
+                                              qemu_plugin_vcpu_simple_cb_t cb);
+
 /** struct qemu_plugin_tb - Opaque handle for a translation block */
 struct qemu_plugin_tb;
 /** struct qemu_plugin_insn - Opaque handle for a translated instruction */
diff --git a/plugins/core.c b/plugins/core.c
index bb105e8e68..9de997069c 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -559,6 +559,24 @@ void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
     plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_RESUME, cb);
 }
 
+void qemu_plugin_register_vcpu_interrupt_cb(qemu_plugin_id_t id,
+                                            qemu_plugin_vcpu_simple_cb_t cb)
+{
+    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_INTERRUPT, cb);
+}
+
+void qemu_plugin_register_vcpu_exception_cb(qemu_plugin_id_t id,
+                                            qemu_plugin_vcpu_simple_cb_t cb)
+{
+    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_EXCEPTION, cb);
+}
+
+void qemu_plugin_register_vcpu_semihosting_cb(qemu_plugin_id_t id,
+                                              qemu_plugin_vcpu_simple_cb_t cb)
+{
+    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_SEMIHOSTING, cb);
+}
+
 void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,
                                    qemu_plugin_simple_cb_t cb)
 {
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index 032661f9ea..449a47af22 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -34,6 +34,9 @@
   qemu_plugin_register_vcpu_mem_cb;
   qemu_plugin_register_vcpu_mem_inline_per_vcpu;
   qemu_plugin_register_vcpu_resume_cb;
+  qemu_plugin_register_vcpu_interrupt_cb;
+  qemu_plugin_register_vcpu_exception_cb;
+  qemu_plugin_register_vcpu_semihosting_cb;
   qemu_plugin_register_vcpu_syscall_cb;
   qemu_plugin_register_vcpu_syscall_ret_cb;
   qemu_plugin_register_vcpu_tb_exec_cb;
-- 
2.45.2


