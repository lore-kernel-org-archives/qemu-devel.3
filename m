Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E6AC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 08:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2RY6-0004Bk-Rt; Thu, 02 May 2024 04:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2RXu-0004Ax-NU
 for qemu-devel@nongnu.org; Thu, 02 May 2024 04:12:03 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2RXi-0006YV-4N
 for qemu-devel@nongnu.org; Thu, 02 May 2024 04:12:02 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2df848f9325so64912681fa.1
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 01:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714637507; x=1715242307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3Q5YSO6K1f+WJxekQ1Tyf6qsNXu5BvlWnLkuvxc6h5Q=;
 b=cwf2zwKGMIaUiWNEboTI0ogSaiGZpg3Td2lgdfy2DQ3ljGH65ILalJNyTieCOj3J86
 3iDT9fW6SFid6X5IeMK9i+d0EIITlF0Z29ygyi8qCKFrEmO3RIiM/DpTrSTgE8UzHwcw
 hXS25ZFCOqeM+fTKigC3gq1C7NXNm2g+qGRCTit0VYzsLDJqghvk9iUm781br5BW/pzH
 PAZXw7EGf3ERRlvj8Fg1oJOLdk/kOwFHhLzW3bopuy5bXbaQyr3EYaZVV2o+KXeJXpJG
 c55/jmfeTFDW9RRHqgqD8Aw8Q8sXglWKkZywLZDaBN3hU5ofCJdCAGB70ssFyJ+/au5m
 yAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714637507; x=1715242307;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Q5YSO6K1f+WJxekQ1Tyf6qsNXu5BvlWnLkuvxc6h5Q=;
 b=wtJ0wPZcNqF1J70VT4dZTRatZU/XyDLQe+iguppngRtMmeDYtWIEc4HxcvGJwrkQXl
 NBffd9yY8ZPb/lnqidlAJMTYzfpc6TxMhJ4SsYIrA4ibo6RNTUXgcmODErrgUvejh5Pl
 j9WgZ51thOlZVOXqOl7Rim2E+q96rOjzg4mREibK3htoNIpWEdXGvRgoW6B4F4rrL/SA
 ex9od5OFcAbaMgWjZPDpKN3L+0VCXiwXTYnD+d5ppzhceQClQ8ToRvW0mrUhUuPYA5JC
 DA+5FcG11C/DjGeX46n/DO0cN4k7ADPbYhWaOZaOJqfvR21tbbhv6DgPqE0VN6IzFhDp
 6jOw==
X-Gm-Message-State: AOJu0YwxZIQywBT+8ZAapPRqGS6b0xL1V/gFs1tbalrL1EYjFUmVZCm3
 y66IEjouZ6j4Euj+DL1Ey86RTVE1cNWIcLAVp+t04HYXO0feR7f8yCqZnCS+qTmsom+vJDuWH8w
 c
X-Google-Smtp-Source: AGHT+IFXskFx1d+zwTVYaBklbprk0A2VLszpAO3KcJLEuVpUevWvDodYbkSpDJ+5EaPiZZq+PyUmdg==
X-Received: by 2002:a05:651c:b13:b0:2dd:b190:241f with SMTP id
 b19-20020a05651c0b1300b002ddb190241fmr1170795ljr.39.1714637507490; 
 Thu, 02 May 2024 01:11:47 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.215.106])
 by smtp.gmail.com with ESMTPSA id
 dh18-20020a0560000a9200b003439d2a5f99sm627768wrb.55.2024.05.02.01.11.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 May 2024 01:11:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] crypto: Allow building with GnuTLS but without Libtasn1
Date: Thu,  2 May 2024 10:11:44 +0200
Message-ID: <20240502081144.86599-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

We only use Libtasn1 in unit tests. As noted in commit d47b83b118
("tests: add migration tests of TLS with x509 credentials"), having
GnuTLS without Libtasn1 is a valid configuration, so do not require
Libtasn1, to avoid:

  Dependency gnutls found: YES 3.7.1 (cached)
  Run-time dependency libtasn1 found: NO (tried pkgconfig)

  ../meson.build:1914:10: ERROR: Dependency "libtasn1" not found, tried pkgconfig

Restrict the unit test pkix_asn1_tab[] variable to CONFIG_TASN1.

Fixes: ba7ed407e6 ("configure, meson: convert libtasn1 detection to meson")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build                          | 1 +
 tests/unit/crypto-tls-x509-helpers.h | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 5db2dbc12e..837a2bdb56 100644
--- a/meson.build
+++ b/meson.build
@@ -1912,6 +1912,7 @@ endif
 tasn1 = not_found
 if gnutls.found()
   tasn1 = dependency('libtasn1',
+                     required: false,
                      method: 'pkg-config')
 endif
 keyutils = not_found
diff --git a/tests/unit/crypto-tls-x509-helpers.h b/tests/unit/crypto-tls-x509-helpers.h
index 247e7160eb..bddf00d392 100644
--- a/tests/unit/crypto-tls-x509-helpers.h
+++ b/tests/unit/crypto-tls-x509-helpers.h
@@ -23,7 +23,6 @@
 
 #include <gnutls/gnutls.h>
 #include <gnutls/x509.h>
-#include <libtasn1.h>
 
 
 #define QCRYPTO_TLS_TEST_CLIENT_NAME "ACME QEMU Client"
@@ -171,6 +170,9 @@ void test_tls_cleanup(const char *keyfile);
     };                                                                  \
     test_tls_generate_cert(&varname, cavarname.crt)
 
+#ifdef CONFIG_TASN1
+#include <libtasn1.h>
 extern const asn1_static_node pkix_asn1_tab[];
+#endif
 
 #endif
-- 
2.41.0


