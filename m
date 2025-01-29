Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C55CC0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcwjj-0002Zj-Hn; Tue, 28 Jan 2025 20:19:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1tcwji-0002ZU-3k
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:19:22 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1tcwje-0008Iy-R7
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:19:21 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ab69bba49e2so491485366b.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738113555; x=1738718355; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OXzl11jdf7H0MIwJZNsW0QLxixEbbk2wIsam+LD7w8A=;
 b=jsfez8ncHbXp5agxIkq41htC3/+5bmuC0EuPggtTN4JiqHL3gEOAgd18+skNsJyfSR
 j3jfWI5dH0Uuh/Ncjbe7o7aysl3TI6/pPs/9fcCiBLjMhvGtOXet+JgkJgannu8j92Vb
 hPH4CiV4ONBcNXJT2vSidZcWUCMjYiomh6NEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738113555; x=1738718355;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OXzl11jdf7H0MIwJZNsW0QLxixEbbk2wIsam+LD7w8A=;
 b=Ci2e02equ0oZ0wjC/mNibTS+fGXmhQk8E/54Trl/iZjrWrgPaJVSUU7SgY/Dev0g86
 7VI2mHoBx4tIf5MrlvOf6pEzm/4jdRnmoNpBGQyhTjlVhueUyv4WjFhXBZr4YjufmwvH
 Od6CNQryhUGFHHBBDk+T9BA9rMTxXAYOkdUoTvSL3dyDbNhthLL1nxbgu+9gSz4jZxPw
 gRHnxRidyHplqKD3jNJVY5OCxE1ItEm6ciiumCuolY6QuYOCcWyIl8Iv+VDXt10CT6PR
 S6AW5agp5I0i2gEDj+PDoSwALNliYNpV89JUs1cxzqSXvgPnAzke10gHCJy0OHUSJWbz
 VWMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRpEFJ7qgMjXu75IG9dhCWec4EqP17pnlK1fjsY/mP5M3lzHNMtzJC8gKCMJQSPYFjbdP75aHNjJnu@nongnu.org
X-Gm-Message-State: AOJu0Yw3lfVdWghOAbG9JnhGTU2aX3iMjbGOHjcDqDli21w9YrmWJWhq
 9gLQNdkkxff/+uy2HYd7m3MkgFtoo8bUYGc+J4UTX8JWmMxYxY2Y38QuMXSxQv1sWJzwPUCAVEg
 =
X-Gm-Gg: ASbGncu7Ct0auq8lioFeUtl++zbgkik8RWB1WPjQVte2FFRez3AnehHuXwlzZxHihjV
 yy2/gRJwnwPVvezcSItxpQhi3uZvtOc3YGXh/dWNGBc6bIabH5PfJWx+R4hmQNFfnI+abK5uX4s
 lQX0OpixeapayTIJFGO294xv5uYvWmxHnztadOWDWJdWTCdlgtC3FRy2gpzjhxnrPQFxe6ouAIy
 n5jiezUQ0D69ABuVX7nahnIY1BQurDvhUOixutrARF+bSi4aSDWslXzmL/2zVOd+JTlhHJhqEaX
 sqMjjs0mlhFKcwWATkxzoW0frQ7yNqUeknuoaes+VOPbgHYb/Ndf8aa7dX2rdNs=
X-Google-Smtp-Source: AGHT+IHaXpveL5vrNU4D7YV0bbP1/QtPO8z3as3DiQ8SO2knElhyVQwmj2y/b0I2yG/hmiMdeL3OoQ==
X-Received: by 2002:a05:6402:524b:b0:5d9:ad1:dafc with SMTP id
 4fb4d7f45d1cf-5dc5efec0c7mr2223784a12.25.1738113554395; 
 Tue, 28 Jan 2025 17:19:14 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com.
 [209.85.208.44]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab675e653d1sm892902066b.68.2025.01.28.17.19.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 17:19:13 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-5dbfc122b82so15018a12.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:19:12 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWh4Dxobh2X5CVb7pjWYYbX19jwEzwINmYppVmjPaZN4ZN5R6WWUxGnAnW5UNqT3O799E/SBHBwcyv6@nongnu.org
