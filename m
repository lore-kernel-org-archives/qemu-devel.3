Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4447C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublW7-0006lm-VG; Tue, 15 Jul 2025 15:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkwg-0003pe-F4
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:04:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkwe-0001IX-QC
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o1hSbirm0FeR7HEVUY1DNIhxsSnwTVjUfV1F5k4OPBg=;
 b=CorILoU5kCmjusFkAWxRHrACJd+f7JUkvArNVqayRDNIb0/XS+8UPliCJ12vyXIgPWo2II
 SyJdd9eA/NQ42Wk601pP7NvmpL2SXcVnvJcJufmHJb8FwRnBsz61dyLx3bHzBaSk81AGJN
 0b7bUiKGv8+RdFOteAPcfpI6L8ceUzg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-RH-eXnsPPsONcMRZ0BKgzw-1; Tue,
 15 Jul 2025 15:04:01 -0400
X-MC-Unique: RH-eXnsPPsONcMRZ0BKgzw-1
X-Mimecast-MFC-AGG-ID: RH-eXnsPPsONcMRZ0BKgzw_1752606240
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6253618001F9; Tue, 15 Jul 2025 19:04:00 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D4C09197702B; Tue, 15 Jul 2025 19:03:58 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 11/57] block/stream: mark stream_prepare() as GRAPH_UNLOCKED
Date: Tue, 15 Jul 2025 21:02:44 +0200
Message-ID: <20250715190330.378764-12-kwolf@redhat.com>
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

The function stream_prepare() calls bdrv_drain_all_begin(), which
must be called with the graph unlocked.

Also mark the JobDriver's prepare() callback as GRAPH_UNLOCKED_PTR,
because that is the callback via which stream_prepare() is reached.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20250530151125.955508-34-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/qemu/job.h | 2 +-
 block/stream.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/qemu/job.h b/include/qemu/job.h
index a5a04155ea..bb8ee766ef 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -263,7 +263,7 @@ struct JobDriver {
      * This callback will not be invoked if the job has already failed.
      * If it fails, abort and then clean will be called.
      */
-    int (*prepare)(Job *job);
+    int GRAPH_UNLOCKED_PTR (*prepare)(Job *job);
 
     /**
      * If the callback is not NULL, it will be invoked when all the jobs
diff --git a/block/stream.c b/block/stream.c
index 17e240460c..c0616b69e2 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -51,7 +51,7 @@ static int coroutine_fn stream_populate(BlockBackend *blk,
     return blk_co_preadv(blk, offset, bytes, NULL, BDRV_REQ_PREFETCH);
 }
 
-static int stream_prepare(Job *job)
+static int GRAPH_UNLOCKED stream_prepare(Job *job)
 {
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
     BlockDriverState *unfiltered_bs;
-- 
2.50.1


