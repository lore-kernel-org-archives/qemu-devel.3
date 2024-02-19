Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF78C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 13:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc3Fi-0003bL-V1; Mon, 19 Feb 2024 08:00:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rc3Fe-0003Zj-Io
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 08:00:06 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rc3Fb-000114-8s
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 08:00:06 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-55c2cf644f3so5751892a12.1
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 05:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708347601; x=1708952401; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pmMlfLcvbz2y9zTGjATqUCqKfzXx2Um85Hd5DfR1QcI=;
 b=PeQeQzyRQuW9d6mZN+nKskhXh3O3LnBtF8DmklVXJApj36Pl09FAZ8w+fe7lDC8LhY
 RvR/5qOTwdao63TLjFNLzyZSknfQT6wZ1Tkia8kyV/QYi3js0ali4f8bBJjKpIF2tFRt
 vSq7naAvVfJYMhaYkcNX4fOHZe2DBzgbGEkHIzRRpQ7hZkVspyXOprDcr2D+DTZZmfIB
 Bt9cp7ztGEcYKoD2iFiyNKvH3OjtsN5+TSbiW/AflBi2VhSx7lmsMVvWBNT9XK4JvkcK
 lsTups5V58Np1UkP9yEN6lc2Gpgka8JeYIOwnIFdbhiRfVBKu4Y69Wc4cbkz4vZOwunq
 RL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708347601; x=1708952401;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pmMlfLcvbz2y9zTGjATqUCqKfzXx2Um85Hd5DfR1QcI=;
 b=nt7zYHsV3vNAXYrx7yspEhm9lmqCm5H33gnIJrseObJ5dzp2EwjyE25qn4aczo1czE
 rvu4z0r+AZvj/rpxoowgUWB7AdyoAxKbsqOLBZgRArNdojws/4i0/8XH/6kcwCyx37vN
 9RzqEpZ169MATdLZOOzD05ksxHhwQ5hGHBglXzQc3DlVKHl1FnxFROctA8m4LIXPVbG9
 /TiLA3r0b2aPjOmbMfPEJY7tDpdyBBA+waTHbitoONO/86XLgpSv/1H/TjBAgp1CvoNh
 YaVoWZ3loN+gxArolUCpwGjwr+ses4JvXg57ojjs7emvx2xrd/pSRXk8+qFcx0kbYS3G
 9knw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/JWNePGdhcA8jlv5U7UFsVhJ/6k5IAekAGljQy5Z104UIYJKdyphaj2FKfz5Cx2R+SUiurVeyJev+q6D1A046QFy3hRI=
X-Gm-Message-State: AOJu0YyWpbhDeAudxNrx5Faj2EpScXFbbneeIO60fOACO0e4rh7l2qJO
 AXZkttPEQrvcWFvBfO+e7KpQJpXoqBjE2jXvwZW3SYPLDTTqMaGhvCoHgVvGC/ke9Y88KF5YV55
 9kEHV/5Swk1MdVm1kcAxy1wevUSOmmMe2pShQSA==
X-Google-Smtp-Source: AGHT+IHRIZCX0wIpK+VkzzIxmm1/rVQDf98MpuNhbYkB25O7w0s4sBg7dkALlx056OeLl1JRPCOB3OOvN0JZo7VH+SY=
X-Received: by 2002:aa7:db59:0:b0:564:ad01:20b with SMTP id
 n25-20020aa7db59000000b00564ad01020bmr63996edt.25.1708347601252; Mon, 19 Feb
 2024 05:00:01 -0800 (PST)
MIME-Version: 1.0
References: <a289a081-9a61-4bcb-b693-bf6cd7768c0e@t-online.de>
 <20240218083351.8524-7-vr_qemu@t-online.de>
In-Reply-To: <20240218083351.8524-7-vr_qemu@t-online.de>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 19 Feb 2024 14:59:45 +0200
Message-ID: <CAAjaMXYhYuV3BZ0D+Q1dMq5QD+2tDKX8gTZv0cCm3nWGBfJJAA@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] hw/audio/virtio-sound: add stream state variable
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello Volker,

