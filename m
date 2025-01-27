Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131A1C0218C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 06:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcIbg-0000XT-IG; Mon, 27 Jan 2025 01:28:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tcIbf-0000XL-2o
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 01:28:23 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tcIbc-0003J4-B4
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 01:28:22 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2efb17478adso6936798a91.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 22:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737959298; x=1738564098;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qdGklV3bD/Na9yyaq0qF6kZZAzrWlyOwPH/OxSTWyMY=;
 b=dwPPTcfBuydPYVoDhxvJZsr1RtybMyzNP2d3Dl8AtJ2OSVkdj3waYcGksFL6XbmNAT
 YLSnldCf1EFT134U9uNz2myFgwGGDXHUmr2aogHVz7b0PUmePermnCWFxvhgJua080yc
 I6aVRAnUnqO1RO5l5AWiwXHrd4B/80xDU4ZY14pSNie+TjOd+nnoIlqEmfBvgMYffmLM
 9UF9pjhdDmH3d+q13y8yn/OfB/GVVnCp+huIukSStCHNUx88nlw+KbthiUmmp70unThj
 hgurhs0dFv8pwjOyvT1YVYW3inTrdl8+Dr9kvQHAjQUlzuOKZiVu7keKDp6sA1W3KlDP
 LAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737959298; x=1738564098;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qdGklV3bD/Na9yyaq0qF6kZZAzrWlyOwPH/OxSTWyMY=;
 b=KTkMu+kex4ntvWraTyKyV2+dFmuP5Ul6da0yOJSBr6DhI4eKgji4qULKMj+WeWqxZy
 5p07+O5SHo8tHD+fhTcajtBL9rB7De4FYnyfodzlioqDtygjGHrAehoZAa07lfS9tlus
 Q5p3uqzDWiqLq8lela8iH6qvVg43Wvu6fUSNsmMYx/EFFJICEd5T9e8bjpt1JDre+lxX
 J0E/HLCyeYVAIrE3MsFKG27AbTZfD1lcDD8xZmDgkDpXNT8W5fHOjG4Lyifslzv89gA0
 WR1NoVGMrb+GWiUX+twDb8Hva5nllS7j8i4VB9hlcnI5e4Vz9+warP+3yZ/IInTEg+3i
 p9hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2WoM+upRXdZf+rqPS1nn0RlEfJiCQ37iyqJdPdRgBs8ilZ6JUzp12kNclBhj/wIp9/MY2SrWFyOjv@nongnu.org
X-Gm-Message-State: AOJu0Yw/BBVPjH/q8lahZf5zMajaVj4wDRmfH6UY8rCTYW5EYVgh0H52
 KwyX3Bv1+OYXITvfZOh7GU/pp/Ex5FbInETnLn6Nr8EfQuAf7KhtkaJrby6FNzs=
X-Gm-Gg: ASbGncuOxYEeYyhRir9vSCzu7i4QuP7pWqg728n6NBOfEi5W/p3R+AtzkkhxdfRgaVy
 wky0+Wgja5YdIKOEfbsZgJp2wst4i8bbc63zEeiyw0KmbwSIQ+WlGhzCt1FiswFymTnGUPdUh9t
 BfXcYJZG2lmg5mtWaOGb2FDdYOsh+FQMkOmxavnfOnHsiy42sb78Se9f38BrBnCVQBS9RG6kXJo
 A02CdS3KuXy4rTYgBLnzlSjlimmoCA5IgZzARpmmgvgzGbNPmNLSy6z5iAK/0/0rAP6VTFRDKT2
 B5rMMIo9bVLmYbg=
X-Google-Smtp-Source: AGHT+IHGQiOksgMIIWv0sF8aFMIL+v6xACbWm9bVb0A8iZkgQZWlNDid+2LMquWAJMyvykGaQBqIVA==
X-Received: by 2002:a17:90b:2703:b0:2ee:d63f:d71 with SMTP id
 98e67ed59e1d1-2f782c7252dmr65163412a91.14.1737959298309; 
 Sun, 26 Jan 2025 22:28:18 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffa6ad74sm6150355a91.23.2025.01.26.22.28.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 22:28:17 -0800 (PST)
Message-ID: <42646f72-c2c8-43c5-abe1-e8e1b3c9d31b@daynix.com>
Date: Mon, 27 Jan 2025 15:28:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/10] docs/system: virtio-gpu: Document host/guest
 requirements
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
References: <20250126201121.470990-1-dmitry.osipenko@collabora.com>
 <20250126201121.470990-11-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250126201121.470990-11-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2025/01/27 5:11, Dmitry Osipenko wrote:
