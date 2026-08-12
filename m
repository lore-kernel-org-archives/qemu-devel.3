Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CAEC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8jo-0002aQ-L2; Wed, 12 Aug 2026 09:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8jY-0002OT-O9; Wed, 12 Aug 2026 09:11:09 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8jW-00068R-Tc; Wed, 12 Aug 2026 09:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539784; bh=7YWQdyTPQ71s8nEbOO1oYKMkrB3yb9Sb9g3i6Nq0BRg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=yLMF1W3T0Y4WOrAC+NmmGZ/1ZlxLxwn9FdWW7U6ympVrmQU1XO+1OoYztLjWBzy6O
 7GW1akl8nwqeygkc9Dj1THExeqRX+GKpgJjjdSF33tPcmLUrw8ijZuArThbrWjgQqG
 p/6HEYwQvrqomjsxqzoMWcHryIGIMN4jRmAu54zOYuEZb5OE1CMFxvp66sNMsmCGxk
 PMklOsC6BrkxcPlA+m6E3gR73he4X9l8Uip5Q7EszN0/79Paw8ZYiytSxskzOuB0os
 Xo9xrdnsUpEHNmws78AEwjH/OCs9C3FqiMqhNYeuRSCPXrfxdWVTYvhLbTuL5/QUoW
 P/6loP2f1oOjA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 869031CA4D0;
 Wed, 12 Aug 2026 16:03:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id BD183409BB3;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A36452F936; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 081/102] tests/unit: add reproducer for
 BlockAcctStats histogram locking race
Date: Wed, 12 Aug 2026 16:01:56 +0300
Message-ID: <20260812130233.621965-81-mjt@tls.msk.ru>
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
(cherry picked from commit 842c89281a20c3ea783609c5ac9da226e017e490)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 1a85f85d182..336f492cf4f 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -74,6 +74,7 @@ if have_block
     'test-blockjob': [testblock],
     'test-blockjob-txn': [testblock],
     'test-block-backend': [testblock],
+    'test-block-accounting': [testblock],
     'test-block-iothread': [testblock],
     'test-write-threshold': [testblock],
     'test-crypto-hash': [crypto],
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
-- 
2.47.3


