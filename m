Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9162AC88E40
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 06:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5dev-0000Oq-9V; Sun, 13 Sep 2026 02:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1x5det-0000OT-Em
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 02:25:47 -0400
Received: from va-1-112.ptr.blmpb.com ([209.127.230.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1x5deq-0002o3-TU
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 02:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1789280740; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=hjUCxRH7owdhiSIR0fePXWNWgjxCC/rztZABGwgn0Wo=;
 b=pvNJWbWDLFmKw7RjMiNrHP4bdoBRDnW2XUVCyW+MR+V54GlXnSvU8DGVs4KxlxXNAsrnZY
 rHYZKqj65ZJOFcxBCZIzYtyZeEu12iomBPFNdiu5tGTMUtTU6zUN4FdGosOLOx/4FNltpd
 2u2gSMqtV+Ir609RdJsBpeY77khfUloaTWXa3Q5nREp8MmajDxCT5T55ZLIJhDI/TeaNxD
 Y0vN5zRRDcvuCtqCRzuuyyYIlqPL1VOZ+PGBIz+w2Ih7ayr5J0ikyksSTLSeaAJEBtthYx
 xkul5bxq7Pt4p5iqifgR+8rz/A/hOk4Oh1tr2eBtsRJp0bdUZF9KxugAn9+fhw==
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26aa641e2+0f31a6+nongnu.org+yanfei.xu@bytedance.com>
X-Mailer: git-send-email 2.20.1
X-Original-From: Yanfei Xu <yanfei.xu@bytedance.com>
References: <20260913062455.940447-1-yanfei.xu@bytedance.com>
From: "Yanfei Xu" <yanfei.xu@bytedance.com>
Subject: [PATCH v3 3/4] migration/rdma: Allow multiple in-flight writes per
 chunk
Date: Sun, 13 Sep 2026 14:24:54 +0800
Content-Type: text/plain; charset=UTF-8
To: <qemu-devel@nongnu.org>, <peterx@redhat.com>
Cc: <farosas@suse.de>, <lizhijian@fujitsu.com>, <isyanfei.xu@gmail.com>, 
 <jinpu.wang@cloud.ionos.com>, "Yanfei Xu" <yanfei.xu@bytedance.com>
Message-Id: <20260913062455.940447-4-yanfei.xu@bytedance.com>
In-Reply-To: <20260913062455.940447-1-yanfei.xu@bytedance.com>
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

qemu_rdma_write_one() waits for an earlier write that shares the same
registration chunk, even when the dirty ranges do not overlap.  This
serializes sparse writes and leaves send queue capacity unused.

RAM round notifiers now provide the completion barrier before a newer
page version can be sent, and the obsolete unregister path no longer
requires per-chunk serialization.  Remove the wait.  The global nb_sent
count continues to manage CQ and send queue resources.

Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c       | 19 +------------------
 migration/trace-events |  1 -
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 16e9c6c30e..6f9b474e29 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1740,7 +1740,7 @@ static int qemu_rdma_write_one(RDMAContext *rdma,
     struct ibv_sge sge;
     struct ibv_send_wr send_wr = { 0 };
     struct ibv_send_wr *bad_wr;
-    int reg_result_idx, ret, count = 0;
+    int reg_result_idx, ret;
     uint64_t chunk, chunks;
     uint64_t chunk_size = migrate_rdma_chunk_size();
     uint8_t *chunk_start, *chunk_end;
@@ -1772,23 +1772,6 @@ retry:
 
     chunk_end = ram_chunk_end(block, chunk + chunks);
 
-
-    while (test_bit(chunk, block->transit_bitmap)) {
-        (void)count;
-        trace_rdma_write_one_block(count++, current_index, chunk,
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
     if (!rdma->pin_all) {
         if (!block->remote_keys[chunk]) {
             /*
diff --git a/migration/trace-events b/migration/trace-events
index a9b02b3113..70d083f3fe 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -243,7 +243,6 @@ rdma_register_odp_mr(const char *name) "Try to register On-Demand Paging memory
 rdma_advise_mr(const char *name, uint32_t len, uint64_t addr, const char *res) "Try to advise block %s prefetch at %" PRIu32 "@0x%" PRIx64 ": %s"
 rdma_resolve_host_trying(const char *host, const char *ip) "Trying %s => %s"
 rdma_write_flush(int sent) "sent total: %d"
-rdma_write_one_block(int count, int block, uint64_t chunk, uint64_t current, uint64_t len, int nb_sent, int nb_chunks) "(%d) Not clobbering: block: %d chunk %" PRIu64 " current %" PRIu64 " len %" PRIu64 " %d %d"
 rdma_write_one_post(uint64_t chunk, long addr, long remote, uint32_t len) "Posting chunk: %" PRIu64 ", addr: 0x%lx remote: 0x%lx, bytes %" PRIu32
 rdma_write_one_queue_full(void) ""
 rdma_write_one_recvregres(int mykey, int theirkey, uint64_t chunk) "Received registration result: my key: 0x%x their key 0x%x, chunk %" PRIu64
-- 
2.20.1

