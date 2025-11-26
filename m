Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6E8D10F58
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 15:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOHUJ-00055m-SX; Wed, 26 Nov 2025 10:31:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vOHU7-0004iS-L1; Wed, 26 Nov 2025 10:31:14 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vOHU3-0001lG-Et; Wed, 26 Nov 2025 10:31:11 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCXn1MnHSdpJ5IEAQ--.41357S2;
 Wed, 26 Nov 2025 23:30:47 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwCX8e4lHSdpN6MHAA--.21552S3;
 Wed, 26 Nov 2025 23:30:45 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v4 0/4] hw/misc: Introduce a generalized IOMMU test framework
Date: Wed, 26 Nov 2025 23:30:34 +0800
Message-Id: <20251126153040.1280317-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCX8e4lHSdpN6MHAA--.21552S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAGBWkmDa4HfgAJse
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3WFykZw18Wr15JF1DJrWUurg_yoWxuF1rpF
 Z3Ga9xKw48JF1fAwn3Aw40vFy3ta1kJa12vr17Kw1Sv3y3Ary8Ar43KFyrtF9rJrW8ZF47
 Za18tr1UuF40v3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is v4 of the IOMMU test framework. This series builds upon v3 by adding a
shared smmuv3-common.h so the model and libqos consume the same STE/CD and
register definitions. V4 also removes redundant iommu-testdev registers,
introduces the DMA doorbell helper / “not armed” status, optimizes code style
and refreshes the libqos/qtest stack so it uses the shared header and the
simplified device API.

Motivation
----------

Currently, thoroughly testing IOMMU emulation (e.g., ARM SMMUv3) requires
a significant software stack. We need to boot a full guest operating
system (like Linux) with the appropriate drivers (e.g., IOMMUFD) and rely
on firmware (e.g., ACPI with IORT tables or Hafnium) to correctly
configure the IOMMU and orchestrate DMA from a peripheral device.

This dependency on a complex software stack presents several challenges:

* High Barrier to Entry: Writing targeted tests for specific IOMMU
    features (like fault handling, specific translation regimes, etc.)
    becomes cumbersome.

* Difficult to Debug: It's hard to distinguish whether a bug originates
    from the IOMMU emulation itself, the guest driver, the firmware
    tables, or the guest kernel's configuration.

* Slow Iteration: The need to boot a full guest OS slows down the
    development and testing cycle.

The primary goal of this work is to create a lightweight, self-contained
testing environment that allows us to exercise the IOMMU's core logic
directly at the qtest level, removing the need for any guest-side software.

Our Approach: A Dedicated Test Framework
-----------------------------------------

To achieve this, we introduce three main components:

* A minimal hardware device: iommu-testdev
* A reusable IOMMU helper library: libqos/qos-smmuv3
* A comprehensive qtest suite: iommu-smmuv3-test

The iommu-testdev is intentionally not a conformant, general-purpose PCIe
or platform device. It is a purpose-built, highly simplified "DMA engine"
designed to be analogous to a minimal PCIe Root Complex that bypasses the
full, realistic topology (Host Bridges, Switches, Endpoints) to provide a
direct, programmable path for a DMA request to reach the IOMMU. Its sole
purpose is to trigger a DMA transaction when its registers are written to,
making it perfectly suited for direct control from a test environment like
qtest.

The Qtest Framework
-------------------

The new qtest (iommu-smmuv3-test.c) serves as the "bare-metal driver"
for both the IOMMU and the iommu-testdev. It leverages the libqos helper
library to manually perform all the setup that would typically be handled
by the guest kernel and firmware, but in a completely controlled and
predictable manner:

1.  IOMMU Configuration: It directly initializes the SMMU's registers to a
    known state using helper functions from qos-smmuv3.

2.  Translation Structure Setup: It uses the libqos library to construct
    the necessary translation structures in memory, including Stream Table
    Entries (STEs), Context Descriptors (CDs), and Page Tables (PTEs).

3.  DMA Trigger: It programs the iommu-testdev to initiate a DMA operation
    targeting a specific IOVA with configurable attributes.

4.  Verification: It waits for the transaction to complete and verifies
    that the memory was accessed correctly after address translation by
    the IOMMU.

