Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117ECD70DE8
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 18:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGjQQ-000714-Hx; Thu, 28 Nov 2024 13:39:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1tGjQL-0006yN-Qy; Thu, 28 Nov 2024 13:39:34 -0500
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1tGjQI-00060M-I4; Thu, 28 Nov 2024 13:39:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=XJ42Z62QlzdbZHtaE5BzFMve5MgZ1kwBIfta+yFGPaM=; b=Q6NGYyHZQ0p6
 9oVMRMdoDgOfvXkPRiT6VhdI3z5YCYk2mkVE3B28jg+RYJkTQIs4jmJFpIjiMFW0QkPhpgFXjpHun
 DvYFlchkC60doKRxtInGbkpN86vtPxHUwSZjGl/yj9IUAoZzYXM0IEyJXsBdUQS9RNf8hIRJa0d5A
 x2ozFE0gfFwL2SH2FZQCr8E7Ceht/ULX+T9Q6VzIpHHtxbhG3SvNBusbjQScq9HOncNmtB+8mIHB9
 fdkCdRA+gzbCEP3GhEU71JWH70Mz3y3xQsf9NVUrPdeiAi0iFNBCtcDA+gJIsenJX9+0WuMWseiUa
 ByWsjlXY0LiG5waHsXcxWA==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1tGjPo-00E2DN-1t;
 Thu, 28 Nov 2024 19:39:10 +0100
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 3/6] preallocate: rework preallocate_truncate_to_real_size()
Date: Thu, 28 Nov 2024 19:25:50 +0100
Message-ID: <20241128183911.837699-4-den@openvz.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241128183911.837699-1-den@openvz.org>
References: <20241128183911.837699-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The filter is not enabled if s->data_end is negative. In this case it
would be useless completely to initialize s->file_end inside
preallocate_truncate_to_real_size() without setting s->data_end.
Here are we are going to reset the state and disable the filter as
we are either in the process of switching to the read-only state or
the driver is being closed.

Now the driver is disabled unconditionally even on the error and this is
pretty much correct. In the worst case the image would be a bit longer
and that is all.

The patch also adds redundant check for bs->open_flags into this helper
for the convinience.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
---
 block/preallocate.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/block/preallocate.c b/block/preallocate.c
index d0ed56eecb..65c1ff5d78 100644
--- a/block/preallocate.c
+++ b/block/preallocate.c
@@ -179,12 +179,11 @@ preallocate_truncate_to_real_size(BlockDriverState *bs, Error **errp)
     BDRVPreallocateState *s = bs->opaque;
     int ret;
 
-    if (s->file_end < 0) {
-        s->file_end = bdrv_getlength(bs->file->bs);
-        if (s->file_end < 0) {
-            error_setg_errno(errp, -s->file_end, "Failed to get file length");
-            return s->file_end;
-        }
+    if (!(bs->open_flags & BDRV_O_RDWR)) {
+        return 0;
+    }
+    if (s->data_end < 0) {
+        return 0;
     }
 
     if (s->data_end < s->file_end) {
@@ -192,11 +191,9 @@ preallocate_truncate_to_real_size(BlockDriverState *bs, Error **errp)
                             NULL);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "Failed to drop preallocation");
-            s->file_end = ret;
-            return ret;
         }
-        s->file_end = s->data_end;
     }
+    s->data_end = s->file_end = s->zero_start = -EINVAL;
 
     return 0;
 }
@@ -211,9 +208,7 @@ static void preallocate_close(BlockDriverState *bs)
     qemu_bh_cancel(s->drop_resize_bh);
     qemu_bh_delete(s->drop_resize_bh);
 
-    if (s->data_end >= 0) {
-        preallocate_truncate_to_real_size(bs, NULL);
-    }
+    preallocate_truncate_to_real_size(bs, NULL);
 }
 
 
@@ -528,8 +523,6 @@ preallocate_drop_resize(BlockDriverState *bs, Error **errp)
      * change the child, so mark all states invalid. We'll regain control if a
      * parent requests write access again.
      */
-    s->data_end = s->file_end = s->zero_start = -EINVAL;
-
     bdrv_child_refresh_perms(bs, bs->file, NULL);
 
     return 0;
-- 
2.45.2


