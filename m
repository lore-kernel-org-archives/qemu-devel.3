Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730DBCD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvEw-0005H9-P0; Fri, 29 May 2026 07:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvEk-0004uw-M5
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:18:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvEj-0008Ve-05
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780053524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/45PWJIlvtplfS6tYbvgPglrF3hQ9j7W0s88Nl7Np3I=;
 b=P3iFY3JO2R25qM4u3k/0DFFWCAcyVlW4FBKLbv2g7Jh6DRAcO+vLq38lSwHaSjlCULni73
 GrkuczjS7/rArpQXyRjQPtikHZup6pe9GAtLuyqRy+Sf9qzLA7dEOxjSVgEBnIhs2YEuWn
 uwlq+g07F0zvpS+gRIO33v5o0T9Flms=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-e-anqkd8Pxe3wUdtuW9Ksg-1; Fri,
 29 May 2026 07:18:38 -0400
X-MC-Unique: e-anqkd8Pxe3wUdtuW9Ksg-1
X-Mimecast-MFC-AGG-ID: e-anqkd8Pxe3wUdtuW9Ksg_1780053517
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 323A419560AD; Fri, 29 May 2026 11:18:37 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C43C21800357; Fri, 29 May 2026 11:18:35 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 29 May 2026 15:16:40 +0400
Subject: [PATCH 19/32] ui/dbus: implement display cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260529-b4-ui-v1-19-8db3068421ef@redhat.com>
References: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
In-Reply-To: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1544;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=yhYBT7ch2dihRxPP22Eb7+8NveFD8IZ4MazvCK53hvk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqGXWP8/yYRffcBVNRkiX9ZJIwvcT+nCheAXihm
 G7p0HMUuCCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCahl1jwAKCRDa6OEJdZac
 5WlTD/kBfOlyYHUn9hn9VTCkoIQViLtUODPu9uWa1+6ZdfvQK72Jq58qkDK3i4TZVICuSBaIDAX
 3PfE5GQiNWeVHemPw28Vn340d3EfyjmGs8XlFzRwkCkxiOQLvnAp/WDJFDwnN7RsPa5lWI88arR
 zBs97D9TiPgaY8aJr/53sQkqsJo/uY0bDwEakVu9DftGU6RI4voV4YzDC4063FM3qmSHAgNK0FD
 +TwHWWll8po1CXkkDqXZ017SlFidUK5uMnJ/b7Sr8K9Loqxb3oZjVhCIOPqXg4tMCxE/LETCfWS
 xu7ZbH5R6i5483XPaippeDfx/dPvtVeRaJ/YQ12DwNoGbrM1oQlmyDEWxPjyjkOpjuiifEza7A7
 QwuLUsSJ2sqdDHS2rIgq3Ji4hCURUI8IWZ5zlWWH+t4KmCdeqNncUroGZ/GM/u6klsDQhP3FqKg
 ZFtnhGChbSG8FlCxLLRSb3KrlrBKQjE1UMcP952PChmfnSoE/OOJzcnJER5+3m97WIy+m6qo4MB
 yg2vbE6951KrKYw/IzmdgVXEvRffOE/mUUrHLoCMn3yrqStWKnx8fnsvVWSUf7OEM0c9IXjwOJ6
 gc82/YDwN2YkgSDxEeyP7R/UkhRSsYgic7eb8X+mGujhZknxAq43V6O16/3ixv98UGqibaiyRhP
 KvNsgqIYWk8frqw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

Add dbus_cleanup() to unparent the D-Bus display object, ensuring
proper teardown before user_creatable_cleanup() runs.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-console.c |  3 +++
 ui/dbus.c         | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/ui/dbus-console.c b/ui/dbus-console.c
index 0813a08f85e..0048951a7ab 100644
--- a/ui/dbus-console.c
+++ b/ui/dbus-console.c
@@ -151,6 +151,9 @@ dbus_display_console_dispose(GObject *object)
     DBusDisplayConsole *ddc = DBUS_DISPLAY_CONSOLE(object);
 
     qemu_console_unregister_listener(&ddc->dcl);
+    if (ddc->dcl.con) {
+        qemu_console_set_display_gl_ctx(ddc->dcl.con, NULL);
+    }
     qemu_remove_mouse_mode_change_notifier(&ddc->mouse_mode_notifier);
     g_clear_object(&ddc->iface_touch);
     g_clear_object(&ddc->iface_mouse);
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


