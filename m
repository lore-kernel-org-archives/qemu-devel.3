Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9DFF459F7
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 16:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBENY-0005Nt-9f; Fri, 10 Apr 2026 12:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wBEN6-0004ST-3g
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 12:06:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wBEN2-0006au-S6
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 12:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775837168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CTXWR1q0+DOQ7/YKsNUH2tLiIcL9JM619frqTvcBYQ0=;
 b=Cq5utwsJQvGPvfPNiD5s+KhlqZIrCB7ihZ0gMEUiKkjagTULxHT+blQWkaRNfzD4/3yVMy
 u6P63teU8RumHyjk3a1DMnTUtUAtvJI0hnDbaxFSF+4eF0+Acc75NU3EIa5klspaSBEyeO
 JCKjPb8Alkwe2be5qUgp/qwCM/Ks3S4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-SFpPaZ2PPGmISU_B3sNI7A-1; Fri,
 10 Apr 2026 12:06:05 -0400
X-MC-Unique: SFpPaZ2PPGmISU_B3sNI7A-1
X-Mimecast-MFC-AGG-ID: SFpPaZ2PPGmISU_B3sNI7A_1775837164
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8FBC1956095; Fri, 10 Apr 2026 16:06:03 +0000 (UTC)
Received: from toolbx.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8945A1956056; Fri, 10 Apr 2026 16:06:00 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Christian Brauner <brauner@kernel.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH 16/17] monitor: eliminate monitor_is_hmp_non_interactive method
Date: Fri, 10 Apr 2026 17:04:57 +0100
Message-ID: <20260410160458.3778874-17-berrange@redhat.com>
In-Reply-To: <20260410160458.3778874-1-berrange@redhat.com>
References: <20260410160458.3778874-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The monitor_is_hmp_non_interactive method is used by
monitor_suspend and monitor_resume, to make them a no-op
if the HMP does not use readline.

There are only a handful of callers of suspend/resume and
they can be made to skip the call with readline is not
present.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/monitor/monitor.h      |  2 +-
 migration/migration-hmp-cmds.c |  5 ++++-
 monitor/hmp-cmds.c             |  5 ++++-
 monitor/hmp.c                  | 14 +++++++++-----
 monitor/monitor-internal.h     |  1 -
 monitor/monitor.c              | 30 +-----------------------------
 6 files changed, 19 insertions(+), 38 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index f66e465775..52df053c6d 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -34,7 +34,7 @@ int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp);
 int monitor_new_opts(QemuOpts *opts, Error **errp);
 void monitor_cleanup(void);
 
