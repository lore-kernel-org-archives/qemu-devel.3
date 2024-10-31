Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786EFE68972
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 10:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6SO9-0002O5-NX; Thu, 31 Oct 2024 06:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t6SO8-0002Nb-0L
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 06:26:48 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t6SO5-0006Cn-P9
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 06:26:47 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-539fe76e802so941764e87.1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 03:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730370403; x=1730975203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fv95Tfif0bqZGbzLaIjiXWHxm7z3kTxzdMEec8vqSgw=;
 b=UZFrXmf0+zK2rtnuHVCUafJjCqosnhNf3ZL1+uGFLHUGbO/rjZN0zsGQ/2UY7Vnoj7
 BmPmyo2/fQalwJjcf6DovsnobsTsBCOsYIJ4+oM1AC37yZnwyNABe2nA/RHiSUdvpZzF
 Jd6U7hC9u9Gt0BkuwBrigzbS3dE9tKFbl58UBmevgDkhepOy/Rljmg07R5K7FASPYAbF
 29KYIlLWIt6HLkEXxL8+04sBP4LnB4DA58CHnFjgOvrllG7SLlQQT/yBss3HmMJNTltw
 rSCeoPc0Io+ME0teI9pNaXel9wKXQuLW6DsekddEDn/XT6c4rLI45fx4deAry361ppGU
 qxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730370403; x=1730975203;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fv95Tfif0bqZGbzLaIjiXWHxm7z3kTxzdMEec8vqSgw=;
 b=Y0E9YRP7bIUaKnpi9wELwd/oTCoj6enwLwp2ATsBjqtTjp3JaHGvyxsJa60Q7ZGmdA
 RHWoOoAcU3boiHAYlL7A+FwyEZzKACa4MZww0l7LnwV1azjK/iNxwEv5Hr6k0f32qibq
 33splI+Pk4niIBd9Bz0mnaVI49JbfVGUR1cn5JNv1jpQon4cW9wB6QB52w/n9LDsdc4j
 yvnb5EFSC9F1msB5LS77vjYrCu2sM7KJP52z9Mia+jAW228ghPzSp2fIrIJPEu2Fn20l
 eMvOq2b6bjCkWTp8Ws8SkDx6olRxP81XCJeUo+LNdeNNPKWPFmNN2t9Ms9HwPtPjXPIM
 pf8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkr+c3g93JcP9IYE1RHV7JUEtPgcq3/odlUR6ZM69fIYbs9ogqrltIyNhvtKGQpeHOHNsM337W/YTi@nongnu.org
X-Gm-Message-State: AOJu0YzcJ8mulcGnujmk7ZCN27c3bq1JvytxIs7t2hyZBdWxSxrAQPbD
 YPfR5uirN/pfnB3R0fUWkigZQgydUeDI52SPIG+a776+woa4mRHXU72o9avLtFo=
X-Google-Smtp-Source: AGHT+IF2bh3BzI5XoNl0btsS6icH3HQVQ2GAT70hNa4q+1HwQdxZFIiCHWHUj4OZqwWTpUc2jfwF2Q==
X-Received: by 2002:a05:6512:3d8b:b0:539:d0ef:b3f9 with SMTP id
 2adb3069b0e04-53b3491dfc0mr10006136e87.40.1730370402710; 
 Thu, 31 Oct 2024 03:26:42 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9aa83asm51340415e9.31.2024.10.31.03.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 03:26:42 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5A1685F780;
 Thu, 31 Oct 2024 10:26:41 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,  Huang Rui
 <ray.huang@amd.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,  "Michael S . Tsirkin" <mst@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Gert Wollny <gert.wollny@collabora.com>,
 qemu-devel@nongnu.org,  Gurchetan Singh <gurchetansingh@chromium.org>,
 Alyssa Ross <hi@alyssa.is>,  Roger Pau =?utf-8?Q?Monn=C3=A9?=
 <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,  Stefano Stabellini
 <stefano.stabellini@amd.com>,  Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,  Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>,  Honglei Huang
 <honglei1.huang@amd.com>,  Julia Zhang <julia.zhang@amd.com>,  Chen Jiqian
 <Jiqian.Chen@amd.com>,  Rob Clark <robdclark@gmail.com>,  Yiwei Zhang
 <zzyiwei@chromium.org>,  Sergio Lopez Pascual <slp@redhat.com>
