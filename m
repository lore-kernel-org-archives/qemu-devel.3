Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9277FC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 13:45:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdUps-0000he-0k; Thu, 30 Jan 2025 08:44:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tdUpp-0000gq-KJ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:43:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tdUpo-0003O7-5R
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738244633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6mI0ox+IW4A2wveybGPBBGrr0tC1d/ufYPPDScM5z98=;
 b=IO3DvLk+A2qHpDG+M4/NQVnTBljc38onGv7qKGeVrgqGDv0z2us+GjJ+8ejlRQSFlyq4j+
 uyUFwfDO8fW+OsYJS9SR7GOeXBs1bghJNnej5UFN3ory4oyJ7CFfiLXT8IHquOch8evcNH
 XFLwD9Aq8RZeX0YuTsnGCW+rdDk48rA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-qeXmXs0CNHe3qVrdisvwWw-1; Thu,
 30 Jan 2025 08:43:52 -0500
X-MC-Unique: qeXmXs0CNHe3qVrdisvwWw-1
X-Mimecast-MFC-AGG-ID: qeXmXs0CNHe3qVrdisvwWw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73B7219560A3
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 13:43:51 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.105])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A88321800969; Thu, 30 Jan 2025 13:43:48 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 0/9]vfio: Improve error reporting when MMIO region mapping
 fails
Date: Thu, 30 Jan 2025 14:43:37 +0100
Message-ID: <20250130134346.1754143-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hello,

Under certain circumstances, a MMIO region of a device fails to map
because the region is outside the supported IOVA ranges of the VM. In
this case, PCI peer-to-peer transactions on BARs are not supported.
This typically occurs when the IOMMU address space width is less than
the physical address width, as can be the case on some consumer
processors or when using a vIOMMU device with default settings.

This series tries to clarify the error message reported to the user.

Thanks,

C.

Changes in v2:

 - Removed advices on how to resolve the issue. Diagnostic is enough.
 - Introduced helpers
 - Checked device type, since this only applies to PCI
 - Added cleanup

Cédric Le Goater (9):
  util/error: Introduce warn_report_once_err()
  vfio/pci: Replace "iommu_device" by "vIOMMU"
  vfio: Rephrase comment in vfio_listener_region_add() error path
  vfio: Introduce vfio_get_vfio_device()
  vfio: Improve error reporting when MMIO region mapping fails
  vfio: Remove reports of DMA mapping errors in backends
  cpu: Introduce cpu_get_phys_bits()
  vfio: Check compatibility of CPU and IOMMU address space width
  vfio: Remove superfluous error report in vfio_listener_region_add()

 include/hw/core/cpu.h            |  9 +++++
 include/hw/core/sysemu-cpu-ops.h |  6 ++++
 include/hw/vfio/vfio-common.h    |  1 +
 include/qapi/error.h             |  5 +++
 backends/iommufd.c               |  3 --
 cpu-target.c                     |  5 +++
 hw/core/cpu-system.c             | 11 ++++++
 hw/vfio/common.c                 | 61 ++++++++++++++++++++++++++------
 hw/vfio/container.c              |  2 --
 hw/vfio/helpers.c                | 10 ++++++
 hw/vfio/pci.c                    |  2 +-
 target/i386/cpu.c                |  6 ++++
 util/error.c                     |  9 +++++
 13 files changed, 113 insertions(+), 17 deletions(-)

-- 
2.48.1


