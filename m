Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981A0606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 05:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMJ06-00076d-Fc; Thu, 29 Oct 2026 01:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xMIzk-00072W-9u; Thu, 29 Oct 2026 01:48:12 -0400
Received: from mxhk.zte.com.cn ([160.30.148.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xMIzg-0000dP-IA; Thu, 29 Oct 2026 01:48:12 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jFYDJ5lhJz5PkGt;
 Thu, 29 Oct 2026 13:48:00 +0800 (CST)
Received: from szxl2zmapp05.zte.com.cn ([10.1.32.37])
 by mse-fl1.zte.com.cn with SMTP id 69T5ls6N079238;
 Thu, 29 Oct 2026 13:47:54 +0800 (+08)
 (envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
 by smtp (Zmail) with SMTP; Thu, 29 Oct 2026 13:47:56 +0800
X-Zmail-TransId: 3e816ae2de0b027-e636d
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: gong.shuai@sanechips.com.cn
From: Gong Shuai <gong.shuai@sanechips.com.cn>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Wu Fei <wu.fei9@sanechips.com.cn>,
 Qingye Zhao <zhao.qingye@sanechips.com.cn>,
 Gong Shuai <gong.shuai@sanechips.com.cn>, Gong Shuai <gsh517025@gmail.com>
Subject: [RFC PATCH v2 06/14] hw/riscv/riscv-iommu-accel: Introduce RISC-V
 IOMMU accel device
Date: Thu, 29 Oct 2026 13:47:43 +0800
Message-ID: <20261029054751.563493-7-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029054751.563493-1-gong.shuai@sanechips.com.cn>
References: <20261029054751.563493-1-gong.shuai@sanechips.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl1.zte.com.cn 69T5ls6N079238
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 29 Oct 2026 13:48:00 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE2DE10.001/4jFYDJ5lhJz5PkGt
Received-SPF: pass client-ip=160.30.148.34;
 envelope-from=gong.shuai@sanechips.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wu Fei <wu.fei9@sanechips.com.cn>

Add an optional accel device for the RISC-V IOMMU. Its behaviour
matches the default path so far, leaving room for upcoming
accelerated (nested) translation. When the accel device is enabled,
each device's address space is embedded in RISCVIOMMUAccelDevice, a
per-device struct that will store per-device data for nested
translation.

Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
---
 hw/riscv/Kconfig             |  5 ++++
 hw/riscv/meson.build         |  1 +
 hw/riscv/riscv-iommu-accel.c | 49 ++++++++++++++++++++++++++++++++++++
 hw/riscv/riscv-iommu-accel.h | 25 ++++++++++++++++++
 hw/riscv/riscv-iommu.c       |  5 ++++
 hw/riscv/riscv-iommu.h       |  3 +++
 6 files changed, 88 insertions(+)
 create mode 100644 hw/riscv/riscv-iommu-accel.c
 create mode 100644 hw/riscv/riscv-iommu-accel.h

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index a423fafca1..bed2e713f3 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -1,5 +1,10 @@
+config RISCV_IOMMU_ACCEL
+    bool
+    depends on RISCV_IOMMU
+
 config RISCV_IOMMU
     bool
+    select RISCV_IOMMU_ACCEL if IOMMUFD
 
 config RISCV_NUMA
     bool
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 6bdabb9544..b1f3b3a2d2 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -17,6 +17,7 @@ riscv_ss.add(when: 'CONFIG_TENSTORRENT', if_true: files('tt_atlantis.c'))
 riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
 	'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv-iommu-hpm.c'))
+riscv_ss.add(when: 'CONFIG_RISCV_IOMMU_ACCEL', if_true: files('riscv-iommu-accel.c'))
 riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c'))
 riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan_kmh.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_MIPS_CPS', if_true: files('cps.c'))
diff --git a/hw/riscv/riscv-iommu-accel.c b/hw/riscv/riscv-iommu-accel.c
new file mode 100644
index 0000000000..41e4d03be6
--- /dev/null
+++ b/hw/riscv/riscv-iommu-accel.c
@@ -0,0 +1,49 @@
+/*
+ * RISC-V IOMMU - accelerated (nested) translation support
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "riscv-iommu.h"
+#include "riscv-iommu-accel.h"
+
+static RISCVIOMMUAccelDevice *riscv_iommu_accel_get_dev(RISCVIOMMUState *s,
+                                                        PCIBus *bus, int devfn)
+{
+    RISCVIOMMUSpace *as;
+    RISCVIOMMUAccelDevice *accel_dev;
+
+    /* FIXME: for simplicity, assume only one iommu right now */
+    as = riscv_iommu_get_space(s, bus, devfn);
+    if (as) {
+        return container_of(as, RISCVIOMMUAccelDevice, as);
+    }
+
+    accel_dev = g_new0(RISCVIOMMUAccelDevice, 1);
+    as = &accel_dev->as;
+    riscv_iommu_init_space(s, as, bus, devfn);
+
+    return accel_dev;
+}
+
+static AddressSpace *riscv_iommu_accel_find_as(PCIBus *bus, void *opaque,
+                                               int devfn)
+{
+    RISCVIOMMUState *s = (RISCVIOMMUState *) opaque;
+
+    RISCVIOMMUAccelDevice *accel_dev = riscv_iommu_accel_get_dev(s, bus, devfn);
+    RISCVIOMMUSpace *as = &accel_dev->as;
+
+    return &as->iova_as;
+}
+
+static const PCIIOMMUOps riscv_iommu_accel_ops = {
+    .get_address_space = riscv_iommu_accel_find_as,
+};
+
+void riscv_iommu_accel_init(RISCVIOMMUState *s)
+{
+    s->iommu_ops = &riscv_iommu_accel_ops;
+}
diff --git a/hw/riscv/riscv-iommu-accel.h b/hw/riscv/riscv-iommu-accel.h
new file mode 100644
index 0000000000..c69fea87dd
--- /dev/null
+++ b/hw/riscv/riscv-iommu-accel.h
@@ -0,0 +1,25 @@
+/*
+ * RISC-V IOMMU - accelerated (nested) translation support
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_RISCV_RISCV_IOMMU_ACCEL_H
+#define HW_RISCV_RISCV_IOMMU_ACCEL_H
+
+#include "hw/riscv/riscv-iommu.h"
+#include CONFIG_DEVICES
+
+typedef struct RISCVIOMMUAccelDevice {
+    RISCVIOMMUSpace as;
+} RISCVIOMMUAccelDevice;
+
+#ifdef CONFIG_RISCV_IOMMU_ACCEL
+void riscv_iommu_accel_init(RISCVIOMMUState *s);
+#else
+static inline void riscv_iommu_accel_init(RISCVIOMMUState *s)
+{
+}
+#endif
+
+#endif /* HW_RISCV_RISCV_IOMMU_ACCEL_H */
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 10f81f8bdf..762691c8ed 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -31,6 +31,7 @@
 
 #include "cpu_bits.h"
 #include "riscv-iommu.h"
+#include "riscv-iommu-accel.h"
 #include "riscv-iommu-bits.h"
 #include "riscv-iommu-hpm.h"
 #include "trace.h"
@@ -2707,6 +2708,10 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
 {
     RISCVIOMMUState *s = RISCV_IOMMU(dev);
 
+    if (s->accel) {
+        riscv_iommu_accel_init(s);
+    }
+
     /* Report QEMU target physical address space limits. */
     s->cap = set_field(s->cap, RISCV_IOMMU_CAP_PAS, s->pas_bits);
 
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 3e10647975..0bc096ba60 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -111,6 +111,9 @@ struct RISCVIOMMUState {
     uint8_t hpm_cntrs;
 
     const PCIIOMMUOps *iommu_ops;
+
+    /* nested iommu support */
+    bool accel;
 };
 
 void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
-- 
2.53.0


