Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98752CD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXGet-0006Cj-FJ; Wed, 10 Jun 2026 06:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGeU-0005ls-2l
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:59:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGeQ-0000Iw-BJ
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781089153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Y8EBryG7J2AwkW2FnwDImop49e0w/lo+Q8d2a9jPH4=;
 b=SaxffsXlJqq9XPXNGFZ/nB+c0h4kBQTw31yMhKzhadGeGJEKvIKyI/0eviH7a2GNm528ri
 /j4p02Hce8g0fuCD33a2hIvxSoR741TBvgWsttZUN3kzBU7FluygdcHNwmGkxi4BPvNnYx
 wLAu4bFn0LOr/+EXhq72/jW2qOJtKCU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-mC0rNIbfMK2ugDY7d8-ODg-1; Wed,
 10 Jun 2026 06:59:09 -0400
X-MC-Unique: mC0rNIbfMK2ugDY7d8-ODg-1
X-Mimecast-MFC-AGG-ID: mC0rNIbfMK2ugDY7d8-ODg_1781089148
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D21E19540CC; Wed, 10 Jun 2026 10:59:08 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C8D413000223; Wed, 10 Jun 2026 10:59:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 10 Jun 2026 14:57:01 +0400
Subject: [PATCH v2 19/22] ui/vnc: switch LED handling to Notifier-based
 input API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260610-ui-input-v2-19-f68452dd6a22@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4414;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=9EvPEBUMG8vTwC/626zYm+fU5TkcgcDC/RHnOIaj7XQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKUMBbGaZ2FimEqmGjP6HYV6RKkEvMSnMAnkC9
 bFsCu+ao6eJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCailDAQAKCRDa6OEJdZac
 5UCQD/44RiLO0TRWzL6oJqwpCU0HNC713YkUFH8QM7xEKscDtqPbdGAVvSGcYwwSGzg6Zvetum0
 CJ5ZLyG4B9Q1R+vxfNg+2nmK0lxdvizOUw0+Z9Ynbb1uShszic++Bpftrq+khO5pL7+J6jS4Oz1
 CXBjVfcr91mUzMCqykTC4KfEYO2QOGhi0JYNUENy0wd2BVt+rqJo81Ss9ADmhFclgSPvJUxxGQ2
 F3r/mzIAYL2rDJu9NrkgAvSvjiQhrFIpfUAUwk8yFYVW2NEbjHDd5cDisvO1nzeFWcto5tm0gcZ
 h4t9IEKk6+/VP76X5NYCtRPyF/aYXI8WznqaVHy+DpDEinuA1uc0vWkeInraAqM7YYzgGzdzewl
 0LRxeSQvAZzlLk+lPgeONg1k5IMrwYg7jh6OYthkpPiwED9sBbEJfSuPr3K6iHdSeruOsg+0Rxo
 s9p2F0nP2v+GLRrAfT2990h2kl+CHs1PJQrMAYJ4TGqKTdkua/3E4cKi1tFU1uiCWmOvQ2aVkqq
 PUW3uK0EHUssxFRA8MwOMQRZAgQEJE2v2ZsT6LzL4nIaDV/IdWeC7b0XF1PY/PA2S+M0C+WHoEB
 9uNBuIeeKTDT/PLysdJuHp5fy3VRXbfqBCKg2aEqys5kU7OiL1HHVAD6Ow+wJaGJR3pJMho5ldc
 ontnPa9k3Va2h7Q==
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

Replace QEMUPutLEDEntry with an embedded Notifier in VncDisplay.
Use qemu_input_led_notifier_add/remove instead of the old
qemu_add/remove_led_event_handler.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.h               |  2 +-
 tools/qemu-vnc/input.c | 49 +++++++++++++++++--------------------------------
 ui/vnc.c               | 11 ++++++-----
 3 files changed, 24 insertions(+), 38 deletions(-)

diff --git a/ui/vnc.h b/ui/vnc.h
index c8d87cd5301..88293ef4971 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -147,7 +147,7 @@ struct VncDisplay
     DisplayChangeListener dcl;
     kbd_layout_t *kbd_layout;
     int lock_key_sync;
-    QEMUPutLEDEntry *led;
+    Notifier led_notifier;
     int ledstate;
     QKbdState *kbd;
     QemuMutex mutex;
diff --git a/tools/qemu-vnc/input.c b/tools/qemu-vnc/input.c
index 6fb73b31248..b96ff741308 100644
--- a/tools/qemu-vnc/input.c
+++ b/tools/qemu-vnc/input.c
@@ -13,58 +13,43 @@
 #include "trace.h"
 #include "qemu-vnc.h"
 
