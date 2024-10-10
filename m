Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E876CFC5E4
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 16:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syvva-0006we-W4; Thu, 10 Oct 2024 12:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1syvvU-0006uP-Np
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 12:22:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1syvvM-0004NS-Pn
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 12:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728577320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YpwiYJ3ZLO7kpZscaCRsl7Q4vjEbbQmMK9aN6p9w8H8=;
 b=bY+8TksV2JPb2sHIQx7QELMJTIobDgEvrTVIEeBLK+Q+s4gBYpuv1diqxTKtN+/3dTApEA
 bYXZwnGjwgFC+SyCUGl4z2iyjdX7+rEUkoeq6PSoOugPTjaoPPML0UD32E8DtXQ9DF9wKe
 m3/4cW9HsEEsrJbqw+A4/P9G8mFYy1E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-qcXeTvuGORqDueWITSV8gg-1; Thu,
 10 Oct 2024 12:21:58 -0400
X-MC-Unique: qcXeTvuGORqDueWITSV8gg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 838631955F25; Thu, 10 Oct 2024 16:21:57 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.110])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AC0E0300019E; Thu, 10 Oct 2024 16:21:55 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kunwu <chentao@kylinos.cn>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alejandro Zeise <alejandro.zeise@seagate.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 02/17] crypto/hash-glib: Implement new hash API
Date: Thu, 10 Oct 2024 17:20:09 +0100
Message-ID: <20241010162024.988284-3-berrange@redhat.com>
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

Implements the new hashing API in the GLib hash driver.
Supports creating/destroying a context, updating the context
with input data and obtaining an output hash.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
[ clg: - Dropped qcrypto_hash_supports() in qcrypto_glib_hash_new()
       - Removed superfluous cast (GChecksum *) in qcrypto_glib_hash_free()
       - Reworked qcrypto_glib_hash_finalize() ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/hash-glib.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/crypto/hash-glib.c b/crypto/hash-glib.c
index a5a2949333..783283facc 100644
--- a/crypto/hash-glib.c
+++ b/crypto/hash-glib.c
@@ -1,6 +1,7 @@
 /*
  * QEMU Crypto hash algorithms
  *
+ * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
  * Copyright (c) 2016 Red Hat, Inc.
  *
  * This library is free software; you can redistribute it and/or
@@ -95,6 +96,72 @@ qcrypto_glib_hash_bytesv(QCryptoHashAlgo alg,
 }
 
 
+static
+QCryptoHash *qcrypto_glib_hash_new(QCryptoHashAlgo alg,
+                                   Error **errp)
+{
+    QCryptoHash *hash;
+
+    hash = g_new(QCryptoHash, 1);
+    hash->alg = alg;
+    hash->opaque = g_checksum_new(qcrypto_hash_alg_map[alg]);
+
+    return hash;
+}
+
+static
+void qcrypto_glib_hash_free(QCryptoHash *hash)
+{
+    if (hash->opaque) {
+        g_checksum_free(hash->opaque);
+    }
+
+    g_free(hash);
+}
+
+
+static
+int qcrypto_glib_hash_update(QCryptoHash *hash,
+                             const struct iovec *iov,
+                             size_t niov,
+                             Error **errp)
+{
+    GChecksum *ctx = hash->opaque;
+
+    for (int i = 0; i < niov; i++) {
+        g_checksum_update(ctx, iov[i].iov_base, iov[i].iov_len);
+    }
+
+    return 0;
+}
+
+static
+int qcrypto_glib_hash_finalize(QCryptoHash *hash,
+                               uint8_t **result,
+                               size_t *result_len,
+                               Error **errp)
+{
+    int ret;
+    GChecksum *ctx = hash->opaque;
+
+    ret = g_checksum_type_get_length(qcrypto_hash_alg_map[hash->alg]);
+    if (ret < 0) {
+        error_setg(errp, "Unable to get hash length");
+        *result_len = 0;
+        return -1;
+    }
+
+    *result_len = ret;
+    *result = g_new(uint8_t, *result_len);
+
+    g_checksum_get_digest(ctx, *result, result_len);
+    return 0;
+}
+
 QCryptoHashDriver qcrypto_hash_lib_driver = {
     .hash_bytesv = qcrypto_glib_hash_bytesv,
+    .hash_new      = qcrypto_glib_hash_new,
+    .hash_update   = qcrypto_glib_hash_update,
+    .hash_finalize = qcrypto_glib_hash_finalize,
+    .hash_free     = qcrypto_glib_hash_free,
 };
-- 
2.46.0


