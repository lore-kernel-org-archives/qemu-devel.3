Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E97CCD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZs7K-0005GE-Bk; Wed, 17 Jun 2026 11:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs7I-0005E6-64
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:23:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs7G-000446-Ga
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781709825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rambNSgx5DF5OBlD4yqYHn8fwQtRbWr+liVloOeJlu0=;
 b=JXq9gA29vzO0HWc55frC3J1GatAGWXN0xVAoW9aCUHM7/j4Gb+gkns9+ss1MaMWpfP42Tg
 hy860Tm5WNmWzMYTT9GPh739EGsEnewvL8qyfI39UiriTOzciDgrKcjzFKeUivhuvDALq0
 pRg24JkqWxrUasopKoZ9WnUdc6j64y4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-Zb0RABisPd6vkHDs72Ymag-1; Wed,
 17 Jun 2026 11:23:44 -0400
X-MC-Unique: Zb0RABisPd6vkHDs72Ymag-1
X-Mimecast-MFC-AGG-ID: Zb0RABisPd6vkHDs72Ymag_1781709823
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 671541806C86
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 15:23:43 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 21F073008B3D; Wed, 17 Jun 2026 15:23:41 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Jun 2026 19:23:00 +0400
Subject: [GIT PULL 03/27] hw/i386/vmmouse: convert to QemuInputHandler API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260617-ui-input-v1-3-79e9aedc5899@redhat.com>
References: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
In-Reply-To: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6706;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=cBOsmCZOmYIqojWNv1AOUvbr9Uk0cg9No4sFDN7duMA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMrvojyN8+OMdJ3vNlt32NWf6QBwKnqeAX82An
 dzY8llpCYmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajK76AAKCRDa6OEJdZac
 5fWJD/9neTCqeP2JGJGwfiYiUjyJgmFzA/nMskhgByjltfQDIZ9XEPiEORXe3jkliK6TU61AiNC
 lP+VMZmazuVlcaF8y+lslEYAVDOPpEpCk4PI34rtC3DSvU2rcevSB7J9C7iuUtICa97G97pSuLS
 W3/3h/k8oEvYkTnnWBgvhgaf9MXqbP9+k5z49sVeumvrbxRJpZZxSiy/903ijRZPx8Fhg+55ao2
 KVKtQxqizgXOB20V+zCsSg+AJXnDv39Ga2DSMFtQB/cPKCNESRxeaBCNgV25qO0Y1wScrMHPEW3
 I/NutnpLtgtCzlILaxjcEjK3iwEaQcw7K6khvEj+YA4ZGt4gB7NipbokMp/PiyEYVMHVc3OWVws
 eyn0rNyCYICIHM5X5SVWXxNiyddnmMtl3UVYvquXawkDK3CEufQSBPponB9dZp5UEs9o2n4oaLe
 RQvwpelsf1IO4u0MvyqlEAEQLunFgIyC8vnpD3iAYd05U9EXADPihGyaz0ZJ6ZJS5Kt17lbMGuK
 DZvw1+GccJdMGrO6CrslfDZHosdy6LdSCKC0uia3b+MYd5mH9DQdhAJiVytUGmJCP96ey9uX3NF
 Q8Q0qeBV4T0t7ifzFfrrmJzpRL9AKRgVqSGJjg17plvKjIuqJKR7An7Ece1rVmaFZNPFRGedaw+
 TNkW1o5KCU23a5g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Replace the legacy QEMUPutMouseEvent callback with a proper
QemuInputHandler registration. This eliminates one of the two
remaining users of the legacy input adapter in ui/input-legacy.c.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/vmmouse.c    | 115 +++++++++++++++++++++++++++++++++++++--------------
 hw/i386/trace-events |   2 +-
 2 files changed, 85 insertions(+), 32 deletions(-)

diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index d54adb34a88..e289bce8e2e 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -68,7 +68,10 @@ struct VMMouseState {
     uint16_t nb_queue;
     uint16_t status;
     uint8_t absolute;
-    QEMUPutMouseEntry *entry;
+    QemuInputHandlerState *hs;
+    int axis[INPUT_AXIS__MAX];
+    int dz;
+    bool btns[INPUT_BUTTON__MAX];
     ISAKBDState *i8042;
 };
 
@@ -99,39 +102,78 @@ static uint32_t vmmouse_get_status(VMMouseState *s)
     return (s->status << 16) | s->nb_queue;
 }
 
