Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1EDCCFA13
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Nov 2025 12:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHhiU-0006iC-Cb; Sat, 08 Nov 2025 07:06:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zzyiwei@gmail.com>) id 1vHhiS-0006hZ-WB
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 07:06:49 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zzyiwei@gmail.com>) id 1vHhiQ-0005A2-7u
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 07:06:48 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-640c48b3b90so2600727a12.0
 for <qemu-devel@nongnu.org>; Sat, 08 Nov 2025 04:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762603604; x=1763208404; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LvLD8buReYLiZw24KDvZ6ZZs/JXBPcGlHyfGtoTFdrA=;
 b=d7nJmlUpe4S6n0odKQwK9yqyC9SnGoms5GyxzhnPOpbsYrX6Od41XGEG+dvaONfUU6
 bujlWM6/N3G5+ez9rQ3mEmYbyI7Sf+xM4rUD4/U08rvBK2rHI5yrd2rnlgbVlh3UcUQ0
 V+g5Sjkl9wKTrRLbeGqWymsthmV9WYqlaeSzxm8Tqa+TEwYta6cldeEgMde2SrBnaLn3
 KrklRrVDDdjy67Kc+I9rLZMaDnO4MBK/BqWCmVaiXPkvP5k9MeSBOFckXiM9icyXy8WI
 J8uiET3LxjJhrsj7GS6PgWfi6luQQtYbMPRHVj56QJ+AFlfUiohSmBYpbIwkyHBmN0zi
 adjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762603604; x=1763208404;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LvLD8buReYLiZw24KDvZ6ZZs/JXBPcGlHyfGtoTFdrA=;
 b=GuqB0KUJfvoLCNLH+XjQxFO85pn58nDtNNsC8ngKrfuMlfvBDXeU2iEbbjvAsFv6Zw
 rXuPCCUAn+hQl/Skl9b3F2fKWklALdNuTm7ltd486d8gmgcWCA7t2IqHLzwjoKLcT1j1
 oS98IBg6lQ3lIkZRoQkCvsumXicdsHRuVQg8xU7OYvPFMAARFDGcs10vN7HEHhENmG/b
 0d0ecuEezh7GYxaE578CgvZ+ePKwWw3Jpli647ADzyyXbkZ7GZccRYd1ZroAVq58FzVQ
 53sN2xhUQbc6KXmL7LPEsEdj8aStDlqpxZCDeBeYGH7V/rFefbnB1y8W/ChdzogkikeH
 Z/nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGQ70kHnEnrSE98WZxRXpnmmaNEIDaHlhjUxFprQgku3LmbS8aPFBXKsDKqNLwHyXrGeb2lFx9IOxT@nongnu.org
X-Gm-Message-State: AOJu0YyKZwUdU3u+se+TPyiCdu7yRYyCaT9C3YOLpz2n8D9wrZ0V0EYe
 HxylRQ+mIAFUiWo84PTXNdc7uRNOIZkLzaDklXiOYTD3zrDPBqf0cNjd9nu1zgCp+ns+yOKsbmX
 5ZDlenWlz+TJu9ULPrwCuOyPw/p5XA8I=
X-Gm-Gg: ASbGnctTtUa4rV0RwWsxelvLPbHnbTYhx+CiU6YzAgkOZyZZhaDJtNBKkzLbi3wX2hb
 n0HmdYf9NweF1/uiNhU5HNRyrSnA7N5S09bBaKbb8RGAIsgkP6KKv/kOPCYsyuRX2ZpwsBR5Y4N
 4nWF+u0N0jLZAATuU5NIx0mI50bbUivem+ma2VGNXhmbOBJH5O+envF/V2oJ3cPvmUsZ5ZwThOJ
 fr1XR5L7rL3auGn3hsYN9/B2yTswsG6LpnCmeX+KNFzU9MRSzxURGyaply22k6yCfERv5mwFb3B
 CfGHco5xphDgFnKdGlQ0ihh4gL4Jrbij3mRFvfs=
X-Google-Smtp-Source: AGHT+IHZ8i5nGEsRg0zjgLi99gB73bDspnzvShfIBWrlOOpsAUXbAKDONVZx9Vyk5OW36/vRefnjImslsHBfAz2qlnw=
X-Received: by 2002:a17:907:3f0f:b0:b71:3647:21bf with SMTP id
 a640c23a62f3a-b72e037cf58mr224900266b.27.1762603604037; Sat, 08 Nov 2025
 04:06:44 -0800 (PST)
MIME-Version: 1.0
References: <20251020233949.506088-1-dmitry.osipenko@collabora.com>
 <DM8PR12MB543171EE8DB9CD0272C7A99D8DC4A@DM8PR12MB5431.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB543171EE8DB9CD0272C7A99D8DC4A@DM8PR12MB5431.namprd12.prod.outlook.com>
