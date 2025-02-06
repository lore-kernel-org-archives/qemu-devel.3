Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E43EC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 14:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg2mx-0002AX-3Q; Thu, 06 Feb 2025 09:23:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tg2mv-00029K-85
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 09:23:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tg2ms-0006jw-Qz
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 09:23:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738851804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=cy1SgcFKcXiUGeNw53L+swdVrmIJrgio8vJP+3XCMYU=;
 b=f1ts+yS1/KgW0oOggJjnSLKu+XPGw+N1qKbL8+u1PHIII31ayVebFQhqPm/yIcrb1LFIk0
 2wVxwZi/c8zcw5eCgWnYm2QgwhF3sBJaacSbn1pWPQGoU5z4RM+Y3ms3Uv6Epvd3eKM/7G
 nkP9J0GtMCU969NlfITiYICAjyheHQw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475--dh_SZzCPFKwCzL9ErYXfg-1; Thu,
 06 Feb 2025 09:23:20 -0500
X-MC-Unique: -dh_SZzCPFKwCzL9ErYXfg-1
X-Mimecast-MFC-AGG-ID: -dh_SZzCPFKwCzL9ErYXfg
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14C591956086; Thu,  6 Feb 2025 14:23:18 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2E3621800570; Thu,  6 Feb 2025 14:23:10 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 jasowang@redhat.com, imammedo@redhat.com, peterx@redhat.com,
 alex.williamson@redhat.com, clg@redhat.com, philmd@linaro.org,
 zhenzhong.duan@intel.com, ddutile@redhat.com
Subject: [PATCH 0/5] Fix vIOMMU reset order
Date: Thu,  6 Feb 2025 15:21:51 +0100
Message-ID: <20250206142307.921070-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is a follow-up of Peter's attempt to fix the fact that
vIOMMUs are likely to be reset before the device they protect:

[PATCH 0/4] intel_iommu: Reset vIOMMU after all the rest of devices
https://lore.kernel.org/all/20240117091559.144730-1-peterx@redhat.com/

This is especially observed with virtio devices when a qmp system_reset
command is sent but also with VFIO devices.

This series puts the vIOMMU reset in the 3-phase exit callback.

This scheme was tested successful with virtio-devices and some
VFIO devices. Nevertheless not all the topologies have been
tested yet.

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/viommu-3phase-reset-v1

Eric Auger (4):
  hw/virtio/virtio-iommu: Migrate to 3-phase reset
  hw/i386/intel-iommu: Migrate to 3-phase reset
  hw/arm/smmuv3: Move reset to exit phase
  hw/vfio/common: Add a trace point in vfio_reset_handler

Peter Xu (1):
  hw/i386/intel_iommu: Tear down address spaces before IOMMU reset

 hw/arm/smmuv3.c          |  9 +++++----
 hw/i386/intel_iommu.c    | 10 ++++++----
 hw/vfio/common.c         |  1 +
 hw/virtio/virtio-iommu.c |  9 +++++----
 hw/arm/trace-events      |  1 +
 hw/i386/trace-events     |  1 +
 hw/vfio/trace-events     |  1 +
 hw/virtio/trace-events   |  2 +-
 8 files changed, 21 insertions(+), 13 deletions(-)

-- 
2.47.1


