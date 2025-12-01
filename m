Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB4FD116F5
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 11:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ22F-0004Yv-By; Mon, 01 Dec 2025 06:25:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ229-0004DI-Bv
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:25:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ21l-0006sT-J8
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764588304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SjlS5jM2VJyjoucUnciKUWXKQgrLk2dMyYE8uQ43Koc=;
 b=J1+tuWCUug+gRuzD+JFT956adwVS/l6tez51pnOkLe885N/yla/gtbbySv/opx11a+LJuF
 mJiN4L6w/vK/TPQdwlVF0UGCscHgBYsieEDqrDQzjjGaKUE+kLEhZP9hSKOWOHJ4r5sj9I
 ZED6zQQ6jK96ABXv9V5Ch2jd2moYVBc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528--mAunWC7MrqrahD7a1k-Yg-1; Mon,
 01 Dec 2025 06:25:01 -0500
X-MC-Unique: -mAunWC7MrqrahD7a1k-Yg-1
X-Mimecast-MFC-AGG-ID: -mAunWC7MrqrahD7a1k-Yg_1764588300
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D89C1955DC0; Mon,  1 Dec 2025 11:25:00 +0000 (UTC)
Received: from localhost (unknown [10.45.242.40])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A64861800451; Mon,  1 Dec 2025 11:24:58 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Ratchov <alex@caoua.org>, dirty.ice.hu@gmail.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC 16/24] replay: remove dependency on audio/
Date: Mon,  1 Dec 2025 15:22:57 +0400
Message-ID: <20251201112309.4163921-17-marcandre.lureau@redhat.com>
In-Reply-To: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The replay infrastructure shouldn't depend on internals of audio/.
(st_sample is an internal implementation detail and could be different)

Let audio drive the audio samples recording/replaying.

Notice also we don't need to save & restore the internal ring "wpos",
all replay should care about is the number of samples and the samples.

Bump the replay version.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_int.h        |  5 ++++
 include/qemu/audio.h     |  5 ----
 include/system/replay.h  |  8 +++++--
 replay/replay-internal.h |  2 ++
 audio/audio.c            | 23 ++++++++++++++++--
 replay/replay-audio.c    | 51 +++++++++++++++++++++++-----------------
 replay/replay.c          |  2 +-
 replay/stubs-system.c    |  8 ++++++-
 8 files changed, 72 insertions(+), 32 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index d2d54b924e..79e54fd60a 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -316,6 +316,11 @@ static inline size_t audio_ring_posb(size_t pos, size_t dist, size_t len)
 AudiodevPerDirectionOptions *audio_get_pdo_in(Audiodev *dev);
 AudiodevPerDirectionOptions *audio_get_pdo_out(Audiodev *dev);
 
+void audio_sample_to_uint64(const st_sample *sample, int pos,
+                            uint64_t *left, uint64_t *right);
+void audio_sample_from_uint64(st_sample *sample, int pos,
+                              uint64_t left, uint64_t right);
+
 #define TYPE_AUDIO_DRIVER "audio-driver"
 OBJECT_DECLARE_TYPE(AudioDriver, AudioDriverClass, AUDIO_DRIVER)
 
diff --git a/include/qemu/audio.h b/include/qemu/audio.h
index 3abf1037f8..07a2e23998 100644
--- a/include/qemu/audio.h
+++ b/include/qemu/audio.h
@@ -124,11 +124,6 @@ void audio_cleanup(void);
 
 typedef struct st_sample st_sample;
 
-void audio_sample_to_uint64(const st_sample *sample, int pos,
-                            uint64_t *left, uint64_t *right);
-void audio_sample_from_uint64(st_sample *sample, int pos,
-                            uint64_t left, uint64_t right);
-
 void audio_add_audiodev(Audiodev *audio);
 void audio_add_default_audiodev(Audiodev *dev, Error **errp);
 void audio_parse_option(const char *opt);
