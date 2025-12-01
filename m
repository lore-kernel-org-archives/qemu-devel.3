Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57790D111A8
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 11:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ215-0000jO-ME; Mon, 01 Dec 2025 06:24:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ20s-0000AY-E4
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:24:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ20p-0006Y0-Jb
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:24:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764588248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eFakANaqmO6A83+P/MHbrOBs9AEyOy7Lrkd3AuAnQEc=;
 b=HCOc+6kUAKqm4zyF0yzB6qaZh9uAnohIQhTm0/h0dmFcHkyBf15AKzyjewW2+EndeQ6LBl
 zE8hF/nEDVXE7BWsmn0SJZqNj0otSQf/v/BKbLV/AQ4U3UMU7Pui//f+070QpDg0nn1kNP
 Se2Us2DwT313FFoa4Q5CLfh6sPr+SmE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-ZyviYWkQPEWMsTMzkzS7dA-1; Mon,
 01 Dec 2025 06:24:05 -0500
X-MC-Unique: ZyviYWkQPEWMsTMzkzS7dA-1
X-Mimecast-MFC-AGG-ID: ZyviYWkQPEWMsTMzkzS7dA_1764588243
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF2F4180061B; Mon,  1 Dec 2025 11:24:01 +0000 (UTC)
Received: from localhost (unknown [10.45.242.40])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3CB821955F1A; Mon,  1 Dec 2025 11:23:59 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Ratchov <alex@caoua.org>, dirty.ice.hu@gmail.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [RFC 07/24] audio: move object creation to audio_driver_init()
Date: Mon,  1 Dec 2025 15:22:48 +0400
Message-ID: <20251201112309.4163921-8-marcandre.lureau@redhat.com>
In-Reply-To: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

As we will allow other kind of AudioBackend objects to be instantiated,
move the object allocation to a dedicated function.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 7b978e862c..fab6024207 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1563,19 +1563,23 @@ size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
     return total;
 }
 
-static bool audio_driver_do_init(AudioDriver *d, Error **errp)
+static AudioBackend *audio_be_new(Audiodev *dev, Error **errp)
 {
-    const char *drvname = AudiodevDriver_str(d->dev->driver);
+    const char *drvname = AudiodevDriver_str(dev->driver);
     struct audio_driver *drv = audio_driver_lookup(drvname);
 
     if (!drv) {
         error_setg(errp, "Unknown audio driver `%s'", drvname);
-        return false;
+        return NULL;
     }
 
+    AudioDriver *d = AUDIO_DRIVER(object_new(TYPE_AUDIO_DRIVER));
+    d->dev = dev;
+
     d->drv_opaque = drv->init(d->dev, errp);
     if (!d->drv_opaque) {
-        return false;
+        object_unref(OBJECT(d));
+        return NULL;
     }
 
     if (!drv->pcm_ops->get_buffer_in) {
@@ -1597,7 +1601,7 @@ static bool audio_driver_do_init(AudioDriver *d, Error **errp)
         d->period_ticks = d->dev->timer_period * (int64_t)SCALE_US;
     }
 
-    return true;
+    return AUDIO_BACKEND(d);
 }
 
 static void audio_vm_change_state_handler (void *opaque, bool running,
@@ -1795,13 +1799,12 @@ void audio_create_default_audiodevs(void)
  */
 static AudioBackend *audio_init(Audiodev *dev, Error **errp)
 {
-    AudioDriver *d;
+    AudioBackend *be;
 
-    d = AUDIO_DRIVER(object_new(TYPE_AUDIO_DRIVER));
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
@@ -1809,27 +1812,24 @@ static AudioBackend *audio_init(Audiodev *dev, Error **errp)
             AudiodevListEntry *e = QSIMPLEQ_FIRST(&default_audiodevs);
             if (!e) {
                 error_setg(errp, "no default audio driver available");
-                goto out;
+                return NULL;
             }
-            d->dev = e->dev;
             QSIMPLEQ_REMOVE_HEAD(&default_audiodevs, next);
+            be = audio_be_new(e->dev, NULL);
             g_free(e);
-            if (audio_driver_do_init(d, NULL)) {
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
-- 
2.51.1


