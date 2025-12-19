Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81F3D7879F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 18:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWeto-0002S6-QE; Fri, 19 Dec 2025 13:08:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1vWetm-0002Rc-Tl; Fri, 19 Dec 2025 13:08:19 -0500
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1vWetl-0006R0-ER; Fri, 19 Dec 2025 13:08:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=4FS6L5FyYnEDm7EmvtkyXM7Sw8RJvdD0yZUtVLUQ1mo=; b=IIfnb/YNhJql
 WcCpzNAbyE73TeR12v0gsvsaQBbWPMw26EZ05wmGoOfY+bAp5kjih8Ywqgqy1g0tbNl3E8KjLHp10
 lr+I2pqNXn6ezEfy/1l41WaQ9p+zmytO7pix1dZ+ZX6u7RncvUlJaCEb1fe763hR81xPAjyMA3GrY
 hf/eixWUxzxeJ0pIYnSxnzLqVAsCywKuWGbs0KUZUSeoUA2rx2kQoxRb0ZN5m5xiRXahZl/vPmzyq
 oRomLihRiO4Dcg5BhDUpoTJIS7wRzPCFIC7xLJZOwK1SI0OWMXhMHXZ0rQ6VqJAYd47xomcflwqsD
 U5wA+JlKpNB0li24vGAJqg==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1vWete-007RYq-0x;
 Fri, 19 Dec 2025 19:08:10 +0100
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 1/1] qcow2: add very final sync on QCOW2 image closing
Date: Fri, 19 Dec 2025 19:08:13 +0100
Message-ID: <20251219180813.1000884-1-den@openvz.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=ham autolearn_force=no
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

qcow2_header_updated() is the final call during image close. This means
after this point we will have no IO operations on this file descriptor.
This assumption has been validated via 'strace' which clearly confirms
that this is very final write and there is no sync after this point.

There is almost no problem when the image is residing in local
filesystem except that we will have image check if the chage will
not reach disk before powerloss, but with a network or distributed
filesystem we come to trouble. The change could be in flight and we
can miss this data on other node like during migration.

The patch adds BDRV_REQ_FUA to the write request to do the trick.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
---
 block/qcow2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index e29810d86a..abbc4e82ba 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3252,7 +3252,7 @@ int qcow2_update_header(BlockDriverState *bs)
     }
 
     /* Write the new header */
-    ret = bdrv_pwrite(bs->file, 0, s->cluster_size, header, 0);
+    ret = bdrv_pwrite(bs->file, 0, s->cluster_size, header, BDRV_REQ_FUA);
     if (ret < 0) {
         goto fail;
     }
-- 
2.51.0


