Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A422CE9A03E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 09:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsdTE-0000ij-VR; Wed, 18 Feb 2026 04:03:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdTD-0000iF-Rk
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:03:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdTC-0008Ru-2Q
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:03:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771405421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LHlqBgh12YKNNRewWHcvCXhGSyIOzkU8EAa1DmmKP+0=;
 b=KdFzMEJEtOQwnJcbOycUNKOfFw7OiXIBXWNvwhAriNG0zNVPaP8wuX/r1g81Vjtc/d5Qyp
 +oz6Q2wk6tQFH1xjn2XDia9DEXlRiZjUQmCzbKYUoBUKeFtDkKuZscBuRSf/ogihUBK4u9
 P4363dsF75A7xsoga5uHOB98XA8c1lM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-bJwXkrHVNOqHyDCfj1tj7Q-1; Wed,
 18 Feb 2026 04:03:37 -0500
X-MC-Unique: bJwXkrHVNOqHyDCfj1tj7Q-1
X-Mimecast-MFC-AGG-ID: bJwXkrHVNOqHyDCfj1tj7Q_1771405416
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC88F1955D80; Wed, 18 Feb 2026 09:03:35 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E956119560AD; Wed, 18 Feb 2026 09:03:34 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 01/85] audio: remove obsolete/obscure functions
Date: Wed, 18 Feb 2026 10:02:01 +0100
Message-ID: <20260218090330.1476169-2-marcandre.lureau@redhat.com>
In-Reply-To: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
References: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
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
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

AUD_init_time_stamp_{in,out} and AUD_get_elapsed_usec_{in,out} are only
used by the adlib device. The result isn't actually being used since
ADLIB_KILL_TIMERS was set some 20y ago. Let's drop this dead code now.

Drop QEMUAudioTimeStamp as well as reported by Akihiko Odaki.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_template.h                        | 34 -------------------
 include/qemu/audio.h                          | 10 ------
 hw/audio/adlib.c                              | 18 +---------
 .../codeconverter/test_regexps.py             |  1 -
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


