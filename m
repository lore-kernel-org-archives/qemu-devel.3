Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D666CD8C92
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWUG5-0002Ci-08; Mon, 08 Jun 2026 03:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUFr-0001Np-BC
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:18:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUFp-0000Sw-IA
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780903116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ylTC7BARlqZ+04IBD49T6S4GmlKV0BK7BLmD7AYS7/w=;
 b=N8xQaoP+M50hSb6FVVYMECcYzYdxWBypl9xrPjKFStrzj8b89FHWMi0l+s/4InsFaFX3Hq
 K5cPjvmWjlCgmPEXiFNQY6T0qGMGiiLNWPPrwbtnowXYbptW9YVj7OIDtM3E/IEB9Z2N5S
 bopb0Wst1viONfsizUw1OGSZAS+eusc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-a8r50Z4LOL2BkaSDLIb6Cg-1; Mon,
 08 Jun 2026 03:18:27 -0400
X-MC-Unique: a8r50Z4LOL2BkaSDLIb6Cg-1
X-Mimecast-MFC-AGG-ID: a8r50Z4LOL2BkaSDLIb6Cg_1780903106
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92E5A1956089; Mon,  8 Jun 2026 07:18:26 +0000 (UTC)
Received: from localhost (unknown [10.44.22.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A8F619560A6; Mon,  8 Jun 2026 07:18:25 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 08 Jun 2026 11:16:38 +0400
Subject: [PATCH v2 20/33] ui/dbus: implement display cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-b4-ui-v2-20-9ea6355ea08f@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1563;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=KjogY/hMAZwWfbbFTG+U8PdOErEGRgvAosOe7XnBmzY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqJmxLZb7Qy9ngLLiTcrLxuOJiz+H6pYVsr2mGO
 B8cdV0FR8KJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiZsSwAKCRDa6OEJdZac
 5W9CEACqvr7Tnypc1K4zHeKg+2/OGDwMAoZb0fIo2RHM9CqX8OKjkk3O5jILOtHl+1vsruWQCFc
 cPiBg6BQqLrDeZD0M2lEcsOqXsFcBM1ERserB+ANE52mDQ5BclALV90GQcsDXuQsW5stF9NsUEN
 wSjnAPdUYGfe9FH7YKt5WLULYGVq9Ia9DiGI4hAR8YPJBtjaMnmQLkodTLgZJTlYrfE7Vk/TOxb
 9MtuaBPtvcn0XQ6v3y0sSzlyc2d8nXToDzwX7qXyHYdjUQvfFUxt5Cso+lsnlOGmgJi22+Jc6E6
 bZxXai+2ddkPpn7gNQU8v225k+6JXKSz3APtd8Gzg0NOu2bOg7J7LLoogRngJUX0Ho+Xe6ra7Cm
 lyIOZpYFUNrlM4d2XLL8JIuQtpdAn3gCz/dMdw7gw3uK+473K0s+okcVYkBipuqvsFNr1n/uQgJ
 +HN8bgs2fb7KwtgxaoJLnCqHk+koYQT3fdKGuatmooIinp2koOA2vOSeiQIMTFPeO8qEsQsuUP7
 t/jou1ezUfaJazgw51xmY+f1y4ukS451rAEwqXA4PtP7kYHOskrUP0UuB6aNLtWy/OvZPrFrSfP
 RtUwcOuMOd2SzfUZUQ2W/b4JaA5ojyW4LZVwt07MkrWZQnvFolsjzI1fXZHSsKQnCQgEffUl2ud
 5wfj2PeNEDSfDZQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

Add dbus_cleanup() to unparent the D-Bus display object, ensuring
proper teardown before user_creatable_cleanup() runs.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-console.c |  3 +++
 ui/dbus.c         | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/ui/dbus-console.c b/ui/dbus-console.c
index f784ccbe572..a4a17f5b4d0 100644
--- a/ui/dbus-console.c
+++ b/ui/dbus-console.c
@@ -152,6 +152,9 @@ dbus_display_console_dispose(GObject *object)
     DBusDisplayConsole *ddc = DBUS_DISPLAY_CONSOLE(object);
 
     qemu_console_unregister_listener(&ddc->dcl);
+    if (ddc->dcl.con) {
+        qemu_console_set_display_gl_ctx(ddc->dcl.con, NULL);
+    }
     qemu_remove_mouse_mode_change_notifier(&ddc->mouse_mode_notifier);
     qemu_remove_led_event_handler(ddc->kbd_leds_updated);
     g_clear_object(&ddc->iface_touch);
diff --git a/ui/dbus.c b/ui/dbus.c
index e02a94df2f3..b23cb44c535 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -615,10 +615,23 @@ static const TypeInfo dbus_display_info = {
     }
 };
 
+static void
+dbus_cleanup(void)
+{
+    Object *o;
+
+    o = object_resolve_path_component(object_get_objects_root(),
+                                      "dbus-display");
+    if (o) {
+        object_unparent(o);
+    }
+}
+
 static QemuDisplay qemu_display_dbus = {
     .type       = DISPLAY_TYPE_DBUS,
     .early_init = early_dbus_init,
     .init       = dbus_init,
+    .cleanup    = dbus_cleanup,
     .vc         = "vc",
 };
 

-- 
2.54.0


