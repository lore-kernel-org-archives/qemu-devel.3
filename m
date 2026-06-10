Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A911CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 10:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXGcv-00025q-LB; Wed, 10 Jun 2026 06:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGcu-00025f-MB
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:57:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGcr-0004PW-UT
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781089057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iigtK5jQySpzmNZYscoufMj5Qgow6LaU8KkOX7BSx7I=;
 b=hiBU56jUWk1ZHt4lAPIj3pAqRhcX38kogYtgUP65kjfITqmhv8M6nZPXgNcR4duc9yzPfE
 lhDs6bHFR/UZ4bCxgpkLZtN1pOCWiJ7ukvqkufMrftlkire6hQDt0UXMQbkUR388YQIa3D
 K5E8wuiQc0WiGYkgPhxojKs0Ds/Zu5A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-MYja2EbQPo-E4FGswIDG6w-1; Wed,
 10 Jun 2026 06:57:35 -0400
X-MC-Unique: MYja2EbQPo-E4FGswIDG6w-1
X-Mimecast-MFC-AGG-ID: MYja2EbQPo-E4FGswIDG6w_1781089054
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CEC56180ACD4; Wed, 10 Jun 2026 10:57:33 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DA693414; Wed, 10 Jun 2026 10:57:30 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 10 Jun 2026 14:56:45 +0400
Subject: [PATCH v2 03/22] hw/i386/vmmouse: convert to QemuInputHandler API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260610-ui-input-v2-3-f68452dd6a22@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6661;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ok6DMbp8gZxQxXT21UM+2t0aNckeLotDFTlxwjH+kCQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKUL/9xzPdgdw6nJj494Guw2if4yXwoA2o1mAf
 GmJzEvJbfmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCailC/wAKCRDa6OEJdZac
 5aIJD/97a2enkFQSGCELifRyVvyped06EiLzGV2L5JDamoaqZxgwKDL6ePU6XhzcWkaibyXUm5e
 JcDwvMker0H46nQMsmVvUXh+RS37CqIyUs0N53qecBAYSBnS8IXDJVqZa5Iw6fPapuedGC3YkqK
 dDs55bT6XXLqTtUhRLJ4gPbqIA63uA0nV7hDZHzBinFbaRjHMAwnUDAomeHgibbYdEqd1UjLkKT
 KBeH5ShWciRkgRnLtXrLKowRRe/kKRo61/kIzOzniNL0a5zyW1DAnYo3IsNtLGweKbVsAtx0HWr
 X4htAjk+VPHpYjYErqKZDltZzQROjOFr+POCJGqsObuNiwYi50ziouNIxST+y3VsOUW0ODK65Co
 OIMtQGHir1EwS3mnSVk7E9XPMurhUeMuZ+5fAK/TW0PwT0bEhjcsJbQXyrxy/qwhGHcco2ZOEhY
 vHs5A1nGQr2wI8TzIRsWPPPr3sSVhRo70SmG4daf7ipTgKpm8VBAU1HzVrfWthxH1ULnc0AJMwn
 Z0esMos7u07WuouPMmj5DHPikw4aJ0AB9jgEX5Tgv5c3JXzA0SYCJonb3nZUJcD8AgBupWocNJg
 pRUAcFFXze2nDx2QW14zMewhQAF9ttDgL2KldfE9E5jYjRXbbCtNv6ciwqU5FVdsEldUGhoatIb
 RGjFoljLYUf/1gg==
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

Replace the legacy QEMUPutMouseEvent callback with a proper
QemuInputHandler registration. This eliminates one of the two
remaining users of the legacy input adapter in ui/input-legacy.c.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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
index 5fa5e93b68d..1920212332a 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -133,7 +133,7 @@ port92_write(uint8_t val) "port92: write 0x%02x"
 
 # vmmouse.c
 vmmouse_get_status(void) ""
-vmmouse_mouse_event(int x, int y, int dz, int buttons_state) "event: x=%d y=%d dz=%d state=%d"
+vmmouse_queue_event(int x, int y, int dz, int buttons_state) "event: x=%d y=%d dz=%d state=%d"
 vmmouse_init(void) ""
 vmmouse_read_id(void) ""
 vmmouse_request_relative(void) ""

-- 
2.54.0


