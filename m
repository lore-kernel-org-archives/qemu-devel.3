Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76491CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 19:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI9ec-0007zO-Po; Sat, 17 Oct 2026 15:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9dR-0005Yv-Qo; Sat, 17 Oct 2026 15:00:04 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9dP-00040H-Oz; Sat, 17 Oct 2026 15:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792263414; bh=KIe7/Zr2q8cJ8X1SQu3MBDVC6x/u9G9DW/ciEHoz4Ps=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=yKc5o1tpkqBlrssMXPSBmxI5Md+Z95wN6ITmlXUYiKLGfb0+vhjTgeQ2me4obXsSF
 m5pECK1IjWDIno7VmYvuZ6kEan8UmkwwdELSVe7zws2QZFXdRqzUSioPVl7TmsSUUH
 Iphgym7MThViS6GHbL+0vot9HJmio6n6Z/ttv/RsKjMI2F8cP4BfKjiNkRclHo9Vdq
 k3x8ggvmXVkIO49uNd/OqWGydS0C9NXIUEkAxOvhhmPS768c+j7t+f3s86o3z7c5JC
 3ujBbHldsNDX2Z5VHCAF56MaczqVrIXu4/uU4Ourm3oaaMQJsvERC6l93LywSUA422
 /7mHueRD2bIRg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 26AA41DE6D0;
 Sat, 17 Oct 2026 21:56:54 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id DE937443398;
 Sat, 17 Oct 2026 21:56:52 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 45/63] io: cork TLS writes to avoid small TLS records
Date: Sat, 17 Oct 2026 21:55:01 +0300
Message-ID: <20261017185528.722197-45-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

The migration code caches vmstate/ram writes into an iovec and
flushes this periodically. The total amount of data to sent
may be 100's of KB, but split across many iovec, each of which
is potentially quite small.

The QIOChannelTLS receives the iovec, but since GNUTLS cannot
accept iovec data, it iterates calling send for each element.

As a result of the migration data pattern, this results in
GNUTLS putting lots of small TLS records on the wire. This
has shown writes alternate between about 4k and 30 bytes
in some tests.

This is triggering the nagle algorithm on migration-test for
many of the TLS test cases, resulting in a "go slow" for I/O
that eventually hits the migration timeout configured by the
test.

Not every contributor reports seeing the "go slow" but for
those who do see it, it hits >= 95% of the time for at least
one of the migration TLS test cases run by 'make check'.

While we could disable the nagle algorithm (and multifd
channels already do this), that would stil result in lots
of small TLS records hitting the wire which is not good for
throughput. The migration code flushes in batches because
it wants large writes for high throughput.

To achieve this we must tell GNUTLS to encrypt data but not
immediately sent TLS records by "corking" its output. Once
the complete iovec has been written to GNUTLS, it can be
uncorked allowing it to hit the wire.

There is added complexity with uncorking on non-blocking
channels as not all encrypted data can be sent at once.
qio_channel_write() will return what was sent, but some
data might remain pending inside GNUTLS buffers. A later
call to qio_channel_write() will provide the same plain
text data buffers that have already been cached. Thus the
code must attempt to uncork GNUTLS again to clear pending
data and then deduct the equivalent amount of plain text.

