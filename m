Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A5CCCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 14:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vETyf-00011T-8u; Thu, 30 Oct 2025 10:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vETyY-0000qk-JW
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:50:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vETyO-0001S4-Bz
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761835794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ijiDla8PCG3Gdp62DJdl6trpnwJuNRk9+TxJP6qIEkY=;
 b=i79KfQdwhbEFvzC33hoNXX4zDrNqr/e6IBHuZuWmDQpahTtrDIZ4xbALDtnLAaRGobReTf
 7PZrerS6ABz8RqXR7IgI67o5uWBoK07uERm6M6/ZgM85dDyJXxazaHk0lif/9OXvJJNDY+
 Ur8XKV2EPmXv43Gh0gRWOqGjiTt8v9o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-Oebbgh6rML2j1AfFM8Nh0A-1; Thu,
 30 Oct 2025 10:49:49 -0400
X-MC-Unique: Oebbgh6rML2j1AfFM8Nh0A-1
X-Mimecast-MFC-AGG-ID: Oebbgh6rML2j1AfFM8Nh0A_1761835788
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9FB211801F02; Thu, 30 Oct 2025 14:49:48 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.122])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 201E230001A1; Thu, 30 Oct 2025 14:49:46 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 devel@lists.libvirt.org
Subject: [PATCH 09/21] crypto: shorten the endpoint == server check in TLS
 creds
Date: Thu, 30 Oct 2025 14:49:15 +0000
Message-ID: <20251030144927.2241109-10-berrange@redhat.com>
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

This eliminates a number of long lines aiding readability.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlscredsx509.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index 1555285910..08223781d7 100644
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
 
@@ -664,7 +665,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
         }
     }
 
-    if (creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
+    if (isServer) {
         if (qcrypto_tls_creds_get_dh_params_file(&creds->parent_obj, dhparams,
                                                  &creds->parent_obj.dh_params,
                                                  errp) < 0) {
-- 
2.51.1


