Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F52CC53216
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 06:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtKL5-0004tG-Uj; Fri, 20 Feb 2026 01:50:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zzyiwei@gmail.com>) id 1vtKL3-0004t5-GK
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 01:50:09 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zzyiwei@gmail.com>) id 1vtKL1-0006a9-Jq
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 01:50:09 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b8fbb24a9a9so392417666b.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 22:50:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771570204; cv=none;
 d=google.com; s=arc-20240605;
 b=Ljyde7Fyeijy+mSeQT/I9MFz+OivZ3IZyS26/py6OlOxFygQXHWRC1VfAKD9KvtLNr
 m1zR22JGt5Id+iXnZvXTxukRj5yln0r1rdJ4erTc/Egln+yvUprWc1eLIFSrwd6xbdJp
 V8Dv07Bwl6YSqh0vIejfG2FjY9sma6/6aM4F5Zo1BjN8HgIg1YYcWlrPAQA5rGK3G60W
 ICdBkklh5cJ9LQwcQ7B7f/d5OMoA/w20d7ragtHjas/ASkp3Ph6XqowkBbW7d8qdWq5E
 Few98mhksc3EApf8qjxweBsGFbrng2wu1IbYL/daM0SAuhbJ/5QPLQzyGaKJhrUPrq+U
 d9DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9osPLZ479wPe7Q67dRooH/EexfD+Dh6lZlCQpZe3gjg=;
 fh=D7KYN5Yi8IRoJ9tjm9M/DDAsgPjU7thY8IJu4dQ+bkY=;
 b=AwdID57R18+CDmqkIxbB57V2qKJp4pubd8044s8DRdJBThcNjDKE6Q/XbO+ztBdJEs
 q8kr+vlVIGSGFZ757u+GSgtzuGZJPxKXkFVX5ZvqTj4Zwnd3f4sM5rh8OOj9dYlskH1j
 Q0yzuLqphCuGKOau9METXdGMTWiYC+43W7hRyA3T27k9CQDPuCDrdWivk6kGHGmZRQY+
 4mxjhPRUH8x+u+j7X3OIBPyi3Rvv3JllCVnSQih9JTpTVvqGnaaEqNDSKtqidRh2o0Pd
 UcSnFd1C1LddssaxzeCSIlBj/2FjhcbtznE3QVCpUiXF9S0RnBh96Qd5uTYnBNKjuhRK
 pNdA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771570204; x=1772175004; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9osPLZ479wPe7Q67dRooH/EexfD+Dh6lZlCQpZe3gjg=;
 b=FpAE6kT2nbok4UCyVZV2BtTRUGLBmTBP2Qm+66hCCqYJ10HSGsOjJkjk6tZWZqqbbr
 Ipss/n4DeIdXo4Fn0+JhhjKuZY3WWRxaO024aNSIIAMpa6XRETfoh5t+NmiWjD3DS2Cy
 7jRDLEFoN+XFiVPCx6BjUMXKmmD//Q9Vym+6/KnqW0E6v9zT4h4UulRYC8uNODDvm46a
 ZM5fRHstr2AymQN1pjhfMnG8e2emxW/8FM657UhqdNJlKM83L5hmbkiQwrGmvnsJ5lpg
 x34P/WwgAaU8RU8UyBtUkr4AZ7+lryBWLaYVqtikUYIJ4rYS0Dm75Z2Aavf8C4VN5p6g
 +zcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771570204; x=1772175004;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9osPLZ479wPe7Q67dRooH/EexfD+Dh6lZlCQpZe3gjg=;
 b=cjDjSlJjXsoiAGCIXKn4nBgnXHMkfsL1gv/T2J+IkXjUpdye5t+acRtIGBj84WwDMn
 avOWKETb2lvd1skr4JOjet630PdsM5nGaKTLPv4m6P16UMahNueYfFzMxUoOJBDkwxXA
 lgNciyUGZMXRuOGhiCRTx8vmhjhISJuGxk/N6tNTX5wiBryWNQANGUeD+lVIyNRwnDY5
 Wtwu5Hu4wLwNU2H9rQBO+6AQ8XgyHe/8uaSQZrYbjxcX5ZWbkg8H0QH6Fx0F1/NjxAk+
 Uv45gc9dIRecjQZpRwIAOmhZbbuUcxLXbE4ls9udHDuW1bQujq6yrFhsiPMUAgel7FjS
 66mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO82xNa3JQRYzQJApEKEs/1mSHN2tgtUOF7KOgu+D7gkuFJyVcwYeqxXHAacdjnGq5PyjCXjr0oxCs@nongnu.org
