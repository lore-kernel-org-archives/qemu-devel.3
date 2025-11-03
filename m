Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE19CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFunV-0008OZ-KE; Mon, 03 Nov 2025 08:40:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFunO-00084c-Qy
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:40:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFunD-0004hr-FW
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:40:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762177217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uxplcqBeO5TK/O1vG96dCc9o/MZOP5qDpwqGEsIrzlI=;
 b=Zj50rHHrvnvi0QHXXQNg/iaxE2aAxaQ3Vm7YeVNH3Reu0slrm41oAXwYZ9WTkWG1t88EC6
 5dqjvcfBM6I5245bKh85e0FojS2s0txxfgjAn0nU54UvBJ+Fy76eONMqucVWqPNJDhFTDW
 faxZgftNNno8tItGmlZGMpti6W8smBM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-agtK9y-NMy2fz7rub9LaJg-1; Mon,
 03 Nov 2025 08:40:15 -0500
X-MC-Unique: agtK9y-NMy2fz7rub9LaJg-1
X-Mimecast-MFC-AGG-ID: agtK9y-NMy2fz7rub9LaJg_1762177214
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D886A1953953; Mon,  3 Nov 2025 13:40:13 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.202])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3168B1800576; Mon,  3 Nov 2025 13:40:08 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 22/32] crypto: reduce duplication in handling TLS priority
 strings
Date: Mon,  3 Nov 2025 13:37:16 +0000
Message-ID: <20251103133727.423041-23-berrange@redhat.com>
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
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The logic for setting the TLS priority string on a session object has a
significant amount of logic duplication across the different credential
types. By recording the extra priority string suffix against the
credential class, we can introduce a common method for building the
priority string. The TLS session can now set the priority string without
caring about the credential type.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlscreds.c         | 15 ++++++++++
 crypto/tlscredsanon.c     |  2 ++
 crypto/tlscredspsk.c      |  2 ++
 crypto/tlssession.c       | 60 ++++++---------------------------------
 include/crypto/tlscreds.h | 13 +++++++++
 5 files changed, 41 insertions(+), 51 deletions(-)

diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
index a9e0caf864..c302b3cd72 100644
--- a/crypto/tlscreds.c
+++ b/crypto/tlscreds.c
@@ -268,6 +268,21 @@ bool qcrypto_tls_creds_check_endpoint(QCryptoTLSCreds *creds,
     return true;
 }
 
