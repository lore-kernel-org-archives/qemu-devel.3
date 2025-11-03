Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80FACCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFunf-0000XE-LQ; Mon, 03 Nov 2025 08:40:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFund-0000IX-2C
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:40:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFunR-0004jD-K6
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:40:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762177227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IXIwVfNB2F1tDt1PGqL4itLFEXKo3+zxh5afw7l5lzA=;
 b=UlrsS381B4+23W0jvg0BKZmWKjKk5UhUNExbBq3urWEKqxxpKKdzswR1Wb9g2h5g4/aQmE
 Sh3EoCNVlM7Cm4Jbe4Q0zXQUAJF5OSSEQ7pxFtE/DtQ/WJgJXFTyFuTjeOZZob9Dub1eiX
 qxpCf0FNhYAzLH9tS+riblAAbWZCW60=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-aHeOs4WhOR-9R14EczECBA-1; Mon,
 03 Nov 2025 08:40:26 -0500
X-MC-Unique: aHeOs4WhOR-9R14EczECBA-1
X-Mimecast-MFC-AGG-ID: aHeOs4WhOR-9R14EczECBA_1762177225
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 775DC1801231; Mon,  3 Nov 2025 13:40:25 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.202])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 62CDA180057B; Mon,  3 Nov 2025 13:40:19 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 24/32] crypto: introduce a wrapper around gnutls credentials
Date: Mon,  3 Nov 2025 13:37:18 +0000
Message-ID: <20251103133727.423041-25-berrange@redhat.com>
In-Reply-To: <20251103133727.423041-1-berrange@redhat.com>
References: <20251103133727.423041-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/meson.build   |   5 ++-
 crypto/tlscredsbox.c | 101 +++++++++++++++++++++++++++++++++++++++++++
 crypto/tlscredsbox.h |  50 +++++++++++++++++++++
 3 files changed, 155 insertions(+), 1 deletion(-)
 create mode 100644 crypto/tlscredsbox.c
 create mode 100644 crypto/tlscredsbox.h

diff --git a/crypto/meson.build b/crypto/meson.build
index 110c347033..b51597a879 100644
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
index 0000000000..eeb54d1eeb
--- /dev/null
+++ b/crypto/tlscredsbox.h
@@ -0,0 +1,50 @@
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
+        /*
+         * All of these gnutls_XXXX_credentials_t types are
+         * pointers, hence matching the 'any' field above
+         */
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


