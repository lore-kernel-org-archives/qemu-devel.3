Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CE8CED276
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 07:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy56D-0008AO-8r; Tue, 08 Oct 2024 03:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sy569-00089b-Qe
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 03:57:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sy568-0005bq-4I
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 03:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728374254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xW+uTtmYMytblteQ/H3xqxcn+YRyX+2Fbgjh3Mv4FIw=;
 b=AKmL+YwI1o/sIDsgcutPqbGmgsppciZLUBvxnzx9MijzRpskyhtM1OiZdRdxL1MIFq9MNX
 54t5DLIODPdbfxlCRud53yZzllEgtaOcYF6ifOSCXpx0kTQ4RTHn4YX9KCnr35NcwkH943
 0Vf8oK6pn/UFR4wco2wOn6oBudlxsmo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-DNmIpmCAPMW2KWjHQ9e-5g-1; Tue,
 08 Oct 2024 03:57:33 -0400
X-MC-Unique: DNmIpmCAPMW2KWjHQ9e-5g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 653B719560A2; Tue,  8 Oct 2024 07:57:31 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.61])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E47BD300018D; Tue,  8 Oct 2024 07:57:28 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	berrange@redhat.com
Cc: kris.conklin@seagate.com, jonathan.henze@seagate.com,
 evan.burgess@seagate.com, peter.maydell@linaro.org,
 Alejandro Zeise <alejandro.zeise@seagate.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v5 01/16] crypto: accumulative hashing API
Date: Tue,  8 Oct 2024 09:57:08 +0200
Message-ID: <20241008075724.2772149-2-clg@redhat.com>
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

Changes the hash API to support accumulative hashing.
Hash objects are created with "qcrypto_hash_new",
updated with data with "qcrypto_hash_update", and
the hash obtained with "qcrypto_hash_finalize".

These changes bring the hashing API more in line with the
hmac API.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
[ clg: - Changed documentation "non-zero on error" -> "-1 on error" ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 crypto/hashpriv.h     |  13 +++++
 include/crypto/hash.h | 119 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+)

diff --git a/crypto/hashpriv.h b/crypto/hashpriv.h
index 47daec3f7aed..dcb3ba6cfba0 100644
--- a/crypto/hashpriv.h
+++ b/crypto/hashpriv.h
@@ -1,6 +1,7 @@
 /*
  * QEMU Crypto hash driver supports
  *
+ * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
  * Copyright (c) 2017 HUAWEI TECHNOLOGIES CO., LTD.
  *
  * Authors:
@@ -15,6 +16,8 @@
 #ifndef QCRYPTO_HASHPRIV_H
 #define QCRYPTO_HASHPRIV_H
 
+#include "crypto/hash.h"
+
 typedef struct QCryptoHashDriver QCryptoHashDriver;
 
 struct QCryptoHashDriver {
@@ -24,6 +27,16 @@ struct QCryptoHashDriver {
                        uint8_t **result,
                        size_t *resultlen,
                        Error **errp);
+    QCryptoHash *(*hash_new)(QCryptoHashAlgo alg, Error **errp);
+    int (*hash_update)(QCryptoHash *hash,
+                       const struct iovec *iov,
+                       size_t niov,
+                       Error **errp);
+    int (*hash_finalize)(QCryptoHash *hash,
+                         uint8_t **result,
+                         size_t *resultlen,
+                         Error **errp);
+    void (*hash_free)(QCryptoHash *hash);
 };
 
 extern QCryptoHashDriver qcrypto_hash_lib_driver;
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index 6038a52d0e49..b791ca92a430 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -1,6 +1,7 @@
 /*
  * QEMU Crypto hash algorithms
  *
+ * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
  * Copyright (c) 2015 Red Hat, Inc.
  *
  * This library is free software; you can redistribute it and/or
@@ -33,6 +34,13 @@
 
 /* See also "QCryptoHashAlgo" defined in qapi/crypto.json */
 
