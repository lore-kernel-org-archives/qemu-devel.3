Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5990CCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 14:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vETyi-00018E-IW; Thu, 30 Oct 2025 10:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vETyf-00010m-9w
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:50:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vETyP-0001ST-RL
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761835795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A2bIVn1en+y5IQjSuVDqmm22Qs1faF+vOyoYo8QG8ac=;
 b=P/Sr1z/TYNupddqDvc80kHNxIwlk/WXW+0a/GRboGYSXg3LenQGt02PoS/4KBo78qAG317
 URaamu4avqVLWkq9Ts9lzIBqAiYt+Mvw2cplMly6QKlaD4A8s4NWnJWP007ohVXgD5t+pJ
 DW3o9i3UFtxMqP2B40BDz0csMvn1ZE4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-YxgDfzIdNOiuXMw8DhN1tA-1; Thu,
 30 Oct 2025 10:49:52 -0400
X-MC-Unique: YxgDfzIdNOiuXMw8DhN1tA-1
X-Mimecast-MFC-AGG-ID: YxgDfzIdNOiuXMw8DhN1tA_1761835790
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 766BA1954231; Thu, 30 Oct 2025 14:49:50 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.122])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 12C4F30001A1; Thu, 30 Oct 2025 14:49:48 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 devel@lists.libvirt.org
Subject: [PATCH 10/21] crypto: remove duplication loading x509 CA cert
Date: Thu, 30 Oct 2025 14:49:16 +0000
Message-ID: <20251030144927.2241109-11-berrange@redhat.com>
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

The CA cert is mandatory in both client and server scenarios.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlscredsx509.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index 08223781d7..f2f1aa2815 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -578,11 +578,14 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
 
     trace_qcrypto_tls_creds_x509_load(creds, creds->parent_obj.dir);
 
+    if (qcrypto_tls_creds_get_path(&creds->parent_obj,
+                                   QCRYPTO_TLS_CREDS_X509_CA_CERT,
+                                   true, &cacert, errp) < 0) {
+        return -1;
+    }
+
     if (isServer) {
         if (qcrypto_tls_creds_get_path(&creds->parent_obj,
-                                       QCRYPTO_TLS_CREDS_X509_CA_CERT,
-                                       true, &cacert, errp) < 0 ||
-            qcrypto_tls_creds_get_path(&creds->parent_obj,
                                        QCRYPTO_TLS_CREDS_X509_CA_CRL,
                                        false, &cacrl, errp) < 0 ||
             qcrypto_tls_creds_get_path(&creds->parent_obj,
@@ -598,9 +601,6 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
         }
     } else {
         if (qcrypto_tls_creds_get_path(&creds->parent_obj,
-                                       QCRYPTO_TLS_CREDS_X509_CA_CERT,
-                                       true, &cacert, errp) < 0 ||
-            qcrypto_tls_creds_get_path(&creds->parent_obj,
                                        QCRYPTO_TLS_CREDS_X509_CLIENT_CERT,
                                        false, &cert, errp) < 0 ||
             qcrypto_tls_creds_get_path(&creds->parent_obj,
-- 
2.51.1


