Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F726C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 16:04:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzyzR-0001U9-2i; Fri, 28 Aug 2026 11:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzyzL-0001P8-SL
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:59:33 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzyzA-0008PO-5G
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:59:31 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 282CF1FED2;
 Fri, 28 Aug 2026 15:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787932754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8srkfRBJ8tr/sXtX0mTfj4YigIbqYI314IE+GV72yvo=;
 b=gyHLjYwG2NUP8vpsESgdDbmpW3mienS5U2qxHBZse5mLM6zDS/q70q92F2bw9EcrX6qdWs
 652JmNlK+cqPE5/zO847uLE2mpMKsm94VO0dcXHgd03t6byeWsJYqwrILMpwsP7lspCW79
 2f5f/+YOthxnY9eF2bf2I8+C0H02faQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787932754;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8srkfRBJ8tr/sXtX0mTfj4YigIbqYI314IE+GV72yvo=;
 b=5Szx8NsDgGQrKuqtEyEsQBnHTnKCjfqxMMHjq0vFrCRgB9MLZStSOWGqAjJhKi9aKXYTJp
 9x1TKboisg08pmAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787932750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8srkfRBJ8tr/sXtX0mTfj4YigIbqYI314IE+GV72yvo=;
 b=V56D2LX2WiAdVGAU0i2V5d/tRZ/BMDsGo7t71giHsCbnQsS/YTmtQlJKw9QVJipjCNZX/Z
 Oy/7FD16ckrpgrQ+/h1FvQn5yIvzvA/70DoIEyTCPAD/m22oegnkPDwEou8POjQydkvDrl
 hG7uQ0HKcB7ise+0noKrJO9xMIkB3BQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787932750;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8srkfRBJ8tr/sXtX0mTfj4YigIbqYI314IE+GV72yvo=;
 b=Y2ZvS5kumnVkPpS6Lch4aku15DfO84dX389SY1tJeXDCTvIKddgjmkcJYDAIx4rH/wx8Td
 rT90LgvYWPbbGRAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1FA9713691;
 Fri, 28 Aug 2026 15:59:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qJRdOEywkWpoBQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 28 Aug 2026 15:59:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Jinpu Wang <jinpu.wang@cloud.ionos.com>
Subject: [PULL v2 15/30] migration/rdma: Drop RDMALocalBlock.is_ram_block
Date: Fri, 28 Aug 2026 12:58:30 -0300
Message-ID: <20260828155845.2874508-16-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828155845.2874508-1-farosas@suse.de>
References: <20260828155845.2874508-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.993];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ionos.com:email,imap1.dmz-prg2.suse.org:helo,gitlab.com:url,suse.de:email,suse.de:mid];
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

From: Peter Xu <peterx@redhat.com>

This is guaranteed to be true.  There seems to have support for some
dynamically allocated buffers but it was never really supported.  Remove
dead code.

As a side effect, this patch closes a report by removing the buggy code
completely.

