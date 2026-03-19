Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94972103E185
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 05:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w35qj-0004m4-5R; Thu, 19 Mar 2026 01:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w35qg-0004l8-To
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 01:23:10 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w35qd-0007tU-Nz
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 01:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773897788; x=1805433788;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=e4ynktUEfwd84hb31TFHyRnUHdxm1036eXHHHKrJu6U=;
 b=bUBWuXJdO++gPfPb9qFGzBy/BMl+FQ7l4vvY96RolbyVfQ5QKZRK+G0A
 coNPIJkP0PyNctyZEeige5LO/wLIrXl3mcEX4VvpxnhRUuAqAS6kIYkum
 L0Rln19+m//vTO9E3nUUHhd0rNwczbqZW9q/MJfs/K/2QQU/Sgywvae48
 bB8xYfs6kgbP3XbVctdrJ3PWe7+AwCQGnY3oidfRxEQeol+A/NzZe6ysO
 7nKDvDjIN4P1wRwxwBuVrSJQwG42m+VIEpXhR0hAwG3sHrzJkHGnwR08r
 gBqqE681Nyu2cLCFawmZ6/kVPREzrnMyEbcFdXG47QbktYBDEYkEAi0QK w==;
X-CSE-ConnectionGUID: 1x1FPs0WSJOKtV7oMPWY7Q==
X-CSE-MsgGUID: eS0Fm/gJQpmXAJLXGkLa6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74660350"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; d="scan'208";a="74660350"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 22:23:04 -0700
X-CSE-ConnectionGUID: Z/CiMaijQ8e11nrIVY5L6w==
X-CSE-MsgGUID: yZzwNbmVTSW/jX89AZax8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; d="scan'208";a="218355507"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 22:23:03 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Dongwon Kim <dongwon.kim@intel.com>
Subject: [PATCH v12 00/10] vfio: Create dmabuf from multiple VFIO ranges and
 use it in virtio-gpu
Date: Wed, 18 Mar 2026 22:15:49 -0700
Message-ID: <20260319052023.2088685-1-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

The virtio-gpu driver running in the Guest VM can create Guest blob
resources (by importing dmabufs) that are backed by System RAM. This
is made possible by making use of memfd memory backend and udmabuf
driver on the Host side. However, in order to create Guest blobs
that are backed by vfio-pci device regions (which happens when
virtio-gpu imports dmabufs from devices that have local memory such
as dGPU VFs), we have to add support for creating dmabuf from multiple
VFIO device ranges (same region) and leverage it in virtio-gpu.

So, while creating the blobs we first try to create a dmabuf by
calling into the udmabuf driver assuming that the backing memory 
is memfd based. If that fails, and if it is determined that the blob
is backed by a vfio-pci device region, we would then call into the
vfio-pci driver to have a dmabuf fd created.

Changelog:
v11 -> v12:
- Collect R-b tags from Akihiko
- Rebase and test on top of Qemu master
- Have the helper return VFIO region instead of index (Cedric)
- Introduce a helper to retrieve VFIO region from a MR (Cedric)
- Document the helpers introduced in vfio/device.c (Cedric)
- Verify that the total size of IOV entries is equal to the size
  of the dmabuf (Cedric)

v10 -> v11:
- Have virtio_gpu_remap_dmabuf() and vfio_device_mmap_dmabuf()
  return the mapped pointer on success and NULL on error (Akihiko)

v9 -> v10:
- Adopt the logic structure and style recommended by Akihiko in
  virtio_gpu_init_dmabuf() while creating and mmaping dmabuf
- Destroy the dmabuf by calling virtio_gpu_destroy_dmabuf() if
  mmap fails
- Set res->dmabuf_fd to -1 after closing it to improve consistency

v8 -> v9:
- Replace VFIO_DMABUF_CREATE_GUEST_ERROR/VFIO_DMABUF_CREATE_HOST_ERROR
  with VFIO_DMABUF_CREATE_ERR_INVALID_IOV/VFIO_DMABUF_CREATE_ERR_UNSPEC
  (Akihiko)
