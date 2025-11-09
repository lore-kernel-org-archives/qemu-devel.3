Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C96CCFA18
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 01:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHuFZ-0000vN-3e; Sat, 08 Nov 2025 20:29:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zzyiwei@gmail.com>) id 1vHuF4-0000p8-H8
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 20:29:20 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zzyiwei@gmail.com>) id 1vHuF0-00011D-GU
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 20:29:16 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b7272012d30so343717866b.2
 for <qemu-devel@nongnu.org>; Sat, 08 Nov 2025 17:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762651751; x=1763256551; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ioSre0uri1HcX8F58643KibAj36ztKnFO6f3KiJ0vMk=;
 b=kgj/hZ1EFIJx1wwSTrVpK8wuHnsGMap0lpGVS0AjCyMGWrcVAHSfB2aiHqCV2sBUMJ
 k5i9wwCJHX3N867+lno2+xwxL2DYdYA3y+7qmdW+s81NxSK8gMngmkMAugY/jkcyH93O
 zyRhGeZuamua/fC6luarIby5YLf6jNCX39fBXfxyB+QdO6bTYj0SnsHwjtSJQu2yr2SC
 S0ea+Jq2yyte6PvC3VaB5NAH0Cf5QCtX7UR26ExkP9tM4GY37JF1n6ZBzKTofeBHhPby
 GS6pwO4Kh8AGz3uzAJmZQWhl/LknzVNqRPRR6hYbl3K1BWK2DR9Nc6ijwMy9YOgdHrs+
 FMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762651751; x=1763256551;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ioSre0uri1HcX8F58643KibAj36ztKnFO6f3KiJ0vMk=;
 b=mkjQJvsP7n2OKX7uZO0JwFaoAqYn1yqRTaFHH+I4V+1Rt1puBjykM16a11yx4UZqNB
 bw3wE0ezUN2QUXOzRMUGE+AMhAg0np9DPaeMUNLDMVuteFy4z0WiACdsR/PSWoSHG4Dd
 O2i0fKvZZNF8yYOSsFYenMP4PsxzvX2eAWWwx6cO+6iQw6omQtYfkvzPti8lLO+HOjT5
 cLg3JVo6u59mKmdq9Z1eLX6LgDNeJtEpBfeB6m2nlME6/7tClttl+CEULe6H8dhFt7qw
 HHZGeV217fTa+4cr+V546HYtdzZ3lz8aAnrUgzkOwuzkxJcJ+1WDMZgF5AuflVZniAzf
 JBQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6V+uobRjNTm7UHHLMRc2+NMBT/gzu8yLr/tp70IJ7E6bJt1bReWnDx0XFK53ys/DCYO3GyekJT4FD@nongnu.org
X-Gm-Message-State: AOJu0Yx/E13x6PVdNVM9w/9A+unohKuPDseZNEvAM3fv+PAKPeeGnp5j
 f7Xnh70nWAfAr8fvR/75x5ZIiO98KIldwZvEQPZrcTJZ2oGZB0VDKK5wQ46kXn9+G0HaBF2wLBF
 1K0EJ8xV2R/jqH88IFv9fPawsJJkX/88=
X-Gm-Gg: ASbGncu2/52/Cz8DP6nQXpvBHtAaT6gSf9H7jtdp3QWhLK5RxdSLapru3IZTaIB1MQl
 g75jk+eEEzqO2Xe6zqWbom3Fceiiaxv2P6+ksdBBuxtuZRBvCzS+v4R/97jwgK/BK+Ayy28rj77
 hJMN7d+fOVMOaO0O+TwjNLIVrHAX3apo+X3WSQRQuaFV4IfW0P2hJzZKjF7ILPaQ5rX20ret8yx
 Vu4a9BRJiLw4JSrmnGAozGAg8Cw/d9D8y6EF18T/kzDOK6JxSRpPVoi5ZpQPbBuQZ4nSHz9cM9N
 utvmUZo8HSoO2PunaQ==
X-Google-Smtp-Source: AGHT+IHrmP4ax8PiLkyuX24NCT1zzMjc1PW2Hv2OY5xclYDYQsePU6Iil6mVnVtIZgyB1GVWAh4OKTgdEfG/E4oH//E=
X-Received: by 2002:a17:907:7e85:b0:b2d:830a:8c01 with SMTP id
 a640c23a62f3a-b72e0547d84mr364672166b.61.1762651750402; Sat, 08 Nov 2025
 17:29:10 -0800 (PST)
