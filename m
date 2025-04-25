Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E68EC369D5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 00:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u87LT-0006Vb-PF; Thu, 24 Apr 2025 20:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u87LR-0006Sj-BU
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 20:55:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u87LP-0000iA-Nj
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 20:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745542507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JaGTuPEmX5rOSuL4+9zpLTiq+C9KVG7NUS6X5jCVdks=;
 b=XtBwLCB2nOCAl8+S29J8q1wFLjD8U4ilW6QynmfwQrfiuWDsyaCrsmMBYXdo0E39inKQ+T
 60k943K2dhGrT3U8dMPLGWSBcIocYhcea9swGk4w49Z72sLrUu3cuvmGkzVvfqBbPZG2n+
 csW+XK2Y5spjBKRXgmDNe9RVbW1l3nM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-A2ZK5ZcfNTGTtY4rTRnNVA-1; Thu,
 24 Apr 2025 20:55:03 -0400
X-MC-Unique: A2ZK5ZcfNTGTtY4rTRnNVA-1
X-Mimecast-MFC-AGG-ID: A2ZK5ZcfNTGTtY4rTRnNVA_1745542502
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E92B0180048E; Fri, 25 Apr 2025 00:55:00 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.59])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DA1B318001EF; Fri, 25 Apr 2025 00:54:58 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@yandex-team.ru, stefanha@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 integration@gluster.org (open list:GLUSTER)
Subject: [PATCH v3 02/11] file-posix,
 gluster: Handle zero block status hint better
Date: Thu, 24 Apr 2025 19:52:02 -0500
Message-ID: <20250425005439.2252467-15-eblake@redhat.com>
In-Reply-To: <20250425005439.2252467-13-eblake@redhat.com>
References: <20250425005439.2252467-13-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Although the previous patch to change 'bool want_zero' into a bitmask
made no semantic change, it is now time to differentiate.  When the
caller specifically wants to know what parts of the file read as zero,
we need to use lseek and actually reporting holes, rather than
short-circuiting and advertising full allocation.

This change will be utilized in later patches to let mirroring
optimize for the case when the destination already reads as zeroes.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/file-posix.c | 3 ++-
 block/gluster.c    | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 91deb5bf5af..575cbfba07d 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3217,7 +3217,8 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
         return ret;
     }

-    if (mode != BDRV_WANT_PRECISE) {
+    if (!(mode & BDRV_WANT_ZERO)) {
+        /* There is no backing file - all bytes are allocated in this file.  */
         *pnum = bytes;
         *map = offset;
         *file = bs;
diff --git a/block/gluster.c b/block/gluster.c
index 8197b0ecefa..e702666cbce 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1482,7 +1482,7 @@ static int coroutine_fn qemu_gluster_co_block_status(BlockDriverState *bs,
         return ret;
     }

-    if (mode != BDRV_WANT_PRECISE) {
+    if (!(mode & BDRV_WANT_ZERO)) {
         *pnum = bytes;
         *map = offset;
         *file = bs;
-- 
2.49.0