> From: Alex Bennée <alex.bennee@linaro.org>
> 
> This attempts to tidy up the VirtIO GPU documentation to make the list
> of requirements clearer. There are still a lot of moving parts and the
> distros have some catching up to do before this is all handled
> automatically.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Sergio Lopez Pascual <slp@redhat.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> [dmitry.osipenko@collabora.com: Extended and corrected doc]
> ---
>   docs/system/devices/virtio-gpu.rst | 107 ++++++++++++++++++++++++++++-
>   1 file changed, 106 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/system/devices/virtio-gpu.rst b/docs/system/devices/virtio-gpu.rst
> index ea3eb052df3c..b3db984ff2d3 100644
> --- a/docs/system/devices/virtio-gpu.rst
> +++ b/docs/system/devices/virtio-gpu.rst
> @@ -5,7 +5,9 @@ virtio-gpu
>   ==========
>   
>   This document explains the setup and usage of the virtio-gpu device.
> -The virtio-gpu device paravirtualizes the GPU and display controller.
> +The virtio-gpu device provides a GPU and display controller
> +paravirtualized using VirtIO. It supports a number of different modes
> +from simple 2D displays to fully accelerated 3D graphics.
>   
>   Linux kernel support
>   --------------------
> @@ -13,6 +15,24 @@ Linux kernel support
>   virtio-gpu requires a guest Linux kernel built with the
>   ``CONFIG_DRM_VIRTIO_GPU`` option.
>   
> +Dependencies
> +............
> +
> +.. note::
> +  GPU virtualisation is still an evolving field. Depending on the mode
> +  you are running you may need to override distribution supplied
> +  libraries with more recent versions or enable build options.

s/virtualisation/virtualization/ for consistency with other documentations.

> +
> +  Depending on the mode there are a number of requirements the host must
> +  meet to be able to be able to support guests. For 3D acceleration QEMU
> +  must be able to access the hosts GPU and for the best performance be
> +  able to reliably share GPU memory with the guest.
> +
> +  Virtio-gpu requires a guest Linux kernel built with the
> +  ``CONFIG_DRM_VIRTIO_GPU`` option. For 3D accelerations you
> +  will need support from guest Mesa configured for whichever encapsulation
> +  you need.

This section is part of the "Linux kernel support" chapter, which used 
to describe the guest Linux kernel requirement, but this section 
discusses a broader topic that includes the host requirements and guest 
Mesa. This section needs to be re-structured.

It says "GPU virtualisation is still an evolving field", but I believe 
the main evolving field is 3D acceleration. The later parts also 
repetitively mention 3D acceleration. Instead of repeating the same 
phrase, let the reader know that this section talks about 3D 
acceleration at the beginning. It will make the section more concise and 
allows readers to skip it when they do not care 3D acceleration.

The ``CONFIG_DRM_VIRTIO_GPU`` option is already described earlier so its 
description is redundant.

> +
>   QEMU virtio-gpu variants
>   ------------------------
>   
> @@ -56,6 +76,16 @@ on typical modern Linux distributions.
>   .. _Mesa: https://www.mesa3d.org/
>   .. _SwiftShader: https://github.com/google/swiftshader
>   
> +.. list-table:: Host Requirements
> +  :header-rows: 1
> +
> +  * - Mode
> +    - Kernel
> +    - Userspace
> +  * - virtio-gpu
> +    - Framebuffer enabled

It is not clear what "framebuffer enabled" means, and it is also 
inconsistent with the host requirements tables in later sections that 
describes the Linux kernel version. Also be aware that virtio-gpu works 
effectively anywhere, not just Linux.

> +    - GTK or SDL display

It is also inconsistent with later section that describes acceleration 
backends instead of the display. virtio-gpu also works with any display 
and is not restricted to GTK or SDL.

> +
>   virtio-gpu virglrenderer
>   ------------------------
>   
> @@ -94,6 +124,61 @@ of virtio-gpu host memory window. This is typically between 256M and 8G.
>   
>   .. _drm: https://gitlab.freedesktop.org/virgl/virglrenderer/-/tree/main/src/drm
>   
> +.. list-table:: Host Requirements
> +  :header-rows: 1
> +
> +  * - Mode
> +    - Kernel
> +    - Userspace
> +  * - virtio-gpu-gl (OpenGL pass-through)

It's already in the "virtio-gpu virglrenderer" setion so you don't have 
to mention "virtio-gpu-gl" again here.

