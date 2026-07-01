Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E12C43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes2h-0003kI-D8; Wed, 01 Jul 2026 06:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes2g-0003fA-5p
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:42 -0400
Received: from mail-dl1-x1235.google.com ([2607:f8b0:4864:20::1235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes2e-0004rA-1o
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:41 -0400
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-139f1dfc9faso745720c88.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901179; x=1783505979; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XUC1vU2t4ThfWsMPxXYKY7YwtuA09bZUnKTBs5CDwKo=;
 b=Ll6HrFYGoK6xgJ17mNYEAFYGh/JXqvvIt3Vg3wz2qalZEtippcU9O7wYdxlDfkhGVK
 dAqg54diQ9HCEElxk3JDmloTmlS7JKgny/xkBptiSEMQr0M7xXJeUDmjcI5biFvesMMe
 09GygWCgXq2Utd7O4cz67AVdiMsE8Azducr4OJSq5i3lk96VCm+AeXNTBmBTsuFIeU6b
 v/3ev7KYcjW7bEuvsuO5X6VP5pe1sFHwAQpjrASp0iRdN9sMegqAgT8gp1/nAadiB2+p
 vFYW4QtjMilamjVCWr5hop1e/Ino7RC0sDw1j5/yVcfeoQKGVRWgTkf8Y6e8S3WR7E71
 20yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901179; x=1783505979;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XUC1vU2t4ThfWsMPxXYKY7YwtuA09bZUnKTBs5CDwKo=;
 b=e7oDN0no+E5DpPshSfsC09ck3zpOXQGyS2jCejCo0jHDE/4T+I9XDsb+G3pT1y0JFR
 XcU2vNOsFb4sha9O7emChtwGIOossTlcCzY7jKpPYkgcz9Rf/2919r7Il2IAJ89O27Qj
 UoBiZSXJDpuzc6cZDvo25hJrF+egGmKXj1cnzCXBX0yQ7eWor0/MkOMIgdyyKj4r6nfq
 A8Up16vGCtwKBTDdbOLmHsb0J/TIHAorrEdzqdIj8Ef81/somhXzaNfjAT5j40dKttH6
 ZKGyxI6vHCv8GRa2eF90UzmGXvZ45iyK6T+OaotriRB7no9fpKrcsD9pHZyL2am2eZgj
 7mcQ==
X-Gm-Message-State: AOJu0YxiK2W9zhlgaAJR/B5i8BnknM/iYxzOqAYtkDdWp7V0OkUdyNH3
 PMMg4aS9V90lI38Tzh8wAsGF/fkaFlRlfFzSiuL7tSNDjRBoKwBOBETNrNrXFA==
X-Gm-Gg: AfdE7cmpCcLMgNTw9/L9088Lp8X3xwKBmNozgJEwM+/zSKtHVJG/HgOaZXdSas1Kb0o
 DUF6CgNbBMAGldah9hZoBj1Q0UzE+d79XpEBqDMA/41053BUs+NJJBKCGTeRCtyCd1Y2gD8ih1p
 9aICUl0SWMSd2HZhi1I+a0b6RnrhpO/etJJZToWraO98/70MIut9fapkKsdLqQtriXsz26nBHcP
 PtexO2Qv8ZLlSM/sUw61qepxzFJBR/Otg0/9SKMIHAktuvXSTRrhBQyoJj499uA6cgF0WecNa9u
 +ydGTj/pMd9wclD+tzdjXZEb2Y0dl3fpT97F4BTHlE2b4IFfCoWMWIL8LZfLEojoC8Bpo7g3Ub4
 ZINLwGoMwGw5JvxPS91Q+2SK83jJx4yGBbEYdpfjrCd90pbXVLGko/3TCnFFCnTb9+PkwfUXRm7
 ulfZhbVyPo0JI39lc6qiY2sOLU9O7zkApm/+8ACsoGyQ==
X-Received: by 2002:a05:7022:21a:b0:135:578a:cde2 with SMTP id
 a92af1059eb24-13b3913ceedmr190743c88.34.1782901178477; 
 Wed, 01 Jul 2026 03:19:38 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:19:37 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Joel Stanley <joel@jms.id.au>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Nutty Liu <nutty.liu@hotmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PULL 29/39] hw/riscv/virt: Move AIA initialisation to helper file
Date: Wed,  1 Jul 2026 20:17:42 +1000
Message-ID: <20260701101752.2522962-30-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1235;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x1235.google.com
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

From: Joel Stanley <joel@jms.id.au>

The AIA init will be used by any server class riscv machine. Separate it
out in order to share code with such systems.

The virt machine keeps machine specific #defines such as
VIRT_IRQCHIP_NUM_MSIS, VIRT_IRQCHIP_NUM_PRIO_BITS.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Message-ID: <20260630024952.1520546-4-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/aia.h             | 26 +++++++++++
 include/hw/riscv/virt.h    |  1 -
 hw/riscv/aia.c             | 89 ++++++++++++++++++++++++++++++++++++++
 hw/riscv/virt-acpi-build.c |  2 +
 hw/riscv/virt.c            | 87 +++++--------------------------------
 hw/riscv/meson.build       |  1 +
 6 files changed, 129 insertions(+), 77 deletions(-)
 create mode 100644 hw/riscv/aia.h
 create mode 100644 hw/riscv/aia.c

diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
new file mode 100644
index 0000000000..dbb8333402
--- /dev/null
+++ b/hw/riscv/aia.h
@@ -0,0 +1,26 @@
+/*
+ * QEMU RISC-V Advanced Interrupt Architecture (AIA)
+ *
+ * Copyright (C) 2019 Western Digital Corporation or its affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_RISCV_AIA_H
+#define HW_RISCV_AIA_H
+
+#include "exec/hwaddr.h"
+
+#define VIRT_IRQCHIP_NUM_SOURCES 96
+
+uint32_t imsic_num_bits(uint32_t count);
+
+DeviceState *riscv_create_aia(bool msimode, int aia_guests,
+                             const MemMapEntry *aplic_m,
+                             const MemMapEntry *aplic_s,
+                             const MemMapEntry *imsic_m,
+                             const MemMapEntry *imsic_s,
+                             int socket, int base_hartid, int hart_count,
+                             uint32_t num_msis, uint32_t num_prio_bits);
+
+#endif
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 18a2a323a3..ad858deb76 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -135,7 +135,6 @@ enum {
 bool virt_is_acpi_enabled(RISCVVirtState *s);
 bool virt_is_iommu_sys_enabled(RISCVVirtState *s);
 void virt_acpi_setup(RISCVVirtState *vms);
-uint32_t imsic_num_bits(uint32_t count);
 
 /*
  * The virt machine physical address space used by some of the devices
diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
new file mode 100644
index 0000000000..c724612a50
--- /dev/null
+++ b/hw/riscv/aia.c
@@ -0,0 +1,89 @@
+/*
+ * QEMU RISC-V Advanced Interrupt Architecture (AIA)
+ *
+ * Copyright (C) 2019 Western Digital Corporation or its affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "system/kvm.h"
+#include "hw/intc/riscv_aplic.h"
+#include "hw/intc/riscv_imsic.h"
+
+#include "aia.h"
+
+uint32_t imsic_num_bits(uint32_t count)
+{
+    uint32_t ret = 0;
+
+    while (BIT(ret) < count) {
+        ret++;
+    }
+
+    return ret;
+}
+
+DeviceState *riscv_create_aia(bool msimode, int aia_guests,
+                             const MemMapEntry *aplic_m,
+                             const MemMapEntry *aplic_s,
+                             const MemMapEntry *imsic_m,
+                             const MemMapEntry *imsic_s,
+                             int socket, int base_hartid, int hart_count,
+                             uint32_t num_msis, uint32_t num_prio_bits)
+{
+    int i;
+    hwaddr addr = 0;
+    uint32_t guest_bits;
+    DeviceState *aplic_s_dev = NULL;
+    DeviceState *aplic_m_dev = NULL;
+
+    if (msimode) {
+        if (!kvm_enabled()) {
+            /* Per-socket M-level IMSICs */
+            addr = imsic_m->base + socket * (1U << IMSIC_MMIO_GROUP_MIN_SHIFT);
+            for (i = 0; i < hart_count; i++) {
+                riscv_imsic_create(addr + i * IMSIC_HART_SIZE(0),
+                                   base_hartid + i, true, 1,
+                                   num_msis);
+            }
+        }
+
+        /* Per-socket S-level IMSICs */
+        guest_bits = imsic_num_bits(aia_guests + 1);
+        addr = imsic_s->base + socket * (1U << IMSIC_MMIO_GROUP_MIN_SHIFT);
+        for (i = 0; i < hart_count; i++) {
+            riscv_imsic_create(addr + i * IMSIC_HART_SIZE(guest_bits),
+                               base_hartid + i, false, 1 + aia_guests,
+                               num_msis);
+        }
+    }
+
+    if (!kvm_enabled()) {
+        /* Per-socket M-level APLIC */
+        aplic_m_dev = riscv_aplic_create(aplic_m->base +
+                                     socket * aplic_m->size,
+                                     aplic_m->size,
+                                     (msimode) ? 0 : base_hartid,
+                                     (msimode) ? 0 : hart_count,
+                                     VIRT_IRQCHIP_NUM_SOURCES,
+                                     num_prio_bits,
+                                     msimode, true, NULL);
+    }
+
+    /* Per-socket S-level APLIC */
+    aplic_s_dev = riscv_aplic_create(aplic_s->base +
+                                 socket * aplic_s->size,
+                                 aplic_s->size,
+                                 (msimode) ? 0 : base_hartid,
+                                 (msimode) ? 0 : hart_count,
+                                 VIRT_IRQCHIP_NUM_SOURCES,
+                                 num_prio_bits,
+                                 msimode, false, aplic_m_dev);
+
+    if (kvm_enabled() && msimode) {
+        riscv_aplic_set_kvm_msicfgaddr(RISCV_APLIC(aplic_s_dev), addr);
+    }
+
+    return kvm_enabled() ? aplic_s_dev : aplic_m_dev;
+}
diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 6b06d9aa87..02ab460e58 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -42,6 +42,8 @@
 #include "system/kvm.h"
 #include "system/reset.h"
 
