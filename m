Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96446C79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 14:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3ags-0000OB-30; Mon, 07 Sep 2026 10:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x3agr-0000N4-5t
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 10:51:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x3agp-0001DW-9W
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 10:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788792678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bsxpBn/9znpwFxM2SEjvxMd5rsrdDjfnXlTBtjedChE=;
 b=S4ihVbFGCO8DvUT/fcKDbslIsW0GwGWJnwZ38h5FwY4vbTpx2J7zkGZzsXGTukE/n1PPRf
 kXetVN2W4bN+2RWuRcTCcmJs1kztnBrVll66l6xWYcEnqjodeaNoVlzutHtnICALwqddgP
 h5WdWnvKuSpM1kHE2eapg9H5f+9rXoM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-PJfNPg9BPiCGex6mMinexA-1; Mon,
 07 Sep 2026 10:51:17 -0400
X-MC-Unique: PJfNPg9BPiCGex6mMinexA-1
X-Mimecast-MFC-AGG-ID: PJfNPg9BPiCGex6mMinexA_1788792676
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E232518089B5; Mon,  7 Sep 2026 14:51:15 +0000 (UTC)
Received: from berrange.fritz.box (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 465091800765; Mon,  7 Sep 2026 14:51:13 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH] io: bounce-buffer TLS writes to avoid nagle go-slow
Date: Mon,  7 Sep 2026 15:51:12 +0100
Message-ID: <20260907145112.852497-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
flushes this every 128kb.

The QIOChannelTLS receives the iovec, but size GNUTLS cannot
accept iovec data, it iterates calling send for each element.

As a result of the migration data pattern, this results in
GNUTLS putting writes on the wire that alternate between about
4k and 30 bytes.

This is triggering the nagle algorithm on migration-test for
many of the TLS test cases, resulting in a "go slow" for I/O
that eventually hits the migration timeout configured by the
test.

Not every contributor reports seeing the "go slow" but for
those who do see it, it hits >= 95% of the time for at least
one of the migration TLS test cases run by 'make check'.

While we could disable the nagle algorithm (and multifd
channels already do this), that would just lead to lots of
small TCP packets hitting the wire which is not good for
throughput. The migration code flushes in batches of 128kb
because it wants large writes for high throughput.

The only way to achieve this in the TLS code is to bounce
buffer the writes in order to flatten the iovec. We cannot
fully flatten, however, since GNUTLS puts a cap on the max
TLS record size it is willing to send, which is negotiated
with the server, typically 16 kb out of the box.

This patch thus queries the max TLS record size and then
flattens the iovec into buffers of this size. If the
iovec only contains a single element, bounce buffering
is skipped to avoid the redundant copy.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlssession.c         | 10 ++++++++++
 include/crypto/tlssession.h |  2 ++
 include/io/channel-tls.h    |  2 ++
 io/channel-tls.c            | 35 ++++++++++++++++++++++++++++++-----
 io/trace-events             |  1 +
 5 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/crypto/tlssession.c b/crypto/tlssession.c
index 314e3e96ba..cf4daf8544 100644
--- a/crypto/tlssession.c
+++ b/crypto/tlssession.c
@@ -653,6 +653,11 @@ qcrypto_tls_session_get_peer_name(QCryptoTLSSession *session)
     return NULL;
 }
 
+size_t qcrypto_tls_session_get_send_buffer(QCryptoTLSSession *session)
+{
+    return gnutls_record_get_max_size(session->handle);
+}
+
 
 #else /* ! CONFIG_GNUTLS */
 
@@ -757,4 +762,9 @@ qcrypto_tls_session_get_peer_name(QCryptoTLSSession *sess)
     return NULL;
 }
 
+size_t qcrypto_tls_session_get_send_buffer(QCryptoTLSSession *sess)
+{
+    return 1;
+}
+
 #endif
