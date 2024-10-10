Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EE0CFC5E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 16:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syvve-0006y2-6R; Thu, 10 Oct 2024 12:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1syvvc-0006wz-71
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 12:22:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1syvvZ-0004QM-Vu
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 12:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728577333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XCLt6K70QI6XZ5GYqlrLy86nLHuHSEEZZ9EYnzlkffs=;
 b=I0xsM1MuhG4uNasTG+/C6YgaCoblNF8wELfe04eg0UjxYEiJwC+Aq4O+XkWS1158TZ/aWL
 ghafjxzVXr+yGdSrdSc88Kx7gY+Lv0tiqHg5QhyPUcafmv/Qm4+tlZhNvfaULPe3tXWcMc
 R2/Pbv/t9/X6F8GTnbZbWminhST7mys=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-vlagQ8dzO_6aKUZJQwrdqw-1; Thu,
 10 Oct 2024 12:22:10 -0400
X-MC-Unique: vlagQ8dzO_6aKUZJQwrdqw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33DAE1956096; Thu, 10 Oct 2024 16:22:09 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.110])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 237E530001A6; Thu, 10 Oct 2024 16:22:06 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kunwu <chentao@kylinos.cn>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alejandro Zeise <alejandro.zeise@seagate.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 07/17] crypto/hash-afalg: Implement new hash API
Date: Thu, 10 Oct 2024 17:20:14 +0100
Message-ID: <20241010162024.988284-8-berrange@redhat.com>
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

Updates the afalg hash driver to support the new accumulative
hashing changes as part of the patch series.

Implements opening/closing of contexts, updating hash data
and finalizing the hash digest.

In order to support the update function, a flag needs to be passed
to the kernel via the socket send call (MSG_MORE) to notify it that more
data is to be expected to calculate the hash correctly.
As a result, a new function was added to the iov helper utils to allow
passing a flag to the socket send call.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
[ clg: - Handled qcrypto_afalg_hash_ctx_new() errors in
         qcrypto_afalg_hash_new()
       - Freed alg_name in qcrypto_afalg_hash_new()
       - Reworked qcrypto_afalg_recv_from_kernel()
       - Split iov changes from original patch ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/hash-afalg.c | 127 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/crypto/hash-afalg.c b/crypto/hash-afalg.c
index 28ab899b18..5fbbee288e 100644
--- a/crypto/hash-afalg.c
+++ b/crypto/hash-afalg.c
@@ -1,6 +1,7 @@
 /*
  * QEMU Crypto af_alg-backend hash/hmac support
  *
+ * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
  * Copyright (c) 2017 HUAWEI TECHNOLOGIES CO., LTD.
  *
  * Authors:
@@ -113,6 +114,128 @@ qcrypto_afalg_hmac_ctx_new(QCryptoHashAlgo alg,
     return qcrypto_afalg_hash_hmac_ctx_new(alg, key, nkey, true, errp);
 }
 
+static
+QCryptoHash *qcrypto_afalg_hash_new(QCryptoHashAlgo alg, Error **errp)
+{
+    /* Check if hash algorithm is supported */
+    char *alg_name = qcrypto_afalg_hash_format_name(alg, false, NULL);
+    QCryptoHash *hash;
+
+    if (alg_name == NULL) {
+        error_setg(errp, "Unknown hash algorithm %d", alg);
+        return NULL;
+    }
+
+    g_free(alg_name);
+
+    hash = g_new(QCryptoHash, 1);
+    hash->alg = alg;
+    hash->opaque = qcrypto_afalg_hash_ctx_new(alg, errp);
+    if (!hash->opaque) {
+        free(hash);
+        return NULL;
+    }
+
+    return hash;
+}
+
+static
+void qcrypto_afalg_hash_free(QCryptoHash *hash)
+{
+    QCryptoAFAlg *ctx = hash->opaque;
+
+    if (ctx) {
+        qcrypto_afalg_comm_free(ctx);
+    }
+
+    g_free(hash);
+}
+
+/**
+ * Send data to the kernel's crypto core.
+ *
+ * The more_data parameter is used to notify the crypto engine
+ * that this is an "update" operation, and that more data will
+ * be provided to calculate the final hash.
+ */
+static
+int qcrypto_afalg_send_to_kernel(QCryptoAFAlg *afalg,
+                                 const struct iovec *iov,
+                                 size_t niov,
+                                 bool more_data,
+                                 Error **errp)
+{
+    int ret = 0;
+    int flags = (more_data ? MSG_MORE : 0);
+
+    /* send data to kernel's crypto core */
+    ret = iov_send_recv_with_flags(afalg->opfd, flags, iov, niov,
+                                   0, iov_size(iov, niov), true);
+    if (ret < 0) {
+        error_setg_errno(errp, errno, "Send data to afalg-core failed");
+        ret = -1;
+    } else {
+        /* No error, so return 0 */
+        ret = 0;
+    }
+
+    return ret;
+}
+
+static
+int qcrypto_afalg_recv_from_kernel(QCryptoAFAlg *afalg,
+                                   QCryptoHashAlgo alg,
+                                   uint8_t **result,
+                                   size_t *result_len,
+                                   Error **errp)
+{
+    struct iovec outv;
+    int ret;
+    const int expected_len = qcrypto_hash_digest_len(alg);
+
+    if (*result_len == 0) {
+        *result_len = expected_len;
+        *result = g_new0(uint8_t, *result_len);
+    } else if (*result_len != expected_len) {
+        error_setg(errp,
+                   "Result buffer size %zu is not match hash %d",
+                   *result_len, expected_len);
+        return -1;
+    }
+
+    /* hash && get result */
+    outv.iov_base = *result;
+    outv.iov_len = *result_len;
+    ret = iov_send_recv(afalg->opfd, &outv, 1,
+                        0, iov_size(&outv, 1), false);
+    if (ret < 0) {
+        error_setg_errno(errp, errno, "Recv result from afalg-core failed");
+        return -1;
+    }
+
+    return 0;
+}
+
+static
+int qcrypto_afalg_hash_update(QCryptoHash *hash,
+                              const struct iovec *iov,
+                              size_t niov,
+                              Error **errp)
+{
+    return qcrypto_afalg_send_to_kernel((QCryptoAFAlg *) hash->opaque,
+                                        iov, niov, true, errp);
+}
+
+static
+int qcrypto_afalg_hash_finalize(QCryptoHash *hash,
+                                 uint8_t **result,
+                                 size_t *result_len,
+                                 Error **errp)
+{
+    return qcrypto_afalg_recv_from_kernel((QCryptoAFAlg *) hash->opaque,
+                                          hash->alg, result, result_len, errp);
+}
+
 static int
 qcrypto_afalg_hash_hmac_bytesv(QCryptoAFAlgo *hmac,
                                QCryptoHashAlgo alg,
@@ -205,6 +328,10 @@ static void qcrypto_afalg_hmac_ctx_free(QCryptoHmac *hmac)
 
 QCryptoHashDriver qcrypto_hash_afalg_driver = {
     .hash_bytesv = qcrypto_afalg_hash_bytesv,
+    .hash_new      = qcrypto_afalg_hash_new,
+    .hash_free     = qcrypto_afalg_hash_free,
+    .hash_update   = qcrypto_afalg_hash_update,
+    .hash_finalize = qcrypto_afalg_hash_finalize
 };
 
 QCryptoHmacDriver qcrypto_hmac_afalg_driver = {
-- 
2.46.0


