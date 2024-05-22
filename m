Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC911C25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 12:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9lDl-0007rX-VH; Wed, 22 May 2024 08:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s9lDa-0007m7-O5
 for qemu-devel@nongnu.org; Wed, 22 May 2024 08:37:21 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s9lDY-0006oR-Rh
 for qemu-devel@nongnu.org; Wed, 22 May 2024 08:37:18 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-520f9d559f6so7774204e87.3
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 05:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716381433; x=1716986233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zjaU9v5l40aDwZsQMUKrFwy1HJOmk+ZYgwCiln+Ko5E=;
 b=l/rxSnL76mEVbzS5Gfriw7zDtVEOR7+3/QEoYhKrhrPBW0r8T6Whu8erGuezDYp/ui
 ssItw23JXHRcyovMiuOU4ETicwIGLVsUc8EX7yRI54X17nbKbkm3S+uWDV7FwDMslXN0
 VWcsWpIfkqk+ylAgQEBGiY3Mhe2qWjv5Mso+1usJcXbRAkSjQA2BtVjJRCFSrckcNntT
 RyMM8nH43CAbFVwNlVkpGSrY8CuiekNyzesP0EvUBjbqcfPWj+9QITfRiLSBRlPrqejq
 SPL5vAXhudadMYMlUnfT0UNs6XzSphhr3WYKdP7LOllZVSEbmK3WUVuhhndjuiV7CdRw
 WDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716381433; x=1716986233;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zjaU9v5l40aDwZsQMUKrFwy1HJOmk+ZYgwCiln+Ko5E=;
 b=rZofiLl300f0Ei39AjsUGWfbB5+mLkKaZSjM0cPX5c+s5GMxsqdbxBVMH6frrMrae2
 hBZw/pwyd44L1JmYFwM9GvTamcXhrU/6QqRaAsTIosnzeEiFjZTCqEfE5Qfm5ihUq1bg
 HVSZhVws2YYhBP3G0pJwqIN9UVwWxWTLFNl7Pf1h+gC/nbirlEdFyN47gRpUbENjAZ62
 IYcD8fYnkyh00sqo1hZ8HrXthvckN9tunQ479q9vHb+DRJ9rzmZS5MMimC/+mbgqBKdk
 TKKUlX+AO+4OtCBj1dIx1T55fAxmqlvzmn3w+QXpvbK5SOEKFyt7Hnosef7KqiJqp0NJ
 u7Fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSabKi/U9/r/QzhJIszECoz9b9tI2sPViVuil+7asnxh8uy2xZD1oiBT0Tf/KvWmfH80sSRBoV8HM0W9Nb4WLTQN0c1yI=
X-Gm-Message-State: AOJu0YwsYCym/su8MPB0BSBwBqNKR4Q5p3lpFUsr7nk/uEKm9LqrcHcI
 Zla1LL5faF6XNmxY9Pbw1IvreMTGpOYlBMr5Qc/W/cqkxad8LH4z/PZJja7hBKo=
X-Google-Smtp-Source: AGHT+IEPV8XAUFkAru6nBdzIbNM2gweUOf1pSb2BWxq0/cFgArsnGAgQIUagxna9Legy5hAGGSkZ7g==
X-Received: by 2002:a05:6512:4019:b0:523:bbcd:ed59 with SMTP id
 2adb3069b0e04-526bf642f52mr1475515e87.50.1716381433219; 
 Wed, 22 May 2024 05:37:13 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b01602sm1790193266b.147.2024.05.22.05.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 05:37:12 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 507BB5F78B;
 Wed, 22 May 2024 13:37:12 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,  Huang Rui
 <ray.huang@amd.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,  "Michael S . Tsirkin" <mst@redhat.com>,  Stefano
 Stabellini <sstabellini@kernel.org>,  Antonio Caggiano
 <quic_acaggian@quicinc.com>,  "Dr . David Alan Gilbert"
 <dgilbert@redhat.com>,  Robert Beckett <bob.beckett@collabora.com>,  Gert
 Wollny <gert.wollny@collabora.com>,  qemu-devel@nongnu.org,  Gurchetan
 Singh <gurchetansingh@chromium.org>,  ernunes@redhat.com,  Alyssa Ross
 <hi@alyssa.is>,  Roger Pau =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,  Stefano Stabellini
 <stefano.stabellini@amd.com>,  Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,  Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>,  Honglei Huang
 <honglei1.huang@amd.com>,  Julia Zhang <julia.zhang@amd.com>,  Chen Jiqian
 <Jiqian.Chen@amd.com>,  Yiwei Zhang <zzyiwei@chromium.org>
Subject: Re: [PATCH v12 02/13] virtio-gpu: Handle virtio_gpu_virgl_init()
 failure
