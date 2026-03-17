Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4980CF3381C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QEm-00005x-UR; Tue, 17 Mar 2026 04:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QDc-00044k-0l
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:56:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QDa-00079K-9h
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7VJL4O8+9LOo4hAKKpIFVFC+Y74OqIliDbmAvOmaadA=;
 b=Gwu8ZhDZvUGheCrqEEQFKjCQLZMPpYj0XzcVB4CXW0p6y3T0mvupz/AFbTfQEsRx2mKkNn
 qQ9uiphx3VQ3uxRar+52Ysi4eeVDyEUTNmUWp1+GM4E3cG/JiG4d58MBbb90fanS47w2OO
 dgpM2WsQtj+MzTAeyMq1zs6qcFoG8tI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-fgBwIegrNZenWK_ngrdZOg-1; Tue,
 17 Mar 2026 04:55:59 -0400
X-MC-Unique: fgBwIegrNZenWK_ngrdZOg-1
X-Mimecast-MFC-AGG-ID: fgBwIegrNZenWK_ngrdZOg_1773737759
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DB731956062
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:55:59 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 05F9F19560AB
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:55:57 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:51:09 +0400
Subject: [PATCH 55/60] ui/console: move console_handle_touch_event() to input
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-55-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=9163;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=t+6Ffhw7rudrKvlgQwWmSl0HC8a1R6zvwMGLDGQoEoY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXcrooT+4BTEc1EfOvod+OaJgEXb81sM04AL
 H72dnAw/bSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV3AAKCRDa6OEJdZac
 5bbMD/9X2j6ghtNBTPAF63e0OZCLDJRdgjA+4RKnNC2BraaMchYf10z5U2v+5NJFLguEpSVA19D
 i2rtwozSdV2xnDYyRMioiZLKWkO5i/Fu/m7Ny0zueKIWN1p8ctJc5weMzYhO9mQar90X0VyiAze
 JuxwMUy1q9Q0MO0IiSnBYCy/5uXS0XL8cOiXlKJ6t23tUmYREHpd4WrV0igGuZoF0cHhrYFQfyA
 eIKzhYPNVR5cqJwBDNqZdcVbbhU+ILmXuyc5tDAd55dPeV7NUAV4d7bC+HQ0pYKLPGUpplLNN8w
 awmV2CCvIlPf//LCj7fKp+qj/O7o6YhyinSYEE7h0kojYHhK2/E2sAtgQsTgMOs+VBeY0O/zAPS
 oJo8YFz7rZMC3dZToePR7QUeFFY/Mbf7M/QopwGZWhnE1YWG0Yn5YUhrcxOTH3vTN7JmsZ3Uk1W
 3wz3mgh8yRsiuFmog9bQkqNo5+LbhbpXC1KHwHAc4a8DNwqC99jwFTsRWyzoeT9URmh6Qj0nxRj
 nZNvNzvCoCWd9pIHUoEl6AHc9YCIaJnx9O116CR3QkwLY62NC/5rGZPOgNj/D6Fm8UTOFJxwA7V
 K71ZUVX1pHBY1XhiC+iVNEs/BAYEagGal0Mnzs6SGRE/UzUFwNq3Vf3wBw0z6OZNVir2gMmgdGf
 8fXsBaw0Box0ViA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

The function uses input.c functions to provide a simpler abstraction for
touch events. Let's move it from the already overloaded console.c, and
to avoid some unnecessary dependency from console.c on input.c.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h | 14 -----------
 include/ui/input.h   | 15 ++++++++++++
 ui/console.c         | 65 ----------------------------------------------------
 ui/dbus-console.c    |  6 ++---
 ui/gtk.c             |  8 +++----
 ui/input.c           | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 87 insertions(+), 86 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index f8163ef96a8..6968a1e35f3 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -111,20 +111,6 @@ void qemu_text_console_put_keysym(QemuTextConsole *s, int keysym);
 bool qemu_text_console_put_qcode(QemuTextConsole *s, int qcode, bool ctrl);
 void qemu_text_console_put_string(QemuTextConsole *s, const char *str, int len);
 
