Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62AECCD1BE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 07:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBSqI-00016T-SN; Wed, 22 Oct 2025 03:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBSpT-0000ro-4z
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 03:00:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBSpM-0000AP-EW
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 03:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761116407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QssPPeyaIjfJevdBjzrYuPiKWfc5/sU41ILy4aVHt7c=;
 b=cfnDFy5gsQgHP90srvmWFt1AlOW8qa5soNmJ6BxnBI6QZ94mwMDU7LXLgCS1gIk1aqXm0e
 GNYwksamMZEznkx0SRt/RH+RuYqzl9Wc1sKRhduBcpLPu/iKzgmvnau+a7hSqdkMxsyiwE
 ES+UUy7LhtWB3m5iT5QOFGBuhd3aicE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-ElGh2sksNWqL4rGnDi7lbQ-1; Wed,
 22 Oct 2025 03:00:05 -0400
X-MC-Unique: ElGh2sksNWqL4rGnDi7lbQ-1
X-Mimecast-MFC-AGG-ID: ElGh2sksNWqL4rGnDi7lbQ_1761116403
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C6A8195608F; Wed, 22 Oct 2025 07:00:03 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D982E19560B0; Wed, 22 Oct 2025 07:00:00 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-arm@nongnu.org (open list:Xilinx ZynqMP and...)
Subject: [PATCH v2 35/42] audio: remove QEMUSoundCard
Date: Wed, 22 Oct 2025 10:56:30 +0400
Message-ID: <20251022065640.1172785-36-marcandre.lureau@redhat.com>
In-Reply-To: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
References: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
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

There is no clear need for this extra intermediary structure between
the audio backend and its user.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio.h                       | 18 ++++++------------
 audio/audio_int.h                   |  3 ---
 audio/audio_template.h              | 22 ++++++++++------------
 hw/audio/lm4549.h                   |  2 +-
 include/hw/audio/asc.h              |  2 +-
 include/hw/audio/virtio-snd.h       |  2 +-
 include/hw/display/xlnx_dp.h        |  2 +-
 include/hw/isa/vt82c686.h           |  2 +-
 include/hw/qdev-properties-system.h |  2 +-
 audio/audio.c                       | 29 ++++++++++-------------------
 hw/audio/ac97.c                     | 25 ++++++++++++-------------
 hw/audio/adlib.c                    |  9 ++++-----
 hw/audio/asc.c                      |  9 +++------
 hw/audio/cs4231a.c                  |  8 ++++----
 hw/audio/es1370.c                   | 23 +++++++++++------------
 hw/audio/gus.c                      |  9 ++++-----
 hw/audio/hda-codec.c                | 15 +++++++--------
 hw/audio/lm4549.c                   |  8 ++++----
 hw/audio/pcspk.c                    |  9 +++++----
 hw/audio/pl041.c                    |  2 +-
 hw/audio/sb16.c                     | 16 ++++++++--------
 hw/audio/via-ac97.c                 |  9 ++++-----
 hw/audio/virtio-snd.c               | 13 ++++++-------
 hw/audio/wm8750.c                   | 23 +++++++++++------------
 hw/core/qdev-properties-system.c    | 11 +++++------
 hw/display/xlnx_dp.c                |  6 +++---
 hw/usb/dev-audio.c                  | 11 +++++------
 27 files changed, 129 insertions(+), 161 deletions(-)

diff --git a/audio/audio.h b/audio/audio.h
index 69ba1e8b94..4c596fcc7f 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -69,18 +69,12 @@ struct AudioBackendClass {
 };
 
 typedef struct AudioBackend AudioBackend;
-typedef struct QEMUSoundCard {
-    char *name;
-    AudioBackend *be;
-    QLIST_ENTRY (QEMUSoundCard) entries;
-} QEMUSoundCard;
 
 typedef struct QEMUAudioTimeStamp {
     uint64_t old_ts;
 } QEMUAudioTimeStamp;
 
