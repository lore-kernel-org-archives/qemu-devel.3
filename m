Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C23C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 06:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4acS-0004pq-Aj; Wed, 08 May 2024 02:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s4acP-0004cL-El
 for qemu-devel@nongnu.org; Wed, 08 May 2024 02:17:33 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s4acM-0003KV-LI
 for qemu-devel@nongnu.org; Wed, 08 May 2024 02:17:33 -0400
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-43a317135a5so3422931cf.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 23:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715149049; x=1715753849; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oqtHgovlf7nxbLei33vGGyxizlMUm0PjsscrMguif4M=;
 b=e+SXzSIUtnTW/zQz+fTDN7v+R8ABCjGodgTpJ0wgjCCv8Q96hQv2UNJW/Ht+Gq2VUO
 YRxPwIKrNIImOQz07jX1mFEezWqHOrHrZOS41d4aSCfrDaG4Dr+ND2v8Sg8luNGzWPqW
 HAQblftvMM37xAU5EIg0fF53C0y3Mit5nCrP/1UyHmhf8crdDlSzF5hV1uVVcdIETH/L
 ZE5LSjbodIi4RtphzjoDizZH6ReKeWDYM7CCLsb6ihEuAU/j7KqzVO2rApHW10BauCvJ
 rrnpo8NXC9Jd7XaCb/yjqpRjutrBXFfydj7odH9jVYz/e6g5zW6/VkxlNeaqtE+mG7bn
 dNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715149049; x=1715753849;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oqtHgovlf7nxbLei33vGGyxizlMUm0PjsscrMguif4M=;
 b=T0EIxYxRz96tm1Uf3hJesf0ldKXATyX24NOYMiFkUWcHujk7wXFatgFLpU0WSQObN0
 /+KBHLrIluzkGZ50DdpWkUHITwbulHtmta/lOIZFoGrxyIcmRFdhnALAkNjPiOfP5cAc
 14E/FFxmT2OkD3hVuvXi0/XbmDy+Hhau7pQRanQS6yk5TE03hOtO+Ihcnmhopvl0HiZK
 Or/FNXTwQmr2f3P+9XwK6RgJ6sEdPA4DYpCAxDPH2LvQuEmvrj0TREoM8V7DjuBs06zI
 n025t934gjvWVPyC3PLTbSErXvPUBW1LdHfdENublvrt9RqSC7fqjkeYMSYKRABbbN4g
 8jgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6aS3JtsFT5u1RARqESIkHItr6K1QxwSgkvj15sPeA2aoqWc94yxgLBCWhgbOruhhxYZIkqEHIFpZH1msa8Y0TEDg+qIw=
X-Gm-Message-State: AOJu0YyZqm3U/Af0BlAgDgybtdnrA9GFKCkjrNo+wLmdQIp+NqroXpTn
 Fe6KGYrE7QVKYTbVxzah2bihvNSqU75t67pC+9gHDmvonzil56gCyxJBgjLrSCTBHb9bzSU+pwx
 MeLgEaAmC5CsVSdjsLBVz5Z1UVEM=
X-Google-Smtp-Source: AGHT+IHp4QLg29gX2rtBX0S69sBcj8AiNefTKNJU+RqRq7JrdirCQjdpOGcunV2c6tSegUGUltz8CkKsbCJJNTkryUA=
X-Received: by 2002:a05:622a:1993:b0:43c:8612:8191 with SMTP id
 d75a77b69052e-43d8f32b23amr80256211cf.8.1715149049428; Tue, 07 May 2024
 23:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240504202834.399780-1-dmitry.osipenko@collabora.com>
 <20240504202834.399780-4-dmitry.osipenko@collabora.com>
