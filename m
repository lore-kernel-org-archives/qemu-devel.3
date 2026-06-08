Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807EBCD8C8E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWUYf-0004n2-Bp; Mon, 08 Jun 2026 03:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wWUYI-0004mK-N4
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:37:44 -0400
Received: from [115.124.30.131] (helo=out30-131.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wWUXt-0006vk-QC
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780904196; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=uVXs4uKozx10/GNq7As9iMdwia3TumrKyskF0JGC//4=;
 b=R6H5QZwtQITb8SOPHorWlD2NenhSXCoGM8wDV4vDapsLlEOaJDBUpblQYmRKPG7Go1xL5zOLL6/kL5VxUEQJpXvlPjgsizHwZQAbqegP7zNMHPgjpF27yPfrcPV+gTGsHu5zF6BVuLodWJECVQsRojlThNfxt5kBj+dRFClJrT4=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R881e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam011083073210;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0X4LMWly_1780904194; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X4LMWly_1780904194 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 08 Jun 2026 15:36:34 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@kernel.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH] hw/virtio: balloon: access RAMBlock directly via mr->ram_block
Date: Mon,  8 Jun 2026 15:36:32 +0800
Message-ID: <20260608073632.1113-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.131 (deferred)
Received-SPF: pass client-ip=115.124.30.131;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-131.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

The balloon inflate/deflate paths obtained the RAMBlock through a
round-trip: compute host VA via memory_region_get_ram_ptr(), then
reverse-lookup via qemu_ram_block_from_host() which linearly scans
the RAMBlock list.

Since memory_region_find() already resolves to the concrete RAM
MemoryRegion (aliases flattened), mr->ram_block is guaranteed valid
and mr_offset directly serves as the RAMBlock offset.  Use this to
eliminate the unnecessary VA computation and list walk.

This also removes the long-standing XXX comment asking for a better
approach.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 hw/virtio/virtio-balloon.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 4c5f486ba2..4a7f0bb9a8 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -80,21 +80,15 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
                                  MemoryRegion *mr, hwaddr mr_offset,
                                  PartiallyBalloonedPage *pbp)
 {
-    void *addr = memory_region_get_ram_ptr(mr) + mr_offset;
-    ram_addr_t rb_offset, rb_aligned_offset, base_gpa;
-    RAMBlock *rb;
+    RAMBlock *rb = mr->ram_block;
+    ram_addr_t rb_aligned_offset, base_gpa;
     size_t rb_page_size;
     int subpages;
 
-    /* XXX is there a better way to get to the RAMBlock than via a
-     * host address? */
-    rb = qemu_ram_block_from_host(addr, false, &rb_offset);
     rb_page_size = qemu_ram_pagesize(rb);
 
     if (rb_page_size == BALLOON_PAGE_SIZE) {
-        /* Easy case */
-
-        ram_block_discard_range(rb, rb_offset, rb_page_size);
+        ram_block_discard_range(rb, mr_offset, rb_page_size);
         /* We ignore errors from ram_block_discard_range(), because it
          * has already reported them, and failing to discard a balloon
          * page is not fatal */
@@ -110,10 +104,9 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
     warn_report_once(
 "Balloon used with backing page size > 4kiB, this may not be reliable");
 
-    rb_aligned_offset = QEMU_ALIGN_DOWN(rb_offset, rb_page_size);
+    rb_aligned_offset = QEMU_ALIGN_DOWN(mr_offset, rb_page_size);
     subpages = rb_page_size / BALLOON_PAGE_SIZE;
-    base_gpa = memory_region_get_ram_addr(mr) + mr_offset -
-               (rb_offset - rb_aligned_offset);
+    base_gpa = memory_region_get_ram_addr(mr) + rb_aligned_offset;
 
     if (pbp->bitmap && !virtio_balloon_pbp_matches(pbp, base_gpa)) {
         /* We've partially ballooned part of a host page, but now
@@ -126,7 +119,7 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
         virtio_balloon_pbp_alloc(pbp, base_gpa, subpages);
     }
 
-    set_bit((rb_offset - rb_aligned_offset) / BALLOON_PAGE_SIZE,
+    set_bit((mr_offset - rb_aligned_offset) / BALLOON_PAGE_SIZE,
             pbp->bitmap);
 
     if (bitmap_full(pbp->bitmap, subpages)) {
@@ -144,19 +137,14 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
 static void balloon_deflate_page(VirtIOBalloon *balloon,
                                  MemoryRegion *mr, hwaddr mr_offset)
 {
-    void *addr = memory_region_get_ram_ptr(mr) + mr_offset;
-    ram_addr_t rb_offset;
-    RAMBlock *rb;
+    RAMBlock *rb = mr->ram_block;
     size_t rb_page_size;
     void *host_addr;
     int ret;
 
-    /* XXX is there a better way to get to the RAMBlock than via a
-     * host address? */
-    rb = qemu_ram_block_from_host(addr, false, &rb_offset);
     rb_page_size = qemu_ram_pagesize(rb);
-
-    host_addr = (void *)((uintptr_t)addr & ~(rb_page_size - 1));
+    host_addr = qemu_ram_get_host_addr(rb) +
+                QEMU_ALIGN_DOWN(mr_offset, rb_page_size);
 
     /* When a page is deflated, we hint the whole host page it lives
      * on, since we can't do anything smaller */
-- 
2.50.1 (Apple Git-155)


