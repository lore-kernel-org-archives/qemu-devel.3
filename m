Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDBEC02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 14:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcQ5P-0001Sc-4E; Mon, 27 Jan 2025 09:27:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcQ58-0000o3-1t; Mon, 27 Jan 2025 09:27:18 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcQ56-0003Pq-Ao; Mon, 27 Jan 2025 09:27:17 -0500
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by isrv.corpit.ru (Postfix) with ESMTP id F1AF4E0F98;
 Mon, 27 Jan 2025 17:26:46 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id BE6A851DB7; Mon, 27 Jan 2025 17:18:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.1 41/41] crypto: fix bogus error benchmarking pbkdf on
 fast machines
Date: Mon, 27 Jan 2025 17:17:55 +0300
Message-Id: <20250127141803.3514882-41-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.1-20250127154029@cover.tls.msk.ru>
References: <qemu-stable-9.2.1-20250127154029@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel P. Berrangé <berrange@redhat.com>

We're seeing periodic reports of errors like:

$ qemu-img create -f luks --object secret,data=123456,id=sec0 \
                  -o key-secret=sec0 luks-info.img 1M
  Formatting 'luks-info.img', fmt=luks size=1048576 key-secret=sec0
  qemu-img: luks-info.img: Unable to get accurate CPU usage

This error message comes from a recent attempt to workaround a
kernel bug with measuring rusage in long running processes:

  commit c72cab5ad9f849bbcfcf4be7952b8b8946cc626e
  Author: Tiago Pasqualini <tiago.pasqualini@canonical.com>
  Date:   Wed Sep 4 20:52:30 2024 -0300

    crypto: run qcrypto_pbkdf2_count_iters in a new thread

Unfortunately this has a subtle bug on machines which are very fast.

On the first time around the loop, the 'iterations' value is quite
small (1 << 15), and so will run quite fast. Testing has shown that
some machines can complete this benchmarking task in as little as
7 milliseconds.

Unfortunately the 'getrusage' data is not updated at the time of
the 'getrusage' call, it is done asynchronously by the scheduler.
The 7 millisecond completion time for the benchmark is short
enough that 'getrusage' sometimes reports 0 accumulated execution
time.

As a result the 'delay_ms == 0' sanity check in the above commit
is triggering non-deterministically on such machines.

The benchmarking loop intended to run multiple times, increasing
the 'iterations' value until the benchmark ran for > 500 ms, but
the sanity check doesn't allow this to happen.

To fix it, we keep a loop counter and only run the sanity check
after we've been around the loop more than 5 times. At that point
the 'iterations' value is high enough that even with infrequent
updates of 'getrusage' accounting data on fast machines, we should
see a non-zero value.

Fixes: https://lore.kernel.org/qemu-devel/ffe542bb-310c-4616-b0ca-13182f849fd1@redhat.com/
Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2336437
Reported-by: Thomas Huth <thuth@redhat.com>
Reported-by: Richard W.M. Jones <rjones@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250109093746.1216300-1-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 145f12ea885c8fcfbe2d0ac5230630f071b5a9fb)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/crypto/pbkdf.c b/crypto/pbkdf.c
index 0dd7c3aeaa..2989fc0a40 100644
--- a/crypto/pbkdf.c
+++ b/crypto/pbkdf.c
@@ -107,7 +107,7 @@ static void *threaded_qcrypto_pbkdf2_count_iters(void *data)
     size_t nsalt = iters_data->nsalt;
     size_t nout = iters_data->nout;
     Error **errp = iters_data->errp;
-
+    size_t scaled = 0;
     uint64_t ret = -1;
     g_autofree uint8_t *out = g_new(uint8_t, nout);
     uint64_t iterations = (1 << 15);
@@ -131,7 +131,17 @@ static void *threaded_qcrypto_pbkdf2_count_iters(void *data)
 
         delta_ms = end_ms - start_ms;
 
-        if (delta_ms == 0) { /* sanity check */
+        /*
+         * For very small 'iterations' values, CPU (or crypto
+         * accelerator) might be fast enough that the scheduler
+         * hasn't incremented getrusage() data, or incremented
+         * it by a very small amount, resulting in delta_ms == 0.
+         * Once we've scaled 'iterations' x10, 5 times, we really
+         * should be seeing delta_ms != 0, so sanity check at
+         * that point.
+         */
+        if (scaled > 5 &&
+            delta_ms == 0) { /* sanity check */
             error_setg(errp, "Unable to get accurate CPU usage");
             goto cleanup;
         } else if (delta_ms > 500) {
@@ -141,6 +151,7 @@ static void *threaded_qcrypto_pbkdf2_count_iters(void *data)
         } else {
             iterations = (iterations * 1000 / delta_ms);
         }
+        scaled++;
     }
 
     iterations = iterations * 1000 / delta_ms;
-- 
2.39.5