-static void vmmouse_mouse_event(void *opaque, int x, int y, int dz, int buttons_state)
+static void vmmouse_input_event(DeviceState *dev, QemuConsole *src,
+                                QemuInputEvent *evt)
 {
-    VMMouseState *s = opaque;
+    VMMouseState *s = VMMOUSE(dev);
+
+    switch (evt->type) {
+    case INPUT_EVENT_KIND_BTN:
+        if (evt->btn.down) {
+            if (evt->btn.button == INPUT_BUTTON_WHEEL_UP) {
+                s->dz--;
+            } else if (evt->btn.button == INPUT_BUTTON_WHEEL_DOWN) {
+                s->dz++;
+            }
+        }
+        s->btns[evt->btn.button] = evt->btn.down;
+        break;
+    case INPUT_EVENT_KIND_ABS:
+        if (evt->abs.axis == INPUT_AXIS_X) {
+            s->axis[INPUT_AXIS_X] =
+                qemu_input_scale_axis(evt->abs.value,
+                                      INPUT_EVENT_ABS_MIN, INPUT_EVENT_ABS_MAX,
+                                      VMMOUSE_MIN_X, VMMOUSE_MAX_X);
+        } else if (evt->abs.axis == INPUT_AXIS_Y) {
+            s->axis[INPUT_AXIS_Y] =
+                qemu_input_scale_axis(evt->abs.value,
+                                      INPUT_EVENT_ABS_MIN, INPUT_EVENT_ABS_MAX,
+                                      VMMOUSE_MIN_Y, VMMOUSE_MAX_Y);
+        }
+        break;
+    case INPUT_EVENT_KIND_REL:
+        s->axis[evt->rel.axis] += evt->rel.value;
+        break;
+    default:
+        break;
+    }
+}
+
+static void vmmouse_input_sync(DeviceState *dev)
+{
+    VMMouseState *s = VMMOUSE(dev);
     int buttons = 0;
 
-    if (s->nb_queue > (VMMOUSE_QUEUE_SIZE - 4))
+    if (s->nb_queue > (VMMOUSE_QUEUE_SIZE - 4)) {
         return;
+    }
 
-    trace_vmmouse_mouse_event(x, y, dz, buttons_state);
-
-    if ((buttons_state & MOUSE_EVENT_LBUTTON))
+    if (s->btns[INPUT_BUTTON_LEFT]) {
         buttons |= VMMOUSE_LEFT_BUTTON;
-    if ((buttons_state & MOUSE_EVENT_RBUTTON))
+    }
+    if (s->btns[INPUT_BUTTON_RIGHT]) {
         buttons |= VMMOUSE_RIGHT_BUTTON;
-    if ((buttons_state & MOUSE_EVENT_MBUTTON))
+    }
+    if (s->btns[INPUT_BUTTON_MIDDLE]) {
         buttons |= VMMOUSE_MIDDLE_BUTTON;
-
-    if (s->absolute) {
-        x = qemu_input_scale_axis(x,
-                                  INPUT_EVENT_ABS_MIN, INPUT_EVENT_ABS_MAX,
-                                  VMMOUSE_MIN_X, VMMOUSE_MAX_X);
-        y = qemu_input_scale_axis(y,
-                                  INPUT_EVENT_ABS_MIN, INPUT_EVENT_ABS_MAX,
-                                  VMMOUSE_MIN_Y, VMMOUSE_MAX_Y);
-    } else{
-        /* add for guest vmmouse driver to judge this is a relative packet. */
+    }
+    if (!s->absolute) {
         buttons |= VMMOUSE_RELATIVE_PACKET;
     }
 
+    trace_vmmouse_queue_event(s->axis[INPUT_AXIS_X], s->axis[INPUT_AXIS_Y],
+                              s->dz, buttons);
+
     s->queue[s->nb_queue++] = buttons;
-    s->queue[s->nb_queue++] = x;
-    s->queue[s->nb_queue++] = y;
-    s->queue[s->nb_queue++] = dz;
+    s->queue[s->nb_queue++] = s->axis[INPUT_AXIS_X];
+    s->queue[s->nb_queue++] = s->axis[INPUT_AXIS_Y];
+    s->queue[s->nb_queue++] = s->dz;
+    s->dz = 0;
+
+    if (!s->absolute) {
+        s->axis[INPUT_AXIS_X] = 0;
+        s->axis[INPUT_AXIS_Y] = 0;
+    }
 
     /* need to still generate PS2 events to notify driver to
        read from queue */
@@ -140,14 +182,25 @@ static void vmmouse_mouse_event(void *opaque, int x, int y, int dz, int buttons_
 
 static void vmmouse_remove_handler(VMMouseState *s)
 {
-    if (s->entry) {
-        qemu_remove_mouse_event_handler(s->entry);
-        s->entry = NULL;
-    }
+    g_clear_pointer(&s->hs, qemu_input_handler_unregister);
 }
 
 static void vmmouse_update_handler(VMMouseState *s, int absolute)
 {
+    static const QemuInputHandler vmmouse_abs_handler = {
+        .name  = "vmmouse",
+        .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_ABS,
+        .event = vmmouse_input_event,
+        .sync  = vmmouse_input_sync,
+    };
+
+    static const QemuInputHandler vmmouse_rel_handler = {
+        .name  = "vmmouse",
+        .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_REL,
+        .event = vmmouse_input_event,
+        .sync  = vmmouse_input_sync,
+    };
+
     if (s->status != 0) {
         return;
     }
@@ -155,11 +208,11 @@ static void vmmouse_update_handler(VMMouseState *s, int absolute)
         s->absolute = absolute;
         vmmouse_remove_handler(s);
     }
-    if (s->entry == NULL) {
-        s->entry = qemu_add_mouse_event_handler(vmmouse_mouse_event,
-                                                s, s->absolute,
-                                                "vmmouse");
-        qemu_activate_mouse_event_handler(s->entry);
+    if (s->hs == NULL) {
+        const QemuInputHandler *h = s->absolute ?
+            &vmmouse_abs_handler : &vmmouse_rel_handler;
+        s->hs = qemu_input_handler_register(DEVICE(s), h);
+        qemu_input_handler_activate(s->hs);
     }
 }
 
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index a1dfade20f1..a1a50d09109 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -134,7 +134,7 @@ port92_write(uint8_t val) "port92: write 0x%02x"
 
 # vmmouse.c
 vmmouse_get_status(void) ""
-vmmouse_mouse_event(int x, int y, int dz, int buttons_state) "event: x=%d y=%d dz=%d state=%d"
+vmmouse_queue_event(int x, int y, int dz, int buttons_state) "event: x=%d y=%d dz=%d state=%d"
 vmmouse_init(void) ""
 vmmouse_read_id(void) ""
 vmmouse_request_relative(void) ""

-- 
2.54.0


