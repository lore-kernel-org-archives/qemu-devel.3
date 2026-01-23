Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11866D72347
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 07:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjBxj-0004TH-Jk; Fri, 23 Jan 2026 02:52:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vjBxC-0003nI-Mf
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 02:51:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vjBxB-0002AU-5m
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 02:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769154696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eDump8b9z5E+hvAg8iPkRAOGIIaU9iHnGICVnPuuMNU=;
 b=DT7ld48Jn/7r1rRGqLZCJXHZ/jlNlYrwc2gQfmFkq+at7F4TVyfibvUzNTZXensbKWPp4I
 tnAZL3VFd95HhCnSdm8IZM+m+Ryrf36r3E2ZI15DhuuRfi3BompeZ6GEp2RftjwJyXOveu
 XzDm2CN0cXS7x+q5n9aSf+bUpFhAyWs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-0lbfY2XsNDqSpcH8GVM02A-1; Fri,
 23 Jan 2026 02:51:34 -0500
X-MC-Unique: 0lbfY2XsNDqSpcH8GVM02A-1
X-Mimecast-MFC-AGG-ID: 0lbfY2XsNDqSpcH8GVM02A_1769154693
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7D7019560AA; Fri, 23 Jan 2026 07:51:33 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5DC42180049F; Fri, 23 Jan 2026 07:51:31 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 17/37] audio: constify audsettings argument
Date: Fri, 23 Jan 2026 11:49:20 +0400
Message-ID: <20260123074945.2563196-18-marcandre.lureau@redhat.com>
In-Reply-To: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

It shouldn't be modified by the audio functions.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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
index 5b9d352f325..6eb921f0cca 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -169,7 +169,7 @@ void AUD_log (const char *cap, const char *fmt, ...)
     va_end (ap);
 }
 
-static void audio_print_settings (struct audsettings *as)
+static void audio_print_settings (const struct audsettings *as)
 {
     dolog ("frequency=%d nchannels=%d fmt=", as->freq, as->nchannels);
 
@@ -215,7 +215,7 @@ static void audio_print_settings (struct audsettings *as)
     AUD_log (NULL, "\n");
 }
 
-static int audio_validate_settings (struct audsettings *as)
+static int audio_validate_settings (const struct audsettings *as)
 {
     int invalid;
 
@@ -240,7 +240,7 @@ static int audio_validate_settings (struct audsettings *as)
     return invalid ? -1 : 0;
 }
 
-static int audio_pcm_info_eq (struct audio_pcm_info *info, struct audsettings *as)
+static int audio_pcm_info_eq (struct audio_pcm_info *info, const struct audsettings *as)
 {
     int bits = 8;
     bool is_signed = false, is_float = false;
@@ -280,7 +280,7 @@ static int audio_pcm_info_eq (struct audio_pcm_info *info, struct audsettings *a
         && info->swap_endianness == (as->endianness != HOST_BIG_ENDIAN);
 }
 
-void audio_pcm_init_info (struct audio_pcm_info *info, struct audsettings *as)
+void audio_pcm_init_info (struct audio_pcm_info *info, const struct audsettings *as)
 {
     int bits = 8, mul;
     bool is_signed = false, is_float = false;
-- 
2.52.0


