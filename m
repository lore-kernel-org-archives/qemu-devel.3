Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA39C4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 21:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rW1UK-0008TQ-Hk; Fri, 02 Feb 2024 16:54:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rW1UI-0008Lg-Fx
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 16:54:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rW1UA-0004uV-Ni
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 16:54:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706910850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=77r2j9eRnlux52n9mVjVt4CTYLtK8feRXEl2IUvTNLM=;
 b=EY4t4n9hBsfXpm+EWex8duGH9BGe5SHgBBhruSJJyBFqmisEPRUEjBi/jvR2LSaJaKWbV8
 lNInLYlQ+doMjFhNyrARJOjhV29NKB9VMAjjnnspTIQn8Yalhw6itrNXYI5AvBq7bN57cA
 3uZ5plyr7eqjqDWDVRXi8PmpCeTiwy8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-VEH01V6kP-u9EfeQSdCp_w-1; Fri,
 02 Feb 2024 16:54:08 -0500
X-MC-Unique: VEH01V6kP-u9EfeQSdCp_w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 056D029AA38E;
 Fri,  2 Feb 2024 21:54:08 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 791022166B31;
 Fri,  2 Feb 2024 21:54:06 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PATCH v1 12/15] libvhost-user: Use most of mmap_offset as fd_offset
Date: Fri,  2 Feb 2024 22:53:29 +0100
Message-ID: <20240202215332.118728-13-david@redhat.com>
In-Reply-To: <20240202215332.118728-1-david@redhat.com>
References: <20240202215332.118728-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.276,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

In the past, QEMU would create memory regions that could partially cover
hugetlb pages, making mmap() fail if we would use the mmap_offset as an
fd_offset. For that reason, we never used the mmap_offset as an offset into
the fd and instead always mapped the fd from the very start.

However, that can easily result in us mmap'ing a lot of unnecessary
parts of an fd, possibly repeatedly.

QEMU nowadays does not create memory regions that partially cover huge
pages -- it never really worked with postcopy. QEMU handles merging of
regions that partially cover huge pages (due to holes in boot memory) since
2018 in c1ece84e7c93 ("vhost: Huge page align and merge").

Let's be a bit careful and not unconditionally convert the
mmap_offset into an fd_offset. Instead, let's simply detect the hugetlb
size and pass as much as we can as fd_offset, making sure that we call
mmap() with a properly aligned offset.

With QEMU and a virtio-mem device that is fully plugged (50GiB using 50
memslots) the qemu-storage daemon process consumes in the VA space
1281GiB before this change and 58GiB after this change.

Example debug output:
  ================ Vhost user message ================
  Request: VHOST_USER_ADD_MEM_REG (37)
  Flags:   0x9
  Size:    40
  Fds: 59
  Adding region 50
      guest_phys_addr: 0x0000000d80000000
      memory_size:     0x0000000040000000
      userspace_addr   0x00007f54ebffe000
      mmap_offset      0x0000000c00000000
      fd_offset:       0x0000000c00000000
      new mmap_offset: 0x0000000000000000
      mmap_addr:       0x00007f7ecc000000
  Successfully added new region
  ================ Vhost user message ================
  Request: VHOST_USER_ADD_MEM_REG (37)
  Flags:   0x9
  Size:    40
  Fds: 59
  Adding region 51
      guest_phys_addr: 0x0000000dc0000000
      memory_size:     0x0000000040000000
      userspace_addr   0x00007f552bffe000
      mmap_offset      0x0000000c40000000
      fd_offset:       0x0000000c40000000
      new mmap_offset: 0x0000000000000000
      mmap_addr:       0x00007f7e8c000000
  Successfully added new region

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 50 ++++++++++++++++++++---
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 75e47b7bb3..7d8293dc84 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -43,6 +43,8 @@
 #include <fcntl.h>
 #include <sys/ioctl.h>
 #include <linux/vhost.h>
+#include <sys/vfs.h>
+#include <linux/magic.h>
 
 #ifdef __NR_userfaultfd
 #include <linux/userfaultfd.h>
@@ -281,12 +283,36 @@ vu_remove_all_mem_regs(VuDev *dev)
     dev->nregions = 0;
 }
 
+static size_t
+get_fd_pagesize(int fd)
+{
+    static size_t pagesize;
+#if defined(__linux__)
+    struct statfs fs;
+    int ret;
+
+    do {
+        ret = fstatfs(fd, &fs);
+    } while (ret != 0 && errno == EINTR);
+
+    if (!ret && fs.f_type == HUGETLBFS_MAGIC) {
+        return fs.f_bsize;
+    }
+#endif
+
+    if (!pagesize) {
+        pagesize = getpagesize();
+    }
+    return pagesize;
+}
+
 static void
 _vu_add_mem_reg(VuDev *dev, VhostUserMemoryRegion *msg_region, int fd)
 {
     const uint64_t start_gpa = msg_region->guest_phys_addr;
     const uint64_t end_gpa = start_gpa + msg_region->memory_size;
     int prot = PROT_READ | PROT_WRITE;
+    uint64_t mmap_offset, fd_offset;
     VuDevRegion *r;
     void *mmap_addr;
     int low = 0;
@@ -335,11 +361,25 @@ _vu_add_mem_reg(VuDev *dev, VhostUserMemoryRegion *msg_region, int fd)
     idx = low;
 
     /*
-     * We don't use offset argument of mmap() since the mapped address has
-     * to be page aligned, and we use huge pages.
+     * Convert most of msg_region->mmap_offset to fd_offset. In almost all
+     * cases, this will leave us with mmap_offset == 0, mmap()'ing only
+     * what we really need. Only if a memory region would partially cover
+     * hugetlb pages, we'd get mmap_offset != 0, which usually doesn't happen
+     * anymore (i.e., modern QEMU).
+     *
+     * Note that mmap() with hugetlb would fail if the offset into the file
+     * is not aligned to the huge page size.
      */
-    mmap_addr = mmap(0, msg_region->memory_size + msg_region->mmap_offset,
-                     prot, MAP_SHARED | MAP_NORESERVE, fd, 0);
+    fd_offset = ALIGN_DOWN(msg_region->mmap_offset, get_fd_pagesize(fd));
+    mmap_offset = msg_region->mmap_offset - fd_offset;
+
+    DPRINT("    fd_offset:       0x%016"PRIx64"\n",
+           fd_offset);
+    DPRINT("    adj mmap_offset: 0x%016"PRIx64"\n",
+           mmap_offset);
+
+    mmap_addr = mmap(0, msg_region->memory_size + mmap_offset,
+                     prot, MAP_SHARED | MAP_NORESERVE, fd, fd_offset);
     if (mmap_addr == MAP_FAILED) {
         vu_panic(dev, "region mmap error: %s", strerror(errno));
         return;
@@ -354,7 +394,7 @@ _vu_add_mem_reg(VuDev *dev, VhostUserMemoryRegion *msg_region, int fd)
     r->size = msg_region->memory_size;
     r->qva = msg_region->userspace_addr;
     r->mmap_addr = (uint64_t)(uintptr_t)mmap_addr;
-    r->mmap_offset = msg_region->mmap_offset;
+    r->mmap_offset = mmap_offset;
     dev->nregions++;
 
     if (dev->postcopy_listening) {
-- 
2.43.0