diff --git a/include/system/replay.h b/include/system/replay.h
index 68f91bdfbf..0ee5230586 100644
--- a/include/system/replay.h
+++ b/include/system/replay.h
@@ -165,8 +165,12 @@ void replay_net_packet_event(ReplayNetState *rns, unsigned flags,
 
 /*! Saves/restores number of played samples of audio out operation. */
 void replay_audio_out(size_t *played);
-/*! Saves/restores recorded samples of audio in operation. */
-void replay_audio_in(size_t *recorded, st_sample *samples, size_t *wpos, size_t size);
+/*! Start saves/restores recorded samples of audio in operation, must be called before replay_audio_in_sample_lr(). */
+void replay_audio_in_start(size_t *recorded);
+/*! Saves/restores recorded samples. */
+void replay_audio_in_sample_lr(uint64_t *left, uint64_t *right);
+/*! Finish saves/restores recorded samples. */
+void replay_audio_in_finish(void);
 
 /* VM state operations */
 
diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index 75249b7693..643b357da1 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -85,6 +85,7 @@ enum ReplayEvents {
  * @file_offset: offset into replay log at replay snapshot
  * @block_request_id: current serialised block request id
  * @read_event_id: current async read event id
+ * @n_audio_samples: expected audio samples
  */
 typedef struct ReplayState {
     int64_t cached_clock[REPLAY_CLOCK_COUNT];
@@ -96,6 +97,7 @@ typedef struct ReplayState {
     uint64_t file_offset;
     uint64_t block_request_id;
     uint64_t read_event_id;
+    size_t n_audio_samples;
 } ReplayState;
 extern ReplayState replay_state;
 
diff --git a/audio/audio.c b/audio/audio.c
index 7e5fb4ff8a..f0e31ce4a0 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1301,13 +1301,32 @@ static void audio_run_in(AudioDriver *s)
     while ((hw = audio_pcm_hw_find_any_enabled_in(s, hw))) {
         SWVoiceIn *sw;
         size_t captured = 0, min;
+        int pos;
 
         if (replay_mode != REPLAY_MODE_PLAY) {
             captured = audio_pcm_hw_run_in(
                 hw, hw->conv_buf.size - audio_pcm_hw_get_live_in(hw));
         }
-        replay_audio_in(&captured, hw->conv_buf.buffer, &hw->conv_buf.pos,
-                        hw->conv_buf.size);
+
+        replay_audio_in_start(&captured);
+        assert(captured <= hw->conv_buf.size);
+        if (replay_mode == REPLAY_MODE_PLAY) {
+            hw->conv_buf.pos = (hw->conv_buf.pos + captured) % hw->conv_buf.size;
+        }
+        for (pos = (hw->conv_buf.pos - captured + hw->conv_buf.size) % hw->conv_buf.size;
+             pos != hw->conv_buf.pos;
+             pos = (pos + 1) % hw->conv_buf.size) {
+                uint64_t left, right;
+
+                if (replay_mode == REPLAY_MODE_RECORD) {
+                    audio_sample_to_uint64(hw->conv_buf.buffer, pos, &left, &right);
+                }
+                replay_audio_in_sample_lr(&left, &right);
+                if (replay_mode == REPLAY_MODE_PLAY) {
+                    audio_sample_from_uint64(hw->conv_buf.buffer, pos, left, right);
+                }
+        }
+        replay_audio_in_finish();
 
         min = audio_pcm_hw_find_min_in (hw);
         hw->total_samples_captured += captured - min;
diff --git a/replay/replay-audio.c b/replay/replay-audio.c
index 1b614f4137..7d20ae9110 100644
--- a/replay/replay-audio.c
+++ b/replay/replay-audio.c
@@ -13,7 +13,6 @@
 #include "qemu/error-report.h"
 #include "system/replay.h"
 #include "replay-internal.h"
-#include "qemu/audio.h"
 
 void replay_audio_out(size_t *played)
 {
@@ -35,38 +34,48 @@ void replay_audio_out(size_t *played)
     }
 }
 
-void replay_audio_in(size_t *recorded, st_sample *samples, size_t *wpos, size_t size)
+void replay_audio_in_start(size_t *nsamples)
 {
-    int pos;
-    uint64_t left, right;
     if (replay_mode == REPLAY_MODE_RECORD) {
         g_assert(replay_mutex_locked());
         replay_save_instructions();
         replay_put_event(EVENT_AUDIO_IN);
-        replay_put_qword(*recorded);
-        replay_put_qword(*wpos);
-        for (pos = (*wpos - *recorded + size) % size ; pos != *wpos
-             ; pos = (pos + 1) % size) {
-            audio_sample_to_uint64(samples, pos, &left, &right);
-            replay_put_qword(left);
-            replay_put_qword(right);
-        }
+        replay_put_qword(*nsamples);
+        replay_state.n_audio_samples = *nsamples;
     } else if (replay_mode == REPLAY_MODE_PLAY) {
         g_assert(replay_mutex_locked());
         replay_account_executed_instructions();
         if (replay_next_event_is(EVENT_AUDIO_IN)) {
-            *recorded = replay_get_qword();
-            *wpos = replay_get_qword();
-            for (pos = (*wpos - *recorded + size) % size ; pos != *wpos
-                 ; pos = (pos + 1) % size) {
-                left = replay_get_qword();
-                right = replay_get_qword();
-                audio_sample_from_uint64(samples, pos, left, right);
-            }
-            replay_finish_event();
+            *nsamples = replay_get_qword();
+            replay_state.n_audio_samples = *nsamples;
         } else {
             error_report("Missing audio in event in the replay log");
             abort();
         }
     }
 }
+
+void replay_audio_in_sample_lr(uint64_t *left, uint64_t *right)
+{
+    if (replay_mode == REPLAY_MODE_RECORD) {
+        replay_put_qword(*left);
+        replay_put_qword(*right);
+    } else if (replay_mode == REPLAY_MODE_PLAY) {
+        *left = replay_get_qword();
+        *right = replay_get_qword();
+    } else {
+        return;
+    }
+
+    assert(replay_state.n_audio_samples > 0);
+    replay_state.n_audio_samples--;
+}
+
+void replay_audio_in_finish(void)
+{
+    assert(replay_state.n_audio_samples == 0);
+
+    if (replay_mode == REPLAY_MODE_PLAY) {
+        replay_finish_event();
+    }
+}
diff --git a/replay/replay.c b/replay/replay.c
index b2121788c1..2e5c6fa82e 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -22,7 +22,7 @@
 
 /* Current version of the replay mechanism.
    Increase it when file format changes. */
-#define REPLAY_VERSION              0xe0200c
+#define REPLAY_VERSION              0xe0200d
 /* Size of replay log header */
 #define HEADER_SIZE                 (sizeof(uint32_t) + sizeof(uint64_t))
 
diff --git a/replay/stubs-system.c b/replay/stubs-system.c
index 7f85764936..b2c52bc404 100644
--- a/replay/stubs-system.c
+++ b/replay/stubs-system.c
@@ -15,7 +15,13 @@ void replay_input_sync_event(void)
 void replay_add_blocker(const char *feature)
 {
 }
-void replay_audio_in(size_t *recorded, st_sample *samples, size_t *wpos, size_t size)
+void replay_audio_in_start(size_t *nsamples)
+{
+}
+void replay_audio_in_sample_lr(uint64_t *left, uint64_t *right)
+{
+}
+void replay_audio_in_finish(void)
 {
 }
 void replay_audio_out(size_t *played)
-- 
2.51.1


