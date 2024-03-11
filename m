Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE55FC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 12:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjedA-0002zr-Qe; Mon, 11 Mar 2024 08:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rjed8-0002ze-PX
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 08:19:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rjed6-0007vK-F0
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 08:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710159583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g5Rr8wdXUIuFsIy7U9R+mneTGnAbnCnM4CTFXrrGGIQ=;
 b=HDwwur8CvWgAxkHTJHVTJuzo+Ihapfn9+cnmEukXP5n5cya8GFqkC54mSWmcwy03TAJjZI
 51ITSXX4CjJjbl7CyNw0yut9VbZk8LjqulRy/3vG4/YHkv3jfkGydi0voXOds43eMlaSPb
 k/dGI4CY6bf9HHtMVnmfDNZKHhIWuJQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-ZNy7FoTyNZOA2-MIvfpBHA-1; Mon,
 11 Mar 2024 08:19:31 -0400
X-MC-Unique: ZNy7FoTyNZOA2-MIvfpBHA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 87E3F29AB443
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 12:19:31 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED9D4C15771;
 Mon, 11 Mar 2024 12:19:30 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 1/4] crypto: factor out conversion of QAPI to gcrypt constants
Date: Mon, 11 Mar 2024 12:19:26 +0000
Message-ID: <20240311121929.212472-2-berrange@redhat.com>
In-Reply-To: <20240311121929.212472-1-berrange@redhat.com>
References: <20240311121929.212472-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The conversion of cipher mode will shortly be required in more
than one place.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/cipher-gcrypt.c.inc | 116 +++++++++++++++++++------------------
 1 file changed, 60 insertions(+), 56 deletions(-)

diff --git a/crypto/cipher-gcrypt.c.inc b/crypto/cipher-gcrypt.c.inc
index 1377cbaf14..6b82280f90 100644
--- a/crypto/cipher-gcrypt.c.inc
+++ b/crypto/cipher-gcrypt.c.inc
@@ -20,6 +20,56 @@
 
 #include <gcrypt.h>
 
+static int qcrypto_cipher_alg_to_gcry_alg(QCryptoCipherAlgorithm alg)
+{
+    switch (alg) {
+    case QCRYPTO_CIPHER_ALG_DES:
+        return GCRY_CIPHER_DES;
+    case QCRYPTO_CIPHER_ALG_3DES:
+        return GCRY_CIPHER_3DES;
+    case QCRYPTO_CIPHER_ALG_AES_128:
+        return GCRY_CIPHER_AES128;
+    case QCRYPTO_CIPHER_ALG_AES_192:
+        return GCRY_CIPHER_AES192;
+    case QCRYPTO_CIPHER_ALG_AES_256:
+        return GCRY_CIPHER_AES256;
+    case QCRYPTO_CIPHER_ALG_CAST5_128:
+        return GCRY_CIPHER_CAST5;
+    case QCRYPTO_CIPHER_ALG_SERPENT_128:
+        return GCRY_CIPHER_SERPENT128;
+    case QCRYPTO_CIPHER_ALG_SERPENT_192:
+        return GCRY_CIPHER_SERPENT192;
+    case QCRYPTO_CIPHER_ALG_SERPENT_256:
+        return GCRY_CIPHER_SERPENT256;
+    case QCRYPTO_CIPHER_ALG_TWOFISH_128:
+        return GCRY_CIPHER_TWOFISH128;
+    case QCRYPTO_CIPHER_ALG_TWOFISH_256:
+        return GCRY_CIPHER_TWOFISH;
+#ifdef CONFIG_CRYPTO_SM4
+    case QCRYPTO_CIPHER_ALG_SM4:
+        return GCRY_CIPHER_SM4;
+#endif
+    default:
+        return GCRY_CIPHER_NONE;
+    }
+}
+
+static int qcrypto_cipher_mode_to_gcry_mode(QCryptoCipherMode mode)
+{
+    switch (mode) {
+    case QCRYPTO_CIPHER_MODE_ECB:
+        return GCRY_CIPHER_MODE_ECB;
+    case QCRYPTO_CIPHER_MODE_XTS:
+        return GCRY_CIPHER_MODE_XTS;
+    case QCRYPTO_CIPHER_MODE_CBC:
+        return GCRY_CIPHER_MODE_CBC;
+    case QCRYPTO_CIPHER_MODE_CTR:
+        return GCRY_CIPHER_MODE_CTR;
+    default:
+        return GCRY_CIPHER_MODE_NONE;
+    }
+}
+
 bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
                              QCryptoCipherMode mode)
 {
@@ -188,72 +238,26 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
         return NULL;
     }
 
