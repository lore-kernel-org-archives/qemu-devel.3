Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148A2CD98EE
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 06:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZk0H-00052r-7C; Wed, 17 Jun 2026 02:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wZk08-00050k-7u
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 02:43:52 -0400
Received: from [115.124.30.113] (helo=out30-113.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wZk04-00087t-12
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 02:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1781678615; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=RvHiGd84B4E+MzEP41DH/YKTdVyWkPmp3PJ1VyYskjc=;
 b=BQoKB4Sm6716Lsu/pi8zdiB7V7375RjAlUWuUT977yk37u4t5A7tUhCWIOrxvwFoyTJDNXYCBcQLZT73m4nVckq9UkqnDvIFdIDFB+EefMNY0hegQ7+WUb1k7VAs9kQXaWQVge+vPItX9JXEIAlrIzuIc32KQl/dbF5fzU24nyg=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0X52TpQs_1781678614; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X52TpQs_1781678614 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 17 Jun 2026 14:43:34 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	lizhijian@fujitsu.com,
	farosas@suse.de
Subject: [PATCH v2 2/2] migration/rdma: account transferred bytes for zero
 page compression
Date: Wed, 17 Jun 2026 14:43:32 +0800
Message-ID: <20260617064332.75618-2-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260617064332.75618-1-guobin@linux.alibaba.com>
References: <20260617064332.75618-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.113 (deferred)
Received-SPF: pass client-ip=115.124.30.113;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-113.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

RDMA zero page compression sends an RDMA_CONTROL_COMPRESS message
instead of an RDMA Write, but the transfer accounting
(mig_stats.rdma_bytes and ram_transferred_add) was not updated.
This caused migration progress and bandwidth to be undercounted.

Account the wire cost (RDMAControlHeader + RDMACompress payload),
matching how the non-RDMA path accounts for zero page markers.

Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 migration/rdma.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 201cb9eb12..f08468881f 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1930,15 +1930,15 @@ retry:
                 }
 
                 /*
-                 * TODO: Here we are sending something, but we are not
-                 * accounting for anything transferred.  The following is wrong:
-                 *
-                 * stat64_add(&mig_stats.rdma_bytes, sge.length);
-                 *
-                 * because we are using some kind of compression.  I
-                 * would think that head.len would be the more similar
-                 * thing to a correct value.
+                 * Account for the control message we just sent.
+                 * The actual bytes on the wire are the control header
+                 * plus the RDMACompress payload, not the original page
+                 * size (which was never transferred).
                  */
+                qatomic_add(&mig_stats.rdma_bytes,
+                            sizeof(RDMAControlHeader) + sizeof(RDMACompress));
+                ram_transferred_add(sizeof(RDMAControlHeader) +
+                                    sizeof(RDMACompress));
                 qatomic_add(&mig_stats.zero_pages,
                             sge.length / qemu_target_page_size());
                 return 1;
-- 
2.50.1 (Apple Git-155)