- Drop the error_prepend() in virtio_gpu_init_dmabuf() (Akihiko)
- Improve the logic structure in virtio_gpu_init_dmabuf() by calling
  the map memory function immediately after creating the dmabuf
  in both memfd/udmabuf and VFIO cases (Akihiko)

v7 -> v8:
- Move the error enum to vfio and include only negative values (Akihiko)
- Reuse the same VFIO err enum to categorize Guest/Host errors in
  virtio_gpu_create_udmabuf() (Akihiko)
- Make the error messages more descriptive and readable (Akihiko)
- Do not print any error messages on Guest triggered errors (Akihiko)
- Move the vfio dmabuf stubs file to hw/vfio directory (Akihiko)
- Make vfio_device_create_dmabuf() return an fd on success (Akihiko)
- Rename vfio_device_create_dmabuf to vfio_device_create_dmabuf_fd
  since it now returns an fd on success

v6 -> v7:
- Introduce an enum to categorize Guest and Host errors (Akihiko)
- Drop the CONFIG_VIRTIO_GPU_VFIO_BLOB Kconfig option and add stubs
  for VFIO dmabuf helpers when CONFIG_VFIO is not enabled (Akihiko)
- Check the correct return value of vfio_device_get_region_info()
  in vfio_device_mmap_dmabuf()

v5 -> v6:
- Drop the additional error_setg() call in virtio_gpu_create_udmabuf()
  and only have LOG_GUEST_ERROR for invalid ramblocks (Akihiko)
- Merge the patch that introduces vfio_device_lookup() helper with the
  one that adds support for vfio_device_create_dmabuf() (Cedric)
- Use only one 'Error **' parameter instead of two while creating
  and mmapping the dmabuf (Cedric)
- Collect R-b tags from Akihiko

v4 -> v5:
- Improve commit message for the patch that replaces dma_memory_map()
  with virtio_gpu_dma_memory_map() (Akihiko)
- Create separate patches to remove rcu_read_lock/unlock and use
  g_autofree for list pointer in virtio_gpu_create_udmabuf()
  (Akihiko, Cedric)
- Create a separate patch to improve error handling (Cedric)
- Make vfio_device_lookup() a common helper local to vfio/device.c
  (Cedric, Akihiko)
- Move the dmabuf mmap helper to vfio/device.c (Akihiko)
- Replace PROT_READ with PROT_NONE and vbasedev->fd with -1 while
  creating the placeholder mapping in dmabuf mmap helper (Akihiko)

v3 -> v4:
- Drop the patch that introduces ram_block_is_memfd_backed()
- Drop the additional check in virtio_gpu_create_udmabuf() that
  checks for memfd backed ram blocks (Akihiko)
- Remove rcu_read_lock/unlock and replace warn_report() with
  qemu_log_mask() in virtio_gpu_create_udmabuf()
- Improve the commit message and logic in the patch that adds
  support for vfio_device_create_dmabuf_fd()
- Rebase on top of vfio-next

v2 -> v3:
- Use memory_region_get_ram_ptr() to obtain hva for both memfd and
  VFIO backed memory regions (Akihiko)
- Drop the patch that introduced qemu_iovec_same_memory_regions()
  helper and move the "same memory region" check into
  virtio_gpu_create_udmabuf(), vfio_device_create_dmabuf_fd() (Akihiko)
- Refactor virtio_gpu_init_dmabuf() to not rely on helpers such as
  memory_region_is_ram_device() to identify memory regions and
  instead call virtio_gpu_create_udmabuf() unconditionally (Akihiko)
- Add a patch to introduce ram_block_is_memfd_backed() helper

v1 -> v2:
- Drop the patch that uses res->blob_size instead of res->blob to
  identify blob resources (Akihiko)
- Remove the res->dmabuf_fd < 0 check while attaching backing to a
  resource (Akihiko)
- Remove cmd->cmd_hdr.type != VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB
  check while attaching backing (Akihiko)
