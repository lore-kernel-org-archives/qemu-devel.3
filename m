Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27499CCD1BE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 07:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBSqU-0001V5-1o; Wed, 22 Oct 2025 03:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBSpz-0000zW-JM
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 03:00:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBSpx-0000JU-CU
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 03:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761116443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OAXmPexSmFyJsxaNsDjZRC4NyniIAGeOBz95+dSKihY=;
 b=S/Pbn/GMmp35YWHCakxNEztO2SH7lxx/kXDctGPYly3yeHdAnUJ/Mp7g/Av0gI3Mz6zxk2
 UUf7g5HQvvBl6XjM5u+CkbxSKhaiIglJTqGqjvft7zJqaDpoqVn5jaTJhi6sFG8tRWDIZF
 KE2VJpRzdphDz/OL/+9VGaF4IV8exZM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-NZIpPWg0NDa6lFvNogigUw-1; Wed,
 22 Oct 2025 03:00:40 -0400
X-MC-Unique: NZIpPWg0NDa6lFvNogigUw-1
X-Mimecast-MFC-AGG-ID: NZIpPWg0NDa6lFvNogigUw_1761116438
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60D981956053; Wed, 22 Oct 2025 07:00:38 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8D24D3000221; Wed, 22 Oct 2025 07:00:36 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>
Subject: [PATCH v2 41/42] audio: drop needless audio_driver "descr" field
Date: Wed, 22 Oct 2025 10:56:36 +0400
Message-ID: <20251022065640.1172785-42-marcandre.lureau@redhat.com>
In-Reply-To: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
References: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
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

