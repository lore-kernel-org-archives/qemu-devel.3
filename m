Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80030CFC5E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 16:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syvvi-00072a-G3; Thu, 10 Oct 2024 12:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1syvvg-00071T-Cx
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 12:22:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1syvve-0004Qx-PX
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 12:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728577338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6VE2N7b3gnGCDPqBULYRlMyPOe+yJdysz1T9lis10fY=;
 b=d4cGfJXpa1fp4XUljrvZtJ6MjCYc4MDU2UgV0fFJctPYguhYqXIOVYWsB2eGcVJukjAL43
 c5epqJ5EXNSTo++DC45f6+oP0XVEHhzbycAERZY38/UAgpyTT+tzucJT7hFNn52psUsq8O
 9ZTYAJnOsm9/yNk6LaEnEAvzOWUDhjo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-Xk0LsqpYNbi9qRNdTJUJgg-1; Thu,
 10 Oct 2024 12:22:14 -0400
X-MC-Unique: Xk0LsqpYNbi9qRNdTJUJgg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5E2C1955BCF; Thu, 10 Oct 2024 16:22:13 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.110])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CD32D30001A2; Thu, 10 Oct 2024 16:22:11 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kunwu <chentao@kylinos.cn>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alejandro Zeise <alejandro.zeise@seagate.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 09/17] tests/unit/test-crypto-hash: accumulative hashing
Date: Thu, 10 Oct 2024 17:20:16 +0100
Message-ID: <20241010162024.988284-10-berrange@redhat.com>
In-Reply-To: <20241010162024.988284-1-berrange@redhat.com>
References: <20241010162024.988284-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Alejandro Zeise <alejandro.zeise@seagate.com>

Added an accumulative hashing test. Checks for functionality of
the new hash create, update, finalize and free functions.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
[ clg: - Improved test_hash_accumulate() with g_autofree variables ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/unit/test-crypto-hash.c | 46 +++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tests/unit/test-crypto-hash.c b/tests/unit/test-crypto-hash.c
index 124d204485..e5829ca766 100644
--- a/tests/unit/test-crypto-hash.c
+++ b/tests/unit/test-crypto-hash.c
@@ -1,6 +1,7 @@
 /*
  * QEMU Crypto hash algorithms
  *
+ * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
  * Copyright (c) 2015 Red Hat, Inc.
  *
  * This library is free software; you can redistribute it and/or
@@ -241,6 +242,50 @@ static void test_hash_base64(void)
     }
 }
 
+static void test_hash_accumulate(void)
+{
+    size_t i;
+
+    for (i = 0; i < G_N_ELEMENTS(expected_outputs) ; i++) {
+        g_autoptr(QCryptoHash) hash = NULL;
+        struct iovec iov[] = {
+            { .iov_base = (char *)INPUT_TEXT1, .iov_len = strlen(INPUT_TEXT1) },
+            { .iov_base = (char *)INPUT_TEXT2, .iov_len = strlen(INPUT_TEXT2) },
+            { .iov_base = (char *)INPUT_TEXT3, .iov_len = strlen(INPUT_TEXT3) },
+        };
+        g_autofree uint8_t *result = NULL;
+        size_t resultlen = 0;
+        int ret;
+        size_t j;
+
+        if (!qcrypto_hash_supports(i)) {
+            continue;
+        }
+
+        hash = qcrypto_hash_new(i, &error_fatal);
+        g_assert(hash != NULL);
+
+        /* Add each iovec to the hash context separately */
+        for (j = 0; j < G_N_ELEMENTS(iov); j++) {
+            ret = qcrypto_hash_updatev(hash,
+                                      &iov[j], 1,
+                                      &error_fatal);
+
+            g_assert(ret == 0);
+        }
+
+        ret = qcrypto_hash_finalize_bytes(hash, &result, &resultlen,
+                                          &error_fatal);
+
+        g_assert(ret == 0);
+        g_assert(resultlen == expected_lens[i]);
+        for (j = 0; j < resultlen; j++) {
+            g_assert(expected_outputs[i][j * 2] == hex[(result[j] >> 4) & 0xf]);
+            g_assert(expected_outputs[i][j * 2 + 1] == hex[result[j] & 0xf]);
+        }
+    }
+}
+
 int main(int argc, char **argv)
 {
     int ret = qcrypto_init(&error_fatal);
@@ -252,5 +297,6 @@ int main(int argc, char **argv)
     g_test_add_func("/crypto/hash/prealloc", test_hash_prealloc);
     g_test_add_func("/crypto/hash/digest", test_hash_digest);
     g_test_add_func("/crypto/hash/base64", test_hash_base64);
+    g_test_add_func("/crypto/hash/accumulate", test_hash_accumulate);
     return g_test_run();
 }
-- 
2.46.0


