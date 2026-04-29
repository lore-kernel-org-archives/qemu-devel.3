Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD46FF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 06:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHyJ6-0004r5-I5; Wed, 29 Apr 2026 02:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wHyHx-0004Vr-Gw; Wed, 29 Apr 2026 02:20:51 -0400
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wHyHr-00078I-Uj; Wed, 29 Apr 2026 02:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1777443629; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=MARf+gfsHcq6jSDjRoPtErFT1ue1g868Ee90sY5sqak=;
 b=wr0U93eZxno4saD9w/3jnAR7Nb08wjxxWZjLsGQCsdzxv+9Z8XQi5VJE/OcpCHHfLvOWeHAdbHP1a1lQsV+nTYD5lk1FbSGyBLkWmaI7bOJhuXE03XZVdcEKvvqviB+B2og92h/g4FOIwKkBYHA7jlxKvDSpvqqGwI2prqtwCCo=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam011083073210;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=6; SR=0;
 TI=SMTPD_---0X1wgCg6_1777443622; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X1wgCg6_1777443622 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 29 Apr 2026 14:20:28 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com, qemu-block@nongnu.org
Subject: [PATCH 2/3] block/block-backend: delegate blk_co_preadv to
 blk_co_preadv_part
Date: Wed, 29 Apr 2026 14:20:03 +0800
Message-ID: <20260429062004.36582-3-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260429062004.36582-1-guobin@linux.alibaba.com>
References: <20260429062004.36582-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.118;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-118.freemail.mail.aliyun.com
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

blk_co_preadv() and blk_co_preadv_part() share identical bodies except
that blk_co_preadv() always passes qiov_offset=0.  blk_co_pwritev()
already uses this pattern and simply calls blk_co_pwritev_part() with
qiov_offset=0.  Apply the same simplification to the read side so that
both pairs are consistent and the shared logic lives in a single place.

Before this change blk_co_preadv() duplicated the
blk_inc_in_flight / blk_co_do_preadv_part / blk_dec_in_flight
sequence.  After this change it is a one-liner wrapper, matching the
write side.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 block/block-backend.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 9944657120..490b149bf8 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1376,14 +1376,8 @@ int coroutine_fn blk_co_preadv(BlockBackend *blk, int64_t offset,
                                int64_t bytes, QEMUIOVector *qiov,
                                BdrvRequestFlags flags)
 {
-    int ret;
     IO_OR_GS_CODE();
-
-    blk_inc_in_flight(blk);
-    ret = blk_co_do_preadv_part(blk, offset, bytes, qiov, 0, flags);
-    blk_dec_in_flight(blk);
-
-    return ret;
+    return blk_co_preadv_part(blk, offset, bytes, qiov, 0, flags);
 }
 
 int coroutine_fn blk_co_preadv_part(BlockBackend *blk, int64_t offset,
-- 
2.50.1 (Apple Git-155)


