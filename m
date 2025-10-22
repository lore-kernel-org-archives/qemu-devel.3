Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B384CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 07:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBSp7-0000YT-He; Wed, 22 Oct 2025 02:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBSp6-0000UJ-71
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:59:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBSoz-0008Mv-9i
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761116382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=diOv9EHv5g2wvAeeVNhVdb4+wKRzzCXow7Ys5XqMn1A=;
 b=dg0nzf9amzM4fg2TzN6glmQxRDEH3KKtQrpwGCNvwdv2MtqYje1G3M0+TMAlrSKNLVZBVa
 PMSOubtrL+/J4QiGhK3bs7UuUZ3gqTpTHtJLftvTEON+54oLSMsarOSBjvTq3CliPiCvjW
 SuV9j2vXriLEpeZKSPxojjaue2dsBPU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-fc_pHtpBO2qGecs2U5-AsQ-1; Wed,
 22 Oct 2025 02:59:39 -0400
X-MC-Unique: fc_pHtpBO2qGecs2U5-AsQ-1
X-Mimecast-MFC-AGG-ID: fc_pHtpBO2qGecs2U5-AsQ_1761116378
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48DD6180A228; Wed, 22 Oct 2025 06:59:32 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C4F2180057D; Wed, 22 Oct 2025 06:59:29 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:Xilinx ZynqMP and...)
Subject: [PATCH v2 30/42] audio: introduce AUD_set_volume_{in,out}_lr()
Date: Wed, 22 Oct 2025 10:56:25 +0400
Message-ID: <20251022065640.1172785-31-marcandre.lureau@redhat.com>
In-Reply-To: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
References: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Keep the AUD_ prefix for consistency. Introduce a macro to call the
more flexible Volume function.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio.h         |  8 ++++----
 audio/audio.c         | 16 ++--------------
 hw/audio/ac97.c       |  4 ++--
 hw/audio/asc.c        |  2 +-
 hw/audio/hda-codec.c  |  4 ++--
 hw/audio/lm4549.c     |  2 +-
 hw/audio/via-ac97.c   |  2 +-
 hw/audio/virtio-snd.c |  4 ++--
 hw/audio/wm8750.c     | 12 ++++++------
 hw/display/xlnx_dp.c  |  2 +-
 hw/usb/dev-audio.c    |  4 ++--
 11 files changed, 24 insertions(+), 36 deletions(-)

diff --git a/audio/audio.h b/audio/audio.h
index 0af911fd9a..2175223ef6 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -119,8 +119,8 @@ int  AUD_is_active_out (SWVoiceOut *sw);
 void     AUD_init_time_stamp_out (SWVoiceOut *sw, QEMUAudioTimeStamp *ts);
 uint64_t AUD_get_elapsed_usec_out (SWVoiceOut *sw, QEMUAudioTimeStamp *ts);
 
-void AUD_set_volume_out (SWVoiceOut *sw, int mute, uint8_t lvol, uint8_t rvol);
-void AUD_set_volume_in (SWVoiceIn *sw, int mute, uint8_t lvol, uint8_t rvol);
+#define AUD_set_volume_out_lr(sw, mut, lvol, rvol) AUD_set_volume_out(sw, &(Volume) { .mute = mut, .channels = 2, .vol = { lvol, rvol } })
+#define AUD_set_volume_in_lr(sw, mut, lvol, rvol) AUD_set_volume_in(sw, &(Volume) { .mute = mut, .channels = 2, .vol = { lvol, rvol } })
 
 #define AUDIO_MAX_CHANNELS 16
 typedef struct Volume {
@@ -129,8 +129,8 @@ typedef struct Volume {
     uint8_t vol[AUDIO_MAX_CHANNELS];
 } Volume;
 
-void audio_set_volume_out(SWVoiceOut *sw, Volume *vol);
-void audio_set_volume_in(SWVoiceIn *sw, Volume *vol);
+void AUD_set_volume_out(SWVoiceOut *sw, Volume *vol);
+void AUD_set_volume_in(SWVoiceIn *sw, Volume *vol);
 
 SWVoiceIn *AUD_open_in (
     QEMUSoundCard *card,
diff --git a/audio/audio.c b/audio/audio.c
index 284ea13289..9e6d79b4e3 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1949,13 +1949,7 @@ void AUD_del_capture (CaptureVoiceOut *cap, void *cb_opaque)
     }
 }
 
