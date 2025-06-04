Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DF1C5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 17:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMsN2-0002yt-PN; Wed, 04 Jun 2025 13:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMsMG-0002Mu-7q
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:57:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMsME-0000YZ-GD
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749059817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bNvCLhllTxzVuFCaOmSvJ2HQnjndsSpuezXea4ddMbo=;
 b=a9YEFqfMDKdyGy6WQ34s5k05nCXBIqd54rO0+v9yNT8OfG/r9h0sVAxa7hqibs3qz5t+e6
 BwVsSpTPzOvfQixJVtRdSbEGlFE8XRflikW4lRSx6w0UN2H9B1Iy29SAo3kp1k54VwFt1o
 rbJoV5XNGMGogPCzy1C/cLOOxC4aiYw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-QpjkLknbPei8ncdjzMMWqg-1; Wed,
 04 Jun 2025 13:56:54 -0400
X-MC-Unique: QpjkLknbPei8ncdjzMMWqg-1
X-Mimecast-MFC-AGG-ID: QpjkLknbPei8ncdjzMMWqg_1749059813
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B67A21955D48; Wed,  4 Jun 2025 17:56:53 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.34.43])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 721B518003FD; Wed,  4 Jun 2025 17:56:52 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 19/24] block: mark bdrv_drained_begin() and friends as
 GRAPH_UNLOCKED
Date: Wed,  4 Jun 2025 19:56:08 +0200
Message-ID: <20250604175613.344113-20-kwolf@redhat.com>
In-Reply-To: <20250604175613.344113-1-kwolf@redhat.com>
References: <20250604175613.344113-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Fiona Ebner <f.ebner@proxmox.com>

All of bdrv_drain_all_begin(), bdrv_drain_all() and
bdrv_drained_begin() poll and are not allowed to be called with the
block graph lock held. Mark the function as such.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20250530151125.955508-20-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-global-state.h | 4 ++--
 include/block/block-io.h           | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index 91f249b5ad..84a2a4ecd5 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -192,10 +192,10 @@ int bdrv_inactivate_all(void);
 
 int bdrv_flush_all(void);
 void bdrv_close_all(void);
-void bdrv_drain_all_begin(void);
+void GRAPH_UNLOCKED bdrv_drain_all_begin(void);
 void bdrv_drain_all_begin_nopoll(void);
 void bdrv_drain_all_end(void);
-void bdrv_drain_all(void);
+void GRAPH_UNLOCKED bdrv_drain_all(void);
 
 void bdrv_aio_cancel(BlockAIOCB *acb);
 
diff --git a/include/block/block-io.h b/include/block/block-io.h
index b99cc98d26..4cf83fb367 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -431,7 +431,7 @@ bdrv_drain_poll(BlockDriverState *bs, BdrvChild *ignore_parent,
  *
  * This function can be recursive.
  */
-void bdrv_drained_begin(BlockDriverState *bs);
+void GRAPH_UNLOCKED bdrv_drained_begin(BlockDriverState *bs);
 
 /**
  * bdrv_do_drained_begin_quiesce:
-- 
2.49.0


