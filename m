Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389A6C531DB
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 16:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scSKJ-0000lU-Sx; Fri, 09 Aug 2024 12:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1scSKH-0000cH-0U
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 12:18:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1scSKE-0007lJ-Vk
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 12:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723220326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wVwk3CzSEVvtSU//YcDoWiPUxj58p921PM9x8tT3Ga8=;
 b=GD6XVwDW5XImM+r2Jtsncv3eaLskx/v9hYurIMrJ8Ex5MrD6s9VrPKwEp5LmKWOVKbFlLa
 hTDMG1sP+QdAPxx62CrbaUVU+8NIg41ENXcgnQHYpT7Ko0SMvQjANzAANzWpZNFLp+5KZl
 xijTvuTij2tra9YRKApXVI2JbHILU1Q=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-ioAmKdKSPLqDiyUwIHypXA-1; Fri,
 09 Aug 2024 12:18:42 -0400
X-MC-Unique: ioAmKdKSPLqDiyUwIHypXA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC64F1955D5F; Fri,  9 Aug 2024 16:18:40 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1DA4B19560A3; Fri,  9 Aug 2024 16:18:37 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, vsementsov@yandex-team.ru,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 2/2] nbd/server: Allow users to adjust handshake limit in QMP
Date: Fri,  9 Aug 2024 11:14:26 -0500
Message-ID: <20240809161828.1342831-6-eblake@redhat.com>
In-Reply-To: <20240809161828.1342831-4-eblake@redhat.com>
References: <20240809161828.1342831-4-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
--opt-mode'.  Expose a QMP knob 'handshake-max-secs' to allow the user
to alter the timeout away from the default.

The parameter name here intentionally matches the spelling of the
constant added in commit fb1c2aaa98, and not the command-line spelling
added in the previous patch for qemu-nbd; that's because in QMP,
longer names serve as good self-documentation, and unlike the command
line, machines don't have problems generating longer spellings.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-export.json         | 10 ++++++++++
 include/block/nbd.h            |  6 +++---
 block/monitor/block-hmp-cmds.c |  4 ++--
 blockdev-nbd.c                 | 26 ++++++++++++++++++--------
 4 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index ce33fe378df..c110dd375ad 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -17,6 +17,10 @@
 #
 # @addr: Address on which to listen.
 #
+# @handshake-max-secs: Time limit, in seconds, at which a client that
+#     has not completed the negotiation handshake will be disconnected,
+#     or 0 for no limit (since 9.2; default: 10).
+#
 # @tls-creds: ID of the TLS credentials object (since 2.6).
 #
 # @tls-authz: ID of the QAuthZ authorization object used to validate
@@ -34,6 +38,7 @@
 ##
 { 'struct': 'NbdServerOptions',
   'data': { 'addr': 'SocketAddress',
+            '*handshake-max-secs': 'uint32',
             '*tls-creds': 'str',
             '*tls-authz': 'str',
             '*max-connections': 'uint32' } }
@@ -52,6 +57,10 @@
 #
 # @addr: Address on which to listen.
 #
+# @handshake-max-secs: Time limit, in seconds, at which a client that
+#     has not completed the negotiation handshake will be disconnected,
+#     or 0 for no limit (since 9.2; default: 10).
+#
 # @tls-creds: ID of the TLS credentials object (since 2.6).
 #
 # @tls-authz: ID of the QAuthZ authorization object used to validate
