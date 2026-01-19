Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBFC7D29C2E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 16:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhrrP-0005jW-Uy; Mon, 19 Jan 2026 11:12:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vhrrN-0005e4-6e; Mon, 19 Jan 2026 11:12:09 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vhrrJ-000275-VE; Mon, 19 Jan 2026 11:12:08 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwA3P1OvV25pUHw4Aw--.8346S2;
 Tue, 20 Jan 2026 00:11:27 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwCX8O2mV25pCfIUAA--.37135S6;
 Tue, 20 Jan 2026 00:11:24 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v9 3/8] hw/misc: Introduce iommu-testdev for bare-metal IOMMU
 testing
Date: Tue, 20 Jan 2026 00:11:07 +0800
Message-Id: <20260119161112.3841386-4-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260119161112.3841386-1-tangtao1634@phytium.com.cn>
References: <20260119161112.3841386-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCX8O2mV25pCfIUAA--.37135S6
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAABWltPrkFKAAAsq
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoWftrykJFy8JF1rWw4kAFWUJwb_yoW8tw1Uto
 WYgF4fC3WxGw1xur1vkas7WF45ZFyvgFnxJayUWr4Fga95A3ZxJr15Aa15W3Z8Krn3CFy7
 uFykt34xtr9rWF93n29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
 J3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UU
 UUUUUUU==
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a minimal PCI test device designed to exercise IOMMU translation
(such as ARM SMMUv3) without requiring guest firmware or OS. The device
provides MMIO registers to configure and trigger DMA operations with
controllable attributes (security state, address space), enabling
deterministic IOMMU testing.

Key features:
- Bare-metal IOMMU testing via simple MMIO interface
- Configurable DMA attributes for security states and address spaces
- Write-then-read verification pattern with automatic result checking

The device performs a deterministic DMA test pattern: write a known
value (0x12345678) to a configured GVA, read it back, and verify data
integrity. Results are reported through a dedicated result register,
eliminating the need for complex interrupt handling or driver
infrastructure in tests.

This is purely a test device and not intended for production use or
machine realism. It complements existing test infrastructure like
pci-testdev but focuses specifically on IOMMU translation path
validation.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 MAINTAINERS                     |   7 +
 docs/specs/index.rst            |   1 +
 docs/specs/iommu-testdev.rst    | 138 ++++++++++++++
 hw/misc/Kconfig                 |   5 +
 hw/misc/iommu-testdev.c         | 318 ++++++++++++++++++++++++++++++++
 hw/misc/meson.build             |   1 +
 hw/misc/trace-events            |  10 +
 include/hw/misc/iommu-testdev.h |  87 +++++++++
 8 files changed, 567 insertions(+)
 create mode 100644 docs/specs/iommu-testdev.rst
 create mode 100644 hw/misc/iommu-testdev.c
 create mode 100644 include/hw/misc/iommu-testdev.h

diff --git a/MAINTAINERS b/MAINTAINERS
index de8246c3ff..1abfec594f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2372,6 +2372,13 @@ F: include/hw/core/iommu.h
 F: util/chardev_open.c
 F: docs/devel/vfio-iommufd.rst
 
+iommu-testdev
+M: Tao Tang <tangtao1634@phytium.com.cn>
+S: Maintained
+F: hw/misc/iommu-testdev.c
+F: include/hw/misc/iommu-testdev.h
+F: docs/specs/iommu-testdev.rst
+
 vhost
 M: Michael S. Tsirkin <mst@redhat.com>
 R: Stefano Garzarella <sgarzare@redhat.com>
diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index f19d73c9f6..b7909a108a 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -39,3 +39,4 @@ guest hardware that is specific to QEMU.
    riscv-iommu
    riscv-aia
    aspeed-intc
