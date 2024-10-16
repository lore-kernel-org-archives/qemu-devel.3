Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF21D1AD42
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 10:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t118o-0000Lc-Hv; Wed, 16 Oct 2024 06:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t118m-0000Kv-Nw
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 06:20:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t118l-0002pI-69
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 06:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729074022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/77uZabxQYbI+7iElg+IwhYCsa5tCIzuO6b18O5VOLc=;
 b=gz2a4VKnbCBk31HqH/rA7sF4pcp8UyhfUJgdMIaMeaNfMa/8xDHizNR36W9Kj3W+UrYcx8
 ZPLJUcOKixIbTDCohXgbP8aRYwDAjeDl1KQ32W7lC1sQ6uM4LU8DE/3jIPZa0qZwXKBVqx
 mcPnB/J3Ged9QvdRkN9Kx2wuhvksh/Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-VbpXEhBwNMG7mvogCtXhDA-1; Wed,
 16 Oct 2024 06:20:20 -0400
X-MC-Unique: VbpXEhBwNMG7mvogCtXhDA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 599361954B18; Wed, 16 Oct 2024 10:20:17 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.95])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F1C461956056; Wed, 16 Oct 2024 10:20:15 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Dorjoy Chowdhury <dorjoychy111@gmail.com>
Subject: [PATCH v2 3/3] include/crypto: clarify @result/@result_len for
 hash/hmac APIs
Date: Wed, 16 Oct 2024 11:20:06 +0100
Message-ID: <20241016102006.480218-4-berrange@redhat.com>
In-Reply-To: <20241016102006.480218-1-berrange@redhat.com>
References: <20241016102006.480218-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The @result parameter passed to hash/hmac APIs may either contain
a pre-allocated buffer, or a buffer can be allocated on the fly.
Clarify these two different usage models in the API docs.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/crypto/hash.h | 30 +++++++++++++++++++++++-------
 include/crypto/hmac.h | 17 ++++++++++++-----
 2 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index b791ca92a4..317bf9ecde 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -98,11 +98,18 @@ int qcrypto_hash_bytesv(QCryptoHashAlgo alg,
  * @errp: pointer to a NULL-initialized error object
  *
  * Computes the hash across all the memory region
- * @buf of length @len. The @result pointer will be
- * filled with raw bytes representing the computed
- * hash, which will have length @resultlen. The
- * memory pointer in @result must be released
- * with a call to g_free() when no longer required.
+ * @buf of length @len.
+ *
+ * If @result_len is set to a non-zero value by the caller, then
+ * @result must hold a pointer that is @result_len in size, and
+ * @result_len match the size of the hash output. The digest will
+ * be written into @result.
+ *
+ * If @result_len is set to zero, then this function will allocate
+ * a buffer to hold the hash output digest, storing a pointer to
+ * the buffer in @result, and setting @result_len to its size.
+ * The memory referenced in @result must be released with a call
+ * to g_free() when no longer required by the caller.
  *
  * Returns: 0 on success, -1 on error
  */
@@ -215,8 +222,17 @@ int qcrypto_hash_finalize_base64(QCryptoHash *hash,
  *
  * Computes the hash from the given hash object. Hash object
  * is expected to have it's data updated from the qcrypto_hash_update function.
- * The memory pointer in @result must be released with a call to g_free()
- * when no longer required.
+ *
+ * If @result_len is set to a non-zero value by the caller, then
+ * @result must hold a pointer that is @result_len in size, and
+ * @result_len match the size of the hash output. The digest will
+ * be written into @result.
+ *
+ * If @result_len is set to zero, then this function will allocate
+ * a buffer to hold the hash output digest, storing a pointer to
+ * the buffer in @result, and setting @result_len to its size.
+ * The memory referenced in @result must be released with a call
+ * to g_free() when no longer required by the caller.
  *
  * Returns: 0 on success, -1 on error
  */
diff --git a/include/crypto/hmac.h b/include/crypto/hmac.h
index c69a0dfab3..aaff95f7db 100644
--- a/include/crypto/hmac.h
+++ b/include/crypto/hmac.h
@@ -103,11 +103,18 @@ int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
  * @errp: pointer to a NULL-initialized error object
  *
  * Computes the hmac across all the memory region
- * @buf of length @len. The @result pointer will be
- * filled with raw bytes representing the computed
- * hmac, which will have length @resultlen. The
- * memory pointer in @result must be released
- * with a call to g_free() when no longer required.
+ * @buf of length @len.
+ *
+ * If @result_len is set to a non-zero value by the caller, then
+ * @result must hold a pointer that is @result_len in size, and
+ * @result_len match the size of the hash output. The digest will
+ * be written into @result.
+ *
+ * If @result_len is set to zero, then this function will allocate
+ * a buffer to hold the hash output digest, storing a pointer to
+ * the buffer in @result, and setting @result_len to its size.
+ * The memory referenced in @result must be released with a call
+ * to g_free() when no longer required by the caller.
  *
  * Returns:
  *  0 on success, -1 on error
-- 
2.46.0


