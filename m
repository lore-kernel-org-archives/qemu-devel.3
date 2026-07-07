Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657FCC44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh3aK-0002Xa-Ee; Tue, 07 Jul 2026 07:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wh3aA-0002Nu-Ib
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:03:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wh3a5-00085k-0J
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783422191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=36C4nZfybz50g8FrCaHi5x+CSAEXG8i0zQCQ5lWdL20=;
 b=KS+hgaxeQKISR5fCa37IX1I68thorPW3GHP6gOGBrlP5phOOFINw5wTVGP8LyYvqyUihcx
 +ATFWzDkQudTU0Q7aUdjyu+FRBLodalURC5j7+LEsf/K9vb5ZqUHlW8EIjii72Ws8zmibr
 KkgYwRCk1cvWBQtV0Omy3eW45kRCGhA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-FiQMaQx8OtCP1MD3p2yUKw-1; Tue,
 07 Jul 2026 07:03:10 -0400
X-MC-Unique: FiQMaQx8OtCP1MD3p2yUKw-1
X-Mimecast-MFC-AGG-ID: FiQMaQx8OtCP1MD3p2yUKw_1783422189
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C38D11808887
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 11:03:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4919218005B3
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 11:03:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F25D221E61A5; Tue, 07 Jul 2026 13:03:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>
Subject: [PULL 23/35] monitor: implement "user creatable" interface for adding
 monitors
Date: Tue,  7 Jul 2026 13:02:48 +0200
Message-ID: <20260707110300.1918153-24-armbru@redhat.com>
In-Reply-To: <20260707110300.1918153-1-armbru@redhat.com>
References: <20260707110300.1918153-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

From: Daniel P. Berrangé <berrange@redhat.com>

Implement the user creatable QOM interface and define the monitor-qmp
and monitor-hmp types in QAPI. This unlocks the ability to create them
on the command line with -object or in HMP/QMP with object_add.

For example:

  $QEMU -chardev stdio,id=monchr0 -object monitor-hmp,id=mon0,chrdev=monchr0

Initially the "prepare_delete" callback is hardcoded to return an error
which means -object and object_add can be used, but object_del will fail.
Support for deleting monitors will be introduced in subsequent commits.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Peter Krempa <pkrempa@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260706135824.2623960-24-berrange@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/qom.json              | 43 +++++++++++++++++++++++
 monitor/monitor-internal.h |  1 -
 monitor/hmp.c              | 72 ++++++++++++++++++++++++--------------
 monitor/monitor.c          | 14 ++++++--
 monitor/qmp.c              | 45 ++++++++++++++++--------
 stubs/monitor-internal.c   |  1 +
 system/vl.c                |  8 ++++-
 7 files changed, 138 insertions(+), 46 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index dd45ac1087..33a827b9fa 100644
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
+# @readline: whether to enable readline for line editing
+#      (default: true)
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
+# @pretty: whether to pretty print JSON responses (default: false)
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
+      'monitor-hmp':                'MonitorHMPProperties',
+      'monitor-qmp':                'MonitorQMPProperties',
       'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
                                       'if': 'CONFIG_LINUX' },
       'qtest':                      'QtestProperties',
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
diff --git a/monitor/hmp.c b/monitor/hmp.c
index a51de8e467..75b93f29a3 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -40,6 +40,7 @@
 #include "qemu/target-info.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
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
@@ -1605,41 +1612,52 @@ static void monitor_readline_flush(void *opaque)
 void monitor_new_hmp(const char *id, const char *chardev_id,
                      bool use_readline, Error **errp)
 {
-    ERRP_GUARD();
-    MonitorHMP *mon;
     g_autofree char *autoid = id ? NULL : monitor_compat_id();
-    Object *obj = object_new_with_props(TYPE_MONITOR_HMP,
-                                        object_get_objects_root(),
-                                        id ? id : autoid,
-                                        errp,
-                                        "chardev", chardev_id,
-                                        "readline", use_readline ? "yes" : "no",
-                                        NULL);
+    object_new_with_props(TYPE_MONITOR_HMP,
+                          object_get_objects_root(),
+                          id ? id : autoid,
+                          errp,
+                          "chardev", chardev_id,
+                          "readline", use_readline ? "yes" : "no",
+                          NULL);
+}
 
