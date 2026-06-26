Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B48CDE013
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3sY-0003wU-Hz; Fri, 26 Jun 2026 06:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wd3sW-0003vj-Vo
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:33:45 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wd3sT-0008HQ-TB
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:33:44 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c07a6527453so109280066b.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:33:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782470020; cv=none;
 d=google.com; s=arc-20260327;
 b=XHeyikf/6c28y3Vcbw7SlQHUiWNnf9OtMvOgL42gt7pbde0sKtHgnRrMHTAlnGYEUg
 cIcsiudnZfPLp6On4s0RBza2MbWEpdedX9fbfY17F9rhWnOHjX9vjZiOCNbf5JKVEPxN
 d7ZvEaNJn9f+c2vlxRfU+1pi8FJUQDX29nvXBoJIPdCH6eG6r16VChESI+H6e56if+Vn
 TL3eRaqX79qj1zbq9MDmyGFLYMgJuSw1vUnFaDqMXz8VSXukLOceMl7sESgTHTm05sK3
 j+j4yc0H2/lkc1EP67bP9+O850mr7/DUzJPbgbAldZX2QtQ/3HJHKMl3/52opjPMTBCN
 3e3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/OctKrYO/8IyDOKKdOx0UF+b+Xs9YnZ+bDg0VcZOeYc=;
 fh=WTMaVroxeFO+odfNo/HlSXKoRZAjtoqL4+bW6Ec/xOQ=;
 b=qGnBzU27tnO/f0fboSkNAjRPQQ5XMQNPTfDFg4yNv5aL2bTXVNLK1m4TiYgosX2vqY
 eCHWsh3GhPI39g/+dVd8ExOvx0K/0DVUKJ+ImHltugxDfv0z5jCFwDvYfplwo93hrZ8u
 PfmIbkwQYEaaJUT3QlnscFjMQBH4OTZxyIKe3C2D7q+w/CpipI0BoSM3fpqkxlQR4Pbo
 uYf68Zrz0yK+6AskJ4Fgig7sPJvMZH3IoXSAxshhjgclSjKFm3iVyvOPMVyFGYmaW6Bg
 ceqwyt2hkhZZ/jbnuwrjhctBAT6A0EwCkqG6C8iPMUyLThinlSoiVIH9Vivv9pDClqSZ
 KCdA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1782470020; x=1783074820; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/OctKrYO/8IyDOKKdOx0UF+b+Xs9YnZ+bDg0VcZOeYc=;
 b=G7vT4ZGEPe/+5pIjlEj3421KIiPAHoSIBygYx9OauOCz23TH1YzciQXOO8rvo9VqlX
 a4+gkFb6N8qEtugJkANz9M6NiFAKyOPAswYbPcFhrEGFSVUW22MiIxI1T+lj61oi6OBK
 M+cef/DLdWbKqeYlb+OP2+NAELx50mlO2Hg+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782470020; x=1783074820;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/OctKrYO/8IyDOKKdOx0UF+b+Xs9YnZ+bDg0VcZOeYc=;
 b=AznFSn/BlBrbfaefI07EOIMfChjhnxhM7TosJT+1EnKu4tGRxkxJnAO48plQzEn1fc
 PX0D65et2SBmjptHgbvawNSIJQ0FkLgdhOVSjHhobAxXz9Fazj3ZMj/+q3M1kvs0qc4D
 YHhG3+YZGge+yWqmWDbhOLYiqzYCf8KDuYKug9qg262LgAFxdZUxDwQha8m55z/pnDYz
 YxdH1IeObUIGeFutH3dQuhwLIKFBeMsIF2lYnrMPyA+CxsGlREEtm/OgNqAfkHaJAKX7
 A9K/G3UH4R9xebGURp4BYbgfA+VTiuLyzxrswydmJ1UycgoZs5r7jQwHiSge49zgNNOM
 qMFg==
X-Gm-Message-State: AOJu0Yxn4HB3ra743ywV0nc1RyWsNJRxHqntw9zo7SetYBNhptqg8UYP
 omC3x/oQPBddwdNts3yIV1CBF62Kk9ygqzWqmolIQKxjojW8XTtpveHySC4x7k2CD0JqweEYrPr
 Q1Y4bguDsT1ju9TFeBx4HTHpMJiC430sJPK+qFVePXw==
X-Gm-Gg: AfdE7ckFiFFUi91Eu9INEIk3J82ca9CvPYSunnDJGp8oLhJXuovvp768jj1hOonf9f4
 lntvV/5KAXdPbRFJdjRVt2eoEr0SbtHA4GgstEuRCrG8G5Ql7Vjm+lgECagXWX3LtTXIvf99IzG
 ZviBTnmHxPa+Mxei4CW2dnvXJudNaC3Gk6ekAc5ps42XPCjDksKoZ1nMq1pSQoXi9XiGPJd5wim
 aBFpCxtndjtsahfBMUbxUWG60qPWkC34Sgq8BSKweZJDHjm2UQRgQ3O4bG581jNIUEkU3ZMBL48
 cGIOmHTa9IhYnn+Ia1PtafWiMcqO
