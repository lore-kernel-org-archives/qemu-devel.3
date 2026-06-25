Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75015CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 15:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclZ0-0002bB-NX; Thu, 25 Jun 2026 11:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wclYy-0002Z5-K0
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 11:00:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wclYv-0004J9-Up
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 11:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782399617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TlkShGuprk/jfGzFdEAPNKD9rkcgeYwU6RtT9Rd8Yf0=;
 b=YDmIX64LyiPCy03Rhr5eMi2A3JEB/YY9Ocngn1ZqwF5oMjFDVo+UDjQ6H5fwEh2+DGxJWv
 bt8uYFw+a4u2KYLn7/dI0FIA8iVJgd14cxl0ADklPbvsremHsnafet4rChsdH9elLV5rKJ
 J4e+1cgK0xr8qkX3UPaslTEw4/xHMAo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-MWSegljpNiSnCtK0tfPEWg-1; Thu,
 25 Jun 2026 11:00:13 -0400
X-MC-Unique: MWSegljpNiSnCtK0tfPEWg-1
X-Mimecast-MFC-AGG-ID: MWSegljpNiSnCtK0tfPEWg_1782399612
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51EF81873123; Thu, 25 Jun 2026 15:00:12 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C89CE195608C; Thu, 25 Jun 2026 15:00:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 5/9] hw/audio/virtio-sound: add stream state
 variable
From: marcandre.lureau@redhat.com
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 =?utf-8?q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
In-Reply-To: <20260625095250.65073-6-alexander@mihalicyn.com>
References: <20260625095250.65073-1-alexander@mihalicyn.com>
 <20260625095250.65073-6-alexander@mihalicyn.com>
Date: Thu, 25 Jun 2026 18:59:34 +0400
Message-Id: <178239957438.405566.4745811512948076973.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=18556;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=NkRig6UAgFZKOstEU3UbP9IsOedE3o9B5CqgAHCsdkE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPUJatJeE9jgP2U3tpib/YKuNZlXuzGQtJ1jB/
 bF09zlDnImJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj1CWgAKCRDa6OEJdZac
 5bp+D/97lUD0K+oJBSfkDiaelam0KAiyc5oJ85OD14Xeb18UFHYRmtl8FxA/KnQ3JmtQLyjJOUL
 ORQ/dFDfvWtJ1wRFLvln+qY1z40/VOuyl/CuGegShfdpfPc9fnMMuqug/ekUCxV4RgtjgnZOh2P
 UNv9I7D6yeXbHv/Resbpmpl+0aC8I5h9YUdfKv2XEZPsVZIfBk0v6kXuSm4ulxupUeCq0ApRR+O
 2AO5GQ172nY4R+pYk7hc/BCZq6ojw0OLAlXHIMTXoXj31CvoQQvC/9WQNp9x8YB+ev/JKGpejsa
 UqhEQ1K5KyCEIWgfdU5zqbLZhiyCKIHNav8hZ515adx4rb55Edx/g5mkRzTSMuaxxZhaxFbcWca
 /+kwRZiB6PH5j05OsBx0pV73UNIb0mhW4HrysD4T2U1MOM0qDPImuNT0HOXpuBqsna+pEuNqGbl
 60oYS7cSkTP23WTHlsCxrfhALY8Dhb544wACQ8uIhSrLAsVhipWsDiKYZKrY3rEMOf2SgIRHn65
 z5SR7AMZcgwP/ifGYkP8++n2x0JJLRjLnEh6bPecTuVY18nk7A8l1HlXiNzZBl/DsPy9LABW4XK
 WJI01dAHG0Txht6XvIJKPG8bQqo/OmBwQCwtjP0S2DuJVB2rIga6039t46nHS+QEzPvIur7vSm9
 fcXFHhVKeYjKuWA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> Message-ID: <20260625095250.65073-6-alexander@mihalicyn.com>
