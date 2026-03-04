Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDA3EDEC12
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 06:17:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxfY8-0004Dy-Kf; Wed, 04 Mar 2026 01:17:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxfY2-0004D1-A6
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 01:17:30 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxfXz-0003Df-Kv
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 01:17:30 -0500
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6246H77u067747
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 4 Mar 2026 15:17:18 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=w61ce1R8XUXkpU7hpBsRGRcv0aB4Z5vn3TmzvMPi8Nc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1772605038; v=1;
 b=EtcLAHwb+RSDWtXVx9m586mJUlS6Z6zDMXtDthkvNKNCgCCqtbBjhs5LOf34TJpp
 qSHwFY0gQ2eFlc+1TBl/r6TQ0UDvPD5BJ2hRyEikIm6w1E6wd4tv4SclZ/Y1H7mb
 2p1zXnelMyrC2LwqBQs9dbtpoYOcFyGfh+od6MQiXdZXWv5BE0YNzYwm65HuykBD
 aEDl2v7/fUPIIvO6d1VFOVJ1wbFUIjG+k1eH5NC7x9Rn+R5rOWCF7bxO+AxzvRW2
 AeRVGYkS2xfYSsoQgwcZTKhIldpHmFd0ZK4kVPPuGLrBA+1cM6ArxUs6p6WADq7s
 3xGK1RSQhEr1OVZCoG+WEQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 04 Mar 2026 15:16:58 +0900
Subject: [PATCH v8 5/6] audio: Add functions to initialize buffers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-coreaudio-v8-5-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
References: <20260304-coreaudio-v8-0-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260304-coreaudio-v8-0-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
To: Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, devel@daynix.com,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>
X-Mailer: b4 0.15-dev-5ab4c
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

These functions can be used to re-initialize buffers when hardware
parameters change due to device hotplug, for example.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 audio/audio_int.h       |  2 ++
 audio/audio-mixeng-be.c | 24 ++++++++++++++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 06f79ade6b0a..290cf373b49f 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -141,9 +141,11 @@ static inline void *advance(void *p, size_t incr)
 int wav_start_capture(AudioBackend *state, CaptureState *s, const char *path,
                       int freq, int bits, int nchannels);
 
+void audio_generic_initialize_buffer_in(HWVoiceIn *hw);
 void audio_generic_run_buffer_in(HWVoiceIn *hw);
 void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t *size);
 void audio_generic_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size);
+void audio_generic_initialize_buffer_out(HWVoiceOut *hw);
 void audio_generic_run_buffer_out(HWVoiceOut *hw);
 size_t audio_generic_buffer_get_free(HWVoiceOut *hw);
 void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size);
diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
index 370404505111..1419e7521503 100644
--- a/audio/audio-mixeng-be.c
+++ b/audio/audio-mixeng-be.c
@@ -1187,14 +1187,20 @@ void audio_run(AudioMixengBackend *s, const char *msg)
     }
 }
 
+void audio_generic_initialize_buffer_in(HWVoiceIn *hw)
+{
+    g_free(hw->buf_emul);
+    hw->size_emul = hw->samples * hw->info.bytes_per_frame;
+    hw->buf_emul = g_malloc(hw->size_emul);
+    hw->pos_emul = hw->pending_emul = 0;
+}
+
 void audio_generic_run_buffer_in(HWVoiceIn *hw)
 {
     AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_GET_CLASS(hw->s);
 
     if (unlikely(!hw->buf_emul)) {
-        hw->size_emul = hw->samples * hw->info.bytes_per_frame;
-        hw->buf_emul = g_malloc(hw->size_emul);
-        hw->pos_emul = hw->pending_emul = 0;
+        audio_generic_initialize_buffer_in(hw);
     }
 
     while (hw->pending_emul < hw->size_emul) {
@@ -1227,6 +1233,14 @@ void audio_generic_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size)
     hw->pending_emul -= size;
 }
 
+void audio_generic_initialize_buffer_out(HWVoiceOut *hw)
+{
+    g_free(hw->buf_emul);
+    hw->size_emul = hw->samples * hw->info.bytes_per_frame;
+    hw->buf_emul = g_malloc(hw->size_emul);
+    hw->pos_emul = hw->pending_emul = 0;
+}
+
 size_t audio_generic_buffer_get_free(HWVoiceOut *hw)
 {
     if (hw->buf_emul) {
@@ -1260,9 +1274,7 @@ void audio_generic_run_buffer_out(HWVoiceOut *hw)
 void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size)
 {
     if (unlikely(!hw->buf_emul)) {
-        hw->size_emul = hw->samples * hw->info.bytes_per_frame;
-        hw->buf_emul = g_malloc(hw->size_emul);
-        hw->pos_emul = hw->pending_emul = 0;
+        audio_generic_initialize_buffer_out(hw);
     }
 
     *size = MIN(hw->size_emul - hw->pending_emul,

-- 
2.53.0


