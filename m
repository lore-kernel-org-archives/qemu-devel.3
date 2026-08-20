Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920E7C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 12:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx2MP-0005NL-58; Thu, 20 Aug 2026 08:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1wx2MM-0005N2-8H
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:59:06 -0400
Received: from va-1-112.ptr.blmpb.com ([209.127.230.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1wx2MK-0005TK-3s
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1787230738; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=bNmPWQY9+XYhV/JRx6TQAUQSp0U3XZW6In1fSxl7oR0=;
 b=fviMtCXvnll8tQ2RI06uT99Oqu1euW1z+20WQYLZixdUpXBwE6jC6Ey8p1g0FFW+eZlfI4
 mqbdqLgT0i5/gRQ+wUjB06f3vifVKCe5B8c6ZHR7s0Yi911Krg1z1n5oXoYJNDN5hWujzX
 wiE6O81AdDQiggXRYQtDbx/81MbMdcXKMJe6/Jh5qjdMlWlvJHiJrZCNBj6jrVjxqIQl+4
 96KH5MJalROv4RNlB+PT9TcNV+Hnmt/rdSnTNt10scsdVbzOY2kwMN8itTuIH0BNAgSqey
 LR/72Yk7Ah8eGpquJhdrOPh3NxoOvu/Kbi31He5l2YzwoKjP5e7Bxu/7/cJaBA==
In-Reply-To: <20260820125833.1541756-1-yanfei.xu@bytedance.com>
Cc: <peterx@redhat.com>, <farosas@suse.de>, <lizhijian@fujitsu.com>, 
 <isyanfei.xu@gmail.com>, <jinpu.wang@cloud.ionos.com>, 
 "Yanfei Xu" <yanfei.xu@bytedance.com>
Message-Id: <20260820125833.1541756-2-yanfei.xu@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26a86fa10+1cc84e+nongnu.org+yanfei.xu@bytedance.com>
References: <20260820125833.1541756-1-yanfei.xu@bytedance.com>
To: <qemu-devel@nongnu.org>
X-Original-From: Yanfei Xu <yanfei.xu@bytedance.com>
X-Mailer: git-send-email 2.20.1
Content-Type: text/plain; charset=UTF-8
From: "Yanfei Xu" <yanfei.xu@bytedance.com>
Date: Thu, 20 Aug 2026 20:58:32 +0800
Subject: [RFC PATCH v1 1/2] migration/rdma: Track in-flight writes with
 refcounts
Mime-Version: 1.0
Received-SPF: pass client-ip=209.127.230.112;
 envelope-from=yanfei.xu@bytedance.com; helo=va-1-112.ptr.blmpb.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The transit bitmap can only represent one outstanding write per
registration chunk.  Replace it with a per-chunk reference count and
assert the count on each update.

Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
---
 migration/rdma.c       | 48 ++++++++++++++++++++++++++++++------------
 migration/trace-events |  4 ++--
 2 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index d1f44a5f55..973a7a745a 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -199,7 +199,7 @@ typedef struct RDMALocalBlock {
     unsigned int   src_index;       /* (Only used on dest) */
     bool           is_ram_block;
     int            nb_chunks;
-    unsigned long *transit_bitmap;
+    unsigned int  *transit_refcnt;
     unsigned long *unregister_bitmap;
 } RDMALocalBlock;
 
@@ -552,6 +552,29 @@ static inline uint8_t *ram_chunk_end(const RDMALocalBlock *rdma_ram_block,
     return result;
 }
 
+static inline bool qemu_rdma_chunk_in_transit(const RDMALocalBlock *block,
+                                              uint64_t chunk)
+{
+    assert(chunk < block->nb_chunks);
+    return block->transit_refcnt[chunk] > 0;
+}
+
+static inline void qemu_rdma_chunk_transit_inc(RDMALocalBlock *block,
+                                               uint64_t chunk)
+{
+    assert(chunk < block->nb_chunks);
+    assert(block->transit_refcnt[chunk] < UINT_MAX);
+    block->transit_refcnt[chunk]++;
+}
+
+static inline void qemu_rdma_chunk_transit_dec(RDMALocalBlock *block,
+                                               uint64_t chunk)
+{
+    assert(chunk < block->nb_chunks);
+    assert(block->transit_refcnt[chunk] > 0);
+    block->transit_refcnt[chunk]--;
+}
+
 static void rdma_add_block(RDMAContext *rdma, const char *block_name,
                            void *host_addr,
                            ram_addr_t block_offset, uint64_t length)
@@ -585,8 +608,7 @@ static void rdma_add_block(RDMAContext *rdma, const char *block_name,
     block->index = local->nb_blocks;
     block->src_index = ~0U; /* Filled in by the receipt of the block list */
     block->nb_chunks = ram_chunk_index(host_addr, host_addr + length) + 1UL;
-    block->transit_bitmap = bitmap_new(block->nb_chunks);
-    bitmap_clear(block->transit_bitmap, 0, block->nb_chunks);
+    block->transit_refcnt = g_new0(unsigned int, block->nb_chunks);
     block->unregister_bitmap = bitmap_new(block->nb_chunks);
     bitmap_clear(block->unregister_bitmap, 0, block->nb_chunks);
     block->remote_keys = g_new0(uint32_t, block->nb_chunks);
@@ -601,8 +623,7 @@ static void rdma_add_block(RDMAContext *rdma, const char *block_name,
                          (uintptr_t) block->local_host_addr,
                          block->offset, block->length,
                          (uintptr_t) (block->local_host_addr + block->length),
-                         BITS_TO_LONGS(block->nb_chunks) *
-                             sizeof(unsigned long) * 8,
+                         block->nb_chunks * sizeof(*block->transit_refcnt),
                          block->nb_chunks);
 
     local->nb_blocks++;
@@ -673,8 +694,8 @@ static void rdma_delete_block(RDMAContext *rdma, RDMALocalBlock *block)
         block->mr = NULL;
     }
 
-    g_free(block->transit_bitmap);
-    block->transit_bitmap = NULL;
+    g_free(block->transit_refcnt);
+    block->transit_refcnt = NULL;
 
     g_free(block->unregister_bitmap);
     block->unregister_bitmap = NULL;
@@ -716,8 +737,9 @@ static void rdma_delete_block(RDMAContext *rdma, RDMALocalBlock *block)
     trace_rdma_delete_block(block, (uintptr_t)block->local_host_addr,
                            block->offset, block->length,
                             (uintptr_t)(block->local_host_addr + block->length),
-                           BITS_TO_LONGS(block->nb_chunks) *
-                               sizeof(unsigned long) * 8, block->nb_chunks);
+                           block->nb_chunks *
+                               sizeof(*block->transit_refcnt),
+                           block->nb_chunks);
 
     g_free(old);
 
@@ -1237,7 +1259,7 @@ static int qemu_rdma_unregister_waiting(RDMAContext *rdma)
          */
         clear_bit(chunk, block->unregister_bitmap);
 
-        if (test_bit(chunk, block->transit_bitmap)) {
+        if (qemu_rdma_chunk_in_transit(block, chunk)) {
             trace_qemu_rdma_unregister_waiting_inflight(chunk);
             continue;
         }
@@ -1328,7 +1350,7 @@ static int qemu_rdma_poll(RDMAContext *rdma, struct ibv_cq *cq,
                                    index, chunk, block->local_host_addr,
                                    (void *)(uintptr_t)block->remote_host_addr);
 
-        clear_bit(chunk, block->transit_bitmap);
+        qemu_rdma_chunk_transit_dec(block, chunk);
 
         if (rdma->nb_sent > 0) {
             rdma->nb_sent--;
@@ -1889,7 +1911,7 @@ retry:
     chunk_end = ram_chunk_end(block, chunk + chunks);
 
 
-    while (test_bit(chunk, block->transit_bitmap)) {
+    while (qemu_rdma_chunk_in_transit(block, chunk)) {
         (void)count;
         trace_qemu_rdma_write_one_block(count++, current_index, chunk,
                 sge.addr, length, rdma->nb_sent, block->nb_chunks);
@@ -2053,7 +2075,7 @@ retry:
         return -1;
     }
 
-    set_bit(chunk, block->transit_bitmap);
+    qemu_rdma_chunk_transit_inc(block, chunk);
     qatomic_add(&mig_stats.normal_pages, sge.length / qemu_target_page_size());
     /*
      * We are adding to transferred the amount of data written, but no
diff --git a/migration/trace-events b/migration/trace-events
index af0e784535..172761be78 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -256,9 +256,9 @@ qemu_rdma_write_one_recvregres(int mykey, int theirkey, uint64_t chunk) "Receive
 qemu_rdma_write_one_sendreg(uint64_t chunk, int len, int index, int64_t offset) "Sending registration request chunk %" PRIu64 " for %d bytes, index: %d, offset: %" PRId64
 qemu_rdma_write_one_top(uint64_t chunks, uint64_t size) "Writing %" PRIu64 " chunks, (%" PRIu64 " MB)"
 qemu_rdma_write_one_zero(uint64_t chunk, int len, int index, int64_t offset) "Entire chunk is zero, sending compress: %" PRIu64 " for %d bytes, index: %d, offset: %" PRId64
-rdma_add_block(const char *block_name, int block, uint64_t addr, uint64_t offset, uint64_t len, uint64_t end, uint64_t bits, int chunks) "Added Block: '%s':%d, addr: %" PRIu64 ", offset: %" PRIu64 " length: %" PRIu64 " end: %" PRIu64 " bits %" PRIu64 " chunks %d"
+rdma_add_block(const char *block_name, int block, uint64_t addr, uint64_t offset, uint64_t len, uint64_t end, uint64_t refcnt_bytes, int chunks) "Added Block: '%s':%d, addr: %" PRIu64 ", offset: %" PRIu64 " length: %" PRIu64 " end: %" PRIu64 " refcnt-bytes %" PRIu64 " chunks %d"
 rdma_block_notification_handle(const char *name, int index) "%s at %d"
-rdma_delete_block(void *block, uint64_t addr, uint64_t offset, uint64_t len, uint64_t end, uint64_t bits, int chunks) "Deleted Block: %p, addr: %" PRIu64 ", offset: %" PRIu64 " length: %" PRIu64 " end: %" PRIu64 " bits %" PRIu64 " chunks %d"
+rdma_delete_block(void *block, uint64_t addr, uint64_t offset, uint64_t len, uint64_t end, uint64_t refcnt_bytes, int chunks) "Deleted Block: %p, addr: %" PRIu64 ", offset: %" PRIu64 " length: %" PRIu64 " end: %" PRIu64 " refcnt-bytes %" PRIu64 " chunks %d"
 rdma_registration_handle_compress(int64_t length, int index, int64_t offset) "Zapping zero chunk: %" PRId64 " bytes, index %d, offset %" PRId64
 rdma_registration_handle_finished(void) ""
 rdma_registration_handle_ram_blocks(void) ""
-- 
2.20.1

