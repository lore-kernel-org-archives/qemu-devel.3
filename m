Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E62DC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 12:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx2Ma-0005Oz-TG; Thu, 20 Aug 2026 08:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1wx2MZ-0005Oo-Fl
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:59:19 -0400
Received: from va-1-113.ptr.blmpb.com ([209.127.230.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1wx2MX-0005V4-Gc
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1787230747; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=c2OFBpaMKAYU75s6016ad4m6ba8dR4V1MhOGQxkaS7M=;
 b=e0ffiUFDpoxx3i74DSr9GTr/D8VIna8Ba5WJU1VleTcUWTsFaasFCaIIjs+UTYyhEoTVFY
 Sr7JTyzNvELS1aG98NlTgT+rd6oRSDDmgBO12Tp/JA44XJnNZML4RYTAO1h7HERc2EXMo7
 HT+xJsBeflR0TpT0WH01qsGBUG9DmTWC7GASjMz9FZrwyWzrQvmbFTCbT+VO7XezNbsUsH
 38CqvX5r2967o/xecgq3eTDXac/7Tx0kxeLWjvw1/wOK0h1h/2MXCRpQaKBxSpmZlh2RV6
 0rw5kfQm164uPTpAfJ1mfLw/jYhk78dyTcYuu20iXAfMkjMZ0up6NrNOxPoMMQ==
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26a86fa19+199646+nongnu.org+yanfei.xu@bytedance.com>
X-Mailer: git-send-email 2.20.1
X-Original-From: Yanfei Xu <yanfei.xu@bytedance.com>
To: <qemu-devel@nongnu.org>
Cc: <peterx@redhat.com>, <farosas@suse.de>, <lizhijian@fujitsu.com>, 
 <isyanfei.xu@gmail.com>, <jinpu.wang@cloud.ionos.com>, 
 "Yanfei Xu" <yanfei.xu@bytedance.com>
Date: Thu, 20 Aug 2026 20:58:33 +0800
Content-Type: text/plain; charset=UTF-8
From: "Yanfei Xu" <yanfei.xu@bytedance.com>
Message-Id: <20260820125833.1541756-3-yanfei.xu@bytedance.com>
Mime-Version: 1.0
Subject: [RFC PATCH v1 2/2] migration/rdma: Allow multiple in-flight writes
 per chunk
In-Reply-To: <20260820125833.1541756-1-yanfei.xu@bytedance.com>
References: <20260820125833.1541756-1-yanfei.xu@bytedance.com>
Received-SPF: pass client-ip=209.127.230.113;
 envelope-from=yanfei.xu@bytedance.com; helo=va-1-113.ptr.blmpb.com
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

qemu_rdma_write_one() waits for an earlier write to the same
registration chunk to complete.  This serializes disjoint dirty ranges
in a chunk and leaves send queue capacity unused.

Remove the per-chunk wait and use the reference counts to track all
outstanding writes.  The existing per-iteration drain remains the
completion barrier.

Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
---
 migration/rdma.c       | 19 +------------------
 migration/trace-events |  1 -
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 973a7a745a..63bc357657 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1869,7 +1869,7 @@ static int qemu_rdma_write_one(RDMAContext *rdma,
     struct ibv_sge sge;
     struct ibv_send_wr send_wr = { 0 };
     struct ibv_send_wr *bad_wr;
-    int reg_result_idx, ret, count = 0;
+    int reg_result_idx, ret;
     uint64_t chunk, chunks;
     uint64_t chunk_size = migrate_rdma_chunk_size();
     uint8_t *chunk_start, *chunk_end;
@@ -1910,23 +1910,6 @@ retry:
 
     chunk_end = ram_chunk_end(block, chunk + chunks);
 
-
-    while (qemu_rdma_chunk_in_transit(block, chunk)) {
-        (void)count;
-        trace_qemu_rdma_write_one_block(count++, current_index, chunk,
-                sge.addr, length, rdma->nb_sent, block->nb_chunks);
-
-        ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NULL);
-
-        if (ret < 0) {
-            error_setg(errp, "Failed to Wait for previous write to complete "
-                    "block %d chunk %" PRIu64
-                    " current %" PRIu64 " len %" PRIu64 " %d",
-                    current_index, chunk, sge.addr, length, rdma->nb_sent);
-            return -1;
-        }
-    }
-
     if (!rdma->pin_all || !block->is_ram_block) {
         if (!block->remote_keys[chunk]) {
             /*
diff --git a/migration/trace-events b/migration/trace-events
index 172761be78..253ff71891 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -249,7 +249,6 @@ qemu_rdma_unregister_waiting_proc(uint64_t chunk, int pos) "Processing unregiste
 qemu_rdma_unregister_waiting_send(uint64_t chunk) "Sending unregister for chunk: %" PRIu64
 qemu_rdma_unregister_waiting_complete(uint64_t chunk) "Unregister for chunk: %" PRIu64 " complete."
 qemu_rdma_write_flush(int sent) "sent total: %d"
-qemu_rdma_write_one_block(int count, int block, uint64_t chunk, uint64_t current, uint64_t len, int nb_sent, int nb_chunks) "(%d) Not clobbering: block: %d chunk %" PRIu64 " current %" PRIu64 " len %" PRIu64 " %d %d"
 qemu_rdma_write_one_post(uint64_t chunk, long addr, long remote, uint32_t len) "Posting chunk: %" PRIu64 ", addr: 0x%lx remote: 0x%lx, bytes %" PRIu32
 qemu_rdma_write_one_queue_full(void) ""
 qemu_rdma_write_one_recvregres(int mykey, int theirkey, uint64_t chunk) "Received registration result: my key: 0x%x their key 0x%x, chunk %" PRIu64
-- 
2.20.1

