Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4151DECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 14:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snfDP-0003xq-CN; Mon, 09 Sep 2024 10:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1snfDA-0002UN-RT
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:17:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1snfD7-0003QN-Lg
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:17:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725891465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k9/tGajAtWoDx1VNQGN8/qbY8n3LIiVuLQPmyt2WZLo=;
 b=YWrFlYSFzFtFQ57cggj9WUuCrwXNqe7G2RVti2AnnQwoVEa3sSV4bq+B0RVJ+1CZrr1jAG
 PjQ+mkzQxTf6cYJPGwVrwuTPyXnK9VzqfMtflCY/dJEwnW7YXabVU/s81pE4aZSgZ6D5oQ
 wHWaurCqbtlb9faV/g/38/8AxbOkn3c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-bD5Wy_wfMvKHV_gfFv0ShA-1; Mon,
 09 Sep 2024 10:17:42 -0400
X-MC-Unique: bD5Wy_wfMvKHV_gfFv0ShA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B553E1977023; Mon,  9 Sep 2024 14:17:39 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.212])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 217AA1956054; Mon,  9 Sep 2024 14:17:34 +0000 (UTC)
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
Subject: [PULL 10/10] crypto: Introduce x509 utils
Date: Mon,  9 Sep 2024 15:16:35 +0100
Message-ID: <20240909141635.1459701-11-berrange@redhat.com>
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

An utility function for getting fingerprint from X.509 certificate
has been introduced. Implementation only provided using gnutls.

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
[DB: fixed missing gnutls_x509_crt_deinit in success path]
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/meson.build          |  4 ++
 crypto/x509-utils.c         | 76 +++++++++++++++++++++++++++++++++++++
 include/crypto/x509-utils.h | 22 +++++++++++
 3 files changed, 102 insertions(+)
 create mode 100644 crypto/x509-utils.c
 create mode 100644 include/crypto/x509-utils.h

diff --git a/crypto/meson.build b/crypto/meson.build
index c46f9c22a7..735635de1f 100644
--- a/crypto/meson.build
+++ b/crypto/meson.build
@@ -24,6 +24,10 @@ crypto_ss.add(files(
   'rsakey.c',
 ))
 
+if gnutls.found()
+  crypto_ss.add(files('x509-utils.c'))
+endif
+
 if nettle.found()
   crypto_ss.add(nettle, files('hash-nettle.c', 'hmac-nettle.c', 'pbkdf-nettle.c'))
   if hogweed.found()
diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
new file mode 100644
index 0000000000..6e157af76b
--- /dev/null
+++ b/crypto/x509-utils.c
@@ -0,0 +1,76 @@
+/*
+ * X.509 certificate related helpers
+ *
+ * Copyright (c) 2024 Dorjoy Chowdhury <dorjoychy111@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "crypto/x509-utils.h"
+#include <gnutls/gnutls.h>
+#include <gnutls/crypto.h>
+#include <gnutls/x509.h>
+
+static const int qcrypto_to_gnutls_hash_alg_map[QCRYPTO_HASH_ALG__MAX] = {
+    [QCRYPTO_HASH_ALG_MD5] = GNUTLS_DIG_MD5,
+    [QCRYPTO_HASH_ALG_SHA1] = GNUTLS_DIG_SHA1,
+    [QCRYPTO_HASH_ALG_SHA224] = GNUTLS_DIG_SHA224,
+    [QCRYPTO_HASH_ALG_SHA256] = GNUTLS_DIG_SHA256,
+    [QCRYPTO_HASH_ALG_SHA384] = GNUTLS_DIG_SHA384,
+    [QCRYPTO_HASH_ALG_SHA512] = GNUTLS_DIG_SHA512,
+    [QCRYPTO_HASH_ALG_RIPEMD160] = GNUTLS_DIG_RMD160,
+};
+
+int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
+                                      QCryptoHashAlgorithm alg,
+                                      uint8_t *result,
+                                      size_t *resultlen,
+                                      Error **errp)
+{
+    int ret = -1;
+    int hlen;
+    gnutls_x509_crt_t crt;
+    gnutls_datum_t datum = {.data = cert, .size = size};
+
+    if (alg >= G_N_ELEMENTS(qcrypto_to_gnutls_hash_alg_map)) {
+        error_setg(errp, "Unknown hash algorithm");
+        return -1;
+    }
+
+    if (result == NULL) {
+        error_setg(errp, "No valid buffer given");
+        return -1;
+    }
+
+    gnutls_x509_crt_init(&crt);
+
+    if (gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM) != 0) {
+        error_setg(errp, "Failed to import certificate");
+        goto cleanup;
+    }
+
+    hlen = gnutls_hash_get_len(qcrypto_to_gnutls_hash_alg_map[alg]);
+    if (*resultlen < hlen) {
+        error_setg(errp,
+                   "Result buffer size %zu is smaller than hash %d",
+                   *resultlen, hlen);
+        goto cleanup;
+    }
+
+    if (gnutls_x509_crt_get_fingerprint(crt,
+                                        qcrypto_to_gnutls_hash_alg_map[alg],
+                                        result, resultlen) != 0) {
+        error_setg(errp, "Failed to get fingerprint from certificate");
+        goto cleanup;
+    }
+
+    ret = 0;
+
+ cleanup:
+    gnutls_x509_crt_deinit(crt);
+    return ret;
+}
diff --git a/include/crypto/x509-utils.h b/include/crypto/x509-utils.h
new file mode 100644
index 0000000000..4210dfbcfc
--- /dev/null
+++ b/include/crypto/x509-utils.h
@@ -0,0 +1,22 @@
+/*
+ * X.509 certificate related helpers
+ *
+ * Copyright (c) 2024 Dorjoy Chowdhury <dorjoychy111@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#ifndef QCRYPTO_X509_UTILS_H
+#define QCRYPTO_X509_UTILS_H
+
+#include "crypto/hash.h"
+
+int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
+                                      QCryptoHashAlgorithm hash,
+                                      uint8_t *result,
+                                      size_t *resultlen,
+                                      Error **errp);
+
+#endif
-- 
2.45.2


