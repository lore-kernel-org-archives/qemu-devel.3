Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F400CED277
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 07:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy56T-0008DF-Hf; Tue, 08 Oct 2024 03:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sy56R-0008D4-H9
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 03:57:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sy56P-0005dL-SZ
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 03:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728374273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y3lra9Fp7eddZvXBVCbjv4rYpExX1Of03druZPncO4o=;
 b=G4tOhIv+NrJsGhlVBMMhBsXM6HMenVbVIDk0dbUweYozsepFUGhr1Jo0hcWLh1artxXeA8
 RX/Co/HKa/6falAQXpbLlEMcmh4e8dnbnUnooMbXLtWKWWTE8A4nfHTn6gjJ7tXspCq+9l
 x7FgyYhkiDtn5LHkG0yluSnpkbSJHKY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-uXeb9jAOMm6ePYSujw1wAA-1; Tue,
 08 Oct 2024 03:57:49 -0400
X-MC-Unique: uXeb9jAOMm6ePYSujw1wAA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 710FA19560B4; Tue,  8 Oct 2024 07:57:48 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.61])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 23404300019E; Tue,  8 Oct 2024 07:57:45 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	berrange@redhat.com
Cc: kris.conklin@seagate.com, jonathan.henze@seagate.com,
 evan.burgess@seagate.com, peter.maydell@linaro.org,
 Alejandro Zeise <alejandro.zeise@seagate.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v5 07/16] crypto/hash-afalg: Implement new hash API
Date: Tue,  8 Oct 2024 09:57:14 +0200
Message-ID: <20241008075724.2772149-8-clg@redhat.com>
In-Reply-To: <20241008075724.2772149-1-clg@redhat.com>
References: <20241008075724.2772149-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
---
 crypto/hash-afalg.c | 127 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/crypto/hash-afalg.c b/crypto/hash-afalg.c
index 28ab899b18f6..5fbbee288e9b 100644
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
2.46.2


