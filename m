Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4727DC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 17:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbkna-0007a1-7f; Wed, 07 Aug 2024 13:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sbknX-0007Po-4k
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 13:50:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sbknT-0000Sf-TV
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 13:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723053002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WQK01Bifiek87mMyVcAtTTYs9fgskkmzBNhnR63Cn9w=;
 b=FQrnnV5I6c/wjQID06won+f3GUvkUBCKlAUuscfIIup39YMTTb1M+6eyhxpYKb8qhL/B4B
 h/e6g/a6yRo3bLsKsTYfSOCwIcYhuKp6avrNRIt0UdwBN+26sRLlDBJL/JfnvBm+fkE5zv
 3xhPb4XanVFxtkBcEi00bShXg69JKc4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-XX7cXEvIOci2zXH9V0i9Nw-1; Wed,
 07 Aug 2024 13:49:58 -0400
X-MC-Unique: XX7cXEvIOci2zXH9V0i9Nw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82AAE19560A3; Wed,  7 Aug 2024 17:49:57 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3E7E4300018D; Wed,  7 Aug 2024 17:49:55 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, vsementsov@yandex-team.ru,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v4 3/7] nbd/server: CVE-2024-7409: Change default
 max-connections to 100
Date: Wed,  7 Aug 2024 12:43:29 -0500
Message-ID: <20240807174943.771624-12-eblake@redhat.com>
In-Reply-To: <20240807174943.771624-9-eblake@redhat.com>
References: <20240807174943.771624-9-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

Allowing an unlimited number of clients to any web service is a recipe
for a rudimentary denial of service attack: the client merely needs to
open lots of sockets without closing them, until qemu no longer has
any more fds available to allocate.

For qemu-nbd, we default to allowing only 1 connection unless more are
explicitly asked for (-e or --shared); this was historically picked as
a nice default (without an explicit -t, a non-persistent qemu-nbd goes
away after a client disconnects, without needing any additional
follow-up commands), and we are not going to change that interface now
(besides, someday we want to point people towards qemu-storage-daemon
instead of qemu-nbd).

But for qemu proper, the QMP nbd-server-start command has historically
had a default of unlimited number of connections, in part because
unlike qemu-nbd it is inherently persistent.  Allowing multiple client
sockets is particularly useful for clients that can take advantage of
MULTI_CONN (creating parallel sockets to increase throughput),
although known clients that do so (such as libnbd's nbdcopy) typically
use only 8 or 16 connections (the benefits of scaling diminish once
more sockets are competing for kernel attention).  Picking a number
large enough for typical use cases, but not unlimited, makes it
slightly harder for a malicious client to perform a denial of service
merely by opening lots of connections withot progressing through the
handshake.

This change does not eliminate CVE-2024-7409 on its own, but reduces
the chance for fd exhaustion or unlimited memory usage as an attack
surface.  On the other hand, by itself, it makes it more obvious that
with a finite limit, we have the problem of an unauthenticated client
holding 100 fds opened as a way to block out a legitimate client from
being able to connect; thus, later patches will further add timeouts
to reject clients that are not making progress.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-export.json         | 4 ++--
 include/block/nbd.h            | 7 +++++++
 block/monitor/block-hmp-cmds.c | 3 ++-
 blockdev-nbd.c                 | 8 ++++++++
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index 665d5fd0262..ce33fe378df 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -28,7 +28,7 @@
 # @max-connections: The maximum number of connections to allow at the
 #     same time, 0 for unlimited.  Setting this to 1 also stops the
 #     server from advertising multiple client support (since 5.2;
-#     default: 0)
+#     default: 100)
 #
 # Since: 4.2
 ##
@@ -63,7 +63,7 @@
 # @max-connections: The maximum number of connections to allow at the
 #     same time, 0 for unlimited.  Setting this to 1 also stops the
 #     server from advertising multiple client support (since 5.2;
-#     default: 0).
+#     default: 100).
 #
 # Errors:
 #     - if the server is already running
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 5fe14786414..fd5044359dc 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -39,6 +39,13 @@ extern const BlockExportDriver blk_exp_nbd;
  */
 #define NBD_DEFAULT_HANDSHAKE_LIMIT 10

+/*
+ * NBD_DEFAULT_MAX_CONNECTIONS: Number of client sockets to allow at
+ * once; must be large enough to allow a MULTI_CONN-aware client like
+ * nbdcopy to create its typical number of 8-16 sockets.
+ */
+#define NBD_DEFAULT_MAX_CONNECTIONS 100
+
 /* Handshake phase structs - this struct is passed on the wire */

 typedef struct NBDOption {
diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index d954bec6f1e..bdf2eb50b68 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -402,7 +402,8 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
         goto exit;
     }

-    nbd_server_start(addr, NULL, NULL, 0, &local_err);
+    nbd_server_start(addr, NULL, NULL, NBD_DEFAULT_MAX_CONNECTIONS,
+                     &local_err);
     qapi_free_SocketAddress(addr);
     if (local_err != NULL) {
         goto exit;
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 11f878b6db3..19c57897819 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -170,6 +170,10 @@ void nbd_server_start(SocketAddress *addr, const char *tls_creds,

 void nbd_server_start_options(NbdServerOptions *arg, Error **errp)
 {
+    if (!arg->has_max_connections) {
+        arg->max_connections = NBD_DEFAULT_MAX_CONNECTIONS;
+    }
+
     nbd_server_start(arg->addr, arg->tls_creds, arg->tls_authz,
                      arg->max_connections, errp);
 }
@@ -182,6 +186,10 @@ void qmp_nbd_server_start(SocketAddressLegacy *addr,
 {
     SocketAddress *addr_flat = socket_address_flatten(addr);

+    if (!has_max_connections) {
+        max_connections = NBD_DEFAULT_MAX_CONNECTIONS;
+    }
+
     nbd_server_start(addr_flat, tls_creds, tls_authz, max_connections, errp);
     qapi_free_SocketAddress(addr_flat);
 }
-- 
2.45.2


