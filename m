Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B46C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 09:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2TBZ-0000dk-F5; Thu, 02 May 2024 05:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2TBV-0000ci-78
 for qemu-devel@nongnu.org; Thu, 02 May 2024 05:57:01 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2TBS-00017U-Fp
 for qemu-devel@nongnu.org; Thu, 02 May 2024 05:57:00 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-34db6a29a1eso1359488f8f.1
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 02:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714643816; x=1715248616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hscm9KdbM1whIxlQwwTQ6xBil1LPfb+u+PB5hBKBEJA=;
 b=YwufLK4fL7WvEkZ5dfh2QoZtWrUFywq45knQTAKvSIhbp+jJ5vm3Iti+DWJsnpbnWE
 8t6mYlxMg6MPnAv3qNbcJ8UnqPy7m4H/TF/mhYvdSJZku6IDEruv+nXM/zVjqX8qQvdR
 cWjUOBsHe3DZmhDZr2Y/YtYHz80OmDxwT2LqbEHlHxXDWXGcdiBMCGi53LvL522zjrDm
 A+CzPIXjvtZ96pcxj+psCJVeyKWHeVBkv42yUqHYIUIv/Z0ZLF9Rr8tBmngRoTZaD3HN
 XRsmAd5AVFknLgYUmlEJMzFkh8t9MyH6YpQZk/CkdLuQG34uL3jT0SRqrMWvvuFWToiN
 Xesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714643816; x=1715248616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hscm9KdbM1whIxlQwwTQ6xBil1LPfb+u+PB5hBKBEJA=;
 b=RLDTT8L/WzxnzKZS6M/aXbAz1303cU7VF2WpbskHC5RXLGefV6jXLzRmliVfUwlRLB
 2RHUFZd9HeNLcF5FQ7iNe4rdyT5O+8m63It6A+ePVOqrlRbwJgvvg44OVrYyGLocpZor
 4hshOp9rGs5D7r109ZWoFHJ/S45D5Bm1e2G8BZ+EK05TcblfvLfT/XQy2iSPrPDMQHAK
 HZycyv22ZO+3w3o0xrV9jM1xNpaYc8HNac4E0/s++uZ4ytCsSzEIr11IqNBpyoS0TUUw
 5/DmrJZl2sRlTFloyJZZLf8rTJ1U6ZFUAkPFMUpSWGGg44yaZGGJD16GpMMig7DhVNaS
 kvIw==
X-Gm-Message-State: AOJu0YxcRUMvjor5gR3hRiZGXP9iTsoenDx9AruPNhdshqu36kynBDMY
 CG+e6tc99Vz2vXlaWgOtENtd5OP+cJSQPKMaXe+55TZucP8XC2gBPgXVo7TE524vM6ECLRXp4i5
 +
X-Google-Smtp-Source: AGHT+IHGjSo9gjk7S7oeHfnoEpfWc02cGP7mrc+2jy61M9y91d4PgtownjBSMfGlCpRDqUyv8rvB8Q==
X-Received: by 2002:adf:e508:0:b0:34c:8adf:8fc9 with SMTP id
 j8-20020adfe508000000b0034c8adf8fc9mr3384338wrm.51.1714643816476; 
 Thu, 02 May 2024 02:56:56 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.215.106])
 by smtp.gmail.com with ESMTPSA id
 r8-20020a5d4988000000b0034cceee9051sm853767wrq.105.2024.05.02.02.56.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 May 2024 02:56:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/3] crypto: Restrict pkix_asn1_tab[] to
 crypto-tls-x509-helpers.c
Date: Thu,  2 May 2024 11:56:41 +0200
Message-ID: <20240502095642.93368-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240502095642.93368-1-philmd@linaro.org>
References: <20240502095642.93368-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

pkix_asn1_tab[] is only accessed by crypto-tls-x509-helpers.c,
rename pkix_asn1_tab.c as pkix_asn1_tab.c.inc and include it once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/unit/crypto-tls-x509-helpers.h                | 3 ---
 tests/unit/crypto-tls-x509-helpers.c                | 6 +++++-
 tests/unit/{pkix_asn1_tab.c => pkix_asn1_tab.c.inc} | 5 +----
 tests/qtest/meson.build                             | 3 +--
 tests/unit/meson.build                              | 6 +++---
 5 files changed, 10 insertions(+), 13 deletions(-)
 rename tests/unit/{pkix_asn1_tab.c => pkix_asn1_tab.c.inc} (99%)

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
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index b128fa5a4b..f16931f82e 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -314,8 +314,7 @@ if gnutls.found()
   migration_files += [files('../unit/crypto-tls-psk-helpers.c'), gnutls]
 
   if tasn1.found()
-    migration_files += [files('../unit/crypto-tls-x509-helpers.c',
-                              '../unit/pkix_asn1_tab.c'), tasn1]
+    migration_files += [files('../unit/crypto-tls-x509-helpers.c'), tasn1]
   endif
 endif
 
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
-- 
2.41.0


