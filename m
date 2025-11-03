Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92210CCFA05
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFulN-0005JM-QK; Mon, 03 Nov 2025 08:38:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFulL-0005IS-L5
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:38:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFul7-0004NV-Li
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:38:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762177086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CytbbGx/qePdqn9PylzopkGkWlb8xBh0alfr/0UkUZU=;
 b=N92kKChkt7yq3SUiv63CcjJlpaDyACj/dAik/nYZBV7wdm8RZLhMKtYzYGNZfWh2nD8ABC
 mNKTDHp295YjOppWSwfJLUU9bPgpki+lpTHPaHegEEZNs9RqjjdVyApHkQC8wrKW+38i95
 KLLkYny2+FoI056jjoF/QUPdcVBpIuA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-wkJwEJHDOYa-FloUFcrk1g-1; Mon,
 03 Nov 2025 08:38:02 -0500
X-MC-Unique: wkJwEJHDOYa-FloUFcrk1g-1
X-Mimecast-MFC-AGG-ID: wkJwEJHDOYa-FloUFcrk1g_1762177080
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CBF4A195605B; Mon,  3 Nov 2025 13:38:00 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.202])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 67E2A180057B; Mon,  3 Nov 2025 13:37:53 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 03/32] crypto/hash: Have hashing functions take void * buffer
 argument
