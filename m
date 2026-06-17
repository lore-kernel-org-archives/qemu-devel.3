Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA49CD98F6
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZs8s-0001qD-AS; Wed, 17 Jun 2026 11:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs8q-0001el-Ef
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:25:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs8o-0004pf-Hx
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781709921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FLohL/DwiLVV7GyrSavecJTc687UTN0ybDOhKS/1QrE=;
 b=hHrT8XDeZn7c1ukQ+EguTbvXWTcHweWfFJnE5R1mngXhovGjCuRTEmc3hPJjZZP9lm0gGd
 EckbytD2XRQi0Y7FnhvJNHu5odzNkmssKAnW7FK4DRKqjzQrl/DGkchh92aqrcrpatJfIv
 nj1Axoq806dMvcw6R2cGv5s05W2teyg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-0pBN9-2RMxSffSNpo3HUwA-1; Wed,
 17 Jun 2026 11:25:16 -0400
X-MC-Unique: 0pBN9-2RMxSffSNpo3HUwA-1
X-Mimecast-MFC-AGG-ID: 0pBN9-2RMxSffSNpo3HUwA_1781709910
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48BD31953948
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 15:25:10 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 320BE3008B3D; Wed, 17 Jun 2026 15:25:08 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Jun 2026 19:23:16 +0400
Subject: [GIT PULL 19/27] ui/vnc: switch LED handling to Notifier-based
 input API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260617-ui-input-v1-19-79e9aedc5899@redhat.com>
References: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
In-Reply-To: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4501;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=zUUEt9oCBNnW+aR0Wbm+JgKybJImWQolrOxUb4LHNOA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMrvpXhj9j3wo0zZozrsvy/gwhteQAtfxBl0Q/
 UOBuU+JxAqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajK76QAKCRDa6OEJdZac
 5TrMD/4pdQ9MQ+l/vkIt/RYrswhp+nEXQCM3c5xZ9sPz/HRQP+IdEhkBo1ZiGwGJIAX3WuXF2pU
 QAY7culf/dWfOb8GDfGZe2H/ZFqQf9pCjHtM/WeYX0FbecTCTO3OqpjVi4bUlnzywhvnJLEqrmn
 rbVLIExisEDzw1ZPK1y8NpYbBwoYmoLqKZp/rPoBH6lhWoRk8tKDy9Ay0cngxYO2oDCQT1/NC/K
 icxk6GSNAz1QKlgD+zwvE/6ahM2rhXX2Uo0jUbvQWN982Qi/5sq4gYhU2OLh9mAuR/783NnroHD
 DBn4bffv+58EHuQUG+VNjHoPQ7e6t3ClYEpL8wNQ4uqyKeGOxn3AYrd+1M/1ma/cFvbCsZ5rXtc
 QhRx1Ak3hcFmtEjmGeK9Zq49INnU+JtxD1voDUlMybkwzqxXL9RDu9gyiHSYDpmVqWhyZHtXUzS
 jhsWhqr6hJiiyo91I0pGl4EkTQ9N49JuxVfcSdU2PpKRCecT2tujNlXmcc40pG/PxU0wdSARlYZ
 VlkOutvti3J/B+gx5FPocyXmEq2hpLzDw0kSXn4AxLI5YX0k7Zh5kww2y3GPy7dFm+a+w96En8e
 gsE2c+mYoT2/Lv5s+MU/jHHqJQQGMvWeWLIx9Yb/O9wrpN1yJ2Q3vJvRfw1UuIWqTNeIpL6QITj
 yolMcuy3VBLZ3Qg==
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

Replace QEMUPutLEDEntry with an embedded Notifier in VncDisplay.
Use qemu_input_led_notifier_add/remove instead of the old
qemu_add/remove_led_event_handler.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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
index 6fb73b31248..dd6a55ce9e5 100644
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
+uint32_t qemu_input_get_leds_mask(const QemuConsole *con)
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
index 253b1a9f634..b2b69923b75 100644
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
+    int ledstate = qemu_input_get_leds_mask(vd->dcl.con);
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


