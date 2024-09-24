Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA038CF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 12:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st55x-0007Df-DZ; Tue, 24 Sep 2024 08:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1st55Y-0005YR-Ou; Tue, 24 Sep 2024 08:56:23 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1st55U-0007Yk-Ga; Tue, 24 Sep 2024 08:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=pnHpVA2l5CDhMpgeIkIR2CZqgq8C3/4Nc0dAahvQGcQ=; b=L558auwxWPJK
 CvQ3XmuRVAfMDPgghrzipdNM2IjVJMmByX8nObvWfqh1HvqWlCwht0mHzrzM3xUaqnUM7DF3i4c1D
 c3f0btGOuI3QUn6F2uAI/2Wrl4TRAErI/JXSJ4qmHqxuphAJ44c4RfJL+7aF6EurOna/732ae49A8
 yiGSAKsTukaLdfqAzbF2vqvLzIh8nCuQ8rzmx3fSANImcGkXZR8KBRn9/DZm0eLHeST7pruUiNP2+
 6ta9+n1DNeF73n6KC9t5gEjnXqkXWGQSM+/mR1BXnDPFSZYEKWzM6Rv9+EQAYTLhfzO30GtYc3oMa
 iNThjGX94OxViSmEYkMyvA==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1st52L-004Gjl-1y;
 Tue, 24 Sep 2024 14:56:00 +0200
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eesposit@redhat.com, vsementsov@yandex-team.ru,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [Bug Report][RFC PATCH 1/1] block: fix failing assert on paused VM
 migration
Date: Tue, 24 Sep 2024 15:56:11 +0300
Message-Id: <20240924125611.664315-2-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240924125611.664315-1-andrey.drobyshev@virtuozzo.com>
References: <20240924125611.664315-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Instead of throwing an assert let's just ignore that flag is already set
and return.  We assume that it's going to be safe to ignore.  Otherwise
this assert fails when migrating a paused VM back and forth.

Ideally we'd like to have a more sophisticated solution, e.g. not even
scan the nodes which should be inactive at this point.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 7d90007cae..c1dcf906d1 100644
--- a/block.c
+++ b/block.c
@@ -6973,7 +6973,15 @@ static int GRAPH_RDLOCK bdrv_inactivate_recurse(BlockDriverState *bs)
         return 0;
     }
 
-    assert(!(bs->open_flags & BDRV_O_INACTIVE));
+    if (bs->open_flags & BDRV_O_INACTIVE) {
+        /*
+         * Return here instead of throwing assert as a workaround to
+         * prevent failure on migrating paused VM.
+         * Here we assume that if we're trying to inactivate BDS that's
+         * already inactive, it's safe to just ignore it.
+         */
+        return 0;
+    }
 
     /* Inactivate this node */
     if (bs->drv->bdrv_inactivate) {
-- 
2.39.3