-void AUD_set_volume_out (SWVoiceOut *sw, int mute, uint8_t lvol, uint8_t rvol)
-{
-    Volume vol = { .mute = mute, .channels = 2, .vol = { lvol, rvol } };
-    audio_set_volume_out(sw, &vol);
-}
-
-void audio_set_volume_out(SWVoiceOut *sw, Volume *vol)
+void AUD_set_volume_out(SWVoiceOut *sw, Volume *vol)
 {
     if (sw) {
         HWVoiceOut *hw = sw->hw;
@@ -1971,13 +1965,7 @@ void audio_set_volume_out(SWVoiceOut *sw, Volume *vol)
     }
 }
 
-void AUD_set_volume_in (SWVoiceIn *sw, int mute, uint8_t lvol, uint8_t rvol)
-{
-    Volume vol = { .mute = mute, .channels = 2, .vol = { lvol, rvol } };
-    audio_set_volume_in(sw, &vol);
-}
-
-void audio_set_volume_in(SWVoiceIn *sw, Volume *vol)
+void AUD_set_volume_in(SWVoiceIn *sw, Volume *vol)
 {
     if (sw) {
         HWVoiceIn *hw = sw->hw;
diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 3d3c667e86..9157588dbc 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -414,7 +414,7 @@ static void update_combined_volume_out(AC97LinkState *s)
     lvol = (lvol * plvol) / 255;
     rvol = (rvol * prvol) / 255;
 
-    AUD_set_volume_out(s->voice_po, mute, lvol, rvol);
+    AUD_set_volume_out_lr(s->voice_po, mute, lvol, rvol);
 }
 
 static void update_volume_in(AC97LinkState *s)
@@ -425,7 +425,7 @@ static void update_volume_in(AC97LinkState *s)
     get_volume(mixer_load(s, AC97_Record_Gain_Mute), 0x0f, 0,
                &mute, &lvol, &rvol);
 
-    AUD_set_volume_in(s->voice_pi, mute, lvol, rvol);
+    AUD_set_volume_in_lr(s->voice_pi, mute, lvol, rvol);
 }
 
 static void set_volume(AC97LinkState *s, int index, uint32_t val)
diff --git a/hw/audio/asc.c b/hw/audio/asc.c
index 41472dc2e3..991316e984 100644
--- a/hw/audio/asc.c
+++ b/hw/audio/asc.c
@@ -489,7 +489,7 @@ static void asc_write(void *opaque, hwaddr addr, uint64_t value,
         {
             int vol = (value & 0xe0);
 
-            AUD_set_volume_out(s->voice, 0, vol, vol);
+            AUD_set_volume_out_lr(s->voice, 0, vol, vol);
             break;
         }
     }
diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 66edad280f..cc87557954 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -466,9 +466,9 @@ static void hda_audio_set_amp(HDAAudioStream *st)
         return;
     }
     if (st->output) {
-        AUD_set_volume_out(st->voice.out, muted, left, right);
+        AUD_set_volume_out_lr(st->voice.out, muted, left, right);
     } else {
-        AUD_set_volume_in(st->voice.in, muted, left, right);
+        AUD_set_volume_in_lr(st->voice.in, muted, left, right);
     }
 }
 
diff --git a/hw/audio/lm4549.c b/hw/audio/lm4549.c
index a4a77c8dc6..dccbf56068 100644
--- a/hw/audio/lm4549.c
+++ b/hw/audio/lm4549.c
@@ -308,7 +308,7 @@ void lm4549_init(lm4549_state *s, lm4549_callback data_req_cb, void* opaque,
         &as
     );
 
-    AUD_set_volume_out(s->voice, 0, 255, 255);
+    AUD_set_volume_out_lr(s->voice, 0, 255, 255);
 
     s->voice_is_active = 0;
 
diff --git a/hw/audio/via-ac97.c b/hw/audio/via-ac97.c
index d5231e1cf2..62341e5600 100644
--- a/hw/audio/via-ac97.c
+++ b/hw/audio/via-ac97.c
@@ -53,7 +53,7 @@ static void codec_volume_set_out(ViaAC97State *s)
     rvol /= 255;
     mute = CODEC_REG(s, AC97_Master_Volume_Mute) >> MUTE_SHIFT;
     mute |= CODEC_REG(s, AC97_PCM_Out_Volume_Mute) >> MUTE_SHIFT;
