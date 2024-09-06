Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B5ECE7AB8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 07:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smSvz-0003q5-PZ; Fri, 06 Sep 2024 02:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smSut-0005R5-8C; Fri, 06 Sep 2024 02:58:00 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smSup-0003af-Nr; Fri, 06 Sep 2024 02:57:58 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2AA148C25B;
 Fri,  6 Sep 2024 09:53:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E6AEE133413;
 Fri,  6 Sep 2024 09:54:31 +0300 (MSK)
Received: (nullmailer pid 43632 invoked by uid 1000);
 Fri, 06 Sep 2024 06:54:30 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.7 38/53] nbd/server: CVE-2024-7409: Cap default
 max-connections to 100
Date: Fri,  6 Sep 2024 09:54:08 +0300
Message-Id: <20240906065429.42415-38-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.7-20240906080902@cover.tls.msk.ru>
References: <qemu-stable-8.2.7-20240906080902@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Eric Blake <eblake@redhat.com>

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

But for qemu proper, and the newer qemu-storage-daemon, the QMP
nbd-server-start command has historically had a default of unlimited
number of connections, in part because unlike qemu-nbd it is
inherently persistent until nbd-server-stop.  Allowing multiple client
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

This is an INTENTIONAL change in behavior, and will break any client
of nbd-server-start that was not passing an explicit max-connections
parameter, yet expects more than 100 simultaneous connections.  We are
not aware of any such client (as stated above, most clients aware of
MULTI_CONN get by just fine on 8 or 16 connections, and probably cope
with later connections failing by relying on the earlier connections;
libvirt has not yet been passing max-connections, but generally
creates NBD servers with the intent for a single client for the sake
of live storage migration; meanwhile, the KubeSAN project anticipates
a large cluster sharing multiple clients [up to 8 per node, and up to
100 nodes in a cluster], but it currently uses qemu-nbd with an
explicit --shared=0 rather than qemu-storage-daemon with
nbd-server-start).

We considered using a deprecation period (declare that omitting
max-parameters is deprecated, and make it mandatory in 3 releases -
then we don't need to pick an arbitrary default); that has zero risk
of breaking any apps that accidentally depended on more than 100
connections, and where such breakage might not be noticed under unit
testing but only under the larger loads of production usage.  But it
does not close the denial-of-service hole until far into the future,
and requires all apps to change to add the parameter even if 100 was
good enough.  It also has a drawback that any app (like libvirt) that
is accidentally relying on an unlimited default should seriously
consider their own CVE now, at which point they are going to change to
pass explicit max-connections sooner than waiting for 3 qemu releases.
Finally, if our changed default breaks an app, that app can always
pass in an explicit max-parameters with a larger value.

It is also intentional that the HMP interface to nbd-server-start is
not changed to expose max-connections (any client needing to fine-tune
things should be using QMP).

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20240807174943.771624-12-eblake@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
[ericb: Expand commit message to summarize Dan's argument for why we
break corner-case back-compat behavior without a deprecation period]
Signed-off-by: Eric Blake <eblake@redhat.com>
(cherry picked from commit c8a76dbd90c2f48df89b75bef74917f90a59b623)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index c729cbf1eb..78a6975852 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -415,7 +415,8 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
         goto exit;
     }
 
-    nbd_server_start(addr, NULL, NULL, 0, &local_err);
+    nbd_server_start(addr, NULL, NULL, NBD_DEFAULT_MAX_CONNECTIONS,
+                     &local_err);
     qapi_free_SocketAddress(addr);
     if (local_err != NULL) {
         goto exit;
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 267a1de903..24ba5382db 100644
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
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 1d4d65922d..d4f8b21aec 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -39,6 +39,13 @@ extern const BlockExportDriver blk_exp_nbd;
  */
 #define NBD_DEFAULT_HANDSHAKE_MAX_SECS 10
 
+/*
+ * NBD_DEFAULT_MAX_CONNECTIONS: Number of client sockets to allow at
+ * once; must be large enough to allow a MULTI_CONN-aware client like
+ * nbdcopy to create its typical number of 8-16 sockets.
+ */
+#define NBD_DEFAULT_MAX_CONNECTIONS 100
+
 /* Handshake phase structs - this struct is passed on the wire */
 
 typedef struct NBDOption {
diff --git a/qapi/block-export.json b/qapi/block-export.json
index 7874a49ba7..1d255d77e3 100644
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
 # Returns: error if the server is already running.
 #
-- 
2.39.2


