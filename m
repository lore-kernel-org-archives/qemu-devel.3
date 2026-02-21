Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA217C61DE1
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Feb 2026 10:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtjpo-0005o4-1w; Sat, 21 Feb 2026 05:03:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vtjpg-0005mO-Dm; Sat, 21 Feb 2026 05:03:28 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vtjpe-00052J-0S; Sat, 21 Feb 2026 05:03:28 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwD3TNDfgplpDhdzAA--.3242S2;
 Sat, 21 Feb 2026 18:03:11 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwD3TevcgplpBk4cAA--.34138S3;
 Sat, 21 Feb 2026 18:03:08 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v4 00/31] hw/arm/smmuv3: Support Secure state for SMMUv3
Date: Sat, 21 Feb 2026 18:02:19 +0800
Message-Id: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwD3TevcgplpBk4cAA--.34138S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAJBWmTeekBBQAYs7
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3Xw1rGF1kuw4DWry3Zr17trb_yoW3XryUpa
 yfCF98KrWDCFyxZrWxZa10v3ZxKa93JF17trnxKryrZw1UAr95XrW0yr1rKFyDGry5AF47
 u3WI9F4kXr1jyaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

This is v4 of the Secure SMMUv3 series.

Many thanks to everyone who reviewed the earlier versions. This revision focuses
on tightening architectural compliance, improving integration points, and making
the SEC_SID plumbing complete across the fast paths.

