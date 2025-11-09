Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29615CCFA1A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 05:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHy8b-0005Wb-Hu; Sun, 09 Nov 2025 00:38:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vHy8Y-0005Va-AT
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 00:38:50 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vHy8W-0007Zb-0g
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 00:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762666728; x=1794202728;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6Sy8VXtgCZSGk57vPMggVSWrN4GbdKovxUVmatat0lk=;
 b=gVe/s/PcxLVnvv3xZii/tm2DVc6OpaQllnbOPBi8Ox9e5q+rePVkopBs
 YRBvBcaCbop24BmrrU5vvBMPrN3Ihr7t9SKU4jEqJo6oGHAeiQAfuj9mv
 KMsXL/zC0eOb/vuLi9P6l9JgxM3/9X6xw8P0kuWVqUMLWfrPkJMrlJnB1
 nRQ30dCzjl+7jzOiHokCu7pcEV5PYa4gMnaX83ReBso7dgx3KVoNpfoB0
 bzbzecSHHXNRiRna9XUfKZrFwZHUZN8CtjPwFpE6Nbj6uugTEDD3zNc1a
 6nwXNRzdDhHwkKthmiKEzs4EO+NCSzTHZi9lHxGOwS+RzFyNBC0GSVt7F g==;
X-CSE-ConnectionGUID: S6fa+SKHQgOzjWvxSHUvnA==
X-CSE-MsgGUID: hdSr2z6VSrSYhqxniPdf6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11607"; a="63965784"
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; d="scan'208";a="63965784"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2025 21:38:40 -0800
X-CSE-ConnectionGUID: 0xpJEW2ySeqizMBpNdpt9w==
X-CSE-MsgGUID: O9A2be+NRHeKv5d3LcQurQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; d="scan'208";a="188129040"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2025 21:38:40 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Dongwon Kim <dongwon.kim@intel.com>
Subject: [PATCH v2 00/10] vfio: Implement VFIO_DEVICE_FEATURE_DMA_BUF and use
 it in virtio-gpu
Date: Sat,  8 Nov 2025 21:33:43 -0800
Message-ID: <20251109053801.2267149-1-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The virtio-gpu driver running in the Guest VM can create Guest blob
resources (by importing dmabufs) that are backed by System RAM. This
is made possible by making use of memfd memory backend and udmabuf
driver on the Host side. However, in order to create Guest blobs
that are backed by vfio-pci device regions (which happens when
virtio-gpu imports dmabufs from devices that have local memory such
as dGPU VFs), we have to implement VFIO_DEVICE_FEATURE_DMA_BUF and
leverage it in virtio-gpu.

So, while creating the blobs we use memory_region_is_ram_device() to
figure out if the blob is backed by memfd or a vfio-pci device. If
it is determined that the blob is backed by vfio-pci device region,
instead of calling into udmabuf driver to create a dmabuf fd we would
now call into vfio-pci driver to have a dmabuf fd created on the Host.

Changelog:
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

Associated vfio-pci kernel driver series:
https://lore.kernel.org/dri-devel/cover.1754311439.git.leon@kernel.org/
Associated virtio-gpu kernel driver series (merged):
https://lore.kernel.org/dri-devel/20241126031643.3490496-1-vivek.kasireddy@intel.com/

---
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Cédric Le Goater <clg@redhat.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>

Vivek Kasireddy (10):
  virtio-gpu: Recreate the resource's dmabuf if new backing is attached
  virtio-gpu: Find hva for Guest's DMA addr associated with a ram device
  vfio: Document vfio_device_get_region_info()
  vfio/region: Add a helper to get region index from memory region
  vfio/device: Add a helper to lookup VFIODevice from memory region
  linux-headers: Update vfio.h to include VFIO_DEVICE_FEATURE_DMA_BUF
  vfio/device: Add support for VFIO_DEVICE_FEATURE_DMA_BUF
  virtio-gpu: Rename udmabuf files and helpers to dmabuf
  virtio-gpu-dmabuf: Introduce qemu_iovec_same_memory_regions()
  virtio-gpu-dmabuf: Create dmabuf for blobs associated with VFIO
    devices

 hw/display/Kconfig                            |   5 +
 hw/display/meson.build                        |   4 +-
 ...abuf-stubs.c => virtio-gpu-dmabuf-stubs.c} |   4 +-
 ...rtio-gpu-udmabuf.c => virtio-gpu-dmabuf.c} | 149 ++++++++++++++++--
 hw/display/virtio-gpu.c                       |  34 +++-
 hw/vfio/device.c                              |  52 ++++++
 hw/vfio/region.c                              |  14 ++
 include/hw/vfio/vfio-device.h                 |  46 ++++++
 include/hw/virtio/virtio-gpu.h                |   6 +-
 linux-headers/linux/vfio.h                    |  25 +++
 10 files changed, 316 insertions(+), 23 deletions(-)
 rename hw/display/{virtio-gpu-udmabuf-stubs.c => virtio-gpu-dmabuf-stubs.c} (79%)
 rename hw/display/{virtio-gpu-udmabuf.c => virtio-gpu-dmabuf.c} (56%)

-- 
2.50.1


