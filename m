Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95025C021A1
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWO7-0006pH-Se; Mon, 10 Feb 2025 11:12:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thWNg-0006dh-I2
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:11:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thWNf-00016D-6D
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:11:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739203890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dTE/GH+PuHnefFY9oVdhiH76tQC4DZdeZvwJ6Aj1Umw=;
 b=ZeI7ayW0tIP1q8ZnJ2AHmtyZcA6dBBbtRa+/1vW4dIwsRP5uPJygOwdUf5qAnxCSS7wadY
 5RFAwNqezEqH4MAh/HQr02nuLH0KJu78iQGclMStVrO5iu1vk/5gCcs5AyaU7E7TuGmsu1
 0rRm2WLDx5XifxfTyTRzfGB8bqdv0/Y=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-t_lEDS6MNdSg1MLZHZ4lMg-1; Mon,
 10 Feb 2025 11:11:26 -0500
X-MC-Unique: t_lEDS6MNdSg1MLZHZ4lMg-1
X-Mimecast-MFC-AGG-ID: t_lEDS6MNdSg1MLZHZ4lMg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A7561955D7C; Mon, 10 Feb 2025 16:11:24 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.225.156])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ED676195608D; Mon, 10 Feb 2025 16:11:22 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 18/25] block/export: Don't ignore image activation error in
 blk_exp_add()
Date: Mon, 10 Feb 2025 17:10:27 +0100
Message-ID: <20250210161034.76494-19-kwolf@redhat.com>
In-Reply-To: <20250210161034.76494-1-kwolf@redhat.com>
References: <20250210161034.76494-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Currently, block exports can't handle inactive images correctly.
Incoming write requests would run into assertion failures. Make sure
that we return an error when creating an export can't activate the
image.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Acked-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20250204211407.381505-11-kwolf@redhat.com>
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


