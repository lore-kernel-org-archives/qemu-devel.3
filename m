Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4295ACCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 15:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDOw3-0005Hg-Tv; Mon, 27 Oct 2025 11:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vDOvk-0004vD-It
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:14:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vDOvV-00042J-JO
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761578063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tOfVtsEaZO+vrKqi4txTmFlgspZc2hje1lURZHHHbjs=;
 b=aHJkodnJoRxskPu5qtLzbFnPYRW09PmudS7Sb33mc7+SLD2I8VPLvW8Eu7/GnXkGZgW6uB
 ux2kXNJr7+XvY5+Cq6EJ+Lj5smCx3itEIHxI9wf2NlAEFJxYmkjqMrF+VBmURNVwdT6t2s
 KR4DGjHo0eMadBfCNMWF0VZ7cPXkQYU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-SU95BJ5_MdK1Y08esamh1g-1; Mon,
 27 Oct 2025 11:14:20 -0400
X-MC-Unique: SU95BJ5_MdK1Y08esamh1g-1
X-Mimecast-MFC-AGG-ID: SU95BJ5_MdK1Y08esamh1g_1761578056
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22FE91808997; Mon, 27 Oct 2025 15:14:16 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A144D1800353; Mon, 27 Oct 2025 15:14:14 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Alexandre Ratchov <alex@caoua.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jan Kiszka <jan.kiszka@web.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-ppc@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 31/35] audio: cleanup, use bool for booleans
Date: Mon, 27 Oct 2025 19:10:38 +0400
Message-ID: <20251027151045.2863176-32-marcandre.lureau@redhat.com>
In-Reply-To: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
References: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

