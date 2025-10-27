Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CEDCCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 15:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDOxQ-0006WM-LI; Mon, 27 Oct 2025 11:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vDOw8-0005Qx-2E
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:15:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vDOvr-000476-R1
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761578088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5uEAD8IufxGlfbgcYTAd6K5nN0aUVsvDwES5X6ku/Aw=;
 b=emun6P46NH3UsX/xzllWSlYz5BTiSZZkTj6uB6BCMeSsiRdmmqOvVx9fAf0VzqJs/1e7mN
 VjaBoKypVVDE4UOYd2ug+hHQb12TrtfB7jqavWUun8AySy4EIB0jAf4vLSN0EqAE4iSP4S
 ATmgubyf98X7E0khHefXJShxeUGy1m4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-LlJD0ToGOFSD_dkmd2rLiQ-1; Mon,
 27 Oct 2025 11:14:43 -0400
X-MC-Unique: LlJD0ToGOFSD_dkmd2rLiQ-1
X-Mimecast-MFC-AGG-ID: LlJD0ToGOFSD_dkmd2rLiQ_1761578081
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4BAB180136C; Mon, 27 Oct 2025 15:14:40 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2862030001A2; Mon, 27 Oct 2025 15:14:38 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Alexandre Ratchov <alex@caoua.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jan Kiszka <jan.kiszka@web.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-ppc@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 35/35] audio: Rename @endianness argument as @big_endian
 for clarity
Date: Mon, 27 Oct 2025 19:10:42 +0400
Message-ID: <20251027151045.2863176-36-marcandre.lureau@redhat.com>
In-Reply-To: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
References: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

@endianness is used as a boolean, rename for clarity.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/alsaaudio.c | 32 ++++++--------------------------
 audio/ossaudio.c  | 14 +++-----------
 audio/paaudio.c   |  8 ++++----
 audio/pwaudio.c   | 12 ++++++------
 4 files changed, 19 insertions(+), 47 deletions(-)

diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 89f6dad1a9..7d7da576dc 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -264,7 +264,7 @@ static int alsa_poll_in (HWVoiceIn *hw)
     return alsa_poll_helper (alsa->handle, &alsa->pollhlp, POLLIN);
 }
 