From: Yiwei Zhang <zzyiwei@gmail.com>
Date: Sat, 8 Nov 2025 04:06:49 -0800
X-Gm-Features: AWmQ_bnsXwa9EE1H1fYOrX2cpkAVjc44G8FxYGqN5R9-F74bCSK2_U5Oqn7I10A
Message-ID: <CAJ+hS_gGVc++CXCOh6uTcD2H6cn4ZNA_A=EWdWHYyo8HBhUPmg@mail.gmail.com>
Subject: Re: [PATCH v14 00/10] Support virtio-gpu DRM native context
To: "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 "Huang, Ray" <Ray.Huang@amd.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Gert Wollny <gert.wollny@collabora.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>, 
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "Stabellini, Stefano" <stefano.stabellini@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, 
 "Ragiadakou, Xenia" <Xenia.Ragiadakou@amd.com>, "Huang,
 Honglei1" <Honglei1.Huang@amd.com>, 
 "Zhang, Julia" <Julia.Zhang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>, 
 Rob Clark <robdclark@gmail.com>, Sergio Lopez Pascual <slp@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=zzyiwei@gmail.com; helo=mail-ed1-x52f.google.com
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

On Tue, Nov 4, 2025 at 2:02=E2=80=AFAM Pelloux-Prayer, Pierre-Eric
<Pierre-eric.Pelloux-prayer@amd.com> wrote:
>
> [Public]
>
> Hi,
>
> The whole series is Acked-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pel=
loux-prayer@amd.com>
>
> Thanks a lot Dmitry!
>
> Pierre-Eric
>
> ________________________________
> From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Sent: Tuesday, October 21, 2025 1:39 AM
> To: Akihiko Odaki <akihiko.odaki@daynix.com>; Huang, Ray <Ray.Huang@amd.c=
om>; Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>; Philippe Mathieu=
-Daud=C3=A9 <philmd@linaro.org>; Gerd Hoffmann <kraxel@redhat.com>; Alex Be=
nn=C3=A9e <alex.bennee@linaro.org>; Pelloux-Prayer, Pierre-Eric <Pierre-eri=
c.Pelloux-prayer@amd.com>; Michael S . Tsirkin <mst@redhat.com>; Paolo Bonz=
ini <pbonzini@redhat.com>
> Cc: Gert Wollny <gert.wollny@collabora.com>; qemu-devel@nongnu.org <qemu-=
devel@nongnu.org>; Gurchetan Singh <gurchetansingh@chromium.org>; Alyssa Ro=
ss <hi@alyssa.is>; Roger Pau Monn=C3=A9 <roger.pau@citrix.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>; Stabellini, Stefano <stefano.stabellin=
i@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Ragiadakou, Xenia=
 <Xenia.Ragiadakou@amd.com>; Huang, Honglei1 <Honglei1.Huang@amd.com>; Zhan=
g, Julia <Julia.Zhang@amd.com>; Chen, Jiqian <Jiqian.Chen@amd.com>; Rob Cla=
rk <robdclark@gmail.com>; Yiwei Zhang <zzyiwei@gmail.com>; Sergio Lopez Pas=
cual <slp@redhat.com>
> Subject: [PATCH v14 00/10] Support virtio-gpu DRM native context
>
> This patchset adds DRM native context support to VirtIO-GPU on QEMU.
>
> Contarary to Virgl and Venus contexts that mediates high level GFX APIs,
> DRM native context [1] mediates lower level kernel driver UAPI, which
> reflects in a less CPU overhead and less/simpler code needed to support i=
t.
> DRM context consists of a host and guest parts that have to be implemente=
d
> for each GPU driver. On a guest side, DRM context presents a virtual GPU =
as
> a real/native host GPU device for GL/VK applications.
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
> 1. DRM context uses host blobs and on host requires v6.13 or newer versio=
n
> of Linux kernel that contains necessary KVM fixes.
>
> 2. Use latest available Mesa (both guest and host) and libvirglrenderer
> versions. On guest, build Mesa with enabled virtio native context support=
.
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
> 3. Xorg on guest creates initial dumb buffer that is a vrend buffer, whic=
h
>    can't be re-used by native contexts. This may cause drawing artifacts.
>    Boot kernel with disabled fbdev using drm_client_lib.active=3D"" kerne=
l
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
> v11:- Added column for libvirglrenderer host requrements versions and
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
>     - Added guest kernel minimum versions to the guest requirements table=
.
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
>       "Support  asynchronous fencing" patch, so added it back and verifie=
d
>       that old virglrenderer works properly.
>
>     - Added new patch from Alex Benn=C3=A9e that adds more virtio-gpu
>       documentation with a couple corrections and additions to it from me=
.
>
>     - Rebased patches on top of latest staging tree.
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
>       Alex Benn=C3=A9e.
>
>     - Renamed 'drm=3Don' option of virtio-gpu-gl device to
>       'drm_native_context=3Don' for more clarity as was suggested by
>       Alex Benn=C3=A9e. Haven't added added new context-type option that
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
>
> --
> 2.51.0
>

The whole series looks good to me, and Tested-by: Yiwei Zhang
<zzyiwei@gmail.com>

Besides the reviewed and one with unresolved comment, below are
Acked-by: Yiwei Zhang <zzyiwei@gmail.com>
- [PATCH v14 01/10] ui/sdl2: Restore original context after new context cre=
ation
- [PATCH v14 02/10] ui/sdl2: Implement dpy dmabuf functions
- [PATCH v14 06/10] ui/sdl2: Don't disable scanout when display is refreshe=
d
- [PATCH v14 07/10] ui/gtk: Don't disable scanout when display is refreshed

Cheers!

