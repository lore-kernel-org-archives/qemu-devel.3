Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B71C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 20:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx8zP-0008Ur-Ci; Thu, 20 Aug 2026 16:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wx8zO-0008Ui-2j
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:03:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wx8zM-0005DB-4S
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787256227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AeXHJa6e2Krc0rxpv0YEuzHdoFnWYceRPQkLOOt2s5U=;
 b=NChoha0kfy12s4VJ1cQQ9cOesnuWlrMZapj6vFCETWZf2lFLwY8v70MeCiZ4MfKS2ltJv6
 iLuXmZ4AiNqYId/UtS0wPZ7dDjfcKkrDB1q9rb2Bd9JCR95Pgd1Sh+dCaqbCvNrBz4RYzP
 KpXbqyPSjimf9BSpyrl8WWwpL07MzB0=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-sAJ3raxoPAWP3ClWrw3Rdw-1; Thu, 20 Aug 2026 16:03:46 -0400
X-MC-Unique: sAJ3raxoPAWP3ClWrw3Rdw-1
X-Mimecast-MFC-AGG-ID: sAJ3raxoPAWP3ClWrw3Rdw_1787256225
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-6b14d9c02b7so259281eaf.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 13:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787256225; x=1787861025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AeXHJa6e2Krc0rxpv0YEuzHdoFnWYceRPQkLOOt2s5U=;
 b=BflD6CokNh85JqKsEQE4jWglcjJhe8oomVu89eW/YptocUP5RsPPRxjz+21AvsN3Kc
 xfvvpwwy97bcnGCb97OGwkWBr4b2Iyl5fdPJ4rskuLgMhkki7HmfKfexEr9JzrKMv5I+
 opkkPctPIFwVOpcjoX3hnA1D+1rilt/gyDNVIqdr52Ow1vvl90+64M0XWC5taDvzhfFW
 kL23nqn7MRpPK0P3lxHSST14JL87fOixzQS1NcYcOxRj6FjvB4EVXEvxbtaNG4+ID4P0
 s5hXyST6+SFElULmgTPg7yjD1zBNbqhl3IvPbRiT8bSFMB1OtMB2sAUZe4MHdsjeXf2F
 GMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787256225; x=1787861025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AeXHJa6e2Krc0rxpv0YEuzHdoFnWYceRPQkLOOt2s5U=;
 b=WnkHVmkGXogT4l1ThOubMKREVQvdyKFsKn6z41GRrRaqsK1hKtCHw+9yo+g1osd69U
 rdj4PFboV3Y1/OcapWezU+Dg64KaNHa4XrI0RN6Kn7kkfkh6n11wON0n/vYE/JXecUW6
 C9DutcFqZzlIQxhccxzaR4Co+pNfiMLU+UpoYFz+uiOIR9Loh7ilekBu5UGHyWRjZ7KD
 XFsKXV+Q7UNCIM7I8cNcGJ7zvOtqK4tpY2md5jqdg4IF+jnBgA9Kd50WWxr6Vx+QJPPk
 j8VnrFUQa8ww/opTlQhB7FdH2xbm+IxXJ6Ct0o5Zls7fZrQ+lXsMshZq5Gs07qPlhbko
 Zwww==
X-Gm-Message-State: AOJu0YyeQ2korDU/hwytctjeAfarxiEJvX/yEIrs4MNYAklg9mg4daJD
 2y9lePlwR9JhEdYTyVz+UG3PW5/FqSI5+LE+uYlUB7Gb5s8Vvu3vXG3NYdl8acRqGAZdN/yXBHa
 Fe8ZvP2P4MBVzoxtvqp47lwosm387oZzT0KX0hrqD+cl4PXbImcsuNWcXrR/mUl2JiJnkxsLlkL
 yY2PJ9W3ksQOP0zW2RdFktW23hOGVtFFh3e10YkQ==
X-Gm-Gg: AR+sD124+axn5jbwpcG1EH707gC7Tr1ksF2llBWdcq/N6LpipLfHkEztc4rqRBzDHNt
 1wYijX3/KHvkg2ntpXz0ki3rXKKjhcxumAFEwXgbnGjCLxsdeGEWo2aPUKwJ90VlFhAsHhlVvm/
 YkBlvo8UL7doPiFaWwtGa3YeZDfnOo+T8oIhPiDuyxJTKih1kcHnUs8UMMfQKt8WeNRjrrqG7Fa
 uo2mBrL+cGsAxsfA15CTb/ePbO3etPxyoVMGRj799cVFbrpQGZ+ZVj8iXNZ5kOEkMST9ChEQ/Ic
 WK9bVckryAuIFxvckxfx1Ox+Wu2s3G9h10i7MFpfpI5KdtNA8m6Vt0qm5lNbqgvMhb/aXieMRY7
 D0N8+94GAqlAUwVWoJfabJqylgbb7GVOuLTHBqPDJswu8rnQC0LfJcpP0COk=
X-Received: by 2002:a05:6820:5712:10b0:6ab:1d3:bbf2 with SMTP id
 006d021491bc7-6b1594630bbmr989238eaf.25.1787256225211; 
 Thu, 20 Aug 2026 13:03:45 -0700 (PDT)
X-Received: by 2002:a05:6820:5712:10b0:6ab:1d3:bbf2 with SMTP id
 006d021491bc7-6b1594630bbmr989167eaf.25.1787256224610; 
 Thu, 20 Aug 2026 13:03:44 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b13cebeb2esm6181314eaf.10.2026.08.20.13.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 13:03:35 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jack Wang <jinpu.wang@ionos.com>, Peter Xu <peterx@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Samuel Zhang <guoqing.zhang@amd.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>,
 Jinpu Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH v2 04/10] migration/rdma: Drop RDMALocalBlock.is_ram_block
Date: Thu, 20 Aug 2026 16:03:16 -0400
Message-ID: <20260820200322.3321036-5-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820200322.3321036-1-peterx@redhat.com>
References: <20260820200322.3321036-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is guaranteed to be true.  There seems to have support for some
dynamically allocated buffers but it was never really supported.  Remove
dead code.

As a side effect, this patch closes a report by removing the buggy code
completely.

Reported-by: Tristan (@TristanInSec)
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4006
Reviewed-by: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c | 75 ++++++++++++++----------------------------------
 1 file changed, 21 insertions(+), 54 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index ffae0a887f..63a8370be2 100644
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
2.54.0


