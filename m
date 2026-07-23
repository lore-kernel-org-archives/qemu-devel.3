Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D77C531CB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 12:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmsge-0008BI-Tc; Thu, 23 Jul 2026 08:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wmsgT-00089q-Vq
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 08:37:55 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wmsgS-0008Tr-45
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 08:37:53 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c1c50c1e29bso82615966b.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 05:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1784810271; x=1785415071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PKfV0SXokYEslLTXjXh9+wVue+6wOlJ2hIFXS73iA80=;
 b=eSAakjUe/wh74APlrFeMMrlvYE1O+gYXdcrOF7cMGGc1BkRBBFgBRW8LKRmFtuU8+B
 0ajumbUUdaKc3cNb7wWwrMdpwQMJQGyMTEFqBUV9t/bmUyC4mAqrLiOAEqyJm3OcQOrm
 GQB8lUufVVzomx4RYpP0/J8TaeqommmHHE/mZwy47Fv+4PAfb178opjFn+1Ys6awvmB7
 8t6j04HqUR7EOOLwMFK7yQaLYBeBWQqtRRMtjaLzrpxtU00dSiKKZRpu6+FzUfMmqWl1
 7nPJzfMs0vYQsph5TPjBYyEBqC1kkPf4519VR32F8LVh7mZ0WWow+I7G7SNKWjoaKh4j
 ANMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784810271; x=1785415071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PKfV0SXokYEslLTXjXh9+wVue+6wOlJ2hIFXS73iA80=;
 b=d3nB/SSzylic5HOKuSPTEFuoBW/HfWlYAmFYJvJfSOVyOtmDcjNMqQ7D1IFxhFPbRA
 gpX5BydDRnCXvWARilk701WZYbPF12yg4WGXzELw051Sz4RE/H5SehTSR+XRTW6k0vc+
 ncI4Bv5F48/tjxGzK9hJWbFKIk6MWnaa/nh5HrhcLkhQaHDGB6Dr8htNeDvZ/Oik0kyG
 oRwyI4KrHvJiQdzTJkgwhPFMs/+nRiFaN+m2dlCGNVFVAYascUesp0VsuhfvraUFVbBn
 Lf6TFuD8G3oiIOwHCgKvDNyVLD2KVlOhpE3GZncNaRNYlJSfxQU/yJNyS83fguNbMXb5
 iQlg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqzGaT6tCcYrZu8E/uU+46B9RlDB/XFC0V1ndFEeKFiiHfv969MEPr8KUvyYPThRbyVsHHhhtAVTBpE@nongnu.org
X-Gm-Message-State: AOJu0YxTzIaSPIN+8lt2vQKG6R/CjrbOjolopb03Xx341YSpiPZn7tqW
 5kRlDBPwc/og2s64ZFdCbPIn9piTMlx07gTEz04in+W3V6fhGV7uG/FHXcSz8roOqxU=
X-Gm-Gg: AR+sD11kexQMPy74L8eYZMQAvuCrSnizciAhFKox/O1w7F/cV3kFZ1Z+icz1ak5rN71
 LXPailaMA0fiEHYRb8dLxtKjPypuI1x65gEpfogPlSvYJ7JdUXHUTO0NqaPnfpsM+Zeohnp1Ace
 ETg9fhorkLdFcZ5fWnrRpO11mmzc+FlOte4ggAf/a+2ke+LnBQTrP7YLI8/YkA0G/aSkl7FcnTR
 J4bbwj8REtydZL/M79e8HR79YdkPQ9XbEu2j7WzlNRjANFN3rPypwqmq6uG6OZqL+6Ey8ayTF5k
 8mQEKIBdrYGphoaVL70ZFb+9gzWL0Jl/MhOiLowezWkq3dO+eA6HaXrrQxp3wAvdJe9+6x+tW3l
 xDZdsztbH70OMpKwq3zUExiZKmxIcK7LLEs8LNyVLOARjGsfiTSDp3a8xqbPnM9EfcgKy8nO4Dp
 c=
X-Received: by 2002:a17:907:25c3:b0:bed:9a7:5ed1 with SMTP id
 a640c23a62f3a-c1c506e8a62mr129875666b.5.1784810270703; 
 Thu, 23 Jul 2026 05:37:50 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:b8fe:da40:80d9:ac01])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32c90b58sm222619166b.39.2026.07.23.05.37.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 05:37:50 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 2/3] block/qapi: take stats->lock when reading BlockAcctStats
 for query-blockstats
