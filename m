Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DBBC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 15:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL1Pg-0004lw-BQ; Fri, 30 May 2025 11:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1Pa-0004VI-ER; Fri, 30 May 2025 11:12:46 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1PX-0002M6-9j; Fri, 30 May 2025 11:12:45 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id ED2BD4496F;
 Fri, 30 May 2025 17:11:48 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: [PATCH v4 40/48] block/commit: mark commit_abort() as GRAPH_UNLOCKED
Date: Fri, 30 May 2025 17:11:17 +0200
Message-Id: <20250530151125.955508-41-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530151125.955508-1-f.ebner@proxmox.com>
References: <20250530151125.955508-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The function commit_abort() calls bdrv_drained_begin(), which must be
called with the graph unlocked.

Also mark the JobDriver's abort() callback as GRAPH_UNLOCKED_PTR,
because that is the callback via which commit_abort() is reached.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block/commit.c     | 2 +-
 include/qemu/job.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 7496cf732e..0d9e1a16d7 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -68,7 +68,7 @@ static int commit_prepare(Job *job)
                                   s->backing_mask_protocol);
 }
 
-static void commit_abort(Job *job)
+static void GRAPH_UNLOCKED commit_abort(Job *job)
 {
     CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
     BlockDriverState *top_bs = blk_bs(s->top);
diff --git a/include/qemu/job.h b/include/qemu/job.h
index bb8ee766ef..ead31578d3 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -283,7 +283,7 @@ struct JobDriver {
      * All jobs will complete with a call to either .commit() or .abort() but
      * never both.
      */
-    void (*abort)(Job *job);
+    void GRAPH_UNLOCKED_PTR (*abort)(Job *job);
 
     /**
      * If the callback is not NULL, it will be invoked after a call to either
-- 
2.39.5



