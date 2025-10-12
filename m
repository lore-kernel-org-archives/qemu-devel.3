Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379EACCD187
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Oct 2025 15:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7xfQ-0001du-4N; Sun, 12 Oct 2025 11:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xfN-0001ax-Qe; Sun, 12 Oct 2025 11:07:21 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xfK-0001cl-Os; Sun, 12 Oct 2025 11:07:21 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCHj5sYxOtodk6gAA--.36S2;
 Sun, 12 Oct 2025 23:07:04 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDXPOoXxOto33dMAA--.3068S3;
 Sun, 12 Oct 2025 23:07:03 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v3 00/21] hw/arm/smmuv3: Add initial support for Secure State
Date: Sun, 12 Oct 2025 23:06:40 +0800
Message-Id: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDXPOoXxOto33dMAA--.3068S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAABWjpYMcKcwAysp
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxCryUury5Ar4UXF4kZry5Arb_yoWrGr4Upa
 95Jas8KryDGF13ZrWxAF4xua47G393JF17ArnrGry5Awn0yrWxJr12k3W5KryDGr1UJr42
 vFn2vw4kur1qq3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi all,

This is v3 of the secure SMMUv3 series. Many thanks to Eric for the
detailed review feedback on v2, which formed the basis for these
changes. The main updates include:

- Re-sliced the series so that purely mechanical refactors land
ahead of the functional updates, which should make the review flow
easier.

- Renamed SMMUSecurityIndex to SMMUSecSID and plumbed it
consistently through the config cache, event reporting, and
invalidation helpers so it mirrors the architectural SEC_SID.

- Used the actual S_IDR1.SEL2 field to detect Secure Stage-2
support. When SEL2 is absent, we now correctly abort any
conflicting operation, be it a translation walk or a command
queue request.

- MMIO dispatch now derives the register bank from the offset, drops
the old non-secure S_INIT alias, and passes the correct security
context into the command/event queue paths.

- Failed fast if the secure address space is unavailable rather than
silently executing secure transactions against the non-secure
mapping.

On the administrative side, I have re-added the RFC tag that was missed
in v2. Eric's Reviewed-by tags have been applied where appropriate,
and a Fixes tag has been added to the patch that corrects the MMIO
register access checks.

The patches for this series also can be found at:
[1] https://github.com/hnusdr/qemu/commits/secure-smmu-v3-community


Self-testing
----------
Testing has been performed as follows:

- The Non-secure code paths were validated using the method at:
[2] https://github.com/hnusdr/qemu/commits/test-ns-secure-smmu-v3-community

This corresponds to the v2 version of smmu-testdev in another series:
[3] https://lists.nongnu.org/archive/html/qemu-arm/2025-09/msg01497.html

- The Secure code paths were validated using the method at:
[4] https://github.com/hnusdr/qemu/commits/test-secure-smmu-v3-community
which relies on an unsubmitted v3 version of smmu-testdev that has been
updated to support Secure SMMU.

Tao Tang (21):
  hw/arm/smmuv3: Fix incorrect reserved mask for SMMU CR0 register
  hw/arm/smmuv3: Correct SMMUEN field name in CR0
  hw/arm/smmuv3: Introduce secure registers
  refactor: Move ARMSecuritySpace to a common header
  hw/arm/smmuv3: Introduce banked registers for SMMUv3 state
  hw/arm/smmuv3: Thread SEC_SID through helper APIs
  hw/arm/smmuv3: Track SEC_SID in configs and events
  hw/arm/smmuv3: Add separate address space for secure SMMU accesses
  hw/arm/smmuv3: Plumb transaction attributes into config helpers
  hw/arm/smmu-common: Key configuration cache on SMMUDevice and SEC_SID
  hw/arm/smmuv3: Decode security attributes from descriptors
  hw/arm/smmu-common: Implement secure state handling in ptw
  hw/arm/smmuv3: Tag IOTLB cache keys with SEC_SID
  hw/arm/smmuv3: Add access checks for MMIO registers
  hw/arm/smmuv3: Determine register bank from MMIO offset
  hw/arm/smmuv3: Implement SMMU_S_INIT register
  hw/arm/smmuv3: Pass security state to command queue and IRQ logic
  hw/arm/smmuv3: Harden security checks in MMIO handlers
  hw/arm/smmuv3: Use iommu_index to represent the security context
  hw/arm/smmuv3: Initialize the secure register bank
  hw/arm/smmuv3: Add secure migration and enable secure state

 hw/arm/smmu-common.c          |  161 ++++-
 hw/arm/smmu-internal.h        |   16 +-
 hw/arm/smmuv3-internal.h      |  109 +++-
 hw/arm/smmuv3.c               | 1077 ++++++++++++++++++++++++++-------
 hw/arm/trace-events           |    9 +-
 hw/arm/virt.c                 |    5 +
 include/hw/arm/arm-security.h |   54 ++
 include/hw/arm/smmu-common.h  |   59 +-
 include/hw/arm/smmuv3.h       |   39 +-
 target/arm/cpu.h              |   25 +-
 10 files changed, 1249 insertions(+), 305 deletions(-)
 create mode 100644 include/hw/arm/arm-security.h

--
2.34.1


