Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADC7CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 11:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOviy-0006ZK-SG; Mon, 18 May 2026 07:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wOviv-0006Y2-8H
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:01:25 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wOvis-0005iH-MA
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1779102078; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=8+8p3ol65rhq0ecDJNkEpWpx97Ua/BIn3MGtDEFk66o=;
 b=VE8pr4T2zcC3NhtjIeg/k1V75viX6qFg3FZtioHxW3E7QAkiCaNSzxU5Ze5TxmJwmI30LMs8RZaEfzAOKyrIuhdnAwSSRYBj1LFHUVdJ5crwd+wVCWC8KXxdw1CKIPGhABsMVAk8qmXMzOgTIh/wSsntZkq/mfWlCeHowf+esms=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0X38AAVS_1779102077; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X38AAVS_1779102077 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 18 May 2026 19:01:17 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de
Subject: [PATCH 6/8] migration/multifd: merge thread-join and cleanup loops in
 multifd_recv_cleanup
Date: Mon, 18 May 2026 19:01:10 +0800
Message-ID: <20260518110112.21395-7-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260518110112.21395-1-guobin@linux.alibaba.com>
References: <20260518110112.21395-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.131;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-131.freemail.mail.aliyun.com
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

multifd_recv_cleanup() iterates over all receive channels twice:
one loop to join threads and another to clean up each channel.  Unlike
the send side where all threads must be signalled before any is joined
(to avoid deadlock), on the receive side the threads are already
terminated by multifd_recv_terminate_threads().  Each join simply
waits for an already-terminated thread, so the join and cleanup for
channel i are independent of channel j, and the two loops can safely
be merged into one.

This cuts the iteration count in half and improves locality: the
thread's resources are freed immediately after its join.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 migration/multifd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index b3eef875cc..67ee9bdf5e 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1153,15 +1153,14 @@ void multifd_recv_cleanup(void)
         return;
     }
     multifd_recv_terminate_threads(NULL);
+
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
         if (p->thread_created) {
             qemu_thread_join(&p->thread);
         }
-    }
-    for (i = 0; i < migrate_multifd_channels(); i++) {
-        multifd_recv_cleanup_channel(&multifd_recv_state->params[i]);
+        multifd_recv_cleanup_channel(p);
     }
     multifd_recv_cleanup_state();
 }
-- 
2.50.1 (Apple Git-155)


