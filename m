Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E633C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 09:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd5lh-0007YP-Qq; Thu, 22 Feb 2024 04:53:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rd5lg-0007Xl-9M
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 04:53:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rd5le-0006oZ-Pk
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 04:53:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708595606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=byLCMPEIKjlNNLbaOQXJ5y319o0Rr0ker5wtX8r6YS8=;
 b=HU7kdAt/nXmAuay14rvohNT2SuhpRNrR4PrqGR3Qo0qVrlJJ1cORHzSlDSDqh35fQ8Vdd0
 BuP8IHVrjyrjNGuOuNpChSQ7L+V/grBB3nk4uI2bMht6hZDztGIL7vEekBkBlPR3ZfWcTA
 hUq0UbgwoIztZ/xdFNXlv9vChpz9iQY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-d_jzQha7MBmTlFZcL5c-1A-1; Thu, 22 Feb 2024 04:53:22 -0500
X-MC-Unique: d_jzQha7MBmTlFZcL5c-1A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79B3E185A786;
 Thu, 22 Feb 2024 09:53:22 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6480F8CED;
 Thu, 22 Feb 2024 09:53:19 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 4/5] migration/multifd: Cleanup outgoing_args in state
 destroy
Date: Thu, 22 Feb 2024 17:53:00 +0800
Message-ID: <20240222095301.171137-5-peterx@redhat.com>
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

outgoing_args is a global cache of socket address to be reused in multifd.
Freeing the cache in per-channel destructor is more or less a hack.  Move
it to multifd_send_cleanup_state() so it only get checked once.  Use a
small helper to do so because it's internal of socket.c.

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
index f52f01ca85..e901b32c19 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -671,6 +671,7 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
 
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


