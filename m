Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD6FC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 15:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmCpR-00055k-V1; Tue, 21 Jul 2026 11:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wmCpP-00051d-Nb
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 11:56:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wmCpN-0004yE-U5
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 11:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784649377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Os2JXx0gcWKjyLiV5BevPuMLA0GWYkKP+Xpy0OT7P+U=;
 b=GIRNHEqaBmy46ABZFYSEXmQFHSqQgU4TfxxGHlAT1Fwsym3OAVRp3jC8+kkSLAsasmzWAj
 XRayBqdiwLd20dBFrJg8eT+c8SzV8a1hDQerBmF+mrf6yQqrOPtYVnUDWnxyia6RZ7jw+0
 6iTzGVBPZJj4spoGCNk7/PFoK4sGfy0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-ZbPPVxOeNaeoma_-UraHYA-1; Tue,
 21 Jul 2026 11:56:13 -0400
X-MC-Unique: ZbPPVxOeNaeoma_-UraHYA-1
X-Mimecast-MFC-AGG-ID: ZbPPVxOeNaeoma_-UraHYA_1784649372
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2967E1956077; Tue, 21 Jul 2026 15:56:12 +0000 (UTC)
Received: from berrange.com (unknown [10.44.32.83])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C551718002B1; Tue, 21 Jul 2026 15:56:08 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Luc Michel <luc.michel@amd.com>
Subject: [PULL 3/5] meson.build: re-add explicit gcrypt/nettle request check
Date: Tue, 21 Jul 2026 16:55:52 +0100
Message-ID: <20260721155554.128840-4-berrange@redhat.com>
In-Reply-To: <20260721155554.128840-1-berrange@redhat.com>
References: <20260721155554.128840-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Luc Michel <luc.michel@amd.com>

c4b3d0074 removed the check that nettle or gcrypt were explicitly
requested as the crypto library to use, breaking the --enable-nettle and
--enable-gcrypt options. Re-add the logic to force usage of nettle or
gcrypt for crypto operations, while still keeping gnutls for TLS.

Fixes: c4b3d0074 (crypto: bump min gnutls to 3.7.5)
Tested-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Luc Michel <luc.michel@amd.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/cipher.c                |  2 +-
 crypto/meson.build             |  2 +-
 meson.build                    | 11 ++++++++++-
 tests/unit/test-crypto-block.c |  3 ++-
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/crypto/cipher.c b/crypto/cipher.c
index 515165e0dc..229710f76b 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -142,7 +142,7 @@ qcrypto_cipher_validate_key_length(QCryptoCipherAlgo alg,
 #include "cipher-gcrypt.c.inc"
 #elif defined CONFIG_NETTLE
 #include "cipher-nettle.c.inc"
-#elif defined CONFIG_GNUTLS
+#elif defined CONFIG_GNUTLS_CRYPTO
 #include "cipher-gnutls.c.inc"
 #else
 #include "cipher-stub.c.inc"
diff --git a/crypto/meson.build b/crypto/meson.build
index b51597a879..6ac83857aa 100644
--- a/crypto/meson.build
+++ b/crypto/meson.build
@@ -38,7 +38,7 @@ if nettle.found()
   endif
 elif gcrypt.found()
   crypto_ss.add(gcrypt, files('hash-gcrypt.c', 'hmac-gcrypt.c', 'pbkdf-gcrypt.c'))
-elif gnutls.found()
+elif gnutls_crypto.found()
   crypto_ss.add(gnutls, files('hash-gnutls.c', 'hmac-gnutls.c', 'pbkdf-gnutls.c'))
 else
   crypto_ss.add(files('hash-glib.c', 'hmac-glib.c', 'pbkdf-stub.c'))
diff --git a/meson.build b/meson.build
index 164328ded8..06c43b4358 100644
--- a/meson.build
+++ b/meson.build
@@ -1783,11 +1783,13 @@ if not get_option('libcbor').auto() or have_system
 endif
 
 gnutls = not_found
+gnutls_crypto = not_found
 gnutls_bug1717_workaround = false
 if get_option('gnutls').enabled() or (get_option('gnutls').auto() and have_system)
   gnutls = dependency('gnutls', version: '>=3.7.5',
                       method: 'pkg-config',
                       required: get_option('gnutls'))
+  gnutls_crypto = gnutls
 
   #if gnutls.found() and not get_option('gnutls-bug1717-workaround').disabled()
     # XXX: when bug 1717 is resolved, add logic to probe for
@@ -1811,7 +1813,12 @@ if get_option('nettle').enabled() and get_option('gcrypt').enabled()
   error('Only one of gcrypt & nettle can be enabled')
 endif
 
-if not gnutls.found()
+# Explicit nettle/gcrypt request, so ignore gnutls for crypto
+if get_option('nettle').enabled() or get_option('gcrypt').enabled()
+  gnutls_crypto = not_found
+endif
+
+if not gnutls_crypto.found()
   if (not get_option('gcrypt').auto() or have_system) and not get_option('nettle').enabled()
     gcrypt = dependency('libgcrypt', version: '>=1.9.4',
                         required: get_option('gcrypt'))
@@ -2513,6 +2520,7 @@ config_host_data.set('CONFIG_XKBCOMMON', xkbcommon.found())
 config_host_data.set('CONFIG_KEYUTILS', keyutils.found())
 config_host_data.set('CONFIG_GETTID', has_gettid)
 config_host_data.set('CONFIG_GNUTLS', gnutls.found())
+config_host_data.set('CONFIG_GNUTLS_CRYPTO', gnutls_crypto.found())
 config_host_data.set('CONFIG_GNUTLS_BUG1717_WORKAROUND', gnutls_bug1717_workaround)
 config_host_data.set('CONFIG_TASN1', tasn1.found())
 config_host_data.set('CONFIG_GCRYPT', gcrypt.found())
@@ -4865,6 +4873,7 @@ summary_info = {}
 summary_info += {'TLS priority':      get_option('tls_priority')}
 summary_info += {'GNUTLS support':    gnutls}
 if gnutls.found()
+  summary_info += {'  GNUTLS crypto':   gnutls_crypto.found()}
   summary_info += {'  GNUTLS bug 1717 workaround': gnutls_bug1717_workaround }
 endif
 summary_info += {'libgcrypt':         gcrypt}
diff --git a/tests/unit/test-crypto-block.c b/tests/unit/test-crypto-block.c
index 218e585f98..3ac7f17b2a 100644
--- a/tests/unit/test-crypto-block.c
+++ b/tests/unit/test-crypto-block.c
@@ -31,7 +31,8 @@
 #endif
 
 #if (defined(_WIN32) || defined RUSAGE_THREAD) && \
-    (defined(CONFIG_NETTLE) || defined(CONFIG_GCRYPT))
+    (defined(CONFIG_NETTLE) || defined(CONFIG_GCRYPT) || \
+     defined(CONFIG_GNUTLS_CRYPTO))
 #define TEST_LUKS
 #else
 #undef TEST_LUKS
-- 
2.55.0


