Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E5BCD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 12:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXIA5-0001zl-90; Wed, 10 Jun 2026 08:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXIA3-0001qe-8F
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 08:35:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXIA0-0003fU-Fx
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 08:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781094955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FKN4ByGxnLkT8nR+yrjTMbdE4C61tjRGk8gZvip8kHw=;
 b=gtYFt5bzIf18TDHd108uZc5soYhCbbjU8JPM/6BLGBPxrCNokuYlDJ6fX7NSt++fFwQ833
 +1m+AA3/OZmt6yfbzKmtW3eJpdAoqfapmKUcdcX+lZLjY/80gAL8ybo0cyzkgC//3SM7Ia
 P+C2tm6wvaxj1iG1Hw49Lu2jVa0NDBY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-Mb4h_I3UND2cICI8FWq3Dg-1; Wed,
 10 Jun 2026 08:35:51 -0400
X-MC-Unique: Mb4h_I3UND2cICI8FWq3Dg-1
X-Mimecast-MFC-AGG-ID: Mb4h_I3UND2cICI8FWq3Dg_1781094950
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09699184556C; Wed, 10 Jun 2026 12:35:50 +0000 (UTC)
Received: from berrange.com (unknown [10.44.50.112])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 80D9A364CC; Wed, 10 Jun 2026 12:35:46 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Brauner <brauner@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 22/35] monitor: implement "user creatable" interface for
 adding monitors
Date: Wed, 10 Jun 2026 13:34:02 +0100
Message-ID: <20260610123415.2883603-23-berrange@redhat.com>
In-Reply-To: <20260610123415.2883603-1-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
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

Implement the user creatable QOM interface and define the monitor-qmp
and monitor-hmp types in QAPI. This unlocks the ability to create them
on the command line with -object or in HMP/QMP with object_add.

For example:

  $QEMU -chardev stdio,id=monchr0 -object monitor-hmp,id=mon0,chrdev=monchr0

Initially the "prepare_delete" callback is hardcoded to return an error
which means -object and object_add can be used, but object_del will fail.
Support for deleting monitors will be introduced in subsequent commits.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 monitor/hmp.c              | 70 ++++++++++++++++++++++++--------------
 monitor/monitor-internal.h |  1 -
 monitor/monitor.c          | 14 ++++++--
 monitor/qmp.c              | 46 +++++++++++++++++--------
 qapi/qom.json              | 43 +++++++++++++++++++++++
 stubs/monitor-internal.c   |  1 +
 system/vl.c                |  8 ++++-
 7 files changed, 138 insertions(+), 45 deletions(-)

diff --git a/monitor/hmp.c b/monitor/hmp.c
index b8cccdcde3..2cd508f1ee 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -40,6 +40,7 @@
 #include "qemu/base-arch-defs.h"
 #include "qemu/target-info.h"
 #include "qemu/units.h"
+#include "qom/object_interfaces.h"
 #include "exec/gdbstub.h"
 #include "system/block-backend.h"
 #include "trace.h"
@@ -71,10 +72,13 @@ static void monitor_hmp_set_readline(Object *obj, bool val, Error **errp)
 int monitor_hmp_vprintf(Monitor *mon, const char *fmt, va_list ap)
     G_GNUC_PRINTF(2, 0);
 static void monitor_hmp_accept_input(Monitor *mon);
