Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D245FCD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWxYu-00053Q-G6; Tue, 09 Jun 2026 10:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWxYs-0004n7-Gk
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:36:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWxYq-0007Xu-6i
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781015771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qx38nzR7RAS4RV+BWU9P9B+GDyhdYUd+EO5NmH4hnuA=;
 b=CynJf/H/ohgY1WLhHpA6bmdiwQdsj+GLtJJOkRTLuBI+ag97OpuxQi6ukgDXZUlN5zRWXR
 QSuDKyY1BpjkCm7m1necS4jS3vEtFbzeZJwuFz1zD7rPQOGvKdYjHVS4FhdWhfJZL4Moxw
 CyChP2CXAdb5Pdk/Cjsbdv2dIWB+GDU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-gDve1isCN9u-96MgcTDWew-1; Tue,
 09 Jun 2026 10:36:09 -0400
X-MC-Unique: gDve1isCN9u-96MgcTDWew-1
X-Mimecast-MFC-AGG-ID: gDve1isCN9u-96MgcTDWew_1781015768
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17D12185CEB0; Tue,  9 Jun 2026 14:36:08 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 302271800480; Tue,  9 Jun 2026 14:36:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 09 Jun 2026 18:34:35 +0400
Subject: [PATCH 16/17] ui/dbus: switch LED handling to Notifier-based input API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260609-ui-input-v1-16-42615deb818e@redhat.com>
References: <20260609-ui-input-v1-0-42615deb818e@redhat.com>
In-Reply-To: <20260609-ui-input-v1-0-42615deb818e@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1963;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2C4B4AqpW8MpGJ6frIAWY552nHkk+HJpvh9goLxBKjs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKCR5RjtCYokON6pZ4rjpYwMTDSoK7yMMPSgDB
 gCu6AZ2YDiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaigkeQAKCRDa6OEJdZac
 5ctnD/9TqCsJFVj6zplky58v6wEtBZG5xikLqDA/0GWtfCNz9VnLETrkA3SYS9dtiWgfc96k5ad
 MvGyjc7MFJpZ2vJtWbaNg2iDQ2G3p0GbLRAU9tnSJHrYKSpHh66A73d9n8Cwx+Z/aOrwWEzk2RR
 LcAUaGMXOS0Zq05lcjaq9KGTXdmI2gOFwaMBN+9NMXLKQHPQ8PCcVDiMRqov40Q0QA+eiunz3gV
 q+ITqRyZC4WM2MczhPgjSbWqMm4soEqlxNo1pN5Yf+/kvlfCoyLnCi9xtY958HCHYej1+eREeB5
 qBtgxvw4T3KMUnrBV1N6PSoCMaSqyUG+0jsJzCumAIukCKzgZRSVCzZtjS0+q9dD7wAwYU06tKK
 p7UFA8oGHUu2g7ssyX3Q2vI0bVs1bx8WFqx2pnwcvesUdyY15X4AOOcnB59ka3GCddawQ/AqAbi
 7EwGUAgAkVY8tYXZ53BsSop04NebpWlISpf78/FuXsBsbpTtgav0tGHmbkinyBLxh8o39tQ7WvO
 +E3M61V9/fS0n6DUj9wYiWiKiGdltOJKu1Cwr+M24EyfmkthFXHSBDz2g+fRS9W5x4WVtsMa+gI
 tjQD4LkKYo2PrqGST/SqFpc55VKJyLPVlO9Rda8Ev4AE+FpD7yWI2BDaOP3BBNuRe32oaPl7JT5
 6faMZAOyKkUCXew==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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