-    if (!obj) {
-        return;
-    }
+static void monitor_hmp_complete(UserCreatable *uc, Error **errp)
+{
+    MonitorHMP *mon = MONITOR_HMP(uc);
+    UserCreatableClass *ucc_parent =
+        USER_CREATABLE_CLASS(
+            object_class_get_parent(
+                OBJECT_CLASS(MONITOR_HMP_GET_CLASS(mon))));
+    ERRP_GUARD();
 
-    mon = MONITOR_HMP(obj);
-
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
-    }
+    if (mon->parent_obj.chardev_id) {
+        if (mon->use_readline) {
+            mon->rs = readline_init(monitor_readline_printf,
+                                    monitor_readline_flush,
+                                    mon,
+                                    monitor_find_completion);
+            monitor_read_command(mon, 0);
+        }
 
-    qemu_chr_fe_set_handlers(&mon->parent_obj.chr,
-                             monitor_can_read, monitor_read, monitor_event,
-                             NULL, &mon->parent_obj, NULL, true);
-    monitor_list_append(&mon->parent_obj);
+        qemu_chr_fe_set_handlers(&mon->parent_obj.chr,
+                                 monitor_can_read,
+                                 monitor_read,
+                                 monitor_event, NULL,
+                                 &mon->parent_obj, NULL, true);
+        monitor_list_append(&mon->parent_obj);
+    }
+}
+
+static bool monitor_hmp_prepare_delete(UserCreatable *uc, Error **errp)
+{
+    error_setg(errp, "Deleting HMP monitors is not supported");
+    return false;
 }
 
 /**
diff --git a/monitor/monitor.c b/monitor/monitor.c
index f1b189c1c2..f0ca6b04ed 100644
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
@@ -75,7 +76,8 @@ static bool monitor_destroyed;
 
 int monitor_device_index;
 
-OBJECT_DEFINE_ABSTRACT_TYPE(Monitor, monitor, MONITOR, OBJECT);
+OBJECT_DEFINE_TYPE_EXTENDED(Monitor, monitor, MONITOR, OBJECT, true,
+                            { TYPE_USER_CREATABLE }, {});
 
 static void monitor_finalize(Object *obj)
 {
@@ -103,11 +105,17 @@ static void monitor_set_chardev_id(Object *obj, const char *str, Error **errp)
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
@@ -689,8 +697,10 @@ char *monitor_compat_id(void)
     return g_strdup_printf("compat_monitor%d", monitor_device_index++);
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
index bd3e6f8375..67ee491f5a 100644
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
@@ -583,25 +590,27 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
 void monitor_new_qmp(const char *id, const char *chardev_id,
                      bool pretty, Error **errp)
 {
-    ERRP_GUARD();
-    MonitorQMP *mon;
     g_autofree char *autoid = id ? NULL : monitor_compat_id();
-    Object *obj = object_new_with_props(TYPE_MONITOR_QMP,
-                                        object_get_objects_root(),
-                                        id ? id : autoid,
-                                        errp,
-                                        "chardev", chardev_id,
-                                        "pretty", pretty ? "yes" : "no",
-                                        NULL);
+    object_new_with_props(TYPE_MONITOR_QMP,
+                          object_get_objects_root(),
+                          id ? id : autoid,
+                          errp,
+                          "chardev", chardev_id,
+                          "pretty", pretty ? "yes" : "no",
+                          NULL);
+}
 
-    if (!obj) {
-        return;
-    }
+static void monitor_qmp_complete(UserCreatable *uc, Error **errp)
+{
+    MonitorQMP *mon = MONITOR_QMP(uc);
+    UserCreatableClass *ucc_parent =
+        USER_CREATABLE_CLASS(
+            object_class_get_parent(
+                OBJECT_CLASS(MONITOR_QMP_GET_CLASS(mon))));
+    ERRP_GUARD();
 
-    mon = MONITOR_QMP(obj);
-    monitor_complete(MONITOR(mon), errp);
+    ucc_parent->complete(uc, errp);
     if (*errp) {
-        object_unparent(OBJECT(mon));
         return;
     }
 
@@ -633,3 +642,9 @@ void monitor_new_qmp(const char *id, const char *chardev_id,
         monitor_list_append(&mon->parent_obj);
     }
 }
+
+static bool monitor_qmp_prepare_delete(UserCreatable *uc, Error **errp)
+{
+    error_setg(errp, "Deleting QMP monitors is not supported");
+    return false;
+}
diff --git a/stubs/monitor-internal.c b/stubs/monitor-internal.c
index f94b5e5c21..731fad221e 100644
--- a/stubs/monitor-internal.c
+++ b/stubs/monitor-internal.c
@@ -11,4 +11,5 @@ int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
 void monitor_new_hmp(const char *id, const char *chardev_id,
                      bool use_readline, Error **errp)
 {
+    g_assert_not_reached();
 }
diff --git a/system/vl.c b/system/vl.c
index 4737c03872..63bdd06dfa 100644
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


