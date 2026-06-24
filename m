Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB76CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcRYi-00072j-TG; Wed, 24 Jun 2026 13:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcRYf-0006zK-AO
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:38:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcRYV-0004RC-AB
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782322704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e4m9gprU/aTCy4ce6IzOXltgS6Oq/eTRIyMo+pW9hpw=;
 b=e2aJKAj3xlO86rqoy89ut4+trM5xoxEAv49OZ9K11hCNxuKQhtn3bP5CHOj1V1ADWJIXUF
 DmARF/blNd8Cdweo4sLk1xdAFLq7N++1LB6PkQtiItIqlvBfFVrc7MRJsRkQ8NinOM7iZo
 YiABd1XfXoF5I4GCqNQXtI3XnWBfLTw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-DEtvYUrcPOCfUAn9e3HiRw-1; Wed,
 24 Jun 2026 13:38:20 -0400
X-MC-Unique: DEtvYUrcPOCfUAn9e3HiRw-1
X-Mimecast-MFC-AGG-ID: DEtvYUrcPOCfUAn9e3HiRw_1782322699
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F2F41955EB7; Wed, 24 Jun 2026 17:38:19 +0000 (UTC)
Received: from berrange.com (unknown [10.44.32.102])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D1676180028B; Wed, 24 Jun 2026 17:38:15 +0000 (UTC)
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
Subject: [PATCH v5 05/35] monitor: minimal conversion of monitors to QOM
Date: Wed, 24 Jun 2026 18:37:21 +0100
Message-ID: <20260624173752.2928717-6-berrange@redhat.com>
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

This introduces a Monitor QOM object, with MonitorHMP and
MonitorQMP subclasses. This is the bare minimum conversion
of just the type declarations and replacing g_new/g_free
with object_new/object_unref.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/monitor/monitor.h  | 11 ++++++++++-
 monitor/hmp.c              | 29 +++++++++++++++++++++++++++--
 monitor/monitor-internal.h | 18 ++++++++++++++++--
 monitor/monitor.c          | 18 ++++++++++++++++--
 monitor/qmp-cmds.c         | 15 ++++++++-------
 monitor/qmp.c              | 29 +++++++++++++++++++++++++++--
 6 files changed, 104 insertions(+), 16 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index b9642b58ba..2e9f9e12e9 100644
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
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 4e4468424a..81047d2513 100644
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
@@ -1526,10 +1540,21 @@ static void monitor_readline_flush(void *opaque)
 
 void monitor_new_hmp(Chardev *chr, bool use_readline, Error **errp)
 {
-    MonitorHMP *mon = g_new0(MonitorHMP, 1);
+    MonitorHMP *mon;
+    static int counter;
+    g_autofree char *id = g_strdup_printf("hmpcompat%d", counter++);
+    Object *obj = object_new_with_props(TYPE_MONITOR_HMP,
+                                        object_get_objects_root(),
+                                        id,
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
index a87597e606..a497c25c54 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -73,6 +73,20 @@ static GHashTable *coroutine_mon; /* Maps Coroutine* to Monitor* */
 MonitorList mon_list;
 static bool monitor_destroyed;
 
+OBJECT_DEFINE_TYPE(Monitor, monitor, MONITOR, OBJECT);
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
@@ -598,7 +612,7 @@ void monitor_list_append(Monitor *mon)
 
     if (mon) {
         monitor_data_destroy(mon);
-        g_free(mon);
+        object_unparent(OBJECT(mon));
     }
 }
 
@@ -680,7 +694,7 @@ void monitor_cleanup(void)
         monitor_flush(mon);
         monitor_data_destroy(mon);
         qemu_mutex_lock(&monitor_lock);
-        g_free(mon);
+        object_unparent(OBJECT(mon));
     }
     qemu_mutex_unlock(&monitor_lock);
 
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
index cb28a95efd..5231ed506a 100644
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
@@ -515,10 +529,21 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
 
 void monitor_new_qmp(Chardev *chr, bool pretty, Error **errp)
 {
-    MonitorQMP *mon = g_new0(MonitorQMP, 1);
+    MonitorQMP *mon;
+    static int counter;
+    g_autofree char *id = g_strdup_printf("qmpcompat%d", counter++);
+    Object *obj = object_new_with_props(TYPE_MONITOR_QMP,
+                                        object_get_objects_root(),
+                                        id,
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
-- 
2.54.0


