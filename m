Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854CAC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 14:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd7IR-0002Hp-Jw; Fri, 26 Jun 2026 10:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wd7IP-0002Hb-8e
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 10:12:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wd7IN-0001H8-1M
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 10:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782483157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZGc148wY84qRu2Bu109BNZum5+7MN6I1IPRxsd7m5ro=;
 b=JWmrbTl4RQy3bX7WbYBN7uGb7mzyjTf1fYXx+1YJBO9+63WimP6R09JAE40vH6AiwYYIgo
 hht2qhBmZCIVC0Bog8YtkONs9X4g6oQxxVBnBEFfogmEjAopB7lwUwG6/W+rqviPTRdabE
 Pf5LbKM1FYFqn+H2vTwf+SdrrPEAXy8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-sjyDMyorN3edPwRXfjnA1w-1; Fri,
 26 Jun 2026 10:12:34 -0400
X-MC-Unique: sjyDMyorN3edPwRXfjnA1w-1
X-Mimecast-MFC-AGG-ID: sjyDMyorN3edPwRXfjnA1w_1782483153
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5692A180131B; Fri, 26 Jun 2026 14:12:32 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C1E6118005B0; Fri, 26 Jun 2026 14:12:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 5/9] hw/audio/virtio-sound: add stream state
 variable
From: marcandre.lureau@redhat.com
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 =?utf-8?q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 =?utf-8?q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
In-Reply-To: <20260626123531.132078-6-alexander@mihalicyn.com>
References: <20260626123531.132078-1-alexander@mihalicyn.com>
 <20260626123531.132078-6-alexander@mihalicyn.com>
Date: Fri, 26 Jun 2026 18:12:23 +0400
Message-Id: <178248314307.2718091.12113748256980319907.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=12685;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2iB2gpS6WC1io+o/y2SuLt3Od0YJuLPTZP+yNTWWawM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPojJPDRhfqQns2MFS5tsKV8mDgQPEhphhx1sL
 WsyNx38VzmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj6IyQAKCRDa6OEJdZac
 5egTD/4py0aL6+nDY7PH6RQqYQeYRooWGCU7V6bVX+FNSOHDSTAmrR/8nJHTvY+8mJ9veI13t82
 /GTGLwXvN6jw1gKjZLEHWJcAVGTrwzBOmeFvKgHjc9e2ocFutRXEAKF5FK5m7VznrMfRUB2VrDF
 tNDpgsCku+TfeRZpM0v96pKzDm7gSdm+2qAjVtSC0eele/1OoFcyqsGSqTHfkUoAdA8ByLup1OT
 3XlSL2FxcwkWuSV23hGuCbZbt87Aod8AyDrpFSHrdkjfRQwnieI+Q0POn0w8ch1pkmZh40LNONa
 VgUqUTq6uudTKYWcMJcUjMzOa2A1SV46IzbIv+MA4LQEOcJ/PrjleeUaTCrvUpsqCP5j9xvNslk
 vZGysY/NTTsbKt2DYHK2vjZpl1C5rytT6B1q0l44S8lZDaFmCxPagkw4ozx9wR2acOobl9pZ9Tx
 9ZGNtostRbV84oZh5oPqndfnssB1Xp8ofHexI5Kr2tzhswIpOALOKPLoAa/w+F/zuE2gRhmhPnk
 BqoRcwEE4ojSxEQc3ujqi6TikDmZtsFKftLba2lLgO6aYFScnvFfkfFKAf3GjetyW9rp3yvXgUZ
 Wr42yWPNincGhha3GMS7hVMTyNk7y7AMqOjEMIhvlmx1JH2BaGp/m3p8XaYHwngT1Rxgmrx0iUO
 FjiUh0YzosB7A/Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> So far, only rudimentary checks have been made to ensure that
