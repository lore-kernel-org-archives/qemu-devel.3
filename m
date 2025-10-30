Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C380ACCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 14:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vETyq-0001Wu-D7; Thu, 30 Oct 2025 10:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vETyn-0001Kr-2A
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:50:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vETyW-0001Th-CH
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761835801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=srbXD/gRg5rZ/UxqrQerd29F8bBGqCt/OYfKexte/J8=;
 b=DRYvDaFlv5QRfUjqct7CWrnYlvsO3jPBQ1Lw2lKDStMyJ6EX2pMnsxofnoTZaeBqlszi+3
 w67mNCfPSbrFmeoUNg9E7yc4dYHZo3vtj7y+KwIPGEJYie1iyhAZ97gBf0PBNk4jtPBl2i
 fbU322G6eWppqTOLAXn8o5R8FN4ExU0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-jSyok26tPriRDmz81nIvbg-1; Thu,
 30 Oct 2025 10:49:56 -0400
X-MC-Unique: jSyok26tPriRDmz81nIvbg-1
X-Mimecast-MFC-AGG-ID: jSyok26tPriRDmz81nIvbg_1761835795
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A677319540DE; Thu, 30 Oct 2025 14:49:55 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.122])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4CA4430001B9; Thu, 30 Oct 2025 14:49:54 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 devel@lists.libvirt.org
Subject: [PATCH 13/21] crypto: introduce a wrapper around gnutls credentials
Date: Thu, 30 Oct 2025 14:49:19 +0000
Message-ID: <20251030144927.2241109-14-berrange@redhat.com>
In-Reply-To: <20251030144927.2241109-1-berrange@redhat.com>
References: <20251030144927.2241109-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The gnutls_credentials_set() method has a very suprising API contract
that requires the caller to preserve the passed in credentials pointer
for as long as the gnutls_session_t object is alive. QEMU is failing
to ensure this happens.

In QEMU the GNUTLS credentials object is owned by the QCryptoTLSCreds
object instance while the GNUTLS session object is owned by the
QCryptoTLSSession object instance. Their lifetimes are not guaranteed
to be the same, though in most common usage the credentials will outlive
the session. This is notably not the case, however, after the VNC server
gained the ability to reload credentials on the fly with:

  commit 1f08e3415120637cad7f540d9ceb4dba3136dbdd
  Author: Zihao Chang <changzihao1@huawei.com>
  Date:   Tue Mar 16 15:58:44 2021 +0800

    vnc: support reload x509 certificates for vnc

If that is triggered while a VNC client is in the middle of performing
a TLS handshake, we might hit a use-after-free.

It is difficult to correct this problem because there's no way to deep-
clone a GNUTLS credentials object, nor is it reference counted. Thus we
introduce a QCryptoTLSCredsBox object whose only purpose is to add
reference counting around the GNUTLS credentials object.

The DH parameters set against a credentials object also have to be kept
alive for as long as the credentials exist. So the box must also hold
the DH parameters pointer.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/meson.build   |   5 ++-
 crypto/tlscredsbox.c | 101 +++++++++++++++++++++++++++++++++++++++++++
 crypto/tlscredsbox.h |  46 ++++++++++++++++++++
 3 files changed, 151 insertions(+), 1 deletion(-)
 create mode 100644 crypto/tlscredsbox.c
 create mode 100644 crypto/tlscredsbox.h

diff --git a/crypto/meson.build b/crypto/meson.build
index 735635de1f..1fc14b2a04 100644
--- a/crypto/meson.build
+++ b/crypto/meson.build
@@ -25,7 +25,10 @@ crypto_ss.add(files(
 ))
 
 if gnutls.found()
-  crypto_ss.add(files('x509-utils.c'))
+  crypto_ss.add(files(
+    'tlscredsbox.c',
+    'x509-utils.c',
+  ))
 endif
 
 if nettle.found()