X-Received: by 2002:a17:906:6206:b0:bed:87c:b24e with SMTP id
 a640c23a62f3a-c1205eef62emr403250666b.29.1782470019255; Fri, 26 Jun 2026
 03:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260625095250.65073-1-alexander@mihalicyn.com>
 <20260625095250.65073-6-alexander@mihalicyn.com>
 <178239957438.405566.4745811512948076973.b4-review@b4>
In-Reply-To: <178239957438.405566.4745811512948076973.b4-review@b4>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Fri, 26 Jun 2026 12:33:28 +0200
X-Gm-Features: AVVi8Cf5v1clsP2ZXHN9KjDkHAMAIHIimKHNexWr8leMDLkjWobBkdBqi86wZaQ
Message-ID: <CAJqdLroSArVJtA4QVPSr=UYmryKPD4kAeWLgSFobw_3hMOGsVw@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] hw/audio/virtio-sound: add stream state variable
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alexander@mihalicyn.com; helo=mail-ej1-x631.google.com
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

Am Do., 25. Juni 2026 um 17:00 Uhr schrieb <marcandre.lureau@redhat.com>:
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
> > Message-ID: <20260625095250.65073-6-alexander@mihalicyn.com>
> >
> > diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-sn=
d.h
> > index d65e6ba85be..28d0322b979 100644
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
> > @@ -121,32 +119,19 @@ struct VirtIOSoundPCMBuffer {
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
> >      uint32_t id;
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
> > @@ -213,7 +198,6 @@ struct VirtIOSound {
> >
> >      VirtQueue *queues[VIRTIO_SND_VQ_MAX];
> >      uint64_t features;
> > -    VirtIOSoundPCM pcm;
> >      VirtIOSoundPCMStream *streams;
> >      AudioBackend *audio_be;
> >      VMChangeStateEntry *vmstate;
> > diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> > index 80dc13318af..388a302255a 100644
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
> > +
> > +    stream->state =3D VSND_PCMSTREAM_STATE_PARAMS_SET;
> > +
> >      return cpu_to_le32(VIRTIO_SND_S_OK);
> >  }
> >
> > @@ -398,15 +436,13 @@ static void virtio_snd_get_qemu_audsettings(audse=
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
> > +    virtio_snd_pcm_flush(stream);
> > +    if (stream->info.direction =3D=3D VIRTIO_SND_D_OUTPUT) {
> > +        audio_be_close_out(stream->s->audio_be, stream->voice.out);
> > +        stream->voice.out =3D NULL;
> > +    } else if (stream->info.direction =3D=3D VIRTIO_SND_D_INPUT) {
> > +        audio_be_close_in(stream->s->audio_be, stream->voice.in);
> > +        stream->voice.in =3D NULL;
> >      }
> >  }
> >
> > @@ -423,32 +459,23 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSoun=
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
> > @@ -472,6 +499,8 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound =
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
> > @@ -540,12 +569,28 @@ static uint32_t virtio_snd_pcm_start_stop(VirtIOS=
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
> > @@ -639,6 +684,15 @@ static void virtio_snd_handle_pcm_release(VirtIOSo=
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
> > @@ -653,6 +707,8 @@ static void virtio_snd_handle_pcm_release(VirtIOSou=
nd *s,
> >          virtio_snd_pcm_flush(stream);
> >      }
> >
> > +    stream->state =3D VSND_PCMSTREAM_STATE_RELEASED;
> > +
> >      cmd->resp.code =3D cpu_to_le32(VIRTIO_SND_S_OK);
> >  }
> >
> > @@ -874,12 +930,11 @@ static void virtio_snd_handle_tx_xfer(VirtIODevic=
e *vdev, VirtQueue *vq)
> >          }
> >          stream_id =3D le32_to_cpu(hdr.stream_id);
> >
> > -        if (stream_id >=3D vsnd->snd_conf.streams
> > -            || vsnd->pcm.streams[stream_id] =3D=3D NULL) {
> > +        if (stream_id >=3D vsnd->snd_conf.streams) {
> >              goto tx_err;
> >          }
> >
> > -        stream =3D vsnd->pcm.streams[stream_id];
> > +        stream =3D &vsnd->streams[stream_id];
> >          if (stream->info.direction !=3D VIRTIO_SND_D_OUTPUT) {
> >              goto tx_err;
> >          }
> > @@ -954,13 +1009,12 @@ static void virtio_snd_handle_rx_xfer(VirtIODevi=
ce *vdev, VirtQueue *vq)
> >          }
> >          stream_id =3D le32_to_cpu(hdr.stream_id);
> >
> > -        if (stream_id >=3D vsnd->snd_conf.streams
> > -            || !vsnd->pcm.streams[stream_id]) {
> > +        if (stream_id >=3D vsnd->snd_conf.streams) {
> >              goto rx_err;
> >          }
> >
> > -        stream =3D vsnd->pcm.streams[stream_id];
> > -        if (stream =3D=3D NULL || stream->info.direction !=3D VIRTIO_S=
ND_D_INPUT) {
> > +        stream =3D &vsnd->streams[stream_id];
> > +        if (stream->info.direction !=3D VIRTIO_SND_D_INPUT) {
> >              goto rx_err;
> >          }
> >
> > @@ -1019,8 +1073,6 @@ static void virtio_snd_realize(DeviceState *dev, =
Error **errp)
> >      ERRP_GUARD();
> >      VirtIOSound *vsnd =3D VIRTIO_SND(dev);
> >      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> > -    virtio_snd_pcm_set_params default_params =3D { 0 };
> > -    uint32_t status;
> >
> >      trace_virtio_snd_realize(vsnd);
> >
> > @@ -1058,6 +1110,7 @@ static void virtio_snd_realize(DeviceState *dev, =
Error **errp)
> >          VirtIOSoundPCMStream *stream =3D &vsnd->streams[i];
> >
> >          stream->id =3D i;
> > +        stream->state =3D VSND_PCMSTREAM_STATE_UNINITIALIZED;
> >          stream->s =3D vsnd;
> >          QSIMPLEQ_INIT(&stream->queue);
> >          stream->info.hdr.hda_fn_nid =3D VIRTIO_SOUND_HDA_FN_NID;
> > @@ -1071,21 +1124,9 @@ static void virtio_snd_realize(DeviceState *dev,=
 Error **errp)
> >          stream->info.channels_max =3D 2;
> >      }
> >
> > -    vsnd->pcm.streams =3D
> > -        g_new0(VirtIOSoundPCMStream *, vsnd->snd_conf.streams);
> > -    vsnd->pcm.pcm_params =3D
> > -        g_new0(virtio_snd_pcm_set_params, vsnd->snd_conf.streams);
> > -
> >      virtio_init(vdev, VIRTIO_ID_SOUND, sizeof(virtio_snd_config));
> >      virtio_add_feature(&vsnd->features, VIRTIO_F_VERSION_1);
> >
> > -    /* set default params for all streams */
> > -    default_params.features =3D 0;
> > -    default_params.buffer_bytes =3D cpu_to_le32(8192);
> > -    default_params.period_bytes =3D cpu_to_le32(2048);
> > -    default_params.channels =3D 2;
> > -    default_params.format =3D VIRTIO_SND_PCM_FMT_S16;
> > -    default_params.rate =3D VIRTIO_SND_PCM_RATE_48000;
> >      vsnd->queues[VIRTIO_SND_VQ_CONTROL] =3D
> >          virtio_add_queue(vdev, 64, virtio_snd_handle_ctrl);
> >      vsnd->queues[VIRTIO_SND_VQ_EVENT] =3D
> > @@ -1096,28 +1137,6 @@ static void virtio_snd_realize(DeviceState *dev,=
 Error **errp)
> >          virtio_add_queue(vdev, 64, virtio_snd_handle_rx_xfer);
> >      QTAILQ_INIT(&vsnd->cmdq);
> >      QSIMPLEQ_INIT(&vsnd->invalid);
> > -
> > -    for (uint32_t i =3D 0; i < vsnd->snd_conf.streams; i++) {
> > -        status =3D virtio_snd_set_pcm_params(vsnd, i, &default_params)=
;
> > -        if (status !=3D cpu_to_le32(VIRTIO_SND_S_OK)) {
> > -            error_setg(errp,
> > -                       "Can't initialize stream params, device respond=
ed with %s.",
> > -                       print_code(status));
> > -            goto error_cleanup;
> > -        }
> > -        status =3D virtio_snd_pcm_prepare(vsnd, i);
> > -        if (status !=3D cpu_to_le32(VIRTIO_SND_S_OK)) {
> > -            error_setg(errp,
> > -                       "Can't prepare streams, device responded with %=
s.",
> > -                       print_code(status));
> > -            goto error_cleanup;
> > -        }
> > -    }
> > -
> > -    return;
> > -
> > -error_cleanup:
> > -    virtio_snd_unrealize(dev);
> >  }
> >
> >  static inline void update_latency(VirtIOSoundPCMStream *s, size_t used=
)
> > @@ -1166,7 +1185,7 @@ static void virtio_snd_pcm_out_cb(void *data, int=
 available)
> >          if (!virtio_queue_ready(buffer->vq)) {
> >              return;
> >          }
> > -        if (!stream->active) {
> > +        if (!(stream->state & VSND_PCMSTREAM_STATE_F_ACTIVE)) {
> >              /* Stream has stopped, so do not perform audio_be_write. *=
/
> >              return_tx_buffer(stream, buffer);
> >              continue;
> > @@ -1260,7 +1279,7 @@ static void virtio_snd_pcm_in_cb(void *data, int =
available)
> >          if (!virtio_queue_ready(buffer->vq)) {
> >              return;
> >          }
> > -        if (!stream->active) {
> > +        if (!(stream->state & VSND_PCMSTREAM_STATE_F_ACTIVE)) {
> >              /* Stream has stopped, so do not perform audio_be_read. */
> >              return_rx_buffer(stream, buffer);
> >              continue;
> > @@ -1333,17 +1352,15 @@ static void virtio_snd_unrealize(DeviceState *d=
ev)
> >      qemu_del_vm_change_state_handler(vsnd->vmstate);
> >      trace_virtio_snd_unrealize(vsnd);
> >
> > -    if (vsnd->pcm.streams) {
> > +    if (vsnd->streams) {
> > +        virtio_snd_process_cmdq(vsnd);
> >          for (uint32_t i =3D 0; i < vsnd->snd_conf.streams; i++) {
> > -            stream =3D vsnd->pcm.streams[i];
> > -            if (stream) {
> > -                virtio_snd_process_cmdq(stream->s);
> > -                virtio_snd_pcm_close(stream);
> > +            stream =3D &vsnd->streams[i];
> > +            if (stream->state & VSND_PCMSTREAM_STATE_F_PREPARED) {
> > +                virtio_snd_pcm_flush(stream);
>
> I am not sure we should let the device do IO during unrealize, but this s=
eems to
> be just buffer work and the notification is hopefully ignored.

Hmm.. yeah, that's a good point. I went to recheck everything once
again and it looks like
even in current QEMU code (without these patches), we have the
following callstack:
virtio_snd_unrealize() -> virtio_snd_pcm_close() ->
virtio_snd_pcm_flush() -> return_{r,t}x_buffer() -> virtio_notify().

So, I agree that doing IO during unrealize() is a bit weird, cause
AFAIU in once we call unrealize guest
has no communication with the device (i.e. device is detached from a
bus and so on).

WDYT?

>
> However, it should rather call virtio_snd_pcm_close() to release the asso=
ciated
> SWVoices.

Exactly, I believe I should do something like:

--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -436,7 +436,6 @@ static void virtio_snd_get_qemu_audsettings(audsettings=
 *as,
  */
 static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
 {
-    virtio_snd_pcm_flush(stream);
     if (stream->info.direction =3D=3D VIRTIO_SND_D_OUTPUT) {
         audio_be_close_out(stream->s->audio_be, stream->voice.out);
         stream->voice.out =3D NULL;
@@ -1361,6 +1360,7 @@ static void virtio_snd_unrealize(DeviceState *dev)
             if (stream->state & VSND_PCMSTREAM_STATE_F_PREPARED) {
                 virtio_snd_pcm_flush(stream);
             }
+            virtio_snd_pcm_close(stream);
         }
     }
     g_free(vsnd->streams);

this is my mistake, in the original patch a call to
virtio_snd_pcm_flush() was removed from virtio_snd_pcm_close(),
then virtio_snd_pcm_flush and virtio_snd_pcm_close we explicitly
called from virtio_snd_unrealize(). I will fix this.

You've given me an idea and I looked once again on all codepaths where
we do  audio_be_{open,close}_{in,out}(),
and I realized that for some reason in virtio_snd_handle_pcm_release()
we only do flush, but not close, while
according to 5.14.6.6.1 PCM Command Lifecycle:
> * - `RELEASE`
> *   The device releases the stream (frees resources, etc).
> *   Possible valid transitions: `SET PARAMETERS`, `PREPARE`.

So, once we reached RELEASE, we can only do:
RELEASE -> PREPARE
RELEASE -> SET PARAMETERS -> PREPARE
[ note: we can also do SET PARAMETERS twice or do loops to, ofc ]

my point is that anyways, in any guest driver that makes something
reasonable, after RELEASE
we, at some point, go to PREPARE and it does audio_be_open_{in,out}().
So the question is why
we don't have a call to virtio_snd_pcm_close() in
virtio_snd_handle_pcm_release()?..

Kind regards,
Alex

>
> --
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>