- Improve vfio_get_region_index_from_mr() and add documentation (Cedric)
- Remove rcu_read_lock/unlock around qemu_ram_block_from_host()
  (Akihiko, Cedric)
- Improve, document and rename vfio_device_create_dmabuf() to
  vfio_device_create_dmabuf_fd() (Cedric)
- Add a new helper to lookup VFIO device from memory region (Cedric)
- Document vfio_device_get_region_info() (Cedric)
- Ensure that info variable (in vfio_dmabuf_mmap()) is initialized
  before use (Cedric)
- Rename udmabuf files and helpers to dmabuf (Akihiko)
- Remove the redundant check for virtio_gpu_have_udmabuf() in
  virtio_gpu_init_dmabuf() (Akihiko)
- Add a helper to check whether all the entries of a dmabuf belong
  to a single memory region or not (Akihiko)

RFC -> v1:
- Create the CPU mapping using vfio device fd if the dmabuf exporter
  (vfio-pci) does not provide mmap() support (Akihiko)
- Log a warning with LOG_GUEST_ERROR instead of warn_report() when
  dmabuf cannot be created using Guest provided addresses (Akihiko)
- Use address_space_translate() instead of gpa2hva() to obtain the
  Host addresses (Akihiko)
- Rearrange the patches and improve the commit messages (Akihiko)
- Fix compilation error when VFIO is not enabled (Alex)
- Add a new helper to obtain VFIO region index from memory region
- Move vfio_device_create_dmabuf() to hw/vfio/device.c

Tested with an SRIOV enabled Intel dGPU (B60) by running Gnome Wayland
(in the VM) and Qemu with the following (relevant) parameters:
-device vfio-pci,host=0000:03:00.1
-device virtio-vga,max_outputs=1,xres=1920,yres=1080,blob=true
-display gtk,gl=on

Associated virtio-gpu kernel driver series (merged):
https://lore.kernel.org/dri-devel/20241126031643.3490496-1-vivek.kasireddy@intel.com/

---
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>

Vivek Kasireddy (10):
  virtio-gpu: Recreate the resource's dmabuf if new backing is attached
  virtio-gpu: Find hva for Guest's DMA addr associated with a ram device
  virtio-gpu: Rename udmabuf files and helpers to dmabuf
  virtio-gpu-dmabuf: Remove rcu_read_lock/unlock from
    virtio_gpu_create_udmabuf()
  virtio-gpu-dmabuf: Use g_autofree for the list pointer
  vfio/region: Add a helper to get VFIO region from memory region
  vfio/device: Add support for creating dmabuf from multiple ranges
  vfio/device: Add a helper to mmap a dmabuf
  virtio-gpu-dmabuf: Improve error handling with 'Error **' and err enum
  virtio-gpu-dmabuf: Create dmabuf for blobs associated with VFIO
    devices

 hw/vfio/vfio-region.h                         |  10 +
 include/hw/vfio/vfio-device.h                 |  39 ++++
 include/hw/virtio/virtio-gpu.h                |   6 +-
 ...abuf-stubs.c => virtio-gpu-dmabuf-stubs.c} |   4 +-
 ...rtio-gpu-udmabuf.c => virtio-gpu-dmabuf.c} |  99 ++++++----
 hw/display/virtio-gpu.c                       |  31 +++-
 hw/vfio/device.c                              | 173 ++++++++++++++++++
 hw/vfio/dmabuf-stubs.c                        |  24 +++
 hw/vfio/region.c                              |  11 ++
 hw/display/meson.build                        |   4 +-
 hw/vfio/meson.build                           |   1 +
 11 files changed, 357 insertions(+), 45 deletions(-)
 rename hw/display/{virtio-gpu-udmabuf-stubs.c => virtio-gpu-dmabuf-stubs.c} (77%)
 rename hw/display/{virtio-gpu-udmabuf.c => virtio-gpu-dmabuf.c} (65%)
 create mode 100644 hw/vfio/dmabuf-stubs.c

-- 
2.53.0


