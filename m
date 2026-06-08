Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D9A9CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWUFB-0007nh-Lo; Mon, 08 Jun 2026 03:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUEm-0007gM-Jg
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:17:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUEl-0008Nh-6j
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780903050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DOjU7ZjMAYNrPdzfVJfpX0bL2ueI8lFCf1IxrYK8dts=;
 b=A6YekPPXfOLude9GS8HJI7kGi4kDfYxM7jluR+l8K2GG/l73ywq0ffkgJF0LWT/npCWAIv
 VuRLh06o8SfK0AQo/VWXYXWXb08bANmxgg4tm8dhkEo/s0EDGqm6wMQuhQ00aQUwq6tlFo
 SdibzaC7NxA76H0hVfjEFQtZIavPvRY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-b6NFnMypNNOmsCIqdCPjLw-1; Mon,
 08 Jun 2026 03:17:24 -0400
X-MC-Unique: b6NFnMypNNOmsCIqdCPjLw-1
X-Mimecast-MFC-AGG-ID: b6NFnMypNNOmsCIqdCPjLw_1780903043
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDBA019560AD; Mon,  8 Jun 2026 07:17:22 +0000 (UTC)
Received: from localhost (unknown [10.44.22.16])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 912A53008B34; Mon,  8 Jun 2026 07:17:21 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 08 Jun 2026 11:16:26 +0400
Subject: [PATCH v2 08/33] ui/dbus: remove led handler
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-b4-ui-v2-8-9ea6355ea08f@redhat.com>
References: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
In-Reply-To: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1483;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+82NOsZ1jlUmr+T1iW5y0vRxBq55sNlfByeJ2Cau8Ao=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqJmxJro/3r2JjC+vwF3fMwq+/hYazX+EcO0NKF
 ImCJQOLQdGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiZsSQAKCRDa6OEJdZac
 5WlnD/9fPasUH/wqZwB5FZgyVigLXEuDVdFF0yZI8rKi1zUqLCT0cxYqVV/MCzVbu7MxSUUZeuj
 7M+CjPYHDlro3XzZsewoJjb9PB35bLWd4D5Y201SMI4d36OvpUMgCjJvs4kujzLNiqH9iSrlmxK
 Vu2YMVK2vtw5CY03cByNJ1b3TfujsyoJrrm6auy63+jdOLlGwKRzhPz7uFPXDEh6BmviDVn49Ax
 GIBfC3thF/NGdkUDlaNKZzgNEvEpoRWVRBdJTz7B9L6RgLJcgWWNzH4lN0FQKhgJLm0fe1F46Mz
 GjZttcnGeq1qILmWVuxNNk0p1sTbPhocRUWn9QfPr9pAnb7FcNG2DoxzGVaA55XsY6YSEKVvjsU
 5/IpA1fGg566HeltkRBmxBkCuh9Ty+tuh5H47RZ5ZvGBnVrG1r0fWFLxKGv+svfaLAV5baOyHek
 o6z14M9mbKTjHoOv2tfllgDhw52an4oS/Jjiks/9/0m6OuWJsvriJKjubyo6QaeYD6ADVEWSl4S
 b50BgIJ3QRocZfOMpDKBPMHhwJ9JUmFZBDkqdATOOuxeV2zbuH/gpxlR6fMwri0kHPNdAa9kO4O
 1reB1MPRPuTljGgiRpBCJSIlcZjZx6pwc0uoPwK1FbbkxYDwGw0fsdIxwjpPlYiy5A4Iuzrx2pW
 MaRnL9KSIpZhZPA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-console.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/ui/dbus-console.c b/ui/dbus-console.c
index 0813a08f85e..f784ccbe572 100644
--- a/ui/dbus-console.c
+++ b/ui/dbus-console.c
@@ -53,6 +53,7 @@ struct _DBusDisplayConsole {
     guint last_x;
     guint last_y;
     Notifier mouse_mode_notifier;
+    QEMUPutLEDEntry *kbd_leds_updated;
 };
 
 G_DEFINE_TYPE(DBusDisplayConsole,
@@ -152,6 +153,7 @@ dbus_display_console_dispose(GObject *object)
 
     qemu_console_unregister_listener(&ddc->dcl);
     qemu_remove_mouse_mode_change_notifier(&ddc->mouse_mode_notifier);
+    qemu_remove_led_event_handler(ddc->kbd_leds_updated);
     g_clear_object(&ddc->iface_touch);
     g_clear_object(&ddc->iface_mouse);
     g_clear_object(&ddc->iface_kbd);
@@ -578,7 +580,8 @@ dbus_display_console_new(DBusDisplay *display, QemuConsole *con)
 
     ddc->kbd = qkbd_state_init(con);
     ddc->iface_kbd = qemu_dbus_display1_keyboard_skeleton_new();
-    qemu_add_led_event_handler(dbus_kbd_qemu_leds_updated, ddc);
+    ddc->kbd_leds_updated = qemu_add_led_event_handler(
+        dbus_kbd_qemu_leds_updated, ddc);
     g_object_connect(ddc->iface_kbd,
         "swapped-signal::handle-press", dbus_kbd_press, ddc,
         "swapped-signal::handle-release", dbus_kbd_release, ddc,

-- 
2.54.0


