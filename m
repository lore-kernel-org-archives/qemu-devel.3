Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4321C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHO9-0006KH-Mw; Thu, 02 Jul 2026 09:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wfHNs-0005zX-8H; Thu, 02 Jul 2026 09:23:23 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wfHNp-0001v7-R2; Thu, 02 Jul 2026 09:23:15 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 6DB7CA2DE6;
 Thu, 02 Jul 2026 15:23:03 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 qemu-stable@nongnu.org
Subject: [PATCH 1/2] block/export/fuse: fix regression with O_TRUNC when
 export is not growable
Date: Thu,  2 Jul 2026 15:22:35 +0200
Message-ID: <20260702132256.661429-2-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702132256.661429-1-f.ebner@proxmox.com>
References: <20260702132256.661429-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1782998575601
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

Before commit a94a1d7699 ("fuse: Manually process requests (without
libfuse)"), the O_TRUNC flag when open()-ing an export would be
ignored. This is because libfuse sets FUSE_CAP_ATOMIC_O_TRUNC, so the
kernel lets user space handle the O_TRUNC flag, which is ignored by
the fuse code for export. After the commit, FUSE_CAP_ATOMIC_O_TRUNC is
not set anymore, so the O_TRUNC flag is handled by the kernel, which
executes a truncate.

For blockdev-based exports, this causes a regression, because opening
with O_TRUNC would previously work, but results in an ENOTSUP after
commit a94a1d7699. For file-based exports, the fact that truncate is
executed can be considered an improvement in general. However, in
combination with growable=off, this still results in a practical
regression in combination with virt-fw-vars, which opens its output
file with O_TRUNC and previously worked with a file-based export with
growable=off. After commit a94a1d7699, the file is truncated upon open
and then cannot grow, meaning virt-fw-vars won't be able to write the
output.

To fix these regressions, while keeping the improved behavior for
file-based exports with growable=on, set the FUSE_CAP_ATOMIC_O_TRUNC
flag again if growable=off.

Cc: qemu-stable@nongnu.org
Fixes: a94a1d7699 ("fuse: Manually process requests (without libfuse)")
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block/export/fuse.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index c0e8dfb643..9ae22a2e00 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -859,6 +859,18 @@ fuse_co_init(FuseExport *exp, struct fuse_init_out *out,
     uint32_t supported_flags = FUSE_ASYNC_READ | FUSE_ASYNC_DIO;
     uint32_t flags2 = 0;
 
+    if (!exp->growable) {
+        /*
+         * Back when libfuse was used, it would always set this flag and thus
+         * the kernel did not execute a truncate itself and passed along O_TRUNC
+         * to user space. Continue setting the flag for backwards compatibility
+         * when the export is not growable to avoid issues with O_TRUNC, i.e.
+         * blockdev-based exports running into ENOTSUP and file-based exports
+         * with growable=off to be truncated and then stuck with size 0.
+         */
+        supported_flags = FUSE_ATOMIC_O_TRUNC;
+    }
+
     if (in->major != 7) {
         error_report("FUSE major version mismatch: We have 7, but kernel has %"
                      PRIu32, in->major);
-- 
2.47.3