@@ -72,6 +81,7 @@
 ##
 { 'command': 'nbd-server-start',
   'data': { 'addr': 'SocketAddressLegacy',
+            '*handshake-max-secs': 'uint32',
             '*tls-creds': 'str',
             '*tls-authz': 'str',
             '*max-connections': 'uint32' },
diff --git a/include/block/nbd.h b/include/block/nbd.h
index d4f8b21aecc..92987c76fd6 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -428,9 +428,9 @@ void nbd_client_put(NBDClient *client);
 void nbd_server_is_qemu_nbd(int max_connections);
 bool nbd_server_is_running(void);
 int nbd_server_max_connections(void);
-void nbd_server_start(SocketAddress *addr, const char *tls_creds,
-                      const char *tls_authz, uint32_t max_connections,
-                      Error **errp);
+void nbd_server_start(SocketAddress *addr, uint32_t handshake_max_secs,
+                      const char *tls_creds, const char *tls_authz,
+                      uint32_t max_connections, Error **errp);
 void nbd_server_start_options(NbdServerOptions *arg, Error **errp);

 /* nbd_read
diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index bdf2eb50b68..cae6e3064a0 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -402,8 +402,8 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
         goto exit;
     }

-    nbd_server_start(addr, NULL, NULL, NBD_DEFAULT_MAX_CONNECTIONS,
-                     &local_err);
+    nbd_server_start(addr, NBD_DEFAULT_HANDSHAKE_MAX_SECS, NULL, NULL,
+                     NBD_DEFAULT_MAX_CONNECTIONS, &local_err);
     qapi_free_SocketAddress(addr);
     if (local_err != NULL) {
         goto exit;
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index f73409ae494..0cdabfbd82c 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -28,6 +28,7 @@ typedef struct NBDConn {

 typedef struct NBDServerData {
     QIONetListener *listener;
+    uint32_t handshake_max_secs;
     QCryptoTLSCreds *tlscreds;
     char *tlsauthz;
     uint32_t max_connections;
@@ -84,8 +85,7 @@ static void nbd_accept(QIONetListener *listener, QIOChannelSocket *cioc,
     nbd_update_server_watch(nbd_server);

     qio_channel_set_name(QIO_CHANNEL(cioc), "nbd-server");
-    /* TODO - expose handshake timeout as QMP option */
-    nbd_client_new(cioc, NBD_DEFAULT_HANDSHAKE_MAX_SECS,
+    nbd_client_new(cioc, nbd_server->handshake_max_secs,
                    nbd_server->tlscreds, nbd_server->tlsauthz,
                    nbd_blockdev_client_closed, conn);
 }
@@ -158,9 +158,9 @@ static QCryptoTLSCreds *nbd_get_tls_creds(const char *id, Error **errp)
 }


-void nbd_server_start(SocketAddress *addr, const char *tls_creds,
-                      const char *tls_authz, uint32_t max_connections,
-                      Error **errp)
+void nbd_server_start(SocketAddress *addr, uint32_t handshake_max_secs,
+                      const char *tls_creds, const char *tls_authz,
+                      uint32_t max_connections, Error **errp)
 {
     if (nbd_server) {
         error_setg(errp, "NBD server already running");
@@ -169,6 +169,7 @@ void nbd_server_start(SocketAddress *addr, const char *tls_creds,

     nbd_server = g_new0(NBDServerData, 1);
     nbd_server->max_connections = max_connections;
+    nbd_server->handshake_max_secs = handshake_max_secs;
     nbd_server->listener = qio_net_listener_new();

     qio_net_listener_set_name(nbd_server->listener,
@@ -206,12 +207,17 @@ void nbd_server_start_options(NbdServerOptions *arg, Error **errp)
     if (!arg->has_max_connections) {
         arg->max_connections = NBD_DEFAULT_MAX_CONNECTIONS;
     }
+    if (!arg->has_handshake_max_secs) {
+        arg->handshake_max_secs = NBD_DEFAULT_HANDSHAKE_MAX_SECS;
+    }

-    nbd_server_start(arg->addr, arg->tls_creds, arg->tls_authz,
-                     arg->max_connections, errp);
+    nbd_server_start(arg->addr, arg->handshake_max_secs, arg->tls_creds,
+                     arg->tls_authz, arg->max_connections, errp);
 }

 void qmp_nbd_server_start(SocketAddressLegacy *addr,
+                          bool has_handshake_max_secs,
+                          uint32_t handshake_max_secs,
                           const char *tls_creds,
                           const char *tls_authz,
                           bool has_max_connections, uint32_t max_connections,
@@ -222,8 +228,12 @@ void qmp_nbd_server_start(SocketAddressLegacy *addr,
     if (!has_max_connections) {
         max_connections = NBD_DEFAULT_MAX_CONNECTIONS;
     }
+    if (!has_handshake_max_secs) {
+        handshake_max_secs = NBD_DEFAULT_HANDSHAKE_MAX_SECS;
+    }

-    nbd_server_start(addr_flat, tls_creds, tls_authz, max_connections, errp);
+    nbd_server_start(addr_flat, handshake_max_secs, tls_creds, tls_authz,
+                     max_connections, errp);
     qapi_free_SocketAddress(addr_flat);
 }

-- 
2.46.0


