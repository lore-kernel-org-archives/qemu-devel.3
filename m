Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E78D111A8
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 11:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ20w-0000Ab-EM; Mon, 01 Dec 2025 06:24:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ20j-00008X-KN
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:24:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ20M-0006W0-JD
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:23:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764588220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+0ReVlWAGq/byZzHvgrljOfsskjahcJZfgv9MIK+QHE=;
 b=L+dfvYApSE6oTf6c5SHWuMtXo41xCu3TwvQnjMAeIP1y58juVTGHpxRaDMA1gByZUwF0Ln
 LuF4McryGc+eKZ0W4C9qw1SbdwXXf7xoYBVojXrmcbbCKKf8cd565L7fmyybUHxP3TyCPH
 H2ET3yk42u4TUoXD0JOKkiRMYqLKJwo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-HzKLxrWhN8iTJr-Des36Iw-1; Mon,
 01 Dec 2025 06:23:37 -0500
X-MC-Unique: HzKLxrWhN8iTJr-Des36Iw-1
X-Mimecast-MFC-AGG-ID: HzKLxrWhN8iTJr-Des36Iw_1764588216
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 317BC1800342; Mon,  1 Dec 2025 11:23:36 +0000 (UTC)
Received: from localhost (unknown [10.45.242.40])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BDE50180047F; Mon,  1 Dec 2025 11:23:34 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Ratchov <alex@caoua.org>, dirty.ice.hu@gmail.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [RFC 03/24] audio/dbus: make "dbus" the default backend when using
 -display dbus
Date: Mon,  1 Dec 2025 15:22:44 +0400
Message-ID: <20251201112309.4163921-4-marcandre.lureau@redhat.com>
In-Reply-To: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Set "using_dbus_display" during early_dbus_init(), so that we can try to
create the "dbus" audio backend by default from audio_prio_list.

This makes dbus audio work by default when using an audio device,
without having to setup and wire up the -audiodev manually.

The added FIXME is addressed in the following commits.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio.c     |  3 +++
 audio/dbusaudio.c |  8 +++++++-
 ui/dbus.c         | 17 +++++++++++++----
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 86e674410a..0f992a775c 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -57,6 +57,9 @@
     that we generate the list.
 */
 const char *audio_prio_list[] = {
+#ifdef CONFIG_GIO
+    "dbus",
+#endif
     "spice",
     CONFIG_AUDIO_DRIVERS
     "none",
diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
index d729a810aa..1fe7c4ed64 100644
--- a/audio/dbusaudio.c
+++ b/audio/dbusaudio.c
@@ -32,6 +32,7 @@
 #endif
 
 #include "ui/dbus.h"
+#include "ui/dbus-display.h"
 #include "ui/dbus-display1.h"
 
 #define AUDIO_CAP "dbus"
@@ -408,8 +409,13 @@ dbus_enable_in(HWVoiceIn *hw, bool enable)
 static void *
 dbus_audio_init(Audiodev *dev, Error **errp)
 {
-    DBusAudio *da = g_new0(DBusAudio, 1);
+    DBusAudio *da;
 
+    if (!qemu_using_dbus_display(errp)) {
+        return NULL;
+    }
+
+    da = g_new0(DBusAudio, 1);
     da->dev = dev;
     da->out_listeners = g_hash_table_new_full(g_str_hash, g_str_equal,
                                                 g_free, g_object_unref);
diff --git a/ui/dbus.c b/ui/dbus.c
index d2dff33258..45fb3c1aa3 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -35,6 +35,7 @@
 #include "ui/egl-context.h"
 #endif
 #include "qemu/audio.h"
+#include "audio/audio_int.h" /* FIXME: use QOM dynamic cast instead of drv->name */
 #include "qapi/error.h"
 #include "trace.h"
 
@@ -218,12 +219,20 @@ dbus_display_complete(UserCreatable *uc, Error **errp)
         return;
     }
 
+    AudioBackend *audio_be = audio_get_default_audio_be(NULL);
+    if (audio_be && !g_str_equal(audio_be->drv->name, "dbus")) {
+        audio_be = NULL;
+    }
     if (dd->audiodev && *dd->audiodev) {
-        AudioBackend *audio_be = audio_be_by_name(dd->audiodev, errp);
-        if (!audio_be || !audio_be_set_dbus_server(audio_be, dd->server, dd->p2p, errp)) {
+        audio_be = audio_be_by_name(dd->audiodev, errp);
+        if (!audio_be) {
             return;
         }
     }
+    if (audio_be && !audio_be_set_dbus_server(audio_be, dd->server, dd->p2p, errp)) {
+        return;
+    }
+
 
     consoles = g_array_new(FALSE, FALSE, sizeof(guint32));
     for (idx = 0;; idx++) {
@@ -475,6 +484,8 @@ early_dbus_init(DisplayOptions *opts)
 #endif
     }
 
+    using_dbus_display = 1;
+
     type_register_static(&dbus_vc_type_info);
 }
 
@@ -488,8 +499,6 @@ dbus_init(DisplayState *ds, DisplayOptions *opts)
         exit(1);
     }
 
-    using_dbus_display = 1;
-
     object_new_with_props(TYPE_DBUS_DISPLAY,
                           object_get_objects_root(),
                           "dbus-display", &error_fatal,
-- 
2.51.1


