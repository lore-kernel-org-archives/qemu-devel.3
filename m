Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02447CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHeUH-0001El-AG; Fri, 16 Oct 2026 05:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHeU8-00012a-H4
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:44:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHeU6-0007ML-9M
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792143857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+z/6pd1mL9+sJnkC4FYFKbajf/obk9AlwHYoGvARpXo=;
 b=SbzMlaBO2kL8vtwzIEptXlc2rF7nDQmdieNQRtmjs8vPaDldyfI5+kz9BoiXlarSbn0J/k
 t3NiF6nWGw7JagbXr9T+BQfyPNLIt5eXRYvLcZQl/b6G9Nj+j0ayN7SSvTvZfaL0H+hAWO
 yqJwoCGMvMJIw9JUK2bgEWHmf0xnCW8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-v-EQoZu8MgibayR1aCoYvg-1; Fri,
 16 Oct 2026 09:44:07 +0000
X-MC-Unique: v-EQoZu8MgibayR1aCoYvg-1
X-Mimecast-MFC-AGG-ID: v-EQoZu8MgibayR1aCoYvg_1792143846
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8BE21800665; Fri, 16 Oct 2026 09:44:06 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 27C6E3000C00; Fri, 16 Oct 2026 09:44:04 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 8/8] Revert "crypto: implement workaround for GNUTLS thread
 safety problems"
Date: Fri, 16 Oct 2026 10:43:48 +0100
Message-ID: <20261016094348.2616374-9-berrange@redhat.com>
In-Reply-To: <20261016094348.2616374-1-berrange@redhat.com>
References: <20261016094348.2616374-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This reverts commit 24ad5e19952b326796c8a3a1595c57ff180dab84.

The workaround for the GNUTLS bug was not correct and it was
decided to rely on GNUTLS being patched by distros instead,
or users manually disabling use of the problematic ciphers.

Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlssession.c         | 92 ++-----------------------------------
 include/crypto/tlssession.h | 14 ------
 meson.build                 |  9 ----
 3 files changed, 3 insertions(+), 112 deletions(-)

diff --git a/crypto/tlssession.c b/crypto/tlssession.c
index 9450c83d9c3..0e9ca9fae0f 100644
--- a/crypto/tlssession.c
+++ b/crypto/tlssession.c
@@ -19,7 +19,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/thread.h"
 #include "crypto/tlssession.h"
 #include "crypto/tlscredsanon.h"
 #include "crypto/tlscredspsk.h"
@@ -53,14 +52,6 @@ struct QCryptoTLSSession {
      */
     Error *rerr;
     Error *werr;
-
-    /*
-     * Used to protect against broken GNUTLS thread safety
-     * https://gitlab.com/gnutls/gnutls/-/issues/1717
-     */
-    bool requireThreadSafety;
-    bool lockEnabled;
-    QemuMutex lock;
 };
 
 
@@ -80,7 +71,6 @@ qcrypto_tls_session_free(QCryptoTLSSession *session)
     g_free(session->authzid);
     qcrypto_tls_creds_box_unref(session->credsbox);
     object_unref(OBJECT(session->creds));
-    qemu_mutex_destroy(&session->lock);
     g_free(session);
 }
 
@@ -96,19 +86,10 @@ qcrypto_tls_session_push(void *opaque, const void *buf, size_t len)
         return -1;
     };
 
-    if (session->lockEnabled) {
-        qemu_mutex_unlock(&session->lock);
-    }
-
     error_free(session->werr);
     session->werr = NULL;
 
     ret = session->writeFunc(buf, len, session->opaque, &session->werr);