diff --git a/crypto/tlscredsbox.c b/crypto/tlscredsbox.c
new file mode 100644
index 0000000000..b8d9846af8
--- /dev/null
+++ b/crypto/tlscredsbox.c
@@ -0,0 +1,101 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * QEMU crypto TLS credential support
+ *
+ * Copyright (c) 2025 Red Hat, Inc.
+ */
+
+#include "qemu/osdep.h"
+#include "crypto/tlscredsbox.h"
+#include "qemu/atomic.h"
+
+
+static QCryptoTLSCredsBox *
+qcrypto_tls_creds_box_new_impl(int type, bool server)
+{
+    QCryptoTLSCredsBox *credsbox = g_new0(QCryptoTLSCredsBox, 1);
+    credsbox->ref = 1;
+    credsbox->server = server;
+    credsbox->type = type;
+    return credsbox;
+}
+
+
+QCryptoTLSCredsBox *
+qcrypto_tls_creds_box_new_server(int type)
+{
+    return qcrypto_tls_creds_box_new_impl(type, true);
+}
+
+
+QCryptoTLSCredsBox *
+qcrypto_tls_creds_box_new_client(int type)
+{
+    return qcrypto_tls_creds_box_new_impl(type, false);
+}
+
+static void qcrypto_tls_creds_box_free(QCryptoTLSCredsBox *credsbox)
+{
+    switch (credsbox->type) {
+    case GNUTLS_CRD_CERTIFICATE:
+        if (credsbox->data.cert) {
+            gnutls_certificate_free_credentials(credsbox->data.cert);
+        }
+        break;
+    case GNUTLS_CRD_PSK:
+        if (credsbox->server) {
+            if (credsbox->data.pskserver) {
+                gnutls_psk_free_server_credentials(credsbox->data.pskserver);
+            }
+        } else {
+            if (credsbox->data.pskclient) {
+                gnutls_psk_free_client_credentials(credsbox->data.pskclient);
+            }
+        }
+        break;
+    case GNUTLS_CRD_ANON:
+        if (credsbox->server) {
+            if (credsbox->data.anonserver) {
+                gnutls_anon_free_server_credentials(credsbox->data.anonserver);
+            }
+        } else {
+            if (credsbox->data.anonclient) {
+                gnutls_anon_free_client_credentials(credsbox->data.anonclient);
+            }
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (credsbox->dh_params) {
+        gnutls_dh_params_deinit(credsbox->dh_params);
+    }
+
+    g_free(credsbox);
+}
+
+
+void qcrypto_tls_creds_box_ref(QCryptoTLSCredsBox *credsbox)
+{
+    uint32_t ref = qatomic_fetch_inc(&credsbox->ref);
+    /* Assert waaay before the integer overflows */
+    g_assert(ref < INT_MAX);
+}
+
+
+void qcrypto_tls_creds_box_unref(QCryptoTLSCredsBox *credsbox)
+{
+    if (!credsbox) {
+        return;
+    }
+
+    g_assert(credsbox->ref > 0);
+
+    if (qatomic_fetch_dec(&credsbox->ref) == 1) {
+        qcrypto_tls_creds_box_free(credsbox);
+    }
+
+}
+
diff --git a/crypto/tlscredsbox.h b/crypto/tlscredsbox.h
new file mode 100644
index 0000000000..5d89335f46
--- /dev/null
+++ b/crypto/tlscredsbox.h
@@ -0,0 +1,46 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * QEMU crypto TLS credential support
+ *
+ * Copyright (c) 2025 Red Hat, Inc.
+ */
+
+#ifndef QCRYPTO_TLSCREDS_BOX_H
+#define QCRYPTO_TLSCREDS_BOX_H
+
+#include "qom/object.h"
+
+#ifdef CONFIG_GNUTLS
+#include <gnutls/gnutls.h>
+#endif
+
+typedef struct QCryptoTLSCredsBox QCryptoTLSCredsBox;
+
+struct QCryptoTLSCredsBox {
+    uint32_t ref;
+    bool server;
+    int type;
+    union {
+        void *any;
+#ifdef CONFIG_GNUTLS
+        gnutls_anon_server_credentials_t anonserver;
+        gnutls_anon_client_credentials_t anonclient;
+        gnutls_psk_server_credentials_t pskserver;
+        gnutls_psk_client_credentials_t pskclient;
+        gnutls_certificate_credentials_t cert;
+#endif
+    } data;
+#ifdef CONFIG_GNUTLS
+    gnutls_dh_params_t dh_params;
+#endif
+};
+
+QCryptoTLSCredsBox *qcrypto_tls_creds_box_new_server(int type);
+QCryptoTLSCredsBox *qcrypto_tls_creds_box_new_client(int type);
+void qcrypto_tls_creds_box_ref(QCryptoTLSCredsBox *credsbox);
+void qcrypto_tls_creds_box_unref(QCryptoTLSCredsBox *credsbox);
+
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoTLSCredsBox, qcrypto_tls_creds_box_unref);
+
+#endif /* QCRYPTO_TLSCREDS_BOX_H */
-- 
2.51.1