Was it ever used?

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_int.h   | 1 -
 audio/alsaaudio.c   | 1 -
 audio/dbusaudio.c   | 1 -
 audio/dsoundaudio.c | 1 -
 audio/jackaudio.c   | 1 -
 audio/noaudio.c     | 1 -
 audio/ossaudio.c    | 1 -
 audio/paaudio.c     | 1 -
 audio/pwaudio.c     | 1 -
 audio/sdlaudio.c    | 1 -
 audio/sndioaudio.c  | 1 -
 audio/spiceaudio.c  | 1 -
 audio/wavaudio.c    | 1 -
 audio/coreaudio.m   | 1 -
 14 files changed, 14 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index c669a0e36f..e0e4da5b70 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -142,7 +142,6 @@ struct SWVoiceIn {
 typedef struct audio_driver audio_driver;
 struct audio_driver {
     const char *name;
-    const char *descr;
     void *(*init) (Audiodev *, Error **);
     void (*fini) (void *);
 #ifdef CONFIG_GIO
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index d1e4817081..89f6dad1a9 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -956,7 +956,6 @@ static struct audio_pcm_ops alsa_pcm_ops = {
 
 static struct audio_driver alsa_audio_driver = {
     .name           = "alsa",
-    .descr          = "ALSA http://www.alsa-project.org",
     .init           = alsa_audio_init,
     .fini           = alsa_audio_fini,
     .pcm_ops        = &alsa_pcm_ops,
diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
index abae8d20ae..9a6b5e586f 100644
--- a/audio/dbusaudio.c
+++ b/audio/dbusaudio.c
@@ -692,7 +692,6 @@ static struct audio_pcm_ops dbus_pcm_ops = {
 
 static struct audio_driver dbus_audio_driver = {
     .name            = "dbus",
-    .descr           = "Timer based audio exposed with DBus interface",
     .init            = dbus_audio_init,
     .fini            = dbus_audio_fini,
     .set_dbus_server = dbus_audio_set_server,
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index fbb8890f5c..e75d235514 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -685,7 +685,6 @@ static struct audio_pcm_ops dsound_pcm_ops = {
 
 static struct audio_driver dsound_audio_driver = {
     .name           = "dsound",
-    .descr          = "DirectSound http://wikipedia.org/wiki/DirectSound",
     .init           = dsound_audio_init,
     .fini           = dsound_audio_fini,
     .pcm_ops        = &dsound_pcm_ops,
diff --git a/audio/jackaudio.c b/audio/jackaudio.c
index 28face9989..7a3fcaedba 100644
--- a/audio/jackaudio.c
+++ b/audio/jackaudio.c
@@ -672,7 +672,6 @@ static struct audio_pcm_ops jack_pcm_ops = {
 
 static struct audio_driver jack_driver = {
     .name           = "jack",
-    .descr          = "JACK Audio Connection Kit Client",
     .init           = qjack_init,
     .fini           = qjack_fini,
     .pcm_ops        = &jack_pcm_ops,
diff --git a/audio/noaudio.c b/audio/noaudio.c
index b136b74e26..4ed9d2156c 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -129,7 +129,6 @@ static struct audio_pcm_ops no_pcm_ops = {
 
 static struct audio_driver no_audio_driver = {
     .name           = "none",
-    .descr          = "Timer based audio emulation",
     .init           = no_audio_init,
     .fini           = no_audio_fini,
     .pcm_ops        = &no_pcm_ops,
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 5ba91f6793..ab8791bece 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -779,7 +779,6 @@ static struct audio_pcm_ops oss_pcm_ops = {
 
 static struct audio_driver oss_audio_driver = {
     .name           = "oss",
-    .descr          = "OSS http://www.opensound.com",
     .init           = oss_audio_init,
     .fini           = oss_audio_fini,
     .pcm_ops        = &oss_pcm_ops,
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 8eb80ede45..6b9b6d219a 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -922,7 +922,6 @@ static struct audio_pcm_ops qpa_pcm_ops = {
 
 static struct audio_driver pa_audio_driver = {
     .name           = "pa",
-    .descr          = "http://www.pulseaudio.org/",
     .init           = qpa_audio_init,
     .fini           = qpa_audio_fini,
     .pcm_ops        = &qpa_pcm_ops,
diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index 8f6c0900c8..0fd59d9fe6 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -838,7 +838,6 @@ static struct audio_pcm_ops qpw_pcm_ops = {
 
 static struct audio_driver pw_audio_driver = {
     .name = "pipewire",
-    .descr = "http://www.pipewire.org/",
     .init = qpw_audio_init,
     .fini = qpw_audio_fini,
     .pcm_ops = &qpw_pcm_ops,
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index 4ef73c8dfb..a7a9652d29 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -490,7 +490,6 @@ static struct audio_pcm_ops sdl_pcm_ops = {
 
 static struct audio_driver sdl_audio_driver = {
     .name           = "sdl",
-    .descr          = "SDL http://www.libsdl.org",
     .init           = sdl_audio_init,
     .fini           = sdl_audio_fini,
     .pcm_ops        = &sdl_pcm_ops,
diff --git a/audio/sndioaudio.c b/audio/sndioaudio.c
index f4f53b1c6f..8197b8b0b4 100644
--- a/audio/sndioaudio.c
+++ b/audio/sndioaudio.c
@@ -546,7 +546,6 @@ static struct audio_pcm_ops sndio_pcm_ops = {
 
 static struct audio_driver sndio_audio_driver = {
     .name           = "sndio",
-    .descr          = "sndio https://sndio.org",
     .init           = sndio_audio_init,
     .fini           = sndio_audio_fini,
     .pcm_ops        = &sndio_pcm_ops,
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index 77ba89ffaa..7db2d1f0df 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -316,7 +316,6 @@ static struct audio_pcm_ops audio_callbacks = {
 
 static struct audio_driver spice_audio_driver = {
     .name           = "spice",
-    .descr          = "spice audio driver",
     .init           = spice_audio_init,
     .fini           = spice_audio_fini,
     .pcm_ops        = &audio_callbacks,
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 4d9c921305..46460a5d57 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -205,7 +205,6 @@ static struct audio_pcm_ops wav_pcm_ops = {
 
 static struct audio_driver wav_audio_driver = {
     .name           = "wav",
-    .descr          = "WAV renderer http://wikipedia.org/wiki/WAV",
     .init           = wav_audio_init,
     .fini           = wav_audio_fini,
     .pcm_ops        = &wav_pcm_ops,
diff --git a/audio/coreaudio.m b/audio/coreaudio.m
index 8b3cd6db16..997017a1e9 100644
--- a/audio/coreaudio.m
+++ b/audio/coreaudio.m
@@ -664,7 +664,6 @@ static void coreaudio_audio_fini (void *opaque)
 
 static struct audio_driver coreaudio_audio_driver = {
     .name           = "coreaudio",
-    .descr          = "CoreAudio http://developer.apple.com/audio/coreaudio.html",
     .init           = coreaudio_audio_init,
     .fini           = coreaudio_audio_fini,
     .pcm_ops        = &coreaudio_pcm_ops,
-- 
2.51.0


