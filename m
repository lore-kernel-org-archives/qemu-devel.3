Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743F1C52D73
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 17:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbknj-000899-4Q; Wed, 07 Aug 2024 13:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sbknf-0007ui-QV
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 13:50:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sbknd-0000g5-Tf
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 13:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723053013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vztq1CNCWY30LcnqqakMkAq58CmWNubW9CXcUKXabaQ=;
 b=jGz3I8mCVYUb8QFHps9i+TD1x35EUGneJgr2uv4YlRRNzW4tND4OtMld4nySOel9L9kYsn
 otANQj0YLc60j59+V1n8yBGOGyw4mwoi2zm2lL2fe4TIcaY/00cJqbxQ8rL2yrBHDUd5U0
 JtHHrnEtiiVbbvtgzy6Bo8PNnxK3OMk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-FYQOZm2IO3Sp0HSXB_kAvA-1; Wed,
 07 Aug 2024 13:50:10 -0400
X-MC-Unique: FYQOZm2IO3Sp0HSXB_kAvA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A82221955F3D; Wed,  7 Aug 2024 17:50:08 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8DA40300018D; Wed,  7 Aug 2024 17:50:06 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, vsementsov@yandex-team.ru,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v4 7/7] nbd/server: Allow users to adjust handshake limit in
 QMP
Date: Wed,  7 Aug 2024 12:43:33 -0500
Message-ID: <20240807174943.771624-16-eblake@redhat.com>
In-Reply-To: <20240807174943.771624-9-eblake@redhat.com>
References: <20240807174943.771624-9-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Although defaulting the handshake limit to 10 seconds was a nice QoI
change to weed out intentionally slow clients, it can interfere with
integration testing done with manual NBD_OPT commands over 'nbdsh
--opt-mode'.  Expose a QMP knob to allow the user to alter the timeout
away from the default.

Signed-off-by: Eric Blake <eblake@redhat.com>

---

I'm not sure if this is 9.1 material.  It is a new feature
(user-visible QMP addition) implemented after soft freeze; on the
other hand, it allows one to recover the behavior that existed prior
to plugging the CVE which may be useful in integration testing.
---
 qapi/block-export.json         | 14 ++++++++++++--
 include/block/nbd.h            |  2 +-
 block/monitor/block-hmp-cmds.c |  2 +-
 blockdev-nbd.c                 | 19 ++++++++++++++-----
 4 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index ce33fe378df..b485b380f1a 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -30,13 +30,18 @@
 #     server from advertising multiple client support (since 5.2;
 #     default: 100)
 #
+# @handshake-limit: Time limit, in seconds, at which a client that
+#     has not completed the negotiation handshake will be disconnected,
+#     or 0 for no limit (since 9.1; default: 10).
+#
 # Since: 4.2
 ##
 { 'struct': 'NbdServerOptions',
   'data': { 'addr': 'SocketAddress',
             '*tls-creds': 'str',
             '*tls-authz': 'str',
-            '*max-connections': 'uint32' } }
+            '*max-connections': 'uint32',
+            '*handshake-limit': 'uint32' } }

 ##
 # @nbd-server-start:
@@ -65,6 +70,10 @@
 #     server from advertising multiple client support (since 5.2;
 #     default: 100).
 #
+# @handshake-limit: Time limit, in seconds, at which a client that
+#     has not completed the negotiation handshake will be disconnected,
+#     or 0 for no limit (since 9.1; default: 10).
+#
 # Errors:
 #     - if the server is already running
 #
@@ -74,7 +83,8 @@
   'data': { 'addr': 'SocketAddressLegacy',
             '*tls-creds': 'str',
             '*tls-authz': 'str',
-            '*max-connections': 'uint32' },
+            '*max-connections': 'uint32',
+            '*handshake-limit': 'uint32' },
   'allow-preconfig': true }

 ##