+#include "aia.h"
+
 #define ACPI_BUILD_TABLE_SIZE             0x20000
 #define ACPI_BUILD_INTC_ID(socket, index) ((socket << 24) | (index))
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index efdb992cb8..b76bbb62f8 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -61,6 +61,8 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/uefi/var-service-api.h"
 
+#include "aia.h"
+
 /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QEMU. */
 static bool virt_use_kvm_aia_aplic_imsic(RISCVVirtAIAType aia_type)
 {
@@ -371,17 +373,6 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
     }
 }
 
-uint32_t imsic_num_bits(uint32_t count)
-{
-    uint32_t ret = 0;
-
-    while (BIT(ret) < count) {
-        ret++;
-    }
-
-    return ret;
-}
-
 static void create_fdt_one_imsic(RISCVVirtState *s, hwaddr base_addr,
                                  uint32_t *intc_phandles, uint32_t msi_phandle,
                                  bool m_mode, uint32_t imsic_guest_bits)
@@ -1146,68 +1137,6 @@ static DeviceState *virt_create_plic(const MemMapEntry *memmap, int socket,
              memmap[VIRT_PLIC].size);
 }
 
-static DeviceState *virt_create_aia(RISCVVirtAIAType aia_type, int aia_guests,
-                                    const MemMapEntry *memmap, int socket,
-                                    int base_hartid, int hart_count)
-{
-    int i;
-    hwaddr addr = 0;
-    uint32_t guest_bits;
-    DeviceState *aplic_s = NULL;
-    DeviceState *aplic_m = NULL;
-    bool msimode = aia_type == VIRT_AIA_TYPE_APLIC_IMSIC;
-
-    if (msimode) {
-        if (!kvm_enabled()) {
-            /* Per-socket M-level IMSICs */
-            addr = memmap[VIRT_IMSIC_M].base +
-                   socket * VIRT_IMSIC_GROUP_MAX_SIZE;
-            for (i = 0; i < hart_count; i++) {
-                riscv_imsic_create(addr + i * IMSIC_HART_SIZE(0),
-                                   base_hartid + i, true, 1,
-                                   VIRT_IRQCHIP_NUM_MSIS);
-            }
-        }
-
-        /* Per-socket S-level IMSICs */
-        guest_bits = imsic_num_bits(aia_guests + 1);
-        addr = memmap[VIRT_IMSIC_S].base + socket * VIRT_IMSIC_GROUP_MAX_SIZE;
-        for (i = 0; i < hart_count; i++) {
-            riscv_imsic_create(addr + i * IMSIC_HART_SIZE(guest_bits),
-                               base_hartid + i, false, 1 + aia_guests,
-                               VIRT_IRQCHIP_NUM_MSIS);
-        }
-    }
-
-    if (!kvm_enabled()) {
-        /* Per-socket M-level APLIC */
-        aplic_m = riscv_aplic_create(memmap[VIRT_APLIC_M].base +
-                                     socket * memmap[VIRT_APLIC_M].size,
-                                     memmap[VIRT_APLIC_M].size,
-                                     (msimode) ? 0 : base_hartid,
-                                     (msimode) ? 0 : hart_count,
-                                     VIRT_IRQCHIP_NUM_SOURCES,
-                                     VIRT_IRQCHIP_NUM_PRIO_BITS,
-                                     msimode, true, NULL);
-    }
-
-    /* Per-socket S-level APLIC */
-    aplic_s = riscv_aplic_create(memmap[VIRT_APLIC_S].base +
-                                 socket * memmap[VIRT_APLIC_S].size,
-                                 memmap[VIRT_APLIC_S].size,
-                                 (msimode) ? 0 : base_hartid,
-                                 (msimode) ? 0 : hart_count,
-                                 VIRT_IRQCHIP_NUM_SOURCES,
-                                 VIRT_IRQCHIP_NUM_PRIO_BITS,
-                                 msimode, false, aplic_m);
-
-    if (kvm_enabled() && msimode) {
-        riscv_aplic_set_kvm_msicfgaddr(RISCV_APLIC(aplic_s), addr);
-    }
-
-    return kvm_enabled() ? aplic_s : aplic_m;
-}
-
 static void create_platform_bus(RISCVVirtState *s, DeviceState *irqchip)
 {
     DeviceState *dev;
@@ -1470,9 +1399,15 @@ static void virt_machine_init(MachineState *machine)
             s->irqchip[i] = virt_create_plic(s->memmap, i,
                                              base_hartid, hart_count);
         } else {
-            s->irqchip[i] = virt_create_aia(s->aia_type, s->aia_guests,
-                                            s->memmap, i, base_hartid,
-                                            hart_count);
+            s->irqchip[i] = riscv_create_aia(s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC,
+                                             s->aia_guests,
+                                             &s->memmap[VIRT_APLIC_M],
+                                             &s->memmap[VIRT_APLIC_S],
+                                             &s->memmap[VIRT_IMSIC_M],
+                                             &s->memmap[VIRT_IMSIC_S],
+                                             i, base_hartid, hart_count,
+                                             VIRT_IRQCHIP_NUM_MSIS,
+                                             VIRT_IRQCHIP_NUM_PRIO_BITS);
         }
 
         /* Try to use different IRQCHIP instance based device type */
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index b70a054579..798477b788 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -1,4 +1,5 @@
 riscv_ss = ss.source_set()
+riscv_ss.add(files('aia.c'))
 riscv_ss.add(files('boot.c'))
 riscv_ss.add(files('fdt-common.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
-- 
2.54.0


