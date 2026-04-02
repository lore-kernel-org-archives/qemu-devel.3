Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F41CD6AB10
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 21:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8PS3-0003jc-Cp; Thu, 02 Apr 2026 17:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1w8PS2-0003j2-3K
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:19:42 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1w8PS0-0004b3-CL
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:19:41 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 612BA60126;
 Thu,  2 Apr 2026 21:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1440C19424;
 Thu,  2 Apr 2026 21:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775164778;
 bh=gPO1Pu3xZDZpzDPyynLjlwUEaoGQCjY4ylfy1aTTGVg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=JNssCbUYR+2RARh2r9e2xQQTXsL6LV+B7wF72+vHZBzAcurOJVYNXTaouzT4DG201
 NyXkc2Ko0aTKNhLTLRqNN9pb6PdWg307AHaCi86iR9/PLMYtdG9Vn1DheYOAWlPuj8
 vlxbENkZoC3aN09xssjn0VNxGGCPqKDVV2Dxe3+DA7fJitvanEydz1aNsMjgUL5dNP
 ZysGgc/Xa7B9qvCQx9DCezLay/CMoowZ2oOR7ccNon45hHoZ+KEEz4B8Z6uz0F2Q1Q
 QKo+CtQYxRTFd9RZYb0N1j8EHAJvvwGA8z3hfYXbVvnj47wpgCxeYXAKExnU0PXK4o
 6LDwpOgNIH+lA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 02 Apr 2026 23:19:18 +0200
Subject: [PATCH 3/5] qapi: add monitor-add, monitor-remove, query-monitors
 commands
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-work-qmp-monitor-hotplug-v1-3-6313a5cdd574@kernel.org>
References: <20260402-work-qmp-monitor-hotplug-v1-0-6313a5cdd574@kernel.org>
In-Reply-To: <20260402-work-qmp-monitor-hotplug-v1-0-6313a5cdd574@kernel.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7468; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gPO1Pu3xZDZpzDPyynLjlwUEaoGQCjY4ylfy1aTTGVg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSeuxsf1PLUnn0Xf9CM1Wb7Al5qTKgSZEsx/vju/J5rC
 UlGFut2d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkfzcjwxXVaFfrHb0vShQe
 3tomnOxQ19Lc0l1b4dTF333LTJPFgOF/REaslOqPhRwyrCk7D3hs28W/OUtuvvGtJ/5MzRuz76v
 zAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=brauner@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add QMP commands for dynamic monitor lifecycle management:

- monitor-add: Create a QMP monitor on an existing chardev at runtime.
  The chardev must exist and not be in use. The new monitor starts in
  capability negotiation mode.

- monitor-remove: Remove a dynamically-added monitor. CLI-created
  monitors cannot be removed. If the dispatcher is currently servicing
  the target monitor (self-removal), destruction is deferred until the
  in-flight command completes. The underlying chardev is not destroyed.

- query-monitors: Introspect all active monitors with their id, mode,
  chardev name, and whether they were dynamically added.

The motivating use case is systemd-vmspawn: when an external client
requests raw QMP access, vmspawn can create an independent QMP session
on demand rather than pre-allocating spare monitors at launch or
building an id-rewriting proxy.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 monitor/qmp-cmds-control.c |  94 ++++++++++++++++++++++++++++++++++++++++
 qapi/control.json          | 106 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 200 insertions(+)

diff --git a/monitor/qmp-cmds-control.c b/monitor/qmp-cmds-control.c
index 150ca9f5cb..0998017620 100644
--- a/monitor/qmp-cmds-control.c
+++ b/monitor/qmp-cmds-control.c
@@ -219,3 +219,97 @@ SchemaInfoList *qmp_query_qmp_schema(Error **errp)
     }
     return schema;
 }
