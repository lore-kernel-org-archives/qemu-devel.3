Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F190C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 15:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH2I7-0006re-GD; Mon, 19 May 2025 11:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uH2I5-0006r7-QU
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:20:33 -0400
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uH2I3-0005S7-Lb
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:20:33 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 989AB180E87
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 17:20:22 +0200 (CEST)
Received: (qmail 1359 invoked by uid 990); 19 May 2025 15:20:22 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 19 May 2025 17:20:22 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v5 02/25] plugins: add API for registering discontinuity
 callbacks
Date: Mon, 19 May 2025 17:19:42 +0200
Message-ID: <3b5ee8f787cf2ebf17962b172eaf2bd46343235f.1747666625.git.neither@nut.email>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747666625.git.neither@nut.email>
References: <cover.1747666625.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ----
X-Rspamd-Report: REPLY(-4) SUSPICIOUS_RECIPS(1.5) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) BAYES_HAM(-3) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -4.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=tqOkdn7H0/+7oThE54seK3nN0I07qvxmlZ9TGuAmoAc=;
 b=LLoHtiVB4UxDvxJeB6wkVg7BMJQtnaRzP1eFZVSFUX7krbYJHYiwA0eTJgXPHvdUyVcM3AxYMY
 3EYmS6SbyEIJ47fVm/kHPDETtMx6Gdshn3XJTS/A9vmocA5v0H7pc+Ia+HvroMMTpWx+OKDqBR5n
 MX7/tGM/fEFB9Jv23FrCv5D0NqUhQtqTwE/gxwXFi48mRix7P8fC34CkTi8GLCXsFkrk69sdRPLn
 YvETSDKCFSH8LdrnX3dIA0N/V8Xq7mtHhUUrpt2nmDoiUaPZe5DXja1PeJTuLUJzIXTfJXLdDeiz
 eJ13ZGmQu7UXl5BYnMq7WtFnXgIutmxwsSYHIypphK4Si52DH+bOE1UvS8MK/Rg4edORTqHeniTL
 FMLHZX97e6jAjrr8XkW+IS/eW7FeZWJAlLsS/Czw7Vy1gA+4jufoLKKaNWoMMdwGM0vJ5WHkoL//
 +qBYHneCindKDwt8XP/1W5vUe6xGBlvXTjwVFMSpVcVhuXzbGZ5xmrjt2Igy6lHRZOI/fll4gLTd
 Cy2qsnFwAZFVz/iP2xYoWgTtwxoe3k6ZQYJNL8p6R947fGYFYItAdmX5Jwac86wZBJG7dus8gQJ7
 zbqJXMLY7Dve3NxZUxrnYcBXu8BuMzfxI8ADKIzw/ZMeX8O8VGG5uXRMEDKTChsOO7ub9MuLJjbw
 M=
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
related events, such as VCPU reset, idle and resume. In addition to
those events, we recently defined discontinuity events, which include
traps.

This change introduces a function to register callbacks for these
events. We define one distinct plugin event type for each type of
discontinuity, granting fine control to plugins in term of which events
they receive.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
index 2e849bff0b..6d46d15e27 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -274,6 +274,22 @@ QEMU_PLUGIN_API
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
index eb9281fe54..dc1f5cb4d8 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -551,6 +551,21 @@ void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
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
2.49.0


