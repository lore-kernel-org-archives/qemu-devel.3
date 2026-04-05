Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408E6F3D5E1
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 13:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9NGT-0006WA-Dp; Sun, 05 Apr 2026 09:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1w9NGP-0006Uj-RY
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 09:11:41 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1w9NGN-0006dG-Ns
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 09:11:41 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CBCF46001A;
 Sun,  5 Apr 2026 13:11:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52262C116C6;
 Sun,  5 Apr 2026 13:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775394698;
 bh=5eeDKAFYh38vdP8ude4jd3oT3eRJVXRuSCT4UpRbzbE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=jqs6r/kZ6j3KROo3FMdUXHccfPhtSrtkk8DTbkj9r0AU6+ITnd9API9+Ed8iBLoQ+
 UCTyOmgyUt3XH3N+MYe4uelYh6TLC0sqxp2lo4MwCAuN8Vky/kPv6udhw3aAXobCDc
 wr7V6AW4012UyBnw2RXAdL84zGgdPYveDA6X4K0/f2cw6T0oKSRcT72V4mHwd4XwAx
 LGcv1tyGSHId5D/Gv6CsJAFZ5LZ+2KjYUDz7P9mWn5oQfDha78EPph6iFTPyD4wRj0
 ppxXR+CQ3R0hGzWbj0weAN8TWHhCxVwBxSyJSYnMTzcnxrze5k0y6i1A10QoB1LBHZ
 zUZHUc5Vujsuw==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 05 Apr 2026 15:11:18 +0200
Subject: [PATCH v2 2/5] monitor/qmp: add infrastructure for safe dynamic
 monitor removal
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260405-work-qmp-monitor-hotplug-v2-2-ad5bedd2917a@kernel.org>
References: <20260405-work-qmp-monitor-hotplug-v2-0-ad5bedd2917a@kernel.org>
In-Reply-To: <20260405-work-qmp-monitor-hotplug-v2-0-ad5bedd2917a@kernel.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=13148; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5eeDKAFYh38vdP8ude4jd3oT3eRJVXRuSCT4UpRbzbE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWReim/qO33r9504dv66eVl7g9QNG7Uu7X4o/DYh6WR03
 NXNb6ec7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIk0kM/1OOpt83t/l5fJvw
 zjBXu91XbAIjpBzaVyz/9d/W8tfJjU8ZGaY7TFs6u3ONfumZKwu4X9ZzLVKZ5rxxElthS2zqD7e
 ZrGwA
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

Add monitor_qmp_destroy() to allow destroying a single QMP monitor at
runtime without shutting down the entire dispatcher coroutine.

Convert monitor_accept_input from a oneshot BH (aio_bh_schedule_oneshot)
to a persistent BH (aio_bh_new + qemu_bh_schedule).  Oneshot BHs cannot
be cancelled, so monitor_resume() racing with destruction would schedule
a callback against memory that monitor_qmp_destroy() is about to free.
A persistent BH can be deleted during destruction, cancelling any
pending schedule.

Move qemu_chr_fe_accept_input() under mon_lock in monitor_accept_input()
so it cannot race with monitor_qmp_destroy() which deletes the BH under
the same lock.

Extract monitor_cancel_out_watch() for cancelling a pending out_watch
GSource.  g_source_remove() only searches the default GMainContext but
iothread monitors attach the watch to the iothread context, so
g_main_context_find_source_by_id() with the correct context followed by
g_source_destroy() is needed.  When chardev handlers have been
disconnected via qemu_chr_fe_set_handlers(NULL), s->gcontext is reset to
NULL by qemu_chr_be_update_read_handlers().  A watch created after the
reset (e.g. by a self-removal response flush) lands on the default
GMainContext rather than the iothread context.  Fall back to searching
the default context when the iothread context search misses.

