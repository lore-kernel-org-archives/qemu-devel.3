Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CCACEACEF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Nov 2025 12:58:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKcKI-0005GK-Q4; Sun, 16 Nov 2025 07:57:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vKcKH-0005Fu-1P
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 07:57:53 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vKcKE-0008Ic-Hr
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 07:57:52 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1763297848; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=k1X6FoG7JXczWYgGn1QHkJ8sB5ek450iljJYhMoKZYd43gU+BCApD6o0RsrOzye/3/ZyHqLKO2uJYI9fetaC/08ZwLNumCig7uiLstsYX7dbpmjP/Izz1km8hDhANWcKtraC0cinBT4a1B+VyasyPYE1KMaX1x9qlFcxtfOqA+A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1763297848;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=3Qk5zJqjVdS/BK3eJuBKOmV02gUOgZRXXpGCYqXoZ3Q=; 
 b=EF1BVNNXOH4c0R3ASHn3PgIXsscmXHI6GirBPrLm27qJMrx1Q8SznzQVM94kXoD2rKmLktS4BQFFx1qbwa+zuf+AYzWiHhIZ6wPJtI6ZW5g8DlPE4P9uInEDuPL+gXCC8qHFa1EdPivS+7RtfNFQ0SNGaLiVQYlQXOwAYylgWTo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763297848; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=3Qk5zJqjVdS/BK3eJuBKOmV02gUOgZRXXpGCYqXoZ3Q=;
 b=Fij2wqdRVHW5gjLvaiSijNxlsM7WFEdaS93rLxYfqu7jXnkribdUbLnUdeCVyOWL
 h2Yp2DBWwR/NgLnLSN0N0mD/wYnlf5YRzEI7qO9wYTdaOW25/GycTOqbiYNcDimFePK
 ObIG2MDM1Jq0uaNPsdmFnnsYK/g+CeSpYRRRipTQ=
Received: by mx.zohomail.com with SMTPS id 1763297846633875.2624930110816;
 Sun, 16 Nov 2025 04:57:26 -0800 (PST)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@gmail.com>, Sergio Lopez Pascual <slp@redhat.com>
Subject: [PATCH v16 00/10] Support virtio-gpu DRM native context
Date: Sun, 16 Nov 2025 15:56:31 +0300
Message-ID: <20251116125641.2255794-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This patchset adds DRM native context support to VirtIO-GPU on QEMU.

Contarary to Virgl and Venus contexts that mediates high level GFX APIs,
DRM native context [1] mediates lower level kernel driver UAPI, which
reflects in a less CPU overhead and less/simpler code needed to support it.
DRM context consists of a host and guest parts that have to be implemented
for each GPU driver. On a guest side, DRM context presents a virtual GPU as
a real/native host GPU device for GL/VK applications.

[1] https://www.youtube.com/watch?v=9sFP_yddLLQ

Today there are four DRM native context drivers existing in a wild:

  - Freedreno (Qualcomm SoC GPUs), completely upstreamed
  - AMDGPU, completely upstreamed
  - Intel (i915), merge requests are opened
  - Asahi (Apple SoC GPUs), partially merged upstream

# How to try out DRM context:

1. DRM context uses host blobs and on host requires v6.13 or newer version
of Linux kernel that contains necessary KVM fixes.

2. Use latest available Mesa (both guest and host) and libvirglrenderer 
versions. On guest, build Mesa with enabled virtio native context support.

3. On guest, use latest Linux kernel v6.14 or newer.

Example QEMU cmdline that enables DRM context:

  qemu-system-x86_64 -device virtio-vga-gl,hostmem=4G,blob=on,drm_native_context=on \
      -machine q35,accel=kvm -m 8G

Using latest virglrenderer-git version + drm-misc-next guest kernel +
my QEMU branch [5] is recommended for the testing. See notes on the perf
problems below.

# Known problems:

1. DRM contexts are mapping host blobs extensively and these mapping
operations work slowly in QEMU. This will be sorted out with addition of
MAP_FIXED support in next versions of virglrenderer and QEMU [4][5][6].

[4] https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1374
[5] https://gitlab.freedesktop.org/digetx/qemu/-/commits/native-context-v16
[6] https://lore.kernel.org/qemu-devel/20251112233118.1475381-2-dmitry.osipenko@collabora.com/

