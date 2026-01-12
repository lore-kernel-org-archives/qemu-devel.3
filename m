Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EB1C9EC94
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 15:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfJo4-00082J-Jf; Mon, 12 Jan 2026 10:26:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vfJnn-0007uL-85; Mon, 12 Jan 2026 10:25:57 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vfJnl-0006p8-CS; Mon, 12 Jan 2026 10:25:55 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 2BFF645D6D;
 Mon, 12 Jan 2026 16:25:49 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 stefanha@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 qemu-stable@nongnu.org, eblake@redhat.com
Subject: [PATCH] block/mirror: check range when setting zero bitmap for sync
 write
Date: Mon, 12 Jan 2026 16:23:51 +0100
Message-ID: <20260112152544.261923-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1768231504919
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Some Proxmox users reported an occasional assertion failure [0][1] in
busy VMs when using drive mirror with active mode. In particular, the
failure may occur for zero writes shorter than the job granularity:

> #0  0x00007b421154b507 in abort ()
> #1  0x00007b421154b420 in ?? ()
> #2  0x0000641c582e061f in bitmap_set (map=0x7b4204014e00, start=14, nr=-1)
> #3  0x0000641c58062824 in do_sync_target_write (job=0x641c7e73d1e0,
>       method=MIRROR_METHOD_ZERO, offset=852480, bytes=4096, qiov=0x0, flags=0)
> #4  0x0000641c58062250 in bdrv_mirror_top_do_write (bs=0x641c7e62e1f0,
        method=MIRROR_METHOD_ZERO, copy_to_target=true, offset=852480,
        bytes=4096, qiov=0x0, flags=0)
> #5  0x0000641c58061f31 in bdrv_mirror_top_pwrite_zeroes (bs=0x641c7e62e1f0,
        offset=852480, bytes=4096, flags=0)

The range for the dirty bitmap described by dirty_bitmap_offset and
dirty_bitmap_end is narrower than the original range and in fact,
dirty_bitmap_end might be smaller than dirty_bitmap_offset. There
already is a check for 'dirty_bitmap_offset < dirty_bitmap_end' before
resetting the dirty bitmap. Add such a check for setting the zero
bitmap too, which uses the same narrower range.

[0]: https://forum.proxmox.com/threads/177981/
[1]: https://bugzilla.proxmox.com/show_bug.cgi?id=7222

Cc: qemu-stable@nongnu.org
Fixes: 7e277545b9 ("mirror: Skip writing zeroes when target is already zero")
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block/mirror.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index b344182c74..bc982cb99a 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1514,9 +1514,12 @@ do_sync_target_write(MirrorBlockJob *job, MirrorMethod method,
         assert(!qiov);
         ret = blk_co_pwrite_zeroes(job->target, offset, bytes, flags);
         if (job->zero_bitmap && ret >= 0) {
-            bitmap_set(job->zero_bitmap, dirty_bitmap_offset / job->granularity,
-                       (dirty_bitmap_end - dirty_bitmap_offset) /
-                       job->granularity);
+            if (dirty_bitmap_offset < dirty_bitmap_end) {
+                bitmap_set(job->zero_bitmap,
+                           dirty_bitmap_offset / job->granularity,
+                           (dirty_bitmap_end - dirty_bitmap_offset) /
+                           job->granularity);
+            }
         }
         break;
 
-- 
2.47.3



