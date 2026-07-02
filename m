Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5DADC44500
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfJtd-00062j-H7; Thu, 02 Jul 2026 12:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wfJtc-00062b-Rs
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 12:04:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wfJtZ-0006Vu-6b
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 12:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783008248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5l4uNZpGC6WvpTFBRdk50B144h762zgwhek3w7eMMuM=;
 b=X3AP77Q1d3xlUeGUdIo0imXlZ3IPovRvmULkMx3RxSvAhtkxlYWaE3e/x45uBWbLA2HyKD
 PEO8R1hl208e8BNcN7KV8JViPSp/6AO1h2e4e/lxs0TsQy391ATZSS9WB4RWTcKMeTqO70
 d5Z12U9ME8I93MiXsUp5IsE2/wPiE1g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-p8YIJ_o-MSKHNAVCJxjX0g-1; Thu,
 02 Jul 2026 12:04:06 -0400
X-MC-Unique: p8YIJ_o-MSKHNAVCJxjX0g-1
X-Mimecast-MFC-AGG-ID: p8YIJ_o-MSKHNAVCJxjX0g_1783008245
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C19618CC491; Thu,  2 Jul 2026 16:04:05 +0000 (UTC)
Received: from berrange.com (unknown [10.44.33.186])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 157481945110; Thu,  2 Jul 2026 16:04:01 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Christian Brauner <brauner@kernel.org>, devel@lists.libvirt.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v6 05/34] monitor: minimal conversion of monitors to QOM
Date: Thu,  2 Jul 2026 17:03:08 +0100
Message-ID: <20260702160337.1910921-6-berrange@redhat.com>
In-Reply-To: <20260702160337.1910921-1-berrange@redhat.com>
References: <20260702160337.1910921-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

This introduces a Monitor QOM object, with MonitorHMP and
MonitorQMP subclasses. This is the bare minimum conversion
of just the type declarations and replacing g_new/g_free
with object_new/object_unref. The Monitor base class is
abstract since only the HMP/QMP variants should ever be
created.