Date: Thu, 23 Jul 2026 14:37:44 +0200
Message-ID: <20260723123745.3294227-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723123745.3294227-1-den@openvz.org>
References: <20260723123745.3294227-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=den@openvz.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

bdrv_query_blk_stats() reads nr_bytes[], nr_ops[], failed_ops[],
invalid_ops[], merged[], total_time_ns[], last_access_time_ns, and
the latency histogram bins directly off BlockAcctStats, without
taking stats->lock. block_account_one_io() updates the same fields
under that lock from whatever iothread completes the I/O, so this is
an unsynchronized read of concurrently-updated state.

This is a narrower issue than the one fixed for the histogram
setters. query-blockstats and block-latency-histogram-set are both
plain (non-allow-oob) QMP commands, so they always run serialized on
the monitor thread and can never execute concurrently with each
other.

Take stats->lock around the read for consistency.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/qapi.c | 102 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 60 insertions(+), 42 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index eabfbfc258..c3f20832b7 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -535,49 +535,67 @@ static void bdrv_query_blk_stats(BlockDeviceStats *ds, BlockBackend *blk)
     BlockAcctTimedStats *ts = NULL;
     BlockLatencyHistogram *hgram;
 
-    ds->rd_bytes = stats->nr_bytes[BLOCK_ACCT_READ];
-    ds->wr_bytes = stats->nr_bytes[BLOCK_ACCT_WRITE];
-    ds->zone_append_bytes = stats->nr_bytes[BLOCK_ACCT_ZONE_APPEND];
-    ds->unmap_bytes = stats->nr_bytes[BLOCK_ACCT_UNMAP];
-    ds->rd_operations = stats->nr_ops[BLOCK_ACCT_READ];
-    ds->wr_operations = stats->nr_ops[BLOCK_ACCT_WRITE];
-    ds->zone_append_operations = stats->nr_ops[BLOCK_ACCT_ZONE_APPEND];
-    ds->unmap_operations = stats->nr_ops[BLOCK_ACCT_UNMAP];
-
-    ds->failed_rd_operations = stats->failed_ops[BLOCK_ACCT_READ];
-    ds->failed_wr_operations = stats->failed_ops[BLOCK_ACCT_WRITE];
-    ds->failed_zone_append_operations =
-        stats->failed_ops[BLOCK_ACCT_ZONE_APPEND];
-    ds->failed_flush_operations = stats->failed_ops[BLOCK_ACCT_FLUSH];
-    ds->failed_unmap_operations = stats->failed_ops[BLOCK_ACCT_UNMAP];
-
-    ds->invalid_rd_operations = stats->invalid_ops[BLOCK_ACCT_READ];
-    ds->invalid_wr_operations = stats->invalid_ops[BLOCK_ACCT_WRITE];
-    ds->invalid_zone_append_operations =
-        stats->invalid_ops[BLOCK_ACCT_ZONE_APPEND];
-    ds->invalid_flush_operations =
-        stats->invalid_ops[BLOCK_ACCT_FLUSH];
-    ds->invalid_unmap_operations = stats->invalid_ops[BLOCK_ACCT_UNMAP];
-
-    ds->rd_merged = stats->merged[BLOCK_ACCT_READ];
-    ds->wr_merged = stats->merged[BLOCK_ACCT_WRITE];
-    ds->zone_append_merged = stats->merged[BLOCK_ACCT_ZONE_APPEND];
-    ds->unmap_merged = stats->merged[BLOCK_ACCT_UNMAP];
-    ds->flush_operations = stats->nr_ops[BLOCK_ACCT_FLUSH];
-    ds->wr_total_time_ns = stats->total_time_ns[BLOCK_ACCT_WRITE];
-    ds->zone_append_total_time_ns =
-        stats->total_time_ns[BLOCK_ACCT_ZONE_APPEND];
-    ds->rd_total_time_ns = stats->total_time_ns[BLOCK_ACCT_READ];
-    ds->flush_total_time_ns = stats->total_time_ns[BLOCK_ACCT_FLUSH];
-    ds->unmap_total_time_ns = stats->total_time_ns[BLOCK_ACCT_UNMAP];
-
-    ds->has_idle_time_ns = stats->last_access_time_ns > 0;
-    if (ds->has_idle_time_ns) {
-        ds->idle_time_ns = block_acct_idle_time_ns(stats);
-    }
+    /*
+     * nr_bytes[] etc. are mutated under stats->lock by block_account_one_io()
+     * from an iothread, and latency_histogram[].{nbins,boundaries,bins} can
+     * be freed and reallocated by a concurrent block_latency_histogram_set()
+     * on the monitor thread, so every read here needs the same lock.
+     */
+    WITH_QEMU_LOCK_GUARD(&stats->lock) {
+        ds->rd_bytes = stats->nr_bytes[BLOCK_ACCT_READ];
+        ds->wr_bytes = stats->nr_bytes[BLOCK_ACCT_WRITE];
+        ds->zone_append_bytes = stats->nr_bytes[BLOCK_ACCT_ZONE_APPEND];
+        ds->unmap_bytes = stats->nr_bytes[BLOCK_ACCT_UNMAP];
+        ds->rd_operations = stats->nr_ops[BLOCK_ACCT_READ];
+        ds->wr_operations = stats->nr_ops[BLOCK_ACCT_WRITE];
+        ds->zone_append_operations = stats->nr_ops[BLOCK_ACCT_ZONE_APPEND];
+        ds->unmap_operations = stats->nr_ops[BLOCK_ACCT_UNMAP];
+
+        ds->failed_rd_operations = stats->failed_ops[BLOCK_ACCT_READ];
+        ds->failed_wr_operations = stats->failed_ops[BLOCK_ACCT_WRITE];
+        ds->failed_zone_append_operations =
+            stats->failed_ops[BLOCK_ACCT_ZONE_APPEND];
+        ds->failed_flush_operations = stats->failed_ops[BLOCK_ACCT_FLUSH];
+        ds->failed_unmap_operations = stats->failed_ops[BLOCK_ACCT_UNMAP];
+
+        ds->invalid_rd_operations = stats->invalid_ops[BLOCK_ACCT_READ];
+        ds->invalid_wr_operations = stats->invalid_ops[BLOCK_ACCT_WRITE];
+        ds->invalid_zone_append_operations =
+            stats->invalid_ops[BLOCK_ACCT_ZONE_APPEND];
+        ds->invalid_flush_operations =
+            stats->invalid_ops[BLOCK_ACCT_FLUSH];
+        ds->invalid_unmap_operations = stats->invalid_ops[BLOCK_ACCT_UNMAP];
+
+        ds->rd_merged = stats->merged[BLOCK_ACCT_READ];
+        ds->wr_merged = stats->merged[BLOCK_ACCT_WRITE];
+        ds->zone_append_merged = stats->merged[BLOCK_ACCT_ZONE_APPEND];
+        ds->unmap_merged = stats->merged[BLOCK_ACCT_UNMAP];
+        ds->flush_operations = stats->nr_ops[BLOCK_ACCT_FLUSH];
+        ds->wr_total_time_ns = stats->total_time_ns[BLOCK_ACCT_WRITE];
+        ds->zone_append_total_time_ns =
+            stats->total_time_ns[BLOCK_ACCT_ZONE_APPEND];
+        ds->rd_total_time_ns = stats->total_time_ns[BLOCK_ACCT_READ];
+        ds->flush_total_time_ns = stats->total_time_ns[BLOCK_ACCT_FLUSH];
+        ds->unmap_total_time_ns = stats->total_time_ns[BLOCK_ACCT_UNMAP];
+
+        ds->has_idle_time_ns = stats->last_access_time_ns > 0;
+        if (ds->has_idle_time_ns) {
+            ds->idle_time_ns = block_acct_idle_time_ns(stats);
+        }
 
-    ds->account_invalid = stats->account_invalid;
-    ds->account_failed = stats->account_failed;
+        ds->account_invalid = stats->account_invalid;
+        ds->account_failed = stats->account_failed;
+
+        hgram = stats->latency_histogram;
+        ds->rd_latency_histogram
+            = bdrv_latency_histogram_stats(&hgram[BLOCK_ACCT_READ]);
+        ds->wr_latency_histogram
+            = bdrv_latency_histogram_stats(&hgram[BLOCK_ACCT_WRITE]);
+        ds->zone_append_latency_histogram
+            = bdrv_latency_histogram_stats(&hgram[BLOCK_ACCT_ZONE_APPEND]);
+        ds->flush_latency_histogram
+            = bdrv_latency_histogram_stats(&hgram[BLOCK_ACCT_FLUSH]);
+    }
 
     while ((ts = block_acct_interval_next(stats, ts))) {
         BlockDeviceTimedStats *dev_stats = g_malloc0(sizeof(*dev_stats));
-- 
2.53.0