diff --git a/include/block/nbd.h b/include/block/nbd.h
index fd5044359dc..22071aea797 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -430,7 +430,7 @@ bool nbd_server_is_running(void);
 int nbd_server_max_connections(void);
 void nbd_server_start(SocketAddress *addr, const char *tls_creds,
                       const char *tls_authz, uint32_t max_connections,
-                      Error **errp);
+                      uint32_t handshake_limit, Error **errp);
 void nbd_server_start_options(NbdServerOptions *arg, Error **errp);

 /* nbd_read
diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index bdf2eb50b68..a258e029f78 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -403,7 +403,7 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
     }

     nbd_server_start(addr, NULL, NULL, NBD_DEFAULT_MAX_CONNECTIONS,
-                     &local_err);
+                     NBD_DEFAULT_HANDSHAKE_LIMIT, &local_err);
     qapi_free_SocketAddress(addr);
     if (local_err != NULL) {
         goto exit;
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 4e38ff46747..ad21bd1412d 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -30,6 +30,7 @@ typedef struct NBDServerData {
     QIONetListener *listener;
     QCryptoTLSCreds *tlscreds;
     char *tlsauthz;
+    uint32_t handshake_limit;
     uint32_t max_connections;
     uint32_t connections;
     QLIST_HEAD(, NBDConn) conns;
@@ -84,8 +85,7 @@ static void nbd_accept(QIONetListener *listener, QIOChannelSocket *cioc,
     nbd_update_server_watch(nbd_server);

     qio_channel_set_name(QIO_CHANNEL(cioc), "nbd-server");
-    /* TODO - expose handshake limit as QMP option */
-    nbd_client_new(cioc, NBD_DEFAULT_HANDSHAKE_LIMIT,
+    nbd_client_new(cioc, nbd_server->handshake_limit,
                    nbd_server->tlscreds, nbd_server->tlsauthz,
                    nbd_blockdev_client_closed, conn);
 }
@@ -160,7 +160,7 @@ static QCryptoTLSCreds *nbd_get_tls_creds(const char *id, Error **errp)

 void nbd_server_start(SocketAddress *addr, const char *tls_creds,
                       const char *tls_authz, uint32_t max_connections,
-                      Error **errp)
+                      uint32_t handshake_limit, Error **errp)
 {
     if (nbd_server) {
         error_setg(errp, "NBD server already running");
@@ -169,6 +169,7 @@ void nbd_server_start(SocketAddress *addr, const char *tls_creds,

     nbd_server = g_new0(NBDServerData, 1);
     nbd_server->max_connections = max_connections;
+    nbd_server->handshake_limit = handshake_limit;
     nbd_server->listener = qio_net_listener_new();

     qio_net_listener_set_name(nbd_server->listener,
@@ -206,15 +207,19 @@ void nbd_server_start_options(NbdServerOptions *arg, Error **errp)
     if (!arg->has_max_connections) {
         arg->max_connections = NBD_DEFAULT_MAX_CONNECTIONS;
     }
+    if (!arg->has_handshake_limit) {
+        arg->handshake_limit = NBD_DEFAULT_HANDSHAKE_LIMIT;
+    }

     nbd_server_start(arg->addr, arg->tls_creds, arg->tls_authz,
-                     arg->max_connections, errp);
+                     arg->max_connections, arg->handshake_limit, errp);
 }

 void qmp_nbd_server_start(SocketAddressLegacy *addr,
                           const char *tls_creds,
                           const char *tls_authz,
                           bool has_max_connections, uint32_t max_connections,
+                          bool has_handshake_limit, uint32_t handshake_limit,
                           Error **errp)
 {
     SocketAddress *addr_flat = socket_address_flatten(addr);
@@ -222,8 +227,12 @@ void qmp_nbd_server_start(SocketAddressLegacy *addr,
     if (!has_max_connections) {
         max_connections = NBD_DEFAULT_MAX_CONNECTIONS;
     }
+    if (!has_handshake_limit) {
+        handshake_limit = NBD_DEFAULT_HANDSHAKE_LIMIT;
+    }

-    nbd_server_start(addr_flat, tls_creds, tls_authz, max_connections, errp);
+    nbd_server_start(addr_flat, tls_creds, tls_authz, max_connections,
+                     handshake_limit, errp);
     qapi_free_SocketAddress(addr_flat);
 }

-- 
2.45.2


