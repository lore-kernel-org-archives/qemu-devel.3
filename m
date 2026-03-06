Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19B1FCC05C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 18:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vya4s-0001ty-If; Fri, 06 Mar 2026 13:39:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vya4A-00015V-9G
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 13:38:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vya48-00065d-Nm
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 13:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772822304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+iLPZIPbuCYPSLiGSoTzWOL4rk0E9KqFweQLtQ2webo=;
 b=N8p1hrIEVCWMXwi/K1iHMaV8vFwsd7g+pBi6dI9V48YuNwJzBDNKNxMIQtWWX6/nLeAYVu
 k6C8lXQe0y51KLsvC2IFJiLPLFJJpdxHDfIvY4SdyQ2Vrjuk9CyY7wGmQAqnhRkvHvgeC+
 GZt4LFhOQFT0cXJmc0DVsnpiVY7aw5M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-bO57mK7ZMFe_dZyosxFolw-1; Fri,
 06 Mar 2026 13:38:20 -0500
X-MC-Unique: bO57mK7ZMFe_dZyosxFolw-1
X-Mimecast-MFC-AGG-ID: bO57mK7ZMFe_dZyosxFolw_1772822300
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E6BDC1956050; Fri,  6 Mar 2026 18:38:19 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.224.210])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AFCDF1800361; Fri,  6 Mar 2026 18:38:18 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 08/12] block/nfs: Do not enter coroutine from CB
Date: Fri,  6 Mar 2026 19:37:01 +0100
Message-ID: <20260306183705.410357-9-kwolf@redhat.com>
In-Reply-To: <20260306183705.410357-1-kwolf@redhat.com>
References: <20260306183705.410357-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Hanna Czenczek <hreitz@redhat.com>

The reasoning I gave for why it would be safe to call aio_co_wake()
despite holding the mutex was wrong: It is true that the current request
will not re-acquire the mutex, but a subsequent request in the same
coroutine can.  Because the mutex is a non-coroutine mutex, this will
result in a deadlock.

Therefore, we must either not enter the coroutine here (only scheduling
it), or release the mutex around aio_co_wake().  I opt for the former,
as it is the behavior prior to the offending commit, and so seems safe
to do.

Fixes: deb35c129b859b9bec70fd42f856a0b7c1dc6e61
       ("nfs: Run co BH CB in the coroutine’s AioContext")
Buglink: https://gitlab.com/qemu-project/qemu/-/issues/2622#note_2965097035
Cc: qemu-stable@nongnu.org
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20260102153246.154207-1-hreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/nfs.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/block/nfs.c b/block/nfs.c
index 1d3a34a30c9..b78f4f86e85 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -249,14 +249,15 @@ nfs_co_generic_cb(int ret, struct nfs_context *nfs, void *data,
     }
 
     /*
-     * Safe to call: nfs_service(), which called us, is only run from the FD
-     * handlers, never from the request coroutine.  The request coroutine in
-     * turn will yield unconditionally.
-     * No need to release the lock, even if we directly enter the coroutine, as
-     * the lock is never re-taken after yielding.  (Note: If we do enter the
-     * coroutine, @task will probably be dangling once aio_co_wake() returns.)
+     * Using aio_co_wake() here could re-enter the coroutine directly, while we
+     * still hold the mutex.  The current request will not attempt to re-take
+     * the mutex, so that is fine; but if the same coroutine then goes on to
+     * submit another request, that new request will try to re-take the mutex,
+     * resulting in a deadlock.
+     * To prevent that, only schedule the coroutine so it will be entered later,
+     * with the mutex released.
      */
-    aio_co_wake(task->co);
+    aio_co_schedule(qemu_coroutine_get_aio_context(task->co), task->co);
 }
 
 static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, int64_t offset,
@@ -716,8 +717,8 @@ nfs_get_allocated_file_size_cb(int ret, struct nfs_context *nfs, void *data,
     if (task->ret < 0) {
         error_report("NFS Error: %s", nfs_get_error(nfs));
     }
-    /* Safe to call, see nfs_co_generic_cb() */
-    aio_co_wake(task->co);
+    /* Must not use aio_co_wake(), see nfs_co_generic_cb() */
+    aio_co_schedule(qemu_coroutine_get_aio_context(task->co), task->co);
 }
 
 static int64_t coroutine_fn nfs_co_get_allocated_file_size(BlockDriverState *bs)
-- 
2.53.0


