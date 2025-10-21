Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF1FCCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 09:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB8Kj-0006ol-F2; Tue, 21 Oct 2025 05:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8KR-0006kT-52
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:06:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8KL-0004O8-QN
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761037604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a56qxv3Kx2W2U/RuFPR1YFbZxI0H20NUSNDtwfSkHwI=;
 b=TBQTtLHn7iYbcQ8PvDbmCnLN7fvzCzUzOeX2qsCVWNPoOTOBy9Kr+6vD50i1QPntXbESD6
 Ihj0cp4IG51bi5SyH74tFeJqZTXwqdWD0IdB8IlpN2RDBp7dn9HmURqeboYtdRt9GhK/Le
 0OvO0jWuuzBynX8KtiBwZ+HCSUeghKc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145--ZXsa_PhOdKqV8f_74DUeg-1; Tue,
 21 Oct 2025 05:06:38 -0400
X-MC-Unique: -ZXsa_PhOdKqV8f_74DUeg-1
X-Mimecast-MFC-AGG-ID: -ZXsa_PhOdKqV8f_74DUeg_1761037596
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C079195420F; Tue, 21 Oct 2025 09:06:36 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ECFAF180057C; Tue, 21 Oct 2025 09:06:33 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-arm@nongnu.org (open list:Xilinx ZynqMP and...)
Subject: [PATCH 35/43] audio: rename QEMUSoundCard -> AudioFE
Date: Tue, 21 Oct 2025 13:03:06 +0400
Message-ID: <20251021090317.425409-36-marcandre.lureau@redhat.com>
In-Reply-To: <20251021090317.425409-1-marcandre.lureau@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio.h                       | 20 ++++++++++----------
 audio/audio_int.h                   |  6 +++---
 audio/audio_template.h              |  4 ++--
 hw/audio/lm4549.h                   |  2 +-
 include/hw/audio/asc.h              |  2 +-
 include/hw/audio/virtio-snd.h       |  2 +-
 include/hw/display/xlnx_dp.h        |  2 +-
 include/hw/isa/vt82c686.h           |  2 +-
 include/hw/qdev-properties-system.h |  2 +-
 audio/audio.c                       | 10 +++++-----
 hw/audio/ac97.c                     |  6 +++---
 hw/audio/adlib.c                    |  6 +++---
 hw/audio/asc.c                      |  6 +++---
 hw/audio/cs4231a.c                  |  4 ++--
 hw/audio/es1370.c                   |  6 +++---
 hw/audio/gus.c                      |  6 +++---
 hw/audio/hda-codec.c                |  6 +++---
 hw/audio/lm4549.c                   |  2 +-
 hw/audio/pcspk.c                    |  4 ++--
 hw/audio/sb16.c                     |  4 ++--
 hw/audio/via-ac97.c                 |  4 ++--
 hw/audio/virtio-snd.c               |  4 ++--
 hw/audio/wm8750.c                   |  6 +++---
 hw/core/qdev-properties-system.c    |  4 ++--
 hw/display/xlnx_dp.c                |  2 +-
 hw/usb/dev-audio.c                  |  6 +++---
 26 files changed, 64 insertions(+), 64 deletions(-)

diff --git a/audio/audio.h b/audio/audio.h
index 845e078169..a43ca0700c 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -70,18 +70,18 @@ struct AudioBEClass {
 };
 
 typedef struct AudioBE AudioBE;
-typedef struct QEMUSoundCard {
+typedef struct AudioFE {
     char *name;
     AudioBE *be;
-    QLIST_ENTRY (QEMUSoundCard) entries;
-} QEMUSoundCard;
+    QLIST_ENTRY (AudioFE) entries;
+} AudioFE;
 
 typedef struct QEMUAudioTimeStamp {
     uint64_t old_ts;
 } QEMUAudioTimeStamp;
 
