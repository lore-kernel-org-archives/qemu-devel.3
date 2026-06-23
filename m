Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03748CDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 09:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbxrt-0003Sf-U1; Tue, 23 Jun 2026 05:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wbxrs-0003SX-0u
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 05:56:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wbxrl-0003TM-7I
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 05:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782208584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tjqfSRxYOxQy1sZSfGITju3lmGN+9Vm+9l61SqZBrSk=;
 b=QkEYMYIyp0n3zIxY4io7Urdnxy1NlXHXM2tBoImpqHmjrcTBzoLjTxsakQWLtm8HsRboG6
 3D5etzbsDmk5Z2wXi1wNRYgWi7VtpG3DvWMvoflC4P7o6BRJ0hIPMfJ8zy2QdTdQpNtH7L
 ZL+KVWzmS/b117Pg9Sm0m2qsiPURV40=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-1bSWwjr5OsC-2AzZZGHYMQ-1; Tue,
 23 Jun 2026 05:56:21 -0400
X-MC-Unique: 1bSWwjr5OsC-2AzZZGHYMQ-1
X-Mimecast-MFC-AGG-ID: 1bSWwjr5OsC-2AzZZGHYMQ_1782208580
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A0F91800599; Tue, 23 Jun 2026 09:56:20 +0000 (UTC)
Received: from berrange.com (unknown [10.44.34.133])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 51E21D6E; Tue, 23 Jun 2026 09:56:17 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Christian Brauner <brauner@kernel.org>, devel@lists.libvirt.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 06/35] monitor: add 'chardev' property to Monitor base class
Date: Tue, 23 Jun 2026 10:55:22 +0100
Message-ID: <20260623095551.2106712-7-berrange@redhat.com>
In-Reply-To: <20260623095551.2106712-1-berrange@redhat.com>
References: <20260623095551.2106712-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is associates both QMP and HMP monitors with a character
device backend.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 chardev/char.c             |  3 ++-
 gdbstub/system.c           |  4 ++--
 include/monitor/monitor.h  |  4 ++--
 monitor/hmp.c              | 10 ++++++--
 monitor/monitor-internal.h |  2 ++
 monitor/monitor.c          | 47 ++++++++++++++++++++++++++++++--------
 monitor/qmp.c              | 18 ++++++++++-----
 stubs/monitor-internal.c   |  2 +-
 8 files changed, 67 insertions(+), 23 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index 813c04d953..981fbb1aaa 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -804,8 +804,9 @@ static Chardev *qemu_chr_new_from_name(const char *label, const char *filename,
     }
 
     if (qemu_opt_get_bool(opts, "mux", 0)) {
+        const char *chardev_id = qemu_opts_id(opts);
         assert(permit_mux_mon);
-        monitor_new_hmp(chr, true, &err);
+        monitor_new_hmp(chardev_id, true, &err);
         if (err) {
             error_report_err(err);
             object_unparent(OBJECT(chr));
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 18f6a62b2e..80175e7fa2 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -387,9 +387,9 @@ bool gdbserver_start(const char *device, Error **errp)
         qemu_add_vm_change_state_handler(gdb_vm_state_change, NULL);
 
         /* Initialize a monitor terminal for gdb */
-        mon_chr = qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
+        mon_chr = qemu_chardev_new("gdbchrdev0", TYPE_CHARDEV_GDB,
                                    NULL, NULL, &error_abort);
-        monitor_new_hmp(mon_chr, false, &error_abort);
+        monitor_new_hmp("gdbchrdev0", false, &error_abort);
     } else {
         qemu_chr_fe_deinit(&gdbserver_system_state.chr, true);
         mon_chr = gdbserver_system_state.mon_chr;
diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 2e9f9e12e9..a135b3a590 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -28,8 +28,8 @@ bool monitor_cur_is_qmp(void);
 
 void monitor_init_globals(void);
 void monitor_init_globals_core(void);
-void monitor_new_qmp(Chardev *chr, bool pretty, Error **errp);
-void monitor_new_hmp(Chardev *chr, bool use_readline, Error **errp);
+void monitor_new_qmp(const char *chardev_id, bool pretty, Error **errp);
+void monitor_new_hmp(const char *chardev_id, bool use_readline, Error **errp);
 int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp);
 int monitor_new_opts(QemuOpts *opts, Error **errp);
 void monitor_cleanup(void);
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 81047d2513..4ab81b5904 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include <dirent.h>
 #include "hw/core/qdev.h"
 #include "hw/core/sysemu-cpu-ops.h"
@@ -1538,8 +1539,9 @@ static void monitor_readline_flush(void *opaque)
     monitor_flush(&mon->parent_obj);
 }
 
