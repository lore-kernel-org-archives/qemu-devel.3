Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A03D1A627
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 13:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veCbA-0004kA-4D; Fri, 09 Jan 2026 08:32:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1veCb5-0004Xv-42
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 08:32:11 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1veCb1-0002BN-0d
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 08:32:10 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2a0d06ffa2aso32054865ad.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 05:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767965524; x=1768570324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J69jVrVN8QHRP16XQEeaeDfscj8/udVi7hg1VnCnrDw=;
 b=E8opknuxEzuLUT43pU/r3Qq3tSxKfMY4zgwm/IQ5nHx3p9NXapB/ww4wiBowT+XiGk
 qE7LCB6sBo/woeBzD3fgu5Wsn4ZBPEPTmo0rHvRmE5ld5AxIieDtdguQAr1herJAIstt
 xKyav0VDSRmqQn21hMcKrpBZzCvlvUHYKVGSTZ4RD8ZJtWBSUMOjsPLhIs5quM4TqEYu
 MfpALETkqUfld84ek7SyRoEAkwnMlAuAmZE53edzRI0ZJsFrudNybjw9Fseyt02ZiU9+
 pzXZ1cFc2pJBCDJZdVgRf8ifTVDnmAjIL2Af/Uvrm0i0cRldaSZ7aLwZJpx/j5lKEcbV
 qpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767965524; x=1768570324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J69jVrVN8QHRP16XQEeaeDfscj8/udVi7hg1VnCnrDw=;
 b=XcokyGlScoquB/V50kChO31FEwy+m5QzJIO+8OYFpMPfkaaG9JIJA1wLBkl0S3MiFg
 dR5Tof7YQwhNRw/miQyTgSLDa95ogwjLK+doksAvV+6FIRLm140zHwRcFu872gWm6Lqy
 IhKKpI+wv4UXBeoGeowRN6DdSm/1S+g1IjDHp3Pb+VUj8iMDbaGaNPTEvhQA3oLrKJxD
 BNPlUxnE0cqUyiajawe6psmCZIqL5zZvGpW3VMCVuX7wFgFYZhnkYfePDYGsHdCv+epZ
 yvUxTjsFwLwUX5CV1TkiPjwDK2WuCZyfhxbBg2ozmylOq1zywwWVogMxTkpVLWcY4gzr
 KuFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWst7MiHKnRrc3MciEgpewGzZ+qBVsX4j9QENM8S3tOstL9P/lIH3LtQqkXAdVboI//GTtC8dTY+0E8@nongnu.org
X-Gm-Message-State: AOJu0Ywq7BSH0f8Qc+VmHo7bu0KNwtNzFt3WAMFWIzk8kqjBoSvqlpkG
 1IEnzKLOSONa4ZyUFvAL0vEwScIiKapidTGV8T52F7E14ZoFCMySiUQf
X-Gm-Gg: AY/fxX7wxeRb8EY8Ls4RIxbRBpZjv3DrF+w0ScVT3WCq7MYD0vIwVFJo2m+PoW5GAzO
 F1GzL5xVYwlAf2Hmjqu4HfLnQsjEENNAc8PUPIPF1KyGhJ6A5iqqPyOqrNKpOgXg61ZKn+t2gfn
 p2iZCDO3ivEcnqLN5VyYaJZKibXwsSr5M3+GTtPoJz7tLFgjBPUc1NE/OUSCqGQkwWY2avjaVC1
 vMInw1Cda++R585mngRT37KTQkqWYH+EbElT4a4mXvtXwzFPGuSaOjHNity3BPWnaAsx7C7rm1T
 N1Ba2+IrPv9K0/plJnOC0luPjfvtQo/ZedTTAmfDQ1l592P5RAKu8ggLZfsVFYg91cEgtFlQV7L
 tipJaSz37vymMDVMOcJ6Zztmr4+45fBPdw3XYeUznAXzl1uQllKUTThyKAq4oehGP8StgFbxBcM
 zBFeWZrX++TuXpYyLoRoQm
X-Google-Smtp-Source: AGHT+IG8Uhe2sqSHO+lh5VjRODHRWZTRbYqCPlwvK7mElvXpgQ9fb7Ww/Ehes6YrBnDRfw55V6exDw==
X-Received: by 2002:a17:902:cece:b0:298:2afa:796d with SMTP id
 d9443c01a7336-2a3ee4c432bmr101768145ad.61.1767965524153; 
 Fri, 09 Jan 2026 05:32:04 -0800 (PST)
