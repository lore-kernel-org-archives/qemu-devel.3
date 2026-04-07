Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317ABFF5134
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABXK-00009Z-S5; Tue, 07 Apr 2026 14:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1wABTx-0002o3-33
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:49:01 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1wA0vu-0007cH-LC
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 03:33:12 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 831D160126;
 Tue,  7 Apr 2026 07:33:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5E4C2BC9E;
 Tue,  7 Apr 2026 07:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775547189;
 bh=vUOsnjMPnEut5csZPoZP/V+/ffYrQlfAd/dULVEgPcU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Pi3DmgXx0xx31Ui53oezrPbjTPYc13zCMdpPbqXfRxXityA1+kKsusEaZG13oTL/D
 NrVaA1kzEQMHm7jkFK8cjBDl5sMkGb87B9sqKEK7kCi2HH5lyikEBB9GCUgQYA+shk
 bc0XHD3N/GsoE6oPmB0PPUGKd6rBPYZz9LQh+3hNtXCobiUhWeiipB0KfYll2ZJeMv
 e+RXAmX6tun+nA22t2Z7bFGDT4BtAxSAcUcefHjbKHvRkJno+7Gzwmwr4XuJyC/Oy+
 Ipye7UA03elVxt8HYXGpyH3AOcev3Jjmo+2atstpvSZaB2cRSfBk/Zzk4Y4zxsFGiA
 6FgmoF/f2y5mg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 07 Apr 2026 09:32:47 +0200
Subject: [PATCH v3 3/5] qapi: add monitor-add, monitor-remove,
 query-monitors commands
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-work-qmp-monitor-hotplug-v3-3-cb259800fffb@kernel.org>
References: <20260407-work-qmp-monitor-hotplug-v3-0-cb259800fffb@kernel.org>
In-Reply-To: <20260407-work-qmp-monitor-hotplug-v3-0-cb259800fffb@kernel.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8601; i=brauner@kernel.org;
 h=from:subject:message-id; bh=vUOsnjMPnEut5csZPoZP/V+/ffYrQlfAd/dULVEgPcU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRe2azZ896gqph/tci+wM7tTltkG5SeMEtq5YfH3g1vX
 djNfGFORykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERe32f4X+G21Xyfi+D8k4G3
 HFczTfOafHDWdecEHQcHd8317oWuEgz/i7XVI3ez/9t7/cnviPzny7f9Lr35tOFINuv3Cbs3C+W
 v5gEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=brauner@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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
  The chardev must exist and not already have a frontend attached
  (enforced by qemu_chr_fe_init()).  The new monitor starts in
  capability negotiation mode.

- monitor-remove: Remove a dynamically-added monitor.  CLI-created
  monitors cannot be removed.  The removal sequence is:

  1. Mark dead and remove from mon_list under monitor_lock.  This
     must happen before disconnecting chardev handlers to prevent
     event broadcast from calling monitor_flush_locked() after the
     gcontext reset, which would create an out_watch on the wrong
     GMainContext (see monitor_cancel_out_watch()).
  2. Cancel any pending out_watch while gcontext still points to the
     correct context.
  3. Disconnect chardev handlers.  For self-removal, preserve
     gcontext by passing the iothread GMainContext and keep the
     chardev connection open so the command response can be flushed.
     For normal removal, pass context=NULL and close the connection.
  4. Drain pending requests from any in-flight monitor_qmp_read().
  5. For self-removal, defer destruction to the dispatcher (the
     response must be flushed first).  Otherwise destroy immediately
     via monitor_qmp_destroy().

- query-monitors: Introspect all active monitors with their id, mode,
  chardev name, and whether they were dynamically added.

The motivating use case is systemd-vmspawn: when an external client
requests raw QMP access, vmspawn can create an independent QMP session
on demand rather than pre-allocating spare monitors at launch or
building an id-rewriting proxy.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 monitor/qmp-cmds-control.c | 111 +++++++++++++++++++++++++++++++++++++++++++++
 qapi/control.json          | 104 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 215 insertions(+)

