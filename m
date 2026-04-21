Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A3FF8FA90
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 16:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFE4F-0004gi-7r; Tue, 21 Apr 2026 12:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wFE3q-0004ZO-Fz
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:34:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wFE3j-0007Jl-Ba
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776789284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/LqUDRlogHhYUCPpYVNRooabDsN3i0xGZtO0LryLFFk=;
 b=RWZPn9TKe5GTAwjfoEzZDsLnBhvMgBHXoKzYdfwKhFuO2iucFFZC592pfkoPthqRM9tvtr
 RJW91lDPQ2zkQuPW8mDM/XMpCYezUu8RdtlMpgc75lZTdjGwRhOQC/NjOjiy8T6/tmoYNr
 e7jWgKdV6vDmLr86zv5qKs/t8WuV8Xc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-h2WwobKtN-mqFP0ZiFoMTA-1; Tue,
 21 Apr 2026 12:34:42 -0400
X-MC-Unique: h2WwobKtN-mqFP0ZiFoMTA-1
X-Mimecast-MFC-AGG-ID: h2WwobKtN-mqFP0ZiFoMTA_1776789282
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC8F8195605F; Tue, 21 Apr 2026 16:34:41 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.70])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5C4061956095; Tue, 21 Apr 2026 16:34:40 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/14] vfio queue
Date: Tue, 21 Apr 2026 18:34:24 +0200
Message-ID: <20260421163438.3447280-1-clg@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 98b060da3a4f92b2a994ead5b16a87e783baf77c:

  Update version for v11.0.0 release (2026-04-21 16:28:47 +0100)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20260421

for you to fetch changes up to aad4254c6d00d9382ae8a6d105a74f493760e738:

  vfio-user: fix DMA write reply (2026-04-21 18:28:42 +0200)

----------------------------------------------------------------
vfio queue:

* Refactors vfio code to remove CONFIG_KVM, CONFIG_IOMMU and
  CONFIG_VFIO_IGD, enabling vfio files to be common files
* Extracts KVM-specific helpers and SPAPR KVM code into separate files
* Improves iommufd with dirty tracking support for nesting parent
  HWPT and variable naming cleanup
* Adds VFIO I/O backend capability flags for feature support
* Enhances vfio-user with DEVICE_FEATURE support and DMA protocol fixes

----------------------------------------------------------------
Cédric Le Goater (1):
      vfio: Add VFIO I/O backend capability flags for feature support

John Levon (3):
      vfio-user: support VFIO_USER_DEVICE_FEATURE
      vfio-user: correct protocol for DMA reads/writes
      vfio-user: fix DMA write reply

Pierrick Bouvier (8):
      hw/vfio/listener.c: remove CONFIG_KVM
      hw/vfio/helpers.c: extract kvm helpers in kvm-helpers.c
      hw/vfio/pci-quirks.c: remove CONFIG_VFIO_IGD
      hw/vfio: eradicate CONFIG_IOMMU from sources
      hw/vfio/pci.c: eradicate CONFIG_KVM
      hw/vfio/ap.c: use full path for target specific header
      hw/vfio/spapr.c: extract vfio_spapr_kvm_attach_tce to hw/vfio/kvm-spapr.c
      hw/vfio: all vfio files can now be common files

Shameer Kolothum (1):
      hw/vfio/iommufd: Control dirty tracking for nesting parent HWPT

Zhenzhong Duan (1):
      iommufd: Rename all the idev and idevc variables to hiod and hiodc

 docs/interop/vfio-user.rst    |   8 +-
 hw/arm/smmuv3-accel.h         |   2 +-
 hw/vfio-user/protocol.h       |  14 ++-
 hw/vfio/kvm-spapr.h           |  12 +++
 hw/vfio/pci.h                 |   2 +
 include/hw/core/iommu.h       |   2 +
 include/hw/vfio/vfio-device.h |  14 +++
 include/system/iommufd.h      |  12 +--
 target/s390x/kvm/kvm_s390x.h  |   2 +-
 backends/iommufd.c            |  26 +++---
 hw/arm/smmuv3-accel.c         |  93 ++++++++++----------
 hw/i386/intel_iommu.c         |   7 +-
 hw/i386/intel_iommu_accel.c   |  44 +++++-----
 hw/vfio-user/device.c         |  42 +++++++++
 hw/vfio-user/pci.c            |  30 +++++--
 hw/vfio/ap.c                  |  11 +--
 hw/vfio/ccw.c                 |   9 --
 hw/vfio/container-legacy.c    |  10 +--
 hw/vfio/device.c              |  13 +++
 hw/vfio/helpers.c             | 172 -------------------------------------
 hw/vfio/igd-stubs.c           |  20 +++++
 hw/vfio/iommufd.c             |  35 +++++---
 hw/vfio/kvm-helpers.c         | 192 ++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/kvm-spapr.c           |  47 +++++++++++
 hw/vfio/kvm-stubs.c           |  34 ++++++++
 hw/vfio/listener.c            |   4 -
 hw/vfio/pci-quirks.c          |   5 --
 hw/vfio/pci.c                 |  39 +++------
 hw/vfio/region.c              |   5 ++
 hw/vfio/spapr.c               |  30 +------
 hw/vfio-user/trace-events     |  23 ++---
 hw/vfio/meson.build           |   6 +-
 32 files changed, 580 insertions(+), 385 deletions(-)
 create mode 100644 hw/vfio/kvm-spapr.h
 create mode 100644 hw/vfio/igd-stubs.c
 create mode 100644 hw/vfio/kvm-helpers.c
 create mode 100644 hw/vfio/kvm-spapr.c
 create mode 100644 hw/vfio/kvm-stubs.c


