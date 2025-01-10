Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC65E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 12:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWDwq-0003cB-2T; Fri, 10 Jan 2025 07:17:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWDwF-000345-Sb
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:16:33 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWDwA-0003ra-Ci
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:16:29 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5d9837f201aso3756734a12.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 04:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736511383; x=1737116183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uoos42d49XQWKqJ/F/XxFw4/f6mS2lzr3W/1PiAuiys=;
 b=vmtWMEFvLxTkug0qyX0jjcATCsONgzpHdUoR7xXOBXOG+06Iu90/FZz+Y8uwl8zQ5i
 p7XX4vdF6B7QjX1vDw3ccGFyrPuASwoc3luRQqFwQacScRZmCu8QrSGOlhN2E4VOhYNm
 wUyhWHF9smruMeytkMJ5e8VZDpkRCh5nMiOW1uW41nx5cCTuMwWh8e/hpfsqaMGkoW+m
 Ic0xDUfpuVc2eLW8YS5AD1SmgBFak0nX/QlFy7yzF9rXXV/fjs65yFtJp7dvoh/3XnTa
 dCrx4G9sigBGpqC+c1Y8iBl0K7/1NzsoYzw+LUoY9xjqCVUWUMus7Db/5y+LpSfW4VOJ
 7ImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736511383; x=1737116183;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uoos42d49XQWKqJ/F/XxFw4/f6mS2lzr3W/1PiAuiys=;
 b=TGRyMFYObmgieyCsv+9WgOjuEjDd3zR4TWVGdmyIZuG7Epd75x6Gk7+U3/hY2odlsy
 LYi90XArbVt2GA4qkQN520x2Qnh4B9jfxJtTqQcqR9TTPY8ASVuKWmhpjh5TEAbmZGcK
 VELoykdvsWcbrM4EZQluI3dxbGLdYMjHhMrqarAwMntXkhLQmYdsilruUAY3FbH1wVzv
 Ugd8IRm0hIq7Z88QKRRW2b063h3b3Iu6JdpSoGeaFRiPl/lRKmC1jADnLylX/mOWn3Ho
 cfqTeFC+bwdr5rxzAzlSq53ab8WgHiivloeQ5BKXY63NQBoLS5tuDCy00/S3YMvLJ+CK
 WSog==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9Qpd+oyeZpLcTIzCLJW/gqRaTMhDyONaQ89IoUBLPwfmjR6PwRNSUG1c4XBbkWTZQyMA8hp4bOml9@nongnu.org
X-Gm-Message-State: AOJu0YzIIsAC+aqTuooefMjAElNjxYzXJ6nkewwTznIu6elKrnk7c/WF
 pG0PA61oHwaxYmRoAG2GzZzLFwxxCofXYDYgoBabxerXrI+2t1vb/Gm7d40ZUHM=
X-Gm-Gg: ASbGnctujKaHIymVpL48JHTFxqzgPP3Js2Ib/Esz+AtM+RCo5IJ+WiXQ0HJ5ZDZid1F
 MgeOyYOBqTd888CV+wxecLyKTCHMeI5h30mru4FKv96/rfGT4LXWLiz4mkKsAAMA0RvMvGwDx7N
 hEotWarKUz/oxujOsO2meDg5nxstO2FOJRoCYsi7in61JWeWdq1BayM4218hMeCWZbmzQs9+ZFx
 J2qRxjPevbfz7TKw32bovEFYv1dcZeuOfbLTDeIFsGc4sELOedcNNs=
