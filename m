Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BA4C54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 23:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIbut-0003Kh-PZ; Fri, 23 May 2025 19:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uIbus-0003J0-7L
 for qemu-devel@nongnu.org; Fri, 23 May 2025 19:35:06 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uIbup-00027D-Dy
 for qemu-devel@nongnu.org; Fri, 23 May 2025 19:35:05 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1748043284; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ASUiQbGa9YDLFAu07Q067gEFtUQdAjNX5hM2FGlrJCSgd5fsKlu/ChqItLtkDxVUzHC4G3sM2k3wsNBHoEZgxbqhYAFBK9Ycswm6mibutUWvLv6eif2rzXpFLythzaGH3eWVhDvGjbSAHIJ6DWtcFrK514pmQNcNDs7SMbBgi6k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1748043284;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=h6ZEUoDGBGxGEQzUIEKFgH7xWj1rcpVFObkuEHSCN2M=; 
 b=E6WdL2wQZPuvXH7UrTajloeHf4vkZ0yAxMfx9emd2IWOxKijigtp0IwtuRxd/GlVxtuJn+MyQ5xz8ic8L5JtI7a5ez3mmKFjS64Un8qCsdTNC7u2lhKN9KEW0FMyW/cR0hRErf+Caohor8c8o4flSSNkv2jG1vcIoxcgEcEcBOo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1748043284; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=h6ZEUoDGBGxGEQzUIEKFgH7xWj1rcpVFObkuEHSCN2M=;
 b=DSmy+xiIx64zGW5D+rUSui9zTk80oHSW7bGQA3sN3KMEQB+QIYQqDp2vfI+MJkI4
 qJtRh5ZClbIJrE0OuPJlFXv/l1o9ZjpqkYhEjvtYgTuo2PX3V8cBrwalpc7idqRG9qv
 SXNlxzWhrsV6iBy5DjvwN5UepG3X2AC96FVK/C2A=
Received: by mx.zohomail.com with SMTPS id 1748043283744630.0139984678375;
 Fri, 23 May 2025 16:34:43 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
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
Subject: [PATCH v12 00/10] Support virtio-gpu DRM native context
Date: Sat, 24 May 2025 02:32:55 +0300
Message-ID: <20250523233305.433424-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.49.0
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This patchset adds DRM native context support to VirtIO-GPU on Qemu.

Contarary to Virgl and Venus contexts that mediates high level GFX APIs,
DRM native context [1] mediates lower level kernel driver UAPI, which
reflects in a less CPU overhead and less/simpler code needed to support it.
DRM context consists of a host and guest parts that have to be implemented
for each GPU driver. On a guest side, DRM context presents a virtual GPU as
a real/native host GPU device for GL/VK applications.

Based-on: 20250518152651.334115-1-zzyiwei@gmail.com

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

Example Qemu cmdline that enables DRM context:

  qemu-system-x86_64 -device virtio-vga-gl,hostmem=4G,blob=on,drm_native_context=on \
      -machine q35,accel=kvm,memory-backend=mem1 \
      -object memory-backend-memfd,id=mem1,size=8G -m 8G

# Note about known performance problem in Qemu:

DRM contexts are mapping host blobs extensively and these mapping
operations work slowly in Qemu. We will need to optimize hostmem
unmapping that currently happens in a deffered RCU work, blocking
GPU for a substantial time [2].

[2] https://lore.kernel.org/qemu-devel/f58d250d-3831-4ff1-a018-f62f9aeb2527@collabora.com/T/#m17ac72336d28a64c793d4e4e0c87fc7dff9aa847

Changelog:

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

 docs/system/devices/virtio-gpu.rst | 117 +++++++++++++++++-
 hw/display/virtio-gpu-gl.c         |   7 ++
 hw/display/virtio-gpu-virgl.c      | 186 ++++++++++++++++++++++++++++-
 hw/display/virtio-gpu.c            |  15 +++
 include/hw/virtio/virtio-gpu.h     |  14 +++
 include/ui/sdl2.h                  |   7 ++
 meson.build                        |   8 +-
 ui/gtk-egl.c                       |   1 -
 ui/gtk-gl-area.c                   |   1 -
 ui/sdl2-gl.c                       |  70 ++++++++++-
 ui/sdl2.c                          |  42 +++++++
 11 files changed, 451 insertions(+), 17 deletions(-)

-- 
2.49.0


