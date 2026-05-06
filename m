Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABB7CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKdeh-0006fd-QE; Wed, 06 May 2026 10:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wKdeK-0006Rw-5g; Wed, 06 May 2026 10:54:57 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wKdeG-0005sA-Uw; Wed, 06 May 2026 10:54:55 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 6996780AF6;
 Wed, 06 May 2026 16:54:39 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 qemu-stable@nongnu.org
Subject: [PATCH 2/3] block/export/fuse: set FUSE_DIRECT_IO_ALLOW_MMAP flag to
 fix regression
Date: Wed,  6 May 2026 16:49:57 +0200
Message-ID: <20260506145424.10249-3-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260506145424.10249-1-f.ebner@proxmox.com>
References: <20260506145424.10249-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1778079171208
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Commit 8599559580 ("fuse: Set direct_io and parallel_direct_writes")
broke use cases that require mmap() with MAP_SHARED on the export. In
particular, swtpm_setup using its 'file://' protocol requires this.
From the kernel documentation [0]:

> To allow shared mmap, the FUSE_DIRECT_IO_ALLOW_MMAP flag may be
> enabled in the FUSE_INIT reply.

Set the FUSE_DIRECT_IO_ALLOW_MMAP flag to restore compatibility with
users requiring shared mmap. The FUSE_INIT_EXT flag needs to be set
for the flags2 member to have an effect.

[0]: https://www.kernel.org/doc/html/next/filesystems/fuse/fuse-io.html

Cc: qemu-stable@nongnu.org
Fixes: 8599559580 ("fuse: Set direct_io and parallel_direct_writes")
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block/export/fuse.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 35218e3197..c0e8dfb643 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -856,7 +856,8 @@ static ssize_t coroutine_fn GRAPH_RDLOCK
 fuse_co_init(FuseExport *exp, struct fuse_init_out *out,
              const struct fuse_init_in *in)
 {
-    const uint32_t supported_flags = FUSE_ASYNC_READ | FUSE_ASYNC_DIO;
+    uint32_t supported_flags = FUSE_ASYNC_READ | FUSE_ASYNC_DIO;
+    uint32_t flags2 = 0;
 
     if (in->major != 7) {
         error_report("FUSE major version mismatch: We have 7, but kernel has %"
@@ -871,13 +872,21 @@ fuse_co_init(FuseExport *exp, struct fuse_init_out *out,
         return -EINVAL;
     }
 
+    if (!using_old_fuse_init_in(in)) {
+        /* The flags2 flags must be shifted down by 32 bits. */
+        const uint32_t supported_flags2 = FUSE_DIRECT_IO_ALLOW_MMAP >> 32;
+        /* flags2 is only considered if FUSE_INIT_EXT is set. */
+        supported_flags = supported_flags | FUSE_INIT_EXT;
+        flags2 = in->flags2 & supported_flags2;
+    }
+
     *out = (struct fuse_init_out) {
         .major = 7,
         .minor = MIN(FUSE_KERNEL_MINOR_VERSION, in->minor),
         .max_readahead = in->max_readahead,
         .max_write = FUSE_MAX_WRITE_BYTES,
         .flags = in->flags & supported_flags,
-        .flags2 = 0,
+        .flags2 = flags2,
 
         /* libfuse maximum: 2^16 - 1 */
         .max_background = UINT16_MAX,
-- 
2.47.3



