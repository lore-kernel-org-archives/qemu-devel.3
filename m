Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F22CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 23:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4pRI-0005AB-Rr; Fri, 03 Oct 2025 19:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v4pRH-00059o-0O
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 19:43:51 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v4pRC-0001RK-Op
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 19:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759535027; x=1791071027;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=OkxTTHYuEfsDLu/MKAiellenBeV1X4x7NGtO0fl6Mlc=;
 b=YPtx9hMjO879pDKRRmeZwjSLGVii+WUeKxza724wz8hJwNDjkB1TuaDB
 7E7w29RIIsc3eTjJb1xkb9Z9Jj3fC5yCKDeVMUvyzG3BruG6FRkkyebUa
 PCW3j7FXxfMBK1348uuFIp5te+6gAZ0r8dKpSiIi2vovZHb3fVbVE/S/u
 sQktc0tYisukdcq04ayCnTqodzqxy1DbvL93dDj6/vPMyhmPUaqxMm3Tg
 hevmO7LuqvDqPKl7Pt7Oxp6G4EXtxs1QGv9EyJzPXc0ZGutafcCbzG7aG
 B/htO3rIr3Qxt+Hsk19h9TryNI0ix7fHTcZA5bpV8ASUlZZnGJU/Cynks A==;
X-CSE-ConnectionGUID: aYgfaJXfQwODdbIdd7U/dQ==
X-CSE-MsgGUID: f1PPmHgdTqisWFr0bzDd/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11571"; a="61705019"
X-IronPort-AV: E=Sophos;i="6.18,314,1751266800"; d="scan'208";a="61705019"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 16:43:38 -0700
X-CSE-ConnectionGUID: hzTwP3p5QtKoWLlUwAdgnQ==
X-CSE-MsgGUID: U4a8J+1VSue4Kgq+Mqfy1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,314,1751266800"; d="scan'208";a="179428140"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 16:43:37 -0700
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
Subject: [PATCH v1 0/7] vfio: Implement VFIO_DEVICE_FEATURE_DMA_BUF and use it
 in virtio-gpu
Date: Fri,  3 Oct 2025 16:35:53 -0700
Message-ID: <20251003234138.85820-1-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
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
instead of calling into udmabuf driver to create dmabuf we would
now call into vfio-pci driver to have a dmabuf created on the Host.

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

Tested with an SRIOV enabled Intel dGPU by running Gnome Wayland
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

Vivek Kasireddy (7):
  virtio-gpu: Recreate the resource's dmabuf if new backing is attached
  virtio-gpu: Don't rely on res->blob to identify blob resources
  virtio-gpu: Find hva for Guest's DMA addr associated with a ram device
  vfio/region: Add a helper to get region index from memory region
  linux-headers: Update vfio.h to include VFIO_DEVICE_FEATURE_DMA_BUF
  vfio/device: Add support for VFIO_DEVICE_FEATURE_DMA_BUF
  virtio-gpu-udmabuf: Create dmabuf for blobs associated with VFIO
    devices

 hw/display/Kconfig              |   5 ++
 hw/display/virtio-gpu-udmabuf.c | 143 ++++++++++++++++++++++++++++++--
 hw/display/virtio-gpu.c         |  53 +++++++++---
 hw/vfio/device.c                |  43 ++++++++++
 hw/vfio/region.c                |  14 ++++
 include/hw/vfio/vfio-device.h   |   5 ++
 linux-headers/linux/vfio.h      |  25 ++++++
 7 files changed, 270 insertions(+), 18 deletions(-)

-- 
2.50.1


