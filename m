Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA55C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 05:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfCHJ-0006cd-2c; Wed, 28 Feb 2024 00:14:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCHH-0006YB-A0
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:14:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCH1-0006cI-5y
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:14:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709097264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wExLy3AKx0EGsAonwI9YK2ZuyIYTZqi6zUyh5A8Ohtw=;
 b=iux2E/7KsCxwYKtONyxPYxBnVLv9FY0DecJVPSDBYWTi3E1qCTUbA0DS8ppOQ4dgXfUFVj
 1vWw3VovSDvKjY8D+D//gUoU/3bZ9bWJSBaGdRmeqgwPp/PkkOeGjRk7Sor+bqW3y0d5aU
 2OC5V0KdfDmn6x0qxu9oZGv7ODyGaVA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-9nZywqdrNHyX6BveCwyZJw-1; Wed, 28 Feb 2024 00:14:21 -0500
X-MC-Unique: 9nZywqdrNHyX6BveCwyZJw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 754A0800074;
 Wed, 28 Feb 2024 05:14:21 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 291541C060AF;
 Wed, 28 Feb 2024 05:14:12 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: [PULL 06/25] migration/multifd: Cleanup TLS iochannel referencing
Date: Wed, 28 Feb 2024 13:12:56 +0800
Message-ID: <20240228051315.400759-7-peterx@redhat.com>
In-Reply-To: <20240228051315.400759-1-peterx@redhat.com>
References: <20240228051315.400759-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240222095301.171137-2-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 43f0820996..84a6b9e58f 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -891,16 +891,22 @@ out:
 
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
 
@@ -910,6 +916,7 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
 {
     MigrationState *s = migrate_get_current();
     const char *hostname = s->hostname;
+    MultiFDTLSThreadArgs *args;
     QIOChannelTLS *tioc;
 
     tioc = migration_tls_client_create(ioc, hostname, errp);
@@ -924,11 +931,14 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
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
@@ -941,6 +951,7 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
 
     migration_ioc_register_yank(ioc);
     p->registered_yank = true;
+    /* Setup p->c only if the channel is completely setup */
     p->c = ioc;
 
     p->thread_created = true;
@@ -994,14 +1005,12 @@ out:
 
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


