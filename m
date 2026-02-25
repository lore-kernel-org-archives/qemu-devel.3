Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB32BEFD211
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 09:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvB4W-0000HF-MI; Wed, 25 Feb 2026 04:20:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vvB4U-0000H2-SF
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 04:20:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vvB4S-0003Qz-QU
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 04:20:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772011239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jsuIoXMwcSXBdK5HIljOOoJYfeLpNq1t7p5+E9vLS4Q=;
 b=HHnkw5qYzqklA5ZseW1sM9hcbx6TdZx2XhXhCH77oXfKUTBIqoaReJZAUcQbxHa+9clHQy
 1AApKJLwqMRb4/cvkD5LbiPpIah8wI65nDGG1ZH9Xpz3dLOi9To+EXza1IsysvNGc8T2I1
 tGp59KJCZXKFn04J2HPlEWZ22r4p2Os=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-sMA2KxbnPbOtfWkBzSf1Qw-1; Wed,
 25 Feb 2026 04:20:35 -0500
X-MC-Unique: sMA2KxbnPbOtfWkBzSf1Qw-1
X-Mimecast-MFC-AGG-ID: sMA2KxbnPbOtfWkBzSf1Qw_1772011233
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 211841956053; Wed, 25 Feb 2026 09:20:33 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.158])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D38E019560A2; Wed, 25 Feb 2026 09:20:26 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, Jason Wang <jasowang@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 00/16] hw/i386/pc: Remove deprecated 2.8 and 2.9 PC machines
Date: Wed, 25 Feb 2026 10:20:08 +0100
Message-ID: <20260225092024.794595-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The -2.8 and -2.9 machine types of the i440fx and q35 machines are
older than 6 years, so according to our support policy we can remove
them, together with a lot of the compatibility knobs that they were
using.

This is a respin of Philippe's original series here:

 https://lore.kernel.org/qemu-devel/20250501210456.89071-1-philmd@linaro.org

The following three patches still need a review:

- hw/pci/pcie: Remove QEMU_PCIE_EXTCAP_INIT definition
- hw/i386/x86-iommu: Remove X86IOMMUState::pt_supported field
- tests/qtest/test-x86-cpuid-compat: Remove the test with the i440fx-2.9 machine

Changes in v2:

- Rebased all patches to current master, and fixed the contextual conflicts
- Added Igor's Reviewed-bys
- Dropped the "hw/southbridge/ich9: Remove ICH9_LPC_SMI_F_BROADCAST_BIT
  definition" patch since the code is still required (the guest can decide
  whether to use this feature or not)
- Dropped the two "hw/nvram/fw_cfg" patches since Igor mentioned that it
  still might be useful to keep this configuration knob
- Fix "hw/pci/pcie: Remove QEMU_PCIE_EXTCAP_INIT definition" according to
  Igor's review
- Adjusted "hw/i386/x86-iommu: Remove X86IOMMUState::pt_supported field":
  The problematic hunk has already been merged in upstream, so I dropped
  it from this patch.
- Added the final patch to drop a qtest that required this machine

Philippe Mathieu-Daudé (15):
  hw/i386/pc: Remove deprecated pc-q35-2.8 and pc-i440fx-2.8 machines
  hw/i386/pc: Remove pc_compat_2_8[] array
  hw/i386/kvm: Remove KVMClockState::mach_use_reliable_get_clock field
  hw/core/machine: Remove hw_compat_2_8[] array
  hw/block/pflash: Remove PFlashCFI01::old_multiple_chip_handling field
  hw/pci/pcie: Remove QEMU_PCIE_EXTCAP_INIT definition
  hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_INIT_DEVERR definition
  hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_INIT_LNKCTL definition
  hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_INIT_PM definition
  hw/i386/pc: Remove deprecated pc-q35-2.9 and pc-i440fx-2.9 machines
  hw/i386/pc: Remove pc_compat_2_9[] array
  hw/core/machine: Remove hw_compat_2_9[] array
  hw/net/virtio-net: Remove VirtIONet::mtu_bypass_backend field
  hw/pci-bridge/gen_pcie_rp: Remove GenPCIERootPort::migrate_msix field
  hw/i386/x86-iommu: Remove X86IOMMUState::pt_supported field

Thomas Huth (1):
  tests/qtest/test-x86-cpuid-compat: Remove the test with the i440fx-2.9
    machine

 include/hw/core/boards.h            |  6 -----
 include/hw/i386/pc.h                |  6 -----
 include/hw/i386/x86-iommu.h         |  1 -
 include/hw/pci/pci.h                |  2 --
 include/hw/virtio/virtio-net.h      |  1 -
 include/hw/virtio/virtio-pci.h      | 12 ----------
 hw/block/pflash_cfi01.c             | 14 +++---------
 hw/core/machine.c                   | 22 ------------------
 hw/i386/intel_iommu.c               | 13 ++---------
 hw/i386/kvm/clock.c                 | 18 ---------------
 hw/i386/pc.c                        | 14 ------------
 hw/i386/pc_piix.c                   | 18 ---------------
 hw/i386/pc_q35.c                    | 18 ---------------
 hw/i386/x86-iommu.c                 |  1 -
 hw/net/virtio-net.c                 |  8 ++-----
 hw/pci-bridge/gen_pcie_root_port.c  | 16 ++-----------
 hw/pci/pci.c                        |  2 --
 hw/pci/pcie.c                       |  6 ++---
 hw/virtio/virtio-pci.c              | 35 ++++++++---------------------
 tests/qtest/test-x86-cpuid-compat.c | 11 ---------
 20 files changed, 20 insertions(+), 204 deletions(-)

-- 
2.53.0


