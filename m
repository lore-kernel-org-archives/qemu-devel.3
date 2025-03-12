Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40774C28B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 09:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsIYk-0003Ze-CW; Wed, 12 Mar 2025 05:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1tsIYc-0003YT-IG; Wed, 12 Mar 2025 05:39:22 -0400
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1tsIYX-0000ks-3E; Wed, 12 Mar 2025 05:39:22 -0400
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
 by Atcsqr.andestech.com with ESMTPS id 52C9bBpv069430
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Mar 2025 17:37:11 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from atcpcw16.andestech.com (10.0.1.106) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 12 Mar 2025
 17:38:42 +0800
To: <qemu-devel@nongnu.org>
CC: <richard.henderson@linaro.org>, <pbonzini@redhat.com>,
 <palmer@dabbelt.com>, <alistair.francis@wdc.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <peterx@redhat.com>,
 <david@redhat.com>, <philmd@linaro.org>, <qemu-riscv@nongnu.org>,
 Ethan Chen <ethan84@andestech.com>
Subject: [PATCH v11 2/8] memory: Introduce memory region fetch operation
Date: Wed, 12 Mar 2025 17:37:26 +0800
Message-ID: <20250312093735.1517740-3-ethan84@andestech.com>
X-Mailer: git-send-email 2.42.0.345.gaab89be2eb.dirty
In-Reply-To: <20250312093735.1517740-1-ethan84@andestech.com>
References: <20250312093735.1517740-1-ethan84@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.1.106]
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 52C9bBpv069430
Received-SPF: pass client-ip=60.248.80.70; envelope-from=ethan84@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Allow memory regions to have different behaviors for read and fetch
operations.

For example, the RISC-V IOPMP could raise an interrupt when the CPU
tries to fetch from a non-executable region.

If the fetch operation for a memory region is not implemented, the read
operation will still be used for fetch operations.

Signed-off-by: Ethan Chen <ethan84@andestech.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 accel/tcg/cputlb.c    |   9 +++-
 include/exec/memory.h |  27 +++++++++++
 system/memory.c       | 104 ++++++++++++++++++++++++++++++++++++++++++
 system/trace-events   |   2 +
 4 files changed, 140 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index fb22048876..83d689f9a6 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1950,8 +1950,13 @@ static uint64_t int_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
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
index d09af58c97..78c41c92cd 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -283,6 +283,11 @@ struct MemoryRegionOps {
                   hwaddr addr,
                   uint64_t data,
                   unsigned size);
+    /* Fetch from the memory region. @addr is relative to @mr; @size is
+     * in bytes. */
+    uint64_t (*fetch)(void *opaque,
+                      hwaddr addr,
+                      unsigned size);
 
     MemTxResult (*read_with_attrs)(void *opaque,
                                    hwaddr addr,
@@ -294,6 +299,11 @@ struct MemoryRegionOps {
                                     uint64_t data,
                                     unsigned size,
                                     MemTxAttrs attrs);
+    MemTxResult (*fetch_with_attrs)(void *opaque,
+                                    hwaddr addr,
+                                    uint64_t *data,
+                                    unsigned size,
+                                    MemTxAttrs attrs);
 
     enum device_endian endianness;
     /* Guest-visible constraints: */
@@ -2614,6 +2624,23 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
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
index 4c829793a0..8c36406664 100644
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
@@ -1493,6 +1538,65 @@ MemTxResult memory_region_dispatch_read(MemoryRegion *mr,
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
diff --git a/system/trace-events b/system/trace-events
index be12ebfb41..0fbaca09c5 100644
--- a/system/trace-events
+++ b/system/trace-events
@@ -18,8 +18,10 @@ cpu_out(unsigned int addr, char size, unsigned int val) "addr 0x%x(%c) value %u"
 # memory.c
 memory_region_ops_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size, const char *name) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u name '%s'"
 memory_region_ops_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size, const char *name) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u name '%s'"
+memory_region_ops_fetch(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size, const char *name) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u name '%s'"
 memory_region_subpage_read(int cpu_index, void *mr, uint64_t offset, uint64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRIx64" size %u"
 memory_region_subpage_write(int cpu_index, void *mr, uint64_t offset, uint64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRIx64" size %u"
+memory_region_subpage_fetch(int cpu_index, void *mr, uint64_t offset, uint64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRIx64" size %u"
 memory_region_ram_device_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
 memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
 memory_region_sync_dirty(const char *mr, const char *listener, int global) "mr '%s' listener '%s' synced (global=%d)"
-- 
2.34.1