In-Reply-To: <20240504202834.399780-4-dmitry.osipenko@collabora.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 8 May 2024 10:17:17 +0400
Message-ID: <CAJ+F1CL77z=7LktBO9tZLNeOKLFm1=9j+VD1eTc1DAm6JA=50Q@mail.gmail.com>
Subject: Re: [PATCH v10 03/10] virtio-gpu: Support context-init feature with
 virglrenderer
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>, 
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, 
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, 
 Gurchetan Singh <gurchetansingh@chromium.org>, ernunes@redhat.com, 
 Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, 
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>, 
 Yiwei Zhang <zzyiwei@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Sun, May 5, 2024 at 12:29=E2=80=AFAM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> From: Huang Rui <ray.huang@amd.com>
>
> Patch "virtio-gpu: CONTEXT_INIT feature" has added the context_init
> feature flags. Expose this feature and support creating virglrenderer
> context with flags using context_id if libvirglrenderer is new enough.
>
> Originally-by: Antonio Caggiano <antonio.caggiano@collabora.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  hw/display/virtio-gpu-gl.c    |  4 ++++
>  hw/display/virtio-gpu-virgl.c | 20 ++++++++++++++++++--
>  meson.build                   |  1 +
>  3 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> index 0c0a8d136954..95806999189e 100644
> --- a/hw/display/virtio-gpu-gl.c
> +++ b/hw/display/virtio-gpu-gl.c
> @@ -127,6 +127,10 @@ static void virtio_gpu_gl_device_realize(DeviceState=
 *qdev, Error **errp)
>      VIRTIO_GPU_BASE(g)->virtio_config.num_capsets =3D
>          virtio_gpu_virgl_get_num_capsets(g);
>
> +#ifdef HAVE_VIRGL_CONTEXT_CREATE_WITH_FLAGS
> +    g->parent_obj.conf.flags |=3D 1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENAB=
LED;
> +#endif
> +
>      virtio_gpu_device_realize(qdev, errp);
>  }
>
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.=
c
> index b0500eccf8e0..8306961ad502 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -106,8 +106,24 @@ static void virgl_cmd_context_create(VirtIOGPU *g,
>      trace_virtio_gpu_cmd_ctx_create(cc.hdr.ctx_id,
>                                      cc.debug_name);
>
> -    virgl_renderer_context_create(cc.hdr.ctx_id, cc.nlen,
> -                                  cc.debug_name);
> +    if (cc.context_init) {
> +        if (!virtio_gpu_context_init_enabled(g->parent_obj.conf)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: context_init disabled",
> +                          __func__);
> +            cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
> +            return;
> +        }
> +
> +#ifdef HAVE_VIRGL_CONTEXT_CREATE_WITH_FLAGS
> +        virgl_renderer_context_create_with_flags(cc.hdr.ctx_id,
> +                                                 cc.context_init,
> +                                                 cc.nlen,
> +                                                 cc.debug_name);
> +        return;
> +#endif

I am wondering if there should be a:

#else
    g_assert_not_reached();
#endif

rather than falling back to a regular context creation.

> +    }
> +
> +    virgl_renderer_context_create(cc.hdr.ctx_id, cc.nlen, cc.debug_name)=
;
>  }
>
>  static void virgl_cmd_context_destroy(VirtIOGPU *g,
> diff --git a/meson.build b/meson.build
> index f4a4d71c1978..513cb2ea6d03 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2288,6 +2288,7 @@ config_host_data.set('CONFIG_VNC_JPEG', jpeg.found(=
))
>  config_host_data.set('CONFIG_VNC_SASL', sasl.found())
>  if virgl.version().version_compare('>=3D1.0.0')
>    config_host_data.set('HAVE_VIRGL_D3D_INFO_EXT', 1)
> +  config_host_data.set('HAVE_VIRGL_CONTEXT_CREATE_WITH_FLAGS', 1)
>  endif
>  config_host_data.set('CONFIG_VIRTFS', have_virtfs)
>  config_host_data.set('CONFIG_VTE', vte.found())
> --
> 2.44.0
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

--=20
Marc-Andr=C3=A9 Lureau

