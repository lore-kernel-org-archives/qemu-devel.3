Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D70DE7BD8A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 10:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrw4W-0001yw-VE; Mon, 16 Feb 2026 05:43:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrw4F-0001rX-6e
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:43:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrw4B-00010D-4J
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:43:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771238576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TQTKsJe+H0JmAEbmIdQJvVw5lqnUUPR6AFifO+6umuY=;
 b=crpxsER1bFNPHN3zvZSGL7LO4T/ImhutjN8kvegPunx4NlKeuAoAWy0HwizmnSHEEwut9m
 TfHETPZ20dqtSQPUqVkFbeHqG5xJ4X33LQKgZ/vBEY02hfQfOldu6Hjh/PMCrD75v5MNPQ
 oDiUy/sQwXNnhoUtuar1uX9m7O1oFdA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-SXMw1KXdPc2cPPzGTl4RVA-1; Mon,
 16 Feb 2026 05:42:52 -0500
X-MC-Unique: SXMw1KXdPc2cPPzGTl4RVA-1
X-Mimecast-MFC-AGG-ID: SXMw1KXdPc2cPPzGTl4RVA_1771238570
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D81511955D8B; Mon, 16 Feb 2026 10:42:49 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9DA231800464; Mon, 16 Feb 2026 10:42:47 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 11:42:16 +0100
Subject: [PATCH 04/85] audio/dbus: make "dbus" the default backend when
 using -display dbus
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-4-edcb25699381@redhat.com>
References: <20260216-audio-v1-0-edcb25699381@redhat.com>
In-Reply-To: <20260216-audio-v1-0-edcb25699381@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3368;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=i0hZV7AIfgA8SuFqO30DlmD20T1D7KstDiHR2TRDsyg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvSTDaBeOarKtQb/e+z8GAIX3xq6nru0YkWgv
 K8KfVYKKg6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL0kwAKCRDa6OEJdZac
 5YvtD/9EYxYxrAw3wrbHnG1FN7/B+BYmBhU8F/1AgWo85WfTJonNupBc4z3teykE2YpwHNvQ32b
 el8efRcYavgibMitmy/ffURLDKvDVH2ctbJ5qql4prRjiZSKIrD5qLtTVFT23YHoy5vu/NpIFDu
 Rc7ZP/2omTe0veZVgYISZ3b+1yMFATawB727eo5/L8tPfkTeSa9gsQ08uM3N3Aw3Ykf/M2NEQEs
 iUCdfoQfd4Oiqyc55Lrn8FXfiZGtbPaUbj0zdPrZIT60LHj2CMtP622JYqNiJAitsrV11ugPv1n
 gtq0Y6U8ixeiuWZBXMuM8+OPWSRdfSTcq/+B3WiRmoGQZNFgqEl3NAuV5/L/6oo8L2Gr87rw/1d
 3zBHS1LgvHKP538d3Ek5CUZT8/SS0A3c3TT12INxCjfA3ZJLCe5Gat3l1t2yJD0K0eWr/F5lLgP
 K/4DlRyjkaBJ+CuWC3xxwmtsiJM84tMTmHHX6ejqi5RnGHvstOP26+vzlX+H2cFh9IaJYE952y4
 lDO/OSrcUBFYndHmFzqmfHlM+OBHqTnXEYfDIi9cOUo73Kbfomkx+2AVtyjt1H5Pj+O3XKujmk+
 z3VtwzFPEXuF9yuc/IkvBbXPRJ5ChSO6P3CRxGse/r0qZU36yE74ksMs4dA3lwHATeKFDU7fuse
 0a2TQC5mRZDLUAQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Set "using_dbus_display" during early_dbus_init(), so that we can try to
create the "dbus" audio backend by default from audio_prio_list.

This makes dbus audio work by default when using an audio device,
without having to setup and wire up the -audiodev manually.

The added FIXME is addressed in the following commits.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 audio/audio.c     |  3 +++
 audio/dbusaudio.c |  8 +++++++-
 ui/dbus.c         | 22 +++++++++++++++++-----
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index a218570a4f4..9563583cd1e 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -58,6 +58,9 @@
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
index d729a810aa6..1fe7c4ed647 100644
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
index 31f6eb1189f..0be1931d208 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -35,6 +35,7 @@
 #include "ui/egl-context.h"
 #endif
 #include "qemu/audio.h"
+#include "audio/audio_int.h" /* FIXME: use QOM dynamic cast instead of drv->name */
 #include "qapi/error.h"
 #include "trace.h"
 
@@ -218,9 +219,20 @@ dbus_display_complete(UserCreatable *uc, Error **errp)
         return;
     }
 
-    if (dd->audiodev && *dd->audiodev) {
-        AudioBackend *audio_be = audio_be_by_name(dd->audiodev, errp);
-        if (!audio_be || !audio_be_set_dbus_server(audio_be, dd->server, dd->p2p, errp)) {
+    {
+        AudioBackend *audio_be = audio_get_default_audio_be(NULL);
+
+        if (audio_be && !g_str_equal(audio_be->drv->name, "dbus")) {
+            audio_be = NULL;
+        }
+        if (dd->audiodev && *dd->audiodev) {
+            audio_be = audio_be_by_name(dd->audiodev, errp);
+            if (!audio_be) {
+                return;
+            }
+        }
+        if (audio_be &&
+            !audio_be_set_dbus_server(audio_be, dd->server, dd->p2p, errp)) {
             return;
         }
     }
@@ -475,6 +487,8 @@ early_dbus_init(DisplayOptions *opts)
 #endif
     }
 
+    using_dbus_display = 1;
+
     type_register_static(&dbus_vc_type_info);
 }
 
@@ -488,8 +502,6 @@ dbus_init(DisplayState *ds, DisplayOptions *opts)
         exit(1);
     }
 
-    using_dbus_display = 1;
-
     object_new_with_props(TYPE_DBUS_DISPLAY,
                           object_get_objects_root(),
                           "dbus-display", &error_fatal,

-- 
2.53.0


