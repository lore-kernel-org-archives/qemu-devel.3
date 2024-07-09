Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CE9C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 11:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR9Mq-0004z5-2u; Tue, 09 Jul 2024 07:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR9Mo-0004rz-05
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:50:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR9MZ-0006JM-TM
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720525825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WtA7+yQ6Wg+YHdbH3L5etgbdkC2briLQECZGXWwaGDY=;
 b=bQO6+q93nfLRhOme8THk7mW9D6UyGm4Z7jHeGoHWtEzjG4EFVwhiwqzwUCNt6yVXrF9J9G
 8+UgjpwyxsK34zqxNPnAPMKI/ccjAJVf78ZRdZolspXvk3luhEemLrcW+b2cjBUKeISC/B
 iyzZwuJ233TtQP8QVo7K0wQWuPorqIw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-IbyL9K0WMuqiXRrLliVPLw-1; Tue,
 09 Jul 2024 07:50:22 -0400
X-MC-Unique: IbyL9K0WMuqiXRrLliVPLw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B4F8196E096
 for <qemu-devel@nongnu.org>; Tue,  9 Jul 2024 11:50:21 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.193.243])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 50C753000181; Tue,  9 Jul 2024 11:50:19 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 0/9] vfio queue
Date: Tue,  9 Jul 2024 13:50:08 +0200
Message-ID: <20240709115017.798043-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The following changes since commit 44b7329de469c121555a1acf9b288f3ae71b8e61:

  Merge tag 'pull-qapi-2024-07-06' of https://repo.or.cz/qemu/armbru into staging (2024-07-07 13:23:28 -0700)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20240709

for you to fetch changes up to 83d90192026eaded6319a6d27466ad7d606a27e0:

  vfio/display: Fix vfio_display_edid_init() error path (2024-07-09 11:50:37 +0200)

----------------------------------------------------------------
vfio queue:

* Fixes on VFIO display
* VIRTIO-IOMMU/HostIOMMUDevice: Fixes and page size mask rework

----------------------------------------------------------------
Eric Auger (7):
      virtio-iommu: Fix error handling in virtio_iommu_set_host_iova_ranges()
      vfio-container-base: Introduce vfio_container_get_iova_ranges() helper
      HostIOMMUDevice : remove Error handle from get_iova_ranges callback
      HostIOMMUDevice: Introduce get_page_size_mask() callback
      virtio-iommu : Retrieve page size mask on virtio_iommu_set_iommu_device()
      memory: remove IOMMU MR iommu_set_page_size_mask() callback
      virtio-iommu: Revert transient enablement of IOMMU MR in bypass mode

Zhenzhong Duan (2):
      vfio/display: Fix potential memleak of edid info
      vfio/display: Fix vfio_display_edid_init() error path

 include/exec/memory.h                 |  38 -----------
 include/hw/vfio/vfio-container-base.h |   9 +++
 include/sysemu/host_iommu_device.h    |  11 ++-
 hw/vfio/common.c                      |   8 ---
 hw/vfio/container-base.c              |  15 +++++
 hw/vfio/container.c                   |  16 +++--
 hw/vfio/display.c                     |  16 +++--
 hw/vfio/iommufd.c                     |  17 +++--
 hw/virtio/virtio-iommu.c              | 123 +++++++++++++++++-----------------
 system/memory.c                       |  13 ----
 hw/virtio/trace-events                |   2 +-
 11 files changed, 127 insertions(+), 141 deletions(-)