+   iommu-testdev
diff --git a/docs/specs/iommu-testdev.rst b/docs/specs/iommu-testdev.rst
new file mode 100644
index 0000000000..e15f9a55a7
--- /dev/null
+++ b/docs/specs/iommu-testdev.rst
@@ -0,0 +1,138 @@
+iommu-testdev — IOMMU test device for bare-metal testing
+=========================================================
+
+Overview
+--------
+``iommu-testdev`` is a minimal, test-only PCI device designed to exercise
+IOMMU translation (such as ARM SMMUv3) without requiring firmware or a guest
+OS. Tests can populate IOMMU translation tables with known values and trigger
+DMA operations that flow through the IOMMU translation path. It is **not** a
+faithful PCIe endpoint and must be considered a QEMU-internal test vehicle.
+
+Key Features
+------------
+* **Bare-metal IOMMU testing**: No guest kernel or firmware required
+* **Configurable DMA attributes**: Supports address space configuration via
+  MMIO registers
+* **Deterministic verification**: Write-then-read DMA pattern with automatic
+  result checking
+
+Status
+------
+* Location: ``hw/misc/iommu-testdev.c``
+* Header: ``include/hw/misc/iommu-testdev.h``
+* Build guard: ``CONFIG_IOMMU_TESTDEV``
+
+Device Interface
+----------------
+The device exposes a single PCI BAR0 with 32-bit MMIO registers:
+
+* ``ITD_REG_DMA_TRIGGERING`` (0x00): Read triggers DMA and consumes
+  the armed request
+* ``ITD_REG_DMA_GVA_LO`` (0x04): DMA IOVA bits [31:0]
+* ``ITD_REG_DMA_GVA_HI`` (0x08): DMA IOVA bits [63:32]
+* ``ITD_REG_DMA_GPA_LO`` (0x1C): DMA GPA bits [31:0] for readback validation
+* ``ITD_REG_DMA_GPA_HI`` (0x20): DMA GPA bits [63:32] for readback validation
+* ``ITD_REG_DMA_LEN`` (0x0C): DMA transfer length
+* ``ITD_REG_DMA_RESULT`` (0x10): DMA result
+  (0=success, 0xffffffff=idle, 0xfffffffe=armed)
+* ``ITD_REG_DMA_DBELL`` (0x14): Write 1 to arm DMA, write 0 to disarm.
+  Arming only marks the request and sets BUSY (no latch/check), but it
+  provides an explicit gate for qtests and leaves room for async/latching.
+* ``ITD_REG_DMA_ATTRS`` (0x18): DMA attributes which shadow some fields in
+  MemTxAttrs:
+
+  - bit[0]: secure (1=Secure, 0=Non-Secure)
+  - bits[2:1]: ArmSecuritySpace (0=Secure, 1=Non-Secure)
+  - bit[3]: space_valid (1=space is valid, 0=ignore space and default to Non-Secure)
+    ``space`` field in MemTxAttrs is consumed only when ``space_valid`` is set.
+    For Secure/Non-Secure, ``secure`` and ``space`` must match; mismatches
+    return ``ITD_DMA_ERR_BAD_ATTRS``. Other bits are reserved but can be wired
+    up easily if future tests need to pass extra attributes.
+
+Translation Setup Workflow
+--------------------------
+``iommu-testdev`` never builds SMMU/AMD-Vi/RISC-V IOMMU structures on its own.
+Architecture-specific construction lives entirely in qtest/libqos helpers.
+Those helpers populate guest memory with page tables/architecture-specific
+structures and program the emulated IOMMU registers directly. See the
+``qsmmu_setup_and_enable_translation()`` function in
+``tests/qtest/libqos/qos-smmuv3.c`` for an example of how SMMUv3 translation
+is set up for this device.
+
+DMA Operation Flow
+------------------
+Arming semantics:
+
+* Writing ``DMA_DBELL`` with bit0=1 marks the request armed and sets
+  ``DMA_RESULT`` to BUSY. It does not latch GVA/LEN/ATTRS; values are sampled
+  when ``DMA_TRIGGERING`` is read.
+* Writing ``DMA_DBELL`` with bit0=0 disarms the request and sets
+  ``DMA_RESULT`` to IDLE.
+* Reading ``DMA_TRIGGERING`` consumes the armed request and clears the armed
+  state, even on error.
+
+The flow would be split into these steps, mainly for timing control and
+debuggability: qtests can easily exercise and assert distinct paths
+(NOT_ARMED, BAD_LEN, TX/RD failures, mismatch) instead of having all side
+effects hidden behind a single step:
+1. Test programs IOMMU translation tables
+2. Test configures DMA IOVA (GVA_LO/HI), GPA for readback, length, and attributes
+3. Test writes 1 to DMA_DBELL to arm the operation
+4. Test reads DMA_TRIGGERING to execute DMA
+5. Test polls DMA_RESULT:
+
+   - 0x00000000: Success
+   - 0xFFFFFFFE: Armed (waiting for trigger). DMA runs synchronously, so
+     BUSY is not observed once the trigger read completes.
+   - 0xDEAD0006: Bad attrs (secure/space mismatch for S/NS)
+   - 0xDEAD000X: Various error codes
+
+The device performs a write-then-read sequence using a known pattern
+(0x12345678) and verifies data integrity automatically.
+
+Running the qtest
+-----------------
+The SMMUv3 test suite uses this device and covers multiple translation modes::
+
+    cd build
+    QTEST_QEMU_BINARY=./qemu-system-aarch64 \\
+        ./tests/qtest/iommu-smmuv3-test --tap -k
+
+This test suite exercises:
+
+* Stage 1 only translation
+* Stage 2 only translation
+* Nested (Stage 1 + Stage 2) translation
+
+Instantiation
+-------------
+The device is not wired into any board by default. Tests instantiate it
+via QEMU command line::
+
+    -device iommu-testdev
+
+For ARM platforms with SMMUv3::
+
+    -M virt,iommu=smmuv3 -device iommu-testdev
+
+When the IOMMU sits on the same PCI root complex (``pci.0``), the device is
+placed behind it automatically. For other PCI topologies, specify the bus
+explicitly.
+
+Limitations
+-----------
+* No realistic PCIe enumeration, MSI/MSI-X, or interrupt handling
+* No ATS/PRI support
+* No actual device functionality beyond DMA test pattern
+* Test-only; not suitable for production or machine realism
+* Address space support (Secure/Root/Realm) is architecture-dependent and
+  gated by ``space_valid``
+* Readback uses the programmed GPA and reads via system memory, avoiding a
+  second IOMMU access for the readback step
+
+See also
+--------
+* ``tests/qtest/iommu-smmuv3-test.c`` — SMMUv3 test suite
+* ``tests/qtest/libqos/qos-smmuv3.{c,h}`` — SMMUv3 test library
+* SMMUv3 emulation: ``hw/arm/smmu*``
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 4a22d68233..f4d49248c0 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -25,6 +25,11 @@ config PCI_TESTDEV
     default y if TEST_DEVICES
     depends on PCI
 
