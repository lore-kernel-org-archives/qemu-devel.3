Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CD4D3C54C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 05:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1fcm-0007Pg-On; Fri, 18 Oct 2024 01:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t1fci-00079b-Uu
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 01:34:05 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t1fcg-0008M7-Ac
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 01:34:04 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20cbca51687so18378845ad.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 22:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1729229640; x=1729834440;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DOmLzDAAGj59oSH09jOFyaSf1npC/5wIw0PJP3kcKhY=;
 b=0j2ypcYN/xCygzVRZ7m3Tnbh5UgyLmlOocW8C+7D2WfSaCEH60rsDrP+yWxhWjyH9Z
 NFLiXCKkNxfIci5ZYKZ0meMG4ZeVY8Iv/0tOWPS7q6bj9yLhlT9A64Fz9aopekkqvreQ
 hOi2rpr/+aphmh5b9b0TuFnxdmor2rgEO+pRo8GQTusJMs+AzOTXYFMF0DmFSIwFKFo2
 XRbhEjqqVq9KGvLd5HAoXNgJD9aKFjV9TACGflyM1JOA8gdsy8F+CoA5S+ElGZupTGJ0
 v7Y3OtHwWFIlPKI6u/lrzBmuFYcqGYsul/O86YwALvca0lLy4dCCDDIIv+l4KpuibbrG
 UHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729229640; x=1729834440;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DOmLzDAAGj59oSH09jOFyaSf1npC/5wIw0PJP3kcKhY=;
 b=j6r6aVBe0wqPurLSN7TMV+Sb0Q8nWJfnqd5J5PqFE8aVIPJiVW8wm3i/zY8nQlceWq
 eUuMCbD3OxTeRApbs9YbribSqv9xGSG9LKAj29m6hbMtatgMQ+9pf8AgxlJlvzDoaGzZ
 TY8EpeycZvEDi2ZrpXopZ+o7RA7z3Nn+jEA/2+xCXK7xlXqi4/fwXXhH7EZo82dI8+S5
 pHhpRfBvGAa5UmqZoiL5w839qfleyNugE45fNNPKXQTBGz3I0Z6LlF7n2Ng0m1CPdpZf
 6eglYySHM1PdE3tAeJsTvvUdCitrMvYyYgnJgbHDslOSW5bIvX6jrTesAgb6X4NFppqk
 9LLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcdDDZLC3syW1qV/e/f5606t4VXN9dTO0SOl3Zx/z+vghrm5vJE87iOercv3AjPapArnxF4dX56yA0@nongnu.org
X-Gm-Message-State: AOJu0Yz5GBVQJZkhtaOnlRJdMVTbUS2byq/73pR3B/R4ajmEOZ731598
 fHLSbe8Gpz/OcnXATfAsKl4vdIslehfgSNVCg6WFQqfc2NL7g2WpKizOz/omDmw=
X-Google-Smtp-Source: AGHT+IHDBPFThF8fkFoSc5QYlu/FdJsDrFXUmpDfnYH3CJBpL7CnaJuZ/td2bKSfOvk/vwORBSWXPA==
X-Received: by 2002:a05:6a21:1707:b0:1d9:1377:c1a3 with SMTP id
 adf61e73a8af0-1d92c5990bbmr1504862637.40.1729229640390; 
 Thu, 17 Oct 2024 22:34:00 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ea3453f60sm628975b3a.148.2024.10.17.22.33.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 22:34:00 -0700 (PDT)
Message-ID: <897267cd-4502-48f9-8cab-87cd83770cb6@daynix.com>
Date: Fri, 18 Oct 2024 14:33:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] virtio-gpu: Support DRM native context
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
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
References: <20241015043238.114034-1-dmitry.osipenko@collabora.com>
 <20241015043238.114034-7-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241015043238.114034-7-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
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

On 2024/10/15 13:32, Dmitry Osipenko wrote:
> Add support for DRM native contexts to VirtIO-GPU. DRM context is enabled
> using a new virtio-gpu-gl device option "drm=on".
> 
> Unlike Virgl and Venus contexts that operate on application API level,
> DRM native contexts work on a kernel UAPI level. This lower level results
> in a lightweight context implementations that yield better performance.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   docs/system/devices/virtio-gpu.rst | 11 +++++++++++
>   hw/display/virtio-gpu-gl.c         |  2 ++
>   hw/display/virtio-gpu-virgl.c      | 22 ++++++++++++++++++++++
>   hw/display/virtio-gpu.c            | 15 +++++++++++++++
>   include/hw/virtio/virtio-gpu.h     |  3 +++
>   5 files changed, 53 insertions(+)
> 
> diff --git a/docs/system/devices/virtio-gpu.rst b/docs/system/devices/virtio-gpu.rst
> index b7eb0fc0e727..49a75138f7ef 100644
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
> +    -device virtio-gpu-gl,hostmem=8G,blob=on,drm=on
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
> index ad6512987079..931805958ae8 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -1229,6 +1229,19 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
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
> +            error_report("DRM native context requires EGL display");
> +            return -EINVAL;
> +        }
> +    }
>   #endif
>   
>       ret = virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
> @@ -1294,5 +1307,14 @@ GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
>           }
>       }
>   
> +    if (virtio_gpu_drm_enabled(g->parent_obj.conf)) {
> +        virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_DRM,
> +                                   &capset_max_ver,
> +                                   &capset_max_size);
> +        if (capset_max_size) {
> +            virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_DRM);
> +        }
> +    }
> +
>       return capset_ids;
>   }
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

This ifdef is unnecessary.

 > +    #if VIRGL_VERSION_MAJOR >= 1> +        if 
(!virtio_gpu_blob_enabled(g->parent_obj.conf) ||
> +            !virtio_gpu_hostmem_enabled(g->parent_obj.conf)) {
> +            error_setg(errp, "drm requires enabled blob and hostmem options");
> +            return;
> +        }
> +    #else
> +        error_setg(errp, "old virglrenderer, drm unsupported");
> +        return;
> +    #endif
> +#endif
 > +    }> +
>       if (!virtio_gpu_base_device_realize(qdev,
>                                           virtio_gpu_handle_ctrl_cb,
>                                           virtio_gpu_handle_cursor_cb,
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index 5673f0be85f4..fbb30d537af8 100644
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


