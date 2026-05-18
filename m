Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FB0CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 11:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOvj2-0006bD-HR; Mon, 18 May 2026 07:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wOviw-0006YS-VM
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:01:26 -0400
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wOvit-0005i8-O7
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1779102077; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=in4Q+1qeG1MAXIiZjKRIDZMBVwfkTU/oNDsy/TkG1Ks=;
 b=gbygNqVTM+ZnWRdDupFRgfUDrFUB/cMM0lpVJcXQhV+dAK50HuefUp+N2Oa/QZCgQieAxjzOmd+U4FSBInQuMxmJPkgDufuC+Y4sVGRMhxzG7d8nA8SRKgB5yak2vA1Ns5DHWzM00p4DrIPyvsDC/TDqjo9/Frdg9Pkb1Rck1bA=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037009110;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0X38AAVB_1779102076; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X38AAVB_1779102076 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 18 May 2026 19:01:17 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de
Subject: [PATCH 5/8] migration/multifd: fix off-by-one in recv channel ID
 validation
Date: Mon, 18 May 2026 19:01:09 +0800
Message-ID: <20260518110112.21395-6-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260518110112.21395-1-guobin@linux.alibaba.com>
References: <20260518110112.21395-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.99;
 envelope-from=guobin@linux.alibaba.com; helo=out30-99.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

multifd_recv_initial_packet() validates the channel ID received from
the source against the configured number of channels. The current
check uses '>' which allows msg.id == N to pass through. This ID is
then used to index multifd_recv_state->params[msg.id], which was
allocated with g_new0(MultiFDRecvParams, N) -- an out-of-bounds
access.

A malicious or buggy source could send id == N and cause heap
corruption on the destination.

Fix by changing '>' to '>='. Also fix the error message to say
"exceeds channel count" for accuracy.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 migration/multifd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 035cb70f7b..b3eef875cc 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -210,9 +210,9 @@ static int multifd_recv_initial_packet(QIOChannel *c, Error **errp)
         return -1;
     }
 
-    if (msg.id > migrate_multifd_channels()) {
-        error_setg(errp, "multifd: received channel id %u is greater than "
-                   "number of channels %u", msg.id, migrate_multifd_channels());
+    if (msg.id >= migrate_multifd_channels()) {
+        error_setg(errp, "multifd: received channel id %u exceeds "
+                   "channel count %u", msg.id, migrate_multifd_channels());
         return -1;
     }
 
-- 
2.50.1 (Apple Git-155)


