Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10126CD98D4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 09:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXbLH-00017T-3y; Thu, 11 Jun 2026 05:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbL7-0000tB-Pu
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:04:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbL6-0004h3-5q
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781168679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PNF4dBrQupDS+BQkGMmXzc/jIpRKvawBFwy1v2uFoyM=;
 b=PqjvLFffgu6jeopy2X+J522q57M/nVxh8B5YuUumlCpqRJTn+/2ithgAP56/bYKxhKv0Qo
 mOjF40pVVTsN6Qyjgy5mspA3/Mf40K0moHVfxrNjidkSRhfJ95ciKOGWOACJH9CTQnBH5C
 rC5zps7+JwId801hKfz+vL90kGS73I8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-EBl_9U2RMMmpxTwmyde7Ww-1; Thu,
 11 Jun 2026 05:04:35 -0400
X-MC-Unique: EBl_9U2RMMmpxTwmyde7Ww-1
X-Mimecast-MFC-AGG-ID: EBl_9U2RMMmpxTwmyde7Ww_1781168674
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEC9C180ACD1; Thu, 11 Jun 2026 09:04:33 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AFBD730A8; Thu, 11 Jun 2026 09:04:32 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jun 2026 13:03:25 +0400
Subject: [PATCH v3 10/35] ui/dbus: remove led handler
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260611-b4-ui-v3-10-72bcbbea0fae@redhat.com>
References: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
In-Reply-To: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1501;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=FpVxxG8nNRmQ0abvxiCSMpev/nXrAIip6WcnPZ/1grM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKnne5ailz8B+fXcBUMbo0OoWi7sWguWSmaswN
 AC2a1+15LyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaip53gAKCRDa6OEJdZac
 5cgiEACeyoI/FWgSw+IkfSt/fs/PVOLM8BtnHP8mjzIHnH2GDM+dbIScEAnq07QeEaxk03fu9xt
 zGt0vxqXnkE8hA0KDJworA4rsJrjX/tR4EB4qGaueU9qWZ4me6lxUHGvxZf0iNEsqNIjcpyXUDk
 jzn44pWgNqEwHV3CRWPranYmr4Bwzyn8FzVAuQnGgK7BS1NDukjDK8mcTIYvHb3mG1EWZmoYmUZ
 juyruMEpQ/pcb/+SBHzzolAV2VqrS7Y7yNtcO0VyoVN75oD0TCCkMMDxPy5hF6YrDZyIgO9bieH
 eXQDHbPjEXuON559DrPS0ulE1IioLUbrnLcc6cHnzifTXCnKEcY/1k2I95PupM53HLPW5wkBnZT
 yXZQeCkk7a2yMhr5YmUmVJ0tqAdDmtpLaDlyM6Mk1TW39OJyXibENzF6v8CJlFzULOi65ntMV03
 d+Gn1bwL/EeAVz2SzoVN+GhYq2wT1SeMcunQlkk9zyuBAx5DDOsIppwZIH6iA+q50O5n5MngNkj
 ZGfPRmNPIkScb0++brlu1alCNMkx4ZtpsNps9K0ayyD1VTCH7iXTHyF4bK+2FZyHkt5TynrZAme
 kui++xFp4g8KnndjSKPAuafOtpwjf/HD+gydD86QvS+GQQNFHEUEasHj5XpFS5z/Rkwou24ENv0
 P7YUxqH/i9TARPQ==
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

Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-console.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/ui/dbus-console.c b/ui/dbus-console.c
index 0813a08f85e..742bf9639a4 100644
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
+    g_clear_pointer(&ddc->kbd_leds_updated, qemu_remove_led_event_handler);
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