2. Linux kernel virtio-gpu driver doesn't limit display refresh rate,
causing poor performance. Fix availalble in drm-misc-next tree [7]
and should land upstream with v6.19+ kernel.

[7] https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/a036f5fceedb9fbd715565fef7b824a121503de7

3. Xorg on guest creates initial dumb buffer that is a vrend buffer, which
   can't be re-used by native contexts. This may cause drawing artifacts.
   Boot kernel with disabled fbdev using drm_client_lib.active="" kernel
   cmdline parameter to work around the issue.

   Wayland on guest isn't affected by this issue.

Changelog:

v16:- Applied async-fence improvement suggested by Yiwei Zhang on v14

v15:- Added ack/rb/tb from Pierre-Eric Pelloux-Prayer and Yiwei Zhang.

    - Applied minor cosmetic code change suggested by Yiwei Zhang on v14.

v14:- Rebased on top of recent QEMU staging tree.

    - DRM native context in QEMU now requires virglrenderer v1.2.0+
      containing fix for async-fencing not working after guest reboot.

    - Updated doc patch with new Asahi nctx rquirements info. Asahi
      support landed to virglrenderer v1.2.0.

v13:- Updated Asahi nctx MR link in the doc patch. Old MR was closed
      and new opened.

    - Fixed compiler warning about unused variable when using older
      virglrenderer version.

v12:- Rebased on top of recent QEMU/staging and a fix from Yiwei Zhang:

        https://lore.kernel.org/qemu-devel/20250518152651.334115-1-zzyiwei@gmail.com/

    - Async-fence and native context features now require virglrenderer > 1.1.1
      that contains fix needed for resetting virtio-gpu-gl properly on QEMU
      reboot:

        https://gitlab.freedesktop.org/virgl/virglrenderer/-/commit/6f4681ff09cb17aa2d6715dbc6034eb3abe5711d

    - Added r-b from Akihiko Odaki to the doc patch.

    - Corrected resetting of async fences list that was done on scanout
      reset in v11 instead of virtio-gpu reset.

v11:- Added column for libvirglrenderer host requrements versions and 
      corrected Asahi kernel link. Suggested by Akihiko Odaki.

v10:- Added links to Asahi and i915 virglrenderer MRs, link to Asahi host
      kernel. Suggested by Akihiko Odaki.

    - Renamed gfxstream guest requrements table's colum to match the host
      requirements table. Suggested by Akihiko Odaki.

v9: - Updated doc patch by addresing review comments from Akihiko Odaki.
      Made kernel requirements section specific to guest kernel and
      removed reference to host requirements. Removed examples of
      external projects' build flags.

    - Added guest kernel minimum versions to the guest requirements table.

v8: - Addressed review comments from Akihiko Odaki on the doc patch.

    - Added r-bs from Akihiko Odaki on the doc patches.

    - Extended vrend doc with info about hostmem requirement for GL 4.6

v7: - Added r-b from Alex Bennée to the async fencing patch.

    - Updated virtio-gpu doc patch with addressed review comments
      from Akihiko Odaki.

v6: - Fixed compilation warning using older version of virglrenderer,
      which wasn't fixed properly in v5.

    - Added t-bs from Alex Bennée.

    - Added patches to improve virgl/venus doc by adding links
      to the Mesa doc as was suggested by Akihiko Odaki.

    - Updated patch that documents guest/host requirements. Added
      links to Asahi nctx and reworked the doc structure by adding
      requirements to each context-type section instead of having
      one big blob or requirements, which was objected by Akihiko Odaki.

v5: - Added r-bs from Akihiko Odaki.

    - Added acks from Michael Tsirkin.

    - Fixed compilation warning using older version of virglrenderer that
      was reported by Alex Bennée. Noticed that I need to keep old
      virgl_write_fence() code around for the older virglrenderer in
      "Support  asynchronous fencing" patch, so added it back and verified
      that old virglrenderer works properly.

    - Added new patch from Alex Bennée that adds more virtio-gpu 
      documentation with a couple corrections and additions to it from me.

    - Rebased patches on top of latest staging tree.

