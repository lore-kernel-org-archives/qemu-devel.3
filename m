Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99395CD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZs7R-0005HQ-JV; Wed, 17 Jun 2026 11:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs7O-0005HC-77
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:23:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs7M-00046H-AA
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781709830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ogG/MnvSzYDiB+fCaAwHVaiQQvOjoc5ERv09JnrV5Ig=;
 b=RPTjw0kSEGZqMLX7EupbXJ09ZU1VceDF+za6SAy0h9Fb8/4rWdi5ijctjDFvXfiMzkfdts
 5ibSoONKUDyuibIIN1TWhcPrZtwcCon9FHn2CA6OmHYpBFOG2r4GoYTRIr+uForeuFaMPS
 tOL9naZGLEgVe0esCT/G20XRqtx7+Z0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-6VvU0mkrOESHplYzRdBJaQ-1; Wed,
 17 Jun 2026 11:23:49 -0400
X-MC-Unique: 6VvU0mkrOESHplYzRdBJaQ-1
X-Mimecast-MFC-AGG-ID: 6VvU0mkrOESHplYzRdBJaQ_1781709828
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A328C18009DF
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 15:23:48 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8DF9D3008B3D; Wed, 17 Jun 2026 15:23:46 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Jun 2026 19:23:01 +0400
Subject: [GIT PULL 04/27] hw/usb/dev-wacom: convert to modern
 QemuInputHandler API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260617-ui-input-v1-4-79e9aedc5899@redhat.com>
References: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
In-Reply-To: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7949;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=zrxXU17/hZeqWHvP0MTFv+W2hkRQVFdnOtABpkxwApM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMrvo6B28yB/1m294JTF+qdnDrIvKtVhkuzvQQ
 3eQmvT+ktyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajK76AAKCRDa6OEJdZac
 5dC/D/9HyZHra0yTRxMjFLGMwyDt6yCBvwKxVIn5FMwBwlOuABbL3IU46I6HKp850ZIc/DBCXs6
 JwuB59MZyXPBLpbFtL1RNF7ZQ+B7DoMoZX+G7sSab4QsDjZrOWRIGnKrL32d6amtjCtwe0AYDli
 MZQlulpE39oYCApd/w++pFz6TNrX6niYiATm7gFWcvcrxxQVKBo4vohLWOtXJ/8awzJtP8G+QYL
 Ruqrp/5+MeiYqBzCDYogJkBf8VR1yqMrucLRbAzz5P1q9Lx/lgXKy43Vt5M7zx25RYq7okqSTM1
 lLhFtS6R+lwbC9O3+Y3052e1BPTLsgAsHq4hPIwa3I7T58i9DmnVZymhoCady7pg2bh9HAh0Qk2
 3H29uh0/6eBW3Lue7k7FjnIf9qn5WHXWagYYU2LfabtKPJmDgS/q+VowBXctSQwiNX96Bn2uR+w
 U6Qy4fNPB02rzN+0sHVfkIFKs7r51wyauNoBT2TRNVG3K02BmkrLnFIKi2lXJbW6lXl8JepoKF8
 y/9P9uiCVoOLFAg4WU+b1Aqvx9jNJibicFZY59ehM0WMUVEtDGwmp9iQxxdIkg3s7sWlKXcSACP
 TQWPTfqd04pgR8HJ6QLz8WXkophpj1dM9Q+o6IJ1b0UegleOcbFM4n+SGcLVEWccXMGwwpewyls
 D7u1w9kzwgaG87w==
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

Replace the legacy QEMUPutMouseEvent callbacks with a proper
QemuInputHandler registration. The device now receives typed
input events (BTN/ABS/REL) directly.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-wacom.c | 155 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 94 insertions(+), 61 deletions(-)

