Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9837EC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh3aP-0002fE-1Y; Tue, 07 Jul 2026 07:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wh3a8-0002Ni-D4
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:03:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wh3a4-00085j-KU
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783422191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pzfn42mHeB75OSSOk8z5ykSeasOmTkQffycd043vnCc=;
 b=hy+y5OLqwi6uyjtqmQSNp/laRpMXhwhpuZcPUwK/tZqcLHwOfh98MhK0nqQ0lHVirFqrJE
 /sQyn2R5ICvqz56iAaGSgGCshfCU1JEefEmeCZopcOL8Mk/LaW3jEPEkMunfBHUUSVOcW3
 oKaboYvjqzHVXGt0ZAeYToH+sju2WQA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-tg2S_ywINuSEmCfVColKtA-1; Tue,
 07 Jul 2026 07:03:10 -0400
X-MC-Unique: tg2S_ywINuSEmCfVColKtA-1
X-Mimecast-MFC-AGG-ID: tg2S_ywINuSEmCfVColKtA_1783422189
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFC0A19540CB
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 11:03:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 492AD1955F7B
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 11:03:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EE32121E64A5; Tue, 07 Jul 2026 13:03:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>
Subject: [PULL 22/35] monitor: eliminate monitor_is_hmp_non_interactive method
Date: Tue,  7 Jul 2026 13:02:47 +0200
Message-ID: <20260707110300.1918153-23-armbru@redhat.com>
In-Reply-To: <20260707110300.1918153-1-armbru@redhat.com>
References: <20260707110300.1918153-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

From: Daniel P. Berrangé <berrange@redhat.com>

The monitor_is_hmp_non_interactive method is used by
monitor_suspend and monitor_resume, to make them a no-op
if the HMP does not use readline.

There are only a handful of callers of suspend/resume and
they can be made to skip the call when readline is not
present.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260706135824.2623960-23-berrange@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/monitor/monitor.h      |  2 +-
 migration/migration-hmp-cmds.c |  5 ++++-
 monitor/hmp-cmds.c             |  5 ++++-
 monitor/hmp.c                  | 11 ++++++++---
 monitor/monitor.c              | 30 +-----------------------------
 5 files changed, 18 insertions(+), 35 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index e802e8dfb2..890497b0d2 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -37,7 +37,7 @@ int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp);
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
index 4636165d0b..a51de8e467 100644
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
index 9b62716033..f1b189c1c2 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -157,25 +157,6 @@ bool monitor_requires_iothread(const Monitor *mon)
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
@@ -550,12 +531,8 @@ static gboolean qapi_event_throttle_equal(const void *a, const void *b)
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
@@ -567,7 +544,6 @@ int monitor_suspend(Monitor *mon)
     }
 
     trace_monitor_suspend(mon, 1);
-    return 0;
 }
 
 static void monitor_accept_input(void *opaque)
@@ -584,10 +560,6 @@ static void monitor_accept_input(void *opaque)
 
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