This framework provides a solid and extensible foundation for validating
the IOMMU's core translation paths. The current test suite covers:

- Stage 1 only translation (VA -> PA via CD page tables)
- Stage 2 only translation (IPA -> PA via STE S2 tables)
- Nested translation (VA -> IPA -> PA, Stage 1 + Stage 2)

The infrastructure is designed to be easily extended to support multiple
security spaces (Non-Secure, Secure, Root, Realm) and additional IOMMU
features.


Testing:
--------
QTEST_QEMU_BINARY=qemu-system-aarch64 tests/qtest/iommu-smmuv3-test --tap -k


Major Changes from v3 to v4:
-----------------------------

1. Added shared smmuv3-common.h so both the device and libqos consume the same
   STE/CD/register definitions as Alex suggested [1]
2. Slimmed iommu-testdev down to a pure DMA trigger with a tighter MMIO
   contract (new doorbell helper, simplified attributes/errors).
3. Updated `qos-smmuv3` and the qtest so they include the common header,
   honor per-test expected results, and rely solely on the streamlined device
   interface.
4. Compacted changes of v2 to v3.

[1] https://lore.kernel.org/qemu-devel/87zf8jk244.fsf@draig.linaro.org/


Major Changes from v2 to v3:
-----------------------------

1. Generalization/Renaming: rebranded `smmu-testdev` → `iommu-testdev` (code,
   headers, docs) to reflect the broadened scope.
2. Separation of concerns: iommu-testdev is now a pure DMA trigger; all
   SMMUv3-specific setup (STE/CD/page tables, multi-mode support, space offsets)
   lives in `qos-smmuv3.{c,h}` and is consumed by the new qtest.
3. Improved modularity & coverage: the stacked design (device + helper + qtest)
   made it straightforward to add S1/S2/Nested tests, a cleaner config system,
   and clearer validation logic.
4. Code/documentation quality: added tracepoints, better error handling/naming,
   and refreshed `docs/specs/iommu-testdev.rst` with the new layout.

Future Work
-----------

The current implementation focuses on basic translation path validation
in the Non-Secure address space. Future extensions could include:

* Multi-space testing (Secure, Root, Realm) for SMMUv3
* Support for other IOMMU types (Intel VT-d, AMD-Vi, RISC-V IOMMU)

Tao Tang (4):
  hw/arm/smmuv3: Extract common definitions to smmuv3-common.h
  hw/misc: Introduce iommu-testdev for bare-metal IOMMU testing
  tests/qtest/libqos: Add SMMUv3 helper library
  tests/qtest: Add SMMUv3 bare-metal test using iommu-testdev

 docs/specs/index.rst            |   1 +
 docs/specs/iommu-testdev.rst    | 109 +++++
 hw/arm/smmuv3-internal.h        | 255 +----------
 hw/misc/Kconfig                 |   5 +
 hw/misc/iommu-testdev.c         | 278 ++++++++++++
 hw/misc/meson.build             |   1 +
 hw/misc/trace-events            |  10 +
 include/hw/arm/smmuv3-common.h  | 461 ++++++++++++++++++++
 include/hw/misc/iommu-testdev.h |  70 +++
 tests/qtest/iommu-smmuv3-test.c | 114 +++++
 tests/qtest/libqos/meson.build  |   3 +
 tests/qtest/libqos/qos-smmuv3.c | 731 ++++++++++++++++++++++++++++++++
 tests/qtest/libqos/qos-smmuv3.h | 267 ++++++++++++
 tests/qtest/meson.build         |   1 +
 14 files changed, 2052 insertions(+), 254 deletions(-)
 create mode 100644 docs/specs/iommu-testdev.rst
 create mode 100644 hw/misc/iommu-testdev.c
 create mode 100644 include/hw/arm/smmuv3-common.h
 create mode 100644 include/hw/misc/iommu-testdev.h
 create mode 100644 tests/qtest/iommu-smmuv3-test.c
 create mode 100644 tests/qtest/libqos/qos-smmuv3.c
 create mode 100644 tests/qtest/libqos/qos-smmuv3.h

-- 
2.34.1


