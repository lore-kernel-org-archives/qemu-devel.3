Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A7B5CD3431
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 11:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slo8f-0006CV-Lo; Wed, 04 Sep 2024 07:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1slo8Y-0005kU-TS
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 07:25:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1slo8V-0004UH-BD
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 07:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725449118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gWp+iCFBJ9F2d1YyCUo75gPc+JrIQoSE3ebW3zYSASw=;
 b=MOqUdpZ5HXmjQEM/zzsUmIJ2HwVI8AAfUfIISo3bBQdIlu15L6Fp531KAlkm3ee71pI6iK
 2yjfZjZixd5Ltwfpfd/L9a8aHKC9DJZsmqq6FcBtfGV8cr9ohbMx/cVUCl20ySeHiIP+tK
 y1SAklsI/gviYwr53q1+GAfNGQs2dd8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-RA6P3sr1OiqPVB6mMsX1Cw-1; Wed,
 04 Sep 2024 07:18:52 -0400
X-MC-Unique: RA6P3sr1OiqPVB6mMsX1Cw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91BE41956096; Wed,  4 Sep 2024 11:18:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9DE030001AB; Wed,  4 Sep 2024 11:18:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D6E9421E682E; Wed,  4 Sep 2024 13:18:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, andrew@codeconstruct.com.au, andrew@daynix.com,
 arei.gonglei@huawei.com, berrange@redhat.com, berto@igalia.com,
 borntraeger@linux.ibm.com, clg@kaod.org, david@redhat.com, den@openvz.org,
 eblake@redhat.com, eduardo@habkost.net, farman@linux.ibm.com,
 farosas@suse.de, hreitz@redhat.com, idryomov@gmail.com, iii@linux.ibm.com,
 jamin_lin@aspeedtech.com, jasowang@redhat.com, joel@jms.id.au,
 jsnow@redhat.com, kwolf@redhat.com, leetroy@gmail.com,
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 michael.roth@amd.com, mst@redhat.com, mtosatti@redhat.com,
 nsg@linux.ibm.com, pasic@linux.ibm.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, peterx@redhat.com, philmd@linaro.org,
 pizhenwei@bytedance.com, pl@dlhnet.de, richard.henderson@linaro.org,
 stefanha@redhat.com, steven_lee@aspeedtech.com, thuth@redhat.com,
 vsementsov@yandex-team.ru, wangyanan55@huawei.com,
 yuri.benditovich@daynix.com, zhao1.liu@intel.com, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org,
 avihaih@nvidia.com
Subject: [PATCH v2 16/19] qapi/crypto: Rename QCryptoAFAlg to QCryptoAFAlgo
Date: Wed,  4 Sep 2024 13:18:33 +0200
Message-ID: <20240904111836.3273842-17-armbru@redhat.com>
In-Reply-To: <20240904111836.3273842-1-armbru@redhat.com>
References: <20240904111836.3273842-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

For consistency with other types names *Algo.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/afalgpriv.h    | 14 +++++++-------
 crypto/hmacpriv.h     |  2 +-
 crypto/afalg.c        |  8 ++++----
 crypto/cipher-afalg.c | 12 ++++++------
 crypto/hash-afalg.c   | 14 +++++++-------
 5 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/crypto/afalgpriv.h b/crypto/afalgpriv.h
index 5a2393f1b7..3fdcc0f831 100644
--- a/crypto/afalgpriv.h
+++ b/crypto/afalgpriv.h
@@ -30,9 +30,9 @@
 #define ALG_OPTYPE_LEN 4
 #define ALG_MSGIV_LEN(len) (sizeof(struct af_alg_iv) + (len))
 
-typedef struct QCryptoAFAlg QCryptoAFAlg;
+typedef struct QCryptoAFAlgo QCryptoAFAlgo;
 
