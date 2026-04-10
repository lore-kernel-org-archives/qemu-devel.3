Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04FEEF459EF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 16:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBEMJ-0003x8-0n; Fri, 10 Apr 2026 12:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wBEM8-0003px-9p
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 12:05:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wBEM6-0006M0-5Z
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 12:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775837113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aRJW94BUf8Tz2S/adz1Cib0l764nc871m2W8dw3Kss0=;
 b=PyTQ51Y6M4nz7xS8Jry/5J2fhx1TEFa5SVQKg+GY3z+J0K0DROq5RsnRG96I1hHf0N6i/3
 LAb4KzzmI7dkk8/saAcnxq6/ZCOtzsQJaul+RUqSGDGtx8zU2ToljwzGaSoLwSmZ1JFxqY
 INuUti5Tqeqw8A3fKUdWzQv5m0np0Kc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-khvHcJw0O2uenKySzOIEOQ-1; Fri,
 10 Apr 2026 12:05:09 -0400
X-MC-Unique: khvHcJw0O2uenKySzOIEOQ-1
X-Mimecast-MFC-AGG-ID: khvHcJw0O2uenKySzOIEOQ_1775837108
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 055E719560BA; Fri, 10 Apr 2026 16:05:08 +0000 (UTC)
Received: from toolbx.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 71F8319560AB; Fri, 10 Apr 2026 16:05:04 +0000 (UTC)
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
Subject: [PATCH 01/17] monitor: replace 'common' with 'parent' in MonitorHMP
Date: Fri, 10 Apr 2026 17:04:42 +0100
Message-ID: <20260410160458.3778874-2-berrange@redhat.com>
In-Reply-To: <20260410160458.3778874-1-berrange@redhat.com>
References: <20260410160458.3778874-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The field name 'parent' is standard practice for QOM structs
so align the HMP monitor.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 monitor/hmp-cmds.c         |  2 +-
 monitor/hmp.c              | 40 +++++++++++++++++++-------------------
 monitor/monitor-internal.h |  2 +-
 monitor/monitor.c          |  6 +++---
 monitor/qmp-cmds.c         | 10 +++++-----
 ui/ui-hmp-cmds.c           |  2 +-
 6 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index bc26b39d70..911d984cbe 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -236,7 +236,7 @@ void hmp_info_sync_profile(Monitor *mon, const QDict *qdict)
 
 void hmp_info_history(Monitor *mon, const QDict *qdict)
 {
-    MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
+    MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, parent);
     int i;
     const char *str;
 
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 0e5913fabb..af346d190b 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -47,9 +47,9 @@ static void monitor_command_cb(void *opaque, const char *cmdline,
 {
     MonitorHMP *mon = opaque;
 
-    monitor_suspend(&mon->common);
+    monitor_suspend(&mon->parent);
     handle_hmp_command(mon, cmdline);
-    monitor_resume(&mon->common);
+    monitor_resume(&mon->parent);
 }
 
 void monitor_read_command(MonitorHMP *mon, int show_prompt)
@@ -72,7 +72,7 @@ int monitor_read_password(MonitorHMP *mon, ReadLineFunc *readline_func,
         /* prompt is printed on return from the command handler */
         return 0;
     } else {
-        monitor_printf(&mon->common,
+        monitor_printf(&mon->parent,
                        "terminal does not support password prompting\n");
         return -ENOTTY;
     }
@@ -689,7 +689,7 @@ static const HMPCommand *monitor_parse_command(MonitorHMP *hmp_mon,
                                                const char **cmdp,
                                                HMPCommand *table)
 {
-    Monitor *mon = &hmp_mon->common;
+    Monitor *mon = &hmp_mon->parent;
     const char *p;
     const HMPCommand *cmd;
     char cmdname[256];
@@ -1182,35 +1182,35 @@ void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
 
     if (!cmd->cmd && !cmd->cmd_info_hrt) {
         /* FIXME: is it useful to try autoload modules here ??? */
-        monitor_printf(&mon->common, "Command \"%.*s\" is not available.\n",
+        monitor_printf(&mon->parent, "Command \"%.*s\" is not available.\n",
                        (int)(cmdline - cmd_start), cmd_start);
         return;
     }
 
-    qdict = monitor_parse_arguments(&mon->common, &cmdline, cmd);
+    qdict = monitor_parse_arguments(&mon->parent, &cmdline, cmd);
     if (!qdict) {
         while (cmdline > cmd_start && qemu_isspace(cmdline[-1])) {
             cmdline--;
         }
-        monitor_printf(&mon->common, "Try \"help %.*s\" for more information\n",
+        monitor_printf(&mon->parent, "Try \"help %.*s\" for more information\n",
                        (int)(cmdline - cmd_start), cmd_start);
         return;
     }
 
     if (!cmd->coroutine) {
         /* old_mon is non-NULL when called from qmp_human_monitor_command() */
-        Monitor *old_mon = monitor_set_cur(qemu_coroutine_self(), &mon->common);
-        handle_hmp_command_exec(&mon->common, cmd, qdict);
+        Monitor *old_mon = monitor_set_cur(qemu_coroutine_self(), &mon->parent);
+        handle_hmp_command_exec(&mon->parent, cmd, qdict);
         monitor_set_cur(qemu_coroutine_self(), old_mon);
     } else {
         HandleHmpCommandCo data = {
-            .mon = &mon->common,
+            .mon = &mon->parent,
             .cmd = cmd,
             .qdict = qdict,
             .done = false,
         };
         Coroutine *co = qemu_coroutine_create(handle_hmp_command_co, &data);
-        monitor_set_cur(co, &mon->common);
+        monitor_set_cur(co, &mon->parent);
         aio_co_enter(qemu_get_aio_context(), co);
         AIO_WAIT_WHILE_UNLOCKED(NULL, !data.done);
     }
@@ -1428,7 +1428,7 @@ cleanup:
 
 static void monitor_read(void *opaque, const uint8_t *buf, int size)
 {
-    MonitorHMP *mon = container_of(opaque, MonitorHMP, common);
+    MonitorHMP *mon = container_of(opaque, MonitorHMP, parent);
     int i;
 
     if (mon->rs) {
@@ -1437,7 +1437,7 @@ static void monitor_read(void *opaque, const uint8_t *buf, int size)
         }
     } else {
         if (size == 0 || buf[size - 1] != 0) {
-            monitor_printf(&mon->common, "corrupted command\n");
+            monitor_printf(&mon->parent, "corrupted command\n");
         } else {
             handle_hmp_command(mon, (char *)buf);
         }
@@ -1506,26 +1506,26 @@ static void G_GNUC_PRINTF(2, 3) monitor_readline_printf(void *opaque,
     MonitorHMP *mon = opaque;
     va_list ap;
     va_start(ap, fmt);
-    monitor_vprintf(&mon->common, fmt, ap);
+    monitor_vprintf(&mon->parent, fmt, ap);
     va_end(ap);
 }
 
 static void monitor_readline_flush(void *opaque)
 {
     MonitorHMP *mon = opaque;
-    monitor_flush(&mon->common);
+    monitor_flush(&mon->parent);
 }
 
 void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp)
 {
     MonitorHMP *mon = g_new0(MonitorHMP, 1);
 
-    if (!qemu_chr_fe_init(&mon->common.chr, chr, errp)) {
+    if (!qemu_chr_fe_init(&mon->parent.chr, chr, errp)) {
         g_free(mon);
         return;
     }
 
-    monitor_data_init(&mon->common, false, false, false);
+    monitor_data_init(&mon->parent, false, false, false);
 
     mon->use_readline = use_readline;
     if (mon->use_readline) {
@@ -1536,9 +1536,9 @@ void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp)
         monitor_read_command(mon, 0);
     }
 
-    qemu_chr_fe_set_handlers(&mon->common.chr, monitor_can_read, monitor_read,
-                             monitor_event, NULL, &mon->common, NULL, true);
-    monitor_list_append(&mon->common);
+    qemu_chr_fe_set_handlers(&mon->parent.chr, monitor_can_read, monitor_read,
+                             monitor_event, NULL, &mon->parent, NULL, true);
+    monitor_list_append(&mon->parent);
 }
 
 /**
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index feca111ae3..ae0cf8c1da 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -119,7 +119,7 @@ struct Monitor {
 };
 
 struct MonitorHMP {
-    Monitor common;
+    Monitor parent;
     bool use_readline;
     /*
      * State used only in the thread "owning" the monitor.
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 00b93ed612..6532796edb 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -132,7 +132,7 @@ static inline bool monitor_is_hmp_non_interactive(const Monitor *mon)
         return false;
     }
 
-    return !monitor_uses_readline(container_of(mon, MonitorHMP, common));
+    return !monitor_uses_readline(container_of(mon, MonitorHMP, parent));
 }
 
 static gboolean monitor_unblocked(void *do_not_use, GIOCondition cond,
@@ -542,7 +542,7 @@ static void monitor_accept_input(void *opaque)
 
     qemu_mutex_lock(&mon->mon_lock);
     if (!monitor_is_qmp(mon) && mon->reset_seen) {
-        MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
+        MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, parent);
         assert(hmp_mon->rs);
         readline_restart(hmp_mon->rs);
         qemu_mutex_unlock(&mon->mon_lock);
@@ -627,7 +627,7 @@ void monitor_data_destroy(Monitor *mon)
     if (monitor_is_qmp(mon)) {
         monitor_data_destroy_qmp(container_of(mon, MonitorQMP, common));
     } else {
-        readline_free(container_of(mon, MonitorHMP, common)->rs);
+        readline_free(container_of(mon, MonitorHMP, parent)->rs);
     }
     g_string_free(mon->outbuf, true);
     qemu_mutex_destroy(&mon->mon_lock);
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index 0c409c27dc..191eba1b3a 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -168,10 +168,10 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
     char *output = NULL;
     MonitorHMP hmp = {};
 
-    monitor_data_init(&hmp.common, false, true, false);
+    monitor_data_init(&hmp.parent, false, true, false);
 
     if (has_cpu_index) {
-        int ret = monitor_set_cpu(&hmp.common, cpu_index);
+        int ret = monitor_set_cpu(&hmp.parent, cpu_index);
         if (ret < 0) {
             error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cpu-index",
                        "a CPU number");
@@ -181,12 +181,12 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
 
     handle_hmp_command(&hmp, command_line);
 
-    WITH_QEMU_LOCK_GUARD(&hmp.common.mon_lock) {
-        output = g_strdup(hmp.common.outbuf->str);
+    WITH_QEMU_LOCK_GUARD(&hmp.parent.mon_lock) {
+        output = g_strdup(hmp.parent.outbuf->str);
     }
 
 out:
-    monitor_data_destroy(&hmp.common);
+    monitor_data_destroy(&hmp.parent);
     return output;
 }
 
diff --git a/ui/ui-hmp-cmds.c b/ui/ui-hmp-cmds.c
index 6c93d452c9..fe89632474 100644
--- a/ui/ui-hmp-cmds.c
+++ b/ui/ui-hmp-cmds.c
@@ -341,7 +341,7 @@ void hmp_change_vnc(Monitor *mon, const char *device, const char *target,
         return;
     }
     if (!arg) {
-        MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
+        MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, parent);
         monitor_read_password(hmp_mon, hmp_change_read_arg, NULL);
     } else {
         qmp_change_vnc_password(arg, errp);
-- 
2.53.0


