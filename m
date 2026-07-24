Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73193C531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 11:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnDqG-0001Vx-FJ; Fri, 24 Jul 2026 07:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wnDqE-0001UV-4A
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 07:13:22 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wnDqC-0001m2-A4
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 07:13:21 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-47f64ca1c2dso136228f8f.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 04:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1784891599; x=1785496399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k8OM4Z+eBoFlDD0mCdq/zvHBMpMffPjuoO6NeF18+/M=;
 b=hj5UUFnX5/ykPF1fmrcOoIOqkEg3fkB0KJu1gxxPfSbgySiUyO2WVymhg3Lwz3RVHn
 gl182zAyiAhgkYH+qf2TDuIm5Dv+fPJc6YfVp19CWtnbYfymttv2Lw5U9h1Q6Y5q+N6B
 LT2K/thwX0XHyNJvM1ei4M6CwHOBD4C0uPgfx2I2C709OsmHhsbNOMIZZYDMJeBIyQzA
 CfzG4vUn6WQBdNK4bAtlm4X12JRffdkYv0u0uta8ZqoQAC8o1QxuwysVQr5driiYJ2xm
 /oKGQk8BsaVRB/7El1PdJR9cZ1qLUZpRp+1KzLWOjVcXHmlI7k/+ASDrWozIHxRwuq7M
 FAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784891599; x=1785496399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=k8OM4Z+eBoFlDD0mCdq/zvHBMpMffPjuoO6NeF18+/M=;
 b=WZasa2Oi0aLD5mRH6zwRG1xG1/OwuM9Z7HIpV6HdpF+2aQUpfGB8xoG3lYhpS4Yum9
 vwLEypsiK2kClld2cmX+Kxxo4kwenGlF1f0DLVXugSrc2lpbUwx9e4BsFyPhxni29Dtp
 IoazL7nN3XcAdKGg2eb2hbP9J6uVU5zmKRxrZn/DoMkDEdHH0GDgUknjeg3uopKInVme
 /bHfS6GDBVVRiGAOgXvyOdX/Y5BeDod9DLDNJjC7c5NV4Q/0Ex8S2Iy09vU0dZ586bfl
 xgcsNShn0iUvWvi9u+duxbCqH6dpEQd5nk3KxN8qQJ9FKALltv5ORvMANHf/JHOkML/m
 Uisw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpJy4DYuorZU/3OKNPIv/ifLlD8huqD6qjC5FhRC7qQQw7hIQ1gBoMpF3a1R/s4FR5kS6yrNj1oFkku@nongnu.org
X-Gm-Message-State: AOJu0Yy+YPi/pNCHsG9ddoPU6QfRlg4aQVQ2izy7dMDjI3OaGIzqJIB0
 uwFJV4bMrKnsLaIUFAdoJVwQkIFxkvDE9LXOZLZe+bA3AzME8gRF6WFsQ9vqGfd6lMs=
X-Gm-Gg: AR+sD11ykdXb154tNJdCVnpUiocinopr3WtExQH44U9DqjjIK0k7Z9xDEqw5redPUA7
 DHhzKYGLMFfQkJXLWpKTHugv7f/7UFrkpx8pBsOebO0pSFthHreOQdioxuGLst43YUX97sfYU5m
 CEHWMKqU01SZWFgHLO+1FCCPQPKoqHLIZRWEo24YKZtdteByLZ8ourclftptFH2G0/YqRSdGV5K
 fO1vHwFP67/T5K4QzAOQ7STL0hJ3t3seUc8CrytRssa3P5chdDIsFIbIlp+ndHRPuLYjn/xE03X
 sNE5RE/urVewfHyYpPTDN3BisyDxq7hZ0gUNo+PSLWWa12z5FMYMtme7G+ieidcftlx2mBkH6IS
 kSl42sIkmNwzS3QL9oiEiQD/XEypNI0P0ZcVHAM2T5U6f2X4tHvMkUNhx0gUs/+I62gSFVENoni
 4=
X-Received: by 2002:a05:6000:2506:b0:47f:95ce:6f48 with SMTP id
 ffacd0b85a97d-47f95ce6f84mr3768506f8f.11.1784891598629; 
 Fri, 24 Jul 2026 04:13:18 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:4f7d:7b60:9d07:3a1b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c531basm23792473f8f.19.2026.07.24.04.13.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 04:13:18 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v2 3/3] tests/unit: add reproducer for BlockAcctStats
 histogram locking race
Date: Fri, 24 Jul 2026 13:13:11 +0200
Message-ID: <20260724111311.4086859-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724111311.4086859-1-den@openvz.org>
References: <20260724111311.4086859-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=den@openvz.org; helo=mail-wr1-x431.google.com
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
---
 tests/unit/meson.build             |   1 +
 tests/unit/test-block-accounting.c | 115 +++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)
 create mode 100644 tests/unit/test-block-accounting.c

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 5ba6b1a230..dc3fb954c0 100644
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
diff --git a/tests/unit/test-block-accounting.c b/tests/unit/test-block-accounting.c
new file mode 100644
index 0000000000..7aae491cfc
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
2.53.0


