Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A28C606A330
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 02:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTs7S-0000r3-5o; Wed, 18 Nov 2026 21:43:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xTs7O-0000pZ-IE; Wed, 18 Nov 2026 21:43:22 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xTs7K-0005eZ-QJ; Wed, 18 Nov 2026 21:43:22 -0500
Received: from k3-03 (unknown [159.226.43.8])
 by APP-01 (Coremail) with SMTP id qwCowAD3Hfg8Yv5qZFtAAQ--.232S5;
 Thu, 19 Nov 2026 10:43:12 +0800 (CST)
From: Tan Chi <tanchi25@mails.ucas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Tan Chi <tanchi25@mails.ucas.ac.cn>
Subject: [PATCH 3/3] hw/riscv: iommu-sys: Add migration support
Date: Thu, 19 Nov 2026 10:42:50 +0800
Message-ID: <20261119024251.280765-4-tanchi25@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119024251.280765-1-tanchi25@mails.ucas.ac.cn>
References: <20261119024251.280765-1-tanchi25@mails.ucas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAD3Hfg8Yv5qZFtAAQ--.232S5
X-Coremail-Antispam: 1UD129KBjvJXoW7WFW5Wry8Gw1fXw4fArW8JFb_yoW8tFWrpF
 s5urWayr1DGr1xAFnIvw1UCF48J3Z7Ww15Z393ua97uF4UtrWDJFs5Kay5ArWkGFZ7Ca4r
 Cr1rGr98Ar4Yvr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUmG14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
 x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
 8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWl
 nxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
 CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvj
 eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I
 1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s02
 6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
 I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
 6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
 0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
 JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbkhLUUUUUU==
X-CM-SenderInfo: pwdquxrlsvqzpdlo2hpxfd2hldfou0/
Received-SPF: pass client-ip=159.226.251.21;
 envelope-from=tanchi25@mails.ucas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add VMState support for the system-bus RISC-V IOMMU device.

Preserve the MSI-X configuration table and pending bit array,
which are maintained in separate buffers by the system-bus
wrapper. The common IOMMU registers and internal state are
migrated independently by the embedded IOMMU device.

Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
---
 hw/riscv/riscv-iommu-sys.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
index 258c171efd..6e4cea00a5 100644
--- a/hw/riscv/riscv-iommu-sys.c
+++ b/hw/riscv/riscv-iommu-sys.c
@@ -21,6 +21,7 @@
 #include "hw/pci/pci_bus.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/sysbus.h"
+#include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/host-utils.h"
@@ -242,6 +243,25 @@ DeviceState *riscv_create_iommu_sys(DeviceState *mmio_irqchip,
     return iommu_sys;
 }
 
+#define RISCV_IOMMU_SYSDEV_MSIX_TABLE_SIZE \
+    (RISCV_IOMMU_PCI_MSIX_VECTORS * PCI_MSIX_ENTRY_SIZE)
+
+#define RISCV_IOMMU_SYSDEV_MSIX_PBA_SIZE \
+    (QEMU_ALIGN_UP(RISCV_IOMMU_PCI_MSIX_VECTORS, 64) / 8)
+
+static const VMStateDescription vmstate_riscv_iommu_sys = {
+    .name = "riscv-iommu-sys",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BUFFER_POINTER_UNSAFE(msix_table, RISCVIOMMUStateSys, 0,
+                                      RISCV_IOMMU_SYSDEV_MSIX_TABLE_SIZE),
+        VMSTATE_BUFFER_POINTER_UNSAFE(msix_pba, RISCVIOMMUStateSys, 0,
+                                      RISCV_IOMMU_SYSDEV_MSIX_PBA_SIZE),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const Property riscv_iommu_sys_properties[] = {
     DEFINE_PROP_UINT64("addr", RISCVIOMMUStateSys, addr, 0),
     DEFINE_PROP_UINT32("base-irq", RISCVIOMMUStateSys, base_irq, 0),
@@ -267,6 +287,7 @@ static void riscv_iommu_sys_class_init(ObjectClass *klass, const void *data)
     rc->phases.hold = riscv_iommu_sys_reset_hold;
 
     dc->realize = riscv_iommu_sys_realize;
+    dc->vmsd = &vmstate_riscv_iommu_sys;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     device_class_set_props(dc, riscv_iommu_sys_properties);
 }
-- 
2.53.0