-    AUD_set_volume_out(s->vo, mute, lvol, rvol);
+    AUD_set_volume_out_lr(s->vo, mute, lvol, rvol);
 }
 
 static void codec_reset(ViaAC97State *s)
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index eca3319e59..88777977a9 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -463,7 +463,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
                                          stream,
                                          virtio_snd_pcm_out_cb,
                                          &as);
-        AUD_set_volume_out(stream->voice.out, 0, 255, 255);
+        AUD_set_volume_out_lr(stream->voice.out, 0, 255, 255);
     } else {
         stream->voice.in = AUD_open_in(&s->card,
                                         stream->voice.in,
@@ -471,7 +471,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
                                         stream,
                                         virtio_snd_pcm_in_cb,
                                         &as);
-        AUD_set_volume_in(stream->voice.in, 0, 255, 255);
+        AUD_set_volume_in_lr(stream->voice.in, 0, 255, 255);
     }
 
     return cpu_to_le32(VIRTIO_SND_S_OK);
diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
index 2846b55fe2..7a36c4bd3f 100644
--- a/hw/audio/wm8750.c
+++ b/hw/audio/wm8750.c
@@ -145,30 +145,30 @@ static void wm8750_vol_update(WM8750State *s)
 {
     /* FIXME: multiply all volumes by s->invol[2], s->invol[3] */
 
-    AUD_set_volume_in(s->adc_voice[0], s->mute,
+    AUD_set_volume_in_lr(s->adc_voice[0], s->mute,
                     s->inmute[0] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[0]),
                     s->inmute[1] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[1]));
-    AUD_set_volume_in(s->adc_voice[1], s->mute,
+    AUD_set_volume_in_lr(s->adc_voice[1], s->mute,
                     s->inmute[0] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[0]),
                     s->inmute[1] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[1]));
-    AUD_set_volume_in(s->adc_voice[2], s->mute,
+    AUD_set_volume_in_lr(s->adc_voice[2], s->mute,
                     s->inmute[0] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[0]),
                     s->inmute[1] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[1]));
 
     /* FIXME: multiply all volumes by s->outvol[0], s->outvol[1] */
 
     /* Speaker: LOUT2VOL ROUT2VOL */
-    AUD_set_volume_out(s->dac_voice[0], s->mute,
+    AUD_set_volume_out_lr(s->dac_voice[0], s->mute,
                     s->outmute[0] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[4]),
                     s->outmute[1] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[5]));
 
     /* Headphone: LOUT1VOL ROUT1VOL */
-    AUD_set_volume_out(s->dac_voice[1], s->mute,
+    AUD_set_volume_out_lr(s->dac_voice[1], s->mute,
                     s->outmute[0] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[2]),
                     s->outmute[1] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[3]));
 
     /* MONOOUT: MONOVOL MONOVOL */
-    AUD_set_volume_out(s->dac_voice[2], s->mute,
+    AUD_set_volume_out_lr(s->dac_voice[2], s->mute,
                     s->outmute[0] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[6]),
                     s->outmute[1] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[6]));
 }
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index ef73e1815f..882ae3c4b4 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1334,7 +1334,7 @@ static void xlnx_dp_realize(DeviceState *dev, Error **errp)
                                            s,
                                            xlnx_dp_audio_callback,
                                            &as);
-    AUD_set_volume_out(s->amixer_output_stream, 0, 255, 255);
+    AUD_set_volume_out_lr(s->amixer_output_stream, 0, 255, 255);
     xlnx_dp_audio_activate(s);
     s->vblank = ptimer_init(vblank_hit, s, DP_VBLANK_PTIMER_POLICY);
     ptimer_transaction_begin(s->vblank);
diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index 26af709f31..f59e5a53f0 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -805,7 +805,7 @@ static int usb_audio_set_control(USBAudioState *s, uint8_t attrib,
             }
             fprintf(stderr, "\n");
         }
-        audio_set_volume_out(s->out.voice, &s->out.vol);
+        AUD_set_volume_out(s->out.voice, &s->out.vol);
     }
 
     return ret;
@@ -981,7 +981,7 @@ static void usb_audio_reinit(USBDevice *dev, unsigned channels)
 
     s->out.voice = AUD_open_out(&s->card, s->out.voice, TYPE_USB_AUDIO,
                                 s, output_callback, &s->out.as);
-    audio_set_volume_out(s->out.voice, &s->out.vol);
+    AUD_set_volume_out(s->out.voice, &s->out.vol);
     AUD_set_active_out(s->out.voice, 0);
 }
 
-- 
2.51.0


