Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42825D1D487
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 12:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veBJb-0005wS-9N; Fri, 09 Jan 2026 07:10:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1veBIW-0005af-LL; Fri, 09 Jan 2026 07:09:00 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1veBIT-00017I-Me; Fri, 09 Jan 2026 07:08:56 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 0FD4C48FAE;
 Fri, 09 Jan 2026 13:08:43 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, kwolf@redhat.com, fam@euphon.net,
 stefanha@redhat.com
Subject: [PATCH 3/6] block/io: honor pwrite_zeroes_alignment in
 bdrv_co_do_zero_pwritev()
Date: Fri,  9 Jan 2026 13:08:30 +0100
Message-ID: <20260109120837.2772961-4-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109120837.2772961-1-f.ebner@proxmox.com>
References: <20260109120837.2772961-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1767960482368
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

Commit 5634622bcb ("file-posix: allow BLKZEROOUT with -t writeback")
enables the BLKZEROOUT ioctl when using 'writeback' cache, regressing
certain 'qemu-img convert' invocations, because of a pre-existing
issue. Namely, the BLKZEROOUT ioctl might fail with errno EINVAL when
the request is shorter than the block size of the block device. Ensure
that bdrv_co_do_zero_pwritev() only issues requests respecting the
block driver's pwrite_zeroes_alignment. The file-posix host_device
block driver already initializes that value.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3257
Resolves: https://bugzilla.proxmox.com/show_bug.cgi?id=7197
Cc: qemu-stable@nongnu.org
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

This breaks the following iotests with qcow2:
154 177 179 204 271
See the following commits for details.

If we decide to go with the current approach, I will re-order in the
next version to avoid the temporary breakage, but I felt like it would
be easier to look at the issues with this patch order here.

 block/io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index 403a45f91d..12dc153573 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2155,7 +2155,8 @@ bdrv_co_do_zero_pwritev(BdrvChild *child, int64_t offset, int64_t bytes,
 {
     BlockDriverState *bs = child->bs;
     QEMUIOVector local_qiov;
-    uint64_t align = bs->bl.request_alignment;
+    uint64_t align = MAX(bs->bl.pwrite_zeroes_alignment,
+                         bs->bl.request_alignment);
     int ret = 0;
     bool padding;
     BdrvRequestPadding pad;
-- 
2.47.3



