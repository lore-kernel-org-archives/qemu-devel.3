Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07962CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 10:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXGdW-0002wG-6s; Wed, 10 Jun 2026 06:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGdU-0002kI-Ft
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:58:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGdS-00074Z-Sp
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781089094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bXpUuOpl0GC2NdoWw2KwznKpIE7Ju+drpUS1Ff4Mj7g=;
 b=PTzh0kc8T960LFepi8rtH3Q4phtGAiVVINaIITnZqcyr5umG9rAxDG5fwxIK7QVagrEUuR
 tfnN5HKNw9mWQyeQUQYlGgNpuFpYWmvJFtoAwcdOG2agVAj5MyZHZcmZyBI6uE9pLlkvGW
 Moep5L/aJrxLU2lHlvf8LFVc0OKdfn8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-KqVj9uUWMDqLWg5w26sC2Q-1; Wed,
 10 Jun 2026 06:58:11 -0400
X-MC-Unique: KqVj9uUWMDqLWg5w26sC2Q-1
X-Mimecast-MFC-AGG-ID: KqVj9uUWMDqLWg5w26sC2Q_1781089089
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 601251955EA2; Wed, 10 Jun 2026 10:58:09 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 82EED1954102; Wed, 10 Jun 2026 10:58:07 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 10 Jun 2026 14:56:51 +0400
Subject: [PATCH v2 09/22] ui/input: add LED state tracking to
 QemuInputHandlerState
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260610-ui-input-v2-9-f68452dd6a22@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4895;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=cMVZYCnggxq6yeX3PGXoPndHc36y1Z8RdA8E0xdY2nI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKUMAjWQRKcriqypiLvc6Wmyk+m2hkZ5A3Djc5
 Zr45mKP+LaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCailDAAAKCRDa6OEJdZac
 5XcxD/9ihbhQ+gZLpaA22U8rtaikrnG0ZWlNzDrfKZRVlIbXXq34luNRSLI0WP1Z/AJpoUO0HTn
 homiqpTX6EHMWGeoxE65ASmOMOY5XTorUDQd3wLHbivp0V3W5V87ageWEqd7Mz/V5e7mZjgTM9j
 w3lRJEo6uS4p/IWztSAOzi9TbS3toji46NG8AyHcCKP589yXtRTXlrAEnwx2O6d6sAO3IshSvW9
 3lbDNgmu2yQpdZpU0LNOjncTYNl5Q/hFAW+uM9Zg4rfDDVMu68ToBwhAU1m1e++MY8O7O3x+pqT
 T3j0njJhEEZyDKwrEtA0D1IYevyFg2e7rmuXpd75h2riYRmLcRGIqUc9tyd83KDT3a2Aeu7l6b5
 TNI0KtrOZKmJWe06BoJHZkLTqdiVk3y30ScrOmbB7zEA+z/izApLgS5mcNTdsZXvhLESV2X1crV
 29PgnyWKzPEo3UqFbs3c+sj+iBTLg+CBCzQat8Y7uJUcSSgC6H5lZgGCKGfrLkp+3RLR3kOpvxz
 GQLDuCeIvUaKGt2AWtGyRiWZJDGy/Mb+z5BilmiPXFYoSZ+bKqKXiZFntG/o90lPDhAahyKZia2
 SCXblX/dzVKpyOUZIahF7Q00viLcmeW6Uz0B2ide1zXhOByReEkV8I2BaodlsiuHBCdODHARKdP
 3kCzNxq6qMt3gQQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add per-handler LED state and a NotifierList for UI backends to
subscribe to LED changes.

Devices call qemu_input_handler_set_led() to store their LED state and
notify backends. Notify also on focus change, or list update.

Note: I considered conflating mouse-mode & led-state changes, but those
are quite different events (from different source kinds etc) and we may
want to improve the internal implementation.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/input.h |  5 +++++
 ui/input.c         | 49 +++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/include/ui/input.h b/include/ui/input.h
index 6df8ae3a8a3..66e5c1f4b06 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -151,4 +151,9 @@ extern const guint16 qemu_input_map_xorgxwin_to_linux[];
 extern const guint qemu_input_map_osx_to_linux_len;
 extern const guint16 qemu_input_map_osx_to_linux[];
 
+void qemu_input_handler_set_led(QemuInputHandlerState *s, int ledstate);
+void qemu_input_led_notifier_add(Notifier *n);
+void qemu_input_led_notifier_remove(Notifier *n);
+int qemu_input_get_led(QemuConsole *con);
+
 #endif /* INPUT_H */