-/* Touch devices */
-typedef struct touch_slot {
-    int x;
-    int y;
-    int tracking_id;
-} touch_slot;
-
-void console_handle_touch_event(QemuConsole *con,
-                                struct touch_slot touch_slots[INPUT_EVENT_SLOTS_MAX],
-                                uint64_t num_slot,
-                                int width, int height,
-                                double x, double y,
-                                InputMultiTouchType type,
-                                Error **errp);
 /* consoles */
 
 struct QemuConsoleClass {
diff --git a/include/ui/input.h b/include/ui/input.h
index 8f9aac562ed..52c164bde57 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -70,6 +70,21 @@ void qemu_input_queue_mtt_abs(QemuConsole *src, InputAxis axis, int value,
                               int min_in, int max_in,
                               int slot, int tracking_id);
 
+/* Touch devices */
+typedef struct touch_slot {
+    int x;
+    int y;
+    int tracking_id;
+} touch_slot;
+
+void qemu_input_touch_event(QemuConsole *con,
+                            struct touch_slot touch_slots[INPUT_EVENT_SLOTS_MAX],
+                            uint64_t num_slot,
+                            int width, int height,
+                            double x, double y,
+                            InputMultiTouchType type,
+                            Error **errp);
+
 void qemu_input_check_mode_change(void);
 void qemu_add_mouse_mode_change_notifier(Notifier *notify);
 void qemu_remove_mouse_mode_change_notifier(Notifier *notify);
diff --git a/ui/console.c b/ui/console.c
index 05c72e19c02..d1079348970 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -550,71 +550,6 @@ static bool console_compatible_with(QemuConsole *con,
     return true;
 }
 
-void console_handle_touch_event(QemuConsole *con,
-                                struct touch_slot touch_slots[INPUT_EVENT_SLOTS_MAX],
-                                uint64_t num_slot,
-                                int width, int height,
-                                double x, double y,
-                                InputMultiTouchType type,
-                                Error **errp)
-{
-    struct touch_slot *slot;
-    bool needs_sync = false;
-    int update;
-    int i;
-
-    if (num_slot >= INPUT_EVENT_SLOTS_MAX) {
-        error_setg(errp,
-                   "Unexpected touch slot number: % " PRId64" >= %d",
-                   num_slot, INPUT_EVENT_SLOTS_MAX);
-        return;
-    }
-
-    slot = &touch_slots[num_slot];
-    slot->x = x;
-    slot->y = y;
-
-    if (type == INPUT_MULTI_TOUCH_TYPE_BEGIN) {
-        slot->tracking_id = num_slot;
-    }
-
-    for (i = 0; i < INPUT_EVENT_SLOTS_MAX; ++i) {
-        if (i == num_slot) {
-            update = type;
-        } else {
-            update = INPUT_MULTI_TOUCH_TYPE_UPDATE;
-        }
-
-        slot = &touch_slots[i];
-
-        if (slot->tracking_id == -1) {
-            continue;
-        }
-
-        if (update == INPUT_MULTI_TOUCH_TYPE_END) {
-            slot->tracking_id = -1;
-            qemu_input_queue_mtt(con, update, i, slot->tracking_id);
-            needs_sync = true;
-        } else {
-            qemu_input_queue_mtt(con, update, i, slot->tracking_id);
-            qemu_input_queue_btn(con, INPUT_BUTTON_TOUCH, true);
-            qemu_input_queue_mtt_abs(con,
-                                    INPUT_AXIS_X, (int) slot->x,
-                                    0, width,
-                                    i, slot->tracking_id);
-            qemu_input_queue_mtt_abs(con,
-                                    INPUT_AXIS_Y, (int) slot->y,
-                                    0, height,
-                                    i, slot->tracking_id);
-            needs_sync = true;
-        }
-    }
-
-    if (needs_sync) {
-        qemu_input_event_sync();
-    }
-}
-
 void qemu_console_set_display_gl_ctx(QemuConsole *con, DisplayGLCtx *gl)
 {
     /* display has opengl support */
diff --git a/ui/dbus-console.c b/ui/dbus-console.c
index 88f58e88efb..b8e5c57b148 100644
--- a/ui/dbus-console.c
+++ b/ui/dbus-console.c
@@ -423,9 +423,9 @@ dbus_touch_send_event(DBusDisplayConsole *ddc,
     width = qemu_console_get_width(ddc->dcl.con, 0);
     height = qemu_console_get_height(ddc->dcl.con, 0);
 
-    console_handle_touch_event(ddc->dcl.con, touch_slots,
-                               num_slot, width, height,
-                               x, y, kind, &error);
+    qemu_input_touch_event(ddc->dcl.con, touch_slots,
+                           num_slot, width, height,
+                           x, y, kind, &error);
     if (error != NULL) {
         g_dbus_method_invocation_return_error(
             invocation, DBUS_DISPLAY_ERROR,
diff --git a/ui/gtk.c b/ui/gtk.c
index bcb67db7ee7..3b84224d8e8 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1201,10 +1201,10 @@ static gboolean gd_touch_event(GtkWidget *widget, GdkEventTouch *touch,
         return FALSE;
     }
 
-    console_handle_touch_event(vc->gfx.dcl.con, touch_slots,
-                               num_slot, surface_width(vc->gfx.ds),
-                               surface_height(vc->gfx.ds), touch->x,
-                               touch->y, type, &err);
+    qemu_input_touch_event(vc->gfx.dcl.con, touch_slots,
+                           num_slot, surface_width(vc->gfx.ds),
+                           surface_height(vc->gfx.ds), touch->x,
+                           touch->y, type, &err);
     if (err) {
         warn_report_err(err);
     }
diff --git a/ui/input.c b/ui/input.c
index 147e69c1c3c..57e7817878a 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -609,3 +609,68 @@ bool qemu_mouse_set(int index, Error **errp)
     notifier_list_notify(&mouse_mode_notifiers, NULL);
     return true;
 }
+
+void qemu_input_touch_event(QemuConsole *con,
+                            struct touch_slot touch_slots[INPUT_EVENT_SLOTS_MAX],
+                            uint64_t num_slot,
+                            int width, int height,
+                            double x, double y,
+                            InputMultiTouchType type,
+                            Error **errp)
+{
+    struct touch_slot *slot;
+    bool needs_sync = false;
+    int update;
+    int i;
+
+    if (num_slot >= INPUT_EVENT_SLOTS_MAX) {
+        error_setg(errp,
+                   "Unexpected touch slot number: % " PRId64" >= %d",
+                   num_slot, INPUT_EVENT_SLOTS_MAX);
+        return;
+    }
+
+    slot = &touch_slots[num_slot];
+    slot->x = x;
+    slot->y = y;
+
+    if (type == INPUT_MULTI_TOUCH_TYPE_BEGIN) {
+        slot->tracking_id = num_slot;
+    }
+
+    for (i = 0; i < INPUT_EVENT_SLOTS_MAX; ++i) {
+        if (i == num_slot) {
+            update = type;
+        } else {
+            update = INPUT_MULTI_TOUCH_TYPE_UPDATE;
+        }
+
+        slot = &touch_slots[i];
+
+        if (slot->tracking_id == -1) {
+            continue;
+        }
+
+        if (update == INPUT_MULTI_TOUCH_TYPE_END) {
+            slot->tracking_id = -1;
+            qemu_input_queue_mtt(con, update, i, slot->tracking_id);
+            needs_sync = true;
+        } else {
+            qemu_input_queue_mtt(con, update, i, slot->tracking_id);
+            qemu_input_queue_btn(con, INPUT_BUTTON_TOUCH, true);
+            qemu_input_queue_mtt_abs(con,
+                                    INPUT_AXIS_X, (int) slot->x,
+                                    0, width,
+                                    i, slot->tracking_id);
+            qemu_input_queue_mtt_abs(con,
+                                    INPUT_AXIS_Y, (int) slot->y,
+                                    0, height,
+                                    i, slot->tracking_id);
+            needs_sync = true;
+        }
+    }
+
+    if (needs_sync) {
+        qemu_input_event_sync();
+    }
+}

-- 
2.53.0


