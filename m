Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2425C98328
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA82O-0006hO-1o; Fri, 25 Sep 2026 11:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xA82M-0006gn-GL
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:40:34 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xA82K-0004bh-Gq
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:40:34 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 35EA21FF6B;
 Fri, 25 Sep 2026 15:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790350827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7OSpCuW9nO5gBUIlHX+CIcRjX/6Jh/dAG4Pg2+xuudQ=;
 b=zmTUD0KAkkSE5H010zXP3/rIvcDXIMp8cYq5TSTJEBSl/f3PTTVNOPjEfSEenNNPW7+XPU
 gvGvarO9jSUdPOaSgW/kWW4ff9zhKZIr+jsp3E+OAO8QJHXScSl1ge9PD6s25arY4xmppc
 wSVWakHVdOk8XFrKWFvzsuj9sOL3Wt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790350827;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7OSpCuW9nO5gBUIlHX+CIcRjX/6Jh/dAG4Pg2+xuudQ=;
 b=0HDrwIu97RqANSPZEMxgCloms4Hcr7+cN0U4XaAWnNYtEnwoBE+p3kBuoo9cCMfci2xGV6
 UJvMrUtxvrReKkBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aPjSd1Fx;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1Pn0WDOX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790350823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7OSpCuW9nO5gBUIlHX+CIcRjX/6Jh/dAG4Pg2+xuudQ=;
 b=aPjSd1Fx3oAioumCg5qVQW283JXbXL6vdf0neSNmYIpU1bkJN9pZlpBLB76k0qmvO8QWuD
 6y/a15jcmTXJohd9/WrJctACplCLeW/Z0fF/3ViwcNQ3h2/Q0dtUXUOrjHA1Mo/Ody5yCv
 arUZ1d/XBloCvt2CpzGDaW1h+oWwE3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790350823;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7OSpCuW9nO5gBUIlHX+CIcRjX/6Jh/dAG4Pg2+xuudQ=;
 b=1Pn0WDOXpXm80s+G667Mhipj7+y+JeS9nuCYFjS6BY6hMN1T+f95moYOJV/eZw1Ri9dL4y
 KpLzovRFw5GOHaAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFE5C1333E;
 Fri, 25 Sep 2026 15:40:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xxRgCd2VtmqjOwAAD6G6ig:T7
 (envelope-from <farosas@suse.de>); Fri, 25 Sep 2026 15:40:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Yanfei Xu <yanfei.xu@bytedance.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PULL 06/19] migration/rdma: Retry control sends on full queue
Date: Fri, 25 Sep 2026 12:39:57 -0300
Message-ID: <20260925154010.599247-7-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925154010.599247-1-farosas@suse.de>
References: <20260925154010.599247-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 35EA21FF6B
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid,ionos.com:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

From: Yanfei Xu <yanfei.xu@bytedance.com>

RAM writes and control messages share the send queue. If outstanding
writes fill it, RDMA writes drain a completion and retry, but control
sends fail the migration.

Move send posting and queue-full handling into a common helper. On
ENOMEM, drain one outstanding RDMA write and retry the failed request
once. If no write is outstanding, or the retry still fails, propagate
the error.

Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/rdma.c       | 75 ++++++++++++++++++++++++++----------------
 migration/trace-events |  2 +-
 2 files changed, 48 insertions(+), 29 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 618324645b..35d918ec83 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1423,6 +1423,51 @@ err_block_for_wrid:
     return -1;
 }
 
