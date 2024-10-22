Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE67D2C56A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 15:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Gkb-0007pa-LE; Tue, 22 Oct 2024 11:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3GkV-0007iX-5I
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 11:24:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3GkT-000500-0f
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 11:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729610680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fCIjd5XoRAWklxpBwC1ESO697qS5sCLzfEo5E37CLA4=;
 b=EJNIdQGRXPP1HNrt+clHZJCcUTAZKVtfBn0W1jwRJzyZq4Z/aK2wsHjh5eJ4UHAxLLRPfX
 QYRPZYY5s7ylaFhYTEq/Ulcnij6PSHTofQh+K0je67QbV+5BzPrHbCL6B6v/t50f8F0GfD
 9YH32UbhqwZDNd6f+ciOHgrVlnXd06E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-PVTZbQKBOumCMi9E6WTfhA-1; Tue,
 22 Oct 2024 11:24:38 -0400
X-MC-Unique: PVTZbQKBOumCMi9E6WTfhA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3F65197700C; Tue, 22 Oct 2024 15:24:36 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.59])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7001B19560A2; Tue, 22 Oct 2024 15:24:34 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dorjoy Chowdhury <dorjoychy111@gmail.com>
Subject: [PULL 06/14] include/crypto: clarify @result/@result_len for
 hash/hmac APIs
Date: Tue, 22 Oct 2024 16:24:07 +0100
Message-ID: <20241022152415.1632556-7-berrange@redhat.com>
In-Reply-To: <20241022152415.1632556-1-berrange@redhat.com>
References: <20241022152415.1632556-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
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

The @result parameter passed to hash/hmac APIs may either contain
a pre-allocated buffer, or a buffer can be allocated on the fly.
Clarify these two different usage models in the API docs.

Reviewed-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/crypto/hash.h | 47 ++++++++++++++++++++++++++++++++-----------
 include/crypto/hmac.h | 34 ++++++++++++++++++++++---------
 2 files changed, 59 insertions(+), 22 deletions(-)

diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index b791ca92a4..712cac79ee 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -73,11 +73,18 @@ size_t qcrypto_hash_digest_len(QCryptoHashAlgo alg);
  * @errp: pointer to a NULL-initialized error object
  *
  * Computes the hash across all the memory regions
- * present in @iov. The @result pointer will be
- * filled with raw bytes representing the computed
- * hash, which will have length @resultlen. The
- * memory pointer in @result must be released
- * with a call to g_free() when no longer required.
+ * present in @iov.
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
@@ -98,11 +105,18 @@ int qcrypto_hash_bytesv(QCryptoHashAlgo alg,
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
@@ -215,8 +229,17 @@ int qcrypto_hash_finalize_base64(QCryptoHash *hash,
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
index c69a0dfab3..da8a1e3ceb 100644
--- a/include/crypto/hmac.h
+++ b/include/crypto/hmac.h
@@ -77,11 +77,18 @@ G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoHmac, qcrypto_hmac_free)
  * @errp: pointer to a NULL-initialized error object
  *
  * Computes the hmac across all the memory regions
- * present in @iov. The @result pointer will be
- * filled with raw bytes representing the computed
- * hmac, which will have length @resultlen. The
- * memory pointer in @result must be released
- * with a call to g_free() when no longer required.
+ * present in @iov.
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
@@ -103,11 +110,18 @@ int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
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


