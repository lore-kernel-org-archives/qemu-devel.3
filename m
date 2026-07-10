Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29D4C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 14:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiCeg-00053B-GC; Fri, 10 Jul 2026 10:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wiCef-000533-CA
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 10:56:41 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wiCeb-00085F-Gi
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 10:56:40 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-69532288224so1881164a12.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 07:56:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783695394; cv=none;
 d=google.com; s=arc-20260327;
 b=EUtYar8E7H1P5r49Dyix8deON9WlHTbc42eV2ScZh8JFc4/chb+mZxk0KLy35+0/nr
 ArAEaObulMpeotZ6u9ke7qzzOWTo1c5l2x20rPk0vJb+tR9L316Pkv1Ypmz6Hp8x8U28
 V8RcmSde7PpYdXu2gSfohJXgWiK10Kb/K2nVFWVp+BGbnNK2eY2UTVk1j1NHT2Sm4gGm
 w+I3UmFz4nuEGsyxXthG9eutZIcInhVyydD+NGPLqC2+q6hBFaxjDJFgc36Ob286fPWb
 IKZvXro6BYsbDikZGq1bSBXZwYE/l9j751LdRv0A1046YCD4h64PTYnDFcBKLDxGA1KS
 IBwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6QjXBG8VmiERsup4FSb8gYsxcEZ8IevDwRw0yWvY6B8=;
 fh=SwNleLYJHDBNZ+ewKo8ooGZbSGpoaqEpx2+XEMRpscw=;
 b=hIpwjObFAaWEVIaR5v8MIAIlpZ9vJJw0cjIpyTRk5FSgFLDEPbXqGE0fTZtCG5ne/o
 yj+AukUj6GyfnGupJVCoey66JZy+ewZKWUw2n96qVuZCHnCZ3BMfYXoxetA9Hy7Yca3o
 C6eRenwqOlqZMKPZOtunLcND3snPrSbGzFZvZCBFKQN8V64NHsN+PS1N4sIXDh28K1y4
 Qp+YfsO30/J4+BHD9KZUhHDUTinU90PD3+pj9RGAnPaUdbNACqSWPiZhE5nTv3oyewMt
 gMy5r8UpGGflJZ//PLKHkRfyzP+wGUCbG5zaD62+GJdTWhC3gIdSj3jrxVWTmDXZqtjc
 i9Eg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1783695394; x=1784300194; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6QjXBG8VmiERsup4FSb8gYsxcEZ8IevDwRw0yWvY6B8=;
 b=SULW6rNlWLEgrr9M7izajDhAfyZHuO4TGsfGI/AAyc9zuzQ7nEfedPLTlqZa70nKtG
 ca3lho5sZJWKVJRwuPG6sUQOMyYSpzGee0souIt33xciRGsyaWs1K0YnkrKJCoGv/iXu
 aIRzRfAam6vWlSaueC5rhQGAv2vJcevg3CxDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783695394; x=1784300194;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6QjXBG8VmiERsup4FSb8gYsxcEZ8IevDwRw0yWvY6B8=;
 b=OTd8V/gcBDQQm3kIXeJefEDXwdkrvzNG/cgm9ILh8ZEbhcRVMF7jNvDNhUZgqMnEW6
 bQfJ/310BWmOZMDT/pHUz2wrzq3Z2omq+H/3TWYALIcy8z7m2ZdV6EDnmlxRV0WVlDDj
 B1ssrOW/R4VdrgjFo2brqY59DLi5mMatNJ89SfopbNo4fVACHbBCDAf2wzAx0wbmjqDZ
 HVI3IwfISBAbqDE/tOXncqGr6FjBnq2jHIPZ1ForkQJZ6cEaK3oravdF0ZdAwUWJ13Rp
 H6vzW/N4P+jTsGkuAi+j3tibtlxSSJkfLOfNeSx+H+JPMlLP8un9tAHRK9D88R/0UXoE
 BMCA==
X-Gm-Message-State: AOJu0YybhyulAUUzsS5Pfhla1j5ROU/LkpxI9JfzS8A66iUPtp+bfAA4
 ryjKWVH/gQBPWXV2QlhR4sKrLLW2i9AdNhp3AmAaH/tImGtQT/Q9bWzUGaN6smCU2fOo3Sxls1q
 8ePySNY/CY5fuDV0WBbm42p6smUQbIP86YZ3UgF1hnQ==
