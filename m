Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1687C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuARM-0002yF-5J; Wed, 12 Aug 2026 11:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAR0-00024I-2K; Wed, 12 Aug 2026 11:00:03 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAQx-0001jD-3J; Wed, 12 Aug 2026 11:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546233; bh=ZTsIC9tM2UMS3Br6vxpl/HgUmamFLSeZlh3TEzQc5bw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=yI/6p/uYanpRzjR3tMmxcAJipY8lgF6pAIixpXRrk9/cr9YHlRwtkb6UBeNX6uK9m
 rkuMR2L+5nTrduSk5vsHZzA5X1ag6kzPxK1/6hZdxSgbBysZGyolDsVIMa8LbRSoIx
 e65IKAHbwx1OaqIJWc9qK15xDZ4GMzR5kEfyd9ZbDiO2EQA8cA9qfJeULirBHt16b1
 XDtjWj8zUHsVbtq+oZ7yHRW0BSXGMYL1VZRblNGbbAljVo9ua44Jtyze7vE2hFZ5gg
 I4su5K4TlV4J7IVHSeRgjx4HU3HjfYVO+wuPsJvodpODbOWMMZJMaNm2m1tUkXmK4W
 +1coOV5q/UYiQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 585DA1CA660;
 Wed, 12 Aug 2026 17:50:33 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B3401409DA2;
 Wed, 12 Aug 2026 17:50:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 1ED252FA1B; Wed, 12 Aug 2026 17:50:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, malike <malike@kylinos.cn>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 092/120] block/cloop: fix integer overflow in
 total_sectors calculation
Date: Wed, 12 Aug 2026 17:49:15 +0300
Message-ID: <20260812144955.649205-92-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: malike <malike@kylinos.cn>

The total_sectors is computed as n_blocks * sectors_per_block where
both operands are uint32_t. The multiplication is performed in 32-bit
arithmetic and can overflow when the product exceeds UINT32_MAX,
producing a value much smaller than the true image size. The result
is assigned to int64_t total_sectors but the 32-bit multiplication
has already wrapped around, and the zero-extension to 64-bit does
not recover the correct value.

This causes the block layer to reject valid I/O requests (DoS) when
the reported total_sectors is smaller than the actual image.

Use 64-bit arithmetic by casting one operand to uint64_t so the
multiplication is performed in 64-bit precision.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3972
Signed-off-by: Ma Like <malike@kylinos.cn>
Message-ID: <20260713031750.58448-1-malike@kylinos.cn>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 0d3db94a886610c5923e52cc23f841ccb9cb546c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/cloop.c b/block/cloop.c
index 443af1444e8..a16f08e6ef6 100644
--- a/block/cloop.c
+++ b/block/cloop.c
@@ -202,7 +202,8 @@ static int cloop_open(BlockDriverState *bs, QDict *options, int flags,
     s->current_block = s->n_blocks;
 
     s->sectors_per_block = s->block_size/512;
-    bs->total_sectors = s->n_blocks * s->sectors_per_block;
+    /* Cast to uint64_t to prevent uint32_t overflow */
+    bs->total_sectors = (uint64_t)s->n_blocks * s->sectors_per_block;
     qemu_co_mutex_init(&s->lock);
     return 0;
 
-- 
2.47.3