diff --git a/include/crypto/tlssession.h b/include/crypto/tlssession.h
index 28e419681e..b29648a0a9 100644
--- a/include/crypto/tlssession.h
+++ b/include/crypto/tlssession.h
@@ -369,4 +369,6 @@ int qcrypto_tls_session_get_key_size(QCryptoTLSSession *sess,
  */
 char *qcrypto_tls_session_get_peer_name(QCryptoTLSSession *sess);
 
+size_t qcrypto_tls_session_get_send_buffer(QCryptoTLSSession *sess);
+
 #endif /* QCRYPTO_TLSSESSION_H */
diff --git a/include/io/channel-tls.h b/include/io/channel-tls.h
index 7e9023570d..1c22a3fd07 100644
--- a/include/io/channel-tls.h
+++ b/include/io/channel-tls.h
@@ -50,6 +50,8 @@ struct QIOChannelTLS {
     QIOChannelShutdown shutdown;
     guint hs_ioc_tag;
     guint bye_ioc_tag;
+    char *send_buffer;
+    size_t send_buffer_len;
 };
 
 /**
diff --git a/io/channel-tls.c b/io/channel-tls.c
index 31ec4d236d..ba2699786e 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -24,6 +24,7 @@
 #include "io/channel-tls.h"
 #include "trace.h"
 #include "qemu/atomic.h"
+#include "qemu/iov.h"
 
 
 static ssize_t qio_channel_tls_write_handler(const void *buf,
@@ -201,6 +202,12 @@ static gboolean qio_channel_tls_handshake_task(QIOChannelTLS *ioc,
         } else {
             trace_qio_channel_tls_credentials_allow(ioc);
         }
+
+        ioc->send_buffer_len = qcrypto_tls_session_get_send_buffer(
+            ioc->session);
+        ioc->send_buffer = g_new0(char, ioc->send_buffer_len);
+        trace_qio_channel_tls_send_buffer_len(ioc, ioc->send_buffer_len);
+
         qio_task_complete(task);
         return TRUE;
     } else {
@@ -376,6 +383,7 @@ static void qio_channel_tls_finalize(Object *obj)
         g_clear_handle_id(&ioc->bye_ioc_tag, g_source_remove);
     }
 
+    g_free(ioc->send_buffer);
     object_unref(OBJECT(ioc->master));
     qcrypto_tls_session_free(ioc->session);
 }
@@ -446,13 +454,30 @@ static ssize_t qio_channel_tls_writev(QIOChannel *ioc,
                                       Error **errp)
 {
     QIOChannelTLS *tioc = QIO_CHANNEL_TLS(ioc);
-    size_t i;
     ssize_t done = 0;
+    size_t tot = iov_size(iov, niov);
 
-    for (i = 0 ; i < niov ; i++) {
+    /* Skip bounce buffer in simple case */
+    if (niov == 1) {
         ssize_t ret = qcrypto_tls_session_write(tioc->session,
-                                                iov[i].iov_base,
-                                                iov[i].iov_len,
+                                                iov[0].iov_base,
+                                                iov[0].iov_len,
+                                                errp);
+        if (ret == QCRYPTO_TLS_SESSION_ERR_BLOCK) {
+            return QIO_CHANNEL_ERR_BLOCK;
+        } else if (ret < 0) {
+            return -1;
+        }
+        return ret;
+    }
+
+    while (done < tot) {
+        size_t got = iov_to_buf(iov, niov, done,
+                                tioc->send_buffer,
+                                tioc->send_buffer_len);
+        ssize_t ret = qcrypto_tls_session_write(tioc->session,
+                                                tioc->send_buffer,
+                                                got,
                                                 errp);
         if (ret == QCRYPTO_TLS_SESSION_ERR_BLOCK) {
             if (done) {
@@ -464,7 +489,7 @@ static ssize_t qio_channel_tls_writev(QIOChannel *ioc,
             return -1;
         }
         done += ret;
-        if (ret < iov[i].iov_len) {
+        if (ret < got) {
             break;
         }
     }
diff --git a/io/trace-events b/io/trace-events
index ec91453335..88ebd5b478 100644
--- a/io/trace-events
+++ b/io/trace-events
@@ -44,6 +44,7 @@ qio_channel_tls_handshake_pending(void *ioc, int status) "TLS handshake pending
 qio_channel_tls_handshake_fail(void *ioc) "TLS handshake fail ioc=%p"
 qio_channel_tls_handshake_complete(void *ioc) "TLS handshake complete ioc=%p"
 qio_channel_tls_handshake_cancel(void *ioc) "TLS handshake cancel ioc=%p"
+qio_channel_tls_send_buffer_len(void *ioc, int len) "TLS send buffer len ioc=%p len=%d"
 qio_channel_tls_bye_start(void *ioc) "TLS termination start ioc=%p"
 qio_channel_tls_bye_pending(void *ioc, int status) "TLS termination pending ioc=%p status=%d"
 qio_channel_tls_bye_fail(void *ioc) "TLS termination fail ioc=%p"
-- 
2.55.0