-bool AUD_register_card (const char *name, QEMUSoundCard *card, Error **errp);
-void AUD_remove_card (QEMUSoundCard *card);
+bool AUD_backend_check (AudioBackend **be, Error **errp);
 CaptureVoiceOut *AUD_add_capture(
     AudioBackend *s,
     struct audsettings *as,
@@ -90,7 +84,7 @@ CaptureVoiceOut *AUD_add_capture(
 void AUD_del_capture (CaptureVoiceOut *cap, void *cb_opaque);
 
 SWVoiceOut *AUD_open_out (
-    QEMUSoundCard *card,
+    AudioBackend *be,
     SWVoiceOut *sw,
     const char *name,
     void *callback_opaque,
@@ -98,7 +92,7 @@ SWVoiceOut *AUD_open_out (
     struct audsettings *settings
     );
 
-void AUD_close_out (QEMUSoundCard *card, SWVoiceOut *sw);
+void AUD_close_out (AudioBackend *be, SWVoiceOut *sw);
 size_t AUD_write (SWVoiceOut *sw, void *pcm_buf, size_t size);
 int  AUD_get_buffer_size_out (SWVoiceOut *sw);
 void AUD_set_active_out (SWVoiceOut *sw, int on);
@@ -121,7 +115,7 @@ void AUD_set_volume_out(SWVoiceOut *sw, Volume *vol);
 void AUD_set_volume_in(SWVoiceIn *sw, Volume *vol);
 
 SWVoiceIn *AUD_open_in (
-    QEMUSoundCard *card,
+    AudioBackend *be,
     SWVoiceIn *sw,
     const char *name,
     void *callback_opaque,
@@ -129,7 +123,7 @@ SWVoiceIn *AUD_open_in (
     struct audsettings *settings
     );
 
-void AUD_close_in (QEMUSoundCard *card, SWVoiceIn *sw);
+void AUD_close_in (AudioBackend *be, SWVoiceIn *sw);
 size_t AUD_read (SWVoiceIn *sw, void *pcm_buf, size_t size);
 void AUD_set_active_in (SWVoiceIn *sw, int on);
 int  AUD_is_active_in (SWVoiceIn *sw);
@@ -155,7 +149,7 @@ void audio_help(void);
 
 AudioBackend *audio_be_by_name(const char *name, Error **errp);
 AudioBackend *audio_get_default_audio_be(Error **errp);
-const char *audio_get_id(QEMUSoundCard *card);
+const char *audio_be_get_id(AudioBackend *be);
 
 #define DEFINE_AUDIO_PROPERTIES(_s, _f)         \
     DEFINE_PROP_AUDIODEV("audiodev", _s, _f)
diff --git a/audio/audio_int.h b/audio/audio_int.h
index d3929034b3..210457e0c4 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -108,7 +108,6 @@ typedef struct HWVoiceIn {
 } HWVoiceIn;
 
 struct SWVoiceOut {
-    QEMUSoundCard *card;
     AudioBackend *s;
     struct audio_pcm_info info;
     t_sample *conv;
@@ -125,7 +124,6 @@ struct SWVoiceOut {
 };
 
 struct SWVoiceIn {
-    QEMUSoundCard *card;
     AudioBackend *s;
     int active;
     struct audio_pcm_info info;
@@ -246,7 +244,6 @@ typedef struct AudioBackend {
     void *drv_opaque;
 
     QEMUTimer *ts;
-    QLIST_HEAD (card_listhead, QEMUSoundCard) card_head;
     QLIST_HEAD (hw_in_listhead, HWVoiceIn) hw_head_in;
     QLIST_HEAD (hw_out_listhead, HWVoiceOut) hw_head_out;
     QLIST_HEAD (cap_listhead, CaptureVoiceOut) cap_head;
diff --git a/audio/audio_template.h b/audio/audio_template.h
index b3c10a0709..97305445c8 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -473,11 +473,11 @@ static void glue (audio_close_, TYPE) (SW *sw)
     g_free (sw);
 }
 
-void glue (AUD_close_, TYPE) (QEMUSoundCard *card, SW *sw)
+void glue (AUD_close_, TYPE) (AudioBackend *be, SW *sw)
 {
     if (sw) {
-        if (audio_bug(__func__, !card)) {
-            dolog ("card=%p\n", card);
+        if (audio_bug(__func__, !be)) {
+            dolog ("backend=%p\n", be);
             return;
         }
 
@@ -486,7 +486,7 @@ void glue (AUD_close_, TYPE) (QEMUSoundCard *card, SW *sw)
 }
 
 SW *glue (AUD_open_, TYPE) (
-    QEMUSoundCard *card,
+    AudioBackend *be,
     SW *sw,
     const char *name,
     void *callback_opaque ,
@@ -494,16 +494,15 @@ SW *glue (AUD_open_, TYPE) (
     struct audsettings *as
     )
 {
-    AudioBackend *s;
+    AudioBackend *s = be;
     AudiodevPerDirectionOptions *pdo;
 
-    if (audio_bug(__func__, !card || !name || !callback_fn || !as)) {
-        dolog ("card=%p name=%p callback_fn=%p as=%p\n",
-               card, name, callback_fn, as);
+    if (audio_bug(__func__, !be || !name || !callback_fn || !as)) {
+        dolog ("backend=%p name=%p callback_fn=%p as=%p\n",
+               be, name, callback_fn, as);
         goto fail;
     }
 
-    s = card->be;
     pdo = glue(audio_get_pdo_, TYPE)(s->dev);
 
     ldebug ("open %s, freq %d, nchannels %d, fmt %d\n",
@@ -524,7 +523,7 @@ SW *glue (AUD_open_, TYPE) (
     }
 
     if (!pdo->fixed_settings && sw) {
-        glue (AUD_close_, TYPE) (card, sw);
+        glue (AUD_close_, TYPE) (be, sw);
         sw = NULL;
     }
 
@@ -548,7 +547,6 @@ SW *glue (AUD_open_, TYPE) (
         }
     }
 
-    sw->card = card;
     sw->vol = nominal_volume;
     sw->callback.fn = callback_fn;
     sw->callback.opaque = callback_opaque;
@@ -562,7 +560,7 @@ SW *glue (AUD_open_, TYPE) (
     return sw;
 
  fail:
-    glue (AUD_close_, TYPE) (card, sw);
+    glue (AUD_close_, TYPE) (be, sw);
     return NULL;
 }
 
diff --git a/hw/audio/lm4549.h b/hw/audio/lm4549.h
index 61c3ab12dd..1d858e2a04 100644
--- a/hw/audio/lm4549.h
+++ b/hw/audio/lm4549.h
@@ -21,7 +21,7 @@ typedef void (*lm4549_callback)(void *opaque);
 
 
 typedef struct {
-    QEMUSoundCard card;
+    AudioBackend *audio_be;
     SWVoiceOut *voice;
     uint32_t voice_is_active;
 
diff --git a/include/hw/audio/asc.h b/include/hw/audio/asc.h
index 04fac270b6..a60c2f597c 100644
--- a/include/hw/audio/asc.h
+++ b/include/hw/audio/asc.h
@@ -61,7 +61,7 @@ struct ASCState {
     MemoryRegion mem_regs;
     MemoryRegion mem_extregs;
 
-    QEMUSoundCard card;
+    AudioBackend *audio_be;
     SWVoiceOut *voice;
     uint8_t *mixbuf;
     int samples;
diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index 8dafedb276..0ad80bc9be 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -216,7 +216,7 @@ struct VirtIOSound {
     VirtQueue *queues[VIRTIO_SND_VQ_MAX];
     uint64_t features;
     VirtIOSoundPCM *pcm;
-    QEMUSoundCard card;
+    AudioBackend *audio_be;
     VMChangeStateEntry *vmstate;
     virtio_snd_config snd_conf;
     QemuMutex cmdq_mutex;
diff --git a/include/hw/display/xlnx_dp.h b/include/hw/display/xlnx_dp.h
index e86a87f235..802a1427c9 100644
--- a/include/hw/display/xlnx_dp.h
+++ b/include/hw/display/xlnx_dp.h
@@ -84,7 +84,7 @@ struct XlnxDPState {
     struct PixmanPlane v_plane;
     struct PixmanPlane bout_plane;
 
-    QEMUSoundCard aud_card;
+    AudioBackend *audio_be;
     SWVoiceOut *amixer_output_stream;
     int16_t audio_buffer_0[AUD_CHBUF_MAX_DEPTH];
     int16_t audio_buffer_1[AUD_CHBUF_MAX_DEPTH];
diff --git a/include/hw/isa/vt82c686.h b/include/hw/isa/vt82c686.h
index da1722daf2..48c412ce81 100644
--- a/include/hw/isa/vt82c686.h
+++ b/include/hw/isa/vt82c686.h
@@ -24,7 +24,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(ViaAC97State, VIA_AC97);
 
 struct ViaAC97State {
     PCIDevice dev;
-    QEMUSoundCard card;
+    AudioBackend *audio_be;
     MemoryRegion sgd;
     MemoryRegion fm;
     MemoryRegion midi;
diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
index 9601a11a09..1bd7a7634b 100644
--- a/include/hw/qdev-properties-system.h
+++ b/include/hw/qdev-properties-system.h
@@ -87,7 +87,7 @@ extern const PropertyInfo qdev_prop_virtio_gpu_output_list;
                 .set_default = true)
 
 #define DEFINE_PROP_AUDIODEV(_n, _s, _f) \
-    DEFINE_PROP(_n, _s, _f, qdev_prop_audiodev, QEMUSoundCard)
+    DEFINE_PROP(_n, _s, _f, qdev_prop_audiodev, AudioBackend *)
 
 #define DEFINE_PROP_UUID_NODEFAULT(_name, _state, _field) \
     DEFINE_PROP(_name, _state, _field, qdev_prop_uuid, QemuUUID)
diff --git a/audio/audio.c b/audio/audio.c
index 8a7489ec82..a2350cfe23 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1620,7 +1620,6 @@ static void audio_be_init(Object *obj)
     QLIST_INIT (&s->hw_head_out);
     QLIST_INIT (&s->hw_head_in);
     QLIST_INIT (&s->cap_head);
-    QLIST_INIT (&s->card_head);
     s->ts = timer_new_ns(QEMU_CLOCK_VIRTUAL, audio_timer, s);
 
     s->vmse = qemu_add_vm_change_state_handler(audio_vm_change_state_handler, s);
@@ -1812,28 +1811,20 @@ AudioBackend *audio_get_default_audio_be(Error **errp)
     return default_audio_be;
 }
 
-bool AUD_register_card (const char *name, QEMUSoundCard *card, Error **errp)
+bool AUD_backend_check (AudioBackend **be, Error **errp)
 {
-    if (!card->be) {
-        card->be = audio_get_default_audio_be(errp);
-        if (!card->be) {
+    assert(be != NULL);
+
+    if (!*be) {
+        *be = audio_get_default_audio_be(errp);
+        if (!*be) {
             return false;
         }
     }
 
-    card->name = g_strdup (name);
-    memset (&card->entries, 0, sizeof (card->entries));
-    QLIST_INSERT_HEAD(&card->be->card_head, card, entries);
-
     return true;
 }
 
-void AUD_remove_card (QEMUSoundCard *card)
-{
-    QLIST_REMOVE (card, entries);
-    g_free (card->name);
-}
-
 static struct audio_pcm_ops capture_pcm_ops;
 
 CaptureVoiceOut *AUD_add_capture(
@@ -2232,11 +2223,11 @@ AudioBackend *audio_be_by_name(const char *name, Error **errp)
     }
 }
 
-const char *audio_get_id(QEMUSoundCard *card)
+const char *audio_be_get_id(AudioBackend *be)
 {
-    if (card->be) {
-        assert(card->be->dev);
-        return card->be->dev->id;
+    if (be) {
+        assert(be->dev);
+        return be->dev->id;
     } else {
         return "";
     }
diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 1b2ce601a6..d23cfcf325 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -120,7 +120,7 @@ typedef struct AC97BusMasterRegs {
 
 struct AC97LinkState {
     PCIDevice dev;
-    QEMUSoundCard card;
+    AudioBackend *audio_be;
     uint32_t glob_cnt;
     uint32_t glob_sta;
     uint32_t cas;
@@ -316,7 +316,7 @@ static void open_voice(AC97LinkState *s, int index, int freq)
         switch (index) {
         case PI_INDEX:
             s->voice_pi = AUD_open_in(
-                &s->card,
+                s->audio_be,
                 s->voice_pi,
                 "ac97.pi",
                 s,
@@ -327,7 +327,7 @@ static void open_voice(AC97LinkState *s, int index, int freq)
 
         case PO_INDEX:
             s->voice_po = AUD_open_out(
-                &s->card,
+                s->audio_be,
                 s->voice_po,
                 "ac97.po",
                 s,
@@ -338,7 +338,7 @@ static void open_voice(AC97LinkState *s, int index, int freq)
 
         case MC_INDEX:
             s->voice_mc = AUD_open_in(
-                &s->card,
+                s->audio_be,
                 s->voice_mc,
                 "ac97.mc",
                 s,
@@ -351,17 +351,17 @@ static void open_voice(AC97LinkState *s, int index, int freq)
         s->invalid_freq[index] = freq;
         switch (index) {
         case PI_INDEX:
-            AUD_close_in(&s->card, s->voice_pi);
+            AUD_close_in(s->audio_be, s->voice_pi);
             s->voice_pi = NULL;
             break;
 
         case PO_INDEX:
-            AUD_close_out(&s->card, s->voice_po);
+            AUD_close_out(s->audio_be, s->voice_po);
             s->voice_po = NULL;
             break;
 
         case MC_INDEX:
-            AUD_close_in(&s->card, s->voice_mc);
+            AUD_close_in(s->audio_be, s->voice_mc);
             s->voice_mc = NULL;
             break;
         }
@@ -1271,7 +1271,7 @@ static void ac97_realize(PCIDevice *dev, Error **errp)
     AC97LinkState *s = AC97(dev);
     uint8_t *c = s->dev.config;
 
-    if (!AUD_register_card ("ac97", &s->card, errp)) {
+    if (!AUD_backend_check (&s->audio_be, errp)) {
         return;
     }
 
@@ -1316,14 +1316,13 @@ static void ac97_exit(PCIDevice *dev)
 {
     AC97LinkState *s = AC97(dev);
 
-    AUD_close_in(&s->card, s->voice_pi);
-    AUD_close_out(&s->card, s->voice_po);
-    AUD_close_in(&s->card, s->voice_mc);
-    AUD_remove_card(&s->card);
+    AUD_close_in(s->audio_be, s->voice_pi);
+    AUD_close_out(s->audio_be, s->voice_po);
+    AUD_close_in(s->audio_be, s->voice_mc);
 }
 
 static const Property ac97_properties[] = {
-    DEFINE_AUDIO_PROPERTIES(AC97LinkState, card),
+    DEFINE_AUDIO_PROPERTIES(AC97LinkState, audio_be),
 };
 
 static void ac97_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index 231055b8b5..1b3d2b8bfc 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -53,7 +53,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AdlibState, ADLIB)
 struct AdlibState {
     ISADevice parent_obj;
 
-    QEMUSoundCard card;
+    AudioBackend *audio_be;
     uint32_t freq;
     uint32_t port;
     int ticking[2];
@@ -236,7 +236,6 @@ static void Adlib_fini (AdlibState *s)
 
     s->active = 0;
     s->enabled = 0;
-    AUD_remove_card (&s->card);
 }
 
 static MemoryRegionPortio adlib_portio_list[] = {
@@ -251,7 +250,7 @@ static void adlib_realizefn (DeviceState *dev, Error **errp)
     AdlibState *s = ADLIB(dev);
     struct audsettings as;
 
-    if (!AUD_register_card ("adlib", &s->card, errp)) {
+    if (!AUD_backend_check(&s->audio_be, errp)) {
         return;
     }
 
@@ -271,7 +270,7 @@ static void adlib_realizefn (DeviceState *dev, Error **errp)
     as.endianness = HOST_BIG_ENDIAN;
 
     s->voice = AUD_open_out (
-        &s->card,
+        s->audio_be,
         s->voice,
         "adlib",
         s,
@@ -294,7 +293,7 @@ static void adlib_realizefn (DeviceState *dev, Error **errp)
 }
 
 static const Property adlib_properties[] = {
-    DEFINE_AUDIO_PROPERTIES(AdlibState, card),
+    DEFINE_AUDIO_PROPERTIES(AdlibState, audio_be),
     DEFINE_PROP_UINT32 ("iobase",  AdlibState, port, 0x220),
     DEFINE_PROP_UINT32 ("freq",    AdlibState, freq,  44100),
 };
diff --git a/hw/audio/asc.c b/hw/audio/asc.c
index 991316e984..5c3f6c8f86 100644
--- a/hw/audio/asc.c
+++ b/hw/audio/asc.c
@@ -634,8 +634,6 @@ static void asc_unrealize(DeviceState *dev)
 
     g_free(s->mixbuf);
     g_free(s->silentbuf);
-
-    AUD_remove_card(&s->card);
 }
 
 static void asc_realize(DeviceState *dev, Error **errp)
@@ -643,7 +641,7 @@ static void asc_realize(DeviceState *dev, Error **errp)
     ASCState *s = ASC(dev);
     struct audsettings as;
 
-    if (!AUD_register_card("Apple Sound Chip", &s->card, errp)) {
+    if (!AUD_backend_check(&s->audio_be, errp)) {
         return;
     }
 
@@ -652,10 +650,9 @@ static void asc_realize(DeviceState *dev, Error **errp)
     as.fmt = AUDIO_FORMAT_U8;
     as.endianness = HOST_BIG_ENDIAN;
 
-    s->voice = AUD_open_out(&s->card, s->voice, "asc.out", s, asc_out_cb,
+    s->voice = AUD_open_out(s->audio_be, s->voice, "asc.out", s, asc_out_cb,
                             &as);
     if (!s->voice) {
-        AUD_remove_card(&s->card);
         error_setg(errp, "Initializing audio stream failed");
         return;
     }
@@ -702,7 +699,7 @@ static void asc_init(Object *obj)
 }
 
 static const Property asc_properties[] = {
-    DEFINE_AUDIO_PROPERTIES(ASCState, card),
+    DEFINE_AUDIO_PROPERTIES(ASCState, audio_be),
     DEFINE_PROP_UINT8("asctype", ASCState, type, ASC_TYPE_ASC),
 };
 
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index 062af7628b..9049065a0e 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -65,7 +65,7 @@ DECLARE_INSTANCE_CHECKER(CSState, CS4231A,
 
 struct CSState {
     ISADevice dev;
-    QEMUSoundCard card;
+    AudioBackend *audio_be;
     MemoryRegion ioports;
     qemu_irq pic;
     uint32_t regs[CS_REGS];
@@ -324,7 +324,7 @@ static void cs_reset_voices (CSState *s, uint32_t val)
     }
 
     s->voice = AUD_open_out (
-        &s->card,
+        s->audio_be,
         s->voice,
         "cs4231a",
         s,
@@ -674,7 +674,7 @@ static void cs4231a_realizefn (DeviceState *dev, Error **errp)
         return;
     }
 
-    if (!AUD_register_card ("cs4231a", &s->card, errp)) {
+    if (!AUD_backend_check(&s->audio_be, errp)) {
         return;
     }
 
@@ -690,7 +690,7 @@ static void cs4231a_realizefn (DeviceState *dev, Error **errp)
 }
 
 static const Property cs4231a_properties[] = {
-    DEFINE_AUDIO_PROPERTIES(CSState, card),
+    DEFINE_AUDIO_PROPERTIES(CSState, audio_be),
     DEFINE_PROP_UINT32 ("iobase",  CSState, port, 0x534),
     DEFINE_PROP_UINT32 ("irq",     CSState, irq,  9),
     DEFINE_PROP_UINT32 ("dma",     CSState, dma,  3),
diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index ac5a6aba85..a8ca2045b3 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -258,7 +258,7 @@ struct chan {
 
 struct ES1370State {
     PCIDevice dev;
-    QEMUSoundCard card;
+    AudioBackend *audio_be;
     MemoryRegion io;
     struct chan chan[NB_CHANNELS];
     SWVoiceOut *dac_voice[2];
@@ -330,10 +330,10 @@ static void es1370_reset (ES1370State *s)
         d->scount = 0;
         d->leftover = 0;
         if (i == ADC_CHANNEL) {
-            AUD_close_in (&s->card, s->adc_voice);
+            AUD_close_in(s->audio_be, s->adc_voice);
             s->adc_voice = NULL;
         } else {
-            AUD_close_out (&s->card, s->dac_voice[i]);
+            AUD_close_out(s->audio_be, s->dac_voice[i]);
             s->dac_voice[i] = NULL;
         }
     }
@@ -412,7 +412,7 @@ static void es1370_update_voices (ES1370State *s, uint32_t ctl, uint32_t sctl)
                 if (i == ADC_CHANNEL) {
                     s->adc_voice =
                         AUD_open_in (
-                            &s->card,
+                            s->audio_be,
                             s->adc_voice,
                             "es1370.adc",
                             s,
@@ -422,7 +422,7 @@ static void es1370_update_voices (ES1370State *s, uint32_t ctl, uint32_t sctl)
                 } else {
                     s->dac_voice[i] =
                         AUD_open_out (
-                            &s->card,
+                            s->audio_be,
                             s->dac_voice[i],
                             i ? "es1370.dac2" : "es1370.dac1",
                             s,
@@ -784,12 +784,12 @@ static int es1370_post_load (void *opaque, int version_id)
     for (i = 0; i < NB_CHANNELS; ++i) {
         if (i == ADC_CHANNEL) {
             if (s->adc_voice) {
-                AUD_close_in (&s->card, s->adc_voice);
+                AUD_close_in(s->audio_be, s->adc_voice);
                 s->adc_voice = NULL;
             }
         } else {
             if (s->dac_voice[i]) {
-                AUD_close_out (&s->card, s->dac_voice[i]);
+                AUD_close_out(s->audio_be, s->dac_voice[i]);
                 s->dac_voice[i] = NULL;
             }
         }
@@ -833,7 +833,7 @@ static void es1370_realize(PCIDevice *dev, Error **errp)
     ES1370State *s = ES1370(dev);
     uint8_t *c = s->dev.config;
 
-    if (!AUD_register_card ("es1370", &s->card, errp)) {
+    if (!AUD_backend_check(&s->audio_be, errp)) {
         return;
     }
 
@@ -861,15 +861,14 @@ static void es1370_exit(PCIDevice *dev)
     int i;
 
     for (i = 0; i < 2; ++i) {
-        AUD_close_out(&s->card, s->dac_voice[i]);
+        AUD_close_out(s->audio_be, s->dac_voice[i]);
     }
 
-    AUD_close_in(&s->card, s->adc_voice);
-    AUD_remove_card(&s->card);
+    AUD_close_in(s->audio_be, s->adc_voice);
 }
 
 static const Property es1370_properties[] = {
-    DEFINE_AUDIO_PROPERTIES(ES1370State, card),
+    DEFINE_AUDIO_PROPERTIES(ES1370State, audio_be),
 };
 
 static void es1370_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index 40073f2d4f..434fa58136 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -45,7 +45,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(GUSState, GUS)
 struct GUSState {
     ISADevice dev;
     GUSEmuState emu;
-    QEMUSoundCard card;
+    AudioBackend *audio_be;
     uint32_t freq;
     uint32_t port;
     int pos, left, shift, irqs;
@@ -238,7 +238,7 @@ static void gus_realizefn (DeviceState *dev, Error **errp)
     IsaDmaClass *k;
     struct audsettings as;
 
-    if (!AUD_register_card ("gus", &s->card, errp)) {
+    if (!AUD_backend_check(&s->audio_be, errp)) {
         return;
     }
 
@@ -254,7 +254,7 @@ static void gus_realizefn (DeviceState *dev, Error **errp)
     as.endianness = HOST_BIG_ENDIAN;
 
     s->voice = AUD_open_out (
-        &s->card,
+        s->audio_be,
         NULL,
         "gus",
         s,
@@ -263,7 +263,6 @@ static void gus_realizefn (DeviceState *dev, Error **errp)
         );
 
     if (!s->voice) {
-        AUD_remove_card (&s->card);
         error_setg(errp, "No voice");
         return;
     }
@@ -288,7 +287,7 @@ static void gus_realizefn (DeviceState *dev, Error **errp)
 }
 
 static const Property gus_properties[] = {
-    DEFINE_AUDIO_PROPERTIES(GUSState, card),
+    DEFINE_AUDIO_PROPERTIES(GUSState, audio_be),
     DEFINE_PROP_UINT32 ("freq",    GUSState, freq,        44100),
     DEFINE_PROP_UINT32 ("iobase",  GUSState, port,        0x240),
     DEFINE_PROP_UINT32 ("irq",     GUSState, emu.gusirq,  7),
diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index cc87557954..f7ae2aa1fd 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -178,7 +178,7 @@ struct HDAAudioState {
     HDACodecDevice hda;
     const char *name;
 
-    QEMUSoundCard card;
+    AudioBackend *audio_be;
     const desc_codec *desc;
     HDAAudioStream st[4];
     bool running_compat[16];
@@ -491,7 +491,7 @@ static void hda_audio_setup(HDAAudioStream *st)
         } else {
             cb = hda_audio_compat_output_cb;
         }
-        st->voice.out = AUD_open_out(&st->state->card, st->voice.out,
+        st->voice.out = AUD_open_out(st->state->audio_be, st->voice.out,
                                      st->node->name, st, cb, &st->as);
     } else {
         if (use_timer) {
@@ -500,7 +500,7 @@ static void hda_audio_setup(HDAAudioStream *st)
         } else {
             cb = hda_audio_compat_input_cb;
         }
-        st->voice.in = AUD_open_in(&st->state->card, st->voice.in,
+        st->voice.in = AUD_open_in(st->state->audio_be, st->voice.in,
                                    st->node->name, st, cb, &st->as);
     }
 }
@@ -696,7 +696,7 @@ static void hda_audio_init(HDACodecDevice *hda,
     const desc_param *param;
     uint32_t i, type;
 
-    if (!AUD_register_card("hda", &a->card, errp)) {
+    if (!AUD_backend_check(&a->audio_be, errp)) {
         return;
     }
 
@@ -754,12 +754,11 @@ static void hda_audio_exit(HDACodecDevice *hda)
         }
         timer_free(st->buft);
         if (st->output) {
-            AUD_close_out(&a->card, st->voice.out);
+            AUD_close_out(a->audio_be, st->voice.out);
         } else {
-            AUD_close_in(&a->card, st->voice.in);
+            AUD_close_in(a->audio_be, st->voice.in);
         }
     }
-    AUD_remove_card(&a->card);
 }
 
 static int hda_audio_post_load(void *opaque, int version)
@@ -858,7 +857,7 @@ static const VMStateDescription vmstate_hda_audio = {
 };
 
 static const Property hda_audio_properties[] = {
-    DEFINE_AUDIO_PROPERTIES(HDAAudioState, card),
+    DEFINE_AUDIO_PROPERTIES(HDAAudioState, audio_be),
     DEFINE_PROP_UINT32("debug", HDAAudioState, debug,   0),
     DEFINE_PROP_BOOL("mixer", HDAAudioState, mixer,  true),
     DEFINE_PROP_BOOL("use-timer", HDAAudioState, use_timer,  true),
diff --git a/hw/audio/lm4549.c b/hw/audio/lm4549.c
index dccbf56068..c51ec0e66f 100644
--- a/hw/audio/lm4549.c
+++ b/hw/audio/lm4549.c
@@ -190,7 +190,7 @@ void lm4549_write(lm4549_state *s,
         as.endianness = 0;
 
         s->voice = AUD_open_out(
-            &s->card,
+            s->audio_be,
             s->voice,
             "lm4549.out",
             s,
@@ -260,7 +260,7 @@ static int lm4549_post_load(void *opaque, int version_id)
     as.endianness = 0;
 
     s->voice = AUD_open_out(
-        &s->card,
+        s->audio_be,
         s->voice,
         "lm4549.out",
         s,
@@ -282,7 +282,7 @@ void lm4549_init(lm4549_state *s, lm4549_callback data_req_cb, void* opaque,
     struct audsettings as;
 
     /* Register an audio card */
-    if (!AUD_register_card("lm4549", &s->card, errp)) {
+    if (!AUD_backend_check(&s->audio_be, errp)) {
         return;
     }
 
@@ -300,7 +300,7 @@ void lm4549_init(lm4549_state *s, lm4549_callback data_req_cb, void* opaque,
     as.endianness = 0;
 
     s->voice = AUD_open_out(
-        &s->card,
+        s->audio_be,
         s->voice,
         "lm4549.out",
         s,
diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index e9ab5ac41b..36efb038f3 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -48,7 +48,7 @@ struct PCSpkState {
     MemoryRegion ioport;
     uint32_t iobase;
     uint8_t sample_buf[PCSPK_BUF_LEN];
-    QEMUSoundCard card;
+    AudioBackend *audio_be;
     SWVoiceOut *voice;
     PITCommonState *pit;
     unsigned int pit_count;
@@ -122,7 +122,7 @@ static int pcspk_audio_init(PCSpkState *s)
         return 0;
     }
 
-    s->voice = AUD_open_out(&s->card, s->voice, s_spk, s, pcspk_callback, &as);
+    s->voice = AUD_open_out(s->audio_be, s->voice, s_spk, s, pcspk_callback, &as);
     if (!s->voice) {
         error_report("pcspk: Could not open voice");
         return -1;
@@ -188,8 +188,9 @@ static void pcspk_realizefn(DeviceState *dev, Error **errp)
 
     isa_register_ioport(isadev, &s->ioport, s->iobase);
 
-    if (s->card.be && AUD_register_card(s_spk, &s->card, errp)) {
+    if (s->audio_be && AUD_backend_check(&s->audio_be, errp)) {
         pcspk_audio_init(s);
+        return;
     }
 }
 
@@ -213,7 +214,7 @@ static const VMStateDescription vmstate_spk = {
 };
 
 static const Property pcspk_properties[] = {
-    DEFINE_AUDIO_PROPERTIES(PCSpkState, card),
+    DEFINE_AUDIO_PROPERTIES(PCSpkState, audio_be),
     DEFINE_PROP_UINT32("iobase", PCSpkState, iobase,  0x61),
     DEFINE_PROP_BOOL("migrate", PCSpkState, migrate,  true),
     DEFINE_PROP_LINK("pit", PCSpkState, pit, TYPE_PIT_COMMON, PITCommonState *),
diff --git a/hw/audio/pl041.c b/hw/audio/pl041.c
index 5d9d6c1178..fd3d09611f 100644
--- a/hw/audio/pl041.c
+++ b/hw/audio/pl041.c
@@ -626,7 +626,7 @@ static const VMStateDescription vmstate_pl041 = {
 };
 
 static const Property pl041_device_properties[] = {
-    DEFINE_AUDIO_PROPERTIES(PL041State, codec.card),
+    DEFINE_AUDIO_PROPERTIES(PL041State, codec.audio_be),
     /* Non-compact FIFO depth property */
     DEFINE_PROP_UINT32("nc_fifo_depth", PL041State, fifo_depth,
                        DEFAULT_FIFO_DEPTH),
diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index 069cf6e120..4978c2c014 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -50,7 +50,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(SB16State, SB16)
 struct SB16State {
     ISADevice parent_obj;
 
-    QEMUSoundCard card;
+    AudioBackend *audio_be;
     qemu_irq pic;
     uint32_t irq;
     uint32_t dma;
@@ -212,7 +212,7 @@ static void continue_dma8 (SB16State *s)
         as.endianness = 0;
 
         s->voice = AUD_open_out (
-            &s->card,
+            s->audio_be,
             s->voice,
             "sb16",
             s,
@@ -375,7 +375,7 @@ static void dma_cmd (SB16State *s, uint8_t cmd, uint8_t d0, int dma_len)
         as.endianness = 0;
 
         s->voice = AUD_open_out (
-            &s->card,
+            s->audio_be,
             s->voice,
             "sb16",
             s,
@@ -876,7 +876,7 @@ static void legacy_reset (SB16State *s)
     as.endianness = 0;
 
     s->voice = AUD_open_out (
-        &s->card,
+        s->audio_be,
         s->voice,
         "sb16",
         s,
@@ -1283,7 +1283,7 @@ static int sb16_post_load (void *opaque, int version_id)
     SB16State *s = opaque;
 
     if (s->voice) {
-        AUD_close_out (&s->card, s->voice);
+        AUD_close_out(s->audio_be, s->voice);
         s->voice = NULL;
     }
 
@@ -1299,7 +1299,7 @@ static int sb16_post_load (void *opaque, int version_id)
             as.endianness = 0;
 
             s->voice = AUD_open_out (
-                &s->card,
+                s->audio_be,
                 s->voice,
                 "sb16",
                 s,
@@ -1397,7 +1397,7 @@ static void sb16_realizefn (DeviceState *dev, Error **errp)
     SB16State *s = SB16 (dev);
     IsaDmaClass *k;
 
-    if (!AUD_register_card ("sb16", &s->card, errp)) {
+    if (!AUD_backend_check(&s->audio_be, errp)) {
         return;
     }
 
@@ -1436,7 +1436,7 @@ static void sb16_realizefn (DeviceState *dev, Error **errp)
 }
 
 static const Property sb16_properties[] = {
-    DEFINE_AUDIO_PROPERTIES(SB16State, card),
+    DEFINE_AUDIO_PROPERTIES(SB16State, audio_be),
     DEFINE_PROP_UINT32 ("version", SB16State, ver,  0x0405), /* 4.5 */
     DEFINE_PROP_UINT32 ("iobase",  SB16State, port, 0x220),
     DEFINE_PROP_UINT32 ("irq",     SB16State, irq,  5),
diff --git a/hw/audio/via-ac97.c b/hw/audio/via-ac97.c
index 62341e5600..019d296853 100644
--- a/hw/audio/via-ac97.c
+++ b/hw/audio/via-ac97.c
@@ -239,7 +239,7 @@ static void open_voice_out(ViaAC97State *s)
         .fmt = s->aur.type & BIT(5) ? AUDIO_FORMAT_S16 : AUDIO_FORMAT_S8,
         .endianness = 0,
     };
-    s->vo = AUD_open_out(&s->card, s->vo, "via-ac97.out", s, out_cb, &as);
+    s->vo = AUD_open_out(s->audio_be, s->vo, "via-ac97.out", s, out_cb, &as);
 }
 
 static uint64_t sgd_read(void *opaque, hwaddr addr, unsigned size)
@@ -426,7 +426,7 @@ static void via_ac97_realize(PCIDevice *pci_dev, Error **errp)
     ViaAC97State *s = VIA_AC97(pci_dev);
     Object *o = OBJECT(s);
 
-    if (!AUD_register_card ("via-ac97", &s->card, errp)) {
+    if (!AUD_backend_check(&s->audio_be, errp)) {
         return;
     }
 
@@ -455,12 +455,11 @@ static void via_ac97_exit(PCIDevice *dev)
 {
     ViaAC97State *s = VIA_AC97(dev);
 
-    AUD_close_out(&s->card, s->vo);
-    AUD_remove_card(&s->card);
+    AUD_close_out(s->audio_be, s->vo);
 }
 
 static const Property via_ac97_properties[] = {
-    DEFINE_AUDIO_PROPERTIES(ViaAC97State, card),
+    DEFINE_AUDIO_PROPERTIES(ViaAC97State, audio_be),
 };
 
 static void via_ac97_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 88777977a9..9101560f38 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -78,7 +78,7 @@ static const VMStateDescription vmstate_virtio_snd = {
 };
 
 static const Property virtio_snd_properties[] = {
-    DEFINE_AUDIO_PROPERTIES(VirtIOSound, card),
+    DEFINE_AUDIO_PROPERTIES(VirtIOSound, audio_be),
     DEFINE_PROP_UINT32("jacks", VirtIOSound, snd_conf.jacks,
                        VIRTIO_SOUND_JACK_DEFAULT),
     DEFINE_PROP_UINT32("streams", VirtIOSound, snd_conf.streams,
@@ -391,10 +391,10 @@ static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
     if (stream) {
         virtio_snd_pcm_flush(stream);
         if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
-            AUD_close_out(&stream->pcm->snd->card, stream->voice.out);
+            AUD_close_out(stream->pcm->snd->audio_be, stream->voice.out);
             stream->voice.out = NULL;
         } else if (stream->info.direction == VIRTIO_SND_D_INPUT) {
-            AUD_close_in(&stream->pcm->snd->card, stream->voice.in);
+            AUD_close_in(stream->pcm->snd->audio_be, stream->voice.in);
             stream->voice.in = NULL;
         }
     }
@@ -457,7 +457,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
     stream->as = as;
 
     if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
-        stream->voice.out = AUD_open_out(&s->card,
+        stream->voice.out = AUD_open_out(s->audio_be,
                                          stream->voice.out,
                                          "virtio-sound.out",
                                          stream,
@@ -465,7 +465,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
                                          &as);
         AUD_set_volume_out_lr(stream->voice.out, 0, 255, 255);
     } else {
-        stream->voice.in = AUD_open_in(&s->card,
+        stream->voice.in = AUD_open_in(s->audio_be,
                                         stream->voice.in,
                                         "virtio-sound.in",
                                         stream,
@@ -1053,7 +1053,7 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (!AUD_register_card("virtio-sound", &vsnd->card, errp)) {
+    if (!AUD_backend_check(&vsnd->audio_be, errp)) {
         return;
     }
 
@@ -1330,7 +1330,6 @@ static void virtio_snd_unrealize(DeviceState *dev)
         g_free(vsnd->pcm);
         vsnd->pcm = NULL;
     }
-    AUD_remove_card(&vsnd->card);
     qemu_mutex_destroy(&vsnd->cmdq_mutex);
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_CONTROL]);
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_EVENT]);
diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
index 7a36c4bd3f..d399c335c3 100644
--- a/hw/audio/wm8750.c
+++ b/hw/audio/wm8750.c
@@ -34,7 +34,7 @@ struct WM8750State {
 
     uint8_t i2c_data[2];
     int i2c_len;
-    QEMUSoundCard card;
+    AudioBackend *audio_be;
     SWVoiceIn *adc_voice[IN_PORT_N];
     SWVoiceOut *dac_voice[OUT_PORT_N];
     int enable;
@@ -188,12 +188,12 @@ static void wm8750_set_format(WM8750State *s)
 
     for (i = 0; i < IN_PORT_N; i ++)
         if (s->adc_voice[i]) {
-            AUD_close_in(&s->card, s->adc_voice[i]);
+            AUD_close_in(s->audio_be, s->adc_voice[i]);
             s->adc_voice[i] = NULL;
         }
     for (i = 0; i < OUT_PORT_N; i ++)
         if (s->dac_voice[i]) {
-            AUD_close_out(&s->card, s->dac_voice[i]);
+            AUD_close_out(s->audio_be, s->dac_voice[i]);
             s->dac_voice[i] = NULL;
         }
 
@@ -206,11 +206,11 @@ static void wm8750_set_format(WM8750State *s)
     in_fmt.freq = s->adc_hz;
     in_fmt.fmt = AUDIO_FORMAT_S16;
 
-    s->adc_voice[0] = AUD_open_in(&s->card, s->adc_voice[0],
+    s->adc_voice[0] = AUD_open_in(s->audio_be, s->adc_voice[0],
                     CODEC ".input1", s, wm8750_audio_in_cb, &in_fmt);
-    s->adc_voice[1] = AUD_open_in(&s->card, s->adc_voice[1],
+    s->adc_voice[1] = AUD_open_in(s->audio_be, s->adc_voice[1],
                     CODEC ".input2", s, wm8750_audio_in_cb, &in_fmt);
-    s->adc_voice[2] = AUD_open_in(&s->card, s->adc_voice[2],
+    s->adc_voice[2] = AUD_open_in(s->audio_be, s->adc_voice[2],
                     CODEC ".input3", s, wm8750_audio_in_cb, &in_fmt);
 
     /* Setup output */
@@ -219,12 +219,12 @@ static void wm8750_set_format(WM8750State *s)
     out_fmt.freq = s->dac_hz;
     out_fmt.fmt = AUDIO_FORMAT_S16;
 
-    s->dac_voice[0] = AUD_open_out(&s->card, s->dac_voice[0],
+    s->dac_voice[0] = AUD_open_out(s->audio_be, s->dac_voice[0],
                     CODEC ".speaker", s, wm8750_audio_out_cb, &out_fmt);
-    s->dac_voice[1] = AUD_open_out(&s->card, s->dac_voice[1],
+    s->dac_voice[1] = AUD_open_out(s->audio_be, s->dac_voice[1],
                     CODEC ".headphone", s, wm8750_audio_out_cb, &out_fmt);
     /* MONOMIX is also in stereo for simplicity */
-    s->dac_voice[2] = AUD_open_out(&s->card, s->dac_voice[2],
+    s->dac_voice[2] = AUD_open_out(s->audio_be, s->dac_voice[2],
                     CODEC ".monomix", s, wm8750_audio_out_cb, &out_fmt);
     /* no sense emulating OUT3 which is a mix of other outputs */
 
@@ -624,7 +624,7 @@ static void wm8750_realize(DeviceState *dev, Error **errp)
 {
     WM8750State *s = WM8750(dev);
 
-    if (!AUD_register_card(CODEC, &s->card, errp)) {
+    if (!AUD_backend_check(&s->audio_be, errp)) {
         return;
     }
 
@@ -637,7 +637,6 @@ static void wm8750_fini(I2CSlave *i2c)
     WM8750State *s = WM8750(i2c);
 
     wm8750_reset(I2C_SLAVE(s));
-    AUD_remove_card(&s->card);
     g_free(s);
 }
 #endif
@@ -707,7 +706,7 @@ void wm8750_set_bclk_in(void *opaque, int new_hz)
 }
 
 static const Property wm8750_properties[] = {
-    DEFINE_AUDIO_PROPERTIES(WM8750State, card),
+    DEFINE_AUDIO_PROPERTIES(WM8750State, audio_be),
 };
 
 static void wm8750_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index c83a52fc62..578cbdc015 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -487,18 +487,17 @@ static void get_audiodev(Object *obj, Visitor *v, const char* name,
                          void *opaque, Error **errp)
 {
     const Property *prop = opaque;
-    QEMUSoundCard *card = object_field_prop_ptr(obj, prop);
-    char *p = g_strdup(audio_get_id(card));
+    AudioBackend **be = object_field_prop_ptr(obj, prop);
+    g_autofree char *id = g_strdup(audio_be_get_id(*be));
 
-    visit_type_str(v, name, &p, errp);
-    g_free(p);
+    visit_type_str(v, name, (char **)&id, errp);
 }
 
 static void set_audiodev(Object *obj, Visitor *v, const char* name,
                          void *opaque, Error **errp)
 {
     const Property *prop = opaque;
-    QEMUSoundCard *card = object_field_prop_ptr(obj, prop);
+    AudioBackend **be = object_field_prop_ptr(obj, prop);
     AudioBackend *state;
     g_autofree char *str = NULL;
 
@@ -508,7 +507,7 @@ static void set_audiodev(Object *obj, Visitor *v, const char* name,
 
     state = audio_be_by_name(str, errp);
     if (state) {
-        card->be = state;
+        *be = state;
     }
 }
 
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 882ae3c4b4..96cbb1b3a7 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1306,7 +1306,7 @@ static void xlnx_dp_realize(DeviceState *dev, Error **errp)
     DisplaySurface *surface;
     struct audsettings as;
 
-    if (!AUD_register_card("xlnx_dp.audio", &s->aud_card, errp)) {
+    if (!AUD_backend_check(&s->audio_be, errp)) {
         return;
     }
 
@@ -1328,7 +1328,7 @@ static void xlnx_dp_realize(DeviceState *dev, Error **errp)
     as.fmt = AUDIO_FORMAT_S16;
     as.endianness = 0;
 
-    s->amixer_output_stream = AUD_open_out(&s->aud_card,
+    s->amixer_output_stream = AUD_open_out(s->audio_be,
                                            s->amixer_output_stream,
                                            "xlnx_dp.audio.out",
                                            s,
@@ -1392,7 +1392,7 @@ static void xlnx_dp_reset(DeviceState *dev)
 }
 
 static const Property xlnx_dp_device_properties[] = {
-    DEFINE_AUDIO_PROPERTIES(XlnxDPState, aud_card),
+    DEFINE_AUDIO_PROPERTIES(XlnxDPState, audio_be),
 };
 
 static void xlnx_dp_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index f59e5a53f0..c8e032ab64 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -635,7 +635,7 @@ static uint8_t *streambuf_get(struct streambuf *buf, size_t *len)
 struct USBAudioState {
     /* qemu interfaces */
     USBDevice dev;
-    QEMUSoundCard card;
+    AudioBackend *audio_be;
 
     /* state */
     struct {
@@ -931,8 +931,7 @@ static void usb_audio_unrealize(USBDevice *dev)
     }
 
     usb_audio_set_output_altset(s, ALTSET_OFF);
-    AUD_close_out(&s->card, s->out.voice);
-    AUD_remove_card(&s->card);
+    AUD_close_out(s->audio_be, s->out.voice);
 
     streambuf_fini(&s->out.buf);
 }
@@ -942,7 +941,7 @@ static void usb_audio_realize(USBDevice *dev, Error **errp)
     USBAudioState *s = USB_AUDIO(dev);
     int i;
 
-    if (!AUD_register_card(TYPE_USB_AUDIO, &s->card, errp)) {
+    if (!AUD_backend_check(&s->audio_be, errp)) {
         return;
     }
 
@@ -979,7 +978,7 @@ static void usb_audio_reinit(USBDevice *dev, unsigned channels)
     s->out.as.endianness = 0;
     streambuf_init(&s->out.buf, s->buffer, s->out.channels);
 
-    s->out.voice = AUD_open_out(&s->card, s->out.voice, TYPE_USB_AUDIO,
+    s->out.voice = AUD_open_out(s->audio_be, s->out.voice, TYPE_USB_AUDIO,
                                 s, output_callback, &s->out.as);
     AUD_set_volume_out(s->out.voice, &s->out.vol);
     AUD_set_active_out(s->out.voice, 0);
@@ -991,7 +990,7 @@ static const VMStateDescription vmstate_usb_audio = {
 };
 
 static const Property usb_audio_properties[] = {
-    DEFINE_AUDIO_PROPERTIES(USBAudioState, card),
+    DEFINE_AUDIO_PROPERTIES(USBAudioState, audio_be),
     DEFINE_PROP_UINT32("debug", USBAudioState, debug, 0),
     DEFINE_PROP_UINT32("buffer", USBAudioState, buffer_user, 0),
     DEFINE_PROP_BOOL("multi", USBAudioState, multi, false),
-- 
2.51.0


