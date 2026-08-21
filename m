Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3A7C5DF89
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 13:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxPRU-0002g7-B3; Fri, 21 Aug 2026 09:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1wxPRR-0002XB-MU
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 09:37:53 -0400
Received: from va-1-114.ptr.blmpb.com ([209.127.230.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1wxPRP-0000np-L6
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 09:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1787319466; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=JcsPBIPKPtR3x0fEbCq/mhvKorUmjmYoZV6kGdQScWw=;
 b=F+d1KrnVYjJ6U1dLeT+TAmSe8eW/FDhnLmBGmHrDGP2Go2fAq1rWMRd0w8pT4CgdD6Kqc0
 KyrdmpY3hL/0orXPXpQGnK0+LZf/d6EOF4L94rSslSosLSUr8JZImcbgwP99X3Yq3gVpFm
 TRyP0s4wiLZVAOsWG/Nnk/mNvJVjpxbv0bKsQqHDbmVfFbC++0Yr1xM6NvKzQGZs4MZOxg
 x1mqy/x0Go036LBYNue0ok7ZuqYpuW4OICnwTwIW44YHXsvaFY7/eaf1LDnQOOGm1IiF0E
 GxkfgSB9zVhl7tawCjJjbQieiVvm5AhNNDxdtPBHY04W575AFG7Bny6fktaWpw==
References: <20260821133559.3815727-1-yanfei.xu@bytedance.com>
Message-Id: <20260821133559.3815727-4-yanfei.xu@bytedance.com>
X-Lms-Return-Path: <lba+26a8854a8+536bd7+nongnu.org+yanfei.xu@bytedance.com>
From: "Yanfei Xu" <yanfei.xu@bytedance.com>
Subject: [PATCH v2 3/3] migration/rdma: Retry control sends on full queue
Date: Fri, 21 Aug 2026 21:35:59 +0800
Mime-Version: 1.0
In-Reply-To: <20260821133559.3815727-1-yanfei.xu@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: <qemu-devel@nongnu.org>
Cc: <peterx@redhat.com>, <farosas@suse.de>, <lizhijian@fujitsu.com>, 
 <jinpu.wang@cloud.ionos.com>, <isyanfei.xu@gmail.com>, 
 "Yanfei Xu" <yanfei.xu@bytedance.com>
X-Original-From: Yanfei Xu <yanfei.xu@bytedance.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 7bit
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

RAM writes and control messages share the send queue. If outstanding
writes fill it, RDMA writes drain a completion and retry, but control
sends fail the migration.

Move send posting and queue-full handling into a common helper. On
ENOMEM, drain one outstanding RDMA write and retry the failed request
once. If no write is outstanding, or the retry still fails, propagate
the error.

Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
---
 migration/rdma.c       | 78 +++++++++++++++++++++++++++---------------
 migration/trace-events |  2 +-
 2 files changed, 51 insertions(+), 29 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 6e8436ccc1..ee6da4f137 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1530,6 +1530,52 @@ err_block_for_wrid:
     return -1;
 }
 
+/*
+ * Post a send work request, draining an outstanding RDMA write if the send
+ * queue is full.
+ */
+static int qemu_rdma_post_send(RDMAContext *rdma,
+                               struct ibv_send_wr *send_wr,
+                               Error **errp)
+{
+    struct ibv_send_wr *bad_wr;
+    uint64_t wr_id = send_wr->wr_id & RDMA_WRID_TYPE_MASK;
+    const char *wr_desc;
+    int ret;
+
+    switch (wr_id) {
+    case RDMA_WRID_RDMA_WRITE:
+        wr_desc = "RDMA write";
+        break;
+    case RDMA_WRID_SEND_CONTROL:
+        wr_desc = "control send";
+        break;
+    default:
+        wr_desc = "send work request";
+        break;
+    }
+
+    ret = ibv_post_send(rdma->qp, send_wr, &bad_wr);
+    if (ret == ENOMEM && rdma->nb_sent) {
+        trace_qemu_rdma_post_send_queue_full(send_wr->wr_id, rdma->nb_sent);
+        ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NULL);
+        if (ret < 0) {
+            error_setg(errp, "rdma migration: failed to make room for %s",
+                       wr_desc);
+            return -1;
+        }
+        ret = ibv_post_send(rdma->qp, send_wr, &bad_wr);
+    }
+
+    if (ret > 0) {
+        error_setg_errno(errp, ret, "rdma migration: post %s failed",
+                         wr_desc);
+        return -1;
+    }
+
+    return 0;
+}
+
 /*
  * Post a SEND message work request for the control channel
  * containing some data and block until the post completes.
@@ -1540,7 +1586,6 @@ static int qemu_rdma_post_send_control(RDMAContext *rdma, uint8_t *buf,
 {
     int ret;
     RDMAWorkRequestData *wr = &rdma->wr_data[RDMA_WRID_CONTROL];
-    struct ibv_send_wr *bad_wr;
     struct ibv_sge sge = {
                            .addr = (uintptr_t)(wr->control),
                            .length = head->len + sizeof(RDMAControlHeader),
@@ -1572,11 +1617,8 @@ static int qemu_rdma_post_send_control(RDMAContext *rdma, uint8_t *buf,
         memcpy(wr->control + sizeof(RDMAControlHeader), buf, head->len);
     }
 
-
-    ret = ibv_post_send(rdma->qp, &send_wr, &bad_wr);
-
-    if (ret > 0) {
-        error_setg(errp, "Failed to use post IB SEND for control");
+    ret = qemu_rdma_post_send(rdma, &send_wr, errp);
+    if (ret < 0) {
         return -1;
     }
 
@@ -1836,7 +1878,6 @@ static int qemu_rdma_write_one(RDMAContext *rdma,
 {
     struct ibv_sge sge;
     struct ibv_send_wr send_wr = { 0 };
-    struct ibv_send_wr *bad_wr;
     int reg_result_idx, ret, count = 0;
     uint64_t chunk, chunks;
     uint64_t chunk_size = migrate_rdma_chunk_size();
@@ -1850,7 +1891,6 @@ static int qemu_rdma_write_one(RDMAContext *rdma,
                                .repeat = 1,
                              };
 
-retry:
     sge.addr = (uintptr_t)(block->local_host_addr +
                             (current_addr - block->offset));
     sge.length = length;
@@ -2020,26 +2060,8 @@ retry:
     trace_qemu_rdma_write_one_post(chunk, sge.addr, send_wr.wr.rdma.remote_addr,
                                    sge.length);
 
-    /*
-     * ibv_post_send() does not return negative error numbers,
-     * per the specification they are positive - no idea why.
-     */
-    ret = ibv_post_send(rdma->qp, &send_wr, &bad_wr);
-
-    if (ret == ENOMEM) {
-        trace_qemu_rdma_write_one_queue_full();
-        ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NULL);
-        if (ret < 0) {
-            error_setg(errp, "rdma migration: failed to make "
-                         "room in full send queue!");
-            return -1;
-        }
-
-        goto retry;
-
-    } else if (ret > 0) {
-        error_setg_errno(errp, ret,
-                         "rdma migration: post rdma write failed");
+    ret = qemu_rdma_post_send(rdma, &send_wr, errp);
+    if (ret < 0) {
         return -1;
     }
 
diff --git a/migration/trace-events b/migration/trace-events
index af0e784535..bc0c167a1a 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -251,7 +251,7 @@ qemu_rdma_unregister_waiting_complete(uint64_t chunk) "Unregister for chunk: %"
 qemu_rdma_write_flush(int sent) "sent total: %d"
 qemu_rdma_write_one_block(int count, int block, uint64_t chunk, uint64_t current, uint64_t len, int nb_sent, int nb_chunks) "(%d) Not clobbering: block: %d chunk %" PRIu64 " current %" PRIu64 " len %" PRIu64 " %d %d"
 qemu_rdma_write_one_post(uint64_t chunk, long addr, long remote, uint32_t len) "Posting chunk: %" PRIu64 ", addr: 0x%lx remote: 0x%lx, bytes %" PRIu32
-qemu_rdma_write_one_queue_full(void) ""
+qemu_rdma_post_send_queue_full(uint64_t wr_id, int sent) "send queue full, wr_id=%" PRIu64 ", outstanding writes=%d"
 qemu_rdma_write_one_recvregres(int mykey, int theirkey, uint64_t chunk) "Received registration result: my key: 0x%x their key 0x%x, chunk %" PRIu64
 qemu_rdma_write_one_sendreg(uint64_t chunk, int len, int index, int64_t offset) "Sending registration request chunk %" PRIu64 " for %d bytes, index: %d, offset: %" PRId64
 qemu_rdma_write_one_top(uint64_t chunks, uint64_t size) "Writing %" PRIu64 " chunks, (%" PRIu64 " MB)"
-- 
2.20.1