-static snd_pcm_format_t aud_to_alsafmt (AudioFormat fmt, int endianness)
+static snd_pcm_format_t aud_to_alsafmt(AudioFormat fmt, bool big_endian)
 {
     switch (fmt) {
     case AUDIO_FORMAT_S8:
@@ -274,39 +274,19 @@ static snd_pcm_format_t aud_to_alsafmt (AudioFormat fmt, int endianness)
         return SND_PCM_FORMAT_U8;
 
     case AUDIO_FORMAT_S16:
-        if (endianness) {
-            return SND_PCM_FORMAT_S16_BE;
-        } else {
-            return SND_PCM_FORMAT_S16_LE;
-        }
+        return big_endian ? SND_PCM_FORMAT_S16_BE : SND_PCM_FORMAT_S16_LE;
 
     case AUDIO_FORMAT_U16:
-        if (endianness) {
-            return SND_PCM_FORMAT_U16_BE;
-        } else {
-            return SND_PCM_FORMAT_U16_LE;
-        }
+        return big_endian ? SND_PCM_FORMAT_U16_BE : SND_PCM_FORMAT_U16_LE;
 
     case AUDIO_FORMAT_S32:
-        if (endianness) {
-            return SND_PCM_FORMAT_S32_BE;
-        } else {
-            return SND_PCM_FORMAT_S32_LE;
-        }
+        return big_endian ? SND_PCM_FORMAT_S32_BE : SND_PCM_FORMAT_S32_LE;
 
     case AUDIO_FORMAT_U32:
-        if (endianness) {
-            return SND_PCM_FORMAT_U32_BE;
-        } else {
-            return SND_PCM_FORMAT_U32_LE;
-        }
+        return big_endian ? SND_PCM_FORMAT_U32_BE : SND_PCM_FORMAT_U32_LE;
 
     case AUDIO_FORMAT_F32:
-        if (endianness) {
-            return SND_PCM_FORMAT_FLOAT_BE;
-        } else {
-            return SND_PCM_FORMAT_FLOAT_LE;
-        }
+        return big_endian ? SND_PCM_FORMAT_FLOAT_BE : SND_PCM_FORMAT_FLOAT_LE;
 
     default:
         dolog ("Internal logic error: Bad audio format %d\n", fmt);
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 86c4805675..c6cad47a01 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -131,7 +131,7 @@ static void oss_poll_in (HWVoiceIn *hw)
     qemu_set_fd_handler(oss->fd, oss_helper_poll_in, NULL, hw->s);
 }
 
-static int aud_to_ossfmt (AudioFormat fmt, int endianness)
+static int aud_to_ossfmt(AudioFormat fmt, bool big_endian)
 {
     switch (fmt) {
     case AUDIO_FORMAT_S8:
@@ -141,18 +141,10 @@ static int aud_to_ossfmt (AudioFormat fmt, int endianness)
         return AFMT_U8;
 
     case AUDIO_FORMAT_S16:
-        if (endianness) {
-            return AFMT_S16_BE;
-        } else {
-            return AFMT_S16_LE;
-        }
+        return big_endian ? AFMT_S16_BE : AFMT_S16_LE;
 
     case AUDIO_FORMAT_U16:
-        if (endianness) {
-            return AFMT_U16_BE;
-        } else {
-            return AFMT_U16_LE;
-        }
+        return big_endian ? AFMT_U16_BE : AFMT_U16_LE;
 
     default:
         dolog ("Internal logic error: Bad audio format %d\n", fmt);
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 6b9b6d219a..0c06a39719 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -316,7 +316,7 @@ unlock_and_fail:
     return 0;
 }
 
-static pa_sample_format_t audfmt_to_pa (AudioFormat afmt, int endianness)
+static pa_sample_format_t audfmt_to_pa(AudioFormat afmt, bool big_endian)
 {
     int format;
 
@@ -327,14 +327,14 @@ static pa_sample_format_t audfmt_to_pa (AudioFormat afmt, int endianness)
         break;
     case AUDIO_FORMAT_S16:
     case AUDIO_FORMAT_U16:
-        format = endianness ? PA_SAMPLE_S16BE : PA_SAMPLE_S16LE;
+        format = big_endian ? PA_SAMPLE_S16BE : PA_SAMPLE_S16LE;
         break;
     case AUDIO_FORMAT_S32:
     case AUDIO_FORMAT_U32:
-        format = endianness ? PA_SAMPLE_S32BE : PA_SAMPLE_S32LE;
+        format = big_endian ? PA_SAMPLE_S32BE : PA_SAMPLE_S32LE;
         break;
     case AUDIO_FORMAT_F32:
-        format = endianness ? PA_SAMPLE_FLOAT32BE : PA_SAMPLE_FLOAT32LE;
+        format = big_endian ? PA_SAMPLE_FLOAT32BE : PA_SAMPLE_FLOAT32LE;
         break;
     default:
         dolog ("Internal logic error: Bad audio format %d\n", afmt);
diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index 0fd59d9fe6..30f717ccac 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -324,7 +324,7 @@ done_unlock:
 }
 
 static int
-audfmt_to_pw(AudioFormat fmt, int endianness)
+audfmt_to_pw(AudioFormat fmt, bool big_endian)
 {
     int format;
 
@@ -336,19 +336,19 @@ audfmt_to_pw(AudioFormat fmt, int endianness)
         format = SPA_AUDIO_FORMAT_U8;
         break;
     case AUDIO_FORMAT_S16:
-        format = endianness ? SPA_AUDIO_FORMAT_S16_BE : SPA_AUDIO_FORMAT_S16_LE;
+        format = big_endian ? SPA_AUDIO_FORMAT_S16_BE : SPA_AUDIO_FORMAT_S16_LE;
         break;
     case AUDIO_FORMAT_U16:
-        format = endianness ? SPA_AUDIO_FORMAT_U16_BE : SPA_AUDIO_FORMAT_U16_LE;
+        format = big_endian ? SPA_AUDIO_FORMAT_U16_BE : SPA_AUDIO_FORMAT_U16_LE;
         break;
     case AUDIO_FORMAT_S32:
-        format = endianness ? SPA_AUDIO_FORMAT_S32_BE : SPA_AUDIO_FORMAT_S32_LE;
+        format = big_endian ? SPA_AUDIO_FORMAT_S32_BE : SPA_AUDIO_FORMAT_S32_LE;
         break;
     case AUDIO_FORMAT_U32:
-        format = endianness ? SPA_AUDIO_FORMAT_U32_BE : SPA_AUDIO_FORMAT_U32_LE;
+        format = big_endian ? SPA_AUDIO_FORMAT_U32_BE : SPA_AUDIO_FORMAT_U32_LE;
         break;
     case AUDIO_FORMAT_F32:
-        format = endianness ? SPA_AUDIO_FORMAT_F32_BE : SPA_AUDIO_FORMAT_F32_LE;
+        format = big_endian ? SPA_AUDIO_FORMAT_F32_BE : SPA_AUDIO_FORMAT_F32_LE;
         break;
     default:
         dolog("Internal logic error: Bad audio format %d\n", fmt);
-- 
2.51.0


