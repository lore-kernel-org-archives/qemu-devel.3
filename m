Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C15C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublNr-0004dx-VE; Tue, 15 Jul 2025 15:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkwz-00046p-JC
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:04:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkww-0001MF-3Q
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8W8fQy5JCYizGetg+mDWw1LL18wUNUGbfORKfvklxKo=;
 b=F7qqcCuY39s+YBFjfDPLhSwt31VNfkoI2ktm7XB6IKaoF06+Xw45cgS4whV8+V16tvOxxB
 f6xr5rxLHE3j+3PGZg/QzIvl2nIyZMslf2xUesvdzO4ooAPCqc5TwERB4dtjwRN+kuruqR
 QkESwXt4gD+M0CpUdHrsqkSv1tIFYuY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-9-WJwmQLNkKz1TAbOgkjAQ-1; Tue,
 15 Jul 2025 15:04:18 -0400
X-MC-Unique: 9-WJwmQLNkKz1TAbOgkjAQ-1
X-Mimecast-MFC-AGG-ID: 9-WJwmQLNkKz1TAbOgkjAQ_1752606257
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3D76195608E; Tue, 15 Jul 2025 19:04:17 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3A667197702B; Tue, 15 Jul 2025 19:04:15 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 19/57] block: Allow bdrv_new() with and without graph lock
Date: Tue, 15 Jul 2025 21:02:52 +0200
Message-ID: <20250715190330.378764-20-kwolf@redhat.com>
In-Reply-To: <20250715190330.378764-1-kwolf@redhat.com>
References: <20250715190330.378764-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

bdrv_new() calls bdrv_drained_begin(), which can poll and therefore
can't be called while holding the graph lock. One option to make sure
that this call is allowed would be marking bdrv_new() GRAPH_UNLOCKED.

However, this is actually an unnecessary restriction because we know
that we only just created the BlockDriverState and it isn't even part of
the graph yet. We can use bdrv_do_drained_begin_quiesce() instead to
avoid the polling, which means that bdrv_new() can now safely be called
from callers that hold the graph lock as well as from callers that
don't.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 932e599f45..fe5aa2e767 100644
--- a/block.c
+++ b/block.c
@@ -431,7 +431,7 @@ BlockDriverState *bdrv_new(void)
     bs->block_status_cache = g_new0(BdrvBlockStatusCache, 1);
 
     for (i = 0; i < bdrv_drain_all_count; i++) {
-        bdrv_drained_begin(bs);
+        bdrv_do_drained_begin_quiesce(bs, NULL);
     }
 
     QTAILQ_INSERT_TAIL(&all_bdrv_states, bs, bs_list);
-- 
2.50.1


