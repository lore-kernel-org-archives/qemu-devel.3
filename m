Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C2BCED276
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 07:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy56f-0008EH-1x; Tue, 08 Oct 2024 03:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sy56X-0008Di-80
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 03:58:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sy56V-0005dm-JW
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 03:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728374279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qG27T+g3U6Yp7fsVwDGPNBU8KssZgStbQTbkt259FB4=;
 b=NnkA/0AxH24JVwGq9O3g9wYtbHdVpGuX/lAxdBsUDZy0nZg7zMfp/NqEjS3VvzWzrFllX8
 OTIwK78GpTgECpMef+xHVEDjJSlZyC2/TlsSb1BVdYiTvIii9xt07+YsLUNtXj4pxNVBML
 OUOuOe2czjshpfJZjsOAm/aTOk9cyJs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-f4x-3Q0ANVKEJ5glcXc3lg-1; Tue,
 08 Oct 2024 03:57:53 -0400
X-MC-Unique: f4x-3Q0ANVKEJ5glcXc3lg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 382AE19560BD; Tue,  8 Oct 2024 07:57:51 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.61])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DDB0A300019F; Tue,  8 Oct 2024 07:57:48 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	berrange@redhat.com
Cc: kris.conklin@seagate.com, jonathan.henze@seagate.com,
 evan.burgess@seagate.com, peter.maydell@linaro.org,
 Alejandro Zeise <alejandro.zeise@seagate.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v5 08/16] crypto/hash: Implement and use new hash API
Date: Tue,  8 Oct 2024 09:57:15 +0200
Message-ID: <20241008075724.2772149-9-clg@redhat.com>
In-Reply-To: <20241008075724.2772149-1-clg@redhat.com>
References: <20241008075724.2772149-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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
---
 crypto/hash.c | 161 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 131 insertions(+), 30 deletions(-)

diff --git a/crypto/hash.c b/crypto/hash.c
index 4a265582b80a..0c8548c5683c 100644
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
2.46.2


