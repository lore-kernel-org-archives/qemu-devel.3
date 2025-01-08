Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD676E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 13:15:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVVtm-0000Cc-LT; Wed, 08 Jan 2025 08:15:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tVVtb-00008a-9D
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 08:14:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tVVtZ-0005vI-3s
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 08:14:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736342085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cEkHEM2uXbF0GIH/9F60fOgYiIRz5wUBSyGV0etjq0Y=;
 b=MZxQ7Oq8dTWwX8ipO/NJEgWQ+YDOXBRckEh3bqcjdm8sy/jMpluJHhGX8vAxO0K1/o2aZQ
 7h2M0WjNr0jtHX3u6nMiL7yNBgi0N3UY9MqCd3Wl3WE1A2tCMn+9q2KVyRwCxyhXBwcSDp
 /XzK3orEQI2lVsiFspc3o8JdLF0i/1Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-iO9PGZZoNVW7DzH-qSojwA-1; Wed, 08 Jan 2025 08:14:43 -0500
X-MC-Unique: iO9PGZZoNVW7DzH-qSojwA-1
X-Mimecast-MFC-AGG-ID: iO9PGZZoNVW7DzH-qSojwA
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4361b090d23so49429005e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 05:14:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736342082; x=1736946882;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cEkHEM2uXbF0GIH/9F60fOgYiIRz5wUBSyGV0etjq0Y=;
 b=ntYgCFl1GJiZfTJEZwtejxfD//khvhCa4s+F5cZZj2VNpCawwmd7By8gtPvoqksGuQ
 My9LhOqSoPB2apm4sRvhhNw3A1DzybcZGP/XaAjw7BoIq3cDRrYVbj3ADryb4HdOIXYG
 faLY/guwBhcSVP0xB59dM/OdLJGANICv3+S/e4/+JPlIpeAHuV98dInyeRu4BNzn38fH
 b73ON+Jg9BTdib5cpmppELul8WPd4Qr81+yiMVgTL5FuFIYuY5zmI2i7uBcfTlDMI0pC
 BdmEPk29LS9nlt+kNkpsG9SxVA3usST1WBGVqmmBnp5BxfyDgBBZMDA8ntzM4bD5GrR0
 iEtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBux6AznLym8DNleqwrJ4QiGXA8r45+ootw6FLWpUUuukSwRPX3AQpbIYPAHJE+fUwMOyV6oI4lF0y@nongnu.org
X-Gm-Message-State: AOJu0Yxpqb/XppFaMj1qM4DZw+L1c50x/9/5aEnzP4LFjg8FYC9vFIhd
 8UPwIWxpCmC4F+XzuSbKB8QIEVe10iJkPhm4YqADfPNuA3pE4p4nBHcOjnjMOhy7ay4ijRA2SV+
 R92rLtJL75Mf2+aYaQHnAaTBOdv58HpqHj07yhK+KygEh9uB1HK4E
X-Gm-Gg: ASbGncv2lhv+0tXBz7EKCMAbTmYXuaN/gLHulmVvhvyA64Wk0iTAgWhSfHwsdCUFVNd
 r58xriHiUB9nfzO1c7GyZuhPr2M+R362Dd4nJXMcOvjS8ozrpjLV3UZiJ9Df8ATLvSRT0siVTTd
 LtMzoAqpgB2j6jNU7v4HeDUSaVGGcUYnzymvhcFI5Nhy+jM4tA0C/Z/Gm3sjmiXUCInVsXJ0b7O
 FeK/wnmh5sjhBYm6gjo7Xt4FTZqRB1u2aG2IHEJ7V+ptEyYqNk=
X-Received: by 2002:a5d:64cc:0:b0:386:366d:5d0b with SMTP id
 ffacd0b85a97d-38a8732098dmr2411067f8f.55.1736342081969; 
 Wed, 08 Jan 2025 05:14:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6xXFzlkU+Xvf8VuL4H3Q267XPbJwCcjzJTXdSo8EcD3RwUWVYrBZxq+b0j5AGVr3Yh56+9A==
