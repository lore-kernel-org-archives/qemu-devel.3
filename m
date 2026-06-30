Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D320BC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 04:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weQ84-0006e2-9f; Tue, 30 Jun 2026 00:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weQ7y-0006cn-Hr
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 00:31:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weQ7w-0002xn-Mk
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 00:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782793874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=61f9sdQYSAC8k3s6MNsubR2AlF64ehPyF/cXMAxzO0E=;
 b=dgjY551QK/5jiDCY4pezBHJY8jugaxAaKma75f4R0vLgXI1JjHNgmniie6WZ7r/Rja6HlC
 hrMNV0XvyBe1JRe+xmMOHM6/KzmH4GSL33fln5oio+7ZpcrNmirVWMtUza6QUrE656tO7H
 v5vrjDKXOJNAKFCb8zyHsS7r6W0Ns9k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-VU9xOJhmO-uB951kx71n6g-1; Tue,
 30 Jun 2026 00:31:11 -0400
X-MC-Unique: VU9xOJhmO-uB951kx71n6g-1
X-Mimecast-MFC-AGG-ID: VU9xOJhmO-uB951kx71n6g_1782793870
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3058185BD59
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 04:31:10 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.58])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5F0A51956045; Tue, 30 Jun 2026 04:31:09 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/23] vfio queue
Date: Tue, 30 Jun 2026 06:30:44 +0200
Message-ID: <20260630043107.1511076-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit 30e8a06b64aa58a3990ba39cb5d09531e7d265e0:

  Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into staging (2026-06-29 17:41:42 +0200)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20260630

for you to fetch changes up to afe79bb7bf7fe16f418d6e10522946e13da04384:

  vfio/listener: Fix translated_addr for non-identity-mapped RAM sections (2026-06-30 05:35:56 +0200)

----------------------------------------------------------------
vfio queue:

* Fixes ROM read issues in vfio/pci: information leak, error
  propagation, and uninitialized state
* Validates VERSION replies in vfio-user and updates the spec
  for DMA access mode bits
* Merges .dma_map_file() into .dma_map() in the iommufd backend
* Reworks switchover-ack to be re-usable and implements the
  VFIO_PRECOPY_INFO_REINIT feature for additional pre-copy
  iterations before switchover
* Adds ATS support for passthrough devices via iommufd
* Fixes translated_addr for non-identity-mapped RAM sections in
  the VFIO listener

----------------------------------------------------------------
Avihai Horon (14):
      migration: Propagate errors in migration_completion_precopy()
      migration/ram: Use migration_bitmap_sync_precopy() for postcopy discard
      migration: Run final save_query_pending at switchover
      migration: Log the approver in qemu_loadvm_approve_switchover()
      migration: Replace switchover_ack_needed SaveVMHandler
      migration: Rename switchover-ack code to legacy
      migration: Make switchover-ack re-usable
      migration: Fail migration if switchover-ack is requested after switchover decision
      vfio/migration: Extract VFIO_MIG_FLAG_DEV_INIT_DATA_SENT sending to helper
      vfio/migration: Add Error ** parameter to vfio_migration_init()
      vfio/migration: Add new switchover-ack mechanism
      vfio/migration: Implement VFIO_PRECOPY_INFO_REINIT feature
      vfio/migration: Check VFIO_PRECOPY_INFO_REINIT during switchover
      migration: Enable new switchover-ack

Cédric Le Goater (3):
      vfio/pci: Fix information leak in vfio_rom_read()
      vfio/iommufd: Merge .dma_map_file() into .dma_map()
      vfio/listener: Fix translated_addr for non-identity-mapped RAM sections

GuoHan Zhao (1):
      vfio-user: validate VERSION replies

Mario Casquero (2):
      vfio/pci: Initialize rom_read_failed in vfio_pci_load_rom()
      vfio/pci: Propagate errors in vfio_pci_load_rom() using Error API

Mattias Nissler (1):
      docs: Update vfio-user spec to describe DMA access mode bits

Nathan Chen (2):
      iommufd: Introduce handler for device ATS support
      vfio/pci: Add ats property

 docs/devel/migration/vfio.rst      |  17 +++-
 docs/interop/vfio-user.rst         |  82 +++++++++------
 qapi/migration.json                |  14 ++-
 hw/vfio/pci.h                      |   1 +
 hw/vfio/vfio-migration-internal.h  |   2 +
 include/hw/vfio/vfio-container.h   |  15 ---
 include/migration/client-options.h |   1 +
 include/migration/misc.h           |   2 +
 include/migration/register.h       |  56 +++++-----
 include/system/host_iommu_device.h |   9 ++
 migration/migration.h              |  34 ++++++-
 migration/savevm.h                 |   9 +-
 backends/iommufd.c                 |   8 ++
 hw/core/machine.c                  |   1 +
 hw/s390x/s390-stattrib.c           |   2 +-
 hw/vfio-user/proxy.c               |  21 ++--
 hw/vfio/container.c                |  38 -------
 hw/vfio/iommufd.c                  |  50 ++++++---
 hw/vfio/listener.c                 |   5 +-
 hw/vfio/migration.c                | 204 +++++++++++++++++++++++++++++--------
 hw/vfio/pci.c                      | 129 +++++++++++++++++++----
 migration/block-dirty-bitmap.c     |  11 +-
 migration/migration.c              |  73 ++++++++++---
 migration/options.c                |   9 ++
 migration/ram.c                    |  40 ++++----
 migration/savevm.c                 | 173 +++++++++++++++++++++----------
 hw/vfio/trace-events               |   7 +-
 migration/trace-events             |   9 +-
 28 files changed, 709 insertions(+), 313 deletions(-)


