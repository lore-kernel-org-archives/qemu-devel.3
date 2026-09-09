Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F97FC79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4GMZ-00084I-5Q; Wed, 09 Sep 2026 07:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1x4GMY-00083v-2e
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:21:10 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1x4GMU-0000sY-Jp
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:21:09 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c250a2bc3b3so700451566b.2
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 04:21:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788952864; cv=none;
 d=google.com; s=arc-20260327;
 b=M+Htz8owF/3te8EQjPTYS/ilE1wlPtNlJiIYMFoKZ8PBNyqpz+EIeRIzN7yP+z9+yd
 cj3mIH8F/+McqZBvlcqcKFFIhaijbtrcAfzNSf4J3gIi5yimD9xAA+UBDNgTo1puim81
 8o8gUtxjnZv0TmGhEcmh0SsQosPNt3AictwbHpO/kSYGKFxwQYisDbmjL8/AjC3NLV3R
 RBReS7xf61QsTLi37+EnUFFbMb2FFTFoQ3B59xvk9fscJaMa54Z+dopC3DwpGdXadWDN
 iI23fwlJyDmSDtvdKDl0V7Q5OFOVRU7Y7/3G5JUlkYvW5uZRABW/2Tih0SFWM7ZFUrgz
 1Jyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pb3SzBKrkPff6FHxpB8DzuuXXEjMDUEqPl1T8gdRoMU=;
 fh=+YY8Td6BzP/pG4PCbnufthTNhmxWwkmv9wr1dFxI/U4=;
 b=SiEQDHCc5v0dV9kInQbQyY+zUhJT7veByhnw8l1MzmGfNi3UWJ/5jOCmw6AkSec7Ln
 3ixXozHxIw7gnO0dzcBu2B5xcZZq2jOhEU12h7W/A9Plgo16HuI/eTdu8eclzgEmcZ6w
 Yy4rI/3R+3hVLddcWDegCXDW+lw9Ih/PcyP49Dzj+avvIpiWQm6HPJgPxaIoNzG8sdeT
 mhp7phRCP/sGm6ylm4vViQggWpXvboF4jJ0FW68hvX4uasbTl0MLAfYIgViBC/yXK6CY
 4JlU5/2BK/UfIdKLBoV3i1XtU4qZeghpA8Px17ndkg8rFwtAcj3YwAfRhUJdnZDICS1j
 2v5w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1788952864; x=1789557664; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pb3SzBKrkPff6FHxpB8DzuuXXEjMDUEqPl1T8gdRoMU=;
 b=J/Gpv74dCD4Ky28Z2bZQaY/MSPK2oNUG+WUr5eQJp/0wMO3GKrKMlXQEs6Gm/s6Gks
 5Yz3Qa2IFAsaD8/x0e/gene9dFaA6mdZmhw9HJMU1MlvWEfoLogFCqEXacpHL9RcIruo
 AMqdjVCa8r8xh+YV3g4gyGwZA3egVcb4HowOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788952864; x=1789557664;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pb3SzBKrkPff6FHxpB8DzuuXXEjMDUEqPl1T8gdRoMU=;
 b=re8xx4pv5U5M0GSLjDLHe5YJiX5Oju6sKeAuLgnOPeM+dkhsn1z6FNBwII9gq28RLc
 25xPlTB7zQjD8gJoU5R1UIAaIGa1QUUCAeTNR1AUI4nzYG4CWPTb0U/qnPgAcsffMv/P
 pnjBPVrn76hSbBL4+A+Ag2MARTKMAkAF6vJaKu8u4YQ/ZL0EdUTK+YdGF7/D8byXOwwP
 sTgZoGnsWL1bdy8NanVhmTCQPQOqxb+oCfkgNt8XlbDN7tlAd0wRhBG8/0d9LkJIrcwU
 ZA0SLOb6itG3TQk4lVoUcu8vS7xSBvxyU9Ltu2+RO1XzD/buvQHOi1GwOLE/mra4MxW/
 Hlig==
