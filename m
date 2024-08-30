Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D82CA0FE1
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 11:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjzRq-000854-92; Fri, 30 Aug 2024 07:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjzRp-000825-Gv
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 07:05:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjzRn-0005t3-OL
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 07:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725015942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LRv60yb9OW9m8a0eygl5RDRTdVLgaPkJ900k0QOGIiM=;
 b=jSpyC11p2ChKSagUnOXQK+iYINfynhrmys2j6gcI0udBJ0hCg5fjvv5R4muqGyPOCL8yON
 KG2WL0Nw5Vz3qBwdi8EFmEpZkGuBJaePTgeNQ5+ib6x9rf5g+ipXMNnICXvB9hxuRdMdqX
 k+NJkQtulU28nffp+5meSbDs+ljY+Bk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-P7Z2ujZUMZKI-cMB0FXIMA-1; Fri,
 30 Aug 2024 07:05:40 -0400
X-MC-Unique: P7Z2ujZUMZKI-cMB0FXIMA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94A0A1954B08
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 11:05:39 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.49])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 46D5B19560A3; Fri, 30 Aug 2024 11:05:37 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/2] tests/unit: always build the pbkdf crypto unit test
Date: Fri, 30 Aug 2024 12:05:33 +0100
Message-ID: <20240830110533.2544070-3-berrange@redhat.com>
In-Reply-To: <20240830110533.2544070-1-berrange@redhat.com>
References: <20240830110533.2544070-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Also add CONFIG_DARWIN to the remaining condition, since we have a way
to measure CPU time on this platform since commit bf98afc75efedf1.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/unit/meson.build         | 4 +---
 tests/unit/test-crypto-pbkdf.c | 9 ++++++---
 2 files changed, 7 insertions(+), 6 deletions(-)

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
index 43c417f6b4..034bb02422 100644
--- a/tests/unit/test-crypto-pbkdf.c
+++ b/tests/unit/test-crypto-pbkdf.c
@@ -25,8 +25,7 @@
 #include <sys/resource.h>
 #endif
 
-#if ((defined(CONFIG_NETTLE) || defined(CONFIG_GCRYPT)) && \
-     (defined(_WIN32) || defined(RUSAGE_THREAD)))
+#if defined(_WIN32) || defined(RUSAGE_THREAD) || defined(CONFIG_DARWIN)
 #include "crypto/pbkdf.h"
 
 typedef struct QCryptoPbkdfTestData QCryptoPbkdfTestData;
@@ -422,13 +421,17 @@ int main(int argc, char **argv)
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
+    if (g_test_slow() && qcrypto_pbkdf2_supports(QCRYPTO_HASH_ALG_SHA256)) {
         g_test_add_func("/crypt0/pbkdf/timing", test_pbkdf_timing);
     }
 
-- 
2.45.2


