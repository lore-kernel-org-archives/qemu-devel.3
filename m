Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45023606A333
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 14:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ovhcloud.com header.i=@ovhcloud.com header.a=rsa-sha256 header.s=mailout header.b=lTlNlmby
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRrxz-0006bI-4g; Fri, 13 Nov 2026 09:09:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xRrxx-0006ZR-Bu
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 09:09:21 -0500
Received: from 2.mo508.mail-out.ovh.net ([5.135.90.177])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xRrxu-0004Oe-Tq
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 09:09:21 -0500
Received: from DAGFR11EX3.OVH.local (unknown [10.110.58.209])
 by mo508.mail-out.ovh.net (Postfix) with ESMTPS id 4jQzdm0Hb3z7tCX;
 Fri, 13 Nov 2026 14:09:16 +0000 (UTC)
Received: from ovhcloud.com (109.190.254.61) by DAGFR11EX3.OVH.local
 (172.16.2.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 13 Nov
 2026 15:09:15 +0100
From: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-block@nongnu.org>, <eblake@redhat.com>, <vsementsov@yandex-team.ru>, 
 <kwolf@redhat.com>, <hreitz@redhat.com>, <armbru@redhat.com>, Guillaume
 Vincke <guillaume.vincke@ovhcloud.com>
Subject: [PATCH v2 1/2] nbd: Add an unstable query for the client state
Date: Fri, 13 Nov 2026 15:08:51 +0100
Message-ID: <20261113140852.702959-2-guillaume.vincke@ovhcloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113140852.702959-1-guillaume.vincke@ovhcloud.com>
References: <20261113140852.702959-1-guillaume.vincke@ovhcloud.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CAS4.OVH.local (172.16.1.4) To DAGFR11EX3.OVH.local
 (172.16.2.113)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 1876875148953272760
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTEaildEnH9HZvkKsOe+5Zdcife+EAsyGX++l8F/tVT2DfFMXfiUPWEc7bVXlDoJ7GmIlf66Vrx2OChfs9JkTL8irHXnImIKWEXg6Boq7tcGv5W9AnisV7ZakDZf50IrA6fbeaifF8VqGYTz5EBmOhamLXtxsfVHzGVigd5PM1Qk1tn+QhYSXvUc97iWPI6EPHeUOtZIDjKQ8mPr05rOI1zKvtMyI/qUV2jB21ik+ggAYNO3Yz3huPYy6hW7e+hOwhqVCA828D/2cJkCr3xqcjSO03i6Np5EqDgcxLhKItRxGb5lrljJl+CZiJIIuzBK8LLfbsyTQEvwZDnbzU1nIJsCHx2xA1IF4coMp7kwVU40od58q2cEv8VYnOtOzw+ua1wp+IYZ4H7azPLB4N4eAcgYrK3cD+e0PRdluNEgzwvYAuvoE+wBKwMskGZfvJGCRiC+WzpKpyLt2DwRhuI3JoDQWpOQsgsZ9VP1AsavP2A2h/n/nRyp81FIzKYzv0qnkq3hT7gTQ1kd4H8jYnp9X+wvS0nvmNZfcT4Gef0U3le7iKq7583gFiqHbYP2fZ8h81HXJWzAggvx3IxpIcqoPL3iAxuUs0bOjns9tjNYkK5FQn4UT1AT5VNyRWrGsCmfrZwNxEcS3wWBrMJeKQ08+MWTzgMkbQuMOsn4M1mEQtPZPw
DKIM-Signature: a=rsa-sha256; bh=w2CsNwlKNWKmb9ROlRU20/DnVq9nc2W5pbX1KAQGj5g=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1794578956; v=1; 
 b=lTlNlmbyqWv9sPXjsKc77tlBxMpkZQSKfws+Bp8/KplIZOvG3slcWWmRZGX7eu+MQPoQR6D7
 EHAYaXfqP5hUaMJHK7UnqH/KGGRXdEhTFXh7k+f6FcAbKhyPXc1FhlODWqrALtwJ/Gv4BhiazmC
 e7nduY1SYdroV91TtPESnWE4=
Received-SPF: pass client-ip=5.135.90.177;
 envelope-from=guillaume.vincke@ovhcloud.com; helo=2.mo508.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: guillaume.vincke@ovhcloud.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

At the moment, NBD client internals cannot be accessed. Therefore,
tests have to infer the client state from I/O results and wait with
sleeps, which is racy.

Add the x-debug-query-nbd-client QMP command that reports the state of
the client's connection and of its connector. Other fields will be
added when needed.

The next patch uses this command to make the nbd-stale-connection test
deterministic.

Signed-off-by: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
---
 block/nbd.c             | 57 +++++++++++++++++++++++++++
 include/block/nbd.h     |  9 +++++
 nbd/client-connection.c | 22 +++++++++++
 qapi/block-core.json    | 87 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 175 insertions(+)

diff --git a/block/nbd.c b/block/nbd.c
index e5e16722ba..49f585eab5 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -35,9 +35,11 @@
 #include "qemu/cutils.h"
 #include "qemu/main-loop.h"
 
+#include "qapi/qapi-commands-block-core.h"
 #include "qapi/qapi-visit-sockets.h"
 #include "qobject/qstring.h"
 #include "qapi/clone-visitor.h"
+#include "qapi/error.h"
 
 #include "block/qdict.h"
 #include "block/nbd.h"
@@ -2246,6 +2248,61 @@ static BlockDriver bdrv_nbd_unix = {
     .bdrv_detach_aio_context    = nbd_detach_aio_context,
 };
 
+XDbgNbdClient *qmp_x_debug_query_nbd_client(const char *node_name,
+                                            Error **errp)
+{
+    BlockDriverState *bs;
+    BDRVNBDState *s;
+    XDbgNbdClient *info;
+
+    bs = bdrv_find_node(node_name);
+    if (!bs) {
+        error_setg(errp, "Node '%s' not found", node_name);
+        return NULL;
+    }
+
+    if (bs->drv != &bdrv_nbd &&
+        bs->drv != &bdrv_nbd_tcp &&
+        bs->drv != &bdrv_nbd_unix) {
+        error_setg(errp, "Node '%s' is not an NBD client", node_name);
+        return NULL;
+    }
+
+    s = bs->opaque;
+    info = g_new0(XDbgNbdClient, 1);
+    WITH_QEMU_LOCK_GUARD(&s->requests_lock) {
+        switch (s->state) {
+        case NBD_CLIENT_CONNECTING_WAIT:
+            info->state = XDBG_NBD_CLIENT_STATE_CONNECTING_WAIT;
+            break;
+        case NBD_CLIENT_CONNECTING_NOWAIT:
+            info->state = XDBG_NBD_CLIENT_STATE_CONNECTING_NOWAIT;
+            break;
+        case NBD_CLIENT_CONNECTED:
+            info->state = XDBG_NBD_CLIENT_STATE_CONNECTED;
+            break;
+        case NBD_CLIENT_QUIT:
+            info->state = XDBG_NBD_CLIENT_STATE_QUIT;
+            break;
+        }
+
+        info->connector = g_new0(XDbgNbdClientConnector, 1);
+        switch (nbd_client_connection_get_thread_state(s->conn)) {
+        case NBD_CLIENT_CONNECTION_THREAD_IDLE:
+            info->connector->state = XDBG_NBD_CLIENT_CONNECTOR_STATE_IDLE;
+            break;
+        case NBD_CLIENT_CONNECTION_THREAD_RUNNING:
+            info->connector->state = XDBG_NBD_CLIENT_CONNECTOR_STATE_RUNNING;
+            break;
+        case NBD_CLIENT_CONNECTION_THREAD_PARKED:
+            info->connector->state = XDBG_NBD_CLIENT_CONNECTOR_STATE_PARKED;
+            break;
+        }
+    }
+
+    return info;
+}
+
 static void bdrv_nbd_init(void)
 {
     bdrv_register(&bdrv_nbd);
diff --git a/include/block/nbd.h b/include/block/nbd.h
index ab40842da9..15ddec91ac 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -492,6 +492,15 @@ const char *nbd_mode_lookup(NBDMode mode);
 /* nbd/client-connection.c */
 void nbd_client_connection_enable_retry(NBDClientConnection *conn);
 
+typedef enum NBDClientConnectionThreadState {
+    NBD_CLIENT_CONNECTION_THREAD_IDLE,
+    NBD_CLIENT_CONNECTION_THREAD_RUNNING,
+    NBD_CLIENT_CONNECTION_THREAD_PARKED,
+} NBDClientConnectionThreadState;
+
+NBDClientConnectionThreadState
+nbd_client_connection_get_thread_state(NBDClientConnection *conn);
+
 NBDClientConnection *nbd_client_connection_new(const SocketAddress *saddr,
                                                bool do_negotiation,
                                                const char *export_name,
diff --git a/nbd/client-connection.c b/nbd/client-connection.c
index aec62934d1..78caea3c37 100644
--- a/nbd/client-connection.c
+++ b/nbd/client-connection.c
@@ -42,6 +42,10 @@ struct NBDClientConnection {
     bool do_negotiation;
     bool do_retry;
 
+    /*
+     * @mutex is taken under BDRVNBDState.requests_lock. Calling back into the
+     * block driver with it held is unsafe.
+     */
     QemuMutex mutex;
 
     NBDExportInfo updated_info;
@@ -78,6 +82,24 @@ void nbd_client_connection_enable_retry(NBDClientConnection *conn)
     conn->do_retry = true;
 }
 
+NBDClientConnectionThreadState
+nbd_client_connection_get_thread_state(NBDClientConnection *conn)
+{
+    NBDClientConnectionThreadState ret;
+
+    WITH_QEMU_LOCK_GUARD(&conn->mutex) {
+        if (conn->running) {
+            ret = NBD_CLIENT_CONNECTION_THREAD_RUNNING;
+        } else if (conn->sioc) {
+            ret = NBD_CLIENT_CONNECTION_THREAD_PARKED;
+        } else {
+            ret = NBD_CLIENT_CONNECTION_THREAD_IDLE;
+        }
+    }
+
+    return ret;
+}
+
 NBDClientConnection *nbd_client_connection_new(const SocketAddress *saddr,
                                                bool do_negotiation,
                                                const char *export_name,
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 23c5787d99..0aa3ced3fe 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2217,6 +2217,93 @@
   'features': [ 'unstable' ],
   'allow-preconfig': true }
 
+##
+# @XDbgNbdClientState:
+#     An enumeration of NBD client states.
+#
+# @connecting-wait: No active connection.  Reached when the client
+#     hits an I/O error.  A request waits for the connection attempt
+#     to finish, while reconnect-delay has not expired.
+#
+# @connecting-nowait: No active connection.  Reached when
+#     reconnect-delay expires.  A request fails at once if no channel
+#     is ready.
+#
+# @connected: Client has a valid connection.  Reached when a request
+#     gets a channel from the connector.
+#
+# @quit: Client stopped and will never reconnect.  New requests
+#     fail.  A running attempt or a parked channel stays until the
+#     node is closed.  Reached on fatal error, teardown or yank.
+#
+# Since: 12.0
+##
+{ 'enum': 'XDbgNbdClientState',
+  'data': [ 'connecting-wait', 'connecting-nowait', 'connected', 'quit' ] }
+
+##
+# @XDbgNbdClientConnectorState:
+#     An enumeration of NBD client connector states.
+#
+# @idle: No connection attempt running and no parked channel.  In
+#     'connecting-wait' or 'connecting-nowait', the next request
+#     starts an attempt.
+#
+# @running: Connection attempt is in progress.  A request waits or
+#     fails, as described in 'connecting-wait' and
+#     'connecting-nowait'.
+#
+# @parked: Connection was successful and channel is kept.  The next
+#     request takes the channel and the client goes to 'connected'.
+#
+# Since: 12.0
+##
+{ 'enum': 'XDbgNbdClientConnectorState',
+  'data': [ 'idle', 'running', 'parked' ] }
+
+##
+# @XDbgNbdClientConnector:
+#     The NBD connector information.
+#
+# @state: State of the connector.
+#
+# Since: 12.0
+##
+{ 'struct': 'XDbgNbdClientConnector',
+  'data': { 'state': 'XDbgNbdClientConnectorState' } }
+
+##
+# @XDbgNbdClient:
+#     The NBD connection state of the client and its connector.
+#
+# @state: The client state.
+#
+# @connector: The connector details.
+#
+# Since: 12.0
+##
+{ 'struct': 'XDbgNbdClient',
+  'data': { 'state': 'XDbgNbdClientState',
+            'connector': 'XDbgNbdClientConnector' } }
+
+##
+# @x-debug-query-nbd-client:
+#     Get the NBD client state.
+#
+# @node-name: node name of a block node using the nbd driver.
+#     Use `query-named-block-nodes` to list block nodes.
+#
+# Features:
+#
+# @unstable: This command is meant for debugging and testing.
+#
+# Since: 12.0
+##
+{ 'command': 'x-debug-query-nbd-client',
+  'data': { 'node-name': 'str' },
+  'returns': 'XDbgNbdClient',
+  'features': [ 'unstable' ] }
+
 ##
 # @drive-mirror:
 #     Start mirroring a block device's writes to a new destination.
-- 
2.43.0


