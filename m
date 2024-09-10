Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E3EEDE99A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 16:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so41k-00079U-TX; Tue, 10 Sep 2024 12:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1so41Z-0006nJ-L1
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 12:47:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1so41V-0007Z5-1k
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 12:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725986844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BPgIWJFDXw1X3s4ousUDlkeawfkmplLI8vxddj+tXTs=;
 b=iUe0Swe5wZoDUGlzMrI/07tDvjZ7mxRSJ10G0IlP+NGGd++ehJR/VqGShkh5Uep0XvGR5A
 sZkpDD1gQHRweseEOzzt2YVlIf0IwxJlwxPbxps/H5QWE9lj36WsHB63WPMUuUlyVgAzB6
 7SnFjMPk/PrleiGMaARK2/H9rH3rj/w=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-cSlpnjj7NnSS0oGVLzBofw-1; Tue,
 10 Sep 2024 12:47:21 -0400
X-MC-Unique: cSlpnjj7NnSS0oGVLzBofw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4B2219560A2; Tue, 10 Sep 2024 16:47:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B83D19560AB; Tue, 10 Sep 2024 16:47:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A031121E682C; Tue, 10 Sep 2024 18:47:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 14/19] qapi/crypto: Rename QCryptoAkCipherAlgorithm to *Algo,
 and drop prefix
Date: Tue, 10 Sep 2024 18:47:09 +0200
Message-ID: <20240910164714.1993531-15-armbru@redhat.com>
In-Reply-To: <20240910164714.1993531-1-armbru@redhat.com>
References: <20240910164714.1993531-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

QAPI's 'prefix' feature can make the connection between enumeration
type and its constants less than obvious.  It's best used with
restraint.

QCryptoAkCipherAlgorithm has a 'prefix' that overrides the generated
enumeration constants' prefix to QCRYPTO_AKCIPHER_ALG.

We could simply drop 'prefix', but then the prefix becomes
QCRYPTO_AK_CIPHER_ALGORITHM, which is rather long.

We could additionally rename the type to QCryptoAkCipherAlg, but I
think the abbreviation "alg" is less than clear.

Rename the type to QCryptoAkCipherAlgo instead.  The prefix becomes
QCRYPTO_AK_CIPHER_ALGO.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20240904111836.3273842-15-armbru@redhat.com>
---
 qapi/crypto.json                        |  7 +++----
 crypto/akcipherpriv.h                   |  2 +-
 backends/cryptodev-builtin.c            |  4 ++--
 backends/cryptodev-lkcf.c               |  4 ++--
 crypto/akcipher.c                       |  2 +-
 tests/bench/benchmark-crypto-akcipher.c |  2 +-
 tests/unit/test-crypto-akcipher.c       | 10 +++++-----
 crypto/akcipher-gcrypt.c.inc            |  4 ++--
 crypto/akcipher-nettle.c.inc            |  4 ++--
 9 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/qapi/crypto.json b/qapi/crypto.json
index 3e6a7fb8e5..331d49ebb8 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -586,7 +586,7 @@
             '*sanity-check': 'bool',
             '*passwordid': 'str' } }
 ##
-# @QCryptoAkCipherAlgorithm:
+# @QCryptoAkCipherAlgo:
 #
 # The supported algorithms for asymmetric encryption ciphers
 #
@@ -594,8 +594,7 @@
 #
 # Since: 7.1
 ##