-
-    if (session->lockEnabled) {
-        qemu_mutex_lock(&session->lock);
-    }
-
     if (ret == QCRYPTO_TLS_SESSION_ERR_BLOCK) {
         errno = EAGAIN;
         return -1;
@@ -135,16 +116,7 @@ qcrypto_tls_session_pull(void *opaque, void *buf, size_t len)
     error_free(session->rerr);
     session->rerr = NULL;
 
-    if (session->lockEnabled) {
-        qemu_mutex_unlock(&session->lock);
-    }
-
     ret = session->readFunc(buf, len, session->opaque, &session->rerr);
-
-    if (session->lockEnabled) {
-        qemu_mutex_lock(&session->lock);
-    }
-
     if (ret == QCRYPTO_TLS_SESSION_ERR_BLOCK) {
         errno = EAGAIN;
         return -1;
@@ -181,8 +153,6 @@ qcrypto_tls_session_new(QCryptoTLSCreds *creds,
     session->creds = creds;
     object_ref(OBJECT(creds));
 
-    qemu_mutex_init(&session->lock);
-
     if (creds->endpoint != endpoint) {
         error_setg(errp, "Credentials endpoint doesn't match session");
         goto error;
@@ -247,11 +217,6 @@ qcrypto_tls_session_new(QCryptoTLSCreds *creds,
     return NULL;
 }
 
-void qcrypto_tls_session_require_thread_safety(QCryptoTLSSession *sess)
-{
-    sess->requireThreadSafety = true;
-}
-
 static int
 qcrypto_tls_session_check_certificate(QCryptoTLSSession *session,
                                       Error **errp)
@@ -438,17 +403,7 @@ qcrypto_tls_session_write(QCryptoTLSSession *session,
                           size_t len,
                           Error **errp)
 {
-    ssize_t ret;
-
-    if (session->lockEnabled) {
-        qemu_mutex_lock(&session->lock);
-    }
-
-    ret = gnutls_record_send(session->handle, buf, len);
-
-    if (session->lockEnabled) {
-        qemu_mutex_unlock(&session->lock);
-    }
+    ssize_t ret = gnutls_record_send(session->handle, buf, len);
 
     if (ret < 0) {
         if (ret == GNUTLS_E_AGAIN) {
@@ -476,17 +431,7 @@ qcrypto_tls_session_read(QCryptoTLSSession *session,
                          size_t len,
                          Error **errp)
 {
-    ssize_t ret;
-
-    if (session->lockEnabled) {
-        qemu_mutex_lock(&session->lock);
-    }
-
-    ret = gnutls_record_recv(session->handle, buf, len);
-
-    if (session->lockEnabled) {
-        qemu_mutex_unlock(&session->lock);
-    }
+    ssize_t ret = gnutls_record_recv(session->handle, buf, len);
 
     if (ret < 0) {
         if (ret == GNUTLS_E_AGAIN) {
@@ -556,29 +501,8 @@ int
 qcrypto_tls_session_handshake(QCryptoTLSSession *session,
                               Error **errp)
 {
-    int ret;
-    ret = gnutls_handshake(session->handle);
-
+    int ret = gnutls_handshake(session->handle);
     if (!ret) {
-#ifdef CONFIG_GNUTLS_BUG1717_WORKAROUND
-        gnutls_cipher_algorithm_t cipher =
-            gnutls_cipher_get(session->handle);
-
-        /*
-         * Any use of rekeying in TLS 1.3 is unsafe for
-         * a gnutls with bug 1717, however, we know that
-         * QEMU won't initiate manual rekeying. Thus we
-         * only have to protect against automatic rekeying
-         * which doesn't trigger with CHACHA20
-         */
-        if (session->requireThreadSafety &&
-            gnutls_protocol_get_version(session->handle) ==
-            GNUTLS_TLS1_3 &&
-            cipher != GNUTLS_CIPHER_CHACHA20_POLY1305) {
-            session->lockEnabled = true;
-        }
-#endif
-
         session->handshakeComplete = true;
         return QCRYPTO_TLS_HANDSHAKE_COMPLETE;
     }
@@ -616,15 +540,8 @@ qcrypto_tls_session_bye(QCryptoTLSSession *session, Error **errp)
         return 0;
     }
 
-    if (session->lockEnabled) {
-        qemu_mutex_lock(&session->lock);
-    }
     ret = gnutls_bye(session->handle, GNUTLS_SHUT_WR);
 
-    if (session->lockEnabled) {
-        qemu_mutex_unlock(&session->lock);
-    }
-
     if (!ret) {
         return QCRYPTO_TLS_BYE_COMPLETE;
     }
@@ -690,9 +607,6 @@ qcrypto_tls_session_new(QCryptoTLSCreds *creds G_GNUC_UNUSED,
     return NULL;
 }
 
-void qcrypto_tls_session_require_thread_safety(QCryptoTLSSession *sess)
-{
-}
 
 void
 qcrypto_tls_session_free(QCryptoTLSSession *sess G_GNUC_UNUSED)
diff --git a/include/crypto/tlssession.h b/include/crypto/tlssession.h
index 5415503ebab..274f4fd07ac 100644
--- a/include/crypto/tlssession.h
+++ b/include/crypto/tlssession.h
@@ -166,20 +166,6 @@ void qcrypto_tls_session_free(QCryptoTLSSession *sess);
 
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoTLSSession, qcrypto_tls_session_free)
 
-/**
- * qcrypto_tls_session_require_thread_safety:
- * @sess: the TLS session object
- *
- * Mark that this TLS session will require thread safety
- * for concurrent I/O in both directions. This must be
- * called before the handshake is performed.
- *
- * This will activate a workaround for GNUTLS thread
- * safety issues, where appropriate for the negotiated
- * TLS session parameters.
- */
-void qcrypto_tls_session_require_thread_safety(QCryptoTLSSession *sess);
-
 /**
  * qcrypto_tls_session_check_credentials:
  * @sess: the TLS session object
diff --git a/meson.build b/meson.build
index 255c887e8e6..1dd0d6392c9 100644
--- a/meson.build
+++ b/meson.build
@@ -1795,18 +1795,11 @@ endif
 
 gnutls = not_found
 gnutls_crypto = not_found
-gnutls_bug1717_workaround = false
 if get_option('gnutls').enabled() or (get_option('gnutls').auto() and have_system)
   gnutls = dependency('gnutls', version: '>=3.7.5',
                       method: 'pkg-config',
                       required: get_option('gnutls'))
   gnutls_crypto = gnutls
-
-  #if gnutls.found() and not get_option('gnutls-bug1717-workaround').disabled()
-    # XXX: when bug 1717 is resolved, add logic to probe for
-    # the GNUTLS fixed version number to handle the 'auto' case
-  #  gnutls_bug1717_workaround = true
-  #endif
 endif
 
 # We prefer use of gnutls for crypto, unless the options
@@ -2533,7 +2526,6 @@ config_host_data.set('CONFIG_KEYUTILS', keyutils.found())
 config_host_data.set('CONFIG_GETTID', has_gettid)
 config_host_data.set('CONFIG_GNUTLS', gnutls.found())
 config_host_data.set('CONFIG_GNUTLS_CRYPTO', gnutls_crypto.found())
-config_host_data.set('CONFIG_GNUTLS_BUG1717_WORKAROUND', gnutls_bug1717_workaround)
 config_host_data.set('CONFIG_TASN1', tasn1.found())
 config_host_data.set('CONFIG_GCRYPT', gcrypt.found())
 config_host_data.set('CONFIG_NETTLE', nettle.found())
@@ -4906,7 +4898,6 @@ summary_info += {'TLS priority':      get_option('tls_priority')}
 summary_info += {'GNUTLS support':    gnutls}
 if gnutls.found()
   summary_info += {'  GNUTLS crypto':   gnutls_crypto.found()}
-  summary_info += {'  GNUTLS bug 1717 workaround': gnutls_bug1717_workaround }
 endif
 summary_info += {'libgcrypt':         gcrypt}
 summary_info += {'nettle':            nettle}
-- 
2.56.0


