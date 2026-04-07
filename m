Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0B7FF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABXH-00008a-M7; Tue, 07 Apr 2026 14:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1wABTx-0002iK-6r
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:49:01 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1wA0vo-0007bc-Tw
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 03:33:06 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 92EFE434F8;
 Tue,  7 Apr 2026 07:33:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27962C2BC9E;
 Tue,  7 Apr 2026 07:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775547183;
 bh=G81uyv8r5lRSGGkc7QTHuaYAIIqRbuYMdg2xyWaslgI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=abaXlLO2QBi3KtcwXrha7OiatW8C8D3wyeoVOtM+kbqHcHk7PSXU45fyY4LN/kfbc
 KHzu7+Y+n6Edp4w7Fttl3pWC5AsCABeckZc5pf7IjuAdwFeEEqBa95JmN41k4L+aQq
 5C1islo66fOrVDzh/ALUM0qOmFLlK87s2ZYlFcmlT8mz03CcDhD3WHNmrS/7JjgfWA
 6xkKkYY2G6VBGMz1qE6yBHA+qpOrzmeeDe6DlB2NqwXVG0M9qVrTo8ZIG82r+T1xxk
 60d2L6RtCkRrwNv6gfAprGIULpxiTAD1xp3SBJIv7sf/Pf+IBYFn/3RRsuFVO7lQz+
 u47wLOgNOysWQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 07 Apr 2026 09:32:45 +0200
Subject: [PATCH v3 1/5] monitor: store monitor id and dynamic flag in
 Monitor struct
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-work-qmp-monitor-hotplug-v3-1-cb259800fffb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7226; i=brauner@kernel.org;
 h=from:subject:message-id; bh=G81uyv8r5lRSGGkc7QTHuaYAIIqRbuYMdg2xyWaslgI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRe2azJedBxWVpSEE9T55pXNW3eMqk7WY7NFhDOD3D6d
 URG9jtvRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERufWFkeNWwV2N3gWnpw8v3
 Eh/4M1yY7T4jrmav8VS280mX07tvxDAy3JVe8nePvNA3iRyPc5xpy+femirsPfPv07M/ryyLz17
 kywsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Received-SPF: pass client-ip=172.234.252.31; envelope-from=brauner@kernel.org;
 helo=sea.source.kernel.org
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

Add 'id', 'dynamic', and 'dead' fields to struct Monitor. The id field
stores the monitor identifier from MonitorOptions which was previously
parsed but discarded. The dynamic flag marks monitors created at runtime
via the upcoming monitor-add command, and the dead flag will be used for
deferred destruction during monitor-remove.

Extend monitor_init_qmp() to accept id and dynamic parameters so these
are set before the monitor is added to mon_list.

For iothread monitors, move monitor_list_append() from the setup BH to
the caller so monitor_find_by_id() can detect duplicates immediately.
Without this, two concurrent monitor-add calls could both pass the
duplicate check before either BH runs.  This means the monitor is now
visible in mon_list before its chardev handlers are set up, which was
not the case before.  This is safe because the request queue is still
empty (no chardev handlers means no monitor_qmp_read(), so the
dispatcher finds nothing to dispatch) and event broadcast is handled
below.

This requires initializing mon->commands = &qmp_cap_negotiation_commands
before monitor_list_append().  Without it, commands is NULL (from
g_new0) and monitor_qapi_event_emit() would not skip the monitor during
event broadcast -- its check is specifically for the
qmp_cap_negotiation_commands pointer, so a NULL falls through to
qmp_send_response() on an uninitialized monitor.  CHR_EVENT_OPENED sets
commands to the same value again later.

Add monitor_find_by_id() to look up monitors by identifier.  The lookup
takes monitor_lock to serialize with the I/O thread BH that modifies
mon_list, but releases it before returning.  The caller must hold the
BQL to ensure the returned pointer remains valid since only BQL holders
can destroy monitors.

Free the id string in monitor_data_destroy().

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 include/monitor/monitor.h  |  3 ++-
 monitor/monitor-internal.h |  5 +++++
 monitor/monitor.c          | 21 ++++++++++++++++++++-
 monitor/qmp.c              | 11 ++++++++---
 4 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 296690e1f1..7a2bb603e4 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -19,7 +19,8 @@ bool monitor_cur_is_qmp(void);
 
 void monitor_init_globals(void);
 void monitor_init_globals_core(void);
