Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC924C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 09:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTelb-0005fW-GT; Tue, 16 Jul 2024 05:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sTelZ-0005c5-RF
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:46:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sTelX-0000Ll-R7
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721123193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DSdmdXUQ3zTou+N7IQHCWEWgmRzLg47Zppv3Vq7Z7IY=;
 b=asTgJZNZb0+HbJiAES9aut3OaHuYEuuZTo6VF/fRdtqsbeaWxDEG/JltRxWWHc0pYZS8wA
 7UcDB1nKJlaHUIk11d2OiQxzMdtUzZHXrinqdV7zYyg3EzmEJ8iV8IcL23yxBGGwoeF5OR
 kM+1MZc/i1m6+Nn1SVliswtCWVjRQWQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-eJjFxVMzM6OTb5tbzNgxLg-1; Tue,
 16 Jul 2024 05:46:29 -0400
X-MC-Unique: eJjFxVMzM6OTb5tbzNgxLg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6794919540F3; Tue, 16 Jul 2024 09:46:28 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.185])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0BA87300018D; Tue, 16 Jul 2024 09:46:22 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 peter.maydell@linaro.org, clg@redhat.com, zhenzhong.duan@intel.com,
 alex.williamson@redhat.com, jasowang@redhat.com
Cc: yanghliu@redhat.com
Subject: [PATCH 0/6] VIRTIO-IOMMU/VFIO: Revert IOMMUDevice clear and fix
 hotunplug
Date: Tue, 16 Jul 2024 11:45:02 +0200
Message-ID: <20240716094619.1713905-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

1b889d6e39c3 ("virtio-iommu: Clear IOMMUDevice when VFIO
device is unplugged" fixes the VFIO hotplug/hotunplug/hotplug
sequence by clearing the IOMMUDevice which backs the VFIO device.
However this brings other troubles such as a memory corruption.

Even when fixing some cleanups that were missed on the first
attempt the memory corruption still exists if the IOMMUDevice is
freed. Until we understand the exact cause let's make things simpler:
let the backing IOMMUDevice survive the unplug as what is done
on intel iommu for instance. Clean up/reset resources that would
prevent the device from being hotplugged again (probe_done is removed,
[host_]resv_regions are reset). By doing this we also rule out the
use case of aliased BDFs which is known to be not functional with
virtio-iommu (missing guest kernel support) and the virtio-iommu device
implementation is not ready either.

This series can be found at:
https://github.com/eauger/qemu/tree/virtio_iommu_device_clear_fixes_v1


Eric Auger (6):
  Revert "virtio-iommu: Clear IOMMUDevice when VFIO device is unplugged"
  virtio-iommu: Remove probe_done
  virtio-iommu: Free [host_]resv_ranges on unset_iommu_devices
  virtio-iommu: Remove the end point on detach
  hw/vfio/common: Add vfio_listener_region_del_iommu trace event
  virtio-iommu: Add trace point on
    virtio_iommu_detach_endpoint_from_domain

 include/hw/virtio/virtio-iommu.h |  1 -
 hw/vfio/common.c                 |  3 +-
 hw/virtio/virtio-iommu.c         | 88 +++++++++++---------------------
 hw/vfio/trace-events             |  3 +-
 hw/virtio/trace-events           |  1 +
 5 files changed, 35 insertions(+), 61 deletions(-)

-- 
2.41.0


