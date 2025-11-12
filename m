Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9ACCD13DD
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 16:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJDc2-0002ii-H4; Wed, 12 Nov 2025 11:22:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vJDbo-0002da-WB; Wed, 12 Nov 2025 11:22:13 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vJDbk-0004oc-MX; Wed, 12 Nov 2025 11:22:12 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwBHYqgktBRpI6oPAg--.69S2;
 Thu, 13 Nov 2025 00:21:56 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDnP+0jtBRpz0YEAA--.8224S3;
 Thu, 13 Nov 2025 00:21:55 +0800 (CST)
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
 Mostafa Saleh <smostafa@google.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v3 0/3] hw/misc: Introduce a generalized IOMMU test framework
Date: Thu, 13 Nov 2025 00:21:49 +0800
Message-Id: <20251112162152.447327-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDnP+0jtBRpz0YEAA--.8224S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAMBWkTmLAHcAAHsq
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxtFy3KFWUWFWkJF43Ar1kZrb_yoW3Wr1UpF
 93Cay3KF48JF1fZrn3Aw40yFy3tan5Ja12vr13Gw1Sg3y3AFy8tF47KFy8tF93A395ZF17
 Za1Utr15ur4FyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is v3 of the IOMMU test framework. V2 introduced the smmu-testdev for
bare-metal SMMUv3 testing. V3 is a significant architectural refactoring of that
work, generalizing it into a modular and extensible IOMMU test framework. The
device has been renamed from smmu-testdev to iommu-testdev and the
architecture has been significantly restructured for better modularity
and extensibility.

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


Major Changes from v2 to v3:
-----------------------------

1. Generalization and Renaming:
   - Device renamed from "smmu-testdev" to "iommu-testdev" to reflect
     its generic nature and potential use with other IOMMU types beyond
     SMMUv3.
   - File paths updated:
     * hw/misc/smmu-testdev.c -> hw/misc/iommu-testdev.c
     * include/hw/misc/smmu-testdev.h -> include/hw/misc/iommu-testdev.h
     * docs/specs/smmu-testdev.rst -> docs/specs/iommu-testdev.rst

2. Architectural Refactoring - Separation of Concerns:
   The most significant change is the separation of IOMMU-specific logic
   from the test device:

   - iommu-testdev (hw/misc/iommu-testdev.c):
     * Now focuses solely on being a DMA trigger device
     * Contains only MMIO register handling and DMA operation triggering
     * No longer contains SMMU-specific page table construction logic
     * Provides a clean, minimal interface for IOMMU testing

   - libqos/qos-smmuv3 (tests/qtest/libqos/qos-smmuv3.{c,h}):
     * Encapsulates all SMMUv3-specific initialization and setup
     * Handles Stream Table Entry (STE) construction
     * Handles Context Descriptor (CD) construction
     * Manages multi-level page table setup (L0-L3)
     * Provides support for different translation modes (S1, S2, nested)
     * Can be reused across multiple test suites
     * Includes helper functions for security space offset calculations

   - iommu-smmuv3-test (tests/qtest/iommu-smmuv3-test.c):
     * Focuses on test logic rather than setup boilerplate
     * Cleaner and more maintainable test cases
     * Uses high-level abstractions from qos-smmuv3 library

3. Enhanced Modularity:
   - Clear separation between:
     * Generic DMA trigger mechanism (iommu-testdev)
     * IOMMU-specific setup logic (qos-smmuv3)
     * Test scenarios (iommu-smmuv3-test)
   - This structure makes it easier to:
     * Add tests for new IOMMU features
     * Support additional IOMMU types (e.g., Intel VT-d)

4. Improved Test Coverage:
   - Explicit tests for multiple translation modes:
     * Stage 1 only
     * Stage 2 only
     * Nested (Stage 1 + Stage 2)
   - Better structured test configuration system
   - Clearer test result validation

5. Code Quality Improvements:
   - Added comprehensive tracing support (8 trace points)
   - Better error handling and validation
   - More descriptive variable names and comments

6. Documentation Updates:
   - Updated device specification in docs/specs/iommu-testdev.rst
   - More detailed register descriptions

Future Work
-----------

The current implementation focuses on basic translation path validation
in the Non-Secure address space. Future extensions could include:

* Multi-space testing (Secure, Root, Realm) for SMMUv3
* Support for other IOMMU types (Intel VT-d, AMD-Vi, RISC-V IOMMU)

Tao Tang (3):
  hw/misc: introduce iommu-testdev for bare-metal IOMMU testing
  tests/qtest: add libqos SMMUv3 helper library
  tests/qtest: add SMMUv3 bare-metal test using iommu-testdev

 docs/specs/index.rst            |   1 +
 docs/specs/iommu-testdev.rst    |  96 ++++
 hw/misc/Kconfig                 |   5 +
 hw/misc/iommu-testdev.c         | 292 ++++++++++
 hw/misc/meson.build             |   1 +
 hw/misc/trace-events            |  10 +
 include/hw/misc/iommu-testdev.h |  78 +++
 tests/qtest/iommu-smmuv3-test.c | 116 ++++
 tests/qtest/libqos/meson.build  |   3 +
 tests/qtest/libqos/qos-smmuv3.c | 920 ++++++++++++++++++++++++++++++++
 tests/qtest/libqos/qos-smmuv3.h | 291 ++++++++++
 tests/qtest/meson.build         |   1 +
 12 files changed, 1814 insertions(+)
 create mode 100644 docs/specs/iommu-testdev.rst
 create mode 100644 hw/misc/iommu-testdev.c
 create mode 100644 include/hw/misc/iommu-testdev.h
 create mode 100644 tests/qtest/iommu-smmuv3-test.c
 create mode 100644 tests/qtest/libqos/qos-smmuv3.c
 create mode 100644 tests/qtest/libqos/qos-smmuv3.h

-- 
2.34.1


