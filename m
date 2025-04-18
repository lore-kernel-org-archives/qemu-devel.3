Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00354C369CB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 21:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5tfU-0003ID-BM; Fri, 18 Apr 2025 17:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u5tfR-0003HN-VD
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 17:54:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u5tfP-00037n-T1
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 17:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745013275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RON3PBfsdVHaCf7GmDRygCtskeQId7e9NvEEkLDC1UU=;
 b=ZxZxAD106Dw6zvM5CQ+9IaSoVrD1wqMm5ZEyEA8Xy/M/1xfIWUrFDatkcr6I0sMrqe5dxN
 Ig+j+X3wrj1bKCZyzACY8Ntt37tjnhnl5m75wYJtm1baqoR/QBgOgGuRCaEO+NlvmBr/Sv
 DXt6so27Ao8+/MJfrqgE7jdDFEZPmMo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-uB3GW1SWNkmuVvDGMloBPg-1; Fri,
 18 Apr 2025 17:54:31 -0400
X-MC-Unique: uB3GW1SWNkmuVvDGMloBPg-1
X-Mimecast-MFC-AGG-ID: uB3GW1SWNkmuVvDGMloBPg_1745013270
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0FBE01800368; Fri, 18 Apr 2025 21:54:30 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.121])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8888D1801944; Fri, 18 Apr 2025 21:54:28 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 integration@gluster.org (open list:GLUSTER)
Subject: [PATCH v2.5 02/11] file-posix,
 gluster: Handle zero block status hint better
Date: Fri, 18 Apr 2025 16:52:47 -0500
Message-ID: <20250418215412.404558-4-eblake@redhat.com>
In-Reply-To: <20250418215412.404558-3-eblake@redhat.com>
References: <20250417184133.105746-13-eblake@redhat.com>
 <20250418215412.404558-3-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---

Compared to v2, also adjust the gluster driver which copies file-posix.

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


