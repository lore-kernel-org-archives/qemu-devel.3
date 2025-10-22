Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4373CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 07:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBSp9-0000Zt-NV; Wed, 22 Oct 2025 02:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBSp6-0000VS-6W
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:59:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBSp4-0008Ne-CE
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761116389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DKT1nXlJpI9tRXzouXdla7L7sC/MuqhqLow2hMhCfo0=;
 b=DD2XmVA2KQ8M4/4293Xl30hyThqov6WCkBVMvJ66ffM8+fFglcvGIuxXHF+0p8yqG737IZ
 82I8y6RVZ/zWfb9PU9b61hO5LW9s+iO7MdhkSbE5pFB9pRq6TU6l0eYBfH/TgXWiV4FBqv
 Y11A+njHYfFdrKiVy2hOActh1hJbyFA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-5XfCOtDJNWiZYOu9H9WvIg-1; Wed,
 22 Oct 2025 02:59:45 -0400
X-MC-Unique: 5XfCOtDJNWiZYOu9H9WvIg-1
X-Mimecast-MFC-AGG-ID: 5XfCOtDJNWiZYOu9H9WvIg_1761116384
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E5E91800C32; Wed, 22 Oct 2025 06:59:44 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CDB9A1800579; Wed, 22 Oct 2025 06:59:42 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 32/42] audio/replay: fix type punning
Date: Wed, 22 Oct 2025 10:56:27 +0400
Message-ID: <20251022065640.1172785-33-marcandre.lureau@redhat.com>
In-Reply-To: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
References: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio.h           | 6 ++++--
 audio/mixeng.h          | 1 -
 include/system/replay.h | 3 ++-
 audio/mixeng.c          | 6 ++----
 replay/replay-audio.c   | 2 +-
 replay/stubs-system.c   | 2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/audio/audio.h b/audio/audio.h
index 2175223ef6..68509fed58 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -160,9 +160,11 @@ int wav_start_capture(AudioState *state, CaptureState *s, const char *path,
 
 void audio_cleanup(void);
 
-void audio_sample_to_uint64(const void *samples, int pos,
+typedef struct st_sample st_sample;
+
+void audio_sample_to_uint64(const st_sample *sample, int pos,
                             uint64_t *left, uint64_t *right);
-void audio_sample_from_uint64(void *samples, int pos,
+void audio_sample_from_uint64(st_sample *sample, int pos,
                             uint64_t left, uint64_t right);
 
 void audio_add_audiodev(Audiodev *audio);
diff --git a/audio/mixeng.h b/audio/mixeng.h
index ead93ac2f7..f63283f408 100644
--- a/audio/mixeng.h
+++ b/audio/mixeng.h
@@ -33,7 +33,6 @@ struct st_sample { mixeng_real l; mixeng_real r; };
 struct mixeng_volume { int mute; int64_t r; int64_t l; };
 struct st_sample { int64_t l; int64_t r; };
 #endif
-typedef struct st_sample st_sample;
 
 typedef void (t_sample) (struct st_sample *dst, const void *src, int samples);
 typedef void (f_sample) (void *dst, const struct st_sample *src, int samples);
diff --git a/include/system/replay.h b/include/system/replay.h
index 1c87c97fdd..1e63c0784c 100644
--- a/include/system/replay.h
+++ b/include/system/replay.h
@@ -16,6 +16,7 @@
 #include "qapi/qapi-types-run-state.h"
 #include "qapi/qapi-types-ui.h"
 #include "block/aio.h"
+#include "audio/audio.h"
 
 /* replay clock kinds */
 enum ReplayClockKind {
@@ -165,7 +166,7 @@ void replay_net_packet_event(ReplayNetState *rns, unsigned flags,
 /*! Saves/restores number of played samples of audio out operation. */
 void replay_audio_out(size_t *played);
 /*! Saves/restores recorded samples of audio in operation. */
-void replay_audio_in(size_t *recorded, void *samples, size_t *wpos, size_t size);
+void replay_audio_in(size_t *recorded, st_sample *samples, size_t *wpos, size_t size);
 
 /* VM state operations */
 
diff --git a/audio/mixeng.c b/audio/mixeng.c
index be38617e9b..af9ec3d4d2 100644
--- a/audio/mixeng.c
+++ b/audio/mixeng.c
@@ -404,7 +404,7 @@ f_sample *mixeng_clip_float[2][2] = {
     }
 };
 
-void audio_sample_to_uint64(const void *samples, int pos,
+void audio_sample_to_uint64(const st_sample *sample, int pos,
                             uint64_t *left, uint64_t *right)
 {
 #ifdef FLOAT_MIXENG
@@ -412,14 +412,13 @@ void audio_sample_to_uint64(const void *samples, int pos,
         "Coreaudio and floating point samples are not supported by replay yet");
     abort();
 #else
-    const struct st_sample *sample = samples;
     sample += pos;
     *left = sample->l;
     *right = sample->r;
 #endif
 }
 
-void audio_sample_from_uint64(void *samples, int pos,
+void audio_sample_from_uint64(st_sample *sample, int pos,
                             uint64_t left, uint64_t right)
 {
 #ifdef FLOAT_MIXENG
@@ -427,7 +426,6 @@ void audio_sample_from_uint64(void *samples, int pos,
         "Coreaudio and floating point samples are not supported by replay yet");
     abort();
 #else
-    struct st_sample *sample = samples;
     sample += pos;
     sample->l = left;
     sample->r = right;
diff --git a/replay/replay-audio.c b/replay/replay-audio.c
index ed2ba2164b..3413801062 100644
--- a/replay/replay-audio.c
+++ b/replay/replay-audio.c
@@ -35,7 +35,7 @@ void replay_audio_out(size_t *played)
     }
 }
 
-void replay_audio_in(size_t *recorded, void *samples, size_t *wpos, size_t size)
+void replay_audio_in(size_t *recorded, st_sample *samples, size_t *wpos, size_t size)
 {
     int pos;
     uint64_t left, right;
diff --git a/replay/stubs-system.c b/replay/stubs-system.c
index 8f2b2d326e..7f85764936 100644
--- a/replay/stubs-system.c
+++ b/replay/stubs-system.c
@@ -15,7 +15,7 @@ void replay_input_sync_event(void)
 void replay_add_blocker(const char *feature)
 {
 }
-void replay_audio_in(size_t *recorded, void *samples, size_t *wpos, size_t size)
+void replay_audio_in(size_t *recorded, st_sample *samples, size_t *wpos, size_t size)
 {
 }
 void replay_audio_out(size_t *played)
-- 
2.51.0


