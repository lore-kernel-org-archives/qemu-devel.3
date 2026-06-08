Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E46CD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWUHz-0004OD-5O; Mon, 08 Jun 2026 03:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUGs-00036x-Mz
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:19:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUGp-0000zm-BZ
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780903178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZoHRGobLUxqerXDNbYNx+RPADFh2pje54raj1bkZA5c=;
 b=jS+SqNBz1J51JYzyp+YbgJ11MvML3+HerOu7DQ85/B6LANL5LI35UzG77N/oCugurTt2Ed
 8JhHZO/yPLn/FWvH783OxngokMHWhTnsN8gvLQprfuPRLdmPD0XfC2Qma4dgDB1ILDNcDF
 cnURqYnLvrJjx+HwwAf3z/2QmC011PU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-_viUqlscPteF84vU1Eps_w-1; Mon,
 08 Jun 2026 03:19:32 -0400
X-MC-Unique: _viUqlscPteF84vU1Eps_w-1
X-Mimecast-MFC-AGG-ID: _viUqlscPteF84vU1Eps_w_1780903171
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD0341956050; Mon,  8 Jun 2026 07:19:30 +0000 (UTC)
Received: from localhost (unknown [10.44.22.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 65C9019560A3; Mon,  8 Jun 2026 07:19:28 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 08 Jun 2026 11:16:50 +0400
Subject: [PATCH v2 32/33] ui/dbus: handle console hotplug/unplug events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-b4-ui-v2-32-9ea6355ea08f@redhat.com>
References: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
In-Reply-To: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6566;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=HZFDz6Yi9B8ywej4sh9mgPViu/0HVObhL89ecuGVYbM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqJmxOQtT3Gq4sZ0WBAir8PP2PqTG0UbXP3q1Ph
 26g7FGAtViJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiZsTgAKCRDa6OEJdZac
 5ZAXEACSvx2OxbDRjNhH9ru0ZL7tTKhvNfgkUM8cTgtyJY7vID5BTobQpaHSPcH83WTGJS1wZ+Q
 xxTvqFBLFXfArFSvFQ7p0KC3eBns/dmQbqjnFQ+s/f5XaVfVs63ACvdvLKemaYjyXrMbDM4RyFc
 f1im9pfa3a4CCW6k37hhefQQK4oVCaFTb20nM6rksrjhPSqzfGiYH/zz+45eXUiugokMphewRj7
 7GqPWg/69aROFx+nl0s8tVWXQbsyHENpIK2wkrKlOWJsd9qyEIdMFcnRbyDXcg9FG+lJ0O7JDBo
 h6zhHHVu1O7RHpQLaNARxH7xQPNlJGNC1QPHq1in05ufIbD5NUwNthDCi3Mm636zI+YFqPhFYyz
 yhErF4xhEoOZJCXYHXsQDHg/gp7s9mZTKNSZQiwFn9tWo5MNYlwbca5zNjg4u9r/l7iEtOVwhum
 PAx7JWfaqJ2fj8iotuf/ztp29YkPl1eng97GJHukoLf9n/RfE18va6QVNpift1u08KogWaFnO/m
 QqmtjE72N+O4hCBQAa3xr8Z8RgIwQ/L2qq+AmrnefrvJnyEIIcO/r5zGsr2N/rr7xF5d5dLmrsk
 21J+cM19YtTk94sZLX5PgjILXAI3mICBpRuIfI7l/ThG8jJrYk04yiqwubH9RzZZNnqcunDbtdk
 1J2EmOSmmYdTdVg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Subscribe to QemuConsoleEvent notifications to dynamically add and
remove D-Bus display consoles. This mirrors the GTK backend's
handling added in the previous commits.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus.h         |  3 ++
 ui/dbus-console.c |  5 +++
 ui/dbus.c         | 93 +++++++++++++++++++++++++++++++++++++++++++++----------
 3 files changed, 84 insertions(+), 17 deletions(-)

diff --git a/ui/dbus.h b/ui/dbus.h
index e4e78590b49..d2cc176648a 100644
--- a/ui/dbus.h
+++ b/ui/dbus.h
@@ -60,6 +60,7 @@ struct DBusDisplay {
     DBusClipboardRequest clipboard_request[QEMU_CLIPBOARD_SELECTION__COUNT];
 
     Notifier notifier;
+    Notifier console_notifier;
 };
 
 #ifdef WIN32
@@ -86,6 +87,8 @@ dbus_display_console_new(DBusDisplay *display, QemuConsole *con);
 int
 dbus_display_console_get_index(DBusDisplayConsole *ddc);
 
+QemuConsole *
+dbus_display_console_get_qemu_console(DBusDisplayConsole *ddc);
 
 extern const DisplayChangeListenerOps dbus_console_dcl_ops;
 
diff --git a/ui/dbus-console.c b/ui/dbus-console.c
index a4a17f5b4d0..66ed4b1def4 100644
--- a/ui/dbus-console.c
+++ b/ui/dbus-console.c
@@ -533,6 +533,11 @@ int dbus_display_console_get_index(DBusDisplayConsole *ddc)
     return qemu_console_get_index(ddc->dcl.con);
 }
 
+QemuConsole *dbus_display_console_get_qemu_console(DBusDisplayConsole *ddc)
+{
+    return ddc->dcl.con;
+}
+
 DBusDisplayConsole *
 dbus_display_console_new(DBusDisplay *display, QemuConsole *con)
 {
diff --git a/ui/dbus.c b/ui/dbus.c
index b23cb44c535..7be0f8e2611 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -142,6 +142,9 @@ dbus_display_finalize(Object *o)
 {
     DBusDisplay *dd = DBUS_DISPLAY(o);
 
+    if (dd->console_notifier.notify) {
+        qemu_console_remove_notifier(&dd->console_notifier);
+    }
     if (dd->notifier.notify) {
         dbus_display_notifier_remove(&dd->notifier);
     }
@@ -164,14 +167,35 @@ dbus_display_finalize(Object *o)
     dbus_display = NULL;
 }
 
+static void
+dbus_update_console_ids(DBusDisplay *dd)
+{
+    g_autoptr(GArray) arr = g_array_new(FALSE, FALSE, sizeof(guint32));
+
+    for (guint i = 0; i < dd->consoles->len; i++) {
+        DBusDisplayConsole *ddc = g_ptr_array_index(dd->consoles, i);
+        guint32 idx = dbus_display_console_get_index(ddc);
+        g_array_append_val(arr, idx);
+    }
+
+    g_object_set(dd->iface, "console-ids",
+        g_variant_new_fixed_array(G_VARIANT_TYPE("u"),
+            arr->data, arr->len,
+            sizeof(guint32)),
+        NULL);
+}
+
 static bool
-dbus_display_add_console(DBusDisplay *dd, int idx, Error **errp)
+dbus_display_add_console(DBusDisplay *dd, QemuConsole *con, Error **errp)
 {
-    QemuConsole *con;
     DBusDisplayConsole *dbus_console;
 
-    con = qemu_console_lookup_by_index(idx);
-    assert(con);
+    for (guint i = 0; i < dd->consoles->len; i++) {
+        DBusDisplayConsole *ddc = g_ptr_array_index(dd->consoles, i);
+        if (dbus_display_console_get_qemu_console(ddc) == con) {
+            return true;
+        }
+    }
 
     if (qemu_console_is_graphic(con) &&
         dd->gl_mode != DISPLAY_GL_MODE_OFF) {
@@ -179,20 +203,58 @@ dbus_display_add_console(DBusDisplay *dd, int idx, Error **errp)
     }
 
     dbus_console = dbus_display_console_new(dd, con);
-    g_ptr_array_insert(dd->consoles, idx, dbus_console);
+    g_ptr_array_add(dd->consoles, dbus_console);
     g_dbus_object_manager_server_export(dd->server,
                                         G_DBUS_OBJECT_SKELETON(dbus_console));
+    dbus_update_console_ids(dd);
     return true;
 }
 
+static void
+dbus_display_remove_console(DBusDisplay *dd, QemuConsole *con)
+{
+    for (guint i = 0; i < dd->consoles->len; i++) {
+        DBusDisplayConsole *ddc = g_ptr_array_index(dd->consoles, i);
+        if (dbus_display_console_get_qemu_console(ddc) == con) {
+            if (display_opengl) {
+                qemu_console_set_display_gl_ctx(con, NULL);
+            }
+            g_dbus_object_manager_server_unexport(
+                dd->server,
+                g_dbus_object_get_object_path(G_DBUS_OBJECT(ddc)));
+            g_ptr_array_remove_index(dd->consoles, i);
+            dbus_update_console_ids(dd);
+            break;
+        }
+    }
+}
+
+static void
+dbus_console_notify(Notifier *n, void *data)
+{
+    DBusDisplay *dd = container_of(n, DBusDisplay, console_notifier);
+    QemuConsoleEvent *event = data;
+
+    switch (event->type) {
+    case QEMU_CONSOLE_ADDED: {
+        Error *err = NULL;
+        if (!dbus_display_add_console(dd, event->con, &err)) {
+            error_report_err(err);
+        }
+        break;
+    }
+    case QEMU_CONSOLE_REMOVED:
+        dbus_display_remove_console(dd, event->con);
+        break;
+    }
+}
+
 static void
 dbus_display_complete(UserCreatable *uc, Error **errp)
 {
     DBusDisplay *dd = DBUS_DISPLAY(uc);
     g_autoptr(GError) err = NULL;
     g_autofree char *uuid = qemu_uuid_unparse_strdup(&qemu_uuid);
-    g_autoptr(GArray) consoles = NULL;
-    GVariant *console_ids;
     int idx;
 
     if (!object_resolve_path_type("", TYPE_DBUS_DISPLAY, NULL)) {
@@ -233,27 +295,24 @@ dbus_display_complete(UserCreatable *uc, Error **errp)
         }
     }
 
-    consoles = g_array_new(FALSE, FALSE, sizeof(guint32));
     for (idx = 0;; idx++) {
-        if (!qemu_console_lookup_by_index(idx)) {
+        QemuConsole *con = qemu_console_lookup_by_index(idx);
+        if (!con) {
             break;
         }
-        if (!dbus_display_add_console(dd, idx, errp)) {
+        if (!dbus_display_add_console(dd, con, errp)) {
             return;
         }
-        g_array_append_val(consoles, idx);
     }
 
-    console_ids = g_variant_new_from_data(
-        G_VARIANT_TYPE("au"),
-        consoles->data, consoles->len * sizeof(guint32), TRUE,
-        (GDestroyNotify)g_array_unref, consoles);
-    g_steal_pointer(&consoles);
     g_object_set(dd->iface,
                  "name", qemu_name ?: "QEMU " QEMU_VERSION,
                  "uuid", uuid,
-                 "console-ids", console_ids,
                  NULL);
+    dbus_update_console_ids(dd);
+
+    dd->console_notifier.notify = dbus_console_notify;
+    qemu_console_add_notifier(&dd->console_notifier);
 
     if (dd->bus) {
         g_dbus_object_manager_server_set_connection(dd->server, dd->bus);

-- 
2.54.0