-int monitor_suspend(Monitor *mon);
+void monitor_suspend(Monitor *mon);
 void monitor_resume(Monitor *mon);
 
 int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp);
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 0a193b8f54..e9bb970b20 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -18,6 +18,7 @@
 #include "migration/snapshot.h"
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
+#include "monitor/monitor-internal.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-visit-migration.h"
@@ -836,12 +837,14 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
 
     if (!detach) {
         HMPMigrationStatus *status;
+        MonitorHMP *hmp = MONITOR_HMP(mon);
 
-        if (monitor_suspend(mon) < 0) {
+        if (!hmp->rs) {
             monitor_printf(mon, "terminal does not allow synchronous "
                            "migration, continuing detached\n");
             return;
         }
+        monitor_suspend(mon);
 
         status = g_malloc0(sizeof(*status));
         status->mon = mon;
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 911d984cbe..a6314c1159 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -90,7 +90,10 @@ void hmp_info_version(Monitor *mon, const QDict *qdict)
 
 void hmp_quit(Monitor *mon, const QDict *qdict)
 {
-    monitor_suspend(mon);
+    MonitorHMP *hmp = MONITOR_HMP(mon);
+    if (hmp->rs) {
+        monitor_suspend(mon);
+    }
     qmp_quit(NULL);
 }
 
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 5f9373a87b..387dab2567 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1491,13 +1491,16 @@ static void monitor_read(void *opaque, const uint8_t *buf, int size)
 static void monitor_event(void *opaque, QEMUChrEvent event)
 {
     Monitor *mon = opaque;
+    MonitorHMP *hmp = MONITOR_HMP(mon);
 
     switch (event) {
     case CHR_EVENT_MUX_IN:
         qemu_mutex_lock(&mon->mon_lock);
         if (mon->mux_out) {
             mon->mux_out = 0;
-            monitor_resume(mon);
+            if (hmp->rs) {
+                monitor_resume(mon);
+            }
         }
         qemu_mutex_unlock(&mon->mon_lock);
         break;
@@ -1510,7 +1513,9 @@ static void monitor_event(void *opaque, QEMUChrEvent event)
             } else {
                 monitor_flush_locked(mon);
             }
-            monitor_suspend(mon);
+            if (hmp->rs) {
+                monitor_suspend(mon);
+            }
             mon->mux_out = 1;
         }
         qemu_mutex_unlock(&mon->mon_lock);
@@ -1521,7 +1526,7 @@ static void monitor_event(void *opaque, QEMUChrEvent event)
                        "information\n", QEMU_VERSION);
         qemu_mutex_lock(&mon->mon_lock);
         mon->reset_seen = 1;
-        if (!mon->mux_out) {
+        if (!mon->mux_out && hmp->rs) {
             /* Suspend-resume forces the prompt to be printed.  */
             monitor_suspend(mon);
             monitor_resume(mon);
@@ -1569,8 +1574,7 @@ void monitor_new_hmp(Chardev *chr, bool use_readline, Error **errp)
         return;
     }
 
-    mon->use_readline = use_readline;
-    if (mon->use_readline) {
+    if (use_readline) {
         mon->rs = readline_init(monitor_readline_printf,
                                 monitor_readline_flush,
                                 mon,
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index d40fdde793..7557deb978 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -133,7 +133,6 @@ struct MonitorHMPClass {
 
 struct MonitorHMP {
     Monitor parent;
-    bool use_readline;
     /*
      * State used only in the thread "owning" the monitor.
      * If @use_io_thread, this is @mon_iothread. (This does not actually happen
diff --git a/monitor/monitor.c b/monitor/monitor.c
index f48603a7e8..3860486a32 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -130,25 +130,6 @@ Monitor *monitor_set_cur(Coroutine *co, Monitor *mon)
     return old_monitor;
 }
 
-/**
- * Is @mon is using readline?
- * Note: not all HMP monitors use readline, e.g., gdbserver has a
- * non-interactive HMP monitor, so readline is not used there.
- */
-static inline bool monitor_uses_readline(const MonitorHMP *mon)
-{
-    return mon->use_readline;
-}
-
-static inline bool monitor_is_hmp_non_interactive(const Monitor *mon)
-{
-    if (!object_dynamic_cast(OBJECT(mon), TYPE_MONITOR_HMP)) {
-        return false;
-    }
-
-    return !monitor_uses_readline(container_of(mon, MonitorHMP, parent));
-}
-
 static gboolean monitor_unblocked(void *do_not_use, GIOCondition cond,
                                   void *opaque)
 {
@@ -523,12 +504,8 @@ static gboolean qapi_event_throttle_equal(const void *a, const void *b)
     return TRUE;
 }
 
-int monitor_suspend(Monitor *mon)
+void monitor_suspend(Monitor *mon)
 {
-    if (monitor_is_hmp_non_interactive(mon)) {
-        return -ENOTTY;
-    }
-
     qatomic_inc(&mon->suspend_cnt);
 
     if (mon->use_io_thread) {
@@ -540,7 +517,6 @@ int monitor_suspend(Monitor *mon)
     }
 
     trace_monitor_suspend(mon, 1);
-    return 0;
 }
 
 static void monitor_accept_input(void *opaque)
@@ -557,10 +533,6 @@ static void monitor_accept_input(void *opaque)
 
 void monitor_resume(Monitor *mon)
 {
-    if (monitor_is_hmp_non_interactive(mon)) {
-        return;
-    }
-
     if (qatomic_dec_fetch(&mon->suspend_cnt) == 0) {
         AioContext *ctx;
 
-- 
2.53.0


