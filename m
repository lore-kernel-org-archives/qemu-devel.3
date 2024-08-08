Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C066C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 21:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scB6v-000422-VV; Thu, 08 Aug 2024 17:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1scB6r-0003t3-HN
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 17:55:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1scB6p-0004au-Jb
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 17:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723154146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ga2Mqu/c8WDWZTYY1BG1jDy0Z9/qdi44vVEuyktmlm8=;
 b=LII008ln/f56we9pSsYWB4GrOtNd0OsVSPbxBiL7eNpwTO2e2Ob15ZKxYOPds8ZWH7Nd1q
 z9JN6HAzU9H8uQY+mdSsLqHsw54SAM6ACqUqZG+ryl+teCyMMQRWPpD0ZHFF0JsD7HkfxS
 XTV/x601H1mrb6AHSlwBt28HRXaMH7c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-Kxt_8kNcPKiPi7wQlZny_A-1; Thu,
 08 Aug 2024 17:55:45 -0400
X-MC-Unique: Kxt_8kNcPKiPi7wQlZny_A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0FFA619541B4; Thu,  8 Aug 2024 21:55:44 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 190421956056; Thu,  8 Aug 2024 21:55:41 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 2/5] nbd/server: Plumb in new args to nbd_client_add()
Date: Thu,  8 Aug 2024 16:53:40 -0500
Message-ID: <20240808215529.1065336-9-eblake@redhat.com>
In-Reply-To: <20240808215529.1065336-7-eblake@redhat.com>
References: <20240808215529.1065336-7-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Upcoming patches to fix a CVE need to track an opaque pointer passed
in by the owner of a client object, as well as request for a time
limit on how fast negotiation must complete.  Prepare for that by
changing the signature of nbd_client_new() and adding an accessor to
get at the opaque pointer, although for now the two servers
(qemu-nbd.c and blockdev-nbd.c) do not change behavior even though
they pass in a new default timeout value.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20240807174943.771624-11-eblake@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
[eblake: s/LIMIT/MAX_SECS/ as suggested by Dan]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/nbd.h | 11 ++++++++++-
 blockdev-nbd.c      |  6 ++++--
 nbd/server.c        | 20 +++++++++++++++++---
 qemu-nbd.c          |  4 +++-
 4 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 4e7bd6342f9..1d4d65922d1 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -33,6 +33,12 @@ typedef struct NBDMetaContexts NBDMetaContexts;

 extern const BlockExportDriver blk_exp_nbd;

+/*
+ * NBD_DEFAULT_HANDSHAKE_MAX_SECS: Number of seconds in which client must
+ * succeed at NBD_OPT_GO before being forcefully dropped as too slow.
+ */
+#define NBD_DEFAULT_HANDSHAKE_MAX_SECS 10
+
 /* Handshake phase structs - this struct is passed on the wire */

 typedef struct NBDOption {
@@ -403,9 +409,12 @@ AioContext *nbd_export_aio_context(NBDExport *exp);
 NBDExport *nbd_export_find(const char *name);

 void nbd_client_new(QIOChannelSocket *sioc,
+                    uint32_t handshake_max_secs,
                     QCryptoTLSCreds *tlscreds,
                     const char *tlsauthz,
-                    void (*close_fn)(NBDClient *, bool));
+                    void (*close_fn)(NBDClient *, bool),
+                    void *owner);
+void *nbd_client_owner(NBDClient *client);
 void nbd_client_get(NBDClient *client);
 void nbd_client_put(NBDClient *client);

diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 213012435f4..267a1de903f 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -64,8 +64,10 @@ static void nbd_accept(QIONetListener *listener, QIOChannelSocket *cioc,
     nbd_update_server_watch(nbd_server);

     qio_channel_set_name(QIO_CHANNEL(cioc), "nbd-server");
-    nbd_client_new(cioc, nbd_server->tlscreds, nbd_server->tlsauthz,
-                   nbd_blockdev_client_closed);
+    /* TODO - expose handshake timeout as QMP option */
+    nbd_client_new(cioc, NBD_DEFAULT_HANDSHAKE_MAX_SECS,
+                   nbd_server->tlscreds, nbd_server->tlsauthz,
+                   nbd_blockdev_client_closed, NULL);
 }

 static void nbd_update_server_watch(NBDServerData *s)
diff --git a/nbd/server.c b/nbd/server.c
index ecd9366ba64..fee04415d83 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -124,12 +124,14 @@ struct NBDMetaContexts {
 struct NBDClient {
     int refcount; /* atomic */
     void (*close_fn)(NBDClient *client, bool negotiated);
+    void *owner;

     QemuMutex lock;

     NBDExport *exp;
     QCryptoTLSCreds *tlscreds;
     char *tlsauthz;
+    uint32_t handshake_max_secs;
     QIOChannelSocket *sioc; /* The underlying data channel */
     QIOChannel *ioc; /* The current I/O channel which may differ (eg TLS) */

@@ -3191,6 +3193,7 @@ static coroutine_fn void nbd_co_client_start(void *opaque)

     qemu_co_mutex_init(&client->send_lock);

+    /* TODO - utilize client->handshake_max_secs */
     if (nbd_negotiate(client, &local_err)) {
         if (local_err) {
             error_report_err(local_err);
@@ -3205,14 +3208,17 @@ static coroutine_fn void nbd_co_client_start(void *opaque)
 }

 /*
- * Create a new client listener using the given channel @sioc.
+ * Create a new client listener using the given channel @sioc and @owner.
  * Begin servicing it in a coroutine.  When the connection closes, call
- * @close_fn with an indication of whether the client completed negotiation.
+ * @close_fn with an indication of whether the client completed negotiation
+ * within @handshake_max_secs seconds (0 for unbounded).
  */
 void nbd_client_new(QIOChannelSocket *sioc,
+                    uint32_t handshake_max_secs,
                     QCryptoTLSCreds *tlscreds,
                     const char *tlsauthz,
-                    void (*close_fn)(NBDClient *, bool))
+                    void (*close_fn)(NBDClient *, bool),
+                    void *owner)
 {
     NBDClient *client;
     Coroutine *co;
@@ -3225,13 +3231,21 @@ void nbd_client_new(QIOChannelSocket *sioc,
         object_ref(OBJECT(client->tlscreds));
     }
     client->tlsauthz = g_strdup(tlsauthz);
+    client->handshake_max_secs = handshake_max_secs;
     client->sioc = sioc;
     qio_channel_set_delay(QIO_CHANNEL(sioc), false);
     object_ref(OBJECT(client->sioc));
     client->ioc = QIO_CHANNEL(sioc);
     object_ref(OBJECT(client->ioc));
     client->close_fn = close_fn;
+    client->owner = owner;

     co = qemu_coroutine_create(nbd_co_client_start, client);
     qemu_coroutine_enter(co);
 }
+
+void *
+nbd_client_owner(NBDClient *client)
+{
+    return client->owner;
+}
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 8e104ef22c3..a186d2e1190 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -390,7 +390,9 @@ static void nbd_accept(QIONetListener *listener, QIOChannelSocket *cioc,

     nb_fds++;
     nbd_update_server_watch();
-    nbd_client_new(cioc, tlscreds, tlsauthz, nbd_client_closed);
+    /* TODO - expose handshake timeout as command line option */
+    nbd_client_new(cioc, NBD_DEFAULT_HANDSHAKE_MAX_SECS,
+                   tlscreds, tlsauthz, nbd_client_closed, NULL);
 }

 static void nbd_update_server_watch(void)
-- 
2.46.0


