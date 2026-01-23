Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BACD72347
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 07:59:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjByK-00063Z-CG; Fri, 23 Jan 2026 02:52:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vjBxr-0005a4-1N
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 02:52:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vjBxp-0002DS-7y
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 02:52:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769154736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DvuHOndliJPYrPOc08eYB57IW0vT7Xdir2dhvIhYl9g=;
 b=Oqmf/PLR/Oiz2iLycUxeqExtmV0h8jzMMhhfUt2Xw+mdN1PWXidQdSWFMB502vq85UlRTm
 w4w7KhjtP2SHnibzTv5Voit8gryYGxyhRO4FbGlQRC0CzRqi7Qo+XcNqqNzkpLhoagXuZz
 BG76fn+jHGj5BNAjG9NYlCaZwkVM/Gc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-4RD-3O_SMh-yoMKMNhNIqg-1; Fri,
 23 Jan 2026 02:52:12 -0500
X-MC-Unique: 4RD-3O_SMh-yoMKMNhNIqg-1
X-Mimecast-MFC-AGG-ID: 4RD-3O_SMh-yoMKMNhNIqg_1769154732
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED1BD1955DA7; Fri, 23 Jan 2026 07:52:11 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D33BE18004D8; Fri, 23 Jan 2026 07:52:09 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 23/37] audio: lookup "audio-" object types, and realize them
Date: Fri, 23 Jan 2026 11:49:26 +0400
Message-ID: <20260123074945.2563196-24-marcandre.lureau@redhat.com>
In-Reply-To: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Now "audio_driver" is a detail implementation of AudioMixengBackend and
not required to implement an AudioBackend.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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
index 7e23a63d401..f6896229cfb 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1561,24 +1561,16 @@ size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
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
@@ -1600,7 +1592,26 @@ static AudioBackend *audio_be_new(Audiodev *dev, Error **errp)
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
@@ -1643,6 +1654,7 @@ static void audio_mixeng_backend_class_init(ObjectClass *klass, const void *data
 {
     AudioBackendClass *be = AUDIO_BACKEND_CLASS(klass);
 
+    be->realize = audio_mixeng_backend_realize;
     be->get_id = audio_mixeng_backend_get_id;
 }
 
-- 
2.52.0


