Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0099CC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 12:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGyVq-0006hI-EN; Wed, 14 Oct 2026 08:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xGu5n-0006Fs-Gw; Wed, 14 Oct 2026 04:12:07 -0400
Received: from mxhk.zte.com.cn ([160.30.148.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xGu5l-0000uW-WC; Wed, 14 Oct 2026 04:12:07 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4j4P7R04JFz8R03f;
 Wed, 14 Oct 2026 16:12:03 +0800 (CST)
Received: (from root@localhost) by mse-fl2.zte.com.cn id 69E8C07q099096;
 Wed, 14 Oct 2026 16:12:00 +0800 (+08)
 (envelope-from gong.shuai@sanechips.com.cn)
Message-Id: <202610140812.69E8C07q099096@mse-fl2.zte.com.cn>
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
 by mse-fl2.zte.com.cn with SMTP id 69E80ImO079396;
 Wed, 14 Oct 2026 16:00:18 +0800 (+08)
 (envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
 by smtp (Zmail) with SMTP; Wed, 14 Oct 2026 16:00:20 +0800
X-Zmail-TransId: 3e816acf3694024-0e228
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
Subject: [RFC PATCH 03/14] hw/riscv/riscv-iommu: Allow PCI IOMMU ops to be
 overridden
Date: Wed, 14 Oct 2026 15:59:54 +0800
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014080005.548066-1-gong.shuai@sanechips.com.cn>
References: <20261014080005.548066-1-gong.shuai@sanechips.com.cn>
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl2.zte.com.cn 69E8C07q099096
X-MSS: AUDITRELEASE@mse-fl2.zte.com.cn
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 14 Oct 2026 16:12:03 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6ACF3953.000/4j4P7R04JFz8R03f
Received-SPF: pass client-ip=160.30.148.35;
 envelope-from=gong.shuai@sanechips.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 14 Oct 2026 08:54:57 -0400
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

Add an iommu_ops field to RISCVIOMMUState and use it when
registering the IOMMU on a PCI bus, falling back to the default
riscv_iommu_ops when unset. This lets callers install custom PCI
IOMMU ops without changing existing behaviour.

Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
---
 hw/riscv/riscv-iommu.c | 5 ++++-
 hw/riscv/riscv-iommu.h | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 323a041b4a..2887336456 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2995,7 +2995,10 @@ void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
         RISCVIOMMUState *last = (RISCVIOMMUState *)bus->iommu_opaque;
         QLIST_INSERT_AFTER(last, iommu, iommus);
     } else if (!bus->iommu_ops && !bus->iommu_opaque) {
-        pci_setup_iommu(bus, &riscv_iommu_ops, iommu);
+        if (!iommu->iommu_ops) {
+            iommu->iommu_ops = &riscv_iommu_ops;
+        }
+        pci_setup_iommu(bus, iommu->iommu_ops, iommu);
     } else {
         error_setg(errp, "can't register secondary IOMMU for PCI bus #%d",
             pci_bus_num(bus));
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 7c470ba084..68e1cdd82d 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -24,6 +24,7 @@
 #include "system/dma.h"
 #include "hw/riscv/iommu.h"
 #include "hw/riscv/riscv-iommu-bits.h"
+#include "hw/pci/pci.h"
 
 typedef enum riscv_iommu_igs_modes riscv_iommu_igs_mode;
 
@@ -96,6 +97,8 @@ struct RISCVIOMMUState {
     /* HPM event counters */
     GHashTable *hpm_event_ctr_map; /* Mapping of events to counters */
     uint8_t hpm_cntrs;
+
+    const PCIIOMMUOps *iommu_ops;
 };
 
 void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
-- 
2.53.0


