Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D821ECCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFunf-0000MP-JD; Mon, 03 Nov 2025 08:40:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFunX-0008Va-4X
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:40:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFunN-0004iY-Fb
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:40:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762177222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aZOsUq436Ugr8X1RKjdBYkhL68FnICgV1ZP0VKPzx30=;
 b=WbUIZwZuVhREPalIpmMhJM+GajnU0IN9fUO7qjCJblIpWbTAF0Y6BotnbVJrue3F60YBqk
 JlH3rADLWHnHNBDcCVDO9kWUZRHnnOyrbcWDt0XoydKH8EDOrNAa7hEQhYvyfMO7+h1JDo
 OKXe8qBn4f/AOB0ZdtKR8zij27Gv0zc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-UszjXLJkP0KyWWbuE3d85Q-1; Mon,
 03 Nov 2025 08:40:21 -0500
X-MC-Unique: UszjXLJkP0KyWWbuE3d85Q-1
X-Mimecast-MFC-AGG-ID: UszjXLJkP0KyWWbuE3d85Q_1762177220
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E58B7180899E; Mon,  3 Nov 2025 13:40:18 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.202])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7295C1800581; Mon,  3 Nov 2025 13:40:14 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 23/32] crypto: introduce method for reloading TLS creds
Date: Mon,  3 Nov 2025 13:37:17 +0000
Message-ID: <20251103133727.423041-24-berrange@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This prevents direct access of the class members by the VNC
display code.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlscreds.c         | 15 +++++++++++++++
 include/crypto/tlscreds.h | 13 +++++++++++++
 ui/vnc.c                  |  9 +--------
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
index c302b3cd72..0db9bf6eeb 100644
--- a/crypto/tlscreds.c
+++ b/crypto/tlscreds.c
@@ -283,6 +283,21 @@ char *qcrypto_tls_creds_get_priority(QCryptoTLSCreds *creds)
 }
 
 
+bool qcrypto_tls_creds_reload(QCryptoTLSCreds *creds,
+                              Error **errp)
+{
+    QCryptoTLSCredsClass *credscls = QCRYPTO_TLS_CREDS_GET_CLASS(creds);
+
+    if (credscls->reload) {
+        return credscls->reload(creds, errp);
+    }
+
+    error_setg(errp, "%s does not support reloading credentials",
+               object_get_typename(OBJECT(creds)));
+    return false;
+}
+
+
 static const TypeInfo qcrypto_tls_creds_info = {
     .parent = TYPE_OBJECT,
     .name = TYPE_QCRYPTO_TLS_CREDS,
diff --git a/include/crypto/tlscreds.h b/include/crypto/tlscreds.h
index afd1016088..bb9280ed1a 100644
--- a/include/crypto/tlscreds.h
+++ b/include/crypto/tlscreds.h
@@ -77,4 +77,17 @@ bool qcrypto_tls_creds_check_endpoint(QCryptoTLSCreds *creds,
  */
 char *qcrypto_tls_creds_get_priority(QCryptoTLSCreds *creds);
 
+
+/**
+ * qcrypto_tls_creds_reload:
+ * @creds: pointer to a TLS credentials object
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Request a reload of the TLS credentials, if supported
+ *
+ * Returns: true on success, false on error or if not supported
+ */
+bool qcrypto_tls_creds_reload(QCryptoTLSCreds *creds,
+                              Error **errp);
+
 #endif /* QCRYPTO_TLSCREDS_H */
diff --git a/ui/vnc.c b/ui/vnc.c
index 0094ec680c..50016ff7ab 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -578,7 +578,6 @@ VncInfo2List *qmp_query_vnc_servers(Error **errp)
 bool vnc_display_reload_certs(const char *id, Error **errp)
 {
     VncDisplay *vd = vnc_display_find(id);
-    QCryptoTLSCredsClass *creds = NULL;
 
     if (!vd) {
         error_setg(errp, "Can not find vnc display");
@@ -590,13 +589,7 @@ bool vnc_display_reload_certs(const char *id, Error **errp)
         return false;
     }
 
-    creds = QCRYPTO_TLS_CREDS_GET_CLASS(OBJECT(vd->tlscreds));
-    if (creds->reload == NULL) {
-        error_setg(errp, "%s doesn't support to reload TLS credential",
-                   object_get_typename(OBJECT(vd->tlscreds)));
-        return false;
-    }
-    if (!creds->reload(vd->tlscreds, errp)) {
+    if (!qcrypto_tls_creds_reload(vd->tlscreds, errp)) {
         return false;
     }
 
-- 
2.51.1