+static void monitor_hmp_complete(UserCreatable *uc, Error **errp);
+static bool monitor_hmp_prepare_delete(UserCreatable *uc, Error **errp);
 
 static void monitor_hmp_class_init(ObjectClass *cls, const void *data)
 {
     MonitorClass *moncls = MONITOR_CLASS(cls);
+    UserCreatableClass *ucc = USER_CREATABLE_CLASS(cls);
 
     object_class_property_add_bool(cls, "readline",
                                    monitor_hmp_get_readline,
@@ -82,6 +86,9 @@ static void monitor_hmp_class_init(ObjectClass *cls, const void *data)
 
     moncls->vprintf = monitor_hmp_vprintf;
     moncls->accept_input = monitor_hmp_accept_input;
+
+    ucc->complete = monitor_hmp_complete;
+    ucc->prepare_delete = monitor_hmp_prepare_delete;
 }
 
 static void monitor_hmp_init(Object *obj)
@@ -1604,42 +1611,53 @@ static void monitor_readline_flush(void *opaque)
 
 void monitor_new_hmp(const char *chardev_id, bool use_readline, Error **errp)
 {
-    ERRP_GUARD();
-    MonitorHMP *mon;
     static int counter;
     g_autofree char *id = g_strdup_printf("hmpcompat%d", counter++);
-    Object *obj = object_new_with_props(TYPE_MONITOR_HMP,
-                                        object_get_objects_root(),
-                                        id,
-                                        errp,
-                                        "chardev", chardev_id,
-                                        "readline", use_readline ? "yes" : "no",
-                                        NULL);
-
-    if (!obj) {
-        return;
-    }
+    object_new_with_props(TYPE_MONITOR_HMP,
+                          object_get_objects_root(),
+                          id,
+                          errp,
+                          "chardev", chardev_id,
+                          "readline", use_readline ? "yes" : "no",
+                          NULL);
+}
 
-    mon = MONITOR_HMP(obj);
+static void monitor_hmp_complete(UserCreatable *uc, Error **errp)
+{
+    MonitorHMP *mon = MONITOR_HMP(uc);
+    UserCreatableClass *ucc_parent =
+        USER_CREATABLE_CLASS(
+            object_class_get_parent(
+                OBJECT_CLASS(MONITOR_HMP_GET_CLASS(mon))));
+    ERRP_GUARD();
 
-    monitor_complete(MONITOR(mon), errp);
+    ucc_parent->complete(uc, errp);
     if (*errp) {
-        object_unparent(OBJECT(mon));
         return;
     }
 
-    if (mon->use_readline) {
-        mon->rs = readline_init(monitor_readline_printf,
-                                monitor_readline_flush,
-                                mon,
-                                monitor_find_completion);
-        monitor_read_command(mon, 0);
+    if (mon->parent_obj.chardev_id) {
+        if (mon->use_readline) {
+            mon->rs = readline_init(monitor_readline_printf,
+                                    monitor_readline_flush,
+                                    mon,
+                                    monitor_find_completion);
+            monitor_read_command(mon, 0);
+        }
+
+        qemu_chr_fe_set_handlers(&mon->parent_obj.chr,
+                                 monitor_can_read,
+                                 monitor_read,
+                                 monitor_event, NULL,
+                                 &mon->parent_obj, NULL, true);
+        monitor_list_append(&mon->parent_obj);
     }
+}
 
-    qemu_chr_fe_set_handlers(&mon->parent_obj.chr,
-                             monitor_can_read, monitor_read, monitor_event,
-                             NULL, &mon->parent_obj, NULL, true);
-    monitor_list_append(&mon->parent_obj);
+static bool monitor_hmp_prepare_delete(UserCreatable *uc, Error **errp)
+{
+    error_setg(errp, "Deleting HMP monitors is not supported");
+    return false;
 }
 
 /**
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index fe5703af6d..012d442a20 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -204,7 +204,6 @@ extern QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
 extern QemuMutex monitor_lock;
 extern MonitorList mon_list;
 
-void monitor_complete(Monitor *mon, Error **errp);
 bool monitor_requires_iothread(const Monitor *mon);
 int monitor_can_read(void *opaque);
 void monitor_list_append(Monitor *mon);
diff --git a/monitor/monitor.c b/monitor/monitor.c
index c401e23b7b..9257dae0be 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -29,6 +29,7 @@
 #include "qapi/qapi-emit-events.h"
 #include "qapi/qapi-visit-control.h"
 #include "qobject/qdict.h"
+#include "qom/object_interfaces.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "system/qtest.h"
@@ -73,7 +74,8 @@ static GHashTable *coroutine_mon; /* Maps Coroutine* to Monitor* */
 MonitorList mon_list;
 static bool monitor_destroyed;
 
-OBJECT_DEFINE_TYPE(Monitor, monitor, MONITOR, OBJECT);
+OBJECT_DEFINE_TYPE_EXTENDED(Monitor, monitor, MONITOR, OBJECT, true,
+                            { TYPE_USER_CREATABLE }, {});
 
 static void monitor_finalize(Object *obj)
 {
@@ -100,11 +102,17 @@ static void monitor_set_chardev_id(Object *obj, const char *str, Error **errp)
     mon->chardev_id = g_strdup(str);
 }
 
+static void monitor_complete(UserCreatable *uc, Error **errp);
+
 static void monitor_class_init(ObjectClass *cls, const void *data)
 {
+    UserCreatableClass *ucc = USER_CREATABLE_CLASS(cls);
+
     object_class_property_add_str(cls, "chardev",
                                   monitor_get_chardev_id,
                                   monitor_set_chardev_id);
+
+    ucc->complete = monitor_complete;
 }
 
 static void monitor_init(Object *obj)
@@ -679,8 +687,10 @@ void monitor_init_globals(void)
     aio_co_schedule(iohandler_get_aio_context(), qmp_dispatcher_co);
 }
 
-void monitor_complete(Monitor *mon, Error **errp)
+static void monitor_complete(UserCreatable *uc, Error **errp)
 {
+    Monitor *mon = MONITOR(uc);
+
     if (mon->chardev_id) {
         Chardev *chr = qemu_chr_find(mon->chardev_id);
         if (chr == NULL) {
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 5cf38c6273..ff39b8cda4 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -31,6 +31,7 @@
 #include "qobject/qdict.h"
 #include "qobject/qjson.h"
 #include "qobject/qlist.h"
+#include "qom/object_interfaces.h"
 #include "trace.h"
 
 /*
@@ -101,10 +102,13 @@ static void monitor_qmp_set_pretty(Object *obj, bool val, Error **errp)
 
 static void monitor_qmp_emit_event(Monitor *mon, QAPIEvent event, QDict *qdict);
 static bool monitor_qmp_requires_iothread(const Monitor *mon);
+static void monitor_qmp_complete(UserCreatable *uc, Error **errp);
+static bool monitor_qmp_prepare_delete(UserCreatable *uc, Error **errp);
 
 static void monitor_qmp_class_init(ObjectClass *cls, const void *data)
 {
     MonitorClass *moncls = MONITOR_CLASS(cls);
+    UserCreatableClass *ucc = USER_CREATABLE_CLASS(cls);
 
     object_class_property_add_bool(cls, "pretty",
                                    monitor_qmp_get_pretty,
@@ -112,6 +116,9 @@ static void monitor_qmp_class_init(ObjectClass *cls, const void *data)
 
     moncls->emit_event = monitor_qmp_emit_event;
     moncls->requires_iothread = monitor_qmp_requires_iothread;
+
+    ucc->complete = monitor_qmp_complete;
+    ucc->prepare_delete = monitor_qmp_prepare_delete;
 }
 
 static void handle_qmp_command(void *opaque, QObject *req, Error *err);
@@ -582,25 +589,28 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
 
 void monitor_new_qmp(const char *chardev_id, bool pretty, Error **errp)
 {
-    MonitorQMP *mon;
     static int counter;
     g_autofree char *id = g_strdup_printf("qmpcompat%d", counter++);
-    Object *obj = object_new_with_props(TYPE_MONITOR_QMP,
-                                        object_get_objects_root(),
-                                        id,
-                                        errp,
-                                        "chardev", chardev_id,
-                                        "pretty", pretty ? "yes" : "no",
-                                        NULL);
-
-    if (!obj) {
-        return;
-    }
+    object_new_with_props(TYPE_MONITOR_QMP,
+                          object_get_objects_root(),
+                          id,
+                          errp,
+                          "chardev", chardev_id,
+                          "pretty", pretty ? "yes" : "no",
+                          NULL);
+}
 
-    mon = MONITOR_QMP(obj);
-    monitor_complete(MONITOR(mon), errp);
+static void monitor_qmp_complete(UserCreatable *uc, Error **errp)
+{
+    MonitorQMP *mon = MONITOR_QMP(uc);
+    UserCreatableClass *ucc_parent =
+        USER_CREATABLE_CLASS(
+            object_class_get_parent(
+                OBJECT_CLASS(MONITOR_QMP_GET_CLASS(mon))));
+    ERRP_GUARD();
+
+    ucc_parent->complete(uc, errp);
     if (*errp) {
-        object_unparent(OBJECT(mon));
         return;
     }
 
@@ -632,3 +642,9 @@ void monitor_new_qmp(const char *chardev_id, bool pretty, Error **errp)
         monitor_list_append(&mon->parent_obj);
     }
 }
+
+static bool monitor_qmp_prepare_delete(UserCreatable *uc, Error **errp)
+{
+    error_setg(errp, "Deleting QMP monitors is not supported");
+    return false;
+}
diff --git a/qapi/qom.json b/qapi/qom.json
index dd45ac1087..6ed510858e 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1187,6 +1187,45 @@
   'data': { '*cpu-affinity': ['uint16'],
             '*node-affinity': ['uint16'] } }
 
+##
+# @MonitorProperties:
+#
+# Properties for all monitors
+#
+# @chardev: ID of the character device providing the monitor transport
+#
+# Since: 11.1
+##
+{ 'struct': 'MonitorProperties',
+  'data': { 'chardev': 'str' }}
+
+##
+# @MonitorHMPProperties:
+#
+# Properties for the HMP monitor
+#
+# @readline: whether to enable readline for interactive command
+#      usage (default: enabled)
+#
+# Since: 11.1
+##
+{ 'struct': 'MonitorHMPProperties',
+  'base': 'MonitorProperties',
+  'data': { '*readline': 'bool' } }
+
+##
+# @MonitorQMPProperties:
+#
+# Properties for the QMP monitor
+#
+# @pretty: whether to pretty print JSON responses (default: disabled)
+#
+# Since: 11.1
+##
+{ 'struct': 'MonitorQMPProperties',
+  'base': 'MonitorProperties',
+  'data': { '*pretty': 'bool' } }
+
 ##
 # @ObjectType:
 #
@@ -1237,6 +1276,8 @@
     'memory-backend-ram',
     { 'name': 'memory-backend-shm',
       'if': 'CONFIG_POSIX' },
+    'monitor-hmp',
+    'monitor-qmp',
     'pef-guest',
     { 'name': 'pr-manager-helper',
       'if': 'CONFIG_LINUX' },
@@ -1315,6 +1356,8 @@
       'memory-backend-ram':         'MemoryBackendProperties',
       'memory-backend-shm':         { 'type': 'MemoryBackendShmProperties',
                                       'if': 'CONFIG_POSIX' },
+      'monitor-hmp':                {'type': 'MonitorHMPProperties' },
+      'monitor-qmp':                {'type': 'MonitorQMPProperties' },
       'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
                                       'if': 'CONFIG_LINUX' },
       'qtest':                      'QtestProperties',
diff --git a/stubs/monitor-internal.c b/stubs/monitor-internal.c
index 51db7588b9..59ccc4b35c 100644
--- a/stubs/monitor-internal.c
+++ b/stubs/monitor-internal.c
@@ -10,4 +10,5 @@ int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
 
 void monitor_new_hmp(const char *chardev_id, bool use_readline, Error **errp)
 {
+    g_assert_not_reached();
 }
diff --git a/system/vl.c b/system/vl.c
index 21ef2dac51..86f09a8b5c 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1829,6 +1829,10 @@ static void object_option_add_visitor(Visitor *v)
 {
     ObjectOption *opt = g_new0(ObjectOption, 1);
     visit_type_ObjectOptions(v, NULL, &opt->opts, &error_fatal);
+    if (opt->opts->qom_type == OBJECT_TYPE_MONITOR_HMP ||
+        opt->opts->qom_type == OBJECT_TYPE_MONITOR_QMP) {
+        default_monitor = 0;
+    }
     QTAILQ_INSERT_TAIL(&object_opts, opt, next);
 }
 
@@ -1970,7 +1974,9 @@ static bool object_create_early(const char *type)
 
     /* Reason: property "chardev" */
     if (g_str_equal(type, "rng-egd") ||
-        g_str_equal(type, "qtest")) {
+        g_str_equal(type, "qtest") ||
+        g_str_equal(type, "monitor-hmp") ||
+        g_str_equal(type, "monitor-qmp")) {
         return false;
     }
 
-- 
2.54.0


