Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E88E9A03E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 09:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsdUW-0002nV-Sh; Wed, 18 Feb 2026 04:05:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdUB-0002c4-Uu
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:04:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdUA-00006p-Aa
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:04:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771405481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=99d2Aunspa8tSdfszEIfDfTDk4GKioE/L+0EPViLRM0=;
 b=ZcB2OxJamJUp2+5lZCg8cIUmtwOwczicpY92U8hd4hGlFze9xCOO/At0S9hu+bJmoFerQ4
 8KSVXEIhy8Q08nDtuMTT3J99isGyd0aKpRpeQBWjwgHuwlpzAllO/IQm5Fa8DY1GxhMs86
 YkY4hXN+X8OKzWfsEc3yoAm2XH6/RFk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-v0J110ggOyuVOZN-IKATyQ-1; Wed,
 18 Feb 2026 04:04:38 -0500
X-MC-Unique: v0J110ggOyuVOZN-IKATyQ-1
X-Mimecast-MFC-AGG-ID: v0J110ggOyuVOZN-IKATyQ_1771405477
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D12818005B7; Wed, 18 Feb 2026 09:04:37 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C4A3F19560AD; Wed, 18 Feb 2026 09:04:36 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 22/85] audio: simplify audio_init()
Date: Wed, 18 Feb 2026 10:02:22 +0100
Message-ID: <20260218090330.1476169-23-marcandre.lureau@redhat.com>
In-Reply-To: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
References: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

Factorize looking up the driver in audio_driver_init()

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio.c | 66 ++++++++++++++++++++++-----------------------------
 1 file changed, 29 insertions(+), 37 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index c4e4adec106..10e32bcbb1a 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1562,11 +1562,18 @@ size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
     return total;
 }
 
-static bool audio_driver_do_init(AudioMixengBackend *s, struct audio_driver *drv,
-                                 Audiodev *dev, Error **errp)
+static bool audio_driver_do_init(AudioMixengBackend *d, Error **errp)
 {
-    s->drv_opaque = drv->init(dev, errp);
-    if (!s->drv_opaque) {
+    const char *drvname = AudiodevDriver_str(d->dev->driver);
+    struct audio_driver *drv = audio_driver_lookup(drvname);
+
+    if (!drv) {
+        error_setg(errp, "Unknown audio driver `%s'", drvname);
+        return false;
+    }
+
+    d->drv_opaque = drv->init(d->dev, errp);
+    if (!d->drv_opaque) {
         return false;
     }
 
@@ -1579,14 +1586,14 @@ static bool audio_driver_do_init(AudioMixengBackend *s, struct audio_driver *drv
         drv->pcm_ops->put_buffer_out = audio_generic_put_buffer_out;
     }
 
-    audio_init_nb_voices_out(s, drv, 1);
-    audio_init_nb_voices_in(s, drv, 0);
-    s->drv = drv;
+    audio_init_nb_voices_out(d, drv, 1);
+    audio_init_nb_voices_in(d, drv, 0);
+    d->drv = drv;
 
-    if (dev->timer_period <= 0) {
-        s->period_ticks = 1;
+    if (d->dev->timer_period <= 0) {
+        d->period_ticks = 1;
     } else {
-        s->period_ticks = dev->timer_period * (int64_t)SCALE_US;
+        d->period_ticks = d->dev->timer_period * (int64_t)SCALE_US;
     }
 
     return true;
@@ -1786,24 +1793,12 @@ void audio_create_default_audiodevs(void)
  */
 static AudioBackend *audio_init(Audiodev *dev, Error **errp)
 {
-    int done = 0;
-    const char *drvname;
-    AudioMixengBackend *s;
-    struct audio_driver *driver;
+    AudioMixengBackend *d;
 
-    s = AUDIO_MIXENG_BACKEND(object_new(TYPE_AUDIO_MIXENG_BACKEND));
-
-    if (dev) {
-        /* -audiodev option */
-        s->dev = dev;
-        drvname = AudiodevDriver_str(dev->driver);
-        driver = audio_driver_lookup(drvname);
-        if (driver) {
-            done = audio_driver_do_init(s, driver, dev, errp);
-        } else {
-            error_setg(errp, "Unknown audio driver `%s'", drvname);
-        }
-        if (!done) {
+    d = AUDIO_MIXENG_BACKEND(object_new(TYPE_AUDIO_MIXENG_BACKEND));
+    d->dev = dev;
+    if (d->dev) {
+        if (!audio_driver_do_init(d, errp)) {
             goto out;
         }
     } else {
@@ -1814,27 +1809,24 @@ static AudioBackend *audio_init(Audiodev *dev, Error **errp)
                 error_setg(errp, "no default audio driver available");
                 goto out;
             }
-            s->dev = dev = e->dev;
+            d->dev = e->dev;
             QSIMPLEQ_REMOVE_HEAD(&default_audiodevs, next);
             g_free(e);
-            drvname = AudiodevDriver_str(dev->driver);
-            driver = audio_driver_lookup(drvname);
-            if (audio_driver_do_init(s, driver, dev, NULL)) {
+            if (audio_driver_do_init(d, NULL)) {
                 break;
             }
-            qapi_free_Audiodev(dev);
-            s->dev = NULL;
         }
     }
 
-    if (!object_property_try_add_child(get_audiodevs_root(), dev->id, OBJECT(s), errp)) {
+    if (!object_property_try_add_child(get_audiodevs_root(),
+                                       d->dev->id, OBJECT(d), errp)) {
         goto out;
     }
-    object_unref(s);
-    return AUDIO_BACKEND(s);
+    object_unref(d);
+    return AUDIO_BACKEND(d);
 
 out:
-    object_unref(s);
+    object_unref(d);
     return NULL;
 }
 
-- 
2.53.0


