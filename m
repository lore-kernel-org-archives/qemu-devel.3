Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB2BFC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 18:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhueV-0003Bm-7n; Fri, 01 Aug 2025 14:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uht9G-0006Lc-Bt
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:02:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uht9E-0007Wl-6X
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754067743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nMh3VQEh72KnFoywfGjavyvv2VK1t3S3nP81n/mRNC8=;
 b=A++RSsfqW6qHpja9KjRkZRDsGsvpwBafBJ4tXnoCpDk0K9nQUFgZQjlXDXUC8Td8dopere
 o638jH65+lcmwQh5c0YaC6FiZjoHwg08ptOCn78+jo0q1nGbx9lGYhQXJp2Dgh9aVBwVdF
 Y25ENFuvMvlcZg0KpftkUHo1Hnv1ygU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-iVpk-ZrYNHW-XVyUn51T5g-1; Fri,
 01 Aug 2025 13:02:21 -0400
X-MC-Unique: iVpk-ZrYNHW-XVyUn51T5g-1
X-Mimecast-MFC-AGG-ID: iVpk-ZrYNHW-XVyUn51T5g_1754067741
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C279A1800349; Fri,  1 Aug 2025 17:02:20 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.64])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 348541800D8C; Fri,  1 Aug 2025 17:02:18 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/2] migration: fix workaround for gnutls thread safety
Date: Fri,  1 Aug 2025 18:02:12 +0100
Message-ID: <20250801170212.54409-3-berrange@redhat.com>
In-Reply-To: <20250801170212.54409-1-berrange@redhat.com>
References: <20250801170212.54409-1-berrange@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In previous commits

  eb3618e9 migration: activate TLS thread safety workaround
  edea8183 io: add support for activating TLS thread safety workaround
  24ad5e19 crypto: implement workaround for GNUTLS thread safety problems

an attempt was made to workaround broken gnutls thread safety when
TLS 1.3 rekeying is performed.

Those patches acquired locks before calling gnutls_record_{send|recv}
but temporarily dropped the locks in the push/pull functions, in the
mistaken belief that there was a race inside gnutls that did not cross
execution of the push/pull functions.

A non-deterministic reproducer mislead into thinking the workaround
was operating as expected, but this was wrong. Juraj demonstrated
that QEMU would still see errors from GNUTLS as well as crashes.

The issue is that a pointer to internal state is saved before the
the push/pull functions are called, and after they return this
saved pointer is potentially invalid. IOW, it is never safe to
temporarily drop the mutexes inside the push/pull functions. The
lock must be held throughout execution of gnutls_record_{send|recv}.

This would be possible with QEMU migration, except that the return
path thread sits in a blocking read waiting for data that very
rarely arrives from the destination QEMU. This blocks ability to
send any migration data in the other thread.

It is possible to workaround this issue, however, by proactively
calling poll() to check for available incoming data before trying
the qio_channel_read() call.

Reported-by: Juraj Marcin <jmarcin@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlssession.c   | 16 ----------------
 migration/qemu-file.c | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/crypto/tlssession.c b/crypto/tlssession.c
index 86d407a142..7e11317528 100644
--- a/crypto/tlssession.c
+++ b/crypto/tlssession.c
@@ -95,19 +95,11 @@ qcrypto_tls_session_push(void *opaque, const void *buf, size_t len)
         return -1;
     };
 
-    if (session->lockEnabled) {
-        qemu_mutex_unlock(&session->lock);
-    }
-
     error_free(session->werr);
     session->werr = NULL;
 
     ret = session->writeFunc(buf, len, session->opaque, &session->werr);
 
-    if (session->lockEnabled) {
-        qemu_mutex_lock(&session->lock);
-    }
-
     if (ret == QCRYPTO_TLS_SESSION_ERR_BLOCK) {
         errno = EAGAIN;
         return -1;
@@ -134,16 +126,8 @@ qcrypto_tls_session_pull(void *opaque, void *buf, size_t len)
     error_free(session->rerr);
     session->rerr = NULL;
 
-    if (session->lockEnabled) {
-        qemu_mutex_unlock(&session->lock);
-    }
-
     ret = session->readFunc(buf, len, session->opaque, &session->rerr);
 
-    if (session->lockEnabled) {
-        qemu_mutex_lock(&session->lock);
-    }
-
     if (ret == QCRYPTO_TLS_SESSION_ERR_BLOCK) {
         errno = EAGAIN;
         return -1;
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 8ee44c5ac9..cf6115e699 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -338,6 +338,22 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
         return 0;
     }
 
+    /*
+     * This feature triggers acquisition of mutexes around every
+     * read and write. Thus we must not sit in a blocking read
+     * if this is set, but must instead poll proactively. This
+     * does not work with some channel types, however, so must
+     * only pre-poll when the featre is set.
+     */
+    if (qio_channel_has_feature(f->ioc,
+                                QIO_CHANNEL_FEATURE_CONCURRENT_IO)) {
+        if (qemu_in_coroutine()) {
+            qio_channel_yield(f->ioc, G_IO_IN);
+        } else {
+            qio_channel_wait(f->ioc, G_IO_IN);
+        }
+    }
+
     do {
         struct iovec iov = { f->buf + pending, IO_BUF_SIZE - pending };
         len = qio_channel_readv_full(f->ioc, &iov, 1, pfds, pnfd, 0,
-- 
2.50.1


