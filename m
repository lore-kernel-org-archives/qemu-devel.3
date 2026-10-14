Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DECCC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 12:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGyW5-0006oE-2w; Wed, 14 Oct 2026 08:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xGu6R-0006Lc-Uq; Wed, 14 Oct 2026 04:12:47 -0400
Received: from mxct.zte.com.cn ([183.62.165.209])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xGu6P-0000ye-GX; Wed, 14 Oct 2026 04:12:47 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4j4P855Xz4z59tmT;
 Wed, 14 Oct 2026 16:12:37 +0800 (CST)
Received: (from root@localhost) by mse-fl2.zte.com.cn id 69E8CcV4002763;
 Wed, 14 Oct 2026 16:12:38 +0800 (+08)
 (envelope-from gong.shuai@sanechips.com.cn)
Message-Id: <202610140812.69E8CcV4002763@mse-fl2.zte.com.cn>
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
 by mse-fl1.zte.com.cn with SMTP id 69E80Klt093682;
 Wed, 14 Oct 2026 16:00:20 +0800 (+08)
 (envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
 by smtp (Zmail) with SMTP; Wed, 14 Oct 2026 16:00:22 +0800
X-Zmail-TransId: 3e816acf3696024-0e266
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
 Gong Shuai <gong.shuai@sanechips.com.cn>, Gong Shuai <gsh517025@gmail.com>
Subject: [RFC PATCH 06/14] hw/riscv/riscv-iommu-accel: Introduce RISC-V IOMMU
 accel device
Date: Wed, 14 Oct 2026 15:59:57 +0800
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014080005.548066-1-gong.shuai@sanechips.com.cn>
References: <20261014080005.548066-1-gong.shuai@sanechips.com.cn>
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl2.zte.com.cn 69E8CcV4002763
X-MSS: AUDITRELEASE@mse-fl2.zte.com.cn
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 14 Oct 2026 16:12:37 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6ACF3975.000/4j4P855Xz4z59tmT
Received-SPF: pass client-ip=183.62.165.209;
 envelope-from=gong.shuai@sanechips.com.cn; helo=mxct.zte.com.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 14 Oct 2026 08:54:59 -0400
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
index 311f1c3cc2..68305e7686 100644
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
index 7aa3c1578d..10cdcc05fa 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -16,6 +16,7 @@ riscv_ss.add(when: 'CONFIG_TENSTORRENT', if_true: files('tt_atlantis.c'))
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
index 19d4cfa503..bdbb4aece1 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -31,6 +31,7 @@
 
 #include "cpu_bits.h"
 #include "riscv-iommu.h"
+#include "riscv-iommu-accel.h"
 #include "riscv-iommu-bits.h"
 #include "riscv-iommu-hpm.h"
 #include "trace.h"
@@ -2699,6 +2700,10 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
 {
     RISCVIOMMUState *s = RISCV_IOMMU(dev);
 
+    if (s->accel) {
+        riscv_iommu_accel_init(s);
+    }
+
     /* Report QEMU target physical address space limits. */
     s->cap = set_field(s->cap, RISCV_IOMMU_CAP_PAS, s->pas_bits);
 
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 84437d8771..0d8613a8b1 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -110,6 +110,9 @@ struct RISCVIOMMUState {
     uint8_t hpm_cntrs;
 
     const PCIIOMMUOps *iommu_ops;
+
+    /* nested iommu support */
+    bool accel;
 };
 
 void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
-- 
2.53.0


