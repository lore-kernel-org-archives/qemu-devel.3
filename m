Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0002C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 14:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEU5L-0002CY-L2; Mon, 12 May 2025 10:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEU5K-0002C0-An
 for qemu-devel@nongnu.org; Mon, 12 May 2025 10:24:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEU5H-0006YB-Hg
 for qemu-devel@nongnu.org; Mon, 12 May 2025 10:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747059886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4sFQWhoUgIvwKA3xg8VRd0TcxBEG9HiqRu9KlTxjDy4=;
 b=P1B6BS7xy2TjKgp9AF4UuhGPaLg9XyRinXA9GJYtvzfki8i/c4M3T5f8r1wzI+W3ErI6x6
 KmPmnEk2yYWjn3SyNdT1HpgzExrPjJmKUQLedh2b+VJEVTgez7SH0r3mHuOQEUky6TYXT1
 cLJSrHfIxA0nbIU5Jn+1NQyNu5Dg4J0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-LA23bzdsOz2LMH2BizX19g-1; Mon,
 12 May 2025 10:24:45 -0400
X-MC-Unique: LA23bzdsOz2LMH2BizX19g-1
X-Mimecast-MFC-AGG-ID: LA23bzdsOz2LMH2BizX19g_1747059884
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0CD7219560AA
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 14:24:44 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.162])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1945F1955EA0; Mon, 12 May 2025 14:24:42 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 1/4] tests: skip encrypted secret tests if AES is not
 available
Date: Mon, 12 May 2025 15:24:36 +0100
Message-ID: <20250512142439.1101159-2-berrange@redhat.com>
In-Reply-To: <20250512142439.1101159-1-berrange@redhat.com>
References: <20250512142439.1101159-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

This avoids test breakage when we drop support for using the
built-in AES impl as a fallback for missing crypto libraries.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/unit/test-crypto-secret.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/tests/unit/test-crypto-secret.c b/tests/unit/test-crypto-secret.c
index ffd13ff70e..fc32a01747 100644
--- a/tests/unit/test-crypto-secret.c
+++ b/tests/unit/test-crypto-secret.c
@@ -22,6 +22,7 @@
 
 #include "crypto/init.h"
 #include "crypto/secret.h"
+#include "crypto/cipher.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #if defined(CONFIG_KEYUTILS) && defined(CONFIG_SECRET_KEYRING)
@@ -597,18 +598,21 @@ int main(int argc, char **argv)
     g_test_add_func("/crypto/secret/conv/utf8/base64",
                     test_secret_conv_utf8_base64);
 
-    g_test_add_func("/crypto/secret/crypt/raw",
-                    test_secret_crypt_raw);
-    g_test_add_func("/crypto/secret/crypt/base64",
-                    test_secret_crypt_base64);
-    g_test_add_func("/crypto/secret/crypt/shortkey",
-                    test_secret_crypt_short_key);
-    g_test_add_func("/crypto/secret/crypt/shortiv",
-                    test_secret_crypt_short_iv);
-    g_test_add_func("/crypto/secret/crypt/missingiv",
-                    test_secret_crypt_missing_iv);
-    g_test_add_func("/crypto/secret/crypt/badiv",
-                    test_secret_crypt_bad_iv);
+    if (qcrypto_cipher_supports(QCRYPTO_CIPHER_ALGO_AES_128,
+                                QCRYPTO_CIPHER_MODE_CBC)) {
+        g_test_add_func("/crypto/secret/crypt/raw",
+                        test_secret_crypt_raw);
+        g_test_add_func("/crypto/secret/crypt/base64",
+                        test_secret_crypt_base64);
+        g_test_add_func("/crypto/secret/crypt/shortkey",
+                        test_secret_crypt_short_key);
+        g_test_add_func("/crypto/secret/crypt/shortiv",
+                        test_secret_crypt_short_iv);
+        g_test_add_func("/crypto/secret/crypt/missingiv",
+                        test_secret_crypt_missing_iv);
+        g_test_add_func("/crypto/secret/crypt/badiv",
+                        test_secret_crypt_bad_iv);
+    }
 
     return g_test_run();
 }
-- 
2.49.0


