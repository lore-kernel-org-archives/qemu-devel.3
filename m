Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1D2CED274
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 07:58:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy56g-0008F2-DA; Tue, 08 Oct 2024 03:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sy56e-0008EP-Kz
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 03:58:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sy56d-0005eE-2i
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 03:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728374284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S4Lu4CvXepcnqDYYoSSfGxHOKQsYCMn2p7GVV7BxCVQ=;
 b=enJMJwwB7o3/w2zceK1wX1vVrwgCbkfPoTqqfwFjiwakzRnhJO1TIqvW9K+XxoEC2yjERf
 mjpa3YemOJSliqqmUrK2t47PWEaAMUxOCJ42N//7NfSELJtK1Sv4KkDOkXGTH/sUzxg6J/
 RYlMxQd+woglj5APltbpZeh7nEZ/YpU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-MKAT5ZJ-Oj69n2ZXFLr2KQ-1; Tue,
 08 Oct 2024 03:58:01 -0400
X-MC-Unique: MKAT5ZJ-Oj69n2ZXFLr2KQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C55AE19560A7; Tue,  8 Oct 2024 07:57:59 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.61])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 31276300018D; Tue,  8 Oct 2024 07:57:56 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	berrange@redhat.com
Cc: kris.conklin@seagate.com, jonathan.henze@seagate.com,
 evan.burgess@seagate.com, peter.maydell@linaro.org,
 Alejandro Zeise <alejandro.zeise@seagate.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v5 11/16] crypto/hash-gcrypt: Remove old hash API functions
Date: Tue,  8 Oct 2024 09:57:18 +0200
Message-ID: <20241008075724.2772149-12-clg@redhat.com>
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

Removes old hash implementation in the gcrypt hash driver.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
[ clg: - Fixed spelling in commit log ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 crypto/hash-gcrypt.c | 67 --------------------------------------------
 1 file changed, 67 deletions(-)

diff --git a/crypto/hash-gcrypt.c b/crypto/hash-gcrypt.c
index cb2cb37f25ed..ccc3cce3f8ab 100644
--- a/crypto/hash-gcrypt.c
+++ b/crypto/hash-gcrypt.c
@@ -45,72 +45,6 @@ gboolean qcrypto_hash_supports(QCryptoHashAlgo alg)
     return false;
 }
 
-
-static int
-qcrypto_gcrypt_hash_bytesv(QCryptoHashAlgo alg,
-                           const struct iovec *iov,
-                           size_t niov,
-                           uint8_t **result,
-                           size_t *resultlen,
-                           Error **errp)
-{
-    int i, ret;
-    gcry_md_hd_t md;
-    unsigned char *digest;
-
-    if (!qcrypto_hash_supports(alg)) {
-        error_setg(errp,
-                   "Unknown hash algorithm %d",
-                   alg);
-        return -1;
-    }
-
-    ret = gcry_md_open(&md, qcrypto_hash_alg_map[alg], 0);
-
-    if (ret < 0) {
-        error_setg(errp,
-                   "Unable to initialize hash algorithm: %s",
-                   gcry_strerror(ret));
-        return -1;
-    }
-
-    for (i = 0; i < niov; i++) {
-        gcry_md_write(md, iov[i].iov_base, iov[i].iov_len);
-    }
-
-    ret = gcry_md_get_algo_dlen(qcrypto_hash_alg_map[alg]);
-    if (ret <= 0) {
-        error_setg(errp,
-                   "Unable to get hash length: %s",
-                   gcry_strerror(ret));
-        goto error;
-    }
-    if (*resultlen == 0) {
-        *resultlen = ret;
-        *result = g_new0(uint8_t, *resultlen);
-    } else if (*resultlen != ret) {
-        error_setg(errp,
-                   "Result buffer size %zu is smaller than hash %d",
-                   *resultlen, ret);
-        goto error;
-    }
-
-    digest = gcry_md_read(md, 0);
-    if (!digest) {
-        error_setg(errp,
-                   "No digest produced");
-        goto error;
-    }
-    memcpy(*result, digest, *resultlen);
-
-    gcry_md_close(md);
-    return 0;
-
- error:
-    gcry_md_close(md);
-    return -1;
-}
-
 static
 QCryptoHash *qcrypto_gcrypt_hash_new(QCryptoHashAlgo alg, Error **errp)
 {
@@ -187,7 +121,6 @@ int qcrypto_gcrypt_hash_finalize(QCryptoHash *hash,
 }
 
 QCryptoHashDriver qcrypto_hash_lib_driver = {
-    .hash_bytesv = qcrypto_gcrypt_hash_bytesv,
     .hash_new      = qcrypto_gcrypt_hash_new,
     .hash_update   = qcrypto_gcrypt_hash_update,
     .hash_finalize = qcrypto_gcrypt_hash_finalize,
-- 
2.46.2


