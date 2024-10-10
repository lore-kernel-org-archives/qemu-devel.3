Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FA7CFC5E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 16:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syvvg-00071L-Ai; Thu, 10 Oct 2024 12:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1syvve-0006y4-DD
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 12:22:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1syvvc-0004Qg-C2
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 12:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728577335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T1r7GMIhVKgSZMZfmMxHoAmL/6vMk4PksaNooyNGPyY=;
 b=M1zCGt4VpzYdkh6ltmX6M0pKwT17ECNaxVe28ImunIyOtkjKgKfeXDgWFRX40gilY85G0A
 XrFCv46e5isAcrdi0051d7LbShuUd4bJiZhrKLQgea8C6PjxtaI1k61kFDJLwYnhglfTdw
 xFvlmdx4g0auCSg8Mx64+pmx2U59z5k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-sRwN5x_ROnOsZO8pbJfQ9A-1; Thu,
 10 Oct 2024 12:22:12 -0400
X-MC-Unique: sRwN5x_ROnOsZO8pbJfQ9A-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58DFD1955F29; Thu, 10 Oct 2024 16:22:11 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.110])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 927ED30001A0; Thu, 10 Oct 2024 16:22:09 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kunwu <chentao@kylinos.cn>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alejandro Zeise <alejandro.zeise@seagate.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 08/17] crypto/hash: Implement and use new hash API
Date: Thu, 10 Oct 2024 17:20:15 +0100
Message-ID: <20241010162024.988284-9-berrange@redhat.com>
In-Reply-To: <20241010162024.988284-1-berrange@redhat.com>
References: <20241010162024.988284-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

Changes the public hash API implementation to support accumulative hashing.

Implementations for the public functions are added to call the new
driver functions that implement context creation, updating,
finalization, and destruction.