X-Google-Smtp-Source: AGHT+IHNsd6wj2PXjvGVKcr3zzgvUmXWefoNrevyV6DRiwv0EttPr7M1B/smTN+2qb7/aiV+uOCgdw==
X-Received: by 2002:a17:906:dc92:b0:aa6:7c8e:808c with SMTP id
 a640c23a62f3a-ab2c3cb6e09mr614966366b.17.1736511382660; 
 Fri, 10 Jan 2025 04:16:22 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c96461dasm159526566b.168.2025.01.10.04.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 04:16:22 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F21505F8C8;
 Fri, 10 Jan 2025 12:16:20 +0000 (GMT)
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
Subject: Re: [PATCH v4 0/5] Support virtio-gpu DRM native context
In-Reply-To: <20241110221838.2241356-1-dmitry.osipenko@collabora.com> (Dmitry
 Osipenko's message of "Mon, 11 Nov 2024 01:18:32 +0300")
References: <20241110221838.2241356-1-dmitry.osipenko@collabora.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 10 Jan 2025 12:16:20 +0000
Message-ID: <87o70e50ff.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
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

> This patchset adds DRM native context support to VirtIO-GPU on Qemu.
>
> Contarary to Virgl and Venus contexts which mediate high level GFX APIs,
> DRM native context [1] mediates lower level kernel driver UAPI, which
> reflects in a less CPU overhead and less/simpler code needed to support i=
t.
> DRM context consists of a host and guest parts that have to be implemented
> for each GPU driver. On a guest side, DRM context presents a virtual GPU =
as
> a real/native host GPU device for GL/VK applications.
>
> [1] https://www.youtube.com/watch?v=3D9sFP_yddLLQ
>
> Today there are four known DRM native context drivers existing in a wild:
>
>   - Freedreno (Qualcomm SoC GPUs), completely upstreamed
>   - AMDGPU, mostly merged into upstreams
>   - Intel (i915), merge requests are opened
>   - Asahi (Apple SoC GPUs), WIP status
>
>
> # How to try out DRM context:
>
> 1. DRM context uses host blobs and requires latest developer version=20
> of Linux kernel [2] that has necessary KVM fixes.
>
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
>
> 2. Use latest libvirglrenderer from upstream git/main for Freedreno
> and AMDGPU native contexts. For Intel use patches [3].
>
> [3] https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1=
384
>

Can we detect if virglrenderer has support at build time?

  [drm] pci: virtio-gpu-pci detected at 0000:00:02.0
  [drm] Host memory window: 0x8000000000 +0x100000000
  [drm] features: +virgl +edid +resource_blob +host_visible
  [drm] features: +context_init
  [drm] number of scanouts: 1
  [drm] number of cap sets: 2
  DRM native context support was not enabled in virglrenderer
  qemu: virgl could not be initialized: -1
  [drm:virtio_gpu_init] *ERROR* timed out waiting for cap set 0

is a poor failure mode at runtime.

> 3. On guest, use latest Mesa version for Freedreno. For AMDGPU use
> Mesa patches [4], for Intel [5].
>
> [4] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/21658
> [5] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/29870
>
> 4. On guest, use latest Linux kernel v6.6+. Apply patch [6] if you're
>    running Xorg in guest.
>
> [6] https://lore.kernel.org/dri-devel/20241020224725.179937-1-dmitry.osip=
enko@collabora.com/
>
> Example Qemu cmdline that enables DRM context:
>
>   qemu-system-x86_64 -device virtio-vga-gl,hostmem=3D4G,blob=3Don,drm_nat=
ive_context=3Don \
>       -machine q35,accel=3Dkvm,memory-backend=3Dmem1 \
>       -object memory-backend-memfd,id=3Dmem1,size=3D8G -m 8G
>
>
> # Note about known performance problem in Qemu:
>
> DRM contexts are mapping host blobs extensively and these mapping
> operations work slowly in Qemu. Exact reason is unknown. Mappings work
> fast on Crosvm For DRM contexts this problem is more visible than for
> Venus/Virgl.
>
> Changelog:
>
> v4: - Improved SDL2/dmabuf patch by reusing existing Meson X11 config=20
>       option, better handling EGL error and extending comment telling
>       that it's safe to enable SDL2 EGL preference hint. As was suggested
>       by Akihiko Odaki.
>
>     - Replaced another QSLIST_FOREACH_SAFE with QSLIST_EMPTY+FIRST in
>       the async-fencing patch for more consistency of the code. As was
>       suggested by Akihiko Odaki.
>
>     - Added missing braces around if-statement that was spotted by
>       Alex Benn=C3=A9e.
>
>     - Renamed 'drm=3Don' option of virtio-gpu-gl device to=20
>       'drm_native_context=3Don' for more clarity as was suggested by=20
>       Alex Benn=C3=A9e. Haven't added added new context-type option that=
=20
>       was also proposed by Alex, might do it with a separate patch.
>       This context-type option will duplicate and depecate existing
>       options, but in a longer run likely will be worthwhile adding
>       it.
>
>     - Dropped Linux headers-update patch as headers has been updated
>       in the staging tree.
>
> v3: - Improved EGL presence-check code on X11 systems for the SDL2
>       hint that prefers EGL over GLX by using better ifdefs and checking
>       Xlib presence at a build time to avoid build failure if lib SDL2
>       and system are configured with a disabled X11 support. Also added
>       clarifying comment telling that X11 hint doesn't affect Wayland
>       systems. Suggested by Akihiko Odaki.
>
>     - Corrected strerror(err) that used negative error where it should
>       be positive and vice versa that was caught by Akihiko Odaki. Added
>       clarifying comment for the case where we get positive error code
>       from virglrenderer that differs from other virglrenderer API functi=
ons.
>
>     - Improved QSLIST usage by dropping mutex protecting the async fence
>       list and using atomic variant of QSLIST helpers instead. Switched a=
way
>       from using FOREACH helper to improve readability of the code, showi=
ng
>       that we don't precess list in unoptimal way. Like was suggested by
>       Akihiko Odaki.
>
>     - Updated patchset base to Venus v18.
>
> v2: - Updated SDL2-dmabuf patch by making use of error_report() and
>       checking presense of X11+EGL in the system before making SDL2
>       to prefer EGL backend over GLX, suggested by Akihiko Odaki.
>
>     - Improved SDL2's dmabuf-presence check that wasn't done properly
>       in v1, where EGL was set up only after first console was fully
>       inited, and thus, SDL's display .has_dmabuf callback didn't work
>       for the first console. Now dmabuf support status is pre-checked
>       before console is registered.
>
>     - Updated commit description of the patch that fixes SDL2's context
>       switching logic with a more detailed explanation of the problem.
>       Suggested by Akihiko Odaki.
>
>     - Corrected rebase typo in the async-fencing patch and switched
>       async-fencing to use a sigle-linked list instead of the double,
>       as was suggested by Akihiko Odaki.
>
>     - Replaced "=3Dtrue" with "=3Don" in the DRM native context documenta=
tion
>       example and made virtio_gpu_virgl_init() to fail with a error messa=
ge
>       if DRM context can't be initialized instead of giving a warning
>       message, as was suggested by Akihiko Odaki.
>
>     - Added patchew's dependecy tag to the cover letter as was suggested =
by
>       Akihiko Odaki.
>
> Dmitry Osipenko (4):
>   ui/sdl2: Restore original context after new context creation
>   virtio-gpu: Handle virgl fence creation errors
>   virtio-gpu: Support asynchronous fencing
>   virtio-gpu: Support DRM native context
>
> Pierre-Eric Pelloux-Prayer (1):
>   ui/sdl2: Implement dpy dmabuf functions
>
>  docs/system/devices/virtio-gpu.rst |  11 ++
>  hw/display/virtio-gpu-gl.c         |   5 +
>  hw/display/virtio-gpu-virgl.c      | 158 ++++++++++++++++++++++++++---
>  hw/display/virtio-gpu.c            |  15 +++
>  include/hw/virtio/virtio-gpu.h     |  16 +++
>  include/ui/sdl2.h                  |   7 ++
>  meson.build                        |   6 +-
>  ui/sdl2-gl.c                       |  67 ++++++++++++
>  ui/sdl2.c                          |  42 ++++++++
>  9 files changed, 309 insertions(+), 18 deletions(-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

