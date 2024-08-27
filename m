Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8CAC52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 08:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sirhn-0004XG-K3; Tue, 27 Aug 2024 04:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sirhl-0004VW-OK
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 04:37:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sirhj-0000VH-VX
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 04:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724747847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lNGyJd6a1fHUkeHTa+agjaUASrR9gJyGuVVoRtAw3mc=;
 b=L6xPwo5vOIWqz7a4oVEq2B47ukRyg5qNidSlcUi3V/HjrCw54vUF1WXX82G/CfyEh3za00
 iSjhxbzne15dbt8cPWi3gibkY0UhnecGwV203i5JLzmf6Ky213WJW6lKSrSxE/oy5GzDUk
 uyeneLL7MSRBaZXlmulejdKXhSO4hOE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-wwRfa919NS-gnOKExh7y9Q-1; Tue,
 27 Aug 2024 04:37:23 -0400
X-MC-Unique: wwRfa919NS-gnOKExh7y9Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 130F21955F2F; Tue, 27 Aug 2024 08:37:22 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.114])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 45DAC1956054; Tue, 27 Aug 2024 08:37:16 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v1] softmmu/physmem: fix memory leak in dirty_memory_extend()
Date: Tue, 27 Aug 2024 10:37:15 +0200
Message-ID: <20240827083715.257768-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

As reported by Peter, we might be leaking memory when removing the
highest RAMBlock (in the weird ram_addr_t space), and adding a new one.

We will fail to realize that we already allocated bitmaps for more
dirty memory blocks, and effectively discard the pointers to them.

Fix it by getting rid of last_ram_page() and simply storing the number
of dirty memory blocks that have been allocated. We'll store the number
of blocks along with the actual pointer to keep it simple.

Looks like this leak was introduced as we switched from using a single
bitmap_zero_extend() to allocating multiple bitmaps:
bitmap_zero_extend() relies on g_renew() which should have taken care of
this.

Resolves: https://lkml.kernel.org/r/CAFEAcA-k7a+VObGAfCFNygQNfCKL=AfX6A4kScq=VSSK0peqPg@mail.gmail.com
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: 5b82b703b69a ("memory: RCU ram_list.dirty_memory[] for safe RAM hotplug")
Cc: qemu-stable@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/exec/ramlist.h |  1 +
 system/physmem.c       | 44 ++++++++++++++----------------------------
 2 files changed, 16 insertions(+), 29 deletions(-)

diff --git a/include/exec/ramlist.h b/include/exec/ramlist.h
index 2ad2a81acc..f2a965f293 100644
--- a/include/exec/ramlist.h
+++ b/include/exec/ramlist.h
@@ -41,6 +41,7 @@ typedef struct RAMBlockNotifier RAMBlockNotifier;
 #define DIRTY_MEMORY_BLOCK_SIZE ((ram_addr_t)256 * 1024 * 8)
 typedef struct {
     struct rcu_head rcu;
+    unsigned int num_blocks;
     unsigned long *blocks[];
 } DirtyMemoryBlocks;
 
diff --git a/system/physmem.c b/system/physmem.c
index 94600a33ec..fa48ff8333 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1534,18 +1534,6 @@ static ram_addr_t find_ram_offset(ram_addr_t size)
     return offset;
 }
 
-static unsigned long last_ram_page(void)
-{
-    RAMBlock *block;
-    ram_addr_t last = 0;
-
-    RCU_READ_LOCK_GUARD();
-    RAMBLOCK_FOREACH(block) {
-        last = MAX(last, block->offset + block->max_length);
-    }
-    return last >> TARGET_PAGE_BITS;
-}
-
 static void qemu_ram_setup_dump(void *addr, ram_addr_t size)
 {
     int ret;
@@ -1799,28 +1787,31 @@ void qemu_ram_msync(RAMBlock *block, ram_addr_t start, ram_addr_t length)
 }
 
 /* Called with ram_list.mutex held */
-static void dirty_memory_extend(ram_addr_t old_ram_size,
-                                ram_addr_t new_ram_size)
+static void dirty_memory_extend(ram_addr_t new_ram_size)
 {
-    ram_addr_t old_num_blocks = DIV_ROUND_UP(old_ram_size,
-                                             DIRTY_MEMORY_BLOCK_SIZE);
     ram_addr_t new_num_blocks = DIV_ROUND_UP(new_ram_size,
                                              DIRTY_MEMORY_BLOCK_SIZE);
     int i;
 
-    /* Only need to extend if block count increased */
-    if (new_num_blocks <= old_num_blocks) {
-        return;
-    }
-
     for (i = 0; i < DIRTY_MEMORY_NUM; i++) {
         DirtyMemoryBlocks *old_blocks;
         DirtyMemoryBlocks *new_blocks;
+        ram_addr_t old_num_blocks = 0;
         int j;
 
         old_blocks = qatomic_rcu_read(&ram_list.dirty_memory[i]);
+        if (old_blocks) {
+            old_num_blocks = old_blocks->num_blocks;
+
+            /* Only need to extend if block count increased */
+            if (new_num_blocks <= old_num_blocks) {
+                return;
+            }
+        }
+
         new_blocks = g_malloc(sizeof(*new_blocks) +
                               sizeof(new_blocks->blocks[0]) * new_num_blocks);
+        new_blocks->num_blocks = new_num_blocks;
 
         if (old_num_blocks) {
             memcpy(new_blocks->blocks, old_blocks->blocks,
@@ -1846,11 +1837,9 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
     RAMBlock *block;
     RAMBlock *last_block = NULL;
     bool free_on_error = false;
-    ram_addr_t old_ram_size, new_ram_size;
+    ram_addr_t ram_size;
     Error *err = NULL;
 
-    old_ram_size = last_ram_page();
-
     qemu_mutex_lock_ramlist();
     new_block->offset = find_ram_offset(new_block->max_length);
 
@@ -1901,11 +1890,8 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         }
     }
 
-    new_ram_size = MAX(old_ram_size,
-              (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS);
-    if (new_ram_size > old_ram_size) {
-        dirty_memory_extend(old_ram_size, new_ram_size);
-    }
+    ram_size = (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS;
+    dirty_memory_extend(ram_size);
     /* Keep the list sorted from biggest to smallest block.  Unlike QTAILQ,
      * QLIST (which has an RCU-friendly variant) does not have insertion at
      * tail, so save the last element in last_block.
-- 
2.46.0


