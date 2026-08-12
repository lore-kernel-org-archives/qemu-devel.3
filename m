Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A79C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8jG-0000vJ-SZ; Wed, 12 Aug 2026 09:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8jE-0000o0-8G; Wed, 12 Aug 2026 09:10:44 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8jC-00068C-DL; Wed, 12 Aug 2026 09:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539784; bh=a0iP75LbtPykcsRAHHU8CcY6Iv58uyrPqwiflMHn8ZE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DNpmpLRBLb8jo7MRbgCOE/d+P0vtgLb2Imv8t+nd6yMzsvtrzZ+9xXQk/7rs1NoF4
 /TwsufRGwHvXSP1MvZ1boXV20JN9tk+KfORO+45/tAusjbQ7/HXfzK2TAcAr4AJizC
 RGfqF1AE1O3EvqgXgl2GaapuA4KjaLzRb2b+6FfbvrEiJffUjIjZok2mtiIKlSvZ/w
 Kcvz5ZAfnWHOySZdXgKD+S1CoDO0M+THHOzyFC5zXV71P1oOiPf0pJacvk/HUyGwHk
 UBMqF46XbTecg6pfCVDckM3L3Jyf4T73P7QpPQhqHI2MpTyLlsAB6xsokg7TkibW4x
 UhZGi+xQLIPvQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 828881CA4CF;
 Wed, 12 Aug 2026 16:03:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B9031409BB2;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A09422F934; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 080/102] block/qapi: take stats->lock when reading
 BlockAcctStats for query-blockstats
Date: Wed, 12 Aug 2026 16:01:55 +0300
Message-ID: <20260812130233.621965-80-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
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

From: "Denis V. Lunev" <den@openvz.org>

bdrv_query_blk_stats() reads BlockAcctStats's counters, latency
histogram, and per-interval TimedAverage stats without stats->lock,
while block_account_one_io() updates the same fields under that lock
from an iothread. timed_average_min()/max()/avg() make this worse
than a stale read: they call check_expirations(), which can reset a
window's sum/count/min/max -- a write, not just a read -- so this is
a genuine race with a concurrent writer, not merely a slower reader
like the scalar counters.

Take stats->lock for the whole call, both to close the race and to
make the returned snapshot internally consistent (previously each
field could reflect a different instant relative to concurrent
updates).

block_acct_queue_depth() used to take the lock itself on every call;
since bdrv_query_blk_stats() is its only caller and now already holds
the lock, that would self-deadlock. Make it require the caller to
hold stats->lock instead (documented and asserted).

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Message-ID: <20260724111311.4086859-3-den@openvz.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 16f94ef4c6ce3e7ca6b02b796580e2cfc41e9789)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/accounting.c b/block/accounting.c
index c5584abb76e..79e2a37e8a7 100644
--- a/block/accounting.c
+++ b/block/accounting.c
@@ -306,10 +306,9 @@ double block_acct_queue_depth(BlockAcctTimedStats *stats,
     uint64_t sum, elapsed;
 
     assert(type < BLOCK_MAX_IOTYPE);
+    assert(qemu_mutex_trylock(&stats->stats->lock) == -EBUSY);
 
-    qemu_mutex_lock(&stats->stats->lock);
     sum = timed_average_sum(&stats->latency[type], &elapsed);
-    qemu_mutex_unlock(&stats->stats->lock);
 
     return (double) sum / elapsed;
 }
diff --git a/block/qapi.c b/block/qapi.c
index 2c50a6bf3b8..33cb1b18b77 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -498,6 +498,8 @@ static void bdrv_query_blk_stats(BlockDeviceStats *ds, BlockBackend *blk)
     BlockAcctTimedStats *ts = NULL;
     BlockLatencyHistogram *hgram;
 
+    qemu_mutex_lock(&stats->lock);
+
     ds->rd_bytes = stats->nr_bytes[BLOCK_ACCT_READ];
     ds->wr_bytes = stats->nr_bytes[BLOCK_ACCT_WRITE];
     ds->zone_append_bytes = stats->nr_bytes[BLOCK_ACCT_ZONE_APPEND];
@@ -587,6 +589,7 @@ static void bdrv_query_blk_stats(BlockDeviceStats *ds, BlockBackend *blk)
         = bdrv_latency_histogram_stats(&hgram[BLOCK_ACCT_ZONE_APPEND]);
     ds->flush_latency_histogram
         = bdrv_latency_histogram_stats(&hgram[BLOCK_ACCT_FLUSH]);
+    qemu_mutex_unlock(&stats->lock);
 }
 
 static BlockStats * GRAPH_RDLOCK
diff --git a/include/block/accounting.h b/include/block/accounting.h
index a59e39f49d9..6982add4d57 100644
--- a/include/block/accounting.h
+++ b/include/block/accounting.h
@@ -115,6 +115,7 @@ void block_acct_invalid(BlockAcctStats *stats, enum BlockAcctType type);
 void block_acct_merge_done(BlockAcctStats *stats, enum BlockAcctType type,
                            int num_requests);
 int64_t block_acct_idle_time_ns(BlockAcctStats *stats);
+/* Caller must hold stats->stats->lock. */
 double block_acct_queue_depth(BlockAcctTimedStats *stats,
                               enum BlockAcctType type);
 int block_latency_histogram_set(BlockAcctStats *stats, enum BlockAcctType type,
-- 
2.47.3


