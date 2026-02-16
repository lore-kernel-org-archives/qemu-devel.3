Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2D4E7BD95
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwdV-0000AO-VZ; Mon, 16 Feb 2026 06:19:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwar-0005JQ-Ow
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwak-0007Sg-9P
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:16:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=owCMqtDAeefUA/PLyaaNUJQAaFbI+2RUQ1YruU0M5ag=;
 b=e9hP0KOEYS3kdc5XO/hHAWBgBRyTeUyS7SLDd4cJv33yxQuytGwTjeZzQHihwgCxIbju2j
 /QoPAjYUE8grb/j6I6XeYXOU11msMJr7YkvYqMVHEOkS0H/7nPLdSBxAlg/bbqlmSmFpKS
 t11AcV0IP1gRqCYmW6KuehkjHI0zs8M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-orSCkSvbOhS5awcRN2Gnyw-1; Mon,
 16 Feb 2026 06:16:33 -0500
X-MC-Unique: orSCkSvbOhS5awcRN2Gnyw-1
X-Mimecast-MFC-AGG-ID: orSCkSvbOhS5awcRN2Gnyw_1771240591
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 125B9180047F; Mon, 16 Feb 2026 11:16:31 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 37C5E18003F5; Mon, 16 Feb 2026 11:16:29 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:08 +0100
Subject: [PATCH 19/85] audio: constify audsettings argument
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-19-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4072;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=H6n2uw6uj550TicI/7n5wOdjySxspRP/33lyJ5l2eig=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxOMws7WNYm/ZuK05nJjbuIFb6UOyEwrRK2m
 IvOqgGlWKWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8TgAKCRDa6OEJdZac
 5cfnEACA51/pvVdJhl5JbUBKtvX4vKk4LjULhzf9QOViMuTHEXT8QLpZNsJRGr+ZLSOaoW3w7m6
 Fgc5se7RSlN7CcwoAZOVdfjEuAxB6Plr8ZOOjNkatHOMSowPZEWgrebqnMgEecroyt8SS6rJdOv
 bAQWKcTNqFKt5ihtCItzVYPG9F3ASSOA1HgUDvSrz8ptAJJY5WspvTZb7KId0Vd5ZG+OwmB3Qv/
 d+4DGBhOc5eL+mYao06G1Fl88fa49MLvqA2Fz9tChwgieiuCsnC+EMUPLCXssCaURul2/xumaKE
 iqRLyRJP+qR/3agfcS9e/JT3dCqYP6/VcROQgWRl6mebTcNFDPIJh4/NvG5/Y7P0rkBRQWFjZTQ
 jaU4wPhaijevwEUD58g3yzNG7U65s9uAQODrWCIiF7fF0XIXBEoM09XUJlfQi2HVwhzWGSoUYuU
 bM2tIfyjRZ+lBuZRPACIbkMV21mtzzDPQYwc3R1YYTJKE+rpaRHrJYWCjaXrY2zGfv7q426HXaA
 bY5b9RLRf1UfzFpkwvA2g+vG3lTnoLw/Ej5WLFbjHp5X9LaCDzirBMkzt0BAJpt2HFdMo7tB+KW
 vVFeybKBcRwli39MaUiTcKAanSLyoN+RhZy1EP4KgXaD7lUZJYgeJCPftZifYI/Zq8DRKA3Jo6y
 THMl1IyipPeVmDQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

It shouldn't be modified by the audio functions.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 audio/audio_int.h      | 2 +-
 audio/audio_template.h | 6 +++---
 include/qemu/audio.h   | 4 ++--
 audio/audio.c          | 8 ++++----
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 25de0e3f9cf..a6276375887 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -265,7 +265,7 @@ extern const char *audio_prio_list[];
 
 void audio_driver_register(audio_driver *drv);
 
-void audio_pcm_init_info (struct audio_pcm_info *info, struct audsettings *as);
+void audio_pcm_init_info (struct audio_pcm_info *info, const struct audsettings *as);
 void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len);
 
 int audio_bug (const char *funcname, int cond);
diff --git a/audio/audio_template.h b/audio/audio_template.h
index 1ab3c47fd76..e69e6e74570 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -159,7 +159,7 @@ static int glue (audio_pcm_sw_init_, TYPE) (
     SW *sw,
     HW *hw,
     const char *name,
-    struct audsettings *as
+    const struct audsettings *as
     )
 {
     int err;
@@ -426,7 +426,7 @@ static HW *glue(audio_pcm_hw_add_, TYPE)(AudioBackend *s, struct audsettings *as
 static SW *glue(audio_pcm_create_voice_pair_, TYPE)(
     AudioBackend *s,
     const char *sw_name,
-    struct audsettings *as
+    const struct audsettings *as
     )
 {
     SW *sw;
@@ -491,7 +491,7 @@ SW *glue (AUD_open_, TYPE) (
     const char *name,
     void *callback_opaque ,
     audio_callback_fn callback_fn,
-    struct audsettings *as
+    const struct audsettings *as
     )
 {
     AudioBackend *s = be;
diff --git a/include/qemu/audio.h b/include/qemu/audio.h
index a1a64ad340d..370e993f080 100644
--- a/include/qemu/audio.h
+++ b/include/qemu/audio.h
@@ -58,7 +58,7 @@ SWVoiceOut *AUD_open_out (
     const char *name,
     void *callback_opaque,
     audio_callback_fn callback_fn,
-    struct audsettings *settings
+    const struct audsettings *settings
     );
 
 void AUD_close_out (AudioBackend *be, SWVoiceOut *sw);
@@ -97,7 +97,7 @@ SWVoiceIn *AUD_open_in(
     const char *name,
     void *callback_opaque,
     audio_callback_fn callback_fn,
-    struct audsettings *settings
+    const struct audsettings *settings
     );
 
 void AUD_close_in(AudioBackend *be, SWVoiceIn *sw);
diff --git a/audio/audio.c b/audio/audio.c
index 68698b13e15..5dccb9b0a36 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -170,7 +170,7 @@ void AUD_log (const char *cap, const char *fmt, ...)
     va_end (ap);
 }
 
-static void audio_print_settings (struct audsettings *as)
+static void audio_print_settings (const struct audsettings *as)
 {
     dolog ("frequency=%d nchannels=%d fmt=", as->freq, as->nchannels);
 
@@ -216,7 +216,7 @@ static void audio_print_settings (struct audsettings *as)
     AUD_log (NULL, "\n");
 }
 
-static int audio_validate_settings (struct audsettings *as)
+static int audio_validate_settings (const struct audsettings *as)
 {
     int invalid;
 
@@ -241,7 +241,7 @@ static int audio_validate_settings (struct audsettings *as)
     return invalid ? -1 : 0;
 }
 
-static int audio_pcm_info_eq (struct audio_pcm_info *info, struct audsettings *as)
+static int audio_pcm_info_eq (struct audio_pcm_info *info, const struct audsettings *as)
 {
     int bits = 8;
     bool is_signed = false, is_float = false;
@@ -281,7 +281,7 @@ static int audio_pcm_info_eq (struct audio_pcm_info *info, struct audsettings *a
         && info->swap_endianness == (as->endianness != HOST_BIG_ENDIAN);
 }
 
-void audio_pcm_init_info (struct audio_pcm_info *info, struct audsettings *as)
+void audio_pcm_init_info (struct audio_pcm_info *info, const struct audsettings *as)
 {
     int bits = 8, mul;
     bool is_signed = false, is_float = false;

-- 
2.53.0


