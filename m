Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EEDC54F4D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 17:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wolkn-0007bs-P1; Tue, 28 Jul 2026 13:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wolkc-0007VQ-OX
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:38:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wolkb-0005ut-3R
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785260276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZgqdjJosFXzFF//IVWqTtWQUTkOOL3qZXel9XxMrhUc=;
 b=YklLdiDxWrrOvWKHtukMB8Mzg/553QyITfPMjVkQkhCFJvx++FwQcGqCYEDRfdFqTGt5xn
 zO3YIIKW6pzgykKhBwingTQeBPA0ZNTnmrzHGsc76qSlAegUuOky17kvQ243xaYt1Eupwm
 SvZiPY70Kv8o1BIb/7e9ixS8yK4WIeM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-0NwMDJIDOHSUdTcre-X5oQ-1; Tue,
 28 Jul 2026 13:37:53 -0400
X-MC-Unique: 0NwMDJIDOHSUdTcre-X5oQ-1
X-Mimecast-MFC-AGG-ID: 0NwMDJIDOHSUdTcre-X5oQ_1785260272
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19DE319560B5; Tue, 28 Jul 2026 17:37:52 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.49.201])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BA18419560AB; Tue, 28 Jul 2026 17:37:50 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 04/17] tests/unit: add reproducer for BlockAcctStats histogram
 locking race
Date: Tue, 28 Jul 2026 19:37:26 +0200
Message-ID: <20260728173739.352078-5-kwolf@redhat.com>
In-Reply-To: <20260728173739.352078-1-kwolf@redhat.com>
References: <20260728173739.352078-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

block_latency_histogram_set() and block_latency_histograms_clear()
replace BlockLatencyHistogram's nbins/boundaries/bins without taking
stats->lock, while block_account_one_io() reads those same fields
under that lock from whatever iothread completes the I/O.

Add a test that races two real threads against
block_latency_histogram_set() and
block_acct_start()/block_acct_done() on the same BlockAcctStats.
Applied here it passes, since the previous two commits already take
the lock; reverting them locally reproduces the abort this series
fixes, in about a second.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Message-ID: <20260724111311.4086859-4-den@openvz.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/unit/test-block-accounting.c | 115 +++++++++++++++++++++++++++++
 tests/unit/meson.build             |   1 +
 2 files changed, 116 insertions(+)
 create mode 100644 tests/unit/test-block-accounting.c

diff --git a/tests/unit/test-block-accounting.c b/tests/unit/test-block-accounting.c
new file mode 100644
index 00000000000..7aae491cfc2
--- /dev/null
+++ b/tests/unit/test-block-accounting.c
@@ -0,0 +1,115 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * BlockAcctStats latency histogram locking regression test
+ *
+ * Copyright (c) 2026 Virtuozzo International GmbH.
+ *
+ * Regression test for missing stats->lock in
+ * block_latency_histogram_set()/block_latency_histograms_clear(),
+ * racing block_account_one_io() reading the same fields from an
+ * iothread. Aborts reliably before the fix, passes after it.
+ */
+
+#include "qemu/osdep.h"
+#include "block/block.h"
+#include "block/accounting.h"
+#include "system/block-backend.h"
+#include "system/block-backend-io.h"
+#include "qapi/error.h"
+#include "qemu/main-loop.h"
+#include "qemu/thread.h"
+
+#define RACE_DURATION_MS 2000
+#define NUM_READER_THREADS 8
+
+static bool stop_workers;
+
+/*
+ * Different bin counts, so the writer's g_free()/g_new() churn can be
+ * caught mid-update. Values are small enough (nanoseconds) that plain
+ * back-to-back start/done calls exercise every bin without sleeping.
+ */
+static uint64List boundaries_a[] = {
+    { .next = &boundaries_a[1], .value = 1000 },
+    { .next = &boundaries_a[2], .value = 5000 },
+    { .next = NULL,             .value = 50000 },
+};
+
+static uint64List boundaries_b[] = {
+    { .next = &boundaries_b[1], .value = 800 },
+    { .next = &boundaries_b[2], .value = 3000 },
+    { .next = &boundaries_b[3], .value = 20000 },
+    { .next = NULL,             .value = 200000 },
+};
+
+static void *writer_thread(void *opaque)
+{
+    BlockAcctStats *stats = opaque;
+
+    while (!qatomic_read(&stop_workers)) {
+        block_latency_histogram_set(stats, BLOCK_ACCT_READ, boundaries_a);
+        block_latency_histogram_set(stats, BLOCK_ACCT_READ, boundaries_b);
+        block_latency_histograms_clear(stats);
+    }
+
+    return NULL;
+}
+
+static void *reader_thread(void *opaque)
+{
+    BlockAcctStats *stats = opaque;
+
+    while (!qatomic_read(&stop_workers)) {
+        BlockAcctCookie cookie;
+
+        block_acct_start(stats, &cookie, 4096, BLOCK_ACCT_READ);
+        block_acct_done(stats, &cookie);
+    }
+
+    return NULL;
+}
+
+static void test_latency_histogram_race(void)
+{
+    BlockBackend *blk = blk_new(qemu_get_aio_context(),
+                                BLK_PERM_ALL, BLK_PERM_ALL);
+    BlockAcctStats *stats = blk_get_stats(blk);
+    QemuThread writer, readers[NUM_READER_THREADS];
+    int i;
+
+    /* Histogram has to be enabled (bins != NULL) before racing it. */
+    g_assert(block_latency_histogram_set(stats, BLOCK_ACCT_READ,
+                                         boundaries_a) == 0);
+
+    stop_workers = false;
+    qemu_thread_create(&writer, "hist-writer", writer_thread, stats,
+                       QEMU_THREAD_JOINABLE);
+    for (i = 0; i < NUM_READER_THREADS; i++) {
+        qemu_thread_create(&readers[i], "hist-reader", reader_thread, stats,
+                           QEMU_THREAD_JOINABLE);
+    }
+
+    g_usleep(RACE_DURATION_MS * 1000);
+    qatomic_set(&stop_workers, true);
+
+    qemu_thread_join(&writer);
+    for (i = 0; i < NUM_READER_THREADS; i++) {
+        qemu_thread_join(&readers[i]);
+    }
+
+    blk_unref(blk);
+}
+
+int main(int argc, char **argv)
+{
+    bdrv_init();
+    qemu_init_main_loop(&error_abort);
+
+    g_test_init(&argc, &argv, NULL);
+
+    g_test_add_func("/block-accounting/latency_histogram_race",
+                    test_latency_histogram_race);
+
+    return g_test_run();
+}
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 5ba6b1a2304..dc3fb954c03 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -75,6 +75,7 @@ if have_block
     'test-blockjob': [testblock],
     'test-blockjob-txn': [testblock],
     'test-block-backend': [testblock],
+    'test-block-accounting': [testblock],
     'test-block-iothread': [testblock],
     'test-write-threshold': [testblock],
     'test-crypto-hash': [crypto],
-- 
2.55.0


