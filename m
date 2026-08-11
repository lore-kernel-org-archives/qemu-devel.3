Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EEB9C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:37:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpPV-0006la-Sz; Tue, 11 Aug 2026 12:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpOy-0005WX-W0
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpOv-00012l-KK
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P7SjT+HLx4LWeTRU0wOOqHIPUH+StHb6E/H866toUws=;
 b=Pq9PhuHLWaSb8Xuiu9+cmB7iCKjlIZO7bmR6tEmixaQ/lW/7CGDXeoW8CkhFXcAUVX/eTs
 ePPWylz0XljlgKfhnTDqKTJ+0zfTZ+iD3n755ZxRN7bNCq0h31OJXKykhHkYtVIm9KrY35
 u6KFRoYyo7QbizAMNw+vzsnIHeAevGE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-oQUMMLmPPzOeW78tpP3nsg-1; Tue,
 11 Aug 2026 12:32:25 -0400
X-MC-Unique: oQUMMLmPPzOeW78tpP3nsg-1
X-Mimecast-MFC-AGG-ID: oQUMMLmPPzOeW78tpP3nsg_1786465944
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDB8619560BB; Tue, 11 Aug 2026 16:32:23 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0B862195DF91; Tue, 11 Aug 2026 16:32:21 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 75/83] crypto/cipher: Add setaad/gettag for AEAD modes
Date: Tue, 11 Aug 2026 18:29:30 +0200
Message-ID: <20260811162938.1403216-76-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jamin Lin <jamin_lin@aspeedtech.com>

AEAD modes such as GCM authenticate optional associated data (AAD) and
produce an authentication tag, which the block-cipher encrypt/decrypt
interface cannot express. Add qcrypto_cipher_setaad() and
qcrypto_cipher_gettag() plus the matching backend driver hooks. The
generic front-end reports an error when the selected mode's driver does
not implement them, so calling them on a non-AEAD mode fails cleanly.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>
Link: https://lore.kernel.org/qemu-devel/20260811060115.1849266-9-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 crypto/cipherpriv.h     |  8 ++++++++
 include/crypto/cipher.h | 36 ++++++++++++++++++++++++++++++++++++
 crypto/cipher.c         | 31 +++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)

diff --git a/crypto/cipherpriv.h b/crypto/cipherpriv.h
index 64737ce96153..c4f995f36910 100644
--- a/crypto/cipherpriv.h
+++ b/crypto/cipherpriv.h
@@ -34,6 +34,14 @@ struct QCryptoCipherDriver {
                         const uint8_t *iv, size_t niv,
                         Error **errp);
 
+    int (*cipher_setaad)(QCryptoCipher *cipher,
+                         const uint8_t *aad, size_t len,
+                         Error **errp);
+
+    int (*cipher_gettag)(QCryptoCipher *cipher,
+                         uint8_t *tag, size_t len,
+                         Error **errp);
+
     void (*cipher_free)(QCryptoCipher *cipher);
 };
 
diff --git a/include/crypto/cipher.h b/include/crypto/cipher.h
index 92939310ef09..2e361411b949 100644
--- a/include/crypto/cipher.h
+++ b/include/crypto/cipher.h
@@ -235,4 +235,40 @@ int qcrypto_cipher_setiv(QCryptoCipher *cipher,
                          const uint8_t *iv, size_t niv,
                          Error **errp);
 
+/**
+ * qcrypto_cipher_setaad:
+ * @cipher: the cipher object
+ * @aad: the associated data to authenticate
+ * @len: the length of @aad
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * For AEAD modes such as GCM, feed the associated data (AAD) that is
+ * authenticated but not encrypted. It must be called after
+ * qcrypto_cipher_setiv() and before the first encrypt/decrypt call. It is
+ * an error to call this on a mode that is not an AEAD mode.
+ *
+ * Returns: 0 on success, -1 on error
+ */
+int qcrypto_cipher_setaad(QCryptoCipher *cipher,
+                          const uint8_t *aad, size_t len,
+                          Error **errp);
+
+/**
+ * qcrypto_cipher_gettag:
+ * @cipher: the cipher object
+ * @tag: buffer to receive the authentication tag
+ * @len: the length of @tag
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * For AEAD modes such as GCM, read back the authentication tag computed
+ * over the associated data and the message. It must be called after the
+ * encrypt/decrypt operation. It is an error to call this on a mode that is
+ * not an AEAD mode.
+ *
+ * Returns: 0 on success, -1 on error
+ */
+int qcrypto_cipher_gettag(QCryptoCipher *cipher,
+                          uint8_t *tag, size_t len,
+                          Error **errp);
+
 #endif /* QCRYPTO_CIPHER_H */
diff --git a/crypto/cipher.c b/crypto/cipher.c
index 64c2339d1798..1dc912b2178e 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -205,6 +205,37 @@ int qcrypto_cipher_setiv(QCryptoCipher *cipher,
 }
 
 
+int qcrypto_cipher_setaad(QCryptoCipher *cipher,
+                          const uint8_t *aad, size_t len,
+                          Error **errp)
+{
+    const QCryptoCipherDriver *drv = cipher->driver;
+
+    if (!drv->cipher_setaad) {
+        error_setg(errp, "The cipher mode does not support associated data");
+        return -1;
+    }
+
+    return drv->cipher_setaad(cipher, aad, len, errp);
+}
+
+
+int qcrypto_cipher_gettag(QCryptoCipher *cipher,
+                          uint8_t *tag, size_t len,
+                          Error **errp)
+{
+    const QCryptoCipherDriver *drv = cipher->driver;
+
+    if (!drv->cipher_gettag) {
+        error_setg(errp,
+                   "The cipher mode does not produce an authentication tag");
+        return -1;
+    }
+
+    return drv->cipher_gettag(cipher, tag, len, errp);
+}
+
+
 void qcrypto_cipher_free(QCryptoCipher *cipher)
 {
     if (cipher) {
-- 
2.55.0


