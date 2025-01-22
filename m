Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDA4C02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 15:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tacUJ-0004cN-E3; Wed, 22 Jan 2025 10:17:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tacUG-0004bO-4s
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 10:17:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tacUE-0004YN-DK
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 10:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737559065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Y/eO5sN9XODmFhAtqnqXOxPh53iLVvN0mSXJCxe3m3Q=;
 b=Lt1ilsBUrizT3SV5so/OfOahLL6i5Gb2Ir6YFvZBWGOOrdUAO9z9XZ4wdxdXmeBt3FFT+k
 9wVxmZH4wanYNA+wMbvULBEZn/KA6MZ8eHPIel6rFW0vHOFCm67uhKwuD6ssBCC9RZt2Hh
 Ip4pb+Yoruvypg6v6yD4WPeyU6tRWwg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-GueLhFboN_icPaOn4sdQVg-1; Wed,
 22 Jan 2025 10:17:38 -0500
X-MC-Unique: GueLhFboN_icPaOn4sdQVg-1
X-Mimecast-MFC-AGG-ID: GueLhFboN_icPaOn4sdQVg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B565819560B0
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 15:17:37 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.154])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 11BAC19560AD; Wed, 22 Jan 2025 15:17:35 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 0/5] vfio: Improve error reporting when MMIO region mapping
 fails
Date: Wed, 22 Jan 2025 16:17:27 +0100
Message-ID: <20250122151732.1351821-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

Hello,

Under certain circumstances, a MMIO region of a device fails to map
because the region is outside the supported IOVA ranges of the VM. In
this case, PCI peer-to-peer transactions on BARs are not supported.
This typically occurs when the IOMMU address space width is less than
the physical address width, as can be the case on consumer processors
or when using a vIOMMU device with default settings.

This series tries to clarify the error message reported to the user
and provide advice on how to possibly resolve this issue.

Thanks,

C.

Cédric Le Goater (5):
  vfio/pci: Replace "iommu_device" by "vIOMMU"
  vfio: Modify vfio_viommu_preset() parameter
  vfio: Improve error reporting when MMIO region mapping fails
  cpu: Introduce cpu_get_phys_bits()
  vfio: Check compatibility of CPU and IOMMU address space width

 include/hw/core/cpu.h            |  9 ++++++
 include/hw/core/sysemu-cpu-ops.h |  6 ++++
 include/hw/vfio/vfio-common.h    |  2 +-
 cpu-target.c                     |  5 ++++
 hw/core/cpu-system.c             | 11 ++++++++
 hw/vfio/common.c                 | 47 +++++++++++++++++++++++++++++---
 hw/vfio/migration.c              |  2 +-
 hw/vfio/pci.c                    |  2 +-
 target/i386/cpu.c                |  6 ++++
 9 files changed, 83 insertions(+), 7 deletions(-)

-- 
2.48.1


