Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AB8D44D5E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 13:35:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8gBB-0001hU-9y; Wed, 06 Nov 2024 08:34:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t8gB8-0001gv-8c
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 08:34:34 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t8gB6-0001at-AC
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 08:34:34 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-720cb6ac25aso5202490b3a.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 05:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1730900071; x=1731504871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CfJEur4IrmO6iNqhGkNHqo96+uRQo7JpR47tGh3SBH0=;
 b=iFsubFUekQGD6EpsMiLzcFK4mRl6a7uX1bDQ9iWkpaadl6Ors7fWku8aGK34rPww9m
 E+ULH+yBwlINwszf9otI5t4p05RPa5+d7cvibk+X5De5DX6QcPjJK8xtlyE11PowmPNu
 eXRu2n+TgozIJmReOr9bnP80svM3pezRU3iMopHPVXqsFeaMwkQPzCVwLiFevfSNU4I+
 1vzFwWNvVBMIbZKZfY2m7O8Ze+k8yfaCGljro1+LvLyyMu9Qfem5CglOX9pSQwXr2xiS
 p3pt3hv1pAeiNABuB8tUkMIIy9DmH7mmAoxhBY10xH7o7SvP++GpZwOfmcX6KbWbNNvJ
 t8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730900071; x=1731504871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CfJEur4IrmO6iNqhGkNHqo96+uRQo7JpR47tGh3SBH0=;
 b=TDvBjPWilp3BeH01IPaX+trff2kJ8AZlqJle2/RUdFcLHLCKr8/xc3BUcLKKVtQANX
 Y/H1YczOsg78SQQk6LPABf69RbRasEA8SkqDwOcIB/lQojsjpQNRo4VfDYyxp8NH2s/C
 YGzTVRmcagXhaay+QC/eUWUJ5/5znWkjsOkk33LhmflVKCbnr40yDg07AidyFqna9p9X
 6QhRktrxbfi1f1PhKvzTvE+uqytEHV9MjrQ7ZR6ZTmSOhkYNC0LDcE86SVmSa4m15czp
 ipn6W5rhO+DDf65eZbTxxKiwi7wrc+2T58YmFUU9K6TgsnnKGe9dU/rkbSOLVXdp4BUK
 xcGQ==
X-Gm-Message-State: AOJu0YxDUwWSKCySZXQ3eyl/dRqy9FZpetkrwLP8KNAKdgHcm4v+rH7j
 LAR1l2tEruhzdEjEuuJ6EzU8EghwqO3IL3wisC6ah846riuKv8hNFv4trD0ZqQ3ySGBH00U1Zmo
 y
X-Google-Smtp-Source: AGHT+IHND+dAC7/aHSiz7LYskE26ugOVYkxF/L0Xkke6WypdSpSYa0PHb3xGFh29AOUKyklM6lfHfA==
X-Received: by 2002:a05:6a00:3cc8:b0:71e:b4ee:960d with SMTP id
 d2e1a72fcca58-72062fa1349mr55835619b3a.10.1730900070620; 
 Wed, 06 Nov 2024 05:34:30 -0800 (PST)
Received: from grind.. ([189.79.22.174]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc2eb64esm11749765b3a.168.2024.11.06.05.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 05:34:30 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Tomasz Jeznach <tjeznach@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-10.0 3/7] hw/riscv: add riscv-iommu-sys platform device
Date: Wed,  6 Nov 2024 10:34:03 -0300
Message-ID: <20241106133407.604587-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241106133407.604587-1-dbarboza@ventanamicro.com>
References: <20241106133407.604587-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Tomasz Jeznach <tjeznach@rivosinc.com>

This device models the RISC-V IOMMU as a sysbus device. The same design
decisions taken in the riscv-iommu-pci device were kept, namely the
existence of 4 vectors are available for each interrupt cause.

The WSIs are emitted using the input of the s->notify() callback as a
index to an IRQ list. The IRQ list starts at 'base_irq' and goes until
base_irq + 3. This means that boards must have 4 contiguous IRQ lines
available, starting from 'base_irq'.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/meson.build       |   2 +-
 hw/riscv/riscv-iommu-sys.c | 128 +++++++++++++++++++++++++++++++++++++
 hw/riscv/riscv-iommu.c     |   3 +-
 include/hw/riscv/iommu.h   |   4 ++
 4 files changed, 134 insertions(+), 3 deletions(-)
 create mode 100644 hw/riscv/riscv-iommu-sys.c

diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index adbef8a9b2..3be13d7774 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -10,6 +10,6 @@ riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
 riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
 riscv_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true: files('microchip_pfsoc.c'))
 riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
-riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files('riscv-iommu.c', 'riscv-iommu-pci.c'))
+riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files('riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c'))
 
 hw_arch += {'riscv': riscv_ss}
diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
new file mode 100644
index 0000000000..4b82046ce9
--- /dev/null
+++ b/hw/riscv/riscv-iommu-sys.c
@@ -0,0 +1,128 @@
+/*
+ * QEMU emulation of an RISC-V IOMMU Platform Device
+ *
+ * Copyright (C) 2022-2023 Rivos Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/irq.h"
+#include "hw/pci/pci_bus.h"
+#include "hw/qdev-properties.h"
+#include "hw/sysbus.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/host-utils.h"
+#include "qemu/module.h"
+#include "qom/object.h"
+
+#include "riscv-iommu.h"
+
+#define RISCV_IOMMU_SYSDEV_ICVEC_VECTORS 0x3333
+
+/* RISC-V IOMMU System Platform Device Emulation */
+
+struct RISCVIOMMUStateSys {
+    SysBusDevice     parent;
+    uint64_t         addr;
+    uint32_t         base_irq;
+    DeviceState      *irqchip;
+    RISCVIOMMUState  iommu;
+    qemu_irq         irqs[RISCV_IOMMU_INTR_COUNT];
+};
+
+static void riscv_iommu_sysdev_notify(RISCVIOMMUState *iommu,
+                                      unsigned vector)
+{
+    RISCVIOMMUStateSys *s = container_of(iommu, RISCVIOMMUStateSys, iommu);
+    uint32_t fctl =  riscv_iommu_reg_get32(iommu, RISCV_IOMMU_REG_FCTL);
+
+    /* We do not support MSIs yet */
+    if (!(fctl & RISCV_IOMMU_FCTL_WSI)) {
+        return;
+    }
+
+    qemu_irq_pulse(s->irqs[vector]);
+}
+
+static void riscv_iommu_sys_realize(DeviceState *dev, Error **errp)
+{
+    RISCVIOMMUStateSys *s = RISCV_IOMMU_SYS(dev);
+    SysBusDevice *sysdev = SYS_BUS_DEVICE(s);
+    PCIBus *pci_bus;
+    qemu_irq irq;
+
+    qdev_realize(DEVICE(&s->iommu), NULL, errp);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iommu.regs_mr);
+    if (s->addr) {
+        sysbus_mmio_map(SYS_BUS_DEVICE(s), 0, s->addr);
+    }
+
+    pci_bus = (PCIBus *) object_resolve_path_type("", TYPE_PCI_BUS, NULL);
+    if (pci_bus) {
+        riscv_iommu_pci_setup_iommu(&s->iommu, pci_bus, errp);
+    }
+
+    s->iommu.notify = riscv_iommu_sysdev_notify;
+
+    /* 4 IRQs are defined starting from s->base_irq */
+    for (int i = 0; i < RISCV_IOMMU_INTR_COUNT; i++) {
+        sysbus_init_irq(sysdev, &s->irqs[i]);
+        irq = qdev_get_gpio_in(s->irqchip, s->base_irq + i);
+        sysbus_connect_irq(sysdev, i, irq);
+    }
+}
+
+static void riscv_iommu_sys_init(Object *obj)
+{
+    RISCVIOMMUStateSys *s = RISCV_IOMMU_SYS(obj);
+    RISCVIOMMUState *iommu = &s->iommu;
+
+    object_initialize_child(obj, "iommu", iommu, TYPE_RISCV_IOMMU);
+    qdev_alias_all_properties(DEVICE(iommu), obj);
+
+    iommu->icvec_avail_vectors = RISCV_IOMMU_SYSDEV_ICVEC_VECTORS;
+    riscv_iommu_set_cap_igs(iommu, RISCV_IOMMU_CAP_IGS_WSI);
+}
+
+static Property riscv_iommu_sys_properties[] = {
+    DEFINE_PROP_UINT64("addr", RISCVIOMMUStateSys, addr, 0),
+    DEFINE_PROP_UINT32("base-irq", RISCVIOMMUStateSys, base_irq, 0),
+    DEFINE_PROP_LINK("irqchip", RISCVIOMMUStateSys, irqchip,
+                     TYPE_DEVICE, DeviceState *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void riscv_iommu_sys_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    dc->realize = riscv_iommu_sys_realize;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    device_class_set_props(dc, riscv_iommu_sys_properties);
+}
+
+static const TypeInfo riscv_iommu_sys = {
+    .name          = TYPE_RISCV_IOMMU_SYS,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .class_init    = riscv_iommu_sys_class_init,
+    .instance_init = riscv_iommu_sys_init,
+    .instance_size = sizeof(RISCVIOMMUStateSys),
+};
+
+static void riscv_iommu_register_sys(void)
+{
+    type_register_static(&riscv_iommu_sys);
+}
+
+type_init(riscv_iommu_register_sys)
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index d95b4b95d8..239f83f5bd 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -94,10 +94,9 @@ static uint8_t riscv_iommu_get_icvec_vector(uint32_t icvec, uint32_t vec_type)
 
 static void riscv_iommu_notify(RISCVIOMMUState *s, int vec_type)
 {
-    const uint32_t fctl = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FCTL);
     uint32_t ipsr, icvec, vector;
 
-    if (fctl & RISCV_IOMMU_FCTL_WSI || !s->notify) {
+    if (!s->notify) {
         return;
     }
 
diff --git a/include/hw/riscv/iommu.h b/include/hw/riscv/iommu.h
index 80769a1400..fc20808553 100644
--- a/include/hw/riscv/iommu.h
+++ b/include/hw/riscv/iommu.h
@@ -33,4 +33,8 @@ typedef struct RISCVIOMMUSpace RISCVIOMMUSpace;
 OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUStatePci, RISCV_IOMMU_PCI)
 typedef struct RISCVIOMMUStatePci RISCVIOMMUStatePci;
 
+#define TYPE_RISCV_IOMMU_SYS "riscv-iommu-device"
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUStateSys, RISCV_IOMMU_SYS)
+typedef struct RISCVIOMMUStateSys RISCVIOMMUStateSys;
+
 #endif
-- 
2.45.2