Overall this corking action fixes the test suite timeouts,
but more importantly, it also improves the performance of
TLS protection migrations in the real world. Tests with
one workload show at 36% increase in throughput.

Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: Juraj Marcin <jmarcin@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
(cherry picked from commit 99a8b5a0dda91e3cdabbf3fec47a504197af63c7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/crypto/tlssession.c b/crypto/tlssession.c
index 6d8f8df623..a1bfdc7902 100644
--- a/crypto/tlssession.c
+++ b/crypto/tlssession.c
@@ -534,6 +534,39 @@ qcrypto_tls_session_read(QCryptoTLSSession *session,
 }
 
 
+void qcrypto_tls_session_write_cork(QCryptoTLSSession *sess)
+{
+    gnutls_record_cork(sess->handle);
+}
+
+
+ssize_t qcrypto_tls_session_write_uncork(QCryptoTLSSession *sess,
+                                         Error **errp)
+{
+    int ret;
+    ret = gnutls_record_uncork(sess->handle, 0);
+    if (ret == GNUTLS_E_AGAIN ||
+        ret == GNUTLS_E_INTERRUPTED) {
+        ret = gnutls_record_check_corked(sess->handle);
+        if (ret < 0) {
+            error_setg(errp,
+                       "Cannot query pending TLS output: %s",
+                       gnutls_strerror(ret));
+            return -1;
+        }
+
+        return ret;
+    } else if (ret < 0) {
+        error_setg(errp,
+                   "Cannot uncork TLS output: %s",
+                   gnutls_strerror(ret));
+        return -1;
+    }
+
+    return 0;
+}
+
+
 size_t
 qcrypto_tls_session_check_pending(QCryptoTLSSession *session)
 {
@@ -738,4 +771,16 @@ qcrypto_tls_session_get_peer_name(QCryptoTLSSession *sess)
     return NULL;
 }
 
+void qcrypto_tls_session_write_cork(QCryptoTLSSession *sess)
+{
+}
+
+
+ssize_t qcrypto_tls_session_write_uncork(QCryptoTLSSession *sess,
+                                         Error **errp)
+{
+    error_setg(errp, "TLS requires GNUTLS support");
+    return -1;
+}
+
 #endif
diff --git a/include/crypto/tlssession.h b/include/crypto/tlssession.h
index d77ae0d423..0e85982389 100644
--- a/include/crypto/tlssession.h
+++ b/include/crypto/tlssession.h
@@ -193,6 +193,31 @@ typedef ssize_t (*QCryptoTLSSessionReadFunc)(char *buf,
                                              void *opaque,
                                              Error **errp);
 
+/**
+ * qcrypto_tls_session_write_cork:
+ * @sess: the TLS session object
+ *
+ * Causes future qcrypto_tls_session_write() calls to encrypt
+ * and queue data, without sending on the wire.
+ */
+void qcrypto_tls_session_write_cork(QCryptoTLSSession *sess);
+
+/**
+ * qcrypto_tls_session_write_uncork:
+ * @sess: the TLS session object
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Attempt to send previously queued data. If the underlying
+ * stream is non-blocking, then only a subset of data (if any)
+ * may be written. To process outstanding data, this method
+ * must be called again until it returns 0.
+ *
+ * Returns: the number of bytes remaining to be sent,
+ * or -1 on error.
+ */
+ssize_t qcrypto_tls_session_write_uncork(QCryptoTLSSession *sess,
+                                         Error **errp);
+
 /**
  * qcrypto_tls_session_set_callbacks:
  * @sess: the TLS session object
diff --git a/include/io/channel-tls.h b/include/io/channel-tls.h
index 7e9023570d..9e9b00c034 100644
--- a/include/io/channel-tls.h
+++ b/include/io/channel-tls.h
@@ -50,6 +50,7 @@ struct QIOChannelTLS {
     QIOChannelShutdown shutdown;
     guint hs_ioc_tag;
     guint bye_ioc_tag;
+    size_t corked;
 };
 
 /**
diff --git a/io/channel-tls.c b/io/channel-tls.c
index d25a55c107..ff0dda3eaa 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#include "qemu/iov.h"
 #include "io/channel-tls.h"
 #include "trace.h"
 #include "qemu/atomic.h"
@@ -425,12 +426,24 @@ static ssize_t qio_channel_tls_writev(QIOChannel *ioc,
     QIOChannelTLS *tioc = QIO_CHANNEL_TLS(ioc);
     size_t i;
     ssize_t done = 0;
+    ssize_t remain;
+    g_autofree struct iovec *tmpiov = NULL;
+    size_t ntmpiov = 0;
 
-    for (i = 0 ; i < niov ; i++) {
-        ssize_t ret = qcrypto_tls_session_write(tioc->session,
-                                                iov[i].iov_base,
-                                                iov[i].iov_len,
-                                                errp);
+    /*
+     * The previous write encrypted all the data, but some
+     * was not able to be sent on the wire when uncorked,
+     * so we returned a short write. The encrypted data
+     * will still be cached by GNUTLS and the session will
+     * be in a corked state.
+     *
+     * This write call will be trying to write the remaining
+     * plain text data again, but we must avoid sending that
+     * into GNUTLS. Instead flush the previously encrypted
+     * pending data.
+     */
+    while (tioc->corked) {
+        ssize_t ret = qcrypto_tls_session_write_uncork(tioc->session, errp);
         if (ret == QCRYPTO_TLS_SESSION_ERR_BLOCK) {
             if (done) {
                 return done;
@@ -440,12 +453,74 @@ static ssize_t qio_channel_tls_writev(QIOChannel *ioc,
         } else if (ret < 0) {
             return -1;
         }
+        done += (tioc->corked - ret);
+        tioc->corked = ret;
+    }
+
+    /*
+     * If we flushed pending data, we must discard an
+     * equivalent amount of plain text data from this
+     * write call, and then process what's left over,
+     * if any.
+     */
+    if (done) {
+        ssize_t total = iov_size(iov, niov);
+        if (done == total) {
+            return done;
+        }
+
+        tmpiov = g_new0(struct iovec, niov);
+        ntmpiov = iov_copy(tmpiov, niov, iov, niov,
+                           done, total - done);
+
+        iov = tmpiov;
+        niov = ntmpiov;
+    }
+
+    /*
+     * At this point we should ony be processing "new"
+     * data, not seen by a previous write call so we
+     * send to GNUTLS as normal.
+     */
+    qcrypto_tls_session_write_cork(tioc->session);
+    for (i = 0 ; i < niov ; i++) {
+        ssize_t ret = qcrypto_tls_session_write(tioc->session,
+                                                iov[i].iov_base,
+                                                iov[i].iov_len,
+                                                errp);
+        if (ret == QCRYPTO_TLS_SESSION_ERR_BLOCK) {
+            error_setg(errp, "Unexpected TLS blocking I/O while corked");
+            return -1;
+        } else if (ret < 0) {
+            return -1;
+        }
         done += ret;
         if (ret < iov[i].iov_len) {
             break;
         }
     }
-    return done;
+
+    /*
+     * On non-blocking sockets, uncorking may not succeed
+     * in sending all encrypted data, so we have to check
+     * what was actually sent to see if GNUTLS remains in
+     * the corked state with pending data.
+     */
+    remain = qcrypto_tls_session_write_uncork(tioc->session, errp);
+    if (remain < 0) {
+        return -1;
+    } else if (remain) {
+        tioc->corked = remain;
+    }
+    /*
+     * done == what we sent to GNUTLS for encryption & sending
+     * remain == subset of 'done' that was encrypted but not sent
+     */
+    if (done && (remain == done)) {
+        return QIO_CHANNEL_ERR_BLOCK;
+    } else {
+        return done - remain;
+    }
 }
 
 static int qio_channel_tls_set_blocking(QIOChannel *ioc,
-- 
2.47.3


