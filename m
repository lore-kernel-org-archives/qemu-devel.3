Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB3BC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublNa-0003vv-HH; Tue, 15 Jul 2025 15:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkwv-00043Z-2s
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:04:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkwt-0001Ld-Bx
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6bG2LiKW4UY4F0ikb9ynKo/iZ38MY+OeFpp3X1qbbw8=;
 b=b/Mpf8lNsl4RXFyHZtJSLtQsL6kHVQ3CsTP1qdK3C86G9Fsj8rgoo9hiW3sozg3eucdfYV
 KlOv8rNCrc92M/M0oriUqtQ+YtxzcSDea8SIEO4Rzu7+ircRx9AuzXDjFbJOIlKP7beQ7Z
 trqegB4p2vrNSZGw2IGic7ZMLr2pK90=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-wAFutUMYMuWbQj8ZZyGjWg-1; Tue,
 15 Jul 2025 15:04:16 -0400
X-MC-Unique: wAFutUMYMuWbQj8ZZyGjWg-1
X-Mimecast-MFC-AGG-ID: wAFutUMYMuWbQj8ZZyGjWg_1752606255
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9165180028F; Tue, 15 Jul 2025 19:04:15 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 39665197702B; Tue, 15 Jul 2025 19:04:13 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 18/57] block/commit: mark commit_abort() as GRAPH_UNLOCKED
Date: Tue, 15 Jul 2025 21:02:51 +0200
Message-ID: <20250715190330.378764-19-kwolf@redhat.com>
In-Reply-To: <20250715190330.378764-1-kwolf@redhat.com>
References: <20250715190330.378764-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Fiona Ebner <f.ebner@proxmox.com>

The function commit_abort() calls bdrv_drained_begin(), which must be
called with the graph unlocked.

Also mark the JobDriver's abort() callback as GRAPH_UNLOCKED_PTR,
because that is the callback via which commit_abort() is reached.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20250530151125.955508-41-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/qemu/job.h | 2 +-
 block/commit.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
-- 
2.50.1