The monitor_qmp_destroy() sequence is:

  1. Delete accept_input_bh (cancel pending resume).
  2. Under mon_lock: set skip_flush so no further writes can create
     new out_watch GSources, then cancel any existing out_watch.
     skip_flush must be set first because the chardev gcontext has
     already been reset to NULL by handler disconnect -- a flush at
     this point would attach the watch to the default GMainContext
     rather than the iothread context, and
     monitor_cancel_out_watch() searching the iothread context would
     miss it, leaking a GSource that fires monitor_unblocked() on
     freed memory.
  3. For iothread monitors: synchronize with the iothread via
     aio_wait_bh_oneshot().  An in-flight monitor_unblocked() GSource
     callback may be blocked on mon_lock (held in step 2) and will
     resume after we release it.  Since BHs cannot fire while a
     GSource callback is dispatching, the no-op BH only runs after
     monitor_unblocked() has returned, making destruction safe.
  4. Final drain of the request queue to catch requests enqueued by an
     in-flight monitor_qmp_read() that raced with the drain in
     qmp_monitor_remove().
  5. monitor_data_destroy() + g_free().

Add qmp_dispatcher_current_mon tracking in the dispatcher coroutine to
handle self-removal (a monitor sends monitor-remove targeting itself).
Both the dispatcher yield points and QMP command handlers run under the
BQL, so no additional locking is needed.  After dispatching each
request, the dispatcher checks the dead flag: if set, it closes the
chardev connection, calls monitor_qmp_destroy(), and clears the tracking
pointer.  monitor_resume() is skipped because the chardev handlers are
already disconnected, and resume would schedule a BH against a monitor
about to be freed.

Add a setup_pending flag for iothread monitors so qmp_monitor_remove()
can reject removal before the setup BH has completed.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 monitor/monitor-internal.h |  6 +++++
 monitor/monitor.c          | 49 ++++++++++++++++++++++++++--------
 monitor/qmp.c              | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+), 11 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 8f5fe7c111..1d9f740abb 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -100,6 +100,7 @@ struct Monitor {
     bool use_io_thread;
     bool dynamic;               /* true if created via monitor-add */
     bool dead;                  /* true if monitor-remove called, awaiting drain */
+    QEMUBH *accept_input_bh;   /* persistent BH for monitor_accept_input() */
 
     char *id;                   /* Monitor identifier (NULL for unnamed CLI monitors) */
     char *mon_cpu_path;
@@ -138,6 +139,7 @@ typedef struct {
     Monitor common;
     JSONMessageParser parser;
     bool pretty;
+    bool setup_pending;  /* iothread BH has not yet set up chardev handlers */
     /*
      * When a client connects, we're in capabilities negotiation mode.
      * @commands is &qmp_cap_negotiation_commands then.  When command
@@ -176,15 +178,19 @@ void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
                        bool use_io_thread);
 void monitor_data_destroy(Monitor *mon);
 int monitor_can_read(void *opaque);
+void monitor_cancel_out_watch(Monitor *mon);
 void monitor_list_append(Monitor *mon);
 void monitor_fdsets_cleanup(void);
 
 void qmp_send_response(MonitorQMP *mon, const QDict *rsp);
 void monitor_data_destroy_qmp(MonitorQMP *mon);
+void monitor_qmp_destroy(MonitorQMP *mon);
+void monitor_qmp_drain_queue(MonitorQMP *mon);
 void coroutine_fn monitor_qmp_dispatcher_co(void *data);
 void qmp_dispatcher_co_wake(void);
 
 Monitor *monitor_find_by_id(const char *id);
+bool monitor_qmp_dispatcher_is_servicing(MonitorQMP *mon);
 
 int get_monitor_def(Monitor *mon, int64_t *pval, const char *name);
 void handle_hmp_command(MonitorHMP *mon, const char *cmdline);
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 7144255e12..0080e8ca0e 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -146,6 +146,28 @@ static gboolean monitor_unblocked(void *do_not_use, GIOCondition cond,
     return G_SOURCE_REMOVE;
 }
 
+/* Cancel a pending out_watch GSource.  Caller must hold mon_lock. */
+void monitor_cancel_out_watch(Monitor *mon)
+{
+    if (mon->out_watch) {
+        GMainContext *ctx = NULL;
+        GSource *src;
+
+        if (mon->use_io_thread) {
+            ctx = iothread_get_g_main_context(mon_iothread);
+        }
+        src = g_main_context_find_source_by_id(ctx, mon->out_watch);
+        if (!src && ctx) {
+            /* Handler disconnect may have reset gcontext to NULL. */
+            src = g_main_context_find_source_by_id(NULL, mon->out_watch);
+        }
+        if (src) {
+            g_source_destroy(src);
+        }
+        mon->out_watch = 0;
+    }
+}
+
 /* Caller must hold mon->mon_lock */
 void monitor_flush_locked(Monitor *mon)
 {
@@ -545,13 +567,13 @@ static void monitor_accept_input(void *opaque)
         MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
         assert(hmp_mon->rs);
         readline_restart(hmp_mon->rs);
+        qemu_chr_fe_accept_input(&mon->chr);
         qemu_mutex_unlock(&mon->mon_lock);
         readline_show_prompt(hmp_mon->rs);
     } else {
+        qemu_chr_fe_accept_input(&mon->chr);
         qemu_mutex_unlock(&mon->mon_lock);
     }
-
-    qemu_chr_fe_accept_input(&mon->chr);
 }
 
 void monitor_resume(Monitor *mon)
@@ -561,15 +583,7 @@ void monitor_resume(Monitor *mon)
     }
 
     if (qatomic_dec_fetch(&mon->suspend_cnt) == 0) {
-        AioContext *ctx;
-
-        if (mon->use_io_thread) {
-            ctx = iothread_get_aio_context(mon_iothread);
-        } else {
-            ctx = qemu_get_aio_context();
-        }
-
-        aio_bh_schedule_oneshot(ctx, monitor_accept_input, mon);
+        qemu_bh_schedule(mon->accept_input_bh);
     }
 
     trace_monitor_suspend(mon, -1);
