Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CC7CFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 10:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxknL-0007oJ-DO; Mon, 07 Oct 2024 06:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sxknJ-0007nl-4k
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 06:16:49 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sxknH-0000SQ-BT
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 06:16:48 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-71e023635acso544970b3a.2
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 03:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728296206; x=1728901006;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=//p0QAZIFxBdtctr+n8wpv2jCgbiwpxUcQc3BVVy7ek=;
 b=DBlPTB3+spCzXpRm+fps17aHo8qCxXAhGZ9lmWxC2S8CN75Z16d9q1CJ+C7BcUF7xM
 pizSc6wlPt5kvcX4YTNbJ80AC2mW7ouTceTn9qf9XqDfziG/c++LgqOVA1Jd2WOOkO/x
 r5GdeelPg0P9oaD2Jz1ejJwxwPhtETC7u+ubsON5YNE770c2tOYvDpzQWD4iJ65iBF+l
 1zTGqCYD+XLyCzlP44cA3k/u6i0kjL3P0+MK8F7FRqzO0VisukSUhI39fryAXWadr/Id
 5L2U++ERMhkFQW3wu0MEouV45OokiDCvYHlCO+wraBAER0OaZCUcmkc5Yqcpp1ytn+QF
 GLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728296206; x=1728901006;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=//p0QAZIFxBdtctr+n8wpv2jCgbiwpxUcQc3BVVy7ek=;
 b=pVhsKs3J0nBYw5q9aQzBf6Y9csja3EM4GDM+hUtrMBwmy0QcETCKTBicUM9GmEZSE4
 zQreax0J+XQzgSHa34WW7BNqzYd+tUhjJQlPB7nYl6KKxIq25BgOHSK5qDXS1TC5XMy7
 iRKVTWBOvqrEQMANiTqRoGClGVG1HxWU8BbOvoOsrKNTvn4/J40gFJ7KZgSkbW52NfER
 irCuGf/Htf/yZcGK3oq9mbULf0YACU1f1QP+rv5Wn3jlaS4gwZxChw2B7kQBxnbbVlKO
 2dftp3J75naPQb2xSu6tEtTT4Ohk8Hl6db7M3Cl0/8GnYpfPlUdJQg26TFfFanfDvXu5
 TW0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnOJhJjqLrSd6DDj80Z+vgbeM+x52ixJgZ6/LSS56e+l7BfLofChN3EjtQFcwgqV+kdVDwBti/aaQ8@nongnu.org
X-Gm-Message-State: AOJu0YzSGH/ok3JvT0sbvLkGIlllXdPEKr3W0o3P1mcNbhtIMZi/G1C5
 RfOMwXBQiANw+VY+9s/cS1kq6SrrmPHVT6fyJzTzR8f2CJ1FkKVWXIsKJW4Oz/g=
X-Google-Smtp-Source: AGHT+IHKVJkRjXt91/py9aUQuP1q6p3GWUtklwgIqKyDsEVEzv7LXHVozo1iXI93XcZZ/VvmlxUIVg==
X-Received: by 2002:a05:6a00:b42:b0:71e:48b:6422 with SMTP id
 d2e1a72fcca58-71e048b6681mr3759789b3a.2.1728296205713; 
 Mon, 07 Oct 2024 03:16:45 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d66319sm4055051b3a.156.2024.10.07.03.16.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 03:16:45 -0700 (PDT)
Message-ID: <05f5e97a-f5fb-43c1-8538-8dc77b629a0f@daynix.com>
Date: Mon, 7 Oct 2024 19:16:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/6] virtio-gpu: Support DRM native context
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>
References: <20241006232350.3198759-1-dmitry.osipenko@collabora.com>
 <20241006232350.3198759-7-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241006232350.3198759-7-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/10/07 8:23, Dmitry Osipenko wrote:
