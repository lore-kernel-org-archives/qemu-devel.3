Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DC6C47258
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 17:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rU9K5-0005Xa-Un; Sun, 28 Jan 2024 12:52:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rU9JV-0004Dv-CQ; Sun, 28 Jan 2024 12:51:26 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rU9JS-0000rH-Qg; Sun, 28 Jan 2024 12:51:24 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 529044810D;
 Sun, 28 Jan 2024 20:51:33 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id F01DF6D529;
 Sun, 28 Jan 2024 20:50:41 +0300 (MSK)
Received: (nullmailer pid 812431 invoked by uid 1000);
 Sun, 28 Jan 2024 17:50:35 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ari Sundholm <ari@tuxera.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.1 64/71] block/blklogwrites: Fix a bug when logging
 "write zeroes" operations.
Date: Sun, 28 Jan 2024 20:50:27 +0300
Message-Id: <20240128175035.812352-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.1-20240128204849@cover.tls.msk.ru>
References: <qemu-stable-8.2.1-20240128204849@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ari Sundholm <ari@tuxera.com>

There is a bug in the blklogwrites driver pertaining to logging "write
zeroes" operations, causing log corruption. This can be easily observed
by setting detect-zeroes to something other than "off" for the driver.

The issue is caused by a concurrency bug pertaining to the fact that
"write zeroes" operations have to be logged in two parts: first the log
entry metadata, then the zeroed-out region. While the log entry
metadata is being written by bdrv_co_pwritev(), another operation may
begin in the meanwhile and modify the state of the blklogwrites driver.
This is as intended by the coroutine-driven I/O model in QEMU, of
course.

Unfortunately, this specific scenario is mishandled. A short example:
    1. Initially, in the current operation (#1), the current log sector
number in the driver state is only incremented by the number of sectors
taken by the log entry metadata, after which the log entry metadata is
written. The current operation yields.
    2. Another operation (#2) may start while the log entry metadata is
being written. It uses the current log position as the start offset for
its log entry. This is in the sector right after the operation #1 log
entry metadata, which is bad!
    3. After bdrv_co_pwritev() returns (#1), the current log sector
number is reread from the driver state in order to find out the start
offset for bdrv_co_pwrite_zeroes(). This is an obvious blunder, as the
offset will be the sector right after the (misplaced) operation #2 log
entry, which means that the zeroed-out region begins at the wrong
offset.
    4. As a result of the above, the log is corrupt.

Fix this by only reading the driver metadata once, computing the
offsets and sizes in one go (including the optional zeroed-out region)
and setting the log sector number to the appropriate value for the next
operation in line.

Signed-off-by: Ari Sundholm <ari@tuxera.com>
Cc: qemu-stable@nongnu.org
Message-ID: <20240109184646.1128475-1-megari@gmx.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit a9c8ea95470c27a8a02062b67f9fa6940e828ab6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 3678f6cf42..84e03f309f 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -328,22 +328,39 @@ static void coroutine_fn GRAPH_RDLOCK
 blk_log_writes_co_do_log(BlkLogWritesLogReq *lr)
 {
     BDRVBlkLogWritesState *s = lr->bs->opaque;
-    uint64_t cur_log_offset = s->cur_log_sector << s->sectorbits;
 
-    s->nr_entries++;
-    s->cur_log_sector +=
-            ROUND_UP(lr->qiov->size, s->sectorsize) >> s->sectorbits;
+    /*
+     * Determine the offsets and sizes of different parts of the entry, and
+     * update the state of the driver.
+     *
+     * This needs to be done in one go, before any actual I/O is done, as the
+     * log entry may have to be written in two parts, and the state of the
+     * driver may be modified by other driver operations while waiting for the
+     * I/O to complete.
+     */
+    const uint64_t entry_start_sector = s->cur_log_sector;
+    const uint64_t entry_offset = entry_start_sector << s->sectorbits;
+    const uint64_t qiov_aligned_size = ROUND_UP(lr->qiov->size, s->sectorsize);
+    const uint64_t entry_aligned_size = qiov_aligned_size +
+        ROUND_UP(lr->zero_size, s->sectorsize);
+    const uint64_t entry_nr_sectors = entry_aligned_size >> s->sectorbits;
 
-    lr->log_ret = bdrv_co_pwritev(s->log_file, cur_log_offset, lr->qiov->size,
+    s->nr_entries++;
+    s->cur_log_sector += entry_nr_sectors;
+
+    /*
+     * Write the log entry. Note that if this is a "write zeroes" operation,
+     * only the entry header is written here, with the zeroing being done
+     * separately below.
+     */
+    lr->log_ret = bdrv_co_pwritev(s->log_file, entry_offset, lr->qiov->size,
                                   lr->qiov, 0);
 
     /* Logging for the "write zeroes" operation */
     if (lr->log_ret == 0 && lr->zero_size) {
-        cur_log_offset = s->cur_log_sector << s->sectorbits;
-        s->cur_log_sector +=
-                ROUND_UP(lr->zero_size, s->sectorsize) >> s->sectorbits;
+        const uint64_t zeroes_offset = entry_offset + qiov_aligned_size;
 
-        lr->log_ret = bdrv_co_pwrite_zeroes(s->log_file, cur_log_offset,
+        lr->log_ret = bdrv_co_pwrite_zeroes(s->log_file, zeroes_offset,
                                             lr->zero_size, 0);
     }
 
-- 
2.39.2


