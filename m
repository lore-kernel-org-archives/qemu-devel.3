Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 719E7C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 08:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN6Bo-0006Xz-UZ; Thu, 05 Jun 2025 04:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uN6Bm-0006XL-2h
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:43:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uN6Ba-0008DG-IG
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749112972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LVXYJz1LHrfEI2wniogu/4VAM1/25Ron5wCxT6/x7PE=;
 b=I180aAgYQGFcPrmb5puZ+CMpt8zrsJkpyLzTMGzZ5kyBJSdi+4Xu2okeqj5k8I285qFaAl
 JKe7Q4tKlCXOYk5WMaZRUjckAAUMRE4WVnOFw7/Ra9LYF/J7Nxodqy3L7JiPovI8w7pM7T
 ww9pTsXM3Gb6LBlcSZtKtHQC5VK8YeM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-IS-JOWF4OYuQUfdhqHWPwg-1; Thu,
 05 Jun 2025 04:42:50 -0400
X-MC-Unique: IS-JOWF4OYuQUfdhqHWPwg-1
X-Mimecast-MFC-AGG-ID: IS-JOWF4OYuQUfdhqHWPwg_1749112970
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1577218003FC
 for <qemu-devel@nongnu.org>; Thu,  5 Jun 2025 08:42:50 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.77])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 80A351954B33; Thu,  5 Jun 2025 08:42:48 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/16] vfio queue
Date: Thu,  5 Jun 2025 10:42:29 +0200
Message-ID: <20250605084245.1520562-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

The following changes since commit 09be8a511a2e278b45729d7b065d30c68dd699d0:

  Merge tag 'pull-qapi-2025-06-03' of https://repo.or.cz/qemu/armbru into staging (2025-06-03 09:19:26 -0400)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20250605

for you to fetch changes up to 3ed34463a2d8ab8aabfa1d612f12b56600c87983:

  vfio: move vfio-cpr.h (2025-06-05 10:40:38 +0200)

----------------------------------------------------------------
vfio queue:

* Fixed OpRegion detection in IGD
* Added prerequisite rework for IOMMU nesting support
* Added prerequisite rework for vfio-user
* Added prerequisite rework for VFIO live update
* Modified memory_get_xlat_addr() to return a MemoryRegion

----------------------------------------------------------------
Edmund Raile (1):
      vfio/igd: OpRegion not found fix error typo

John Levon (5):
      vfio: add more VFIOIOMMUClass docs
      vfio: move more cleanup into vfio_pci_put_device()
      vfio: move config space read into vfio_pci_config_setup()
      vfio: refactor out IRQ signalling setup
      vfio/container: pass MemoryRegion to DMA operations

Steve Sistare (4):
      vfio: return mr from vfio_get_xlat_addr
      MAINTAINERS: Add reviewer for CPR
      vfio: vfio_find_ram_discard_listener
      vfio: move vfio-cpr.h

Tomita Moeko (1):
      vfio/igd: Fix incorrect error propagation in vfio_pci_igd_opregion_detect()

Zhenzhong Duan (5):
      vfio/iommufd: Add comment emphasizing no movement of hiod->realize() call
      backends/iommufd: Add a helper to invalidate user-managed HWPT
      vfio/iommufd: Add properties and handlers to TYPE_HOST_IOMMU_DEVICE_IOMMUFD
      vfio/iommufd: Implement [at|de]tach_hwpt handlers
      vfio/iommufd: Save vendor specific device info

 MAINTAINERS                           | 10 ++++
 hw/vfio/vfio-cpr.h                    | 15 ------
 include/hw/vfio/vfio-container-base.h | 83 ++++++++++++++++++++++++++++++--
 include/hw/vfio/vfio-cpr.h            | 18 +++++++
 include/system/host_iommu_device.h    | 15 ++++++
 include/system/iommufd.h              | 54 +++++++++++++++++++++
 include/system/memory.h               | 19 ++++----
 backends/iommufd.c                    | 58 +++++++++++++++++++++++
 hw/vfio/container-base.c              |  4 +-
 hw/vfio/container.c                   |  5 +-
 hw/vfio/cpr.c                         |  2 +-
 hw/vfio/igd.c                         | 22 ++++-----
 hw/vfio/iommufd.c                     | 45 +++++++++++++++---
 hw/vfio/listener.c                    | 74 ++++++++++++++++++-----------
 hw/vfio/pci.c                         | 89 +++++++++++++++++++----------------
 hw/virtio/vhost-vdpa.c                |  9 +++-
 system/memory.c                       | 32 +++----------
 backends/trace-events                 |  1 +
 18 files changed, 406 insertions(+), 149 deletions(-)
 delete mode 100644 hw/vfio/vfio-cpr.h
 create mode 100644 include/hw/vfio/vfio-cpr.h