MIME-Version: 1.0
References: <20251020233949.506088-1-dmitry.osipenko@collabora.com>
 <DM8PR12MB543171EE8DB9CD0272C7A99D8DC4A@DM8PR12MB5431.namprd12.prod.outlook.com>
 <CAJ+hS_gGVc++CXCOh6uTcD2H6cn4ZNA_A=EWdWHYyo8HBhUPmg@mail.gmail.com>
In-Reply-To: <CAJ+hS_gGVc++CXCOh6uTcD2H6cn4ZNA_A=EWdWHYyo8HBhUPmg@mail.gmail.com>
From: Yiwei Zhang <zzyiwei@gmail.com>
Date: Sat, 8 Nov 2025 17:29:15 -0800
X-Gm-Features: AWmQ_bnjVZf6RJRBwPk0LxHxG7PGujK6qZabk_zyHPOjOhWiVQMBuycB9T8Vz8Y
Message-ID: <CAJ+hS_j=WRqXZNQCe1DrxjnFB6Haw7nc+fu-2HYoaa2uounMrg@mail.gmail.com>
Subject: Re: [PATCH v14 00/10] Support virtio-gpu DRM native context
To: "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>, "Huang,
 Ray" <Ray.Huang@amd.com>, 
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
 Rob Clark <robdclark@gmail.com>, Sergio Lopez Pascual <slp@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=zzyiwei@gmail.com; helo=mail-ej1-x62d.google.com
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

On Sat, Nov 8, 2025 at 4:06=E2=80=AFAM Yiwei Zhang <zzyiwei@gmail.com> wrot=
e:
>
> On Tue, Nov 4, 2025 at 2:02=E2=80=AFAM Pelloux-Prayer, Pierre-Eric
> <Pierre-eric.Pelloux-prayer@amd.com> wrote:
> >
> > [Public]
> >
> > Hi,
> >
> > The whole series is Acked-by: Pierre-Eric Pelloux-Prayer <pierre-eric.p=
elloux-prayer@amd.com>
> >
> > Thanks a lot Dmitry!
> >
> > Pierre-Eric
> >
> > ________________________________
> > From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Sent: Tuesday, October 21, 2025 1:39 AM
> > To: Akihiko Odaki <akihiko.odaki@daynix.com>; Huang, Ray <Ray.Huang@amd=
.com>; Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>; Philippe Mathi=
eu-Daud=C3=A9 <philmd@linaro.org>; Gerd Hoffmann <kraxel@redhat.com>; Alex =
Benn=C3=A9e <alex.bennee@linaro.org>; Pelloux-Prayer, Pierre-Eric <Pierre-e=
ric.Pelloux-prayer@amd.com>; Michael S . Tsirkin <mst@redhat.com>; Paolo Bo=
nzini <pbonzini@redhat.com>
> > Cc: Gert Wollny <gert.wollny@collabora.com>; qemu-devel@nongnu.org <qem=
u-devel@nongnu.org>; Gurchetan Singh <gurchetansingh@chromium.org>; Alyssa =
Ross <hi@alyssa.is>; Roger Pau Monn=C3=A9 <roger.pau@citrix.com>; Deucher, =
Alexander <Alexander.Deucher@amd.com>; Stabellini, Stefano <stefano.stabell=
ini@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Ragiadakou, Xen=
ia <Xenia.Ragiadakou@amd.com>; Huang, Honglei1 <Honglei1.Huang@amd.com>; Zh=
ang, Julia <Julia.Zhang@amd.com>; Chen, Jiqian <Jiqian.Chen@amd.com>; Rob C=
lark <robdclark@gmail.com>; Yiwei Zhang <zzyiwei@gmail.com>; Sergio Lopez P=
ascual <slp@redhat.com>
> > Subject: [PATCH v14 00/10] Support virtio-gpu DRM native context
> >
> > This patchset adds DRM native context support to VirtIO-GPU on QEMU.
> >
> > Contarary to Virgl and Venus contexts that mediates high level GFX APIs=
,
> > DRM native context [1] mediates lower level kernel driver UAPI, which
> > reflects in a less CPU overhead and less/simpler code needed to support=
 it.
