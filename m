Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E77D70DEB
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 18:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGjQW-000735-Rc; Thu, 28 Nov 2024 13:39:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1tGjQN-0006zW-NH; Thu, 28 Nov 2024 13:39:35 -0500
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1tGjQI-00060J-HN; Thu, 28 Nov 2024 13:39:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=eFKiUc6Dqon9qjQmOVmuIQxOp19FJBFUFGirXOnfNrE=; b=aPHeyWz1z4gU
 zve7/yxfXxeEtK5LB5WXNzFm9OgeV7yXQ1aa3lwIIh8Tey/pPqRjyu7EBgXmzLuHFChL5+TkkOtlI
 0NVbM/Dw1LggV5Fck5cxnTe/qqEIkn+r1S/Hu83QlkKgDi7dvu6ChF1kQjow1Ev2LqScWCaSSr2lO
 gtLaXsNbfm+9tXDFt/BeIwW5MD89neQ43IEkQkpB1IfWFQExA10zorms7bM7sbch1NNCBngOt47DA
 NlXMgMkdvCDMwywuGFzeOJ0XFizjXHyIB9o2YectRUVZEM+wh3OkHMFbX8bF0OeklCfXanuJkYGsh
 2dqEBLGGM0yvpTUmJNcy5Q==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1tGjPo-00E2DN-0n;
 Thu, 28 Nov 2024 19:39:10 +0100
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 2/6] preallocate: do not enable filter inside
 preallocate_co_getlength()
Date: Thu, 28 Nov 2024 19:25:49 +0100
Message-ID: <20241128183911.837699-3-den@openvz.org>
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

Let us auto-enable it inside handle_write() and truncate(), i.e. on the
actual write operation. This just makes things more relaxing.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
---
 block/preallocate.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/block/preallocate.c b/block/preallocate.c
index c14e6a530d..d0ed56eecb 100644
--- a/block/preallocate.c
+++ b/block/preallocate.c
@@ -494,20 +494,13 @@ static int coroutine_fn GRAPH_RDLOCK preallocate_co_flush(BlockDriverState *bs)
 static int64_t coroutine_fn GRAPH_RDLOCK
 preallocate_co_getlength(BlockDriverState *bs)
 {
-    int64_t ret;
     BDRVPreallocateState *s = bs->opaque;
 
     if (s->data_end >= 0) {
         return s->data_end;
     }
 
-    ret = bdrv_co_getlength(bs->file->bs);
-
-    if (has_prealloc_perms(bs)) {
-        s->file_end = s->zero_start = s->data_end = ret;
-    }
-
-    return ret;
+    return bdrv_co_getlength(bs->file->bs);
 }
 
 static int GRAPH_RDLOCK
-- 
2.45.2


