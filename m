Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E245FFF8868
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 15:09:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHk3E-0002tf-7w; Tue, 28 Apr 2026 11:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHk3B-0002jZ-FV
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 11:08:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHk39-0000ka-EV
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 11:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777388914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l2i3x+eDYXXk9cfWr/IeBQOYE2X03s17Dn3GAzkjgRY=;
 b=BpauzZ8nkfXwVf/eeombGxd11b/P6N/k7/rt/AITGsahE/ZmIUJ2lEL2t+ua8tzPfnM/Hs
 8YiCSLGzy9lW9XCNgzb5Ga0JViqsOzSkbgT+yv0sRmHm/H7aUnP9l/6TDJflvHIOzIXUAo
 MLDDloJ7PVShJCVtAKRvEvxqkiJluq8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-1zk_ZmlzNyKvsRS6mNQPSA-1; Tue,
 28 Apr 2026 11:08:30 -0400
X-MC-Unique: 1zk_ZmlzNyKvsRS6mNQPSA-1
X-Mimecast-MFC-AGG-ID: 1zk_ZmlzNyKvsRS6mNQPSA_1777388909
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B9F21956056; Tue, 28 Apr 2026 15:08:29 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B2DD5180047F; Tue, 28 Apr 2026 15:08:27 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v2 09/15] ui/console: move console_handle_touch_event() to input
Date: Tue, 28 Apr 2026 19:07:19 +0400
Message-ID: <20260428150726.1659814-10-marcandre.lureau@redhat.com>
In-Reply-To: <20260428150726.1659814-1-marcandre.lureau@redhat.com>
References: <20260428150726.1659814-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.109,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The function uses input.c functions to provide a simpler abstraction for
touch events. Let's move it from the already overloaded console.c, and
to avoid some unnecessary dependency from console.c on input.c.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h | 14 ----------
 include/ui/input.h   | 15 ++++++++++
 ui/console.c         | 65 --------------------------------------------
 ui/dbus-console.c    |  6 ++--
 ui/gtk.c             |  8 +++---
 ui/input.c           | 65 ++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 87 insertions(+), 86 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 0bc9e544fad..27eacc39cc0 100644
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
index a608c29b843..799d61ec1a5 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -548,71 +548,6 @@ static bool console_compatible_with(QemuConsole *con,
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
index 85e215ef233..564f004bd86 100644
--- a/ui/dbus-console.c
+++ b/ui/dbus-console.c
@@ -424,9 +424,9 @@ dbus_touch_send_event(DBusDisplayConsole *ddc,
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
index 9ebe7e8df0d..8fd39c90c29 100644
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
2.54.0


