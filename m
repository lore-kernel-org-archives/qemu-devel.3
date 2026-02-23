Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BAE1EA4FC1
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 13:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuWK7-0003p5-Cq; Mon, 23 Feb 2026 08:50:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWIs-0000n0-WC
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:48:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWIr-00075n-EW
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:48:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771854528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6GhijycHKeebI32O4PhP+DIZaklxb5TcF/ISqeLI/T0=;
 b=HYrG9ulqqxWybB2pHrroAR6P3lOEHoRNBi+zMlk74ezHEXBVkYf9oIo/107sIvhdaLHBRs
 +TA4WOaHnjDxIkzRhDtImNnJkCZrH1SPgkB6JPmaudP5imvdrKRp/iCjkEy/+oD2QpudwW
 jMWK5zfkidJKLWXUB0NRHDmk3sQL/w0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-NPpNhE_JO8qtGR1Biz_kDw-1; Mon,
 23 Feb 2026 08:48:45 -0500
X-MC-Unique: NPpNhE_JO8qtGR1Biz_kDw-1
X-Mimecast-MFC-AGG-ID: NPpNhE_JO8qtGR1Biz_kDw_1771854524
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1D2619560AA; Mon, 23 Feb 2026 13:48:44 +0000 (UTC)
Received: from localhost (unknown [10.45.242.25])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CF53F1800351; Mon, 23 Feb 2026 13:48:43 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL v3 26/85] audio: lookup "audio-" object types, and realize them
Date: Mon, 23 Feb 2026 14:46:27 +0100
Message-ID: <20260223134731.2377432-27-marcandre.lureau@redhat.com>
In-Reply-To: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
References: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
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