This revision contains 31 commits in total. Only one patch touches hw/pci
(patch #27); the remaining patches are confined to the Arm SMMUv3 model.

Commits layout:
---------------
The commits are roughly grouped as follows:
1. (#27, hw/pci only) Add a PCIDevice "sec-sid" property so boards can mark a
  device's SEC_SID (system integration knob).
2. (#1-4, #28-30) Core data-structure and plumbing refactors.
3. (#5-10) Introduce SEC_SID through caches, notifiers, and helpers.
4. (#11-16) Page table walk related updates (e.g. NSCFG/PTE helpers).
5. (#17-20) EVTQ/CMDQ handling and invalidation paths.
6. (#21-26) MMIO/register access checks and architectural corner cases.
7. (#31) A temporary [NOT-MERGE] commit used with Hafnium to exercise
  secure-bank register access.

Main updates:
-------------
The main updates in v4 include:

1. (#27, hw/pci only) Add a "sec-sid" property to PCIDevice and consume it from
  the SMMU in #28 to select the security context and validate capabilities.

  @Michael, @Marcel: could you please review the hw/pci change
  ("hw/pci: Add sec-sid property to PCIDevice") and confirm this kind of
  system-integration property is acceptable for the PCI subtree?

  For context, I previously posted this as a standalone patch [1]:
  [1] https://lore.kernel.org/qemu-devel/20251211102729.227376-1-tangtao1634@phytium.com.cn/

  The commit in this v4 series is an updated version based on Pierrick's
  feedback (notably switching sec-sid to a string property). We also discussed
  the need for this knob as a prerequisite for accurately modelling SMMU secure
  state here [2]:

  [2] https://lore.kernel.org/qemu-devel/4870b7df-4cb3-457e-9a18-87f3558adf09@linaro.org/

  We do need a stable way for boards to statically mark devices that may issue
  Secure transactions.

2. Add secure register-bank migration and a new "secure-impl" device property to
  control S_IDR1.SECURE_IMPL.

3. Strengthen and decompose MMIO access checks (CMDQ/EVENTQ, STRTAB_BASE/CR2,
  GERROR IRQ cfg), and fix a few architectural corner cases (e.g. CFGI_CD
  behaviour when stage-1 is unsupported, and SEL2 capability checks when
  decoding STEs).

4. Make invalidation and queue handling security-state aware end-to-end: CMDQ
  invalidation paths carry the security context; SEC_SID is plumbed through cmdq
  consumption, event production, and the IOMMU notifier path; and TLB entries
  are tagged with SEC_SID to keep Secure vs Non-secure DMA isolated.

5. Totally removed #8 in V3 [3]:
  [3] https://lore.kernel.org/qemu-devel/20251012150701.4127034-9-tangtao1634@phytium.com.cn/

  and use the merged patch "hw/arm/smmu: add memory regions as property for an
  SMMU instance" which is committed by Pierrick, to handle the SMMU-internal
  Secure/Non-Secure AddressSpace.

6. Track NS/NSTable and CD.NSCFG translation attributes for correct Secure vs
  Non-secure page-table interpretation.

7. Note: the branch contains a `NOT-MERGE` bring-up commit for Hafnium test and
  is not intended for upstream submission.


Testing notes:
--------------
- Non-secure regression coverage
  QEMU  CI already exercises the baseline (non-secure) SMMUv3 paths via
  iommu-testdev + iommu-smmuv3-test and test_device_passthrough.py, and those
  jobs are passing with this work applied.

- Testing MMIO accesses
  The branch currently contains one commit explicitly marked [NOT-MERGE]. It is
  only used to cooperate with Hafnium to exercise and validate secure-bank
  register read/write paths in a small, reproducible setup as described in [4]:
  [4] https://hnusdr.github.io/2025/08/09/Test-Secure-SMMU-with-Hafnium-ENG/

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

- Testing translations
  The translation/invalidation flows are exercised using qtest plus
  iommu-testdev. The qtest/iommu-testdev extensions needed for the new
  secure/space plumbing will be posted as a separate incremental series;
  the current work-in-progress code is already available at [5]:
  [5] https://github.com/hnusdr/qemu/tree/qtest-arm-secure-api

  Secure Stage 1 translation can be tested with
  /iommu-testdev/translation/secure-s1-only using the previous WIP branch.


The patches are available in:
https://github.com/hnusdr/qemu/tree/secure-smmu-v4-community

CI result:
https://gitlab.com/TaoTang/qemu/-/pipelines/2340976439

Best regards,
Tao


Tao Tang (31):
  hw/arm/smmuv3-common: Fix incorrect reserved mask for SMMU CR0
    register
  hw/arm/smmuv3: Correct SMMUEN field name in CR0
  hw/arm/smmuv3: Introduce secure registers
  hw/arm/smmuv3: Introduce banked registers for SMMUv3 state
  hw/arm/smmuv3: Thread SEC_SID through helper APIs
  hw/arm/smmuv3: Track SEC_SID in configs and events
  hw/arm/smmu-common: Add security-aware address space selector
  hw/arm/smmuv3: Plumb transaction attributes into config helpers
  hw/arm/smmuv3: Enforce Secure stage 2 capability check when decoding
    STE
  hw/arm/smmu-common: Key configuration cache on SMMUDevice and SEC_SID
  hw/arm/smmu: Add PTE NS/NSTable helpers
  hw/arm/smmuv3: Store CD NSCFG in TT info
  hw/arm/smmu-common: Add sec_sid field to TLB entries
  hw/arm/smmu-common: Implement secure state handling in ptw
  hw/arm/smmuv3: Tag IOTLB cache keys with SEC_SID
  hw/arm/smmuv3: Plumb SEC_SID through IOMMU notifier path
  hw/arm/smmuv3: Pass sec_sid into cmdq consume path
  hw/arm/smmuv3: Make evtq producer use SEC_SID
  hw/arm/smmuv3: Fix CFGI_CD handling when stage-1 is unsupported
  hw/arm/smmu: Make CMDQ invalidation security-state aware
  hw/arm/smmuv3: Add access checks for GERROR_IRQ_CFG registers
  hw/arm/smmuv3: Add access checks for STRTAB_BASE and CR2 registers
  hw/arm/smmuv3: Add access checks for CMDQ and EVENTQ registers
  hw/arm/smmuv3: Determine register bank from MMIO offset
  hw/arm/smmuv3: Implement SMMU_S_INIT register
  hw/arm/smmuv3: Harden security checks in MMIO handlers
  hw/pci: Add sec-sid property to PCIDevice
  hw/arm/smmuv3: Select sec-sid from PCI property and validate
    SECURE_IMPL
  hw/arm/smmuv3: Initialize the secure register bank
  hw/arm/smmuv3: Add secure bank migration and secure-impl property
  [NOT-MERGE] hw/arm/smmuv3: temporarily enable SEL2 bit and sone other
    features

 hw/arm/smmu-common.c           |  340 +++++++--
 hw/arm/smmu-internal.h         |   18 +-
 hw/arm/smmuv3-accel.c          |   57 +-
 hw/arm/smmuv3-internal.h       |   37 +-
 hw/arm/smmuv3.c                | 1180 +++++++++++++++++++++++++-------
 hw/arm/trace-events            |   23 +-
 hw/pci/pci.c                   |    7 +
 include/hw/arm/smmu-common.h   |   55 +-
 include/hw/arm/smmuv3-common.h |   80 ++-
 include/hw/arm/smmuv3.h        |   32 +-
 include/hw/pci/pci_device.h    |    3 +
 11 files changed, 1462 insertions(+), 370 deletions(-)

--
2.34.1


