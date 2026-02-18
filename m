Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B56FE9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 09:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsdUb-0003CY-UQ; Wed, 18 Feb 2026 04:05:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdUG-0002lU-E7
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:04:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdUE-000074-BB
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:04:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771405485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6n0Nw4IjvpoGYNAliP9f9QdpiSJbuthryuT9oA6KUP4=;
 b=gA9TI/Lg/sN/KWK123MzgCjSmzhW7oE9Ao7v1DQ6YYYt53f/UwZCFTewVGfV0RH0HjucSJ
 dPCl+jTX7oHhllVLbigIQVQpfdeldMrS+qwQr/T6dG+/mLmPIIbvFB8Fqbpcf6I5uMogZd
 fjxBKzqweevMNbNmMoD3rRoqjD2eLW8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-2PbopVKnNxGPK66rUM-Hew-1; Wed,
 18 Feb 2026 04:04:41 -0500
X-MC-Unique: 2PbopVKnNxGPK66rUM-Hew-1
X-Mimecast-MFC-AGG-ID: 2PbopVKnNxGPK66rUM-Hew_1771405480
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A99621955D8B; Wed, 18 Feb 2026 09:04:40 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D60BD180066F; Wed, 18 Feb 2026 09:04:39 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 23/85] audio: move object creation to audio_driver_init()
Date: Wed, 18 Feb 2026 10:02:23 +0100
Message-ID: <20260218090330.1476169-24-marcandre.lureau@redhat.com>
In-Reply-To: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
References: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
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
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

As we will allow other kind of AudioBackend objects to be instantiated,
move the object allocation to a audio_driver_init() and rename it
audio_be_new().

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio.c | 65 +++++++++++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 31 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 10e32bcbb1a..3e1cd988852 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1562,19 +1562,24 @@ size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
     return total;
 }
 
-static bool audio_driver_do_init(AudioMixengBackend *d, Error **errp)
+static AudioBackend *audio_be_new(Audiodev *dev, Error **errp)
 {
-    const char *drvname = AudiodevDriver_str(d->dev->driver);
+    const char *drvname = AudiodevDriver_str(dev->driver);
     struct audio_driver *drv = audio_driver_lookup(drvname);
 
     if (!drv) {
         error_setg(errp, "Unknown audio driver `%s'", drvname);
-        return false;
+        qapi_free_Audiodev(dev);
+        return NULL;
     }
 
-    d->drv_opaque = drv->init(d->dev, errp);
-    if (!d->drv_opaque) {
-        return false;
+    AudioMixengBackend *be = AUDIO_MIXENG_BACKEND(object_new(TYPE_AUDIO_MIXENG_BACKEND));
+    be->dev = dev;
+
+    be->drv_opaque = drv->init(be->dev, errp);
+    if (!be->drv_opaque) {
+        object_unref(OBJECT(be));
+        return NULL;
     }
 
     if (!drv->pcm_ops->get_buffer_in) {
@@ -1586,17 +1591,17 @@ static bool audio_driver_do_init(AudioMixengBackend *d, Error **errp)
         drv->pcm_ops->put_buffer_out = audio_generic_put_buffer_out;
     }
 
-    audio_init_nb_voices_out(d, drv, 1);
-    audio_init_nb_voices_in(d, drv, 0);
-    d->drv = drv;
+    audio_init_nb_voices_out(be, drv, 1);
+    audio_init_nb_voices_in(be, drv, 0);
+    be->drv = drv;
 
-    if (d->dev->timer_period <= 0) {
-        d->period_ticks = 1;
+    if (be->dev->timer_period <= 0) {
+        be->period_ticks = 1;
     } else {
-        d->period_ticks = d->dev->timer_period * (int64_t)SCALE_US;
+        be->period_ticks = be->dev->timer_period * (int64_t)SCALE_US;
     }
 
-    return true;
+    return AUDIO_BACKEND(be);
 }
 
 static void audio_vm_change_state_handler (void *opaque, bool running,
@@ -1793,41 +1798,39 @@ void audio_create_default_audiodevs(void)
  */
 static AudioBackend *audio_init(Audiodev *dev, Error **errp)
 {
-    AudioMixengBackend *d;
+    AudioBackend *be;
 
-    d = AUDIO_MIXENG_BACKEND(object_new(TYPE_AUDIO_MIXENG_BACKEND));
-    d->dev = dev;
-    if (d->dev) {
-        if (!audio_driver_do_init(d, errp)) {
-            goto out;
+    if (dev) {
+        be = audio_be_new(dev, errp);
+        if (!be) {
+            return NULL;
         }
     } else {
         assert(!default_audio_be);
         for (;;) {
             AudiodevListEntry *e = QSIMPLEQ_FIRST(&default_audiodevs);
+
             if (!e) {
                 error_setg(errp, "no default audio driver available");
-                goto out;
+                return NULL;
             }
-            d->dev = e->dev;
+            dev = e->dev;
             QSIMPLEQ_REMOVE_HEAD(&default_audiodevs, next);
             g_free(e);
-            if (audio_driver_do_init(d, NULL)) {
+            be = audio_be_new(dev, NULL);
+            if (be) {
                 break;
             }
         }
     }
 
     if (!object_property_try_add_child(get_audiodevs_root(),
-                                       d->dev->id, OBJECT(d), errp)) {
-        goto out;
+                                       audio_be_get_id(be), OBJECT(be), errp)) {
+        object_unref(be);
+        return NULL;
     }
-    object_unref(d);
-    return AUDIO_BACKEND(d);
-
-out:
-    object_unref(d);
-    return NULL;
+    object_unref(be);
+    return be;
 }
 
 AudioBackend *audio_get_default_audio_be(Error **errp)
@@ -2183,7 +2186,7 @@ void audio_init_audiodevs(void)
     AudiodevListEntry *e;
 
     QSIMPLEQ_FOREACH(e, &audiodevs, next) {
-        audio_init(e->dev, &error_fatal);
+        audio_init(QAPI_CLONE(Audiodev, e->dev), &error_fatal);
     }
 }
 
-- 
2.53.0