> > DRM context consists of a host and guest parts that have to be implemen=
ted
> > for each GPU driver. On a guest side, DRM context presents a virtual GP=
U as
> > a real/native host GPU device for GL/VK applications.
> >
> > [1] https://www.youtube.com/watch?v=3D9sFP_yddLLQ
> >
> > Today there are four DRM native context drivers existing in a wild:
> >
> >   - Freedreno (Qualcomm SoC GPUs), completely upstreamed
> >   - AMDGPU, completely upstreamed
> >   - Intel (i915), merge requests are opened
> >   - Asahi (Apple SoC GPUs), partially merged upstream
> >
> > # How to try out DRM context:
> >
> > 1. DRM context uses host blobs and on host requires v6.13 or newer vers=
ion
> > of Linux kernel that contains necessary KVM fixes.
> >
> > 2. Use latest available Mesa (both guest and host) and libvirglrenderer
> > versions. On guest, build Mesa with enabled virtio native context suppo=
rt.
> >
> > 3. On guest, use latest Linux kernel v6.14 or newer.
> >
> > Example QEMU cmdline that enables DRM context:
> >
> >   qemu-system-x86_64 -device virtio-vga-gl,hostmem=3D4G,blob=3Don,drm_n=
ative_context=3Don \
> >       -machine q35,accel=3Dkvm -m 8G
> >
> > # Notes about known problems:
> >
> > 1. DRM contexts are mapping host blobs extensively and these mapping
> > operations work slowly in QEMU. We will need to optimize hostmem
> > unmapping that currently happens in a deffered RCU work, blocking
> > GPU for a substantial time. WIP fixes available at [2][3].
> >
> > [2] https://lore.kernel.org/qemu-devel/20251016-force-v1-1-919a82112498=
@rsg.ci.i.u-tokyo.ac.jp/
> > [3] https://lore.kernel.org/qemu-devel/20251014111234.3190346-6-alex.be=
nnee@linaro.org/
> >
> > 2. Linux kernel virtio-gpu driver doesn't limit display refresh rate,
> > causing poor performance. Fix availalble in drm-misc-next tree [4]
> > and should land upstream with v6.19+ kernel.
> >
> > [4] https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/a036f5fceed=
b9fbd715565fef7b824a121503de7
> >
> > 3. Xorg on guest creates initial dumb buffer that is a vrend buffer, wh=
ich
> >    can't be re-used by native contexts. This may cause drawing artifact=
s.
> >    Boot kernel with disabled fbdev using drm_client_lib.active=3D"" ker=
nel
> >    cmdline parameter to work around the issue.
> >
> >    Wayland on guest isn't affected by this issue.
> >
> > Changelog:
> >
> > v14:- Rebased on top of recent QEMU staging tree.
> >
> >     - DRM native context in QEMU now requires virglrenderer v1.2.0+
> >       containing fix for async-fencing not working after guest reboot.
> >
> >     - Updated doc patch with new Asahi nctx rquirements info. Asahi
> >       support landed to virglrenderer v1.2.0.
> >
> > v13:- Updated Asahi nctx MR link in the doc patch. Old MR was closed
> >       and new opened.
> >
> >     - Fixed compiler warning about unused variable when using older
> >       virglrenderer version.
> >
> > v12:- Rebased on top of recent QEMU/staging and a fix from Yiwei Zhang:
> >
> >         https://lore.kernel.org/qemu-devel/20250518152651.334115-1-zzyi=
wei@gmail.com/
> >
> >     - Async-fence and native context features now require virglrenderer=
 > 1.1.1
