Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257AEC88E7E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 09:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkIni-0001ls-Rr; Mon, 26 Jan 2026 04:22:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vkIne-0001iZ-DQ
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 04:22:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vkInc-0005sw-M1
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 04:22:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769419339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yCITULsD6dLTaLan8MMBGXgVg2icZrqocnzYrfbIq58=;
 b=V2ITif24yTHuGcsSQsyBh0lnqk8CfrYXXj9Fa+YClAPEmwVom5ak4xy/lfTEeDLZ4ULNnd
 oMNwP+b6IgL0JEZv6jjIwR4FDznke0hV73kie3Ica+qbyrVn3Fu5Hdy9aych9jFW7rU7Ik
 nO9vQd376TpDzGFPb3KTfvsc1J/B8Xo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-iLFHshAlPR6WtAfPoqEagA-1; Mon,
 26 Jan 2026 04:22:17 -0500
X-MC-Unique: iLFHshAlPR6WtAfPoqEagA-1
X-Mimecast-MFC-AGG-ID: iLFHshAlPR6WtAfPoqEagA_1769419336
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4AE0819775AF; Mon, 26 Jan 2026 09:22:16 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.175])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CA4901956095; Mon, 26 Jan 2026 09:22:14 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 0/7] vfio queue
Date: Mon, 26 Jan 2026 10:22:05 +0100
Message-ID: <20260126092212.503162-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following changes since commit fea2d7a784fc3627a8aa72875f51fe7634b04b81:

  Merge tag 'linux-user-for-v11-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-01-24 21:31:17 +1100)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20260126

for you to fetch changes up to 4c5e5d66f991599bd34a65fc243d3c513e6b1e81:

  vfio-user: update VFIOProxy flag constants to use the BIT() macro (2026-01-26 08:30:04 +0100)

----------------------------------------------------------------
vfio queue:

* Fixes for vfio-user and CPR
* Fixes issues detected by Coverity
* Updates linux-headers to Linux v6.19-rc1
* Adds support for the creation of dma-buf objects for PCI BARs. This
  allows safe P2P DMA operations when using iommufd host backend.

----------------------------------------------------------------
Jim Shu (1):
      hw/vfio: cpr-iommufd: Fix wrong usage of migrate_add_blocker_modes

Mark Cave-Ayland (2):
      vfio-user: fix VFIO_PROXY_USE_MULTI constant value
      vfio-user: update VFIOProxy flag constants to use the BIT() macro

Nicolin Chen (1):
      hw/vfio/region: Create dmabuf for PCI BAR per region

Shameer Kolothum (2):
      linux-headers: Update to Linux v6.19-rc1
      hw/vfio: Add helper to retrieve device feature

Zhenzhong Duan (1):
      vfio/migration: Fix page size calculation

 hw/vfio-user/proxy.h                               |   8 +-
 include/hw/vfio/vfio-device.h                      |   3 +
 include/standard-headers/drm/drm_fourcc.h          |  25 +++--
 include/standard-headers/linux/ethtool.h           |   5 +
 include/standard-headers/linux/input-event-codes.h |  14 ++-
 include/standard-headers/linux/pci_regs.h          |  89 ++++++++++++++++
 include/standard-headers/linux/virtio_net.h        |   3 +-
 include/standard-headers/linux/virtio_pci.h        |   2 +-
 linux-headers/asm-arm64/kvm.h                      |   2 +-
 linux-headers/asm-arm64/unistd_64.h                |   1 +
 linux-headers/asm-generic/unistd.h                 |   4 +-
 linux-headers/asm-loongarch/kvm.h                  |   1 +
 linux-headers/asm-loongarch/unistd.h               |   6 ++
 linux-headers/asm-loongarch/unistd_64.h            |   1 +
 linux-headers/asm-mips/unistd_n32.h                |   1 +
 linux-headers/asm-mips/unistd_n64.h                |   1 +
 linux-headers/asm-mips/unistd_o32.h                |   1 +
 linux-headers/asm-powerpc/unistd_32.h              |   1 +
 linux-headers/asm-powerpc/unistd_64.h              |   1 +
 linux-headers/asm-riscv/kvm.h                      |   3 +
 linux-headers/asm-riscv/unistd_32.h                |   1 +
 linux-headers/asm-riscv/unistd_64.h                |   1 +
 linux-headers/asm-s390/bitsperlong.h               |   4 -
 linux-headers/asm-s390/unistd.h                    |   4 -
 linux-headers/asm-s390/unistd_64.h                 |   9 +-
 linux-headers/asm-x86/kvm.h                        |   1 +
 linux-headers/asm-x86/unistd_32.h                  |   1 +
 linux-headers/asm-x86/unistd_64.h                  |   1 +
 linux-headers/asm-x86/unistd_x32.h                 |   1 +
 linux-headers/linux/iommufd.h                      |  10 ++
 linux-headers/linux/kvm.h                          |  11 ++
 linux-headers/linux/mshv.h                         | 116 ++++++++++++++++++++-
 linux-headers/linux/psp-sev.h                      |  66 +++++++-----
 linux-headers/linux/vfio.h                         |  28 +++++
 hw/net/virtio-net.c                                |  11 +-
 hw/vfio/container.c                                |   2 +-
 hw/vfio/cpr-iommufd.c                              |   4 +-
 hw/vfio/device.c                                   |   9 ++
 hw/vfio/listener.c                                 |   4 +-
 hw/vfio/migration.c                                |   2 +-
 hw/vfio/region.c                                   |  65 +++++++++++-
 hw/vfio/trace-events                               |   1 +
 42 files changed, 457 insertions(+), 67 deletions(-)


