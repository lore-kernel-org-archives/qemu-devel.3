Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10268E7BD92
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwfN-0006Sw-6h; Mon, 16 Feb 2026 06:21:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwbK-0005Z7-6S
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwb6-0007Vx-0b
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fPazC4ZZdFPqExfN3XudQnauOZaANg5Zk51udOOUWKE=;
 b=LIfxTjv3IXSyqSCnewdo2QoviqB+HZIL5k3ucLYUwGB3H613w38UMPnrPyrbPzV0RP0pmF
 fdYQ6iHDlHgrtF+9L8LvxKb3wxPnpnUuPaRfZcRHwBX49pJREsJpXrC/OCwtZXGqCWzNG0
 xUBhI6d/2p4JAoOpnaQrGFMeHfZ1uuM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-Up68Dq7XNzmTVOsVPnoyEA-1; Mon,
 16 Feb 2026 06:16:52 -0500
X-MC-Unique: Up68Dq7XNzmTVOsVPnoyEA-1
X-Mimecast-MFC-AGG-ID: Up68Dq7XNzmTVOsVPnoyEA_1771240610
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 915C41955D8C; Mon, 16 Feb 2026 11:16:50 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F3CD030001A5; Mon, 16 Feb 2026 11:16:49 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:15 +0100
Subject: [PATCH 26/85] audio: lookup "audio-" object types, and realize
 them
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-26-e676662e4514@redhat.com>
References: <20260216-audio-v1-0-e676662e4514@redhat.com>
In-Reply-To: <20260216-audio-v1-0-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3172;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=OJw6jsdt7wyQcbBsg8GjmVtm4QV1qTWG9rTVIVZxcO0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxP8FIJBr3CGLwm9OUTFfNLqhx5FpSXiHdHl
 PQZPf44SeWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8TwAKCRDa6OEJdZac
 5X/zD/0SfbgLLY+P5ZjBjQPEFjax6JUXRGp5ezDTcd2HMi4+O1EAF0XcWKnQQu9TED1z6tWO1VU
 G647nvGnA0gSbEHEU7Wla3ML/S0D+8KDmtxYBwOXcbSbiE0BtTQBUC7H91fqxmPsy5i2qpVmTI8
 FxfVe7BAWq8K7y6KlxMFA9Nf3F8mS+0uVxem/wgTKiTTQauDzyA0watsd6cf1LhhzKgDxSt2Xu7
 /6bKk6fTvQBpAsIUbHr6IeddJcY2gOFfFR9i2TnUHbEqCpaNQUw1QNwrICbweL5nSzVTnLfisk1
 pP8zNnO7zTrCtbfimxyaKp4AAesmgw1Lo6uSM2awJ9BDOXmflHRzyeWw3q7g8lwikj6j4yhsLWh
 V4cd4Anx7aI7G+cKSlW6UkmL8hwCtFHyongTaIKgD+wGOwZA9jQmUeM8SFoEfrXsUXqETobARBT
 /Q4q98+qAb5ZXw82SFikQDxpUNsyLZHVqLo45+GiAK6BNgizejgtrEuV+GTGtIrybA+cTC0j62l
 lj7hvvCOqFzSfmC378fesbTjKdn0jaR8MjvFhe9ePt+DbbhpW/lxzCCtEyIS2iMn5Bzzyj0SM7I
 gPMUDjfA+gNpzVBmfINsB9eNiiiLKON7VZGSHgHMl7lYv0qojE4YeDiPuXuqIPjhtK8gjQ5efg0
 d3LdVD3ZEBlY/cg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Now "audio_driver" is a detail implementation of AudioMixengBackend and
not required to implement an AudioBackend.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/qemu/audio.h |  1 +
 audio/audio.c        | 40 ++++++++++++++++++++++++++--------------
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/include/qemu/audio.h b/include/qemu/audio.h
index 474d761f0be..1eeead2a722 100644
--- a/include/qemu/audio.h
+++ b/include/qemu/audio.h
@@ -51,6 +51,7 @@ typedef struct AudioBackend {
 typedef struct AudioBackendClass {
     ObjectClass parent_class;
 
+    bool (*realize)(AudioBackend *be, Audiodev *dev, Error **errp);
     const char *(*get_id)(AudioBackend *be);
 #ifdef CONFIG_GIO
     bool (*set_dbus_server)(AudioBackend *be,
diff --git a/audio/audio.c b/audio/audio.c
index 5d0f5ad2145..72949fe27f5 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1562,24 +1562,16 @@ size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
     return total;
 }
 
-static AudioBackend *audio_be_new(Audiodev *dev, Error **errp)
+static bool audio_mixeng_backend_realize(AudioBackend *abe,
+                                         Audiodev *dev, Error **errp)
 {
-    const char *drvname = AudiodevDriver_str(dev->driver);
-    struct audio_driver *drv = audio_driver_lookup(drvname);
+    AudioMixengBackend *be = AUDIO_MIXENG_BACKEND(abe);
+    audio_driver *drv = AUDIO_MIXENG_BACKEND_GET_CLASS(be)->driver;
 
-    if (!drv) {
-        error_setg(errp, "Unknown audio driver `%s'", drvname);
-        qapi_free_Audiodev(dev);
-        return NULL;
-    }
-
-    AudioMixengBackend *be = AUDIO_MIXENG_BACKEND(object_new(TYPE_AUDIO_MIXENG_BACKEND));
     be->dev = dev;
-
     be->drv_opaque = drv->init(be->dev, errp);
     if (!be->drv_opaque) {
-        object_unref(OBJECT(be));
-        return NULL;
+        return false;
     }
 
     if (!drv->pcm_ops->get_buffer_in) {
@@ -1601,7 +1593,26 @@ static AudioBackend *audio_be_new(Audiodev *dev, Error **errp)
         be->period_ticks = be->dev->timer_period * (int64_t)SCALE_US;
     }
 
-    return AUDIO_BACKEND(be);
+    return true;
+}
+
+static AudioBackend *audio_be_new(Audiodev *dev, Error **errp)
+{
+    const char *drvname = AudiodevDriver_str(dev->driver);
+    g_autofree char *type = g_strconcat("audio-", drvname, NULL);
+    AudioBackend *be = AUDIO_BACKEND(object_new(type));
+
+    if (!be) {
+        error_setg(errp, "Unknown audio driver `%s'", drvname);
+        return NULL;
+    }
+
+    if (!AUDIO_BACKEND_GET_CLASS(be)->realize(be, dev, errp)) {
+        object_unref(OBJECT(be));
+        return NULL;
+    }
+
+    return be;
 }
 
 static void audio_vm_change_state_handler (void *opaque, bool running,
@@ -1644,6 +1655,7 @@ static void audio_mixeng_backend_class_init(ObjectClass *klass, const void *data
 {
     AudioBackendClass *be = AUDIO_BACKEND_CLASS(klass);
 
+    be->realize = audio_mixeng_backend_realize;
     be->get_id = audio_mixeng_backend_get_id;
 }
 

-- 
2.53.0


