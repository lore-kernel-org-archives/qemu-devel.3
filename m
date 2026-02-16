Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E7AE7BD9B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwfG-0005EL-4D; Mon, 16 Feb 2026 06:21:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwc5-0006Ol-2v
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:18:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwc1-00089Q-Q8
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:18:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FEm66eRxFketQFIgeZBzb+TUChBafUGfeNq/IMh5ojk=;
 b=JrSvBeQmc6eU6zJa+kzPxRizcsgyKPL9P0kByv1wD9455qpiuTRyEgjb3i8hEMmEpbt4g+
 Z+uz5dzV7foteG1EsuEj+9IllMb/D7iPXTuc6CRUtjuINj4uAXyrUbcvpiHF0cAynIYhgY
 Qj6HPyZwvdxxUTwR+t2zdss97c3L3H0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-xBxOfUlKOMW5imetpbPsyw-1; Mon,
 16 Feb 2026 06:17:52 -0500
X-MC-Unique: xBxOfUlKOMW5imetpbPsyw-1
X-Mimecast-MFC-AGG-ID: xBxOfUlKOMW5imetpbPsyw_1771240670
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AB731800367; Mon, 16 Feb 2026 11:17:50 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 44DED30001A5; Mon, 16 Feb 2026 11:17:49 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:36 +0100
Subject: [PATCH 47/85] audio/oss: convert to QOM lifecycle methods
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-47-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4118;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=WSaswajA4EH4bQvF1yrHLLnXVV/md1CQHXeFT1moIKg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxQCWIyFxILKTEM9E5I8G/E+JA2cKon2GziR
 0mw2ZgO4GSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8UAAKCRDa6OEJdZac
 5ZVrD/0aE3LDDMhOs8tIc36loNx326609rrLev+SeQjQ0OvkE4fitDeY+ZFjvSOBJeldk0Ejgub
 I9HpvWfasNhPnn+bqhx85dWEYPgtBsGilDfAtXxUfqbr4+aowcYk9hBdgLGexX2MrxkYuSe3Rj7
 jfEMvY9j3+49VHu9Om6Xg78NmpRK973xo/J9DSqOrx4EYegsQ5uOqVJmkSErSMJy/CiS3sFYJNG
 CGz5h5dQbONyMNtEdt4ipcRvjeWbr2MS1UvzC9EE455qO/2iD8WtgXENaLaZuXFw/DVmvokB/vu
 d9RoFfLmd3zUbYmIqY+8JahHoLYZzJjFTKu63jlTmdzkq92QWLmJXm++yDDPGg1wAFc/lrlXYIf
 EYuOtGM4VG7JYV2z0lwyxsR0wvIvIHcZY4xarj8LDzCigFfR7VxA2WGWqHyMC0fSdv/kFgWaiIN
 6PEUG9CBh2H7JT+IJBhr2TcSUWgk+gcjdW5LYOuQb1n+KjiJT/bW1Bwusc0zhMh2HMDqal2aIzZ
 kx6psFeNh4ykZjNyCDxircAghw8RfNq5QUbssv1zWtcyz2LoY0n+r7ubnnyqvADJc7bBOOHh3Ry
 jjgSM2MmyV4y7BWVhvZ1+CIY8VrGZLHFR+JbYoXAw7MC62i90qgTFnXPOzSwLBrCT9/aHmDqQxv
 M+pD4POPkumPXNw==
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

Migrate the OSS audio backend from the legacy driver init/fini
callbacks to proper QOM realize method.

The oss_audio_init() function is replaced with audio_oss_realize(),
which performs the same device accessibility check before delegating
to the parent class realize method. The empty oss_audio_fini() is
removed.

Access to the Audiodev is now through hw->s->dev instead of the
drv_opaque pointer.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 audio/ossaudio.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index f64c564e345..fedd2bbd722 100644
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
     AudioMixengBackend parent_obj;
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
-        return NULL;
+        qapi_free_Audiodev(dev);
+        return false;
     }
     if (access(oopts->out->dev ?: "/dev/dsp", R_OK | W_OK) < 0) {
         error_setg_errno(errp, errno, "%s not accessible", oopts->out->dev ?: "/dev/dsp");
-        return NULL;
+        qapi_free_Audiodev(dev);
+        return false;
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
 static const TypeInfo audio_types[] = {
     {
         .name = TYPE_AUDIO_OSS,

-- 
2.53.0


