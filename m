Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E5ECA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 16:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urIhn-0005sh-LE; Wed, 27 Aug 2025 12:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.syms@cloud.com>)
 id 1urIhl-0005rm-2Y
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 12:08:57 -0400
Received: from na1pdmzitismtp01.corp.cloud.com ([160.101.131.8]
 helo=na1pdmzitismtp01.tibco.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.syms@cloud.com>)
 id 1urIhj-0007v6-BO
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 12:08:56 -0400
Received: from mewpvdipd1010.corp.cloud.com (unknown [10.113.40.46])
 by na1pdmzitismtp01.tibco.com (Postfix) with ESMTP id 5B60C40D6683;
 Wed, 27 Aug 2025 12:08:14 -0400 (EDT)
To: qemu-devel@nongnu.org,
	xen-devel@lists.xenproject.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 Mark Syms <mark.syms@cloud.com>
Subject: [PATCH] [xen-block] Return BLKIF_RSP_EOPNOTSUPP for unknown operation
Date: Wed, 27 Aug 2025 17:08:41 +0100
Message-ID: <20250827160841.351707-1-mark.syms@cloud.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=160.101.131.8; envelope-from=mark.syms@cloud.com;
 helo=na1pdmzitismtp01.tibco.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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
Reply-to:  Mark Syms <mark.syms@cloud.com>
From:  Mark Syms via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Returning BLKIF_RSP_ERROR if an operation is not supoprted does not
allow the frontend to exercise any discretion on how to handle the
response and may lead to an operating system crash. As different
backends may support different feature sets and we might, during a
migration, switch backends, an in-flight request might be issued (or
reissued) which is then not supported by this backend.

Signed-off-by: Mark Syms <mark.syms@cloud.com>
---
 hw/block/dataplane/xen-block.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index 48c2e315f3..32cf919a97 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -167,7 +167,8 @@ static int xen_block_parse_request(XenBlockRequest *request)
         return 0;
     default:
         error_report("error: unknown operation (%d)", request->req.operation);
-        goto err;
+        request->status = BLKIF_RSP_EOPNOTSUPP;
+        return -1;
     };
 
     if (request->req.operation != BLKIF_OP_READ &&
-- 
2.50.1