diff --git a/monitor/qmp-cmds-control.c b/monitor/qmp-cmds-control.c
index 150ca9f5cb..c0a3e03aa5 100644
--- a/monitor/qmp-cmds-control.c
+++ b/monitor/qmp-cmds-control.c
@@ -219,3 +219,114 @@ SchemaInfoList *qmp_query_qmp_schema(Error **errp)
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
+    bool self_remove;
+
+    mon = monitor_find_by_id(id);
+    if (!mon) {
+        error_setg(errp, "monitor '%s' not found", id);
+        return;
+    }
+
+    if (!mon->is_qmp) {
+        error_setg(errp, "monitor '%s' is not a QMP monitor", id);
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
+    if (qatomic_read(&qmp_mon->setup_pending)) {
+        error_setg(errp, "monitor '%s' is still initializing", id);
+        return;
+    }
+
+    self_remove = monitor_qmp_dispatcher_is_servicing(qmp_mon);
+
+    /* Remove from mon_list before chardev disconnect. */
+    WITH_QEMU_LOCK_GUARD(&monitor_lock) {
+        mon->dead = true;
+        QTAILQ_REMOVE(&mon_list, mon, entry);
+    }
+
+    /* Cancel out_watch while gcontext still points to the right ctx. */
+    WITH_QEMU_LOCK_GUARD(&mon->mon_lock) {
+        monitor_cancel_out_watch(mon);
+    }
+
+    /*
+     * Clear chardev handlers.  Self-removal preserves gcontext so the
+     * response flush creates out_watch on the correct GMainContext.
+     */
+    if (self_remove) {
+        GMainContext *ctx = mon->use_io_thread
+            ? iothread_get_g_main_context(mon_iothread) : NULL;
+
+        qemu_chr_fe_set_handlers(&mon->chr, NULL, NULL, NULL, NULL,
+                                 NULL, ctx, false);
+    } else {
+        qemu_chr_fe_set_handlers(&mon->chr, NULL, NULL, NULL, NULL,
+                                 NULL, NULL, true);
+    }
+
+    /* Drain requests from any in-flight monitor_qmp_read(). */
+    monitor_qmp_drain_queue(qmp_mon);
+
+    /* Self-removal: defer destruction so the response is flushed first. */
+    if (self_remove) {
+        return;
+    }
+
+    monitor_qmp_destroy(qmp_mon);
+    monitor_fdsets_cleanup();
+}
+
+MonitorInfoList *qmp_query_monitors(Error **errp)
+{
+    MonitorInfoList *list = NULL;
+    Monitor *mon;
+
+    WITH_QEMU_LOCK_GUARD(&monitor_lock) {
+        QTAILQ_FOREACH(mon, &mon_list, entry) {
+            MonitorInfo *info = g_new0(MonitorInfo, 1);
+            Chardev *chr = qemu_chr_fe_get_driver(&mon->chr);
+
+            info->id = g_strdup(mon->id);
+            info->mode = mon->is_qmp ? MONITOR_MODE_CONTROL
+                                     : MONITOR_MODE_READLINE;
+            info->chardev = g_strdup(chr ? chr->label : "unknown");
+            info->dynamic = mon->dynamic;
+            QAPI_LIST_PREPEND(list, info);
+        }
+    }
+
+    return list;
+}
diff --git a/qapi/control.json b/qapi/control.json
index 9a5302193d..fd58b57c31 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -211,3 +211,107 @@
       '*pretty': 'bool',
       'chardev': 'str'
   } }
+
+##
+# @monitor-add:
+#
+# Add a QMP monitor on an existing character device backend.
+#
+# The chardev must already exist (created via chardev-add or CLI).
+# The monitor begins in capability negotiation mode -- the first
+# client to connect receives the QMP greeting.
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


