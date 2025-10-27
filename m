Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A02CCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 10:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDKtz-0006gC-NK; Mon, 27 Oct 2025 06:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDKtx-0006fk-Pi
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:56:37 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDKtt-0004Wy-GM
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:56:37 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-63e076e24f2so472704a12.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 03:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761562590; x=1762167390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gFq5ZUI0QuzwvzpO5hCe7bTH4w8/yMd6w/y04oWsSZ4=;
 b=Lkha/cf4UXGeN3UduhuyG/Tyv4iIROpUmuZZvsxtEfc/VhTCtyN2FZOUEv5VK1Qogr
 6DvFd/uKhV06+cGCOeDaDs2MwerAi4w+qiRxjmaRsXoc1oNbW9TFzHDJkAM9Z1bXu/1x
 HZQOJxEApMpyk4hcZ3lzBJEsiWsDF3bJmwcRA5aaZAloKTNI8NVcwcy6H+cKDyLtAXXJ
 XD4HF3T/xlxk0E8Zf7IY3+s0l4rrIHg14iLzvEN+9Vml4hwGHPEjyA/fdY8fRP+ubdwq
 RONhjsu/6VVnF6vbvpUByvUv2p+31CeCcmWvnGSFN6/cbbX5c7P2DrLnDQjkGuYwHCYA
 9h+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761562590; x=1762167390;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gFq5ZUI0QuzwvzpO5hCe7bTH4w8/yMd6w/y04oWsSZ4=;
 b=BxASv3+V1Q0uXyPtS93uIkSN7efjXRZDau+Twww1HivwGJqJ5R8QOZlPYGBWscIX+U
 3LkZWywmf9D4FE6/KIfrz0FG6whvALJBs47InqLtaenAFPmd2x7vobg2X0OenMDEHstV
 z0+Ubyx+4XEmZ4K4OFdIUhUjMX2vol9x5pZIoa4JaO5keUcFI/p+bCWIlbKNPFH8Zhw6
 TZ08BoyU/HOVi2uFAzqjF2SnqCLqed5e3mPLiVrdCGza7QX0N7WJ1VcMqojejVNGt/Dw
 qfb+2jhxWK13tA9fhsYv2BIkhqx9U+iuDjA1yDld/T1oNJEAMTuV/Y6CNieGM0qPpEoX
 TjTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWM5O1GynfOzEFfSj8B3wy5mjIUkGP89dX59x0vApxtAv06wjughKnIrV4Fg5/ZtXbHrFEfOpb8Jdpt@nongnu.org
X-Gm-Message-State: AOJu0YzSqjOTK6eFjUlFXHI7IkuCC9FPVzxOCaVe4uOzI1UvMaLLfSL0
 6kF6SrpmrIwYemzm5GUT5esfs8FZm5GVsDNrZDBsTAsZonxOscVQXgVjGekxA2F3F3w=
X-Gm-Gg: ASbGnct18BYbPCZxsbC43Wi9lDw2oC4KudiU69YRoXXjFOdRRf/Vj/vMqzFSUhUl1gH
 KBwf+vzGtG6j6q1D5uhIRdQa7kiSADzlN3hc8G/nvs6wEHe8/vOwyrZAkTHT2E0h9o0Rc3olv7f
 XABkb9f7peEmnZi0W7ZGeTOTlg9OFYUefe9shvQrF7dJwhvh7SYrPJyBe2YIDb7z31UTBElpE6I
 V3ZurL3gdvTHs+zvmA851NKkt163WWDMUTxLaCS9uKaIqVJTL6yUCdcEYtb6tCL8jq/PpIQ/zm/
 CiVYF/vTOyZvI9R3/R3KxKXFtpUd1pPDbAfEZT4WREacNq6MV+vXVlaoq1oVg7vkH5PRWZIq1jF
 OCu7x5CTz2S9IXJbjywHXaC1jCe97gxWS1B+CUEkKkr490ejr9whPPmlpIEh962zAhf6ia0hjX8
 2l0eXO42VUTCk=
