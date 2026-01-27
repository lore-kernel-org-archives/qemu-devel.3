Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0028AD2FEDC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vknrM-0001DY-5g; Tue, 27 Jan 2026 13:32:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vknor-0002Dx-Hk
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:29:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vknol-0003l8-8C
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:29:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769538571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sfrZY2yrYbtBdm8NY08D0va2e2kNv/cD6NJjXP0WpTk=;
 b=aw5a+5OH79MWH2SK96ROxP0JRlENVGkx1m+dRcZ2e1idyTDggcaEEXtfmv44yDGsmr3Y44
 jC8Pklc4iT612W7rnzzF47uoNW6mIgfHvddY6btx+VbUMq7JlteD8RWMI9gLfJeRgvmaUs
 kO6tCZfvZoG92PLSziHyEgrwglQOfYA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204--HEW5RWUOVGVnsmokwWG2A-1; Tue,
 27 Jan 2026 13:29:29 -0500
X-MC-Unique: -HEW5RWUOVGVnsmokwWG2A-1
X-Mimecast-MFC-AGG-ID: -HEW5RWUOVGVnsmokwWG2A_1769538567
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC1471977300; Tue, 27 Jan 2026 18:29:16 +0000 (UTC)
Received: from localhost (unknown [10.45.242.23])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5DEE71955F66; Tue, 27 Jan 2026 18:29:14 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 39/43] audio: rework invalid audsettings error
Date: Tue, 27 Jan 2026 22:25:06 +0400
Message-ID: <20260127182516.289834-40-marcandre.lureau@redhat.com>
In-Reply-To: <20260127182516.289834-1-marcandre.lureau@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
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

Currently, when given invalid settings, QEMU will print to stderr:

A bug was just triggered in audio_mixeng_backend_open_out
Save all your work and restart without audio
I am sorry
Context:
audio: frequency=44100 nchannels=0 fmt=S16 endianness=little

Now it will use error_report() and simply report:
audio: Invalid audio settings: frequency=44100 nchannels=0 fmt=s16 endian=little

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_template.h  |  5 +++--
 audio/audio-mixeng-be.c | 41 +++++++----------------------------------
 2 files changed, 10 insertions(+), 36 deletions(-)

diff --git a/audio/audio_template.h b/audio/audio_template.h
index e884c8e9b1a..5711f4a26e1 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -513,8 +513,9 @@ static SW *glue(audio_mixeng_backend_open_, TYPE) (
     trace_audio_open_in(name, as->freq, as->nchannels, as->fmt);
 #endif
 
-    if (audio_bug(__func__, audio_validate_settings(as))) {
-        audio_print_settings (as);
+    if (audio_validate_settings(as)) {
+        g_autofree char *str = audsettings_to_string(as);
+        error_report("audio: Invalid audio settings: %s", str);
         goto fail;
     }
 
diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
index 5165768a531..e8fae2ab977 100644
--- a/audio/audio-mixeng-be.c
+++ b/audio/audio-mixeng-be.c
@@ -101,38 +101,11 @@ void AUD_log (const char *cap, const char *fmt, ...)
     va_end (ap);
 }
 
-static void audio_print_settings (const struct audsettings *as)
+static char *audsettings_to_string(const struct audsettings *as)
 {
-    dolog ("frequency=%d nchannels=%d fmt=", as->freq, as->nchannels);
-
-    switch (as->fmt) {
-    case AUDIO_FORMAT_S8:
-        AUD_log (NULL, "S8");
-        break;
-    case AUDIO_FORMAT_U8:
-        AUD_log (NULL, "U8");
-        break;
-    case AUDIO_FORMAT_S16:
-        AUD_log (NULL, "S16");
-        break;
-    case AUDIO_FORMAT_U16:
-        AUD_log (NULL, "U16");
-        break;
-    case AUDIO_FORMAT_S32:
-        AUD_log (NULL, "S32");
-        break;
-    case AUDIO_FORMAT_U32:
-        AUD_log (NULL, "U32");
-        break;
-    case AUDIO_FORMAT_F32:
-        AUD_log (NULL, "F32");
-        break;
-    default:
-        AUD_log (NULL, "invalid(%d)", as->fmt);
-        break;
-    }
-
-    AUD_log (NULL, " endianness=%s\n", as->big_endian ? "big" : "little");
+    return g_strdup_printf("frequency=%d nchannels=%d fmt=%s endian=%s",
+                           as->freq, as->nchannels, AudioFormat_str(as->fmt),
+                           as->big_endian ? "big" : "little");
 }
 
 static int audio_validate_settings (const struct audsettings *as)
@@ -1607,9 +1580,9 @@ static CaptureVoiceOut *audio_mixeng_backend_add_capture(
         return NULL;
     }
 
-    if (audio_validate_settings (as)) {
-        dolog ("Invalid settings were passed when trying to add capture\n");
-        audio_print_settings (as);
+    if (audio_validate_settings(as)) {
+        g_autofree char *str = audsettings_to_string(as);
+        error_report("audio: Invalid audio settings when trying to add capture: %s", str);
         return NULL;
     }
 
-- 
2.52.0


