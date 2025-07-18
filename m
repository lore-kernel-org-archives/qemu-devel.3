Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60506C83F3B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 15:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucmmo-0008Cg-Ht; Fri, 18 Jul 2025 11:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ucmeR-0007s2-0C
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 11:05:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ucmeO-0003rt-42
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 11:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752851126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HMQIIVlJxp52OaY7ElfmvLHEZ9tkVbCE+uGzlMGGpFc=;
 b=XkmQn6ukFeXhSE9Cm4jUBe7qujbtiJxwzp043O7RTfIVmS/p1f1+iho5EzoZpR8IBVyggN
 +fRxqFk9FAgup9MTRc/eM8AiAw/OCgGOiuoulOVA28eZ5WzJbL2Jlb0OXWJ5P0BAAFr9Kd
 Kee+9X7PFb1d1V/OcPnY1GHXscDxq08=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-ooiAIwZ_ODqOT51J0fQS9Q-1; Fri,
 18 Jul 2025 11:05:23 -0400
X-MC-Unique: ooiAIwZ_ODqOT51J0fQS9Q-1
X-Mimecast-MFC-AGG-ID: ooiAIwZ_ODqOT51J0fQS9Q_1752851122
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0718119560B5; Fri, 18 Jul 2025 15:05:22 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.137])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A3406195608D; Fri, 18 Jul 2025 15:05:19 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 1/4] crypto: implement workaround for GNUTLS thread safety
 problems
Date: Fri, 18 Jul 2025 16:05:11 +0100
Message-ID: <20250718150514.2635338-2-berrange@redhat.com>
In-Reply-To: <20250718150514.2635338-1-berrange@redhat.com>
References: <20250718150514.2635338-1-berrange@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When TLS 1.3 is negotiated on a TLS session, GNUTLS will perform
automatic rekeying of the session after 16 million records. This
is done for all algorithms except CHACHA20_POLY1305 which does
not require rekeying.

Unfortunately the rekeying breaks GNUTLS' promise that it is safe
to use a gnutls_session_t object concurrently from multiple threads
if they are exclusively calling gnutls_record_send/recv.

This patch implements a workaround for QEMU that adds a mutex lock
around any gnutls_record_send/recv call to serialize execution
within GNUTLS code. When GNUTLS calls into the push/pull functions
we can release the lock so the OS level I/O calls can at least
have some parallelism.

The big downside of this is that the actual encryption/decryption
code is fully serialized, which will halve performance of that
cipher operations if two threads are contending.

The workaround is not enabled by default, since most use of GNUTLS
in QEMU does not tickle the problem, only non-multifd migration
with a return path open is affected. Fortunately the migration
code also won't trigger the halving of performance, since only
the outbound channel diretion needs to sustain high data rates,
the inbound direction is low volume.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlssession.c           | 89 +++++++++++++++++++++++++++++++++--
 include/crypto/tlssession.h   | 14 ++++++
 meson.build                   |  9 ++++
 meson_options.txt             |  2 +
 scripts/meson-buildoptions.sh |  5 ++
 5 files changed, 116 insertions(+), 3 deletions(-)

diff --git a/crypto/tlssession.c b/crypto/tlssession.c
index 6d8f8df623..939f69bdb3 100644
--- a/crypto/tlssession.c
+++ b/crypto/tlssession.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/thread.h"
 #include "crypto/tlssession.h"
 #include "crypto/tlscredsanon.h"
 #include "crypto/tlscredspsk.h"
@@ -51,6 +52,14 @@ struct QCryptoTLSSession {
      */
     Error *rerr;
     Error *werr;
+
+    /*
+     * Used to protect against broken GNUTLS thread safety
+     * https://gitlab.com/gnutls/gnutls/-/issues/1717
+     */
+    bool requireThreadSafety;
+    bool lockEnabled;
+    QemuMutex lock;
 };
 
 
@@ -69,6 +78,7 @@ qcrypto_tls_session_free(QCryptoTLSSession *session)
     g_free(session->peername);
     g_free(session->authzid);
     object_unref(OBJECT(session->creds));
+    qemu_mutex_destroy(&session->lock);
     g_free(session);
 }
 
@@ -84,10 +94,19 @@ qcrypto_tls_session_push(void *opaque, const void *buf, size_t len)
         return -1;
     };
 
+    if (session->lockEnabled) {
+        qemu_mutex_unlock(&session->lock);
+    }
+
     error_free(session->werr);
     session->werr = NULL;
 
     ret = session->writeFunc(buf, len, session->opaque, &session->werr);
