Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE05BC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 10:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taBw9-0006hU-9I; Tue, 21 Jan 2025 05:56:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1taBvs-0006eM-5k
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:56:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1taBvo-000567-2a
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:56:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737456987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XxRDZtd5Utt5iRwmjAyBTVlmUz2KjyWXBIEy7zrcS7g=;
 b=hTwF0T+8EhmomTi5M+IO0GWEIZeLg68+PsJ/SPfotplV/lL8U/BGo8esTxfHn3z+293ZfZ
 P6K043wdNmc4S9UQj3q32Y9Iy8z2UYQbcN6q5yfXkpIARrfdpP5p6pFtaIxa2Q55HiHJFh
 B38qgsTQIbAEd0nWojPIY3KA4eFrufk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-wa6ChJUMNHuyVtQLXbHX1Q-1; Tue,
 21 Jan 2025 05:56:25 -0500
X-MC-Unique: wa6ChJUMNHuyVtQLXbHX1Q-1
X-Mimecast-MFC-AGG-ID: wa6ChJUMNHuyVtQLXbHX1Q
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E81231956055
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 10:56:24 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.56])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E535219560A7; Tue, 21 Jan 2025 10:56:22 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Richard W.M. Jones" <rjones@redhat.com>
Subject: [PULL 3/9] crypto: fix bogus error benchmarking pbkdf on fast machines
Date: Tue, 21 Jan 2025 11:56:05 +0100
Message-ID: <20250121105613.1286672-4-thuth@redhat.com>
In-Reply-To: <20250121105613.1286672-1-thuth@redhat.com>
References: <20250121105613.1286672-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 crypto/pbkdf.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

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
2.48.1