-struct QCryptoAFAlg {
+struct QCryptoAFAlgo {
     QCryptoCipher base;
 
     int tfmfd;
@@ -46,22 +46,22 @@ struct QCryptoAFAlg {
  * @type: the type of crypto operation
  * @name: the name of crypto operation
  *
- * Allocate a QCryptoAFAlg object and bind itself to
+ * Allocate a QCryptoAFAlgo object and bind itself to
  * a AF_ALG socket.
  *
  * Returns:
- *  a new QCryptoAFAlg object, or NULL in error.
+ *  a new QCryptoAFAlgo object, or NULL in error.
  */
-QCryptoAFAlg *
+QCryptoAFAlgo *
 qcrypto_afalg_comm_alloc(const char *type, const char *name,
                          Error **errp);
 
 /**
  * afalg_comm_free:
- * @afalg: the QCryptoAFAlg object
+ * @afalg: the QCryptoAFAlgo object
  *
  * Free the @afalg.
  */
-void qcrypto_afalg_comm_free(QCryptoAFAlg *afalg);
+void qcrypto_afalg_comm_free(QCryptoAFAlgo *afalg);
 
 #endif
diff --git a/crypto/hmacpriv.h b/crypto/hmacpriv.h
index bd4c498c62..f339596bd9 100644
--- a/crypto/hmacpriv.h
+++ b/crypto/hmacpriv.h
@@ -37,7 +37,7 @@ extern QCryptoHmacDriver qcrypto_hmac_lib_driver;
 
 #include "afalgpriv.h"
 
-QCryptoAFAlg *qcrypto_afalg_hmac_ctx_new(QCryptoHashAlgo alg,
+QCryptoAFAlgo *qcrypto_afalg_hmac_ctx_new(QCryptoHashAlgo alg,
                                          const uint8_t *key, size_t nkey,
                                          Error **errp);
 extern QCryptoHmacDriver qcrypto_hmac_afalg_driver;
diff --git a/crypto/afalg.c b/crypto/afalg.c
index 52a491dbb5..246d0679d4 100644
--- a/crypto/afalg.c
+++ b/crypto/afalg.c
@@ -66,13 +66,13 @@ qcrypto_afalg_socket_bind(const char *type, const char *name,
     return sbind;
 }
 
-QCryptoAFAlg *
+QCryptoAFAlgo *
 qcrypto_afalg_comm_alloc(const char *type, const char *name,
                          Error **errp)
 {
-    QCryptoAFAlg *afalg;
+    QCryptoAFAlgo *afalg;
 
-    afalg = g_new0(QCryptoAFAlg, 1);
+    afalg = g_new0(QCryptoAFAlgo, 1);
     /* initialize crypto API socket */
     afalg->opfd = -1;
     afalg->tfmfd = qcrypto_afalg_socket_bind(type, name, errp);
@@ -93,7 +93,7 @@ error:
     return NULL;
 }
 
-void qcrypto_afalg_comm_free(QCryptoAFAlg *afalg)
+void qcrypto_afalg_comm_free(QCryptoAFAlgo *afalg)
 {
     if (!afalg) {
         return;
diff --git a/crypto/cipher-afalg.c b/crypto/cipher-afalg.c
index c08eb7a39b..4980d419c4 100644
--- a/crypto/cipher-afalg.c
+++ b/crypto/cipher-afalg.c
@@ -65,7 +65,7 @@ qcrypto_afalg_cipher_ctx_new(QCryptoCipherAlgo alg,
                              const uint8_t *key,
                              size_t nkey, Error **errp)
 {
-    QCryptoAFAlg *afalg;
+    QCryptoAFAlgo *afalg;
     size_t expect_niv;
     char *name;
 
@@ -119,7 +119,7 @@ qcrypto_afalg_cipher_setiv(QCryptoCipher *cipher,
                            const uint8_t *iv,
                            size_t niv, Error **errp)
 {
-    QCryptoAFAlg *afalg = container_of(cipher, QCryptoAFAlg, base);
+    QCryptoAFAlgo *afalg = container_of(cipher, QCryptoAFAlgo, base);
     struct af_alg_iv *alg_iv;
     size_t expect_niv;
 
@@ -143,7 +143,7 @@ qcrypto_afalg_cipher_setiv(QCryptoCipher *cipher,
 }
 
 static int
-qcrypto_afalg_cipher_op(QCryptoAFAlg *afalg,
+qcrypto_afalg_cipher_op(QCryptoAFAlgo *afalg,
                         const void *in, void *out,
                         size_t len, bool do_encrypt,
                         Error **errp)
@@ -202,7 +202,7 @@ qcrypto_afalg_cipher_encrypt(QCryptoCipher *cipher,
                              const void *in, void *out,
                              size_t len, Error **errp)
 {
-    QCryptoAFAlg *afalg = container_of(cipher, QCryptoAFAlg, base);
+    QCryptoAFAlgo *afalg = container_of(cipher, QCryptoAFAlgo, base);
 
     return qcrypto_afalg_cipher_op(afalg, in, out, len, true, errp);
 }
@@ -212,14 +212,14 @@ qcrypto_afalg_cipher_decrypt(QCryptoCipher *cipher,
                              const void *in, void *out,
                              size_t len, Error **errp)
 {
-    QCryptoAFAlg *afalg = container_of(cipher, QCryptoAFAlg, base);
+    QCryptoAFAlgo *afalg = container_of(cipher, QCryptoAFAlgo, base);
 
     return qcrypto_afalg_cipher_op(afalg, in, out, len, false, errp);
 }
 
 static void qcrypto_afalg_comm_ctx_free(QCryptoCipher *cipher)
 {
-    QCryptoAFAlg *afalg = container_of(cipher, QCryptoAFAlg, base);
+    QCryptoAFAlgo *afalg = container_of(cipher, QCryptoAFAlgo, base);
 
     qcrypto_afalg_comm_free(afalg);
 }
diff --git a/crypto/hash-afalg.c b/crypto/hash-afalg.c
index 8fc6bd0edf..28ab899b18 100644
--- a/crypto/hash-afalg.c
+++ b/crypto/hash-afalg.c
@@ -64,12 +64,12 @@ qcrypto_afalg_hash_format_name(QCryptoHashAlgo alg,
     return name;
 }
 
-static QCryptoAFAlg *
+static QCryptoAFAlgo *
 qcrypto_afalg_hash_hmac_ctx_new(QCryptoHashAlgo alg,
                                 const uint8_t *key, size_t nkey,
                                 bool is_hmac, Error **errp)
 {
-    QCryptoAFAlg *afalg;
+    QCryptoAFAlgo *afalg;
     char *name;
 
     name = qcrypto_afalg_hash_format_name(alg, is_hmac, errp);
@@ -98,14 +98,14 @@ qcrypto_afalg_hash_hmac_ctx_new(QCryptoHashAlgo alg,
     return afalg;
 }
 
-static QCryptoAFAlg *
+static QCryptoAFAlgo *
 qcrypto_afalg_hash_ctx_new(QCryptoHashAlgo alg,
                            Error **errp)
 {
     return qcrypto_afalg_hash_hmac_ctx_new(alg, NULL, 0, false, errp);
 }
 
-QCryptoAFAlg *
+QCryptoAFAlgo *
 qcrypto_afalg_hmac_ctx_new(QCryptoHashAlgo alg,
                            const uint8_t *key, size_t nkey,
                            Error **errp)
@@ -114,14 +114,14 @@ qcrypto_afalg_hmac_ctx_new(QCryptoHashAlgo alg,
 }
 
 static int
-qcrypto_afalg_hash_hmac_bytesv(QCryptoAFAlg *hmac,
+qcrypto_afalg_hash_hmac_bytesv(QCryptoAFAlgo *hmac,
                                QCryptoHashAlgo alg,
                                const struct iovec *iov,
                                size_t niov, uint8_t **result,
                                size_t *resultlen,
                                Error **errp)
 {
-    QCryptoAFAlg *afalg;
+    QCryptoAFAlgo *afalg;
     struct iovec outv;
     int ret = 0;
     bool is_hmac = (hmac != NULL) ? true : false;
@@ -197,7 +197,7 @@ qcrypto_afalg_hmac_bytesv(QCryptoHmac *hmac,
 
 static void qcrypto_afalg_hmac_ctx_free(QCryptoHmac *hmac)
 {
-    QCryptoAFAlg *afalg;
+    QCryptoAFAlgo *afalg;
 
     afalg = hmac->opaque;
     qcrypto_afalg_comm_free(afalg);
-- 
2.46.0


