Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54661C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 11:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi93h-0003Z9-VW; Fri, 10 Jul 2026 07:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wi93f-0003Xr-Ol
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 07:06:15 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wi93c-0002wH-8x
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 07:06:15 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-69c19a37eeaso1506152a12.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 04:06:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783681570; cv=none;
 d=google.com; s=arc-20260327;
 b=TEsGDmew360eFqnRcf2OYNj1lhEXAkaKwwuy/9t+RSZIh1wbRpqm0oOJBUcHLDVqNy
 WPbu51BWl4Z+xGYDLUTvt2dcJ1QxfyAQEFhN0bM88RLflmWaSD7nEQOeg1AKbIjI7RbF
 k8KrKYkR9Cv0oeOhrpzrrrqXqeaYFWkZHs9Z0+yR/5inQosdwny/sXB/4vix1GjnGjch
 3YCFm9O/4ho/h1x2hnnXzgcMTKBHqmtjg9N/yoNMZCDM5ti+GgPrezxeTZSVbO2+JUeT
 lnFvq1TXgovXFO3py9kf2XwYKLkaVJF1DWgtPALsJBBOyzQcOqRVs2OLO76GPzgNUocU
 nZwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tt2qkq4j7/rt7Y1fcXGHgZZfv4VzPSDesTkYkI0Q8oc=;
 fh=qty3g77Sl39ix/vs6vEQferIpKkxxHZnWW1uZOZG04Y=;
 b=hzeh/yVqlwR30mIRS3fkEdcyao7l7R9yDvjRgX3WYAYJnMsRApecV36V2+l51h/4bY
 9p0WfUHT7wb65ztbqIVQhHKlQWli9pqMCq1EZNVOCOaDbD77Kq0CCO6Rn+HVx0Q7cvvI
 My29WKoiBBCXI5lKnAPI5hG9NwkBEwxUuGuCLKj/i3XA2Pd/MJ/kEJeQeY6wgiL2XPTt
 bZqL6OTh26Si0IA27VDQJd9SkDh48tZh8yD/TLqdMCRxJisqi7g5YmWcxdoykt/2YF+C
 6t6uTCaM4EtAB0kxXi5alFaAI3mbgJ73yC0cT3dUsOpAXbMRcd/aPWG0kr+kRCCK7ERz
 xlmw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1783681570; x=1784286370; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tt2qkq4j7/rt7Y1fcXGHgZZfv4VzPSDesTkYkI0Q8oc=;
 b=gl9CPYmTsYhrWv15dcC/WTPtJhzvKt3lhW1OKBo7URNbQrM1ShFb0rQQZfT4UL1Q4L
 t6ZbeO7Sce9s4ougx64AN5GpZGlDLv1EVk5N+bHP47KLy6gNr/TJh3ITnlqrBgw2X+Qo
 c+IZeMfsHt3WLmnM6H9qBAd4mhiiGShhHJB8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783681570; x=1784286370;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tt2qkq4j7/rt7Y1fcXGHgZZfv4VzPSDesTkYkI0Q8oc=;
 b=pT8GUXOwlZugjXQzIktJ9aEzvkZ9IK42eaQwO9EmT5Zze13T1PXD1eNNcqw5Pywncu
 K3YyG8bVNAfuNUBO1Jjs6OSwo3lX1jqASUvGlBxD6VOINfACq7b7S7ydaymQajD7wlFd
 JV1WipLemJqOzLaE4i6J1cdEyZmTjYYR8qfdP+mmXNEqq/I6XVYEXq0mUBevvHKmkFMf
 HhyL5GsL1vvbvRzJnxImVgXkt9dR9fGslvK1T06459BP0sS2lPa5wH4y5XEwvkLchH0U
 QIVjtEdLJnDxMskkPziameor151ovjuTNg2JJ5E/L9d3YPXxi9oPNBnuZYKPNYzyJpRk
 7UuQ==
X-Gm-Message-State: AOJu0YwKDQVznyWgrFVlPaS4jaMnXOlvS7cgmg9JC8lePOzA7Ywzv3T4
 QDLLF2ys0A9h46YKUZEBEKM92wwTWhm76jKHfu2jiZxJfjtm6qyOvXrcu7OUtiIlqCyGB5LBaqi
 e4JxT6LQGXCoKsR8dyo63cM14BG93t76nudRd/abpqg==
