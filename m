Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB250C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 09:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHJrb-0001P6-Tn; Wed, 12 Jun 2024 05:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1sHJrZ-0001OL-CJ
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 05:01:49 -0400
Received: from 59-120-53-16.hinet-ip.hinet.net ([59.120.53.16]
 helo=mail.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1sHJrX-0006Rp-0g
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 05:01:49 -0400
Received: from atcpcw16.andestech.com (10.0.1.106) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 12 Jun
 2024 17:01:39 +0800
To: <qemu-devel@nongnu.org>
CC: <richard.henderson@linaro.org>, <pbonzini@redhat.com>,
 <peterx@redhat.com>, <david@redhat.com>, <philmd@linaro.org>, Ethan Chen
 <ethan84@andestech.com>
Subject: [RFC PATCH] memory: Introduce memory region fetch operation
Date: Wed, 12 Jun 2024 17:01:32 +0800
Message-ID: <20240612090132.3522566-1-ethan84@andestech.com>
X-Mailer: git-send-email 2.42.0.345.gaab89be2eb.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.1.106]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
Received-SPF: pass client-ip=59.120.53.16; envelope-from=ethan84@andestech.com;
 helo=mail.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, TVD_RCVD_IP=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Allow the memory region to have different behaviors for read and fetch
operations.

For example RISCV IOPMP will raise interrupt when cpu try to fetch a
non-excutable region.

If fetch operation of a memory region is not implemented, it still uses the
read operation for fetch.

Signed-off-by: Ethan Chen <ethan84@andestech.com>
---
 accel/tcg/cputlb.c    |   9 +++-
 include/exec/memory.h |  30 ++++++++++++
 system/memory.c       | 104 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 117b516739..edb3715017 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1942,8 +1942,13 @@ static uint64_t int_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
         this_size = 1 << this_mop;
         this_mop |= MO_BE;
 
-        r = memory_region_dispatch_read(mr, mr_offset, &val,
-                                        this_mop, full->attrs);
+        if (type == MMU_INST_FETCH) {
+            r = memory_region_dispatch_fetch(mr, mr_offset, &val,
+                                             this_mop, full->attrs);
+        } else {
+            r = memory_region_dispatch_read(mr, mr_offset, &val,
+                                            this_mop, full->attrs);
+        }
         if (unlikely(r != MEMTX_OK)) {
             io_failed(cpu, full, addr, this_size, type, mmu_idx, r, ra);
         }
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 1be58f694c..6d61ec443e 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -274,6 +274,13 @@ struct MemoryRegionOps {
                   uint64_t data,
                   unsigned size);
 
+    /* Fetch to the memory region. @addr is relative to @mr; @size is
+     * in bytes. */
+    uint64_t (*fetch)(void *opaque,
+                      hwaddr addr,
+                      unsigned size);
+
+
     MemTxResult (*read_with_attrs)(void *opaque,
                                    hwaddr addr,
                                    uint64_t *data,
@@ -284,6 +291,12 @@ struct MemoryRegionOps {
                                     uint64_t data,
                                     unsigned size,
                                     MemTxAttrs attrs);
+    MemTxResult (*fetch_with_attrs)(void *opaque,
+                                    hwaddr addr,
+                                    uint64_t *data,
+                                    unsigned size,
+                                    MemTxAttrs attrs);
+
 
     enum device_endian endianness;
     /* Guest-visible constraints: */
@@ -2672,6 +2685,23 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
                                          MemOp op,
                                          MemTxAttrs attrs);
 
