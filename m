Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18B6E7BDA1
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwdX-0000LJ-Bm; Mon, 16 Feb 2026 06:19:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwb3-0005Oq-Lu
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwav-0007UA-OG
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:16:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LnSaRxBAGTqpOnRjgcU7fK6qN6/pVq5+xwI7hZXDScs=;
 b=KvHooYU/5PRR1jGxt/ShjiKQ73H6WqiW7PDZRowjnfPYpD2MYSf0hKrxOTy0UX/cMGFscF
 48OuXir78NInPhH37t0GJG6cNZkYT1avX7FBU9ysHX3MBZeicTL7ACDHUBR2pdg7OnJ3Gh
 f/pwjL1RYH15VPOeGYO7TC12g8wcuv8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-9K88Oy9KPICHbPifigC9Tg-1; Mon,
 16 Feb 2026 06:16:42 -0500
X-MC-Unique: 9K88Oy9KPICHbPifigC9Tg-1
X-Mimecast-MFC-AGG-ID: 9K88Oy9KPICHbPifigC9Tg_1771240600
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45B5F1800465; Mon, 16 Feb 2026 11:16:40 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E625630001B9; Mon, 16 Feb 2026 11:16:38 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:11 +0100
Subject: [PATCH 22/85] audio: simplify audio_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-22-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4073;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=K/qLh28e2vPgm33e8WRKkMMDOHVC8mGtCBftRfM7Y78=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxPuWQjmx+oAltbb6CXK981lEPRn579VgwUM
 BP+4Z5bxBSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8TwAKCRDa6OEJdZac
 5bgSD/9rUthyG3AFSNVI0xfNO8rT0yVrZymsmKqCeO4cVmf+zCoACx+uUNKiu6ePb2Kf9wo2KzU
 YSOpuk5GWAPC2vrgCyyPMn6whCoJpO3/VLqk9T1J618ttpwZcAJZjMzu/yAqdjTaubIZaJGeype
 6J2dB5EWvCtzuRDRHrs//W1q6JVsH3F7Vq8qekTP7iTbn98OcAmwH4R/yAci1jdWf+R7hIFYR8Z
 LjbmlvX02P0W+BJWYvm2+JeMgrD9rQvpWi+V6GehY3VbuYcHL6zMConcsIlF3fyL83D3d2F+1n7
 ShCZBB801J+7nUY0m4YRG7x3WcJg5kFQ12FMb55MULX66cA14EjMzRirps8NB6n1HW1OzjqVtbK
 zuw1HWCXafcGCTPhx2G1ICi//dp8LYOPJ9+p8VcfLRCEEd8FIViye9sCPpl3lLHFSn1op8pHFbR
 hCtfPEAyEesbztFukJfq2r6StLrcqAYdCYyYibCw1+ov0+1qnFSAC8p8lE3tB66gMTb4LAr9iP6
 Pp9XSxZhvJSNNrx+p6YIR8t5QXOCiwPF34QpgBK9hsS1dRqTqtnrO+S/g9ByGMqmx2LZ0KGkujr
 oMEIJEfEfHxrrtiRXtvAaJIAX4nFuSa1wXtj8PaDsRTTUGkOr5HzhPyZSkInZaTFwV2oXqpJtBt
 iNEE/F7LmaMSSKQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Factorize looking up the driver in audio_driver_init()

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 audio/audio.c | 66 ++++++++++++++++++++++++++---------------------------------
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


