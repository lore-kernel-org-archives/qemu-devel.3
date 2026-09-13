Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982C5C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 06:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5df7-0000YO-6R; Sun, 13 Sep 2026 02:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1x5df4-0000Ut-5w
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 02:25:58 -0400
Received: from va-1-114.ptr.blmpb.com ([209.127.230.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1x5df0-0002oe-1T
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 02:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1789280749; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=papa7K0qt3qBqtxuBR0A7TO9lTB6ZZXXJ86FLrBGYyo=;
 b=fTQGlDDPbhC5DZaBBUAFaBBU+/0ahVv6tQcXOj1HVRrZ7M1FTKQOxXL8CebRivvIGwqc7Q
 PrDnGBiRuWZwUEwwnuUeBTQsfOafq4a9DnhzvbU448gEXBDgQPSWUV4y9I9TsyAQIPe8K7
 owtfqha1awAvESSOnEf0vCbR4ddJOaB0Jx0sfnD2crmMa/ODvQBh8jgpfM8UxaFRyox8Hl
 X9l6/KtqSocA4yiJkisKvmseXUMO4jOl5iAaG6+x03yXrC9f2Bhw9nvvP88E5m7GPlaBYc
 W6cOZfcOKvlj5k1CqGXt+o68L0tf4y35oUsxdiZKBychCxOq3XAdgmNncpgmUw==
Subject: [PATCH v3 4/4] migration/rdma: Remove unused transit bitmap
Date: Sun, 13 Sep 2026 14:24:55 +0800
Mime-Version: 1.0
X-Original-From: Yanfei Xu <yanfei.xu@bytedance.com>
X-Mailer: git-send-email 2.20.1
From: "Yanfei Xu" <yanfei.xu@bytedance.com>
Content-Transfer-Encoding: 7bit
To: <qemu-devel@nongnu.org>, <peterx@redhat.com>
Cc: <farosas@suse.de>, <lizhijian@fujitsu.com>, <isyanfei.xu@gmail.com>, 
 <jinpu.wang@cloud.ionos.com>, "Yanfei Xu" <yanfei.xu@bytedance.com>
Message-Id: <20260913062455.940447-5-yanfei.xu@bytedance.com>
References: <20260913062455.940447-1-yanfei.xu@bytedance.com>
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20260913062455.940447-1-yanfei.xu@bytedance.com>
X-Lms-Return-Path: <lba+26aa641eb+3ed993+nongnu.org+yanfei.xu@bytedance.com>
Received-SPF: pass client-ip=209.127.230.114;
 envelope-from=yanfei.xu@bytedance.com; helo=va-1-114.ptr.blmpb.com
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

After the per-chunk write wait is removed, transit_bitmap is no longer
read.  The remaining set and clear operations only maintain unused
state.

Remove the bitmap and simplify the block lifecycle tracepoints.

Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c       | 20 +++-----------------
 migration/trace-events |  4 ++--
 2 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 6f9b474e29..7a884ecb6e 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -30,7 +30,6 @@
 #include "qemu/module.h"
 #include "qemu/rcu.h"
 #include "qemu/sockets.h"
-#include "qemu/bitmap.h"
 #include "qemu/coroutine.h"
 #include "system/memory.h"
 #include <sys/socket.h>
@@ -197,7 +196,6 @@ typedef struct RDMALocalBlock {
     int            index;           /* which block are we */
     unsigned int   src_index;       /* (Only used on dest) */
     int            nb_chunks;
-    unsigned long *transit_bitmap;
 } RDMALocalBlock;
 
 /*
@@ -571,8 +569,6 @@ static void rdma_add_block(RDMAContext *rdma, const char *block_name,
     block->index = local->nb_blocks;
     block->src_index = ~0U; /* Filled in by the receipt of the block list */
     block->nb_chunks = ram_chunk_index(host_addr, host_addr + length) + 1UL;
-    block->transit_bitmap = bitmap_new(block->nb_chunks);
-    bitmap_clear(block->transit_bitmap, 0, block->nb_chunks);
     block->remote_keys = g_new0(uint32_t, block->nb_chunks);
 
     if (rdma->blockmap) {
@@ -583,8 +579,6 @@ static void rdma_add_block(RDMAContext *rdma, const char *block_name,
                          (uintptr_t) block->local_host_addr,
                          block->offset, block->length,
                          (uintptr_t) (block->local_host_addr + block->length),
-                         BITS_TO_LONGS(block->nb_chunks) *
-                             sizeof(unsigned long) * 8,
                          block->nb_chunks);
 
     local->nb_blocks++;
@@ -654,9 +648,6 @@ static void rdma_delete_block(RDMAContext *rdma, RDMALocalBlock *block)
         block->mr = NULL;
     }
 
-    g_free(block->transit_bitmap);
-    block->transit_bitmap = NULL;
-
     g_free(block->remote_keys);
     block->remote_keys = NULL;
 
@@ -693,9 +684,8 @@ static void rdma_delete_block(RDMAContext *rdma, RDMALocalBlock *block)
 
     trace_rdma_delete_block(block, (uintptr_t)block->local_host_addr,
                            block->offset, block->length,
-                            (uintptr_t)(block->local_host_addr + block->length),
-                           BITS_TO_LONGS(block->nb_chunks) *
-                               sizeof(unsigned long) * 8, block->nb_chunks);
+                           (uintptr_t)(block->local_host_addr + block->length),
+                           block->nb_chunks);
 
     g_free(old);
 
@@ -1221,8 +1211,6 @@ static int qemu_rdma_poll(RDMAContext *rdma, struct ibv_cq *cq,
                                    index, chunk, block->local_host_addr,
                                    (void *)(uintptr_t)block->remote_host_addr);
 
-        clear_bit(chunk, block->transit_bitmap);
-
         if (rdma->nb_sent > 0) {
             rdma->nb_sent--;
         }
@@ -1877,8 +1865,7 @@ retry:
     /*
      * Encode the ram block index and chunk within this wrid.
      * We will use this information at the time of completion
-     * to figure out which bitmap to check against and then which
-     * chunk in the bitmap to look for.
+     * to identify the completed write in trace output.
      */
     send_wr.wr_id = qemu_rdma_make_wrid(RDMA_WRID_RDMA_WRITE,
                                         current_index, chunk);
@@ -1916,7 +1903,6 @@ retry:
         return -1;
     }
 
