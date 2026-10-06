Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20CACA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENLA-0003yA-Ig; Wed, 07 Oct 2026 04:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xEJqq-0001MB-0q
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:06:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xEJqg-000570-2r
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791349544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FCndgU01yR3d8HyPbhGVfu21sZ38RP7fYu7mPLwomlA=;
 b=Z1vDV9xiOQahSoUNDrBRzZq7nnL6Yzb4dv1wS8bjc4iwIfZDUEqOCJ2DyACaPpTe1O1w3J
 r0qrLotmcNXcQfHpmMwqcJSaNszxOTBW1BH9Es3olIZFK+mgrN9JDPOxyuEA4VFv0esVCL
 XntV0amXfTTeZzfUE+I48DVonoNIfp0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-ZVcJpECSPzSlLvDnt-yzUg-1; Tue,
 06 Oct 2026 04:34:58 -0400
X-MC-Unique: ZVcJpECSPzSlLvDnt-yzUg-1
X-Mimecast-MFC-AGG-ID: ZVcJpECSPzSlLvDnt-yzUg_1791275698
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14E0718512E4
 for <qemu-devel@nongnu.org>; Tue,  6 Oct 2026 08:34:58 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B6EB2180034F; Tue,  6 Oct 2026 08:34:56 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 3/4] io: cork TLS writes to avoid small TLS records
Date: Tue,  6 Oct 2026 09:34:50 +0100
Message-ID: <20261006083451.956881-4-berrange@redhat.com>
In-Reply-To: <20261006083451.956881-1-berrange@redhat.com>
References: <20261006083451.956881-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
---
 crypto/tlssession.c         | 45 +++++++++++++++++++
 include/crypto/tlssession.h | 25 +++++++++++
 include/io/channel-tls.h    |  1 +
 io/channel-tls.c            | 87 ++++++++++++++++++++++++++++++++++---
 4 files changed, 152 insertions(+), 6 deletions(-)

diff --git a/crypto/tlssession.c b/crypto/tlssession.c
index 314e3e96ba8..b343d1a5956 100644
--- a/crypto/tlssession.c
+++ b/crypto/tlssession.c
@@ -513,6 +513,39 @@ qcrypto_tls_session_read(QCryptoTLSSession *session,
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
@@ -757,4 +790,16 @@ qcrypto_tls_session_get_peer_name(QCryptoTLSSession *sess)
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
index 28e419681e4..5415503ebab 100644
--- a/include/crypto/tlssession.h
+++ b/include/crypto/tlssession.h
@@ -208,6 +208,31 @@ typedef ssize_t (*QCryptoTLSSessionReadFunc)(void *buf,
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
index 7e9023570d8..9e9b00c034b 100644
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
index 31ec4d236de..05317ed5a38 100644
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
@@ -448,12 +449,24 @@ static ssize_t qio_channel_tls_writev(QIOChannel *ioc,
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
@@ -463,12 +476,74 @@ static ssize_t qio_channel_tls_writev(QIOChannel *ioc,
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
2.55.0


