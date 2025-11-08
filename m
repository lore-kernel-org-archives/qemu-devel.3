Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB60CCFA13
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Nov 2025 12:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHhdy-0004dm-Re; Sat, 08 Nov 2025 07:02:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zzyiwei@gmail.com>) id 1vHhdu-0004Vk-6W
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 07:02:06 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zzyiwei@gmail.com>) id 1vHhds-0003py-7X
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 07:02:05 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b729f239b39so343997666b.0
 for <qemu-devel@nongnu.org>; Sat, 08 Nov 2025 04:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762603322; x=1763208122; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RnUoao9IgjecDnyXzzfTSTWx4M44P8XsUBh6mRJWBsU=;
 b=eHkxd/zu1te6Ws/xI2xXoyJuquz9sx5jEYDSbfCi0Hxbgqe/c44aXG85hzJCUG6hXR
 2QPkcTu94vtV9rLwny3XfYGRVjUNym5yKlUjfjfI3MQFG0pEyZTRODJBAhnh4Y7oheB8
 463lJ5BlqzBactOzLeIUABKBAaFsUcn0gfLbNY+Dv/2OdSTvgM7WvodoTR5j16E18NdJ
 6quJPNSaAVFQua0TYZsvhC/gEmHDaQFfItIkA2M2lYOjJqajV8Df9JCogFZq5ffksoRS
 L34olwjZiIFdnuWBTSOHQXFKG8rYrOc2QYPEFa/f3W+5r9mRa2be7/YcdrD+s4mUhJzN
 UcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762603322; x=1763208122;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RnUoao9IgjecDnyXzzfTSTWx4M44P8XsUBh6mRJWBsU=;
 b=lt14bjaQj9bubvBOF27TWt+AUn3/8RCgWKN0UnwDMfj6KV7wImf+aEWF2FjBJ09tHc
 b4L+1EGW0eQ3uKCC4uaTvnxZYInPZ1LeiyXUugONcUdNmJa/7oGXY6CImSPWummm99/m
 1LLPFAzMkS5SX358KC6gF7RyE5hcEUnMWcOtfu+xjF8zpH387xsis7n/QJR5fkL78fWh
 pqjm5g2nph4fbD2cvfS4B6WsW6nWSFJtCbPsHbbZosk14my+ETu6JmZ2OYzWAjk3/SxA
 CHBunmOD0yVXTCmC61jpxUUZ0ZmzMybdNJI+ZYJDWqnfo+fhfcsftRt71eSL7sA0YbcF
 7zOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA5Jw84cu6+bvvIPjBHTeYrmHQjpZFj30RUCKX7iQ49WcX8/Pc5FZyLQpzuzz9VphgPWeqpFmM5QMB@nongnu.org
X-Gm-Message-State: AOJu0YyXSPNQIIpVCDC/dtESOx2ACIATUjWJ4SDeKmdS4eD8bVhBVpH9
 dnyBwLuysMOKILZsHYBjjQgBERS/tfnDtKSYV7Afl0VkIotNAgYC6FI2fNyfy0MWDRay7Fwossh
 uPsMh1aJepw3QOIIGzprIpM6Jy4PAYdA=
X-Gm-Gg: ASbGncu2s5mEIEpdTQJz1QIZSa016Omw+YccENSsbrfv69ksrctOK7EjR27pQ7of8s+
 kZS2brk2J0tTmt6Qb0DHH5HirLWGASHujz//85Yjo8u7hGr+rrlK1nYtJJjxVkXCLA2YovHJ6Wq
 TpAfhF/2AaWTtgR8RjCjYgIRP0XWoTjEDYsPIRBLtxtCiV6c4wHYdmSj/xsoc+wQ3GPk0zkpNZi
 F3chm0ZPPRwNdfLBT4UIJromXwNXqemOeBdabSqGo1VHTrwvRIc34Ap1dTLdoS/dzA+s/EdpoTq
 KQovQQRRFJPs/q8EbQ==
X-Google-Smtp-Source: AGHT+IFWhjZ/piVD0pSM1oecV7f4oX5ZTCqi8gyp6hk9AJthlDbI/FzSemDFXoChurgIcjwaZlywnY5raCsEooS317s=
X-Received: by 2002:a17:907:c398:b0:b72:e158:8218 with SMTP id
 a640c23a62f3a-b72e15887fcmr203411566b.22.1762603321974; Sat, 08 Nov 2025
 04:02:01 -0800 (PST)
MIME-Version: 1.0
References: <20251020233949.506088-1-dmitry.osipenko@collabora.com>
 <20251020233949.506088-11-dmitry.osipenko@collabora.com>