> Add support for DRM native contexts to VirtIO-GPU. DRM context is enabled
> using a new virtio-gpu-gl device option "drm=true".
> 
> Unlike Virgl and Venus contexts that operate on application API level,
> DRM native contexts work on a kernel UAPI level. This lower level results
> in a lightweight context implementations that yield better performance.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   docs/system/devices/virtio-gpu.rst | 11 +++++++++++
>   hw/display/virtio-gpu-gl.c         |  2 ++
>   hw/display/virtio-gpu-virgl.c      | 12 ++++++++++++
>   hw/display/virtio-gpu.c            | 15 +++++++++++++++
>   include/hw/virtio/virtio-gpu.h     |  3 +++
>   5 files changed, 43 insertions(+)
> 
> diff --git a/docs/system/devices/virtio-gpu.rst b/docs/system/devices/virtio-gpu.rst
> index b7eb0fc0e727..8ce67c98aae2 100644
> --- a/docs/system/devices/virtio-gpu.rst
> +++ b/docs/system/devices/virtio-gpu.rst
> @@ -82,6 +82,17 @@ of virtio-gpu host memory window. This is typically between 256M and 8G.
>   
>   .. _venus: https://gitlab.freedesktop.org/virgl/venus-protocol/
>   
> +DRM native context is supported since release of `virglrenderer`_ v1.0.0
> +using `drm`_ protocol. ``DRM`` virtio-gpu capability set ("capset") requires
> +host blob support (``hostmem`` and ``blob`` fields) and should be enabled
> +using ``drm`` field. The ``hostmem`` field specifies the size of virtio-gpu
> +host memory window. This is typically between 256M and 8G.
> +
> +.. parsed-literal::
> +    -device virtio-gpu-gl,hostmem=8G,blob=true,drm=true

"on" is more commonly used than "true".

> +
> +.. _drm: https://gitlab.freedesktop.org/virgl/virglrenderer/-/tree/main/src/drm
> +
>   virtio-gpu rutabaga
>   -------------------
>   
> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> index 53d938f23f20..bd0c0692a5c4 100644
> --- a/hw/display/virtio-gpu-gl.c
> +++ b/hw/display/virtio-gpu-gl.c
> @@ -159,6 +159,8 @@ static Property virtio_gpu_gl_properties[] = {
>                       VIRTIO_GPU_FLAG_STATS_ENABLED, false),
>       DEFINE_PROP_BIT("venus", VirtIOGPU, parent_obj.conf.flags,
>                       VIRTIO_GPU_FLAG_VENUS_ENABLED, false),
> +    DEFINE_PROP_BIT("drm", VirtIOGPU, parent_obj.conf.flags,
> +                    VIRTIO_GPU_FLAG_DRM_ENABLED, false),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index ad1d40901bff..d61f78a28881 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -1227,6 +1227,18 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>       if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
>           flags |= VIRGL_RENDERER_VENUS | VIRGL_RENDERER_RENDER_SERVER;
>       }
> +    if (virtio_gpu_drm_enabled(g->parent_obj.conf)) {
> +        flags |= VIRGL_RENDERER_DRM;
> +
> +        if (!gl->context_fence_enabled) {
> +            /*
> +             * Virglrenderer skips enabling DRM context support without
> +             * enabled async-fence feature. VirtIO-GPU will initialize
> +             * successfully, but DRM context won't be available in guest.
> +             */
> +            warn_report("DRM native context requires EGL display");

It should report an error and stop when an explicitly requested feature 
is unavailable.

> +        }
> +    }
>   #endif
>   
>       ret = virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 0d1de7dc398c..cfd4ed8a104f 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1521,6 +1521,21 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
>   #endif
>       }
>   
> +    if (virtio_gpu_drm_enabled(g->parent_obj.conf)) {
> +#ifdef VIRGL_VERSION_MAJOR
> +    #if VIRGL_VERSION_MAJOR >= 1
> +        if (!virtio_gpu_blob_enabled(g->parent_obj.conf) ||
> +            !virtio_gpu_hostmem_enabled(g->parent_obj.conf)) {
> +            error_setg(errp, "drm requires enabled blob and hostmem options");
> +            return;
> +        }
> +    #else
> +        error_setg(errp, "old virglrenderer, drm unsupported");
> +        return;
> +    #endif
> +#endif
> +    }
> +
>       if (!virtio_gpu_base_device_realize(qdev,
>                                           virtio_gpu_handle_ctrl_cb,
>                                           virtio_gpu_handle_cursor_cb,
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index e95d1619c885..6aaf27d1b319 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -100,6 +100,7 @@ enum virtio_gpu_base_conf_flags {
>       VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED,
>       VIRTIO_GPU_FLAG_RUTABAGA_ENABLED,
>       VIRTIO_GPU_FLAG_VENUS_ENABLED,
> +    VIRTIO_GPU_FLAG_DRM_ENABLED,
>   };
>   
>   #define virtio_gpu_virgl_enabled(_cfg) \
> @@ -120,6 +121,8 @@ enum virtio_gpu_base_conf_flags {
>       (_cfg.hostmem > 0)
>   #define virtio_gpu_venus_enabled(_cfg) \
>       (_cfg.flags & (1 << VIRTIO_GPU_FLAG_VENUS_ENABLED))
> +#define virtio_gpu_drm_enabled(_cfg) \
> +    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_DRM_ENABLED))
>   
>   struct virtio_gpu_base_conf {
>       uint32_t max_outputs;