v4: - Improved SDL2/dmabuf patch by reusing existing Meson X11 config 
      option, better handling EGL error and extending comment telling
      that it's safe to enable SDL2 EGL preference hint. As was suggested
      by Akihiko Odaki.

    - Replaced another QSLIST_FOREACH_SAFE with QSLIST_EMPTY+FIRST in
      the async-fencing patch for more consistency of the code. As was
      suggested by Akihiko Odaki.

    - Added missing braces around if-statement that was spotted by
      Alex Bennée.

    - Renamed 'drm=on' option of virtio-gpu-gl device to 
      'drm_native_context=on' for more clarity as was suggested by 
      Alex Bennée. Haven't added added new context-type option that 
      was also proposed by Alex, might do it with a separate patch.
      This context-type option will duplicate and depecate existing
      options, but in a longer run likely will be worthwhile adding
      it.

    - Dropped Linux headers-update patch as headers has been updated
      in the staging tree.

v3: - Improved EGL presence-check code on X11 systems for the SDL2
      hint that prefers EGL over GLX by using better ifdefs and checking
      Xlib presence at a build time to avoid build failure if lib SDL2
      and system are configured with a disabled X11 support. Also added
      clarifying comment telling that X11 hint doesn't affect Wayland
      systems. Suggested by Akihiko Odaki.

    - Corrected strerror(err) that used negative error where it should
      be positive and vice versa that was caught by Akihiko Odaki. Added
      clarifying comment for the case where we get positive error code
      from virglrenderer that differs from other virglrenderer API functions.

    - Improved QSLIST usage by dropping mutex protecting the async fence
      list and using atomic variant of QSLIST helpers instead. Switched away
      from using FOREACH helper to improve readability of the code, showing
      that we don't precess list in unoptimal way. Like was suggested by
      Akihiko Odaki.

    - Updated patchset base to Venus v18.

v2: - Updated SDL2-dmabuf patch by making use of error_report() and
      checking presense of X11+EGL in the system before making SDL2
      to prefer EGL backend over GLX, suggested by Akihiko Odaki.

    - Improved SDL2's dmabuf-presence check that wasn't done properly
      in v1, where EGL was set up only after first console was fully
      inited, and thus, SDL's display .has_dmabuf callback didn't work
      for the first console. Now dmabuf support status is pre-checked
      before console is registered.

    - Updated commit description of the patch that fixes SDL2's context
      switching logic with a more detailed explanation of the problem.
      Suggested by Akihiko Odaki.

    - Corrected rebase typo in the async-fencing patch and switched
      async-fencing to use a sigle-linked list instead of the double,
      as was suggested by Akihiko Odaki.

    - Replaced "=true" with "=on" in the DRM native context documentation
      example and made virtio_gpu_virgl_init() to fail with a error message
      if DRM context can't be initialized instead of giving a warning
      message, as was suggested by Akihiko Odaki.

    - Added patchew's dependecy tag to the cover letter as was suggested by
      Akihiko Odaki.

Alex Bennée (1):
  docs/system: virtio-gpu: Document host/guest requirements

Dmitry Osipenko (8):
  ui/sdl2: Restore original context after new context creation
  virtio-gpu: Handle virgl fence creation errors
  virtio-gpu: Support asynchronous fencing
  virtio-gpu: Support DRM native context
  ui/sdl2: Don't disable scanout when display is refreshed
  ui/gtk: Don't disable scanout when display is refreshed
  docs/system: virtio-gpu: Add link to Mesa VirGL doc
  docs/system: virtio-gpu: Update Venus link

Pierre-Eric Pelloux-Prayer (1):
  ui/sdl2: Implement dpy dmabuf functions

 docs/system/devices/virtio/virtio-gpu.rst | 116 +++++++++++++-
 hw/display/virtio-gpu-gl.c                |   7 +
 hw/display/virtio-gpu-virgl.c             | 182 +++++++++++++++++++++-
 hw/display/virtio-gpu.c                   |  15 ++
 include/hw/virtio/virtio-gpu.h            |  14 ++
 include/ui/sdl2.h                         |   7 +
 meson.build                               |   8 +-
 ui/gtk-egl.c                              |   1 -
 ui/gtk-gl-area.c                          |   1 -
 ui/sdl2-gl.c                              |  70 ++++++++-
 ui/sdl2.c                                 |  42 +++++
 11 files changed, 446 insertions(+), 17 deletions(-)

-- 
2.51.1