> the guest only performs state transitions permitted in
> virtio-v1.2-csd01 5.14.6.6.1 PCM Command Lifecycle. Add a state
> variable per audio stream and check all state transitions.
> 
> Because only permitted state transitions are possible, only one
> copy of the audio stream parameters is required and these do not
> need to be initialised with default values.
> 
> The state variable will also make it easier to restore the audio
> stream after migration.
> 
> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
> [AM: there were too many conflicts, I did `git checkout --ours -- <.>`
>      and then reimplemented the patch idea
> /AM]
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> Message-ID: <20260626123531.132078-6-alexander@mihalicyn.com>
>
> diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
> index 41c63b3f23b..72ef34e0976 100644
> --- a/include/hw/audio/virtio-snd.h
> +++ b/include/hw/audio/virtio-snd.h
> @@ -75,8 +75,6 @@ typedef struct VirtIOSoundPCMStream VirtIOSoundPCMStream;
>  
>  typedef struct virtio_snd_ctrl_command virtio_snd_ctrl_command;
>  
> -typedef struct VirtIOSoundPCM VirtIOSoundPCM;
> -
>  typedef struct VirtIOSoundPCMBuffer VirtIOSoundPCMBuffer;
>  
>  /*
> @@ -121,31 +119,18 @@ struct VirtIOSoundPCMBuffer {
>      uint8_t data[];
>  };
>  
> -struct VirtIOSoundPCM {
> -    /*
> -     * PCM parameters are a separate field instead of a VirtIOSoundPCMStream
> -     * field, because the operation of PCM control requests is first
> -     * VIRTIO_SND_R_PCM_SET_PARAMS and then VIRTIO_SND_R_PCM_PREPARE; this
> -     * means that some times we get parameters without having an allocated
> -     * stream yet.
> -     */
> -    virtio_snd_pcm_set_params *pcm_params;
> -    VirtIOSoundPCMStream **streams;
> -};
> -
>  struct VirtIOSoundPCMStream {
>      virtio_snd_pcm_info info;
>      virtio_snd_pcm_set_params params;
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
>      uint32_t latency_bytes;
>      QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) queue;
>  };
> @@ -212,7 +197,6 @@ struct VirtIOSound {
>  
>      VirtQueue *queues[VIRTIO_SND_VQ_MAX];
>      uint64_t features;
> -    VirtIOSoundPCM pcm;
>      VirtIOSoundPCMStream *streams;
>      AudioBackend *audio_be;
>      VMChangeStateEntry *vmstate;
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index 300ba13ffeb..68d737478f5 100644
> --- a/hw/audio/virtio-snd.c
> +++ b/hw/audio/virtio-snd.c
> @@ -30,11 +30,30 @@
>  #define VIRTIO_SOUND_CHMAP_DEFAULT 0
>  #define VIRTIO_SOUND_HDA_FN_NID 0
>  
> +#define VSND_PCMSTREAM_STATE_F_PARAMS_SET  0x10000
> +#define VSND_PCMSTREAM_STATE_F_PREPARED    0x20000
> +#define VSND_PCMSTREAM_STATE_F_ACTIVE      0x40000
> +
> +#define VSND_PCMSTREAM_STATE_UNINITIALIZED 0
> +#define VSND_PCMSTREAM_STATE_PARAMS_SET    (1 \
> +                                           | VSND_PCMSTREAM_STATE_F_PARAMS_SET)
> +#define VSND_PCMSTREAM_STATE_PREPARED      (2 \
> +                                           | VSND_PCMSTREAM_STATE_F_PARAMS_SET \
> +                                           | VSND_PCMSTREAM_STATE_F_PREPARED)
> +#define VSND_PCMSTREAM_STATE_STARTED       (4 \
> +                                           | VSND_PCMSTREAM_STATE_F_PARAMS_SET \
> +                                           | VSND_PCMSTREAM_STATE_F_PREPARED \
> +                                           | VSND_PCMSTREAM_STATE_F_ACTIVE)
> +#define VSND_PCMSTREAM_STATE_STOPPED       (6 \
> +                                           | VSND_PCMSTREAM_STATE_F_PARAMS_SET \
> +                                           | VSND_PCMSTREAM_STATE_F_PREPARED)
> +#define VSND_PCMSTREAM_STATE_RELEASED      (7 \
> +                                           | VSND_PCMSTREAM_STATE_F_PARAMS_SET)

