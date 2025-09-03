Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D032CA100B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 05:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utgKz-0005RU-PJ; Wed, 03 Sep 2025 01:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1utgKx-0005Qy-Ls
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:47:15 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1utgKu-000206-34
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756878433; x=1788414433;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=F068w2uet0gCfJJMRsmAhZ6dLwCgtueHGaTQy1w2tw4=;
 b=Ns0IK73mZH/SifuLYWWrRP8IFuUH9mbGM624+vS4BY9ikGXcrS6Aa+0A
 WF1047Pa8znO6OdoVQqxWu6ZaH0XsUJY8ed9v07B9QJqXurKUvqU0hese
 vpTq1iG9jUtQDxIkKjsTKYNoG0Hvc0brr3slFS9gTch+9XK53+keSKg+g
 mIiScd+znPWY1qNoObPRW9AZu7AN5sXzPU3pKSZPhoxGBlQuBJrToM81w
 MzGlqzyZw6X7nb++ZO9MCJ+aPbeAdltcK/OTV8PscWAF1VeOpS37nh/uy
 T/HFKflevy9U3Pgrc9xwkDpapTcZAgrsdmQaaco/NVUHSt+W6gzTeN6MB w==;
X-CSE-ConnectionGUID: R9eFAYxLRdeDg6DSTD8Ivw==
X-CSE-MsgGUID: xt5xOMsUS/i5co5AgdppJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="58878184"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="58878184"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 22:47:08 -0700
X-CSE-ConnectionGUID: Hfiw9vIyQPumV2CGXiQHyw==
X-CSE-MsgGUID: pY5y4FukR8aDjdT9FzTejQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="175634757"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 22:47:07 -0700
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
Subject: [RFC 0/6] vfio: Implement VFIO_DEVICE_FEATURE_DMA_BUF and use it in
 virtio-gpu
Date: Tue,  2 Sep 2025 22:42:13 -0700
Message-ID: <20250903054438.1179384-1-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20;
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
that are backed by vfio-pci device regions, we have to implement
VFIO_DEVICE_FEATURE_DMA_BUF and leverage it in virtio-gpu.

So, while creating the blobs we use memory_region_is_ram_device() to
figure out if the blob is backed by memfd or a vfio-pci device. If
it is determined that the blob is backed by vfio-pci device region,
instead of calling into udmabuf driver to create dmabuf we would
now call into vfio-pci driver to have a dmabuf created on the Host.

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

Vivek Kasireddy (6):
  linux-headers: Update vfio.h to include VFIO_DEVICE_FEATURE_DMA_BUF
  vfio: Add support for VFIO_DEVICE_FEATURE_DMA_BUF
  virtio-gpu-udmabuf: Create dmabuf for blobs associated with VFIO
    devices
  virtio-gpu: Don't rely on res->blob to identify blob resources
  virtio-gpu: Recreate the resource's dmabuf if new backing is attached
  virtio-gpu: Find the host addr given gpa associated with a ram device

 hw/display/virtio-gpu-udmabuf.c | 60 ++++++++++++++++++++++++++++-----
 hw/display/virtio-gpu.c         | 58 +++++++++++++++++++++++++------
 hw/vfio/region.c                | 49 +++++++++++++++++++++++++++
 include/hw/vfio/vfio-device.h   |  3 ++
 linux-headers/linux/vfio.h      | 25 ++++++++++++++
 5 files changed, 176 insertions(+), 19 deletions(-)

-- 
2.50.1


