Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05AA8CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXGd3-0002AA-I3; Wed, 10 Jun 2026 06:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGd2-000284-1H
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:57:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGd0-0005G7-73
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781089065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FAwULspIvzALTW+4Bmpz5id6tDC+ZD0VsNa3K0DQrco=;
 b=SLY80xLU+QnSgtCvP+HkF7eUaNcPd6/56PhGXmClX3SMQ4bpeAZ4YbMu0i+vGtwUmLXPc+
 dIKKHpquoxe4HmuWJIvLqEwYlayx8gkvs8sIo/IR5pq3PHYXrqpyCJZZINKggjAEKSnzyc
 RzT2bNO8JbO310uK0vUcEahORe/KW1g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-i7j_FO9ePdCmlgvUcGPwBA-1; Wed,
 10 Jun 2026 06:57:42 -0400
X-MC-Unique: i7j_FO9ePdCmlgvUcGPwBA-1
X-Mimecast-MFC-AGG-ID: i7j_FO9ePdCmlgvUcGPwBA_1781089060
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 673D9180059E; Wed, 10 Jun 2026 10:57:40 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 540851954B09; Wed, 10 Jun 2026 10:57:37 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 10 Jun 2026 14:56:46 +0400
Subject: [PATCH v2 04/22] hw/usb/dev-wacom: convert to modern
 QemuInputHandler API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260610-ui-input-v2-4-f68452dd6a22@redhat.com>
References: <20260610-ui-input-v2-0-f68452dd6a22@redhat.com>
In-Reply-To: <20260610-ui-input-v2-0-f68452dd6a22@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jan Kiszka <jan.kiszka@web.de>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 qemu-ppc@nongnu.org, Thomas Huth <th.huth+qemu@posteo.eu>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7904;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=1v9X3RjtBH40kWO7TrlJJLMEL1/840D/jNHs/b0Kp3k=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKUL/ZRyMFpLukW7anY4oeusy96CBgbyGgea61
 dRN8u20nreJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCailC/wAKCRDa6OEJdZac
 5XwHD/0S7hee5PZOhRFXcrQbTUeZZ3HcjUlHIOINmEB5d62oD5p75gpyb7TPKUaROHBnqDN4TBn
 taxGhgtbtSELscCcntCrRyjt1598ps2sV9rOEt+6DxlSpLf/R3BXwrTQx/E3IwzjQLfllqNRYJI
 4bnxnPpTkIEnMPmSX9nBcN3A1MpRBLSIMliRzLqm99r1+Dy4xeMUf0xJtt6QoHukHRIgOGI1NFi
 VBgcfbxrD21li+Kww43ljlIc8LahsNGBQFWBwdR1tKmFQcXMD5gXgmDXvwWECAPJUPncCR2c74K
 7ndtBfNwkK8uMav8ywbVecFWVRitebpr+oIeUlceBKSY3OTLf+rxSfV/yaFu+ZRFEF6nJ1ni1/6
 TxKFdbBvkAzQNrI0acL64mzGinAr+7dxekFRjCWNdN2FLa8AgGwjHQG5lBXs0oeqYG+XEgPgU3U
 bPzvLlf3ZQ17uNhfxYXAWm3MnyyFwOeMBhHrffV3+w+62NizUMOJz4vamZLBADgqJLWG06E4SRM
 lF1tDpUUwU1WOVV2xPXPQG2tUgYTI2DHvD7tMmQi8ELdKj263jtgFS4Xi0oTPiLIdDkvyH5JKIn
 y+SBv/rSvVR1fv1n8dAZiibkO0uB5PRgKvh4coPBgLC8gMwoRDvyMnXTS0F+kFAIeA51Oei1szd
 wI1Q7qW2Ai2oyUA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