In-Reply-To: <20240519212712.2605419-3-dmitry.osipenko@collabora.com> (Dmitry
 Osipenko's message of "Mon, 20 May 2024 00:27:01 +0300")
References: <20240519212712.2605419-1-dmitry.osipenko@collabora.com>
 <20240519212712.2605419-3-dmitry.osipenko@collabora.com>
Date: Wed, 22 May 2024 13:37:12 +0100
Message-ID: <87v836ggzr.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12d.google.com
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

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> virtio_gpu_virgl_init() may fail, leading to a further Qemu crash
> because Qemu assumes it never fails. Check virtio_gpu_virgl_init()
> return code and don't execute virtio commands on error. Failed
> virtio_gpu_virgl_init() will result in a timed out virtio commands
> for a guest OS.
>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  hw/display/virtio-gpu-gl.c     | 15 +++++++++++++--
>  hw/display/virtio-gpu-virgl.c  |  3 +++
>  include/hw/virtio/virtio-gpu.h |  1 +
>  3 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> index 0c0a8d136954..b353c3193afa 100644
> --- a/hw/display/virtio-gpu-gl.c
> +++ b/hw/display/virtio-gpu-gl.c
> @@ -29,9 +29,14 @@ static void virtio_gpu_gl_update_cursor_data(VirtIOGPU=
 *g,
>                                               struct virtio_gpu_scanout *=
s,
>                                               uint32_t resource_id)
>  {
> +    VirtIOGPUGL *gl =3D VIRTIO_GPU_GL(g);
>      uint32_t width, height;
>      uint32_t pixels, *data;
>=20=20
> +    if (!gl->renderer_inited) {
> +        return;
> +    }
> +
>      data =3D virgl_renderer_get_cursor_data(resource_id, &width, &height=
);
>      if (!data) {
>          return;
> @@ -60,13 +65,18 @@ static void virtio_gpu_gl_handle_ctrl(VirtIODevice *v=
dev, VirtQueue *vq)
>      VirtIOGPU *g =3D VIRTIO_GPU(vdev);
>      VirtIOGPUGL *gl =3D VIRTIO_GPU_GL(vdev);
>      struct virtio_gpu_ctrl_command *cmd;
> +    int ret;
>=20=20
> -    if (!virtio_queue_ready(vq)) {
> +    if (!virtio_queue_ready(vq) || gl->renderer_init_failed) {
>          return;
>      }
>=20=20
>      if (!gl->renderer_inited) {
> -        virtio_gpu_virgl_init(g);
> +        ret =3D virtio_gpu_virgl_init(g);
> +        if (ret) {
> +            gl->renderer_init_failed =3D true;
> +            return;
> +        }
>          gl->renderer_inited =3D true;
>      }
>      if (gl->renderer_reset) {
> @@ -101,6 +111,7 @@ static void virtio_gpu_gl_reset(VirtIODevice *vdev)
>      if (gl->renderer_inited && !gl->renderer_reset) {
>          virtio_gpu_virgl_reset_scanout(g);
>          gl->renderer_reset =3D true;
> +        gl->renderer_init_failed =3D false;
>      }
>  }
>=20=20
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 6ba4c24fda1d..bfbc6553e879 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -668,6 +668,9 @@ int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)
>=20=20
>  void virtio_gpu_virgl_deinit(VirtIOGPU *g)
>  {
> +    if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
> +        timer_free(g->print_stats);
> +    }
>      timer_free(g->fence_poll);
>      virgl_renderer_cleanup(NULL);
>  }
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
> index 8ece1ec2e98b..236daba24dd2 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -230,6 +230,7 @@ struct VirtIOGPUGL {
>=20=20
>      bool renderer_inited;
>      bool renderer_reset;
> +    bool renderer_init_failed;

Do we really want 3 bools to represent a bunch of mutually incompatible
state? How about:

  typedef enum {
    /** starting state */
    RS_START =3D 0,
    /** renderer initialised */
    RS_INITED,
    /** renderer reset */
    RS_RESET,
    /** failed initialisation */
    RS_INIT_FAILED
  } RenderState;

then for example you could flow virtio_gpu_gl_handle_ctrl() as:

  switch (gl->render_state) {
  case RS_START:
  {
        gl->render_state =3D virtio_gpu_virgl_init(g) ? RS_INIT_FAILED : RS=
_INITED;=20=20
  }
  case RS_RESET:
  {
        virtio_gpu_virgl_reset(g);
        gl->render_state =3D RS_INITED;
        break;
  }
  case RS_INIT_FAILED:
       /* nothing to do, return early and maybe log */
       return;
  case RS_INITED:
         /* just continue */
         break;
  }



>  };
>=20=20
>  struct VhostUserGPU {

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

