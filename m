Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567CFC36000
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 12:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvEyV-00069y-1S; Thu, 20 Mar 2025 08:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <81bcefde27e7450ea4061acf0f63320ac0f8f95d@kylie.crudebyte.com>)
 id 1tvEyT-00069f-GL
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 08:26:13 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <81bcefde27e7450ea4061acf0f63320ac0f8f95d@kylie.crudebyte.com>)
 id 1tvEyQ-0006sR-Kc
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 08:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Message-Id:Cc:To:Subject:Date:From:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=U1CJbSQ4ojuRj9btueVTKiBMg7jOOtRxixjKO+xArJc=; b=MLS4O
 nrAwjUi8+yZpQ6bA7C57sFM7QNNG7mmnc5U9DTMb388pU9VFybrYttCZt8kucOZQvMUXjKs0bK2n6
 VoHMe6yVF6hdxm7SWQIXBWTDus9/stAhxw0S+2uXNTKstvegqU3JFfwpLuvmIqvU829y7gsgI74am
 BLzSopwWT1g5P05f4Wfw56Q7f68egwwOVzh+QTeNQZD83UsLLnCID/Kr+ORL1du4iME1WaMH4CO6B
 Lso1AR83pxD4BA0BSCY9YGFzb7TpfniAUZjIszZHXgFRU8Z/6Y6wXWEHFd/6O4BfKjd/mJ/5LwTGD
 RlBgSW43CpzzGDEEyaVihJV7yoLCWANhpIK8U8Pcy6GeWFA8B/O6LdR2GQ9mB3IDeR+bCwlx/UCUX
 QZAeEtiBC9RXj68P47DjWGQRI0vLDdfXRK86WFvNAYqZJyjAfusKSh9YvnrkPhDt5spQbBsljcWvP
 1ZZ8gJAO3UcdddMFaMjMCWnOgmAC5T0m6Z10O38KP5G7E8Vl49j+RcKcQmPrpvZipVh0aPXIJ0cbP
 f25xLBcZHb9JQlDkzQzlgNfNoyuJDpOmMHpYU25PtPjkNI7jqmU4ZW2K/a4FxOvIHlnSgaGWBqi44
 nak1GE/oEYKc3+tUkk0f95r0WpWVzttjGkI43x9nFegQ8iRZWEJiplMxKHbPWk=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 20 Mar 2025 13:16:20 +0100
Subject: [PATCH v2] 9pfs: fix 'total_open_fd' decrementation
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Message-Id: <E1tvEyJ-004dMa-So@kylie.crudebyte.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=81bcefde27e7450ea4061acf0f63320ac0f8f95d@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

According to 'man 2 close' errors returned by close() should only be used
for either diagnostic purposes or for catching data loss due to a previous
write error, as an error result of close() usually indicates a deferred
error of a previous write operation.

Therefore not decrementing 'total_open_fd' on a close() error is wrong
and would yield in a higher open file descriptor count than actually the
case, leading to 9p server reclaiming open file descriptors too soon.

Based-on: <20250312152933.383967-7-groug@kaod.org>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 V2: log a warning message on unexpected close() -> EBADF case

 hw/9pfs/9p.c     | 10 +++++++++-
 hw/9pfs/codir.c  |  7 ++++++-
 hw/9pfs/cofile.c |  7 ++++++-
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index b22df3aa2b..8b001b9112 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -510,7 +510,15 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
             err = (f->fid_type == P9_FID_DIR) ?
                 s->ops->closedir(&s->ctx, &f->fs_reclaim) :
                 s->ops->close(&s->ctx, &f->fs_reclaim);
-            if (!err) {
+
+            /* 'man 2 close' suggests to ignore close() errors except of EBADF */
+            if (unlikely(err && errno == EBADF)) {
+                /*
+                 * unexpected case as FIDs were picked above by having a valid
+                 * file descriptor
+                 */
+                error_report("9pfs: v9fs_reclaim_fd() WARNING: close() failed with EBADF");
+            } else {
                 /* total_open_fd must only be mutated on main thread */
                 nclosed++;
             }
diff --git a/hw/9pfs/codir.c b/hw/9pfs/codir.c
index 2068a4779d..bce7dd96e9 100644
--- a/hw/9pfs/codir.c
+++ b/hw/9pfs/codir.c
@@ -20,6 +20,7 @@
 #include "fsdev/qemu-fsdev.h"
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
+#include "qemu/error-report.h"
 #include "coth.h"
 #include "9p-xattr.h"
 #include "9p-util.h"
@@ -353,7 +354,11 @@ int coroutine_fn v9fs_co_closedir(V9fsPDU *pdu, V9fsFidOpenState *fs)
                 err = -errno;
             }
         });
-    if (!err) {
+    /* 'man 2 close' suggests to ignore close() errors except of EBADF */
+    if (unlikely(err && errno == EBADF)) {
+        /* unexpected case as we should have checked for a valid file handle */
+        error_report("9pfs: WARNING: v9fs_co_closedir() failed with EBADF");
+    } else {
         total_open_fd--;
     }
     return err;
diff --git a/hw/9pfs/cofile.c b/hw/9pfs/cofile.c
index 71174c3e4a..6e775c8e41 100644
--- a/hw/9pfs/cofile.c
+++ b/hw/9pfs/cofile.c
@@ -20,6 +20,7 @@
 #include "fsdev/qemu-fsdev.h"
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
+#include "qemu/error-report.h"
 #include "coth.h"
 
 int coroutine_fn v9fs_co_st_gen(V9fsPDU *pdu, V9fsPath *path, mode_t st_mode,
@@ -197,7 +198,11 @@ int coroutine_fn v9fs_co_close(V9fsPDU *pdu, V9fsFidOpenState *fs)
                 err = -errno;
             }
         });
-    if (!err) {
+    /* 'man 2 close' suggests to ignore close() errors except of EBADF */
+    if (unlikely(err && errno == EBADF)) {
+        /* unexpected case as we should have checked for a valid file handle */
+        error_report("9pfs: WARNING: v9fs_co_close() failed with EBADF");
+    } else {
         total_open_fd--;
     }
     return err;
-- 
2.39.5


