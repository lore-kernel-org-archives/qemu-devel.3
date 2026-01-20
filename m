Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FEBD26289
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGdh-0008FB-Pt; Tue, 20 Jan 2026 13:39:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGdZ-0007xU-3e
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:39:33 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGdV-0005xE-Nl
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:39:32 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so52422535e9.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768934368; x=1769539168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MLnOJXLSgGcGwZZNvPsButwVtGAdAe/N7an6/c2DGGo=;
 b=nFkMYOPqs3PBH+b2rLZ0pZVdLoIycb5z5znVIYcm7fN26/klZiJxWbcmixOWzj+b1a
 QhMQY4lLxNy0epApA+/gCtSLOUn9pfXOEZ7kVgTp47OtnLQBfPXB7PRFoVnE880paF2U
 aNu2+plggcy5iYuI9LouE/v/JarXb3EDTDIz0CVKJHzE6pOXSm4/zcUQehjN1MJXO0Ri
 l7bADDprxuDvpqX9Y+xyQHN02z8rpj1m8lgipTQ/WzEZ8Z7ehHQuBQMzwZkzd+BshAoL
 tAKcxGJDbBa7pTvd5v7cOEB3tIyIf3rsX6P2Z5BcfDHCX6I8VCsJHokVIjVsckxO3dgP
 +TJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768934368; x=1769539168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MLnOJXLSgGcGwZZNvPsButwVtGAdAe/N7an6/c2DGGo=;
 b=Hrag5OwXzRIVsaXy2tfJvov0YpZkz3zoRmJC6AfqVZW601hcIDyXgCSCNGglFVVcGL
 emXyq1sKdo0P9JuTlTdt74sgJf6y5Eukr5kubGaKyfEqKAcOPmHrFmfNW1wQ7sY2NRAK
 p0JtVPvCGCATUOICpe9ZnBt6/oUzMXgI4o15/ZaRFv45sc/zDk29vuogT0g2ZpiwrBZe
 MZdMKmw7/ext3N+TzgislALctKen7sD7TrI3fdeMeNBhLIHnPl/TsMYTet29g4EjRLt3
 CxXsvVxZcCWUENlrXpTpSMnHHpFFVcZehG51/kZYeLQJnH6nEWGQYnMD6gzPAyIVNMX2
 U4Bw==
X-Gm-Message-State: AOJu0YyFtSyvUcFraz5Tu3FJUpr0Hvmf2M8rKbeJP3+fmmoeGOiEk8nu
 W1o8suF0mDokFbtmeozn5BVE5iRHT+l5je9lW5GZF+ksD3mGOJskK6BymL2vl3jvYdHmUSMmJQJ
 nfWutHB4=
X-Gm-Gg: AY/fxX5z0W/V+NpIog4ZwJ1fZGjqs12bxH2cmtFCxbAyBjqVHJqNF3AhomOXK74HW5z
 TUB5+gMME+WNzrWKiW6Cu8r+iwIoelWtNE8OjI3qSX++qSgq/mM2OSvf8U9Nl5GSeYTJ7yDajiu
 QsI9w2qV++tjhiYwetsbC1h0mKuU0vsnkNMpcShTinoqzhnBvnbQKStFAzSzyHYx1dXVhdKkxzv
 7tne2IeEGwtD6iNfCaApKDwr7OnSNcAq5fa+xPzcKRHqo4S87RfRvAIGSHFPRqCG90LGol20hWQ
 +yjJo9RdFJPiVm4oV/UL0M3klP4XDK7WNv5KudaXDZ/248HjNDyaiKkNMFggFAU6drmL4raSZDK
 1BW6NRcB3VexsKO8NEoYn6G2OPxmu7FiyrJKPk4tbh6TeJr3y4OVmtEe34UV9+11FxEyhNP1ZB4
 NBr7UfYzCeythMLKJ4m+AGdZ0uZoubkQxE7K6mL4quEdF10lVKsTpCkOg6CMmw
X-Received: by 2002:a05:600c:8189:b0:477:c478:46d7 with SMTP id
 5b1f17b1804b1-4801e333f07mr183254535e9.22.1768934367403; 
 Tue, 20 Jan 2026 10:39:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f4289b789sm317446095e9.1.2026.01.20.10.39.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jan 2026 10:39:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/29] hw/misc: Introduce iommu-testdev for bare-metal IOMMU
 testing
Date: Tue, 20 Jan 2026 19:38:36 +0100
Message-ID: <20260120183902.73845-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120183902.73845-1-philmd@linaro.org>
References: <20260120183902.73845-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Tao Tang <tangtao1634@phytium.com.cn>

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
Message-ID: <20260119161112.3841386-4-tangtao1634@phytium.com.cn>
[PMD: Add SPDX-License-Identifier: GPL-2.0-or-later tag]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                     |   7 +
 docs/specs/index.rst            |   1 +
 docs/specs/iommu-testdev.rst    | 140 ++++++++++++++
 include/hw/misc/iommu-testdev.h |  87 +++++++++
 hw/misc/iommu-testdev.c         | 318 ++++++++++++++++++++++++++++++++
 hw/misc/Kconfig                 |   5 +
 hw/misc/meson.build             |   1 +
 hw/misc/trace-events            |  10 +
 8 files changed, 569 insertions(+)
 create mode 100644 docs/specs/iommu-testdev.rst
 create mode 100644 include/hw/misc/iommu-testdev.h
 create mode 100644 hw/misc/iommu-testdev.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c1e586c58f0..63a04350fb0 100644
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
index f19d73c9f6e..b7909a108ab 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -39,3 +39,4 @@ guest hardware that is specific to QEMU.
    riscv-iommu
    riscv-aia
    aspeed-intc
+   iommu-testdev
diff --git a/docs/specs/iommu-testdev.rst b/docs/specs/iommu-testdev.rst
new file mode 100644
index 00000000000..89929a307e2
--- /dev/null
+++ b/docs/specs/iommu-testdev.rst
@@ -0,0 +1,140 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+iommu-testdev — IOMMU test device for bare-metal testing
+========================================================
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
diff --git a/include/hw/misc/iommu-testdev.h b/include/hw/misc/iommu-testdev.h
new file mode 100644
index 00000000000..338365947c6
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
diff --git a/hw/misc/iommu-testdev.c b/hw/misc/iommu-testdev.c
new file mode 100644
index 00000000000..15eb6de78a5
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
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 4a22d68233e..f4d49248c08 100644
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
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 32b878e035d..c444e030ecd 100644
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
index eeb9243898e..4cee8a2b454 100644
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
-- 
2.52.0


