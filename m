Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48857D1AD41
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 10:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t118q-0000Mj-MO; Wed, 16 Oct 2024 06:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t118o-0000LC-3y
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 06:20:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t118l-0002ou-6A
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 06:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729074022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ENNrYL48iopybgO3xqkXmLRGJM0WPuBI+yVnGuIHfCE=;
 b=JMw3roCJ7iYIIkK0vIXgm4BgTe0F0jpeiLRvb2ggaQdVeQN4LXKzVFC4m351fALL1uNSZk
 Wx0fIo1lgOLaliHQekz3FgoWlYfK/UimE4orYdrdVBr50+YryHXmMIM4RtTG6vFbPKNXqv
 bCgJMQujXu/BeH4ImcbLhLdlO1B/jmI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-EKvklxcpO1uBPYe6PD3gMA-1; Wed,
 16 Oct 2024 06:20:21 -0400
X-MC-Unique: EKvklxcpO1uBPYe6PD3gMA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EF851955BCE; Wed, 16 Oct 2024 10:20:15 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.95])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 268D51955E7B; Wed, 16 Oct 2024 10:20:12 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Dorjoy Chowdhury <dorjoychy111@gmail.com>
Subject: [PATCH v2 2/3] tests: correctly validate result buffer in hash/hmac
 tests
Date: Wed, 16 Oct 2024 11:20:05 +0100
Message-ID: <20241016102006.480218-3-berrange@redhat.com>
In-Reply-To: <20241016102006.480218-1-berrange@redhat.com>
References: <20241016102006.480218-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

Validate that the pre-allocated buffer pointer was not overwritten
by the hash/hmac APIs.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/unit/test-crypto-hash.c | 7 ++++---
 tests/unit/test-crypto-hmac.c | 6 ++++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/tests/unit/test-crypto-hash.c b/tests/unit/test-crypto-hash.c
index e5829ca766..76c4699c15 100644
--- a/tests/unit/test-crypto-hash.c
+++ b/tests/unit/test-crypto-hash.c
@@ -123,7 +123,7 @@ static void test_hash_prealloc(void)
     size_t i;
 
     for (i = 0; i < G_N_ELEMENTS(expected_outputs) ; i++) {
-        uint8_t *result;
+        uint8_t *result, *origresult;
         size_t resultlen;
         int ret;
         size_t j;
@@ -133,7 +133,7 @@ static void test_hash_prealloc(void)
         }
 
         resultlen = expected_lens[i];
-        result = g_new0(uint8_t, resultlen);
+        origresult = result = g_new0(uint8_t, resultlen);
 
         ret = qcrypto_hash_bytes(i,
                                  INPUT_TEXT,
@@ -142,7 +142,8 @@ static void test_hash_prealloc(void)
                                  &resultlen,
                                  &error_fatal);
         g_assert(ret == 0);
-
+        /* Validate that our pre-allocated pointer was not replaced */
+        g_assert(result == origresult);
         g_assert(resultlen == expected_lens[i]);
         for (j = 0; j < resultlen; j++) {
             g_assert(expected_outputs[i][j * 2] == hex[(result[j] >> 4) & 0xf]);
diff --git a/tests/unit/test-crypto-hmac.c b/tests/unit/test-crypto-hmac.c
index 3fa50f24bb..cdb8774443 100644
--- a/tests/unit/test-crypto-hmac.c
+++ b/tests/unit/test-crypto-hmac.c
@@ -126,7 +126,7 @@ static void test_hmac_prealloc(void)
     for (i = 0; i < G_N_ELEMENTS(test_data); i++) {
         QCryptoHmacTestData *data = &test_data[i];
         QCryptoHmac *hmac = NULL;
-        uint8_t *result = NULL;
+        uint8_t *result = NULL, *origresult = NULL;
         size_t resultlen = 0;
         const char *exp_output = NULL;
         int ret;
@@ -139,7 +139,7 @@ static void test_hmac_prealloc(void)
         exp_output = data->hex_digest;
 
         resultlen = strlen(exp_output) / 2;
-        result = g_new0(uint8_t, resultlen);
+        origresult = result = g_new0(uint8_t, resultlen);
 
         hmac = qcrypto_hmac_new(data->alg, (const uint8_t *)KEY,
                                 strlen(KEY), &error_fatal);
@@ -149,6 +149,8 @@ static void test_hmac_prealloc(void)
                                  strlen(INPUT_TEXT), &result,
                                  &resultlen, &error_fatal);
         g_assert(ret == 0);
+        /* Validate that our pre-allocated pointer was not replaced */
+        g_assert(result == origresult);
 
         exp_output = data->hex_digest;
         for (j = 0; j < resultlen; j++) {
-- 
2.46.0


