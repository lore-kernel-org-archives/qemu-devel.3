Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA71C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 19:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpYwq-0002lJ-QL; Wed, 27 Mar 2024 15:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rpYwm-0002l3-P2
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 15:28:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rpYwl-0003Pw-9N
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 15:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711567706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7eEXqro75PuvQx0e5oR7FAG9jbS5Y28Mki/OuOrtBVs=;
 b=CyVwvIJUs7rhfu9v3qj5smf1KRjIyF5jNUxobovY+TqeOkAyBth0da0chrXD2VtT7ieCS4
 b1CDD7r9M/olzrgi2al9JswhE6oMv4s9epomCdqSFw2FNq214WyeOSYqdZOdYuO0XomF2g
 XPa6JSC9YOXsdfSn0ReRmMygMicPT44=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-xKGeDYWGP0mCeXI-lXdczw-1; Wed, 27 Mar 2024 15:28:23 -0400
X-MC-Unique: xKGeDYWGP0mCeXI-lXdczw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 973AE800264;
 Wed, 27 Mar 2024 19:28:22 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE59E40C6DAE;
 Wed, 27 Mar 2024 19:28:21 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	f.ebner@proxmox.com,
	qemu-devel@nongnu.org
Subject: [PATCH] block: Remove unnecessary NULL check in bdrv_pad_request()
Date: Wed, 27 Mar 2024 20:27:50 +0100
Message-ID: <20240327192750.204197-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Coverity complains that the check introduced in commit 3f934817 suggests
that qiov could be NULL and we dereference it before reaching the check.
In fact, all of the callers pass a non-NULL pointer, so just remove the
misleading check.

Resolves: Coverity CID 1542668
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index 395bea3bac..7217cf811b 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1730,7 +1730,7 @@ static int bdrv_pad_request(BlockDriverState *bs,
      * For prefetching in stream_populate(), no qiov is passed along, because
      * only copy-on-read matters.
      */
-    if (qiov && *qiov) {
+    if (*qiov) {
         sliced_iov = qemu_iovec_slice(*qiov, *qiov_offset, *bytes,
                                       &sliced_head, &sliced_tail,
                                       &sliced_niov);
-- 
2.44.0