diff --git a/hw/usb/dev-wacom.c b/hw/usb/dev-wacom.c
index 14d07e81281..c69e247f7b7 100644
--- a/hw/usb/dev-wacom.c
+++ b/hw/usb/dev-wacom.c
@@ -42,10 +42,10 @@
 struct USBWacomState {
     USBDevice dev;
     USBEndpoint *intr;
-    QEMUPutMouseEntry *eh_entry;
-    int dx, dy, dz, buttons_state;
-    int x, y;
-    int mouse_grabbed;
+    QemuInputHandlerState *hs;
+    int axis[INPUT_AXIS__MAX];
+    int dz;
+    bool btns[INPUT_BUTTON__MAX];
     enum {
         WACOM_MODE_HID = 1,
         WACOM_MODE_WACOM = 2,
@@ -188,29 +188,37 @@ static const USBDesc desc_wacom = {
     .str  = desc_strings,
 };
 
-static void usb_mouse_event(void *opaque,
-                            int dx1, int dy1, int dz1, int buttons_state)
+static void usb_wacom_input_event(DeviceState *dev, QemuConsole *src,
+                                  QemuInputEvent *evt)
 {
-    USBWacomState *s = opaque;
+    USBWacomState *s = USB_WACOM(dev);
 
-    s->dx += dx1;
-    s->dy += dy1;
-    s->dz += dz1;
-    s->buttons_state = buttons_state;
-    s->changed = 1;
-    usb_wakeup(s->intr, 0);
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
+        s->axis[evt->abs.axis] = evt->abs.value;
+        break;
+    case INPUT_EVENT_KIND_REL:
+        s->axis[evt->rel.axis] += evt->rel.value;
+        break;
+    default:
+        break;
+    }
 }
 
-static void usb_wacom_event(void *opaque,
-                            int x, int y, int dz, int buttons_state)
+static void usb_wacom_input_sync(DeviceState *dev)
 {
-    USBWacomState *s = opaque;
+    USBWacomState *s = USB_WACOM(dev);
 
-    /* scale to Penpartner resolution */
-    s->x = (x * 5040 / 0x7FFF);
-    s->y = (y * 3780 / 0x7FFF);
-    s->dz += dz;
-    s->buttons_state = buttons_state;
     s->changed = 1;
     usb_wakeup(s->intr, 0);
 }
@@ -225,32 +233,57 @@ static inline int int_clamp(int val, int vmin, int vmax)
         return val;
 }
 