Additionally changes the "shortcut" functions to use these 4 new core
functions.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
[ clg: - Reworked qcrypto_hash_bytesv() error handling
       - Used hash->driver int qcrypto_hash_new(), qcrypto_hash_free()
         qcrypto_hash_updatev()
       - Introduced qcrypto_hash_supports() check in
         qcrypto_hash_new()
       - Introduced g_autofree variables in qcrypto_hash_finalize_digest()
         and qcrypto_hash_finalize_base64()
       - Re-arrranged code in qcrypto_hash_digestv() and
         qcrypto_hash_digest()
       - Checkpatch fixes ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/hash.c | 161 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 131 insertions(+), 30 deletions(-)

diff --git a/crypto/hash.c b/crypto/hash.c
index 4a265582b8..0c8548c568 100644
--- a/crypto/hash.c
+++ b/crypto/hash.c
@@ -1,6 +1,7 @@
 /*
  * QEMU Crypto hash algorithms
  *
+ * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
  * Copyright (c) 2015 Red Hat, Inc.
  *
  * This library is free software; you can redistribute it and/or
@@ -19,6 +20,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi-types-crypto.h"
 #include "crypto/hash.h"
 #include "hashpriv.h"
 
@@ -45,23 +48,18 @@ int qcrypto_hash_bytesv(QCryptoHashAlgo alg,
                         size_t *resultlen,
                         Error **errp)
 {
-#ifdef CONFIG_AF_ALG
-    int ret;
-    /*
-     * TODO:
-     * Maybe we should treat some afalg errors as fatal
-     */
-    ret = qcrypto_hash_afalg_driver.hash_bytesv(alg, iov, niov,
-                                                result, resultlen,
-                                                NULL);
-    if (ret == 0) {
-        return ret;
+    g_autoptr(QCryptoHash) ctx = qcrypto_hash_new(alg, errp);
+
+    if (!ctx) {
+        return -1;
+    }
+
+    if (qcrypto_hash_updatev(ctx, iov, niov, errp) < 0 ||
+        qcrypto_hash_finalize_bytes(ctx, result, resultlen, errp) < 0) {
+        return -1;
     }
-#endif
 
-    return qcrypto_hash_lib_driver.hash_bytesv(alg, iov, niov,
-                                               result, resultlen,
-                                               errp);
+    return 0;
 }
 
 
@@ -77,29 +75,130 @@ int qcrypto_hash_bytes(QCryptoHashAlgo alg,
     return qcrypto_hash_bytesv(alg, &iov, 1, result, resultlen, errp);
 }
 
+int qcrypto_hash_updatev(QCryptoHash *hash,
+                         const struct iovec *iov,
+                         size_t niov,
+                         Error **errp)
+{
+    QCryptoHashDriver *drv = hash->driver;
+
+    return drv->hash_update(hash, iov, niov, errp);
+}
+
+int qcrypto_hash_update(QCryptoHash *hash,
+                        const char *buf,
+                        size_t len,
+                        Error **errp)
+{
+    struct iovec iov = { .iov_base = (char *)buf, .iov_len = len };
+
+    return qcrypto_hash_updatev(hash, &iov, 1, errp);
+}
+
+QCryptoHash *qcrypto_hash_new(QCryptoHashAlgo alg, Error **errp)
+{
+    QCryptoHash *hash = NULL;
+
+    if (!qcrypto_hash_supports(alg)) {
+        error_setg(errp, "Unsupported hash algorithm %s",
+                   QCryptoHashAlgo_str(alg));
+        return NULL;
+   }
+
+#ifdef CONFIG_AF_ALG
+    hash = qcrypto_hash_afalg_driver.hash_new(alg, NULL);
+    if (hash) {
+        hash->driver = &qcrypto_hash_afalg_driver;
+        return hash;
+    }
+#endif
+
+    hash = qcrypto_hash_lib_driver.hash_new(alg, errp);
+    if (!hash) {
+        return NULL;
+    }
+
+    hash->driver = &qcrypto_hash_lib_driver;
+    return hash;
+}
+
+void qcrypto_hash_free(QCryptoHash *hash)
+{
+   QCryptoHashDriver *drv;
+
+    if (hash) {
+        drv = hash->driver;
+        drv->hash_free(hash);
+    }
+}
+
+int qcrypto_hash_finalize_bytes(QCryptoHash *hash,
+                                uint8_t **result,
+                                size_t *result_len,
+                                Error **errp)
+{
+    QCryptoHashDriver *drv = hash->driver;
+
+    return drv->hash_finalize(hash, result, result_len, errp);
+}
+
 static const char hex[] = "0123456789abcdef";
 
+int qcrypto_hash_finalize_digest(QCryptoHash *hash,
+                                 char **digest,
+                                 Error **errp)
+{
+    int ret;
+    g_autofree uint8_t *result = NULL;
+    size_t resultlen = 0;
+    size_t i;
+
+    ret = qcrypto_hash_finalize_bytes(hash, &result, &resultlen, errp);
+    if (ret == 0) {
+        *digest = g_new0(char, (resultlen * 2) + 1);
+        for (i = 0 ; i < resultlen ; i++) {
+            (*digest)[(i * 2)] = hex[(result[i] >> 4) & 0xf];
+            (*digest)[(i * 2) + 1] = hex[result[i] & 0xf];
+        }
+        (*digest)[resultlen * 2] = '\0';
+    }
+
+    return ret;
+}
+
+int qcrypto_hash_finalize_base64(QCryptoHash *hash,
+                                 char **base64,
+                                 Error **errp)
+{
+    int ret;
+    g_autofree uint8_t *result = NULL;
+    size_t resultlen = 0;
+
+    ret = qcrypto_hash_finalize_bytes(hash, &result, &resultlen, errp);
+    if (ret == 0) {
+        *base64 = g_base64_encode(result, resultlen);
+    }
+
+    return ret;
+}
+
 int qcrypto_hash_digestv(QCryptoHashAlgo alg,
                          const struct iovec *iov,
                          size_t niov,
                          char **digest,
                          Error **errp)
 {
-    uint8_t *result = NULL;
-    size_t resultlen = 0;
-    size_t i;
+    g_autoptr(QCryptoHash) ctx = qcrypto_hash_new(alg, errp);
 
-    if (qcrypto_hash_bytesv(alg, iov, niov, &result, &resultlen, errp) < 0) {
+    if (!ctx) {
         return -1;
     }
 
-    *digest = g_new0(char, (resultlen * 2) + 1);
-    for (i = 0 ; i < resultlen ; i++) {
-        (*digest)[(i * 2)] = hex[(result[i] >> 4) & 0xf];
-        (*digest)[(i * 2) + 1] = hex[result[i] & 0xf];
+    if (qcrypto_hash_updatev(ctx, iov, niov, errp) < 0 ||
+        qcrypto_hash_finalize_digest(ctx, digest, errp) < 0) {
+        return -1;
     }
-    (*digest)[resultlen * 2] = '\0';
-    g_free(result);
+
     return 0;
 }
 
@@ -120,15 +219,17 @@ int qcrypto_hash_base64v(QCryptoHashAlgo alg,
                          char **base64,
                          Error **errp)
 {
-    uint8_t *result = NULL;
-    size_t resultlen = 0;
+    g_autoptr(QCryptoHash) ctx = qcrypto_hash_new(alg, errp);
+
+    if (!ctx) {
+        return -1;
+    }
 
-    if (qcrypto_hash_bytesv(alg, iov, niov, &result, &resultlen, errp) < 0) {
+    if (qcrypto_hash_updatev(ctx, iov, niov, errp) < 0 ||
+        qcrypto_hash_finalize_base64(ctx, base64, errp) < 0) {
         return -1;
     }
 
-    *base64 = g_base64_encode(result, resultlen);
-    g_free(result);
     return 0;
 }
 
-- 
2.46.0


