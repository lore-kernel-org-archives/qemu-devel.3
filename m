Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE020CD8CBF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWxXz-0001Mo-FI; Tue, 09 Jun 2026 10:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWxXx-0001Ip-Ns
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:35:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWxXv-0006uu-HI
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781015713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q0bIPb+d1sMe7sgxf+Bqbmw46O11A0ktQSbb40y4zvo=;
 b=X99C4XLrwfKnP0PbVbIIeKgIYikXXC+5+mPV/XdP0UsdVD/wt2fIa1UtHYoOiUq183OV7c
 WUL+qVn3Otg9ivLQ1P7PwaWH+PeDMzqqrwIkxxlnaI8hPAqQxzbWbYjMwLhlNh+XeHIkL/
 x6C2nfPnmfHptHT5h/d1CGugPuN6M2g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-KLgyW5jrPkqavxSmfACb9g-1; Tue,
 09 Jun 2026 10:35:10 -0400
X-MC-Unique: KLgyW5jrPkqavxSmfACb9g-1
X-Mimecast-MFC-AGG-ID: KLgyW5jrPkqavxSmfACb9g_1781015709
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29B3C1944D23; Tue,  9 Jun 2026 14:35:09 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 32D293008B3C; Tue,  9 Jun 2026 14:35:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 09 Jun 2026 18:34:24 +0400
Subject: [PATCH 05/17] ui: move LED and key utilities to input.c, delete
 input-legacy.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260609-ui-input-v1-5-42615deb818e@redhat.com>
References: <20260609-ui-input-v1-0-42615deb818e@redhat.com>
In-Reply-To: <20260609-ui-input-v1-0-42615deb818e@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=13254;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=xnZ7Kddj51Zq6hMB1+4tdJkJJhRwpIbKu48YMi1H+h0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKCR3YU0YUMZ7A4reHJitgoZf1xOy8Ezj5Uycb
 WLpF01SMLOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaigkdwAKCRDa6OEJdZac
 5RcgEACBqEtreYRg3mx7T8uOKs/+DJMpRLroTKDi3vIo673XBv9qYor/IbRb7HK/dvVJnbrrpy9
 Q+7ayjJbNnItFiOg6VJDya0S75vyMSMtCzVfZog3LE6A5nqemCil/7HX2WOIEUtQ3kjkrKnGHhy
 06tgWTiPKVzpV1eRdsIfLb1cwn8L9SkrVZvHbOS31+ksin0x4VGmVeW0ZF0ER/7s8hdrAAz3Up4
 Nobrf3Mq3h8/I7j3kf+caihqsRLCwxoM4pLAY8LbL3Tc78lsUwYGwg1QbEgHiPJBp++KkAK9Xdh
 KtrqGR3JYK6NOlSA8wugcCp4Yg7MCX1pY97NSg5JFfbgoVxqbnGBeY1PWbBI17rWu7TnBlNoSG7
 j0D/os5IXXYHl8urNnb3JsKi30ySlXw+IgcV7uc2Lyfvxue9uMAdrNGMdlBPFMZBXP9S08+h8Vx
 Gng8csn9+ck6FId3pgYUAlOGrk3q+OKcayXqsgOtg/fZxQhFTO87FreylBpe/yTHgEaA4t1BIqR
 i/hks7fJNZS6ik2G32Evb6X5I4vb0mfvN/bDBgXUGK/cFR6zmw3+2WK84ZbiFsLYwU0urbQZUK8
 iZFUKsw+km9zZ+sqSKbhaqkWxMVmJf7X3bwCHtR6TMAKS01W2VMswahZvrT02RnnwyaN27ROqf8
 Q3S+pkN7dig2BtA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

With both legacy mouse API consumers converted, the remaining
code in input-legacy.c (LED broadcast, index_from_key, qmp_send_key)
is not legacy-specific. Move it to ui/input.c and delete the file.

Clean up include/ui/console.h by removing the now-unused legacy
mouse API declarations (QEMUPutMouseEvent, QEMUPutMouseEntry,
QEMUPutKBDEvent, QEMUPutKbdEntry) and MOUSE_EVENT_* constants.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h |  18 -----
 ui/input-legacy.c    | 221 ---------------------------------------------------
 ui/input.c           |  66 +++++++++++++++
 ui/ui-hmp-cmds.c     |   7 +-
 ui/meson.build       |   1 -
 5 files changed, 70 insertions(+), 243 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 3cb78989cd2..0299ed4b566 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -30,14 +30,6 @@ OBJECT_DECLARE_SIMPLE_TYPE(QemuFixedTextConsole, QEMU_FIXED_TEXT_CONSOLE)
 #define QEMU_IS_FIXED_TEXT_CONSOLE(c) \
     object_dynamic_cast(OBJECT(c), TYPE_QEMU_FIXED_TEXT_CONSOLE)
 
