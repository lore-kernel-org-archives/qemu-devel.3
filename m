Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36A1CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 12:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSDLs-0002Xj-KI; Wed, 27 May 2026 08:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wSDLq-0002X8-Q3
 for qemu-devel@nongnu.org; Wed, 27 May 2026 08:27:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wSDLo-0001Ah-4o
 for qemu-devel@nongnu.org; Wed, 27 May 2026 08:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779884826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SOdfET/fdkap+zJjB14WErwi6GQt6AXCmsDfpIvY+6A=;
 b=fGeWCmyBKIv4VJLi14DqkOIXhUq4wf6V0KTkhJROpZ+nAasNnRdF3ZSknWRu0PHVO6V5Uj
 x09RP2qBczs1SYnpW110isodgSR83ShTrKno78ZotrjlOw5orWkeEZl+ZconJmwyyUA3/U
 BQ4dCeGq7lgvT3fn7RmncqEesEv5l2E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-bcmwF0i-NuK6IYnsCeMt6g-1; Wed,
 27 May 2026 08:27:04 -0400
X-MC-Unique: bcmwF0i-NuK6IYnsCeMt6g-1
X-Mimecast-MFC-AGG-ID: bcmwF0i-NuK6IYnsCeMt6g_1779884824
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0737519560AE
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 12:27:04 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.55])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CD95230001BB; Wed, 27 May 2026 12:27:02 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 0/7] vfio queue
Date: Wed, 27 May 2026 14:26:53 +0200
Message-ID: <20260527122700.1589764-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 3f89b5de5b1ff16873bcda7d5f3ff5b9164f691e:

  Merge tag 'pull-target-arm-20260526' of https://gitlab.com/pm215/qemu into staging (2026-05-26 13:20:15 -0400)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20260527

for you to fetch changes up to e6c47bebdf8628e635e1ba970919ca96d572dbbe:

  vfio/container: Restrict dma_map_file() to shared RAM or RAM devices (2026-05-27 12:15:17 +0200)

----------------------------------------------------------------
vfio queue:

* Fix vfio-user: container disconnect on device info query failure,
  reject zero DMA and migration page size capabilities
* Fix dma_map_file() to avoid DMA against MAP_PRIVATE RAMBlocks
* Remove unused vfio_region_unmap()
* Update linux-headers to Linux v7.1-rc4
* Mark Multi-process QEMU as Odd Fixes in MAINTAINERS

----------------------------------------------------------------
Chenyi Qiang (1):
      vfio/container: Restrict dma_map_file() to shared RAM or RAM devices

Cédric Le Goater (1):
      linux-headers: Update to Linux v7.1-rc4

GuoHan Zhao (3):
      vfio-user: disconnect container when device info query fails
      vfio-user: reject zero DMA page size capability
      vfio-user: reject zero migration page size capability

Jagannathan Raman (1):
      MAINTAINERS: Mark Multi-process QEMU as Odd Fixes

Xiaoyao Li (1):
      vfio: Clean up vfio_region_unmap()

 MAINTAINERS                                        |   2 +-
 hw/vfio/vfio-region.h                              |   1 -
 include/standard-headers/drm/drm_fourcc.h          |  28 +-
 include/standard-headers/linux/const.h             |  18 +
 include/standard-headers/linux/ethtool.h           |  28 +-
 include/standard-headers/linux/input-event-codes.h |  13 +
 include/standard-headers/linux/pci_regs.h          |  71 +++-
 include/standard-headers/linux/typelimits.h        |   8 +
 include/standard-headers/linux/virtio_ring.h       |   5 +-
 include/standard-headers/linux/virtio_rtc.h        | 237 +++++++++++
 include/standard-headers/linux/vmclock-abi.h       |  20 +
 linux-headers/asm-arm64/kvm.h                      |   1 +
 linux-headers/asm-arm64/unistd_64.h                |   1 +
 linux-headers/asm-generic/unistd.h                 |   5 +-
 linux-headers/asm-loongarch/kvm.h                  |   5 +
 linux-headers/asm-loongarch/kvm_para.h             |   1 +
 linux-headers/asm-loongarch/unistd_64.h            |   2 +
 linux-headers/asm-mips/unistd_n32.h                |   1 +
 linux-headers/asm-mips/unistd_n64.h                |   1 +
 linux-headers/asm-mips/unistd_o32.h                |   1 +
 linux-headers/asm-powerpc/unistd_32.h              |   1 +
 linux-headers/asm-powerpc/unistd_64.h              |   1 +
 linux-headers/asm-riscv/kvm.h                      |  11 +-
 linux-headers/asm-riscv/ptrace.h                   |  37 ++
 linux-headers/asm-riscv/unistd_32.h                |   1 +
 linux-headers/asm-riscv/unistd_64.h                |   1 +
 linux-headers/asm-s390/unistd_32.h                 | 446 ---------------------
 linux-headers/asm-s390/unistd_64.h                 |   1 +
 linux-headers/asm-x86/kvm.h                        |  21 +-
 linux-headers/asm-x86/unistd_32.h                  |   1 +
 linux-headers/asm-x86/unistd_64.h                  |   1 +
 linux-headers/asm-x86/unistd_x32.h                 |   1 +
 linux-headers/linux/const.h                        |  18 +
 linux-headers/linux/iommufd.h                      |  48 +++
 linux-headers/linux/kvm.h                          |  46 ++-
 linux-headers/linux/mshv.h                         |   4 +-
 linux-headers/linux/psp-sev.h                      |   2 +-
 linux-headers/linux/stddef.h                       |   4 +
 linux-headers/linux/vduse.h                        |  85 +++-
 linux-headers/linux/vfio.h                         |  30 +-
 hw/vfio-user/container.c                           |   7 +-
 hw/vfio-user/proxy.c                               |  16 +-
 hw/vfio/container.c                                |  34 +-
 hw/vfio/region.c                                   |  15 -
 44 files changed, 761 insertions(+), 520 deletions(-)
 create mode 100644 include/standard-headers/linux/typelimits.h
 create mode 100644 include/standard-headers/linux/virtio_rtc.h
 delete mode 100644 linux-headers/asm-s390/unistd_32.h


