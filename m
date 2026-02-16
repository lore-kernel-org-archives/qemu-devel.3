Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA38E7BD92
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwfj-0000ts-S0; Mon, 16 Feb 2026 06:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwdT-0008Uh-Gq
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:19:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwdQ-0008Un-Il
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:19:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/L1qp3ldn5ldXcfT6BhehGpgMBZTb6wUy0XgMwt8eQ=;
 b=VgMVArvTB8xJTwvc7rh/ZGwk+mjQkxXXJEmHYZ0l4BESvvZF/EDwV3ydppf66QdA8EG3kI
 3VKdbOm3V2J0pW7pwb1PhBKbuneXtVDtXqgNHhzBAIikfS4mqsI9fPnK3CWs9RetprJd/H
 ahMlnWaStCoqI5Pa5Q0oQ1PoEljuxSs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-ij9K_VF3OMeyv3ibV2-OZA-1; Mon,
 16 Feb 2026 06:19:20 -0500
X-MC-Unique: ij9K_VF3OMeyv3ibV2-OZA-1
X-Mimecast-MFC-AGG-ID: ij9K_VF3OMeyv3ibV2-OZA_1771240758
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7B711956050; Mon, 16 Feb 2026 11:19:18 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A059519560A2; Mon, 16 Feb 2026 11:19:17 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:16:07 +0100
Subject: [PATCH 78/85] audio: replace DEBUG_AUDIO with trace
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-78-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2400;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=xQHNvgrEZK26gRRFzeS01/f7AY6vbpJbR/MSqj2WBVI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxSjsTCtVBufqbWe12dQHHQP4s2y6y0BeiKl
 6xSWk4QUzeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8UgAKCRDa6OEJdZac
 5UxLEACRC7wS8hTEs8W4MzLQqSnqwSWssu9QpJ6ji7QfaHvm3NCgQQ3Bzq0KH8ql/P1Iev0CNFi
 MOt9Ma3s4FOsX3tHDzeTlqQICKX5EZIESDFeQ9/sJdkjoQ4rcqHGcsDZF+7vVKWlP4LM2A21Fel
 JfVLs6lThdyoV8fJdsliaJptYgtQ+3t9y0MrYgFrp/YJviL8tM0Q2pnlglbVyo4HS3h4JpH8L3i
 P7jE4vpsZq/tSL2ubW76BBxqlDVerx6CNQZVR99G/tG8L0Zs3cscckS3hgwQbOYqltchzhMQaW/
 2mI7X+YfoIYG4WnyZnwY4dIdvTn1SfyN7xWoMd8bNJASQODHa+R/+X79rdUpHCaPBI9DiAyMyHE
 HfuNnNv5X90Y0oeTSCx2HFsP2xAqSiGKjiRwgwHUEBNYVkdlJAW+JhSEXOspYSxQ2C07PZbuQTz
 P0w5OD5N6TyUxPGr2a4KAMF2TtOYIq6/97MvyirRuhysY8BVHr8U7UeDt2RFszuBLWc47uaLG0H
 6pK7EIWpIqZ8HiBqlwCsOxRmoSyIM9RvpVljHvE7RQexh1luM4Db1oI3pt/Kwn+6pj4w2DoGIho
 I8v5aGf2zwGbIiV+zUqPeiKfarIYX3ZvScTDSkJyIAmQOMG8nkDK9/0TciQNdPeZgD7PGBDkLCO
 0FLSjghCKLeYq2Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
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
index 3dd9d17dd25..7eabb1c2505 100644
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
2.53.0


