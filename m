Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C415CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 10:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXGdB-0002Hp-Pj; Wed, 10 Jun 2026 06:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGd9-0002DM-6E
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:57:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGd6-0005kJ-Pz
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781089072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q0bIPb+d1sMe7sgxf+Bqbmw46O11A0ktQSbb40y4zvo=;
 b=IEhIo4JqSvizYHs5vn8cAWICN6gJio+iKxl+z17ge3sAj9C9yL+NFxLTehF/edcsYKk6/e
 bFWyEn6wMTWHPqYdA3H0r0qSDAzNCnKM1H1oQcFLoy8zgDxQdgQIPg33yulXj/n95DlrZv
 9szNAr3DnwetsP7KAJv0niSQ5A7ibFE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-1El3V5upNPqk6CW4yZGZBQ-1; Wed,
 10 Jun 2026 06:57:48 -0400
X-MC-Unique: 1El3V5upNPqk6CW4yZGZBQ-1
X-Mimecast-MFC-AGG-ID: 1El3V5upNPqk6CW4yZGZBQ_1781089067
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9C4319560BE; Wed, 10 Jun 2026 10:57:46 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C961B1800347; Wed, 10 Jun 2026 10:57:44 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 10 Jun 2026 14:56:47 +0400
Subject: [PATCH v2 05/22] ui: move LED and key utilities to input.c, delete
 input-legacy.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260610-ui-input-v2-5-f68452dd6a22@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13254;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=xnZ7Kddj51Zq6hMB1+4tdJkJJhRwpIbKu48YMi1H+h0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKUL/NRCM+b+7dh7L/Qn12FZBPrY/fzC8DGiZU
 Rb2JxjZbjqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCailC/wAKCRDa6OEJdZac
 5QUYEAC1jI1uidjYeAudvPy8+SYAgS0FfRQjdK0FTO+Dw3tcjbMULlFC7HowZdKfUpmmN4pDNM5
 wbrreXkHUMnRfp/I2Ms5f1rX7466pMj5lPvHlkptglEjJyHX72/gWA/zJ+qbJZ35rEw/emolu6m
 6reEzwQgoXbdQpR4wPFMBqSn/mAhjK8q8goO57lHSLvYSEc7zDbePrQAFSdLVjc56KQf7xmO9BM
 aqkcMLLuACHLcgMO4nfr/b8v7Xl4ZPSsfvRT/KwRpwZfqkt92WAOaK+mf3MVQr3WeqQN12LiyS8
 4qL4UI74Iwrlj11Pog6YXfBF+loNvxF01gN8w6aCXNUZy+/Vx6srghYtS94N05wg3m7F4jlTb3e
 oNxaWa7H64WBC7vRtfVv7hQ896nVZghWsVRbaT2GMFjDhjQlOeyQiWx6ovnMMTvA3ZUjO0HfGYw
 nz0RvWzWFtqJsr0CK6jt+45Y9XPFYtb0TOqEhEQJDcabEyr4CBvdSA4ci2ksnwLni7kgleG/iTi
 Zs6jWd8CtPpV+pLAWPsD2xo1NA1I9p3qiWaBTYIjgg1GAqJ1KIpyP/io0G4XRFv5dZZQYYTAWiV
 IZqqZ2QXK3rDRDPKP+X3shKWTZ0hB8y0af12hQT0vopEq+Vh+vF+DDwbWhdvHvSYJ/CerVZZttJ
 XXrnQtG2EsXjX6w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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


