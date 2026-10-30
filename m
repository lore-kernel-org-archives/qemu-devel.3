Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE300606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N0aJW63N
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoAm-0002rZ-F3; Fri, 30 Oct 2026 11:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMo9d-00025H-E6
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:04:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMo9a-0007Fz-C4
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793372665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ahEu6P9+WQGtrcigda+rkZcqqXsaiIlqMiVEDQP1EQ=;
 b=N0aJW63N349F0zbOvAwrprjZg9FjWDYMFLdWNGSDcbIPKia7/+e7UNlsHqdtTfuuixRIPa
 IcuRTVlPXOY/e80G47hWGLzwzvslXtF/igWRa5puDx64ZA/4xMTPLTTcwUnNzMYop+ex5o
 5zWO72FcpBcdaApBn4qgutoS2CcUxec=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-xllzEd10MwK10aACsMGABA-1; Fri,
 30 Oct 2026 11:04:19 -0400
X-MC-Unique: xllzEd10MwK10aACsMGABA-1
X-Mimecast-MFC-AGG-ID: xllzEd10MwK10aACsMGABA_1793372659
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C069B18009C4
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:04:18 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0D4841956088; Fri, 30 Oct 2026 15:04:17 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 3/3] crypto: add preventative measures wrt uninitialized hash
 info
Date: Fri, 30 Oct 2026 15:04:13 +0000
Message-ID: <20261030150413.2999685-4-berrange@redhat.com>
In-Reply-To: <20261030150413.2999685-1-berrange@redhat.com>
References: <20261030150413.2999685-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Several static arrays can create incorrect behaviour if a new hash
algorithm is added without them being explicitly initialized. Be
more robust against this problem by using a static assert for the
array size, instead of predeclaring the array size.

When querying the arrays also add further sanity checks for missing
initializers.

Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/4786
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/hash-glib.c | 18 ++++++++++++++++--
 crypto/hash.c      | 12 +++++++++++-
 crypto/hmac-glib.c | 18 ++++++++++++++++--
 3 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/crypto/hash-glib.c b/crypto/hash-glib.c
index 39040f1856e..d83caec8cab 100644
--- a/crypto/hash-glib.c
+++ b/crypto/hash-glib.c
@@ -25,7 +25,7 @@
 #include "hashpriv.h"
 
 
-static int qcrypto_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
+static int qcrypto_hash_alg_map[] = {
     [QCRYPTO_HASH_ALGO_MD5] = G_CHECKSUM_MD5,
     [QCRYPTO_HASH_ALGO_SHA1] = G_CHECKSUM_SHA1,
     [QCRYPTO_HASH_ALGO_SHA224] = -1,
@@ -35,11 +35,25 @@ static int qcrypto_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
     [QCRYPTO_HASH_ALGO_RIPEMD160] = -1,
     [QCRYPTO_HASH_ALGO_SM3] = -1,
 };
