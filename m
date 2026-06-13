Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1413CCD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYVBl-0006pS-Ex; Sat, 13 Jun 2026 16:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYVBe-0006XG-Uy; Sat, 13 Jun 2026 16:42:40 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYVBd-0005ad-1J; Sat, 13 Jun 2026 16:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781382966; bh=Qa5RM/R3DMq9VLRLiufaoNNUf9HV7xjAG3zxZJj488Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=nxr76iDsmNDP87fj58y9pa2BwViBb27e/3AvWV11wgffQouWmSInWX6bvJCw+LOhp
 rcZRnyNDfd2LubcAyrdQ6oFhO/lW3vXfocKRqHPI3x1dqpDUjflJfvcwUQ+aR+QWCu
 D5kM6mMTgO6xxRAYRr1v08osd+JEg12f9El4eifR4nPRINBR/6xTCwOOfIOLBuzQEt
 09pITDg9BtGXSV3kQNm6nBh7wY1pgsnCFP5wxkocIbUw+xgnO0M46PrYkTJJQVbzGe
 IkaSKCI/KkR3yUSEI/w/O/4IzGlAIuDqXULKcZdVERKq7FRGSH4iAyldFq/uVLmYNr
 ZxhjJHO5o9ptw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AC78F1B6F25;
 Sat, 13 Jun 2026 23:36:06 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 217023CE96E;
 Sat, 13 Jun 2026 23:36:25 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 66/72] block/export/fuse: set
 FUSE_DIRECT_IO_ALLOW_MMAP flag to fix regression
Date: Sat, 13 Jun 2026 23:35:32 +0300
Message-ID: <20260613203542.1809153-66-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Fiona Ebner <f.ebner@proxmox.com>

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
Message-ID: <20260506145424.10249-3-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit d1664a4058b2b4285d281d32c81ef646f78e7d9a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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


