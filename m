Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F41CFB440
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2024 23:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxade-0004Zn-JV; Sun, 06 Oct 2024 19:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sxadc-0004ZP-O9
 for qemu-devel@nongnu.org; Sun, 06 Oct 2024 19:26:08 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sxada-0006YN-5O
 for qemu-devel@nongnu.org; Sun, 06 Oct 2024 19:26:08 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1728257152; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XF9MvaTN4r+XrmHtKog6Bgj7+Nej6JQgUcCqn4Xmeh63fM4Eze0iQdBAgAAJ0qKjiK5dzF4xqOCJQS8kcMH4UPxq58VBjRPwcXS5iy0TsE9v6mKU2njRhMm3aX0mWFnf1YKh3mjkQofq+xXYYaI+Jg3fZvM8P1czIsjkM6M6+bA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1728257152;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=9TM082r4TvLK+vLOkloKNZxtKZsN5cJ9v3wGKgaf8xQ=; 
 b=YQvXiad1hCjAhtZ0z9H2RqPec9VZ6wuPkoXBNrXZxpQIn0bzG0MB2Jf9VWKWmUKAgXBcvEo9aFQXYxGcACEqs32ZeQ36da8FQ0KKwkrKn5AFkZYcxpJpLbYpbgNzxaLWweW+peQu2W+oTDWYnubwhsyobGN1u5bPhEOnmFzNuLQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728257152; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=9TM082r4TvLK+vLOkloKNZxtKZsN5cJ9v3wGKgaf8xQ=;
 b=GO1PQ0N5+BA1ykZJIxQ6U/uL8Ss43Q3TSgAMoCJke16tZ7qIeqlwF94JXHsngPSg
 yRacR4A/N4FoUTYhMbGEcMl+aHiiLH3hO9ryGOYMJJuFSzYw/N9tpCHSKMfuUgz+Ns0
 LlwZ82JVMWZWrHQYaH5ZHZgrYZgpw3ylHD0FCg0g=
Received: by mx.zohomail.com with SMTPS id 17282571510241008.1980387597356;
 Sun, 6 Oct 2024 16:25:51 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>
Subject: [PATCH v1 0/6] Support virtio-gpu DRM native context
Date: Mon,  7 Oct 2024 02:23:42 +0300
Message-ID: <20241006232350.3198759-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

This patchset adds DRM native context support to VirtIO-GPU on Qemu.
It's based on the pending Venus v17 patches [1] that bring host blobs
support to virtio-gpu-gl device.

[1] https://lore.kernel.org/qemu-devel/20240822185110.1757429-1-dmitry.osipenko@collabora.com/

Contarary to Virgl and Venus contexts which mediate high level GFX APIs,
DRM native context [2] mediates lower level kernel driver UAPI, which
reflects in a less CPU overhead and less/simpler code needed to support it.
DRM context consists of a host and guest parts that have to be implemented
for each GPU driver. On a guest side, DRM context presents a virtual GPU as
a real/native host GPU device for GL/VK applications.

[2] https://www.youtube.com/watch?v=9sFP_yddLLQ

Today there are four known DRM native context drivers existing in a wild:

  - Freedreno (Qualcomm SoC GPUs), completely upstreamed
  - AMDGPU, mostly merged into upstreams
  - Intel (i915), merge requests are opened
  - Asahi (Apple SoC GPUs), WIP status


# How to try out DRM context:

1. Like Venus and Virgl context, DRM context requires applying WIP
KVM patches [3] to host kernel, otherwise mapping of GPU memory blobs
will likely fail.

[3] https://lore.kernel.org/all/20240726235234.228822-1-seanjc@google.com/

2. Use latest libvirglrenderer from upstream git/main for Freedreno
and AMDGPU native contexts. For Intel use patches [4].

[4] https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1384

3. On guest, use latest Mesa version for Freedreno. For AMDGPU use
Mesa patches [5], for Intel [6].

[5] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/21658
[6] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/29870

4. On guest, use latest Linux kernel v6.6+.

Example Qemu cmdline that enables DRM context:

  qemu-system-x86_64 -device virtio-vga-gl,hostmem=4G,blob=true,drm=true \
      -machine q35,accel=kvm,memory-backend=mem1 \
      -object memory-backend-memfd,id=mem1,size=8G -m 8G


# Note about known performance problem in Qemu:

DRM contexts are mapping host blobs extensively and these mapping
operations work slowly in Qemu. Exact reason is unkown. Mappings work
fast on Crosvm For DRM contexts this problem is more visible than for
Venus/Virgl.

Dmitry Osipenko (5):
  ui/sdl2: Restore original context after new context creation
  linux-headers: Update to Linux v6.12-rc1
  virtio-gpu: Handle virgl fence creation errors
  virtio-gpu: Support asynchronous fencing
  virtio-gpu: Support DRM native context

Pierre-Eric Pelloux-Prayer (1):
  ui/sdl2: Implement dpy dmabuf functions

 docs/system/devices/virtio-gpu.rst            |  11 +
 hw/display/virtio-gpu-gl.c                    |   5 +
 hw/display/virtio-gpu-virgl.c                 | 153 ++++++++++--
 hw/display/virtio-gpu.c                       |  15 ++
 include/hw/virtio/virtio-gpu.h                |  17 ++
 include/standard-headers/drm/drm_fourcc.h     |  43 ++++
 include/standard-headers/linux/const.h        |  17 ++
 include/standard-headers/linux/ethtool.h      | 226 ++++++++++++++++++
 include/standard-headers/linux/fuse.h         |  22 +-
 .../linux/input-event-codes.h                 |   2 +
 include/standard-headers/linux/pci_regs.h     |  41 +++-
 .../standard-headers/linux/virtio_balloon.h   |  16 +-
 include/standard-headers/linux/virtio_gpu.h   |   1 +
 include/ui/sdl2.h                             |   5 +
 linux-headers/asm-arm64/mman.h                |   9 +
 linux-headers/asm-arm64/unistd.h              |  25 +-
 linux-headers/asm-generic/unistd.h            |   6 +-
 linux-headers/asm-loongarch/kvm.h             |  24 ++
 linux-headers/asm-loongarch/unistd.h          |   4 +-
 linux-headers/asm-riscv/kvm.h                 |   7 +
 linux-headers/asm-riscv/unistd.h              |  41 +---
 linux-headers/asm-x86/kvm.h                   |   2 +
 linux-headers/asm-x86/unistd_64.h             |   1 +
 linux-headers/asm-x86/unistd_x32.h            |   1 +
 linux-headers/linux/bits.h                    |   3 +
 linux-headers/linux/const.h                   |  17 ++
 linux-headers/linux/iommufd.h                 | 143 +++++++++--
 linux-headers/linux/kvm.h                     |  23 +-
 linux-headers/linux/mman.h                    |   1 +
 linux-headers/linux/psp-sev.h                 |  28 +++
 ui/sdl2-gl.c                                  |  42 ++++
 ui/sdl2.c                                     |   8 +
 32 files changed, 851 insertions(+), 108 deletions(-)

-- 
2.46.0


