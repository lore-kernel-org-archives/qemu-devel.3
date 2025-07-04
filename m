Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361DDC83030
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 08:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXc3M-0007fG-DD; Fri, 04 Jul 2025 04:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc3E-0007eH-LQ
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:45:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc3C-0008Jn-8U
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751618741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wFj6EeglhS4awxwusowbiA3bTHUimokaw0bAlss9faE=;
 b=cLL/e7LVE2hAIyN7BPUDI2UFHsoQx8UksdfrdVxxndyBswfjVZcsIkBvxjMXlQe2UXuee6
 GSc/9xgVj+MkS6LTYLO3ArReWOj1vdEvjhoRlTHAbMmASqUfysxUc1WWKMH13/EYsQTI09
 ybv5k4vF6VA2/VbydFJT50syOoRuATs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-WwNA1VzMOvymnl5gneRKyg-1; Fri,
 04 Jul 2025 04:45:33 -0400
X-MC-Unique: WwNA1VzMOvymnl5gneRKyg-1
X-Mimecast-MFC-AGG-ID: WwNA1VzMOvymnl5gneRKyg_1751618733
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 141B518011CD
 for <qemu-devel@nongnu.org>; Fri,  4 Jul 2025 08:45:33 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.43])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 25DF919560A7; Fri,  4 Jul 2025 08:45:30 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/27] vfio queue
Date: Fri,  4 Jul 2025 10:45:01 +0200
Message-ID: <20250704084528.1412959-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit c77283dd5d79149f4e7e9edd00f65416c648ee59:

  Merge tag 'pull-request-2025-07-02' of https://gitlab.com/thuth/qemu into staging (2025-07-03 06:01:41 -0400)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20250704

for you to fetch changes up to 7437caad2052d920452ff7b9b7bc84f5e8e55c90:

  vfio: doc changes for cpr (2025-07-03 13:42:28 +0200)

----------------------------------------------------------------
vfio queue:

* Added small cleanups for b4 and scope
* Restricted TDX build to 64-bit target
* Fixed issues introduced in first part of VFIO live update support
* Added full VFIO live update support

----------------------------------------------------------------
Cédric Le Goater (2):
      b4: Drop linktrailermask
      Makefile: prune quilt source files for cscope

Mark Cave-Ayland (1):
      vfio-user: do not register vfio-user container with cpr

Steve Sistare (21):
      vfio-pci: preserve MSI
      vfio-pci: preserve INTx
      migration: close kvm after cpr
      migration: cpr_get_fd_param helper
      backends/iommufd: iommufd_backend_map_file_dma
      backends/iommufd: change process ioctl
      physmem: qemu_ram_get_fd_offset
      vfio/iommufd: use IOMMU_IOAS_MAP_FILE
      vfio/iommufd: invariant device name
      vfio/iommufd: add vfio_device_free_name
      vfio/iommufd: device name blocker
      vfio/iommufd: register container for cpr
      migration: vfio cpr state hook
      vfio/iommufd: cpr state
      vfio/iommufd: preserve descriptors
      vfio/iommufd: reconstruct device
      vfio/iommufd: reconstruct hwpt
      vfio/iommufd: change process
      iommufd: preserve DMA mappings
      vfio/container: delete old cpr register
      vfio: doc changes for cpr

Xiaoyao Li (1):
      i386/tdx: Build TDX only for 64-bit target

Zhenzhong Duan (2):
      vfio/container: Fix potential SIGSEGV when recover from unmap-all-vaddr failure
      vfio/container: Fix vfio_container_post_load()

 docs/devel/migration/CPR.rst          |   5 +-
 Makefile                              |   1 +
 qapi/migration.json                   |   6 +-
 hw/vfio/pci.h                         |   2 +
 include/exec/cpu-common.h             |   1 +
 include/hw/vfio/vfio-container-base.h |  15 +++
 include/hw/vfio/vfio-cpr.h            |  36 +++++-
 include/hw/vfio/vfio-device.h         |   3 +
 include/migration/cpr.h               |  14 +++
 include/system/iommufd.h              |   7 ++
 include/system/kvm.h                  |   1 +
 accel/kvm/kvm-all.c                   |  32 +++++
 backends/iommufd.c                    | 107 +++++++++++++++-
 hw/vfio-user/container.c              |  11 +-
 hw/vfio/ap.c                          |   4 +-
 hw/vfio/ccw.c                         |   4 +-
 hw/vfio/container-base.c              |   9 ++
 hw/vfio/cpr-iommufd.c                 | 225 ++++++++++++++++++++++++++++++++++
 hw/vfio/cpr-legacy.c                  |  25 ++--
 hw/vfio/cpr.c                         | 144 ++++++++++++++++++++--
 hw/vfio/device.c                      |  40 ++++--
 hw/vfio/helpers.c                     |  11 ++
 hw/vfio/iommufd-stubs.c               |  18 +++
 hw/vfio/iommufd.c                     |  81 ++++++++++--
 hw/vfio/pci.c                         | 109 +++++++++++++++-
 hw/vfio/platform.c                    |   2 +-
 migration/cpr.c                       |  52 ++++++--
 system/physmem.c                      |   5 +
 .b4-config                            |   1 -
 backends/trace-events                 |   2 +
 hw/i386/Kconfig                       |   2 +-
 hw/vfio/meson.build                   |   2 +
 hw/vfio/trace-events                  |   3 +
 33 files changed, 888 insertions(+), 92 deletions(-)
 create mode 100644 hw/vfio/cpr-iommufd.c
 create mode 100644 hw/vfio/iommufd-stubs.c


