Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB4DCDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcRZT-00087i-GZ; Wed, 24 Jun 2026 13:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcRZR-0007wx-BR
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:39:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcRZP-0004Zb-5y
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782322766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=49VmJdPBQFt7XW7Zwm56uj3jkNQpAb7KfbJJGWpDGNc=;
 b=hiX3vxSNmHyG7DVMO9OPxfn6XLpJgb6zAdDhkKr8/Q89vqXkHlWVbAjfooj14dH2hPZOnV
 UFGMf/sA6kOvX2MQmEnFUWqw76nABKolv8optD92GHVq5hhN7Ea0W+I115DLAeaRq5is2n
 8r6ouGtq/EV4axuhHi/33IFAJAIWAXU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-RwPXa1d8MUuOBAgAK-vKMw-1; Wed,
 24 Jun 2026 13:39:24 -0400
X-MC-Unique: RwPXa1d8MUuOBAgAK-vKMw-1
X-Mimecast-MFC-AGG-ID: RwPXa1d8MUuOBAgAK-vKMw_1782322763
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95D771954237; Wed, 24 Jun 2026 17:39:23 +0000 (UTC)
Received: from berrange.com (unknown [10.44.32.102])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5532A180034F; Wed, 24 Jun 2026 17:39:20 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Brauner <brauner@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>
Subject: [PATCH v5 21/35] monitor: eliminate monitor_is_hmp_non_interactive
 method
Date: Wed, 24 Jun 2026 18:37:37 +0100
Message-ID: <20260624173752.2928717-22-berrange@redhat.com>
In-Reply-To: <20260624173752.2928717-1-berrange@redhat.com>
References: <20260624173752.2928717-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
they can be made to skip the call when readline is not
present.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/monitor/monitor.h      |  2 +-
 migration/migration-hmp-cmds.c |  5 ++++-
 monitor/hmp-cmds.c             |  5 ++++-
 monitor/hmp.c                  | 11 ++++++++---
 monitor/monitor.c              | 30 +-----------------------------
 5 files changed, 18 insertions(+), 35 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 3f730cffee..ffda343585 100644
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
index 8b385f560e..502ca704da 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -19,6 +19,7 @@
 #include "monitor/hmp.h"
 #include "monitor/hmp-completion.h"
 #include "monitor/monitor.h"
+#include "monitor/monitor-internal.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-visit-migration.h"
@@ -853,12 +854,14 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
 
     if (!detach) {
         HMPMigrationStatus *status;
+        MonitorHMP *hmp = MONITOR_HMP(mon);
 
-        if (monitor_suspend(mon) < 0) {
+        if (!hmp->use_readline) {
             monitor_printf(mon, "terminal does not allow synchronous "
                            "migration, continuing detached\n");
             return;
         }
+        monitor_suspend(mon);
 
         status = g_malloc0(sizeof(*status));
         status->mon = mon;
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index e139caeba9..e9fb8d827a 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -129,7 +129,10 @@ void hmp_info_version(Monitor *mon, const QDict *qdict)
 
 void hmp_quit(Monitor *mon, const QDict *qdict)
 {
-    monitor_suspend(mon);
+    MonitorHMP *hmp = MONITOR_HMP(mon);
+    if (hmp->use_readline) {
+        monitor_suspend(mon);
+    }
     qmp_quit(NULL);
 }
 
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 1da9370ead..b8cccdcde3 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1528,13 +1528,16 @@ static void monitor_read(void *opaque, const uint8_t *buf, int size)
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
+            if (hmp->use_readline) {
+                monitor_resume(mon);
+            }
         }
         qemu_mutex_unlock(&mon->mon_lock);
         break;
@@ -1547,7 +1550,9 @@ static void monitor_event(void *opaque, QEMUChrEvent event)
             } else {
                 monitor_flush_locked(mon);
             }
-            monitor_suspend(mon);
+            if (hmp->use_readline) {
+                monitor_suspend(mon);
+            }
             mon->mux_out = 1;
         }
         qemu_mutex_unlock(&mon->mon_lock);
@@ -1558,7 +1563,7 @@ static void monitor_event(void *opaque, QEMUChrEvent event)
                        "information\n", QEMU_VERSION);
         qemu_mutex_lock(&mon->mon_lock);
         mon->reset_seen = 1;
-        if (!mon->mux_out) {
+        if (!mon->mux_out && hmp->use_readline) {
             /* Suspend-resume forces the prompt to be printed.  */
             monitor_suspend(mon);
             monitor_resume(mon);
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 6ed586fc4f..f88364a574 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -155,25 +155,6 @@ bool monitor_requires_iothread(const Monitor *mon)
     return cls->requires_iothread && cls->requires_iothread(mon);
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
-    return !monitor_uses_readline(container_of(mon, MonitorHMP, parent_obj));
-}
-
 static gboolean monitor_unblocked(void *do_not_use, GIOCondition cond,
                                   void *opaque)
 {
@@ -548,12 +529,8 @@ static gboolean qapi_event_throttle_equal(const void *a, const void *b)
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
 
     if (monitor_requires_iothread(mon)) {
@@ -565,7 +542,6 @@ int monitor_suspend(Monitor *mon)
     }
 
     trace_monitor_suspend(mon, 1);
-    return 0;
 }
 
 static void monitor_accept_input(void *opaque)
@@ -582,10 +558,6 @@ static void monitor_accept_input(void *opaque)
 
 void monitor_resume(Monitor *mon)
 {
-    if (monitor_is_hmp_non_interactive(mon)) {
-        return;
-    }
-
     if (qatomic_dec_fetch(&mon->suspend_cnt) == 0) {
         AioContext *ctx;
 
-- 
2.54.0


