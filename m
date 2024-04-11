Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B47CD128A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 10:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rurYV-0006y1-Nj; Thu, 11 Apr 2024 06:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1rurYN-0006Jl-9D
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:21:12 -0400
Received: from madrid.collaboradmins.com ([2a00:1098:ed:100::25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1rurYK-00004u-Qd
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1712830860;
 bh=K8LTZsxmkUTaFGGeyu4wDUh8gsvchUcSYgzf1f19Puc=;
 h=From:To:Cc:Subject:Date:From;
 b=ZGO7nIyz81DgZKvP8s/PFxUj0HzfIjcZbcK02i+ui2dd7sU1wh0inkNhiDJcOwUgr
 EoVE9qun1Djb20LMJMpdRbk0ieAeF1O5L3TJQ6T4pNxW8Lig6j+kmcOBwQ++uIMaWW
 Kd2sNmSS5JwU3a8bcV/YJEpm543SqRTAcPaD3kSpZ629QLd5swOSlga5Ff8uLeF74J
 cUVxSJzgZFtEuY7I19eX1O4Nr3dw2uDqaZI+zNhogE1DS0tiiycY19mdEj/MQ+CKvR
 e3uQiDdPzXMlC5EqFnhUkCnpyFNzUJki8/SPwPvAR38egSULwpkOiNWcctQyBKOfRr
 i60xtjdfeu5uw==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id CA1D5378000B;
 Thu, 11 Apr 2024 10:20:58 +0000 (UTC)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 ernunes@redhat.com, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>
Subject: [PATCH v7 00/10] Support blob memory and venus on qemu
Date: Thu, 11 Apr 2024 13:19:52 +0300
Message-ID: <20240411102002.240536-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:ed:100::25;
 envelope-from=dmitry.osipenko@collabora.com; helo=madrid.collaboradmins.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hello,

This series enables Vulkan Venus context support on virtio-gpu.
Upstreaming of Venus to Qemu was originally started by Antonio Caggiano,
later Huang Rui continued the effort. I'm now taking it over because
Rui will be busy for awhile and he asked me to do so.

All virglrender and almost all Linux kernel prerequisite changes
needed by Venus are already in upstream. For kernel there is a pending
KVM patchset that fixes mapping of compound pages needed for DRM drivers
using TTM [1], othewrwise hostmem blob mapping will fail with a KVM error
from Qemu.

[1] https://lore.kernel.org/kvm/20240229025759.1187910-1-stevensd@google.com/

Part of the credit for the work on v7 goes to Huang Rui. He addressed
some of v6 review comments and I picked up from where he left.

Example Qemu cmdline that enables Venus for virtio-gpu:

  qemu-system-x86_64 -device virtio-vga-gl,hostmem=4G,blob=true,vulkan=true


Changes from V6 to V7

- Used scripts/update-linux-headers.sh to update Qemu headers based
  on Linux v6.8-rc3 that adds Venus capset definition to virtio-gpu
  protocol, was requested by Peter Maydel

- Added r-bs that were given to v6 patches. Corrected missing s-o-bs

- Dropped context_init Qemu's virtio-gpu device configuration flag,
  was suggested by Marc-André Lureau

- Added missing error condition checks spotted by Marc-André Lureau
  and Akihiko Odaki, and few more

- Returned back res->mr referencing to memory_region_init_ram_ptr() like
  was suggested by Akihiko Odaki. Incorporated fix suggested by Pierre-Eric
  to specify the MR name

- Dropped the virgl_gpu_resource wrapper, cleaned up and simplified
  patch that adds blob-cmd support

- Fixed improper blob resource removal from resource list on resource_unref
  that was spotted by Akihiko Odaki

- Change order of the blob patches, was suggested by Akihiko Odaki.
  The cmd_set_scanout_blob support is enabled first

- Factored out patch that adds resource management support to virtio-gpu-gl,
  was requested by Marc-André Lureau

- Simplified and improved the UUID support patch, dropped the hash table
  as we don't need it for now. Moved QemuUUID to virtio_gpu_simple_resource.
  This all was suggested by Akihiko Odaki and Marc-André Lureau

- Dropped console_has_gl() check, suggested by Akihiko Odaki

- Reworked Meson cheking of libvirglrender features, made new features
  available based on virglrender pkgconfig version instead of checking
  symbols in header. This should fix build error using older virglrender
  version, reported by Alex Bennée

- Made enabling of Venus context configrable via new virtio-gpu device
  "vulkan=true" flag, suggested by Marc-André Lureau. The flag is disabled
  by default because it requires blob and hostmem options to be enabled
  and configured

Changes from V5 to V6

- Move macros configurations under virgl.found() and rename
  HAVE_VIRGL_CONTEXT_CREATE_WITH_FLAGS.

- Handle the case while context_init is disabled.

- Enable context_init by default.

- Move virtio_gpu_virgl_resource_unmap() into
  virgl_cmd_resource_unmap_blob().

- Introduce new struct virgl_gpu_resource to store virgl specific members.

- Remove erro handling of g_new0, because glib will abort() on OOM.

- Set resource uuid as option.

- Implement optional subsection of vmstate_virtio_gpu_resource_uuid_state
  for virtio live migration.

- Use g_int_hash/g_int_equal instead of the default

- Add scanout_blob function for virtio-gpu-virgl

- Resolve the memory leak on virtio-gpu-virgl

- Remove the unstable API flags check because virglrenderer is already 1.0

- Squash the render server flag support into "Initialize Venus"

Changes from V4 (virtio gpu V4) to V5

- Inverted patch 5 and 6 because we should configure
  HAVE_VIRGL_CONTEXT_INIT firstly.

- Validate owner of memory region to avoid slowing down DMA.

- Use memory_region_init_ram_ptr() instead of
  memory_region_init_ram_device_ptr().

- Adjust sequence to allocate gpu resource before virglrender resource
  creation

- Add virtio migration handling for uuid.

- Send kernel patch to define VIRTIO_GPU_CAPSET_VENUS.
  https://lore.kernel.org/lkml/20230915105918.3763061-1-ray.huang@amd.com/

- Add meson check to make sure unstable APIs defined from 0.9.0.

Changes from V1 to V2 (virtio gpu V4)

- Remove unused #include "hw/virtio/virtio-iommu.h"

- Add a local function, called virgl_resource_destroy(), that is used
  to release a vgpu resource on error paths and in resource_unref.

- Remove virtio_gpu_virgl_resource_unmap from
  virtio_gpu_cleanup_mapping(),
  since this function won't be called on blob resources and also because
  blob resources are unmapped via virgl_cmd_resource_unmap_blob().

- In virgl_cmd_resource_create_blob(), do proper cleanup in error paths
  and move QTAILQ_INSERT_HEAD(&g->reslist, res, next) after the resource
  has been fully initialized.

- Memory region has a different life-cycle from virtio gpu resources
  i.e. cannot be released synchronously along with the vgpu resource.
  So, here the field "region" was changed to a pointer and is allocated
  dynamically when the blob is mapped.
  Also, since the pointer can be used to indicate whether the blob
  is mapped, the explicite field "mapped" was removed.

- In virgl_cmd_resource_map_blob(), add check on the value of
  res->region, to prevent beeing called twice on the same resource.

- Add a patch to enable automatic deallocation of memory regions to resolve
  use-after-free memory corruption with a reference.

Antonio Caggiano (4):
  virtio-gpu: Handle resource blob commands
  virtio-gpu: Resource UUID
  virtio-gpu: Support Venus capset
  virtio-gpu: Initialize Venus

Dmitry Osipenko (3):
  linux-headers: Update to Linux v6.9-rc3
  virtio-gpu: Use pkgconfig version to decide which virgl features are
    available
  virtio-gpu: Don't require udmabuf when blobs and virgl are enabled

Huang Rui (2):
  virtio-gpu: Support context-init feature with virglrenderer
  virtio-gpu: Add virgl resource management

Robert Beckett (1):
  virtio-gpu: Support blob scanout using dmabuf fd

 hw/display/trace-events                       |   1 +
 hw/display/virtio-gpu-base.c                  |   1 +
 hw/display/virtio-gpu-gl.c                    |   4 +
 hw/display/virtio-gpu-virgl.c                 | 439 ++++++++++-
 hw/display/virtio-gpu.c                       |  37 +-
 hw/i386/x86.c                                 |   8 -
 include/hw/virtio/virtio-gpu.h                |  14 +
 include/standard-headers/asm-x86/bootparam.h  |  17 +-
 include/standard-headers/asm-x86/kvm_para.h   |   3 +-
 include/standard-headers/linux/ethtool.h      |  48 ++
 include/standard-headers/linux/fuse.h         |  39 +-
 .../linux/input-event-codes.h                 |   1 +
 include/standard-headers/linux/virtio_gpu.h   |   2 +
 include/standard-headers/linux/virtio_pci.h   |  10 +-
 include/standard-headers/linux/virtio_snd.h   | 154 ++++
 linux-headers/asm-arm64/kvm.h                 |  15 +-
 linux-headers/asm-arm64/sve_context.h         |  11 +
 linux-headers/asm-generic/bitsperlong.h       |   4 +
 linux-headers/asm-loongarch/kvm.h             |   2 -
 linux-headers/asm-mips/kvm.h                  |   2 -
 linux-headers/asm-powerpc/kvm.h               |  45 +-
 linux-headers/asm-riscv/kvm.h                 |   3 +-
 linux-headers/asm-s390/kvm.h                  | 315 +++++++-
 linux-headers/asm-x86/kvm.h                   | 308 +++++++-
 linux-headers/asm-x86/setup_data.h            |  83 +++
 linux-headers/linux/bits.h                    |  15 +
 linux-headers/linux/kvm.h                     | 689 +-----------------
 linux-headers/linux/psp-sev.h                 |  59 ++
 linux-headers/linux/vhost.h                   |   7 +
 meson.build                                   |  10 +-
 scripts/update-linux-headers.sh               |   4 +-
 31 files changed, 1593 insertions(+), 757 deletions(-)
 create mode 100644 linux-headers/asm-x86/setup_data.h
 create mode 100644 linux-headers/linux/bits.h

-- 
2.44.0