Date: Mon,  3 Nov 2025 13:36:57 +0000
Message-ID: <20251103133727.423041-4-berrange@redhat.com>
In-Reply-To: <20251103133727.423041-1-berrange@redhat.com>
References: <20251103133727.423041-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Cryptographic hash function can operate on any area of memory,
regardless of the content their represent. Do not restrict to
array of char, use the void* type, which is also the type of
the underlying iovec::iov_base field.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/hash.c         | 16 ++++++++--------
 crypto/hmac.c         |  8 ++++----
 include/crypto/hash.h |  8 ++++----
 include/crypto/hmac.h |  4 ++--
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/crypto/hash.c b/crypto/hash.c
index 7513769e42..6ffb88bf54 100644
--- a/crypto/hash.c
+++ b/crypto/hash.c
@@ -67,13 +67,13 @@ int qcrypto_hash_bytesv(QCryptoHashAlgo alg,
 
 
 int qcrypto_hash_bytes(QCryptoHashAlgo alg,
-                       const char *buf,
+                       const void *buf,
                        size_t len,
                        uint8_t **result,
                        size_t *resultlen,
                        Error **errp)
 {
-    struct iovec iov = { .iov_base = (char *)buf,
+    struct iovec iov = { .iov_base = (void *)buf,
                          .iov_len = len };
     return qcrypto_hash_bytesv(alg, &iov, 1, result, resultlen, errp);
 }
@@ -89,11 +89,11 @@ int qcrypto_hash_updatev(QCryptoHash *hash,
 }
 
 int qcrypto_hash_update(QCryptoHash *hash,
-                        const char *buf,
+                        const void *buf,
                         size_t len,
                         Error **errp)
 {
-    struct iovec iov = { .iov_base = (char *)buf, .iov_len = len };
+    struct iovec iov = { .iov_base = (void *)buf, .iov_len = len };
 
     return qcrypto_hash_updatev(hash, &iov, 1, errp);
 }
@@ -206,12 +206,12 @@ int qcrypto_hash_digestv(QCryptoHashAlgo alg,
 }
 
 int qcrypto_hash_digest(QCryptoHashAlgo alg,
-                        const char *buf,
+                        const void *buf,
                         size_t len,
                         char **digest,
                         Error **errp)
 {
-    struct iovec iov = { .iov_base = (char *)buf, .iov_len = len };
+    struct iovec iov = { .iov_base = (void *)buf, .iov_len = len };
 
     return qcrypto_hash_digestv(alg, &iov, 1, digest, errp);
 }
@@ -237,12 +237,12 @@ int qcrypto_hash_base64v(QCryptoHashAlgo alg,
 }
 
 int qcrypto_hash_base64(QCryptoHashAlgo alg,
-                        const char *buf,
+                        const void *buf,
                         size_t len,
                         char **base64,
                         Error **errp)
 {
-    struct iovec iov = { .iov_base = (char *)buf, .iov_len = len };
+    struct iovec iov = { .iov_base = (void *)buf, .iov_len = len };
 
     return qcrypto_hash_base64v(alg, &iov, 1, base64, errp);
 }
diff --git a/crypto/hmac.c b/crypto/hmac.c
index 422e005182..2f0d044cf2 100644
--- a/crypto/hmac.c
+++ b/crypto/hmac.c
@@ -28,14 +28,14 @@ int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
 }
 
 int qcrypto_hmac_bytes(QCryptoHmac *hmac,
-                       const char *buf,
+                       const void *buf,
                        size_t len,
                        uint8_t **result,
                        size_t *resultlen,
                        Error **errp)
 {
     struct iovec iov = {
-            .iov_base = (char *)buf,
+            .iov_base = (void *)buf,
             .iov_len = len
     };
 
@@ -70,13 +70,13 @@ int qcrypto_hmac_digestv(QCryptoHmac *hmac,
 }
 
 int qcrypto_hmac_digest(QCryptoHmac *hmac,
-                        const char *buf,
+                        const void *buf,
                         size_t len,
                         char **digest,
                         Error **errp)
 {
     struct iovec iov = {
-            .iov_base = (char *)buf,
+            .iov_base = (void *)buf,
             .iov_len = len
     };
 
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index 1868d4a0f7..43525098c5 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -122,7 +122,7 @@ int qcrypto_hash_bytesv(QCryptoHashAlgo alg,
  * Returns: 0 on success, -1 on error
  */
 int qcrypto_hash_bytes(QCryptoHashAlgo alg,
-                       const char *buf,
+                       const void *buf,
                        size_t len,
                        uint8_t **result,
                        size_t *resultlen,
@@ -180,7 +180,7 @@ int qcrypto_hash_updatev(QCryptoHash *hash,
  * Returns: 0 on success, -1 on error
  */
 int qcrypto_hash_update(QCryptoHash *hash,
-                        const char *buf,
+                        const void *buf,
                         size_t len,
                         Error **errp);
 
@@ -289,7 +289,7 @@ G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoHash, qcrypto_hash_free)
  * Returns: 0 on success, -1 on error
  */
 int qcrypto_hash_digest(QCryptoHashAlgo alg,
-                        const char *buf,
+                        const void *buf,
                         size_t len,
                         char **digest,
                         Error **errp);
@@ -335,7 +335,7 @@ int qcrypto_hash_base64v(QCryptoHashAlgo alg,
  * Returns: 0 on success, -1 on error
  */
 int qcrypto_hash_base64(QCryptoHashAlgo alg,
-                        const char *buf,
+                        const void *buf,
                         size_t len,
                         char **base64,
                         Error **errp);
diff --git a/include/crypto/hmac.h b/include/crypto/hmac.h
index af3d5f8feb..0885ae22d1 100644
--- a/include/crypto/hmac.h
+++ b/include/crypto/hmac.h
@@ -139,7 +139,7 @@ int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
  *  0 on success, -1 on error
  */
 int qcrypto_hmac_bytes(QCryptoHmac *hmac,
-                       const char *buf,
+                       const void *buf,
                        size_t len,
                        uint8_t **result,
                        size_t *resultlen,
@@ -187,7 +187,7 @@ int qcrypto_hmac_digestv(QCryptoHmac *hmac,
  * Returns: 0 on success, -1 on error
  */
 int qcrypto_hmac_digest(QCryptoHmac *hmac,
-                        const char *buf,
+                        const void *buf,
                         size_t len,
                         char **digest,
                         Error **errp);
-- 
2.51.1