X-Gm-Message-State: AOJu0YyZPqpInbjp8juDEx9SF4W2ggs1yupsaFcP4phDaVtOxcg03wuK
 QLsN8UUMxq8iUyy2khJzxZdBJbv4/iigQzxKDq48lErv6PbmPTmDrMERnEgL48MGlcyZuIGB9Sr
 OBQs++ggczeB0ytAZ4yILasnczCXbEzA=
X-Gm-Gg: AZuq6aJu29Y2PfEN8dSEEREsrxNjHzWGsKOD631/CSGw1CFPOijtShLtWPBIFIedYnc
 w/owAgbw6dOlFnVsop2RW3irRuH1omZOemiYYfzxXzh+rD5dv2hQPRyL+KaWXZxHa2/L+EQM6mF
 wSKO+ewjKI0QHIV54TcpGx5bPg/19zPl9blGEJTylLfsmnBw8H1dH0btUBXRtm7QDacgEwMjDuL
 XpD0KTW0dm7adWSEq3QQ6lOEg/eyTMI7bEwSHlBZpPBgQ1wcmAvOxTVZCv9cwWQcuFMvbRlD5Mm
 dyo7aZK0YvBxFNBavlc=
X-Received: by 2002:a17:907:1ca2:b0:b8f:e992:3fc9 with SMTP id
 a640c23a62f3a-b905415c02bmr303535166b.6.1771570203713; Thu, 19 Feb 2026
 22:50:03 -0800 (PST)
MIME-Version: 1.0
References: <20260220001634.3579257-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20260220001634.3579257-1-dmitry.osipenko@collabora.com>
From: Yiwei Zhang <zzyiwei@gmail.com>
Date: Thu, 19 Feb 2026 22:51:22 -0800
X-Gm-Features: AaiRm50bH0T2wZSkgZZ-T11UtFs-onBZQJEx673HpcwYiTD1zWy4U9abYwU6J80
Message-ID: <CAJ+hS_gqFYgDqCehrpUh1CZq_V=nbyTnmfDYJesynRw9K7Vdwg@mail.gmail.com>
Subject: Re: [PATCH v19 00/20] Support virtio-gpu DRM native context and
 MAP_FIXED API
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Sergio Lopez Pascual <slp@redhat.com>, 
 Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org, 
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>, 
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, 
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>, 
 Rob Clark <robdclark@gmail.com>, Robert Beckett <bob.beckett@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=zzyiwei@gmail.com; helo=mail-ej1-x631.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Feb 19, 2026 at 4:20=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Hello,