X-Received: by 2002:aa7:cf83:0:b0:5d0:eb21:264d with SMTP id
 4fb4d7f45d1cf-5dc609612bamr19178a12.1.1738113552196; Tue, 28 Jan 2025
 17:19:12 -0800 (PST)
MIME-Version: 1.0
References: <20250126201121.470990-1-dmitry.osipenko@collabora.com>
 <20250126201121.470990-11-dmitry.osipenko@collabora.com>
In-Reply-To: <20250126201121.470990-11-dmitry.osipenko@collabora.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Tue, 28 Jan 2025 17:18:59 -0800
X-Gmail-Original-Message-ID: <CAAfnVBmrCSk-TBMD7NnVkHtHf9mECMtmxg=ExZF5WZs1mtmqPg@mail.gmail.com>
X-Gm-Features: AWEUYZn3go74fFln5GkUZWZn8iWNPS6o0iaheLwKher9be5u45tU89UEmGTaCpU
Message-ID: <CAAfnVBmrCSk-TBMD7NnVkHtHf9mECMtmxg=ExZF5WZs1mtmqPg@mail.gmail.com>
Subject: Re: [PATCH v6 10/10] docs/system: virtio-gpu: Document host/guest
 requirements
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org, 
 Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, 
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>, 
 Rob Clark <robdclark@gmail.com>, Yiwei Zhang <zzyiwei@chromium.org>, 
 Sergio Lopez Pascual <slp@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000dc1e0e062cce1813"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=gurchetansingh@chromium.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000dc1e0e062cce1813
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2025 at 12:14=E2=80=AFPM Dmitry Osipenko <
dmitry.osipenko@collabora.com> wrote:

> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> This attempts to tidy up the VirtIO GPU documentation to make the list
> of requirements clearer. There are still a lot of moving parts and the
> distros have some catching up to do before this is all handled
> automatically.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Sergio Lopez Pascual <slp@redhat.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> [dmitry.osipenko@collabora.com: Extended and corrected doc]
> ---
>  docs/system/devices/virtio-gpu.rst | 107 ++++++++++++++++++++++++++++-
>  1 file changed, 106 insertions(+), 1 deletion(-)
>
> diff --git a/docs/system/devices/virtio-gpu.rst
> b/docs/system/devices/virtio-gpu.rst
> index ea3eb052df3c..b3db984ff2d3 100644
> --- a/docs/system/devices/virtio-gpu.rst
> +++ b/docs/system/devices/virtio-gpu.rst
> @@ -5,7 +5,9 @@ virtio-gpu
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  This document explains the setup and usage of the virtio-gpu device.
> -The virtio-gpu device paravirtualizes the GPU and display controller.
> +The virtio-gpu device provides a GPU and display controller
> +paravirtualized using VirtIO. It supports a number of different modes
> +from simple 2D displays to fully accelerated 3D graphics.
>
>  Linux kernel support
>  --------------------
> @@ -13,6 +15,24 @@ Linux kernel support
>  virtio-gpu requires a guest Linux kernel built with the
>  ``CONFIG_DRM_VIRTIO_GPU`` option.
>
> +Dependencies
> +............
> +
> +.. note::
> +  GPU virtualisation is still an evolving field. Depending on the mode
> +  you are running you may need to override distribution supplied
> +  libraries with more recent versions or enable build options.
> +
> +  Depending on the mode there are a number of requirements the host must
> +  meet to be able to be able to support guests. For 3D acceleration QEMU
> +  must be able to access the hosts GPU and for the best performance be
> +  able to reliably share GPU memory with the guest.
> +
> +  Virtio-gpu requires a guest Linux kernel built with the
> +  ``CONFIG_DRM_VIRTIO_GPU`` option. For 3D accelerations you
> +  will need support from guest Mesa configured for whichever encapsulati=
on
> +  you need.
> +
>  QEMU virtio-gpu variants
>  ------------------------
>
> @@ -56,6 +76,16 @@ on typical modern Linux distributions.
>  .. _Mesa: https://www.mesa3d.org/
>  .. _SwiftShader: https://github.com/google/swiftshader
>
> +.. list-table:: Host Requirements
> +  :header-rows: 1
> +
> +  * - Mode
> +    - Kernel
> +    - Userspace
> +  * - virtio-gpu
> +    - Framebuffer enabled
> +    - GTK or SDL display
> +
>  virtio-gpu virglrenderer
>  ------------------------
>
> @@ -94,6 +124,61 @@ of virtio-gpu host memory window. This is typically
> between 256M and 8G.
>
>  .. _drm:
> https://gitlab.freedesktop.org/virgl/virglrenderer/-/tree/main/src/drm
>
> +.. list-table:: Host Requirements
> +  :header-rows: 1
> +
> +  * - Mode
> +    - Kernel
> +    - Userspace
> +  * - virtio-gpu-gl (OpenGL pass-through)
> +    - GPU enabled
> +    - libvirglrenderer (virgl support)
> +  * - virtio-gpu-gl (Vulkan pass-through)
> +    - Linux 6.13+
> +    - libvirglrenderer (>=3D 1.0.0, venus support)
> +  * - virtio-gpu-gl (vDRM native context/AMD)
> +    - Linux 6.13+
> +    - libvirglrenderer (>=3D 1.1.0, DRM renderer support)
> +  * - virtio-gpu-gl (vDRM native context/Freedreno)
> +    - Linux 6.4+
> +    - libvirglrenderer (>=3D 1.0.0, DRM renderer support)
> +  * - virtio-gpu-gl (vDRM native context/Intel i915)
> +    - Linux 6.13+
> +    - libvirglrenderer (`mr1384`_, DRM renderer support)
> +  * - virtio-gpu-gl (vDRM native context/Asahi)
> +    - Linux 6.13+
> +    - libvirglrenderer (`mr1274`_, DRM renderer support)
> +
> +.. _mr1384:
> https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1384
> +.. _mr1274:
> https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1274
> +
> +.. list-table:: Guest Requirements
> +  :header-rows: 1
> +
> +  * - Mode
> +    - Mesa Version
> +    - Mesa build flags
> +  * - virtio-gpu-gl (OpenGL pass-through)
> +    - 20.3.0+
> +    - -Dgallium-drivers=3Dvirgl
> +  * - virtio-gpu-gl (Vulkan pass-through)
> +    - 24.2.0+
> +    - -Dvulkan-drivers=3Dvirtio
> +  * - virtio-gpu-gl (vDRM native context/AMD)
> +    - 25.0.0+
> +    - -Dgallium-drivers=3Dradeonsi -Dvulkan-drivers=3Damd -Damdgpu-virti=
o=3Dtrue
> +  * - virtio-gpu-gl (vDRM native context/Freedreno)
> +    - 23.1.0+
> +    - -Dgallium-drivers=3Dfreedreno -Dvulkan-drivers=3Dfreedreno
> +  * - virtio-gpu-gl (vDRM native context/Intel i915)
> +    - `mr29870`_
> +    - -Dgallium-drivers=3Diris -Dvulkan-drivers=3Dintel
> -Dintel-virtio-experimental=3Dtrue
> +  * - virtio-gpu-gl (vDRM native context/Asahi)
> +    - 24.2.0+
> +    - -Dgallium-drivers=3Dasahi -Dvulkan-drivers=3Dasahi
> +
> +.. _mr29870:
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/29870
> +
>  virtio-gpu rutabaga
>  -------------------
>
> @@ -133,3 +218,23 @@ Surfaceless is the default if ``wsi`` is not
> specified.
>  .. _Wayland display passthrough:
> https://www.youtube.com/watch?v=3DOZJiHMtIQ2M
>  .. _gfxstream-enabled rutabaga:
> https://crosvm.dev/book/appendix/rutabaga_gfx.html
>  .. _guest Wayland proxy: https://crosvm.dev/book/devices/wayland.html
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
> +
> +.. list-table:: Guest Requirements
> +  :header-rows: 1
> +
> +  * - Mode
> +    - Mesa Version
> +    - Mesa build flags
> +  * - virtio-gpu-gl (rutabaga/gfxstream)
>

Shouldn't this be `virtio-gpu-rutabaga` instead of `virtio-gpu-gl`?  If
we're including WiP MRs, can we include Magma too??

https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/33190



> +    - 24.3.0+
> +    - -Dvulkan-drivers=3Dgfxstream
> --
> 2.47.1
>
>

--000000000000dc1e0e062cce1813
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Jan 26,=
 2025 at 12:14=E2=80=AFPM Dmitry Osipenko &lt;<a href=3D"mailto:dmitry.osip=