>
> diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
> index d65e6ba85be..28d0322b979 100644
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
> @@ -121,32 +119,19 @@ struct VirtIOSoundPCMBuffer {
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
>      uint32_t latency_bytes;
>      QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) queue;
>  };
> @@ -213,7 +198,6 @@ struct VirtIOSound {
>  
>      VirtQueue *queues[VIRTIO_SND_VQ_MAX];
>      uint64_t features;
> -    VirtIOSoundPCM pcm;
>      VirtIOSoundPCMStream *streams;
>      AudioBackend *audio_be;
>      VMChangeStateEntry *vmstate;
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index 80dc13318af..388a302255a 100644
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
> +
> +    stream->state = VSND_PCMSTREAM_STATE_PARAMS_SET;
> +
>      return cpu_to_le32(VIRTIO_SND_S_OK);
>  }
>  
> @@ -398,15 +436,13 @@ static void virtio_snd_get_qemu_audsettings(audsettings *as,
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
> +    virtio_snd_pcm_flush(stream);
> +    if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
> +        audio_be_close_out(stream->s->audio_be, stream->voice.out);
> +        stream->voice.out = NULL;
> +    } else if (stream->info.direction == VIRTIO_SND_D_INPUT) {
> +        audio_be_close_in(stream->s->audio_be, stream->voice.in);
> +        stream->voice.in = NULL;
>      }
>  }
>  
> @@ -423,32 +459,23 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
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
> @@ -472,6 +499,8 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
>          audio_be_set_volume_in_lr(s->audio_be, stream->voice.in, 0, 255, 255);
>      }
>  
> +    stream->state = VSND_PCMSTREAM_STATE_PREPARED;
> +
>      return cpu_to_le32(VIRTIO_SND_S_OK);
>  }
>  
> @@ -540,12 +569,28 @@ static uint32_t virtio_snd_pcm_start_stop(VirtIOSound *s,
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
> @@ -639,6 +684,15 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
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
> @@ -653,6 +707,8 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
>          virtio_snd_pcm_flush(stream);
>      }
>  
> +    stream->state = VSND_PCMSTREAM_STATE_RELEASED;
> +
>      cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
>  }
>  
> @@ -874,12 +930,11 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
>          }
>          stream_id = le32_to_cpu(hdr.stream_id);
>  
> -        if (stream_id >= vsnd->snd_conf.streams
> -            || vsnd->pcm.streams[stream_id] == NULL) {
> +        if (stream_id >= vsnd->snd_conf.streams) {
>              goto tx_err;
>          }
>  
> -        stream = vsnd->pcm.streams[stream_id];
> +        stream = &vsnd->streams[stream_id];
>          if (stream->info.direction != VIRTIO_SND_D_OUTPUT) {
>              goto tx_err;
>          }
> @@ -954,13 +1009,12 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
>          }
>          stream_id = le32_to_cpu(hdr.stream_id);
>  
> -        if (stream_id >= vsnd->snd_conf.streams
> -            || !vsnd->pcm.streams[stream_id]) {
> +        if (stream_id >= vsnd->snd_conf.streams) {
>              goto rx_err;
>          }
>  
> -        stream = vsnd->pcm.streams[stream_id];
> -        if (stream == NULL || stream->info.direction != VIRTIO_SND_D_INPUT) {
> +        stream = &vsnd->streams[stream_id];
> +        if (stream->info.direction != VIRTIO_SND_D_INPUT) {
>              goto rx_err;
>          }
>  
> @@ -1019,8 +1073,6 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
>      ERRP_GUARD();
>      VirtIOSound *vsnd = VIRTIO_SND(dev);
>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> -    virtio_snd_pcm_set_params default_params = { 0 };
> -    uint32_t status;
>  
>      trace_virtio_snd_realize(vsnd);
>  
> @@ -1058,6 +1110,7 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
>          VirtIOSoundPCMStream *stream = &vsnd->streams[i];
>  
>          stream->id = i;
> +        stream->state = VSND_PCMSTREAM_STATE_UNINITIALIZED;
>          stream->s = vsnd;
>          QSIMPLEQ_INIT(&stream->queue);
>          stream->info.hdr.hda_fn_nid = VIRTIO_SOUND_HDA_FN_NID;
> @@ -1071,21 +1124,9 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
>          stream->info.channels_max = 2;
>      }
>  
> -    vsnd->pcm.streams =
> -        g_new0(VirtIOSoundPCMStream *, vsnd->snd_conf.streams);
> -    vsnd->pcm.pcm_params =
> -        g_new0(virtio_snd_pcm_set_params, vsnd->snd_conf.streams);
> -
>      virtio_init(vdev, VIRTIO_ID_SOUND, sizeof(virtio_snd_config));
>      virtio_add_feature(&vsnd->features, VIRTIO_F_VERSION_1);
>  
> -    /* set default params for all streams */
> -    default_params.features = 0;
> -    default_params.buffer_bytes = cpu_to_le32(8192);
> -    default_params.period_bytes = cpu_to_le32(2048);
> -    default_params.channels = 2;
> -    default_params.format = VIRTIO_SND_PCM_FMT_S16;
> -    default_params.rate = VIRTIO_SND_PCM_RATE_48000;
>      vsnd->queues[VIRTIO_SND_VQ_CONTROL] =
>          virtio_add_queue(vdev, 64, virtio_snd_handle_ctrl);
>      vsnd->queues[VIRTIO_SND_VQ_EVENT] =
> @@ -1096,28 +1137,6 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
>          virtio_add_queue(vdev, 64, virtio_snd_handle_rx_xfer);
>      QTAILQ_INIT(&vsnd->cmdq);
>      QSIMPLEQ_INIT(&vsnd->invalid);
> -
> -    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
> -        status = virtio_snd_set_pcm_params(vsnd, i, &default_params);
> -        if (status != cpu_to_le32(VIRTIO_SND_S_OK)) {
> -            error_setg(errp,
> -                       "Can't initialize stream params, device responded with %s.",
> -                       print_code(status));
> -            goto error_cleanup;
> -        }
> -        status = virtio_snd_pcm_prepare(vsnd, i);
> -        if (status != cpu_to_le32(VIRTIO_SND_S_OK)) {
> -            error_setg(errp,
> -                       "Can't prepare streams, device responded with %s.",
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
>  static inline void update_latency(VirtIOSoundPCMStream *s, size_t used)
> @@ -1166,7 +1185,7 @@ static void virtio_snd_pcm_out_cb(void *data, int available)
>          if (!virtio_queue_ready(buffer->vq)) {
>              return;
>          }
> -        if (!stream->active) {
> +        if (!(stream->state & VSND_PCMSTREAM_STATE_F_ACTIVE)) {
>              /* Stream has stopped, so do not perform audio_be_write. */
>              return_tx_buffer(stream, buffer);
>              continue;
> @@ -1260,7 +1279,7 @@ static void virtio_snd_pcm_in_cb(void *data, int available)
>          if (!virtio_queue_ready(buffer->vq)) {
>              return;
>          }
> -        if (!stream->active) {
> +        if (!(stream->state & VSND_PCMSTREAM_STATE_F_ACTIVE)) {
>              /* Stream has stopped, so do not perform audio_be_read. */
>              return_rx_buffer(stream, buffer);
>              continue;
> @@ -1333,17 +1352,15 @@ static void virtio_snd_unrealize(DeviceState *dev)
>      qemu_del_vm_change_state_handler(vsnd->vmstate);
>      trace_virtio_snd_unrealize(vsnd);
>  
> -    if (vsnd->pcm.streams) {
> +    if (vsnd->streams) {
> +        virtio_snd_process_cmdq(vsnd);
>          for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
> -            stream = vsnd->pcm.streams[i];
> -            if (stream) {
> -                virtio_snd_process_cmdq(stream->s);
> -                virtio_snd_pcm_close(stream);
> +            stream = &vsnd->streams[i];
> +            if (stream->state & VSND_PCMSTREAM_STATE_F_PREPARED) {
> +                virtio_snd_pcm_flush(stream);

I am not sure we should let the device do IO during unrealize, but this seems to
be just buffer work and the notification is hopefully ignored.

However, it should rather call virtio_snd_pcm_close() to release the associated
SWVoices.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


