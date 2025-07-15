Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1020BC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublV1-0004IT-E8; Tue, 15 Jul 2025 15:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkwQ-0003YU-7O
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:03:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkwO-0001F9-OU
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0B/2XG8+KxS7pnHCp482EzG0hIY2ZE/7Mi1aO29pZNE=;
 b=S6KU93VvHGIM0vFEzazhFD4kOrgbvlsPXAi8qh0s9gtJyYbO3PLgCXcHbQrGKwWFy2aNFj
 HGm00GYjocTwVGWF1n2vmjVaU+ibqKJroPiYc74STVjI8BBq1OrM4NLnsVBuEMRaI8Q9OW
 r7qrO2OQBlfAItvvML23HlI3PKWZkQo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-Uhj__JRZOQq6leaM9e97Vg-1; Tue,
 15 Jul 2025 15:03:44 -0400
X-MC-Unique: Uhj__JRZOQq6leaM9e97Vg-1
X-Mimecast-MFC-AGG-ID: Uhj__JRZOQq6leaM9e97Vg_1752606223
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70D971956089; Tue, 15 Jul 2025 19:03:43 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E45D9197702C; Tue, 15 Jul 2025 19:03:41 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 03/57] block/mirror: switch to bdrv_set_backing_hd_drained()
 variant
Date: Tue, 15 Jul 2025 21:02:36 +0200
Message-ID: <20250715190330.378764-4-kwolf@redhat.com>
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

From: Fiona Ebner <f.ebner@proxmox.com>

This is in preparation to mark bdrv_set_backing_hd() as
GRAPH_UNLOCKED.

Switch to using the bdrv_set_backing_hd_drained() variant, so that the
drained and locked section can also cover the calls to
bdrv_skip_filters() and bdrv_cow_bs().

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20250530151125.955508-26-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/mirror.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 82a6e50cf8..873e95d029 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -761,30 +761,36 @@ static int mirror_exit_common(Job *job)
     bdrv_graph_rdlock_main_loop();
     bdrv_child_refresh_perms(mirror_top_bs, mirror_top_bs->backing,
                              &error_abort);
+    bdrv_graph_rdunlock_main_loop();
 
     if (!abort && s->backing_mode == MIRROR_SOURCE_BACKING_CHAIN) {
         BlockDriverState *backing;
-        BlockDriverState *unfiltered_target = bdrv_skip_filters(target_bs);
+        BlockDriverState *unfiltered_target;
+
+        bdrv_graph_wrlock_drained();
+        unfiltered_target = bdrv_skip_filters(target_bs);
 
         backing = s->sync_mode == MIRROR_SYNC_MODE_NONE ? src : s->base;
         if (bdrv_cow_bs(unfiltered_target) != backing) {
-            bdrv_set_backing_hd(unfiltered_target, backing, &local_err);
+            bdrv_set_backing_hd_drained(unfiltered_target, backing, &local_err);
             if (local_err) {
                 error_report_err(local_err);
                 local_err = NULL;
                 ret = -EPERM;
             }
         }
+        bdrv_graph_wrunlock();
     } else if (!abort && s->backing_mode == MIRROR_OPEN_BACKING_CHAIN) {
+        bdrv_graph_rdlock_main_loop();
         assert(!bdrv_backing_chain_next(target_bs));
         ret = bdrv_open_backing_file(bdrv_skip_filters(target_bs), NULL,
                                      "backing", &local_err);
+        bdrv_graph_rdunlock_main_loop();
         if (ret < 0) {
             error_report_err(local_err);
             local_err = NULL;
         }
     }
-    bdrv_graph_rdunlock_main_loop();
 
     if (s->should_complete && !abort) {
         BlockDriverState *to_replace = s->to_replace ?: src;
-- 
2.50.1