When created through the existing QemuOpts interfaces, the
new internal QOM object will get assigned a dynamic ID with
the format "compat_monitorNNN" which is the historical
QemuOpts ID naming pattern.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 chardev/char.c             |  2 +-
 gdbstub/system.c           |  2 +-
 include/monitor/monitor.h  | 18 +++++++++++++++---
 monitor/hmp.c              | 31 ++++++++++++++++++++++++++++---
 monitor/monitor-internal.h | 18 ++++++++++++++++--
 monitor/monitor.c          | 31 +++++++++++++++++++++++++++----
 monitor/qmp-cmds.c         | 15 ++++++++-------
 monitor/qmp.c              | 31 ++++++++++++++++++++++++++++---
 stubs/monitor-internal.c   |  3 ++-
 system/vl.c                |  7 +++----
 10 files changed, 129 insertions(+), 29 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index 813c04d953..c71ffa7963 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -805,7 +805,7 @@ static Chardev *qemu_chr_new_from_name(const char *label, const char *filename,
 
     if (qemu_opt_get_bool(opts, "mux", 0)) {
         assert(permit_mux_mon);
-        monitor_new_hmp(chr, true, &err);
+        monitor_new_hmp(NULL, chr, true, &err);
         if (err) {
             error_report_err(err);
             object_unparent(OBJECT(chr));
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 18f6a62b2e..fda8ef9352 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -389,7 +389,7 @@ bool gdbserver_start(const char *device, Error **errp)
         /* Initialize a monitor terminal for gdb */
         mon_chr = qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
                                    NULL, NULL, &error_abort);
-        monitor_new_hmp(mon_chr, false, &error_abort);
+        monitor_new_hmp(NULL, mon_chr, false, &error_abort);
     } else {
         qemu_chr_fe_deinit(&gdbserver_system_state.chr, true);
         mon_chr = gdbserver_system_state.mon_chr;
diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index b9642b58ba..83723f705a 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -5,8 +5,17 @@
 #include "qapi/qapi-types-misc.h"
 #include "qemu/readline.h"
 #include "exec/hwaddr.h"
+#include "qom/object.h"
+
+#define TYPE_MONITOR "monitor"
+OBJECT_DECLARE_TYPE(Monitor, MonitorClass, MONITOR);
+
+#define TYPE_MONITOR_HMP "monitor-hmp"
+OBJECT_DECLARE_TYPE(MonitorHMP, MonitorHMPClass, MONITOR_HMP);
+
+#define TYPE_MONITOR_QMP "monitor-qmp"
+OBJECT_DECLARE_TYPE(MonitorQMP, MonitorQMPClass, MONITOR_QMP);
 
-typedef struct MonitorHMP MonitorHMP;
 typedef struct MonitorOptions MonitorOptions;
 
 #define QMP_REQ_QUEUE_LEN_MAX 8
@@ -19,8 +28,11 @@ bool monitor_cur_is_qmp(void);
 
 void monitor_init_globals(void);
 void monitor_init_globals_core(void);
-void monitor_new_qmp(Chardev *chr, bool pretty, Error **errp);
-void monitor_new_hmp(Chardev *chr, bool use_readline, Error **errp);
+char *monitor_compat_id(void);
+void monitor_new_qmp(const char *id, Chardev *chr,
+                     bool pretty, Error **errp);
+void monitor_new_hmp(const char *id, Chardev *chr,
+                     bool use_readline, Error **errp);
 int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp);
 int monitor_new_opts(QemuOpts *opts, Error **errp);
 void monitor_cleanup(void);
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 4e4468424a..da11e56854 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -43,6 +43,20 @@
 #include "system/block-backend.h"
 #include "trace.h"
 
+OBJECT_DEFINE_TYPE(MonitorHMP, monitor_hmp, MONITOR_HMP, MONITOR);
+
+static void monitor_hmp_finalize(Object *obj)
+{
+}
+
+static void monitor_hmp_class_init(ObjectClass *cls, const void *data)
+{
+}
+
+static void monitor_hmp_init(Object *obj)
+{
+}
+
 static void monitor_command_cb(void *opaque, const char *cmdline,
                                void *readline_opaque)
 {
@@ -1524,12 +1538,23 @@ static void monitor_readline_flush(void *opaque)
     monitor_flush(&mon->parent_obj);
 }
 
-void monitor_new_hmp(Chardev *chr, bool use_readline, Error **errp)
+void monitor_new_hmp(const char *id, Chardev *chr,
+                     bool use_readline, Error **errp)
 {
-    MonitorHMP *mon = g_new0(MonitorHMP, 1);
+    MonitorHMP *mon;
+    g_autofree char *autoid = id ? NULL : monitor_compat_id();
+    Object *obj = object_new_with_props(TYPE_MONITOR_HMP,
+                                        object_get_objects_root(),
+                                        id ? id : autoid,
+                                        errp,
+                                        NULL);
+    if (!obj) {
+        return;
+    }
+    mon = MONITOR_HMP(obj);
 
     if (!qemu_chr_fe_init(&mon->parent_obj.chr, chr, errp)) {
-        g_free(mon);
+        object_unparent(OBJECT(mon));
         return;
     }
 
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 4da2b2a677..05c1f2f5e0 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -101,7 +101,13 @@ typedef struct HMPCommand {
     bool coroutine;
 } HMPCommand;
 
+
+struct MonitorClass {
+    ObjectClass parent_class;
+};
+
 struct Monitor {
+    Object parent;
     CharFrontend chr;
     int suspend_cnt;            /* Needs to be accessed atomically */
     bool is_qmp;
@@ -127,6 +133,10 @@ struct Monitor {
     int reset_seen;
 };
 
+struct MonitorHMPClass {
+    MonitorClass parent_class;
+};
+
 struct MonitorHMP {
     Monitor parent_obj;
     bool use_readline;
@@ -140,7 +150,11 @@ struct MonitorHMP {
     ReadLineState *rs;
 };
 
-typedef struct {
+struct MonitorQMPClass {
+    MonitorClass parent_class;
+};
+
+struct MonitorQMP {
     Monitor parent_obj;
     JSONMessageParser parser;
     bool pretty;
@@ -160,7 +174,7 @@ typedef struct {
     QemuMutex qmp_queue_lock;
     /* Input queue that holds all the parsed QMP requests */
     GQueue *qmp_requests;
-} MonitorQMP;
+};
 
 /**
  * Is @mon a QMP monitor?
diff --git a/monitor/monitor.c b/monitor/monitor.c
index a87597e606..18a1d8ddde 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -73,6 +73,22 @@ static GHashTable *coroutine_mon; /* Maps Coroutine* to Monitor* */
 MonitorList mon_list;
 static bool monitor_destroyed;
 
+int monitor_device_index;
+
+OBJECT_DEFINE_ABSTRACT_TYPE(Monitor, monitor, MONITOR, OBJECT);
+
+static void monitor_finalize(Object *obj)
+{
+}
+
+static void monitor_class_init(ObjectClass *cls, const void *data)
+{
+}
+
+static void monitor_init(Object *obj)
+{
+}
+
 Monitor *monitor_cur(void)
 {
     Monitor *mon;
@@ -598,7 +614,7 @@ void monitor_list_append(Monitor *mon)
 
     if (mon) {
         monitor_data_destroy(mon);
-        g_free(mon);
+        object_unparent(OBJECT(mon));
     }
 }
 
@@ -680,7 +696,7 @@ void monitor_cleanup(void)
         monitor_flush(mon);
         monitor_data_destroy(mon);
         qemu_mutex_lock(&monitor_lock);
-        g_free(mon);
+        object_unparent(OBJECT(mon));
     }
     qemu_mutex_unlock(&monitor_lock);
 
@@ -715,6 +731,13 @@ void monitor_init_globals(void)
     aio_co_schedule(iohandler_get_aio_context(), qmp_dispatcher_co);
 }
 
+char *monitor_compat_id(void)
+{
+    static int monitor_device_index;
+
+    return g_strdup_printf("compat_monitor%d", monitor_device_index++);
+}
+
 int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
 {
     ERRP_GUARD();
@@ -732,7 +755,7 @@ int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
 
     switch (opts->mode) {
     case MONITOR_MODE_CONTROL:
-        monitor_new_qmp(chr, opts->pretty, errp);
+        monitor_new_qmp(opts->id, chr, opts->pretty, errp);
         break;
     case MONITOR_MODE_READLINE:
         if (!allow_hmp) {
@@ -743,7 +766,7 @@ int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
             error_setg(errp, "'pretty' is not compatible with HMP monitors");
             return -1;
         }
-        monitor_new_hmp(chr, true, errp);
+        monitor_new_hmp(opts->id, chr, true, errp);
         break;
     default:
         g_assert_not_reached();
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index aa9ee8a391..bfde769ef0 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -166,12 +166,12 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
                                 int64_t cpu_index, Error **errp)
 {
     char *output = NULL;
-    MonitorHMP hmp = {};
+    MonitorHMP *hmp = MONITOR_HMP(object_new(TYPE_MONITOR_HMP));
 
-    monitor_data_init(&hmp.parent_obj, false, true, false);
+    monitor_data_init(&hmp->parent_obj, false, true, false);
 
     if (has_cpu_index) {
-        int ret = monitor_set_cpu(&hmp.parent_obj, cpu_index);
+        int ret = monitor_set_cpu(&hmp->parent_obj, cpu_index);
         if (ret < 0) {
             error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cpu-index",
                        "a CPU number");
@@ -179,14 +179,15 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
         }
     }
 
-    handle_hmp_command(&hmp, command_line);
+    handle_hmp_command(hmp, command_line);
 
-    WITH_QEMU_LOCK_GUARD(&hmp.parent_obj.mon_lock) {
-        output = g_strdup(hmp.parent_obj.outbuf->str);
+    WITH_QEMU_LOCK_GUARD(&hmp->parent_obj.mon_lock) {
+        output = g_strdup(hmp->parent_obj.outbuf->str);
     }
 
 out:
-    monitor_data_destroy(&hmp.parent_obj);
+    monitor_data_destroy(&hmp->parent_obj);
+    object_unref(hmp);
     return output;
 }
 
diff --git a/monitor/qmp.c b/monitor/qmp.c
index cb28a95efd..1ef09352fc 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -71,6 +71,20 @@ typedef struct QMPRequest QMPRequest;
 
 QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
 
+OBJECT_DEFINE_TYPE(MonitorQMP, monitor_qmp, MONITOR_QMP, MONITOR);
+
+static void monitor_qmp_finalize(Object *obj)
+{
+}
+
+static void monitor_qmp_class_init(ObjectClass *cls, const void *data)
+{
+}
+
+static void monitor_qmp_init(Object *obj)
+{
+}
+
 static bool qmp_oob_enabled(MonitorQMP *mon)
 {
     return mon->capab[QMP_CAPABILITY_OOB];
@@ -513,12 +527,23 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
     monitor_list_append(&mon->parent_obj);
 }
 
-void monitor_new_qmp(Chardev *chr, bool pretty, Error **errp)
+void monitor_new_qmp(const char *id, Chardev *chr,
+                     bool pretty, Error **errp)
 {
-    MonitorQMP *mon = g_new0(MonitorQMP, 1);
+    MonitorQMP *mon;
+    g_autofree char *autoid = id ? NULL : monitor_compat_id();
+    Object *obj = object_new_with_props(TYPE_MONITOR_QMP,
+                                        object_get_objects_root(),
+                                        id ? id : autoid,
+                                        errp,
+                                        NULL);
+    if (!obj) {
+        return;
+    }
+    mon = MONITOR_QMP(obj);
 
     if (!qemu_chr_fe_init(&mon->parent_obj.chr, chr, errp)) {
-        g_free(mon);
+        object_unparent(OBJECT(mon));
         return;
     }
     qemu_chr_fe_set_echo(&mon->parent_obj.chr, true);
diff --git a/stubs/monitor-internal.c b/stubs/monitor-internal.c
index 23d58da184..20367b7e9a 100644
--- a/stubs/monitor-internal.c
+++ b/stubs/monitor-internal.c
@@ -8,6 +8,7 @@ int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
     return -1;
 }
 
-void monitor_new_hmp(Chardev *chr, bool use_readline, Error **errp)
+void monitor_new_hmp(const char *id, Chardev *chr,
+                     bool use_readline, Error **errp)
 {
 }
diff --git a/system/vl.c b/system/vl.c
index 6643242729..4737c03872 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1252,7 +1252,6 @@ static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
 
 static void monitor_parse(const char *str, const char *mode, bool pretty)
 {
-    static int monitor_device_index = 0;
     QemuOpts *opts;
     const char *p;
     char label[32];
@@ -1260,8 +1259,9 @@ static void monitor_parse(const char *str, const char *mode, bool pretty)
     if (strstart(str, "chardev:", &p)) {
         snprintf(label, sizeof(label), "%s", p);
     } else {
-        snprintf(label, sizeof(label), "compat_monitor%d",
-                 monitor_device_index);
+        g_autofree char *id = monitor_compat_id();
+        assert(strlen(id) < sizeof(label));
+        memcpy(label, id, strlen(id) + 1);
         opts = qemu_chr_parse_compat(label, str, true);
         if (!opts) {
             error_report("parse error: %s", str);
@@ -1277,7 +1277,6 @@ static void monitor_parse(const char *str, const char *mode, bool pretty)
     } else {
         assert(pretty == false);
     }
-    monitor_device_index++;
 }
 
 struct device_config {
-- 
2.54.0


