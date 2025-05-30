Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9669AC5B543
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 11:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKyCp-0000R4-0t; Fri, 30 May 2025 07:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKyCm-0000Qk-7h
 for qemu-devel@nongnu.org; Fri, 30 May 2025 07:47:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKyCj-0002iH-St
 for qemu-devel@nongnu.org; Fri, 30 May 2025 07:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748605634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2q0VdY4ZERtZvo5VzZjGGKAzfECuDiuynYKQRRWNpMA=;
 b=CQpaZLj8M68YRmrfcyA+QYCd0aTNcHwwJfgqx+EDOsRemeNKJJ4rQVBWxgPhtnhLXbw5tD
 P3kNkUyzpQ8/oH6zQDyjRFtL1yy/zM8rmaG1ibvzmOXl9mqK6x/4uQe2fl8Ph1JAs0irAf
 o2OlfOLYy448Fk8rJExaPC+cQ+8/WMc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-iqjxcHouMxGoUS3645VEcQ-1; Fri,
 30 May 2025 07:47:13 -0400
X-MC-Unique: iqjxcHouMxGoUS3645VEcQ-1
X-Mimecast-MFC-AGG-ID: iqjxcHouMxGoUS3645VEcQ_1748605632
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 782381956080
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 11:47:12 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.76])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C95018003FD; Fri, 30 May 2025 11:47:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 00/25] Functional tests, Microblaze endianness & pc/q35 cleanups
Date: Fri, 30 May 2025 13:47:09 +0200
Message-ID: <20250530114709.186993-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
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

 Hi Stefan!

The following changes since commit d2e9b78162e31b1eaf20f3a4f563da82da56908d:

  Merge tag 'pull-qapi-2025-05-28' of https://repo.or.cz/qemu/armbru into staging (2025-05-29 08:36:01 -0400)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2025-05-30

for you to fetch changes up to 5c54a367265ec19ed94a535cd15d178c16b8cae0:

  tests/unit/test-util-sockets: fix mem-leak on error object (2025-05-30 09:52:08 +0200)

----------------------------------------------------------------
* Functional tests improvements
* Endianness improvements/clean-ups for the Microblaze machines
* Remove obsolete -2.4 and -2.5 i440fx and q35 machine types and related code

v3: Fixed a problem in the microblaze patches that caused CI failure

----------------------------------------------------------------
Matheus Tavares Bernardino (1):
      tests/unit/test-util-sockets: fix mem-leak on error object

Philippe Mathieu-Daudé (17):
      hw/i386/pc: Remove deprecated pc-q35-2.4 and pc-i440fx-2.4 machines
      hw/i386/pc: Remove PCMachineClass::broken_reserved_end field
      hw/i386/pc: Remove pc_compat_2_4[] array
      hw/core/machine: Remove hw_compat_2_4[] array
      hw/net/e1000: Remove unused E1000_FLAG_MAC flag
      hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_MIGRATE_EXTRA definition
      hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_DISABLE_PCIE definition
      hw/i386/pc: Remove deprecated pc-q35-2.5 and pc-i440fx-2.5 machines
      hw/i386/x86: Remove X86MachineClass::save_tsc_khz field
      hw/nvram/fw_cfg: Remove legacy FW_CFG_ORDER_OVERRIDE
      hw/core/machine: Remove hw_compat_2_5[] array
      hw/scsi/vmw_pvscsi: Remove PVSCSI_COMPAT_OLD_PCI_CONFIGURATION definition
      hw/scsi/vmw_pvscsi: Remove PVSCSI_COMPAT_DISABLE_PCIE_BIT definition
      hw/scsi/vmw_pvscsi: Convert DeviceRealize -> InstanceInit
      hw/net/vmxnet3: Remove VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS definition
      hw/net/vmxnet3: Remove VMXNET3_COMPAT_FLAG_DISABLE_PCIE definition
      hw/net/vmxnet3: Merge DeviceRealize in InstanceInit

Thomas Huth (7):
      tests/functional/test_sparc64_tuxrun: Explicitly set the 'sun4u' machine
      tests/functional/test_mips_malta: Re-enable the check for the PCI host bridge
      tests/functional/test_mem_addr_space: Use set_machine() to select the machine
      hw/microblaze: Add endianness property to the petalogix_s3adsp1800 machine
      tests/functional: Test both microblaze s3adsp1800 endianness variants
      hw/microblaze: Remove the big-endian variants of ml605 and xlnx-zynqmp-pmu
      docs: Deprecate the qemu-system-microblazeel binary

 docs/about/deprecated.rst                        |  19 ++--
 docs/about/removed-features.rst                  |   9 ++
 include/hw/boards.h                              |   9 +-
 include/hw/i386/pc.h                             |   7 --
 include/hw/i386/x86.h                            |   5 --
 include/hw/loader.h                              |   2 -
 include/hw/nvram/fw_cfg.h                        |  10 ---
 include/hw/virtio/virtio-pci.h                   |   8 --
 hw/core/loader.c                                 |  14 ---
 hw/core/machine.c                                |  18 ----
 hw/i386/pc.c                                     |  42 ++-------
 hw/i386/pc_piix.c                                |  26 ------
 hw/i386/pc_q35.c                                 |  26 ------
 hw/i386/x86.c                                    |   1 -
 hw/microblaze/petalogix_ml605_mmu.c              |  15 +---
 hw/microblaze/petalogix_s3adsp1800_mmu.c         |  42 +++++++--
 hw/microblaze/xlnx-zynqmp-pmu.c                  |   7 +-
 hw/net/e1000.c                                   |  95 +++++++++-----------
 hw/net/vmxnet3.c                                 |  44 ++-------
 hw/nvram/fw_cfg.c                                | 110 ++---------------------
 hw/scsi/vmw_pvscsi.c                             |  67 +++-----------
 hw/virtio/virtio-pci.c                           |  11 +--
 system/vl.c                                      |   5 --
 target/i386/machine.c                            |   5 +-
 tests/qtest/test-x86-cpuid-compat.c              |  14 ---
 tests/unit/test-util-sockets.c                   |   4 +
 tests/functional/test_mem_addr_space.py          |  63 ++++++-------
 tests/functional/test_microblaze_s3adsp1800.py   |  18 ++--
 tests/functional/test_microblazeel_s3adsp1800.py |   6 +-
 tests/functional/test_mips_malta.py              |   6 +-
 tests/functional/test_sparc64_tuxrun.py          |   1 +
 31 files changed, 198 insertions(+), 511 deletions(-)


