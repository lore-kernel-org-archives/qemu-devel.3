Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C37C02190
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 11:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taZGe-0002Yl-51; Wed, 22 Jan 2025 06:51:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1taZGc-0002Y4-Oz
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 06:51:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1taZGa-00087d-TP
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 06:51:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737546688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h3AzVFjotzbJcbZ0UqufvYfRxr80TJWhnXEy1OHyymQ=;
 b=ce043NEs8XEIvi3kTNS6TPQSms8KCqHhtY3h/dlUYTp7HfgnJ40cLQcC9BwNiXAnDHWXiD
 6E7+weWibJJiNhqIXFSVOHQqomF0hM0B7PJhqMhMnKwI6YPIJnF0LYyViNvBWTq9QaImAr
 BKaKLaMYDQr4fqEPKxToAMYVAyoAuoU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-KcsVINcINQ2XeHy1Jz23oA-1; Wed,
 22 Jan 2025 06:51:27 -0500
X-MC-Unique: KcsVINcINQ2XeHy1Jz23oA-1
X-Mimecast-MFC-AGG-ID: KcsVINcINQ2XeHy1Jz23oA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 264A5195608B; Wed, 22 Jan 2025 11:51:26 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.195])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6C45619560AA; Wed, 22 Jan 2025 11:51:24 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, pkrempa@redhat.com, peterx@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH 4/9] block/export: Don't ignore image activation error in
 blk_exp_add()
Date: Wed, 22 Jan 2025 12:50:41 +0100
Message-ID: <20250122115046.51216-5-kwolf@redhat.com>
In-Reply-To: <20250122115046.51216-1-kwolf@redhat.com>
References: <20250122115046.51216-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.086,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Currently, block jobs can't handle inactive images correctly. Incoming
write requests would run into assertion failures. Make sure that we
return an error when creating an export can't activate the image.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/export/export.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/export/export.c b/block/export/export.c
index 79c71ee245..bac42b8608 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -145,7 +145,11 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
      * ctx was acquired in the caller.
      */
     bdrv_graph_rdlock_main_loop();
-    bdrv_activate(bs, NULL);
+    ret = bdrv_activate(bs, errp);
+    if (ret < 0) {
+        bdrv_graph_rdunlock_main_loop();
+        goto fail;
+    }
     bdrv_graph_rdunlock_main_loop();
 
     perm = BLK_PERM_CONSISTENT_READ;
-- 
2.48.1