-bool AUD_register_card (const char *name, QEMUSoundCard *card, Error **errp);
-void AUD_remove_card (QEMUSoundCard *card);
+bool AUD_register_fe (const char *name, AudioFE *fe, Error **errp);
+void AUD_unregister_fe (AudioFE *fe);
 CaptureVoiceOut *AUD_add_capture(
     AudioBE *s,
     struct audsettings *as,
@@ -91,7 +91,7 @@ CaptureVoiceOut *AUD_add_capture(
 void AUD_del_capture (CaptureVoiceOut *cap, void *cb_opaque);
 
 SWVoiceOut *AUD_open_out (
-    QEMUSoundCard *card,
+    AudioFE *fe,
     SWVoiceOut *sw,
     const char *name,
     void *callback_opaque,
@@ -99,7 +99,7 @@ SWVoiceOut *AUD_open_out (
     struct audsettings *settings
     );
 
-void AUD_close_out (QEMUSoundCard *card, SWVoiceOut *sw);
+void AUD_close_out (AudioFE *fe, SWVoiceOut *sw);
 size_t AUD_write (SWVoiceOut *sw, void *pcm_buf, size_t size);
 int  AUD_get_buffer_size_out (SWVoiceOut *sw);
 void AUD_set_active_out (SWVoiceOut *sw, int on);
@@ -122,7 +122,7 @@ void AUD_set_volume_out(SWVoiceOut *sw, Volume *vol);
 void AUD_set_volume_in(SWVoiceIn *sw, Volume *vol);
 
 SWVoiceIn *AUD_open_in (
-    QEMUSoundCard *card,
+    AudioFE *fe,
     SWVoiceIn *sw,
     const char *name,
     void *callback_opaque,
@@ -130,7 +130,7 @@ SWVoiceIn *AUD_open_in (
     struct audsettings *settings
     );
 
-void AUD_close_in (QEMUSoundCard *card, SWVoiceIn *sw);
+void AUD_close_in (AudioFE *fe, SWVoiceIn *sw);
 size_t AUD_read (SWVoiceIn *sw, void *pcm_buf, size_t size);
 void AUD_set_active_in (SWVoiceIn *sw, int on);
 int  AUD_is_active_in (SWVoiceIn *sw);
@@ -156,7 +156,7 @@ void audio_help(void);
 
 AudioBE *audio_be_by_name(const char *name, Error **errp);
 AudioBE *audio_get_default_audio_be(Error **errp);
-const char *audio_get_id(QEMUSoundCard *card);
+const char *audio_get_id(AudioFE *fe);
 
 #define DEFINE_AUDIO_PROPERTIES(_s, _f)         \
     DEFINE_PROP_AUDIODEV("audiodev", _s, _f)
diff --git a/audio/audio_int.h b/audio/audio_int.h
index d7e24ec089..5943dc3b2a 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -108,7 +108,7 @@ typedef struct HWVoiceIn {
 } HWVoiceIn;
 
 struct SWVoiceOut {
-    QEMUSoundCard *card;
+    AudioFE *card;
     AudioBE *s;
     struct audio_pcm_info info;
     t_sample *conv;
@@ -125,7 +125,7 @@ struct SWVoiceOut {
 };
 
 struct SWVoiceIn {
-    QEMUSoundCard *card;
+    AudioFE *card;
     AudioBE *s;
     int active;
     struct audio_pcm_info info;
@@ -246,7 +246,7 @@ typedef struct AudioBE {
     void *drv_opaque;
 
     QEMUTimer *ts;
-    QLIST_HEAD (card_listhead, QEMUSoundCard) card_head;
+    QLIST_HEAD (fe_listhead, AudioFE) fe_head;
     QLIST_HEAD (hw_in_listhead, HWVoiceIn) hw_head_in;
     QLIST_HEAD (hw_out_listhead, HWVoiceOut) hw_head_out;
     QLIST_HEAD (cap_listhead, CaptureVoiceOut) cap_head;
diff --git a/audio/audio_template.h b/audio/audio_template.h
index c8f3e9dc93..e52587e02c 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -473,7 +473,7 @@ static void glue (audio_close_, TYPE) (SW *sw)
     g_free (sw);
 }
 
-void glue (AUD_close_, TYPE) (QEMUSoundCard *card, SW *sw)
+void glue (AUD_close_, TYPE) (AudioFE *card, SW *sw)
 {
     if (sw) {
         if (audio_bug(__func__, !card)) {
@@ -486,7 +486,7 @@ void glue (AUD_close_, TYPE) (QEMUSoundCard *card, SW *sw)
 }
 
 SW *glue (AUD_open_, TYPE) (
-    QEMUSoundCard *card,
+    AudioFE *card,
     SW *sw,
     const char *name,
     void *callback_opaque ,
diff --git a/hw/audio/lm4549.h b/hw/audio/lm4549.h
index 61c3ab12dd..45023b6535 100644
--- a/hw/audio/lm4549.h
+++ b/hw/audio/lm4549.h
@@ -21,7 +21,7 @@ typedef void (*lm4549_callback)(void *opaque);
 
 
 typedef struct {
-    QEMUSoundCard card;
+    AudioFE card;
     SWVoiceOut *voice;
     uint32_t voice_is_active;
 
diff --git a/include/hw/audio/asc.h b/include/hw/audio/asc.h
index 04fac270b6..5c8c4ef4ec 100644
--- a/include/hw/audio/asc.h
+++ b/include/hw/audio/asc.h
@@ -61,7 +61,7 @@ struct ASCState {
     MemoryRegion mem_regs;
     MemoryRegion mem_extregs;
 
-    QEMUSoundCard card;
+    AudioFE card;
     SWVoiceOut *voice;
     uint8_t *mixbuf;
     int samples;
diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index 8dafedb276..f9a434fe26 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -216,7 +216,7 @@ struct VirtIOSound {
     VirtQueue *queues[VIRTIO_SND_VQ_MAX];
     uint64_t features;
     VirtIOSoundPCM *pcm;
-    QEMUSoundCard card;
+    AudioFE card;
     VMChangeStateEntry *vmstate;
     virtio_snd_config snd_conf;
     QemuMutex cmdq_mutex;
diff --git a/include/hw/display/xlnx_dp.h b/include/hw/display/xlnx_dp.h
index e86a87f235..196f325f52 100644
--- a/include/hw/display/xlnx_dp.h
+++ b/include/hw/display/xlnx_dp.h
@@ -84,7 +84,7 @@ struct XlnxDPState {
     struct PixmanPlane v_plane;
     struct PixmanPlane bout_plane;
 
-    QEMUSoundCard aud_card;
+    AudioFE aud_card;
     SWVoiceOut *amixer_output_stream;
     int16_t audio_buffer_0[AUD_CHBUF_MAX_DEPTH];
     int16_t audio_buffer_1[AUD_CHBUF_MAX_DEPTH];
diff --git a/include/hw/isa/vt82c686.h b/include/hw/isa/vt82c686.h
index da1722daf2..9948daaefb 100644
--- a/include/hw/isa/vt82c686.h
+++ b/include/hw/isa/vt82c686.h
@@ -24,7 +24,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(ViaAC97State, VIA_AC97);
 
 struct ViaAC97State {
     PCIDevice dev;
-    QEMUSoundCard card;
+    AudioFE card;
     MemoryRegion sgd;
     MemoryRegion fm;
     MemoryRegion midi;
diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
index 9601a11a09..cf1839b14d 100644
--- a/include/hw/qdev-properties-system.h
+++ b/include/hw/qdev-properties-system.h
@@ -87,7 +87,7 @@ extern const PropertyInfo qdev_prop_virtio_gpu_output_list;
                 .set_default = true)
 
 #define DEFINE_PROP_AUDIODEV(_n, _s, _f) \
-    DEFINE_PROP(_n, _s, _f, qdev_prop_audiodev, QEMUSoundCard)
+    DEFINE_PROP(_n, _s, _f, qdev_prop_audiodev, AudioFE)
 
 #define DEFINE_PROP_UUID_NODEFAULT(_name, _state, _field) \
     DEFINE_PROP(_name, _state, _field, qdev_prop_uuid, QemuUUID)
diff --git a/audio/audio.c b/audio/audio.c
index 66a2e86f13..7463bbd283 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1620,7 +1620,7 @@ static void audio_be_init(Object *obj)
     QLIST_INIT (&s->hw_head_out);
     QLIST_INIT (&s->hw_head_in);
     QLIST_INIT (&s->cap_head);
-    QLIST_INIT (&s->card_head);
+    QLIST_INIT (&s->fe_head);
     s->ts = timer_new_ns(QEMU_CLOCK_VIRTUAL, audio_timer, s);
 
     s->vmse = qemu_add_vm_change_state_handler(audio_vm_change_state_handler, s);
@@ -1812,7 +1812,7 @@ AudioBE *audio_get_default_audio_be(Error **errp)
     return default_audio_be;
 }
 
-bool AUD_register_card (const char *name, QEMUSoundCard *card, Error **errp)
+bool AUD_register_fe (const char *name, AudioFE *card, Error **errp)
 {
     if (!card->be) {
         card->be = audio_get_default_audio_be(errp);
@@ -1823,12 +1823,12 @@ bool AUD_register_card (const char *name, QEMUSoundCard *card, Error **errp)
 
     card->name = g_strdup (name);
     memset (&card->entries, 0, sizeof (card->entries));
-    QLIST_INSERT_HEAD(&card->be->card_head, card, entries);
+    QLIST_INSERT_HEAD(&card->be->fe_head, card, entries);
 
     return true;
 }
 
-void AUD_remove_card (QEMUSoundCard *card)
+void AUD_unregister_fe (AudioFE *card)
 {
     QLIST_REMOVE (card, entries);
     g_free (card->name);
@@ -2232,7 +2232,7 @@ AudioBE *audio_be_by_name(const char *name, Error **errp)
     }
 }
 
-const char *audio_get_id(QEMUSoundCard *card)
+const char *audio_get_id(AudioFE *card)
 {
     if (card->be) {
         assert(card->be->dev);
diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 1b2ce601a6..9520c6884c 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -120,7 +120,7 @@ typedef struct AC97BusMasterRegs {
 
 struct AC97LinkState {
     PCIDevice dev;
-    QEMUSoundCard card;
+    AudioFE card;
     uint32_t glob_cnt;
     uint32_t glob_sta;
     uint32_t cas;
@@ -1271,7 +1271,7 @@ static void ac97_realize(PCIDevice *dev, Error **errp)
     AC97LinkState *s = AC97(dev);
     uint8_t *c = s->dev.config;
 
-    if (!AUD_register_card ("ac97", &s->card, errp)) {
+    if (!AUD_register_fe ("ac97", &s->card, errp)) {
         return;
     }
 
@@ -1319,7 +1319,7 @@ static void ac97_exit(PCIDevice *dev)
     AUD_close_in(&s->card, s->voice_pi);
     AUD_close_out(&s->card, s->voice_po);
     AUD_close_in(&s->card, s->voice_mc);
-    AUD_remove_card(&s->card);
+    AUD_unregister_fe(&s->card);
 }
 
 static const Property ac97_properties[] = {
diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index 231055b8b5..a1eb356acc 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -53,7 +53,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AdlibState, ADLIB)
 struct AdlibState {
     ISADevice parent_obj;
 
-    QEMUSoundCard card;
+    AudioFE card;
     uint32_t freq;
     uint32_t port;
     int ticking[2];
@@ -236,7 +236,7 @@ static void Adlib_fini (AdlibState *s)
 
     s->active = 0;
     s->enabled = 0;
-    AUD_remove_card (&s->card);
+    AUD_unregister_fe (&s->card);
 }
 
 static MemoryRegionPortio adlib_portio_list[] = {
@@ -251,7 +251,7 @@ static void adlib_realizefn (DeviceState *dev, Error **errp)
     AdlibState *s = ADLIB(dev);
     struct audsettings as;
 
-    if (!AUD_register_card ("adlib", &s->card, errp)) {
+    if (!AUD_register_fe ("adlib", &s->card, errp)) {
         return;
     }
 
diff --git a/hw/audio/asc.c b/hw/audio/asc.c
index 991316e984..791c4372ec 100644
--- a/hw/audio/asc.c
+++ b/hw/audio/asc.c
@@ -635,7 +635,7 @@ static void asc_unrealize(DeviceState *dev)
     g_free(s->mixbuf);
     g_free(s->silentbuf);
 
-    AUD_remove_card(&s->card);
+    AUD_unregister_fe(&s->card);
 }
 
 static void asc_realize(DeviceState *dev, Error **errp)
@@ -643,7 +643,7 @@ static void asc_realize(DeviceState *dev, Error **errp)
     ASCState *s = ASC(dev);
     struct audsettings as;
 
-    if (!AUD_register_card("Apple Sound Chip", &s->card, errp)) {
+    if (!AUD_register_fe("Apple Sound Chip", &s->card, errp)) {
         return;
     }
 
@@ -655,7 +655,7 @@ static void asc_realize(DeviceState *dev, Error **errp)
     s->voice = AUD_open_out(&s->card, s->voice, "asc.out", s, asc_out_cb,
                             &as);
     if (!s->voice) {
-        AUD_remove_card(&s->card);
+        AUD_unregister_fe(&s->card);
         error_setg(errp, "Initializing audio stream failed");
         return;
     }
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index 062af7628b..01c1cd171e 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -65,7 +65,7 @@ DECLARE_INSTANCE_CHECKER(CSState, CS4231A,
 
 struct CSState {
     ISADevice dev;
-    QEMUSoundCard card;
+    AudioFE card;
     MemoryRegion ioports;
     qemu_irq pic;
     uint32_t regs[CS_REGS];
@@ -674,7 +674,7 @@ static void cs4231a_realizefn (DeviceState *dev, Error **errp)
         return;
     }
 
-    if (!AUD_register_card ("cs4231a", &s->card, errp)) {
+    if (!AUD_register_fe ("cs4231a", &s->card, errp)) {
         return;
     }
 
diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index ac5a6aba85..e606bdb622 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -258,7 +258,7 @@ struct chan {
 
 struct ES1370State {
     PCIDevice dev;
-    QEMUSoundCard card;
+    AudioFE card;
     MemoryRegion io;
     struct chan chan[NB_CHANNELS];
     SWVoiceOut *dac_voice[2];
@@ -833,7 +833,7 @@ static void es1370_realize(PCIDevice *dev, Error **errp)
     ES1370State *s = ES1370(dev);
     uint8_t *c = s->dev.config;
 
-    if (!AUD_register_card ("es1370", &s->card, errp)) {
+    if (!AUD_register_fe ("es1370", &s->card, errp)) {
         return;
     }
 
@@ -865,7 +865,7 @@ static void es1370_exit(PCIDevice *dev)
     }
 
     AUD_close_in(&s->card, s->adc_voice);
-    AUD_remove_card(&s->card);
+    AUD_unregister_fe(&s->card);
 }
 
 static const Property es1370_properties[] = {
diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index 40073f2d4f..dcf936a85d 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -45,7 +45,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(GUSState, GUS)
 struct GUSState {
     ISADevice dev;
     GUSEmuState emu;
-    QEMUSoundCard card;
+    AudioFE card;
     uint32_t freq;
     uint32_t port;
     int pos, left, shift, irqs;
@@ -238,7 +238,7 @@ static void gus_realizefn (DeviceState *dev, Error **errp)
     IsaDmaClass *k;
     struct audsettings as;
 
-    if (!AUD_register_card ("gus", &s->card, errp)) {
+    if (!AUD_register_fe ("gus", &s->card, errp)) {
         return;
     }
 
@@ -263,7 +263,7 @@ static void gus_realizefn (DeviceState *dev, Error **errp)
         );
 
     if (!s->voice) {
-        AUD_remove_card (&s->card);
+        AUD_unregister_fe (&s->card);
         error_setg(errp, "No voice");
         return;
     }
diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index cc87557954..760fa7680e 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -178,7 +178,7 @@ struct HDAAudioState {
     HDACodecDevice hda;
     const char *name;
 
-    QEMUSoundCard card;
+    AudioFE card;
     const desc_codec *desc;
     HDAAudioStream st[4];
     bool running_compat[16];
@@ -696,7 +696,7 @@ static void hda_audio_init(HDACodecDevice *hda,
     const desc_param *param;
     uint32_t i, type;
 
-    if (!AUD_register_card("hda", &a->card, errp)) {
+    if (!AUD_register_fe("hda", &a->card, errp)) {
         return;
     }
 
@@ -759,7 +759,7 @@ static void hda_audio_exit(HDACodecDevice *hda)
             AUD_close_in(&a->card, st->voice.in);
         }
     }
-    AUD_remove_card(&a->card);
+    AUD_unregister_fe(&a->card);
 }
 
 static int hda_audio_post_load(void *opaque, int version)
diff --git a/hw/audio/lm4549.c b/hw/audio/lm4549.c
index dccbf56068..21e848ef24 100644
--- a/hw/audio/lm4549.c
+++ b/hw/audio/lm4549.c
@@ -282,7 +282,7 @@ void lm4549_init(lm4549_state *s, lm4549_callback data_req_cb, void* opaque,
     struct audsettings as;
 
     /* Register an audio card */
-    if (!AUD_register_card("lm4549", &s->card, errp)) {
+    if (!AUD_register_fe("lm4549", &s->card, errp)) {
         return;
     }
 
diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index e9ab5ac41b..6e510f0be7 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -48,7 +48,7 @@ struct PCSpkState {
     MemoryRegion ioport;
     uint32_t iobase;
     uint8_t sample_buf[PCSPK_BUF_LEN];
-    QEMUSoundCard card;
+    AudioFE card;
     SWVoiceOut *voice;
     PITCommonState *pit;
     unsigned int pit_count;
@@ -188,7 +188,7 @@ static void pcspk_realizefn(DeviceState *dev, Error **errp)
 
     isa_register_ioport(isadev, &s->ioport, s->iobase);
 
-    if (s->card.be && AUD_register_card(s_spk, &s->card, errp)) {
+    if (s->card.be && AUD_register_fe(s_spk, &s->card, errp)) {
         pcspk_audio_init(s);
     }
 }
diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index 069cf6e120..85f859a461 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -50,7 +50,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(SB16State, SB16)
 struct SB16State {
     ISADevice parent_obj;
 
-    QEMUSoundCard card;
+    AudioFE card;
     qemu_irq pic;
     uint32_t irq;
     uint32_t dma;
@@ -1397,7 +1397,7 @@ static void sb16_realizefn (DeviceState *dev, Error **errp)
     SB16State *s = SB16 (dev);
     IsaDmaClass *k;
 
-    if (!AUD_register_card ("sb16", &s->card, errp)) {
+    if (!AUD_register_fe ("sb16", &s->card, errp)) {
         return;
     }
 
diff --git a/hw/audio/via-ac97.c b/hw/audio/via-ac97.c
index 62341e5600..1063a63742 100644
--- a/hw/audio/via-ac97.c
+++ b/hw/audio/via-ac97.c
@@ -426,7 +426,7 @@ static void via_ac97_realize(PCIDevice *pci_dev, Error **errp)
     ViaAC97State *s = VIA_AC97(pci_dev);
     Object *o = OBJECT(s);
 
-    if (!AUD_register_card ("via-ac97", &s->card, errp)) {
+    if (!AUD_register_fe ("via-ac97", &s->card, errp)) {
         return;
     }
 
@@ -456,7 +456,7 @@ static void via_ac97_exit(PCIDevice *dev)
     ViaAC97State *s = VIA_AC97(dev);
 
     AUD_close_out(&s->card, s->vo);
-    AUD_remove_card(&s->card);
+    AUD_unregister_fe(&s->card);
 }
 
 static const Property via_ac97_properties[] = {
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 88777977a9..15048e323a 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -1053,7 +1053,7 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (!AUD_register_card("virtio-sound", &vsnd->card, errp)) {
+    if (!AUD_register_fe("virtio-sound", &vsnd->card, errp)) {
         return;
     }
 
@@ -1330,7 +1330,7 @@ static void virtio_snd_unrealize(DeviceState *dev)
         g_free(vsnd->pcm);
         vsnd->pcm = NULL;
     }
-    AUD_remove_card(&vsnd->card);
+    AUD_unregister_fe(&vsnd->card);
     qemu_mutex_destroy(&vsnd->cmdq_mutex);
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_CONTROL]);
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_EVENT]);
diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
index 7a36c4bd3f..d24fca37e1 100644
--- a/hw/audio/wm8750.c
+++ b/hw/audio/wm8750.c
@@ -34,7 +34,7 @@ struct WM8750State {
 
     uint8_t i2c_data[2];
     int i2c_len;
-    QEMUSoundCard card;
+    AudioFE card;
     SWVoiceIn *adc_voice[IN_PORT_N];
     SWVoiceOut *dac_voice[OUT_PORT_N];
     int enable;
@@ -624,7 +624,7 @@ static void wm8750_realize(DeviceState *dev, Error **errp)
 {
     WM8750State *s = WM8750(dev);
 
-    if (!AUD_register_card(CODEC, &s->card, errp)) {
+    if (!AUD_register_fe(CODEC, &s->card, errp)) {
         return;
     }
 
@@ -637,7 +637,7 @@ static void wm8750_fini(I2CSlave *i2c)
     WM8750State *s = WM8750(i2c);
 
     wm8750_reset(I2C_SLAVE(s));
-    AUD_remove_card(&s->card);
+    AUD_unregister_fe(&s->card);
     g_free(s);
 }
 #endif
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index be682895f7..fc8e5eb07a 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -487,7 +487,7 @@ static void get_audiodev(Object *obj, Visitor *v, const char* name,
                          void *opaque, Error **errp)
 {
     const Property *prop = opaque;
-    QEMUSoundCard *card = object_field_prop_ptr(obj, prop);
+    AudioFE *card = object_field_prop_ptr(obj, prop);
     char *p = g_strdup(audio_get_id(card));
 
     visit_type_str(v, name, &p, errp);
@@ -498,7 +498,7 @@ static void set_audiodev(Object *obj, Visitor *v, const char* name,
                          void *opaque, Error **errp)
 {
     const Property *prop = opaque;
-    QEMUSoundCard *card = object_field_prop_ptr(obj, prop);
+    AudioFE *card = object_field_prop_ptr(obj, prop);
     AudioBE *state;
     g_autofree char *str = NULL;
 
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 882ae3c4b4..41502ec3f5 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1306,7 +1306,7 @@ static void xlnx_dp_realize(DeviceState *dev, Error **errp)
     DisplaySurface *surface;
     struct audsettings as;
 
-    if (!AUD_register_card("xlnx_dp.audio", &s->aud_card, errp)) {
+    if (!AUD_register_fe("xlnx_dp.audio", &s->aud_card, errp)) {
         return;
     }
 
diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index f59e5a53f0..2eb49a5e33 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -635,7 +635,7 @@ static uint8_t *streambuf_get(struct streambuf *buf, size_t *len)
 struct USBAudioState {
     /* qemu interfaces */
     USBDevice dev;
-    QEMUSoundCard card;
+    AudioFE card;
 
     /* state */
     struct {
@@ -932,7 +932,7 @@ static void usb_audio_unrealize(USBDevice *dev)
 
     usb_audio_set_output_altset(s, ALTSET_OFF);
     AUD_close_out(&s->card, s->out.voice);
-    AUD_remove_card(&s->card);
+    AUD_unregister_fe(&s->card);
 
     streambuf_fini(&s->out.buf);
 }
@@ -942,7 +942,7 @@ static void usb_audio_realize(USBDevice *dev, Error **errp)
     USBAudioState *s = USB_AUDIO(dev);
     int i;
 
-    if (!AUD_register_card(TYPE_USB_AUDIO, &s->card, errp)) {
+    if (!AUD_register_fe(TYPE_USB_AUDIO, &s->card, errp)) {
         return;
     }
 
-- 
2.51.0