> >       that contains fix needed for resetting virtio-gpu-gl properly on =
QEMU
> >       reboot:
> >
> >         https://gitlab.freedesktop.org/virgl/virglrenderer/-/commit/6f4=
681ff09cb17aa2d6715dbc6034eb3abe5711d
> >
> >     - Added r-b from Akihiko Odaki to the doc patch.
> >
> >     - Corrected resetting of async fences list that was done on scanout
> >       reset in v11 instead of virtio-gpu reset.
> >
> > v11:- Added column for libvirglrenderer host requrements versions and
> >       corrected Asahi kernel link. Suggested by Akihiko Odaki.
> >
> > v10:- Added links to Asahi and i915 virglrenderer MRs, link to Asahi ho=
st
> >       kernel. Suggested by Akihiko Odaki.
> >
> >     - Renamed gfxstream guest requrements table's colum to match the ho=
st
> >       requirements table. Suggested by Akihiko Odaki.
> >
> > v9: - Updated doc patch by addresing review comments from Akihiko Odaki=
.
> >       Made kernel requirements section specific to guest kernel and
> >       removed reference to host requirements. Removed examples of
> >       external projects' build flags.
> >
> >     - Added guest kernel minimum versions to the guest requirements tab=
le.
> >
> > v8: - Addressed review comments from Akihiko Odaki on the doc patch.
> >
> >     - Added r-bs from Akihiko Odaki on the doc patches.
> >
> >     - Extended vrend doc with info about hostmem requirement for GL 4.6
> >
> > v7: - Added r-b from Alex Benn=C3=A9e to the async fencing patch.
> >
> >     - Updated virtio-gpu doc patch with addressed review comments
> >       from Akihiko Odaki.
> >
> > v6: - Fixed compilation warning using older version of virglrenderer,
> >       which wasn't fixed properly in v5.
> >
> >     - Added t-bs from Alex Benn=C3=A9e.
> >
> >     - Added patches to improve virgl/venus doc by adding links
> >       to the Mesa doc as was suggested by Akihiko Odaki.
> >
> >     - Updated patch that documents guest/host requirements. Added
> >       links to Asahi nctx and reworked the doc structure by adding
> >       requirements to each context-type section instead of having
> >       one big blob or requirements, which was objected by Akihiko Odaki=
.
> >
> > v5: - Added r-bs from Akihiko Odaki.
> >
> >     - Added acks from Michael Tsirkin.
> >
> >     - Fixed compilation warning using older version of virglrenderer th=
at
> >       was reported by Alex Benn=C3=A9e. Noticed that I need to keep old
> >       virgl_write_fence() code around for the older virglrenderer in
> >       "Support  asynchronous fencing" patch, so added it back and verif=
ied
> >       that old virglrenderer works properly.
> >
> >     - Added new patch from Alex Benn=C3=A9e that adds more virtio-gpu
> >       documentation with a couple corrections and additions to it from =
me.
> >
> >     - Rebased patches on top of latest staging tree.
> >
> > v4: - Improved SDL2/dmabuf patch by reusing existing Meson X11 config
> >       option, better handling EGL error and extending comment telling
> >       that it's safe to enable SDL2 EGL preference hint. As was suggest=
ed
> >       by Akihiko Odaki.
> >
> >     - Replaced another QSLIST_FOREACH_SAFE with QSLIST_EMPTY+FIRST in
> >       the async-fencing patch for more consistency of the code. As was
> >       suggested by Akihiko Odaki.
> >
> >     - Added missing braces around if-statement that was spotted by
> >       Alex Benn=C3=A9e.
> >
> >     - Renamed 'drm=3Don' option of virtio-gpu-gl device to
> >       'drm_native_context=3Don' for more clarity as was suggested by
> >       Alex Benn=C3=A9e. Haven't added added new context-type option tha=
t
> >       was also proposed by Alex, might do it with a separate patch.
> >       This context-type option will duplicate and depecate existing
> >       options, but in a longer run likely will be worthwhile adding
> >       it.
> >
> >     - Dropped Linux headers-update patch as headers has been updated
> >       in the staging tree.
> >
> > v3: - Improved EGL presence-check code on X11 systems for the SDL2
> >       hint that prefers EGL over GLX by using better ifdefs and checkin=
g
> >       Xlib presence at a build time to avoid build failure if lib SDL2
> >       and system are configured with a disabled X11 support. Also added
> >       clarifying comment telling that X11 hint doesn't affect Wayland
> >       systems. Suggested by Akihiko Odaki.
> >
> >     - Corrected strerror(err) that used negative error where it should
> >       be positive and vice versa that was caught by Akihiko Odaki. Adde=
d
> >       clarifying comment for the case where we get positive error code
> >       from virglrenderer that differs from other virglrenderer API func=
tions.
> >
> >     - Improved QSLIST usage by dropping mutex protecting the async fenc=
e
> >       list and using atomic variant of QSLIST helpers instead. Switched=
 away