+
+void qmp_monitor_add(const char *id, const char *chardev,
+                     bool has_pretty, bool pretty, Error **errp)
+{
+    Chardev *chr;
+
+    /* Reject duplicate monitor id */
+    if (monitor_find_by_id(id)) {
+        error_setg(errp, "monitor '%s' already exists", id);
+        return;
+    }
+
+    chr = qemu_chr_find(chardev);
+    if (!chr) {
+        error_setg(errp, "chardev '%s' not found", chardev);
+        return;
+    }
+
+    monitor_init_qmp(chr, has_pretty && pretty, id, true, errp);
+}
+
+void qmp_monitor_remove(const char *id, Error **errp)
+{
+    Monitor *mon;
+    MonitorQMP *qmp_mon;
+
+    mon = monitor_find_by_id(id);
+    if (!mon) {
+        error_setg(errp, "monitor '%s' not found", id);
+        return;
+    }
+
+    if (!mon->dynamic) {
+        error_setg(errp, "monitor '%s' was not dynamically added", id);
+        return;
+    }
+
+    qmp_mon = container_of(mon, MonitorQMP, common);
+
+    /*
+     * Step 1: Disconnect chardev handlers so no new data arrives
+     * and no new requests are enqueued.
+     */
+    qemu_chr_fe_set_handlers(&mon->chr, NULL, NULL, NULL, NULL,
+                             NULL, NULL, true);
+
+    /* Step 2: Drain pending requests from the queue */
+    monitor_qmp_cleanup_queue_and_resume(qmp_mon);
+
+    /*
+     * Step 3: Mark dead and remove from mon_list.
+     * After removal, the dispatcher will never pop new requests from
+     * this monitor, and event broadcast will skip it.
+     */
+    qemu_mutex_lock(&monitor_lock);
+    mon->dead = true;
+    QTAILQ_REMOVE(&mon_list, mon, entry);
+    qemu_mutex_unlock(&monitor_lock);
+
+    /*
+     * Step 4: Check if the dispatcher is currently mid-dispatch on
+     * this monitor (i.e. monitor-remove was sent from the monitor
+     * being removed).  If so, defer destruction -- the dispatcher
+     * will call monitor_qmp_destroy() after completing the request.
+     */
+    if (monitor_qmp_dispatcher_is_servicing(qmp_mon)) {
+        return;
+    }
+
+    /* Step 5: Safe to destroy immediately */
+    monitor_qmp_destroy(qmp_mon);
+}
+
+MonitorInfoList *qmp_query_monitors(Error **errp)
+{
+    MonitorInfoList *list = NULL;
+    Monitor *mon;
+
+    qemu_mutex_lock(&monitor_lock);
+    QTAILQ_FOREACH(mon, &mon_list, entry) {
+        MonitorInfo *info = g_new0(MonitorInfo, 1);
+        Chardev *chr = qemu_chr_fe_get_driver(&mon->chr);
+
+        info->id = g_strdup(mon->id); /* NULL if unnamed */
+        info->mode = mon->is_qmp ? MONITOR_MODE_CONTROL
+                                 : MONITOR_MODE_READLINE;
+        info->chardev = g_strdup(chr ? chr->label : "unknown");
+        info->dynamic = mon->dynamic;
+        QAPI_LIST_PREPEND(list, info);
+    }
+    qemu_mutex_unlock(&monitor_lock);
+
+    return list;
+}
diff --git a/qapi/control.json b/qapi/control.json
index 9a5302193d..b9f495c08c 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -211,3 +211,109 @@
       '*pretty': 'bool',
       'chardev': 'str'
   } }
+
+##
+# @monitor-add:
+#
+# Add a QMP monitor on an existing character device backend.
+#
+# The chardev must already exist (created via chardev-add or CLI) and
+# must not be in use by another frontend.  The monitor begins in
+# capability negotiation mode -- the first client to connect receives
+# the QMP greeting.
+#
+# @id: Monitor identifier, must be unique among monitors
+#
+# @chardev: Name of the character device backend to attach to
+#
+# @pretty: Enable pretty-printing of QMP responses (default: false)
+#
+# Errors:
+#     - GenericError if @id is already in use
+#     - GenericError if @chardev does not exist
+#     - GenericError if @chardev is already in use by another frontend
+#
+# Since: 11.0
+#
+# .. qmp-example::
+#
+#     -> { "execute": "monitor-add",
+#          "arguments": { "id": "extra-qmp",
+#                         "chardev": "qmp-extra" } }
+#     <- { "return": {} }
+##
+{ 'command': 'monitor-add',
+  'data': { 'id': 'str',
+            'chardev': 'str',
+            '*pretty': 'bool' } }
+
+##
+# @monitor-remove:
+#
+# Remove a dynamically added QMP monitor.
+#
+# The monitor must have been created via monitor-add.  Monitors
+# created via CLI options (-mon, -qmp) cannot be removed.  The
+# underlying chardev is NOT removed -- use chardev-remove separately
+# if desired.
+#
+# If a client is currently connected, the connection is dropped.
+#
+# @id: Monitor identifier as passed to monitor-add
+#
+# Errors:
+#     - GenericError if @id does not exist
+#     - GenericError if the monitor was not dynamically added
+#
+# Since: 11.0
+#
+# .. qmp-example::
+#
+#     -> { "execute": "monitor-remove",
+#          "arguments": { "id": "extra-qmp" } }
+#     <- { "return": {} }
+##
+{ 'command': 'monitor-remove',
+  'data': { 'id': 'str' } }
+
+##
+# @MonitorInfo:
+#
+# Information about a QMP/HMP monitor.
+#
+# @id: Monitor identifier (absent for CLI-created monitors without
+#     an explicit id)
+#
+# @mode: Monitor mode (readline or control)
+#
+# @chardev: Name of the attached character device
+#
+# @dynamic: true if created via monitor-add (removable), false if
+#     created via CLI
+#
+# Since: 11.0
+##
+{ 'struct': 'MonitorInfo',
+  'data': { '*id': 'str',
+            'mode': 'MonitorMode',
+            'chardev': 'str',
+            'dynamic': 'bool' } }
+
+##
+# @query-monitors:
+#
+# Return information about all active monitors.
+#
+# Returns: a list of @MonitorInfo for each active monitor
+#
+# Since: 11.0
+#
+# .. qmp-example::
+#
+#     -> { "execute": "query-monitors" }
+#     <- { "return": [ { "id": "mon0", "mode": "control",
+#                         "chardev": "compat_monitor0",
+#                         "dynamic": false } ] }
+##
+{ 'command': 'query-monitors',
+  'returns': ['MonitorInfo'] }

-- 
2.47.3


