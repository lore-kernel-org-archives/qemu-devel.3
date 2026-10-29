Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E378606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 05:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMIzt-00074Z-Tt; Thu, 29 Oct 2026 01:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xMIzk-00072V-9v; Thu, 29 Oct 2026 01:48:12 -0400
Received: from mxhk.zte.com.cn ([160.30.148.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xMIzg-0000dx-JX; Thu, 29 Oct 2026 01:48:11 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jFYDM4mC2z5PkH1;
 Thu, 29 Oct 2026 13:48:03 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
 by mse-fl2.zte.com.cn with SMTP id 69T5lt3i024154;
 Thu, 29 Oct 2026 13:47:55 +0800 (+08)
 (envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
 by smtp (Zmail) with SMTP; Thu, 29 Oct 2026 13:47:56 +0800
X-Zmail-TransId: 3e816ae2de0c027-e637f
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
Subject: [RFC PATCH v2 07/14] hw/riscv/riscv-iommu-accel: Initialize shared
 system address space
Date: Thu, 29 Oct 2026 13:47:44 +0800
Message-ID: <20261029054751.563493-8-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029054751.563493-1-gong.shuai@sanechips.com.cn>
References: <20261029054751.563493-1-gong.shuai@sanechips.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl2.zte.com.cn 69T5lt3i024154
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 29 Oct 2026 13:48:03 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE2DE13.002/4jFYDM4mC2z5PkH1
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

To support accelerated RISC-V IOMMU instances, introduce a shared
system-wide AddressSpace (shared_as_sysmem) that aliases the global
system memory. This shared AddressSpace will be used in a subsequent
patch for all vfio-pci devices behind all accelerated IOMMU instances
within a VM.

Sharing a single system AddressSpace ensures that all devices behind
accelerated IOMMUs use the same system address space pointer. This
allows VFIO/iommufd to reuse a single IOAS ID in
iommufd_cdev_attach(), enabling the Stage-2 page tables to be shared
within the VM rather than duplicated for each IOMMU instance.

This follows the approach of the ARM SMMUv3 accel device.

Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
---
 hw/riscv/riscv-iommu-accel.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/hw/riscv/riscv-iommu-accel.c b/hw/riscv/riscv-iommu-accel.c
index 41e4d03be6..a843cf9d01 100644
--- a/hw/riscv/riscv-iommu-accel.c
+++ b/hw/riscv/riscv-iommu-accel.c
@@ -9,6 +9,14 @@
 #include "riscv-iommu.h"
 #include "riscv-iommu-accel.h"
 
+/*
+ * The root region aliases the global system memory, and shared_as_sysmem
+ * provides a shared Address Space referencing it. This Address Space is used
+ * by all vfio-pci devices behind all accelerated IOMMU instances within a VM.
+ */
+static MemoryRegion root, sysmem;
+static AddressSpace *shared_as_sysmem;
+
 static RISCVIOMMUAccelDevice *riscv_iommu_accel_get_dev(RISCVIOMMUState *s,
                                                         PCIBus *bus, int devfn)
 {
@@ -43,7 +51,24 @@ static const PCIIOMMUOps riscv_iommu_accel_ops = {
     .get_address_space = riscv_iommu_accel_find_as,
 };
 
+static void riscv_iommu_accel_as_init(RISCVIOMMUState *s)
+{
+    if (shared_as_sysmem) {
+        return;
+    }
+
+    memory_region_init(&root, OBJECT(s), "root", UINT64_MAX);
+    memory_region_init_alias(&sysmem, OBJECT(s), "riscv-iommu-accel-sysmem",
+                             get_system_memory(), 0,
+                             memory_region_size(get_system_memory()));
+    memory_region_add_subregion(&root, 0, &sysmem);
+
+    shared_as_sysmem = g_new0(AddressSpace, 1);
+    address_space_init(shared_as_sysmem, &root, "riscv-iommu-accel-as-sysmem");
+}
+
 void riscv_iommu_accel_init(RISCVIOMMUState *s)
 {
     s->iommu_ops = &riscv_iommu_accel_ops;
+    riscv_iommu_accel_as_init(s);
 }
-- 
2.53.0