+typedef struct QCryptoHash QCryptoHash;
+struct QCryptoHash {
+    QCryptoHashAlgo alg;
+    void *opaque;
+    void *driver;
+};
+
 /**
  * qcrypto_hash_supports:
  * @alg: the hash algorithm
@@ -128,6 +136,117 @@ int qcrypto_hash_digestv(QCryptoHashAlgo alg,
                          char **digest,
                          Error **errp);
 
+/**
+ * qcrypto_hash_updatev:
+ * @hash: hash object from qcrypto_hash_new
+ * @iov: the array of memory regions to hash
+ * @niov: the length of @iov
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Updates the given hash object with all the memory regions
+ * present in @iov.
+ *
+ * Returns: 0 on success, -1 on error
+ */
+int qcrypto_hash_updatev(QCryptoHash *hash,
+                         const struct iovec *iov,
+                         size_t niov,
+                         Error **errp);
+/**
+ * qcrypto_hash_update:
+ * @hash: hash object from qcrypto_hash_new
+ * @buf: the memory region to hash
+ * @len: the length of @buf
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Updates the given hash object with the data from
+ * the given buffer.
+ *
+ * Returns: 0 on success, -1 on error
+ */
+int qcrypto_hash_update(QCryptoHash *hash,
+                        const char *buf,
+                        size_t len,
+                        Error **errp);
+
+/**
+ * qcrypto_hash_finalize_digest:
+ * @hash: the hash object to finalize
+ * @digest: pointer to hold output hash
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Computes the hash from the given hash object. Hash object
+ * is expected to have its data updated from the qcrypto_hash_update function.
+ * The @digest pointer will be filled with the printable hex digest of the
+ * computed hash, which will be terminated by '\0'. The memory pointer
+ * in @digest must be released with a call to g_free() when
+ * no longer required.
+ *
+ * Returns: 0 on success, -1 on error
+ */
+int qcrypto_hash_finalize_digest(QCryptoHash *hash,
+                                 char **digest,
+                                 Error **errp);
+
+/**
+ * qcrypto_hash_finalize_base64:
+ * @hash_ctx: hash object to finalize
+ * @base64: pointer to store the hash result in
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Computes the hash from the given hash object. Hash object
+ * is expected to have it's data updated from the qcrypto_hash_update function.
+ * The @base64 pointer will be filled with the base64 encoding of the computed
+ * hash, which will be terminated by '\0'. The memory pointer in @base64
+ * must be released with a call to g_free() when no longer required.
+ *
+ * Returns: 0 on success, -1 on error
+ */
+int qcrypto_hash_finalize_base64(QCryptoHash *hash,
+                                 char **base64,
+                                 Error **errp);
+
+/**
+ * qcrypto_hash_finalize_bytes:
+ * @hash_ctx: hash object to finalize
+ * @result: pointer to store the hash result in
+ * @result_len: Pointer to store the length of the result in
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Computes the hash from the given hash object. Hash object
+ * is expected to have it's data updated from the qcrypto_hash_update function.
+ * The memory pointer in @result must be released with a call to g_free()
+ * when no longer required.
+ *
+ * Returns: 0 on success, -1 on error
+ */
+int qcrypto_hash_finalize_bytes(QCryptoHash *hash,
+                                uint8_t **result,
+                                size_t *result_len,
+                                Error **errp);
+
+/**
+ * qcrypto_hash_new:
+ * @alg: the hash algorithm
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Creates a new hashing context for the chosen algorithm for
+ * usage with qcrypto_hash_update.
+ *
+ * Returns: New hash object with the given algorithm, or NULL on error.
+ */
+QCryptoHash *qcrypto_hash_new(QCryptoHashAlgo alg, Error **errp);
+
+/**
+ * qcrypto_hash_free:
+ * @hash: hash object to free
+ *
+ * Frees a hashing context for the chosen algorithm.
+ */
+void qcrypto_hash_free(QCryptoHash *hash);
+
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoHash, qcrypto_hash_free)
+
 /**
  * qcrypto_hash_digest:
  * @alg: the hash algorithm
-- 
2.46.2


