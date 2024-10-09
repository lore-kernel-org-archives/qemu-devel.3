Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7CDCEDD97
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 14:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syXFQ-0006WR-EK; Wed, 09 Oct 2024 10:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1syXFK-0006Tv-RA; Wed, 09 Oct 2024 10:00:59 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1syXFH-0006YF-IP; Wed, 09 Oct 2024 10:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=IqL0vy7fOfiEYGjr1ttevxLphpw587ILRMR0bSq83E8=; b=JWwBoSaQS2uR
 8rgL2GFax2/Tq2MxUO+KVgHug+pbC2ZlrLy3a08+x4oapuMUS1eIjkm9NW4rOqWBMqW6UZnVRHvSb
 l8Os4h8tqe71/wCsN4KxZEglEGHqGT7woKy9/bH94u3a5PD8R5FV1CuFlhYZxAngqZoSFNIifeeAr
 KW+y3pcpp4W9rJV81/hTTdDitttb+AFRhCgM6CbL9TY1LCKotSlqZsEuEonGQzCqD/3ouUAV72HG3
 5pfzWj3qsKfCJl2R7UKCSDGnsfkTgt+3FFgQUC6bNvdel7UQhkzBtPLrfbLSlf/3iQThHaqbq9XcU
 S2Q6h/QLC8r5D0zQMuWGIw==;
Received: from [130.117.225.1] (helo=dev007.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1syXBf-00AR1a-2Q;
 Wed, 09 Oct 2024 16:00:38 +0200
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 1/2] preallocate: do not allow to change BDS permission
 improperly
Date: Wed,  9 Oct 2024 16:58:50 +0300
Message-ID: <20241009140051.771660-2-den@openvz.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241009140051.771660-1-den@openvz.org>
References: <20241009140051.771660-1-den@openvz.org>
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

RW permissions could not be lifted from the preallocation filter if
truncate operation has not been finished. In the other case this would
mean WRITE operation (image truncate) called after the return from
inactivate call. This is definitely a contract violation.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Kevin Wolf <kwolf@redhat.com>
---
 block/preallocate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/preallocate.c b/block/preallocate.c
index bfb638d8b1..1cf854966c 100644
--- a/block/preallocate.c
+++ b/block/preallocate.c
@@ -581,6 +581,17 @@ static void preallocate_child_perm(BlockDriverState *bs, BdrvChild *c,
     }
 }
 
+static int preallocate_check_perm(BlockDriverState *bs, uint64_t perm,
+                                  uint64_t shared, Error **errp)
+{
+    BDRVPreallocateState *s = bs->opaque;
+    if (!can_write_resize(perm) && s->data_end != -EINVAL) {
+        error_setg_errno(errp, EPERM, "Write access is required for truncate");
+        return -EPERM;
+    }
+    return 0;
+}
+
 static BlockDriver bdrv_preallocate_filter = {
     .format_name = "preallocate",
     .instance_size = sizeof(BDRVPreallocateState),
@@ -602,6 +613,7 @@ static BlockDriver bdrv_preallocate_filter = {
 
     .bdrv_set_perm = preallocate_set_perm,
     .bdrv_child_perm = preallocate_child_perm,
+    .bdrv_check_perm = preallocate_check_perm,
 
     .is_filter = true,
 };
-- 
2.43.5