@@ -610,6 +624,8 @@ static void monitor_iothread_init(void)
 void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
                        bool use_io_thread)
 {
+    AioContext *ctx;
+
     if (use_io_thread && !mon_iothread) {
         monitor_iothread_init();
     }
@@ -618,6 +634,13 @@ void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
     mon->outbuf = g_string_new(NULL);
     mon->skip_flush = skip_flush;
     mon->use_io_thread = use_io_thread;
+
+    if (use_io_thread) {
+        ctx = iothread_get_aio_context(mon_iothread);
+    } else {
+        ctx = qemu_get_aio_context();
+    }
+    mon->accept_input_bh = aio_bh_new(ctx, monitor_accept_input, mon);
 }
 
 void monitor_data_destroy(Monitor *mon)
@@ -631,6 +654,10 @@ void monitor_data_destroy(Monitor *mon)
         readline_free(container_of(mon, MonitorHMP, common)->rs);
     }
     g_string_free(mon->outbuf, true);
+    if (mon->accept_input_bh) {
+        qemu_bh_delete(mon->accept_input_bh);
+        mon->accept_input_bh = NULL;
+    }
     qemu_mutex_destroy(&mon->mon_lock);
 }
 
diff --git a/monitor/qmp.c b/monitor/qmp.c
index afbe2283d6..6645b82d48 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -26,6 +26,7 @@
 
 #include "chardev/char-io.h"
 #include "monitor-internal.h"
+#include "qemu/aio-wait.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-control.h"
 #include "qobject/qdict.h"
@@ -71,6 +72,9 @@ typedef struct QMPRequest QMPRequest;
 
 QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
 
+/* Monitor being serviced by the dispatcher.  Protected by BQL. */
+static MonitorQMP *qmp_dispatcher_current_mon;
+
 static bool qmp_oob_enabled(MonitorQMP *mon)
 {
     return mon->capab[QMP_CAPABILITY_OOB];
@@ -98,6 +102,12 @@ static void monitor_qmp_cleanup_req_queue_locked(MonitorQMP *mon)
     }
 }
 