enko@collabora.com">dmitry.osipenko@collabora.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">From: Alex Benn=C3=A9e &lt=
;<a href=3D"mailto:alex.bennee@linaro.org" target=3D"_blank">alex.bennee@li=
naro.org</a>&gt;<br>
<br>
This attempts to tidy up the VirtIO GPU documentation to make the list<br>
of requirements clearer. There are still a lot of moving parts and the<br>
distros have some catching up to do before this is all handled<br>
automatically.<br>
<br>
Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.or=
g" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
Cc: Sergio Lopez Pascual &lt;<a href=3D"mailto:slp@redhat.com" target=3D"_b=
lank">slp@redhat.com</a>&gt;<br>
Signed-off-by: Dmitry Osipenko &lt;<a href=3D"mailto:dmitry.osipenko@collab=
ora.com" target=3D"_blank">dmitry.osipenko@collabora.com</a>&gt;<br>
[<a href=3D"mailto:dmitry.osipenko@collabora.com" target=3D"_blank">dmitry.=
osipenko@collabora.com</a>: Extended and corrected doc]<br>
---<br>
=C2=A0docs/system/devices/virtio-gpu.rst | 107 ++++++++++++++++++++++++++++=
-<br>
=C2=A01 file changed, 106 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/docs/system/devices/virtio-gpu.rst b/docs/system/devices/virti=
o-gpu.rst<br>
index ea3eb052df3c..b3db984ff2d3 100644<br>
--- a/docs/system/devices/virtio-gpu.rst<br>
+++ b/docs/system/devices/virtio-gpu.rst<br>
@@ -5,7 +5,9 @@ virtio-gpu<br>
=C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
=C2=A0This document explains the setup and usage of the virtio-gpu device.<=
br>
-The virtio-gpu device paravirtualizes the GPU and display controller.<br>
+The virtio-gpu device provides a GPU and display controller<br>
+paravirtualized using VirtIO. It supports a number of different modes<br>
+from simple 2D displays to fully accelerated 3D graphics.<br>
<br>
=C2=A0Linux kernel support<br>
=C2=A0--------------------<br>
@@ -13,6 +15,24 @@ Linux kernel support<br>
=C2=A0virtio-gpu requires a guest Linux kernel built with the<br>
=C2=A0``CONFIG_DRM_VIRTIO_GPU`` option.<br>
<br>
+Dependencies<br>
+............<br>
+<br>
+.. note::<br>
+=C2=A0 GPU virtualisation is still an evolving field. Depending on the mod=
e<br>
+=C2=A0 you are running you may need to override distribution supplied<br>
+=C2=A0 libraries with more recent versions or enable build options.<br>
+<br>
+=C2=A0 Depending on the mode there are a number of requirements the host m=
ust<br>
+=C2=A0 meet to be able to be able to support guests. For 3D acceleration Q=
EMU<br>
+=C2=A0 must be able to access the hosts GPU and for the best performance b=
e<br>
+=C2=A0 able to reliably share GPU memory with the guest.<br>
+<br>
+=C2=A0 Virtio-gpu requires a guest Linux kernel built with the<br>
+=C2=A0 ``CONFIG_DRM_VIRTIO_GPU`` option. For 3D accelerations you<br>
+=C2=A0 will need support from guest Mesa configured for whichever encapsul=
ation<br>
+=C2=A0 you need.<br>
+<br>
=C2=A0QEMU virtio-gpu variants<br>
=C2=A0------------------------<br>
<br>
@@ -56,6 +76,16 @@ on typical modern Linux distributions.<br>
=C2=A0.. _Mesa: <a href=3D"https://www.mesa3d.org/" rel=3D"noreferrer" targ=
et=3D"_blank">https://www.mesa3d.org/</a><br>
=C2=A0.. _SwiftShader: <a href=3D"https://github.com/google/swiftshader" re=
l=3D"noreferrer" target=3D"_blank">https://github.com/google/swiftshader</a=
><br>
<br>
+.. list-table:: Host Requirements<br>
+=C2=A0 :header-rows: 1<br>
+<br>
+=C2=A0 * - Mode<br>
+=C2=A0 =C2=A0 - Kernel<br>
+=C2=A0 =C2=A0 - Userspace<br>
+=C2=A0 * - virtio-gpu<br>
+=C2=A0 =C2=A0 - Framebuffer enabled<br>
+=C2=A0 =C2=A0 - GTK or SDL display<br>
+<br>
=C2=A0virtio-gpu virglrenderer<br>
=C2=A0------------------------<br>
<br>
@@ -94,6 +124,61 @@ of virtio-gpu host memory window. This is typically bet=
ween 256M and 8G.<br>
<br>
=C2=A0.. _drm: <a href=3D"https://gitlab.freedesktop.org/virgl/virglrendere=
r/-/tree/main/src/drm" rel=3D"noreferrer" target=3D"_blank">https://gitlab.=
freedesktop.org/virgl/virglrenderer/-/tree/main/src/drm</a><br>
<br>
+.. list-table:: Host Requirements<br>
+=C2=A0 :header-rows: 1<br>
+<br>
+=C2=A0 * - Mode<br>
+=C2=A0 =C2=A0 - Kernel<br>
+=C2=A0 =C2=A0 - Userspace<br>
+=C2=A0 * - virtio-gpu-gl (OpenGL pass-through)<br>
+=C2=A0 =C2=A0 - GPU enabled<br>
+=C2=A0 =C2=A0 - libvirglrenderer (virgl support)<br>
+=C2=A0 * - virtio-gpu-gl (Vulkan pass-through)<br>
+=C2=A0 =C2=A0 - Linux 6.13+<br>
+=C2=A0 =C2=A0 - libvirglrenderer (&gt;=3D 1.0.0, venus support)<br>
+=C2=A0 * - virtio-gpu-gl (vDRM native context/AMD)<br>
+=C2=A0 =C2=A0 - Linux 6.13+<br>
+=C2=A0 =C2=A0 - libvirglrenderer (&gt;=3D 1.1.0, DRM renderer support)<br>
+=C2=A0 * - virtio-gpu-gl (vDRM native context/Freedreno)<br>
+=C2=A0 =C2=A0 - Linux 6.4+<br>
+=C2=A0 =C2=A0 - libvirglrenderer (&gt;=3D 1.0.0, DRM renderer support)<br>
+=C2=A0 * - virtio-gpu-gl (vDRM native context/Intel i915)<br>
+=C2=A0 =C2=A0 - Linux 6.13+<br>
+=C2=A0 =C2=A0 - libvirglrenderer (`mr1384`_, DRM renderer support)<br>
+=C2=A0 * - virtio-gpu-gl (vDRM native context/Asahi)<br>
+=C2=A0 =C2=A0 - Linux 6.13+<br>
+=C2=A0 =C2=A0 - libvirglrenderer (`mr1274`_, DRM renderer support)<br>
+<br>
+.. _mr1384: <a href=3D"https://gitlab.freedesktop.org/virgl/virglrenderer/=
-/merge_requests/1384" rel=3D"noreferrer" target=3D"_blank">https://gitlab.=
freedesktop.org/virgl/virglrenderer/-/merge_requests/1384</a><br>
+.. _mr1274: <a href=3D"https://gitlab.freedesktop.org/virgl/virglrenderer/=
-/merge_requests/1274" rel=3D"noreferrer" target=3D"_blank">https://gitlab.=
freedesktop.org/virgl/virglrenderer/-/merge_requests/1274</a><br>
+<br>
+.. list-table:: Guest Requirements<br>
+=C2=A0 :header-rows: 1<br>
+<br>
+=C2=A0 * - Mode<br>
+=C2=A0 =C2=A0 - Mesa Version<br>
+=C2=A0 =C2=A0 - Mesa build flags<br>
+=C2=A0 * - virtio-gpu-gl (OpenGL pass-through)<br>
+=C2=A0 =C2=A0 - 20.3.0+<br>
+=C2=A0 =C2=A0 - -Dgallium-drivers=3Dvirgl<br>
+=C2=A0 * - virtio-gpu-gl (Vulkan pass-through)<br>
+=C2=A0 =C2=A0 - 24.2.0+<br>
+=C2=A0 =C2=A0 - -Dvulkan-drivers=3Dvirtio<br>
+=C2=A0 * - virtio-gpu-gl (vDRM native context/AMD)<br>
+=C2=A0 =C2=A0 - 25.0.0+<br>
+=C2=A0 =C2=A0 - -Dgallium-drivers=3Dradeonsi -Dvulkan-drivers=3Damd -Damdg=
pu-virtio=3Dtrue<br>
+=C2=A0 * - virtio-gpu-gl (vDRM native context/Freedreno)<br>
+=C2=A0 =C2=A0 - 23.1.0+<br>
+=C2=A0 =C2=A0 - -Dgallium-drivers=3Dfreedreno -Dvulkan-drivers=3Dfreedreno=
<br>
+=C2=A0 * - virtio-gpu-gl (vDRM native context/Intel i915)<br>
+=C2=A0 =C2=A0 - `mr29870`_<br>
+=C2=A0 =C2=A0 - -Dgallium-drivers=3Diris -Dvulkan-drivers=3Dintel -Dintel-=
virtio-experimental=3Dtrue<br>
+=C2=A0 * - virtio-gpu-gl (vDRM native context/Asahi)<br>
+=C2=A0 =C2=A0 - 24.2.0+<br>
+=C2=A0 =C2=A0 - -Dgallium-drivers=3Dasahi -Dvulkan-drivers=3Dasahi<br>
+<br>
+.. _mr29870: <a href=3D"https://gitlab.freedesktop.org/mesa/mesa/-/merge_r=
equests/29870" rel=3D"noreferrer" target=3D"_blank">https://gitlab.freedesk=
top.org/mesa/mesa/-/merge_requests/29870</a><br>
+<br>
=C2=A0virtio-gpu rutabaga<br>
=C2=A0-------------------<br>
<br>
@@ -133,3 +218,23 @@ Surfaceless is the default if ``wsi`` is not specified=
.<br>
=C2=A0.. _Wayland display passthrough: <a href=3D"https://www.youtube.com/w=
atch?v=3DOZJiHMtIQ2M" rel=3D"noreferrer" target=3D"_blank">https://www.yout=
ube.com/watch?v=3DOZJiHMtIQ2M</a><br>
=C2=A0.. _gfxstream-enabled rutabaga: <a href=3D"https://crosvm.dev/book/ap=
pendix/rutabaga_gfx.html" rel=3D"noreferrer" target=3D"_blank">https://cros=
vm.dev/book/appendix/rutabaga_gfx.html</a><br>
=C2=A0.. _guest Wayland proxy: <a href=3D"https://crosvm.dev/book/devices/w=
ayland.html" rel=3D"noreferrer" target=3D"_blank">https://crosvm.dev/book/d=
evices/wayland.html</a><br>
+<br>
+.. list-table:: Host Requirements<br>
+=C2=A0 :header-rows: 1<br>
+<br>
+=C2=A0 * - Mode<br>
+=C2=A0 =C2=A0 - Kernel<br>
+=C2=A0 =C2=A0 - Userspace<br>
+=C2=A0 * - virtio-gpu-gl (rutabaga/gfxstream)<br>
+=C2=A0 =C2=A0 - GPU enabled<br>
+=C2=A0 =C2=A0 - aemu/rutabaga_gfx_ffi or vhost-user client with support<br=
>
+<br>
+.. list-table:: Guest Requirements<br>
+=C2=A0 :header-rows: 1<br>
+<br>
+=C2=A0 * - Mode<br>
+=C2=A0 =C2=A0 - Mesa Version<br>
+=C2=A0 =C2=A0 - Mesa build flags<br>
+=C2=A0 * - virtio-gpu-gl (rutabaga/gfxstream)<br></blockquote><div><br></d=
iv><div>Shouldn&#39;t this be `virtio-gpu-rutabaga` instead of `virtio-gpu-=
gl`?=C2=A0 If we&#39;re including WiP MRs, can we include Magma too??</div>=
<div><br></div><div><a href=3D"https://gitlab.freedesktop.org/mesa/mesa/-/m=
erge_requests/33190">https://gitlab.freedesktop.org/mesa/mesa/-/merge_reque=
sts/33190</a></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
+=C2=A0 =C2=A0 - 24.3.0+<br>
+=C2=A0 =C2=A0 - -Dvulkan-drivers=3Dgfxstream<br>
-- <br>
2.47.1<br>
<br>
</blockquote></div></div>

--000000000000dc1e0e062cce1813--