X-Gm-Gg: AfdE7cnLMcHrYZP5fEa9OK+8KdLC6BaBPdoIpxfErmdPvy8hIPAQj+QHxUukIYLd+/t
 rG4UnsOgaxeg/62TLRJuIo/uX4lnnRK3yYZyqzeIt0/TA4blPgBmYtuYQByNkWd7bu8mohH4q1+
 4ih5PJ23a2AnEdYMISfIQ5y5DE0qNSoeXHJiOuiOQobuKV6VpfNu1mIK7/23du7OspjyVgBNa8v
 8GT+7rfRLU4RbWEAO/Jba5ARSYfoxOm5iBVg5Tz5LfLGaE5jUlOxP/gHyCAjXhLgA+MgMkAiriC
 cQeYCs2L0Ywb1d1D5863MFLY2RU=
X-Received: by 2002:a17:907:784:b0:bfa:f563:9294 with SMTP id
 a640c23a62f3a-c15ce014238mr496694066b.18.1783695393988; Fri, 10 Jul 2026
 07:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260626123531.132078-1-alexander@mihalicyn.com>
 <20260626123531.132078-6-alexander@mihalicyn.com>
 <178248314307.2718091.12113748256980319907.b4-review@b4>
In-Reply-To: <178248314307.2718091.12113748256980319907.b4-review@b4>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Fri, 10 Jul 2026 16:56:22 +0200
X-Gm-Features: AUfX_myMWaLwht8mAOMOmxJXrFSK8BhtIPzH1zdf4xHa7gdQVxeX10MDnzjMCcM
Message-ID: <CAJqdLrr2FLG=_FWabC+dmJcWVVfiAf-hKxOHqPK_d_7inftMSQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] hw/audio/virtio-sound: add stream state variable
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alexander@mihalicyn.com; helo=mail-ed1-x529.google.com
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

Am Fr., 26. Juni 2026 um 16:12 Uhr schrieb <marcandre.lureau@redhat.com>:
>
> > So far, only rudimentary checks have been made to ensure that
> > the guest only performs state transitions permitted in
> > virtio-v1.2-csd01 5.14.6.6.1 PCM Command Lifecycle. Add a state
> > variable per audio stream and check all state transitions.
> >
> > Because only permitted state transitions are possible, only one
> > copy of the audio stream parameters is required and these do not
> > need to be initialised with default values.
> >
> > The state variable will also make it easier to restore the audio
> > stream after migration.
> >
> > Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> > [AM: there were too many conflicts, I did `git checkout --ours -- <.>`
> >      and then reimplemented the patch idea
> > /AM]
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion=
.io>
> > Message-ID: <20260626123531.132078-6-alexander@mihalicyn.com>
> >
> > diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-sn=
d.h
> > index 41c63b3f23b..72ef34e0976 100644
> > --- a/include/hw/audio/virtio-snd.h
> > +++ b/include/hw/audio/virtio-snd.h
> > @@ -75,8 +75,6 @@ typedef struct VirtIOSoundPCMStream VirtIOSoundPCMStr=
eam;
> >
> >  typedef struct virtio_snd_ctrl_command virtio_snd_ctrl_command;
> >
> > -typedef struct VirtIOSoundPCM VirtIOSoundPCM;
> > -
> >  typedef struct VirtIOSoundPCMBuffer VirtIOSoundPCMBuffer;
> >
> >  /*
> > @@ -121,31 +119,18 @@ struct VirtIOSoundPCMBuffer {
> >      uint8_t data[];
> >  };
> >
> > -struct VirtIOSoundPCM {
> > -    /*
> > -     * PCM parameters are a separate field instead of a VirtIOSoundPCM=
Stream
> > -     * field, because the operation of PCM control requests is first
> > -     * VIRTIO_SND_R_PCM_SET_PARAMS and then VIRTIO_SND_R_PCM_PREPARE; =
this
> > -     * means that some times we get parameters without having an alloc=
ated
> > -     * stream yet.
> > -     */
> > -    virtio_snd_pcm_set_params *pcm_params;
> > -    VirtIOSoundPCMStream **streams;
> > -};
> > -
> >  struct VirtIOSoundPCMStream {
> >      virtio_snd_pcm_info info;
> >      virtio_snd_pcm_set_params params;
> > +    uint32_t state;
> >      /* channel position values (VIRTIO_SND_CHMAP_XXX) */
> >      uint8_t positions[VIRTIO_SND_CHMAP_MAX_SIZE];
> >      VirtIOSound *s;
> > -    bool flushing;
> >      audsettings as;
> >      union {
> >          SWVoiceIn *in;
> >          SWVoiceOut *out;
> >      } voice;
> > -    bool active;
> >      uint32_t latency_bytes;
> >      QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) queue;
> >  };
> > @@ -212,7 +197,6 @@ struct VirtIOSound {
> >
> >      VirtQueue *queues[VIRTIO_SND_VQ_MAX];
> >      uint64_t features;
> > -    VirtIOSoundPCM pcm;
> >      VirtIOSoundPCMStream *streams;
> >      AudioBackend *audio_be;
> >      VMChangeStateEntry *vmstate;
> > diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> > index 300ba13ffeb..68d737478f5 100644
> > --- a/hw/audio/virtio-snd.c
> > +++ b/hw/audio/virtio-snd.c
> > @@ -30,11 +30,30 @@
> >  #define VIRTIO_SOUND_CHMAP_DEFAULT 0
> >  #define VIRTIO_SOUND_HDA_FN_NID 0
> >
> > +#define VSND_PCMSTREAM_STATE_F_PARAMS_SET  0x10000
> > +#define VSND_PCMSTREAM_STATE_F_PREPARED    0x20000
> > +#define VSND_PCMSTREAM_STATE_F_ACTIVE      0x40000
> > +
> > +#define VSND_PCMSTREAM_STATE_UNINITIALIZED 0
> > +#define VSND_PCMSTREAM_STATE_PARAMS_SET    (1 \
> > +                                           | VSND_PCMSTREAM_STATE_F_PA=
RAMS_SET)
> > +#define VSND_PCMSTREAM_STATE_PREPARED      (2 \
> > +                                           | VSND_PCMSTREAM_STATE_F_PA=
RAMS_SET \
> > +                                           | VSND_PCMSTREAM_STATE_F_PR=
EPARED)
> > +#define VSND_PCMSTREAM_STATE_STARTED       (4 \
> > +                                           | VSND_PCMSTREAM_STATE_F_PA=
RAMS_SET \
> > +                                           | VSND_PCMSTREAM_STATE_F_PR=
EPARED \
> > +                                           | VSND_PCMSTREAM_STATE_F_AC=
TIVE)
> > +#define VSND_PCMSTREAM_STATE_STOPPED       (6 \
> > +                                           | VSND_PCMSTREAM_STATE_F_PA=
RAMS_SET \
> > +                                           | VSND_PCMSTREAM_STATE_F_PR=
EPARED)
> > +#define VSND_PCMSTREAM_STATE_RELEASED      (7 \
> > +                                           | VSND_PCMSTREAM_STATE_F_PA=
RAMS_SET)
>

