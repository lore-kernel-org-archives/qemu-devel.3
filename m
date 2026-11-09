Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142A06082BE5
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ovhcloud.com header.i=@ovhcloud.com header.a=rsa-sha256 header.s=mailout header.b=aEuapToE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQRtY-00057J-7d; Mon, 09 Nov 2026 11:06:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xQRtR-00055O-0N; Mon, 09 Nov 2026 11:06:50 -0500
Received: from 1.mo508.mail-out.ovh.net ([5.135.90.176])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xQRtO-0005QB-2w; Mon, 09 Nov 2026 11:06:48 -0500
Received: from DAGFR11EX3.OVH.local (unknown [10.110.54.187])
 by mo508.mail-out.ovh.net (Postfix) with ESMTPS id 4jNZQy5vLcz7tDX;
 Mon,  9 Nov 2026 16:06:34 +0000 (UTC)
Received: from ovhcloud.com (109.190.254.61) by DAGFR11EX3.OVH.local
 (172.16.2.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 17:06:34 +0100
From: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-block@nongnu.org>, <eblake@redhat.com>, <vsementsov@yandex-team.ru>, 
 <kwolf@redhat.com>, <hreitz@redhat.com>, <armbru@redhat.com>, Guillaume
 Vincke <guillaume.vincke@ovhcloud.com>
Subject: [PATCH 1/2] nbd: Add an unstable query for the client state
Date: Mon, 9 Nov 2026 17:06:08 +0100
Message-ID: <20261109160609.1434289-2-guillaume.vincke@ovhcloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109160609.1434289-1-guillaume.vincke@ovhcloud.com>
References: <20261109160609.1434289-1-guillaume.vincke@ovhcloud.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CAS4.OVH.local (172.16.1.4) To DAGFR11EX3.OVH.local
 (172.16.2.113)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 17260608524438225336
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTFP/HMCIPMJK4Fn1LSeHOUwlD4FYOZfx9NtiC+yIw3TvKlgPFr0oV+sXnY6O6ogoIlp4T+QFuidJ15usu5lPJF/QFIQ2x1Xep+q3BDawkTePFEG7vZsSmYbOmb8hWp5RP7ABlosQvRHG2Dw07zXMJfbwR1581InlYbpRHFHumVuMrd3PdUpdLVCnsm0JAMPHObY++5cGOT4U5i7jXlvy5lpaqlQnRMn1wj5k2pXibit82JSx8yOA41kQMKfeYrSjGxJQVp4SlAheU/ZrF3KyfTtqzAp8wcrU9GZRYWIJWbSx0MQEfGmuDRbw4HUodIkWwV25IEsQ9Ud172fJ9ILI1UCpZGr3W5oCzymRNCnq0SIIV6XkA//VquRqGegUuT7+MY+razSrZcyVhh6KGwZCPU4lbCaql106fQJ9b39Y0BICHndo3zQkzidvfpDTNce26w8ujJq0MEVGpN4NTdd9EZFUltAJdw3fZIE4h5qOpwpzM5LlQe6dgtHMySH5JArKmUsYCJ4lxyL3ClyMx1HL/fQyceYW1v1vClubaZnfAJ86Hycz3Lh1mTwQ9COUUcmswdQQ3eceO69Oi3MB5jXgkM7/5aCskr4bpf1Ec3BWrYQNxy8tWkcuX3nQn1zMmLszGcEWo4XoBqoSSYecrTdzgzzvLTOXrdEoBjjFXiipjUT9g
DKIM-Signature: a=rsa-sha256; bh=CuNYb8lq2RSuS41nKf/cOMrqT2czUSWHLncJKXJVnSE=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1794240395; v=1; 
 b=aEuapToEGpm6dYGWgQ0XjEpuKoNf0MudHyNZvVOBylNaIcxAMbCCeLzTyKEcvFQWKb8r2wDf
 9lYvsm9gJlXRaP8AZDfYqlV2G/uJEsGLgTPzOx3l/R2PBl4Pu3I5hJCro0+Rnu0jzLbww5sHF5C
 ZKg+oOyrkU6dHRyOfT/K9QIg=
Received-SPF: pass client-ip=5.135.90.176;
 envelope-from=guillaume.vincke@ovhcloud.com; helo=1.mo508.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 block/nbd.c             | 57 +++++++++++++++++++++++++++++
 include/block/nbd.h     |  9 +++++
 nbd/client-connection.c | 18 ++++++++++
 qapi/block-core.json    | 79 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 163 insertions(+)

diff --git a/block/nbd.c b/block/nbd.c
index e5e16722ba..b9f8d92e43 100644
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
+    }
+
+    switch (nbd_client_connection_get_thread_state(s->conn)) {
+    case NBD_CLIENT_CONNECTION_THREAD_IDLE:
+        break;
+    case NBD_CLIENT_CONNECTION_THREAD_RUNNING:
+        info->connector = g_new0(XDbgNbdClientConnector, 1);
+        info->connector->state = XDBG_NBD_CLIENT_CONNECTOR_STATE_RUNNING;
+        break;
+    case NBD_CLIENT_CONNECTION_THREAD_PARKED:
+        info->connector = g_new0(XDbgNbdClientConnector, 1);
+        info->connector->state = XDBG_NBD_CLIENT_CONNECTOR_STATE_PARKED;
+        break;
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
index aec62934d1..7172ba49b3 100644
--- a/nbd/client-connection.c
+++ b/nbd/client-connection.c
@@ -78,6 +78,24 @@ void nbd_client_connection_enable_retry(NBDClientConnection *conn)
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
index 23c5787d99..973be06dfd 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2217,6 +2217,85 @@
   'features': [ 'unstable' ],
   'allow-preconfig': true }
 