>
> This is follow up to DRM native context v16 [1] and MAP_FIXED API v10 [2]
> virtio-gpu patches that has been reviewed previously and were waiting for
> a new release of libvirglrenderer 1.3.0.
>
> [1] https://lore.kernel.org/qemu-devel/20251116125641.2255794-1-dmitry.os=
ipenko@collabora.com/
> [2] https://lore.kernel.org/qemu-devel/20260118162856.223796-1-dmitry.osi=
penko@collabora.com/
>
> Based-on: 20260214-region-v1-1-229f00ae1f38@rsg.ci.i.u-tokyo.ac.jp
>
> Changelog:
>
> v19:- Further improved improved naming of functions and terminology RE
>       GL context binding. Suggested by Akihiko Odaki.
>
>     - Added new patch "ui/gdk: Restore original context after new context
>       creation" in addition to improved "ui/sdl2: Restore original contex=
t"
>       that now getd actual bound GL context and restores to it instead
>       of restoring to the console's ctx, for consistency with the rest
>       of GL context management fixes that ensure context is bound only
>       when necessary.
>
>     - Improved virtio_gpu_virgl_update_render_state() with force_ctx_0()
>       and unbind_ctx() to make deferred GPU resetting maintain bound GL
>       context properly.
>
> v18:- Changed dpy_gl_ctx_make_current() to use first scanout when unsetti=
ng
>       virgl's GL ctx0 and improved naming of cmd-processing function.
>       Suggested by Akihiko Odaki.
>
>     - Added "ui/gdk: Unset context after GL operations" patch after
>       realizing GDK/GL code needed more gdk_gl_context_clear_current().
>
> v17:- Rebased patches on recent upstream, updated doc patches with new
>       drm native contexts supported by libvirglrenderer.
>
>     - Applied minor change that was requested from Akihiko Odaki
>       by moving virtio_gpu_device_realize() for MAP_FIXED v10.
>
>     - Added virtio_gpu_virgl_update_render_state() to virtio_gpu_fence_po=
ll()
>       that was missed in MAP_FIXED v10.
>
>     - Added new patches fixing another GL context switching problem I ran
>       into recently with virgl commands unexpectedly processed from CPU
>       thread instead main-loop:
>
>         ui/sdl2: Unset context after GL operations
>         ui/gtk-egl: Unset context after GL operations
>         virtio-gpu: Unset context after GL operations
>
> Alex Benn=C3=A9e (1):
>   docs/system: virtio-gpu: Document host/guest requirements
>
> Dmitry Osipenko (18):
>   ui/gdk: Restore original context after new context creation
>   ui/sdl2: Restore original context after new context creation
>   ui/sdl2: Don't disable scanout when display is refreshed
>   ui/gtk: Don't disable scanout when display is refreshed
>   ui/sdl2: Unbind context after GL operations
>   ui/gtk-egl: Unbind context after GL operations
>   ui/gdk: Unbind context after GL operations
>   virtio-gpu: Unbind context after GL operations
>   virtio-gpu: Handle virgl fence creation errors
>   virtio-gpu: Support asynchronous fencing
>   virtio-gpu: Support DRM native context
>   docs/system: virtio-gpu: Add link to Mesa VirGL doc
>   docs/system: virtio-gpu: Update Venus link
>   virtio-gpu: Remove superfluous memory_region_set_enabled()
>   virtio-gpu: Validate hostmem mapping offset
>   virtio-gpu: Replace finish_unmapping with mapping_state
>   virtio-gpu: Destroy virgl resources on virtio-gpu reset
>   virtio-gpu: Support mapping hostmem blobs with map_fixed
>
> Pierre-Eric Pelloux-Prayer (1):
>   ui/sdl2: Implement dpy dmabuf functions
>
>  docs/system/devices/virtio/virtio-gpu.rst | 121 +++++-
>  hw/display/trace-events                   |   2 +-
>  hw/display/virtio-gpu-gl.c                |  62 +++-
>  hw/display/virtio-gpu-virgl.c             | 427 ++++++++++++++++++++--
>  hw/display/virtio-gpu.c                   |  15 +
>  include/hw/virtio/virtio-gpu.h            |  23 +-
>  include/ui/sdl2.h                         |   7 +
>  meson.build                               |   8 +-
>  ui/gtk-egl.c                              |  17 +-
>  ui/gtk-gl-area.c                          |  28 +-
>  ui/sdl2-gl.c                              |  81 +++-
>  ui/sdl2.c                                 |  42 +++
>  12 files changed, 760 insertions(+), 73 deletions(-)
>
> --
> 2.52.0
>

My original r-b's still persist, and this PATCH v19 is t-b. Can't wait
to see this land ; )

