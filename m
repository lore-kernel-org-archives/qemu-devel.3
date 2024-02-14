Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC13C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 15:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raH1B-00082o-Fa; Wed, 14 Feb 2024 10:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1raH19-0007zL-OD
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 10:17:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1raH17-0000QD-3N
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 10:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707923864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rxV7qmtkwuVczLTxmNjIfKVqthnX4qcJ3g6F4Fre2ks=;
 b=fMRTX2kKrMOZZX8/j/6pOeUBGYDSIa0vnaQ3o4wDg+UE5yBFc+Wc1zEpqMSeupn87HSprv
 NSjMWShXr9FQVVr7kUlL80mHs47YvqDLl3C9peW4G9DOVh91rk9liUE3+LdgvHwheCMKpu
 8nDlS4VhGHIcxn7zGraMm/hBejAsgsc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-Q7LVip_nP9qwIh6bjHgeBQ-1; Wed,
 14 Feb 2024 10:17:40 -0500
X-MC-Unique: Q7LVip_nP9qwIh6bjHgeBQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7294C3812582;
 Wed, 14 Feb 2024 15:17:40 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.174])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 67A841C066A9;
 Wed, 14 Feb 2024 15:17:37 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Raphael Norwitz <raphael@enfabrica.net>
Subject: [PATCH v2 11/14] libvhost-user: Use most of mmap_offset as fd_offset
Date: Wed, 14 Feb 2024 16:16:58 +0100
Message-ID: <20240214151701.29906-12-david@redhat.com>
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

================ Vhost user message ================
Request: VHOST_USER_ADD_MEM_REG (37)
Flags:   0x9
Size:    40
Fds: 59
Adding region 4
    guest_phys_addr: 0x0000000200000000
    memory_size:     0x0000000040000000
    userspace_addr:  0x00007fb73bffe000
    old mmap_offset: 0x0000000080000000
    fd_offset:       0x0000000080000000
    new mmap_offset: 0x0000000000000000
    mmap_addr:       0x00007f02f1bdc000
Successfully added new region
================ Vhost user message ================
Request: VHOST_USER_ADD_MEM_REG (37)
Flags:   0x9
Size:    40
Fds: 59
Adding region 5
    guest_phys_addr: 0x0000000240000000
    memory_size:     0x0000000040000000
    userspace_addr:  0x00007fb77bffe000
    old mmap_offset: 0x00000000c0000000
    fd_offset:       0x00000000c0000000
    new mmap_offset: 0x0000000000000000
    mmap_addr:       0x00007f0284000000
Successfully added new region

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 54 ++++++++++++++++++++---
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index ef6353d847..55aef5fcc6 100644
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
@@ -281,12 +283,32 @@ vu_remove_all_mem_regs(VuDev *dev)
     dev->nregions = 0;
 }
 
+static size_t
+get_fd_hugepagesize(int fd)
+{
+#if defined(__linux__)
+    struct statfs fs;
+    int ret;
+
+    do {
+        ret = fstatfs(fd, &fs);
+    } while (ret != 0 && errno == EINTR);
+
+    if (!ret && (unsigned int)fs.f_type == HUGETLBFS_MAGIC) {
+        return fs.f_bsize;
+    }
+#endif
+    return 0;
+}
+
 static void
 _vu_add_mem_reg(VuDev *dev, VhostUserMemoryRegion *msg_region, int fd)
 {
     const uint64_t start_gpa = msg_region->guest_phys_addr;
     const uint64_t end_gpa = start_gpa + msg_region->memory_size;
     int prot = PROT_READ | PROT_WRITE;
+    uint64_t mmap_offset, fd_offset;
+    size_t hugepagesize;
     VuDevRegion *r;
     void *mmap_addr;
     int low = 0;
@@ -300,7 +322,7 @@ _vu_add_mem_reg(VuDev *dev, VhostUserMemoryRegion *msg_region, int fd)
            msg_region->memory_size);
     DPRINT("    userspace_addr:  0x%016"PRIx64"\n",
            msg_region->userspace_addr);
-    DPRINT("    mmap_offset:     0x%016"PRIx64"\n",
+    DPRINT("    old mmap_offset: 0x%016"PRIx64"\n",
            msg_region->mmap_offset);
 
     if (dev->postcopy_listening) {
@@ -335,11 +357,31 @@ _vu_add_mem_reg(VuDev *dev, VhostUserMemoryRegion *msg_region, int fd)
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
+    hugepagesize = get_fd_hugepagesize(fd);
+    if (hugepagesize) {
+        fd_offset = ALIGN_DOWN(msg_region->mmap_offset, hugepagesize);
+        mmap_offset = msg_region->mmap_offset - fd_offset;
+    } else {
+        fd_offset = msg_region->mmap_offset;
+        mmap_offset = 0;
+    }
+
+    DPRINT("    fd_offset:       0x%016"PRIx64"\n",
+           fd_offset);
+    DPRINT("    new mmap_offset: 0x%016"PRIx64"\n",
+           mmap_offset);
+
+    mmap_addr = mmap(0, msg_region->memory_size + mmap_offset,
+                     prot, MAP_SHARED | MAP_NORESERVE, fd, fd_offset);
     if (mmap_addr == MAP_FAILED) {
         vu_panic(dev, "region mmap error: %s", strerror(errno));
         return;
@@ -354,7 +396,7 @@ _vu_add_mem_reg(VuDev *dev, VhostUserMemoryRegion *msg_region, int fd)
     r->size = msg_region->memory_size;
     r->qva = msg_region->userspace_addr;
     r->mmap_addr = (uint64_t)(uintptr_t)mmap_addr;
-    r->mmap_offset = msg_region->mmap_offset;
+    r->mmap_offset = mmap_offset;
     dev->nregions++;
 
     if (dev->postcopy_listening) {
-- 
2.43.0


