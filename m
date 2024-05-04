Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7057FC4345F
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2024 20:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3M0o-0007LV-DD; Sat, 04 May 2024 16:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s3M0l-0007LB-VZ
 for qemu-devel@nongnu.org; Sat, 04 May 2024 16:29:35 -0400
Received: from madrid.collaboradmins.com ([2a00:1098:ed:100::25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s3M0j-0005Ts-Mq
 for qemu-devel@nongnu.org; Sat, 04 May 2024 16:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1714854569;
 bh=gvQzH6376H265/G2WpN2XyjiHscEGI0p3ZMSKd4al6c=;
 h=From:To:Cc:Subject:Date:From;
 b=Mzfng0EUVke6wrYbJw3F268PCllINKV3Lq7F5nN9yT6DzK5nZkVvWzH4PtHN7OJIw
 GJ6RoEJMnY+bPAhSqLQz1u9kaHo3CR7EJdn66Qd3Iay4CxWnMqMJ5kXz0zI04O+Txp
 EnsxObZGItRm622hjn2KtvRPC82G2lWQGYs/VnqxwJtv4388I8rKJ2BwRmSpyDnwMt
 eUNSE76wtZpmOIen1g/HXayFdvy4TWhRVohSlku4gNW6QK7L+eTFZSljKLfXDjU8mg
 YkPtQKI0GpOXdv42TP3kCUyOqdzFalss2DcjUYJlRNsFJ81WizkCMDEjvdHo7UeaR5
 Iifudo//OIcnA==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5A04C378000B;
 Sat,  4 May 2024 20:29:27 +0000 (UTC)
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
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
Subject: [PATCH v10 00/10] Support blob memory and venus on qemu
Date: Sat,  4 May 2024 23:28:24 +0300
Message-ID: <20240504202834.399780-1-dmitry.osipenko@collabora.com>
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

All virglrender and almost all Linux kernel prerequisite changes
needed by Venus are already in upstream. For kernel there is a pending
KVM patchset that fixes mapping of compound pages needed for DRM drivers
using TTM [1], othewrwise hostmem blob mapping will fail with a KVM error
from Qemu.

[1] https://lore.kernel.org/kvm/20240229025759.1187910-1-stevensd@google.com/

You'll need to use recent Mesa version containing patch that removes
dependency on cross-device feature from Venus that isn't supported by
Qemu [2].

[2] https://gitlab.freedesktop.org/mesa/mesa/-/commit/087e9a96d13155e26987befae78b6ccbb7ae242b

Example Qemu cmdline that enables Venus for virtio-gpu:

  qemu-system-x86_64 -device virtio-vga-gl,hostmem=4G,blob=true,venus=true


Changes from V9 to V10

- Dropped 'async_unmap_in_progress' variable and switched to use
  aio_bh_new() isntead of oneshot variant in the "blob commands" patch.

- Further improved error messages by printing error code when actual error
  occurrs and using ERR_UNSPEC instead of ERR_ENOMEM when we don't really
  know if it was ENOMEM for sure.

- Added vdc->unrealize for the virtio GL device and freed virgl data.

- Dropped UUID and doc/migration patches. UUID feature isn't needed
  anymore, instead we changed Mesa Venus driver to not require UUID.

- Renamed virtio-gpu-gl "vulkan" property name back to "venus".

Changes from V8 to V9

- Added resuming of cmdq processing when hostmem MR is freed,
  as was suggested by Akihiko Odaki.

- Added more error messages, suggested by Akihiko Odaki

- Dropped superfluous 'res->async_unmap_completed', suggested
  by Akihiko Odaki.

- Kept using cmd->suspended flag. Akihiko Odaki suggested to make
  virtio_gpu_virgl_process_cmd() return false if cmd processing is
  suspended, but it's not easy to implement due to ubiquitous
  VIRTIO_GPU_FILL_CMD() macros that returns void, requiring to change
  all the virtio-gpu processing code.

- Added back virtio_gpu_virgl_resource as was requested by Akihiko Odaki,
  though I'm not convinced it's really needed.

- Switched to use GArray, renamed capset2_max_ver/size vars and moved
  "vulkan" property definition to the virtio-gpu-gl device in the Venus
  patch, like was suggested by Akihiko Odaki.

- Moved UUID to virtio_gpu_virgl_resource and dropped UUID save/restore
  since it will require bumping VM version and virgl device isn't miratable
  anyways.

- Fixed exposing UUID feature with Rutabaga

- Dropped linux-headers update patch because headers were already updated
  in Qemu/staging.

- Added patch that updates virtio migration doc with a note about virtio-gpu
  migration specifics, suggested by Akihiko Odaki.

- Addressed coding style issue noticed by Akihiko Odaki

Changes from V7 to V8

- Supported suspension of virtio-gpu commands processing and made
  unmapping of hostmem region asynchronous by blocking/suspending
  cmd processing until region is unmapped. Suggested by Akihiko Odaki.

- Fixed arm64 building of x86 targets using updated linux-headers.
  Corrected the update script. Thanks to Rob Clark for reporting
  the issue.

- Added new patch that makes registration of virgl capsets dynamic.
  Requested by Antonio Caggiano and Pierre-Eric Pelloux-Prayer.

- Venus capset now isn't advertised if Vulkan is disabled with vulkan=false

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

Antonio Caggiano (2):
  virtio-gpu: Handle resource blob commands
  virtio-gpu: Support Venus context

Dmitry Osipenko (4):
  virtio-gpu: Unrealize GL device
  virtio-gpu: Use pkgconfig version to decide which virgl features are
    available
  virtio-gpu: Don't require udmabuf when blobs and virgl are enabled
  virtio-gpu: Support suspension of commands processing

Huang Rui (2):
  virtio-gpu: Support context-init feature with virglrenderer
  virtio-gpu: Add virgl resource management

Pierre-Eric Pelloux-Prayer (1):
  virtio-gpu: Register capsets dynamically

Robert Beckett (1):
  virtio-gpu: Support blob scanout using dmabuf fd

 hw/display/virtio-gpu-gl.c       |  24 +-
 hw/display/virtio-gpu-rutabaga.c |   1 +
 hw/display/virtio-gpu-virgl.c    | 534 ++++++++++++++++++++++++++++++-
 hw/display/virtio-gpu.c          |  35 +-
 include/hw/virtio/virtio-gpu.h   |  18 +-
 meson.build                      |  10 +-
 6 files changed, 590 insertions(+), 32 deletions(-)

-- 
2.44.0


