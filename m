Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF43FC3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 09:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWYbB-0001Rn-2Q; Wed, 24 Jul 2024 05:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWYb8-0001RH-LB
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 05:47:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWYb6-0003Mb-Uw
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 05:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721814468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G0CX9vhks7yTdTQlTeKYR0RMQ0dL+1/ELcWrWZDB/wk=;
 b=Ciq95VJ4qfHONfjlTbpPFFivtlwQCMnFgELTebsfTgOx0L1tF6d3qPrOZtklsDUAPWoMKk
 relIsVBzlhW0MOEZPf8NGNpHxeu+z0ysGbc0GeYYZmEzU2sG0Oy2DInyTEiAysrBxEcLxF
 O9FRvKUKQBFa539CagraF6YRwb4DZVI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-UwjJ4ygcNY6tNsGtTYdM6g-1; Wed,
 24 Jul 2024 05:47:44 -0400
X-MC-Unique: UwjJ4ygcNY6tNsGtTYdM6g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F17D81955D4F; Wed, 24 Jul 2024 09:47:42 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.141])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9ADD419560AA; Wed, 24 Jul 2024 09:47:31 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: [PULL 02/11] crypto: Restrict pkix_asn1_tab[] to
 crypto-tls-x509-helpers.c
Date: Wed, 24 Jul 2024 10:46:57 +0100
Message-ID: <20240724094706.30396-3-berrange@redhat.com>
In-Reply-To: <20240724094706.30396-1-berrange@redhat.com>
References: <20240724094706.30396-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

pkix_asn1_tab[] is only accessed by crypto-tls-x509-helpers.c,
rename pkix_asn1_tab.c as pkix_asn1_tab.c.inc and include it once.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[berrange: updated MAINTAINERS for changed filename]
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 MAINTAINERS                                         | 2 +-
 tests/qtest/meson.build                             | 3 +--
 tests/unit/crypto-tls-x509-helpers.c                | 6 +++++-
 tests/unit/crypto-tls-x509-helpers.h                | 3 ---
 tests/unit/meson.build                              | 6 +++---
 tests/unit/{pkix_asn1_tab.c => pkix_asn1_tab.c.inc} | 5 +----
 6 files changed, 11 insertions(+), 14 deletions(-)
 rename tests/unit/{pkix_asn1_tab.c => pkix_asn1_tab.c.inc} (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index dd01288992..73040829b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3484,7 +3484,7 @@ F: qapi/crypto.json
 F: tests/unit/test-crypto-*
 F: tests/bench/benchmark-crypto-*
 F: tests/unit/crypto-tls-*
-F: tests/unit/pkix_asn1_tab.c
+F: tests/unit/pkix_asn1_tab.c.inc
 F: qemu.sasl
 
 Coroutines
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index ff9200f882..e7ab2a4312 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -322,8 +322,7 @@ if gnutls.found()
   migration_files += [files('../unit/crypto-tls-psk-helpers.c'), gnutls]
 
   if tasn1.found()
-    migration_files += [files('../unit/crypto-tls-x509-helpers.c',
-                              '../unit/pkix_asn1_tab.c'), tasn1]
+    migration_files += [files('../unit/crypto-tls-x509-helpers.c'), tasn1]
   endif
 endif
 
diff --git a/tests/unit/crypto-tls-x509-helpers.c b/tests/unit/crypto-tls-x509-helpers.c
index e9937f60d8..3e74ec5b5d 100644
--- a/tests/unit/crypto-tls-x509-helpers.c
+++ b/tests/unit/crypto-tls-x509-helpers.c
@@ -20,15 +20,19 @@
 
 #include "qemu/osdep.h"
 
+#include <libtasn1.h>
+
 #include "crypto-tls-x509-helpers.h"
 #include "crypto/init.h"
 #include "qemu/sockets.h"
 
+#include "pkix_asn1_tab.c.inc"
+
 /*
  * This stores some static data that is needed when
  * encoding extensions in the x509 certs
  */
-asn1_node pkix_asn1;
+static asn1_node pkix_asn1;
 
 /*
  * To avoid consuming random entropy to generate keys,
diff --git a/tests/unit/crypto-tls-x509-helpers.h b/tests/unit/crypto-tls-x509-helpers.h
index 247e7160eb..562c160653 100644
--- a/tests/unit/crypto-tls-x509-helpers.h
+++ b/tests/unit/crypto-tls-x509-helpers.h
@@ -23,7 +23,6 @@
 
 #include <gnutls/gnutls.h>
 #include <gnutls/x509.h>
-#include <libtasn1.h>
 
 
 #define QCRYPTO_TLS_TEST_CLIENT_NAME "ACME QEMU Client"
@@ -171,6 +170,4 @@ void test_tls_cleanup(const char *keyfile);
     };                                                                  \
     test_tls_generate_cert(&varname, cavarname.crt)
 
-extern const asn1_static_node pkix_asn1_tab[];
-
 #endif
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 26c109c968..490ab8182d 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -99,11 +99,11 @@ if have_block
      tasn1.found() and \
      host_os != 'windows'
     tests += {
-      'test-crypto-tlscredsx509': ['crypto-tls-x509-helpers.c', 'pkix_asn1_tab.c',
+      'test-crypto-tlscredsx509': ['crypto-tls-x509-helpers.c',
                                    tasn1, crypto, gnutls],
-      'test-crypto-tlssession': ['crypto-tls-x509-helpers.c', 'pkix_asn1_tab.c', 'crypto-tls-psk-helpers.c',
+      'test-crypto-tlssession': ['crypto-tls-x509-helpers.c', 'crypto-tls-psk-helpers.c',
                                  tasn1, crypto, gnutls],
-      'test-io-channel-tls': ['io-channel-helpers.c', 'crypto-tls-x509-helpers.c', 'pkix_asn1_tab.c',
+      'test-io-channel-tls': ['io-channel-helpers.c', 'crypto-tls-x509-helpers.c',
                               tasn1, io, crypto, gnutls]}
   endif
   if pam.found()
diff --git a/tests/unit/pkix_asn1_tab.c b/tests/unit/pkix_asn1_tab.c.inc
similarity index 99%
rename from tests/unit/pkix_asn1_tab.c
rename to tests/unit/pkix_asn1_tab.c.inc
index 89521408a1..fe29c4102a 100644
--- a/tests/unit/pkix_asn1_tab.c
+++ b/tests/unit/pkix_asn1_tab.c.inc
@@ -3,10 +3,7 @@
  * and is under copyright of various GNUTLS contributors.
  */
 
-#include "qemu/osdep.h"
-#include "crypto-tls-x509-helpers.h"
-
-const asn1_static_node pkix_asn1_tab[] = {
+static const asn1_static_node pkix_asn1_tab[] = {
   {"PKIX1", 536875024, 0},
   {0, 1073741836, 0},
   {"id-ce", 1879048204, 0},
-- 
2.45.2


