Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25248C02196
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 12:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tew1f-0006CU-6w; Mon, 03 Feb 2025 07:58:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tew1b-00065F-2t
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 07:58:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tew1Z-0006oM-E2
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 07:58:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738587480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J+zgXfsmij6i3CLkjUbWumZkTeNWh/0pkGCgM9POXrM=;
 b=Q41gYD4h3/5UpAWAwXMwgTxVDx23XBF893khsE0XBDuYz+u413TyHdRRY+yEZeDqoOiRDj
 IKtxsSH3SOvD4X3rYa8YzE5EcQiOtXw+4m3hZ7mLNtae7PErgcE10OoLKGS5EtNJUkerfv
 XcIxrac6nYuLIBwD35AJqgm02LHL3zI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-7hiy8WZ-P7ayu0A21W5zMg-1; Mon,
 03 Feb 2025 07:57:58 -0500
X-MC-Unique: 7hiy8WZ-P7ayu0A21W5zMg-1
X-Mimecast-MFC-AGG-ID: 7hiy8WZ-P7ayu0A21W5zMg
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 310A91800378; Mon,  3 Feb 2025 12:57:57 +0000 (UTC)
Received: from localhost (unknown [10.39.208.25])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9D3BB1800360; Mon,  3 Feb 2025 12:57:55 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, peter.maydell@linaro.org,
 Gerd Hoffmann <kraxel@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 5/8] ui/dbus: on win32, allow ANONYMOUS with p2p
Date: Mon,  3 Feb 2025 16:57:17 +0400
Message-ID: <20250203125721.640451-6-marcandre.lureau@redhat.com>
In-Reply-To: <20250203125721.640451-1-marcandre.lureau@redhat.com>
References: <20250203125721.640451-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Marc-André Lureau <marcandre.lureau@redhat.com>

GLib doesn't implement EXTERNAL on win32 at the moment, and disables
ANONYMOUS by default. zbus dropped support for COOKIE_SHA1 in 5.0,
making it no longer possible to connect to qemu -display dbus.

Since p2p connections are gated by existing QMP (or a D-Bus connection),
qemu -display dbus p2p can accept authentication with ANONYMOUS.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/dbusaudio.c |  8 +++++++-
 ui/dbus-console.c |  8 +++++++-
 ui/dbus.c         | 10 ++++++++--
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
index 095e739382..af77e7cc33 100644
--- a/audio/dbusaudio.c
+++ b/audio/dbusaudio.c
@@ -524,11 +524,17 @@ dbus_audio_register_listener(AudioState *s,
             );
     }
 
+    GDBusConnectionFlags flags =
+        G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_SERVER;
+#ifdef WIN32
+    flags |= G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_ALLOW_ANONYMOUS;
+#endif
+
     listener_conn =
         g_dbus_connection_new_sync(
             G_IO_STREAM(socket_conn),
             guid,
-            G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_SERVER,
+            flags,
             NULL, NULL, &err);
     if (err) {
         error_report("Failed to setup peer connection: %s", err->message);
diff --git a/ui/dbus-console.c b/ui/dbus-console.c
index 5eb1d40d16..85e215ef23 100644
--- a/ui/dbus-console.c
+++ b/ui/dbus-console.c
@@ -305,10 +305,16 @@ dbus_console_register_listener(DBusDisplayConsole *ddc,
 #endif
     );
 
+    GDBusConnectionFlags flags =
+        G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_SERVER;
+#ifdef WIN32
+    flags |= G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_ALLOW_ANONYMOUS;
+#endif
+
     listener_conn = g_dbus_connection_new_sync(
         G_IO_STREAM(socket_conn),
         guid,
-        G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_SERVER,
+        flags,
         NULL, NULL, &err);
     if (err) {
         error_report("Failed to setup peer connection: %s", err->message);
diff --git a/ui/dbus.c b/ui/dbus.c
index 7b258c6823..2eb03aa247 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -317,11 +317,17 @@ dbus_display_add_client(int csock, Error **errp)
     conn = g_socket_connection_factory_create_connection(socket);
 
     dbus_display->add_client_cancellable = g_cancellable_new();
+    GDBusConnectionFlags flags =
+        G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_SERVER |
+        G_DBUS_CONNECTION_FLAGS_DELAY_MESSAGE_PROCESSING;
+
+#ifdef WIN32
+    flags |= G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_ALLOW_ANONYMOUS;
+#endif
 
     g_dbus_connection_new(G_IO_STREAM(conn),
                           guid,
-                          G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_SERVER |
-                          G_DBUS_CONNECTION_FLAGS_DELAY_MESSAGE_PROCESSING,
+                          flags,
                           NULL,
                           dbus_display->add_client_cancellable,
                           dbus_display_add_client_ready,
-- 
2.47.0


