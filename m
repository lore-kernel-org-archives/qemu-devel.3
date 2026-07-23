Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9818CC531CA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 12:38:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmsh5-0008Kz-2y; Thu, 23 Jul 2026 08:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wmsgV-00089s-2G
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 08:37:55 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wmsgT-0008UA-Bl
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 08:37:54 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c16794450aeso75851966b.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 05:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1784810272; x=1785415072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lT3tAlUEOnvLakbkG7MR8bQ/jFeMpZ3j8U3lSAg3aFk=;
 b=X6Cehg7FgDADXRedksRc2ZCdsT6b5PYR1TswqUjOJKE98xu1h1IJhMkCP/NpjP8JaI
 mhGkRMM/U5bUpzIx0TNPMK7FQy5d43CILpFGID9jitueXE0UX2KqRC+WXZwbngbKqBu9
 3rNmUsVzcIsheXX8db1Zw4EVNS9JdZYF2VdMiQBy/5zy05ZW8q+9SE1gywbzzrHUqwtL
 ei0S6iqrNDx1qZnBchLnFJjPHibIuSJIphE1cSFWa2U63yiHZLzAB+kIh2he/FQfd4Ns
 6Kg2fWijq7thLW0JwUVvd+B0MDqyK+9GbQEXcNa44mH0wovrbp6yqTeyvkvxEwnLU6yZ
 mepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784810272; x=1785415072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lT3tAlUEOnvLakbkG7MR8bQ/jFeMpZ3j8U3lSAg3aFk=;
 b=r7r7dQu9S1ig4S5MiS8l1pQmUYhTPEK42C0Uu71+u3EROmnE/ceb5CfWdWFO7ZWlBz
 RiUKTeQ7U+kotSku5Nnyr9ecBroGvIA3J2nzZ2+IAHiBSRpk2Hg8dQOYcAFySyasC7yM
 f5uB1VFsGtc50uC6ive1qQ9Hj2I+vSVBhsH47YYAHQ/1cK/NlnzrlyhWGeaNeg+hojOf
 oGhgK4uYMCk4I3NKOV/C8JUjbiXAiBxGvbt19lKfdWKIdcRcaoDUAZcmirl2jyKbwWx0
 0rIp96BuJc6AWQlfRdvHnpRShrNaW1sX0hrVEzc7ON1JHa9+D7zzOYW0d7/r5/jO3IVP
 uLHw==
X-Forwarded-Encrypted: i=1;
 AHgh+RquN4ZO30ni74XYagxCMEc+J/4n/QE2TWGvhV8UIuLtkv+HfoC8Th0yotvPB0fPsOORAskXW4uS9/xC@nongnu.org
X-Gm-Message-State: AOJu0YxOoK5loNvcfA91pDfljKMJ3k8uNUVQbtLRZ776JA3BMRS0FeIj
 h/TjYP+7/E7fvzGptmcsdhmkINS2Dv8LOapSFN6A0ex5VDTijCzVWpJl62d94EPDUFM=
X-Gm-Gg: AR+sD12r5JsBToQBk13QTb4/ORAALyWRUyGnb1xy45JzLBN5LvEhJCfxemMWROScxBU
 8qI6+LgYIgpBdMm52UsZHRd9WfYxX1dVVlgMzk3X4XQFU7cmVxNHugKW+BU4OFCS4RSyivFzEFn
 FwF8JcdiZg4EUuSkjaHBfcXMalpfI4LBQnrBH0+hfwsqojdXIFSVKiCeRv0bLdsJPffoq2alwZY
 xhjVITBpwRKQn2+6J7vNVt5Q2Tp3ZX2k+2IXfpceJFMER8DCGw9I2Zy7wKV/bWSPoeDgnZ3BPVs
 akNclniOI43eJKAjFnGxs3cbspvdT33DxxWtf02/7eN3p72ba+WdRNYvA1aw7ele4Mu2jHcN2w0
 MT4pPrbXCZgZKbj9zDJOgjrd0s3rj+mLg41jUNPHUGXQv/l5g33CRixRrc5BnFbPyLvgg4u+EiR
 U=
X-Received: by 2002:a17:907:e006:20b0:c12:b2db:873d with SMTP id
 a640c23a62f3a-c1c50b41459mr89495466b.5.1784810271790; 
 Thu, 23 Jul 2026 05:37:51 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:b8fe:da40:80d9:ac01])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32c90b58sm222619166b.39.2026.07.23.05.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 05:37:51 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 3/3] tests/unit: add reproducer for BlockAcctStats histogram
 locking race
Date: Thu, 23 Jul 2026 14:37:45 +0200
Message-ID: <20260723123745.3294227-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723123745.3294227-1-den@openvz.org>
References: <20260723123745.3294227-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=den@openvz.org; helo=mail-ej1-x635.google.com
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
---
 tests/unit/meson.build             |   1 +
 tests/unit/test-block-accounting.c | 114 +++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+)
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
index 0000000000..e749b73749
--- /dev/null
+++ b/tests/unit/test-block-accounting.c
@@ -0,0 +1,114 @@
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