On Sun, 18 Feb 2024 at 10:34, Volker R=C3=BCmelin <vr_qemu@t-online.de> wro=
te:
>
> So far, only rudimentary checks have been made to ensure that
> the guest only performs state transitions permitted in
> virtio-v1.2-csd01 5.14.6.6.1 PCM Command Lifecycle.

5.14.6.6.1 is non-normative in virtio v1.2. You can even see it's not
in device requirements. The state transitions were thus not checked on
purpose.

There is nothing in the standard that describes error conditions
pertaining to the "PCM lifecycle" state machine. It really should, but
it doesn't, unfortunately.

> Add a state
> variable per audio stream and check all state transitions.
>
> Because only permitted state transitions are possible, only one
> copy of the audio stream parameters is required and these do not
> need to be initialised with default values.
>
> The state variable will also make it easier to restore the audio
> stream after migration.

I suggest you instead add the state tracking but only use it for the
post_load code for migration.



> Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> ---
>  hw/audio/virtio-snd.c         | 213 ++++++++++++++++++----------------
>  include/hw/audio/virtio-snd.h |  20 +---
>  2 files changed, 111 insertions(+), 122 deletions(-)
>
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index 435ce26430..bbbdd01aa9 100644
> --- a/hw/audio/virtio-snd.c
> +++ b/hw/audio/virtio-snd.c
> @@ -31,11 +31,30 @@
>  #define VIRTIO_SOUND_CHMAP_DEFAULT 0
>  #define VIRTIO_SOUND_HDA_FN_NID 0
>
> +#define VSND_PCMSTREAM_STATE_F_PARAMS_SET  0x10000
> +#define VSND_PCMSTREAM_STATE_F_PREPARED    0x20000
> +#define VSND_PCMSTREAM_STATE_F_ACTIVE      0x40000
> +
> +#define VSND_PCMSTREAM_STATE_UNINITIALIZED 0
> +#define VSND_PCMSTREAM_STATE_PARAMS_SET    (1 \
> +                                           | VSND_PCMSTREAM_STATE_F_PARA=
MS_SET)
> +#define VSND_PCMSTREAM_STATE_PREPARED      (2 \
> +                                           | VSND_PCMSTREAM_STATE_F_PARA=
MS_SET \
> +                                           | VSND_PCMSTREAM_STATE_F_PREP=
ARED)
> +#define VSND_PCMSTREAM_STATE_STARTED       (4 \
> +                                           | VSND_PCMSTREAM_STATE_F_PARA=
MS_SET \
> +                                           | VSND_PCMSTREAM_STATE_F_PREP=
ARED \
> +                                           | VSND_PCMSTREAM_STATE_F_ACTI=
VE)
> +#define VSND_PCMSTREAM_STATE_STOPPED       (6 \
> +                                           | VSND_PCMSTREAM_STATE_F_PARA=
MS_SET \
> +                                           | VSND_PCMSTREAM_STATE_F_PREP=
ARED)
> +#define VSND_PCMSTREAM_STATE_RELEASED      (7 \
> +                                           | VSND_PCMSTREAM_STATE_F_PARA=
MS_SET)
> +
>  static void virtio_snd_pcm_out_cb(void *data, int available);
>  static void virtio_snd_process_cmdq(VirtIOSound *s);
>  static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream);
>  static void virtio_snd_pcm_in_cb(void *data, int available);
> -static void virtio_snd_unrealize(DeviceState *dev);
>
>  static uint32_t supported_formats =3D BIT(VIRTIO_SND_PCM_FMT_S8)
>                                    | BIT(VIRTIO_SND_PCM_FMT_U8)
> @@ -153,8 +172,8 @@ virtio_snd_ctrl_cmd_free(virtio_snd_ctrl_command *cmd=
)
>  static VirtIOSoundPCMStream *virtio_snd_pcm_get_stream(VirtIOSound *s,
>                                                         uint32_t stream_i=
d)
>  {
> -    return stream_id >=3D s->snd_conf.streams ? NULL :
> -        s->pcm->streams[stream_id];
> +    return stream_id >=3D s->snd_conf.streams ? NULL
> +        : &s->streams[stream_id];
>  }
>
>  /*
> @@ -167,7 +186,7 @@ static virtio_snd_pcm_set_params *virtio_snd_pcm_get_=
params(VirtIOSound *s,
>                                                              uint32_t str=
eam_id)
>  {
>      return stream_id >=3D s->snd_conf.streams ? NULL
> -        : &s->pcm->pcm_params[stream_id];
> +        : &s->streams[stream_id].params;
>  }
>
>  /*
> @@ -253,11 +272,10 @@ static void virtio_snd_handle_pcm_info(VirtIOSound =
*s,
>
>  /*
>   * Set the given stream params.
> - * Called by both virtio_snd_handle_pcm_set_params and during device
> - * initialization.
>   * Returns the response status code. (VIRTIO_SND_S_*).
>   *
>   * @s: VirtIOSound device
> + * @stream_id: stream id
>   * @params: The PCM params as defined in the virtio specification
>   */
>  static
> @@ -265,9 +283,10 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
>                                     uint32_t stream_id,
>                                     virtio_snd_pcm_set_params *params)
>  {
> +    VirtIOSoundPCMStream *stream;
>      virtio_snd_pcm_set_params *st_params;
>
> -    if (stream_id >=3D s->snd_conf.streams || s->pcm->pcm_params =3D=3D =
NULL) {
> +    if (stream_id >=3D s->snd_conf.streams) {
>          /*
>           * TODO: do we need to set DEVICE_NEEDS_RESET?
>           */
> @@ -275,7 +294,17 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
>          return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>      }
>
> -    st_params =3D virtio_snd_pcm_get_params(s, stream_id);
> +    stream =3D virtio_snd_pcm_get_stream(s, stream_id);
> +
> +    switch (stream->state) {
> +    case VSND_PCMSTREAM_STATE_UNINITIALIZED:
> +    case VSND_PCMSTREAM_STATE_PARAMS_SET:
> +    case VSND_PCMSTREAM_STATE_PREPARED:
> +    case VSND_PCMSTREAM_STATE_RELEASED:
> +        break;
> +    default:
> +        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> +    }
>
>      if (params->channels < 1 || params->channels > AUDIO_MAX_CHANNELS) {
>          error_report("Number of channels is not supported.");
> @@ -290,6 +319,8 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
>          return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
>      }
>
> +    st_params =3D virtio_snd_pcm_get_params(s, stream_id);
> +
>      st_params->buffer_bytes =3D le32_to_cpu(params->buffer_bytes);
>      st_params->period_bytes =3D le32_to_cpu(params->period_bytes);
>      st_params->features =3D le32_to_cpu(params->features);
> @@ -298,6 +329,13 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
>      st_params->format =3D params->format;
>      st_params->rate =3D params->rate;
>
> +    if (stream->state & VSND_PCMSTREAM_STATE_F_PREPARED) {
> +        /* implicit VIRTIO_SND_R_PCM_RELEASE */
> +        virtio_snd_pcm_flush(stream);
> +    }
> +
> +    stream->state =3D VSND_PCMSTREAM_STATE_PARAMS_SET;
> +
>      return cpu_to_le32(VIRTIO_SND_S_OK);
>  }
>
> @@ -410,15 +448,12 @@ static void virtio_snd_get_qemu_audsettings(audsett=
ings *as,
>   */
>  static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
>  {
> -    if (stream) {
> -        virtio_snd_pcm_flush(stream);
> -        if (stream->info.direction =3D=3D VIRTIO_SND_D_OUTPUT) {
> -            AUD_close_out(&stream->pcm->snd->card, stream->voice.out);
> -            stream->voice.out =3D NULL;
> -        } else if (stream->info.direction =3D=3D VIRTIO_SND_D_INPUT) {
> -            AUD_close_in(&stream->pcm->snd->card, stream->voice.in);
> -            stream->voice.in =3D NULL;
> -        }
> +    if (stream->info.direction =3D=3D VIRTIO_SND_D_OUTPUT) {
> +        AUD_close_out(&stream->s->card, stream->voice.out);
> +        stream->voice.out =3D NULL;
> +    } else {
> +        AUD_close_in(&stream->s->card, stream->voice.in);
> +        stream->voice.in =3D NULL;
>      }
>  }
>
> @@ -435,33 +470,23 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound =
*s, uint32_t stream_id)
>      virtio_snd_pcm_set_params *params;
>      VirtIOSoundPCMStream *stream;
>
> -    if (s->pcm->streams =3D=3D NULL ||
> -        s->pcm->pcm_params =3D=3D NULL ||
> -        stream_id >=3D s->snd_conf.streams) {
> +    stream =3D virtio_snd_pcm_get_stream(s, stream_id);
> +    if (!stream) {
>          return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>      }
>
> -    params =3D virtio_snd_pcm_get_params(s, stream_id);
> -    if (params =3D=3D NULL) {
> +    switch (stream->state) {
> +    case VSND_PCMSTREAM_STATE_PARAMS_SET:
> +    case VSND_PCMSTREAM_STATE_PREPARED:
> +    case VSND_PCMSTREAM_STATE_RELEASED:
> +        break;
> +    default:
>          return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>      }
>
> -    stream =3D virtio_snd_pcm_get_stream(s, stream_id);
> -    if (stream =3D=3D NULL) {
> -        stream =3D &s->streams[stream_id];
> -        stream->active =3D false;
> -        stream->pcm =3D s->pcm;
> -
> -        /*
> -         * stream_id >=3D s->snd_conf.streams was checked before so this=
 is
> -         * in-bounds
> -         */
> -        s->pcm->streams[stream_id] =3D stream;
> -    }
> +    params =3D virtio_snd_pcm_get_params(s, stream_id);
>
>      virtio_snd_get_qemu_audsettings(&as, params);
> -    stream->params =3D *params;
> -
>      stream->positions[0] =3D VIRTIO_SND_CHMAP_FL;
>      stream->positions[1] =3D VIRTIO_SND_CHMAP_FR;
>      stream->as =3D as;
> @@ -484,6 +509,8 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s=
, uint32_t stream_id)
>          AUD_set_volume_in(stream->voice.in, 0, 255, 255);
>      }
>
> +    stream->state =3D VSND_PCMSTREAM_STATE_PREPARED;
> +
>      return cpu_to_le32(VIRTIO_SND_S_OK);
>  }
>
> @@ -552,12 +579,28 @@ static uint32_t virtio_snd_pcm_start_stop(VirtIOSou=
nd *s,
>      }
>
>      if (start) {
> +        switch (stream->state) {
> +        case VSND_PCMSTREAM_STATE_PREPARED:
> +        case VSND_PCMSTREAM_STATE_STOPPED:
> +            break;
> +        default:
> +            return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> +        }
> +
>          trace_virtio_snd_handle_pcm_start(stream_id);
> +        stream->state =3D VSND_PCMSTREAM_STATE_STARTED;
>      } else {
> +        switch (stream->state) {
> +        case VSND_PCMSTREAM_STATE_STARTED:
> +            break;
> +        default:
> +            return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> +        }
> +
>          trace_virtio_snd_handle_pcm_stop(stream_id);
> +        stream->state =3D VSND_PCMSTREAM_STATE_STOPPED;
>      }
>
> -    stream->active =3D start;
>      if (stream->info.direction =3D=3D VIRTIO_SND_D_OUTPUT) {
>          AUD_set_active_out(stream->voice.out, start);
>      } else {
> @@ -644,15 +687,18 @@ static void virtio_snd_handle_pcm_release(VirtIOSou=
nd *s,
>
>      stream_id =3D le32_to_cpu(stream_id);
>      trace_virtio_snd_handle_pcm_release(stream_id);
> +
>      stream =3D virtio_snd_pcm_get_stream(s, stream_id);
> -    if (stream =3D=3D NULL) {
> -        /*
> -         * TODO: do we need to set DEVICE_NEEDS_RESET?
> -         */
> -        error_report("already released stream %"PRIu32, stream_id);
> -        virtio_error(VIRTIO_DEVICE(s),
> -                     "already released stream %"PRIu32,
> -                     stream_id);
> +    if (!stream) {
> +        cmd->resp.code =3D cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> +        return;
> +    }
> +
> +    switch (stream->state) {
> +    case VSND_PCMSTREAM_STATE_PREPARED:
> +    case VSND_PCMSTREAM_STATE_STOPPED:
> +        break;
> +    default:
>          cmd->resp.code =3D cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>          return;
>      }
> @@ -671,6 +717,8 @@ static void virtio_snd_handle_pcm_release(VirtIOSound=
 *s,
>          virtio_snd_pcm_flush(stream);
>      }
>
> +    stream->state =3D VSND_PCMSTREAM_STATE_RELEASED;
> +
>      cmd->resp.code =3D cpu_to_le32(VIRTIO_SND_S_OK);
>  }
>
> @@ -873,12 +921,11 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice =
*vdev, VirtQueue *vq)
>          }
>          stream_id =3D le32_to_cpu(hdr.stream_id);
>
> -        if (stream_id >=3D s->snd_conf.streams
> -            || s->pcm->streams[stream_id] =3D=3D NULL) {
> +        if (stream_id >=3D s->snd_conf.streams) {
>              goto tx_err;
>          }
>
> -        stream =3D s->pcm->streams[stream_id];
> +        stream =3D &s->streams[stream_id];
>          if (stream->info.direction !=3D VIRTIO_SND_D_OUTPUT) {
>              goto tx_err;
>          }
> @@ -948,13 +995,12 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice =
*vdev, VirtQueue *vq)
>          }
>          stream_id =3D le32_to_cpu(hdr.stream_id);
>
> -        if (stream_id >=3D s->snd_conf.streams
> -            || !s->pcm->streams[stream_id]) {
> +        if (stream_id >=3D s->snd_conf.streams) {
>              goto rx_err;
>          }
>
> -        stream =3D s->pcm->streams[stream_id];
> -        if (stream =3D=3D NULL || stream->info.direction !=3D VIRTIO_SND=
_D_INPUT) {
> +        stream =3D &s->streams[stream_id];
> +        if (stream->info.direction !=3D VIRTIO_SND_D_INPUT) {
>              goto rx_err;
>          }
>          size =3D iov_size(elem->in_sg, elem->in_num) -
> @@ -1013,8 +1059,6 @@ static void virtio_snd_realize(DeviceState *dev, Er=
ror **errp)
>      ERRP_GUARD();
>      VirtIOSound *vsnd =3D VIRTIO_SND(dev);
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> -    virtio_snd_pcm_set_params default_params =3D { 0 };
> -    uint32_t status;
>
>      trace_virtio_snd_realize(vsnd);
>
> @@ -1052,6 +1096,7 @@ static void virtio_snd_realize(DeviceState *dev, Er=
ror **errp)
>          VirtIOSoundPCMStream *stream =3D &vsnd->streams[i];
>
>          stream->id =3D i;
> +        stream->state =3D VSND_PCMSTREAM_STATE_UNINITIALIZED;
>          stream->s =3D vsnd;
>          QSIMPLEQ_INIT(&stream->queue);
>          stream->info.hdr.hda_fn_nid =3D VIRTIO_SOUND_HDA_FN_NID;
> @@ -1065,23 +1110,9 @@ static void virtio_snd_realize(DeviceState *dev, E=
rror **errp)
>          stream->info.channels_max =3D 2;
>      }
>
> -    vsnd->pcm =3D g_new0(VirtIOSoundPCM, 1);
> -    vsnd->pcm->snd =3D vsnd;
> -    vsnd->pcm->streams =3D
> -        g_new0(VirtIOSoundPCMStream *, vsnd->snd_conf.streams);
> -    vsnd->pcm->pcm_params =3D
> -        g_new0(virtio_snd_pcm_set_params, vsnd->snd_conf.streams);
> -
>      virtio_init(vdev, VIRTIO_ID_SOUND, sizeof(virtio_snd_config));
>      virtio_add_feature(&vsnd->features, VIRTIO_F_VERSION_1);
>
> -    /* set default params for all streams */
> -    default_params.features =3D 0;
> -    default_params.buffer_bytes =3D cpu_to_le32(8192);
> -    default_params.period_bytes =3D cpu_to_le32(2048);
> -    default_params.channels =3D 2;
> -    default_params.format =3D VIRTIO_SND_PCM_FMT_S16;
> -    default_params.rate =3D VIRTIO_SND_PCM_RATE_48000;
>      vsnd->queues[VIRTIO_SND_VQ_CONTROL] =3D
>          virtio_add_queue(vdev, 64, virtio_snd_handle_ctrl);
>      vsnd->queues[VIRTIO_SND_VQ_EVENT] =3D
> @@ -1091,28 +1122,6 @@ static void virtio_snd_realize(DeviceState *dev, E=
rror **errp)
>      vsnd->queues[VIRTIO_SND_VQ_RX] =3D
>          virtio_add_queue(vdev, 64, virtio_snd_handle_rx_xfer);
>      QTAILQ_INIT(&vsnd->cmdq);
> -
> -    for (uint32_t i =3D 0; i < vsnd->snd_conf.streams; i++) {
> -        status =3D virtio_snd_set_pcm_params(vsnd, i, &default_params);
> -        if (status !=3D cpu_to_le32(VIRTIO_SND_S_OK)) {
> -            error_setg(errp,
> -                       "Can't initialize stream params, device responded=
 with %s.",
> -                       print_code(status));
> -            goto error_cleanup;
> -        }
> -        status =3D virtio_snd_pcm_prepare(vsnd, i);
> -        if (status !=3D cpu_to_le32(VIRTIO_SND_S_OK)) {
> -            error_setg(errp,
> -                       "Can't prepare streams, device responded with %s.=
",
> -                       print_code(status));
> -            goto error_cleanup;
> -        }
> -    }
> -
> -    return;
> -
> -error_cleanup:
> -    virtio_snd_unrealize(dev);
>  }
>
>  static inline void return_tx_buffer(VirtIOSoundPCMStream *stream,
> @@ -1154,7 +1163,7 @@ static void virtio_snd_pcm_out_cb(void *data, int a=
vailable)
>          if (!virtio_queue_ready(buffer->vq)) {
>              return;
>          }
> -        if (!stream->active) {
> +        if (!(stream->state & VSND_PCMSTREAM_STATE_F_ACTIVE)) {
>              /* Stream has stopped, so do not perform AUD_write. */
>              return_tx_buffer(stream, buffer);
>              continue;
> @@ -1246,7 +1255,7 @@ static void virtio_snd_pcm_in_cb(void *data, int av=
ailable)
>          if (!virtio_queue_ready(buffer->vq)) {
>              return;
>          }
> -        if (!stream->active) {
> +        if (!(stream->state & VSND_PCMSTREAM_STATE_F_ACTIVE)) {
>              /* Stream has stopped, so do not perform AUD_read. */
>              return_rx_buffer(stream, buffer);
>              continue;
> @@ -1306,19 +1315,14 @@ static void virtio_snd_unrealize(DeviceState *dev=
)
>      trace_virtio_snd_unrealize(vsnd);
>
>      if (vsnd->streams) {
> -        if (vsnd->pcm->streams) {
> -            for (uint32_t i =3D 0; i < vsnd->snd_conf.streams; i++) {
> -                stream =3D vsnd->pcm->streams[i];
> -                if (stream) {
> -                    virtio_snd_process_cmdq(stream->s);
> -                    virtio_snd_pcm_close(stream);
> -                }
> +        virtio_snd_process_cmdq(vsnd);
> +        for (uint32_t i =3D 0; i < vsnd->snd_conf.streams; i++) {
> +            stream =3D &vsnd->streams[i];
> +            if (stream->state & VSND_PCMSTREAM_STATE_F_PREPARED) {
> +                virtio_snd_pcm_flush(stream);
>              }
> -            g_free(vsnd->pcm->streams);
> +            virtio_snd_pcm_close(stream);
>          }
> -        g_free(vsnd->pcm->pcm_params);
> -        g_free(vsnd->pcm);
> -        vsnd->pcm =3D NULL;
>          g_free(vsnd->streams);
>          vsnd->streams =3D NULL;
>      }
> @@ -1347,6 +1351,9 @@ static void virtio_snd_reset(VirtIODevice *vdev)
>          VirtIOSoundPCMStream *stream =3D &s->streams[i];
>          VirtIOSoundPCMBuffer *buffer;
>
> +        virtio_snd_pcm_close(stream);
> +        stream->state =3D VSND_PCMSTREAM_STATE_UNINITIALIZED;
> +
>          while ((buffer =3D QSIMPLEQ_FIRST(&stream->queue))) {
>              QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
>              virtio_snd_pcm_buffer_free(buffer);
> diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.=
h
> index 95aef8192a..65afa6c184 100644
> --- a/include/hw/audio/virtio-snd.h
> +++ b/include/hw/audio/virtio-snd.h
> @@ -75,8 +75,6 @@ typedef struct VirtIOSoundPCMStream VirtIOSoundPCMStrea=
m;
>
>  typedef struct virtio_snd_ctrl_command virtio_snd_ctrl_command;
>
> -typedef struct VirtIOSoundPCM VirtIOSoundPCM;
> -
>  typedef struct VirtIOSoundPCMBuffer VirtIOSoundPCMBuffer;
>
>  /*
> @@ -121,34 +119,19 @@ struct VirtIOSoundPCMBuffer {
>      uint8_t data[];
>  };
>
> -struct VirtIOSoundPCM {
> -    VirtIOSound *snd;
> -    /*
> -     * PCM parameters are a separate field instead of a VirtIOSoundPCMSt=
ream
> -     * field, because the operation of PCM control requests is first
> -     * VIRTIO_SND_R_PCM_SET_PARAMS and then VIRTIO_SND_R_PCM_PREPARE; th=
is
> -     * means that some times we get parameters without having an allocat=
ed
> -     * stream yet.
> -     */
> -    virtio_snd_pcm_set_params *pcm_params;
> -    VirtIOSoundPCMStream **streams;
> -};
> -
>  struct VirtIOSoundPCMStream {
> -    VirtIOSoundPCM *pcm;
>      virtio_snd_pcm_info info;
>      virtio_snd_pcm_set_params params;
>      uint32_t id;
> +    uint32_t state;
>      /* channel position values (VIRTIO_SND_CHMAP_XXX) */
>      uint8_t positions[VIRTIO_SND_CHMAP_MAX_SIZE];
>      VirtIOSound *s;
> -    bool flushing;
>      audsettings as;
>      union {
>          SWVoiceIn *in;
>          SWVoiceOut *out;
>      } voice;
> -    bool active;
>      QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) queue;
>  };
>
> @@ -214,7 +197,6 @@ struct VirtIOSound {
>
>      VirtQueue *queues[VIRTIO_SND_VQ_MAX];
>      uint64_t features;
> -    VirtIOSoundPCM *pcm;
>      VirtIOSoundPCMStream *streams;
>      QEMUSoundCard card;
>      VMChangeStateEntry *vmstate;
> --
> 2.35.3
>

