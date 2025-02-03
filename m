Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5412FC02193
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 06:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tepZv-0007ny-WE; Mon, 03 Feb 2025 01:05:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tepZt-0007nl-Vf
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 01:05:01 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tepZr-0001T0-3E
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 01:05:01 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21619108a6bso65019275ad.3
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2025 22:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738562697; x=1739167497;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oXv00d3LkUH8rQAyy8gYfVqFLi2/tU9IZtHYRvOTy/k=;
 b=B1Hjs96NjzAkUxSwFTmT+JMUQuezX5pImbAKqSY1dDSlK119twRi7X+DPcFMH7VAEZ
 TYXyxFFTQ5DYSmr7qv2VJJXfr7BWA++FcfKJh+0csVttOic/dvwSHPyoyIuHMUCggBTL
 Jd/iZIET91pADbQupPhnUQUgWhkWHRvwirBr8hF15YJaaYpUut/Ywi350+KBqficorkP
 hz3lJeo+eSJ+eE6LFLHEzVpXgeMFWavoO+QaHt4Y4PH8k0EvFusAVBWk/y3+9LKvaa3N
 hMESAFdFCfp20Ikrjx83t/u3jZWLCAd2+i39tgPZgHI5sTf7uVsaG7F/Ko9fqyT8UZ7R
 1itQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738562697; x=1739167497;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oXv00d3LkUH8rQAyy8gYfVqFLi2/tU9IZtHYRvOTy/k=;
 b=ttddTtALIFni1Qin5RHfJMCSvS1zaO5jsO4L/T8TA5JTxYF1vE5UTya5d/fM/e2/0Q
 pFEQPHQ3ochyp7RPfKTscD5FUHV9IVsPNuQjPrSaTFGwbBnKOPVs51sFxMsUfD3YYz7L
 XPBTetmvqgtE7ja1L/9XpM3R6LEYiHUOVOlyvFTt4wwmykyvW78Yb2shHJuog1mS4OvB
 OmmlgoJAqUR1KH6dgIgonwlAQTMhtgnJUnYvCh6ld6DRibYn2e8C0QPKIvM4T+gM5thC
 pcI3cXYqC5XIQIpFU87OtRurzAz6ZyBcfgGjJNsmCKSJ9L6ox1pdS232xrQVOuF9DIJB
 Eo+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB2o6PnazJRS1w+UuOba4aJ3MQ8DZLONAONV0CAM0a6f6vTCRNxuSD26CPsk3RA/XO3Gj3QPscQ1Bt@nongnu.org
X-Gm-Message-State: AOJu0Yxejgd5kgMh6LFvUwCBNY/cEFYyZC9PqpsOghwq6RnG4wPibYFY
 HEP8uNY5PhokgLhW5EUhHiHFyKv5L+iAQ9j2LIR0RoqAUfl32CdTPM6nkSUfPqk=
X-Gm-Gg: ASbGncvmMV2KB5/dMUjIP7EqmS3zIAymoNGzXSt6U9ExLDqTEEqrht1CPZRUmU80mI9
 QEu0Lm0k6V1dkvGOltsw1GBmcjO303xY3k8JRggN0pi7gHp6INWMuEkLgBwsRySwJrc+PXYKiHh
 MWqFXeuLvEhNqpj+0fevmozvTka1FyW46Tl2Wu0Tmeg2tC9KxZn6m8Ow/TzTq8JsNFMwwyEu4bs
 vT5GG+ORp8DWekrLSRRI5SBtNwfWjRZDYhzwoSFkRuIZWwG3ar3EFEsnfEzlAiTvRjWqd1q51Rl
 JudVeqXnpejHcAAsnH72Ex1GcnLU
X-Google-Smtp-Source: AGHT+IHTRhZ5ogu9jW2G4yh0ewRb9cnXfBuLpTWp79T2N0fYkGqx/niISCXWNdKU0rlvj/AC7tPXaA==
X-Received: by 2002:a05:6a20:9e46:b0:1e0:c56f:7db4 with SMTP id
 adf61e73a8af0-1ed7a49a2a4mr37092205637.2.1738562697190; 
 Sun, 02 Feb 2025 22:04:57 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe653a9f3sm7527305b3a.75.2025.02.02.22.04.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Feb 2025 22:04:56 -0800 (PST)
Message-ID: <2ecfebe3-43a3-4d47-9873-41a8fadf5dcf@daynix.com>
Date: Mon, 3 Feb 2025 15:04:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/10] docs/system: virtio-gpu: Document host/guest
 requirements
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
References: <20250202232136.919342-1-dmitry.osipenko@collabora.com>
 <20250202232136.919342-11-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250202232136.919342-11-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/02/03 8:21, Dmitry Osipenko wrote:
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
>   docs/system/devices/virtio-gpu.rst | 92 +++++++++++++++++++++++++++++-
>   1 file changed, 91 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/system/devices/virtio-gpu.rst b/docs/system/devices/virtio-gpu.rst
> index ea3eb052df3c..56950a76aa2e 100644
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
> @@ -56,6 +58,17 @@ on typical modern Linux distributions.
>   .. _Mesa: https://www.mesa3d.org/
>   .. _SwiftShader: https://github.com/google/swiftshader
>   
> +3D acceleration
> +---------------
> +
> +3D acceleration of a virtualized GPU is still an evolving field.
> +Depending on the 3D mode you are running you may need to override
> +distribution supplied libraries with more recent versions or enable
> +build options. There are a number of requirements the host must meet
> +to be able to be able to support guests. QEMU must be able to access the
> +host's GPU and for the best performance be able to reliably share GPU
> +memory with the guest.
> +

