Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D38D2FED2
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vknly-0005DZ-QV; Tue, 27 Jan 2026 13:26:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vknlL-0004jD-L8
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:26:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vknlI-00039c-Lb
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:26:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769538359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+LhYG95rMNfTV5nVAhsB5H02K12KrRQKkVDNuf0MyFM=;
 b=GWq8UlHCFFlQY+SKLq3xRpd8bF0aTc5iZvqz1tRyNRnVu8BP4JrXiyTK7sbr9Uh66KW53h
 3RYYz3AxdS9AuWDbvp3VvIH4LS9Hn15/PPySXDsC+ah4Q7rlJFMNQFcdiTATX+FU0oh4TR
 BSEHgwp7paraSlKjUjz8wF+B2P+CxVY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-NIfgcEMQNHeEebE-8z9Hyw-1; Tue,
 27 Jan 2026 13:25:58 -0500
X-MC-Unique: NIfgcEMQNHeEebE-8z9Hyw-1
X-Mimecast-MFC-AGG-ID: NIfgcEMQNHeEebE-8z9Hyw_1769538357
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67A301800378; Tue, 27 Jan 2026 18:25:57 +0000 (UTC)
Received: from localhost (unknown [10.45.242.23])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 229E030001A2; Tue, 27 Jan 2026 18:25:55 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 06/43] audio/oss: convert to QOM lifecycle methods
Date: Tue, 27 Jan 2026 22:24:33 +0400
Message-ID: <20260127182516.289834-7-marcandre.lureau@redhat.com>
In-Reply-To: <20260127182516.289834-1-marcandre.lureau@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Migrate the OSS audio backend from the legacy driver init/fini
callbacks to proper QOM realize method.

The oss_audio_init() function is replaced with audio_oss_realize(),
which performs the same device accessibility check before delegating
to the parent class realize method. The empty oss_audio_fini() is
removed.

Access to the Audiodev is now through hw->s->dev instead of the
drv_opaque pointer.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/ossaudio.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 013958e1344..e745149ca39 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi-types-audio.h"
 #include <sys/ioctl.h>
 #include <sys/soundcard.h>
 #include "qemu/main-loop.h"
@@ -39,19 +40,14 @@
 #define TYPE_AUDIO_OSS "audio-oss"
 OBJECT_DECLARE_SIMPLE_TYPE(AudioOss, AUDIO_OSS)
 
+static AudioBackendClass *audio_oss_parent_class;
+
 struct AudioOss {
     AudioMixengBackend parent;
 };
 
 static struct audio_driver oss_audio_driver;
 
-static void audio_oss_class_init(ObjectClass *klass, const void *data)
-{
-    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
-
-    k->driver = &oss_audio_driver;
-}
-
 #if defined OSS_GETVERSION && defined SNDCTL_DSP_POLICY
 #define USE_DSP_POLICY
 #endif
@@ -505,7 +501,7 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as,
     int err;
     int fd;
     struct audsettings obt_as;
-    Audiodev *dev = drv_opaque;
+    Audiodev *dev = hw->s->dev;
     AudiodevOssOptions *oopts = &dev->u.oss;
 
     oss->fd = -1;
@@ -636,7 +632,7 @@ static int oss_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     int err;
     int fd;
     struct audsettings obt_as;
-    Audiodev *dev = drv_opaque;
+    Audiodev *dev = hw->s->dev;
 
     oss->fd = -1;
 
@@ -737,7 +733,8 @@ static void oss_init_per_direction(AudiodevOssPerDirectionOptions *opdo)
     }
 }
 
-static void *oss_audio_init(Audiodev *dev, Error **errp)
+static bool
+audio_oss_realize(AudioBackend *abe, Audiodev *dev, Error **errp)
 {
     AudiodevOssOptions *oopts;
     assert(dev->driver == AUDIODEV_DRIVER_OSS);
@@ -748,17 +745,16 @@ static void *oss_audio_init(Audiodev *dev, Error **errp)
 
     if (access(oopts->in->dev ?: "/dev/dsp", R_OK | W_OK) < 0) {
         error_setg_errno(errp, errno, "%s not accessible", oopts->in->dev ?: "/dev/dsp");
+        qapi_free_Audiodev(dev);
         return NULL;
     }
     if (access(oopts->out->dev ?: "/dev/dsp", R_OK | W_OK) < 0) {
         error_setg_errno(errp, errno, "%s not accessible", oopts->out->dev ?: "/dev/dsp");
+        qapi_free_Audiodev(dev);
         return NULL;
     }
-    return dev;
-}
 
-static void oss_audio_fini (void *opaque)
-{
+    return audio_oss_parent_class->realize(abe, dev, errp);
 }
 
 static struct audio_pcm_ops oss_pcm_ops = {
@@ -780,8 +776,6 @@ static struct audio_pcm_ops oss_pcm_ops = {
 
 static struct audio_driver oss_audio_driver = {
     .name           = "oss",
-    .init           = oss_audio_init,
-    .fini           = oss_audio_fini,
     .pcm_ops        = &oss_pcm_ops,
     .max_voices_out = INT_MAX,
     .max_voices_in  = INT_MAX,
@@ -789,6 +783,17 @@ static struct audio_driver oss_audio_driver = {
     .voice_size_in  = sizeof (OSSVoiceIn)
 };
 
+static void audio_oss_class_init(ObjectClass *klass, const void *data)
+{
+    AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
+    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
+
+    audio_oss_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
+
+    b->realize = audio_oss_realize;
+    k->driver = &oss_audio_driver;
+}
+
 static const TypeInfo audio_oss_info = {
     .name = TYPE_AUDIO_OSS,
     .parent = TYPE_AUDIO_MIXENG_BACKEND,
-- 
2.52.0