X-Gm-Gg: AfdE7cm1QXfRFhPod2zTEbNj0loo8vUtUP+A3Ax8GkeEsPm3H+5sgIeY84rZfVdBHcb
 Wc0TcSot2MThnCIXHZgU9/DHYvVOAGEfM/3ZXwCLZ5jkHnWxyEBJ2Ne3ZMHcOrVk4xsZjbqKeXQ
 1n1CpW2HfrGe1IDjkRuxvm6Q1pl74w5hBTKZkmZuey0u3LZLVgpa4btT2KtVDZG0/hjB3/0OgbZ
 qBfNA40FPataL6ZU2vc9a4TwjuqHaoHr026KTiwFz/4Nh4uABBzw0aqHUgMF0SKFCEJOP5O+YGT
 6dVOyxzoe/F28S4ZORszGV68TD8=
X-Received: by 2002:a17:907:982:b0:c12:6201:c4c6 with SMTP id
 a640c23a62f3a-c15ce01095fmr521769666b.11.1783681570142; Fri, 10 Jul 2026
 04:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260626123531.132078-1-alexander@mihalicyn.com>
 <20260626123531.132078-6-alexander@mihalicyn.com>
 <thdwg7.z2gqqr4zn5aq@linaro.org>
In-Reply-To: <thdwg7.z2gqqr4zn5aq@linaro.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Fri, 10 Jul 2026 13:05:58 +0200
X-Gm-Features: AUfX_myaHxiOFvPLgStglfUK5Z74GWfjKR7qFCMRLNBf6OLFPR4qDz1Oh6TFGCE
Message-ID: <CAJqdLrrtHf49FKNPq+Yo+QC9Q89sZ8CLiXNtVTYB7KGnrpBy0A@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] hw/audio/virtio-sound: add stream state variable
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alexander@mihalicyn.com; helo=mail-ed1-x533.google.com
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

Am Mo., 29. Juni 2026 um 10:19 Uhr schrieb Manos Pitsidianakis
<manos.pitsidianakis@linaro.org>:
>
> On Fri, 26 Jun 2026 15:35, Alexander Mikhalitsyn <alexander@mihalicyn.com=
> wrote:
> >From: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> >
> >So far, only rudimentary checks have been made to ensure that
> >the guest only performs state transitions permitted in
> >virtio-v1.2-csd01 5.14.6.6.1 PCM Command Lifecycle. Add a state
> >variable per audio stream and check all state transitions.
>
>
> This was on purpose: 5.14.6.6.1 is not a Device Requirement / normative
> statement. (In my opinion it should have been).
>
> I do not oppose keeping the state though, I chose to do it in the Rust
> implementation (vhost-device-sound) after I wrote this one as well. It
> makes sense. But please update the commit message to say that this is
> not about spec compliance, but simply doing a sanity check following the
> PCM Command Lifecycle section.
>
>
> >
> >Because only permitted state transitions are possible, only one
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
> >v3:
> >       - explicitly call virtio_snd_pcm_close() from unrealize
> >       - remove a call to virtio_snd_pcm_flush() from virtio_snd_pcm_clo=
se()
> >       [ ^ this was my rebase mistake ]
> >---
> > hw/audio/virtio-snd.c         | 196 +++++++++++++++++++---------------
> > include/hw/audio/virtio-snd.h |  18 +---
> > 2 files changed, 109 insertions(+), 105 deletions(-)
> >
> >diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> >index 300ba13ffeb..68d737478f5 100644
> >--- a/hw/audio/virtio-snd.c
> >+++ b/hw/audio/virtio-snd.c
> >@@ -30,11 +30,30 @@
> > #define VIRTIO_SOUND_CHMAP_DEFAULT 0
> > #define VIRTIO_SOUND_HDA_FN_NID 0
> >
> >+#define VSND_PCMSTREAM_STATE_F_PARAMS_SET  0x10000
> >+#define VSND_PCMSTREAM_STATE_F_PREPARED    0x20000
> >+#define VSND_PCMSTREAM_STATE_F_ACTIVE      0x40000
> >+
> >+#define VSND_PCMSTREAM_STATE_UNINITIALIZED 0
> >+#define VSND_PCMSTREAM_STATE_PARAMS_SET    (1 \
> >+                                           | VSND_PCMSTREAM_STATE_F_PAR=
AMS_SET)
> >+#define VSND_PCMSTREAM_STATE_PREPARED      (2 \
> >+                                           | VSND_PCMSTREAM_STATE_F_PAR=
AMS_SET \
> >+                                           | VSND_PCMSTREAM_STATE_F_PRE=
PARED)
> >+#define VSND_PCMSTREAM_STATE_STARTED       (4 \
> >+                                           | VSND_PCMSTREAM_STATE_F_PAR=
AMS_SET \
> >+                                           | VSND_PCMSTREAM_STATE_F_PRE=
PARED \
> >+                                           | VSND_PCMSTREAM_STATE_F_ACT=
IVE)
> >+#define VSND_PCMSTREAM_STATE_STOPPED       (6 \
> >+                                           | VSND_PCMSTREAM_STATE_F_PAR=
AMS_SET \
> >+                                           | VSND_PCMSTREAM_STATE_F_PRE=
PARED)
> >+#define VSND_PCMSTREAM_STATE_RELEASED      (7 \
> >+                                           | VSND_PCMSTREAM_STATE_F_PAR=
AMS_SET)
>
> Are the VSND_PCMSTREAM_STATE_F_* really needed? Seems excessive.