Hmm, those 1,2,4,6,7 values matches the spec 5.14.6.6.1 states. Ok, but worth a
comment imho.

> +
>  static void virtio_snd_pcm_out_cb(void *data, int available);
>  static void virtio_snd_process_cmdq(VirtIOSound *s);
>  static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream);
>  static void virtio_snd_pcm_in_cb(void *data, int available);
> -static void virtio_snd_unrealize(DeviceState *dev);
>  
>  static uint32_t supported_formats = BIT(VIRTIO_SND_PCM_FMT_S8)
>                                    | BIT(VIRTIO_SND_PCM_FMT_U8)
> @@ -129,7 +148,7 @@ static VirtIOSoundPCMStream *virtio_snd_pcm_get_stream(VirtIOSound *s,
>                                                         uint32_t stream_id)
>  {
>      return stream_id >= s->snd_conf.streams ? NULL :
> -        s->pcm.streams[stream_id];
> +        &s->streams[stream_id];
>  }
>  
>  /*
> @@ -141,8 +160,8 @@ static VirtIOSoundPCMStream *virtio_snd_pcm_get_stream(VirtIOSound *s,
>  static virtio_snd_pcm_set_params *virtio_snd_pcm_get_params(VirtIOSound *s,
>                                                              uint32_t stream_id)
>  {
> -    return stream_id >= s->snd_conf.streams ? NULL
> -        : &s->pcm.pcm_params[stream_id];
> +    return stream_id >= s->snd_conf.streams ? NULL :
> +        &s->streams[stream_id].params;
>  }
>  
>  /*
> @@ -245,11 +264,10 @@ static void virtio_snd_handle_pcm_info(VirtIOSound *s,
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
> @@ -257,14 +275,25 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
>                                     uint32_t stream_id,
>                                     virtio_snd_pcm_set_params *params)
>  {
> +    VirtIOSoundPCMStream *stream;
>      virtio_snd_pcm_set_params *st_params;
>  
> -    if (stream_id >= s->snd_conf.streams || s->pcm.pcm_params == NULL) {
> +    if (stream_id >= s->snd_conf.streams) {
>          virtio_error(VIRTIO_DEVICE(s), "Streams have not been initialized.\n");

The error message should be updated.

>          return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>      }
>  
> -    st_params = virtio_snd_pcm_get_params(s, stream_id);
> +    stream = virtio_snd_pcm_get_stream(s, stream_id);
> +
> +    switch (stream->state) {
> +    case VSND_PCMSTREAM_STATE_UNINITIALIZED:
> +    case VSND_PCMSTREAM_STATE_PARAMS_SET:
> +    case VSND_PCMSTREAM_STATE_PREPARED:
> +    case VSND_PCMSTREAM_STATE_RELEASED:
> +        break;
> +    default:

Keep a virtio_error()?

> +        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> +    }
>  
>      if (params->channels < 1 || params->channels > AUDIO_MAX_CHANNELS) {
>          error_report("Number of channels is not supported.");
> @@ -281,6 +310,8 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
>          return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
>      }
>  
> +    st_params = virtio_snd_pcm_get_params(s, stream_id);
> +
>      st_params->buffer_bytes = le32_to_cpu(params->buffer_bytes);
>      st_params->period_bytes = le32_to_cpu(params->period_bytes);
>      st_params->features = le32_to_cpu(params->features);
> @@ -289,6 +320,13 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
>      st_params->format = params->format;
>      st_params->rate = params->rate;
>  
> +    if (stream->state & VSND_PCMSTREAM_STATE_F_PREPARED) {
> +        /* implicit VIRTIO_SND_R_PCM_RELEASE */
> +        virtio_snd_pcm_flush(stream);
> +    }

I'd leave a comment to explain we keep the SWVoice opened.