What about having a bigger section for "host requirements" that includes 
the "Linux kernel support" and "3D acceleration" section?

Also it's better to note that the details of 3D acceleration 
requirements are described later as this section only contains an 
abstract description.

>   virtio-gpu virglrenderer
>   ------------------------
>   
> @@ -94,6 +107,61 @@ of virtio-gpu host memory window. This is typically between 256M and 8G.
>   
>   .. _drm: https://gitlab.freedesktop.org/virgl/virglrenderer/-/tree/main/src/drm
>   
> +.. list-table:: Linux Host Requirements
> +  :header-rows: 1
> +
> +  * - Mode

"Mode" is not a word used elsewhere. Perhaps you may call it "capability".

> +    - Kernel
> +    - libvirglrenderer build flags

Just "virglrenderer" for consistency.

> +  * - OpenGL pass-through
> +    - Linux any stable version
QEMU's support policy is different from Linux's own idea of stable 
releases. Perhaps you may refer to any Linux version compatible with QEMU.

> +    - N/A
> +  * - Vulkan pass-through
> +    - Linux 6.13+
> +    - -Dvenus=true -Drender-server=true
> +  * - AMDGPU DRM native context
> +    - Linux 6.13+
> +    - -Ddrm-renderers=amdgpu-experimental
> +  * - Freedreno DRM native context
> +    - Linux 6.4+
> +    - -Ddrm-renderers=msm
> +  * - Intel i915 DRM native context
> +    - Linux 6.13+
> +    - -Ddrm-renderers=i915-experimental `mr1384`_
> +  * - Asahi DRM native context
> +    - Linux 6.13+

Asahi does not need patches for virglrenderer but requires patches for 
the kernel too as the upstream kernel doesn't have the GPU support at all.

> +    - -Ddrm-renderers=asahi-experimental `mr1274`_
> +
> +.. _mr1384: https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1384
> +.. _mr1274: https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1274
> +
> +.. list-table:: Linux Guest Requirements
> +  :header-rows: 1
> +
> +  * - Mode
> +    - Mesa Version
> +    - Mesa build flags
> +  * - OpenGL pass-through
> +    - 16.0.0+
> +    - -Dgallium-drivers=virgl
> +  * - Vulkan pass-through
> +    - 24.2.0+
> +    - -Dvulkan-drivers=virtio
> +  * - AMDGPU DRM native context
> +    - 25.0.0+
> +    - -Dgallium-drivers=radeonsi -Dvulkan-drivers=amd -Damdgpu-virtio=true
> +  * - Freedreno DRM native context
> +    - 23.1.0+
> +    - -Dgallium-drivers=freedreno -Dvulkan-drivers=freedreno
> +  * - Intel i915 DRM native context
> +    - `mr29870`_
> +    - -Dgallium-drivers=iris -Dvulkan-drivers=intel -Dintel-virtio-experimental=true
> +  * - Asahi DRM native context
> +    - 24.2.0+
> +    - -Dgallium-drivers=asahi -Dvulkan-drivers=asahi
> +
> +.. _mr29870: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/29870
> +
>   virtio-gpu rutabaga
>   -------------------
>   
> @@ -133,3 +201,25 @@ Surfaceless is the default if ``wsi`` is not specified.
>   .. _Wayland display passthrough: https://www.youtube.com/watch?v=OZJiHMtIQ2M
>   .. _gfxstream-enabled rutabaga: https://crosvm.dev/book/appendix/rutabaga_gfx.html
>   .. _guest Wayland proxy: https://crosvm.dev/book/devices/wayland.html
> +
> +.. list-table:: Linux Host Requirements
> +  :header-rows: 1
> +
> +  * - Mode
> +    - Kernel
> +    - Userspace
> +  * - rutabaga-gfxstream

This notation is not consistent with the table for virglrenderer.
Following the description of capsets will allow creating a consistent table.

> +    - Linux 6.13+
> +    - rutabaga_gfx_ffi or vhost-user client with `gfxstream support`_

rutabaga_gfx_ffi is a crate name but not mentioned in other 
documentations. This page already contains a link to
https://crosvm.dev/book/appendix/rutabaga_gfx.html so let's make it 
consistent with it.

vhost-user is irrelevant with virtio-gpu-rutabaga. Also note that QEMU 
has its own vhost-user-gpu implementation that doesn't use Rutabaga in 
contrib/vhost-user-gpu.

Regards,
Akihiko Odaki

> +
> +.. _gfxstream support: https://github.com/rust-vmm/vhost-device/tree/main/staging/vhost-device-gpu
> +
> +.. list-table:: Linux Guest Requirements
> +  :header-rows: 1
> +
> +  * - Mode
> +    - Mesa Version
> +    - Mesa build flags
> +  * - rutabaga-gfxstream
> +    - 24.3.0+
> +    - -Dvulkan-drivers=gfxstream