Subject: Re: [PATCH v3 6/6] virtio-gpu: Support DRM native context
In-Reply-To: <20241024233355.136867-7-dmitry.osipenko@collabora.com> (Dmitry
 Osipenko's message of "Fri, 25 Oct 2024 02:33:54 +0300")
References: <20241024233355.136867-1-dmitry.osipenko@collabora.com>
 <20241024233355.136867-7-dmitry.osipenko@collabora.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 31 Oct 2024 10:26:41 +0000
Message-ID: <87sescin4u.fsf@draig.linaro.org>
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

> Add support for DRM native contexts to VirtIO-GPU. DRM context is enabled
> using a new virtio-gpu-gl device option "drm=3Don".

I feel like using "drm" is confusing in this context because drm exists
for the host and guest. What about "native-context" or even
"context=3D[opengl|vulkan|wayland|native]"?

The GPU command line is already getting complex so now might be the time
to rationalise it.

As an aside can mesa build the intel drivers on non-x86 systems as now I
could potentially pass my native intel context to my emulated aarch64
guests?

>
> Unlike Virgl and Venus contexts that operate on application API level,
> DRM native contexts work on a kernel UAPI level. This lower level results
> in a lightweight context implementations that yield better performance.
>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  docs/system/devices/virtio-gpu.rst | 11 +++++++++++
>  hw/display/virtio-gpu-gl.c         |  2 ++
>  hw/display/virtio-gpu-virgl.c      | 22 ++++++++++++++++++++++
>  hw/display/virtio-gpu.c            | 15 +++++++++++++++
>  include/hw/virtio/virtio-gpu.h     |  3 +++
>  5 files changed, 53 insertions(+)
>
> diff --git a/docs/system/devices/virtio-gpu.rst b/docs/system/devices/vir=
tio-gpu.rst
> index b7eb0fc0e727..49a75138f7ef 100644
> --- a/docs/system/devices/virtio-gpu.rst
> +++ b/docs/system/devices/virtio-gpu.rst
> @@ -82,6 +82,17 @@ of virtio-gpu host memory window. This is typically be=
tween 256M and 8G.
>=20=20
>  .. _venus: https://gitlab.freedesktop.org/virgl/venus-protocol/
>=20=20
> +DRM native context is supported since release of `virglrenderer`_ v1.0.0
> +using `drm`_ protocol. ``DRM`` virtio-gpu capability set ("capset") requ=
ires
> +host blob support (``hostmem`` and ``blob`` fields) and should be enabled
> +using ``drm`` field. The ``hostmem`` field specifies the size of virtio-=
gpu
> +host memory window. This is typically between 256M and 8G.
> +
> +.. parsed-literal::
> +    -device virtio-gpu-gl,hostmem=3D8G,blob=3Don,drm=3Don
> +
> +.. _drm: https://gitlab.freedesktop.org/virgl/virglrenderer/-/tree/main/=
src/drm
> +
>  virtio-gpu rutabaga
>  -------------------
>=20=20
> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> index 53d938f23f20..bd0c0692a5c4 100644
> --- a/hw/display/virtio-gpu-gl.c
> +++ b/hw/display/virtio-gpu-gl.c
> @@ -159,6 +159,8 @@ static Property virtio_gpu_gl_properties[] =3D {
>                      VIRTIO_GPU_FLAG_STATS_ENABLED, false),
>      DEFINE_PROP_BIT("venus", VirtIOGPU, parent_obj.conf.flags,
>                      VIRTIO_GPU_FLAG_VENUS_ENABLED, false),
> +    DEFINE_PROP_BIT("drm", VirtIOGPU, parent_obj.conf.flags,
> +                    VIRTIO_GPU_FLAG_DRM_ENABLED, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>=20=20
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 37b40e258398..89ca1878fb7c 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -1232,6 +1232,19 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>      if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
>          flags |=3D VIRGL_RENDERER_VENUS | VIRGL_RENDERER_RENDER_SERVER;
>      }
> +    if (virtio_gpu_drm_enabled(g->parent_obj.conf)) {
> +        flags |=3D VIRGL_RENDERER_DRM;
> +
> +        if (!gl->context_fence_enabled) {
> +            /*
> +             * Virglrenderer skips enabling DRM context support without
> +             * enabled async-fence feature. VirtIO-GPU will initialize
> +             * successfully, but DRM context won't be available in guest.
> +             */
> +            error_report("DRM native context requires EGL display");
> +            return -EINVAL;
> +        }
> +    }
>  #endif
>=20=20
>      ret =3D virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
> @@ -1294,5 +1307,14 @@ GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
>          }
>      }
>=20=20
> +    if (virtio_gpu_drm_enabled(g->parent_obj.conf)) {
> +        virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_DRM,
> +                                   &capset_max_ver,
> +                                   &capset_max_size);
> +        if (capset_max_size) {
> +            virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_DR=
M);
> +        }
> +    }
> +
>      return capset_ids;
>  }
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index c0570ef8565a..c1acafe6246b 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1492,6 +1492,21 @@ void virtio_gpu_device_realize(DeviceState *qdev, =
Error **errp)
>  #endif
>      }
>=20=20
> +    if (virtio_gpu_drm_enabled(g->parent_obj.conf)) {
> +#ifdef VIRGL_VERSION_MAJOR
> +    #if VIRGL_VERSION_MAJOR >=3D 1
> +        if (!virtio_gpu_blob_enabled(g->parent_obj.conf) ||
> +            !virtio_gpu_hostmem_enabled(g->parent_obj.conf)) {
> +            error_setg(errp, "drm requires enabled blob and hostmem opti=
ons");
> +            return;
> +        }
> +    #else
> +        error_setg(errp, "old virglrenderer, drm unsupported");
> +        return;
> +    #endif
> +#endif
> +    }
> +
>      if (!virtio_gpu_base_device_realize(qdev,
>                                          virtio_gpu_handle_ctrl_cb,
>                                          virtio_gpu_handle_cursor_cb,
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
> index 99cc6286f473..f1799fcb6eee 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -98,6 +98,7 @@ enum virtio_gpu_base_conf_flags {
>      VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED,
>      VIRTIO_GPU_FLAG_RUTABAGA_ENABLED,
>      VIRTIO_GPU_FLAG_VENUS_ENABLED,
> +    VIRTIO_GPU_FLAG_DRM_ENABLED,
>  };
>=20=20
>  #define virtio_gpu_virgl_enabled(_cfg) \
> @@ -118,6 +119,8 @@ enum virtio_gpu_base_conf_flags {
>      (_cfg.hostmem > 0)
>  #define virtio_gpu_venus_enabled(_cfg) \
>      (_cfg.flags & (1 << VIRTIO_GPU_FLAG_VENUS_ENABLED))
> +#define virtio_gpu_drm_enabled(_cfg) \
> +    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_DRM_ENABLED))
>=20=20
>  struct virtio_gpu_base_conf {
>      uint32_t max_outputs;

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