X-Google-Smtp-Source: AGHT+IFKeOA5RM/Gz8n6dEQzh0D2gAmk6pRCMOyWzB1xl5gTGnnVVYm2+5CSf97wbndP0NBJMdJvPA==
X-Received: by 2002:a17:906:fe09:b0:b47:de64:df1b with SMTP id
 a640c23a62f3a-b6473b5263fmr4455121066b.39.1761562589870; 
 Mon, 27 Oct 2025 03:56:29 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d853077c7sm732054766b.7.2025.10.27.03.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 03:56:29 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6D5105F8CD;
 Mon, 27 Oct 2025 10:56:28 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,  Huang Rui
 <ray.huang@amd.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>,  "Michael S . Tsirkin"
 <mst@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Gert Wollny
 <gert.wollny@collabora.com>,  qemu-devel@nongnu.org,  Gurchetan Singh
 <gurchetansingh@chromium.org>,  Alyssa Ross <hi@alyssa.is>,  Roger Pau
 =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>,  Alex Deucher
 <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,  Christian =?utf-8?Q?K?=
 =?utf-8?Q?=C3=B6nig?=
 <christian.koenig@amd.com>,  Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>,  Julia Zhang
 <julia.zhang@amd.com>,  Chen Jiqian <Jiqian.Chen@amd.com>,  Rob Clark
 <robdclark@gmail.com>,  Yiwei Zhang <zzyiwei@gmail.com>,  Sergio Lopez
 Pascual <slp@redhat.com>