-struct QEMUPutLEDEntry {
-    QEMUPutLEDEvent *put_led;
-    void *opaque;
-    QTAILQ_ENTRY(QEMUPutLEDEntry) next;
-};
-
 static NotifierList mouse_mode_notifiers =
     NOTIFIER_LIST_INITIALIZER(mouse_mode_notifiers);
-static QTAILQ_HEAD(, QEMUPutLEDEntry) led_handlers =
-    QTAILQ_HEAD_INITIALIZER(led_handlers);
+static NotifierList led_notifiers =
+    NOTIFIER_LIST_INITIALIZER(led_notifiers);
 
 /* Track the target console for pending mouse events (used by sync) */
 static QemuConsole *mouse_target;
 
-QEMUPutLEDEntry *qemu_add_led_event_handler(QEMUPutLEDEvent *func,
-                                            void *opaque)
+/*
+ * The D-Bus Keyboard.Modifiers property uses the same
+ * bit layout as QEMU's LED constants.
+ */
+static guint modifiers;
+
+void qemu_input_led_notifier_add(Notifier *n)
 {
-    QEMUPutLEDEntry *s;
+    notifier_list_add(&led_notifiers, n);
+}
 
-    s = g_new0(QEMUPutLEDEntry, 1);
-    s->put_led = func;
-    s->opaque = opaque;
-    QTAILQ_INSERT_TAIL(&led_handlers, s, next);
-    return s;
+void qemu_input_led_notifier_remove(Notifier *n)
+{
+    notifier_remove(n);
 }
 
-void qemu_remove_led_event_handler(QEMUPutLEDEntry *entry)
+int qemu_input_get_led(QemuConsole *con)
 {
-    if (!entry) {
-        return;
-    }
-    QTAILQ_REMOVE(&led_handlers, entry, next);
-    g_free(entry);
+    return modifiers;
 }
 
 static void
 on_keyboard_modifiers_changed(GObject *gobject, GParamSpec *pspec,
                               gpointer user_data)
 {
-    guint modifiers;
-    QEMUPutLEDEntry *cursor;
-
     modifiers = qemu_dbus_display1_keyboard_get_modifiers(
         QEMU_DBUS_DISPLAY1_KEYBOARD(gobject));
 
-    /*
-     * The D-Bus Keyboard.Modifiers property uses the same
-     * bit layout as QEMU's LED constants.
-     */
-    QTAILQ_FOREACH(cursor, &led_handlers, next) {
-        cursor->put_led(cursor->opaque, modifiers);
-    }
+    notifier_list_notify(&led_notifiers, NULL);
 }
 
 void qemu_add_mouse_mode_change_notifier(Notifier *notify)
diff --git a/ui/vnc.c b/ui/vnc.c
index 253b1a9f634..3b6765393e0 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1820,9 +1820,10 @@ static void vnc_led_state_change(VncState *vs)
     vnc_flush(vs);
 }
 
-static void kbd_leds(void *opaque, int ledstate)
+static void kbd_leds(Notifier *notifier, void *data)
 {
-    VncDisplay *vd = opaque;
+    VncDisplay *vd = container_of(notifier, VncDisplay, led_notifier);
+    int ledstate = qemu_input_get_led(vd->dcl.con);
     VncState *client;
 
     trace_vnc_key_guest_leds((ledstate & QEMU_CAPS_LOCK_LED),
@@ -3489,8 +3490,7 @@ static void vnc_display_close(VncDisplay *vd)
     g_free(vd->tlsauthzid);
     vd->tlsauthzid = NULL;
     if (vd->lock_key_sync) {
-        qemu_remove_led_event_handler(vd->led);
-        vd->led = NULL;
+        qemu_input_led_notifier_remove(&vd->led_notifier);
     }
 #ifdef CONFIG_VNC_SASL
     if (vd->sasl.authz) {
@@ -4221,7 +4221,8 @@ static bool vnc_display_open(VncDisplay *vd, Error **errp)
 #endif
     vd->lock_key_sync = lock_key_sync;
     if (lock_key_sync) {
-        vd->led = qemu_add_led_event_handler(kbd_leds, vd);
+        vd->led_notifier.notify = kbd_leds;
+        qemu_input_led_notifier_add(&vd->led_notifier);
     }
     vd->ledstate = 0;
 

-- 
2.54.0


