Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8E3D116F5
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 11:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ20b-00005H-4f; Mon, 01 Dec 2025 06:24:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ20J-0008SG-9W
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:23:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ20H-0006Vf-Mx
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:23:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764588217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3kYSTSuwqhKH9Sm+PFHYKfCorVGrfWqK5KxrHlVSMac=;
 b=XMs4vpQh4SrNweEjJkQZGCHM9/ImWI3udnX+UdbN0AEdXWqLG4G7++ljOBYG/d2jpsLwyB
 M24cOeOeLyF5Nq+HKz1CK8NuHwqEdOg10SBm3MqWAn+gh76houi5oAmAO7CD26+IzRvzbq
 XG6qPVsEGSV+cb14DhNHaykW7tg14M0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-0_rzaTGSOc6vRU6lOowJrg-1; Mon,
 01 Dec 2025 06:23:31 -0500
X-MC-Unique: 0_rzaTGSOc6vRU6lOowJrg-1
X-Mimecast-MFC-AGG-ID: 0_rzaTGSOc6vRU6lOowJrg_1764588210
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C134718001FE; Mon,  1 Dec 2025 11:23:29 +0000 (UTC)
Received: from localhost (unknown [10.45.242.40])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C130530001A4; Mon,  1 Dec 2025 11:23:27 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Ratchov <alex@caoua.org>, dirty.ice.hu@gmail.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [RFC 02/24] audio: remove obsolete/obscure functions
Date: Mon,  1 Dec 2025 15:22:43 +0400
Message-ID: <20251201112309.4163921-3-marcandre.lureau@redhat.com>
In-Reply-To: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

AUD_init_time_stamp_{in,out} and AUD_get_elapsed_usec_{in,out} are only
used by the adlib device. The result isn't actually being used since
ADLIB_KILL_TIMERS was set some 20y ago. Let's drop this dead code now.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_template.h | 34 ----------------------------------
 include/qemu/audio.h   |  6 ------
 hw/audio/adlib.c       | 18 +-----------------
 3 files changed, 1 insertion(+), 57 deletions(-)

diff --git a/audio/audio_template.h b/audio/audio_template.h
index 7a8c431f2d..1ab3c47fd7 100644
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
index c56af895d6..2562710bec 100644
--- a/include/qemu/audio.h
+++ b/include/qemu/audio.h
@@ -71,9 +71,6 @@ int  AUD_get_buffer_size_out (SWVoiceOut *sw);
 void AUD_set_active_out(SWVoiceOut *sw, bool on);
 bool AUD_is_active_out(SWVoiceOut *sw);
 
-void     AUD_init_time_stamp_out (SWVoiceOut *sw, QEMUAudioTimeStamp *ts);
-uint64_t AUD_get_elapsed_usec_out (SWVoiceOut *sw, QEMUAudioTimeStamp *ts);
-
 #define AUDIO_MAX_CHANNELS 16
 typedef struct Volume {
     bool mute;
@@ -112,9 +109,6 @@ size_t AUD_read (SWVoiceIn *sw, void *pcm_buf, size_t size);
 void AUD_set_active_in(SWVoiceIn *sw, bool on);
 bool AUD_is_active_in(SWVoiceIn *sw);
 
-void     AUD_init_time_stamp_in (SWVoiceIn *sw, QEMUAudioTimeStamp *ts);
-uint64_t AUD_get_elapsed_usec_in (SWVoiceIn *sw, QEMUAudioTimeStamp *ts);
-
 void audio_cleanup(void);
 
 typedef struct st_sample st_sample;
diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index 19d3a5f128..2a2fe7d04f 100644
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
-- 
2.51.1