+##
+# @XDbgNbdClientState:
+#     Enum of NBD client state.
+#
+# @connecting-wait: No active connection.  A request waits for the
+#     connection attempt to finish, while reconnect-delay has not
+#     expired.
+#
+# @connecting-nowait: No active connection.  A request fails at once
+#     if no channel is ready.
+#
+# @connected: Client has a valid connection.
+#
+# @quit: Client will not reconnect.
+#
+# Since: 11.2
+##
+{ 'enum': 'XDbgNbdClientState',
+  'data': [ 'connecting-wait', 'connecting-nowait', 'connected', 'quit' ] }
+
+##
+# @XDbgNbdClientConnectorState:
+#     Enum of NBD client connector state.
+#
+# @running: Connection attempt is in progress.
+#
+# @parked: Connection was successful and channel is kept for the next
+#     request.
+#
+# Since: 11.2
+##
+{ 'enum': 'XDbgNbdClientConnectorState',
+  'data': [ 'running', 'parked' ] }
+
+##
+# @XDbgNbdClientConnector:
+#     The NBD connector information.
+#
+# @state: State of the connector.
+#
+# Since: 11.2
+##
+{ 'struct': 'XDbgNbdClientConnector',
+  'data': { 'state': 'XDbgNbdClientConnectorState' } }
+
+##
+# @XDbgNbdClient:
+#     The NBD connection state of the client and its connector.
+#     The two members are read independently and may not reflect a
+#     single point in time.
+#
+# @state: The client state.
+#
+# @connector: The connector details.  Only present while a connection
+#     attempt is running or its channel is parked.
+#
+# Since: 11.2
+##
+{ 'struct': 'XDbgNbdClient',
+  'data': { 'state': 'XDbgNbdClientState',
+            '*connector': 'XDbgNbdClientConnector' } }
+
+##
+# @x-debug-query-nbd-client:
+#     Get the NBD client state.
+#
+# @node-name: node name of the NBD client to query.
+#
+# Features:
+#
+# @unstable: This command is meant for debugging and testing.
+#
+# Since: 11.2
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


