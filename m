Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF99C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 10:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTIhf-0003Ro-Dy; Mon, 15 Jul 2024 06:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1sTIhZ-0003AG-Uc; Mon, 15 Jul 2024 06:13:02 -0400
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1sTIhT-00037M-Pe; Mon, 15 Jul 2024 06:13:01 -0400
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 46FACYOn080322
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Mon, 15 Jul 2024 18:12:34 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from atcpcw16.andestech.com (10.0.1.106) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 18:12:36 +0800
To: <qemu-devel@nongnu.org>
CC: <richard.henderson@linaro.org>, <pbonzini@redhat.com>, <peterx@redhat.com>,
 <david@redhat.com>, <philmd@linaro.org>, <palmer@dabbelt.com>,
 <alistair.francis@wdc.com>, <bmeng.cn@gmail.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <qemu-riscv@nongnu.org>, Ethan Chen
 <ethan84@andestech.com>
Subject: [PATCH v8 5/8] hw/misc/riscv_iopmp: Add API to set up IOPMP
 protection for system memory
Date: Mon, 15 Jul 2024 18:12:28 +0800
Message-ID: <20240715101228.1247759-1-ethan84@andestech.com>
X-Mailer: git-send-email 2.42.0.345.gaab89be2eb.dirty
In-Reply-To: <20240715095702.1222213-1-ethan84@andestech.com>
References: <20240715095702.1222213-1-ethan84@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.1.106]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 46FACYOn080322
Received-SPF: pass client-ip=60.248.80.70; envelope-from=ethan84@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
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
Reply-to:  Ethan Chen <ethan84@andestech.com>
From:  Ethan Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

To enable system memory transactions through the IOPMP, memory regions must
be moved to the IOPMP downstream and then replaced with IOMMUs for IOPMP
translation.

The iopmp_setup_system_memory() function copies subregions of system memory
to create the IOPMP downstream and then replaces the specified memory
regions in system memory with the IOMMU regions of the IOPMP. It also
adds entries to a protection map that records the relationship between
physical address regions and the IOPMP, which is used by the IOPMP DMA
API to send transaction information.

Signed-off-by: Ethan Chen <ethan84@andestech.com>
---
 hw/misc/riscv_iopmp.c         | 61 +++++++++++++++++++++++++++++++++++
 include/hw/misc/riscv_iopmp.h |  3 ++
 2 files changed, 64 insertions(+)

diff --git a/hw/misc/riscv_iopmp.c b/hw/misc/riscv_iopmp.c
index db43e3c73f..e62ac57437 100644
--- a/hw/misc/riscv_iopmp.c
+++ b/hw/misc/riscv_iopmp.c
@@ -1151,4 +1151,65 @@ iopmp_register_types(void)
     type_register_static(&iopmp_iommu_memory_region_info);
 }
 
+/*
+ * Copies subregions from the source memory region to the destination memory
+ * region
+ */
+static void copy_memory_subregions(MemoryRegion *src_mr, MemoryRegion *dst_mr)
+{
+    int32_t priority;
+    hwaddr addr;
+    MemoryRegion *alias, *subregion;
+    QTAILQ_FOREACH(subregion, &src_mr->subregions, subregions_link) {
+        priority = subregion->priority;
+        addr = subregion->addr;
+        alias = g_malloc0(sizeof(MemoryRegion));
+        memory_region_init_alias(alias, NULL, subregion->name, subregion, 0,
+                                 memory_region_size(subregion));
+        memory_region_add_subregion_overlap(dst_mr, addr, alias, priority);
+    }
+}
+
+/*
+ * Create downstream of system memory for IOPMP, and overlap memory region
+ * specified in memmap with IOPMP translator. Make sure subregions are added to
+ * system memory before call this function. It also add entry to
+ * iopmp_protection_memmaps for recording the relationship between physical
+ * address regions and IOPMP.
+ */
+void iopmp_setup_system_memory(DeviceState *dev, const MemMapEntry *memmap,
+                               uint32_t map_entry_num)
+{
+    IopmpState *s = IOPMP(dev);
+    uint32_t i;
+    MemoryRegion *iommu_alias;
+    MemoryRegion *target_mr = get_system_memory();
+    MemoryRegion *downstream = g_malloc0(sizeof(MemoryRegion));
+    memory_region_init(downstream, NULL, "iopmp_downstream",
+                       memory_region_size(target_mr));
+    /* Copy subregions of target to downstream */
+    copy_memory_subregions(target_mr, downstream);
+
+    iopmp_protection_memmap *map;
+    for (i = 0; i < map_entry_num; i++) {
+        /* Memory access to protected regions of target are through IOPMP */
+        iommu_alias = g_new(MemoryRegion, 1);
+        memory_region_init_alias(iommu_alias, NULL, "iommu_alias",
+                                 MEMORY_REGION(&s->iommu), memmap[i].base,
+                                 memmap[i].size);
+        memory_region_add_subregion_overlap(target_mr, memmap[i].base,
+                                            iommu_alias, 1);
+        /* Record which IOPMP is responsible for the region */
+        map = g_new0(iopmp_protection_memmap, 1);
+        map->iopmp_s = s;
+        map->entry.base = memmap[i].base;
+        map->entry.size = memmap[i].size;
+        QLIST_INSERT_HEAD(&iopmp_protection_memmaps, map, list);
+    }
+    s->downstream = downstream;
+    address_space_init(&s->downstream_as, s->downstream,
+                       "iopmp-downstream-as");
+}
+
+
 type_init(iopmp_register_types);
diff --git a/include/hw/misc/riscv_iopmp.h b/include/hw/misc/riscv_iopmp.h
index b8fe479108..ebe9c4bc4a 100644
--- a/include/hw/misc/riscv_iopmp.h
+++ b/include/hw/misc/riscv_iopmp.h
@@ -165,4 +165,7 @@ typedef struct IopmpState {
     uint32_t fabricated_v;
 } IopmpState;
 
+void iopmp_setup_system_memory(DeviceState *dev, const MemMapEntry *memmap,
+                               uint32_t mapentry_num);
+
 #endif
-- 
2.34.1


