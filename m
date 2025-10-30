Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE9FCCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 14:54:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vETyn-0001La-Ku; Thu, 30 Oct 2025 10:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vETyk-0001Am-Aq
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:50:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vETyS-0001T6-D9
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761835798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PrE8bgi9PjoBLwGNc3WEHWoyWqp5DjsEI2dDgZnafyA=;
 b=PJYN9c3itjghvF7yYiMk8Qzooxrq1IZjBmc1rW5ZIovjOWDzOgcw2yC1NBldjQn6pi01Gd
 eRYYBNuWgCW4p6UZS+SrOwmzsbND+8tJ10WBbjJ8h8+D9NarD0t2ZVAZBLZgRyPcDbMyDk
 Tsmja9b+N1EwQMVRAP6qaDcJJVHOZUU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-gbsvE6fCPhuGrv-GWeNUxw-1; Thu,
 30 Oct 2025 10:49:56 -0400
X-MC-Unique: gbsvE6fCPhuGrv-GWeNUxw-1
X-Mimecast-MFC-AGG-ID: gbsvE6fCPhuGrv-GWeNUxw_1761835794
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F17C61801A13; Thu, 30 Oct 2025 14:49:53 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.122])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8C16930001A1; Thu, 30 Oct 2025 14:49:52 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 devel@lists.libvirt.org
Subject: [PATCH 12/21] crypto: introduce method for reloading TLS creds
Date: Thu, 30 Oct 2025 14:49:18 +0000
Message-ID: <20251030144927.2241109-13-berrange@redhat.com>
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
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlscreds.c         | 15 +++++++++++++++
 include/crypto/tlscreds.h | 13 +++++++++++++
 ui/vnc.c                  |  9 +--------
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
index 49c7eb46a5..9433b4c363 100644
--- a/crypto/tlscreds.c
+++ b/crypto/tlscreds.c
@@ -281,6 +281,21 @@ char *qcrypto_tls_creds_get_priority(QCryptoTLSCreds *creds)
 }
 
 
+bool qcrypto_tls_creds_reload(QCryptoTLSCreds *creds,
+                              Error **errp)
+{
+    QCryptoTLSCredsClass *credscls = QCRYPTO_TLS_CREDS_GET_CLASS(OBJECT(creds));
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
index 77c823bf2e..6b32dd0fe9 100644
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