-    switch (alg) {
-    case QCRYPTO_CIPHER_ALG_DES:
-        gcryalg = GCRY_CIPHER_DES;
-        break;
-    case QCRYPTO_CIPHER_ALG_3DES:
-        gcryalg = GCRY_CIPHER_3DES;
-        break;
-    case QCRYPTO_CIPHER_ALG_AES_128:
-        gcryalg = GCRY_CIPHER_AES128;
-        break;
-    case QCRYPTO_CIPHER_ALG_AES_192:
-        gcryalg = GCRY_CIPHER_AES192;
-        break;
-    case QCRYPTO_CIPHER_ALG_AES_256:
-        gcryalg = GCRY_CIPHER_AES256;
-        break;
-    case QCRYPTO_CIPHER_ALG_CAST5_128:
-        gcryalg = GCRY_CIPHER_CAST5;
-        break;
-    case QCRYPTO_CIPHER_ALG_SERPENT_128:
-        gcryalg = GCRY_CIPHER_SERPENT128;
-        break;
-    case QCRYPTO_CIPHER_ALG_SERPENT_192:
-        gcryalg = GCRY_CIPHER_SERPENT192;
-        break;
-    case QCRYPTO_CIPHER_ALG_SERPENT_256:
-        gcryalg = GCRY_CIPHER_SERPENT256;
-        break;
-    case QCRYPTO_CIPHER_ALG_TWOFISH_128:
-        gcryalg = GCRY_CIPHER_TWOFISH128;
-        break;
-    case QCRYPTO_CIPHER_ALG_TWOFISH_256:
-        gcryalg = GCRY_CIPHER_TWOFISH;
-        break;
-#ifdef CONFIG_CRYPTO_SM4
-    case QCRYPTO_CIPHER_ALG_SM4:
-        gcryalg = GCRY_CIPHER_SM4;
-        break;
-#endif
-    default:
+    gcryalg = qcrypto_cipher_alg_to_gcry_alg(alg);
+    if (gcryalg == GCRY_CIPHER_NONE) {
         error_setg(errp, "Unsupported cipher algorithm %s",
                    QCryptoCipherAlgorithm_str(alg));
         return NULL;
     }
 
-    drv = &qcrypto_gcrypt_driver;
-    switch (mode) {
-    case QCRYPTO_CIPHER_MODE_ECB:
-        gcrymode = GCRY_CIPHER_MODE_ECB;
-        break;
-    case QCRYPTO_CIPHER_MODE_XTS:
-        gcrymode = GCRY_CIPHER_MODE_XTS;
-        break;
-    case QCRYPTO_CIPHER_MODE_CBC:
-        gcrymode = GCRY_CIPHER_MODE_CBC;
-        break;
-    case QCRYPTO_CIPHER_MODE_CTR:
-        drv = &qcrypto_gcrypt_ctr_driver;
-        gcrymode = GCRY_CIPHER_MODE_CTR;
-        break;
-    default:
+    gcrymode = qcrypto_cipher_mode_to_gcry_mode(mode);
+    if (gcrymode == GCRY_CIPHER_MODE_NONE) {
         error_setg(errp, "Unsupported cipher mode %s",
                    QCryptoCipherMode_str(mode));
         return NULL;
     }
 
+    if (mode == QCRYPTO_CIPHER_MODE_CTR) {
+        drv = &qcrypto_gcrypt_ctr_driver;
+    } else {
+        drv = &qcrypto_gcrypt_driver;
+    }
+
     ctx = g_new0(QCryptoCipherGcrypt, 1);
     ctx->base.driver = drv;
 
-- 
2.43.0


