Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD91ECD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXGeu-0006Nx-QJ; Wed, 10 Jun 2026 06:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGep-00069B-CN
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:59:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGeb-0000lb-JJ
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781089163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qx38nzR7RAS4RV+BWU9P9B+GDyhdYUd+EO5NmH4hnuA=;
 b=fnyzexPdjU1ZtAG0K7mgLiTLGwshZLb8ZS5B3cXRDr3mx/ld/JAPJxVlc9fkWv5dVaT4hi
 wgGamD9RO1GRuw1f6a6TxhT0mPvNlEXmfbE5zCJ05RVkNyaemYPf8VCVyXmoPpMtbrUvaE
 /15/NliJtUz69ZOAC3XYNDiqr69AXUs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-3iUX_xIWMTesHnvPhAODPQ-1; Wed,
 10 Jun 2026 06:59:20 -0400
X-MC-Unique: 3iUX_xIWMTesHnvPhAODPQ-1
X-Mimecast-MFC-AGG-ID: 3iUX_xIWMTesHnvPhAODPQ_1781089158
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B121E1955F12; Wed, 10 Jun 2026 10:59:18 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7BD401954B09; Wed, 10 Jun 2026 10:59:17 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 10 Jun 2026 14:57:03 +0400
Subject: [PATCH v2 21/22] ui/dbus: switch LED handling to Notifier-based
 input API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260610-ui-input-v2-21-f68452dd6a22@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1963;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2C4B4AqpW8MpGJ6frIAWY552nHkk+HJpvh9goLxBKjs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKUMCzTPnyGL8Zpji8Dv3encwLyJRElBfIrnqK
 lF9F1cosDKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCailDAgAKCRDa6OEJdZac
 5Wd3D/9J25aWkslYF37irlBk+GJlVFgn2F/fwWuEsEqM+vzinWyBXPBnprmdzP40Pwexpzw87uw
 sQbIYI8J5FuYPItsyF0SZapVfIkBbVm4HqWDZhmy06rqmEknwR3V62HBw9XSz92RHeGtv4MLjG7
 MwXCp0yFSVRPWOKQ9wQlsJ/6lz3M8hvx+ZHz5nliE1eNpuWiEUAOZtbggakU1zxh2PHOmONaoK1
 +uKNkZ+2vDo/qt7OnkdS5IOY/RlHG7fZnABtlhTuB52aRFgKuiScnBW2zBK9u4HjdAr15a9vn2d
 RVIJtXHbxpmlp8OXHJJmmq1Z/AY/7kLSDmgydgyl69HFwexI0QJhrutfnhTV2wj6IOIYoL+Nahs
 egAzGyL6EMqxWuBdMlEYloQknHFD5HMwGUJHzIdgR01Y4qlz8JsURGk7R4UdtqwUYgXEKeOWZtw
 3B/wH/2NL4+3a35Nglpud0K225B94BmDG8k3euZ0u5XMxlfuY8ggimS6bL0N37x859hoQbLZmKv
 A3kPZwwEVel/02lYYbdqxP6UVQrzFiWN4BxK6kDXsTDsKRPyaaclCgVxZg8xj0cpVyFwCbqi/OC
 FMYJdlWdQbbSSKrPudpeIDi6HcYhu6gXyIBqvfv60gCGtmhjsord8STvyAM7vI55AQ+CdwmZUB5
 uyHHaV7RbH4WgyQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-console.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/ui/dbus-console.c b/ui/dbus-console.c
index 21eceb24362..6ff44881895 100644
--- a/ui/dbus-console.c
+++ b/ui/dbus-console.c
@@ -46,6 +46,7 @@ struct _DBusDisplayConsole {
 
     QemuDBusDisplay1Keyboard *iface_kbd;
     QKbdState *kbd;
+    Notifier led_notifier;
 
     QemuDBusDisplay1Mouse *iface_mouse;
     QemuDBusDisplay1MultiTouch *iface_touch;
@@ -150,6 +151,7 @@ dbus_display_console_dispose(GObject *object)
 {
     DBusDisplayConsole *ddc = DBUS_DISPLAY_CONSOLE(object);
 
+    qemu_input_led_notifier_remove(&ddc->led_notifier);
     qemu_console_unregister_listener(&ddc->dcl);
     g_clear_object(&ddc->iface_touch);
     g_clear_object(&ddc->iface_mouse);
@@ -367,9 +369,11 @@ dbus_kbd_release(DBusDisplayConsole *ddc,
 }
 
 static void
-dbus_kbd_qemu_leds_updated(void *data, int ledstate)
+dbus_kbd_qemu_leds_updated(Notifier *notifier, void *data)
 {
-    DBusDisplayConsole *ddc = DBUS_DISPLAY_CONSOLE(data);
+    DBusDisplayConsole *ddc = container_of(notifier, DBusDisplayConsole,
+                                           led_notifier);
+    int ledstate = qemu_input_get_led(ddc->dcl.con);
 
     qemu_dbus_display1_keyboard_set_modifiers(ddc->iface_kbd, ledstate);
 }
@@ -577,7 +581,8 @@ dbus_display_console_new(DBusDisplay *display, QemuConsole *con)
 
     ddc->kbd = qkbd_state_init(con);
     ddc->iface_kbd = qemu_dbus_display1_keyboard_skeleton_new();
-    qemu_add_led_event_handler(dbus_kbd_qemu_leds_updated, ddc);
+    ddc->led_notifier.notify = dbus_kbd_qemu_leds_updated;
+    qemu_input_led_notifier_add(&ddc->led_notifier);
     g_object_connect(ddc->iface_kbd,
         "swapped-signal::handle-press", dbus_kbd_press, ddc,
         "swapped-signal::handle-release", dbus_kbd_release, ddc,

-- 
2.54.0


