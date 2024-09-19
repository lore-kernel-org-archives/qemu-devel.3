Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CABA2CF3942
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srHUf-0007kN-0H; Thu, 19 Sep 2024 09:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1srHUU-00078J-TI
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:46:39 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1srHUQ-000609-UN
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=+ITeZviAUjdU79Lh7KnozJBelk/8symZBSM8bBXNmh8=; b=hTDDoJfmTCNi14vv
 2lkRR0W9oAS61ad+vNLQYnVT/ZBeE7aOct/u4ZB1qvUNirQ1FGSSPXgl85gnGse/y6vetv0u6SDEi
 zcTkWb0AegkR44sjgko7In5ZEKj9RqpYwY0tPyFhKbMxLbI/xkE8I/3xkvK4lXUf9SfaoaV/iN/DJ
 bDalJNs+YVSlBfj7HPPvUTUOBR1VPa+prD5i2OqjPqKuNQsRqQ837y5+9IB91B0HG5ag1Ci7bZ7On
 7K/4q/9wQTHpozhv+zhZYtTNq9YYXbjhdS/2RJARnFqPxi8JflDU3ZDeezUkMWFaJZ4yUTdk8kLtq
 kC5JhoYLQ8s+c4bs3Q==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1srHUN-006QOJ-0s;
 Thu, 19 Sep 2024 13:46:31 +0000
From: dave@treblig.org
To: peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com
Cc: qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v2 5/7] util/userfaultfd: Return -errno on error
Date: Thu, 19 Sep 2024 14:46:24 +0100
Message-ID: <20240919134626.166183-6-dave@treblig.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240919134626.166183-1-dave@treblig.org>
References: <20240919134626.166183-1-dave@treblig.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

Convert (the currently unused) uffd_wakeup, uffd_copy_page and
uffd_zero_page to return -errno on error rather than -1.

That will make it easier to reuse in postcopy.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 util/userfaultfd.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/util/userfaultfd.c b/util/userfaultfd.c
index 1b2fa949d4..518d5c3586 100644
--- a/util/userfaultfd.c
+++ b/util/userfaultfd.c
@@ -240,7 +240,7 @@ int uffd_change_protection(int uffd_fd, void *addr, uint64_t length,
  * Copy range of source pages to the destination to resolve
  * missing page fault somewhere in the destination range.
  *
- * Returns 0 on success, negative value in case of an error
+ * Returns 0 on success, -errno in case of an error
  *
  * @uffd_fd: UFFD file descriptor
  * @dst_addr: destination base address
@@ -259,10 +259,11 @@ int uffd_copy_page(int uffd_fd, void *dst_addr, void *src_addr,
     uffd_copy.mode = dont_wake ? UFFDIO_COPY_MODE_DONTWAKE : 0;
 
     if (ioctl(uffd_fd, UFFDIO_COPY, &uffd_copy)) {
+        int e = errno;
         error_report("uffd_copy_page() failed: dst_addr=%p src_addr=%p length=%" PRIu64
                 " mode=%" PRIx64 " errno=%i", dst_addr, src_addr,
-                length, (uint64_t) uffd_copy.mode, errno);
-        return -1;
+                length, (uint64_t) uffd_copy.mode, e);
+        return -e;
     }
 
     return 0;
@@ -273,7 +274,7 @@ int uffd_copy_page(int uffd_fd, void *dst_addr, void *src_addr,
  *
  * Fill range pages with zeroes to resolve missing page fault within the range.
  *
- * Returns 0 on success, negative value in case of an error
+ * Returns 0 on success, -errno in case of an error
  *
  * @uffd_fd: UFFD file descriptor
  * @addr: base address
@@ -289,10 +290,11 @@ int uffd_zero_page(int uffd_fd, void *addr, uint64_t length, bool dont_wake)
     uffd_zeropage.mode = dont_wake ? UFFDIO_ZEROPAGE_MODE_DONTWAKE : 0;
 
     if (ioctl(uffd_fd, UFFDIO_ZEROPAGE, &uffd_zeropage)) {
+        int e = errno;
         error_report("uffd_zero_page() failed: addr=%p length=%" PRIu64
                 " mode=%" PRIx64 " errno=%i", addr, length,
-                (uint64_t) uffd_zeropage.mode, errno);
-        return -1;
+                (uint64_t) uffd_zeropage.mode, e);
+        return -e;
     }
 
     return 0;
@@ -306,7 +308,7 @@ int uffd_zero_page(int uffd_fd, void *addr, uint64_t length, bool dont_wake)
  * via UFFD-IO IOCTLs with MODE_DONTWAKE flag set, then after that all waits
  * for the whole memory range are satisfied in a single call to uffd_wakeup().
  *
- * Returns 0 on success, negative value in case of an error
+ * Returns 0 on success, -errno in case of an error
  *
  * @uffd_fd: UFFD file descriptor
  * @addr: base address
@@ -320,9 +322,10 @@ int uffd_wakeup(int uffd_fd, void *addr, uint64_t length)
     uffd_range.len = length;
 
     if (ioctl(uffd_fd, UFFDIO_WAKE, &uffd_range)) {
+        int e = errno;
         error_report("uffd_wakeup() failed: addr=%p length=%" PRIu64 " errno=%i",
-                addr, length, errno);
-        return -1;
+                addr, length, e);
+        return -e;
     }
 
     return 0;
-- 
2.46.1


