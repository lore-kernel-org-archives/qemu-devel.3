Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2FAFF8860
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 13:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGcu8-00078p-UV; Sat, 25 Apr 2026 09:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wGctx-000773-GC
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 09:18:30 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wGctt-00006v-Gb
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 09:18:29 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-82735a41920so3560200b3a.2
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2026 06:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777123104; x=1777727904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FPFZawW7CBjQCqRdR52jBPq2AM2fVcdKfMBVBqWA1qE=;
 b=K/IV4zepdUGgVQ47Xxn4wDPLlvvVHOm+89wCX7iq3w/WIveXaHFFXXO+LeBP5TCzWs
 8xTOonW+hjUJG38KDTnZpg6k7SIy8BNe1dRE/sVaanBZGaQaEZ6MiQL2PT52Za29c1LW
 BIROfCsp5XBOr26zZcwXKsGHxWEpoZBe77MxEAlBXuP+1rHerVVV8e8jFZ47Dsne8oox
 38WNa5pZ2a7bT/3XMUBAsdpPHfTKcn6pCNjCaFy5cqb9uThtgbhsEKka8LmzBuUQtAyL
 yVkGFWknsd0WfvpUeGzOiOrcUXCxd1fWmOX5cXL6mUUWNA7qLaYl3fv8mM6VVIB5CO2Z
 3OSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777123104; x=1777727904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FPFZawW7CBjQCqRdR52jBPq2AM2fVcdKfMBVBqWA1qE=;
 b=ac6+pWPd5ppcA8w1ffcaB4i/QKvQ6fv1w0jUcMRfjSeBUKu3JXAkqYA0TUwBcW4JM1
 ilLr5TrGuBsPYybKjfehBXBimukE5nmRUltHw7bULz08R7AfQ9Ry2tgQ4qRv1o1RSU+y
 HCPio5rQWWpaW35viS+Sj/deMU0YzNRxpME4S/vHXgnkL9bkc3ufZlnbA9OKBGIp/yvR
 ilNRj34Ad3vQiIvoZZjHtg895l/FYfarQpScAh1BmUlzYaTr8n5PqTqAAlPxAveRabqR
 k+0hyNVx9MsjFc1LaDZDzFbULWH22KsamXuKJTych8624ft+C8yFef5FeiizJ9nIK2Xg
 F0wQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Z2xpuViP75SqY6hN7CAV2E1Axd3t3B2r6JxfGHXEhfJ6lAqCle8/ClWXX1+PnL+c1GBMVVMjUi24J@nongnu.org
X-Gm-Message-State: AOJu0YyH8bqR9WGo3oUcX6fhYD3o8ItTV3pBcf06SSaTVPus/kGcZJxY
 J4lgUSAiDBW8BNhx1rne7PQOwplyQzp+LU6eqEhGozU/x7wDyVOmDLdg
X-Gm-Gg: AeBDieuqleE7KFwMZ56fOfI3SrJU8b93ZU+DBTKuSzfR0xjDMh5aWujhV2iTGIMjbD2
 oPrJLbwAYqSfLywW6yW5j9xpgRurVpBvga/x4G5v105f6fF8NtDCwuf2+INt2DZKG+ILio8K+ug
 3Cg9xVuz/INaHyaZm4EqHgqt/QmJNxGKz8/KyRW/YE2ZyqOCzfjvqmmiJj2Gem/gMk+Ii0e5T86
 +pL442yyh6sJgIPG4QBw2XoBJLzc8NgZeN3dYRasZZGWtTsjluqzMDUAtBvF9av+c8rIqybglGh
 zG2nMI3G62bxnk5zBW+jgkI01/9uQEbXY9bLfnbZFzIEtIc2dkPQgvRaw5ZRTUsczMHnQFOENHe
 e8HMJe8ozpKC1i0ent0ldDnNj9RNSaOuuNwgF9M1bIvzS8mxBzzr6d8Lp53jQXcdy5S9XPgsJtw
 ff6gdmQn/MGdSknfn2f9fgYD+/O3YdOo4oMqv49b7kcdvjPeKfIsuMY6EVhwEJQ4y1MBKz8Zbyy
 oJYCBb3rcvqNJppHfEMzLSW4mu4Kc9b7WChJHxFIFw=
X-Received: by 2002:a05:6a00:bb84:b0:81f:be3c:9c9e with SMTP id
 d2e1a72fcca58-82f8c8d67d0mr37148389b3a.33.1777123103653; 
 Sat, 25 Apr 2026 06:18:23 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9f7735sm26898866b3a.21.2026.04.25.06.18.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 06:18:22 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Nutty Liu <nutty.liu@hotmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 05/13] hw/riscv/virt: Move AIA initialisation to helper file
Date: Sat, 25 Apr 2026 23:17:11 +1000
Message-ID: <20260425131721.932250-6-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260425131721.932250-1-joel@jms.id.au>
References: <20260425131721.932250-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The AIA init will be used by any server class riscv machine. Separate it
out in order to share code with such systems.

The virt machine keeps machine specific #defines such as
VIRT_IRQCHIP_NUM_MSIS, VIRT_IRQCHIP_NUM_PRIO_BITS.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v3:
 - Add r-b
 - Move fewer things out of virt machine into aia common code, as they
   are virt machine specific and not part of aia. Done as part of this
   movement patch to avoid moving them out only put them back in the
   next patch.
---
 hw/riscv/aia.h             | 26 +++++++++++
 include/hw/riscv/virt.h    |  1 -
 hw/riscv/aia.c             | 89 ++++++++++++++++++++++++++++++++++++++
 hw/riscv/virt-acpi-build.c |  2 +
 hw/riscv/virt.c            | 87 +++++--------------------------------
 hw/riscv/meson.build       |  2 +-
 6 files changed, 129 insertions(+), 78 deletions(-)
 create mode 100644 hw/riscv/aia.h
 create mode 100644 hw/riscv/aia.c

diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
new file mode 100644
index 000000000000..dbb833340276
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
index 18a2a323a344..ad858deb76ad 100644
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
index 000000000000..c724612a50a5
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
index fd6ca5dbc4ff..145f8d92ad69 100644
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
index 4501d5581b62..ce0fd6f50c4a 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -59,6 +59,8 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/uefi/var-service-api.h"
 
+#include "aia.h"
+
 /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QEMU. */
 static bool virt_use_kvm_aia_aplic_imsic(RISCVVirtAIAType aia_type)
 {
@@ -509,17 +511,6 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
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
@@ -1293,68 +1284,6 @@ static DeviceState *virt_create_plic(const MemMapEntry *memmap, int socket,
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
@@ -1617,9 +1546,15 @@ static void virt_machine_init(MachineState *machine)
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
index 533472e22aef..e53c180d0d10 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -1,5 +1,5 @@
 riscv_ss = ss.source_set()
-riscv_ss.add(files('boot.c'))
+riscv_ss.add(files('boot.c', 'aia.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
 riscv_ss.add(files('riscv_hart.c'))
 riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
-- 
2.47.3


