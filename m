Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D718C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 09:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd5lc-0007W7-9b; Thu, 22 Feb 2024 04:53:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rd5lV-0007Tp-SJ
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 04:53:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rd5lU-0006mb-Cx
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 04:53:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708595594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XVZgEJyPi0lNLpFEaYQlAovpe/n6EgDfNQp8be0H6wA=;
 b=BDelc/JppML02POmhaYsi6Kz9uwAiiYjan+tk6crPjgLdJvL45VCKDsgU8i+zs6ejHC10h
 gsI3mV/+AJy638AS28b+qgg5c6Bf+qwdXbQuDbiLFnswg1JVlyHAFt0TYYmJ8DAeCosZzX
 jRnYEcgWPzd2LaIcGrfwa1WZd26bwio=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-5RCpDHlRO9SX1L6hWA2nBQ-1; Thu,
 22 Feb 2024 04:53:10 -0500
X-MC-Unique: 5RCpDHlRO9SX1L6hWA2nBQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6569A3816447;
 Thu, 22 Feb 2024 09:53:10 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 50BB910802;
 Thu, 22 Feb 2024 09:53:07 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 1/5] migration/multifd: Cleanup TLS iochannel referencing
Date: Thu, 22 Feb 2024 17:52:57 +0800
Message-ID: <20240222095301.171137-2-peterx@redhat.com>
In-Reply-To: <20240222095301.171137-1-peterx@redhat.com>
References: <20240222095301.171137-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

Commit a1af605bd5 ("migration/multifd: fix hangup with TLS-Multifd due to
blocking handshake") introduced a thread for TLS channels, which will
resolve the issue on blocking the main thread.  However in the same commit
p->c is slightly abused just to be able to pass over the pointer "p" into
the thread.

That's the major reason we'll need to conditionally free the io channel in
the fault paths.

To clean it up, using a separate structure to pass over both "p" and "tioc"
in the tls handshake thread.  Then we can make it a rule that p->c will
never be set until the channel is completely setup.  With that, we can drop
the tricky conditional unref of the io channel in the error path.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index adfe8c9a0a..6b89a6c885 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -873,16 +873,22 @@ out:
 
 static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque);
 
+typedef struct {
+    MultiFDSendParams *p;
+    QIOChannelTLS *tioc;
+} MultiFDTLSThreadArgs;
+
 static void *multifd_tls_handshake_thread(void *opaque)
 {
-    MultiFDSendParams *p = opaque;
-    QIOChannelTLS *tioc = QIO_CHANNEL_TLS(p->c);
+    MultiFDTLSThreadArgs *args = opaque;
 
-    qio_channel_tls_handshake(tioc,
+    qio_channel_tls_handshake(args->tioc,
                               multifd_new_send_channel_async,
-                              p,
+                              args->p,
                               NULL,
                               NULL);
+    g_free(args);
+
     return NULL;
 }
 
@@ -892,6 +898,7 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
 {
     MigrationState *s = migrate_get_current();
     const char *hostname = s->hostname;
+    MultiFDTLSThreadArgs *args;
     QIOChannelTLS *tioc;
 
     tioc = migration_tls_client_create(ioc, hostname, errp);
@@ -906,11 +913,14 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
     object_unref(OBJECT(ioc));
     trace_multifd_tls_outgoing_handshake_start(ioc, tioc, hostname);
     qio_channel_set_name(QIO_CHANNEL(tioc), "multifd-tls-outgoing");
-    p->c = QIO_CHANNEL(tioc);
+
+    args = g_new0(MultiFDTLSThreadArgs, 1);
+    args->tioc = tioc;
+    args->p = p;
 
     p->tls_thread_created = true;
     qemu_thread_create(&p->tls_thread, "multifd-tls-handshake-worker",
-                       multifd_tls_handshake_thread, p,
+                       multifd_tls_handshake_thread, args,
                        QEMU_THREAD_JOINABLE);
     return true;
 }
@@ -923,6 +933,7 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
 
     migration_ioc_register_yank(ioc);
     p->registered_yank = true;
+    /* Setup p->c only if the channel is completely setup */
     p->c = ioc;
 
     p->thread_created = true;
@@ -976,14 +987,12 @@ out:
 
     trace_multifd_new_send_channel_async_error(p->id, local_err);
     multifd_send_set_error(local_err);
-    if (!p->c) {
-        /*
-         * If no channel has been created, drop the initial
-         * reference. Otherwise cleanup happens at
-         * multifd_send_channel_destroy()
-         */
-        object_unref(OBJECT(ioc));
-    }
+    /*
+     * For error cases (TLS or non-TLS), IO channel is always freed here
+     * rather than when cleanup multifd: since p->c is not set, multifd
+     * cleanup code doesn't even know its existence.
+     */
+    object_unref(OBJECT(ioc));
     error_free(local_err);
 }
 
-- 
2.43.0


