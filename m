Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2FAD6CFDC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 06:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjAYg-00037e-Fn; Fri, 23 Jan 2026 01:22:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vjAYe-00036w-Tz
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 01:22:12 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vjAYc-0000rq-94
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 01:22:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769149330; x=1800685330;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=5c8RMHEKb87i/0fubhExL66bvOqqK7bxmqu61b4IA5Y=;
 b=MUgWHivjuHRxWotDyHc8BWYpGMZayvBbTgVInODZZ8GuDIsCLSE9YffD
 iOeRe0zgPvrYlxlPiqTo2ePYuIlv5S+aDadVmQIECnKtIESdumWFmMqHY
 mkW2H3QPLZr8qda37G5x+j/HvYrw0jXIJDrt46KdH8syzFmB6wg3iMKgA
 pgfv+TQN/mmmz5yvqYr39wUp3ZqV45uLQVM1Fl1CEkd71GGOlypJWS5du
 ykf3HDol7E8BUUhivPqhTZ5Ui8nH48IJ6mwcPVZzK8J/sOH/efGHmIuQf
 IS/CDvc5Ss/9xoZXnuT/DUfuaKnuHkBHOR4Ps39n4rZAxU0Svl+2TlqfD Q==;
X-CSE-ConnectionGUID: IMekkYciTRmzZsjhVejS+Q==
X-CSE-MsgGUID: yzW3TlU5RN6tT1qr73DP8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="74254176"
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; d="scan'208";a="74254176"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 22:22:05 -0800
X-CSE-ConnectionGUID: 7nuwAGsDQ+aMBWedYFRO5g==
X-CSE-MsgGUID: BntDD2tjRLmzbrM+jOMWZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; d="scan'208";a="207287396"
Received: from unknown (HELO vkasired-desk2.fm.intel.com) ([10.105.128.132])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 22:22:04 -0800
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
Subject: [PATCH v4 0/8] vfio: Create dmabuf from multiple VFIO ranges and use
 it in virtio-gpu
Date: Thu, 22 Jan 2026 22:17:39 -0800
Message-ID: <20260123062042.568703-1-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Vivek Kasireddy (8):
  virtio-gpu: Recreate the resource's dmabuf if new backing is attached
  virtio-gpu: Find hva for Guest's DMA addr associated with a ram device
  vfio: Document vfio_device_get_region_info()
  vfio/region: Add a helper to get region index from memory region
  vfio/device: Add a helper to lookup VFIODevice from memory region
  vfio/device: Add support for creating dmabuf from multiple ranges
  virtio-gpu: Rename udmabuf files and helpers to dmabuf
  virtio-gpu-dmabuf: Create dmabuf for blobs associated with VFIO
    devices

 hw/display/Kconfig                            |   5 +
 hw/display/meson.build                        |   4 +-
 ...abuf-stubs.c => virtio-gpu-dmabuf-stubs.c} |   4 +-
 ...rtio-gpu-udmabuf.c => virtio-gpu-dmabuf.c} | 127 ++++++++++++++++--
 hw/display/virtio-gpu.c                       |  31 ++++-
 hw/vfio/device.c                              |  56 ++++++++
 hw/vfio/region.c                              |  14 ++
 include/hw/vfio/vfio-device.h                 |  46 +++++++
 include/hw/virtio/virtio-gpu.h                |   6 +-
 9 files changed, 266 insertions(+), 27 deletions(-)
 rename hw/display/{virtio-gpu-udmabuf-stubs.c => virtio-gpu-dmabuf-stubs.c} (79%)
 rename hw/display/{virtio-gpu-udmabuf.c => virtio-gpu-dmabuf.c} (62%)

-- 
2.50.1


