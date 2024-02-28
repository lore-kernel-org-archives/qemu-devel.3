Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D98C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 05:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfCHy-0008N6-36; Wed, 28 Feb 2024 00:15:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCHa-0007vO-PZ
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:15:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCHW-0006fs-ML
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:15:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709097301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J1Vi2VYmdQgFvbilKpbKfSDnUAxZu1Rt48EmQaB8wVw=;
 b=YVjA0/X91jOzwgGUPqOH2EjzpBUSi2zg/U6rUFBIvd9RP4DrF5CYLT/yhA04MV72YdRMST
 6u4tecUULGhauinXXI8veG73e694aODaQeX4Fd49Voa69avTA1KVuBbpbp9HLcdciKg5T7
 dNJt4NB0+pGjiXbyG5G96nC1VGfpbbQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-Y0Y3uIZxOCyGVOoMa7C-wg-1; Wed, 28 Feb 2024 00:14:58 -0500
X-MC-Unique: Y0Y3uIZxOCyGVOoMa7C-wg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 177C5811E79;
 Wed, 28 Feb 2024 05:14:58 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F01F1C060B1;
 Wed, 28 Feb 2024 05:14:49 +0000 (UTC)
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
Subject: [PULL 10/25] migration/multifd: Drop unnecessary helper to destroy IOC
Date: Wed, 28 Feb 2024 13:13:00 +0800
Message-ID: <20240228051315.400759-11-peterx@redhat.com>
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

Both socket_send_channel_destroy() and multifd_send_channel_destroy() are
unnecessary wrappers to destroy an IOC, as the only thing to do is to
release the final IOC reference.  We have plenty of code that destroys an
IOC using direct unref() already; keep that style.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240222095301.171137-6-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/socket.h  | 1 -
 migration/multifd.c | 7 +------
 migration/socket.c  | 7 -------
 3 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/migration/socket.h b/migration/socket.h
index 5f52eddd4c..46c233ecd2 100644
--- a/migration/socket.h
+++ b/migration/socket.h
@@ -23,7 +23,6 @@
 
 void socket_send_channel_create(QIOTaskFunc f, void *data);
 QIOChannel *socket_send_channel_create_sync(Error **errp);
-int socket_send_channel_destroy(QIOChannel *send);
 
 void socket_start_incoming_migration(SocketAddress *saddr, Error **errp);
 
diff --git a/migration/multifd.c b/migration/multifd.c
index fa33fd98b4..6c07f19af1 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -659,16 +659,11 @@ static void multifd_send_terminate_threads(void)
     }
 }
 
-static int multifd_send_channel_destroy(QIOChannel *send)
-{
-    return socket_send_channel_destroy(send);
-}
-
 static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
 {
     if (p->c) {
         migration_ioc_unregister_yank(p->c);
-        multifd_send_channel_destroy(p->c);
+        object_unref(OBJECT(p->c));
         p->c = NULL;
     }
     qemu_sem_destroy(&p->sem);
diff --git a/migration/socket.c b/migration/socket.c
index 3184c7c3c1..9ab89b1e08 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -60,13 +60,6 @@ QIOChannel *socket_send_channel_create_sync(Error **errp)
     return QIO_CHANNEL(sioc);
 }
 
-int socket_send_channel_destroy(QIOChannel *send)
-{
-    /* Remove channel */
-    object_unref(OBJECT(send));
-    return 0;
-}
-
 struct SocketConnectData {
     MigrationState *s;
     char *hostname;
-- 
2.43.0


