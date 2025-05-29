Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79E8C5B543
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 22:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKlKm-0005WA-3F; Thu, 29 May 2025 18:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKlKk-0005Vh-1g
 for qemu-devel@nongnu.org; Thu, 29 May 2025 18:02:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKlKi-0002Yx-1h
 for qemu-devel@nongnu.org; Thu, 29 May 2025 18:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748556159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U0vEHaYcZpF3/g7DHEkOZXpi9Y1ZKVx3ya/+92EcPpQ=;
 b=G56Z1BzgPfSXZkzRR85m0dvzYHUdLrmQ5Xy45IXprlhBrWtVhOY7V9gD6ujYLvgc1/aPpF
 7VA6rxcRDmtCB0SQ5SI0FtA73A580Ic+FC7n1utIO8DCta9eaFOvOCYXgawgCv6ShYQiM0
 Hj87UaWH6pN6okUFFTpowq0cBZAXQO0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-FLvnN5IGPmaijhFYwypKyw-1; Thu,
 29 May 2025 18:02:37 -0400
X-MC-Unique: FLvnN5IGPmaijhFYwypKyw-1
X-Mimecast-MFC-AGG-ID: FLvnN5IGPmaijhFYwypKyw_1748556156
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE23E1956086; Thu, 29 May 2025 22:02:35 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.48])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6B1AA19560AE; Thu, 29 May 2025 22:02:34 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nir Soffer <nirsof@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 2/6] nbd: Set unix socket send buffer on macOS
Date: Thu, 29 May 2025 17:02:09 -0500
Message-ID: <20250529220228.1187563-10-eblake@redhat.com>
In-Reply-To: <20250529220228.1187563-8-eblake@redhat.com>
References: <20250529220228.1187563-8-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Nir Soffer <nirsof@gmail.com>

On macOS we need to increase unix socket buffers size on the client and
server to get good performance. We set socket buffers on macOS after
connecting or accepting a client connection.

Testing shows that setting socket receive buffer size (SO_RCVBUF) has no
effect on performance, so we set only the send buffer size (SO_SNDBUF).
It seems to work like Linux but not documented.

Testing shows that optimal buffer size is 512k to 4 MiB, depending on
the test case. The difference is very small, so I chose 2 MiB.

I tested reading from qemu-nbd and writing to qemu-nbd with qemu-img and
computing a blkhash with nbdcopy and blksum.

To focus on NBD communication and get less noisy results, I tested
reading and writing to null-co driver. I added a read-pattern option to
the null-co driver to return data full of 0xff:

    NULL="json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '10g', 'read-pattern': 255}}"

For testing buffer size I added an environment variable for setting the
socket buffer size.

Read from qemu-nbd via qemu-img convert. In this test buffer size of 2m
is optimal (12.6 times faster).

    qemu-nbd -r -t -e 0 -f raw -k /tmp/nbd.sock "$NULL" &
    qemu-img convert -f raw -O raw -W -n "nbd+unix:///?socket=/tmp/nbd.sock" "$NULL"

| buffer size | time    | user    | system  |
|-------------|---------|---------|---------|
|     default |  13.361 |   2.653 |   5.702 |
|       65536 |   2.283 |   0.204 |   1.318 |
|      131072 |   1.673 |   0.062 |   1.008 |
|      262144 |   1.592 |   0.053 |   0.952 |
|      524288 |   1.496 |   0.049 |   0.887 |
|     1048576 |   1.234 |   0.047 |   0.738 |
|     2097152 |   1.060 |   0.080 |   0.602 |
|     4194304 |   1.061 |   0.076 |   0.604 |

Write to qemu-nbd with qemu-img convert. In this test buffer size of 2m
is optimal (9.2 times faster).

    qemu-nbd -t -e 0 -f raw -k /tmp/nbd.sock "$NULL" &
    qemu-img convert -f raw -O raw -W -n "$NULL" "nbd+unix:///?socket=/tmp/nbd.sock"

| buffer size | time    | user    | system  |
|-------------|---------|---------|---------|
|     default |   8.063 |   2.522 |   4.184 |
|       65536 |   1.472 |   0.430 |   0.867 |
|      131072 |   1.071 |   0.297 |   0.654 |
|      262144 |   1.012 |   0.239 |   0.587 |
|      524288 |   0.970 |   0.201 |   0.514 |
|     1048576 |   0.895 |   0.184 |   0.454 |
|     2097152 |   0.877 |   0.174 |   0.440 |
|     4194304 |   0.944 |   0.231 |   0.535 |

Compute a blkhash with nbdcopy, using 4 NBD connections and 256k request
size. In this test buffer size of 4m is optimal (5.1 times faster).

    qemu-nbd -r -t -e 0 -f raw -k /tmp/nbd.sock "$NULL" &
    nbdcopy --blkhash "nbd+unix:///?socket=/tmp/nbd.sock" null:

| buffer size | time    | user    | system  |
|-------------|---------|---------|---------|
|     default |   8.624 |   5.727 |   6.507 |
|       65536 |   2.563 |   4.760 |   2.498 |
|      131072 |   1.903 |   4.559 |   2.093 |
|      262144 |   1.759 |   4.513 |   1.935 |
|      524288 |   1.729 |   4.489 |   1.924 |
|     1048576 |   1.696 |   4.479 |   1.884 |
|     2097152 |   1.710 |   4.480 |   1.763 |
|     4194304 |   1.687 |   4.479 |   1.712 |

Compute a blkhash with blksum, using 1 NBD connection and 256k read
size. In this test buffer size of 512k is optimal (10.3 times faster).

    qemu-nbd -r -t -e 0 -f raw -k /tmp/nbd.sock "$NULL" &
    blksum "nbd+unix:///?socket=/tmp/nbd.sock"

| buffer size | time    | user    | system  |
|-------------|---------|---------|---------|
|     default |  13.085 |   5.664 |   6.461 |
|       65536 |   3.299 |   5.106 |   2.515 |
|      131072 |   2.396 |   4.989 |   2.069 |
|      262144 |   1.607 |   4.724 |   1.555 |
|      524288 |   1.271 |   4.528 |   1.224 |
|     1048576 |   1.294 |   4.565 |   1.333 |
|     2097152 |   1.299 |   4.569 |   1.344 |
|     4194304 |   1.291 |   4.559 |   1.327 |

Signed-off-by: Nir Soffer <nirsof@gmail.com>
Message-ID: <20250517201154.88456-3-nirsof@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/nbd-internal.h      |  5 +++++
 nbd/client-connection.c |  3 +++
 nbd/common.c            | 25 +++++++++++++++++++++++++
 nbd/server.c            |  2 ++
 4 files changed, 35 insertions(+)

diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index 715d92d6efc..6bafeef5ddc 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -74,4 +74,9 @@ static inline int nbd_write(QIOChannel *ioc, const void *buffer, size_t size,

 int nbd_drop(QIOChannel *ioc, size_t size, Error **errp);

+/* nbd_set_socket_send_buffer
+ * Set the socket send buffer size for optimal performance.
+ */
+void nbd_set_socket_send_buffer(QIOChannelSocket *sioc);
+
 #endif
diff --git a/nbd/client-connection.c b/nbd/client-connection.c
index b11e266807d..79ea97e4cc1 100644
--- a/nbd/client-connection.c
+++ b/nbd/client-connection.c
@@ -31,6 +31,8 @@
 #include "qapi/clone-visitor.h"
 #include "qemu/coroutine.h"

+#include "nbd/nbd-internal.h"
+
 struct NBDClientConnection {
     /* Initialization constants, never change */
     SocketAddress *saddr; /* address to connect to */
@@ -140,6 +142,7 @@ static int nbd_connect(QIOChannelSocket *sioc, SocketAddress *addr,
         return ret;
     }

+    nbd_set_socket_send_buffer(sioc);
     qio_channel_set_delay(QIO_CHANNEL(sioc), false);

     if (!info) {
diff --git a/nbd/common.c b/nbd/common.c
index 589a748cfe6..9436e9d1d14 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -18,6 +18,9 @@

 #include "qemu/osdep.h"
 #include "trace.h"
+#include "io/channel-socket.h"
+#include "qapi/error.h"
+#include "qemu/units.h"
 #include "nbd-internal.h"

 /* Discard length bytes from channel.  Return -errno on failure and 0 on
@@ -264,3 +267,25 @@ const char *nbd_mode_lookup(NBDMode mode)
         return "<unknown>";
     }
 }
+
+/*
+ * Testing shows that 2m send buffer is optimal. Changing the receive buffer
+ * size has no effect on performance.
+ */
+#if defined(__APPLE__)
+#define UNIX_STREAM_SOCKET_SEND_BUFFER_SIZE (2 * MiB)
+#endif
+
+void nbd_set_socket_send_buffer(QIOChannelSocket *sioc)
+{
+#ifdef UNIX_STREAM_SOCKET_SEND_BUFFER_SIZE
+    if (sioc->localAddr.ss_family == AF_UNIX) {
+        size_t size = UNIX_STREAM_SOCKET_SEND_BUFFER_SIZE;
+        Error *errp = NULL;
+
+        if (qio_channel_socket_set_send_buffer(sioc, size, &errp) < 0) {
+            warn_report_err(errp);
+        }
+    }
+#endif /* UNIX_STREAM_SOCKET_SEND_BUFFER_SIZE */
+}
diff --git a/nbd/server.c b/nbd/server.c
index 2076fb2666b..d242be98115 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -3291,6 +3291,8 @@ void nbd_client_new(QIOChannelSocket *sioc,
     client->close_fn = close_fn;
     client->owner = owner;

+    nbd_set_socket_send_buffer(sioc);
+
     co = qemu_coroutine_create(nbd_co_client_start, client);
     qemu_coroutine_enter(co);
 }
-- 
2.49.0