+static void usb_wacom_register_input_handler(USBWacomState *s, bool absolute)
+{
+    static const QemuInputHandler usb_wacom_abs_handler = {
+        .name  = "QEMU PenPartner tablet",
+        .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_ABS,
+        .event = usb_wacom_input_event,
+        .sync  = usb_wacom_input_sync,
+    };
+
+    static const QemuInputHandler usb_wacom_rel_handler = {
+        .name  = "QEMU PenPartner tablet",
+        .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_REL,
+        .event = usb_wacom_input_event,
+        .sync  = usb_wacom_input_sync,
+    };
+
+    const QemuInputHandler *h = absolute ?
+        &usb_wacom_abs_handler : &usb_wacom_rel_handler;
+
+    g_clear_pointer(&s->hs, qemu_input_handler_unregister);
+
+    s->hs = qemu_input_handler_register(DEVICE(s), h);
+    qemu_input_handler_activate(s->hs);
+}
+
 static int usb_mouse_poll(USBWacomState *s, uint8_t *buf, int len)
 {
     int dx, dy, dz, b, l;
 
-    if (!s->mouse_grabbed) {
-        s->eh_entry = qemu_add_mouse_event_handler(usb_mouse_event, s, 0,
-                        "QEMU PenPartner tablet");
-        qemu_activate_mouse_event_handler(s->eh_entry);
-        s->mouse_grabbed = 1;
+    if (!s->hs) {
+        usb_wacom_register_input_handler(s, false);
     }
 
-    dx = int_clamp(s->dx, -128, 127);
-    dy = int_clamp(s->dy, -128, 127);
+    dx = int_clamp(s->axis[INPUT_AXIS_X], -128, 127);
+    dy = int_clamp(s->axis[INPUT_AXIS_Y], -128, 127);
     dz = int_clamp(s->dz, -128, 127);
 
-    s->dx -= dx;
-    s->dy -= dy;
+    s->axis[INPUT_AXIS_X] -= dx;
+    s->axis[INPUT_AXIS_Y] -= dy;
     s->dz -= dz;
 
     b = 0;
-    if (s->buttons_state & MOUSE_EVENT_LBUTTON)
+    if (s->btns[INPUT_BUTTON_LEFT]) {
         b |= 0x01;
-    if (s->buttons_state & MOUSE_EVENT_RBUTTON)
+    }
+    if (s->btns[INPUT_BUTTON_RIGHT]) {
         b |= 0x02;
-    if (s->buttons_state & MOUSE_EVENT_MBUTTON)
+    }
+    if (s->btns[INPUT_BUTTON_MIDDLE]) {
         b |= 0x04;
+    }
 
     buf[0] = b;
     buf[1] = dx;
@@ -265,32 +298,40 @@ static int usb_mouse_poll(USBWacomState *s, uint8_t *buf, int len)
 
 static int usb_wacom_poll(USBWacomState *s, uint8_t *buf, int len)
 {
-    int b;
+    int b, x, y;
 
-    if (!s->mouse_grabbed) {
-        s->eh_entry = qemu_add_mouse_event_handler(usb_wacom_event, s, 1,
-                        "QEMU PenPartner tablet");
-        qemu_activate_mouse_event_handler(s->eh_entry);
-        s->mouse_grabbed = 1;
+    if (!s->hs) {
+        usb_wacom_register_input_handler(s, true);
     }
 
     b = 0;
-    if (s->buttons_state & MOUSE_EVENT_LBUTTON)
+    if (s->btns[INPUT_BUTTON_LEFT]) {
         b |= 0x01;
-    if (s->buttons_state & MOUSE_EVENT_RBUTTON)
+    }
+    if (s->btns[INPUT_BUTTON_RIGHT]) {
         b |= 0x40;
-    if (s->buttons_state & MOUSE_EVENT_MBUTTON)
+    }
+    if (s->btns[INPUT_BUTTON_MIDDLE]) {
         b |= 0x20; /* eraser */
+    }
 
-    if (len < 7)
+    if (len < 7) {
         return 0;
+    }
+
+    x = qemu_input_scale_axis(s->axis[INPUT_AXIS_X],
+                              INPUT_EVENT_ABS_MIN, INPUT_EVENT_ABS_MAX,
+                              0, 5040);
+    y = qemu_input_scale_axis(s->axis[INPUT_AXIS_Y],
+                              INPUT_EVENT_ABS_MIN, INPUT_EVENT_ABS_MAX,
+                              0, 3780);
 
     buf[0] = s->mode;
     buf[5] = 0x00 | (b & 0xf0);
-    buf[1] = s->x & 0xff;
-    buf[2] = s->x >> 8;
-    buf[3] = s->y & 0xff;
-    buf[4] = s->y >> 8;
+    buf[1] = x & 0xff;
+    buf[2] = x >> 8;
+    buf[3] = y & 0xff;
+    buf[4] = y >> 8;
     if (b & 0x3f) {
         buf[6] = 0;
     } else {
@@ -302,15 +343,13 @@ static int usb_wacom_poll(USBWacomState *s, uint8_t *buf, int len)
 
 static void usb_wacom_handle_reset(USBDevice *dev)
 {
-    USBWacomState *s = (USBWacomState *) dev;
+    USBWacomState *s = USB_WACOM(dev);
 
-    s->dx = 0;
-    s->dy = 0;
+    memset(s->axis, 0, sizeof(s->axis));
+    memset(s->btns, 0, sizeof(s->btns));
     s->dz = 0;
-    s->x = 0;
-    s->y = 0;
-    s->buttons_state = 0;
     s->mode = WACOM_MODE_HID;
+    g_clear_pointer(&s->hs, qemu_input_handler_unregister);
 }
 
 static void usb_wacom_handle_control(USBDevice *dev, USBPacket *p,
@@ -337,10 +376,7 @@ static void usb_wacom_handle_control(USBDevice *dev, USBPacket *p,
         }
         break;
     case WACOM_SET_REPORT:
-        if (s->mouse_grabbed) {
-            qemu_remove_mouse_event_handler(s->eh_entry);
-            s->mouse_grabbed = 0;
-        }
+        g_clear_pointer(&s->hs, qemu_input_handler_unregister);
         s->mode = data[0];
         break;
     case WACOM_GET_REPORT:
@@ -400,10 +436,7 @@ static void usb_wacom_unrealize(USBDevice *dev)
 {
     USBWacomState *s = (USBWacomState *) dev;
 
-    if (s->mouse_grabbed) {
-        qemu_remove_mouse_event_handler(s->eh_entry);
-        s->mouse_grabbed = 0;
-    }
+    g_clear_pointer(&s->hs, qemu_input_handler_unregister);
 }
 
 static void usb_wacom_realize(USBDevice *dev, Error **errp)

-- 
2.54.0


