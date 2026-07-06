Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71E9C44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjqS-0001pi-Um; Mon, 06 Jul 2026 09:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wgjqQ-0001p5-FZ
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:58:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wgjqO-0001YK-9F
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783346323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ghdqZMUGeCj/f6yTinvRaBunSm0yhHUhP+zeygbRb+w=;
 b=cx30OU9JhjgKIiEWo5fZu4jt608/ahsZyIVl9iJmiN99HwEQy8/c9XrvMuPYsXbHnBvW6D
 9a7SqlAajy57vMnkXDJpyqPXT2K1i1OvrHHDjdp2Unj/HlNesiuBDiZohDUb4A/NEJs6s+
 KMZnmT+xEG8+aefkR/WgR2JrufOkY3k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-a1xcGSQKMqa0WNhQMt6sjw-1; Mon,
 06 Jul 2026 09:58:40 -0400
X-MC-Unique: a1xcGSQKMqa0WNhQMt6sjw-1
X-Mimecast-MFC-AGG-ID: a1xcGSQKMqa0WNhQMt6sjw_1783346319
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2F971955F3F; Mon,  6 Jul 2026 13:58:39 +0000 (UTC)
Received: from berrange.com (unknown [10.44.48.165])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C99DA3000B4C; Mon,  6 Jul 2026 13:58:35 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Christian Brauner <brauner@kernel.org>, devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v7 02/35] monitor: replace 'common' with 'parent_obj' in
 MonitorHMP
Date: Mon,  6 Jul 2026 14:57:50 +0100
Message-ID: <20260706135824.2623960-3-berrange@redhat.com>
In-Reply-To: <20260706135824.2623960-1-berrange@redhat.com>
References: <20260706135824.2623960-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

The field name 'parent_obj' is standard practice for QOM structs
so align the HMP monitor.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Tested-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 monitor/hmp-cmds.c         |  2 +-
 monitor/hmp.c              | 43 ++++++++++++++++++++------------------
 monitor/monitor-internal.h |  2 +-
 monitor/monitor.c          |  6 +++---
 monitor/qmp-cmds.c         | 10 ++++-----
 ui/ui-hmp-cmds.c           |  2 +-
 6 files changed, 34 insertions(+), 31 deletions(-)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 443b8c785d..e139caeba9 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -287,7 +287,7 @@ void hmp_info_sync_profile(Monitor *mon, const QDict *qdict)
 
 void hmp_info_history(Monitor *mon, const QDict *qdict)
 {
-    MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
+    MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, parent_obj);
     int i;
     const char *str;
 