+/*
+ * Post a send work request, draining an outstanding RDMA write if the send
+ * queue is full.
+ */
+static bool qemu_rdma_post_send(RDMAContext *rdma,
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
+        g_assert_not_reached();
+    }
+
+    ret = ibv_post_send(rdma->qp, send_wr, &bad_wr);
+    if (ret == ENOMEM && rdma->nb_sent) {
+        trace_rdma_post_send_queue_full(send_wr->wr_id, rdma->nb_sent);
+        ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NULL);
+        if (ret < 0) {
+            error_setg(errp, "rdma migration: failed to make room for %s",
+                       wr_desc);
+            return false;
+        }
+        ret = ibv_post_send(rdma->qp, send_wr, &bad_wr);
+    }
+
+    if (ret > 0) {
+        error_setg_errno(errp, ret, "rdma migration: post %s failed",
+                         wr_desc);
+        return false;
+    }
+
+    return true;
+}
+
 /*
  * Post a SEND message work request for the control channel
  * containing some data and block until the post completes.
@@ -1433,7 +1478,6 @@ static int qemu_rdma_post_send_control(RDMAContext *rdma, uint8_t *buf,
 {
     int ret;
     RDMAWorkRequestData *wr = &rdma->wr_data[RDMA_WRID_CONTROL];
-    struct ibv_send_wr *bad_wr;
     struct ibv_sge sge = {
                            .addr = (uintptr_t)(wr->control),
                            .length = head->len + sizeof(RDMAControlHeader),
@@ -1465,11 +1509,7 @@ static int qemu_rdma_post_send_control(RDMAContext *rdma, uint8_t *buf,
         memcpy(wr->control + sizeof(RDMAControlHeader), buf, head->len);
     }
 
-
-    ret = ibv_post_send(rdma->qp, &send_wr, &bad_wr);
-
-    if (ret > 0) {
-        error_setg(errp, "Failed to use post IB SEND for control");
+    if (!qemu_rdma_post_send(rdma, &send_wr, errp)) {
         return -1;
     }
 
@@ -1729,7 +1769,6 @@ static int qemu_rdma_write_one(RDMAContext *rdma,
 {
     struct ibv_sge sge;
     struct ibv_send_wr send_wr = { 0 };
-    struct ibv_send_wr *bad_wr;
     int reg_result_idx, ret, count = 0;
     uint64_t chunk, chunks;
     uint64_t chunk_size = migrate_rdma_chunk_size();
@@ -1743,7 +1782,6 @@ static int qemu_rdma_write_one(RDMAContext *rdma,
                                .repeat = 1,
                              };
 
-retry:
     sge.addr = (uintptr_t)(block->local_host_addr +
                             (current_addr - block->offset));
     sge.length = length;
@@ -1900,26 +1938,7 @@ retry:
     trace_rdma_write_one_post(chunk, sge.addr, send_wr.wr.rdma.remote_addr,
                                    sge.length);
 
-    /*
-     * ibv_post_send() does not return negative error numbers,
-     * per the specification they are positive - no idea why.
-     */
-    ret = ibv_post_send(rdma->qp, &send_wr, &bad_wr);
-
-    if (ret == ENOMEM) {
-        trace_rdma_write_one_queue_full();
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
+    if (!qemu_rdma_post_send(rdma, &send_wr, errp)) {
         return -1;
     }
 
diff --git a/migration/trace-events b/migration/trace-events
index e87d4abd91..2ee2c8f212 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -245,7 +245,7 @@ rdma_resolve_host_trying(const char *host, const char *ip) "Trying %s => %s"
 rdma_write_flush(int sent) "sent total: %d"
 rdma_write_one_block(int count, int block, uint64_t chunk, uint64_t current, uint64_t len, int nb_sent, int nb_chunks) "(%d) Not clobbering: block: %d chunk %" PRIu64 " current %" PRIu64 " len %" PRIu64 " %d %d"
 rdma_write_one_post(uint64_t chunk, long addr, long remote, uint32_t len) "Posting chunk: %" PRIu64 ", addr: 0x%lx remote: 0x%lx, bytes %" PRIu32
-rdma_write_one_queue_full(void) ""
+rdma_post_send_queue_full(uint64_t wr_id, int sent) "send queue full, wr_id=%" PRIu64 ", outstanding writes=%d"
 rdma_write_one_recvregres(int mykey, int theirkey, uint64_t chunk) "Received registration result: my key: 0x%x their key 0x%x, chunk %" PRIu64
 rdma_write_one_sendreg(uint64_t chunk, int len, int index, int64_t offset) "Sending registration request chunk %" PRIu64 " for %d bytes, index: %d, offset: %" PRId64
 rdma_write_one_top(uint64_t chunks, uint64_t size) "Writing %" PRIu64 " chunks, (%" PRIu64 " MB)"
-- 
2.53.0


