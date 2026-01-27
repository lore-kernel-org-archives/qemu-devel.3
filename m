Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B76CD2FED2
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vknrG-0000GI-0k; Tue, 27 Jan 2026 13:32:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vknoV-00023u-V8
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:29:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vknoT-0003aB-NJ
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769538554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JBLZzFOFTuMbO24GgEzA2JXkR7wNLOYd6Ot73CMXjXQ=;
 b=Wk89FFa3vwPwEgRiqB1X72/uRYdW0Wfa2ZM866juONeJtqNDHZfEj+VbCnhSmZgXggJljL
 0lk9WG0WNtzqmIR1h0XBbURZEc7W1TQBwrJmRXznoUegwFdI3niFbc+pH7M1UVB2hNMWFi
 +F18M0KYbgoU0UsN8R63qTGXIpyarrI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-fhnXwbArNzSJyEJPiY3oZA-1; Tue,
 27 Jan 2026 13:29:12 -0500
X-MC-Unique: fhnXwbArNzSJyEJPiY3oZA-1
X-Mimecast-MFC-AGG-ID: fhnXwbArNzSJyEJPiY3oZA_1769538547
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10A20192D0F6; Tue, 27 Jan 2026 18:29:05 +0000 (UTC)
Received: from localhost (unknown [10.45.242.23])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 57480195419C; Tue, 27 Jan 2026 18:29:00 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 37/43] audio: replace DEBUG_AUDIO with trace
Date: Tue, 27 Jan 2026 22:25:04 +0400
Message-ID: <20260127182516.289834-38-marcandre.lureau@redhat.com>
In-Reply-To: <20260127182516.289834-1-marcandre.lureau@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_template.h  | 10 +++++-----
 audio/audio-mixeng-be.c |  9 ---------
 audio/trace-events      |  1 +
 3 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/audio/audio_template.h b/audio/audio_template.h
index c47a2f202f0..e884c8e9b1a 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -556,11 +556,11 @@ static SW *glue(audio_mixeng_backend_open_, TYPE) (
     sw->callback.fn = callback_fn;
     sw->callback.opaque = callback_opaque;
 
-#ifdef DEBUG_AUDIO
-    dolog ("%s\n", name);
-    audio_pcm_print_info ("hw", &sw->hw->info);
-    audio_pcm_print_info ("sw", &sw->info);
-#endif
+    trace_audio_voice_pair(G_STRINGIFY(TYPE), name,
+                           AudioFormat_str(sw->hw->info.af),
+                           sw->hw->info.freq, sw->hw->info.nchannels,
+                           AudioFormat_str(sw->info.af),
+                           sw->info.freq, sw->info.nchannels);
 
     return sw;
 
diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
index 5303c08a285..5165768a531 100644
--- a/audio/audio-mixeng-be.c
+++ b/audio/audio-mixeng-be.c
@@ -620,15 +620,6 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *buf, size_t buf_len)
     return total_in * sw->info.bytes_per_frame;
 }
 
-#ifdef DEBUG_AUDIO
-static void audio_pcm_print_info (const char *cap, struct audio_pcm_info *info)
-{
-    dolog("%s: %s, freq %d, nchan %d\n",
-          cap, AudioFormat_str(info->af), info->freq,
-          info->nchannels);
-}
-#endif
-
 #define DAC
 #include "audio_template.h"
 #undef DAC
diff --git a/audio/trace-events b/audio/trace-events
index 7a73d6eb84f..ed04792d508 100644
--- a/audio/trace-events
+++ b/audio/trace-events
@@ -74,3 +74,4 @@ audio_out_played(size_t played) "played=%zu"
 # audio_template.h
 audio_open_out(const char *name, int freq, int nchannels, int fmt) "open %s, freq %d, nchannels %d, fmt %d"
 audio_open_in(const char *name, int freq, int nchannels, int fmt) "open %s, freq %d, nchannels %d, fmt %d"
+audio_voice_pair(const char *type, const char *name, const char *hw_fmt, int hw_freq, int hw_nchannels, const char *sw_fmt, int sw_freq, int sw_nchannels) "%s: name=%s hw=%s/%d/%d sw=%s/%d/%d"
-- 
2.52.0


