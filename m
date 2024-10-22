Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D777D2C56D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 15:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Gkc-0007qO-2O; Tue, 22 Oct 2024 11:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3GkY-0007n8-Us
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 11:24:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3GkW-00050V-Of
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 11:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729610683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BokGzU5ocSxTIiJ9O/ulSdi5PZJ3j6wdadTlergfOL4=;
 b=Q2PaK1U7EDB6GBA9NqIO4EmeER1xppUWaGIZuhRJ0pQdegSAymxhDRU05fQ3+IJvzHy2L5
 ap50rKwH0OYqK5jRK1dIqExALn5+H6yI6hqw0P4jI6GN4uXIikmx1VJqqTH2iemcQWmWHs
 nJsx6rExtKxM+5TYANk5f1CE1ymdJeA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-BzrTUTlOOZ6ddqLQBzCE7w-1; Tue,
 22 Oct 2024 11:24:40 -0400
X-MC-Unique: BzrTUTlOOZ6ddqLQBzCE7w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 993CE1977016; Tue, 22 Oct 2024 15:24:39 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.59])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 70EFF19560B2; Tue, 22 Oct 2024 15:24:37 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 07/14] crypto/hash-afalg: Fix broken build
Date: Tue, 22 Oct 2024 16:24:08 +0100
Message-ID: <20241022152415.1632556-8-berrange@redhat.com>
In-Reply-To: <20241022152415.1632556-1-berrange@redhat.com>
References: <20241022152415.1632556-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

From: Markus Armbruster <armbru@redhat.com>

Fux build broken by semantic conflict with commit
8f525028bc6 (qapi/crypto: Rename QCryptoAFAlg to QCryptoAFAlgo).

Fixes: 90c3dc60735a (crypto/hash-afalg: Implement new hash API)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
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


