Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B50BE7BD8C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 10:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrw4N-0001sl-Jz; Mon, 16 Feb 2026 05:43:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrw40-0001pM-8Z
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:42:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrw3y-0000y7-Fl
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:42:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771238565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a+cxlaNFYy99fV6iC6NoJX8UA3JXNvcFW8aev589keg=;
 b=LhMF5OeycUcLyQ6XJzWz4yOsZ0s6ptmylL4s+TAcuXCAgcBO1QxO28hW/UEas8b0wM7h54
 Ny71jiu0XdCP2DN9JkHPR0cGoTxtTz6raZ6s4530eCd+838+PXfzxrw8uR0Y5uREuC5JTx
 hJIDVG49WKXEyOXQJvNNvvjCs1AjgPI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-9TXNNgeLMJaY5VQgo5FWBQ-1; Mon,
 16 Feb 2026 05:42:41 -0500
X-MC-Unique: 9TXNNgeLMJaY5VQgo5FWBQ-1
X-Mimecast-MFC-AGG-ID: 9TXNNgeLMJaY5VQgo5FWBQ_1771238559
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E23E6195DE50; Mon, 16 Feb 2026 10:42:38 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A0A3E1955F43; Mon, 16 Feb 2026 10:42:37 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 11:42:13 +0100
Subject: [PATCH 01/85] audio: remove obsolete/obscure functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-1-edcb25699381@redhat.com>
References: <20260216-audio-v1-0-edcb25699381@redhat.com>
In-Reply-To: <20260216-audio-v1-0-edcb25699381@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4945;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=uYrPkyR2tbIVOyryH+czFSaxcbDkF6UtkEqgWhCJ+H4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvSSpgr3KXvBW/Uuue5UDXDuIDk3G1LZmXvF6
 jtx43sDOSmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL0kgAKCRDa6OEJdZac
 5UybD/0R3v2fVDEOAX71TfgWzEMJ+BVr9MMlF36LnZwNCbPefK58Bj4FQdun3h6bymu8pieS/fp
 fpy5Slj0xQhOOvWGwR7JoYwpyY0TLXgdHg4OK+E99El+BEo+963I+wRMTL0VzjZJWhs8YX5CAp2
 dNIo+ZUqEocIc8NopNbvxDMORMQfVeT2DmP+ff7KwYeBSg0wAjjBCFK1NIQVNZBxPSv4ThzbAXy
 PRvppcgq0oLVAlrEpaQnXXCt3BXkhD5/9xe7OMdNeo9WU5oynJhkLGSz6ZYpf3ZeblAU81viu/9
 yxwZ7kbkC3ei6w9d9TWIQwf9PMHEtEDV0CW+pA9nri7AQPup/Gh0tb4uzBi6ryHnT0yafz2ACYB
 nZoUgL88AFFlsKNDWM6Ha02+Bx8wIoAFdTb2OHTyymIVWcDbJY4uW2f9hwBmf8uO/MJGHTlMl1o
 MJoybXI7arZEIZaiMqIjRjxXYjJS4MZF9e+3q7vuQ8/JJcz5bIazhoS+W9efrz2EoyvI7dG7s+q
 nLqcgmldCHRIv+wHq9eO3ISWBRnX46Aal++Th07bixJpd9KCfDOotht0FokG3J7qf1ugQ3ovtPc
 YBD9BCKFU2o9AdsPc7UrYRw7MsspVfxlIdJ6n0JevDVLeNNv8pjwPqpKnOVitW6gt0UTx8k+QfG
 p5JOFa7fjlHZX3w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

AUD_init_time_stamp_{in,out} and AUD_get_elapsed_usec_{in,out} are only
used by the adlib device. The result isn't actually being used since
ADLIB_KILL_TIMERS was set some 20y ago. Let's drop this dead code now.

Drop QEMUAudioTimeStamp as well as reported by Akihiko Odaki.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 audio/audio_template.h                             | 34 ----------------------
 include/qemu/audio.h                               | 10 -------
 hw/audio/adlib.c                                   | 18 +-----------
 .../codeconverter/codeconverter/test_regexps.py    |  1 -
 4 files changed, 1 insertion(+), 62 deletions(-)

diff --git a/audio/audio_template.h b/audio/audio_template.h
index 7a8c431f2d7..1ab3c47fd76 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -569,40 +569,6 @@ bool glue(AUD_is_active_, TYPE)(SW *sw)
     return sw ? sw->active : 0;
 }
 