+
+    if (session->lockEnabled) {
+        qemu_mutex_lock(&session->lock);
+    }
+
     if (ret == QCRYPTO_TLS_SESSION_ERR_BLOCK) {
         errno = EAGAIN;
         return -1;
@@ -114,7 +133,16 @@ qcrypto_tls_session_pull(void *opaque, void *buf, size_t len)
     error_free(session->rerr);
     session->rerr = NULL;
 
+    if (session->lockEnabled) {
+        qemu_mutex_unlock(&session->lock);
+    }
+
     ret = session->readFunc(buf, len, session->opaque, &session->rerr);
+
+    if (session->lockEnabled) {
+        qemu_mutex_lock(&session->lock);
+    }
+
     if (ret == QCRYPTO_TLS_SESSION_ERR_BLOCK) {
         errno = EAGAIN;
         return -1;
@@ -153,6 +181,8 @@ qcrypto_tls_session_new(QCryptoTLSCreds *creds,
     session->creds = creds;
     object_ref(OBJECT(creds));
 
+    qemu_mutex_init(&session->lock);
+
     if (creds->endpoint != endpoint) {
         error_setg(errp, "Credentials endpoint doesn't match session");
         goto error;
@@ -289,6 +319,11 @@ qcrypto_tls_session_new(QCryptoTLSCreds *creds,
     return NULL;
 }
 
+void qcrypto_tls_session_require_thread_safety(QCryptoTLSSession *sess)
+{
+    sess->requireThreadSafety = true;
+}
+
 static int
 qcrypto_tls_session_check_certificate(QCryptoTLSSession *session,
                                       Error **errp)
@@ -480,7 +515,17 @@ qcrypto_tls_session_write(QCryptoTLSSession *session,
                           size_t len,
                           Error **errp)
 {
-    ssize_t ret = gnutls_record_send(session->handle, buf, len);
+    ssize_t ret;
+
+    if (session->lockEnabled) {
+        qemu_mutex_lock(&session->lock);
+    }
+
+    ret = gnutls_record_send(session->handle, buf, len);
+
+    if (session->lockEnabled) {
+        qemu_mutex_unlock(&session->lock);
+    }
 
     if (ret < 0) {
         if (ret == GNUTLS_E_AGAIN) {
@@ -509,7 +554,17 @@ qcrypto_tls_session_read(QCryptoTLSSession *session,
                          bool gracefulTermination,
                          Error **errp)
 {
-    ssize_t ret = gnutls_record_recv(session->handle, buf, len);
+    ssize_t ret;
+
+    if (session->lockEnabled) {
+        qemu_mutex_lock(&session->lock);
+    }
+
+    ret = gnutls_record_recv(session->handle, buf, len);
+
+    if (session->lockEnabled) {
+        qemu_mutex_unlock(&session->lock);
+    }
 
     if (ret < 0) {
         if (ret == GNUTLS_E_AGAIN) {
@@ -545,8 +600,29 @@ int
 qcrypto_tls_session_handshake(QCryptoTLSSession *session,
                               Error **errp)
 {
-    int ret = gnutls_handshake(session->handle);
+    int ret;
+    ret = gnutls_handshake(session->handle);
+
     if (!ret) {
+        gnutls_cipher_algorithm_t cipher =
+            gnutls_cipher_get(session->handle);
+
+#ifdef CONFIG_GNUTLS_BUG1717_WORKAROUND
+        /*
+         * Any use of rekeying in TLS 1.3 is unsafe for
+         * a gnutls with bug 1717, however, we know that
+         * QEMU won't initiate manual rekeying. Thus we
+         * only have to protect against automatic rekeying
+         * which doesn't trigger with CHACHA20
+         */
+        if (session->requireThreadSafety &&
+            gnutls_protocol_get_version(session->handle) ==
+            GNUTLS_TLS1_3 &&
+            cipher != GNUTLS_CIPHER_CHACHA20_POLY1305) {
+            session->lockEnabled = true;
+        }
+#endif
+
         session->handshakeComplete = true;
         return QCRYPTO_TLS_HANDSHAKE_COMPLETE;
     }
@@ -584,8 +660,15 @@ qcrypto_tls_session_bye(QCryptoTLSSession *session, Error **errp)
         return 0;
     }
 
+    if (session->lockEnabled) {
+        qemu_mutex_lock(&session->lock);
+    }
     ret = gnutls_bye(session->handle, GNUTLS_SHUT_WR);
 
+    if (session->lockEnabled) {
+        qemu_mutex_unlock(&session->lock);
+    }
+
     if (!ret) {
         return QCRYPTO_TLS_BYE_COMPLETE;
     }
diff --git a/include/crypto/tlssession.h b/include/crypto/tlssession.h
index d77ae0d423..2f62ce2d67 100644
--- a/include/crypto/tlssession.h
+++ b/include/crypto/tlssession.h
@@ -165,6 +165,20 @@ void qcrypto_tls_session_free(QCryptoTLSSession *sess);
 
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoTLSSession, qcrypto_tls_session_free)
 
+/**
+ * qcrypto_tls_session_require_thread_safety:
+ * @sess: the TLS session object
+ *
+ * Mark that this TLS session will require thread safety
+ * for concurrent I/O in both directions. This must be
+ * called before the handshake is performed.
+ *
+ * This will activate a workaround for GNUTLS thread
+ * safety issues, where appropriate for the negotiated
+ * TLS session parameters.
+ */
+void qcrypto_tls_session_require_thread_safety(QCryptoTLSSession *sess);
+
 /**
  * qcrypto_tls_session_check_credentials:
  * @sess: the TLS session object
diff --git a/meson.build b/meson.build
index c2bc3eeedc..e53cd5b413 100644
--- a/meson.build
+++ b/meson.build
@@ -1809,6 +1809,7 @@ endif
 
 gnutls = not_found
 gnutls_crypto = not_found
+gnutls_bug1717_workaround = false
 if get_option('gnutls').enabled() or (get_option('gnutls').auto() and have_system)
   # For general TLS support our min gnutls matches
   # that implied by our platform support matrix
@@ -1834,6 +1835,12 @@ if get_option('gnutls').enabled() or (get_option('gnutls').auto() and have_syste
                         method: 'pkg-config',
                         required: get_option('gnutls'))
   endif
+
+  if gnutls.found() and not get_option('gnutls-bug1717-workaround').disabled()
+    # XXX: when bug 1717 is resolved, add logic to probe for
+    # the GNUTLS fixed version number to handle the 'auto' case
+    gnutls_bug1717_workaround = true
+  endif
 endif
 
 # We prefer use of gnutls for crypto, unless the options
@@ -2585,6 +2592,7 @@ config_host_data.set('CONFIG_KEYUTILS', keyutils.found())
 config_host_data.set('CONFIG_GETTID', has_gettid)
 config_host_data.set('CONFIG_GNUTLS', gnutls.found())
 config_host_data.set('CONFIG_GNUTLS_CRYPTO', gnutls_crypto.found())
+config_host_data.set('CONFIG_GNUTLS_BUG1717_WORKAROUND', gnutls_bug1717_workaround)
 config_host_data.set('CONFIG_TASN1', tasn1.found())
 config_host_data.set('CONFIG_GCRYPT', gcrypt.found())
 config_host_data.set('CONFIG_NETTLE', nettle.found())
@@ -4869,6 +4877,7 @@ summary_info += {'TLS priority':      get_option('tls_priority')}
 summary_info += {'GNUTLS support':    gnutls}
 if gnutls.found()
   summary_info += {'  GNUTLS crypto':   gnutls_crypto.found()}
+  summary_info += {'  GNUTLS bug 1717 workaround': gnutls_bug1717_workaround }
 endif
 summary_info += {'libgcrypt':         gcrypt}
 summary_info += {'nettle':            nettle}
diff --git a/meson_options.txt b/meson_options.txt
index fff1521e58..dd33530750 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -174,6 +174,8 @@ option('libcbor', type : 'feature', value : 'auto',
        description: 'libcbor support')
 option('gnutls', type : 'feature', value : 'auto',
        description: 'GNUTLS cryptography support')
+option('gnutls-bug1717-workaround', type: 'feature', value : 'auto',
+       description: 'GNUTLS workaround for https://gitlab.com/gnutls/gnutls/-/issues/1717')
 option('nettle', type : 'feature', value : 'auto',
        description: 'nettle cryptography support')
 option('gcrypt', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index e8504689e8..3493952d18 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -123,6 +123,9 @@ meson_options_help() {
   printf "%s\n" '  gio             use libgio for D-Bus support'
   printf "%s\n" '  glusterfs       Glusterfs block device driver'
   printf "%s\n" '  gnutls          GNUTLS cryptography support'
+  printf "%s\n" '  gnutls-bug1717-workaround'
+  printf "%s\n" '                  GNUTLS workaround for'
+  printf "%s\n" '                  https://gitlab.com/gnutls/gnutls/-/issues/1717'
   printf "%s\n" '  gtk             GTK+ user interface'
   printf "%s\n" '  gtk-clipboard   clipboard support for the gtk UI (EXPERIMENTAL, MAY HANG)'
   printf "%s\n" '  guest-agent     Build QEMU Guest Agent'
@@ -331,6 +334,8 @@ _meson_option_parse() {
     --disable-glusterfs) printf "%s" -Dglusterfs=disabled ;;
     --enable-gnutls) printf "%s" -Dgnutls=enabled ;;
     --disable-gnutls) printf "%s" -Dgnutls=disabled ;;
+    --enable-gnutls-bug1717-workaround) printf "%s" -Dgnutls-bug1717-workaround=enabled ;;
+    --disable-gnutls-bug1717-workaround) printf "%s" -Dgnutls-bug1717-workaround=disabled ;;
     --enable-gtk) printf "%s" -Dgtk=enabled ;;
     --disable-gtk) printf "%s" -Dgtk=disabled ;;
     --enable-gtk-clipboard) printf "%s" -Dgtk_clipboard=enabled ;;
-- 
2.50.1