-/* keyboard/mouse support */
-
-#define MOUSE_EVENT_LBUTTON 0x01
-#define MOUSE_EVENT_RBUTTON 0x02
-#define MOUSE_EVENT_MBUTTON 0x04
-#define MOUSE_EVENT_WHEELUP 0x08
-#define MOUSE_EVENT_WHEELDN 0x10
-
 /* identical to the ps/2 keyboard bits */
 #define QEMU_SCROLL_LOCK_LED (1 << 0)
 #define QEMU_NUM_LOCK_LED    (1 << 1)
@@ -62,20 +54,10 @@ enum qemu_color_names {
 #define ATTR2CHTYPE(c, fg, bg, bold) \
     ((bold) << 21 | (bg) << 11 | (fg) << 8 | (c))
 
-typedef void QEMUPutKBDEvent(void *opaque, int keycode);
 typedef void QEMUPutLEDEvent(void *opaque, int ledstate);
-typedef void QEMUPutMouseEvent(void *opaque, int dx, int dy, int dz, int buttons_state);
 
-typedef struct QEMUPutMouseEntry QEMUPutMouseEntry;
-typedef struct QEMUPutKbdEntry QEMUPutKbdEntry;
 typedef struct QEMUPutLEDEntry QEMUPutLEDEntry;
 
-QEMUPutMouseEntry *qemu_add_mouse_event_handler(QEMUPutMouseEvent *func,
-                                                void *opaque, int absolute,
-                                                const char *name);
-void qemu_remove_mouse_event_handler(QEMUPutMouseEntry *entry);
-void qemu_activate_mouse_event_handler(QEMUPutMouseEntry *entry);
-
 QEMUPutLEDEntry *qemu_add_led_event_handler(QEMUPutLEDEvent *func, void *opaque);
 void qemu_remove_led_event_handler(QEMUPutLEDEntry *entry);
 
diff --git a/ui/input-legacy.c b/ui/input-legacy.c
deleted file mode 100644
index 71b17a3cfc7..00000000000
--- a/ui/input-legacy.c
+++ /dev/null
@@ -1,221 +0,0 @@
-/*
- * QEMU System Emulator
- *
- * Copyright (c) 2003-2008 Fabrice Bellard
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#include "qemu/osdep.h"
-#include "qemu/log.h"
-#include "qapi/qapi-commands-ui.h"
-#include "ui/console.h"
-#include "keymaps.h"
-#include "ui/input.h"
-
-struct QEMUPutMouseEntry {
-    QEMUPutMouseEvent *qemu_put_mouse_event;
-    void *qemu_put_mouse_event_opaque;
-    int qemu_put_mouse_event_absolute;
-
-    /* new input core */
-    QemuInputHandler h;
-    QemuInputHandlerState *s;
-    int axis[INPUT_AXIS__MAX];
-    int buttons;
-};
-
-struct QEMUPutKbdEntry {
-    QEMUPutKBDEvent *put_kbd;
-    void *opaque;
-    QemuInputHandlerState *s;
-};
-
-struct QEMUPutLEDEntry {
-    QEMUPutLEDEvent *put_led;
-    void *opaque;
-    QTAILQ_ENTRY(QEMUPutLEDEntry) next;
-};
-
-static QTAILQ_HEAD(, QEMUPutLEDEntry) led_handlers =
-    QTAILQ_HEAD_INITIALIZER(led_handlers);
-
-void qmp_send_key(KeyValueList *keys, bool has_hold_time, int64_t hold_time,
-                  Error **errp)
-{
-    KeyValueList *p;
-    unsigned int *up = NULL;
-    int count = 0;
-
-    if (!has_hold_time) {
-        hold_time = 0; /* use default */
-    }
-
-    for (p = keys; p != NULL; p = p->next) {
-        up = g_realloc(up, sizeof(*up) * (count+1));
-        up[count] = qemu_input_key_value_to_linux(p->value);
-        qemu_input_event_send_key_linux(NULL, up[count], true);
-        qemu_input_event_send_key_delay(hold_time);
-        count++;
-    }
-    while (count) {
-        count--;
-        qemu_input_event_send_key_linux(NULL, up[count], false);
-        qemu_input_event_send_key_delay(hold_time);
-    }
-    g_free(up);
-}
-
-static void legacy_mouse_event(DeviceState *dev, QemuConsole *src,
-                               QemuInputEvent *evt)
-{
-    static const int bmap[INPUT_BUTTON__MAX] = {
-        [INPUT_BUTTON_LEFT]   = MOUSE_EVENT_LBUTTON,
-        [INPUT_BUTTON_MIDDLE] = MOUSE_EVENT_MBUTTON,
-        [INPUT_BUTTON_RIGHT]  = MOUSE_EVENT_RBUTTON,
-    };
-    QEMUPutMouseEntry *s = (QEMUPutMouseEntry *)dev;
-
-    switch (evt->type) {
-    case INPUT_EVENT_KIND_BTN:
-        if (evt->btn.down) {
-            s->buttons |= bmap[evt->btn.button];
-        } else {
-            s->buttons &= ~bmap[evt->btn.button];
-        }
-        if (evt->btn.down && evt->btn.button == INPUT_BUTTON_WHEEL_UP) {
-            s->qemu_put_mouse_event(s->qemu_put_mouse_event_opaque,
-                                    s->axis[INPUT_AXIS_X],
-                                    s->axis[INPUT_AXIS_Y],
-                                    -1,
-                                    s->buttons);
-        }
-        if (evt->btn.down && evt->btn.button == INPUT_BUTTON_WHEEL_DOWN) {
-            s->qemu_put_mouse_event(s->qemu_put_mouse_event_opaque,
-                                    s->axis[INPUT_AXIS_X],
-                                    s->axis[INPUT_AXIS_Y],
-                                    1,
-                                    s->buttons);
-        }
-        if (evt->btn.down && evt->btn.button == INPUT_BUTTON_WHEEL_RIGHT) {
-            s->qemu_put_mouse_event(s->qemu_put_mouse_event_opaque,
-                                    s->axis[INPUT_AXIS_X],
-                                    s->axis[INPUT_AXIS_Y],
-                                    -2,
-                                    s->buttons);
-        }
-        if (evt->btn.down && evt->btn.button == INPUT_BUTTON_WHEEL_LEFT) {
-            s->qemu_put_mouse_event(s->qemu_put_mouse_event_opaque,
-                                    s->axis[INPUT_AXIS_X],
-                                    s->axis[INPUT_AXIS_Y],
-                                    2,
-                                    s->buttons);
-        }
-        break;
-    case INPUT_EVENT_KIND_ABS:
-        s->axis[evt->abs.axis] = evt->abs.value;
-        break;
-    case INPUT_EVENT_KIND_REL:
-        s->axis[evt->rel.axis] += evt->rel.value;
-        break;
-    default:
-        break;
-    }
-}
-
-static void legacy_mouse_sync(DeviceState *dev)
-{
-    QEMUPutMouseEntry *s = (QEMUPutMouseEntry *)dev;
-
-    s->qemu_put_mouse_event(s->qemu_put_mouse_event_opaque,
-                            s->axis[INPUT_AXIS_X],
-                            s->axis[INPUT_AXIS_Y],
-                            0,
-                            s->buttons);
-
-    if (!s->qemu_put_mouse_event_absolute) {
-        s->axis[INPUT_AXIS_X] = 0;
-        s->axis[INPUT_AXIS_Y] = 0;
-    }
-}
-
-QEMUPutMouseEntry *qemu_add_mouse_event_handler(QEMUPutMouseEvent *func,
-                                                void *opaque, int absolute,
-                                                const char *name)
-{
-    QEMUPutMouseEntry *s;
-
-    s = g_new0(QEMUPutMouseEntry, 1);
-
-    s->qemu_put_mouse_event = func;
-    s->qemu_put_mouse_event_opaque = opaque;
-    s->qemu_put_mouse_event_absolute = absolute;
-
-    s->h.name = name;
-    s->h.mask = INPUT_EVENT_MASK_BTN |
-        (absolute ? INPUT_EVENT_MASK_ABS : INPUT_EVENT_MASK_REL);
-    s->h.event = legacy_mouse_event;
-    s->h.sync = legacy_mouse_sync;
-    s->s = qemu_input_handler_register((DeviceState *)s,
-                                       &s->h);
-
-    return s;
-}
-
-void qemu_activate_mouse_event_handler(QEMUPutMouseEntry *entry)
-{
-    qemu_input_handler_activate(entry->s);
-}
-
-void qemu_remove_mouse_event_handler(QEMUPutMouseEntry *entry)
-{
-    qemu_input_handler_unregister(entry->s);
-
-    g_free(entry);
-}
-
-QEMUPutLEDEntry *qemu_add_led_event_handler(QEMUPutLEDEvent *func,
-                                            void *opaque)
-{
-    QEMUPutLEDEntry *s;
-
-    s = g_new0(QEMUPutLEDEntry, 1);
-
-    s->put_led = func;
-    s->opaque = opaque;
-    QTAILQ_INSERT_TAIL(&led_handlers, s, next);
-    return s;
-}
-
-void qemu_remove_led_event_handler(QEMUPutLEDEntry *entry)
-{
-    if (entry == NULL)
-        return;
-    QTAILQ_REMOVE(&led_handlers, entry, next);
-    g_free(entry);
-}
-
-void kbd_put_ledstate(int ledstate)
-{
-    QEMUPutLEDEntry *cursor;
-
-    QTAILQ_FOREACH(cursor, &led_handlers, next) {
-        cursor->put_led(cursor->opaque, ledstate);
-    }
-}
diff --git a/ui/input.c b/ui/input.c
index c013cd9f7e0..55769c66fcc 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -648,3 +648,69 @@ void qemu_input_touch_event(QemuConsole *con,
         qemu_input_event_sync();
     }
 }
