Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2697CC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 17:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sACRY-00016U-QY; Thu, 23 May 2024 13:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sACQk-0000f1-H8
 for qemu-devel@nongnu.org; Thu, 23 May 2024 13:40:49 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sACQe-0001Za-Ui
 for qemu-devel@nongnu.org; Thu, 23 May 2024 13:40:40 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f05b669b6cso22143855ad.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 10:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716486035; x=1717090835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sFYh/sZ/5aWV4UXAxOYIoojjxEy/AqrJwmzbsQkoddA=;
 b=MlNm2Hw8IGK1tUCn8cFLlMTbEh+l6L+X/B4N8fNgQ1ZQx2MG8kTZo+PCVWzN9Lq964
 DZYayk+hzv3npLuUyPrEy4fkHAPEjTNtoHSDpKFxAhZ3Guw2suY13PBfzubKtS0cxtIh
 VoQS6nIBycMW/EOh1tUTGYwNfoCI378e8a/mDBWc4UBW9qSSaijIAHztK5JV53LrwlhY
 Qoe4wyHtcxMWR9vy+EhZwUwdWEoRlslIYz+CdQHHqxzTF3y8OpCr9GrhnJEZYqG6aBL9
 QYtl12lj75eZN/QFZ7ryvKFb9Mod3oK2D+mJ+4WyzAAHRuhupt1VuFNM5J9OSj8HAfKN
 yJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716486035; x=1717090835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sFYh/sZ/5aWV4UXAxOYIoojjxEy/AqrJwmzbsQkoddA=;
 b=fguEfIFKI94VebqzY32QiPLT6EaABzfUbqJgESsmDctXElG7XA8aceMzJgCEMOlswZ
 cGaC7PCCP7PLAMlWfdW4ZfFdUxGfnThTMZCN28krIOZhPk2WdMC5P34dIZCZXBI2qxm0
 XEJzYS5Pq5SzPGjoQxFc8k/uT3NM8N6VD8crRetWY+tPP8LRY9jyQLG43VzsKdgdrHMT
 wO5y432r4Z35slAvzIbRfwmO22tPpWW5Q4L+y7WrebaarKyZG256PLkreMysaSlOtDWD
 nadiSEpUuj2SMY1j0+GRRepk8UDltY/C5TFWvw5fzBbDHSOd0QUiSqktPf6yRZHD3nZj
 XQVw==
X-Gm-Message-State: AOJu0YyylMDzLTa3TJ7PFck6cYVLBHkqgozGpCuLuvXBTA5e8uIzzcV9
 V88VDVBbazlwSECW96dhA6MDr/1zCRCuZTR69V1ZdZumfUsVwASswWVlve55/b6AzhMn06EfchJ
 +
X-Google-Smtp-Source: AGHT+IExWq1OkP2eT0Ay+5FkrMJxaRtf3umIB1YaFPRj4M5YwhHbFs3qlmYVmI4TUstFd9bmqYVk5A==
X-Received: by 2002:a17:902:d4c7:b0:1e2:9ddc:f72d with SMTP id
 d9443c01a7336-1f44870278dmr227055ad.26.1716486034811; 
 Thu, 23 May 2024 10:40:34 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.42.4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f2fb4ca0ebsm81246535ad.119.2024.05.23.10.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 10:40:34 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 tjeznach@rivosinc.com, ajones@ventanamicro.com, frank.chang@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 07/13] test/qtest: add riscv-iommu-pci tests
Date: Thu, 23 May 2024 14:39:48 -0300
Message-ID: <20240523173955.1940072-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240523173955.1940072-1-dbarboza@ventanamicro.com>
References: <20240523173955.1940072-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x636.google.com
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

To test the RISC-V IOMMU emulation we'll use its PCI representation.
Create a new 'riscv-iommu-pci' libqos device that will be present with
CONFIG_RISCV_IOMMU.  This config is only available for RISC-V, so this
device will only be consumed by the RISC-V libqos machine.

Start with basic tests: a PCI sanity check and a reset state register
test. The reset test was taken from the RISC-V IOMMU spec chapter 5.2,
"Reset behavior".

More tests will be added later.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
---
 tests/qtest/libqos/meson.build   |  4 ++
 tests/qtest/libqos/riscv-iommu.c | 76 ++++++++++++++++++++++++++
 tests/qtest/libqos/riscv-iommu.h | 71 ++++++++++++++++++++++++
 tests/qtest/meson.build          |  1 +
 tests/qtest/riscv-iommu-test.c   | 93 ++++++++++++++++++++++++++++++++
 5 files changed, 245 insertions(+)
 create mode 100644 tests/qtest/libqos/riscv-iommu.c
 create mode 100644 tests/qtest/libqos/riscv-iommu.h
 create mode 100644 tests/qtest/riscv-iommu-test.c

diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.build
index 3aed6efcb8..07fe20eacb 100644
--- a/tests/qtest/libqos/meson.build
+++ b/tests/qtest/libqos/meson.build
@@ -67,6 +67,10 @@ if have_virtfs
   libqos_srcs += files('virtio-9p.c', 'virtio-9p-client.c')
 endif
 
+if config_all_devices.has_key('CONFIG_RISCV_IOMMU')
+  libqos_srcs += files('riscv-iommu.c')
+endif
+
 libqos = static_library('qos', libqos_srcs + genh,
                         name_suffix: 'fa',
                         build_by_default: false)
diff --git a/tests/qtest/libqos/riscv-iommu.c b/tests/qtest/libqos/riscv-iommu.c
new file mode 100644
index 0000000000..01e3b31c0b
--- /dev/null
+++ b/tests/qtest/libqos/riscv-iommu.c
@@ -0,0 +1,76 @@
+/*
+ * libqos driver riscv-iommu-pci framework
+ *
+ * Copyright (c) 2024 Ventana Micro Systems Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at your
+ * option) any later version.  See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "../libqtest.h"
+#include "qemu/module.h"
+#include "qgraph.h"
+#include "pci.h"
+#include "riscv-iommu.h"
+
+static void *riscv_iommu_pci_get_driver(void *obj, const char *interface)
+{
+    QRISCVIOMMU *r_iommu_pci = obj;
+
+    if (!g_strcmp0(interface, "pci-device")) {
+        return &r_iommu_pci->dev;
+    }
+
+    fprintf(stderr, "%s not present in riscv_iommu_pci\n", interface);
+    g_assert_not_reached();
+}
+
+static void riscv_iommu_pci_start_hw(QOSGraphObject *obj)
+{
+    QRISCVIOMMU *pci = (QRISCVIOMMU *)obj;
+    qpci_device_enable(&pci->dev);
+}
+
+static void riscv_iommu_pci_destructor(QOSGraphObject *obj)
+{
+    QRISCVIOMMU *pci = (QRISCVIOMMU *)obj;
+    qpci_iounmap(&pci->dev, pci->reg_bar);
+}
+
+static void *riscv_iommu_pci_create(void *pci_bus, QGuestAllocator *alloc,
+                                    void *addr)
+{
+    QRISCVIOMMU *r_iommu_pci = g_new0(QRISCVIOMMU, 1);
+    QPCIBus *bus = pci_bus;
+
+    qpci_device_init(&r_iommu_pci->dev, bus, addr);
+    r_iommu_pci->reg_bar = qpci_iomap(&r_iommu_pci->dev, 0, NULL);
+
+    r_iommu_pci->obj.get_driver = riscv_iommu_pci_get_driver;
+    r_iommu_pci->obj.start_hw = riscv_iommu_pci_start_hw;
+    r_iommu_pci->obj.destructor = riscv_iommu_pci_destructor;
+    return &r_iommu_pci->obj;
+}
+
+static void riscv_iommu_pci_register_nodes(void)
+{
+    QPCIAddress addr = {
+        .vendor_id = RISCV_IOMMU_PCI_VENDOR_ID,
+        .device_id = RISCV_IOMMU_PCI_DEVICE_ID,
+        .devfn = QPCI_DEVFN(1, 0),
+    };
+
+    QOSGraphEdgeOptions opts = {
+        .extra_device_opts = "addr=01.0",
+    };
+
+    add_qpci_address(&opts, &addr);
+
+    qos_node_create_driver("riscv-iommu-pci", riscv_iommu_pci_create);
+    qos_node_produces("riscv-iommu-pci", "pci-device");
+    qos_node_consumes("riscv-iommu-pci", "pci-bus", &opts);
+}
+
+libqos_init(riscv_iommu_pci_register_nodes);
diff --git a/tests/qtest/libqos/riscv-iommu.h b/tests/qtest/libqos/riscv-iommu.h
new file mode 100644
index 0000000000..d123efb41f
--- /dev/null
+++ b/tests/qtest/libqos/riscv-iommu.h
@@ -0,0 +1,71 @@
+/*
+ * libqos driver riscv-iommu-pci framework
+ *
+ * Copyright (c) 2024 Ventana Micro Systems Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at your
+ * option) any later version.  See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef TESTS_LIBQOS_RISCV_IOMMU_H
+#define TESTS_LIBQOS_RISCV_IOMMU_H
+
+#include "qgraph.h"
+#include "pci.h"
+#include "qemu/bitops.h"
+
+#ifndef GENMASK_ULL
+#define GENMASK_ULL(h, l) (((~0ULL) >> (63 - (h) + (l))) << (l))
+#endif
+
+/*
+ * RISC-V IOMMU uses PCI_VENDOR_ID_REDHAT 0x1b36 and
+ * PCI_DEVICE_ID_REDHAT_RISCV_IOMMU 0x0014.
+ */
+#define RISCV_IOMMU_PCI_VENDOR_ID       0x1b36
+#define RISCV_IOMMU_PCI_DEVICE_ID       0x0014
+#define RISCV_IOMMU_PCI_DEVICE_CLASS    0x0806
+
+/* Common field positions */
+#define RISCV_IOMMU_QUEUE_ENABLE        BIT(0)
+#define RISCV_IOMMU_QUEUE_INTR_ENABLE   BIT(1)
+#define RISCV_IOMMU_QUEUE_MEM_FAULT     BIT(8)
+#define RISCV_IOMMU_QUEUE_ACTIVE        BIT(16)
+#define RISCV_IOMMU_QUEUE_BUSY          BIT(17)
+
+#define RISCV_IOMMU_REG_CAP             0x0000
+#define RISCV_IOMMU_CAP_VERSION         GENMASK_ULL(7, 0)
+
+#define RISCV_IOMMU_REG_DDTP            0x0010
+#define RISCV_IOMMU_DDTP_BUSY           BIT_ULL(4)
+#define RISCV_IOMMU_DDTP_MODE           GENMASK_ULL(3, 0)
+#define RISCV_IOMMU_DDTP_MODE_OFF       0
+
+#define RISCV_IOMMU_REG_CQCSR           0x0048
+#define RISCV_IOMMU_CQCSR_CQEN          RISCV_IOMMU_QUEUE_ENABLE
+#define RISCV_IOMMU_CQCSR_CIE           RISCV_IOMMU_QUEUE_INTR_ENABLE
+#define RISCV_IOMMU_CQCSR_CQON          RISCV_IOMMU_QUEUE_ACTIVE
+#define RISCV_IOMMU_CQCSR_BUSY          RISCV_IOMMU_QUEUE_BUSY
+
+#define RISCV_IOMMU_REG_FQCSR           0x004C
+#define RISCV_IOMMU_FQCSR_FQEN          RISCV_IOMMU_QUEUE_ENABLE
+#define RISCV_IOMMU_FQCSR_FIE           RISCV_IOMMU_QUEUE_INTR_ENABLE
+#define RISCV_IOMMU_FQCSR_FQON          RISCV_IOMMU_QUEUE_ACTIVE
+#define RISCV_IOMMU_FQCSR_BUSY          RISCV_IOMMU_QUEUE_BUSY
+
+#define RISCV_IOMMU_REG_PQCSR           0x0050
+#define RISCV_IOMMU_PQCSR_PQEN          RISCV_IOMMU_QUEUE_ENABLE
+#define RISCV_IOMMU_PQCSR_PIE           RISCV_IOMMU_QUEUE_INTR_ENABLE
+#define RISCV_IOMMU_PQCSR_PQON          RISCV_IOMMU_QUEUE_ACTIVE
+#define RISCV_IOMMU_PQCSR_BUSY          RISCV_IOMMU_QUEUE_BUSY
+
+#define RISCV_IOMMU_REG_IPSR            0x0054
+
+typedef struct QRISCVIOMMU {
+    QOSGraphObject obj;
+    QPCIDevice dev;
+    QPCIBar reg_bar;
+} QRISCVIOMMU;
+
+#endif
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 86293051dc..1b81db2807 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -293,6 +293,7 @@ qos_test_ss.add(
   'vmxnet3-test.c',
   'igb-test.c',
   'ufs-test.c',
+  'riscv-iommu-test.c',
 )
 
 if config_all_devices.has_key('CONFIG_VIRTIO_SERIAL')
