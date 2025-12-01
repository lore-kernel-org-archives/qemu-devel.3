Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AC1D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 11:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ21F-0001DD-Oa; Mon, 01 Dec 2025 06:24:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ21E-0001Cc-H8
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:24:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ21C-0006b7-Pd
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:24:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764588274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g+OW/DPD4MLSKrF9wdP7p/as6/OerG5A2lPxhjUVmGM=;
 b=jOePC6R2nyfHJMRr9mGdknC88ZCKFFEJCryD3BAcHaRXM7yn2ogRzNnQbI4RzXNKB7QdXB
 vWOiKwli6Lj2MQVc9zsdp1SYdaLDqe2Z+90IaAZO0pxLXMNyW5pHCaY+YzfeWPMxMh0X8M
 NZtzKt18EQpsEJSJpbaxxLXl5TNSoo8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-bx10GkvtMFq_534SB5yHIA-1; Mon,
 01 Dec 2025 06:24:30 -0500
X-MC-Unique: bx10GkvtMFq_534SB5yHIA-1
X-Mimecast-MFC-AGG-ID: bx10GkvtMFq_534SB5yHIA_1764588269
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5642A193531C; Mon,  1 Dec 2025 11:24:22 +0000 (UTC)
Received: from localhost (unknown [10.45.242.40])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E3D501800451; Mon,  1 Dec 2025 11:24:20 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Ratchov <alex@caoua.org>, dirty.ice.hu@gmail.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [RFC 10/24] audio: lookup "audio-" object types, and realize them
Date: Mon,  1 Dec 2025 15:22:51 +0400
Message-ID: <20251201112309.4163921-11-marcandre.lureau@redhat.com>
In-Reply-To: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Now "audio_driver" is a detail implementation of AudioBEDriver and not
required to implement an AudioBE.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qemu/audio.h |  1 +
 audio/audio.c        | 38 +++++++++++++++++++++++++-------------
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/include/qemu/audio.h b/include/qemu/audio.h
index f83f8326ab..3abf1037f8 100644
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
index 1693563c62..31459f9707 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1563,23 +1563,15 @@ size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
     return total;
 }
 
-static AudioBackend *audio_be_new(Audiodev *dev, Error **errp)
+static bool audio_be_driver_realize(AudioBackend *abe, Audiodev *dev, Error **errp)
 {
-    const char *drvname = AudiodevDriver_str(dev->driver);
-    struct audio_driver *drv = audio_driver_lookup(drvname);
-
-    if (!drv) {
-        error_setg(errp, "Unknown audio driver `%s'", drvname);
-        return NULL;
-    }
+    AudioDriver *d = AUDIO_DRIVER(abe);
+    audio_driver *drv = AUDIO_DRIVER_GET_CLASS(d)->driver;
 
-    AudioDriver *d = AUDIO_DRIVER(object_new(TYPE_AUDIO_DRIVER));
     d->dev = dev;
-
     d->drv_opaque = drv->init(d->dev, errp);
     if (!d->drv_opaque) {
-        object_unref(OBJECT(d));
-        return NULL;
+        return false;
     }
 
     if (!drv->pcm_ops->get_buffer_in) {
@@ -1601,7 +1593,26 @@ static AudioBackend *audio_be_new(Audiodev *dev, Error **errp)
         d->period_ticks = d->dev->timer_period * (int64_t)SCALE_US;
     }
 
-    return AUDIO_BACKEND(d);
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
@@ -1645,6 +1656,7 @@ static void audio_driver_class_init(ObjectClass *klass, const void *data)
 {
     AudioBackendClass *be = AUDIO_BACKEND_CLASS(klass);
 
+    be->realize = audio_be_driver_realize;
     be->get_id = audio_driver_get_id;
 }
 
-- 
2.51.1


