Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1F4CCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 13:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCHic-0005qm-WD; Fri, 24 Oct 2025 09:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vCHiA-0005XU-Fn
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 09:20:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vCHi7-0004nh-Ta
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 09:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761312003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JZB7OCoqm6b79w7L+YOt3iE+VCy+nmZflnF5z8stP38=;
 b=e5j9CmSUeJp8qhAnRJ6JZF3aUD4AB0Mo4BWkOY0O66ETjova+uWnQHAxRomks4W9R9+AzE
 wdPnpNrvEmnWKX3Yqd3tyD5Lua8B3AuqlgjWVa71GtnxQ16Qgl9SMNb7GEPO6dUR/BJ+Tl
 jVoEBSWxAtjdnGz2xAZfOQhLxhpLido=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-F174ytIsMJ6nIL0EN4T76g-1; Fri,
 24 Oct 2025 09:19:59 -0400
X-MC-Unique: F174ytIsMJ6nIL0EN4T76g-1
X-Mimecast-MFC-AGG-ID: F174ytIsMJ6nIL0EN4T76g_1761311998
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A760419560B5; Fri, 24 Oct 2025 13:19:58 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E136019540EB; Fri, 24 Oct 2025 13:19:56 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>
Subject: [PULL 08/13] crypto: remove extraneous pointer usage in gnutls certs
Date: Fri, 24 Oct 2025 14:19:32 +0100
Message-ID: <20251024131937.56673-9-berrange@redhat.com>
In-Reply-To: <20251024131937.56673-1-berrange@redhat.com>
References: <20251024131937.56673-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

The 'gnutls_x509_crt_t' type is already a pointer, not a struct,
so the extra level of pointer indirection is not needed.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlscredsx509.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index 3df2a33b0b..4169ad9a75 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -325,25 +325,25 @@ qcrypto_tls_creds_check_authority_chain(QCryptoTLSCredsX509 *creds,
                                         bool isCA,
                                         Error **errp)
 {
-    gnutls_x509_crt_t *cert_to_check = &cert;
+    gnutls_x509_crt_t cert_to_check = cert;
     bool checking_issuer = true;
     int retval = 0;
 
     while (checking_issuer) {
         checking_issuer = false;
 
-        if (gnutls_x509_crt_check_issuer(*cert_to_check,
-                                         *cert_to_check)) {
+        if (gnutls_x509_crt_check_issuer(cert_to_check,
+                                         cert_to_check)) {
             /*
              * The cert is self-signed indicating we have
              * reached the root of trust.
              */
             return qcrypto_tls_creds_check_cert(
-                creds, *cert_to_check, cacertFile,
+                creds, cert_to_check, cacertFile,
                 isServer, isCA, errp);
         }
         for (int i = 0; i < ncacerts; i++) {
-            if (gnutls_x509_crt_check_issuer(*cert_to_check,
+            if (gnutls_x509_crt_check_issuer(cert_to_check,
                                              cacerts[i])) {
                 retval = qcrypto_tls_creds_check_cert(
                     creds, cacerts[i], cacertFile,
@@ -351,7 +351,7 @@ qcrypto_tls_creds_check_authority_chain(QCryptoTLSCredsX509 *creds,
                 if (retval < 0) {
                     return retval;
                 }
-                cert_to_check = &cacerts[i];
+                cert_to_check = cacerts[i];
                 checking_issuer = true;
                 break;
             }
-- 
2.50.1


