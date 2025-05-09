Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D80AC3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 13:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDNXr-0001hp-1B; Fri, 09 May 2025 09:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNXe-0001hC-Qc
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:13:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNXc-0006tc-9d
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746796405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CqTRzT3dkKLjY3Tep0+sbwtvInPdUnlQzJjxVXaI74M=;
 b=YyeDO9cpHD1ejwMm9eApwwdGjOtPectNd4DtUxdaXJxsnJ4rUprQMTdZkM2bzRpYSDynkf
 zy401CHq4PgcArfwyN+kS/RVkiEqx0Bk76l3WYkeb9vI6WiSAx/hweMVjG8ekQ2sFO2arQ
 MZg7LNLgLS6tGR8UkDX2yht43ya6jkY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-LIwTya1NO8Cc70BpyOlPlA-1; Fri,
 09 May 2025 09:13:24 -0400
X-MC-Unique: LIwTya1NO8Cc70BpyOlPlA-1
X-Mimecast-MFC-AGG-ID: LIwTya1NO8Cc70BpyOlPlA_1746796403
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A54019560AF
 for <qemu-devel@nongnu.org>; Fri,  9 May 2025 13:13:23 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1B22C18003FD; Fri,  9 May 2025 13:13:20 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/28] vfio queue
Date: Fri,  9 May 2025 15:12:49 +0200
Message-ID: <20250509131317.164235-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 4b1f5b73e060971c434e70694d571adfee553027:

  tests/functional: Use -no-shutdown in the hppa_seabios test (2025-05-08 15:38:40 -0400)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20250509

for you to fetch changes up to d9b7d8b6993b5193480e5a972902e3e9bbc4d8a1:

  vfio/container: pass listener_begin/commit callbacks (2025-05-09 12:42:28 +0200)

----------------------------------------------------------------
vfio queue:

* Preparatory changes for the introduction of CPR support
* Automatic enablement of OpRegion for IGD device passthrough
* Linux headers update
* Preparatory changes for the introduction of vfio-user

----------------------------------------------------------------
John Levon (14):
      vfio: add vfio_device_prepare()
      vfio: add vfio_device_unprepare()
      vfio: add vfio_attach_device_by_iommu_type()
      vfio: add vfio_device_get_irq_info() helper
      vfio: consistently handle return value for helpers
      vfio: add strread/writeerror()
      vfio: add vfio_pci_config_space_read/write()
      vfio: add unmap_all flag to DMA unmap callback
      vfio: implement unmap all for DMA unmap callbacks
      vfio: add device IO ops vector
      vfio: add region info cache
      vfio: add read/write to device IO ops vector
      vfio: add vfio-pci-base class
      vfio/container: pass listener_begin/commit callbacks

Rorie Reyes (2):
      linux-header: update-linux-header script changes
      linux-headers: Update to Linux v6.15-rc3

Steve Sistare (3):
      vfio/container: ram discard disable helper
      vfio/container: reform vfio_container_connect cleanup
      vfio/container: vfio_container_group_add

Tomita Moeko (9):
      vfio/igd: Restrict legacy mode to Gen6-9 devices
      vfio/igd: Always emulate ASLS (OpRegion) register
      vfio/igd: Detect IGD device by OpRegion
      vfio/igd: Check vendor and device ID on GVT-g mdev
      vfio/igd: Check OpRegion support on GVT-g mdev
      vfio/igd: Enable OpRegion by default
      vfio/igd: Allow overriding GMS with 0xf0 to 0xfe on Gen9+
      vfio/igd: Only emulate GGC register when x-igd-gms is set
      vfio/igd: Remove generation limitation for IGD passthrough

 docs/igd-assign.txt                           |  11 +-
 hw/vfio/pci.h                                 |  10 +-
 include/hw/vfio/vfio-container-base.h         |  17 +-
 include/hw/vfio/vfio-device.h                 |  82 ++++++++
 include/standard-headers/asm-x86/setup_data.h |   4 +-
 include/standard-headers/drm/drm_fourcc.h     |  41 ++++
 include/standard-headers/linux/const.h        |   2 +-
 include/standard-headers/linux/ethtool.h      |  22 +++
 include/standard-headers/linux/fuse.h         |  12 +-
 include/standard-headers/linux/pci_regs.h     |  13 +-
 include/standard-headers/linux/virtio_net.h   |  13 ++
 include/standard-headers/linux/virtio_snd.h   |   2 +-
 linux-headers/asm-arm64/kvm.h                 |  11 ++
 linux-headers/asm-arm64/unistd_64.h           |   1 +
 linux-headers/asm-generic/mman-common.h       |   1 +
 linux-headers/asm-generic/unistd.h            |   4 +-
 linux-headers/asm-loongarch/unistd_64.h       |   1 +
 linux-headers/asm-mips/unistd_n32.h           |   1 +
 linux-headers/asm-mips/unistd_n64.h           |   1 +
 linux-headers/asm-mips/unistd_o32.h           |   1 +
 linux-headers/asm-powerpc/unistd_32.h         |   1 +
 linux-headers/asm-powerpc/unistd_64.h         |   1 +
 linux-headers/asm-riscv/kvm.h                 |   2 +
 linux-headers/asm-riscv/unistd_32.h           |   1 +
 linux-headers/asm-riscv/unistd_64.h           |   1 +
 linux-headers/asm-s390/unistd_32.h            |   1 +
 linux-headers/asm-s390/unistd_64.h            |   1 +
 linux-headers/asm-x86/kvm.h                   |   3 +
 linux-headers/asm-x86/unistd_32.h             |   1 +
 linux-headers/asm-x86/unistd_64.h             |   1 +
 linux-headers/asm-x86/unistd_x32.h            |   1 +
 linux-headers/linux/bits.h                    |   8 +-
 linux-headers/linux/const.h                   |   2 +-
 linux-headers/linux/iommufd.h                 | 129 ++++++++++++-
 linux-headers/linux/kvm.h                     |   1 +
 linux-headers/linux/psp-sev.h                 |  21 ++-
 linux-headers/linux/stddef.h                  |   2 +
 linux-headers/linux/vfio.h                    |  30 ++-
 hw/vfio/ap.c                                  |  19 +-
 hw/vfio/ccw.c                                 |  25 ++-
 hw/vfio/container-base.c                      |  10 +-
 hw/vfio/container.c                           | 190 +++++++++++--------
 hw/vfio/device.c                              | 183 ++++++++++++++++--
 hw/vfio/igd.c                                 | 226 ++++++++++++----------
 hw/vfio/iommufd.c                             |  32 ++--
 hw/vfio/listener.c                            |  64 +++++--
 hw/vfio/pci.c                                 | 259 ++++++++++++++++----------
 hw/vfio/platform.c                            |   6 +-
 hw/vfio/region.c                              |  19 +-
 scripts/update-linux-headers.sh               |   2 +-
 50 files changed, 1085 insertions(+), 407 deletions(-)