diff --git a/ui/input.c b/ui/input.c
index 15affeabf44..99a1090f8c3 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -14,6 +14,7 @@ struct QemuInputHandlerState {
     int               id;
     int               events;
     QemuConsole       *con;
+    int               ledstate;
     QTAILQ_ENTRY(QemuInputHandlerState) node;
 };
 
@@ -38,6 +39,8 @@ static QTAILQ_HEAD(, QemuInputHandlerState) handlers =
     QTAILQ_HEAD_INITIALIZER(handlers);
 static NotifierList mouse_mode_notifiers =
     NOTIFIER_LIST_INITIALIZER(mouse_mode_notifiers);
+static NotifierList led_notifiers =
+    NOTIFIER_LIST_INITIALIZER(led_notifiers);
 
 static QemuInputEventQueueHead kbd_queue = QTAILQ_HEAD_INITIALIZER(kbd_queue);
 static QEMUTimer *kbd_timer;
@@ -45,6 +48,14 @@ static uint32_t kbd_default_delay_ms = 10;
 static uint32_t queue_count;
 static uint32_t queue_limit = 1024;
 
+static void notify_input_changed(uint32_t mask)
+{
+    notifier_list_notify(&mouse_mode_notifiers, NULL);
+    if (mask & INPUT_EVENT_MASK_KEY) {
+        notifier_list_notify(&led_notifiers, NULL);
+    }
+}
+
 QemuInputHandlerState *qemu_input_handler_register(DeviceState *dev,
                                             const QemuInputHandler *handler)
 {
@@ -55,8 +66,8 @@ QemuInputHandlerState *qemu_input_handler_register(DeviceState *dev,
     s->handler = handler;
     s->id = id++;
     QTAILQ_INSERT_TAIL(&handlers, s, node);
+    notify_input_changed(handler->mask);
 
-    notifier_list_notify(&mouse_mode_notifiers, NULL);
     return s;
 }
 
@@ -64,21 +75,23 @@ void qemu_input_handler_activate(QemuInputHandlerState *s)
 {
     QTAILQ_REMOVE(&handlers, s, node);
     QTAILQ_INSERT_HEAD(&handlers, s, node);
-    notifier_list_notify(&mouse_mode_notifiers, NULL);
+    notify_input_changed(s->handler->mask);
 }
 
 void qemu_input_handler_deactivate(QemuInputHandlerState *s)
 {
     QTAILQ_REMOVE(&handlers, s, node);
     QTAILQ_INSERT_TAIL(&handlers, s, node);
-    notifier_list_notify(&mouse_mode_notifiers, NULL);
+    notify_input_changed(s->handler->mask);
 }
 
 void qemu_input_handler_unregister(QemuInputHandlerState *s)
 {
+    uint32_t mask = s->handler->mask;
+
     QTAILQ_REMOVE(&handlers, s, node);
     g_free(s);
-    notifier_list_notify(&mouse_mode_notifiers, NULL);
+    notify_input_changed(mask);
 }
 
 void qemu_input_handler_bind(QemuInputHandlerState *s,
@@ -122,6 +135,23 @@ qemu_input_find_handler(uint32_t mask, QemuConsole *con)
     return NULL;
 }
 
+void qemu_input_handler_set_led(QemuInputHandlerState *s, int ledstate)
+{
+    assert(s->handler->mask & INPUT_EVENT_MASK_KEY);
+    s->ledstate = ledstate;
+    notifier_list_notify(&led_notifiers, NULL);
+}
+
+void qemu_input_led_notifier_add(Notifier *n)
+{
+    notifier_list_add(&led_notifiers, n);
+}
+
+void qemu_input_led_notifier_remove(Notifier *n)
+{
+    notifier_remove(n);
+}
+
 void qmp_input_send_event(const char *device,
                           bool has_head, int64_t head,
                           InputEventList *events, Error **errp)
@@ -445,6 +475,17 @@ bool qemu_input_is_absolute(QemuConsole *con)
     return (s != NULL) && (s->handler->mask & INPUT_EVENT_MASK_ABS);
 }
 
+int qemu_input_get_led(QemuConsole *con)
+{
+    QemuInputHandlerState *s;
+
+    s = qemu_input_find_handler(INPUT_EVENT_MASK_KEY, con);
+    if (s) {
+        return s->ledstate;
+    }
+    return 0;
+}
+
 int qemu_input_scale_axis(int value,
                           int min_in, int max_in,
                           int min_out, int max_out)

-- 
2.54.0