diff --git a/monitor/hmp.c b/monitor/hmp.c
index cc4390486e..3dde52ddbe 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -48,9 +48,9 @@ static void monitor_command_cb(void *opaque, const char *cmdline,
 {
     MonitorHMP *mon = opaque;
 
-    monitor_suspend(&mon->common);
+    monitor_suspend(&mon->parent_obj);
     handle_hmp_command(mon, cmdline);
-    monitor_resume(&mon->common);
+    monitor_resume(&mon->parent_obj);
 }
 
 void monitor_read_command(MonitorHMP *mon, int show_prompt)
@@ -73,7 +73,7 @@ int monitor_read_password(MonitorHMP *mon, ReadLineFunc *readline_func,
         /* prompt is printed on return from the command handler */
         return 0;
     } else {
-        monitor_printf(&mon->common,
+        monitor_printf(&mon->parent_obj,
                        "terminal does not support password prompting\n");
         return -ENOTTY;
     }
@@ -695,7 +695,7 @@ static const HMPCommand *monitor_parse_command(MonitorHMP *hmp_mon,
                                                const char **cmdp,
                                                HMPCommand *table)
 {
-    Monitor *mon = &hmp_mon->common;
+    Monitor *mon = &hmp_mon->parent_obj;
     const char *p;
     const HMPCommand *cmd;
     char cmdname[256];
@@ -1188,35 +1188,37 @@ void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
 
     if (!cmd->cmd && !cmd->cmd_info_hrt) {
         /* FIXME: is it useful to try autoload modules here ??? */
-        monitor_printf(&mon->common, "Command \"%.*s\" is not available.\n",
+        monitor_printf(&mon->parent_obj, "Command \"%.*s\" is not available.\n",
                        (int)(cmdline - cmd_start), cmd_start);
         return;
     }
 
-    qdict = monitor_parse_arguments(&mon->common, &cmdline, cmd);
+    qdict = monitor_parse_arguments(&mon->parent_obj, &cmdline, cmd);
     if (!qdict) {
         while (cmdline > cmd_start && qemu_isspace(cmdline[-1])) {
             cmdline--;
         }
-        monitor_printf(&mon->common, "Try \"help %.*s\" for more information\n",
+        monitor_printf(&mon->parent_obj,
+                       "Try \"help %.*s\" for more information\n",
                        (int)(cmdline - cmd_start), cmd_start);
         return;
     }
 
     if (!cmd->coroutine) {
         /* old_mon is non-NULL when called from qmp_human_monitor_command() */
-        Monitor *old_mon = monitor_set_cur(qemu_coroutine_self(), &mon->common);
-        handle_hmp_command_exec(&mon->common, cmd, qdict);
+        Monitor *old_mon = monitor_set_cur(qemu_coroutine_self(),
+                                           &mon->parent_obj);
+        handle_hmp_command_exec(&mon->parent_obj, cmd, qdict);
         monitor_set_cur(qemu_coroutine_self(), old_mon);
     } else {
         HandleHmpCommandCo data = {
-            .mon = &mon->common,
+            .mon = &mon->parent_obj,
             .cmd = cmd,
             .qdict = qdict,
             .done = false,
         };
         Coroutine *co = qemu_coroutine_create(handle_hmp_command_co, &data);
-        monitor_set_cur(co, &mon->common);
+        monitor_set_cur(co, &mon->parent_obj);
         aio_co_enter(qemu_get_aio_context(), co);
         AIO_WAIT_WHILE_UNLOCKED(NULL, !data.done);
     }
@@ -1434,7 +1436,7 @@ cleanup:
 
 static void monitor_read(void *opaque, const uint8_t *buf, int size)
 {
-    MonitorHMP *mon = container_of(opaque, MonitorHMP, common);
+    MonitorHMP *mon = container_of(opaque, MonitorHMP, parent_obj);
     int i;
 
     if (mon->rs) {
@@ -1443,7 +1445,7 @@ static void monitor_read(void *opaque, const uint8_t *buf, int size)
         }
     } else {
         if (size == 0 || buf[size - 1] != 0) {
-            monitor_printf(&mon->common, "corrupted command\n");
+            monitor_printf(&mon->parent_obj, "corrupted command\n");
         } else {
             handle_hmp_command(mon, (char *)buf);
         }
@@ -1512,26 +1514,26 @@ static void G_GNUC_PRINTF(2, 3) monitor_readline_printf(void *opaque,
     MonitorHMP *mon = opaque;
     va_list ap;
     va_start(ap, fmt);
-    monitor_vprintf(&mon->common, fmt, ap);
+    monitor_vprintf(&mon->parent_obj, fmt, ap);
     va_end(ap);
 }
 
 static void monitor_readline_flush(void *opaque)
 {
     MonitorHMP *mon = opaque;
-    monitor_flush(&mon->common);
+    monitor_flush(&mon->parent_obj);
 }
 
 void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp)
 {
     MonitorHMP *mon = g_new0(MonitorHMP, 1);
 
-    if (!qemu_chr_fe_init(&mon->common.chr, chr, errp)) {
+    if (!qemu_chr_fe_init(&mon->parent_obj.chr, chr, errp)) {
         g_free(mon);
         return;
     }
 
-    monitor_data_init(&mon->common, false, false, false);
+    monitor_data_init(&mon->parent_obj, false, false, false);
 
     mon->use_readline = use_readline;
     if (mon->use_readline) {
@@ -1542,9 +1544,10 @@ void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp)
         monitor_read_command(mon, 0);
     }
 
-    qemu_chr_fe_set_handlers(&mon->common.chr, monitor_can_read, monitor_read,
-                             monitor_event, NULL, &mon->common, NULL, true);
-    monitor_list_append(&mon->common);
+    qemu_chr_fe_set_handlers(&mon->parent_obj.chr,
+                             monitor_can_read, monitor_read, monitor_event,
+                             NULL, &mon->parent_obj, NULL, true);
+    monitor_list_append(&mon->parent_obj);
 }
 
 /**
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index a5c4aba306..eb301ea796 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -128,7 +128,7 @@ struct Monitor {
 };
 
 struct MonitorHMP {
-    Monitor common;
+    Monitor parent_obj;
     bool use_readline;
     /*
      * State used only in the thread "owning" the monitor.
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 00b93ed612..2a1b511ff4 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -132,7 +132,7 @@ static inline bool monitor_is_hmp_non_interactive(const Monitor *mon)
         return false;
     }
 
-    return !monitor_uses_readline(container_of(mon, MonitorHMP, common));
+    return !monitor_uses_readline(container_of(mon, MonitorHMP, parent_obj));
 }
 
 static gboolean monitor_unblocked(void *do_not_use, GIOCondition cond,
@@ -542,7 +542,7 @@ static void monitor_accept_input(void *opaque)
 
     qemu_mutex_lock(&mon->mon_lock);
     if (!monitor_is_qmp(mon) && mon->reset_seen) {
-        MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
+        MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, parent_obj);
         assert(hmp_mon->rs);
         readline_restart(hmp_mon->rs);
         qemu_mutex_unlock(&mon->mon_lock);
@@ -627,7 +627,7 @@ void monitor_data_destroy(Monitor *mon)
     if (monitor_is_qmp(mon)) {
         monitor_data_destroy_qmp(container_of(mon, MonitorQMP, common));
     } else {
-        readline_free(container_of(mon, MonitorHMP, common)->rs);
+        readline_free(container_of(mon, MonitorHMP, parent_obj)->rs);
     }
     g_string_free(mon->outbuf, true);
     qemu_mutex_destroy(&mon->mon_lock);
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index 0c409c27dc..aa9ee8a391 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -168,10 +168,10 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
     char *output = NULL;
     MonitorHMP hmp = {};
 
-    monitor_data_init(&hmp.common, false, true, false);
+    monitor_data_init(&hmp.parent_obj, false, true, false);
 
     if (has_cpu_index) {
-        int ret = monitor_set_cpu(&hmp.common, cpu_index);
+        int ret = monitor_set_cpu(&hmp.parent_obj, cpu_index);
         if (ret < 0) {
             error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cpu-index",
                        "a CPU number");
@@ -181,12 +181,12 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
 
     handle_hmp_command(&hmp, command_line);
 
-    WITH_QEMU_LOCK_GUARD(&hmp.common.mon_lock) {
-        output = g_strdup(hmp.common.outbuf->str);
+    WITH_QEMU_LOCK_GUARD(&hmp.parent_obj.mon_lock) {
+        output = g_strdup(hmp.parent_obj.outbuf->str);
     }
 
 out:
-    monitor_data_destroy(&hmp.common);
+    monitor_data_destroy(&hmp.parent_obj);
     return output;
 }
 
diff --git a/ui/ui-hmp-cmds.c b/ui/ui-hmp-cmds.c
index ee3e731d07..06f4030ce4 100644
--- a/ui/ui-hmp-cmds.c
+++ b/ui/ui-hmp-cmds.c
@@ -343,7 +343,7 @@ void hmp_change_vnc(Monitor *mon, const char *device, const char *target,
         return;
     }
     if (!arg) {
-        MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
+        MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, parent_obj);
         monitor_read_password(hmp_mon, hmp_change_read_arg, NULL);
     } else {
         qmp_change_vnc_password(arg, errp);
-- 
2.55.0


