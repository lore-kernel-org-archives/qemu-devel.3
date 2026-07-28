Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83FFC54F54
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 17:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wolkb-0007UE-4U; Tue, 28 Jul 2026 13:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wolkZ-0007SR-L2
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:37:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wolkX-0005uA-L8
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785260273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TUfP1MZqGOC1JM5FBKvAKia4foMHvKwuszAbsWpwtVs=;
 b=bzZ1wH0JF8J65vDY0ZTaf1NRpnJgcf2i4mZv9Ff+30MP2DV/8Rdq//guswZdu0OC0vjg0h
 WFg+OGVaZDIf9sPAQu4ZPYk+4j51ptBf2lotw+TBsmrovFf58cGlFAALvcfrmtlFPP2E7H
 91Pjgpj4y0o909xE3ssX6hoS/XQedLY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-XFA5Q5TxOjysqgU1VC8vfA-1; Tue,
 28 Jul 2026 13:37:51 -0400
X-MC-Unique: XFA5Q5TxOjysqgU1VC8vfA-1
X-Mimecast-MFC-AGG-ID: XFA5Q5TxOjysqgU1VC8vfA_1785260270
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50664180057B; Tue, 28 Jul 2026 17:37:50 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.49.201])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D324D19560AB; Tue, 28 Jul 2026 17:37:48 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 03/17] block/qapi: take stats->lock when reading BlockAcctStats
 for query-blockstats
Date: Tue, 28 Jul 2026 19:37:25 +0200
Message-ID: <20260728173739.352078-4-kwolf@redhat.com>
In-Reply-To: <20260728173739.352078-1-kwolf@redhat.com>
References: <20260728173739.352078-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 include/block/accounting.h | 1 +
 block/accounting.c         | 3 +--
 block/qapi.c               | 3 +++
 3 files changed, 5 insertions(+), 2 deletions(-)

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
-- 
2.55.0


