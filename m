Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41637CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 14:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vETx4-0008RW-W0; Thu, 30 Oct 2025 10:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vETwz-0008Ls-5b
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:48:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vETwu-0001KQ-QV
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761835701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IMJuSZEo3BXsqMSLuhmXkaE3L5ZQCca3i5r8L+BsH1k=;
 b=e0wYuDDqb7A2VURnEvCEvXtstT5qWzM1S7acE47L/uq3HZgzd0Hk2Itt1gAcM7I1lL+xpU
 6uoB6oCe8MT7cF3ivpP9sESXDPzP8i34+ycNeQZn1rhLyVaYs+1auiW7Qk2hvK0gO1moH7
 vwCwqFKEMLwxs31FkngzrmK2GW/x+60=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-s9z6LJSbMdGHOMA8OQNuGg-1; Thu,
 30 Oct 2025 10:48:17 -0400
X-MC-Unique: s9z6LJSbMdGHOMA8OQNuGg-1
X-Mimecast-MFC-AGG-ID: s9z6LJSbMdGHOMA8OQNuGg_1761835696
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1AC251953989; Thu, 30 Oct 2025 14:48:16 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.122])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C30321800583; Thu, 30 Oct 2025 14:48:14 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org
Subject: [PATCH 04/21] crypto: remove redundant access() checks before loading
 certs
Date: Thu, 30 Oct 2025 14:47:48 +0000
Message-ID: <20251030144805.2239954-5-berrange@redhat.com>
In-Reply-To: <20251030144805.2239954-1-berrange@redhat.com>
References: <20251030144805.2239954-1-berrange@redhat.com>
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

The qcrypto_tls_creds_get_path method will perform an access()
check on the file and return a NULL path if it fails. By the
time we get to loading the cert files we know they must exist
on disk and thus the second access() check is redundant.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlscredsx509.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index 75c70af522..0acb17b6ec 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -496,8 +496,7 @@ qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509 *creds,
     size_t i;
     int ret = -1;
 
-    if (certFile &&
-        access(certFile, R_OK) == 0) {
+    if (certFile) {
         if (qcrypto_tls_creds_load_cert_list(creds,
                                              certFile,
                                              &certs,
@@ -508,16 +507,15 @@ qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509 *creds,
             goto cleanup;
         }
     }
-    if (access(cacertFile, R_OK) == 0) {
-        if (qcrypto_tls_creds_load_cert_list(creds,
-                                             cacertFile,
-                                             &cacerts,
-                                             &ncacerts,
-                                             isServer,
-                                             true,
-                                             errp) < 0) {
-            goto cleanup;
-        }
+
+    if (qcrypto_tls_creds_load_cert_list(creds,
+                                         cacertFile,
+                                         &cacerts,
+                                         &ncacerts,
+                                         isServer,
+                                         true,
+                                         errp) < 0) {
+        goto cleanup;
     }
 
     for (i = 0; i < ncerts; i++) {
-- 
2.51.1


