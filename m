Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02B7CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 10:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDgxb-000291-23; Tue, 28 Oct 2025 06:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vDgxP-000289-Ss
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:29:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vDgxJ-0003G3-QL
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761647367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7lblHZQp7xcFlccXMjH8p11Ct3OW/swaZzgve7bPRaU=;
 b=MH1JE5P3MiTW0VXEAHCjOkQLsPTu3N2udNsKGOa/umvu7t7Uez1g7+Hs0+4JoneYMzfp87
 bUwi7Z1OqEIFvxQbcpnFtwcGuHnrwvdspIza2Itc/Vid7wUZ8U5B1KUs79o5BInPI5OcS9
 Q6sNO/mD3Q62A/cHt3I/0VXBFwL0+c8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-qKBnQKmJObaVQ83mEm7ugg-1; Tue,
 28 Oct 2025 06:29:24 -0400
X-MC-Unique: qKBnQKmJObaVQ83mEm7ugg-1
X-Mimecast-MFC-AGG-ID: qKBnQKmJObaVQ83mEm7ugg_1761647363
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D44C318001D1; Tue, 28 Oct 2025 10:29:22 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.73])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 55CB71956056; Tue, 28 Oct 2025 10:29:19 +0000 (UTC)
Date: Tue, 28 Oct 2025 11:29:17 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Wesley Hershberger <wesley.hershberger@canonical.com>,
 qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, jsnow@redhat.com
Subject: Re: [PATCH] block: Add missing null checks during
 query-named-block-nodes
Message-ID: <aQCa_dDWxGWlQa_N@redhat.com>
References: <20251024-second-fix-3149-v1-1-d997fa3d5ce2@canonical.com>
 <aP9BhBEUSuM0ougc@redhat.com>
 <a6a09fdf-e5a6-4c8e-b232-223bbbd53509@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6a09fdf-e5a6-4c8e-b232-223bbbd53509@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Am 27.10.2025 um 20:44 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Anyway, starting from 3860c0201924d, permission restrictions become less aggressive, let's
> check, staying at 3860c0201924d, and with same hack to bdrv_drop_filter:
> 
> check -qcow2 028 055 056 124 129 141 185 219 222 256 257 264 281 283 294 304
> 
> - only 257 fails. (why?)
> 
> Double check with 3860c0201924d^: again, almost all fails:
> 
> Failures: 028 055 056 124 129 185 222 256 257 264 281 304
> 
> 
> 
> And same with current master: 257 fails, if hack bdrv_drop_filter() to
> pass detach_subchain=false to bdrv_replace_node_common().

I'm trying to understand the 257, but that seems to be a fairly
complicated test case.

Looking at the first failing part, this uses error injection with a
blkdebug configuration where one single I/O error is injected on the
second read after the first flush. This feels very specific, like it's
targeting a specific operation to fail, but it doesn't really document
what it is.

John, I'm sure that after six years, you remember the details! :-)

Anyway, the difference that we're seeing after changing
bdrv_drop_filter() to pass detach_subchain=false is that now the error
seems to be triggered earlier. The same error that we get in the bad
output happens in the reference output, too, but only during "Test
Backup #1" rather than "Reference Backup #1".

So taking a shot in the dark, I tried failing the second read after the
_second_ flush (patch see below), and that fixes the test apart from the
changed blockdev-add commands. So not detaching the cor node causes an
additional flush on the image. I suspect this might be the flush in
bdrv_close() when the cor node is deleted?

Anyway, an additional flush is harmless, so I think we should be good if
we just change the test case.

Kevin


diff --git a/block.c b/block.c
index cf08e64add..982371e735 100644
--- a/block.c
+++ b/block.c
@@ -5478,7 +5478,7 @@ int bdrv_drop_filter(BlockDriverState *bs, Error **errp)

     bdrv_drained_begin(child_bs);
     bdrv_graph_wrlock();
-    ret = bdrv_replace_node_common(bs, child_bs, true, true, errp);
+    ret = bdrv_replace_node_common(bs, child_bs, true, false, errp);
     bdrv_graph_wrunlock();
     bdrv_drained_end(child_bs);

diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
index 7d3720b8e5..dffc3ba0a4 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -310,14 +310,18 @@ def test_bitmap_sync(bsync_mode, msync_mode='bitmap', failure=None):
                     'state': 1,
                     'new_state': 2
                 }, {
-                    'event': 'read_aio',
+                    'event': 'flush_to_disk',
                     'state': 2,
                     'new_state': 3
+                }, {
+                    'event': 'read_aio',
+                    'state': 3,
+                    'new_state': 4
                 }],
                 'inject-error': [{
                     'event': 'read_aio',
                     'errno': 5,
-                    'state': 3,
+                    'state': 4,
                     'immediately': False,
                     'once': True
                 }]


