Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F6FC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 15:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWHJn-0004ia-IU; Tue, 23 Jul 2024 11:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sWHJl-0004hZ-Ii
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 11:20:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sWHJj-00039D-AY
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 11:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721748041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JBr7K1mvTBnSFVbh/KGsTN/Qirv8RJ5mu7dM6aeGcdk=;
 b=PyMlZed9B4V9zEbCu7ZTH9QisbE/4nCHXXqIXs8rHMdlrx0AFQVzoSjlBBQjRRrmcdI0XE
 Wvru0lK0X8sanUb0SQqIWRRVJUFDgdaIDcTuGuHivtK7qmro9LgEg/MlBcbBnAFR+DxxbL
 WXN5uzZRxnj1YGv7HyWUNYe4ToHiajY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-jTf2jO4eP0ySVhskdoE7Tw-1; Tue,
 23 Jul 2024 11:20:40 -0400
X-MC-Unique: jTf2jO4eP0ySVhskdoE7Tw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 171D21955D44
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 15:20:39 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.91])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6120E195605A; Tue, 23 Jul 2024 15:20:37 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL v2 00/16] vfio queue
Date: Tue, 23 Jul 2024 17:20:34 +0200
Message-ID: <20240723152035.409000-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 3cce8bd4d737f2ca688bbdcb92cd5cc683245bbd:

  Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2024-07-23 15:23:05 +1000)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20240723-1

for you to fetch changes up to 30b9167785177ac43d11b881fe321918124aeb88:

  vfio/common: Allow disabling device dirty page tracking (2024-07-23 17:14:53 +0200)

Changes in v2:

  - Rebased  
  - Fixed bogus email in "vfio/iommufd: Implement
    VFIOIOMMUClass::query_dirty_bitmap support"

----------------------------------------------------------------
vfio queue:

* IOMMUFD Dirty Tracking support
* Fix for a possible SEGV in IOMMU type1 container
* Dropped initialization of host IOMMU device with mdev devices

----------------------------------------------------------------
Eric Auger (1):
      hw/vfio/container: Fix SIGSEV on vfio_container_instance_finalize()

Joao Martins (13):
      vfio/pci: Extract mdev check into an helper
      vfio/iommufd: Don't initialize nor set a HOST_IOMMU_DEVICE with mdev
      backends/iommufd: Extend iommufd_backend_get_device_info() to fetch HW capabilities
      vfio/iommufd: Return errno in iommufd_cdev_attach_ioas_hwpt()
      vfio/iommufd: Introduce auto domain creation
      vfio/{iommufd,container}: Remove caps::aw_bits
      vfio/iommufd: Add hw_caps field to HostIOMMUDeviceCaps
      vfio/{iommufd, container}: Invoke HostIOMMUDevice::realize() during attach_device()
      vfio/iommufd: Probe and request hwpt dirty tracking capability
      vfio/iommufd: Implement VFIOIOMMUClass::set_dirty_tracking support
      vfio/iommufd: Implement VFIOIOMMUClass::query_dirty_bitmap support
      vfio/migration: Don't block migration device dirty tracking is unsupported
      vfio/common: Allow disabling device dirty page tracking

Zhenzhong Duan (2):
      vfio/ap: Don't initialize HOST_IOMMU_DEVICE with mdev
      vfio/ccw: Don't initialize HOST_IOMMU_DEVICE with mdev

 include/hw/vfio/vfio-common.h      |  15 +++
 include/sysemu/host_iommu_device.h |   5 +-
 include/sysemu/iommufd.h           |  13 ++-
 backends/iommufd.c                 |  89 ++++++++++++++++-
 hw/vfio/ap.c                       |   3 +
 hw/vfio/ccw.c                      |   3 +
 hw/vfio/common.c                   |  17 ++--
 hw/vfio/container.c                |  10 +-
 hw/vfio/helpers.c                  |  25 +++++
 hw/vfio/iommufd.c                  | 196 +++++++++++++++++++++++++++++++++++--
 hw/vfio/migration.c                |  12 ++-
 hw/vfio/pci.c                      |  26 ++---
 backends/trace-events              |   3 +
 13 files changed, 377 insertions(+), 40 deletions(-)