-void glue (AUD_init_time_stamp_, TYPE) (SW *sw, QEMUAudioTimeStamp *ts)
-{
-    if (!sw) {
-        return;
-    }
-
-    ts->old_ts = sw->hw->ts_helper;
-}
-
-uint64_t glue (AUD_get_elapsed_usec_, TYPE) (SW *sw, QEMUAudioTimeStamp *ts)
-{
-    uint64_t delta, cur_ts, old_ts;
-
-    if (!sw) {
-        return 0;
-    }
-
-    cur_ts = sw->hw->ts_helper;
-    old_ts = ts->old_ts;
-    /* dolog ("cur %" PRId64 " old %" PRId64 "\n", cur_ts, old_ts); */
-
-    if (cur_ts >= old_ts) {
-        delta = cur_ts - old_ts;
-    } else {
-        delta = UINT64_MAX - old_ts + cur_ts;
-    }
-
-    if (!delta) {
-        return 0;
-    }
-
-    return muldiv64 (delta, sw->hw->info.freq, 1000000);
-}
-
 #undef TYPE
 #undef HW
 #undef SW
diff --git a/include/qemu/audio.h b/include/qemu/audio.h
index a92e0b70ef0..a1a64ad340d 100644
--- a/include/qemu/audio.h
+++ b/include/qemu/audio.h
@@ -50,10 +50,6 @@ struct AudioBackendClass {
 
 typedef struct AudioBackend AudioBackend;
 
-typedef struct QEMUAudioTimeStamp {
-    uint64_t old_ts;
-} QEMUAudioTimeStamp;
-
 bool AUD_backend_check(AudioBackend **be, Error **errp);
 
 SWVoiceOut *AUD_open_out (
@@ -71,9 +67,6 @@ int  AUD_get_buffer_size_out (SWVoiceOut *sw);
 void AUD_set_active_out(SWVoiceOut *sw, bool on);
 bool AUD_is_active_out(SWVoiceOut *sw);
 
-void     AUD_init_time_stamp_out (SWVoiceOut *sw, QEMUAudioTimeStamp *ts);
-uint64_t AUD_get_elapsed_usec_out (SWVoiceOut *sw, QEMUAudioTimeStamp *ts);
-
 #define AUDIO_MAX_CHANNELS 16
 typedef struct Volume {
     bool mute;
@@ -112,9 +105,6 @@ size_t AUD_read (SWVoiceIn *sw, void *pcm_buf, size_t size);
 void AUD_set_active_in(SWVoiceIn *sw, bool on);
 bool AUD_is_active_in(SWVoiceIn *sw);
 
-void     AUD_init_time_stamp_in (SWVoiceIn *sw, QEMUAudioTimeStamp *ts);
-uint64_t AUD_get_elapsed_usec_in (SWVoiceIn *sw, QEMUAudioTimeStamp *ts);
-
 void audio_cleanup(void);
 
 typedef struct st_sample st_sample;
diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index 8b9fe53e17b..efab5107a4c 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -34,8 +34,6 @@
 
 #define DEBUG 0
 
-#define ADLIB_KILL_TIMERS 1
-
 #define ADLIB_DESC "Yamaha YM3812 (OPL2)"
 
 #if DEBUG
@@ -71,7 +69,6 @@ struct AdlibState {
     uint64_t dexp[2];
     SWVoiceOut *voice;
     int left, pos, samples;
-    QEMUAudioTimeStamp ats;
     FM_OPL *opl;
     PortioList port_list;
 };
@@ -88,19 +85,7 @@ static void adlib_kill_timers (AdlibState *s)
 
     for (i = 0; i < 2; ++i) {
         if (s->ticking[i]) {
-            uint64_t delta;
-
-            delta = AUD_get_elapsed_usec_out (s->voice, &s->ats);
-            ldebug (
-                "delta = %f dexp = %f expired => %d",
-                delta / 1000000.0,
-                s->dexp[i] / 1000000.0,
-                delta >= s->dexp[i]
-                );
-            if (ADLIB_KILL_TIMERS || delta >= s->dexp[i]) {
-                adlib_stop_opl_timer (s, i);
-                AUD_init_time_stamp_out (s->voice, &s->ats);
-            }
+            adlib_stop_opl_timer(s, i);
         }
     }
 }
@@ -149,7 +134,6 @@ static void timer_handler (void *opaque, int c, double interval_Sec)
 #endif
 
     s->dexp[n] = interval_Sec * 1000000.0;
-    AUD_init_time_stamp_out (s->voice, &s->ats);
 }
 
 static int write_audio (AdlibState *s, int samples)
diff --git a/scripts/codeconverter/codeconverter/test_regexps.py b/scripts/codeconverter/codeconverter/test_regexps.py
index 2b9f5b80111..f92389e9618 100644
--- a/scripts/codeconverter/codeconverter/test_regexps.py
+++ b/scripts/codeconverter/codeconverter/test_regexps.py
@@ -202,7 +202,6 @@ def test_struct_re():
     uint64_t dexp[2];
     SWVoiceOut *voice;
     int left, pos, samples;
-    QEMUAudioTimeStamp ats;
     FM_OPL *opl;
     PortioList port_list;
 } AdlibState;

-- 
2.53.0


