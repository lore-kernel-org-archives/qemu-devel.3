Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AAAE9DE5C
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 07:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAjfJ-0007Mq-Qf; Thu, 09 Apr 2026 03:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1wAjfA-0007Lk-CP
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 03:18:52 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1wAjf6-0000ZG-8M
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 03:18:51 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 79B4760125;
 Thu,  9 Apr 2026 07:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F92C4CEF7;
 Thu,  9 Apr 2026 07:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775719120;
 bh=vfa+TrNtrxBo2wYtO9pePlx356JM3/1McvzEe45+0lQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=R+I7mmn2eGGTUwosgGWt6r6ZOVNsu2rSXUZfjCAk3GDGsF8UIP7uAJfnJ0QD4S0KR
 gF3CqwpNEMP49dFiPFNpfdHN5/9Tybg64S2u9SnIYkOSQLScFSOV+MofJZQLm44Tj1
 C/kTLWVTS/oSrRZysDZ88bELHl4jf3w8iucR5Xcn6OoQhSurPAtuXf9huzXx2gZjdH
 KZrD3M8+BoMul2zEOiFgG+Cb2tntKygu9TujWZZxzsCymYlzDONIEx7UcGUCeBlAn2
 mKS070yXoUUAupKvOjojrCaJdnVhiAEwcplvZhahugt35wu+XCts1QKjC+UhAZLS68
 R+U13ZDEjuFvg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 09 Apr 2026 09:18:20 +0200
Subject: [PATCH v4 3/5] qapi: add monitor-add, monitor-remove,
 query-monitors commands
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-work-qmp-monitor-hotplug-v4-3-89c4fdf69df1@kernel.org>
References: <20260409-work-qmp-monitor-hotplug-v4-0-89c4fdf69df1@kernel.org>
In-Reply-To: <20260409-work-qmp-monitor-hotplug-v4-0-89c4fdf69df1@kernel.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7958; i=brauner@kernel.org;
 h=from:subject:message-id; bh=vfa+TrNtrxBo2wYtO9pePlx356JM3/1McvzEe45+0lQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWReDzo6N1ry61WT19qz7A5qaSZy7atdpcUTcKVNak+Sx
 EOelb4rOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayT5aR4c1WjbpHno/lp3iz
 SzvPmJt3olRAu2n+jcn1kxe+UJY/WsHwi+m8RNo3/ufsO9ex/ymzLSqwc4g8Y3Oy6uqE9JyEuX7
 BjAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Received-SPF: pass client-ip=172.105.4.254; envelope-from=brauner@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Add QMP commands for monitor lifecycle management:

- monitor-add: Create a QMP monitor on an existing chardev at runtime.
  The chardev must exist and not already have a frontend attached
  (enforced by qemu_chr_fe_init()).  The new monitor starts in
  capability negotiation mode.

- monitor-remove: Remove a QMP monitor.  The removal sequence is:

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
  and chardev name.

The motivating use case is systemd-vmspawn: when an external client
requests raw QMP access, vmspawn can create an independent QMP session
on demand rather than pre-allocating spare monitors at launch or
building an id-rewriting proxy.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 monitor/qmp-cmds-control.c | 105 +++++++++++++++++++++++++++++++++++++++++++++
 qapi/control.json          |  97 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 202 insertions(+)

diff --git a/monitor/qmp-cmds-control.c b/monitor/qmp-cmds-control.c
index 150ca9f5cb..33d02c8fb6 100644
--- a/monitor/qmp-cmds-control.c
+++ b/monitor/qmp-cmds-control.c
@@ -219,3 +219,108 @@ SchemaInfoList *qmp_query_qmp_schema(Error **errp)
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
+    monitor_init_qmp(chr, has_pretty && pretty, id, errp);
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
+            QAPI_LIST_PREPEND(list, info);
+        }
+    }
+
+    return list;
+}
diff --git a/qapi/control.json b/qapi/control.json
index 9a5302193d..eb4a30b59e 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -211,3 +211,100 @@
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
+#     - If @id is already in use
+#     - If @chardev does not exist
+#
+# Since: 11.1
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
+# Remove a QMP monitor.
+#
+# The underlying chardev is NOT removed -- use chardev-remove
+# separately if desired.
+#
+# If a client is currently connected, the connection is dropped.
+#
+# @id: Monitor identifier
+#
+# Errors:
+#     - If @id does not exist
+#     - If the monitor is not a QMP monitor
+#
+# Since: 11.1
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
+# @id: Monitor identifier.  Always present for QMP monitors (auto-
+#     generated if not explicitly set).  Absent for HMP monitors.
+#
+# @mode: Monitor mode (readline or control)
+#
+# @chardev: Name of the attached character device
+#
+# Since: 11.1
+##
+{ 'struct': 'MonitorInfo',
+  'data': { '*id': 'str',
+            'mode': 'MonitorMode',
+            'chardev': 'str' } }
+
+##
+# @query-monitors:
+#
+# Return information about all active monitors.
+#
+# Returns: a list of @MonitorInfo for each active monitor
+#
+# Since: 11.1
+#
+# .. qmp-example::
+#
+#     -> { "execute": "query-monitors" }
+#     <- { "return": [ { "id": "mon0", "mode": "control",
+#                        "chardev": "compat_monitor0" } ] }
+##
+{ 'command': 'query-monitors',
+  'returns': ['MonitorInfo'] }

-- 
2.47.3


