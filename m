Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF55CC0219C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 10:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgL9g-0006u8-81; Fri, 07 Feb 2025 05:00:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tgL9e-0006qf-0V; Fri, 07 Feb 2025 05:00:10 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tgL9b-00024M-Ox; Fri, 07 Feb 2025 05:00:09 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 23BB6E7349;
 Fri, 07 Feb 2025 12:59:18 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8D7451B09CD;
 Fri,  7 Feb 2025 12:59:59 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 817B652D7B; Fri, 07 Feb 2025 12:59:59 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Steve Sistare <steven.sistare@oracle.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.1 45/49] physmem: fix qemu_ram_alloc_from_fd size
 calculation
Date: Fri,  7 Feb 2025 12:59:47 +0300
Message-Id: <20250207095956.2238705-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.1-20250207102656@cover.tls.msk.ru>
References: <qemu-stable-9.2.1-20250207102656@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

qemu_ram_alloc_from_fd allocates space if file_size == 0.  If non-zero,
it uses the existing space and verifies it is large enough, but the
verification was broken when the offset parameter was introduced.  As
a result, a file smaller than offset passes the verification and causes
errors later.  Fix that, and update the error message to include offset.

Peter provides this concise reproducer:

  $ touch ramfile
  $ truncate -s 64M ramfile
  $ ./qemu-system-x86_64 -object memory-backend-file,mem-path=./ramfile,offset=128M,size=128M,id=mem1,prealloc=on
  qemu-system-x86_64: qemu_prealloc_mem: preallocating memory failed: Bad address

With the fix, the error message is:
  qemu-system-x86_64: mem1 backing store size 0x4000000 is too small for 'size' option 0x8000000 plus 'offset' option 0x8000000

Cc: qemu-stable@nongnu.org
Fixes: 4b870dc4d0c0 ("hostmem-file: add offset option")
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/1736967650-129648-3-git-send-email-steven.sistare@oracle.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
(cherry picked from commit 719168fba7c3215cc996dcfd32a6e5e9c7b8eee0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/system/physmem.c b/system/physmem.c
index dc1db3a384..75389064a8 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1970,10 +1970,12 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
     size = REAL_HOST_PAGE_ALIGN(size);
 
     file_size = get_file_size(fd);
-    if (file_size > offset && file_size < (offset + size)) {
-        error_setg(errp, "backing store size 0x%" PRIx64
-                   " does not match 'size' option 0x" RAM_ADDR_FMT,
-                   file_size, size);
+    if (file_size && file_size < offset + size) {
+        error_setg(errp, "%s backing store size 0x%" PRIx64
+                   " is too small for 'size' option 0x" RAM_ADDR_FMT
+                   " plus 'offset' option 0x%" PRIx64,
+                   memory_region_name(mr), file_size, size,
+                   (uint64_t)offset);
         return NULL;
     }
 
-- 
2.39.5