+config IOMMU_TESTDEV
+    bool
+    default y if TEST_DEVICES
+    depends on PCI
+
 config EDU
     bool
     default y if TEST_DEVICES
diff --git a/hw/misc/iommu-testdev.c b/hw/misc/iommu-testdev.c
new file mode 100644
index 0000000000..15eb6de78a
--- /dev/null
+++ b/hw/misc/iommu-testdev.c
@@ -0,0 +1,318 @@
+/*
+ * A test device for IOMMU
+ *
+ * Copyright (c) 2026 Phytium Technology
+ *
+ * Author:
+ *  Tao Tang <tangtao1634@phytium.com.cn>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "system/address-spaces.h"
+#include "system/memory.h"
+#include "trace.h"
+#include "hw/pci/pci_device.h"
+#include "hw/core/qdev-properties.h"
+#include "qom/object.h"
+#include "hw/misc/iommu-testdev.h"
+
+#define TYPE_IOMMU_TESTDEV "iommu-testdev"
+OBJECT_DECLARE_SIMPLE_TYPE(IOMMUTestDevState, IOMMU_TESTDEV)
+
+struct IOMMUTestDevState {
+    PCIDevice parent_obj;
+    MemoryRegion bar0;
+    uint64_t dma_vaddr;
+    uint64_t dma_paddr;
+    uint32_t dma_len;
+    uint32_t dma_result;
+    bool dma_armed; /* armed until a trigger consumes the request */
+
+    AddressSpace *dma_as;   /* IOMMU-mediated DMA AS for this device */
+    uint32_t dma_attrs_cfg; /* bit0 secure, bits[2:1] space, bit3 valid */
+};
+
+static bool iommu_testdev_attrs_inconsistent(uint32_t cfg)
+{
+    uint32_t space;
+    bool secure;
+
+    if (!ITD_ATTRS_GET_SPACE_VALID(cfg)) {
+        return false;
+    }
+
+    space = ITD_ATTRS_GET_SPACE(cfg);
+    secure = ITD_ATTRS_GET_SECURE(cfg);
+
+    if (space == ITD_ATTRS_SPACE_SECURE || space == ITD_ATTRS_SPACE_NONSECURE) {
+        return secure != (space == ITD_ATTRS_SPACE_SECURE);
+    }
+
+    return false;
+}
+
+static void iommu_testdev_maybe_run_dma(IOMMUTestDevState *s)
+{
+    uint32_t expected_val, actual_val;
+    g_autofree uint8_t *write_buf = NULL;
+    g_autofree uint8_t *read_buf = NULL;
+    MemTxResult write_res, read_res;
+    MemTxAttrs attrs = {};
+    AddressSpace *as;
+    bool space_valid;
+
+    if (!s->dma_armed) {
+        s->dma_result = ITD_DMA_ERR_NOT_ARMED;
+        trace_iommu_testdev_dma_result(s->dma_result);
+        return;
+    }
+    trace_iommu_testdev_dma_start();
+
+    if (!s->dma_len) {
+        s->dma_result = ITD_DMA_ERR_BAD_LEN;
+        goto out;
+    }
+
+    write_buf = g_malloc(s->dma_len);
+    read_buf = g_malloc(s->dma_len);
+
+    /* Initialize MemTxAttrs from generic register. */
+    attrs.secure = ITD_ATTRS_GET_SECURE(s->dma_attrs_cfg);
+
+    space_valid = ITD_ATTRS_GET_SPACE_VALID(s->dma_attrs_cfg);
+    if (space_valid) {
+        /* The 'space' field in MemTxAttrs is ARM-specific. */
+        attrs.space = ITD_ATTRS_GET_SPACE(s->dma_attrs_cfg);
+    } else {
+        /* Default to Non-Secure when space is not valid. */
+        attrs.space = ITD_ATTRS_SPACE_NONSECURE;
+    }
+
+    if (iommu_testdev_attrs_inconsistent(s->dma_attrs_cfg)) {
+        s->dma_result = ITD_DMA_ERR_BAD_ATTRS;
+        goto out;
+    }
+
+    as = s->dma_as;
+
+    /* Step 1: Write ITD_DMA_WRITE_VAL to DMA address */
+    trace_iommu_testdev_dma_write(s->dma_vaddr, s->dma_len);
+
+    for (int i = 0; i < s->dma_len; i++) {
+        /* Data is written in little-endian order */
+        write_buf[i] = (ITD_DMA_WRITE_VAL >> ((i % 4) * 8)) & 0xff;
+    }
+    write_res = dma_memory_write(as, s->dma_vaddr, write_buf,
+                                 s->dma_len, attrs);
+
+    if (write_res != MEMTX_OK) {
+        s->dma_result = ITD_DMA_ERR_TX_FAIL;
+        goto out;
+    }
+
+    /* Step 2: Read back from the same DMA address */
+    trace_iommu_testdev_dma_read(s->dma_vaddr, s->dma_len);
+
+    read_res = address_space_read(&address_space_memory, s->dma_paddr,
+                                  attrs, read_buf, s->dma_len);
+
+    if (read_res != MEMTX_OK) {
+        s->dma_result = ITD_DMA_ERR_RD_FAIL;
+        goto out;
+    }
+
+    /* Step 3: Verify the read data matches what we wrote */
+    for (int i = 0; i < s->dma_len; i += 4) {
+        int remaining_bytes = MIN(4, s->dma_len - i);
+
+        expected_val = 0;
+        actual_val = 0;
+
+        for (int j = 0; j < remaining_bytes; j++) {
+            expected_val |= ((uint32_t)write_buf[i + j]) << (j * 8);
+            actual_val |= ((uint32_t)read_buf[i + j]) << (j * 8);
+        }
+
+        trace_iommu_testdev_dma_verify(expected_val, actual_val);
+
+        if (expected_val != actual_val) {
+            s->dma_result = ITD_DMA_ERR_MISMATCH;
+            goto out;
+        }
+    }
+
+    /* All checks passed */
+    s->dma_result = 0;
+out:
+    trace_iommu_testdev_dma_result(s->dma_result);
+    s->dma_armed = false;
+}
+
+static uint64_t iommu_testdev_mmio_read(void *opaque, hwaddr addr,
+                                        unsigned size)
+{
+    IOMMUTestDevState *s = opaque;
+    uint64_t value = 0;
+
+    switch (addr) {
+    case ITD_REG_DMA_TRIGGERING:
+        /*
+         * This lets tests poll ITD_REG_DMA_RESULT to observe BUSY before
+         * consuming the DMA.
+         */
+        iommu_testdev_maybe_run_dma(s);
+        value = 0;
+        break;
+    case ITD_REG_DMA_GVA_LO:
+        value = (uint32_t)(s->dma_vaddr & 0xffffffffu);
+        break;
+    case ITD_REG_DMA_GVA_HI:
+        value = (uint32_t)(s->dma_vaddr >> 32);
+        break;
+    case ITD_REG_DMA_GPA_LO:
+        value = (uint32_t)(s->dma_paddr & 0xffffffffu);
+        break;
+    case ITD_REG_DMA_GPA_HI:
+        value = (uint32_t)(s->dma_paddr >> 32);
+        break;
+    case ITD_REG_DMA_LEN:
+        value = s->dma_len;
+        break;
+    case ITD_REG_DMA_RESULT:
+        value = s->dma_result;
+        break;
+    case ITD_REG_DMA_ATTRS:
+        value = s->dma_attrs_cfg;
+        break;
+    default:
+        value = 0;
+        break;
+    }
+
+    trace_iommu_testdev_mmio_read(addr, value, size);
+    return value;
+}
+
+static void iommu_testdev_mmio_write(void *opaque, hwaddr addr, uint64_t val,
+                                     unsigned size)
+{
+    IOMMUTestDevState *s = opaque;
+    uint32_t data = val;
+
+    trace_iommu_testdev_mmio_write(addr, val, size);
+
+    switch (addr) {
+    case ITD_REG_DMA_GVA_LO:
+        s->dma_vaddr = (s->dma_vaddr & ~0xffffffffull) | data;
+        break;
+    case ITD_REG_DMA_GVA_HI:
+        s->dma_vaddr = (s->dma_vaddr & 0xffffffffull) |
+                       ((uint64_t)data << 32);
+        break;
+    case ITD_REG_DMA_GPA_LO:
+        s->dma_paddr = (s->dma_paddr & ~0xffffffffull) | data;
+        break;
+    case ITD_REG_DMA_GPA_HI:
+        s->dma_paddr = (s->dma_paddr & 0xffffffffull) |
+                       ((uint64_t)data << 32);
+        break;
+    case ITD_REG_DMA_LEN:
+        s->dma_len = data;
+        break;
+    case ITD_REG_DMA_RESULT:
+        s->dma_result = data;
+        break;
+    case ITD_REG_DMA_DBELL:
+        if (data & ITD_DMA_DBELL_ARM) {
+            /* Arm the DMA operation; repeated arm is idempotent. */
+            s->dma_armed = true;
+            s->dma_result = ITD_DMA_RESULT_BUSY;
+            trace_iommu_testdev_dma_armed(true);
+        } else {
+            /* Disarm the DMA operation */
+            s->dma_armed = false;
+            s->dma_result = ITD_DMA_RESULT_IDLE;
+            trace_iommu_testdev_dma_armed(false);
+        }
+        break;
+    case ITD_REG_DMA_ATTRS:
+        s->dma_attrs_cfg = data;
+        break;
+    default:
+        break;
+    }
+}
+
+static const MemoryRegionOps iommu_testdev_mmio_ops = {
+    .read = iommu_testdev_mmio_read,
+    .write = iommu_testdev_mmio_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void iommu_testdev_realize(PCIDevice *pdev, Error **errp)
+{
+    IOMMUTestDevState *s = IOMMU_TESTDEV(pdev);
+
+    s->dma_vaddr = 0;
+    s->dma_paddr = 0;
+    s->dma_len = 0;
+    s->dma_result = ITD_DMA_RESULT_IDLE;
+    s->dma_armed = false;
+    s->dma_attrs_cfg = ITD_ATTRS_SET_SPACE(0, ITD_ATTRS_SPACE_NONSECURE);
+    s->dma_as = pci_device_iommu_address_space(pdev);
+
+    memory_region_init_io(&s->bar0, OBJECT(pdev), &iommu_testdev_mmio_ops, s,
+                          TYPE_IOMMU_TESTDEV ".bar0", BAR0_SIZE);
+    pci_register_bar(pdev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->bar0);
+}
+
+static void iommu_testdev_reset(DeviceState *dev)
+{
+    IOMMUTestDevState *s = IOMMU_TESTDEV(dev);
+
+    s->dma_vaddr = 0;
+    s->dma_paddr = 0;
+    s->dma_len = 0;
+    s->dma_result = ITD_DMA_RESULT_IDLE;
+    s->dma_armed = false;
+    s->dma_attrs_cfg = ITD_ATTRS_SET_SPACE(0, ITD_ATTRS_SPACE_NONSECURE);
+}
+
+static void iommu_testdev_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
+
+    pc->realize = iommu_testdev_realize;
+    pc->vendor_id = IOMMU_TESTDEV_VENDOR_ID;
+    pc->device_id = IOMMU_TESTDEV_DEVICE_ID;
+    pc->revision = 0;
+    pc->class_id = PCI_CLASS_OTHERS;
+    dc->desc = "A test device for IOMMU";
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    device_class_set_legacy_reset(dc, iommu_testdev_reset);
+}
+
+static const TypeInfo iommu_testdev_info = {
+    .name          = TYPE_IOMMU_TESTDEV,
+    .parent        = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(IOMMUTestDevState),
+    .class_init    = iommu_testdev_class_init,
+    .interfaces    = (const InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { }
+    },
+};
+
+static void iommu_testdev_register_types(void)
+{
+    type_register_static(&iommu_testdev_info);
+}
+
+type_init(iommu_testdev_register_types);
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 32b878e035..c444e030ec 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -4,6 +4,7 @@ system_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('vmcoreinfo.c'))
 system_ss.add(when: 'CONFIG_ISA_DEBUG', if_true: files('debugexit.c'))
 system_ss.add(when: 'CONFIG_ISA_TESTDEV', if_true: files('pc-testdev.c'))
 system_ss.add(when: 'CONFIG_PCI_TESTDEV', if_true: files('pci-testdev.c'))