X-Gm-Message-State: AFuF++nlK42aWZgdFBu1he0LugPY3xyNqVQih974O+vyJFgxEv68T+dg
 TT0ewJnvMYuAoFAeProqeRclxD1+bsw1pId7W1ohNn072oDkYGpsqGtmR+ovA7vxFU82e3UX69O
 dmCnBW6eQZqOueYs8N5C+cs/paZRbXF4UhFzGCbOGag==
X-Gm-Gg: AYBFou3xvBBRLZQAFuHwNKugKgJgCMmcyQXCQfrDPzNCycT+eECptLMlaeoKq7lEuej
 4xHuHjuKOsRQsBsdEBbc15iQttCI66ItDEi7UKCphoMXBbYaqyiUr1WMWh9KYodDLCF1p3LFLq1
 4Ohc3nH2/Kwbf2P0baLcaWdmTVjgNlBkK1asqF4zSwEXDynaSXIWOeGyC5DWU9tUY/HNQEMlFlq
 MCyiZaphAijUbsuBGC5rc6eeBRvUamdWRZIV24DRDHrDnFHNTGeROXox1g/ssylfkhPrLj07Qaw
 El+rwkFpJArrsUe4U9USSXFJmiIDWhxTunyP5d3J4enb6wOi/9wDYH9F2k1M9ske3kSzb6UBtZb
 YxrGEPnBFS7Y=
X-Received: by 2002:a17:907:ea8d:b0:c26:2795:b494 with SMTP id
 a640c23a62f3a-c262795c1b3mr970647666b.49.1788952864139; Wed, 09 Sep 2026
 04:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260803081159.91981-1-alexander@mihalicyn.com>
 <20260803081159.91981-8-alexander@mihalicyn.com>
 <tl364p.3wmmsms274jr@linaro.org>