+
+/**
+ * memory_region_dispatch_fetch: perform a fetch directly to the specified
+ * MemoryRegion.
+ *
+ * @mr: #MemoryRegion to access
+ * @addr: address within that region
+ * @pval: pointer to uint64_t which the data is written to
+ * @op: size, sign, and endianness of the memory operation
+ * @attrs: memory transaction attributes to use for the access
+ */
+MemTxResult memory_region_dispatch_fetch(MemoryRegion *mr,
+                                         hwaddr addr,
+                                         uint64_t *pval,
+                                         MemOp op,
+                                         MemTxAttrs attrs);
+
 /**
  * address_space_init: initializes an address space
  *
diff --git a/system/memory.c b/system/memory.c
index 74cd73ebc7..ecd3020b1c 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -477,6 +477,51 @@ static MemTxResult memory_region_read_with_attrs_accessor(MemoryRegion *mr,
     return r;
 }
 
+static MemTxResult memory_region_fetch_accessor(MemoryRegion *mr,
+                                                hwaddr addr,
+                                                uint64_t *value,
+                                                unsigned size,
+                                                signed shift,
+                                                uint64_t mask,
+                                                MemTxAttrs attrs)
+{
+    uint64_t tmp;
+
+    tmp = mr->ops->fetch(mr->opaque, addr, size);
+    if (mr->subpage) {
+        trace_memory_region_subpage_fetch(get_cpu_index(), mr, addr, tmp, size);
+    } else if (trace_event_get_state_backends(TRACE_MEMORY_REGION_OPS_FETCH)) {
+        hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
+        trace_memory_region_ops_fetch(get_cpu_index(), mr, abs_addr, tmp, size,
+                                     memory_region_name(mr));
+    }
+    memory_region_shift_read_access(value, shift, mask, tmp);
+    return MEMTX_OK;
+}
+
+static MemTxResult memory_region_fetch_with_attrs_accessor(MemoryRegion *mr,
+                                                          hwaddr addr,
+                                                          uint64_t *value,
+                                                          unsigned size,
+                                                          signed shift,
+                                                          uint64_t mask,
+                                                          MemTxAttrs attrs)
+{
+    uint64_t tmp = 0;
+    MemTxResult r;
+
+    r = mr->ops->fetch_with_attrs(mr->opaque, addr, &tmp, size, attrs);
+    if (mr->subpage) {
+        trace_memory_region_subpage_fetch(get_cpu_index(), mr, addr, tmp, size);
+    } else if (trace_event_get_state_backends(TRACE_MEMORY_REGION_OPS_FETCH)) {
+        hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
+        trace_memory_region_ops_fetch(get_cpu_index(), mr, abs_addr, tmp, size,
+                                      memory_region_name(mr));
+    }
+    memory_region_shift_read_access(value, shift, mask, tmp);
+    return r;
+}
+
 static MemTxResult memory_region_write_accessor(MemoryRegion *mr,
                                                 hwaddr addr,
                                                 uint64_t *value,
@@ -1461,6 +1506,65 @@ MemTxResult memory_region_dispatch_read(MemoryRegion *mr,
     return r;
 }
 
+static MemTxResult memory_region_dispatch_fetch1(MemoryRegion *mr,
+                                                hwaddr addr,
+                                                uint64_t *pval,
+                                                unsigned size,
+                                                MemTxAttrs attrs)
+{
+    *pval = 0;
+
+    if (mr->ops->fetch) {
+        return access_with_adjusted_size(addr, pval, size,
+                                         mr->ops->impl.min_access_size,
+                                         mr->ops->impl.max_access_size,
+                                         memory_region_fetch_accessor,
+                                         mr, attrs);
+    } else if (mr->ops->fetch_with_attrs) {
+        return access_with_adjusted_size(addr, pval, size,
+            mr->ops->impl.min_access_size,
+            mr->ops->impl.max_access_size,
+            memory_region_fetch_with_attrs_accessor,
+            mr, attrs);
+    } else if (mr->ops->read) {
+        return access_with_adjusted_size(addr, pval, size,
+                                         mr->ops->impl.min_access_size,
+                                         mr->ops->impl.max_access_size,
+                                         memory_region_read_accessor,
+                                         mr, attrs);
+    } else {
+        return access_with_adjusted_size(addr, pval, size,
+                                         mr->ops->impl.min_access_size,
+                                         mr->ops->impl.max_access_size,
+                                         memory_region_read_with_attrs_accessor,
+                                         mr, attrs);
+    }
+}
+
+MemTxResult memory_region_dispatch_fetch(MemoryRegion *mr,
+                                        hwaddr addr,
+                                        uint64_t *pval,
+                                        MemOp op,
+                                        MemTxAttrs attrs)
+{
+    unsigned size = memop_size(op);
+    MemTxResult r;
+
+    if (mr->alias) {
+        return memory_region_dispatch_fetch(mr->alias,
+                                           mr->alias_offset + addr,
+                                           pval, op, attrs);
+    }
+    if (!memory_region_access_valid(mr, addr, size, false, attrs)) {
+        *pval = unassigned_mem_read(mr, addr, size);
+        return MEMTX_DECODE_ERROR;
+    }
+
+    r = memory_region_dispatch_fetch1(mr, addr, pval, size, attrs);
+    adjust_endianness(mr, pval, op);
+    return r;
+}
+
 /* Return true if an eventfd was signalled */
 static bool memory_region_dispatch_write_eventfds(MemoryRegion *mr,
                                                     hwaddr addr,
-- 
2.34.1


