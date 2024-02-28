Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1086C54E4A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 05:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfCHR-0006vq-Pr; Wed, 28 Feb 2024 00:14:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCHQ-0006lY-9d
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:14:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCHO-0006eo-Ky
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:14:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709097292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iKLOjP6Vqfp6rSbYaqpDtf5DO20+UXqF1gUTY7yRzzY=;
 b=YmS7iti6VNV1kBpGpnGp1BMStc94z+lKla0ivOWxeIw7g4j4igMwC/5ZCoC+uZBQ9E7vRh
 9oXbfCLpElOW2T6pt1UzX6aiFnllqx29BMa/dOrKwl6gewQdvKKThfG5LYpXxXxwcizk35
 Aknlb0swDuPa0cCk06nPtPxhdtVtcNU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-bVEClmLnPWGe0xlk4dLQjQ-1; Wed, 28 Feb 2024 00:14:49 -0500
X-MC-Unique: bVEClmLnPWGe0xlk4dLQjQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE6D285A58A;
 Wed, 28 Feb 2024 05:14:48 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 99AA81C060AF;
 Wed, 28 Feb 2024 05:14:40 +0000 (UTC)
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
Subject: [PULL 09/25] migration/multifd: Cleanup outgoing_args in state destroy
Date: Wed, 28 Feb 2024 13:12:59 +0800
Message-ID: <20240228051315.400759-10-peterx@redhat.com>
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

outgoing_args is a global cache of socket address to be reused in multifd.
Freeing the cache in per-channel destructor is more or less a hack.  Move
it to multifd_send_cleanup_state() so it only get checked once.  Use a
small helper to do so because it's internal of socket.c.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240222095301.171137-5-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/socket.h  |  2 ++
 migration/multifd.c |  1 +
 migration/socket.c  | 12 ++++++++----
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/migration/socket.h b/migration/socket.h
index 5e4c33b8ea..5f52eddd4c 100644
--- a/migration/socket.h
+++ b/migration/socket.h
@@ -29,4 +29,6 @@ void socket_start_incoming_migration(SocketAddress *saddr, Error **errp);
 
 void socket_start_outgoing_migration(MigrationState *s,
                                      SocketAddress *saddr, Error **errp);
+void socket_cleanup_outgoing_migration(void);
+
 #endif
diff --git a/migration/multifd.c b/migration/multifd.c
index af89e05915..fa33fd98b4 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -689,6 +689,7 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
 
 static void multifd_send_cleanup_state(void)
 {
+    socket_cleanup_outgoing_migration();
     qemu_sem_destroy(&multifd_send_state->channels_created);
     qemu_sem_destroy(&multifd_send_state->channels_ready);
     g_free(multifd_send_state->params);
diff --git a/migration/socket.c b/migration/socket.c
index 98e3ea1514..3184c7c3c1 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -64,10 +64,6 @@ int socket_send_channel_destroy(QIOChannel *send)
 {
     /* Remove channel */
     object_unref(OBJECT(send));
-    if (outgoing_args.saddr) {
-        qapi_free_SocketAddress(outgoing_args.saddr);
-        outgoing_args.saddr = NULL;
-    }
     return 0;
 }
 
@@ -137,6 +133,14 @@ void socket_start_outgoing_migration(MigrationState *s,
                                      NULL);
 }
 
+void socket_cleanup_outgoing_migration(void)
+{
+    if (outgoing_args.saddr) {
+        qapi_free_SocketAddress(outgoing_args.saddr);
+        outgoing_args.saddr = NULL;
+    }
+}
+
 static void socket_accept_incoming_migration(QIONetListener *listener,
                                              QIOChannelSocket *cioc,
                                              gpointer opaque)
-- 
2.43.0


