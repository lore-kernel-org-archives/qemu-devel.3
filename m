Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71AC8CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 08:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHdWR-0005HX-EF; Fri, 16 Oct 2026 04:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xHdWM-0005Ga-6j; Fri, 16 Oct 2026 04:42:34 -0400
Received: from 2.mo15.mail-out.ovh.net ([5.135.90.179])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xHdWJ-0000fa-TS; Fri, 16 Oct 2026 04:42:33 -0400
Received: from DAGFR11EX3.OVH.local (unknown [10.109.254.243])
 by mo15.mail-out.ovh.net (Postfix) with ESMTPS id 4j5djV6177z3y0C;
 Fri, 16 Oct 2026 08:42:22 +0000 (UTC)
Received: from ovhcloud.com (109.190.254.61) by DAGFR11EX3.OVH.local
 (172.16.2.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 10:42:22 +0200
From: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-block@nongnu.org>, Eric Blake <eblake@redhat.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Guillaume Vincke
 <guillaume.vincke@ovhcloud.com>
Subject: [PATCH v2 1/2] nbd/client-connection: Fix client returning a closed
 channel
Date: Fri, 16 Oct 2026 10:41:35 +0200
Message-ID: <20261016084136.233836-2-guillaume.vincke@ovhcloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016084136.233836-1-guillaume.vincke@ovhcloud.com>
References: <20261016084136.233836-1-guillaume.vincke@ovhcloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [109.190.254.61]
X-ClientProxiedBy: CAS4.OVH.local (172.16.1.4) To DAGFR11EX3.OVH.local
 (172.16.2.113)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 16388036094213570855
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFQWFIasQWwgkcRHX+30LvtB4TZAVg1fsrA7T7lVwn4CHTDRSIX0O3imyPoZCSjpPjSg8ZonNEjcciV1rkWuhkRBqebwbKRn8B5Aqi6+Bo3JbPlJNbNJV5HiMfeX0RRoEBhBl/gVCCPAVkfGN6ksPSIzC8uoB3ez40EtDyluuxQ/8XKJpcKy8Mheg1n1w+YqbMbrd49oj7mkGUJZEiSrgc8QrVGxnKpZLAFF8fi+BVId9Modl3fQwmfrnzRJg8pajcdKoBAMLXb+ZQC5A+JT8XVDRrUhB7x5dqOMv+0B6ar3EjdMHjhN3hYAzARm83XbImcRt58AUJw9UT89BdOlQOFo6dufizF2KDbqexKHpRBSeRu0gHWy3fwnfbR4CQpd3yHI52R/lU0sW8iMHPqSgNTpROMD8B2QbBRLbVe2+7C4HR04uxldmFkRjpwhhtDvy2w9UO8GSSr8fmgVRdRDXnXHWvXb4IaWT/+lN1mkVSqTcU5PVJl1nZv7yiGwXXXwxfc+9DGfeA5tIMscxfbtFv43A7BMkA8IMVSGuvgDBNgr8rNiCGLJ4VMKQ8KN0zFr7uJ1K2gFAqmzHCqtKzTJFfQf5QwwKK+GxfJ89V07UCY8fmYzEQ+CN36gZfsoO0xOegxcV4H9SdfyXfF2mDzkHtuios1pDvAvuZ8GrkAT7wp9g
DKIM-Signature: a=rsa-sha256; bh=US8NJbCfg9WNF2BgSiZJeNvLqjLRNqts6mdflstllps=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1792140143; v=1; 
 b=ErTO6lle33Tsza4WHo8cnMR2Z01Gw5Gl7B+ue0FQB/YpMhwq2/g+yzY1h+6GpYXjb7csnuhr
 UUE3mMvEs42MJRMTley9H5iFUwtn0p51SRXjyWm7hmKWC0TfDbug6Hou+4wTnfufem9OE/uy6LL
 ngpLTs8cfh+ndJ6hua/fGACw=
Received-SPF: pass client-ip=5.135.90.179;
 envelope-from=guillaume.vincke@ovhcloud.com; helo=2.mo15.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: guillaume.vincke@ovhcloud.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When a server closes the connection after a successful handshake but
before running any operations, the channel returned by
nbd_co_establish_connection() is the closed one and the connect thread
is not started.

When configured with reconnect-delay=0 (the default), this situation
generates at least two IO errors. The first one happens when trying to
issue an operation to the closed socket. The connect thread will be
started on the next request, which may happen long after, and will
create the second error as nbd_co_establish_connection() returns a NULL
channel.

Peeking the channel to detect FIN or RST avoids the first IO error and
does not delay the starting of the connect thread.

Signed-off-by: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 nbd/client-connection.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/nbd/client-connection.c b/nbd/client-connection.c
index 6a4f080717..aec62934d1 100644
--- a/nbd/client-connection.c
+++ b/nbd/client-connection.c
@@ -274,6 +274,23 @@ void nbd_client_connection_release(NBDClientConnection *conn)
     }
 }
 
+/* Only true when the peer closed the channel. Does not detect if dead. */
+static bool nbd_channel_is_closed(QIOChannel *ioc)
+{
+    char data;
+    struct iovec iov = { .iov_base = &data, .iov_len = 1 };
+    ssize_t len = -1;
+
+    if (!qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
+        return false;
+    }
+
+    len = qio_channel_readv_full(
+        ioc, &iov, 1, NULL, NULL, QIO_CHANNEL_READ_FLAG_MSG_PEEK, NULL);
+
+    return len == 0 || (len < 0 && len != QIO_CHANNEL_ERR_BLOCK);
+}
+
 /*
  * Get a new connection in context of @conn:
  *   if the thread is running, wait for completion
@@ -295,6 +312,7 @@ nbd_co_establish_connection(NBDClientConnection *conn, NBDExportInfo *info,
                             bool blocking, Error **errp)
 {
     QemuThread thread;
+    QIOChannel *ioc;
 
     if (conn->do_negotiation) {
         assert(info);
@@ -308,6 +326,20 @@ nbd_co_establish_connection(NBDClientConnection *conn, NBDExportInfo *info,
         assert(!conn->wait_co);
 
         if (!conn->running) {
+            if (conn->sioc) {
+                /* discard if the socket got closed by its peer */
+                ioc = QIO_CHANNEL(conn->sioc);
+                if (!qio_channel_set_blocking(ioc, false, NULL) ||
+                    nbd_channel_is_closed(ioc)) {
+
+                    qio_channel_close(ioc, NULL);
+                    object_unref(OBJECT(conn->sioc));
+                    conn->sioc = NULL;
+                    object_unref(OBJECT(conn->ioc));
+                    conn->ioc = NULL;
+                }
+            }
+
             if (conn->sioc) {
                 /* Previous attempt finally succeeded in background */
                 if (conn->do_negotiation) {
-- 
2.43.0


