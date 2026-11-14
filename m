Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9657A606A32E
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 15:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSFy5-0001lm-Fh; Sat, 14 Nov 2026 10:47:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSFy2-0001iy-Er; Sat, 14 Nov 2026 10:47:02 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSFxz-0005uH-QO; Sat, 14 Nov 2026 10:47:02 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwAHD1tngvhqMgkGAg--.41682S2; 
 Sat, 14 Nov 2026 23:46:47 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwjHVhgvhqRdv6AA--.29616S3;
 Sat, 14 Nov 2026 23:46:42 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Mostafa Saleh <smostafa@google.com>,
 Chao Liu <chao.liu@processmission.com>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PATCH v6 00/35] hw/arm/smmuv3: Support Secure state for SMMUv3
Date: Sat, 14 Nov 2026 23:46:23 +0800
Message-Id: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwjHVhgvhqRdv6AA--.29616S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQATBWr3ZUsBAgACsl
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3JF13Aw4rJFy8tF15Jw13Arb_yoW7tr4kpa
 yfC3sxKrWDCa47ZrWxJa1I9asxJan7J3WUtrnrGryrXr1jyryfJr4jy34rKFyDCFyUZF43
 u3WIgan7Wr1jy3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

This is v6 of the Secure SMMUv3 series.

Many thanks to everyone who reviewed the earlier versions. This version contains
35 commits in total. Most of them are confined to the Arm SMMU model. But a few
commits also touch the PCI device model, and the virt machine model.

Secure Stage 2 is not implemented. Secure STEs which enable Stage 2 are
rejected with C_BAD_STE. Realm and Root programming interfaces are outside the
scope of this series.


Commits layout:
---------------
The commits are roughly grouped as follows:

1. (#30, hw/pci only) Add a PCIDevice "sec-sid" property so boards can mark a
   device's SEC_SID (system integration knob).
2. (#1-2, #31-35) Core data-structure and plumbing refactors.
3. (#3-8) Introduce SEC_SID through caches, notifiers, and helpers.
4. (#9-12) Page table walk related updates (e.g. NSCFG/PTE helpers).
5. (#13-20) EVTQ/CMDQ handling and invalidation paths.
6. (#21-29) MMIO/register access checks and architectural corner cases.


Changes since v5:
----------------
- Split the invalidation and register-check patches, separate secure-impl
  from migration, and move S2 walker changes into the page-table walk patch.
- Add fixes for Secure S1 VMID tagging (#18) and ATC_INV checks (#20).
- Validate sec-sid in the PCI setter, reject incompatible devices through
  the PCI IOMMU check, and refresh SEC_SID on device reuse.
- Wire Secure IRQs on virt and sbsa-ref, and update CMDQV IRQ indexing.
- Document secure-impl and preserve the previous default for older
  machine types.
- Drop the temporary [NOT-MERGE] Hafnium bring-up patch.


Testing notes:
--------------
- Testing MMIO accesses
I also tested Secure-bank register reads and writes using Hafnium
firmware as described in [1].

- Testing DMA translation
I integrated this series with the latest RFCing QTest memory-attribute
extensions from [2]. The test integration also includes the iommu-testdev DMA
readback fix and the SMMUv3 security-space tests. It is available in [3].

All five SMMUv3 test cases passed:
-- Non-secure Stage 1.
-- Non-secure Stage 2.
-- Non-secure nested translation.
-- Secure Stage 1.
-- Secure Stage 2 rejection with C_BAD_STE.

The first three cases has upstreamed. For the last two cases:

    QTEST_QEMU_BINARY=./build/qemu-system-aarch64 \
      ./build/tests/qtest/iommu-smmuv3-test --tap -k \
      -p /aarch64/iommu-testdev/translation/secure-s1-only

    QTEST_QEMU_BINARY=./build/qemu-system-aarch64 \
      ./build/tests/qtest/iommu-smmuv3-test --tap -k \
      -p /aarch64/iommu-testdev/translation/secure-s2-only-bad-ste


The patches also available at [4]. The CI [5] passed with warnings from two jobs,
which also occured in upstream CI.

Best regards,
Tao

[1] https://hnusdr.github.io/2025/08/09/Test-Secure-SMMU-with-Hafnium-ENG/
[2] https://gitlab.com/TaoTang/qemu/-/tree/series/qtest-secure-v6
[3] https://gitlab.com/TaoTang/qemu/-/tree/integration/secure-smmu-v6-qtest
[4] https://gitlab.com/TaoTang/qemu/-/tree/series/secure-smmu-v6
[5] https://gitlab.com/TaoTang/qemu/-/pipelines/3065596056

Tao Tang (35):
  hw/arm/smmuv3: Introduce Secure registers
  hw/arm/smmuv3: Introduce banked registers for SMMUv3 state
  hw/arm/smmuv3: Thread SEC_SID through helper APIs
  hw/arm/smmuv3: Track SEC_SID in configs and events
  hw/arm/smmu-common: Add security-aware address space selector
  hw/arm/smmuv3: Plumb transaction attributes into config helpers
  hw/arm/smmuv3: Reject Secure STEs with stage-2 enabled
  hw/arm/smmu-common: Key configuration cache on SMMUDevice and SEC_SID
  hw/arm/smmu: Add PTE NS/NSTable helpers
  hw/arm/smmuv3: Store CD NSCFG in TT info
  hw/arm/smmu-common: Implement Secure state handling in ptw
  hw/arm/smmuv3: Tag IOTLB cache keys with SEC_SID
  hw/arm/smmuv3: Pass sec_sid into cmdq consume path
  hw/arm/smmuv3: Make evtq producer use SEC_SID
  hw/arm/smmuv3: Limit IOMMU notifications to Non-secure targets
  hw/arm/smmuv3: Scope configuration invalidation by SEC_SID
  hw/arm/smmuv3: Scope IOTLB invalidation by SEC_SID
  hw/arm/smmuv3: Fix VMID tagging for Secure stage 1
  hw/arm/smmuv3: Keep accelerated invalidation Non-secure-only
  hw/arm/smmuv3: Fix ATC invalidation command checks
  hw/arm/smmuv3: Make GERROR_IRQ_CFG registers RES0 without MSI
  hw/arm/smmuv3: Ignore CR2 writes while the SMMU is enabled
  hw/arm/smmuv3: Guard stream table register writes
  hw/arm/smmuv3: Guard command queue register writes
  hw/arm/smmuv3: Guard event queue register writes
  hw/arm/smmuv3: Determine register bank from MMIO offset
  hw/arm/smmuv3: Route IRQ and GERROR handling by SEC_SID
  hw/arm/smmuv3: Implement SMMU_S_INIT register
  hw/arm/smmuv3: Harden security checks in MMIO handlers
  hw/pci: Add sec-sid property to PCIDevice
  hw/arm/smmuv3: Select sec-sid from PCI property and validate
    SECURE_IMPL
  hw/arm/smmuv3: Reject IOMMU notifiers for non-NS devices
  hw/arm/smmuv3: Initialize the Secure register bank
  hw/arm/smmuv3: Add the secure-impl property
  hw/arm/smmuv3: Migrate the Secure register bank

 docs/system/arm/virt.rst       |   11 +
 hw/arm/smmu-internal.h         |   13 +
 hw/arm/smmuv3-internal.h       |   39 +-
 include/hw/arm/smmu-common.h   |   80 ++-
 include/hw/arm/smmuv3-common.h |   71 +-
 include/hw/arm/smmuv3.h        |   44 +-
 include/hw/arm/virt.h          |    1 +
 include/hw/pci/pci_device.h    |    3 +
 hw/arm/sbsa-ref.c              |    8 +
 hw/arm/smmu-common.c           |  426 ++++++++++--
 hw/arm/smmuv3-accel.c          |   77 ++-
 hw/arm/smmuv3.c                | 1184 +++++++++++++++++++++++---------
 hw/arm/tegra241-cmdqv.c        |    6 +-
 hw/arm/virt-acpi-build.c       |    3 +-
 hw/arm/virt.c                  |    7 +
 hw/core/machine.c              |    1 +
 hw/pci/pci.c                   |   48 ++
 hw/arm/trace-events            |   37 +-
 18 files changed, 1597 insertions(+), 462 deletions(-)

--
2.34.1