Subject: Re: [PATCH v14 00/10] Support virtio-gpu DRM native context
In-Reply-To: <20251020233949.506088-1-dmitry.osipenko@collabora.com> (Dmitry
 Osipenko's message of "Tue, 21 Oct 2025 02:39:39 +0300")
References: <20251020233949.506088-1-dmitry.osipenko@collabora.com>
User-Agent: mu4e 1.12.14-dev2; emacs 30.1
Date: Mon, 27 Oct 2025 10:56:28 +0000
Message-ID: <871pmozk83.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
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

> This patchset adds DRM native context support to VirtIO-GPU on QEMU.
>
> Contarary to Virgl and Venus contexts that mediates high level GFX APIs,
> DRM native context [1] mediates lower level kernel driver UAPI, which
> reflects in a less CPU overhead and less/simpler code needed to support i=
t.
> DRM context consists of a host and guest parts that have to be implemented
> for each GPU driver. On a guest side, DRM context presents a virtual GPU =
as
> a real/native host GPU device for GL/VK applications.

Gentle ping for any review. I'm running a bit tight for softfreeze and I
don't think I have time to do this justice.

>
> [1] https://www.youtube.com/watch?v=3D9sFP_yddLLQ
>
> Today there are four DRM native context drivers existing in a wild:
>
>   - Freedreno (Qualcomm SoC GPUs), completely upstreamed
>   - AMDGPU, completely upstreamed
>   - Intel (i915), merge requests are opened
>   - Asahi (Apple SoC GPUs), partially merged upstream
>
> # How to try out DRM context:
>
> 1. DRM context uses host blobs and on host requires v6.13 or newer version
> of Linux kernel that contains necessary KVM fixes.
>
> 2. Use latest available Mesa (both guest and host) and libvirglrenderer=20
> versions. On guest, build Mesa with enabled virtio native context support.
>
> 3. On guest, use latest Linux kernel v6.14 or newer.
>
> Example QEMU cmdline that enables DRM context:
>
>   qemu-system-x86_64 -device virtio-vga-gl,hostmem=3D4G,blob=3Don,drm_nat=
ive_context=3Don \
>       -machine q35,accel=3Dkvm -m 8G
>
> # Notes about known problems:
>
> 1. DRM contexts are mapping host blobs extensively and these mapping
> operations work slowly in QEMU. We will need to optimize hostmem
> unmapping that currently happens in a deffered RCU work, blocking
> GPU for a substantial time. WIP fixes available at [2][3].
>
> [2] https://lore.kernel.org/qemu-devel/20251016-force-v1-1-919a82112498@r=
sg.ci.i.u-tokyo.ac.jp/
> [3] https://lore.kernel.org/qemu-devel/20251014111234.3190346-6-alex.benn=
ee@linaro.org/
>
> 2. Linux kernel virtio-gpu driver doesn't limit display refresh rate,
> causing poor performance. Fix availalble in drm-misc-next tree [4]
> and should land upstream with v6.19+ kernel.
>
> [4] https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/a036f5fceedb9=
fbd715565fef7b824a121503de7
>
> 3. Xorg on guest creates initial dumb buffer that is a vrend buffer, which
>    can't be re-used by native contexts. This may cause drawing artifacts.
>    Boot kernel with disabled fbdev using drm_client_lib.active=3D"" kernel
>    cmdline parameter to work around the issue.
>
>    Wayland on guest isn't affected by this issue.
>
> Changelog:
>
> v14:- Rebased on top of recent QEMU staging tree.
>
>     - DRM native context in QEMU now requires virglrenderer v1.2.0+
>       containing fix for async-fencing not working after guest reboot.
>
>     - Updated doc patch with new Asahi nctx rquirements info. Asahi
>       support landed to virglrenderer v1.2.0.
>
> v13:- Updated Asahi nctx MR link in the doc patch. Old MR was closed
>       and new opened.
>
>     - Fixed compiler warning about unused variable when using older
>       virglrenderer version.
>
> v12:- Rebased on top of recent QEMU/staging and a fix from Yiwei Zhang:
>
>         https://lore.kernel.org/qemu-devel/20250518152651.334115-1-zzyiwe=
i@gmail.com/
>
>     - Async-fence and native context features now require virglrenderer >=
 1.1.1
>       that contains fix needed for resetting virtio-gpu-gl properly on QE=
MU
>       reboot:
>
>         https://gitlab.freedesktop.org/virgl/virglrenderer/-/commit/6f468=
1ff09cb17aa2d6715dbc6034eb3abe5711d
>
>     - Added r-b from Akihiko Odaki to the doc patch.
>
>     - Corrected resetting of async fences list that was done on scanout
>       reset in v11 instead of virtio-gpu reset.
>
> v11:- Added column for libvirglrenderer host requrements versions and=20
>       corrected Asahi kernel link. Suggested by Akihiko Odaki.
>
> v10:- Added links to Asahi and i915 virglrenderer MRs, link to Asahi host
>       kernel. Suggested by Akihiko Odaki.
>
>     - Renamed gfxstream guest requrements table's colum to match the host
>       requirements table. Suggested by Akihiko Odaki.
>
> v9: - Updated doc patch by addresing review comments from Akihiko Odaki.
>       Made kernel requirements section specific to guest kernel and
>       removed reference to host requirements. Removed examples of
>       external projects' build flags.
>
>     - Added guest kernel minimum versions to the guest requirements table.
>
> v8: - Addressed review comments from Akihiko Odaki on the doc patch.
>
>     - Added r-bs from Akihiko Odaki on the doc patches.
>
>     - Extended vrend doc with info about hostmem requirement for GL 4.6
>
> v7: - Added r-b from Alex Benn=C3=A9e to the async fencing patch.
>
>     - Updated virtio-gpu doc patch with addressed review comments
>       from Akihiko Odaki.
>
> v6: - Fixed compilation warning using older version of virglrenderer,
>       which wasn't fixed properly in v5.
>
>     - Added t-bs from Alex Benn=C3=A9e.
>
>     - Added patches to improve virgl/venus doc by adding links
>       to the Mesa doc as was suggested by Akihiko Odaki.
>
>     - Updated patch that documents guest/host requirements. Added
>       links to Asahi nctx and reworked the doc structure by adding
>       requirements to each context-type section instead of having
>       one big blob or requirements, which was objected by Akihiko Odaki.
>
> v5: - Added r-bs from Akihiko Odaki.
>
>     - Added acks from Michael Tsirkin.
>
>     - Fixed compilation warning using older version of virglrenderer that
>       was reported by Alex Benn=C3=A9e. Noticed that I need to keep old
>       virgl_write_fence() code around for the older virglrenderer in
>       "Support  asynchronous fencing" patch, so added it back and verified
>       that old virglrenderer works properly.
>
>     - Added new patch from Alex Benn=C3=A9e that adds more virtio-gpu=20
>       documentation with a couple corrections and additions to it from me.
>
>     - Rebased patches on top of latest staging tree.
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
> Alex Benn=C3=A9e (1):
>   docs/system: virtio-gpu: Document host/guest requirements
>
> Dmitry Osipenko (8):
>   ui/sdl2: Restore original context after new context creation
>   virtio-gpu: Handle virgl fence creation errors
>   virtio-gpu: Support asynchronous fencing
>   virtio-gpu: Support DRM native context
>   ui/sdl2: Don't disable scanout when display is refreshed
>   ui/gtk: Don't disable scanout when display is refreshed
>   docs/system: virtio-gpu: Add link to Mesa VirGL doc
>   docs/system: virtio-gpu: Update Venus link
>
> Pierre-Eric Pelloux-Prayer (1):
>   ui/sdl2: Implement dpy dmabuf functions
>
>  docs/system/devices/virtio-gpu.rst | 116 +++++++++++++++++-
>  hw/display/virtio-gpu-gl.c         |   7 ++
>  hw/display/virtio-gpu-virgl.c      | 185 ++++++++++++++++++++++++++++-
>  hw/display/virtio-gpu.c            |  15 +++
>  include/hw/virtio/virtio-gpu.h     |  14 +++
>  include/ui/sdl2.h                  |   7 ++
>  meson.build                        |   8 +-
>  ui/gtk-egl.c                       |   1 -
>  ui/gtk-gl-area.c                   |   1 -
>  ui/sdl2-gl.c                       |  70 ++++++++++-
>  ui/sdl2.c                          |  42 +++++++
>  11 files changed, 449 insertions(+), 17 deletions(-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