> >       from using FOREACH helper to improve readability of the code, sho=
wing
> >       that we don't precess list in unoptimal way. Like was suggested b=
y
> >       Akihiko Odaki.
> >
> >     - Updated patchset base to Venus v18.
> >
> > v2: - Updated SDL2-dmabuf patch by making use of error_report() and
> >       checking presense of X11+EGL in the system before making SDL2
> >       to prefer EGL backend over GLX, suggested by Akihiko Odaki.
> >
> >     - Improved SDL2's dmabuf-presence check that wasn't done properly
> >       in v1, where EGL was set up only after first console was fully
> >       inited, and thus, SDL's display .has_dmabuf callback didn't work
> >       for the first console. Now dmabuf support status is pre-checked
> >       before console is registered.
> >
> >     - Updated commit description of the patch that fixes SDL2's context
> >       switching logic with a more detailed explanation of the problem.
> >       Suggested by Akihiko Odaki.
> >
> >     - Corrected rebase typo in the async-fencing patch and switched
> >       async-fencing to use a sigle-linked list instead of the double,
> >       as was suggested by Akihiko Odaki.
> >
> >     - Replaced "=3Dtrue" with "=3Don" in the DRM native context documen=
tation
> >       example and made virtio_gpu_virgl_init() to fail with a error mes=
sage
> >       if DRM context can't be initialized instead of giving a warning
> >       message, as was suggested by Akihiko Odaki.
> >
> >     - Added patchew's dependecy tag to the cover letter as was suggeste=
d by
> >       Akihiko Odaki.
> >
> > Alex Benn=C3=A9e (1):
> >   docs/system: virtio-gpu: Document host/guest requirements
> >
> > Dmitry Osipenko (8):
> >   ui/sdl2: Restore original context after new context creation
> >   virtio-gpu: Handle virgl fence creation errors
> >   virtio-gpu: Support asynchronous fencing
> >   virtio-gpu: Support DRM native context
> >   ui/sdl2: Don't disable scanout when display is refreshed
> >   ui/gtk: Don't disable scanout when display is refreshed
> >   docs/system: virtio-gpu: Add link to Mesa VirGL doc
> >   docs/system: virtio-gpu: Update Venus link
> >
> > Pierre-Eric Pelloux-Prayer (1):
> >   ui/sdl2: Implement dpy dmabuf functions
> >
> >  docs/system/devices/virtio-gpu.rst | 116 +++++++++++++++++-
> >  hw/display/virtio-gpu-gl.c         |   7 ++
> >  hw/display/virtio-gpu-virgl.c      | 185 ++++++++++++++++++++++++++++-
> >  hw/display/virtio-gpu.c            |  15 +++
> >  include/hw/virtio/virtio-gpu.h     |  14 +++
> >  include/ui/sdl2.h                  |   7 ++
> >  meson.build                        |   8 +-
> >  ui/gtk-egl.c                       |   1 -
> >  ui/gtk-gl-area.c                   |   1 -
> >  ui/sdl2-gl.c                       |  70 ++++++++++-
> >  ui/sdl2.c                          |  42 +++++++
> >  11 files changed, 449 insertions(+), 17 deletions(-)
> >
> > --
> > 2.51.0
> >
>
> The whole series looks good to me, and Tested-by: Yiwei Zhang
> <zzyiwei@gmail.com>

Just to clarify. My testing is done with venus + virgl to verify async
fence cb in QEMU is working as intended.

>
> Besides the reviewed and one with unresolved comment, below are
> Acked-by: Yiwei Zhang <zzyiwei@gmail.com>
> - [PATCH v14 01/10] ui/sdl2: Restore original context after new context c=
reation
> - [PATCH v14 02/10] ui/sdl2: Implement dpy dmabuf functions
> - [PATCH v14 06/10] ui/sdl2: Don't disable scanout when display is refres=
hed
> - [PATCH v14 07/10] ui/gtk: Don't disable scanout when display is refresh=
ed
>
> Cheers!

