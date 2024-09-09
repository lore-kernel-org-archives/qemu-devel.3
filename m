Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C95FECE57A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 14:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snfCU-0007u2-Bw; Mon, 09 Sep 2024 10:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1snfCT-0007s2-KW
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1snfCR-0003Ix-Ps
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725891423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fPO4I0oxWW77zveyLGOcTMiBWgRiSGpWO8LL8G9uTno=;
 b=iPrLjLFYMIo8Ra5zA7EvKfmzf//GDZPQ/lWCKr39Sw+l8tAdaF0R0QXLjehaAGfdavrlYn
 PzgrHLdkIoM/G7Z8Jltr4iqG0a0W35aShEJTCKOiwxH4Oq8iMncvPyR6SIZJH3uEJLpJFx
 S8HBTxj2vvP5cGZts0nW9qMvNS1P5Ww=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-ilg3g7raMgmWJL1ADe6MUw-1; Mon,
 09 Sep 2024 10:16:59 -0400
X-MC-Unique: ilg3g7raMgmWJL1ADe6MUw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C4A01953965; Mon,  9 Sep 2024 14:16:57 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.212])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 86A4C1955F45; Mon,  9 Sep 2024 14:16:52 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hyman Huang <yong.huang@smartx.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Tiago Pasqualini <tiago.pasqualini@canonical.com>
Subject: [PULL 02/10] crypto: run qcrypto_pbkdf2_count_iters in a new thread
Date: Mon,  9 Sep 2024 15:16:27 +0100
Message-ID: <20240909141635.1459701-3-berrange@redhat.com>
In-Reply-To: <20240909141635.1459701-1-berrange@redhat.com>
References: <20240909141635.1459701-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Tiago Pasqualini <tiago.pasqualini@canonical.com>

CPU time accounting in the kernel has been demonstrated to have a
sawtooth pattern[1][2]. This can cause the getrusage system call to
not be as accurate as we are expecting, which can cause this calculation
to stall.

The kernel discussions shows that this inaccuracy happens when CPU time
gets big enough, so this patch changes qcrypto_pbkdf2_count_iters to run
in a fresh thread to avoid this inaccuracy. It also adds a sanity check
to fail the process if CPU time is not accounted.

[1] https://lore.kernel.org/lkml/159231011694.16989.16351419333851309713.tip-bot2@tip-bot2/
[2] https://lore.kernel.org/lkml/20221226031010.4079885-1-maxing.lan@bytedance.com/t/#m1c7f2fdc0ea742776a70fd1aa2a2e414c437f534

Resolves: #2398
Signed-off-by: Tiago Pasqualini <tiago.pasqualini@canonical.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/pbkdf.c | 53 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 7 deletions(-)

diff --git a/crypto/pbkdf.c b/crypto/pbkdf.c
index 8d198c152c..d1c06ef3ed 100644
--- a/crypto/pbkdf.c
+++ b/crypto/pbkdf.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/thread.h"
 #include "qapi/error.h"
 #include "crypto/pbkdf.h"
 #ifndef _WIN32
@@ -85,12 +86,28 @@ static int qcrypto_pbkdf2_get_thread_cpu(unsigned long long *val_ms,
 #endif
 }
 
-uint64_t qcrypto_pbkdf2_count_iters(QCryptoHashAlgorithm hash,
-                                    const uint8_t *key, size_t nkey,
-                                    const uint8_t *salt, size_t nsalt,
-                                    size_t nout,
-                                    Error **errp)
+typedef struct CountItersData {
+    QCryptoHashAlgorithm hash;
+    const uint8_t *key;
+    size_t nkey;
+    const uint8_t *salt;
+    size_t nsalt;
+    size_t nout;
+    uint64_t iterations;
+    Error **errp;
+} CountItersData;
+
+static void *threaded_qcrypto_pbkdf2_count_iters(void *data)
 {
+    CountItersData *iters_data = (CountItersData *) data;
+    QCryptoHashAlgorithm hash = iters_data->hash;
+    const uint8_t *key = iters_data->key;
+    size_t nkey = iters_data->nkey;
+    const uint8_t *salt = iters_data->salt;
+    size_t nsalt = iters_data->nsalt;
+    size_t nout = iters_data->nout;
+    Error **errp = iters_data->errp;
+
     uint64_t ret = -1;
     g_autofree uint8_t *out = g_new(uint8_t, nout);
     uint64_t iterations = (1 << 15);
@@ -114,7 +131,10 @@ uint64_t qcrypto_pbkdf2_count_iters(QCryptoHashAlgorithm hash,
 
         delta_ms = end_ms - start_ms;
 
-        if (delta_ms > 500) {
+        if (delta_ms == 0) { /* sanity check */
+            error_setg(errp, "Unable to get accurate CPU usage");
+            goto cleanup;
+        } else if (delta_ms > 500) {
             break;
         } else if (delta_ms < 100) {
             iterations = iterations * 10;
@@ -129,5 +149,24 @@ uint64_t qcrypto_pbkdf2_count_iters(QCryptoHashAlgorithm hash,
 
  cleanup:
     memset(out, 0, nout);
-    return ret;
+    iters_data->iterations = ret;
+    return NULL;
+}
+
+uint64_t qcrypto_pbkdf2_count_iters(QCryptoHashAlgorithm hash,
+                                    const uint8_t *key, size_t nkey,
+                                    const uint8_t *salt, size_t nsalt,
+                                    size_t nout,
+                                    Error **errp)
+{
+    CountItersData data = {
+        hash, key, nkey, salt, nsalt, nout, 0, errp
+    };
+    QemuThread thread;
+
+    qemu_thread_create(&thread, "pbkdf2", threaded_qcrypto_pbkdf2_count_iters,
+                       &data, QEMU_THREAD_JOINABLE);
+    qemu_thread_join(&thread);
+
+    return data.iterations;
 }
-- 
2.45.2


