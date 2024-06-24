Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C96C30653
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 21:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLrBU-0002dv-J1; Mon, 24 Jun 2024 17:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrBS-0002dk-NK
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:25:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrBQ-0006Q0-HV
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719264303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JKbw7Ew14AfchSn1bTTqvAZzsV53YxZtxrY9CzyUKjQ=;
 b=MZUJPRerjHRKjr6mj7lH1vQNrY+ntSUCqdV0xp6ITDwrldSY6L6PT2L1QzkPLAvpp5hUWm
 VMOpBvfezQC/raL1E6zNMtfVznF6VOrTpQTFdoM7UrzJ7FnUhC4Jq64+oQnZNRNB3QFyCk
 kU/IFJY9iUft7ZlsC56eM3tJi0DlARY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-gkWSRjk3Nx2wInHcAJHSjg-1; Mon,
 24 Jun 2024 17:25:01 -0400
X-MC-Unique: gkWSRjk3Nx2wInHcAJHSjg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA70A19560AD
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 21:25:00 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 49B861956058; Mon, 24 Jun 2024 21:24:58 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/42] vfio queue
Date: Mon, 24 Jun 2024 23:24:14 +0200
Message-ID: <20240624212456.350919-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit d89b64beea65f77c21a553cb54cb97b75c53dc21:

  Merge tag 'pull-request-2024-06-24' of https://gitlab.com/thuth/qemu into staging (2024-06-24 11:57:11 -0700)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20240624

for you to fetch changes up to 96b7af4388b38bc1f66467a9c7c8ee9d3bff500f:

  vfio/container: Move vfio_container_destroy() to an instance_finalize() handler (2024-06-24 23:15:31 +0200)

----------------------------------------------------------------
vfio queue:

* Add a host IOMMU device abstraction
* VIRTIO-IOMMU/VFIO: Fix host iommu geometry handling
* QOMify VFIOContainer

----------------------------------------------------------------
Avihai Horon (1):
      vfio/common: Extract vIOMMU code from vfio_sync_dirty_bitmap()

Cédric Le Goater (15):
      vfio: Make vfio_devices_dma_logging_start() return bool
      vfio: Remove unused declarations from vfio-common.h
      vfio/container: Introduce vfio_address_space_insert()
      vfio/container: Simplify vfio_container_init()
      vfio/container: Modify vfio_get_iommu_type() to use a container fd
      vfio/container: Introduce vfio_get_iommu_class_name()
      vfio/container: Introduce vfio_create_container()
      vfio/container: Discover IOMMU type before creating the container
      vfio/container: Change VFIOContainerBase to use QOM
      vfio/container: Switch to QOM
      vfio/container: Introduce an instance_init() handler
      vfio/container: Remove VFIOContainerBase::ops
      vfio/container: Remove vfio_container_init()
      vfio/container: Introduce vfio_iommu_legacy_instance_init()
      vfio/container: Move vfio_container_destroy() to an instance_finalize() handler

Eric Auger (8):
      HostIOMMUDevice: Store the VFIO/VDPA agent
      virtio-iommu: Implement set|unset]_iommu_device() callbacks
      HostIOMMUDevice: Introduce get_iova_ranges callback
      HostIOMMUDevice: Store the aliased bus and devfn
      virtio-iommu: Compute host reserved regions
      virtio-iommu: Remove the implementation of iommu_set_iova_range
      hw/vfio: Remove memory_region_iommu_set_iova_ranges() call
      memory: Remove IOMMU MR iommu_set_iova_range API

Joao Martins (1):
      vfio/common: Move dirty tracking ranges update to helper

Yi Liu (2):
      hw/pci: Introduce pci_device_[set|unset]_iommu_device()
      intel_iommu: Implement [set|unset]_iommu_device() callbacks

Zhenzhong Duan (15):
      backends: Introduce HostIOMMUDevice abstract
      backends/host_iommu_device: Introduce HostIOMMUDeviceCaps
      vfio/container: Introduce TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO device
      backends/iommufd: Introduce TYPE_HOST_IOMMU_DEVICE_IOMMUFD[_VFIO] devices
      range: Introduce range_get_last_bit()
      vfio/container: Implement HostIOMMUDeviceClass::realize() handler
      backends/iommufd: Introduce helper function iommufd_backend_get_device_info()
      vfio/iommufd: Implement HostIOMMUDeviceClass::realize() handler
      vfio/container: Implement HostIOMMUDeviceClass::get_cap() handler
      backends/iommufd: Implement HostIOMMUDeviceClass::get_cap() handler
      vfio: Create host IOMMU device instance
      hw/pci: Introduce helper function pci_device_get_iommu_bus_devfn()
      vfio/pci: Pass HostIOMMUDevice to vIOMMU
      intel_iommu: Extract out vtd_cap_init() to initialize cap/ecap
      intel_iommu: Check compatibility with host IOMMU capabilities

 MAINTAINERS                           |   2 +
 include/exec/memory.h                 |  32 ----
 include/hw/i386/intel_iommu.h         |   2 +
 include/hw/pci/pci.h                  |  38 ++++-
 include/hw/vfio/vfio-common.h         |  18 ++-
 include/hw/vfio/vfio-container-base.h |  22 +--
 include/hw/virtio/virtio-iommu.h      |   2 +
 include/qemu/range.h                  |  11 ++
 include/sysemu/host_iommu_device.h    | 102 ++++++++++++
 include/sysemu/iommufd.h              |  19 +++
 backends/host_iommu_device.c          |  33 ++++
 backends/iommufd.c                    |  76 +++++++--
 hw/i386/intel_iommu.c                 | 203 ++++++++++++++++++-----
 hw/pci/pci.c                          |  79 ++++++++-
 hw/vfio/common.c                      | 150 ++++++++++-------
 hw/vfio/container-base.c              |  70 ++++----
 hw/vfio/container.c                   | 164 +++++++++++++------
 hw/vfio/helpers.c                     |  17 ++
 hw/vfio/iommufd.c                     |  68 +++++++-
 hw/vfio/pci.c                         |  23 ++-
 hw/vfio/spapr.c                       |   3 +
 hw/virtio/virtio-iommu.c              | 296 ++++++++++++++++++++++------------
 system/memory.c                       |  13 --
 backends/meson.build                  |   1 +
 24 files changed, 1066 insertions(+), 378 deletions(-)
 create mode 100644 include/sysemu/host_iommu_device.h
 create mode 100644 backends/host_iommu_device.c