+
+struct QEMUPutLEDEntry {
+    QEMUPutLEDEvent *put_led;
+    void *opaque;
+    QTAILQ_ENTRY(QEMUPutLEDEntry) next;
+};
+
+static QTAILQ_HEAD(, QEMUPutLEDEntry) led_handlers =
+    QTAILQ_HEAD_INITIALIZER(led_handlers);
+
+QEMUPutLEDEntry *qemu_add_led_event_handler(QEMUPutLEDEvent *func,
+                                            void *opaque)
+{
+    QEMUPutLEDEntry *s;
+
+    s = g_new0(QEMUPutLEDEntry, 1);
+
+    s->put_led = func;
+    s->opaque = opaque;
+    QTAILQ_INSERT_TAIL(&led_handlers, s, next);
+    return s;
+}
+
+void qemu_remove_led_event_handler(QEMUPutLEDEntry *entry)
+{
+    if (entry == NULL) {
+        return;
+    }
+    QTAILQ_REMOVE(&led_handlers, entry, next);
+    g_free(entry);
+}
+
+void kbd_put_ledstate(int ledstate)
+{
+    QEMUPutLEDEntry *cursor;
+
+    QTAILQ_FOREACH(cursor, &led_handlers, next) {
+        cursor->put_led(cursor->opaque, ledstate);
+    }
+}
+
+void qmp_send_key(KeyValueList *keys, bool has_hold_time, int64_t hold_time,
+                  Error **errp)
+{
+    KeyValueList *p;
+    unsigned int *up = NULL;
+    int count = 0;
+
+    if (!has_hold_time) {
+        hold_time = 0; /* use default */
+    }
+
+    for (p = keys; p != NULL; p = p->next) {
+        up = g_realloc_n(up, count + 1, sizeof(*up));
+        up[count] = qemu_input_key_value_to_linux(p->value);
+        qemu_input_event_send_key_linux(NULL, up[count], true);
+        qemu_input_event_send_key_delay(hold_time);
+        count++;
+    }
+    while (count) {
+        count--;
+        qemu_input_event_send_key_linux(NULL, up[count], false);
+        qemu_input_event_send_key_delay(hold_time);
+    }
+    g_free(up);
+}
diff --git a/ui/ui-hmp-cmds.c b/ui/ui-hmp-cmds.c
index 76f5181de43..ee3e731d07e 100644
--- a/ui/ui-hmp-cmds.c
+++ b/ui/ui-hmp-cmds.c
@@ -55,10 +55,11 @@ void hmp_mouse_move(Monitor *mon, const QDict *qdict)
 
 void hmp_mouse_button(Monitor *mon, const QDict *qdict)
 {
+    /* HMP mouse_button bitmask: 1=L, 2=R, 4=M */
     static uint32_t bmap[INPUT_BUTTON__MAX] = {
-        [INPUT_BUTTON_LEFT]       = MOUSE_EVENT_LBUTTON,
-        [INPUT_BUTTON_MIDDLE]     = MOUSE_EVENT_MBUTTON,
-        [INPUT_BUTTON_RIGHT]      = MOUSE_EVENT_RBUTTON,
+        [INPUT_BUTTON_LEFT]       = 0x01,
+        [INPUT_BUTTON_MIDDLE]     = 0x04,
+        [INPUT_BUTTON_RIGHT]      = 0x02,
     };
     int button_state = qdict_get_int(qdict, "button_state");
 
diff --git a/ui/meson.build b/ui/meson.build
index bb01f0728e2..0c6a432948c 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -53,7 +53,6 @@ libui = static_library('qemuui', libui_sources + genh,
 ui = declare_dependency(objects: libui.extract_all_objects(recursive: false), dependencies: [pixman])
 system_ss.add(png)
 system_ss.add(files(
-  'input-legacy.c',
   'input-barrier.c',
   'input.c',
   'ui-hmp-cmds.c',

-- 
2.54.0


