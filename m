Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C7CC54E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 16:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riGDr-0005Ci-KL; Thu, 07 Mar 2024 11:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riGDo-0005AS-Lq
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 11:03:52 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riGDk-0006CN-7i
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 11:03:51 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1dcb3e6ff3fso8776955ad.2
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 08:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709827426; x=1710432226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vhkJJXYBYc+DN7sMxGa2YG7Peqpq43f7HgOQhMshYT8=;
 b=NrOpMpOGXUCnKZrrL13h0A52R4I6cBwccGIeQe9nwSmq3QXBpwAnhvwXId8kOrJHOM
 tYhNoFocGsZflrtV8bV+MT2iEFwfPFccRzx0jmISBC/UZJoCLDNjgAau/bbxs6cChHmO
 +euurTsokR3sIXW18XxI9T12VrwOZkT7CjIPdtc2CalYs1mAUbcHGQh8m77PK1gZAXWR
 Ij6OeTUhU9yxx3ry8XcZon8s0xBbZv/n42Lk/09oWkvcut7QsU8STva9sX39a522yb2V
 SKmR4trt/mRP2JIJrMUXU2I37RLTUo3+WCSOhO4xY4U8Tm3jXjmZiXO7MhwDQZx2S+zW
 zLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709827426; x=1710432226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vhkJJXYBYc+DN7sMxGa2YG7Peqpq43f7HgOQhMshYT8=;
 b=pi2Ucuzb0YF9POXT0Tn+kIIeaswhZyFRsm7dNdp/TYjqaI0+Cy+GQSHO92gTAsSxLG
 SQbVaLXBh2yEhsblMdC032wtefE/2kikji1IDI2pzWA8RorZLP6Tvtxo3pdL4PTXkTgk
 sVac7MiCOkvyU5K7mHeVPIQMiLzvFQi/geBo/XnoRhh/Q4bq97nnnIsAtNq+F1AUEfkS
 fUnlvE7X+cU9tTuBUhQG6OOLVMELzWOIGln2FljFre3xdQFBXmL1wwPvRppbZVd3mFBD
 y2FwqNOwsyDaj5rQIlreCZlDyXJZr917t61Qzw+8wzQsqd/3O+9kLCg2oQjBL17CFUVl
 8C/Q==
X-Gm-Message-State: AOJu0YzwuAkwrc8p5L/2noify2l1A7vyqQNZVX6RRApv7bwYjQXxsraF
 EQcLfPMTWEipH2MkTkrGfo8Oc5L4hqR2MBd+9nLMwCgcqgzOAQIP3BBKrb35eB6kNqjwmkNVSeV
 b
X-Google-Smtp-Source: AGHT+IHvXzRLTMjy3t2Jpn9Ky44AhmCy8U5YGQdB2RHgyIBtuOqVkKKVsQT2V2YkYm9tlFWwRHNIhg==
X-Received: by 2002:a17:902:c081:b0:1dc:a282:365f with SMTP id
 j1-20020a170902c08100b001dca282365fmr7817500pld.40.1709827425435; 
 Thu, 07 Mar 2024 08:03:45 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 u11-20020a170903124b00b001db2b8b2da7sm14663136plh.122.2024.03.07.08.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 08:03:45 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, tjeznach@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 05/15] hw/riscv: add riscv-iommu-sys platform device
Date: Thu,  7 Mar 2024 13:03:08 -0300
Message-ID: <20240307160319.675044-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240307160319.675044-1-dbarboza@ventanamicro.com>
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This device models the RISC-V IOMMU as a sysbus device.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/meson.build       |  2 +-
 hw/riscv/riscv-iommu-sys.c | 93 ++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/iommu.h   |  4 ++
 3 files changed, 98 insertions(+), 1 deletion(-)
 create mode 100644 hw/riscv/riscv-iommu-sys.c

diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 4674cec6c4..e37c5d78e2 100644
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
index 0000000000..4305cf8d79
--- /dev/null
+++ b/hw/riscv/riscv-iommu-sys.c
@@ -0,0 +1,93 @@
+/*
+ * QEMU emulation of an RISC-V IOMMU (Ziommu) - Platform Device
+ *
+ * Copyright (C) 2022-2023 Rivos Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
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
+#include "hw/pci/pci_bus.h"
+#include "hw/qdev-properties.h"
+#include "hw/sysbus.h"
+#include "qapi/error.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/host-utils.h"
+#include "qemu/module.h"
+#include "qemu/osdep.h"
+#include "qom/object.h"
+
+#include "riscv-iommu.h"
+
+/* RISC-V IOMMU System Platform Device Emulation */
+
+struct RISCVIOMMUStateSys {
+    SysBusDevice     parent;
+    uint64_t         addr;
+    RISCVIOMMUState  iommu;
+};
+
+static void riscv_iommu_sys_realize(DeviceState *dev, Error **errp)
+{
+    RISCVIOMMUStateSys *s = RISCV_IOMMU_SYS(dev);
+    PCIBus *pci_bus;
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
+}
+
+static void riscv_iommu_sys_init(Object *obj)
+{
+    RISCVIOMMUStateSys *s = RISCV_IOMMU_SYS(obj);
+    RISCVIOMMUState *iommu = &s->iommu;
+
+    object_initialize_child(obj, "iommu", iommu, TYPE_RISCV_IOMMU);
+    qdev_alias_all_properties(DEVICE(iommu), obj);
+}
+
+static Property riscv_iommu_sys_properties[] = {
+    DEFINE_PROP_UINT64("addr", RISCVIOMMUStateSys, addr, 0),
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
diff --git a/include/hw/riscv/iommu.h b/include/hw/riscv/iommu.h
index 403b365893..c8d28a79a1 100644
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
2.43.2