In-Reply-To: <tl364p.3wmmsms274jr@linaro.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 9 Sep 2026 13:20:51 +0200
X-Gm-Features: AcwNN1Xdm9-tMDZ4mNHxEz2rW0LFe2Rgzr_cxyXIOaBDiM7DW68ah6dFoN4zdx0
Message-ID: <CAJqdLrr2aAVHzJNpg8ykJKABTGT=TkLWOV_PDrSk8tsmBBBE+g@mail.gmail.com>
Subject: Re: [PATCH v5 07/10] hw/audio/virtio-sound: add stream state variable
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alexander@mihalicyn.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am Mi., 9. Sept. 2026 um 09:29 Uhr schrieb Manos Pitsidianakis
<manos.pitsidianakis@linaro.org>:
>
> On Mon, 03 Aug 2026 11:11, Alexander Mikhalitsyn <alexander@mihalicyn.com=
> wrote:
> >From: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> >
> >So far, only rudimentary checks have been made to ensure that
> >the guest only performs state transitions described in
> >virtio-v1.2-csd01 5.14.6.6.1 PCM Command Lifecycle. While this
> >is not a Device Requirement, let's add a state variable
> >per audio stream and check all state transitions.
> >
> >Because only permitted state transitions are now possible, only one
> >copy of the audio stream parameters is required and these do not
> >need to be initialised with default values.
> >
> >The state variable will also make it easier to restore the audio
> >stream after migration.
> >
> >Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> >[AM: there were too many conflicts, I did `git checkout --ours -- <.>`
> >     and then reimplemented the patch idea
> >/AM]
> >Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.=
io>
> >---
> >v5:
> >       - checkpatch fix
> >v4:
> >       - switched to enum virtio_snd_pcm_state
> >         (suggested by Manos Pitsidianakis)
> >       - call virtio_snd_pcm_close() when switching to
> >         VSND_PCMSTREAM_STATE_PARAMS_SET and VSND_PCMSTREAM_STATE_RELEAS=
ED
> >         states
> >       - added virtio_error() in case when stream->state is unexpected
> >       - fixed an error message text in virtio_snd_set_pcm_params
> >         (suggestions from Marc-Andr=C3=A9 Lureau)
> >v3:
> >       - explicitly call virtio_snd_pcm_close() from unrealize
> >       - remove a call to virtio_snd_pcm_flush() from virtio_snd_pcm_clo=
se()
> >       [ ^ this was my rebase mistake ]
> >---
> > hw/audio/virtio-snd.c         | 213 ++++++++++++++++++++--------------
> > include/hw/audio/virtio-snd.h |  17 +--
> > 2 files changed, 124 insertions(+), 106 deletions(-)
> >
> >diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> >index 46026b8cffc..1c218569cfd 100644
> >--- a/hw/audio/virtio-snd.c
> >+++ b/hw/audio/virtio-snd.c
> >@@ -30,11 +30,26 @@
> > #define VIRTIO_SOUND_CHMAP_DEFAULT 0
> > #define VIRTIO_SOUND_HDA_FN_NID 0
> >
> >+typedef enum virtio_snd_pcm_state {
> >+    VIRTIO_SND_PCM_STATE_UNINIT =3D 0,
> >+    VIRTIO_SND_PCM_STATE_PARAMS_SET,
> >+    VIRTIO_SND_PCM_STATE_PREPARED,
> >+    VIRTIO_SND_PCM_STATE_STARTED,
> >+    VIRTIO_SND_PCM_STATE_STOPPED,
> >+    VIRTIO_SND_PCM_STATE_RELEASED,
> >+} virtio_snd_pcm_state;
> >+
> >+static inline bool virtio_snd_pcm_state_prepared(virtio_snd_pcm_state s=
)
> >+{
> >+    return s > VIRTIO_SND_PCM_STATE_PARAMS_SET &&
> >+           s < VIRTIO_SND_PCM_STATE_RELEASED;
> >+}
> >+
> > static void virtio_snd_pcm_out_cb(void *data, int available);
> > static void virtio_snd_process_cmdq(VirtIOSound *s);
> > static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream);
> >+static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream);
> > static void virtio_snd_pcm_in_cb(void *data, int available);
> >-static void virtio_snd_unrealize(DeviceState *dev);
> >
> > static uint32_t supported_formats =3D BIT(VIRTIO_SND_PCM_FMT_S8)
> >                                   | BIT(VIRTIO_SND_PCM_FMT_U8)
> >@@ -129,7 +144,7 @@ static VirtIOSoundPCMStream *virtio_snd_pcm_get_stre=
am(VirtIOSound *s,
> >                                                        uint32_t stream_=
id)
> > {
> >     return stream_id >=3D s->snd_conf.streams ? NULL :
> >-        s->pcm.streams[stream_id];
> >+        &s->streams[stream_id];
> > }
> >
> > /*
> >@@ -141,8 +156,8 @@ static VirtIOSoundPCMStream *virtio_snd_pcm_get_stre=
am(VirtIOSound *s,
> > static virtio_snd_pcm_set_params *virtio_snd_pcm_get_params(VirtIOSound=
 *s,
> >                                                             uint32_t st=
ream_id)
> > {
> >-    return stream_id >=3D s->snd_conf.streams ? NULL
> >-        : &s->pcm.pcm_params[stream_id];
> >+    return stream_id >=3D s->snd_conf.streams ? NULL :
> >+        &s->streams[stream_id].params;
> > }
> >
> > /*
> >@@ -245,11 +260,10 @@ static void virtio_snd_handle_pcm_info(VirtIOSound=
 *s,
> >
> > /*
> >  * Set the given stream params.
> >- * Called by both virtio_snd_handle_pcm_set_params and during device
> >- * initialization.
> >  * Returns the response status code. (VIRTIO_SND_S_*).
> >  *
> >  * @s: VirtIOSound device
> >+ * @stream_id: stream id
> >  * @params: The PCM params as defined in the virtio specification
> >  */
> > static
> >@@ -257,14 +271,27 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
> >                                    uint32_t stream_id,
> >                                    virtio_snd_pcm_set_params *params)
> > {
> >+    VirtIOSoundPCMStream *stream;
> >     virtio_snd_pcm_set_params *st_params;
> >
> >-    if (stream_id >=3D s->snd_conf.streams || s->pcm.pcm_params =3D=3D =
NULL) {
> >-        virtio_error(VIRTIO_DEVICE(s), "Streams have not been initializ=
ed.\n");
> >+    stream =3D virtio_snd_pcm_get_stream(s, stream_id);
> >+    if (!stream) {
> >+        virtio_error(VIRTIO_DEVICE(s), "invalid stream id: %"PRIu32,
> >+                     stream_id);
> >         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> >     }
> >
> >-    st_params =3D virtio_snd_pcm_get_params(s, stream_id);
> >+    switch (stream->state) {
> >+    case VIRTIO_SND_PCM_STATE_UNINIT:
> >+    case VIRTIO_SND_PCM_STATE_PARAMS_SET:
> >+    case VIRTIO_SND_PCM_STATE_PREPARED:
> >+    case VIRTIO_SND_PCM_STATE_RELEASED:
> >+        break;
> >+    default:
> >+        virtio_error(VIRTIO_DEVICE(s), "unexpected stream state: %"PRIu=
32,
> >+                     stream->state);
> >+        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> >+    }
> >
> >     if (params->channels < 1 || params->channels > AUDIO_MAX_CHANNELS) =
{
> >         error_report("Number of channels is not supported.");
> >@@ -281,6 +308,8 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
> >         return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
> >     }
> >
> >+    st_params =3D virtio_snd_pcm_get_params(s, stream_id);
> >+
> >     st_params->buffer_bytes =3D le32_to_cpu(params->buffer_bytes);
> >     st_params->period_bytes =3D le32_to_cpu(params->period_bytes);
> >     st_params->features =3D le32_to_cpu(params->features);
> >@@ -289,6 +318,15 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
> >     st_params->format =3D params->format;
> >     st_params->rate =3D params->rate;
> >
> >+    if (virtio_snd_pcm_state_prepared(stream->state)) {
> >+        /* implicit VIRTIO_SND_R_PCM_RELEASE */
> >+        virtio_snd_pcm_flush(stream);
> >+    }
> >+
> >+    virtio_snd_pcm_close(stream);
> >+
> >+    stream->state =3D VIRTIO_SND_PCM_STATE_PARAMS_SET;
> >+
> >     return cpu_to_le32(VIRTIO_SND_S_OK);
> > }
> >
> >@@ -398,15 +436,12 @@ static void virtio_snd_get_qemu_audsettings(audset=
tings *as,
> >  */
> > static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
> > {
> >-    if (stream) {
> >-        virtio_snd_pcm_flush(stream);
> >-        if (stream->info.direction =3D=3D VIRTIO_SND_D_OUTPUT) {
> >-            audio_be_close_out(stream->s->audio_be, stream->voice.out);
> >-            stream->voice.out =3D NULL;
> >-        } else if (stream->info.direction =3D=3D VIRTIO_SND_D_INPUT) {
> >-            audio_be_close_in(stream->s->audio_be, stream->voice.in);
> >-            stream->voice.in =3D NULL;
> >-        }
> >+    if (stream->info.direction =3D=3D VIRTIO_SND_D_OUTPUT) {
> >+        audio_be_close_out(stream->s->audio_be, stream->voice.out);
> >+        stream->voice.out =3D NULL;
> >+    } else if (stream->info.direction =3D=3D VIRTIO_SND_D_INPUT) {
> >+        audio_be_close_in(stream->s->audio_be, stream->voice.in);
> >+        stream->voice.in =3D NULL;
> >     }
> > }
> >
> >@@ -423,33 +458,26 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound=
 *s, uint32_t stream_id)
> >     virtio_snd_pcm_set_params *params;
> >     VirtIOSoundPCMStream *stream;
> >
> >-    if (s->pcm.streams =3D=3D NULL ||
> >-        s->pcm.pcm_params =3D=3D NULL ||
> >-        stream_id >=3D s->snd_conf.streams) {
> >+    stream =3D virtio_snd_pcm_get_stream(s, stream_id);
> >+    if (!stream) {
> >         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> >     }
> >
> >-    params =3D virtio_snd_pcm_get_params(s, stream_id);
> >-    if (params =3D=3D NULL) {
> >+    switch (stream->state) {
> >+    case VIRTIO_SND_PCM_STATE_PARAMS_SET:
> >+    case VIRTIO_SND_PCM_STATE_PREPARED:
> >+    case VIRTIO_SND_PCM_STATE_RELEASED:
> >+        break;
> >+    default:
> >+        virtio_error(VIRTIO_DEVICE(s), "unexpected stream state: %"PRIu=
32,
> >+                     stream->state);
> >         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> >     }
> >
> >-    stream =3D virtio_snd_pcm_get_stream(s, stream_id);
> >-    if (stream =3D=3D NULL) {
> >-        stream =3D &s->streams[stream_id];
> >-        stream->active =3D false;
> >-        stream->latency_bytes =3D 0;
> >-
> >-        /*
> >-         * stream_id >=3D s->snd_conf.streams was checked before so thi=
s is
> >-         * in-bounds
> >-         */
> >-        s->pcm.streams[stream_id] =3D stream;
> >-    }
> >+    params =3D virtio_snd_pcm_get_params(s, stream_id);
> >
> >     virtio_snd_get_qemu_audsettings(&as, params);
> >     stream->info.channels_max =3D as.nchannels;
> >-    stream->params =3D *params;
> >
> >     stream->as =3D as;
> >
> >@@ -471,6 +499,8 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *=
s, uint32_t stream_id)
> >         audio_be_set_volume_in_lr(s->audio_be, stream->voice.in, 0, 255=
, 255);
> >     }
> >
> >+    stream->state =3D VIRTIO_SND_PCM_STATE_PREPARED;
> >+
> >     return cpu_to_le32(VIRTIO_SND_S_OK);
> > }
> >
> >@@ -545,7 +575,31 @@ static uint32_t virtio_snd_pcm_start_stop(VirtIOSou=
nd *s,
> >         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> >     }
> >
> >-    stream->active =3D start;
> >+    if (start) {
> >+        switch (stream->state) {
> >+        case VIRTIO_SND_PCM_STATE_PREPARED:
> >+        case VIRTIO_SND_PCM_STATE_STOPPED:
> >+            break;
> >+        default:
> >+            virtio_error(VIRTIO_DEVICE(s), "unexpected stream state: %"=
PRIu32,
> >+                         stream->state);
> >+            return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> >+        }
> >+
> >+        stream->state =3D VIRTIO_SND_PCM_STATE_STARTED;
> >+    } else {
> >+        switch (stream->state) {
> >+        case VIRTIO_SND_PCM_STATE_STARTED:
> >+            break;
> >+        default:
> >+            virtio_error(VIRTIO_DEVICE(s), "unexpected stream state: %"=
PRIu32,
> >+                         stream->state);
> >+            return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> >+        }
> >+
> >+        stream->state =3D VIRTIO_SND_PCM_STATE_STOPPED;
> >+    }
> >+
> >     if (stream->info.direction =3D=3D VIRTIO_SND_D_OUTPUT) {
> >         audio_be_set_active_out(s->audio_be, stream->voice.out, start);
> >     } else {
> >@@ -639,6 +693,17 @@ static void virtio_snd_handle_pcm_release(VirtIOSou=
nd *s,
> >         return;
> >     }
> >
> >+    switch (stream->state) {
> >+    case VIRTIO_SND_PCM_STATE_PREPARED:
> >+    case VIRTIO_SND_PCM_STATE_STOPPED:
> >+        break;
> >+    default:
> >+        virtio_error(VIRTIO_DEVICE(s), "unexpected stream state: %"PRIu=
32,
> >+                     stream->state);
> >+        cmd->resp.code =3D cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> >+        return;
> >+    }
> >+
> >     if (virtio_snd_pcm_get_io_msgs_count(stream)) {
> >         /*
> >          * virtio-v1.2-csd01, 5.14.6.6.5.1,
> >@@ -653,6 +718,10 @@ static void virtio_snd_handle_pcm_release(VirtIOSou=
nd *s,
> >         virtio_snd_pcm_flush(stream);
> >     }
> >
> >+    virtio_snd_pcm_close(stream);
> >+
> >+    stream->state =3D VIRTIO_SND_PCM_STATE_RELEASED;
> >+
> >     cmd->resp.code =3D cpu_to_le32(VIRTIO_SND_S_OK);
> > }
> >
> >@@ -876,12 +945,11 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice=
 *vdev, VirtQueue *vq)
> >         size =3D iov_size(elem->out_sg, elem->out_num) - msg_sz;
> >         stream_id =3D le32_to_cpu(hdr.stream_id);
> >
> >-        if (stream_id >=3D vsnd->snd_conf.streams
> >-            || vsnd->pcm.streams[stream_id] =3D=3D NULL) {
> >+        if (stream_id >=3D vsnd->snd_conf.streams) {
> >             goto tx_err;
> >         }
> >
> >-        stream =3D vsnd->pcm.streams[stream_id];
> >+        stream =3D &vsnd->streams[stream_id];
> >         if (stream->info.direction !=3D VIRTIO_SND_D_OUTPUT) {
> >             goto tx_err;
> >         }
> >@@ -959,15 +1027,13 @@ static void virtio_snd_handle_rx_xfer(VirtIODevic=
e *vdev, VirtQueue *vq)
> >         }
> >         stream_id =3D le32_to_cpu(hdr.stream_id);
> >
> >-        if (stream_id >=3D vsnd->snd_conf.streams
> >-            || !vsnd->pcm.streams[stream_id]) {
> >+        if (stream_id >=3D vsnd->snd_conf.streams) {
> >             goto rx_err;
> >         }
> >
> >-        stream =3D vsnd->pcm.streams[stream_id];
> >+        stream =3D &vsnd->streams[stream_id];
> >         size =3D iov_size(elem->in_sg, elem->in_num);
> >-        if (stream =3D=3D NULL
> >-            || stream->info.direction !=3D VIRTIO_SND_D_INPUT
> >+        if (stream->info.direction !=3D VIRTIO_SND_D_INPUT
> >             || size < sizeof(virtio_snd_pcm_status)) {
> >             goto rx_err;
> >         }
> >@@ -1031,8 +1097,6 @@ static void virtio_snd_realize(DeviceState *dev, E=
rror **errp)
> >     ERRP_GUARD();
> >     VirtIOSound *vsnd =3D VIRTIO_SND(dev);
> >     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> >-    virtio_snd_pcm_set_params default_params =3D { 0 };
> >-    uint32_t status;
> >
> >     trace_virtio_snd_realize(vsnd);
> >
> >@@ -1069,6 +1133,7 @@ static void virtio_snd_realize(DeviceState *dev, E=
rror **errp)
> >     for (uint32_t i =3D 0; i < vsnd->snd_conf.streams; i++) {
> >         VirtIOSoundPCMStream *stream =3D &vsnd->streams[i];
> >
> >+        stream->state =3D VIRTIO_SND_PCM_STATE_UNINIT;
> >         stream->s =3D vsnd;
> >         QSIMPLEQ_INIT(&stream->queue);
> >         stream->info.hdr.hda_fn_nid =3D VIRTIO_SOUND_HDA_FN_NID;
> >@@ -1082,21 +1147,9 @@ static void virtio_snd_realize(DeviceState *dev, =
Error **errp)
> >         stream->info.channels_max =3D 2;
> >     }
> >
> >-    vsnd->pcm.streams =3D
> >-        g_new0(VirtIOSoundPCMStream *, vsnd->snd_conf.streams);
> >-    vsnd->pcm.pcm_params =3D
> >-        g_new0(virtio_snd_pcm_set_params, vsnd->snd_conf.streams);
> >-
> >     virtio_init(vdev, VIRTIO_ID_SOUND, sizeof(virtio_snd_config));
> >     virtio_add_feature(&vsnd->features, VIRTIO_F_VERSION_1);
> >
> >-    /* set default params for all streams */
> >-    default_params.features =3D 0;
> >-    default_params.buffer_bytes =3D cpu_to_le32(8192);
> >-    default_params.period_bytes =3D cpu_to_le32(2048);
> >-    default_params.channels =3D 2;
> >-    default_params.format =3D VIRTIO_SND_PCM_FMT_S16;
> >-    default_params.rate =3D VIRTIO_SND_PCM_RATE_48000;
> >     vsnd->queues[VIRTIO_SND_VQ_CONTROL] =3D
> >         virtio_add_queue(vdev, 64, virtio_snd_handle_ctrl);
> >     vsnd->queues[VIRTIO_SND_VQ_EVENT] =3D
> >@@ -1107,28 +1160,6 @@ static void virtio_snd_realize(DeviceState *dev, =
Error **errp)
> >         virtio_add_queue(vdev, 64, virtio_snd_handle_rx_xfer);
> >     QTAILQ_INIT(&vsnd->cmdq);
> >     QSIMPLEQ_INIT(&vsnd->invalid);
> >-
> >-    for (uint32_t i =3D 0; i < vsnd->snd_conf.streams; i++) {
> >-        status =3D virtio_snd_set_pcm_params(vsnd, i, &default_params);
> >-        if (status !=3D cpu_to_le32(VIRTIO_SND_S_OK)) {
> >-            error_setg(errp,
> >-                       "Can't initialize stream params, device responde=
d with %s.",
> >-                       print_code(status));
> >-            goto error_cleanup;
> >-        }
> >-        status =3D virtio_snd_pcm_prepare(vsnd, i);
> >-        if (status !=3D cpu_to_le32(VIRTIO_SND_S_OK)) {
> >-            error_setg(errp,
> >-                       "Can't prepare streams, device responded with %s=
.",
> >-                       print_code(status));
> >-            goto error_cleanup;
> >-        }
> >-    }
> >-
> >-    return;
> >-
> >-error_cleanup:
> >-    virtio_snd_unrealize(dev);
> > }
> >
> > static inline void update_latency(VirtIOSoundPCMStream *s, size_t used)
> >@@ -1177,7 +1208,7 @@ static void virtio_snd_pcm_out_cb(void *data, int =
available)
> >         if (!virtio_queue_ready(buffer->vq)) {
> >             return;
> >         }
> >-        if (!stream->active) {
> >+        if (stream->state !=3D VIRTIO_SND_PCM_STATE_STARTED) {
> >             /* Stream has stopped, so do not perform audio_be_write. */
>
>
> The spec says in 5.14.6.6.1 PCM Command Lifecycle (between PREPARE and
> START states):
>
>     3.  Output only: the driver transfers data for pre-buffing.
>
> Does this mean the guest cannot prebuf?

Yes, it looks like so. My interpretation is that because of
`return_tx_buffer` call we shouldn't
lose anything but guest driver may be a bit surprised by this behavior..

>
> This is not introduced by this patch but it made me notice it.
>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Thank you! ;-)

>
> >             return_tx_buffer(stream, buffer);
> >             continue;
> >@@ -1271,7 +1302,7 @@ static void virtio_snd_pcm_in_cb(void *data, int a=
vailable)
> >         if (!virtio_queue_ready(buffer->vq)) {
> >             return;
> >         }
> >-        if (!stream->active) {
> >+        if (stream->state !=3D VIRTIO_SND_PCM_STATE_STARTED) {
> >             /* Stream has stopped, so do not perform audio_be_read. */
> >             return_rx_buffer(stream, buffer);
> >             continue;
> >@@ -1344,17 +1375,16 @@ static void virtio_snd_unrealize(DeviceState *de=
v)
> >     qemu_del_vm_change_state_handler(vsnd->vmstate);
> >     trace_virtio_snd_unrealize(vsnd);
> >
> >-    if (vsnd->pcm.streams) {
> >+    if (vsnd->streams) {
> >+        virtio_snd_process_cmdq(vsnd);
> >         for (uint32_t i =3D 0; i < vsnd->snd_conf.streams; i++) {
> >-            stream =3D vsnd->pcm.streams[i];
> >-            if (stream) {
> >-                virtio_snd_process_cmdq(stream->s);
> >-                virtio_snd_pcm_close(stream);
> >+            stream =3D &vsnd->streams[i];
> >+            if (virtio_snd_pcm_state_prepared(stream->state)) {
> >+                virtio_snd_pcm_flush(stream);
> >             }
> >+            virtio_snd_pcm_close(stream);
> >         }
> >-        g_free(vsnd->pcm.streams);
> >     }
> >-    g_free(vsnd->pcm.pcm_params);
> >     g_free(vsnd->streams);
> >     vsnd->streams =3D NULL;
> >     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_CONTROL]);
> >@@ -1387,6 +1417,9 @@ static void virtio_snd_reset(VirtIODevice *vdev)
> >         VirtIOSoundPCMStream *stream =3D &vsnd->streams[i];
> >         VirtIOSoundPCMBuffer *buffer;
> >
> >+        virtio_snd_pcm_close(stream);
> >+        stream->state =3D VIRTIO_SND_PCM_STATE_UNINIT;
> >+
> >         while ((buffer =3D QSIMPLEQ_FIRST(&stream->queue))) {
> >             QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
> >             virtio_snd_pcm_buffer_free(buffer);
> >diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd=
.h
> >index 97ffaae18be..85d5d7c8619 100644
> >--- a/include/hw/audio/virtio-snd.h
> >+++ b/include/hw/audio/virtio-snd.h
> >@@ -75,8 +75,6 @@ typedef struct VirtIOSoundPCMStream VirtIOSoundPCMStre=
am;
> >
> > typedef struct virtio_snd_ctrl_command virtio_snd_ctrl_command;
> >
> >-typedef struct VirtIOSoundPCM VirtIOSoundPCM;
> >-
> > typedef struct VirtIOSoundPCMBuffer VirtIOSoundPCMBuffer;
> >
> > /*
> >@@ -121,28 +119,16 @@ struct VirtIOSoundPCMBuffer {
> >     uint8_t data[];
> > };
> >
> >-struct VirtIOSoundPCM {
> >-    /*
> >-     * PCM parameters are a separate field instead of a VirtIOSoundPCMS=
tream
> >-     * field, because the operation of PCM control requests is first
> >-     * VIRTIO_SND_R_PCM_SET_PARAMS and then VIRTIO_SND_R_PCM_PREPARE; t=
his
> >-     * means that some times we get parameters without having an alloca=
ted
> >-     * stream yet.
> >-     */
> >-    virtio_snd_pcm_set_params *pcm_params;
> >-    VirtIOSoundPCMStream **streams;
> >-};
> >-
> > struct VirtIOSoundPCMStream {
> >     virtio_snd_pcm_info info;
> >     virtio_snd_pcm_set_params params;
> >+    uint32_t state;
> >     VirtIOSound *s;
> >     audsettings as;
> >     union {
> >         SWVoiceIn *in;
> >         SWVoiceOut *out;
> >     } voice;
> >-    bool active;
> >     uint32_t latency_bytes;
> >     QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) queue;
> > };
> >@@ -209,7 +195,6 @@ struct VirtIOSound {
> >
> >     VirtQueue *queues[VIRTIO_SND_VQ_MAX];
> >     uint64_t features;
> >-    VirtIOSoundPCM pcm;
> >     VirtIOSoundPCMStream *streams;
> >     AudioBackend *audio_be;
> >     VMChangeStateEntry *vmstate;
> >--
> >2.47.3
> >