-void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp);
+void monitor_init_qmp(Chardev *chr, bool pretty, const char *id,
+                      bool dynamic, Error **errp);
 void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp);
 int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp);
 int monitor_init_opts(QemuOpts *opts, Error **errp);
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index feca111ae3..4896812d4e 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -98,7 +98,10 @@ struct Monitor {
     bool is_qmp;
     bool skip_flush;
     bool use_io_thread;
+    bool dynamic;           /* true if created via monitor-add */
+    bool dead;              /* awaiting drain after monitor-remove */
 
+    char *id;               /* NULL for unnamed CLI monitors */
     char *mon_cpu_path;
     QTAILQ_ENTRY(Monitor) entry;
 
@@ -181,6 +184,8 @@ void monitor_data_destroy_qmp(MonitorQMP *mon);
 void coroutine_fn monitor_qmp_dispatcher_co(void *data);
 void qmp_dispatcher_co_wake(void);
 
+Monitor *monitor_find_by_id(const char *id);
+
 int get_monitor_def(Monitor *mon, int64_t *pval, const char *name);
 void handle_hmp_command(MonitorHMP *mon, const char *cmdline);
 int hmp_compare_cmd(const char *name, const char *list);
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 00b93ed612..7144255e12 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -622,6 +622,7 @@ void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
 
 void monitor_data_destroy(Monitor *mon)
 {
+    g_free(mon->id);
     g_free(mon->mon_cpu_path);
     qemu_chr_fe_deinit(&mon->chr, false);
     if (monitor_is_qmp(mon)) {
@@ -633,6 +634,24 @@ void monitor_data_destroy(Monitor *mon)
     qemu_mutex_destroy(&mon->mon_lock);
 }
 
+/*
+ * Look up a monitor by its id.  The monitor_lock is released before
+ * returning, so the caller must hold the BQL to ensure the returned
+ * pointer remains valid (only BQL holders can destroy monitors).
+ */
+Monitor *monitor_find_by_id(const char *id)
+{
+    Monitor *mon;
+
+    QEMU_LOCK_GUARD(&monitor_lock);
+    QTAILQ_FOREACH(mon, &mon_list, entry) {
+        if (mon->id && strcmp(mon->id, id) == 0) {
+            return mon;
+        }
+    }
+    return NULL;
+}
+
 void monitor_cleanup(void)
 {
     /*
@@ -732,7 +751,7 @@ int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp)
 
     switch (opts->mode) {
     case MONITOR_MODE_CONTROL:
-        monitor_init_qmp(chr, opts->pretty, errp);
+        monitor_init_qmp(chr, opts->pretty, opts->id, false, errp);
         break;
     case MONITOR_MODE_READLINE:
         if (!allow_hmp) {
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 687019811f..afbe2283d6 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -510,10 +510,10 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
     qemu_chr_fe_set_handlers(&mon->common.chr, monitor_can_read,
                              monitor_qmp_read, monitor_qmp_event,
                              NULL, &mon->common, context, true);
-    monitor_list_append(&mon->common);
 }
 
-void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
+void monitor_init_qmp(Chardev *chr, bool pretty, const char *id,
+                      bool dynamic, Error **errp)
 {
     MonitorQMP *mon = g_new0(MonitorQMP, 1);
 
@@ -527,12 +527,16 @@ void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
     monitor_data_init(&mon->common, true, false,
                       qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT));
 
+    mon->common.id = g_strdup(id);
+    mon->common.dynamic = dynamic;
     mon->pretty = pretty;
 
     qemu_mutex_init(&mon->qmp_queue_lock);
     mon->qmp_requests = g_queue_new();
 
     json_message_parser_init(&mon->parser, handle_qmp_command, mon, NULL);
+    /* Prevent event broadcast to an uninitialized monitor. */
+    mon->commands = &qmp_cap_negotiation_commands;
     if (mon->common.use_io_thread) {
         /*
          * Make sure the old iowatch is gone.  It's possible when
@@ -551,7 +555,8 @@ void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
          */
         aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
                                 monitor_qmp_setup_handlers_bh, mon);
-        /* The bottom half will add @mon to @mon_list */
+        /* Synchronous insert for immediate duplicate detection. */
+        monitor_list_append(&mon->common);
     } else {
         qemu_chr_fe_set_handlers(&mon->common.chr, monitor_can_read,
                                  monitor_qmp_read, monitor_qmp_event,

-- 
2.47.3


