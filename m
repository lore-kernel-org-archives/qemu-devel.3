Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80982C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 20:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww3t6-0003sa-9D; Mon, 17 Aug 2026 16:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ww3t4-0003s1-Go
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:24:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ww3t2-0002no-8t
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786998287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E5SAQhGwnMDxads+Ng+Bj5sib/0faYYO8RUGLjuUJBc=;
 b=YFgw+qiLDBP6FMiN+tM+WRqoGmh1YRBk2igbRX9xO7qsINDkbijzzYsL/GXRb/SI6BqmUb
 X2hFHW2QUmzrA2d6Ludjtx1QInVGiMsz8iz/tbIbFgUzIALi3jDANdcfolw1aw9DyR0pOh
 cygKlWy7MJXf58OW2864EmUylzo3RnQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-gK3bNDFNPWmofi68-F5lRw-1; Mon, 17 Aug 2026 16:24:45 -0400
X-MC-Unique: gK3bNDFNPWmofi68-F5lRw-1
X-Mimecast-MFC-AGG-ID: gK3bNDFNPWmofi68-F5lRw_1786998285
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e63df032bso34748985a.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 13:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786998285; x=1787603085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E5SAQhGwnMDxads+Ng+Bj5sib/0faYYO8RUGLjuUJBc=;
 b=kD2igYjMmLdo6EEgDl6/yZJclZJD77q93EyvAe9NgyKZQax4kWe5GFnAjkvydC3J5J
 EDut7RJdg5My3VnZ6psuALQgS/J1rBHnnkaIW4CDNmj529Vb1CMKavCNZ0w46BVfDh75
 L35XZV1pvUpeXdtKnPI3fZU9ZKqxQP1s23LJQeT/xghKBJlPUYsnECpsvL38Ze95pxP3
 OWDDCmn/iEwPDi/7y2qp5y9XBEtK8oWdRhJWbPAt0uXyQLZhdcAhrqeqiV8JKh1e8sH7
 K74qokda0vdGf3+lVCHhPlREfZgPpjWc40Fvu5Ba1MICM4ZMvkYqAqQL4TPVW1BMFVY6
 rouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786998285; x=1787603085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=E5SAQhGwnMDxads+Ng+Bj5sib/0faYYO8RUGLjuUJBc=;
 b=R3fIkBriF2gpIJj/MZ+TZ1W9iqWRr3WsSDe89pHGsx7AdbJumKvHGmK6+1rkCqyMR5
 zJNqLPwScTqDx6sbSFeyOnSW2LAzAx4+OB1IcmW4t2IklMZGw9ig3/DJk2evh2mgV4ij
 Khy8DeTBFu/gzQWYvzrKpdIc/X4VXSlKuBNrdShi6goTi/5C2pN9amuR/Bb0XCfyN4hX
 I05CWpxS6zHnJ+ey8rroaywpW+FtZll7fzaHWXscf+UjtIcD2KRQCrUzbR7351JhsWRO
 KtVULwes7UwbQi/4TIz/EJl5SgNRtSRVXFkvr8oyDlNpy1oyj5MV2s7CA7L4/Z93cxCD
 V8Yw==
X-Gm-Message-State: AOJu0Yw1oUDaaA2mkDQiveHsSYGvmOsp9mRbHxwAz4mmTudHyTX1hTkt
 JYyBPOSnSWPZeEa23f9g0M+a7R9RqFfU/bABBuoNKPMfAYRhWlnk7fAILCWB4U1Xc/0JEuw1U5A
 Z72aQCHNRYwNyg3BOriiWroWCcPrhosUsHUp+peNGwNhiagSlMbd1Ac+XsIkeEzqAzWKIpbX9z2
 oXxmZcC55UdQEp4p2ykQ73XU4+YZp9RSy1Kn4BBQ==
X-Gm-Gg: AR+sD13zIxhwDx0Q34bbsoVWik+t9qRZd2+KGw+G4wea0A+frv8WSTxf/vY4ad6fYuo
 VFJXClJzjA12AAyQt7wi6qcG4qaV1N2mqgVr7+QvCD2qxsTaB+QEQ44sKHGB4jaRBYnsvcY+vcC
 fL11kJY29jWJLg5SFFvfnhFaYwZdSkD+R68Zqq8sslB7R0Yd4oPiehjw9OAIiSA6gG3h7Vkhha/
 Z7K1Aub26NT31K2G4dNE8k6hwivrjMYGx5MkQfqsB4VxYlhCT6j7QGaKQ3PAQxFUeYxp2ZQCnFJ
 mi5OSrpzz8tI/TavQvIPaJPNA2RxBMUfsf4QZLkPqP3AxSa/+ZE/mJj2lNybZC8Rsg==
X-Received: by 2002:a05:622a:5815:b0:51c:4f35:81b8 with SMTP id
 d75a77b69052e-52dbed36031mr20836791cf.7.1786998284786; 
 Mon, 17 Aug 2026 13:24:44 -0700 (PDT)
X-Received: by 2002:a05:622a:5815:b0:51c:4f35:81b8 with SMTP id
 d75a77b69052e-52dbed36031mr20835971cf.7.1786998284142; 
 Mon, 17 Aug 2026 13:24:44 -0700 (PDT)
Received: from x1.com ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52db6136569sm22865761cf.12.2026.08.17.13.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 13:24:43 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>, Samuel Zhang <guoqing.zhang@amd.com>,
 Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Jack Wang <jinpu.wang@ionos.com>, Juraj Marcin <jmarcin@redhat.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>
Subject: [PATCH 04/10] migration/rdma: Drop RDMALocalBlock.is_ram_block
Date: Mon, 17 Aug 2026 16:24:18 -0400
Message-ID: <20260817202424.2901438-5-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260817202424.2901438-1-peterx@redhat.com>
References: <20260817202424.2901438-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c | 73 ++++++++++++++----------------------------------
 1 file changed, 21 insertions(+), 52 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index ffae0a887f..354935433c 100644
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
@@ -441,14 +440,12 @@ static void register_to_network(RDMAContext *rdma, RDMARegister *reg)
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
@@ -585,8 +582,6 @@ static void rdma_add_block(RDMAContext *rdma, const char *block_name,
     bitmap_clear(block->unregister_bitmap, 0, block->nb_chunks);
     block->remote_keys = g_new0(uint32_t, block->nb_chunks);
 
-    block->is_ram_block = local->init ? false : true;
-
     if (rdma->blockmap) {
         g_hash_table_insert(rdma->blockmap, (void *)(uintptr_t)block_offset, block);
     }
@@ -1767,19 +1762,10 @@ retry:
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
@@ -1804,7 +1790,7 @@ retry:
         }
     }
 
-    if (!rdma->pin_all || !block->is_ram_block) {
+    if (!rdma->pin_all) {
         if (!block->remote_keys[chunk]) {
             /*
              * This chunk has not yet been registered, so first check to see
@@ -1853,11 +1839,7 @@ retry:
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
@@ -3408,30 +3390,17 @@ int rdma_registration_handle(QEMUFile *f)
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


