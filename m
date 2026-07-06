Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4DE3C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 14:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjr3-00020z-Bp; Mon, 06 Jul 2026 09:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wgjql-0001rd-5I
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:59:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wgjqj-0001cg-5t
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783346344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iK6bDC7EaRdOs5PB/8RxC28zOLfBXwEkty0qN8zTwRE=;
 b=RNGyrsdmN9+7XdovJbM5qRUhjzHlgn1iB6T30ieIlibP/uWtZTzXlCahLU2TXUtESeyMSj
 p5Vm4zS4mBWMxwEn23HIP4MuJWStEAvqaeX+XlQPciPQ98uRTveN0rOD1HlbNmxO0Y7C15
 g9cIWFnQ5NprurrT8gAyZKI5pcUWMqE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-Zsc1bMUbMueK1PPDsJuwAA-1; Mon,
 06 Jul 2026 09:59:01 -0400
X-MC-Unique: Zsc1bMUbMueK1PPDsJuwAA-1
X-Mimecast-MFC-AGG-ID: Zsc1bMUbMueK1PPDsJuwAA_1783346339
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54DA118052D9; Mon,  6 Jul 2026 13:58:59 +0000 (UTC)
Received: from berrange.com (unknown [10.44.48.165])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0ACCD3000B4E; Mon,  6 Jul 2026 13:58:55 +0000 (UTC)
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
Subject: [PATCH v7 07/35] monitor: add 'chardev' property to Monitor base class
Date: Mon,  6 Jul 2026 14:57:55 +0100
Message-ID: <20260706135824.2623960-8-berrange@redhat.com>
In-Reply-To: <20260706135824.2623960-1-berrange@redhat.com>
References: <20260706135824.2623960-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 monitor/hmp.c              | 24 ++++++++++--------------
 monitor/monitor-internal.h |  2 ++
 monitor/monitor.c          | 36 ++++++++++++++++++++++++++++++++++++
 monitor/qmp.c              | 33 +++++++++++++++------------------
 4 files changed, 63 insertions(+), 32 deletions(-)

diff --git a/monitor/hmp.c b/monitor/hmp.c
index 1704166326..34a39b071c 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1542,28 +1542,24 @@ static void monitor_readline_flush(void *opaque)
 void monitor_new_hmp(const char *id, const char *chardev_id,
                      bool use_readline, Error **errp)
 {
+    ERRP_GUARD();
     MonitorHMP *mon;
     g_autofree char *autoid = id ? NULL : monitor_compat_id();
-    Chardev *chr;
-    Object *obj;
+    Object *obj = object_new_with_props(TYPE_MONITOR_HMP,
+                                        object_get_objects_root(),
+                                        id ? id : autoid,
+                                        errp,
+                                        "chardev", chardev_id,
+                                        NULL);
 
-    chr = qemu_chr_find(chardev_id);
-    if (chr == NULL) {
-        error_setg(errp, "chardev \"%s\" not found", chardev_id);
-        return;
-    }
-
-    obj = object_new_with_props(TYPE_MONITOR_HMP,
-                                object_get_objects_root(),
-                                id ? id : autoid,
-                                errp,
-                                NULL);
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
index cb0299a2f7..1648946c92 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -79,10 +79,31 @@ OBJECT_DEFINE_ABSTRACT_TYPE(Monitor, monitor, MONITOR, OBJECT);
 
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
@@ -738,6 +759,21 @@ char *monitor_compat_id(void)
     return g_strdup_printf("compat_monitor%d", monitor_device_index++);
 }
 
+void monitor_complete(Monitor *mon, Error **errp)
+{
+    if (mon->chardev_id) {
+        Chardev *chr = qemu_chr_find(mon->chardev_id);
+        if (chr == NULL) {
+            error_setg(errp, "chardev \"%s\" not found", mon->chardev_id);
+            return;
+        }
+
+        if (!qemu_chr_fe_init(&mon->chr, chr, errp)) {
+            return;
+        }
+    }
+}
+
 int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
 {
     ERRP_GUARD();
diff --git a/monitor/qmp.c b/monitor/qmp.c
index e2f841212b..df35b530ed 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -530,36 +530,33 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
 void monitor_new_qmp(const char *id, const char *chardev_id,
                      bool pretty, Error **errp)
 {
+    ERRP_GUARD();
     MonitorQMP *mon;
     g_autofree char *autoid = id ? NULL : monitor_compat_id();
-    Chardev *chr;
-    Object *obj;
+    Object *obj = object_new_with_props(TYPE_MONITOR_QMP,
+                                        object_get_objects_root(),
+                                        id ? id : autoid,
+                                        errp,
+                                        "chardev", chardev_id,
+                                        NULL);
 
-    chr = qemu_chr_find(chardev_id);
-    if (chr == NULL) {
-        error_setg(errp, "chardev \"%s\" not found", chardev_id);
-        return;
-    }
-
-    obj = object_new_with_props(TYPE_MONITOR_QMP,
-                                object_get_objects_root(),
-                                id ? id : autoid,
-                                errp,
-                                NULL);
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
 
@@ -572,12 +569,12 @@ void monitor_new_qmp(const char *id, const char *chardev_id,
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
-- 
2.55.0