> +    - GPU enabled> +    - libvirglrenderer (virgl support)> +  * - virtio-gpu-gl (Vulkan 
pass-through)
> +    - Linux 6.13+
> +    - libvirglrenderer (>= 1.0.0, venus support)

"venus support" is a vague wording. I can guess it means it requires a 
build flag, but it's not clear for a novice.

Perhaps you may write the build flag as you did for Mesa.

> +  * - virtio-gpu-gl (vDRM native context/AMD)

The later part of documentation calls it "DRM native context", not "vDRM 
native context"; let's keep them consistent. "vDRM native context" seems 
rarely used; I could only find one example of existing literature:
https://www.collabora.com/news-and-blog/blog/2025/01/15/the-state-of-gfx-virtualization-using-virglrenderer/

Mesa has a directory named vdrm but it is mentioned in no user-facing 
documentation.

> +    - Linux 6.13+
> +    - libvirglrenderer (>= 1.1.0, DRM renderer support)
> +  * - virtio-gpu-gl (vDRM native context/Freedreno)
> +    - Linux 6.4+
> +    - libvirglrenderer (>= 1.0.0, DRM renderer support)
> +  * - virtio-gpu-gl (vDRM native context/Intel i915)
> +    - Linux 6.13+
> +    - libvirglrenderer (`mr1384`_, DRM renderer support)
> +  * - virtio-gpu-gl (vDRM native context/Asahi)
> +    - Linux 6.13+
> +    - libvirglrenderer (`mr1274`_, DRM renderer support)
> +
> +.. _mr1384: https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1384
> +.. _mr1274: https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1274
 > +> +.. list-table:: Guest Requirements
> +  :header-rows: 1
> +
> +  * - Mode
> +    - Mesa Version
> +    - Mesa build flags
> +  * - virtio-gpu-gl (OpenGL pass-through)
> +    - 20.3.0+
> +    - -Dgallium-drivers=virgl
> +  * - virtio-gpu-gl (Vulkan pass-through)
> +    - 24.2.0+
> +    - -Dvulkan-drivers=virtio
> +  * - virtio-gpu-gl (vDRM native context/AMD)
> +    - 25.0.0+
> +    - -Dgallium-drivers=radeonsi -Dvulkan-drivers=amd -Damdgpu-virtio=true
> +  * - virtio-gpu-gl (vDRM native context/Freedreno)
> +    - 23.1.0+
> +    - -Dgallium-drivers=freedreno -Dvulkan-drivers=freedreno
> +  * - virtio-gpu-gl (vDRM native context/Intel i915)
> +    - `mr29870`_
> +    - -Dgallium-drivers=iris -Dvulkan-drivers=intel -Dintel-virtio-experimental=true
> +  * - virtio-gpu-gl (vDRM native context/Asahi)
> +    - 24.2.0+
> +    - -Dgallium-drivers=asahi -Dvulkan-drivers=asahi
> +
> +.. _mr29870: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/29870
> +
>   virtio-gpu rutabaga
>   -------------------
>   
> @@ -133,3 +218,23 @@ Surfaceless is the default if ``wsi`` is not specified.
>   .. _Wayland display passthrough: https://www.youtube.com/watch?v=OZJiHMtIQ2M
>   .. _gfxstream-enabled rutabaga: https://crosvm.dev/book/appendix/rutabaga_gfx.html
>   .. _guest Wayland proxy: https://crosvm.dev/book/devices/wayland.html
> +
> +.. list-table:: Host Requirements
> +  :header-rows: 1
> +
> +  * - Mode
> +    - Kernel
> +    - Userspace
> +  * - virtio-gpu-gl (rutabaga/gfxstream)
> +    - GPU enabled
> +    - aemu/rutabaga_gfx_ffi or vhost-user client with support

Let's omit the mention of aemu. It is a dependency of rutabaga_gfx_ffi 
and referring to dependencies of our dependencies will make the 
documentation too cluttered. Users should also see rutabaga_gfx_ffi 
needs aemu anyway in its build guide; the reference of aemu here is 
effectively redundant.

I don't see the vhost-user support in Rutabaga. Does it really exist?

> +
> +.. list-table:: Guest Requirements
> +  :header-rows: 1
> +
> +  * - Mode
> +    - Mesa Version
> +    - Mesa build flags
> +  * - virtio-gpu-gl (rutabaga/gfxstream)
> +    - 24.3.0+
> +    - -Dvulkan-drivers=gfxstream