Dear Marc-Andr=C3=A9,

> Hmm, those 1,2,4,6,7 values matches the spec 5.14.6.6.1 states. Ok, but w=
orth a
> comment imho.

Manos made a point that we can simplify these definitions and instead
of using bitmask,
just have enum like:

+ enum virtio_snd_pcm_state {
+   VIRTIO_SND_PCM_STATE_UNINIT =3D 0,
+   VIRTIO_SND_PCM_STATE_PARAMS_SET,
+   VIRTIO_SND_PCM_STATE_PREPARED,
+   VIRTIO_SND_PCM_STATE_STARTED,
+   VIRTIO_SND_PCM_STATE_STOPPED,
+   VIRTIO_SND_PCM_STATE_RELEASED,
+ }

(see https://lore.kernel.org/qemu-devel/thdwg7.z2gqqr4zn5aq@linaro.org/#t )

WDYT?

>
> > +
> >  static void virtio_snd_pcm_out_cb(void *data, int available);
> >  static void virtio_snd_process_cmdq(VirtIOSound *s);
> >  static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream);
> >  static void virtio_snd_pcm_in_cb(void *data, int available);
> > -static void virtio_snd_unrealize(DeviceState *dev);
> >
> >  static uint32_t supported_formats =3D BIT(VIRTIO_SND_PCM_FMT_S8)
> >                                    | BIT(VIRTIO_SND_PCM_FMT_U8)
> > @@ -129,7 +148,7 @@ static VirtIOSoundPCMStream *virtio_snd_pcm_get_str=
eam(VirtIOSound *s,
> >                                                         uint32_t stream=
_id)
> >  {
> >      return stream_id >=3D s->snd_conf.streams ? NULL :
> > -        s->pcm.streams[stream_id];
> > +        &s->streams[stream_id];
> >  }
> >
> >  /*
> > @@ -141,8 +160,8 @@ static VirtIOSoundPCMStream *virtio_snd_pcm_get_str=
eam(VirtIOSound *s,
> >  static virtio_snd_pcm_set_params *virtio_snd_pcm_get_params(VirtIOSoun=
d *s,
> >                                                              uint32_t s=
tream_id)
> >  {
> > -    return stream_id >=3D s->snd_conf.streams ? NULL
> > -        : &s->pcm.pcm_params[stream_id];
> > +    return stream_id >=3D s->snd_conf.streams ? NULL :
> > +        &s->streams[stream_id].params;
> >  }
> >
> >  /*
> > @@ -245,11 +264,10 @@ static void virtio_snd_handle_pcm_info(VirtIOSoun=
d *s,
> >
> >  /*
> >   * Set the given stream params.
> > - * Called by both virtio_snd_handle_pcm_set_params and during device
> > - * initialization.
> >   * Returns the response status code. (VIRTIO_SND_S_*).
> >   *
> >   * @s: VirtIOSound device
> > + * @stream_id: stream id
> >   * @params: The PCM params as defined in the virtio specification
> >   */
> >  static
> > @@ -257,14 +275,25 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s=
,
> >                                     uint32_t stream_id,
> >                                     virtio_snd_pcm_set_params *params)
> >  {
> > +    VirtIOSoundPCMStream *stream;
> >      virtio_snd_pcm_set_params *st_params;
> >
> > -    if (stream_id >=3D s->snd_conf.streams || s->pcm.pcm_params =3D=3D=
 NULL) {
> > +    if (stream_id >=3D s->snd_conf.streams) {
> >          virtio_error(VIRTIO_DEVICE(s), "Streams have not been initiali=
zed.\n");
>
> The error message should be updated.

Thanks, I'll fix this in v4.

>
> >          return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> >      }
> >
> > -    st_params =3D virtio_snd_pcm_get_params(s, stream_id);
> > +    stream =3D virtio_snd_pcm_get_stream(s, stream_id);
> > +
> > +    switch (stream->state) {
> > +    case VSND_PCMSTREAM_STATE_UNINITIALIZED:
> > +    case VSND_PCMSTREAM_STATE_PARAMS_SET:
> > +    case VSND_PCMSTREAM_STATE_PREPARED:
> > +    case VSND_PCMSTREAM_STATE_RELEASED:
> > +        break;
> > +    default:
>
> Keep a virtio_error()?

Sure, will do in v4.

>
> > +        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> > +    }
> >
> >      if (params->channels < 1 || params->channels > AUDIO_MAX_CHANNELS)=
 {
> >          error_report("Number of channels is not supported.");
> > @@ -281,6 +310,8 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
> >          return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
> >      }
> >
> > +    st_params =3D virtio_snd_pcm_get_params(s, stream_id);
> > +
> >      st_params->buffer_bytes =3D le32_to_cpu(params->buffer_bytes);
> >      st_params->period_bytes =3D le32_to_cpu(params->period_bytes);
> >      st_params->features =3D le32_to_cpu(params->features);
> > @@ -289,6 +320,13 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
> >      st_params->format =3D params->format;
> >      st_params->rate =3D params->rate;
> >
> > +    if (stream->state & VSND_PCMSTREAM_STATE_F_PREPARED) {
> > +        /* implicit VIRTIO_SND_R_PCM_RELEASE */
> > +        virtio_snd_pcm_flush(stream);
> > +    }
>
> I'd leave a comment to explain we keep the SWVoice opened.

I decided to add virtio_snd_pcm_close(stream) call to
virtio_snd_set_pcm_params().

>
> > +
> > +    stream->state =3D VSND_PCMSTREAM_STATE_PARAMS_SET;
> > +
> >      return cpu_to_le32(VIRTIO_SND_S_OK);
> >  }
> >
> > @@ -398,15 +436,12 @@ static void virtio_snd_get_qemu_audsettings(audse=
ttings *as,
> >   */
> >  static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
> >  {
> > -    if (stream) {
> > -        virtio_snd_pcm_flush(stream);
> > -        if (stream->info.direction =3D=3D VIRTIO_SND_D_OUTPUT) {
> > -            audio_be_close_out(stream->s->audio_be, stream->voice.out)=
;
> > -            stream->voice.out =3D NULL;
> > -        } else if (stream->info.direction =3D=3D VIRTIO_SND_D_INPUT) {
> > -            audio_be_close_in(stream->s->audio_be, stream->voice.in);
> > -            stream->voice.in =3D NULL;
> > -        }
> > +    if (stream->info.direction =3D=3D VIRTIO_SND_D_OUTPUT) {
> > +        audio_be_close_out(stream->s->audio_be, stream->voice.out);
> > +        stream->voice.out =3D NULL;
> > +    } else if (stream->info.direction =3D=3D VIRTIO_SND_D_INPUT) {
> > +        audio_be_close_in(stream->s->audio_be, stream->voice.in);
> > +        stream->voice.in =3D NULL;
> >      }
> >  }
> >
> > @@ -423,32 +458,23 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSoun=
d *s, uint32_t stream_id)
> >      virtio_snd_pcm_set_params *params;
> >      VirtIOSoundPCMStream *stream;
> >
> > -    if (s->pcm.streams =3D=3D NULL ||
> > -        s->pcm.pcm_params =3D=3D NULL ||
> > -        stream_id >=3D s->snd_conf.streams) {
> > +    stream =3D virtio_snd_pcm_get_stream(s, stream_id);
> > +    if (!stream) {
> >          return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> >      }
> >
> > -    params =3D virtio_snd_pcm_get_params(s, stream_id);
> > -    if (params =3D=3D NULL) {
> > +    switch (stream->state) {
> > +    case VSND_PCMSTREAM_STATE_PARAMS_SET:
> > +    case VSND_PCMSTREAM_STATE_PREPARED:
> > +    case VSND_PCMSTREAM_STATE_RELEASED:
> > +        break;
> > +    default:
> >          return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> >      }
> >
> > -    stream =3D virtio_snd_pcm_get_stream(s, stream_id);
> > -    if (stream =3D=3D NULL) {
> > -        stream =3D &s->streams[stream_id];
> > -        stream->active =3D false;
> > -        stream->latency_bytes =3D 0;
> > -
> > -        /*
> > -         * stream_id >=3D s->snd_conf.streams was checked before so th=
is is
> > -         * in-bounds
> > -         */
> > -        s->pcm.streams[stream_id] =3D stream;
> > -    }
> > +    params =3D virtio_snd_pcm_get_params(s, stream_id);
> >
> >      virtio_snd_get_qemu_audsettings(&as, params);
> > -    stream->params =3D *params;
> >
> >      stream->positions[0] =3D VIRTIO_SND_CHMAP_FL;
> >      stream->positions[1] =3D VIRTIO_SND_CHMAP_FR;
> > @@ -472,6 +498,8 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound =
*s, uint32_t stream_id)
> >          audio_be_set_volume_in_lr(s->audio_be, stream->voice.in, 0, 25=
5, 255);
> >      }
> >
> > +    stream->state =3D VSND_PCMSTREAM_STATE_PREPARED;
> > +
> >      return cpu_to_le32(VIRTIO_SND_S_OK);
> >  }
> >
> > @@ -542,12 +570,28 @@ static uint32_t virtio_snd_pcm_start_stop(VirtIOS=
ound *s,
> >      }
> >
> >      if (start) {
> > +        switch (stream->state) {
> > +        case VSND_PCMSTREAM_STATE_PREPARED:
> > +        case VSND_PCMSTREAM_STATE_STOPPED:
> > +            break;
> > +        default:
> > +            return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> > +        }
> > +
> >          trace_virtio_snd_handle_pcm_start(stream_id);
> > +        stream->state =3D VSND_PCMSTREAM_STATE_STARTED;
> >      } else {
> > +        switch (stream->state) {
> > +        case VSND_PCMSTREAM_STATE_STARTED:
> > +            break;
> > +        default:
> > +            return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> > +        }
> > +
> >          trace_virtio_snd_handle_pcm_stop(stream_id);
> > +        stream->state =3D VSND_PCMSTREAM_STATE_STOPPED;
> >      }
> >
> > -    stream->active =3D start;
> >      if (stream->info.direction =3D=3D VIRTIO_SND_D_OUTPUT) {
> >          audio_be_set_active_out(s->audio_be, stream->voice.out, start)=
;
> >      } else {
> > @@ -641,6 +685,15 @@ static void virtio_snd_handle_pcm_release(VirtIOSo=
und *s,
> >          return;
> >      }
> >
> > +    switch (stream->state) {
> > +    case VSND_PCMSTREAM_STATE_PREPARED:
> > +    case VSND_PCMSTREAM_STATE_STOPPED:
> > +        break;
> > +    default:
> > +        cmd->resp.code =3D cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> > +        return;
> > +    }
> > +
> >      if (virtio_snd_pcm_get_io_msgs_count(stream)) {
> >          /*
> >           * virtio-v1.2-csd01, 5.14.6.6.5.1,
> > @@ -655,6 +708,8 @@ static void virtio_snd_handle_pcm_release(VirtIOSou=
nd *s,
> >          virtio_snd_pcm_flush(stream);
> >      }
>
> Same here.

I decided to add virtio_snd_pcm_close(stream) call to
virtio_snd_handle_pcm_release().

Kind regards,
Alex

>
> --
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>