-{ 'enum': 'QCryptoAkCipherAlgorithm',
-  'prefix': 'QCRYPTO_AKCIPHER_ALG',
+{ 'enum': 'QCryptoAkCipherAlgo',
   'data': ['rsa']}
 
 ##
@@ -649,6 +648,6 @@
 # Since: 7.1
 ##
 { 'union': 'QCryptoAkCipherOptions',
-  'base': { 'alg': 'QCryptoAkCipherAlgorithm' },
+  'base': { 'alg': 'QCryptoAkCipherAlgo' },
   'discriminator': 'alg',
   'data': { 'rsa': 'QCryptoAkCipherOptionsRSA' }}
diff --git a/crypto/akcipherpriv.h b/crypto/akcipherpriv.h
index 739f639bcf..3b33e54f08 100644
--- a/crypto/akcipherpriv.h
+++ b/crypto/akcipherpriv.h
@@ -27,7 +27,7 @@
 typedef struct QCryptoAkCipherDriver QCryptoAkCipherDriver;
 
 struct QCryptoAkCipher {
-    QCryptoAkCipherAlgorithm alg;
+    QCryptoAkCipherAlgo alg;
     QCryptoAkCipherKeyType type;
     int max_plaintext_len;
     int max_ciphertext_len;
diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index 2672755661..d8b64091b6 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -64,7 +64,7 @@ static void cryptodev_builtin_init_akcipher(CryptoDevBackend *backend)
 {
     QCryptoAkCipherOptions opts;
 
-    opts.alg = QCRYPTO_AKCIPHER_ALG_RSA;
+    opts.alg = QCRYPTO_AK_CIPHER_ALGO_RSA;
     opts.u.rsa.padding_alg = QCRYPTO_RSA_PADDING_ALG_RAW;
     if (qcrypto_akcipher_supports(&opts)) {
         backend->conf.crypto_services |=
@@ -318,7 +318,7 @@ static int cryptodev_builtin_create_akcipher_session(
 
     switch (sess_info->algo) {
     case VIRTIO_CRYPTO_AKCIPHER_RSA:
-        opts.alg = QCRYPTO_AKCIPHER_ALG_RSA;
+        opts.alg = QCRYPTO_AK_CIPHER_ALGO_RSA;
         if (cryptodev_builtin_set_rsa_options(sess_info->u.rsa.padding_algo,
             sess_info->u.rsa.hash_algo, &opts.u.rsa, errp) != 0) {
             return -1;
diff --git a/backends/cryptodev-lkcf.c b/backends/cryptodev-lkcf.c
index 6e6012e716..6fb6e03d98 100644
--- a/backends/cryptodev-lkcf.c
+++ b/backends/cryptodev-lkcf.c
@@ -133,7 +133,7 @@ static int cryptodev_lkcf_set_op_desc(QCryptoAkCipherOptions *opts,
                                       Error **errp)
 {
     QCryptoAkCipherOptionsRSA *rsa_opt;
-    if (opts->alg != QCRYPTO_AKCIPHER_ALG_RSA) {
+    if (opts->alg != QCRYPTO_AK_CIPHER_ALGO_RSA) {
         error_setg(errp, "Unsupported alg: %u", opts->alg);
         return -1;
     }
@@ -518,7 +518,7 @@ static int cryptodev_lkcf_create_asym_session(
 
     switch (sess_info->algo) {
     case VIRTIO_CRYPTO_AKCIPHER_RSA:
-        sess->akcipher_opts.alg = QCRYPTO_AKCIPHER_ALG_RSA;
+        sess->akcipher_opts.alg = QCRYPTO_AK_CIPHER_ALGO_RSA;
         if (cryptodev_lkcf_set_rsa_opt(
             sess_info->u.rsa.padding_algo, sess_info->u.rsa.hash_algo,
             &sess->akcipher_opts.u.rsa, &local_error) != 0) {
diff --git a/crypto/akcipher.c b/crypto/akcipher.c
index e4bbc6e5f1..0a0576b792 100644
--- a/crypto/akcipher.c
+++ b/crypto/akcipher.c
@@ -115,7 +115,7 @@ int qcrypto_akcipher_export_p8info(const QCryptoAkCipherOptions *opts,
                                    Error **errp)
 {
     switch (opts->alg) {
-    case QCRYPTO_AKCIPHER_ALG_RSA:
+    case QCRYPTO_AK_CIPHER_ALGO_RSA:
         qcrypto_akcipher_rsakey_export_p8info(key, keylen, dst, dst_len);
         return 0;
 
diff --git a/tests/bench/benchmark-crypto-akcipher.c b/tests/bench/benchmark-crypto-akcipher.c
index 0029972385..225e426bde 100644
--- a/tests/bench/benchmark-crypto-akcipher.c
+++ b/tests/bench/benchmark-crypto-akcipher.c
@@ -25,7 +25,7 @@ static QCryptoAkCipher *create_rsa_akcipher(const uint8_t *priv_key,
 {
     QCryptoAkCipherOptions opt;
 
-    opt.alg = QCRYPTO_AKCIPHER_ALG_RSA;
+    opt.alg = QCRYPTO_AK_CIPHER_ALGO_RSA;
     opt.u.rsa.padding_alg = padding;
     opt.u.rsa.hash_alg = hash;
     return qcrypto_akcipher_new(&opt, QCRYPTO_AK_CIPHER_KEY_TYPE_PRIVATE,
diff --git a/tests/unit/test-crypto-akcipher.c b/tests/unit/test-crypto-akcipher.c
index 86501f19ab..7dd86125c2 100644
--- a/tests/unit/test-crypto-akcipher.c
+++ b/tests/unit/test-crypto-akcipher.c
@@ -785,7 +785,7 @@ static QCryptoAkCipherTestData akcipher_test_data[] = {
     {
         .path = "/crypto/akcipher/rsa1024-raw",
         .opt = {
-            .alg = QCRYPTO_AKCIPHER_ALG_RSA,
+            .alg = QCRYPTO_AK_CIPHER_ALGO_RSA,
             .u.rsa = {
                 .padding_alg = QCRYPTO_RSA_PADDING_ALG_RAW,
             },
@@ -805,7 +805,7 @@ static QCryptoAkCipherTestData akcipher_test_data[] = {
     {
         .path = "/crypto/akcipher/rsa1024-pkcs1",
         .opt = {
-            .alg = QCRYPTO_AKCIPHER_ALG_RSA,
+            .alg = QCRYPTO_AK_CIPHER_ALGO_RSA,
             .u.rsa = {
                 .padding_alg = QCRYPTO_RSA_PADDING_ALG_PKCS1,
                 .hash_alg = QCRYPTO_HASH_ALGO_SHA1,
@@ -830,7 +830,7 @@ static QCryptoAkCipherTestData akcipher_test_data[] = {
     {
         .path = "/crypto/akcipher/rsa2048-raw",
         .opt = {
-            .alg = QCRYPTO_AKCIPHER_ALG_RSA,
+            .alg = QCRYPTO_AK_CIPHER_ALGO_RSA,
             .u.rsa = {
                 .padding_alg = QCRYPTO_RSA_PADDING_ALG_RAW,
             },
@@ -850,7 +850,7 @@ static QCryptoAkCipherTestData akcipher_test_data[] = {
     {
         .path = "/crypto/akcipher/rsa2048-pkcs1",
         .opt = {
-            .alg = QCRYPTO_AKCIPHER_ALG_RSA,
+            .alg = QCRYPTO_AK_CIPHER_ALGO_RSA,
             .u.rsa = {
                 .padding_alg = QCRYPTO_RSA_PADDING_ALG_PKCS1,
                 .hash_alg = QCRYPTO_HASH_ALGO_SHA1,
@@ -944,7 +944,7 @@ static void test_rsakey(const void *opaque)
 {
     const QCryptoRSAKeyTestData *data = (const QCryptoRSAKeyTestData *)opaque;
     QCryptoAkCipherOptions opt = {
-        .alg = QCRYPTO_AKCIPHER_ALG_RSA,
+        .alg = QCRYPTO_AK_CIPHER_ALGO_RSA,
         .u.rsa = {
             .padding_alg = QCRYPTO_RSA_PADDING_ALG_PKCS1,
             .hash_alg = QCRYPTO_HASH_ALGO_SHA1,
diff --git a/crypto/akcipher-gcrypt.c.inc b/crypto/akcipher-gcrypt.c.inc
index 2c81de97de..8f1c2b8143 100644
--- a/crypto/akcipher-gcrypt.c.inc
+++ b/crypto/akcipher-gcrypt.c.inc
@@ -59,7 +59,7 @@ QCryptoAkCipher *qcrypto_akcipher_new(const QCryptoAkCipherOptions *opts,
                                       Error **errp)
 {
     switch (opts->alg) {
-    case QCRYPTO_AKCIPHER_ALG_RSA:
+    case QCRYPTO_AK_CIPHER_ALGO_RSA:
         return (QCryptoAkCipher *)qcrypto_gcrypt_rsa_new(
             &opts->u.rsa, type, key, keylen, errp);
 
@@ -568,7 +568,7 @@ error:
 bool qcrypto_akcipher_supports(QCryptoAkCipherOptions *opts)
 {
     switch (opts->alg) {
-    case QCRYPTO_AKCIPHER_ALG_RSA:
+    case QCRYPTO_AK_CIPHER_ALGO_RSA:
         switch (opts->u.rsa.padding_alg) {
         case QCRYPTO_RSA_PADDING_ALG_RAW:
             return true;
diff --git a/crypto/akcipher-nettle.c.inc b/crypto/akcipher-nettle.c.inc
index 37a579fbd9..21f27f8286 100644
--- a/crypto/akcipher-nettle.c.inc
+++ b/crypto/akcipher-nettle.c.inc
@@ -61,7 +61,7 @@ QCryptoAkCipher *qcrypto_akcipher_new(const QCryptoAkCipherOptions *opts,
                                       Error **errp)
 {
     switch (opts->alg) {
-    case QCRYPTO_AKCIPHER_ALG_RSA:
+    case QCRYPTO_AK_CIPHER_ALGO_RSA:
         return qcrypto_nettle_rsa_new(&opts->u.rsa, type, key, keylen, errp);
 
     default:
@@ -425,7 +425,7 @@ error:
 bool qcrypto_akcipher_supports(QCryptoAkCipherOptions *opts)
 {
     switch (opts->alg) {
-    case QCRYPTO_AKCIPHER_ALG_RSA:
+    case QCRYPTO_AK_CIPHER_ALGO_RSA:
         switch (opts->u.rsa.padding_alg) {
         case QCRYPTO_RSA_PADDING_ALG_PKCS1:
             switch (opts->u.rsa.hash_alg) {
-- 
2.46.0


