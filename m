Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3368C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 15:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raH18-0007tV-RP; Wed, 14 Feb 2024 10:17:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1raH14-0007rQ-8R
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 10:17:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1raH12-0000Pi-Ks
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 10:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707923859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=my+wGO0YbSzMmtMrev16Z2y1/ALKJa0gbZGKAXKRFuU=;
 b=RNemFPjlITP8ed2QZA+qYeJ7sEEthJRJnmHYkPF1Yb5SsO4ft9aVoik8Avb9joKrezaq2x
 SYDIDmQKTJ9EtO1kJsoCfJJCu9OOPQa8Jh96hPrSg6ajKcq35gH/CrGJshM3hJk98tfST1
 Pu/0ED9zSCtRpOrXbYbhhEiQBzekUeQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-1gBfL7e-NsauB3GKoh2iyA-1; Wed, 14 Feb 2024 10:17:37 -0500
X-MC-Unique: 1gBfL7e-NsauB3GKoh2iyA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 23A9D85CDF2;
 Wed, 14 Feb 2024 15:17:37 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.174])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E9831C03428;
 Wed, 14 Feb 2024 15:17:34 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Raphael Norwitz <raphael@enfabrica.net>
Subject: [PATCH v2 10/14] libvhost-user: Speedup gpa_to_mem_region() and
 vu_gpa_to_va()
Date: Wed, 14 Feb 2024 16:16:57 +0100
Message-ID: <20240214151701.29906-11-david@redhat.com>
In-Reply-To: <20240214151701.29906-1-david@redhat.com>
References: <20240214151701.29906-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

Let's speed up GPA to memory region / virtual address lookup. Store the
memory regions ordered by guest physical addresses, and use binary
search for address translation, as well as when adding/removing memory
regions.

Most importantly, this will speed up GPA->VA address translation when we
have many memslots.

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 49 +++++++++++++++++++++--
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index d72f25396d..ef6353d847 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -199,19 +199,30 @@ vu_panic(VuDev *dev, const char *msg, ...)
 static VuDevRegion *
 vu_gpa_to_mem_region(VuDev *dev, uint64_t guest_addr)
 {
-    unsigned int i;
+    int low = 0;
+    int high = dev->nregions - 1;
 
     /*
      * Memory regions cannot overlap in guest physical address space. Each
      * GPA belongs to exactly one memory region, so there can only be one
      * match.
+     *
+     * We store our memory regions ordered by GPA and can simply perform a
+     * binary search.
      */
-    for (i = 0; i < dev->nregions; i++) {
-        VuDevRegion *cur = &dev->regions[i];
+    while (low <= high) {
+        unsigned int mid = low + (high - low) / 2;
+        VuDevRegion *cur = &dev->regions[mid];
 
         if (guest_addr >= cur->gpa && guest_addr < cur->gpa + cur->size) {
             return cur;
         }
+        if (guest_addr >= cur->gpa + cur->size) {
+            low = mid + 1;
+        }
+        if (guest_addr < cur->gpa) {
+            high = mid - 1;
+        }
     }
     return NULL;
 }
@@ -273,9 +284,14 @@ vu_remove_all_mem_regs(VuDev *dev)
 static void
 _vu_add_mem_reg(VuDev *dev, VhostUserMemoryRegion *msg_region, int fd)
 {
+    const uint64_t start_gpa = msg_region->guest_phys_addr;
+    const uint64_t end_gpa = start_gpa + msg_region->memory_size;
     int prot = PROT_READ | PROT_WRITE;
     VuDevRegion *r;
     void *mmap_addr;
+    int low = 0;
+    int high = dev->nregions - 1;
+    unsigned int idx;
 
     DPRINT("Adding region %d\n", dev->nregions);
     DPRINT("    guest_phys_addr: 0x%016"PRIx64"\n",
@@ -295,6 +311,29 @@ _vu_add_mem_reg(VuDev *dev, VhostUserMemoryRegion *msg_region, int fd)
         prot = PROT_NONE;
     }
 
+    /*
+     * We will add memory regions into the array sorted by GPA. Perform a
+     * binary search to locate the insertion point: it will be at the low
+     * index.
+     */
+    while (low <= high) {
+        unsigned int mid = low + (high - low)  / 2;
+        VuDevRegion *cur = &dev->regions[mid];
+
+        /* Overlap of GPA addresses. */
+        if (start_gpa < cur->gpa + cur->size && cur->gpa < end_gpa) {
+            vu_panic(dev, "regions with overlapping guest physical addresses");
+            return;
+        }
+        if (start_gpa >= cur->gpa + cur->size) {
+            low = mid + 1;
+        }
+        if (start_gpa < cur->gpa) {
+            high = mid - 1;
+        }
+    }
+    idx = low;
+
     /*
      * We don't use offset argument of mmap() since the mapped address has
      * to be page aligned, and we use huge pages.
@@ -308,7 +347,9 @@ _vu_add_mem_reg(VuDev *dev, VhostUserMemoryRegion *msg_region, int fd)
     DPRINT("    mmap_addr:       0x%016"PRIx64"\n",
            (uint64_t)(uintptr_t)mmap_addr);
 
-    r = &dev->regions[dev->nregions];
+    /* Shift all affected entries by 1 to open a hole at idx. */
+    r = &dev->regions[idx];
+    memmove(r + 1, r, sizeof(VuDevRegion) * (dev->nregions - idx));
     r->gpa = msg_region->guest_phys_addr;
     r->size = msg_region->memory_size;
     r->qva = msg_region->userspace_addr;
-- 
2.43.0