+void monitor_qmp_drain_queue(MonitorQMP *mon)
+{
+    QEMU_LOCK_GUARD(&mon->qmp_queue_lock);
+    monitor_qmp_cleanup_req_queue_locked(mon);
+}
+
 static void monitor_qmp_cleanup_queue_and_resume(MonitorQMP *mon)
 {
     QEMU_LOCK_GUARD(&mon->qmp_queue_lock);
@@ -287,6 +297,7 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
          */
 
         mon = req_obj->mon;
+        qmp_dispatcher_current_mon = mon;
 
         /*
          * We need to resume the monitor if handle_qmp_command()
@@ -342,11 +353,26 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
             qobject_unref(rsp);
         }
 
+        /*
+         * Self-removal: monitor-remove marked this monitor dead.
+         * Close chardev, destroy, skip monitor_resume().
+         */
+        if (mon->common.dead) {
+            qemu_chr_fe_set_handlers(&mon->common.chr, NULL, NULL,
+                                     NULL, NULL, NULL, NULL, true);
+            qmp_request_free(req_obj);
+            monitor_qmp_destroy(mon);
+            monitor_fdsets_cleanup();
+            qmp_dispatcher_current_mon = NULL;
+            continue;
+        }
+
         if (!oob_enabled) {
             monitor_resume(&mon->common);
         }
 
         qmp_request_free(req_obj);
+        qmp_dispatcher_current_mon = NULL;
     }
     qatomic_set(&qmp_dispatcher_co, NULL);
 }
@@ -499,6 +525,44 @@ void monitor_data_destroy_qmp(MonitorQMP *mon)
     g_queue_free(mon->qmp_requests);
 }
 
+static void monitor_qmp_iothread_quiesce(void *opaque)
+{
+    /* No-op: synchronization point only */
+}
+
+/*
+ * Destroy a single dynamically-added QMP monitor.
+ * The monitor must already have been removed from mon_list.
+ */
+void monitor_qmp_destroy(MonitorQMP *mon)
+{
+    qemu_bh_delete(mon->common.accept_input_bh);
+    mon->common.accept_input_bh = NULL;
+
+    WITH_QEMU_LOCK_GUARD(&mon->common.mon_lock) {
+        /* Disable flushes before cancel — gcontext is already wrong. */
+        mon->common.skip_flush = true;
+        monitor_cancel_out_watch(&mon->common);
+    }
+
+    /* Synchronize with in-flight iothread callbacks. */
+    if (mon->common.use_io_thread) {
+        aio_wait_bh_oneshot(iothread_get_aio_context(mon_iothread),
+                            monitor_qmp_iothread_quiesce, NULL);
+    }
+
+    /* Catch requests from a racing monitor_qmp_read(). */
+    monitor_qmp_drain_queue(mon);
+
+    monitor_data_destroy(&mon->common);
+    g_free(mon);
+}
+
+bool monitor_qmp_dispatcher_is_servicing(MonitorQMP *mon)
+{
+    return qmp_dispatcher_current_mon == mon;
+}
+
 static void monitor_qmp_setup_handlers_bh(void *opaque)
 {
     MonitorQMP *mon = opaque;
@@ -510,6 +574,7 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
     qemu_chr_fe_set_handlers(&mon->common.chr, monitor_can_read,
                              monitor_qmp_read, monitor_qmp_event,
                              NULL, &mon->common, context, true);
+    qatomic_set(&mon->setup_pending, false);
 }
 
 void monitor_init_qmp(Chardev *chr, bool pretty, const char *id,
@@ -553,6 +618,7 @@ void monitor_init_qmp(Chardev *chr, bool pretty, const char *id,
          * since chardev might be running in the monitor I/O
          * thread.  Schedule a bottom half.
          */
+        mon->setup_pending = true;
         aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
                                 monitor_qmp_setup_handlers_bh, mon);
         /* Synchronous insert for immediate duplicate detection. */

-- 
2.47.3


