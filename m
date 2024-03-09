Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6DDC54798
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 07:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rirbF-000632-Sk; Sat, 09 Mar 2024 02:58:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rirbE-00062h-Pa
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 02:58:32 -0500
Received: from out-172.mta1.migadu.com ([95.215.58.172])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rirbD-000115-C7
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 02:58:32 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1709971109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wiWWspnbi7Q0vNoPD9xXbXnmFAa8r696Hl2OxFjqnzs=;
 b=o/p1rxAWK6f4X8iNK1bH6qYJOIByuZx7ER8vWQvUmqZ76KcqAeZObPSH9GzBwBQWakAq6H
 5YJA2MqiBzfnWXfK0n5vYosrF55Mb1BFdNyEk7VTsXmd6crBvkpJ33cwMjiCqyOCxeoY0s
 K2h43aXmwtchpK89bF837OFZry/eHgI=
From: Hao Xiang <hao.xiang@linux.dev>
To: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 qemu-devel@nongnu.org
Subject: [PATCH v5 2/7] migration/multifd: Allow clearing of the file_bmap
 from multifd
Date: Sat,  9 Mar 2024 07:57:23 +0000
Message-Id: <20240309075728.1487211-3-hao.xiang@linux.dev>
In-Reply-To: <20240309075728.1487211-1-hao.xiang@linux.dev>
References: <20240309075728.1487211-1-hao.xiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.172; envelope-from=hao.xiang@linux.dev;
 helo=out-172.mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

We currently only need to clear the mapped-ram file bitmap from the
migration thread during save_zero_page.

We're about to add support for zero page detection on the multifd
thread, so allow ramblock_set_file_bmap_atomic() to also clear the
bits.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 2 +-
 migration/ram.c     | 8 ++++++--
 migration/ram.h     | 3 ++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index d4a44da559..6b8a78e4ca 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -115,7 +115,7 @@ static void multifd_set_file_bitmap(MultiFDSendParams *p)
     assert(pages->block);
 
     for (int i = 0; i < p->pages->num; i++) {
-        ramblock_set_file_bmap_atomic(pages->block, pages->offset[i]);
+        ramblock_set_file_bmap_atomic(pages->block, pages->offset[i], true);
     }
 }
 
diff --git a/migration/ram.c b/migration/ram.c
index 003c28e133..f4abc47bbf 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3150,9 +3150,13 @@ static void ram_save_file_bmap(QEMUFile *f)
     }
 }
 
-void ramblock_set_file_bmap_atomic(RAMBlock *block, ram_addr_t offset)
+void ramblock_set_file_bmap_atomic(RAMBlock *block, ram_addr_t offset, bool set)
 {
-    set_bit_atomic(offset >> TARGET_PAGE_BITS, block->file_bmap);
+    if (set) {
+        set_bit_atomic(offset >> TARGET_PAGE_BITS, block->file_bmap);
+    } else {
+        clear_bit_atomic(offset >> TARGET_PAGE_BITS, block->file_bmap);
+    }
 }
 
 /**
diff --git a/migration/ram.h b/migration/ram.h
index b9ac0da587..08feecaf51 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -75,7 +75,8 @@ bool ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *rb, Error **errp);
 bool ramblock_page_is_discarded(RAMBlock *rb, ram_addr_t start);
 void postcopy_preempt_shutdown_file(MigrationState *s);
 void *postcopy_preempt_thread(void *opaque);
-void ramblock_set_file_bmap_atomic(RAMBlock *block, ram_addr_t offset);
+void ramblock_set_file_bmap_atomic(RAMBlock *block, ram_addr_t offset,
+                                   bool set);
 
 /* ram cache */
 int colo_init_ram_cache(void);
-- 
2.30.2