+system_ss.add(when: 'CONFIG_IOMMU_TESTDEV', if_true: files('iommu-testdev.c'))
 system_ss.add(when: 'CONFIG_UNIMP', if_true: files('unimp.c'))
 system_ss.add(when: 'CONFIG_EMPTY_SLOT', if_true: files('empty_slot.c'))
 system_ss.add(when: 'CONFIG_LED', if_true: files('led.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index eeb9243898..4cee8a2b45 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -409,3 +409,13 @@ ivshmem_flat_interrupt_peer(uint16_t peer_id, uint16_t vector_id) "Interrupting
 i2c_echo_event(const char *id, const char *event) "%s: %s"
 i2c_echo_recv(const char *id, uint8_t data) "%s: recv 0x%02" PRIx8
 i2c_echo_send(const char *id, uint8_t data) "%s: send 0x%02" PRIx8
+
+# iommu-testdev.c
+iommu_testdev_mmio_read(uint64_t addr, uint64_t value, unsigned size) "addr=0x%" PRIx64 " value=0x%" PRIx64 " size=%u"
+iommu_testdev_mmio_write(uint64_t addr, uint64_t value, unsigned size) "addr=0x%" PRIx64 " value=0x%" PRIx64 " size=%u"
+iommu_testdev_dma_start(void) "DMA operation started"
+iommu_testdev_dma_write(uint64_t gva, uint32_t len) "gva=0x%" PRIx64 " len=%u"
+iommu_testdev_dma_read(uint64_t gva, uint32_t len) "gva=0x%" PRIx64 " len=%u"
+iommu_testdev_dma_verify(uint32_t expected, uint32_t actual) "expected=0x%x actual=0x%x"
+iommu_testdev_dma_result(uint32_t result) "DMA completed result=0x%x"
+iommu_testdev_dma_armed(bool armed) "armed=%d"
diff --git a/include/hw/misc/iommu-testdev.h b/include/hw/misc/iommu-testdev.h
new file mode 100644
index 0000000000..338365947c
--- /dev/null
+++ b/include/hw/misc/iommu-testdev.h
@@ -0,0 +1,87 @@
+/*
+ * A test device for IOMMU
+ *
+ * Copyright (c) 2026 Phytium Technology
+ *
+ * Author:
+ *  Tao Tang <tangtao1634@phytium.com.cn>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_IOMMU_TESTDEV_H
+#define HW_MISC_IOMMU_TESTDEV_H
+
+#include "hw/pci/pci.h"
+
+#define IOMMU_TESTDEV_VENDOR_ID     PCI_VENDOR_ID_REDHAT
+#define IOMMU_TESTDEV_DEVICE_ID     PCI_DEVICE_ID_REDHAT_TEST
+
+/* DMA_ATTRS register bit definitions which shadow some fields in MemTxAttrs */
+#define ITD_ATTRS_SECURE_SHIFT          0
+#define ITD_ATTRS_SECURE_MASK           0x1
+#define ITD_ATTRS_SPACE_SHIFT           1
+#define ITD_ATTRS_SPACE_MASK            0x3
+#define ITD_ATTRS_SPACE_VALID_SHIFT     3
+#define ITD_ATTRS_SPACE_VALID_MASK      0x1
+
+#define ITD_ATTRS_SPACE_SECURE          0
+#define ITD_ATTRS_SPACE_NONSECURE       1
+
+/* Helper macros for setting fields */
+#define ITD_ATTRS_SET_SECURE(attrs, val)                              \
+    (((attrs) & ~(ITD_ATTRS_SECURE_MASK << ITD_ATTRS_SECURE_SHIFT)) | \
+     (((val) & ITD_ATTRS_SECURE_MASK) << ITD_ATTRS_SECURE_SHIFT))
+
+#define ITD_ATTRS_SET_SPACE(attrs, val)                               \
+    (((attrs) & ~(ITD_ATTRS_SPACE_MASK << ITD_ATTRS_SPACE_SHIFT)) |   \
+     (((val) & ITD_ATTRS_SPACE_MASK) << ITD_ATTRS_SPACE_SHIFT))
+
+#define ITD_ATTRS_SET_SPACE_VALID(attrs, val)                         \
+    (((attrs) & ~(ITD_ATTRS_SPACE_VALID_MASK <<                       \
+                  ITD_ATTRS_SPACE_VALID_SHIFT)) |                     \
+     (((val) & ITD_ATTRS_SPACE_VALID_MASK) <<                         \
+      ITD_ATTRS_SPACE_VALID_SHIFT))
+
+/* Helper macros for getting fields */
+#define ITD_ATTRS_GET_SECURE(attrs)                                   \
+    (((attrs) >> ITD_ATTRS_SECURE_SHIFT) & ITD_ATTRS_SECURE_MASK)
+
+#define ITD_ATTRS_GET_SPACE(attrs)                                    \
+    (((attrs) >> ITD_ATTRS_SPACE_SHIFT) & ITD_ATTRS_SPACE_MASK)
+
+#define ITD_ATTRS_GET_SPACE_VALID(attrs)                              \
+    (((attrs) >> ITD_ATTRS_SPACE_VALID_SHIFT) &                       \
+     ITD_ATTRS_SPACE_VALID_MASK)
+
+/* DMA result/status values shared with tests */
+#define ITD_DMA_RESULT_IDLE    0xffffffffu
+#define ITD_DMA_RESULT_BUSY    0xfffffffeu
+#define ITD_DMA_ERR_BAD_LEN    0xdead0001u
+#define ITD_DMA_ERR_TX_FAIL    0xdead0002u
+#define ITD_DMA_ERR_RD_FAIL    0xdead0003u
+#define ITD_DMA_ERR_MISMATCH   0xdead0004u
+#define ITD_DMA_ERR_NOT_ARMED  0xdead0005u
+#define ITD_DMA_ERR_BAD_ATTRS  0xdead0006u
+
+#define ITD_DMA_WRITE_VAL     0x12345678u
+
+/* DMA doorbell bits */
+#define ITD_DMA_DBELL_ARM    0x1u
+
+/* BAR0 layout of iommu-testdev */
+enum {
+    ITD_REG_DMA_TRIGGERING  = 0x00,
+    ITD_REG_DMA_GVA_LO      = 0x04,
+    ITD_REG_DMA_GVA_HI      = 0x08,
+    ITD_REG_DMA_LEN         = 0x0c,
+    ITD_REG_DMA_RESULT      = 0x10,
+    ITD_REG_DMA_DBELL       = 0x14,
+    /* [0] secure,[2:1] ArmSecuritySpace,[3] space_valid */
+    ITD_REG_DMA_ATTRS       = 0x18,
+    ITD_REG_DMA_GPA_LO      = 0x1c,
+    ITD_REG_DMA_GPA_HI      = 0x20,
+    BAR0_SIZE               = 0x1000,
+};
+
+#endif /* HW_MISC_IOMMU_TESTDEV_H */
-- 
2.34.1