In-Reply-To: <20251020233949.506088-11-dmitry.osipenko@collabora.com>
From: Yiwei Zhang <zzyiwei@gmail.com>
Date: Sat, 8 Nov 2025 04:02:07 -0800
X-Gm-Features: AWmQ_bn-qiiF2VAWhLXTw_KTgyXYMPVraebCGpX6RGmtWW4j1st88c81dcsVWNk
Message-ID: <CAJ+hS_jDtCvQafT41FtvtdSuSwP7dsyUa5xURhLxa=MkrdaGAg@mail.gmail.com>
Subject: Re: [PATCH v14 10/10] docs/system: virtio-gpu: Document host/guest
 requirements
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Huang Rui <ray.huang@amd.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Gert Wollny <gert.wollny@collabora.com>,
 qemu-devel@nongnu.org, 
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>, 
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, 
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>, 
 Rob Clark <robdclark@gmail.com>, Sergio Lopez Pascual <slp@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=zzyiwei@gmail.com; helo=mail-ej1-x633.google.com
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

On Mon, Oct 20, 2025 at 4:43=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> This attempts to tidy up the VirtIO GPU documentation to make the list
> of requirements clearer. There are still a lot of moving parts and the
> distros have some catching up to do before this is all handled
> automatically.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Sergio Lopez Pascual <slp@redhat.com>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> [dmitry.osipenko@collabora.com: Extended and corrected doc]
> ---
>  docs/system/devices/virtio-gpu.rst | 100 ++++++++++++++++++++++++++++-
>  1 file changed, 97 insertions(+), 3 deletions(-)
>
> diff --git a/docs/system/devices/virtio-gpu.rst b/docs/system/devices/vir=
tio-gpu.rst
> index ea3eb052df3c..3324a697013f 100644
> --- a/docs/system/devices/virtio-gpu.rst
> +++ b/docs/system/devices/virtio-gpu.rst
> @@ -5,14 +5,28 @@ virtio-gpu
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  This document explains the setup and usage of the virtio-gpu device.
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
>  virtio-gpu requires a guest Linux kernel built with the
>  ``CONFIG_DRM_VIRTIO_GPU`` option.
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
>  QEMU virtio-gpu variants
>  ------------------------
>
> @@ -65,8 +79,14 @@ intermediate representation is communicated to the hos=
t and the
>  `virglrenderer`_ library on the host translates the intermediate
>  representation back to OpenGL API calls.
>
> +By default OpenGL version on guest is limited to 4.3. In order to enable
> +OpenGL 4.6 support, virtio-gpu  host blobs feature (``hostmem`` and ``bl=
ob``
> +fields) should be enabled.  The ``hostmem`` field specifies the size of
> +virtio-gpu host memory window. This is typically between 256M and 8G.
> +
>  .. parsed-literal::
>      -device virtio-gpu-gl
> +    -device virtio-gpu-gl,hostmem=3D8G,blob=3Dtrue
>
>  .. _virgl: https://docs.mesa3d.org/drivers/virgl.html
>  .. _Gallium3D: https://www.freedesktop.org/wiki/Software/gallium/
> @@ -94,6 +114,62 @@ of virtio-gpu host memory window. This is typically b=
etween 256M and 8G.
>
>  .. _drm: https://gitlab.freedesktop.org/virgl/virglrenderer/-/tree/main/=
src/drm
>
> +.. list-table:: Linux Host Requirements
> +  :header-rows: 1
> +
> +  * - Capability
> +    - Kernel Version
> +    - Libvirglrenderer Version
> +  * - OpenGL pass-through
> +    - Any Linux version compatible with QEMU if not using host blobs fea=
ture,
> +      Linux 6.13+ otherwise
> +    - 0.8.2+
> +  * - Vulkan pass-through
> +    - Linux 6.13+
> +    - 1.0.0+
> +  * - AMDGPU DRM native context
> +    - Linux 6.13+
> +    - 1.1.0+
> +  * - Freedreno DRM native context
> +    - Linux 6.4+
> +    - 1.0.0+
> +  * - Intel i915 DRM native context
> +    - Linux 6.13+
> +    - `mr1384`_
> +  * - Asahi DRM native context
> +    - `Downstream version`_ of Asahi Linux kernel
> +    - 1.2.0+
> +
> +.. _mr1384: https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_r=
equests/1384
> +.. _Downstream version: https://github.com/AsahiLinux/linux
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
> +.. _mr29870: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/2=
9870
> +
>  virtio-gpu rutabaga
>  -------------------
>
> @@ -133,3 +209,21 @@ Surfaceless is the default if ``wsi`` is not specifi=
ed.
>  .. _Wayland display passthrough: https://www.youtube.com/watch?v=3DOZJiH=
MtIQ2M
>  .. _gfxstream-enabled rutabaga: https://crosvm.dev/book/appendix/rutabag=
a_gfx.html
>  .. _guest Wayland proxy: https://crosvm.dev/book/devices/wayland.html
> +
> +.. list-table:: Linux Host Requirements
> +  :header-rows: 1
> +
> +  * - Capability
> +    - Kernel Version
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
> --
> 2.51.0
>

Reviewed-by: Yiwei Zhang <zzyiwei@gmail.com>

