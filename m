Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8052ECAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 19:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4P7r-0007KI-Ub; Thu, 02 Oct 2025 15:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v4P7f-0007HJ-S6
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 15:37:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v4P7W-0000VS-4A
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 15:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759433852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fwA6DUIpDuQdN2DKjqQ6RYybUyt5n+aG35dPOMYS/kM=;
 b=XpcmAyEhD+c5qnWgPhQRuhvMddRqnXxtRM+RPDg+krUbUnQUwFY3pFPXbUyBfpK2tyMerY
 yaFeP8j0izn+owRkScRvVzXuwgF3tpQ3J0zI7bv00B5Z8vl0WVPOtIW9CNFG9LeHAOnMIG
 hprKeNwqtT/hnVilGN3OHtt/3A60oWo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-2tU7LgS6MJiFhx2lFTZMtQ-1; Thu,
 02 Oct 2025 15:37:30 -0400
X-MC-Unique: 2tU7LgS6MJiFhx2lFTZMtQ-1
X-Mimecast-MFC-AGG-ID: 2tU7LgS6MJiFhx2lFTZMtQ_1759433849
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 197CC18004D4; Thu,  2 Oct 2025 19:37:29 +0000 (UTC)
Received: from localhost (unknown [10.2.16.139])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1EA2D1800452; Thu,  2 Oct 2025 19:37:27 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Jean-Louis Dupond <jean-louis@dupond.be>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 1/3] file-posix: populate pwrite_zeroes_alignment
Date: Thu,  2 Oct 2025 14:39:58 -0400
Message-ID: <20251002184000.410486-2-stefanha@redhat.com>
In-Reply-To: <20251002184000.410486-1-stefanha@redhat.com>
References: <20251002184000.410486-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Linux block devices require write zeroes alignment whereas files do not.

It may come as a surprise that block devices opened in buffered I/O mode
require the alignment although regular read/write requests do not.

Therefore it is necessary to populate the pwrite_zeroes_alignment field.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/file-posix.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 8c738674ce..05c92c824d 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1602,6 +1602,23 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
 
             bs->bl.pdiscard_alignment = dalign;
         }
+
+#ifdef __linux__
+        /*
+         * When request_alignment > 1, pwrite_zeroes_alignment does not need to
+         * be set explicitly. When request_alignment == 1, it must be set
+         * explicitly because Linux requires logical block size alignment.
+         */
+        if (bs->bl.request_alignment == 1) {
+            ret = probe_logical_blocksize(s->fd,
+                                          &bs->bl.pwrite_zeroes_alignment);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret,
+                                 "Failed to probe logical block size");
+                return;
+            }
+        }
+#endif /* __linux__ */
     }
 
     raw_refresh_zoned_limits(bs, &st, errp);
-- 
2.51.0


