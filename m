Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF30C98325
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA82V-0006k3-KG; Fri, 25 Sep 2026 11:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xA82U-0006jF-1i
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:40:42 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xA82S-0004ch-3B
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:40:41 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B66C81FFD7;
 Fri, 25 Sep 2026 15:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790350834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+G12ss+6Bd8+EazhCD6uIyuAyXQ3cIZopSQxJRJcs2o=;
 b=Mk6E1SH+cv+dxvRPdlI0BZYa6pkPSig2dX3qQPsUbetXc6rS1VexZ1yrPauWr0kGKJImcB
 TUST2WmDcFRiOa8RNf+2/zquwtz2mA5pE+SwIjEyqyiplP5TZdSaYcB0eH3VC3jzhtdn9D
 URoeKZJqnlv6pazeYQFuA+1uXi11B68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790350834;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+G12ss+6Bd8+EazhCD6uIyuAyXQ3cIZopSQxJRJcs2o=;
 b=3WNKu3Pa/KY8klk95/qo5p8+t9Pg3aFa2eAkqwiPhO6PSJTb/HyA8Mt8Mo61kX/wFxsNly
 1phi65FK6ZWuK8Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790350830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+G12ss+6Bd8+EazhCD6uIyuAyXQ3cIZopSQxJRJcs2o=;
 b=eCLVmBfc1MxFCljsAffJouDBMUitmx11o8H8PcWUSofNRgFaXngKbOHu5yg7n1Uit4fQMm
 l4ejGM2UCDWsivmM0mXHdfOTcX/bw0z1C8fh0dfH4t4ocm68jBmH4TewclnHC30nPR38eo
 kAbh7mojIqDaIU+CjkYD6WP3DCyuB54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790350830;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+G12ss+6Bd8+EazhCD6uIyuAyXQ3cIZopSQxJRJcs2o=;
 b=XeCxx8qcbHFLBaihHB3fBdbaY9JwPx6R4xbLEc9iIGjs3TEtFllAosvDy26KImG6EsU/qw
 sbHixiKNwjWPJMCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7AEF613274;
 Fri, 25 Sep 2026 15:40:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xxRgCd2VtmqjOwAAD6G6ig:T12
 (envelope-from <farosas@suse.de>); Fri, 25 Sep 2026 15:40:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Yanfei Xu <yanfei.xu@bytedance.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PULL 11/19] migration/rdma: Remove unused transit bitmap
Date: Fri, 25 Sep 2026 12:40:02 -0300
Message-ID: <20260925154010.599247-12-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925154010.599247-1-farosas@suse.de>
References: <20260925154010.599247-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ionos.com:email,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,bytedance.com:email];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
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

After the per-chunk write wait is removed, transit_bitmap is no longer
read.  The remaining set and clear operations only maintain unused
state.

Remove the bitmap and simplify the block lifecycle tracepoints.

Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/rdma.c       | 20 +++-----------------
 migration/trace-events |  4 ++--
 2 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index da5dff2f9b..444123cbca 100644
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
@@ -1905,8 +1893,7 @@ static int qemu_rdma_write_one(RDMAContext *rdma,
     /*
      * Encode the ram block index and chunk within this wrid.
      * We will use this information at the time of completion
-     * to figure out which bitmap to check against and then which
-     * chunk in the bitmap to look for.
+     * to identify the completed write in trace output.
      */
     send_wr.wr_id = qemu_rdma_make_wrid(RDMA_WRID_RDMA_WRITE,
                                         current_index, chunk);
@@ -1925,7 +1912,6 @@ static int qemu_rdma_write_one(RDMAContext *rdma,
         return -1;
     }
 
-    set_bit(chunk, block->transit_bitmap);
     qatomic_add(&mig_stats.normal_pages, sge.length / qemu_target_page_size());
     /*
      * We are adding to transferred the amount of data written, but no
diff --git a/migration/trace-events b/migration/trace-events
index 00ac737aa9..db911fe6f2 100644
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
2.53.0


