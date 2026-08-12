Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E191BC5CFCF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuARH-0002ez-Gg; Wed, 12 Aug 2026 11:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAR7-0002Fz-Q2; Wed, 12 Aug 2026 11:00:11 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAR1-0001nR-I8; Wed, 12 Aug 2026 11:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546233; bh=r6AVMyggxDeu9kfBLkC4tiGT1cW2mG3DgvSGSEAyloA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gREvUM1L7qcAgWgwtaf1VGljSCIE8TAQuCcAJbKJjwTDa8JjziSHHk6NAtHuOgw5m
 BoXj2QvShmETlkfk+46NwPcgtRFuTN0k+uEw1rE18RRDipqxnkuTFnJgw6fm/h9AqP
 DeDQQ6cfSD5/ewMBkk+XkV8E7boCc3/BBiEqFKhbbRld1UqM7Zca8hkfZeY3cvTgfk
 eB2DzNG5JoDuEIk81R9ZVSDhMCd9msEE4fVFm8rhA9Ynqr8T3ZSGYAMy4XM1j1jAr0
 A4W71HTlb+rwl6PrmW7buXtoUkLdNPreJREJtdXSJzNFwxsNXj273lPnsEzlpvEj/2
 885+hg9KLLDXQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 68EE11CA662;
 Wed, 12 Aug 2026 17:50:33 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C370F409DA4;
 Wed, 12 Aug 2026 17:50:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 2CA962FA1F; Wed, 12 Aug 2026 17:50:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 094/120] block/qapi: take stats->lock when reading
 BlockAcctStats for query-blockstats
Date: Wed, 12 Aug 2026 17:49:17 +0300
Message-ID: <20260812144955.649205-94-mjt@tls.msk.ru>
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
index 6e06c7609eb..038af370170 100644
--- a/block/accounting.c
+++ b/block/accounting.c
@@ -318,10 +318,9 @@ double block_acct_queue_depth(BlockAcctTimedStats *stats,
     uint64_t sum, elapsed;
 
     assert(type < BLOCK_MAX_IOTYPE);
+    assert(qemu_mutex_trylock(&stats->stats->lock) == -EBUSY);
 
-    qemu_mutex_lock(&stats->stats->lock);
     sum = timed_average_sum(&stats->latency[type], &elapsed);
-    qemu_mutex_unlock(&stats->stats->lock);
 
     return (double) sum / elapsed;
 }
diff --git a/block/qapi.c b/block/qapi.c
index eabfbfc2585..1dfac510918 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -535,6 +535,8 @@ static void bdrv_query_blk_stats(BlockDeviceStats *ds, BlockBackend *blk)
     BlockAcctTimedStats *ts = NULL;
     BlockLatencyHistogram *hgram;
 
+    qemu_mutex_lock(&stats->lock);
+
     ds->rd_bytes = stats->nr_bytes[BLOCK_ACCT_READ];
     ds->wr_bytes = stats->nr_bytes[BLOCK_ACCT_WRITE];
     ds->zone_append_bytes = stats->nr_bytes[BLOCK_ACCT_ZONE_APPEND];
@@ -624,6 +626,7 @@ static void bdrv_query_blk_stats(BlockDeviceStats *ds, BlockBackend *blk)
         = bdrv_latency_histogram_stats(&hgram[BLOCK_ACCT_ZONE_APPEND]);
     ds->flush_latency_histogram
         = bdrv_latency_histogram_stats(&hgram[BLOCK_ACCT_FLUSH]);
+    qemu_mutex_unlock(&stats->lock);
 }
 
 static BlockStats * GRAPH_RDLOCK
diff --git a/include/block/accounting.h b/include/block/accounting.h
index b1cf417b572..12d32460927 100644
--- a/include/block/accounting.h
+++ b/include/block/accounting.h
@@ -116,6 +116,7 @@ void block_acct_invalid(BlockAcctStats *stats, enum BlockAcctType type);
 void block_acct_merge_done(BlockAcctStats *stats, enum BlockAcctType type,
                            int num_requests);
 int64_t block_acct_idle_time_ns(BlockAcctStats *stats);
+/* Caller must hold stats->stats->lock. */
 double block_acct_queue_depth(BlockAcctTimedStats *stats,
                               enum BlockAcctType type);
 int block_latency_histogram_set(BlockAcctStats *stats, enum BlockAcctType type,
-- 
2.47.3