Received: from donnager-debian.. ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c491e7sm107755535ad.38.2026.01.09.05.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 05:32:03 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: [PATCH 1/2] hw/riscv/virt: Move AIA initialisation to helper file
Date: Sat, 10 Jan 2026 00:01:22 +1030
Message-ID: <20260109133125.397364-2-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109133125.397364-1-joel@jms.id.au>
References: <20260109133125.397364-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

The AIA init will be used by any server class riscv machine. Separate it
out in order to share code with such systems.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/aia.h             | 58 +++++++++++++++++++++++++
 include/hw/riscv/virt.h    | 29 -------------
 hw/riscv/aia.c             | 88 ++++++++++++++++++++++++++++++++++++++
 hw/riscv/virt-acpi-build.c |  2 +
 hw/riscv/virt.c            | 85 ++++--------------------------------
 hw/riscv/meson.build       |  2 +-
 6 files changed, 158 insertions(+), 106 deletions(-)
 create mode 100644 hw/riscv/aia.h
 create mode 100644 hw/riscv/aia.c

diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
new file mode 100644
index 000000000000..50c48ea4d79c
--- /dev/null
+++ b/hw/riscv/aia.h
@@ -0,0 +1,58 @@
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
+/*
+ * The virt machine physical address space used by some of the devices
+ * namely ACLINT, PLIC, APLIC, and IMSIC depend on number of Sockets,
+ * number of CPUs, and number of IMSIC guest files.
+ *
+ * Various limits defined by VIRT_SOCKETS_MAX_BITS, VIRT_CPUS_MAX_BITS,
+ * and VIRT_IRQCHIP_MAX_GUESTS_BITS are tuned for maximum utilization
+ * of virt machine physical address space.
+ */
+
+#define VIRT_SOCKETS_MAX_BITS          2
+#define VIRT_CPUS_MAX_BITS             9
+#define VIRT_CPUS_MAX                  (1 << VIRT_CPUS_MAX_BITS)
+#define VIRT_SOCKETS_MAX               (1 << VIRT_SOCKETS_MAX_BITS)
+
+#define VIRT_IRQCHIP_NUM_MSIS 255
+#define VIRT_IRQCHIP_NUM_SOURCES 96
+#define VIRT_IRQCHIP_NUM_PRIO_BITS 3
+#define VIRT_IRQCHIP_MAX_GUESTS_BITS 3
+#define VIRT_IRQCHIP_MAX_GUESTS ((1U << VIRT_IRQCHIP_MAX_GUESTS_BITS) - 1U)
+
+
+#define VIRT_IMSIC_GROUP_MAX_SIZE      (1U << IMSIC_MMIO_GROUP_MIN_SHIFT)
+#if VIRT_IMSIC_GROUP_MAX_SIZE < \
+    IMSIC_GROUP_SIZE(VIRT_CPUS_MAX_BITS, VIRT_IRQCHIP_MAX_GUESTS_BITS)
+#error "Can't accommodate single IMSIC group in address space"
+#endif
+
+#define VIRT_IMSIC_MAX_SIZE            (VIRT_SOCKETS_MAX * \
+                                        VIRT_IMSIC_GROUP_MAX_SIZE)
+#if 0x4000000 < VIRT_IMSIC_MAX_SIZE
+#error "Can't accommodate all IMSIC groups in address space"
+#endif
+
+uint32_t imsic_num_bits(uint32_t count);
+
+DeviceState *riscv_create_aia(bool msimode, int aia_guests,
+                             const MemMapEntry *aplic_m,
+                             const MemMapEntry *aplic_s,
+                             const MemMapEntry *imsic_m,
+                             const MemMapEntry *imsic_s,
+                             int socket, int base_hartid, int hart_count);
+
+
+#endif
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 18a2a323a344..25ec5c665780 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -102,12 +102,6 @@ enum {
 
 #define VIRT_PLATFORM_BUS_NUM_IRQS 32
 
-#define VIRT_IRQCHIP_NUM_MSIS 255
-#define VIRT_IRQCHIP_NUM_SOURCES 96
-#define VIRT_IRQCHIP_NUM_PRIO_BITS 3
-#define VIRT_IRQCHIP_MAX_GUESTS_BITS 3
-#define VIRT_IRQCHIP_MAX_GUESTS ((1U << VIRT_IRQCHIP_MAX_GUESTS_BITS) - 1U)
-
 #define VIRT_PLIC_PRIORITY_BASE 0x00
 #define VIRT_PLIC_PENDING_BASE 0x1000
 #define VIRT_PLIC_ENABLE_BASE 0x2000
@@ -135,28 +129,5 @@ enum {
 bool virt_is_acpi_enabled(RISCVVirtState *s);
 bool virt_is_iommu_sys_enabled(RISCVVirtState *s);
 void virt_acpi_setup(RISCVVirtState *vms);
-uint32_t imsic_num_bits(uint32_t count);
-
-/*
- * The virt machine physical address space used by some of the devices
- * namely ACLINT, PLIC, APLIC, and IMSIC depend on number of Sockets,
- * number of CPUs, and number of IMSIC guest files.
- *
- * Various limits defined by VIRT_SOCKETS_MAX_BITS, VIRT_CPUS_MAX_BITS,
- * and VIRT_IRQCHIP_MAX_GUESTS_BITS are tuned for maximum utilization
- * of virt machine physical address space.
- */
-
-#define VIRT_IMSIC_GROUP_MAX_SIZE      (1U << IMSIC_MMIO_GROUP_MIN_SHIFT)
-#if VIRT_IMSIC_GROUP_MAX_SIZE < \
-    IMSIC_GROUP_SIZE(VIRT_CPUS_MAX_BITS, VIRT_IRQCHIP_MAX_GUESTS_BITS)
-#error "Can't accommodate single IMSIC group in address space"
-#endif
-
-#define VIRT_IMSIC_MAX_SIZE            (VIRT_SOCKETS_MAX * \
-                                        VIRT_IMSIC_GROUP_MAX_SIZE)
-#if 0x4000000 < VIRT_IMSIC_MAX_SIZE
-#error "Can't accommodate all IMSIC groups in address space"
-#endif
 
 #endif
diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
new file mode 100644
index 000000000000..0a89d7b49b7b
--- /dev/null
+++ b/hw/riscv/aia.c
@@ -0,0 +1,88 @@
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
+                             int socket, int base_hartid, int hart_count)
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
+            addr = imsic_m->base + socket * VIRT_IMSIC_GROUP_MAX_SIZE;
+            for (i = 0; i < hart_count; i++) {
+                riscv_imsic_create(addr + i * IMSIC_HART_SIZE(0),
+                                   base_hartid + i, true, 1,
+                                   VIRT_IRQCHIP_NUM_MSIS);
+            }
+        }
+
+        /* Per-socket S-level IMSICs */
+        guest_bits = imsic_num_bits(aia_guests + 1);
+        addr = imsic_s->base + socket * VIRT_IMSIC_GROUP_MAX_SIZE;
+        for (i = 0; i < hart_count; i++) {
+            riscv_imsic_create(addr + i * IMSIC_HART_SIZE(guest_bits),
+                               base_hartid + i, false, 1 + aia_guests,
+                               VIRT_IRQCHIP_NUM_MSIS);
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
+                                     VIRT_IRQCHIP_NUM_PRIO_BITS,
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
+                                 VIRT_IRQCHIP_NUM_PRIO_BITS,
+                                 msimode, false, aplic_m_dev);
+
+    if (kvm_enabled() && msimode) {
+        riscv_aplic_set_kvm_msicfgaddr(RISCV_APLIC(aplic_s_dev), addr);
+    }
+
+    return kvm_enabled() ? aplic_s_dev : aplic_m_dev;
+}
diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index f1406cb68339..b091a9df9e0f 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -40,6 +40,8 @@
 #include "qemu/error-report.h"
 #include "system/reset.h"
 
+#include "aia.h"
+
 #define ACPI_BUILD_TABLE_SIZE             0x20000
 #define ACPI_BUILD_INTC_ID(socket, index) ((socket << 24) | (index))
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index bd8608ea5bfd..01115a0fb946 100644
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
@@ -1302,68 +1293,6 @@ static DeviceState *virt_create_plic(const MemMapEntry *memmap, int socket,
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
@@ -1625,9 +1554,13 @@ static void virt_machine_init(MachineState *machine)
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
+                                             i, base_hartid, hart_count);
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