diff --git a/tests/qtest/riscv-iommu-test.c b/tests/qtest/riscv-iommu-test.c
new file mode 100644
index 0000000000..7f0dbd0211
--- /dev/null
+++ b/tests/qtest/riscv-iommu-test.c
@@ -0,0 +1,93 @@
+/*
+ * QTest testcase for RISC-V IOMMU
+ *
+ * Copyright (c) 2024 Ventana Micro Systems Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at your
+ * option) any later version.  See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+#include "qemu/module.h"
+#include "libqos/qgraph.h"
+#include "libqos/riscv-iommu.h"
+#include "hw/pci/pci_regs.h"
+
+static uint32_t riscv_iommu_read_reg32(QRISCVIOMMU *r_iommu, int reg_offset)
+{
+    uint32_t reg;
+
+    qpci_memread(&r_iommu->dev, r_iommu->reg_bar, reg_offset,
+                 &reg, sizeof(reg));
+    return reg;
+}
+
+static uint64_t riscv_iommu_read_reg64(QRISCVIOMMU *r_iommu, int reg_offset)
+{
+    uint64_t reg;
+
+    qpci_memread(&r_iommu->dev, r_iommu->reg_bar, reg_offset,
+                 &reg, sizeof(reg));
+    return reg;
+}
+
+static void test_pci_config(void *obj, void *data, QGuestAllocator *t_alloc)
+{
+    QRISCVIOMMU *r_iommu = obj;
+    QPCIDevice *dev = &r_iommu->dev;
+    uint16_t vendorid, deviceid, classid;
+
+    vendorid = qpci_config_readw(dev, PCI_VENDOR_ID);
+    deviceid = qpci_config_readw(dev, PCI_DEVICE_ID);
+    classid = qpci_config_readw(dev, PCI_CLASS_DEVICE);
+
+    g_assert_cmpuint(vendorid, ==, RISCV_IOMMU_PCI_VENDOR_ID);
+    g_assert_cmpuint(deviceid, ==, RISCV_IOMMU_PCI_DEVICE_ID);
+    g_assert_cmpuint(classid, ==, RISCV_IOMMU_PCI_DEVICE_CLASS);
+}
+
+static void test_reg_reset(void *obj, void *data, QGuestAllocator *t_alloc)
+{
+    QRISCVIOMMU *r_iommu = obj;
+    uint64_t cap;
+    uint32_t reg;
+
+    cap = riscv_iommu_read_reg64(r_iommu, RISCV_IOMMU_REG_CAP);
+    g_assert_cmpuint(cap & RISCV_IOMMU_CAP_VERSION, ==, 0x10);
+
+    reg = riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_CQCSR);
+    g_assert_cmpuint(reg & RISCV_IOMMU_CQCSR_CQEN, ==, 0);
+    g_assert_cmpuint(reg & RISCV_IOMMU_CQCSR_CIE, ==, 0);
+    g_assert_cmpuint(reg & RISCV_IOMMU_CQCSR_CQON, ==, 0);
+    g_assert_cmpuint(reg & RISCV_IOMMU_CQCSR_BUSY, ==, 0);
+
+    reg = riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_FQCSR);
+    g_assert_cmpuint(reg & RISCV_IOMMU_FQCSR_FQEN, ==, 0);
+    g_assert_cmpuint(reg & RISCV_IOMMU_FQCSR_FIE, ==, 0);
+    g_assert_cmpuint(reg & RISCV_IOMMU_FQCSR_FQON, ==, 0);
+    g_assert_cmpuint(reg & RISCV_IOMMU_FQCSR_BUSY, ==, 0);
+
+    reg = riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_PQCSR);
+    g_assert_cmpuint(reg & RISCV_IOMMU_PQCSR_PQEN, ==, 0);
+    g_assert_cmpuint(reg & RISCV_IOMMU_PQCSR_PIE, ==, 0);
+    g_assert_cmpuint(reg & RISCV_IOMMU_PQCSR_PQON, ==, 0);
+    g_assert_cmpuint(reg & RISCV_IOMMU_PQCSR_BUSY, ==, 0);
+
+    reg = riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_DDTP);
+    g_assert_cmpuint(reg & RISCV_IOMMU_DDTP_BUSY, ==, 0);
+    g_assert_cmpuint(reg & RISCV_IOMMU_DDTP_MODE, ==,
+                     RISCV_IOMMU_DDTP_MODE_OFF);
+
+    reg = riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_IPSR);
+    g_assert_cmpuint(reg, ==, 0);
+}
+
+static void register_riscv_iommu_test(void)
+{
+    qos_add_test("pci_config", "riscv-iommu-pci", test_pci_config, NULL);
+    qos_add_test("reg_reset", "riscv-iommu-pci", test_reg_reset, NULL);
+}
+
+libqos_init(register_riscv_iommu_test);
-- 
2.44.0


