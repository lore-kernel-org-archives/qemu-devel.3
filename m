Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A09C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuY7R-0006Ig-BR; Thu, 13 Aug 2026 12:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuY7E-0006IL-Gi; Thu, 13 Aug 2026 12:17:14 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuY7B-0007n0-2H; Thu, 13 Aug 2026 12:17:11 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwDX0an57X1q7UrmAA--.5014S2;
 Fri, 14 Aug 2026 00:16:57 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8Dw9HPz7X1qwSwjAA--.57149S3;
 Fri, 14 Aug 2026 00:16:51 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>,
 Chao Liu <chao.liu@processmission.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v5 00/28] hw/arm/smmuv3: Support Secure state for SMMUv3
Date: Fri, 14 Aug 2026 00:15:15 +0800
Message-Id: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dw9HPz7X1qwSwjAA--.57149S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAGBWp8yc0HhwAAsQ
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3JF1DGr1fGw4fCFWfZw45GFg_yoWxur1rpa
 yrCrn8KrWDCFyxZrWxJw4Iva43Ga93J3Wjyr1DGryrZr1jyr9xXr40yF1rKFyDCFy5Cr47
 u3WI9F4kWr1jy3DanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi all,

This is v5 of the Secure SMMUv3 series.

Many thanks to everyone who reviewed the earlier versions. This version contains
28 commits in total. Only one patch touches hw/pci (patch #23); the remaining
patches are confined to the Arm SMMUv3 model. Also some patches in v4 have been
merged into the mainline QEMU tree, so the v5 series is now smaller than v4.

Secure Stage 2 is not implemented. Secure STEs which enable Stage 2 are
rejected with C_BAD_STE. Realm and Root programming interfaces are outside the
scope of this series.

Commits layout:
---------------
The commits are roughly grouped as follows:
1. (#23, hw/pci only) Add a PCIDevice "sec-sid" property so boards can mark a
  device's SEC_SID (system integration knob).
2. (#1-2, #24-27) Core data-structure and plumbing refactors.
3. (#3-8) Introduce SEC_SID through caches, notifiers, and helpers.
4. (#9-12) Page table walk related updates (e.g. NSCFG/PTE helpers).
5. (#13-15) EVTQ/CMDQ handling and invalidation paths.
6. (#16-22) MMIO/register access checks and architectural corner cases.
7. (#28) A temporary [NOT-MERGE] commit used with Hafnium to exercise
  secure-bank register access.


Main updates:
-------------
- (#23, hw/pci only) Add a "sec-sid" property to PCIDevice and consume it from
  the SMMU in #24 to select the security context and validate capabilities.

  @Michael: could you please review the hw/pci change
  ("hw/pci: Add sec-sid property to PCIDevice") and confirm this kind of
  system-integration property is acceptable for the PCI subtree?

  For context, I previously posted this as a standalone patch [1]:
  [1] https://lore.kernel.org/qemu-devel/20251211102729.227376-1-tangtao1634@phytium.com.cn/

  The commit in this v5 series is an updated version based on Pierrick's
  feedback (notably switching sec-sid to a string property). We also discussed
  the need for this knob as a prerequisite for accurately modelling SMMU secure
  state here [2]:

  [2] https://lore.kernel.org/qemu-devel/4870b7df-4cb3-457e-9a18-87f3558adf09@linaro.org/

  We do need a stable way for boards to statically mark devices that may issue
  Secure transactions.

other updates:
- Drop the CR0 and CFGI_CD fixes which are already upstream.
- Select MemTxAttrs and AddressSpace on demand from SEC_SID and keep the
  programming-interface namespace in the configuration and IOTLB keys.
- Route CMDQ, EventQ, IRQ and GERROR handling through the originating
  programming-interface bank.
- Tighten MMIO RAZ/WI, writability and reserved-bit handling.
- Reject unsupported non-NS IOMMU notifier registration.
- Make secure-impl an on/off/auto property, resolve auto from the Secure
  AddressSpace, and require Stage 1 support when enabled.


Testing notes:
--------------
- Testing MMIO accesses
  The branch currently contains one commit explicitly marked [NOT-MERGE]. It is
  only used to cooperate with Hafnium to exercise and validate secure-bank
  register read/write paths in a small, reproducible setup as described in [3]:
  [3] https://hnusdr.github.io/2025/08/09/Test-Secure-SMMU-with-Hafnium-ENG/

  This commit is not intended for upstream and will be dropped before posting
  the final mergeable series.

  For reference, the Hafnium test logs show the SMMU being initialized
  successfully:

  INFO: Loading VM id 0x8001: op-tee.
  INFO: Loaded with 4 vCPUs, entry at 0xe300000.
  INFO: Hafnium initialisation completed

  With all smmu* traces enabled in QEMU, we can also observe secure-bank MMIO
  accesses and secure CMDQ consumption (sec_sid=1), including CFGI invalidations
  with ssec=1.

- Testing DMA translation
  DMA translation/invalidation is tested with qtest and iommu-testdev.
  The required secure/space extensions are still under RFC at [4].
  Branch [5] adds the integration needed to test this series.

  [4] https://gitlab.com/TaoTang/qemu/tree/qtest-secure-v5
  [5] https://gitlab.com/TaoTang/qemu/tree/integration/secure-smmu-v5-qtest

  This covers Secure S1 translation and the unsupported SEL2 negative case:

    QTEST_QEMU_BINARY=./build/qemu-system-aarch64 \
      ./build/tests/qtest/iommu-smmuv3-test --tap -k \
      -p /aarch64/iommu-testdev/translation/secure-s1-only

    QTEST_QEMU_BINARY=./build/qemu-system-aarch64 \
      ./build/tests/qtest/iommu-smmuv3-test --tap -k \
      -p /aarch64/iommu-testdev/translation/secure-s2-only-bad-ste


The patches are available in:
https://gitlab.com/TaoTang/qemu/tree/series/secure-smmu-v5

CI is all green:
https://gitlab.com/TaoTang/qemu/-/pipelines/2757878178

Best regards,
Tao


Tao Tang (28):
  hw/arm/smmuv3: Introduce secure registers
  hw/arm/smmuv3: Introduce banked registers for SMMUv3 state
  hw/arm/smmuv3: Thread SEC_SID through helper APIs
  hw/arm/smmuv3: Track SEC_SID in configs and events
  hw/arm/smmu-common: Add security-aware address space selector
  hw/arm/smmuv3: Plumb transaction attributes into config helpers
  hw/arm/smmuv3: Reject secure STEs with stage-2 enabled
  hw/arm/smmu-common: Key configuration cache on SMMUDevice and SEC_SID
  hw/arm/smmu: Add PTE NS/NSTable helpers
  hw/arm/smmuv3: Store CD NSCFG in TT info
  hw/arm/smmu-common: Implement secure state handling in ptw
  hw/arm/smmuv3: Tag IOTLB cache keys with SEC_SID
  hw/arm/smmuv3: Pass sec_sid into cmdq consume path
  hw/arm/smmuv3: Make evtq producer use SEC_SID
  hw/arm/smmu: Make CMDQ invalidation security-state aware
  hw/arm/smmuv3: Add access checks for GERROR_IRQ_CFG registers
  hw/arm/smmuv3: Add access checks for STRTAB_BASE and CR2 registers
  hw/arm/smmuv3: Add access checks for CMDQ and EVENTQ registers
  hw/arm/smmuv3: Determine register bank from MMIO offset
  hw/arm/smmuv3: Route IRQ and GERROR handling by SEC_SID
  hw/arm/smmuv3: Implement SMMU_S_INIT register
  hw/arm/smmuv3: Harden security checks in MMIO handlers
  hw/pci: Add sec-sid property to PCIDevice
  hw/arm/smmuv3: Select sec-sid from PCI property and validate
    SECURE_IMPL
  hw/arm/smmuv3: Reject IOMMU notifiers for non-NS devices
  hw/arm/smmuv3: Initialize the secure register bank
  hw/arm/smmuv3: Add secure bank migration and secure-impl property
  [NOT-MERGE] hw/arm/smmuv3: temporarily enable SEL2 bit and some other
    features

 hw/arm/smmu-common.c           |  406 +++++++--
 hw/arm/smmu-internal.h         |   13 +
 hw/arm/smmuv3-accel-stubs.c    |    6 +-
 hw/arm/smmuv3-accel.c          |  104 ++-
 hw/arm/smmuv3-accel.h          |    6 +-
 hw/arm/smmuv3-internal.h       |   39 +-
 hw/arm/smmuv3.c                | 1426 +++++++++++++++++++++++++-------
 hw/arm/tegra241-cmdqv.c        |    6 +-
 hw/arm/trace-events            |   37 +-
 hw/pci/pci.c                   |    7 +
 include/hw/arm/smmu-common.h   |   74 +-
 include/hw/arm/smmuv3-common.h |   77 +-
 include/hw/arm/smmuv3.h        |   33 +-
 include/hw/pci/pci_device.h    |    3 +
 14 files changed, 1780 insertions(+), 457 deletions(-)

--
2.34.1


