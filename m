Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7ABFCDB471
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcM25-0007cY-Uy; Wed, 24 Jun 2026 07:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM1z-0007KD-Or
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:44:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM1y-0008Ko-1a
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782301473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qqKXza3XqDBqaBj2G9I+Ugfz3/4bOggOYUKyR7YIOpw=;
 b=f8lDpy11QBc8DG3bgMwcmXEPpnKGCa2Pk0kJOxQn3YXWZM0oM77BXOKL9gqKPRY16wDHv2
 iihHiePApj07Ln4Nz2uMCql17sqVFnEDcv7RpSl4fOQeMeOsFRajiDQPnDdiCuHKsMwphk
 PPrdgQnOXrKlkVdbUP4jRiRn+bRx7eQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-I2oOQbssMVCP97EdIXAHGg-1; Wed,
 24 Jun 2026 07:44:31 -0400
X-MC-Unique: I2oOQbssMVCP97EdIXAHGg-1
X-Mimecast-MFC-AGG-ID: I2oOQbssMVCP97EdIXAHGg_1782301471
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2592C1805C18
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:44:31 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B24136921; Wed, 24 Jun 2026 11:44:29 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 24 Jun 2026 15:41:55 +0400
Subject: [GIT PULL 33/35] ui/dbus: handle console hotplug/unplug events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260624-ui-v1-33-482147b0a7af@redhat.com>
References: <20260624-ui-v1-0-482147b0a7af@redhat.com>
In-Reply-To: <20260624-ui-v1-0-482147b0a7af@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6685;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=J3uUyMW3tLzfjLa1Ww2EDgdJ7qhydiSN5sxYNJZ2pAg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqO8Jpv4y5HT0e67r2OPgzwcRvB20AD7/ikppwa
 foJpFaY9+mJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajvCaQAKCRDa6OEJdZac
 5Sq1D/9kxHvLdf8gSnKfgkXOo+/xstJaaJHgWRMtuFgrLSsrG2EPW/EyOaaFEfBR9x+muA/mIU/
 /y7DU0pnZG0pjf1mf5KN7QDvL/t9fMCVMNU6jBPEq73OLEixA9FP+3Ok4kTDZlMi79mpNjZfimX
 FBGOLZ7+J82s+WjPWtX+gUC9JgnosmCvzbPMa7aFqmc2M/L05tv2ZJdqRLeszj1XQ+110Ma28w6
 I0lZfs8j4cmlx6+PH+Zv9IgPXpMgCJOHczG1984iscI5MvjdV4IwPEcDlsvu0T5nOaa68ZFNJpT
 eyukKivMrSPeP2F/RBAdDADqq3/D6owOJhpEtOySODTKJoRbXaQ8GOaQ0kJt8XcF/iZntw9D5gv
 ng8PhgmCK/a9MRmOSK1n0uwG+r9ac+cZi9KhjyoiPmm1iSGoQUt74mdZ+Cnr1+Dhoy+xNukKDQO
 RglVO12bsn0JPHhlfyPI49JjnwRSgg7odpcR95U3i64cAedEdYzvI5fg6NoRjlJnrdcG4CxTbk3
 j3rslYWlOXSsxYzxykgOat57zw2uoWpnI2zWw/gVqh9voRPAjZhqzd7H9nkTK7bZsE97TQWr8Tl
 PhcR5WgoTT0Wq/GsesG9snjEWEOx046ggnjzOEqgirrFgnF+8gR9+pdIUt0aVeI/YsVLWKdpben
 p5g7oPWP5t2/MQA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

Subscribe to QemuConsoleEvent notifications to dynamically add and
remove D-Bus display consoles. This mirrors the GTK backend's
handling added in the previous commits.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260623-b4-ui-v4-33-4656aec3398d@redhat.com>
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
index bdbc208cf01..e1ac06814ba 100644
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


