Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C40CC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 06:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trWSc-0002cy-Vs; Mon, 10 Mar 2025 02:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1trWSb-0002cM-46
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 02:17:57 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1trWSX-0007GF-Fc
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 02:17:56 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-219f8263ae0so69271195ad.0
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 23:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741587471; x=1742192271;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DLwBe2cjMgHJPEz92iz7ArkMS0Lec2n7/WEuV7kR1dI=;
 b=kYLDVYtGxw+sNCElj6uLGBE2cTZKYX6zeUDYO7QZR/3WPAL7Z0/008HXqr5CDMk8/x
 StjBT51YV7+ht9xZXeDgcNUm0nPvYti0c6381VrUI3YW+A4M9KWQ//OUEmYd1urhma1U
 f+WXcUOFagZq6rQZz+PdbBhlYbc8KRqqP0UNTya1MPTo+rNX6z8PqVje84cF2+xYSCNX
 uEl8kSkvzziFt7f81VTXYTo3Y2c8Ak3c1lNGNMsWD51yCn0zydymt6WlU/srUJmjeXc5
 dBRsgcCPCrihJUdTLBylCFYoctWivbypKX8ub6KSgmJ3dVXL1NhHKYQfKbesJM+Tnsxk
 vUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741587471; x=1742192271;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DLwBe2cjMgHJPEz92iz7ArkMS0Lec2n7/WEuV7kR1dI=;
 b=taQWcMwVmNVcye7VqGH8JsusV/p5wF7d7tnabXCkwcJinchgyT3oVgT6aq4U/tYi7M
 hkE2EKtfc79QaEmf41qiafEZ81IUMtR5pd8FObV5pkQUwoZHBUfkVPNn7L0+wFaxzcHk
 J/flm3zYZsQvrjjssJHrj2pb8gZOFQr/B6hF30kCk0otJe4Sup/hmbae9wrRRKG4XsuQ
 l/KuIhRgYe0iflpQjGK44ikQJquRhj9eS9tEr8m9sE/FXEL6g3dC4mz+cm80qDdULKd8
 puREnk9cEDyBafIYO7Fb6DWPMGTIthlM5sY5uR2SFt7p697ZGMFSHlPu0axYicgjukZ3
 Zj1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjBfg/RwYS9C5rFyjf2c0KTzIzN+kCyGezPnfGbXVEFtxZTN2/9Jb+Tz5r1MXB4ebrbWSQayX4rrFj@nongnu.org
X-Gm-Message-State: AOJu0YxFDDqcBPmeOs92I5xvT83ne/uKqsfCM0NsAbo295UQ8TILk7Vj
 mI02m67MDDxrqKAYQiABIZc0q+hFEe90I4kCI8C6sfu3yfYeGQjhthiHve0lx3I=
X-Gm-Gg: ASbGncvTu1F4Ux/5gRSi0CL/p3HuUVPCTOSRWIdRiFvmV3oh3e8EKWQXSnJRO7tto43
 kLcdDS99EyiEBsMplSSiWAleIb5uCeNvqoGmYMG5EX1ZcWz2kinED41wfg1Ukkx3epjTHySQOqV
 6LAswxph6w5HtSgRTnhp0x9N+FrMH5JhjLiUWV4BC+lB4MJ01p7LnlAhhAJsPg0gNgLfvU3GTlX
 Y855jOaFC6WIg7DLCMCHiSk/KBREG6zhc+h7r/yg9cncFDsuU3zb5QcC6OxiUATiMXqwv2ynt1O
 i5YGyddqo/7QJ50Kh4/UMuUQ5OvKw+zqWef+rQF2xKkZfIGOt/sOf7nEcQ==
X-Google-Smtp-Source: AGHT+IE60Atd89jsnJwFyH27jYg29WCHbrxurqvw5DSbvgOreQB0wUJMGWz9XYuNjuQn0mkNGsEOVA==
X-Received: by 2002:a05:6a00:2351:b0:736:4644:86e6 with SMTP id
 d2e1a72fcca58-736aa9fdb77mr17903127b3a.12.1741587470807; 
 Sun, 09 Mar 2025 23:17:50 -0700 (PDT)
Received: from [157.82.205.237] ([157.82.205.237])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736b064ae4dsm5450730b3a.23.2025.03.09.23.17.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 23:17:50 -0700 (PDT)
Message-ID: <45c80b4a-530a-4ded-976e-26628556c119@daynix.com>
Date: Mon, 10 Mar 2025 15:17:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/10] docs/system: virtio-gpu: Document host/guest
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
References: <20250309230539.125374-1-dmitry.osipenko@collabora.com>
 <20250309230539.125374-11-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250309230539.125374-11-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
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

