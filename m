Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7735CAC5B1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 15:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1o1R-0008Gn-ID; Thu, 25 Sep 2025 11:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v1o1P-0008Fs-83; Thu, 25 Sep 2025 11:36:39 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v1o1D-0003kT-9N; Thu, 25 Sep 2025 11:36:34 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCHab5kYdVoB605CQ--.237S2;
 Thu, 25 Sep 2025 23:36:04 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwBXuudhYdVoj_AeAA--.7094S3;
 Thu, 25 Sep 2025 23:36:01 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: pbonzini@redhat.com,
	farosas@suse.de,
	lvivier@redhat.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>, pierrick.bouvier@linaro.org,
 philmd@linaro.org, jean-philippe@linaro.org, smostafa@google.com,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC 0/2] Introduce a new SMMUv3 test framework
Date: Thu, 25 Sep 2025 23:35:48 +0800
Message-Id: <20250925153550.105915-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwBXuudhYdVoj_AeAA--.7094S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAEBWjUSMIHOgAKsB
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxGFW7AFy8KF18Jr4UCw4DArb_yoWrKF1Dpa
 93Wa43tF48JFnrAr1xAw48AFy5Xan3Jw47Cr1fKr1I939xCFyvvF47Ka40yF93CayvvF1a
 vw4jqry8Wan8AFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This patch series introduces a new test framework designed to validate the
QEMU SMMUv3 emulation in a "bare-metal" environment, free from the
complexities of guest firmware and drivers.

Motivation
----------

Currently, thoroughly testing the SMMUv3 emulation requires a significant
software stack. We need to boot a full guest operating system (like Linux)
with the appropriate drivers (e.g., IOMMUFD) and rely on firmware (e.g.,
ACPI with IORT tables or Hafnium) to correctly configure the SMMU and
orchestrate DMA from a peripheral device.

This dependency on a complex software stack presents several challenges:

* High Barrier to Entry: Writing targeted tests for specific SMMU
    features (like fault handling, specific translation regimes, etc.)
    becomes cumbersome.

* Difficult to Debug: It's hard to distinguish whether a bug originates
    from the SMMU emulation itself, the guest driver, the firmware
    tables, or the guest kernel's configuration.

* Slow Iteration: The need to boot a full guest OS slows down the
    development and testing cycle.

The primary goal of this work is to create a lightweight, self-contained
testing environment that allows us to exercise the SMMU's core logic
directly at the qtest level, removing the need for any guest-side software.

Our Approach: A Dedicated Test Device
-------------------------------------

To achieve this, we introduce two main components:

* A new, minimal hardware device: smmu-testdev.
* A corresponding qtest that drives this device to generate SMMU-bound
    traffic.

A key question is, "Why introduce a new smmu-testdev instead of using an
existing PCIe or platform device?"

The answer lies in our goal to minimize complexity. Standard devices,
whether PCIe or platform, come with their own intricate initialization
protocols and often require a complex driver state machine to function.
Using them would re-introduce the very driver-level complexity we aim to
avoid.

The smmu-testdev is intentionally not a conformant, general-purpose PCIe
or platform device. It is a purpose-built, highly simplified "DMA engine."
I've designed it to be analogous to a minimal PCIe Root Complex that
bypasses the full, realistic topology (Host Bridges, Switches, Endpoints)
to provide a direct, programmable path for a DMA request to reach the SMMU.
Its sole purpose is to trigger a DMA transaction when its registers are
written to, making it perfectly suited for direct control from a test
environment like qtest.

The Qtest Framework
-------------------

The new qtest (smmu-testdev-qtest.c) serves as the "bare-metal driver"
for both the SMMU and the smmu-testdev. It manually performs all the
setup that would typically be handled by the guest kernel and firmware,
but in a completely controlled and predictable manner:

1.  SMMU Configuration: It directly initializes the SMMU's registers to a
    known state.

2.  Translation Structure Setup: It manually constructs the necessary
    translation structures in memory, including Stream Table Entries
    (STEs), Context Descriptors (CDs), and Page Tables (PTEs).

3.  DMA Trigger: It programs the smmu-testdev to initiate a DMA operation
    targeting a specific IOVA.

4.  Verification: It waits for the transaction to complete and verifies
    that the memory was accessed correctly after address translation by
    the SMMU.

This framework provides a solid and extensible foundation for validating
the SMMU's core translation paths. The initial test included in this
series covers a basic DMA completion path in the Non-Secure bank,
serving as a smoke test and a proof of concept.

It is worth noting that this series currently only includes tests for the
Non-Secure SMMU. I am aware of the ongoing discussions and RFC patches
for Secure SMMU support. To avoid a dependency on unmerged work, this
submission does not include tests for the Secure world. However, I have
already implemented these tests locally, and I am prepared to submit
them for review as soon as the core Secure SMMU support is merged
upstream.

Thanks,
Tao

Tao Tang (2):
  hw/misc/smmu-testdev: introduce minimal SMMUv3 test device
  tests/qtest: add SMMUv3 smoke test using smmu-testdev DMA source

 docs/specs/smmu-testdev.rst      |   44 ++
 hw/misc/Kconfig                  |    5 +
 hw/misc/meson.build              |    1 +
 hw/misc/smmu-testdev.c           | 1030 ++++++++++++++++++++++++++++++
 include/hw/misc/smmu-testdev.h   |   90 +++
 tests/qtest/meson.build          |    1 +
 tests/qtest/smmu-testdev-qtest.c |  241 +++++++
 7 files changed, 1412 insertions(+)
 create mode 100644 docs/specs/smmu-testdev.rst
 create mode 100644 hw/misc/smmu-testdev.c
 create mode 100644 include/hw/misc/smmu-testdev.h
 create mode 100644 tests/qtest/smmu-testdev-qtest.c

--
2.34.1


