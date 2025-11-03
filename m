Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B18ECCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFunJ-0007TJ-2u; Mon, 03 Nov 2025 08:40:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFun7-0007Jw-8w
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:40:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFumz-0004UF-00
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:40:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762177197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KOG9+uSSP3D6aRKkj7S89tRtR/PRX4gBaIrL1DiPN3U=;
 b=KFbbIF6Ylpes4d2DLD4jFeHHCgDGa5VkEdJkjzlubiQNAxxW3rOxFSlPLryEL6mTQkklGQ
 hXgPE6Dp9wW6IQgVy8b0wavBmZKJIyNHLQDSLdTJ47CXiM4Cg3vh31SVg2W17yxKU0/AH7
 30QU2apdsNL8vUONgoU1sLp+ZaNwVBE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-sMoytPLCOOiFzwsZBbmVzA-1; Mon,
 03 Nov 2025 08:39:54 -0500
X-MC-Unique: sMoytPLCOOiFzwsZBbmVzA-1
X-Mimecast-MFC-AGG-ID: sMoytPLCOOiFzwsZBbmVzA_1762177193
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 868C21800673; Mon,  3 Nov 2025 13:39:53 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.202])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 77B391800576; Mon,  3 Nov 2025 13:39:45 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 19/32] crypto: move release of DH parameters into TLS creds
 parent
Date: Mon,  3 Nov 2025 13:37:13 +0000
Message-ID: <20251103133727.423041-20-berrange@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The code for releasing DH parameters is common to all credential
subclasses, and the unload function is only called from the
finalizers, except for x509 reload, so can be moved into the
parent with a little update of the reload method.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlscreds.c     | 6 ++++++
 crypto/tlscredsanon.c | 4 ----
 crypto/tlscredspsk.c  | 4 ----
 crypto/tlscredsx509.c | 7 +++----
 4 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
index 65e97ddd11..a9e0caf864 100644
--- a/crypto/tlscreds.c
+++ b/crypto/tlscreds.c
@@ -246,6 +246,12 @@ qcrypto_tls_creds_finalize(Object *obj)
 {
     QCryptoTLSCreds *creds = QCRYPTO_TLS_CREDS(obj);
 
+#ifdef CONFIG_GNUTLS
+    if (creds->dh_params) {
+        gnutls_dh_params_deinit(creds->dh_params);
+    }
+#endif
+
     g_free(creds->dir);
     g_free(creds->priority);
 }
diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c
index bc3351b5d6..1ddfe4eb31 100644
--- a/crypto/tlscredsanon.c
+++ b/crypto/tlscredsanon.c
@@ -92,10 +92,6 @@ qcrypto_tls_creds_anon_unload(QCryptoTLSCredsAnon *creds)
             creds->data.server = NULL;
         }
     }
-    if (creds->parent_obj.dh_params) {
-        gnutls_dh_params_deinit(creds->parent_obj.dh_params);
-        creds->parent_obj.dh_params = NULL;
-    }
 }
 
 #else /* ! CONFIG_GNUTLS */
diff --git a/crypto/tlscredspsk.c b/crypto/tlscredspsk.c
index 545d3e45db..bf4efe2114 100644
--- a/crypto/tlscredspsk.c
+++ b/crypto/tlscredspsk.c
@@ -175,10 +175,6 @@ qcrypto_tls_creds_psk_unload(QCryptoTLSCredsPSK *creds)
             creds->data.server = NULL;
         }
     }
-    if (creds->parent_obj.dh_params) {
-        gnutls_dh_params_deinit(creds->parent_obj.dh_params);
-        creds->parent_obj.dh_params = NULL;
-    }
 }
 
 #else /* ! CONFIG_GNUTLS */
diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index 2519f7690b..d93905ec77 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -684,10 +684,6 @@ qcrypto_tls_creds_x509_unload(QCryptoTLSCredsX509 *creds)
         gnutls_certificate_free_credentials(creds->data);
         creds->data = NULL;
     }
-    if (creds->parent_obj.dh_params) {
-        gnutls_dh_params_deinit(creds->parent_obj.dh_params);
-        creds->parent_obj.dh_params = NULL;
-    }
 }
 
 
@@ -779,6 +775,9 @@ qcrypto_tls_creds_x509_reload(QCryptoTLSCreds *creds, Error **errp)
     qcrypto_tls_creds_x509_load(x509_creds, &local_err);
     if (local_err) {
         qcrypto_tls_creds_x509_unload(x509_creds);
+        if (creds->dh_params) {
+            gnutls_dh_params_deinit(creds->dh_params);
+        }
         x509_creds->data = creds_data;
         creds->dh_params = creds_dh_params;
         error_propagate(errp, local_err);
-- 
2.51.1


