Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3E8ECE57A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 14:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snfD6-0001mP-Mg; Mon, 09 Sep 2024 10:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1snfCy-0001YH-Mb
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:17:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1snfCw-0003OV-9j
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725891453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cx43kZJQxvli9IxV/D9S1CP+gks4gZY+IOVuSazDV2k=;
 b=dnfTnanPIKnmjcPr++8zpq/QetAdLNKpHcl9jaebaz4vpwJYzVKsfkidfqhq8aUhvuI/KE
 2c493AJzOuaH1FLGSXeTAG9WqkaD8k3GqOq5SxiZPO3XZ+jvOP39EYx13pwR36lywGipnp
 fvqSCr93xMe3jm/TbVKXROjCrq41Hg4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-kzcwK9LPPwuO_h1VFEUxHg-1; Mon,
 09 Sep 2024 10:17:29 -0400
X-MC-Unique: kzcwK9LPPwuO_h1VFEUxHg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4BC121955EA2; Mon,  9 Sep 2024 14:17:28 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.212])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A46981955F45; Mon,  9 Sep 2024 14:17:23 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hyman Huang <yong.huang@smartx.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Dorjoy Chowdhury <dorjoychy111@gmail.com>
Subject: [PULL 08/10] crypto: Define macros for hash algorithm digest lengths
Date: Mon,  9 Sep 2024 15:16:33 +0100
Message-ID: <20240909141635.1459701-9-berrange@redhat.com>
In-Reply-To: <20240909141635.1459701-1-berrange@redhat.com>
References: <20240909141635.1459701-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

From: Dorjoy Chowdhury <dorjoychy111@gmail.com>

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/hash.c         | 14 +++++++-------
 include/crypto/hash.h |  8 ++++++++
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/crypto/hash.c b/crypto/hash.c
index b0f8228bdc..8087f5dae6 100644
--- a/crypto/hash.c
+++ b/crypto/hash.c
@@ -23,13 +23,13 @@
 #include "hashpriv.h"
 
 static size_t qcrypto_hash_alg_size[QCRYPTO_HASH_ALG__MAX] = {
-    [QCRYPTO_HASH_ALG_MD5] = 16,
-    [QCRYPTO_HASH_ALG_SHA1] = 20,
-    [QCRYPTO_HASH_ALG_SHA224] = 28,
-    [QCRYPTO_HASH_ALG_SHA256] = 32,
-    [QCRYPTO_HASH_ALG_SHA384] = 48,
-    [QCRYPTO_HASH_ALG_SHA512] = 64,
-    [QCRYPTO_HASH_ALG_RIPEMD160] = 20,
+    [QCRYPTO_HASH_ALG_MD5]       = QCRYPTO_HASH_DIGEST_LEN_MD5,
+    [QCRYPTO_HASH_ALG_SHA1]      = QCRYPTO_HASH_DIGEST_LEN_SHA1,
+    [QCRYPTO_HASH_ALG_SHA224]    = QCRYPTO_HASH_DIGEST_LEN_SHA224,
+    [QCRYPTO_HASH_ALG_SHA256]    = QCRYPTO_HASH_DIGEST_LEN_SHA256,
+    [QCRYPTO_HASH_ALG_SHA384]    = QCRYPTO_HASH_DIGEST_LEN_SHA384,
+    [QCRYPTO_HASH_ALG_SHA512]    = QCRYPTO_HASH_DIGEST_LEN_SHA512,
+    [QCRYPTO_HASH_ALG_RIPEMD160] = QCRYPTO_HASH_DIGEST_LEN_RIPEMD160,
 };
 
 size_t qcrypto_hash_digest_len(QCryptoHashAlgorithm alg)
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index 54d87aa2a1..a113cc3b04 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -23,6 +23,14 @@
 
 #include "qapi/qapi-types-crypto.h"
 
+#define QCRYPTO_HASH_DIGEST_LEN_MD5       16
+#define QCRYPTO_HASH_DIGEST_LEN_SHA1      20
+#define QCRYPTO_HASH_DIGEST_LEN_SHA224    28
+#define QCRYPTO_HASH_DIGEST_LEN_SHA256    32
+#define QCRYPTO_HASH_DIGEST_LEN_SHA384    48
+#define QCRYPTO_HASH_DIGEST_LEN_SHA512    64
+#define QCRYPTO_HASH_DIGEST_LEN_RIPEMD160 20
+
 /* See also "QCryptoHashAlgorithm" defined in qapi/crypto.json */
 
 /**
-- 
2.45.2