> +
> +    stream->state = VSND_PCMSTREAM_STATE_PARAMS_SET;
> +
>      return cpu_to_le32(VIRTIO_SND_S_OK);
>  }
>  
> @@ -398,15 +436,12 @@ static void virtio_snd_get_qemu_audsettings(audsettings *as,
>   */
>  static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
>  {
> -    if (stream) {
> -        virtio_snd_pcm_flush(stream);
> -        if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
> -            audio_be_close_out(stream->s->audio_be, stream->voice.out);
> -            stream->voice.out = NULL;
> -        } else if (stream->info.direction == VIRTIO_SND_D_INPUT) {
> -            audio_be_close_in(stream->s->audio_be, stream->voice.in);
> -            stream->voice.in = NULL;
> -        }
> +    if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
> +        audio_be_close_out(stream->s->audio_be, stream->voice.out);
> +        stream->voice.out = NULL;
> +    } else if (stream->info.direction == VIRTIO_SND_D_INPUT) {
> +        audio_be_close_in(stream->s->audio_be, stream->voice.in);
> +        stream->voice.in = NULL;
>      }
>  }
>  
> @@ -423,32 +458,23 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
>      virtio_snd_pcm_set_params *params;
>      VirtIOSoundPCMStream *stream;
>  
> -    if (s->pcm.streams == NULL ||
> -        s->pcm.pcm_params == NULL ||
> -        stream_id >= s->snd_conf.streams) {
> +    stream = virtio_snd_pcm_get_stream(s, stream_id);
> +    if (!stream) {
>          return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>      }
>  
> -    params = virtio_snd_pcm_get_params(s, stream_id);
> -    if (params == NULL) {
> +    switch (stream->state) {
> +    case VSND_PCMSTREAM_STATE_PARAMS_SET:
> +    case VSND_PCMSTREAM_STATE_PREPARED:
> +    case VSND_PCMSTREAM_STATE_RELEASED:
> +        break;
> +    default:
>          return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>      }
>  
> -    stream = virtio_snd_pcm_get_stream(s, stream_id);
> -    if (stream == NULL) {
> -        stream = &s->streams[stream_id];
> -        stream->active = false;
> -        stream->latency_bytes = 0;
> -
> -        /*
> -         * stream_id >= s->snd_conf.streams was checked before so this is
> -         * in-bounds
> -         */
> -        s->pcm.streams[stream_id] = stream;
> -    }
> +    params = virtio_snd_pcm_get_params(s, stream_id);
>  
>      virtio_snd_get_qemu_audsettings(&as, params);
> -    stream->params = *params;
>  
>      stream->positions[0] = VIRTIO_SND_CHMAP_FL;
>      stream->positions[1] = VIRTIO_SND_CHMAP_FR;
> @@ -472,6 +498,8 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
>          audio_be_set_volume_in_lr(s->audio_be, stream->voice.in, 0, 255, 255);
>      }
>  
> +    stream->state = VSND_PCMSTREAM_STATE_PREPARED;
> +
>      return cpu_to_le32(VIRTIO_SND_S_OK);
>  }
>  
> @@ -542,12 +570,28 @@ static uint32_t virtio_snd_pcm_start_stop(VirtIOSound *s,
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
> +        stream->state = VSND_PCMSTREAM_STATE_STARTED;
>      } else {
> +        switch (stream->state) {
> +        case VSND_PCMSTREAM_STATE_STARTED:
> +            break;
> +        default:
> +            return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> +        }
> +
>          trace_virtio_snd_handle_pcm_stop(stream_id);
> +        stream->state = VSND_PCMSTREAM_STATE_STOPPED;
>      }
>  
> -    stream->active = start;
>      if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
>          audio_be_set_active_out(s->audio_be, stream->voice.out, start);
>      } else {
> @@ -641,6 +685,15 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
>          return;
>      }
>  
> +    switch (stream->state) {
> +    case VSND_PCMSTREAM_STATE_PREPARED:
> +    case VSND_PCMSTREAM_STATE_STOPPED:
> +        break;
> +    default:
> +        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> +        return;
> +    }
> +
>      if (virtio_snd_pcm_get_io_msgs_count(stream)) {
>          /*
>           * virtio-v1.2-csd01, 5.14.6.6.5.1,
> @@ -655,6 +708,8 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
>          virtio_snd_pcm_flush(stream);
>      }

Same here.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