yeah, I don't know exactly why Volker went this way originally, but I
can guess he had just
tried to follow a numbering scheme for states from 5.14.6.6.1 "PCM
Command Lifecycle"
and make it universal enough, cause as long as we put this thing as:
VMSTATE_UINT32(state, VirtIOSoundPCMStream)
it stops being just an implementation detail and becomes an API that
we=E2=80=99ll need to remain backward-compatible with.

>
> I'd do: (did not type check/compile)
>
> + enum virtio_snd_pcm_state {
> +   VIRTIO_SND_PCM_STATE_UNINIT =3D 0,
> +   VIRTIO_SND_PCM_STATE_PARAMS_SET,
> +   VIRTIO_SND_PCM_STATE_PREPARED,
> +   VIRTIO_SND_PCM_STATE_STARTED,
> +   VIRTIO_SND_PCM_STATE_STOPPED,
> +   VIRTIO_SND_PCM_STATE_RELEASED,
> + }
>
> Maybe even write a "method" "macro" for preparedness:
>
> +
> + static inline bool virtio_snd_pcm_state_prepared(virtio_snd_pcm_state
> s) {
> + return s > VIRTIO_SND_PCM_STATE_PARAMS_SET && s <
> VIRTIO_SND_PCM_STATE_RELEASED
> + }
>
> And "active" flag bit is only in STARTED state, so just check for
> equality.
>
> This is not a hard request, but it seems simpler to me and would prefer
> it.

yeah, let me try to rework that part to see if everything fits well.

