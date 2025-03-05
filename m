Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0F7C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 23:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpxoR-0007Iw-4v; Wed, 05 Mar 2025 18:06:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tpxoO-0007Gz-LP
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 18:06:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tpxoM-0000A7-GD
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 18:06:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741215955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5y/cYejfVUQnD5+YFuefcNA8OwV8O2KncbnWN0ret9E=;
 b=DL8myni7IVEWTNk9C9GokplU6HkzmPu5LmRX5kK54BUDM2GC519nh787jry8UUfNBxBEvh
 vBokg+u8pr+X6JsKbwjdtxRbQbnmRwetoZPglmuTz8cb+WIBfvMrDeCsaEd5T5AhIGwod4
 HiZjcpYJW5NATiFGvTSKJtdwL7Vvu7w=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-8WRBXni6NquSb_HHq6oSIQ-1; Wed,
 05 Mar 2025 18:05:54 -0500
X-MC-Unique: 8WRBXni6NquSb_HHq6oSIQ-1
X-Mimecast-MFC-AGG-ID: 8WRBXni6NquSb_HHq6oSIQ_1741215953
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2AC6019560B4; Wed,  5 Mar 2025 23:05:53 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.105])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 69E0F1955DCE; Wed,  5 Mar 2025 23:05:51 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 3/4] qapi: merge common parts of NbdServerOptions and
 nbd-server-start data
Date: Wed,  5 Mar 2025 17:05:23 -0600
Message-ID: <20250305230542.2225013-9-eblake@redhat.com>
In-Reply-To: <20250305230542.2225013-6-eblake@redhat.com>
References: <20250305230542.2225013-6-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Instead of comment
"Keep this type consistent with the nbd-server-start arguments", we
can simply merge these things.

Note that each field of new base already has "since" tag, equal in both
original copies. So "since" information is saved.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20250219191914.440451-1-vsementsov@yandex-team.ru>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-export.json | 94 +++++++++++++++++++-----------------------
 blockdev-nbd.c         |  4 +-
 2 files changed, 44 insertions(+), 54 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index 68dcec7edc5..c783e01a532 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -9,53 +9,7 @@
 { 'include': 'block-core.json' }

 ##
-# @NbdServerOptions:
-#
-# Keep this type consistent with the nbd-server-start arguments.  The
-# only intended difference is using SocketAddress instead of
-# SocketAddressLegacy.
-#
-# @addr: Address on which to listen.
-#
-# @handshake-max-seconds: Time limit, in seconds, at which a client
-#     that has not completed the negotiation handshake will be
-#     disconnected, 0 for no limit (since 10.0; default: 10).
-#
-# @tls-creds: ID of the TLS credentials object (since 2.6).
-#
-# @tls-authz: ID of the QAuthZ authorization object used to validate
-#     the client's x509 distinguished name.  This object is is only
-#     resolved at time of use, so can be deleted and recreated on the
-#     fly while the NBD server is active.  If missing, it will default
-#     to denying access (since 4.0).
-#
-# @max-connections: The maximum number of connections to allow at the
-#     same time, 0 for unlimited.  Setting this to 1 also stops the
-#     server from advertising multiple client support (since 5.2;
-#     default: 100)
-#
-# Since: 4.2
-##
-{ 'struct': 'NbdServerOptions',
-  'data': { 'addr': 'SocketAddress',
-            '*handshake-max-seconds': 'uint32',
-            '*tls-creds': 'str',
-            '*tls-authz': 'str',
-            '*max-connections': 'uint32' } }
-
-##
-# @nbd-server-start:
-#
-# Start an NBD server listening on the given host and port.  Block
-# devices can then be exported using @nbd-server-add.  The NBD server
-# will present them as named exports; for example, another QEMU
-# instance could refer to them as "nbd:HOST:PORT:exportname=NAME".
-#
-# Keep this type consistent with the NbdServerOptions type.  The only
-# intended difference is using SocketAddressLegacy instead of
-# SocketAddress.
-#
-# @addr: Address on which to listen.
+# @NbdServerOptionsBase:
 #
 # @handshake-max-seconds: Time limit, in seconds, at which a client
 #     that has not completed the negotiation handshake will be
@@ -73,6 +27,46 @@
 #     same time, 0 for unlimited.  Setting this to 1 also stops the
 #     server from advertising multiple client support (since 5.2;
 #     default: 100).
+##
+{ 'struct': 'NbdServerOptionsBase',
+  'data': { '*handshake-max-seconds': 'uint32',
+            '*tls-creds': 'str',
+            '*tls-authz': 'str',
+            '*max-connections': 'uint32' } }
+
+##
+# @NbdServerOptions:
+#
+# Keep this type consistent with the NbdServerOptionsLegacy type.  The
+# only intended difference is using SocketAddress instead of
+# SocketAddressLegacy.
+#
+# @addr: Address on which to listen (since 4.2).
+##
+{ 'struct': 'NbdServerOptions',
+  'base': 'NbdServerOptionsBase',
+  'data': { 'addr': 'SocketAddress' } }
+
+##
+# @NbdServerOptionsLegacy:
+#
+# Keep this type consistent with the NbdServerOptions type.  The only
+# intended difference is using SocketAddressLegacy instead of
+# SocketAddress.
+#
+# @addr: Address on which to listen (since 1.3).
+##
+{ 'struct': 'NbdServerOptionsLegacy',
+  'base': 'NbdServerOptionsBase',
+  'data': { 'addr': 'SocketAddressLegacy' } }
+
+##
+# @nbd-server-start:
+#
+# Start an NBD server listening on the given host and port.  Block
+# devices can then be exported using @nbd-server-add.  The NBD server
+# will present them as named exports; for example, another QEMU
+# instance could refer to them as "nbd:HOST:PORT:exportname=NAME".
 #
 # Errors:
 #     - if the server is already running
@@ -80,11 +74,7 @@
 # Since: 1.3
 ##
 { 'command': 'nbd-server-start',
-  'data': { 'addr': 'SocketAddressLegacy',
-            '*handshake-max-seconds': 'uint32',
-            '*tls-creds': 'str',
-            '*tls-authz': 'str',
-            '*max-connections': 'uint32' },
+  'data': 'NbdServerOptionsLegacy',
   'allow-preconfig': true }

 ##
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 3f6f4ef92b4..1e3e634b87d 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -219,12 +219,12 @@ void nbd_server_start_options(NbdServerOptions *arg, Error **errp)
                      arg->tls_authz, arg->max_connections, errp);
 }

-void qmp_nbd_server_start(SocketAddressLegacy *addr,
-                          bool has_handshake_max_secs,
+void qmp_nbd_server_start(bool has_handshake_max_secs,
                           uint32_t handshake_max_secs,
                           const char *tls_creds,
                           const char *tls_authz,
                           bool has_max_connections, uint32_t max_connections,
+                          SocketAddressLegacy *addr,
                           Error **errp)
 {
     SocketAddress *addr_flat = socket_address_flatten(addr);
-- 
2.48.1


