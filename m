Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9864CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 16:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvf8P-0006YP-AV; Mon, 08 Sep 2025 12:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvf8B-0006R6-9z
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:54:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvf85-0001Yi-M1
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757350444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WLzGP4nOUBHL8CinAKv651f0cupRAeBa2jp51jlwf+w=;
 b=Fv4Br7rGksRvGNMpMj6x0eHu/wCDcuoll2QZU9HGcrCLXqFEGhFh1aMRGsOANRhkRbx4Sj
 ZhIqM0Yyii/ytWPWJlqgtNyI0NnpG1k6f5VBsUG6+K7wgspkqT5TNYcfaFdO99h8g1hTcT
 KRqHskCZyLJLTNiuXZuOXvWRn6IQgcI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-aVYwxzN0NLGX6un4Vrq7IQ-1; Mon,
 08 Sep 2025 12:54:02 -0400
X-MC-Unique: aVYwxzN0NLGX6un4Vrq7IQ-1
X-Mimecast-MFC-AGG-ID: aVYwxzN0NLGX6un4Vrq7IQ_1757350442
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E90D1800292
 for <qemu-devel@nongnu.org>; Mon,  8 Sep 2025 16:54:02 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.50])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 603D0300018D; Mon,  8 Sep 2025 16:54:00 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/31] vfio queue
Date: Mon,  8 Sep 2025 18:53:23 +0200
Message-ID: <20250908165354.1731444-1-clg@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 6a9fa5ef3230a7d51e0d953a59ee9ef10af705b8:

  Merge tag 'pull-tcg-20250905' of https://gitlab.com/rth7680/qemu into staging (2025-09-05 09:51:27 +0200)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20250908

for you to fetch changes up to bb986792a968ee51cda72cd4cc05822198495375:

  vfio/pci.h: rename VFIOPCIDevice pdev field to parent_obj (2025-09-08 16:46:32 +0200)

----------------------------------------------------------------
vfio queue:

* Large refactor of the VFIO code to use QOM casts and follow the
  current coding style guidelines
* Removal of the deprecated vfio-platform, vfio-calxeda-xgmac and
  vfio-amd-xgbe devices
* Fail with error if dma_max_mappings limit is hit
* Added 'x-pci-class-code' property to vfio-user-pci device
* Added a new helper to retrieve a VFIOPCIDevice from a VFIODevice
* Fixed IGD OpRegion detection

----------------------------------------------------------------
Cédric Le Goater (5):
      vfio: Remove 'vfio-amd-xgbe' device
      vfio: Remove 'vfio-calxeda-xgmac' device
      vfio: Remove 'vfio-platform'
      vfio: Move vfio-region.h under hw/vfio/
      vfio: Report an error when the 'dma_max_mappings' limit is reached

Glenn Miles (1):
      MAINTAINERS: Add myself as reviewer for PowerNV and XIVE

John Levon (1):
      hw/vfio-user: add x-pci-class-code

Mark Cave-Ayland (21):
      vfio/vfio-container-base.h: update VFIOContainerBase declaration
      vfio/vfio-container.h: update VFIOContainer declaration
      hw/vfio/cpr-legacy.c: use QOM casts where appropriate
      hw/vfio/container.c: use QOM casts where appropriate
      ppc/spapr_pci_vfio.c: use QOM casts where appropriate
      vfio/spapr.c: use QOM casts where appropriate
      vfio/vfio-container.h: rename VFIOContainer bcontainer field to parent_obj
      vfio-user/container.h: update VFIOUserContainer declaration
      vfio/container.c: use QOM casts where appropriate
      vfio-user/container.h: rename VFIOUserContainer bcontainer field to parent_obj
      vfio-user/pci.c: update VFIOUserPCIDevice declaration
      vfio-user/pci.c: use QOM casts where appropriate
      vfio-user/pci.c: rename VFIOUserPCIDevice device field to parent_obj
      vfio/pci.h: update VFIOPCIDevice declaration
      vfio/pci.c: use QOM casts where appropriate
      vfio/pci-quirks.c: use QOM casts where appropriate
      vfio/cpr.c: use QOM casts where appropriate
      vfio/igd.c: use QOM casts where appropriate
      vfio-user/pci.c: use QOM casts where appropriate
      s390x/s390-pci-vfio.c: use QOM casts where appropriate
      vfio/pci.h: rename VFIOPCIDevice pdev field to parent_obj

Steve Sistare (1):
      vfio/container: set error on cpr failure

Tomita Moeko (1):
      vfio/igd: Enable quirks when IGD is not the primary display

Zhenzhong Duan (1):
      vfio: Introduce helper vfio_pci_from_vfio_device()

 MAINTAINERS                           |   2 +
 docs/about/deprecated.rst             |  25 --
 docs/about/removed-features.rst       |  25 ++
 docs/devel/kconfig.rst                |   2 -
 hw/vfio-user/container.h              |   7 +-
 hw/vfio/pci.h                         |  20 +-
 {include/hw => hw}/vfio/vfio-region.h |   0
 include/hw/vfio/vfio-amd-xgbe.h       |  46 ---
 include/hw/vfio/vfio-calxeda-xgmac.h  |  43 --
 include/hw/vfio/vfio-container-base.h |  13 +-
 include/hw/vfio/vfio-container.h      |   7 +-
 include/hw/vfio/vfio-device.h         |   2 +-
 include/hw/vfio/vfio-platform.h       |  78 ----
 hw/arm/virt.c                         |   5 -
 hw/core/sysbus-fdt.c                  | 383 ------------------
 hw/ppc/spapr_pci_vfio.c               |   2 +-
 hw/s390x/s390-pci-vfio.c              |  14 +-
 hw/vfio-user/container.c              |  26 +-
 hw/vfio-user/pci.c                    |  18 +-
 hw/vfio/amd-xgbe.c                    |  61 ---
 hw/vfio/calxeda-xgmac.c               |  61 ---
 hw/vfio/container.c                   |  35 +-
 hw/vfio/cpr-legacy.c                  |  14 +-
 hw/vfio/cpr.c                         |  12 +-
 hw/vfio/device.c                      |   2 +-
 hw/vfio/igd.c                         |  45 ++-
 hw/vfio/iommufd.c                     |   4 +-
 hw/vfio/listener.c                    |  20 +-
 hw/vfio/pci-quirks.c                  |  48 ++-
 hw/vfio/pci.c                         | 217 +++++++----
 hw/vfio/platform.c                    | 716 ----------------------------------
 hw/vfio/spapr.c                       |  16 +-
 hw/arm/Kconfig                        |   3 -
 hw/vfio/Kconfig                       |  16 -
 hw/vfio/meson.build                   |   3 -
 hw/vfio/trace-events                  |  11 -
 36 files changed, 329 insertions(+), 1673 deletions(-)
 rename {include/hw => hw}/vfio/vfio-region.h (100%)
 delete mode 100644 include/hw/vfio/vfio-amd-xgbe.h
 delete mode 100644 include/hw/vfio/vfio-calxeda-xgmac.h
 delete mode 100644 include/hw/vfio/vfio-platform.h
 delete mode 100644 hw/vfio/amd-xgbe.c
 delete mode 100644 hw/vfio/calxeda-xgmac.c
 delete mode 100644 hw/vfio/platform.c


