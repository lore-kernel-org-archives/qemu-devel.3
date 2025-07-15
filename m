Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEFBC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublMf-0001uB-QC; Tue, 15 Jul 2025 15:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkwX-0003dm-0B
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:03:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkwV-0001GH-32
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wig8VCwbp0AmNDJnIb/oPWtjxxq10qBR4IkeFYlDmpA=;
 b=aeppKzMAnaITlnMi6ml/lDLqzswL5FaHW1751H/5crKm79SGl70Lg4YUt5fnhZ06KKHhB6
 mxjQMYj8OFwy/aNDjLBoIIqXZdsXNgS2CP3HCpReFQ0SoSH5zaViLsLmOmMG60OSvRzEMY
 UA1JVsfrxCIyumZ6i6lQmAs9Y3UD9NM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-FvH5FVZLN66gRNTP3YOR3Q-1; Tue,
 15 Jul 2025 15:03:52 -0400
X-MC-Unique: FvH5FVZLN66gRNTP3YOR3Q-1
X-Mimecast-MFC-AGG-ID: FvH5FVZLN66gRNTP3YOR3Q_1752606232
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01385195608F; Tue, 15 Jul 2025 19:03:52 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 452E1197702B; Tue, 15 Jul 2025 19:03:50 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 07/57] blockdev: avoid locking and draining multiple times in
 external_snapshot_abort()
Date: Tue, 15 Jul 2025 21:02:40 +0200
Message-ID: <20250715190330.378764-8-kwolf@redhat.com>
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

By using the appropriate variants bdrv_set_backing_hd_drained() and
bdrv_try_change_aio_context_locked(), there only needs to be a single
drained and write-locked section in external_snapshot_abort().

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20250530151125.955508-30-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockdev.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index e625534925..3c53472a23 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1580,11 +1580,19 @@ static void external_snapshot_abort(void *opaque)
             AioContext *tmp_context;
             int ret;
 
+            bdrv_graph_wrlock_drained();
+
             aio_context = bdrv_get_aio_context(state->old_bs);
 
-            bdrv_ref(state->old_bs);   /* we can't let bdrv_set_backind_hd()
-                                          close state->old_bs; we need it */
-            bdrv_set_backing_hd(state->new_bs, NULL, &error_abort);
+            /*
+             * Note that state->old_bs would not disappear during the
+             * write-locked section, because the unref from
+             * bdrv_set_backing_hd_drained() only happens at the end of the
+             * write-locked section. However, just be explicit about keeping a
+             * reference and don't rely on that implicit detail.
+             */
+            bdrv_ref(state->old_bs);
+            bdrv_set_backing_hd_drained(state->new_bs, NULL, &error_abort);
 
             /*
              * The call to bdrv_set_backing_hd() above returns state->old_bs to
@@ -1593,16 +1601,14 @@ static void external_snapshot_abort(void *opaque)
              */
             tmp_context = bdrv_get_aio_context(state->old_bs);
             if (aio_context != tmp_context) {
-                ret = bdrv_try_change_aio_context(state->old_bs,
-                                                  aio_context, NULL, NULL);
+                ret = bdrv_try_change_aio_context_locked(state->old_bs,
+                                                         aio_context, NULL,
+                                                         NULL);
                 assert(ret == 0);
             }
 
-            bdrv_drained_begin(state->new_bs);
-            bdrv_graph_wrlock();
             bdrv_replace_node(state->new_bs, state->old_bs, &error_abort);
             bdrv_graph_wrunlock();
-            bdrv_drained_end(state->new_bs);
 
             bdrv_unref(state->old_bs); /* bdrv_replace_node() ref'ed old_bs */
         }
-- 
2.50.1