>
> >+
> > static void virtio_snd_pcm_out_cb(void *data, int available);
> > static void virtio_snd_process_cmdq(VirtIOSound *s);
> > static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream);
> > static void virtio_snd_pcm_in_cb(void *data, int available);
> >-static void virtio_snd_unrealize(DeviceState *dev);
> >
> > static uint32_t supported_formats =3D BIT(VIRTIO_SND_PCM_FMT_S8)
> >                                   | BIT(VIRTIO_SND_PCM_FMT_U8)
> >@@ -129,7 +148,7 @@ static VirtIOSoundPCMStream *virtio_snd_pcm_get_stre=
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
> >@@ -141,8 +160,8 @@ static VirtIOSoundPCMStream *virtio_snd_pcm_get_stre=
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
> >@@ -245,11 +264,10 @@ static void virtio_snd_handle_pcm_info(VirtIOSound=
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
> >@@ -257,14 +275,25 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
> >                                    uint32_t stream_id,
> >                                    virtio_snd_pcm_set_params *params)
> > {
> >+    VirtIOSoundPCMStream *stream;
> >     virtio_snd_pcm_set_params *st_params;
> >
> >-    if (stream_id >=3D s->snd_conf.streams || s->pcm.pcm_params =3D=3D =
NULL) {
> >+    if (stream_id >=3D s->snd_conf.streams) {
> >         virtio_error(VIRTIO_DEVICE(s), "Streams have not been initializ=
ed.\n");
> >         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> >     }
> >
> >-    st_params =3D virtio_snd_pcm_get_params(s, stream_id);
> >+    stream =3D virtio_snd_pcm_get_stream(s, stream_id);
> >+
> >+    switch (stream->state) {
> >+    case VSND_PCMSTREAM_STATE_UNINITIALIZED:
> >+    case VSND_PCMSTREAM_STATE_PARAMS_SET:
> >+    case VSND_PCMSTREAM_STATE_PREPARED:
> >+    case VSND_PCMSTREAM_STATE_RELEASED:
> >+        break;
> >+    default:
> >+        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> >+    }
> >
> >     if (params->channels < 1 || params->channels > AUDIO_MAX_CHANNELS) =
{
> >         error_report("Number of channels is not supported.");
> >@@ -281,6 +310,8 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
> >         return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
> >     }
> >
> >+    st_params =3D virtio_snd_pcm_get_params(s, stream_id);
> >+
> >     st_params->buffer_bytes =3D le32_to_cpu(params->buffer_bytes);
> >     st_params->period_bytes =3D le32_to_cpu(params->period_bytes);
> >     st_params->features =3D le32_to_cpu(params->features);
> >@@ -289,6 +320,13 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
> >     st_params->format =3D params->format;
> >     st_params->rate =3D params->rate;
> >
> >+    if (stream->state & VSND_PCMSTREAM_STATE_F_PREPARED) {
> >+        /* implicit VIRTIO_SND_R_PCM_RELEASE */
> >+        virtio_snd_pcm_flush(stream);
> >+    }
> >+
> >+    stream->state =3D VSND_PCMSTREAM_STATE_PARAMS_SET;
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
> >@@ -423,32 +458,23 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound=
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
> >+    case VSND_PCMSTREAM_STATE_PARAMS_SET:
> >+    case VSND_PCMSTREAM_STATE_PREPARED:
> >+    case VSND_PCMSTREAM_STATE_RELEASED:
> >+        break;
> >+    default:
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
> >-    stream->params =3D *params;
> >
> >     stream->positions[0] =3D VIRTIO_SND_CHMAP_FL;
> >     stream->positions[1] =3D VIRTIO_SND_CHMAP_FR;
> >@@ -472,6 +498,8 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *=
s, uint32_t stream_id)
> >         audio_be_set_volume_in_lr(s->audio_be, stream->voice.in, 0, 255=
, 255);
> >     }
> >
> >+    stream->state =3D VSND_PCMSTREAM_STATE_PREPARED;
> >+
> >     return cpu_to_le32(VIRTIO_SND_S_OK);
> > }
> >
> >@@ -542,12 +570,28 @@ static uint32_t virtio_snd_pcm_start_stop(VirtIOSo=
und *s,
> >     }
> >
> >     if (start) {
> >+        switch (stream->state) {
> >+        case VSND_PCMSTREAM_STATE_PREPARED:
> >+        case VSND_PCMSTREAM_STATE_STOPPED:
> >+            break;
> >+        default:
> >+            return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> >+        }
> >+
> >         trace_virtio_snd_handle_pcm_start(stream_id);
> >+        stream->state =3D VSND_PCMSTREAM_STATE_STARTED;
> >     } else {
> >+        switch (stream->state) {
> >+        case VSND_PCMSTREAM_STATE_STARTED:
> >+            break;
> >+        default:
> >+            return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> >+        }
> >+
> >         trace_virtio_snd_handle_pcm_stop(stream_id);
> >+        stream->state =3D VSND_PCMSTREAM_STATE_STOPPED;
> >     }
> >
> >-    stream->active =3D start;
> >     if (stream->info.direction =3D=3D VIRTIO_SND_D_OUTPUT) {
> >         audio_be_set_active_out(s->audio_be, stream->voice.out, start);
> >     } else {
> >@@ -641,6 +685,15 @@ static void virtio_snd_handle_pcm_release(VirtIOSou=
nd *s,
> >         return;
> >     }
> >
> >+    switch (stream->state) {
> >+    case VSND_PCMSTREAM_STATE_PREPARED:
> >+    case VSND_PCMSTREAM_STATE_STOPPED:
> >+        break;
> >+    default:
> >+        cmd->resp.code =3D cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> >+        return;
> >+    }
> >+
> >     if (virtio_snd_pcm_get_io_msgs_count(stream)) {
> >         /*
> >          * virtio-v1.2-csd01, 5.14.6.6.5.1,
> >@@ -655,6 +708,8 @@ static void virtio_snd_handle_pcm_release(VirtIOSoun=
d *s,
> >         virtio_snd_pcm_flush(stream);
> >     }
> >
> >+    stream->state =3D VSND_PCMSTREAM_STATE_RELEASED;
> >+
> >     cmd->resp.code =3D cpu_to_le32(VIRTIO_SND_S_OK);
> > }
> >
> >@@ -876,12 +931,11 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice=
 *vdev, VirtQueue *vq)
> >         }
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
> >@@ -956,13 +1010,12 @@ static void virtio_snd_handle_rx_xfer(VirtIODevic=
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
> >-        if (stream =3D=3D NULL || stream->info.direction !=3D VIRTIO_SN=
D_D_INPUT) {
> >+        stream =3D &vsnd->streams[stream_id];
> >+        if (stream->info.direction !=3D VIRTIO_SND_D_INPUT) {
> >             goto rx_err;
> >         }
> >
> >@@ -1021,8 +1074,6 @@ static void virtio_snd_realize(DeviceState *dev, E=
rror **errp)
> >     ERRP_GUARD();
> >     VirtIOSound *vsnd =3D VIRTIO_SND(dev);
> >     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> >-    virtio_snd_pcm_set_params default_params =3D { 0 };
> >-    uint32_t status;
> >
> >     trace_virtio_snd_realize(vsnd);
> >
> >@@ -1059,6 +1110,7 @@ static void virtio_snd_realize(DeviceState *dev, E=
rror **errp)
> >     for (uint32_t i =3D 0; i < vsnd->snd_conf.streams; i++) {
> >         VirtIOSoundPCMStream *stream =3D &vsnd->streams[i];
> >
> >+        stream->state =3D VSND_PCMSTREAM_STATE_UNINITIALIZED;
> >         stream->s =3D vsnd;
> >         QSIMPLEQ_INIT(&stream->queue);
> >         stream->info.hdr.hda_fn_nid =3D VIRTIO_SOUND_HDA_FN_NID;
> >@@ -1072,21 +1124,9 @@ static void virtio_snd_realize(DeviceState *dev, =
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
> >@@ -1097,28 +1137,6 @@ static void virtio_snd_realize(DeviceState *dev, =
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
> >@@ -1167,7 +1185,7 @@ static void virtio_snd_pcm_out_cb(void *data, int =
available)
> >         if (!virtio_queue_ready(buffer->vq)) {
> >             return;
> >         }
> >-        if (!stream->active) {
> >+        if (!(stream->state & VSND_PCMSTREAM_STATE_F_ACTIVE)) {
> >             /* Stream has stopped, so do not perform audio_be_write. */
> >             return_tx_buffer(stream, buffer);
> >             continue;
> >@@ -1261,7 +1279,7 @@ static void virtio_snd_pcm_in_cb(void *data, int a=
vailable)
> >         if (!virtio_queue_ready(buffer->vq)) {
> >             return;
> >         }
> >-        if (!stream->active) {
> >+        if (!(stream->state & VSND_PCMSTREAM_STATE_F_ACTIVE)) {
> >             /* Stream has stopped, so do not perform audio_be_read. */
> >             return_rx_buffer(stream, buffer);
> >             continue;
> >@@ -1334,17 +1352,16 @@ static void virtio_snd_unrealize(DeviceState *de=
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
> >+            if (stream->state & VSND_PCMSTREAM_STATE_F_PREPARED) {
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
> >@@ -1378,6 +1395,9 @@ static void virtio_snd_reset(VirtIODevice *vdev)
> >         VirtIOSoundPCMStream *stream =3D &vsnd->streams[i];
> >         VirtIOSoundPCMBuffer *buffer;
> >
> >+        virtio_snd_pcm_close(stream);
> >+        stream->state =3D VSND_PCMSTREAM_STATE_UNINITIALIZED;
> >+
> >         while ((buffer =3D QSIMPLEQ_FIRST(&stream->queue))) {
> >             QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
> >             virtio_snd_pcm_buffer_free(buffer);
> >diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd=
.h
> >index 41c63b3f23b..72ef34e0976 100644
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
> >@@ -121,31 +119,18 @@ struct VirtIOSoundPCMBuffer {
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
> >     /* channel position values (VIRTIO_SND_CHMAP_XXX) */
> >     uint8_t positions[VIRTIO_SND_CHMAP_MAX_SIZE];
> >     VirtIOSound *s;
> >-    bool flushing;
>
> Spurious change: this should be a separate patch.

Sure, I'll split this one in v4.

>
> >     audsettings as;
> >     union {
> >         SWVoiceIn *in;
> >         SWVoiceOut *out;
> >     } voice;
> >-    bool active;
> >     uint32_t latency_bytes;
> >     QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) queue;
> > };
> >@@ -212,7 +197,6 @@ struct VirtIOSound {
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

