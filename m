Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697E8C3ABCB
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 20:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDUZh-0004ES-C2; Fri, 09 May 2025 16:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uDUZe-0004Dx-CE
 for qemu-devel@nongnu.org; Fri, 09 May 2025 16:44:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uDUZc-0000hD-I8
 for qemu-devel@nongnu.org; Fri, 09 May 2025 16:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746823439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6BQxZ6FJ3EQlHyvOe7o5rrZaEAzgB+2EDVxpzR0s6To=;
 b=XNbr1bpxOIGoxpN7S66oD4fvpJmmscbV7DZHnJtkESXV2B9tpNizfuPGUaqgLGe3S4ZyeM
 77bKJ4J1IgtUGGaIzjdfZjPGushGlwLytYMpwRkzZBTId100NMup3S1DxJvDHim2WFZ0nK
 3fYsbbgNdplosgI9kloWyeXSvLsyL2o=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-vZngiIQGMaWbFZNlIxmLWA-1; Fri,
 09 May 2025 16:43:57 -0400
X-MC-Unique: vZngiIQGMaWbFZNlIxmLWA-1
X-Mimecast-MFC-AGG-ID: vZngiIQGMaWbFZNlIxmLWA_1746823436
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BABEB195608A; Fri,  9 May 2025 20:43:56 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.43])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BD9D13000221; Fri,  9 May 2025 20:43:54 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, sunnyzhyy@qq.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 integration@gluster.org (open list:GLUSTER)
Subject: [PATCH v4 02/13] file-posix,
 gluster: Handle zero block status hint better
Date: Fri,  9 May 2025 15:40:19 -0500
Message-ID: <20250509204341.3553601-17-eblake@redhat.com>
In-Reply-To: <20250509204341.3553601-15-eblake@redhat.com>
References: <20250509204341.3553601-15-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
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
index 805a1a2949b..ec95b748696 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3289,7 +3289,8 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
         return ret;
     }

-    if (mode != BDRV_WANT_PRECISE) {
+    if (!(mode & BDRV_WANT_ZERO)) {
+        /* There is no backing file - all bytes are allocated in this file.  */
         *pnum = bytes;
         *map = offset;
         *file = bs;
diff --git a/block/gluster.c b/block/gluster.c
index 1a2ef53e9b0..89abd40f313 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1478,7 +1478,7 @@ static int coroutine_fn qemu_gluster_co_block_status(BlockDriverState *bs,
         return ret;
     }

-    if (mode != BDRV_WANT_PRECISE) {
+    if (!(mode & BDRV_WANT_ZERO)) {
         *pnum = bytes;
         *map = offset;
         *file = bs;
-- 
2.49.0


