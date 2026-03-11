Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6979112588E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 19:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0PLA-0007WQ-5l; Wed, 11 Mar 2026 15:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PKr-0007S0-Gq; Wed, 11 Mar 2026 15:35:15 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PKp-0008W8-Bq; Wed, 11 Mar 2026 15:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773257666; bh=29LT6J/dsLVkqfhdajZM0lyy+YR1nzRrR8wysJ6fTn8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=wd7JSqXOOYG1PYd9x53fp9gHIhpl/CRjk0S1HoARe5yK/E8a0vGZ8pNH7fix4W9ja
 HJSXua0S0okME+MeO9gS0VKKr9Z/F1Y45cg42+q7g3sVPTwQl8kxmGpi3P8Moaigg1
 3H1QyLBhdT/mVtrTVtwxsW51t1O6CWWdFNGLsgjdjnSkenlJv86fDt2jf/ge7TQelY
 Z6VUr+f4aqloqwaIn6YUWIyVzEmGi9UYO/YQ3vmOB7rMboTV2aZfEiFKjjzv5C8FmT
 9zi6GU6/MChn+kELhUz1C/i1TP9PJI2fHXq569nHLTlrdAwXIIh12pRJbnIrL4qY7W
 NnBifzkHSAcKQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0B7E61920EB;
 Wed, 11 Mar 2026 22:34:26 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4EBD637C450;
 Wed, 11 Mar 2026 22:35:04 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.2 03/53] block/mirror: check range when setting zero
 bitmap for sync write
Date: Wed, 11 Mar 2026 22:33:56 +0300
Message-ID: <20260311193449.1096110-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
References: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Message-ID: <20260112152544.261923-1-f.ebner@proxmox.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
(cherry picked from commit 4a7b1bd18d2e1a6b3796e177ae5df9b198264a0b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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


