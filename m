Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9394D2F7EF
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 06:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1KIf-0005yZ-Ug; Thu, 17 Oct 2024 02:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t1KIe-0005xl-1h
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 02:47:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t1KIc-0006nf-JZ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 02:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729147673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=UROaLmSJ6gYr7ny/maX2lKbFGg3NL1ItaqwotvLIiwM=;
 b=Fghll6uQq8Q8tElpoSqjRw/NeDCGtWJq/PIbdV4kXdWjyyhoINkYg80k/zzjqwnIqW3tPd
 qwjgkzWKY4v88ByQYg1zXr/PN2Y5pYyBKWHdawP+5xE7x88ElsGEWBxFAWzFdlQHAx5kVr
 l7PPUMPBtQQR6kvWbrQ2stGsryOqZuc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-8f8VB3w8OSGW-wQP_imFRg-1; Thu,
 17 Oct 2024 02:47:48 -0400
X-MC-Unique: 8f8VB3w8OSGW-wQP_imFRg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 824C21955EA8; Thu, 17 Oct 2024 06:47:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.150])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45E5219560AD; Thu, 17 Oct 2024 06:47:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 34A2F21E6A28; Thu, 17 Oct 2024 08:47:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, clg@redhat.com, alejandro.zeise@seagate.com,
 peter.maydell@linaro.org
Subject: [PATCH] crypto/hash-afalg: Fix broken build
Date: Thu, 17 Oct 2024 08:47:42 +0200
Message-ID: <20241017064742.2770242-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Fux build broken by semantic conflict with commit
8f525028bc6 (qapi/crypto: Rename QCryptoAFAlg to QCryptoAFAlgo).

Fixes: 90c3dc60735a (crypto/hash-afalg: Implement new hash API)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 crypto/hash-afalg.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/crypto/hash-afalg.c b/crypto/hash-afalg.c
index 06e1e4699c..8c0ce5b520 100644
--- a/crypto/hash-afalg.c
+++ b/crypto/hash-afalg.c
@@ -142,7 +142,7 @@ QCryptoHash *qcrypto_afalg_hash_new(QCryptoHashAlgo alg, Error **errp)
 static
 void qcrypto_afalg_hash_free(QCryptoHash *hash)
 {
-    QCryptoAFAlg *ctx = hash->opaque;
+    QCryptoAFAlgo *ctx = hash->opaque;
 
     if (ctx) {
         qcrypto_afalg_comm_free(ctx);
@@ -159,7 +159,7 @@ void qcrypto_afalg_hash_free(QCryptoHash *hash)
  * be provided to calculate the final hash.
  */
 static
-int qcrypto_afalg_send_to_kernel(QCryptoAFAlg *afalg,
+int qcrypto_afalg_send_to_kernel(QCryptoAFAlgo *afalg,
                                  const struct iovec *iov,
                                  size_t niov,
                                  bool more_data,
@@ -183,7 +183,7 @@ int qcrypto_afalg_send_to_kernel(QCryptoAFAlg *afalg,
 }
 
 static
-int qcrypto_afalg_recv_from_kernel(QCryptoAFAlg *afalg,
+int qcrypto_afalg_recv_from_kernel(QCryptoAFAlgo *afalg,
                                    QCryptoHashAlgo alg,
                                    uint8_t **result,
                                    size_t *result_len,
@@ -222,7 +222,7 @@ int qcrypto_afalg_hash_update(QCryptoHash *hash,
                               size_t niov,
                               Error **errp)
 {
-    return qcrypto_afalg_send_to_kernel((QCryptoAFAlg *) hash->opaque,
+    return qcrypto_afalg_send_to_kernel((QCryptoAFAlgo *) hash->opaque,
                                         iov, niov, true, errp);
 }
 
@@ -232,7 +232,7 @@ int qcrypto_afalg_hash_finalize(QCryptoHash *hash,
                                  size_t *result_len,
                                  Error **errp)
 {
-    return qcrypto_afalg_recv_from_kernel((QCryptoAFAlg *) hash->opaque,
+    return qcrypto_afalg_recv_from_kernel((QCryptoAFAlgo *) hash->opaque,
                                           hash->alg, result, result_len, errp);
 }
 
-- 
2.46.0