Use slightly better types for the job.
Fix some checkpatch issues.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 audio/audio_int.h      | 12 ++++++------
 audio/audio_template.h |  6 +++---
 include/qemu/audio.h   |  8 ++++----
 audio/audio.c          | 30 +++++++++++++++---------------
 4 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 8d4f4ca8fc..df13a466e4 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -70,9 +70,9 @@ typedef struct STSampleBuffer {
 
 typedef struct HWVoiceOut {
     AudioBackend *s;
-    int enabled;
+    bool enabled;
     int poll_mode;
-    int pending_disable;
+    bool pending_disable;
     struct audio_pcm_info info;
 
     f_sample *clip;
@@ -91,7 +91,7 @@ typedef struct HWVoiceOut {
 
 typedef struct HWVoiceIn {
     AudioBackend *s;
-    int enabled;
+    bool enabled;
     int poll_mode;
     struct audio_pcm_info info;
 
@@ -117,8 +117,8 @@ struct SWVoiceOut {
     STSampleBuffer resample_buf;
     void *rate;
     size_t total_hw_samples_mixed;
-    int active;
-    int empty;
+    bool active;
+    bool empty;
     HWVoiceOut *hw;
     char *name;
     struct mixeng_volume vol;
@@ -128,7 +128,7 @@ struct SWVoiceOut {
 
 struct SWVoiceIn {
     AudioBackend *s;
-    int active;
+    bool active;
     struct audio_pcm_info info;
     void *rate;
     size_t total_hw_samples_acquired;
diff --git a/audio/audio_template.h b/audio/audio_template.h
index d621008f38..7a8c431f2d 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -166,10 +166,10 @@ static int glue (audio_pcm_sw_init_, TYPE) (
 
     audio_pcm_init_info (&sw->info, as);
     sw->hw = hw;
-    sw->active = 0;
+    sw->active = false;
 #ifdef DAC
     sw->total_hw_samples_mixed = 0;
-    sw->empty = 1;
+    sw->empty = true;
 #endif
 
     if (sw->info.is_float) {
@@ -564,7 +564,7 @@ SW *glue (AUD_open_, TYPE) (
     return NULL;
 }
 
-int glue (AUD_is_active_, TYPE) (SW *sw)
+bool glue(AUD_is_active_, TYPE)(SW *sw)
 {
     return sw ? sw->active : 0;
 }
diff --git a/include/qemu/audio.h b/include/qemu/audio.h
index 78c27462ba..a857955f51 100644
--- a/include/qemu/audio.h
+++ b/include/qemu/audio.h
@@ -98,8 +98,8 @@ SWVoiceOut *AUD_open_out (
 void AUD_close_out (AudioBackend *be, SWVoiceOut *sw);
 size_t AUD_write (SWVoiceOut *sw, void *pcm_buf, size_t size);
 int  AUD_get_buffer_size_out (SWVoiceOut *sw);
-void AUD_set_active_out (SWVoiceOut *sw, int on);
-int  AUD_is_active_out (SWVoiceOut *sw);
+void AUD_set_active_out(SWVoiceOut *sw, bool on);
+bool AUD_is_active_out(SWVoiceOut *sw);
 
 void     AUD_init_time_stamp_out (SWVoiceOut *sw, QEMUAudioTimeStamp *ts);
 uint64_t AUD_get_elapsed_usec_out (SWVoiceOut *sw, QEMUAudioTimeStamp *ts);
@@ -139,8 +139,8 @@ SWVoiceIn *AUD_open_in (
 
 void AUD_close_in (AudioBackend *be, SWVoiceIn *sw);
 size_t AUD_read (SWVoiceIn *sw, void *pcm_buf, size_t size);
-void AUD_set_active_in (SWVoiceIn *sw, int on);
-int  AUD_is_active_in (SWVoiceIn *sw);
+void AUD_set_active_in(SWVoiceIn *sw, bool on);
+bool AUD_is_active_in(SWVoiceIn *sw);
 
 void     AUD_init_time_stamp_in (SWVoiceIn *sw, QEMUAudioTimeStamp *ts);
 uint64_t AUD_get_elapsed_usec_in (SWVoiceIn *sw, QEMUAudioTimeStamp *ts);
diff --git a/audio/audio.c b/audio/audio.c
index 4bbe6b242f..748dd0da27 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -405,7 +405,7 @@ static void audio_notify_capture (CaptureVoiceOut *cap, audcnotification_e cmd)
     }
 }
 
-static void audio_capture_maybe_changed (CaptureVoiceOut *cap, int enabled)
+static void audio_capture_maybe_changed(CaptureVoiceOut *cap, bool enabled)
 {
     if (cap->hw.enabled != enabled) {
         audcnotification_e cmd;
@@ -419,11 +419,11 @@ static void audio_recalc_and_notify_capture (CaptureVoiceOut *cap)
 {
     HWVoiceOut *hw = &cap->hw;
     SWVoiceOut *sw;
-    int enabled = 0;
+    bool enabled = false;
 
     for (sw = hw->sw_head.lh_first; sw; sw = sw->entries.le_next) {
         if (sw->active) {
-            enabled = 1;
+            enabled = true;
             break;
         }
     }
@@ -475,7 +475,7 @@ static int audio_attach_capture (HWVoiceOut *hw)
         sw = &sc->sw;
         sw->hw = hw_cap;
         sw->info = hw->info;
-        sw->empty = 1;
+        sw->empty = true;
         sw->active = hw->enabled;
         sw->vol = nominal_volume;
         sw->rate = st_rate_start (sw->info.freq, hw_cap->info.freq);
@@ -911,7 +911,7 @@ int AUD_get_buffer_size_out(SWVoiceOut *sw)
     return sw->hw->samples * sw->hw->info.bytes_per_frame;
 }
 
-void AUD_set_active_out (SWVoiceOut *sw, int on)
+void AUD_set_active_out(SWVoiceOut *sw, bool on)
 {
     HWVoiceOut *hw;
 
@@ -928,7 +928,7 @@ void AUD_set_active_out (SWVoiceOut *sw, int on)
         if (on) {
             hw->pending_disable = 0;
             if (!hw->enabled) {
-                hw->enabled = 1;
+                hw->enabled = true;
                 if (s->vm_running) {
                     if (hw->pcm_ops->enable_out) {
                         hw->pcm_ops->enable_out(hw, true);
@@ -959,7 +959,7 @@ void AUD_set_active_out (SWVoiceOut *sw, int on)
     }
 }
 
-void AUD_set_active_in (SWVoiceIn *sw, int on)
+void AUD_set_active_in(SWVoiceIn *sw, bool on)
 {
     HWVoiceIn *hw;
 
@@ -974,7 +974,7 @@ void AUD_set_active_in (SWVoiceIn *sw, int on)
 
         if (on) {
             if (!hw->enabled) {
-                hw->enabled = 1;
+                hw->enabled = true;
                 if (s->vm_running) {
                     if (hw->pcm_ops->enable_in) {
                         hw->pcm_ops->enable_in(hw, true);
@@ -993,7 +993,7 @@ void AUD_set_active_in (SWVoiceIn *sw, int on)
                 }
 
                 if (nb_active == 1) {
-                    hw->enabled = 0;
+                    hw->enabled = false;
                     if (hw->pcm_ops->enable_in) {
                         hw->pcm_ops->enable_in(hw, false);
                     }
@@ -1152,8 +1152,8 @@ static void audio_run_out(AudioBackend *s)
             sw = hw->sw_head.lh_first;
 
             if (hw->pending_disable) {
-                hw->enabled = 0;
-                hw->pending_disable = 0;
+                hw->enabled = false;
+                hw->pending_disable = false;
                 if (hw->pcm_ops->enable_out) {
                     hw->pcm_ops->enable_out(hw, false);
                 }
@@ -1206,13 +1206,13 @@ static void audio_run_out(AudioBackend *s)
 #ifdef DEBUG_OUT
             dolog ("Disabling voice\n");
 #endif
-            hw->enabled = 0;
-            hw->pending_disable = 0;
+            hw->enabled = false;
+            hw->pending_disable = false;
             if (hw->pcm_ops->enable_out) {
                 hw->pcm_ops->enable_out(hw, false);
             }
             for (sc = hw->cap_head.lh_first; sc; sc = sc->entries.le_next) {
-                sc->sw.active = 0;
+                sc->sw.active = false;
                 audio_recalc_and_notify_capture (sc->cap);
             }
             continue;
@@ -1257,7 +1257,7 @@ static void audio_run_out(AudioBackend *s)
             sw->total_hw_samples_mixed -= played;
 
             if (!sw->total_hw_samples_mixed) {
-                sw->empty = 1;
+                sw->empty = true;
             }
         }
     }
-- 
2.51.0