On 2025/03/10 8:05, Dmitry Osipenko wrote:
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
>   docs/system/devices/virtio-gpu.rst | 90 +++++++++++++++++++++++++++++-
>   1 file changed, 87 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/system/devices/virtio-gpu.rst b/docs/system/devices/virtio-gpu.rst
> index ea3eb052df3c..88c7b6011711 100644
> --- a/docs/system/devices/virtio-gpu.rst
> +++ b/docs/system/devices/virtio-gpu.rst
> @@ -5,14 +5,28 @@ virtio-gpu
>   ==========
>   
>   This document explains the setup and usage of the virtio-gpu device.
> -The virtio-gpu device paravirtualizes the GPU and display controller.
> +The virtio-gpu device provides a GPU and display controller
> +paravirtualized using VirtIO. It supports a number of different modes
> +from simple 2D displays to fully accelerated 3D graphics.
>   
> -Linux kernel support
> ---------------------
> +Linux guest kernel support
> +--------------------------
>   
>   virtio-gpu requires a guest Linux kernel built with the
>   ``CONFIG_DRM_VIRTIO_GPU`` option.
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
> +memory with the guest. Details of 3D acceleration requirements are
> +described in a further sections.
> +
>   QEMU virtio-gpu variants
>   ------------------------
>   
> @@ -65,8 +79,14 @@ intermediate representation is communicated to the host and the
>   `virglrenderer`_ library on the host translates the intermediate
>   representation back to OpenGL API calls.
>   
> +By default OpenGL version on guest is limited to 4.3. In order to enable
> +OpenGL 4.6 support, virtio-gpu  host blobs feature (``hostmem`` and ``blob``
> +fields) should be enabled.  The ``hostmem`` field specifies the size of
> +virtio-gpu host memory window. This is typically between 256M and 8G.
> +
>   .. parsed-literal::
>       -device virtio-gpu-gl
> +    -device virtio-gpu-gl,hostmem=8G,blob=true
>   
>   .. _virgl: https://docs.mesa3d.org/drivers/virgl.html
>   .. _Gallium3D: https://www.freedesktop.org/wiki/Software/gallium/
> @@ -94,6 +114,52 @@ of virtio-gpu host memory window. This is typically between 256M and 8G.
>   
>   .. _drm: https://gitlab.freedesktop.org/virgl/virglrenderer/-/tree/main/src/drm
>   
> +.. list-table:: Linux Host Requirements
> +  :header-rows: 1
> +
> +  * - Capability
> +    - Kernel Version
> +  * - OpenGL pass-through
> +    - Any Linux version compatible with QEMU if not using host blobs feature,
> +      Linux 6.13+ otherwise
> +  * - Vulkan pass-through
> +    - Linux 6.13+
> +  * - AMDGPU DRM native context
> +    - Linux 6.13+
> +  * - Freedreno DRM native context
> +    - Linux 6.4+
> +  * - Intel i915 DRM native context
> +    - Linux 6.13+
> +  * - Asahi DRM native context
> +    - Downstream version of Asahi Linux kernel

Having a link for Asahi like one for i915 DRM native context merge 
request would be nice.

> +
> +.. list-table:: Linux Guest Requirements
> +  :header-rows: 1
> +
> +  * - Capability
> +    - Kernel Version
> +    - Mesa Version
> +  * - OpenGL pass-through
> +    - Any Linux version supporting virtio-gpu
> +    - 16.0.0+
> +  * - Vulkan pass-through
> +    - Linux 5.16+
> +    - 24.2.0+
> +  * - AMDGPU DRM native context
> +    - Linux 6.14+
> +    - 25.0.0+
> +  * - Freedreno DRM native context
> +    - Linux 6.14+
> +    - 23.1.0+
> +  * - Intel i915 DRM native context
> +    - Linux 6.14+
> +    - `mr29870`_
> +  * - Asahi DRM native context
> +    - Linux 6.14+
> +    - 24.2.0+
> +
> +.. _mr29870: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/29870
> +
>   virtio-gpu rutabaga
>   -------------------
>   
> @@ -133,3 +199,21 @@ Surfaceless is the default if ``wsi`` is not specified.
>   .. _Wayland display passthrough: https://www.youtube.com/watch?v=OZJiHMtIQ2M
>   .. _gfxstream-enabled rutabaga: https://crosvm.dev/book/appendix/rutabaga_gfx.html
>   .. _guest Wayland proxy: https://crosvm.dev/book/devices/wayland.html
> +
> +.. list-table:: Linux Host Requirements
> +  :header-rows: 1
> +
> +  * - Capability
> +    - Kernel version
> +  * - Vulkan+Wayland pass-through
> +    - Linux 6.13+
> +
> +.. list-table:: Linux Guest Requirements
> +  :header-rows: 1
> +
> +  * - Capability
> +    - Kernel Version
> +    - Mesa Version
> +  * - Vulkan pass-through

The "Linux Host Requirements" refers to "Vulkan+Wayland pass-through" 
but this table refers to "Vulkan pass-through". Please make them consistent.

Regards,
Akihiko Odaki

> +    - Linux 5.16+
> +    - 24.3.0+



