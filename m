Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26668E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2ZD-00035z-Cl; Wed, 18 Dec 2024 17:30:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2Z1-000331-LA
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:30:46 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2Ys-0002YO-5y
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:30:38 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2165448243fso2030565ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561032; x=1735165832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pOV1WvFwGJKAvHvOnB4ZRyY8YK8JT6WQG/HP3IlXapc=;
 b=Nx63tC9l/iHymophxNUW1xcopPjrevczHJc2EC6BcbDt2zFDfgXqq13Pdy6I+81VB7
 8waOAx1N3N3Ooz8ietudFk24LC71QEHnIKGhYCa1FSgYRS2GqZKFnloP7PN+OzotFWi7
 8HkWEz4Mdm0U593VSAkzaBJ9CxrQ228qKWgv6cw2pheNelZL7s7Us8BSiyY6+OhtcRcv
 UkEqS3cyOcyar3UapbBdRS+3PQt21vB6nY62NutHHWi8v7aYaKujieGeypWJjajn3UEO
 2G0+WVPsarwiN9SV/vOA/gKqDu/CvY22V2djQEh72bpacA1GUEvkPCsBTSjW0exd9TMR
 8QBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561032; x=1735165832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pOV1WvFwGJKAvHvOnB4ZRyY8YK8JT6WQG/HP3IlXapc=;
 b=QRa1GRjj9pXi3mnUj08bYBDeE+1356uH43cxKaCdcOJAO0gkimGv8Xyd8ZHwJV7QHd
 5vbbmPLS5DDGtS8b7G/9aIOTESKXNYRhERn6cZRG1+FLoz8YqzOgYtusgky4Ff/VCi0c
 7n0EDxufGwHihijRBHfQtTyLSffPQ4tcNuS+h3eZ4l2mu2SgoA2Jl1f197jM9krBTwmU
 zL6NWFNUQqCXQNOtvWUhK07zTx8cv1feLnCQPfQCKwfsG2l0EDbnivMArDD/z2V1l3X8
 UBjrC29HjtGftN79yRWAXY8pUNBwfcmF/KhGZFOI/3SWnD2P04BaCzN61fRr7GtSqUzg
 TJwA==
X-Gm-Message-State: AOJu0Yz0kl+7EJ2VHPAbsjFjUjpg8b9pguDBcU/9tQoPpccM1xVbkcnJ
 YQH7Qs8QU8zAXaSIWJLAvtagb6eeoAf3ytyZswZ/KSb2UwmfnjTtqB0aSIPo
X-Gm-Gg: ASbGncuzoNRLlV1R3RvO72Tk3teUKqJZHF/N825bePNo1iJc/lFbumJGAL/ZMgtvZcF
 Kgz0PqX0tQEyT44Ak+i2QCd4+p90RcrIvjPli+3tdPfAukL/RxJqyND4Wi8THOTtjXIf/DmySgi
 arW3QN1yQeXVrhRpDEJLFjMnBBhKc3n97eyexS+2oq97yVgC451PWoTW9rLzHwxbE5a+VBxNemL
 7JBufC0UfvccjJAYwlJDVXKXmh89Qxyhd9ZJuX9tLS1EZZMI4RB1z7bSBBQM7pW+kTsfX6AU8Ro
 aaeK3+xJvv4r5Tw23KOC+6GJ0JxEN1x6kiffDoI9p9zyjo8+jlwoQJ0o4Dn6/Xg=
X-Google-Smtp-Source: AGHT+IG9vlvYkheLPEriTE4+CO+ihKIbQE8Bg1XEfVslcHcAeoFhwDbnTBNQRNaKqC4eLI+WnW+6Mw==
X-Received: by 2002:a17:902:f54e:b0:216:25a2:2ebe with SMTP id
 d9443c01a7336-218d70fb66cmr67741015ad.19.1734561031826; 
 Wed, 18 Dec 2024 14:30:31 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:30:31 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 05/39] hw/riscv: add riscv-iommu-sys platform device
Date: Thu, 19 Dec 2024 08:29:35 +1000
Message-ID: <20241218223010.1931245-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241106133407.604587-4-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/iommu.h   |   4 ++
 hw/riscv/riscv-iommu-sys.c | 128 +++++++++++++++++++++++++++++++++++++
 hw/riscv/riscv-iommu.c     |   3 +-
 hw/riscv/meson.build       |   2 +-
 4 files changed, 134 insertions(+), 3 deletions(-)
 create mode 100644 hw/riscv/riscv-iommu-sys.c

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
index 24b879822b..9137217cb7 100644
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
-- 
2.47.1


