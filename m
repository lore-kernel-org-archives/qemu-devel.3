Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155FAC02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 13:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg1ir-0007DK-Ll; Thu, 06 Feb 2025 08:15:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tg1iU-0006w3-Ds
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:14:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tg1iS-0000BQ-S9
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:14:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738847686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=x/P1lFWbl2YRZK7FGbPa2uPdco4GJontdhgnZkj5Vws=;
 b=dZfE/PbP+0bPgLKzbbutJbq4dwVDlpInycotfgpAKBubNj0DzuXLsOCEgd6tubar/Mvvf+
 ezjl7EadRUgYqMi2vxZWLoRSwYc7bfmB+J3ixwkNKd9SzhTjgh5TiCUQ+2V9mPwq4lsE+g
 +ao8pb4lOw5MYxG+J9aPuh4GT5p9D4s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-pmGH-c4KM5a5vRmCz9SpLQ-1; Thu,
 06 Feb 2025 08:14:45 -0500
X-MC-Unique: pmGH-c4KM5a5vRmCz9SpLQ-1
X-Mimecast-MFC-AGG-ID: pmGH-c4KM5a5vRmCz9SpLQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F7C9195604F
 for <qemu-devel@nongnu.org>; Thu,  6 Feb 2025 13:14:44 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.15])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 81A4E30001AB; Thu,  6 Feb 2025 13:14:42 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 0/7] vfio: Improve error reporting when MMIO region mapping
 fails
Date: Thu,  6 Feb 2025 14:14:28 +0100
Message-ID: <20250206131438.1505542-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

Under certain circumstances, a MMIO region of a device fails to map
because the region is outside the supported IOVA ranges of the VM. In
this case, PCI peer-to-peer transactions on BARs are not supported.
This typically occurs when the IOMMU address space width is less than
the physical address width, as can be the case on some Intel consumer
processors or when using a vIOMMU device with default settings.

This series tries to clarify the error message reported to the user.

Thanks,

C.

Changes in v3:

 - Fixed warn_report_err_once()
 - Improved commit logs a bit 
 - Dropped check on compatibility of CPU and IOMMU address space
   width. Will address later in its own series.

Changes in v2:

 - Removed advice on how to resolve the issue. Diagnostic is enough.
 - Introduced helpers
 - Checked device type, since this only applies to PCI
 - Added cleanup
 
Cédric Le Goater (7):
  util/error: Introduce warn_report_err_once()
  vfio/pci: Replace "iommu_device" by "vIOMMU"
  vfio: Rephrase comment in vfio_listener_region_add() error path
  vfio: Introduce vfio_get_vfio_device()
  vfio: Improve error reporting when MMIO region mapping fails
  vfio: Remove reports of DMA mapping errors in backends
  vfio: Remove superfluous error report in vfio_listener_region_add()

 include/hw/vfio/vfio-common.h |  1 +
 include/qapi/error.h          | 12 +++++++++++
 backends/iommufd.c            |  3 ---
 hw/vfio/common.c              | 40 +++++++++++++++++++++++++----------
 hw/vfio/container.c           |  2 --
 hw/vfio/helpers.c             | 10 +++++++++
 hw/vfio/pci.c                 |  2 +-
 util/error.c                  | 11 ++++++++++
 8 files changed, 64 insertions(+), 17 deletions(-)

-- 
2.48.1


