Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEC7ECE57A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 14:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snfCx-0001OL-LU; Mon, 09 Sep 2024 10:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1snfCf-0000P1-Pi
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:17:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1snfCd-0003LF-07
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725891433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zIFpkpAxeAzkjaGmQ0Ee0RDU0FU/iIkRoY2HTVLtNNY=;
 b=f7zmu70H4G3+n/+CsPOzTV2nh1Mga3znticmVnEav79Mreo99Gk64WAfOWkxmSgdmPiLTc
 ZF/+wYmYClf5zr1nQ9g6TbiYoI770jPxmVY4k0q8OgrXyWaRjN8zfuYNGqREOAKErxUlJa
 rA3Fug2ozUviMalINq29BkhMF1lRgTE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-Mg7ODw25NeSJIZdKRzgA6Q-1; Mon,
 09 Sep 2024 10:17:10 -0400
X-MC-Unique: Mg7ODw25NeSJIZdKRzgA6Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19F07196CE18; Mon,  9 Sep 2024 14:17:09 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.212])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E8F7B1956054; Mon,  9 Sep 2024 14:17:02 +0000 (UTC)
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
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PULL 04/10] tests/unit: always build the pbkdf crypto unit test
Date: Mon,  9 Sep 2024 15:16:29 +0100
Message-ID: <20240909141635.1459701-5-berrange@redhat.com>
In-Reply-To: <20240909141635.1459701-1-berrange@redhat.com>
References: <20240909141635.1459701-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The meson rules were excluding the pbkdf crypto test when gnutls was the
crypto backend. It was then excluded again in #if statements in the test
file.

Rather than update these conditions, remove them all, and use the result
of the qcrypto_pbkdf_supports() function to determine whether to skip
test registration.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/unit/meson.build         |  4 +---
 tests/unit/test-crypto-pbkdf.c | 13 ++++++++-----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 490ab8182d..972d792883 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -121,9 +121,7 @@ if have_block
   if config_host_data.get('CONFIG_REPLICATION')
     tests += {'test-replication': [testblock]}
   endif
-  if nettle.found() or gcrypt.found()
-    tests += {'test-crypto-pbkdf': [io]}
-  endif
+  tests += {'test-crypto-pbkdf': [io]}
 endif
 
 if have_system
diff --git a/tests/unit/test-crypto-pbkdf.c b/tests/unit/test-crypto-pbkdf.c
index 43c417f6b4..241e1c2cf0 100644
--- a/tests/unit/test-crypto-pbkdf.c
+++ b/tests/unit/test-crypto-pbkdf.c
@@ -25,8 +25,7 @@
 #include <sys/resource.h>
 #endif
 
-#if ((defined(CONFIG_NETTLE) || defined(CONFIG_GCRYPT)) && \
-     (defined(_WIN32) || defined(RUSAGE_THREAD)))
+#if defined(_WIN32) || defined(RUSAGE_THREAD)
 #include "crypto/pbkdf.h"
 
 typedef struct QCryptoPbkdfTestData QCryptoPbkdfTestData;
@@ -394,7 +393,7 @@ static void test_pbkdf(const void *opaque)
 }
 
 
-static void test_pbkdf_timing(void)
+static void test_pbkdf_timing_sha256(void)
 {
     uint8_t key[32];
     uint8_t salt[32];
@@ -422,14 +421,18 @@ int main(int argc, char **argv)
     g_assert(qcrypto_init(NULL) == 0);
 
     for (i = 0; i < G_N_ELEMENTS(test_data); i++) {
+        if (!qcrypto_pbkdf2_supports(test_data[i].hash)) {
+            continue;
+        }
+
         if (!test_data[i].slow ||
             g_test_slow()) {
             g_test_add_data_func(test_data[i].path, &test_data[i], test_pbkdf);
         }
     }
 
-    if (g_test_slow()) {
-        g_test_add_func("/crypt0/pbkdf/timing", test_pbkdf_timing);
+    if (g_test_slow() && qcrypto_pbkdf2_supports(QCRYPTO_HASH_ALG_SHA256)) {
+        g_test_add_func("/crypt0/pbkdf/timing/sha256", test_pbkdf_timing_sha256);
     }
 
     return g_test_run();
-- 
2.45.2