Reported-by: Tristan (@TristanInSec)
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4006
Reviewed-by: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/rdma.c | 75 ++++++++++++++----------------------------------
 1 file changed, 21 insertions(+), 54 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index ffae0a887f6..63a8370be22 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -196,7 +196,6 @@ typedef struct RDMALocalBlock {
     uint32_t       remote_rkey;     /* rkeys for non-chunk-level registration */
     int            index;           /* which block are we */
     unsigned int   src_index;       /* (Only used on dest) */
-    bool           is_ram_block;
     int            nb_chunks;
     unsigned long *transit_bitmap;
     unsigned long *unregister_bitmap;
@@ -279,7 +278,6 @@ static void network_to_dest_block(RDMADestBlock *db)
  */
 typedef struct RDMALocalBlocks {
     int nb_blocks;
-    bool     init;             /* main memory init complete */
     RDMALocalBlock *block;
 } RDMALocalBlocks;
 
@@ -441,14 +439,12 @@ static void register_to_network(RDMAContext *rdma, RDMARegister *reg)
     RDMALocalBlock *local_block;
     local_block  = &rdma->local_ram_blocks.block[reg->current_index];
 
-    if (local_block->is_ram_block) {
-        /*
-         * current_addr as passed in is an address in the local ram_addr_t
-         * space, we need to translate this for the destination
-         */
-        reg->key.current_addr -= local_block->offset;
-        reg->key.current_addr += rdma->dest_blocks[reg->current_index].offset;
-    }
+    /*
+     * current_addr as passed in is an address in the local ram_addr_t
+     * space, we need to translate this for the destination
+     */
+    reg->key.current_addr -= local_block->offset;
+    reg->key.current_addr += rdma->dest_blocks[reg->current_index].offset;
     reg->key.current_addr = htonll(reg->key.current_addr);
     reg->current_index = htonl(reg->current_index);
     reg->chunks = htonll(reg->chunks);
@@ -585,8 +581,6 @@ static void rdma_add_block(RDMAContext *rdma, const char *block_name,
     bitmap_clear(block->unregister_bitmap, 0, block->nb_chunks);
     block->remote_keys = g_new0(uint32_t, block->nb_chunks);
 
-    block->is_ram_block = local->init ? false : true;
-
     if (rdma->blockmap) {
         g_hash_table_insert(rdma->blockmap, (void *)(uintptr_t)block_offset, block);
     }
@@ -634,7 +628,6 @@ static void qemu_rdma_init_ram_blocks(RDMAContext *rdma)
     trace_rdma_init_ram_blocks(local->nb_blocks);
     rdma->dest_blocks = g_new0(RDMADestBlock,
                                rdma->local_ram_blocks.nb_blocks);
-    local->init = true;
 }
 
 /*
@@ -1767,19 +1760,10 @@ retry:
     chunk = ram_chunk_index(block->local_host_addr,
                             (uint8_t *)(uintptr_t)sge.addr);
     chunk_start = ram_chunk_start(block, chunk);
+    chunks = length / chunk_size;
 
-    if (block->is_ram_block) {
-        chunks = length / chunk_size;
-
-        if (chunks && ((length % chunk_size) == 0)) {
-            chunks--;
-        }
-    } else {
-        chunks = block->length / chunk_size;
-
-        if (chunks && ((block->length % chunk_size) == 0)) {
-            chunks--;
-        }
+    if (chunks && ((length % chunk_size) == 0)) {
+        chunks--;
     }
 
     trace_rdma_write_one_top(chunks + 1,
@@ -1804,7 +1788,7 @@ retry:
         }
     }
 
-    if (!rdma->pin_all || !block->is_ram_block) {
+    if (!rdma->pin_all) {
         if (!block->remote_keys[chunk]) {
             /*
              * This chunk has not yet been registered, so first check to see
@@ -1853,11 +1837,7 @@ retry:
              * Otherwise, tell other side to register.
              */
             reg.current_index = current_index;
-            if (block->is_ram_block) {
-                reg.key.current_addr = current_addr;
-            } else {
-                reg.key.chunk = chunk;
-            }
+            reg.key.current_addr = current_addr;
             reg.chunks = chunks;
 
             trace_rdma_write_one_sendreg(chunk, sge.length, current_index,
@@ -3408,30 +3388,17 @@ int rdma_registration_handle(QEMUFile *f)
                     goto err;
                 }
                 block = &(rdma->local_ram_blocks.block[reg->current_index]);
-                if (block->is_ram_block) {
-                    if (block->offset > reg->key.current_addr) {
-                        error_report("rdma: bad register address for block %s"
-                            " offset: %" PRIx64 " current_addr: %" PRIx64,
-                            block->block_name, block->offset,
-                            reg->key.current_addr);
-                        goto err;
-                    }
-                    host_addr = (block->local_host_addr +
-                                (reg->key.current_addr - block->offset));
-                    chunk = ram_chunk_index(block->local_host_addr,
-                                            (uint8_t *) host_addr);
-                } else {
-                    chunk = reg->key.chunk;
-                    host_addr = block->local_host_addr +
-                        (reg->key.chunk * migrate_rdma_chunk_size());
-                    /* Check for particularly bad chunk value */
-                    if (host_addr < (void *)block->local_host_addr) {
-                        error_report("rdma: bad chunk for block %s"
-                            " chunk: %" PRIx64,
-                            block->block_name, reg->key.chunk);
-                        goto err;
-                    }
+                if (block->offset > reg->key.current_addr) {
+                    error_report("rdma: bad register address for block %s"
+                        " offset: %" PRIx64 " current_addr: %" PRIx64,
+                        block->block_name, block->offset,
+                        reg->key.current_addr);
+                    goto err;
                 }
+                host_addr = (block->local_host_addr +
+                            (reg->key.current_addr - block->offset));
+                chunk = ram_chunk_index(block->local_host_addr,
+                                        (uint8_t *) host_addr);
                 chunk_start = ram_chunk_start(block, chunk);
                 chunk_end = ram_chunk_end(block, chunk + reg->chunks);
                 /* avoid "-Waddress-of-packed-member" warning */
-- 
2.53.0


