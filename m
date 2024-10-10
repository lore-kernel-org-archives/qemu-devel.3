Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8C7CFC5E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 16:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syvvr-00079g-OZ; Thu, 10 Oct 2024 12:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1syvvq-00079P-F6
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 12:22:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1syvvo-0004SK-JK
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 12:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728577347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gwgRKz6GHLRqIlZYfi0xf71cuEfn8qqoNVSC9DtzHd8=;
 b=JlsQ9TKBzrpa3IZaNnUYoBYQJqnDo0xpZSu4wPfQB0cvKnSf/+jLYd4iqFlrwCQTbhspDB
 WN58Q89yf64GvHVpZmLBJmtSHFpk2Bwbe+B/GKPQCcL57paINEFpe5EZ8ysnUxVQ2KZtvm
 +qiu3r1IgUEUGQf0Mr0eJCOpv6fheVw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-of6Ce9JiPGWsLlfE6-Wtsw-1; Thu,
 10 Oct 2024 12:22:26 -0400
X-MC-Unique: of6Ce9JiPGWsLlfE6-Wtsw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB20919560B8; Thu, 10 Oct 2024 16:22:25 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.110])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 19AD5300019E; Thu, 10 Oct 2024 16:22:22 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kunwu <chentao@kylinos.cn>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alejandro Zeise <alejandro.zeise@seagate.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 14/17] crypto/hash-afalg: Remove old hash API functions
Date: Thu, 10 Oct 2024 17:20:21 +0100
Message-ID: <20241010162024.988284-15-berrange@redhat.com>
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

Removes the old hash API functions in the afalg driver,
and modifies the hmac function to use the new helper functions.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
[ clg: - Checkpatch fixes ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/hash-afalg.c | 60 +++------------------------------------------
 1 file changed, 4 insertions(+), 56 deletions(-)

diff --git a/crypto/hash-afalg.c b/crypto/hash-afalg.c
index 5fbbee288e..06e1e4699c 100644
--- a/crypto/hash-afalg.c
+++ b/crypto/hash-afalg.c
@@ -244,68 +244,17 @@ qcrypto_afalg_hash_hmac_bytesv(QCryptoAFAlgo *hmac,
                                size_t *resultlen,
                                Error **errp)
 {
-    QCryptoAFAlgo *afalg;
-    struct iovec outv;
     int ret = 0;
-    bool is_hmac = (hmac != NULL) ? true : false;
-    const int expect_len = qcrypto_hash_digest_len(alg);
-
-    if (*resultlen == 0) {
-        *resultlen = expect_len;
-        *result = g_new0(uint8_t, *resultlen);
-    } else if (*resultlen != expect_len) {
-        error_setg(errp,
-                   "Result buffer size %zu is not match hash %d",
-                   *resultlen, expect_len);
-        return -1;
-    }
-
-    if (is_hmac) {
-        afalg = hmac;
-    } else {
-        afalg = qcrypto_afalg_hash_ctx_new(alg, errp);
-        if (!afalg) {
-            return -1;
-        }
-    }
-
-    /* send data to kernel's crypto core */
-    ret = iov_send_recv(afalg->opfd, iov, niov,
-                        0, iov_size(iov, niov), true);
-    if (ret < 0) {
-        error_setg_errno(errp, errno, "Send data to afalg-core failed");
-        goto out;
-    }
 
-    /* hash && get result */
-    outv.iov_base = *result;
-    outv.iov_len = *resultlen;
-    ret = iov_send_recv(afalg->opfd, &outv, 1,
-                        0, iov_size(&outv, 1), false);
-    if (ret < 0) {
-        error_setg_errno(errp, errno, "Recv result from afalg-core failed");
-    } else {
-        ret = 0;
+    ret = qcrypto_afalg_send_to_kernel(hmac, iov, niov, false, errp);
+    if (ret == 0) {
+        ret = qcrypto_afalg_recv_from_kernel(hmac, alg, result,
+                                             resultlen, errp);
     }
 
-out:
-    if (!is_hmac) {
-        qcrypto_afalg_comm_free(afalg);
-    }
     return ret;
 }
 
-static int
-qcrypto_afalg_hash_bytesv(QCryptoHashAlgo alg,
-                          const struct iovec *iov,
-                          size_t niov, uint8_t **result,
-                          size_t *resultlen,
-                          Error **errp)
-{
-    return qcrypto_afalg_hash_hmac_bytesv(NULL, alg, iov, niov, result,
-                                          resultlen, errp);
-}
-
 static int
 qcrypto_afalg_hmac_bytesv(QCryptoHmac *hmac,
                           const struct iovec *iov,
@@ -327,7 +276,6 @@ static void qcrypto_afalg_hmac_ctx_free(QCryptoHmac *hmac)
 }
 
 QCryptoHashDriver qcrypto_hash_afalg_driver = {
-    .hash_bytesv = qcrypto_afalg_hash_bytesv,
     .hash_new      = qcrypto_afalg_hash_new,
     .hash_free     = qcrypto_afalg_hash_free,
     .hash_update   = qcrypto_afalg_hash_update,
-- 
2.46.0


