Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8D5CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFunN-0007rw-Mg; Mon, 03 Nov 2025 08:40:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFunG-0007Tl-EF
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:40:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFun8-0004h6-Uw
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:40:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762177206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kwX1Thnjdt/JXukp6bxeGadQ7qKel6NbmeI6Gtvbu4U=;
 b=DbvoDI5w5fk8rz/Dbq1zMVOPFHw3MKdTn5+WytzbNzdmwLZ9e+Bn7DuD7PHwz/olu3FED/
 02MFHVVCNB4c5MGZWFRefA5PkqwrNa39NdInGgcJheb9K0MvKCPnekSuXVDZBM/AJQ8V/D
 bQ/ko6wiC/+K/BOcjQgTxm3m+aObZmo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-3A6rQ2cWNNmNjVNhoI8QnA-1; Mon,
 03 Nov 2025 08:40:03 -0500
X-MC-Unique: 3A6rQ2cWNNmNjVNhoI8QnA-1
X-Mimecast-MFC-AGG-ID: 3A6rQ2cWNNmNjVNhoI8QnA_1762177202
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FAEE19560B0; Mon,  3 Nov 2025 13:40:02 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.202])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2E5811800451; Mon,  3 Nov 2025 13:39:53 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 20/32] crypto: shorten the endpoint == server check in TLS creds
Date: Mon,  3 Nov 2025 13:37:14 +0000
Message-ID: <20251103133727.423041-21-berrange@redhat.com>
In-Reply-To: <20251103133727.423041-1-berrange@redhat.com>
References: <20251103133727.423041-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

This eliminates a number of long lines aiding readability.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlscredsx509.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index d93905ec77..7271b549ee 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -567,6 +567,8 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
     g_autofree char *cert = NULL;
     g_autofree char *key = NULL;
     g_autofree char *dhparams = NULL;
+    bool isServer = (creds->parent_obj.endpoint ==
+                     QCRYPTO_TLS_CREDS_ENDPOINT_SERVER);
     int ret;
 
     if (!creds->parent_obj.dir) {
@@ -576,7 +578,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
 
     trace_qcrypto_tls_creds_x509_load(creds, creds->parent_obj.dir);
 
-    if (creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
+    if (isServer) {
         if (qcrypto_tls_creds_get_path(&creds->parent_obj,
                                        QCRYPTO_TLS_CREDS_X509_CA_CERT,
                                        true, &cacert, errp) < 0 ||
@@ -609,9 +611,8 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
     }
 
     if (creds->sanityCheck &&
-        qcrypto_tls_creds_x509_sanity_check(creds,
-            creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER,
-            cacert, cert, errp) < 0) {
+        qcrypto_tls_creds_x509_sanity_check(creds, isServer,
+                                            cacert, cert, errp) < 0) {
         return -1;
     }
 
@@ -663,7 +664,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
         }
     }
 
-    if (creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
+    if (isServer) {
         if (qcrypto_tls_creds_get_dh_params_file(&creds->parent_obj, dhparams,
                                                  &creds->parent_obj.dh_params,
                                                  errp) < 0) {
-- 
2.51.1


