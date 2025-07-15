Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962A3C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublVL-0006Ec-EY; Tue, 15 Jul 2025 15:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkwY-0003fL-DB
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:03:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkwW-0001Gd-68
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6trNushndsv+D2tzWKPPnv40MMao6ZPGsi50y3Zk2k4=;
 b=DCrFfVxQ2V/G5LEWzxJ1QTX1WjslvycqrTx9Ne+yZSE0Tu+Ooo1r7tnf6OueXHhj5BuJdT
 BZudigOfDmSLkFqnsyBSBzlGvGuHcRaVxgF67eOyEzL6kZS+EFYaV3IGxTFPe1YfURrJrp
 IauQUaKV0vyhn5v1w5h0rjeXpQ94Klo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-C4PmwvTaOYO_cL0G6c1GSg-1; Tue,
 15 Jul 2025 15:03:48 -0400
X-MC-Unique: C4PmwvTaOYO_cL0G6c1GSg-1
X-Mimecast-MFC-AGG-ID: C4PmwvTaOYO_cL0G6c1GSg_1752606227
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F248195608C; Tue, 15 Jul 2025 19:03:47 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1EA65197702B; Tue, 15 Jul 2025 19:03:45 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 05/57] block: call bdrv_set_backing_hd() while unlocked in
 bdrv_open_backing_file()
Date: Tue, 15 Jul 2025 21:02:38 +0200
Message-ID: <20250715190330.378764-6-kwolf@redhat.com>
In-Reply-To: <20250715190330.378764-1-kwolf@redhat.com>
References: <20250715190330.378764-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Fiona Ebner <f.ebner@proxmox.com>

This is in preparation to mark bdrv_set_backing_hd() as
GRAPH_UNLOCKED.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20250530151125.955508-28-f.ebner@proxmox.com>
[kwolf: Removed an extra blank line]
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 1da10d55f0..9ef3b0262c 100644
--- a/block.c
+++ b/block.c
@@ -3632,7 +3632,8 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
     Error *local_err = NULL;
 
     GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
+    bdrv_graph_rdlock_main_loop();
 
     if (bs->backing != NULL) {
         goto free_exit;
@@ -3713,7 +3714,9 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
 
     /* Hook up the backing file link; drop our reference, bs owns the
      * backing_hd reference now */
+    bdrv_graph_rdunlock_main_loop();
     ret = bdrv_set_backing_hd(bs, backing_hd, errp);
+    bdrv_graph_rdlock_main_loop();
     bdrv_unref(backing_hd);
 
     if (ret < 0) {
@@ -3725,6 +3728,7 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
 free_exit:
     g_free(backing_filename);
     qobject_unref(tmp_parent_options);
+    bdrv_graph_rdunlock_main_loop();
     return ret;
 }
 
-- 
2.50.1


