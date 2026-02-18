Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88264E9A04C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 09:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsdVi-0007qc-VM; Wed, 18 Feb 2026 04:06:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdVQ-00076O-Rf
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:06:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdVP-0001GM-2a
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:06:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771405558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oaDmncSttA6yajhGZ9BDmb+LfKD4WjheIu/dDDpU9Z8=;
 b=iKb/KIwWz2qmUsY+PTkvBYk2bHC1YdVgAshURUAy8ZXHKwnDI/iYP29t1vM17UbZZ5WZpc
 CArUwPSx5dwvrnEdtF77v6nkMI8xWH0ZYLvBGGErJQYxp3AySXlJdBkbXRcnaMmPRE8Crd
 6FzBE3PZevCkDL3YW0k+5QufqAOdEEg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-8io3fhLBOT2ynXGNx6jfEA-1; Wed,
 18 Feb 2026 04:05:54 -0500
X-MC-Unique: 8io3fhLBOT2ynXGNx6jfEA-1
X-Mimecast-MFC-AGG-ID: 8io3fhLBOT2ynXGNx6jfEA_1771405553
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 348BE1800370; Wed, 18 Feb 2026 09:05:53 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 750A71800348; Wed, 18 Feb 2026 09:05:52 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: [PULL 46/85] audio/alsa: convert to QOM lifecycle methods
Date: Wed, 18 Feb 2026 10:02:46 +0100
Message-ID: <20260218090330.1476169-47-marcandre.lureau@redhat.com>
In-Reply-To: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
References: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Migrate the ALSA audio backend from the legacy driver init/fini
callbacks to proper QOM realize method.

The alsa_audio_init() function is replaced with audio_alsa_realize(),
which performs the same ALSA option initialization before delegating
to the parent class realize method. The empty alsa_audio_fini() is
removed.

The Audiodev pointer stored in ALSAVoiceOut and ALSAVoiceIn is removed
as it can now be accessed through hw->s->dev.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/alsaaudio.c | 43 ++++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index ae1cec6a36e..c2788606b28 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -40,19 +40,14 @@
 #define TYPE_AUDIO_ALSA "audio-alsa"
 OBJECT_DECLARE_SIMPLE_TYPE(AudioALSA, AUDIO_ALSA)
 
+static AudioBackendClass *audio_alsa_parent_class;
+
 struct AudioALSA {
     AudioMixengBackend parent_obj;
 };
 
 static struct audio_driver alsa_audio_driver;
 
-static void audio_alsa_class_init(ObjectClass *klass, const void *data)
-{
-    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
-
-    k->driver = &alsa_audio_driver;
-}
-
 struct pollhlp {
     snd_pcm_t *handle;
     struct pollfd *pfds;
@@ -65,14 +60,12 @@ typedef struct ALSAVoiceOut {
     HWVoiceOut hw;
     snd_pcm_t *handle;
     struct pollhlp pollhlp;
-    Audiodev *dev;
 } ALSAVoiceOut;
 
 typedef struct ALSAVoiceIn {
     HWVoiceIn hw;
     snd_pcm_t *handle;
     struct pollhlp pollhlp;
-    Audiodev *dev;
 } ALSAVoiceIn;
 
 struct alsa_params_req {
@@ -707,7 +700,7 @@ static int alsa_init_out(HWVoiceOut *hw, struct audsettings *as,
     struct alsa_params_obt obt;
     snd_pcm_t *handle;
     struct audsettings obt_as;
-    Audiodev *dev = drv_opaque;
+    Audiodev *dev = hw->s->dev;
 
     req.fmt = aud_to_alsafmt (as->fmt, as->endianness);
     req.freq = as->freq;
@@ -727,7 +720,6 @@ static int alsa_init_out(HWVoiceOut *hw, struct audsettings *as,
 
     alsa->pollhlp.s = hw->s;
     alsa->handle = handle;
-    alsa->dev = dev;
     return 0;
 }
 
@@ -766,7 +758,7 @@ static int alsa_voice_ctl (snd_pcm_t *handle, const char *typ, int ctl)
 static void alsa_enable_out(HWVoiceOut *hw, bool enable)
 {
     ALSAVoiceOut *alsa = (ALSAVoiceOut *) hw;
-    AudiodevAlsaPerDirectionOptions *apdo = alsa->dev->u.alsa.out;
+    AudiodevAlsaPerDirectionOptions *apdo = hw->s->dev->u.alsa.out;
 
     if (enable) {
         bool poll_mode = apdo->try_poll;
@@ -794,7 +786,7 @@ static int alsa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     struct alsa_params_obt obt;
     snd_pcm_t *handle;
     struct audsettings obt_as;
-    Audiodev *dev = drv_opaque;
+    Audiodev *dev = hw->s->dev;
 
     req.fmt = aud_to_alsafmt (as->fmt, as->endianness);
     req.freq = as->freq;
@@ -814,7 +806,6 @@ static int alsa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
 
     alsa->pollhlp.s = hw->s;
     alsa->handle = handle;
-    alsa->dev = dev;
     return 0;
 }
 
@@ -871,7 +862,7 @@ static size_t alsa_read(HWVoiceIn *hw, void *buf, size_t len)
 static void alsa_enable_in(HWVoiceIn *hw, bool enable)
 {
     ALSAVoiceIn *alsa = (ALSAVoiceIn *) hw;
-    AudiodevAlsaPerDirectionOptions *apdo = alsa->dev->u.alsa.in;
+    AudiodevAlsaPerDirectionOptions *apdo = hw->s->dev->u.alsa.in;
 
     if (enable) {
         bool poll_mode = apdo->try_poll;
@@ -901,7 +892,8 @@ static void alsa_init_per_direction(AudiodevAlsaPerDirectionOptions *apdo)
     }
 }
 
-static void *alsa_audio_init(Audiodev *dev, Error **errp)
+static bool
+audio_alsa_realize(AudioBackend *abe, Audiodev *dev, Error **errp)
 {
     AudiodevAlsaOptions *aopts;
     assert(dev->driver == AUDIODEV_DRIVER_ALSA);
@@ -929,11 +921,7 @@ static void *alsa_audio_init(Audiodev *dev, Error **errp)
         dev->u.alsa.in->buffer_length = 92880;
     }
 
-    return dev;
-}
-
-static void alsa_audio_fini (void *opaque)
-{
+    return audio_alsa_parent_class->realize(abe, dev, errp);
 }
 
 static struct audio_pcm_ops alsa_pcm_ops = {
@@ -953,8 +941,6 @@ static struct audio_pcm_ops alsa_pcm_ops = {
 
 static struct audio_driver alsa_audio_driver = {
     .name           = "alsa",
-    .init           = alsa_audio_init,
-    .fini           = alsa_audio_fini,
     .pcm_ops        = &alsa_pcm_ops,
     .max_voices_out = INT_MAX,
     .max_voices_in  = INT_MAX,
@@ -962,6 +948,17 @@ static struct audio_driver alsa_audio_driver = {
     .voice_size_in  = sizeof (ALSAVoiceIn)
 };
 
+static void audio_alsa_class_init(ObjectClass *klass, const void *data)
+{
+    AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
+    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
+
+    audio_alsa_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
+
+    b->realize = audio_alsa_realize;
+    k->driver = &alsa_audio_driver;
+}
+
 static const TypeInfo audio_types[] = {
     {
         .name = TYPE_AUDIO_ALSA,
-- 
2.53.0