-void monitor_new_hmp(Chardev *chr, bool use_readline, Error **errp)
+void monitor_new_hmp(const char *chardev_id, bool use_readline, Error **errp)
 {
+    ERRP_GUARD();
     MonitorHMP *mon;
     static int counter;
     g_autofree char *id = g_strdup_printf("hmpcompat%d", counter++);
@@ -1547,13 +1549,17 @@ void monitor_new_hmp(Chardev *chr, bool use_readline, Error **errp)
                                         object_get_objects_root(),
                                         id,
                                         errp,
+                                        "chardev", chardev_id,
                                         NULL);
+
     if (!obj) {
         return;
     }
+
     mon = MONITOR_HMP(obj);
 
-    if (!qemu_chr_fe_init(&mon->parent_obj.chr, chr, errp)) {
+    monitor_complete(MONITOR(mon), errp);
+    if (*errp) {
         object_unparent(OBJECT(mon));
         return;
     }
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 05c1f2f5e0..145d52fd71 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -108,6 +108,7 @@ struct MonitorClass {
 
 struct Monitor {
     Object parent;
+    char *chardev_id;
     CharFrontend chr;
     int suspend_cnt;            /* Needs to be accessed atomically */
     bool is_qmp;
@@ -192,6 +193,7 @@ extern QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
 extern QemuMutex monitor_lock;
 extern MonitorList mon_list;
 
+void monitor_complete(Monitor *mon, Error **errp);
 void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
                        bool use_io_thread);
 void monitor_data_destroy(Monitor *mon);
diff --git a/monitor/monitor.c b/monitor/monitor.c
index a497c25c54..747ca27fd5 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -77,10 +77,31 @@ OBJECT_DEFINE_TYPE(Monitor, monitor, MONITOR, OBJECT);
 
 static void monitor_finalize(Object *obj)
 {
+    Monitor *mon = MONITOR(obj);
+
+    g_free(mon->chardev_id);
+}
+
+static char *monitor_get_chardev_id(Object *obj, Error **errp)
+{
+    Monitor *mon = MONITOR(obj);
+
+    return g_strdup(mon->chardev_id);
+}
+
+static void monitor_set_chardev_id(Object *obj, const char *str, Error **errp)
+{
+    Monitor *mon = MONITOR(obj);
+
+    g_free(mon->chardev_id);
+    mon->chardev_id = g_strdup(str);
 }
 
 static void monitor_class_init(ObjectClass *cls, const void *data)
 {
+    object_class_property_add_str(cls, "chardev",
+                                  monitor_get_chardev_id,
+                                  monitor_set_chardev_id);
 }
 
 static void monitor_init(Object *obj)
@@ -729,16 +750,24 @@ void monitor_init_globals(void)
     aio_co_schedule(iohandler_get_aio_context(), qmp_dispatcher_co);
 }
 
-int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
+void monitor_complete(Monitor *mon, Error **errp)
 {
-    ERRP_GUARD();
-    Chardev *chr;
+    if (mon->chardev_id) {
+        Chardev *chr = qemu_chr_find(mon->chardev_id);
+        if (chr == NULL) {
+            error_setg(errp, "chardev \"%s\" not found", mon->chardev_id);
+            return;
+        }
 
-    chr = qemu_chr_find(opts->chardev);
-    if (chr == NULL) {
-        error_setg(errp, "chardev \"%s\" not found", opts->chardev);
-        return -1;
+        if (!qemu_chr_fe_init(&mon->chr, chr, errp)) {
+            return;
+        }
     }
+}
+
+int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
+{
+    ERRP_GUARD();
 
     if (!opts->has_mode) {
         opts->mode = allow_hmp ? MONITOR_MODE_READLINE : MONITOR_MODE_CONTROL;
@@ -746,7 +775,7 @@ int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
 
     switch (opts->mode) {
     case MONITOR_MODE_CONTROL:
-        monitor_new_qmp(chr, opts->pretty, errp);
+        monitor_new_qmp(opts->chardev, opts->pretty, errp);
         break;
     case MONITOR_MODE_READLINE:
         if (!allow_hmp) {
@@ -757,7 +786,7 @@ int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
             error_setg(errp, "'pretty' is not compatible with HMP monitors");
             return -1;
         }
-        monitor_new_hmp(chr, true, errp);
+        monitor_new_hmp(opts->chardev, true, errp);
         break;
     default:
         g_assert_not_reached();
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 5231ed506a..0abf2677f9 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -527,8 +527,9 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
     monitor_list_append(&mon->parent_obj);
 }
 
-void monitor_new_qmp(Chardev *chr, bool pretty, Error **errp)
+void monitor_new_qmp(const char *chardev_id, bool pretty, Error **errp)
 {
+    ERRP_GUARD();
     MonitorQMP *mon;
     static int counter;
     g_autofree char *id = g_strdup_printf("qmpcompat%d", counter++);
@@ -536,21 +537,26 @@ void monitor_new_qmp(Chardev *chr, bool pretty, Error **errp)
                                         object_get_objects_root(),
                                         id,
                                         errp,
+                                        "chardev", chardev_id,
                                         NULL);
+
     if (!obj) {
         return;
     }
-    mon = MONITOR_QMP(obj);
 
-    if (!qemu_chr_fe_init(&mon->parent_obj.chr, chr, errp)) {
+    mon = MONITOR_QMP(obj);
+    monitor_complete(MONITOR(mon), errp);
+    if (*errp) {
         object_unparent(OBJECT(mon));
         return;
     }
+
     qemu_chr_fe_set_echo(&mon->parent_obj.chr, true);
 
     /* Note: we run QMP monitor in I/O thread when @chr supports that */
     monitor_data_init(&mon->parent_obj, true, false,
-                      qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT));
+                      qemu_chr_has_feature(mon->parent_obj.chr.chr,
+                                           QEMU_CHAR_FEATURE_GCONTEXT));
 
     mon->pretty = pretty;
 
@@ -563,12 +569,12 @@ void monitor_new_qmp(Chardev *chr, bool pretty, Error **errp)
          * Make sure the old iowatch is gone.  It's possible when
          * e.g. the chardev is in client mode, with wait=on.
          */
-        remove_fd_in_watch(chr);
+        remove_fd_in_watch(mon->parent_obj.chr.chr);
         /*
          * Clean up listener IO sources early to prevent racy fd
          * handling between the main thread and the I/O thread.
          */
-        remove_listener_fd_in_watch(chr);
+        remove_listener_fd_in_watch(mon->parent_obj.chr.chr);
         /*
          * We can't call qemu_chr_fe_set_handlers() directly here
          * since chardev might be running in the monitor I/O
diff --git a/stubs/monitor-internal.c b/stubs/monitor-internal.c
index 23d58da184..51db7588b9 100644
--- a/stubs/monitor-internal.c
+++ b/stubs/monitor-internal.c
@@ -8,6 +8,6 @@ int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
     return -1;
 }
 
-void monitor_new_hmp(Chardev *chr, bool use_readline, Error **errp)
+void monitor_new_hmp(const char *chardev_id, bool use_readline, Error **errp)
 {
 }
-- 
2.54.0