X-Received: by 2002:a5d:64cc:0:b0:386:366d:5d0b with SMTP id
 ffacd0b85a97d-38a8732098dmr2411060f8f.55.1736342081539; 
 Wed, 08 Jan 2025 05:14:41 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a47c9b2efsm33271257f8f.91.2025.01.08.05.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 05:14:40 -0800 (PST)
Date: Wed, 8 Jan 2025 08:14:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
Subject: Re: [PATCH v4 0/5] Support virtio-gpu DRM native context
Message-ID: <20250108081322-mutt-send-email-mst@kernel.org>
References: <20241110221838.2241356-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241110221838.2241356-1-dmitry.osipenko@collabora.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Nov 11, 2024 at 01:18:32AM +0300, Dmitry Osipenko wrote:
> This patchset adds DRM native context support to VirtIO-GPU on Qemu.
> 
> Contarary to Virgl and Venus contexts which mediate high level GFX APIs,
> DRM native context [1] mediates lower level kernel driver UAPI, which
> reflects in a less CPU overhead and less/simpler code needed to support it.
> DRM context consists of a host and guest parts that have to be implemented
> for each GPU driver. On a guest side, DRM context presents a virtual GPU as
> a real/native host GPU device for GL/VK applications.
> 
> [1] https://www.youtube.com/watch?v=9sFP_yddLLQ
> 
> Today there are four known DRM native context drivers existing in a wild:
> 
>   - Freedreno (Qualcomm SoC GPUs), completely upstreamed
>   - AMDGPU, mostly merged into upstreams
>   - Intel (i915), merge requests are opened
>   - Asahi (Apple SoC GPUs), WIP status

Took a quick look, looks ok

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Gerd, you gonnu pick this up?

Dmitry, if you will post a rebase, I can apply too.

> 
> # How to try out DRM context:
> 
> 1. DRM context uses host blobs and requires latest developer version 
> of Linux kernel [2] that has necessary KVM fixes.
> 
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
> 
> 2. Use latest libvirglrenderer from upstream git/main for Freedreno
> and AMDGPU native contexts. For Intel use patches [3].
> 
> [3] https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1384
> 
> 3. On guest, use latest Mesa version for Freedreno. For AMDGPU use
> Mesa patches [4], for Intel [5].
> 
> [4] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/21658
> [5] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/29870
> 
> 4. On guest, use latest Linux kernel v6.6+. Apply patch [6] if you're
>    running Xorg in guest.
> 
> [6] https://lore.kernel.org/dri-devel/20241020224725.179937-1-dmitry.osipenko@collabora.com/
> 
> Example Qemu cmdline that enables DRM context:
> 
>   qemu-system-x86_64 -device virtio-vga-gl,hostmem=4G,blob=on,drm_native_context=on \
>       -machine q35,accel=kvm,memory-backend=mem1 \
>       -object memory-backend-memfd,id=mem1,size=8G -m 8G
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
> v4: - Improved SDL2/dmabuf patch by reusing existing Meson X11 config 
>       option, better handling EGL error and extending comment telling
>       that it's safe to enable SDL2 EGL preference hint. As was suggested
>       by Akihiko Odaki.
> 
>     - Replaced another QSLIST_FOREACH_SAFE with QSLIST_EMPTY+FIRST in
>       the async-fencing patch for more consistency of the code. As was
>       suggested by Akihiko Odaki.
> 
>     - Added missing braces around if-statement that was spotted by
>       Alex Bennée.
> 
>     - Renamed 'drm=on' option of virtio-gpu-gl device to 
>       'drm_native_context=on' for more clarity as was suggested by 
>       Alex Bennée. Haven't added added new context-type option that 
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
>       from virglrenderer that differs from other virglrenderer API functions.
> 
>     - Improved QSLIST usage by dropping mutex protecting the async fence
>       list and using atomic variant of QSLIST helpers instead. Switched away
>       from using FOREACH helper to improve readability of the code, showing
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
>     - Replaced "=true" with "=on" in the DRM native context documentation
>       example and made virtio_gpu_virgl_init() to fail with a error message
>       if DRM context can't be initialized instead of giving a warning
>       message, as was suggested by Akihiko Odaki.
> 
>     - Added patchew's dependecy tag to the cover letter as was suggested by
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
> 
> -- 
> 2.47.0


