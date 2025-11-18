Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFB6CEE33B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 17:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLP7L-0000ih-Re; Tue, 18 Nov 2025 12:03:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vLP7K-0000hK-3b
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:03:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vLP7I-0004qc-83
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:03:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763485423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yl7dqp9QOx/ISaDt5/CgTZ4Jf2aFUCybK+nzp1SYQ1o=;
 b=JqPbiW+i173uFs0xbpTdE1FZBazRwLbeEmUugONmI7vzd/NM1BrT67+2Udq/X88YAiWQJ3
 POJQYsYW7z9fmvBAlN4pyWkFXW4M1gzz4/IH3m47DXef6K/ahols+tbTPcKoXpS7AlFl0Q
 tw5XjWbLKAGxN/gxGzHf95vKAGmHyDY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-OkvHLKMNOgaGFRVByrhrNw-1; Tue,
 18 Nov 2025 12:03:26 -0500
X-MC-Unique: OkvHLKMNOgaGFRVByrhrNw-1
X-Mimecast-MFC-AGG-ID: OkvHLKMNOgaGFRVByrhrNw_1763485406
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF49F18002E9; Tue, 18 Nov 2025 17:03:25 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 56D37300A88D; Tue, 18 Nov 2025 17:03:24 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 10/19] block/io: Take reqs_lock for tracked_requests
Date: Tue, 18 Nov 2025 18:02:47 +0100
Message-ID: <20251118170256.272087-11-kwolf@redhat.com>
In-Reply-To: <20251118170256.272087-1-kwolf@redhat.com>
References: <20251118170256.272087-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Hanna Czenczek <hreitz@redhat.com>

bdrv_co_get_self_request() does not take a lock around iterating through
bs->tracked_requests.  With multiqueue, it may thus iterate over a list
that is in the process of being modified, producing an assertion
failure:

../block/file-posix.c:3702: raw_do_pwrite_zeroes: Assertion `req' failed.

[0] abort() at /lib64/libc.so.6
[1] __assert_fail_base.cold() at /lib64/libc.so.6
[2] raw_do_pwrite_zeroes() at ../block/file-posix.c:3702
[3] bdrv_co_do_pwrite_zeroes() at ../block/io.c:1910
[4] bdrv_aligned_pwritev() at ../block/io.c:2109
[5] bdrv_co_do_zero_pwritev() at ../block/io.c:2192
[6] bdrv_co_pwritev_part() at ../block/io.c:2292
[7] bdrv_co_pwritev() at ../block/io.c:2225
[8] handle_alloc_space() at ../block/qcow2.c:2573
[9] qcow2_co_pwritev_task() at ../block/qcow2.c:2625

Fix this by taking reqs_lock.

Cc: qemu-stable@nongnu.org
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20251110154854.151484-11-hreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/io.c b/block/io.c
index 928c02d1ad..c4a4301321 100644
--- a/block/io.c
+++ b/block/io.c
@@ -718,11 +718,14 @@ BdrvTrackedRequest *coroutine_fn bdrv_co_get_self_request(BlockDriverState *bs)
     Coroutine *self = qemu_coroutine_self();
     IO_CODE();
 
+    qemu_mutex_lock(&bs->reqs_lock);
     QLIST_FOREACH(req, &bs->tracked_requests, list) {
         if (req->co == self) {
+            qemu_mutex_unlock(&bs->reqs_lock);
             return req;
         }
     }
+    qemu_mutex_unlock(&bs->reqs_lock);
 
     return NULL;
 }
-- 
2.51.1


