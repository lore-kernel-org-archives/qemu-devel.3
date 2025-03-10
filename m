Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08CBC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 11:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trbPy-000805-R8; Mon, 10 Mar 2025 07:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1trbPm-0007zQ-Vd
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 07:35:25 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1trbPh-0004co-Gk
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 07:35:22 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22435603572so34750615ad.1
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 04:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741606515; x=1742211315;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ced6n2/LzD+Ijtn2EfIbdCDjELxL6y+VL5qpvPAwWqw=;
 b=uqY1DA8CClM81k6h30soxowu3NVa/V4nSYYIpCqixOgDT60qMn6319e1mhwCXHZSFG
 4No9zF5UtjZ1+v/S4anmBkc2dcqVG2ypArfbLo+N9x6XuxGvATHEpOC5E5WeSP5LYNou
 Wm7BCd21UQJ1x6H0nKD9ft2yiOpxF0OrHDXJEo4Ym8DWKoFi9exlymI1gp5RFASqnSnW
 ZskLgoeOkpX/CM2IahP5l6XDvAZ3Xkvcd0A9ZyXoZ8yvdIddGWoYThiDXtv/z7KggwZh
 zhsk6xR03Ewx9uwI8SBf2zoe2ck3j0J0v7TyrSDSYj8M56oUtQHnIGw6ySh00TbyEcTn
 B6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741606515; x=1742211315;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ced6n2/LzD+Ijtn2EfIbdCDjELxL6y+VL5qpvPAwWqw=;
 b=Gok7TrBbSMDagnZ9tY4dJriairhukLNB00u/M/UudjQtUF4zFSg4iUQmXQta9RN8cb
 9ImDfw2vnDK+Htjb5bEDYwz5HLuLXJKjWTFNCo7/AQQagW0P1qAQn2J6o33zJF9rkpMs
 FSVSRUp87WsYGRsrknL6I9IUibmwVblWmOuYyx78g3ARCLk/yWu1MNIVPeBJHv+XiXWz
 uK+axtMAQyK3Aqk//QnCychqwDEz3FJ3nPXlAbT8ARdb4Iug3YXFbSq3yCaWL/mN1rE3
 G3qqLHGMPAL0BIwgW2jGO3XSIIRAT+pafXsPtUCPguyqP6g0sG1qdzcEDS7bqx7yIFYf
 caTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhVch6U8FS66fBzh9sKis3pS2H9LbvQJiMXlnG6tWg5H0169x3rK7REaqSIu2tQtChWnCOEsMOB/IA@nongnu.org
X-Gm-Message-State: AOJu0YzTnejMSW6lAUPddNcQyiYwAjl07fJhwiOzCKyz3nYevWVcrYXG
 3lXCH8xE4FzY8DuOLviiJwiLhCg1alXvSi98VBI2Wc1yORMhJADJPkVWzpXZWSk=
X-Gm-Gg: ASbGnctkVF1SGPEC+dfkZNNS+OyIB4xcG8j93KvBxx0rfwU7Au5f4lkQfTztjtcwJCB
 qbzcicBnaTI4wblKf5nHQfn/ZPe5PV68L52JjKV1jDPmerkRWDXnGO513szOVn8FLWz8Dwy6yVn
 DAdBOURyTgAufDnD0IRRYiKyfO3iqxUi38D9LcccI9hm2q0FYfxb4c8lhYmtNDsyi/r9WrO37du
 YIfWLgM+qK1ExuTFA7GKlLZKmaymCk5aObJ12geLzFkcfCYYkwJoFAHzlkSjqIncD6DOekoOZ39
 Ggw6yxGa2T3xR9vTxFwvgUgbpWTh2a6vTL62X7OH57j4a3IB5YCi1B0B5g==
X-Google-Smtp-Source: AGHT+IH5zn9SJ4MnDpII9b6/TBzMvDHTQK31soXX1aA4W08G3ocXrCJsCBG1IZjeRWIC+HGN2QY6VA==
X-Received: by 2002:a05:6a00:2d90:b0:736:a694:1a0c with SMTP id
 d2e1a72fcca58-736aab1677bmr21367370b3a.21.1741606515180; 
 Mon, 10 Mar 2025 04:35:15 -0700 (PDT)
Received: from [157.82.205.237] ([157.82.205.237])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736b064ae4dsm6066570b3a.23.2025.03.10.04.35.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 04:35:14 -0700 (PDT)
Message-ID: <d06c83b8-09bd-4e71-a616-a1b771f7ae13@daynix.com>
Date: Mon, 10 Mar 2025 20:35:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 10/10] docs/system: virtio-gpu: Document host/guest
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
References: <20250310111234.145891-1-dmitry.osipenko@collabora.com>
 <20250310111234.145891-11-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250310111234.145891-11-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
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

On 2025/03/10 20:12, Dmitry Osipenko wrote:
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
>   docs/system/devices/virtio-gpu.rst | 94 +++++++++++++++++++++++++++++-
>   1 file changed, 91 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/system/devices/virtio-gpu.rst b/docs/system/devices/virtio-gpu.rst
> index ea3eb052df3c..3e4a1e2c87a0 100644
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
> @@ -94,6 +114,56 @@ of virtio-gpu host memory window. This is typically between 256M and 8G.
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
> +  * - Intel i915 DRM native context `mr1384`_
> +    - Linux 6.13+
> +  * - Asahi DRM native context `mr1274`_
> +    - `Downstream version`_ of Asahi Linux kernel
> +
> +.. _mr1384: https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1384
> +.. _mr1274: https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1274

These links to virglrenderer merge requests are nice additions. It's 
better to have a column for virglrenderer like the "Mesa Version" column 
in the "Linux Guest Requirements" table.

 > +.. _Downstream version: https://gitlab.freedesktop.org/asahi/linux

I think you want to refer to: https://github.com/AsahiLinux/linux
The linked repository of Asahi says it had a last update a year ago.
The repository on GitHub is updated 4 days ago so it's newer.

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
> @@ -133,3 +203,21 @@ Surfaceless is the default if ``wsi`` is not specified.
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
> +  * - Vulkan+Wayland pass-through
> +    - Linux 5.16+
> +    - 24.3.0+


