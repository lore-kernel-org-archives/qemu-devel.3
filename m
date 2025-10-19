Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F5CCCD19F
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 15:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAV8o-0001nP-QD; Sun, 19 Oct 2025 11:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vAV8n-0001nH-5G
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:16:13 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vAV8l-00039G-6s
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:16:12 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 04CE360A83
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 17:16:10 +0200 (CEST)
Received: (qmail 22621 invoked by uid 990); 19 Oct 2025 15:16:09 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 19 Oct 2025 17:16:07 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v8 02/25] plugins: add API for registering discontinuity
 callbacks
Date: Sun, 19 Oct 2025 17:14:51 +0200
Message-ID: <3a521f7982dfe1a2a71b4237f6a71c7b10da6598.1760884672.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1760884672.git.neither@nut.email>
References: <cover.1760884672.git.neither@nut.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ----
X-Rspamd-Report: REPLY(-4) SUSPICIOUS_RECIPS(1.5) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) BAYES_HAM(-3)
X-Rspamd-Score: -4.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=QtKA19sfR0JfExEgWblMeLRIoK6HCqGXkcD3ErSDWR8=;
 b=HU67ZTj2qFYuZJpjRr8hvZkQmjjzjarAe/nSm5BIAxQt/+wLofq14VELlAO31U51k+V/blA9Oi
 7G5YJGfm4hX83doSoO5el/ejz2fLl0mTI1WnoxrW+3JsXVSTmkjaewzVDRcpPahWk+y8DPqfXXaE
 4pWUWOj6IXNXfVsnIOqCVIGkVVmPIC/v/r2PKh09hfAMVyLZc5ZHpku96OkEMdsdw8UG6O3xsYBr
 NLlgf+EAkOe5r1iXGa9f9oqoAfp1E2lwObr2+G0o4P6mV7KbfhayOgdvL+7lv+2JaaWjHRYT3pEH
 J0V8+xGgmNcXfFGPR9KdPk+7yHwhKxV+XQPE/ywF9ZFZbf8K5Wsp+iYHXougRCBrvpwKvHafV3Id
 qZEce6BHSxM4X+zabiLQrkcICqiCTecM41gr0V8Rt7/p4vGrFbfqxF7GkbYel/B97DvUjqMilknG
 oZiC79HxrQLs21yUsgXF9ZpN83BxMdIGft2a1pVN9tlwSgAzpRHN2GzUOk2FnRwgrvmMbai0hh5W
 zqXOy5gzwiawxE8lgu3QgKE+5nbEMbSPr2UMJOPc+DOYiCQ4sBp1yWqk+D75zkaIsSXVE9IXk7g+
 C5oESBvloGVq8EjegHDnN3maEBTcgvQmJK51Y6ZQAdXNrE2dKo9GntQjClWBF3MWVVvT49oZepzv
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
related events, such as VCPU reset, idle and resume. In addition to
those events, we recently defined discontinuity events, which include
traps.

This change introduces a function to register callbacks for these
events. We define one distinct plugin event type for each type of
discontinuity, granting fine control to plugins in term of which events
they receive.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Julian Ganz <neither@nut.email>
---
 include/qemu/plugin-event.h |  3 +++
 include/qemu/qemu-plugin.h  | 16 ++++++++++++++++
 plugins/core.c              | 15 +++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/include/qemu/plugin-event.h b/include/qemu/plugin-event.h
index 7056d8427b..1100dae212 100644
--- a/include/qemu/plugin-event.h
+++ b/include/qemu/plugin-event.h
@@ -20,6 +20,9 @@ enum qemu_plugin_event {
     QEMU_PLUGIN_EV_VCPU_SYSCALL_RET,
     QEMU_PLUGIN_EV_FLUSH,
     QEMU_PLUGIN_EV_ATEXIT,
+    QEMU_PLUGIN_EV_VCPU_INTERRUPT,
+    QEMU_PLUGIN_EV_VCPU_EXCEPTION,
+    QEMU_PLUGIN_EV_VCPU_HOSTCALL,
     QEMU_PLUGIN_EV_MAX, /* total number of plugin events we support */
 };
 
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 08bf366e36..60de4fdd3f 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -281,6 +281,22 @@ QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
                                          qemu_plugin_vcpu_simple_cb_t cb);
 
+/**
+ * qemu_plugin_register_vcpu_discon_cb() - register a discontinuity callback
+ * @id: plugin ID
+ * @type: types of discontinuities for which to call the callback
+ * @cb: callback function
+ *
+ * The @cb function is called every time a vCPU receives a discontinuity event
+ * of the specified type(s), after the vCPU was prepared to handle the event.
+ * Preparation entails updating the PC, usually to some interrupt handler or
+ * trap vector entry.
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_register_vcpu_discon_cb(qemu_plugin_id_t id,
+                                         enum qemu_plugin_discon_type type,
+                                         qemu_plugin_vcpu_discon_cb_t cb);
+
 /** struct qemu_plugin_tb - Opaque handle for a translation block */
 struct qemu_plugin_tb;
 /** struct qemu_plugin_insn - Opaque handle for a translated instruction */
diff --git a/plugins/core.c b/plugins/core.c
index ead09fd2f1..40d001d39a 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -569,6 +569,21 @@ void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
     plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_RESUME, cb);
 }
 
+void qemu_plugin_register_vcpu_discon_cb(qemu_plugin_id_t id,
+                                         enum qemu_plugin_discon_type type,
+                                         qemu_plugin_vcpu_discon_cb_t cb)
+{
+    if (type & QEMU_PLUGIN_DISCON_INTERRUPT) {
+        plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_INTERRUPT, cb);
+    }
+    if (type & QEMU_PLUGIN_DISCON_EXCEPTION) {
+        plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_EXCEPTION, cb);
+    }
+    if (type & QEMU_PLUGIN_DISCON_HOSTCALL) {
+        plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_HOSTCALL, cb);
+    }
+}
+
 void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,
                                    qemu_plugin_simple_cb_t cb)
 {
-- 
2.49.1


