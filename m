Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A9FC30659
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 08:28:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMO0M-0006tZ-0a; Wed, 26 Jun 2024 04:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sMO0L-0006ss-1N
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 04:27:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sMO0J-00077W-BL
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 04:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719390463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Z4TXulyFdXuDYnRFkMcuYu30552IRlokgdYw7ahEtCw=;
 b=gOyZHtNU0+rXbM1eAhjWgI9ok4icjAavdr2WWlunaAdbK5jtVA4+vglso6yDYritrono3g
 RMqUfiGZGPLhQexR2mfqRt+UjMVcInocemsg079xeq7CbraKr4yLIgbD04bHEC7ai+jj6a
 7zxQsyfEtXIBNPczU/zs66DIzHmE0iE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-fB0mPjV6OKK5282KstcsEw-1; Wed,
 26 Jun 2024 04:27:40 -0400
X-MC-Unique: fB0mPjV6OKK5282KstcsEw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05C181956086; Wed, 26 Jun 2024 08:27:38 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.191])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3A4CA1956087; Wed, 26 Jun 2024 08:27:32 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 peter.maydell@linaro.org, clg@redhat.com, yanghliu@redhat.com,
 zhenzhong.duan@intel.com, alex.williamson@redhat.com
Subject: [PATCH 0/7] VIRTIO-IOMMU/HostIOMMUDevice: Fixes and page size mask
 rework
Date: Wed, 26 Jun 2024 10:26:45 +0200
Message-ID: <20240626082727.1278530-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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

The 2 first patches are fixes of
cf2647a76e ("virtio-iommu: Compute host reserved regions")
They can be taken separately of the rest.

Then the series uses the HostIOMMUDevice interface to fetch
information about the page size mask supported along the assigned
device and propagate it to the virtio-iommu. This is a similar
work as what was done in

VIRTIO-IOMMU/VFIO: Fix host iommu geometry handling series

but this time for the page size mask. Using this new
infrastructure allows to handle page size mask conflicts
earlier on device hotplug as opposed to current QEMU
abort:

qemu-system-aarch64: virtio-iommu virtio-iommu-memory-region-8-0
does not support frozen granule 0x10000
qemu: hardware error: vfio: DMA mapping failed, unable to continue

With this series the hotplug nicely fails.

Also this allows to remove hacks consisting in transiently enabling
IOMMU MRs to collect coldplugged device page size mask before machine
init. Those hacks were introduced by

94df5b2180d6 ("virtio-iommu: Fix 64kB host page size VFIO device
assignment")

The series can be found at:
https://github.com/eauger/qemu/tree/virtio-iommu-psmask-rework-v1


Eric Auger (7):
  virtio-iommu: Fix error handling in
    virtio_iommu_set_host_iova_ranges()
  vfio-container-base: Introduce vfio_container_get_iova_ranges() helper
  HostIOMMUDevice : remove Error handle from get_iova_ranges callback
  HostIOMMUDevice: Introduce get_page_size_mask() callback
  virtio-iommu : Retrieve page size mask on
    virtio_iommu_set_iommu_device()
  memory: remove IOMMU MR iommu_set_page_size_mask() callback
  virtio-iommu: Revert transient enablement of IOMMU MR in bypass mode

 include/exec/memory.h                 |  38 --------
 include/hw/vfio/vfio-container-base.h |   9 ++
 include/sysemu/host_iommu_device.h    |  11 ++-
 hw/vfio/common.c                      |   8 --
 hw/vfio/container-base.c              |  15 ++++
 hw/vfio/container.c                   |  16 ++--
 hw/vfio/iommufd.c                     |  21 +++--
 hw/virtio/virtio-iommu.c              | 121 +++++++++++++-------------
 system/memory.c                       |  13 ---
 hw/virtio/trace-events                |   2 +-
 10 files changed, 117 insertions(+), 137 deletions(-)

-- 
2.41.0