+
+char *qcrypto_tls_creds_get_priority(QCryptoTLSCreds *creds)
+{
+    QCryptoTLSCredsClass *tcc = QCRYPTO_TLS_CREDS_GET_CLASS(creds);
+    const char *priorityBase =
+        creds->priority ? creds->priority : CONFIG_TLS_PRIORITY;
+
+    if (tcc->prioritySuffix) {
+        return g_strdup_printf("%s:%s", priorityBase, tcc->prioritySuffix);
+    } else {
+        return g_strdup(priorityBase);
+    }
+}
+
+
 static const TypeInfo qcrypto_tls_creds_info = {
     .parent = TYPE_OBJECT,
     .name = TYPE_QCRYPTO_TLS_CREDS,
diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c
index 1ddfe4eb31..5c55b07b2f 100644
--- a/crypto/tlscredsanon.c
+++ b/crypto/tlscredsanon.c
@@ -137,8 +137,10 @@ static void
 qcrypto_tls_creds_anon_class_init(ObjectClass *oc, const void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
+    QCryptoTLSCredsClass *tcc = QCRYPTO_TLS_CREDS_CLASS(oc);
 
     ucc->complete = qcrypto_tls_creds_anon_complete;
+    tcc->prioritySuffix = "+ANON-DH";
 }
 
 
diff --git a/crypto/tlscredspsk.c b/crypto/tlscredspsk.c
index bf4efe2114..6c2feae077 100644
--- a/crypto/tlscredspsk.c
+++ b/crypto/tlscredspsk.c
@@ -240,8 +240,10 @@ static void
 qcrypto_tls_creds_psk_class_init(ObjectClass *oc, const void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
+    QCryptoTLSCredsClass *tcc = QCRYPTO_TLS_CREDS_CLASS(oc);
 
     ucc->complete = qcrypto_tls_creds_psk_complete;
+    tcc->prioritySuffix = "+ECDHE-PSK:+DHE-PSK:+PSK";
 
     object_class_property_add_str(oc, "username",
                                   qcrypto_tls_creds_psk_prop_get_username,
diff --git a/crypto/tlssession.c b/crypto/tlssession.c
index 92fe4f0380..77f334add3 100644
--- a/crypto/tlssession.c
+++ b/crypto/tlssession.c
@@ -155,9 +155,6 @@ qcrypto_tls_session_pull(void *opaque, void *buf, size_t len)
     }
 }
 
-#define TLS_PRIORITY_ADDITIONAL_ANON "+ANON-DH"
-#define TLS_PRIORITY_ADDITIONAL_PSK "+ECDHE-PSK:+DHE-PSK:+PSK"
-
 QCryptoTLSSession *
 qcrypto_tls_session_new(QCryptoTLSCreds *creds,
                         const char *hostname,
@@ -167,6 +164,7 @@ qcrypto_tls_session_new(QCryptoTLSCreds *creds,
 {
     QCryptoTLSSession *session;
     int ret;
+    g_autofree char *prio = NULL;
 
     session = g_new0(QCryptoTLSSession, 1);
     trace_qcrypto_tls_session_new(
@@ -200,28 +198,17 @@ qcrypto_tls_session_new(QCryptoTLSCreds *creds,
         goto error;
     }
 
+    prio = qcrypto_tls_creds_get_priority(creds);
+    ret = gnutls_priority_set_direct(session->handle, prio, NULL);
+    if (ret < 0) {
+        error_setg(errp, "Unable to set TLS session priority %s: %s",
+                   prio, gnutls_strerror(ret));
+        goto error;
+    }
+
     if (object_dynamic_cast(OBJECT(creds),
                             TYPE_QCRYPTO_TLS_CREDS_ANON)) {
         QCryptoTLSCredsAnon *acreds = QCRYPTO_TLS_CREDS_ANON(creds);
-        char *prio;
-
-        if (creds->priority != NULL) {
-            prio = g_strdup_printf("%s:%s",
-                                   creds->priority,
-                                   TLS_PRIORITY_ADDITIONAL_ANON);
-        } else {
-            prio = g_strdup(CONFIG_TLS_PRIORITY ":"
-                            TLS_PRIORITY_ADDITIONAL_ANON);
-        }
-
-        ret = gnutls_priority_set_direct(session->handle, prio, NULL);
-        if (ret < 0) {
-            error_setg(errp, "Unable to set TLS session priority %s: %s",
-                       prio, gnutls_strerror(ret));
-            g_free(prio);
-            goto error;
-        }
-        g_free(prio);
         if (creds->endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
             ret = gnutls_credentials_set(session->handle,
                                          GNUTLS_CRD_ANON,
@@ -239,25 +226,6 @@ qcrypto_tls_session_new(QCryptoTLSCreds *creds,
     } else if (object_dynamic_cast(OBJECT(creds),
                                    TYPE_QCRYPTO_TLS_CREDS_PSK)) {
         QCryptoTLSCredsPSK *pcreds = QCRYPTO_TLS_CREDS_PSK(creds);
-        char *prio;
-
-        if (creds->priority != NULL) {
-            prio = g_strdup_printf("%s:%s",
-                                   creds->priority,
-                                   TLS_PRIORITY_ADDITIONAL_PSK);
-        } else {
-            prio = g_strdup(CONFIG_TLS_PRIORITY ":"
-                            TLS_PRIORITY_ADDITIONAL_PSK);
-        }
-
-        ret = gnutls_priority_set_direct(session->handle, prio, NULL);
-        if (ret < 0) {
-            error_setg(errp, "Unable to set TLS session priority %s: %s",
-                       prio, gnutls_strerror(ret));
-            g_free(prio);
-            goto error;
-        }
-        g_free(prio);
         if (creds->endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
             ret = gnutls_credentials_set(session->handle,
                                          GNUTLS_CRD_PSK,
@@ -275,17 +243,7 @@ qcrypto_tls_session_new(QCryptoTLSCreds *creds,
     } else if (object_dynamic_cast(OBJECT(creds),
                                    TYPE_QCRYPTO_TLS_CREDS_X509)) {
         QCryptoTLSCredsX509 *tcreds = QCRYPTO_TLS_CREDS_X509(creds);
-        const char *prio = creds->priority;
-        if (!prio) {
-            prio = CONFIG_TLS_PRIORITY;
-        }
 
-        ret = gnutls_priority_set_direct(session->handle, prio, NULL);
-        if (ret < 0) {
-            error_setg(errp, "Cannot set default TLS session priority %s: %s",
-                       prio, gnutls_strerror(ret));
-            goto error;
-        }
         ret = gnutls_credentials_set(session->handle,
                                      GNUTLS_CRD_CERTIFICATE,
                                      tcreds->data);
diff --git a/include/crypto/tlscreds.h b/include/crypto/tlscreds.h
index 2a8a857010..afd1016088 100644
--- a/include/crypto/tlscreds.h
+++ b/include/crypto/tlscreds.h
@@ -47,6 +47,7 @@ typedef bool (*CryptoTLSCredsReload)(QCryptoTLSCreds *, Error **);
 struct QCryptoTLSCredsClass {
     ObjectClass parent_class;
     CryptoTLSCredsReload reload;
+    const char *prioritySuffix;
 };
 
 /**
@@ -64,4 +65,16 @@ bool qcrypto_tls_creds_check_endpoint(QCryptoTLSCreds *creds,
                                       QCryptoTLSCredsEndpoint endpoint,
                                       Error **errp);
 
+
+/**
+ * qcrypto_tls_creds_get_priority:
+ * @creds: pointer to a TLS credentials object
+ *
+ * Get the TLS credentials priority string. The caller
+ * must free the returned string when no longer required.
+ *
+ * Returns: a non-NULL priority string
+ */
+char *qcrypto_tls_creds_get_priority(QCryptoTLSCreds *creds);
+
 #endif /* QCRYPTO_TLSCREDS_H */
-- 
2.51.1