-    set_bit(chunk, block->transit_bitmap);
     qatomic_add(&mig_stats.normal_pages, sge.length / qemu_target_page_size());
     /*
      * We are adding to transferred the amount of data written, but no
diff --git a/migration/trace-events b/migration/trace-events
index 70d083f3fe..4b3239636c 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -249,9 +249,9 @@ rdma_write_one_recvregres(int mykey, int theirkey, uint64_t chunk) "Received reg
 rdma_write_one_sendreg(uint64_t chunk, int len, int index, int64_t offset) "Sending registration request chunk %" PRIu64 " for %d bytes, index: %d, offset: %" PRId64
 rdma_write_one_top(uint64_t chunks, uint64_t size) "Writing %" PRIu64 " chunks, (%" PRIu64 " MB)"
 rdma_write_one_zero(uint64_t chunk, int len, int index, int64_t offset) "Entire chunk is zero, sending compress: %" PRIu64 " for %d bytes, index: %d, offset: %" PRId64
-rdma_add_block(const char *block_name, int block, uint64_t addr, uint64_t offset, uint64_t len, uint64_t end, uint64_t bits, int chunks) "Added Block: '%s':%d, addr: %" PRIu64 ", offset: %" PRIu64 " length: %" PRIu64 " end: %" PRIu64 " bits %" PRIu64 " chunks %d"
+rdma_add_block(const char *block_name, int block, uint64_t addr, uint64_t offset, uint64_t len, uint64_t end, int chunks) "Added Block: '%s':%d, addr: %" PRIu64 ", offset: %" PRIu64 " length: %" PRIu64 " end: %" PRIu64 " chunks %d"
 rdma_block_notification_handle(const char *name, int index) "%s at %d"
-rdma_delete_block(void *block, uint64_t addr, uint64_t offset, uint64_t len, uint64_t end, uint64_t bits, int chunks) "Deleted Block: %p, addr: %" PRIu64 ", offset: %" PRIu64 " length: %" PRIu64 " end: %" PRIu64 " bits %" PRIu64 " chunks %d"
+rdma_delete_block(void *block, uint64_t addr, uint64_t offset, uint64_t len, uint64_t end, int chunks) "Deleted Block: %p, addr: %" PRIu64 ", offset: %" PRIu64 " length: %" PRIu64 " end: %" PRIu64 " chunks %d"
 rdma_registration_handle_compress(int64_t length, int index, int64_t offset) "Zapping zero chunk: %" PRId64 " bytes, index %d, offset %" PRId64
 rdma_registration_handle_finished(void) ""
 rdma_registration_handle_ram_blocks(void) ""
-- 
2.20.1