+/*
+ * Prefer the assert over declaring the array with
+ * size QCRYPTO_HASH_ALGO__MAX so we get better
+ * detection of uninitialize elements.
+ */
+G_STATIC_ASSERT(G_N_ELEMENTS(qcrypto_hash_alg_map) ==
+                QCRYPTO_HASH_ALGO__MAX);
 
 gboolean qcrypto_hash_supports(QCryptoHashAlgo alg)
 {
+    /*
+     * The default static initializer value of 0
+     * matches G_CHECKSUM_MD5, so protect against
+     * accidentally uninitialized fields
+     */
     if (alg < G_N_ELEMENTS(qcrypto_hash_alg_map) &&
-        qcrypto_hash_alg_map[alg] != -1) {
+        qcrypto_hash_alg_map[alg] != -1 &&
+        (alg == QCRYPTO_HASH_ALGO_MD5 ||
+         qcrypto_hash_alg_map[alg] != G_CHECKSUM_MD5)) {
         return true;
     }
     return false;
diff --git a/crypto/hash.c b/crypto/hash.c
index 42a0a8ec56f..e966fc1a633 100644
--- a/crypto/hash.c
+++ b/crypto/hash.c
@@ -25,7 +25,7 @@
 #include "crypto/hash.h"
 #include "hashpriv.h"
 
-static size_t qcrypto_hash_alg_size[QCRYPTO_HASH_ALGO__MAX] = {
+static size_t qcrypto_hash_alg_size[] = {
     [QCRYPTO_HASH_ALGO_MD5]       = QCRYPTO_HASH_DIGEST_LEN_MD5,
     [QCRYPTO_HASH_ALGO_SHA1]      = QCRYPTO_HASH_DIGEST_LEN_SHA1,
     [QCRYPTO_HASH_ALGO_SHA224]    = QCRYPTO_HASH_DIGEST_LEN_SHA224,
@@ -35,10 +35,20 @@ static size_t qcrypto_hash_alg_size[QCRYPTO_HASH_ALGO__MAX] = {
     [QCRYPTO_HASH_ALGO_RIPEMD160] = QCRYPTO_HASH_DIGEST_LEN_RIPEMD160,
     [QCRYPTO_HASH_ALGO_SM3]       = QCRYPTO_HASH_DIGEST_LEN_SM3,
 };
+/*
+ * Prefer the assert over declaring the array with
+ * size QCRYPTO_HASH_ALGO__MAX so we get better
+ * detection of uninitialized elements. We don't
+ * want to ever return digest lengths of zero, as
+ * that risks a div-by-zero in callers.
+ */
+G_STATIC_ASSERT(G_N_ELEMENTS(qcrypto_hash_alg_size) ==
+                QCRYPTO_HASH_ALGO__MAX);
 
 size_t qcrypto_hash_digest_len(QCryptoHashAlgo alg)
 {
     assert(alg < G_N_ELEMENTS(qcrypto_hash_alg_size));
+    assert(qcrypto_hash_alg_size[alg] != 0);
     return qcrypto_hash_alg_size[alg];
 }
 
diff --git a/crypto/hmac-glib.c b/crypto/hmac-glib.c
index 8f652c5064e..34090444083 100644
--- a/crypto/hmac-glib.c
+++ b/crypto/hmac-glib.c
@@ -17,7 +17,7 @@
 #include "crypto/hmac.h"
 #include "hmacpriv.h"
 
-static int qcrypto_hmac_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
+static int qcrypto_hmac_alg_map[] = {
     [QCRYPTO_HASH_ALGO_MD5] = G_CHECKSUM_MD5,
     [QCRYPTO_HASH_ALGO_SHA1] = G_CHECKSUM_SHA1,
     [QCRYPTO_HASH_ALGO_SHA256] = G_CHECKSUM_SHA256,
@@ -27,6 +27,13 @@ static int qcrypto_hmac_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
     [QCRYPTO_HASH_ALGO_RIPEMD160] = -1,
     [QCRYPTO_HASH_ALGO_SM3] = -1,
 };
+/*
+ * Prefer the assert over declaring the array with
+ * size QCRYPTO_HASH_ALGO__MAX so we get better
+ * detection of uninitialize elements.
+ */
+G_STATIC_ASSERT(G_N_ELEMENTS(qcrypto_hmac_alg_map) ==
+                QCRYPTO_HASH_ALGO__MAX);
 
 typedef struct QCryptoHmacGlib QCryptoHmacGlib;
 struct QCryptoHmacGlib {
@@ -35,8 +42,15 @@ struct QCryptoHmacGlib {
 
 bool qcrypto_hmac_supports(QCryptoHashAlgo alg)
 {
+    /*
+     * The default static initializer value of 0
+     * matches G_CHECKSUM_MD5, so protect against
+     * accidentally uninitialized fields
+     */
     if (alg < G_N_ELEMENTS(qcrypto_hmac_alg_map) &&
-        qcrypto_hmac_alg_map[alg] != -1) {
+        qcrypto_hmac_alg_map[alg] != -1 &&
+        (alg == QCRYPTO_HASH_ALGO_MD5 ||
+         qcrypto_hmac_alg_map[alg] != G_CHECKSUM_MD5)) {
         return true;
     }
 
-- 
2.56.0


