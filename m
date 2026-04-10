Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F5BF45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHTu-0007lt-CW; Fri, 10 Apr 2026 15:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHTe-0007SM-Gl
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:25:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHTU-0002ko-5i
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775849102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V8Kmb9hMdDfZvIwjrajmdDx/fPyIjOHyNIBxjOd4ZLI=;
 b=cA8WlCSgUVl64gDRLFOGlfbPe6W3T7c2vwUNbDQTuNQInQEcY8yb+vFFV5k+d3hkegFkci
 vBjOqyiaal5bzO56UwP15+eLqlGu70SCo5GgMuDwtyE38UQUOSqyttJ7tKlPNv5hOwl/CN
 bM7/NDXvfkMPxtUWx2Bz3s3x4hOXaes=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-ZxC_VHCkNGWNLo1W7-RLXQ-1; Fri,
 10 Apr 2026 15:25:00 -0400
X-MC-Unique: ZxC_VHCkNGWNLo1W7-RLXQ-1
X-Mimecast-MFC-AGG-ID: ZxC_VHCkNGWNLo1W7-RLXQ_1775849099
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D308519560AF; Fri, 10 Apr 2026 19:24:59 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 84B36195608E; Fri, 10 Apr 2026 19:24:57 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:19:23 +0400
Subject: [PATCH v2 61/67] ui/console: move console_handle_touch_event() to
 input
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-61-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=9221;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=689gCTcA3cL/UQbDpjNhlr4RASF6v9cOEQL32KHP834=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0XkcIryQX8g+qHkJPqbffhSD/jlVaay0MjE
 eZ7ZQeVlpeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFwAKCRDa6OEJdZac
 5X1jD/0WZRSWLmkpZ6hej+chrFt+yD4NL5k5ToCo56CrOjVxpWit+KmduGXkikF6JZfpkmcbdlm
 ggSM+P9Bl4va1c9NeIK1af3MI0i/Odk0MvadNnF8h6scN4PJXpf4uspQrZKABeBgwn5tXSsAdQ/
 k7Y+P+xvn87OI6iph8R6XhoVWzqxhDRuIyE2U6QzCXN+aH7/AfWJd5uRpMrXySLXb8P0HY2DgJT
 Nhysnh1YwwVlXEnN8BtNqQGdWm3xJfmoerMVnFm0PdGsvt/bJ3/YuDpaACDadUma/6bwOHEzQHS
 uiXTW9HWQb0wO2a6hYSMIqMsQTh6bbEAfg89imonc8jzxWz7nyMcNNMoIFu4PiLitPRapwryIa0
 vXmTChZ5pRo2raepGHoIbeVynrQYFp0DXbtmpAnxHx0fvzVphqIqK31k0d0zcqx/WDrQ0mFQ4Ze
 Plxi8jDUt2fFIkkmr4ff9XLUkYt/EOaiC2ry4eYNyDvF5zEhwolSC6tIRyj4kOiTjrPQL/qLqnl
 bq5QxugRy1oIB5UbU0swrvxB0h0PmrOc+p8HHlXcevym5pRXVVt33kRvUkpt4ANGPat6iSqrX+T
 XPVSvR07uhoao9Y26ZmGvYGqaGQtryjN1XrbjRrwJG+A+cprsjPtJ9nSOI7hO9oKTGm6YQ1aiBB
 D4wqBEqhMVCozIg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

The function uses input.c functions to provide a simpler abstraction for
touch events. Let's move it from the already overloaded console.c, and
to avoid some unnecessary dependency from console.c on input.c.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 5566d1f65f9..89a93230bb0 100644
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
index 344bf308b0c..405dd1bb5b8 100644
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


