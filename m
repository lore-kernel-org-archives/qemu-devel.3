Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A72CED278
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 07:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy56N-0008C0-7E; Tue, 08 Oct 2024 03:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sy56L-0008Bc-BY
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 03:57:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sy56J-0005cn-TV
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 03:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728374267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3p2iMVe9xBex5tpYqFEs45RutGXoRUHuZpC0+1Rn+qA=;
 b=Vj7t2zN+7E1ULRcUpTjUI4mUU7eeiCq9QM4nAi9iDzeVPa5/wOyhnTunfC+qX0qwP9sqQs
 iaW9werujRY5Ir/J3XZsv75c11fYw+3j3RNtx2RWNsN6+oyGHBOGP8JxMjbZN4VwKDbblU
 ZY4nrWtDtIRusIBoNr+wx7zy76zmbGU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-EVl0pjTMPLmBU2deS6B0mw-1; Tue,
 08 Oct 2024 03:57:44 -0400
X-MC-Unique: EVl0pjTMPLmBU2deS6B0mw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC58219560AB; Tue,  8 Oct 2024 07:57:42 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.61])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6E211300018D; Tue,  8 Oct 2024 07:57:40 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	berrange@redhat.com
Cc: kris.conklin@seagate.com, jonathan.henze@seagate.com,
 evan.burgess@seagate.com, peter.maydell@linaro.org,
 Alejandro Zeise <alejandro.zeise@seagate.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v5 05/16] crypto/hash-nettle: Implement new hash API
Date: Tue,  8 Oct 2024 09:57:12 +0200
Message-ID: <20241008075724.2772149-6-clg@redhat.com>
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

Implements the new hashing API in the nettle hash driver.
Supports creating/destroying a context, updating the context
with input data and obtaining an output hash.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
[ clg: - Dropped qcrypto_hash_supports() in qcrypto_nettle_hash_new() ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 crypto/hash-nettle.c | 70 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/crypto/hash-nettle.c b/crypto/hash-nettle.c
index 8b08a9c67531..07e18ce26cba 100644
--- a/crypto/hash-nettle.c
+++ b/crypto/hash-nettle.c
@@ -1,6 +1,7 @@
 /*
  * QEMU Crypto hash algorithms
  *
+ * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
  * Copyright (c) 2016 Red Hat, Inc.
  *
  * This library is free software; you can redistribute it and/or
@@ -155,7 +156,76 @@ qcrypto_nettle_hash_bytesv(QCryptoHashAlgo alg,
     return 0;
 }
 
+static
+QCryptoHash *qcrypto_nettle_hash_new(QCryptoHashAlgo alg, Error **errp)
+{
+    QCryptoHash *hash;
+
+    hash = g_new(QCryptoHash, 1);
+    hash->alg = alg;
+    hash->opaque = g_new(union qcrypto_hash_ctx, 1);
+
+    qcrypto_hash_alg_map[alg].init(hash->opaque);
+    return hash;
+}
+
+static
+void qcrypto_nettle_hash_free(QCryptoHash *hash)
+{
+    union qcrypto_hash_ctx *ctx = hash->opaque;
+
+    g_free(ctx);
+    g_free(hash);
+}
+
+static
+int qcrypto_nettle_hash_update(QCryptoHash *hash,
+                               const struct iovec *iov,
+                               size_t niov,
+                               Error **errp)
+{
+    union qcrypto_hash_ctx *ctx = hash->opaque;
+
+    for (int i = 0; i < niov; i++) {
+        /*
+         * Some versions of nettle have functions
+         * declared with 'int' instead of 'size_t'
+         * so to be safe avoid writing more than
+         * UINT_MAX bytes at a time
+         */
+        size_t len = iov[i].iov_len;
+        uint8_t *base = iov[i].iov_base;
+        while (len) {
+            size_t shortlen = MIN(len, UINT_MAX);
+            qcrypto_hash_alg_map[hash->alg].write(ctx, len, base);
+            len -= shortlen;
+            base += len;
+        }
+    }
+
+    return 0;
+}
+
+static
+int qcrypto_nettle_hash_finalize(QCryptoHash *hash,
+                                 uint8_t **result,
+                                 size_t *result_len,
+                                 Error **errp)
+{
+    union qcrypto_hash_ctx *ctx = hash->opaque;
+
+    *result_len = qcrypto_hash_alg_map[hash->alg].len;
+    *result = g_new(uint8_t, *result_len);
+
+    qcrypto_hash_alg_map[hash->alg].result(ctx, *result_len, *result);
+
+    return 0;
+}
 
 QCryptoHashDriver qcrypto_hash_lib_driver = {
     .hash_bytesv = qcrypto_nettle_hash_bytesv,
+    .hash_new      = qcrypto_nettle_hash_new,
+    .hash_update   = qcrypto_nettle_hash_update,
+    .hash_finalize = qcrypto_nettle_hash_finalize,
+    .hash_free     = qcrypto_nettle_hash_free,
 };
-- 
2.46.2


