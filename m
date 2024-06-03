Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C12C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 14:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE8aL-0003dH-LF; Mon, 03 Jun 2024 10:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sE8aI-0003Y1-Lx
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 10:22:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sE8aG-00036f-6a
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 10:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717424567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YnruYBBBdA9Oe8gL91INL662nm0pO2g3Q1Z56AOjdoI=;
 b=PPAUQHTNtLErqPfnK8Frn9JJoolgrIwPr6ojwFvxckcMgtcYuxEk0bis8M0h0AGpcsarTu
 3v//tbJkmlyTQpf+jRXsMjKkQG0OvxG6+cyXbAYckFxH0CYZqwx0bk6bddZtTuhCYaSS5t
 59zuE4p/Ciupo/Fs4dTtEcDAZzwpZDg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-Q5K3Dm2lOo6kIJfvMb_m8A-1; Mon, 03 Jun 2024 10:22:44 -0400
X-MC-Unique: Q5K3Dm2lOo6kIJfvMb_m8A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF952101A52C;
 Mon,  3 Jun 2024 14:22:43 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4746B1C008BB;
 Mon,  3 Jun 2024 14:22:43 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PULL v2 1/2] qio: Inherit follow_coroutine_ctx across TLS
Date: Mon,  3 Jun 2024 09:21:42 -0500
Message-ID: <20240603142240.22679-5-eblake@redhat.com>
In-Reply-To: <20240603142240.22679-4-eblake@redhat.com>
References: <20240603142240.22679-4-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Since qemu 8.2, the combination of NBD + TLS + iothread crashes on an
assertion failure:

qemu-kvm: ../io/channel.c:534: void qio_channel_restart_read(void *): Assertion `qemu_get_current_aio_context() == qemu_coroutine_get_aio_context(co)' failed.

It turns out that when we removed AioContext locking, we did so by
having NBD tell its qio channels that it wanted to opt in to
qio_channel_set_follow_coroutine_ctx(); but while we opted in on the
main channel, we did not opt in on the TLS wrapper channel.
qemu-iotests has coverage of NBD+iothread and NBD+TLS, but apparently
no coverage of NBD+TLS+iothread, or we would have noticed this
regression sooner.  (I'll add that in the next patch)

But while we could manually opt in to the TLS channel in nbd/server.c
(a one-line change), it is more generic if all qio channels that wrap
other channels inherit the follow status, in the same way that they
inherit feature bits.

CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Daniel P. Berrangé <berrange@redhat.com>
CC: qemu-stable@nongnu.org
Fixes: https://issues.redhat.com/browse/RHEL-34786
Fixes: 06e0f098 ("io: follow coroutine AioContext in qio_channel_yield()", v8.2.0)
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20240518025246.791593-5-eblake@redhat.com>
---
 io/channel-tls.c     | 26 +++++++++++++++-----------
 io/channel-websock.c |  1 +
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/io/channel-tls.c b/io/channel-tls.c
index 1d9c9c72bfb..67b97000060 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -69,37 +69,40 @@ qio_channel_tls_new_server(QIOChannel *master,
                            const char *aclname,
                            Error **errp)
 {
-    QIOChannelTLS *ioc;
+    QIOChannelTLS *tioc;
+    QIOChannel *ioc;

-    ioc = QIO_CHANNEL_TLS(object_new(TYPE_QIO_CHANNEL_TLS));
+    tioc = QIO_CHANNEL_TLS(object_new(TYPE_QIO_CHANNEL_TLS));
+    ioc = QIO_CHANNEL(tioc);

-    ioc->master = master;
+    tioc->master = master;
+    ioc->follow_coroutine_ctx = master->follow_coroutine_ctx;
     if (qio_channel_has_feature(master, QIO_CHANNEL_FEATURE_SHUTDOWN)) {
-        qio_channel_set_feature(QIO_CHANNEL(ioc), QIO_CHANNEL_FEATURE_SHUTDOWN);
+        qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
     }
     object_ref(OBJECT(master));

-    ioc->session = qcrypto_tls_session_new(
+    tioc->session = qcrypto_tls_session_new(
         creds,
         NULL,
         aclname,
         QCRYPTO_TLS_CREDS_ENDPOINT_SERVER,
         errp);
-    if (!ioc->session) {
+    if (!tioc->session) {
         goto error;
     }

     qcrypto_tls_session_set_callbacks(
-        ioc->session,
+        tioc->session,
         qio_channel_tls_write_handler,
         qio_channel_tls_read_handler,
-        ioc);
+        tioc);

-    trace_qio_channel_tls_new_server(ioc, master, creds, aclname);
-    return ioc;
+    trace_qio_channel_tls_new_server(tioc, master, creds, aclname);
+    return tioc;

  error:
-    object_unref(OBJECT(ioc));
+    object_unref(OBJECT(tioc));
     return NULL;
 }

@@ -116,6 +119,7 @@ qio_channel_tls_new_client(QIOChannel *master,
     ioc = QIO_CHANNEL(tioc);

     tioc->master = master;
+    ioc->follow_coroutine_ctx = master->follow_coroutine_ctx;
     if (qio_channel_has_feature(master, QIO_CHANNEL_FEATURE_SHUTDOWN)) {
         qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
     }
diff --git a/io/channel-websock.c b/io/channel-websock.c
index a12acc27cf2..de39f0d182d 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -883,6 +883,7 @@ qio_channel_websock_new_server(QIOChannel *master)
     ioc = QIO_CHANNEL(wioc);

     wioc->master = master;
+    ioc->follow_coroutine_ctx = master->follow_coroutine_ctx;
     if (qio_channel_has_feature(master, QIO_CHANNEL_FEATURE_SHUTDOWN)) {
         qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
     }
-- 
2.45.1


