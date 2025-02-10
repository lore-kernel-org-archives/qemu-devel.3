Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC1CC0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWO5-0006oI-9b; Mon, 10 Feb 2025 11:11:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thWNU-0006Wo-D6
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:11:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thWNS-00012t-Oj
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:11:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739203877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rUilVsCCgZf53+UsTogvN0fSXC1i4Wq0Papr0s3xp1Q=;
 b=CIS1zzXaIKSEWdsL+458Z5zz7O4gjk+64j7jkEZcI+w8lf1N6LXtxFjcQvMWQPn/mpeMPS
 Pia8YQZ33RkAb87gyUJiFqPkMKR7yoqD3j43cicEwyrBIM3d/MGwoKrbFGO9Z3Wf/EUx3g
 uWomwhSUU1i4xmEHYDpeG9CQlTRsMiQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-kPiPadz5NsGYmYekbA0mIw-1; Mon,
 10 Feb 2025 11:11:16 -0500
X-MC-Unique: kPiPadz5NsGYmYekbA0mIw-1
X-Mimecast-MFC-AGG-ID: kPiPadz5NsGYmYekbA0mIw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5EFDA180087D; Mon, 10 Feb 2025 16:11:15 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.225.156])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0DFCE195608D; Mon, 10 Feb 2025 16:11:13 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 13/25] block: Don't attach inactive child to active node
Date: Mon, 10 Feb 2025 17:10:22 +0100
Message-ID: <20250210161034.76494-14-kwolf@redhat.com>
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

An active node makes unrestricted use of its children and would possibly
run into assertion failures when it operates on an inactive child node.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Acked-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20250204211407.381505-6-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block.c b/block.c
index 9458c5e013..66a99e87c5 100644
--- a/block.c
+++ b/block.c
@@ -3183,6 +3183,11 @@ bdrv_attach_child_noperm(BlockDriverState *parent_bs,
                    child_bs->node_name, child_name, parent_bs->node_name);
         return NULL;
     }
+    if (bdrv_is_inactive(child_bs) && !bdrv_is_inactive(parent_bs)) {
+        error_setg(errp, "Inactive '%s' can't be a %s child of active '%s'",
+                   child_bs->node_name, child_name, parent_bs->node_name);
+        return NULL;
+    }
 
     bdrv_get_cumulative_perm(parent_bs, &perm, &shared_perm);
     bdrv_child_perm(parent_bs, child_bs, NULL, child_role, NULL,
-- 
2.48.1


