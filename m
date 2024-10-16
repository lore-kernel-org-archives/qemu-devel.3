Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA89DD1AD41
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 10:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t118o-0000Lk-Rr; Wed, 16 Oct 2024 06:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t118m-0000Ks-KW
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 06:20:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t118l-0002oM-5t
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 06:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729074022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=84N2rxqupBUcdaTpHle3WoL4A06cF9MmgU6vQgWoN4s=;
 b=FQzWM2O9cxTWxM4QMdKQrojldRQMYCbKpIYSz8Sh/btq1f47pvaad8OhHJq/fOSg4uhvj0
 FrDhF7GsM6XWxPsdHWVGeWE5/NG6qOkici+vM7kd/pymMb0oYLD5i6fnRWyWLy/p0sxz1U
 6SVpfvebpXtFSo+e7Qd6AufkjVgk2uU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-ciYjrZ9_OGGlpxXyZrz92g-1; Wed,
 16 Oct 2024 06:20:19 -0400
X-MC-Unique: ciYjrZ9_OGGlpxXyZrz92g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 93BD11913791; Wed, 16 Oct 2024 10:20:12 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.95])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E75A61955E93; Wed, 16 Oct 2024 10:20:10 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Dorjoy Chowdhury <dorjoychy111@gmail.com>
Subject: [PATCH v2 1/3] crypto/hash: avoid overwriting user supplied result
 pointer
Date: Wed, 16 Oct 2024 11:20:04 +0100
Message-ID: <20241016102006.480218-2-berrange@redhat.com>
In-Reply-To: <20241016102006.480218-1-berrange@redhat.com>
References: <20241016102006.480218-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

If the user provides a pre-allocated buffer for the hash result,
we must use that rather than re-allocating a new buffer.

Reported-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/hash-gcrypt.c | 15 ++++++++++++---
 crypto/hash-glib.c   | 11 +++++++++--
 crypto/hash-gnutls.c | 16 +++++++++++++---
 crypto/hash-nettle.c | 14 +++++++++++---
 4 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/crypto/hash-gcrypt.c b/crypto/hash-gcrypt.c
index ccc3cce3f8..73533a4949 100644
--- a/crypto/hash-gcrypt.c
+++ b/crypto/hash-gcrypt.c
@@ -103,16 +103,25 @@ int qcrypto_gcrypt_hash_finalize(QCryptoHash *hash,
                                  size_t *result_len,
                                  Error **errp)
 {
+    int ret;
     unsigned char *digest;
     gcry_md_hd_t *ctx = hash->opaque;
 
-    *result_len = gcry_md_get_algo_dlen(qcrypto_hash_alg_map[hash->alg]);
-    if (*result_len == 0) {
+    ret = gcry_md_get_algo_dlen(qcrypto_hash_alg_map[hash->alg]);
+    if (ret == 0) {
         error_setg(errp, "Unable to get hash length");
         return -1;
     }
 
-    *result = g_new(uint8_t, *result_len);
+    if (*result_len == 0) {
+        *result_len = ret;
+        *result = g_new(uint8_t, *result_len);
+    } else if (*result_len != ret) {
+        error_setg(errp,
+                   "Result buffer size %zu is smaller than hash %d",
+                   *result_len, ret);
+        return -1;
+    }
 
     /* Digest is freed by gcry_md_close(), copy it */
     digest = gcry_md_read(*ctx, 0);
diff --git a/crypto/hash-glib.c b/crypto/hash-glib.c
index 02a6ec1edf..809cef98ae 100644
--- a/crypto/hash-glib.c
+++ b/crypto/hash-glib.c
@@ -99,8 +99,15 @@ int qcrypto_glib_hash_finalize(QCryptoHash *hash,
         return -1;
     }
 
-    *result_len = ret;
-    *result = g_new(uint8_t, *result_len);
+    if (*result_len == 0) {
+        *result_len = ret;
+        *result = g_new(uint8_t, *result_len);
+    } else if (*result_len != ret) {
+        error_setg(errp,
+                   "Result buffer size %zu is smaller than hash %d",
+                   *result_len, ret);
+        return -1;
+    }
 
     g_checksum_get_digest(ctx, *result, result_len);
     return 0;
diff --git a/crypto/hash-gnutls.c b/crypto/hash-gnutls.c
index 34a63994c9..99fbe824ea 100644
--- a/crypto/hash-gnutls.c
+++ b/crypto/hash-gnutls.c
@@ -115,14 +115,24 @@ int qcrypto_gnutls_hash_finalize(QCryptoHash *hash,
                                  Error **errp)
 {
     gnutls_hash_hd_t *ctx = hash->opaque;
+    int ret;
 
-    *result_len = gnutls_hash_get_len(qcrypto_hash_alg_map[hash->alg]);
-    if (*result_len == 0) {
+    ret = gnutls_hash_get_len(qcrypto_hash_alg_map[hash->alg]);
+    if (ret == 0) {
         error_setg(errp, "Unable to get hash length");
         return -1;
     }
 
-    *result = g_new(uint8_t, *result_len);
+    if (*result_len == 0) {
+        *result_len = ret;
+        *result = g_new(uint8_t, *result_len);
+    } else if (*result_len != ret) {
+        error_setg(errp,
+                   "Result buffer size %zu is smaller than hash %d",
+                   *result_len, ret);
+        return -1;
+    }
+
     gnutls_hash_output(*ctx, *result);
     return 0;
 }
diff --git a/crypto/hash-nettle.c b/crypto/hash-nettle.c
index 3b847aa60e..c78624b347 100644
--- a/crypto/hash-nettle.c
+++ b/crypto/hash-nettle.c
@@ -150,9 +150,17 @@ int qcrypto_nettle_hash_finalize(QCryptoHash *hash,
                                  Error **errp)
 {
     union qcrypto_hash_ctx *ctx = hash->opaque;
-
-    *result_len = qcrypto_hash_alg_map[hash->alg].len;
-    *result = g_new(uint8_t, *result_len);
+    int ret = qcrypto_hash_alg_map[hash->alg].len;
+
+    if (*result_len == 0) {
+        *result_len = ret;
+        *result = g_new(uint8_t, *result_len);
+    } else if (*result_len != ret) {
+        error_setg(errp,
+                   "Result buffer size %zu is smaller than hash %d",
+                   *result_len, ret);
+        return -1;
+    }
 
     qcrypto_hash_alg_map[hash->alg].result(ctx, *result_len, *result);
 
-- 
2.46.0


