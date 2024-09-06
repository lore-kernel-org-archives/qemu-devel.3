Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B2ECD5BDD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 11:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smWyf-0004Uy-S7; Fri, 06 Sep 2024 07:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWyE-0002Dz-5k; Fri, 06 Sep 2024 07:17:42 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWyC-0008CT-95; Fri, 06 Sep 2024 07:17:41 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A3A4D8C4A1;
 Fri,  6 Sep 2024 14:12:09 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id AE99413370A;
 Fri,  6 Sep 2024 14:13:27 +0300 (MSK)
Received: (nullmailer pid 353702 invoked by uid 1000);
 Fri, 06 Sep 2024 11:13:24 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.3 48/69] nbd/server: CVE-2024-7409: Drop non-negotiating
 clients
Date: Fri,  6 Sep 2024 14:12:57 +0300
Message-Id: <20240906111324.353230-48-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
References: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
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

A client that opens a socket but does not negotiate is merely hogging
qemu's resources (an open fd and a small amount of memory); and a
malicious client that can access the port where NBD is listening can
attempt a denial of service attack by intentionally opening and
abandoning lots of unfinished connections.  The previous patch put a
default bound on the number of such ongoing connections, but once that
limit is hit, no more clients can connect (including legitimate ones).
The solution is to insist that clients complete handshake within a
reasonable time limit, defaulting to 10 seconds.  A client that has
not successfully completed NBD_OPT_GO by then (including the case of
where the client didn't know TLS credentials to even reach the point
of NBD_OPT_GO) is wasting our time and does not deserve to stay
connected.  Later patches will allow fine-tuning the limit away from
the default value (including disabling it for doing integration
testing of the handshake process itself).

Note that this patch in isolation actually makes it more likely to see
qemu SEGV after nbd-server-stop, as any client socket still connected
when the server shuts down will now be closed after 10 seconds rather
than at the client's whims.  That will be addressed in the next patch.

For a demo of this patch in action:
$ qemu-nbd -f raw -r -t -e 10 file &
$ nbdsh --opt-mode -c '
H = list()
for i in range(20):
  print(i)
  H.insert(i, nbd.NBD())
  H[i].set_opt_mode(True)
  H[i].connect_uri("nbd://localhost")
'
$ kill $!

where later connections get to start progressing once earlier ones are
forcefully dropped for taking too long, rather than hanging.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20240807174943.771624-13-eblake@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
[eblake: rebase to changes earlier in series, reduce scope of timer]
Signed-off-by: Eric Blake <eblake@redhat.com>
(cherry picked from commit b9b72cb3ce15b693148bd09cef7e50110566d8a0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/nbd/server.c b/nbd/server.c
index e50012499f..39285cc971 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -3186,22 +3186,48 @@ static void nbd_client_receive_next_request(NBDClient *client)
     }
 }
 
+static void nbd_handshake_timer_cb(void *opaque)
+{
+    QIOChannel *ioc = opaque;
+
+    trace_nbd_handshake_timer_cb();
+    qio_channel_shutdown(ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
+}
+
 static coroutine_fn void nbd_co_client_start(void *opaque)
 {
     NBDClient *client = opaque;
     Error *local_err = NULL;
+    QEMUTimer *handshake_timer = NULL;
 
     qemu_co_mutex_init(&client->send_lock);
 
-    /* TODO - utilize client->handshake_max_secs */
+    /*
+     * Create a timer to bound the time spent in negotiation. If the
+     * timer expires, it is likely nbd_negotiate will fail because the
+     * socket was shutdown.
+     */
+    if (client->handshake_max_secs > 0) {
+        handshake_timer = aio_timer_new(qemu_get_aio_context(),
+                                        QEMU_CLOCK_REALTIME,
+                                        SCALE_NS,
+                                        nbd_handshake_timer_cb,
+                                        client->sioc);
+        timer_mod(handshake_timer,
+                  qemu_clock_get_ns(QEMU_CLOCK_REALTIME) +
+                  client->handshake_max_secs * NANOSECONDS_PER_SECOND);
+    }
+
     if (nbd_negotiate(client, &local_err)) {
         if (local_err) {
             error_report_err(local_err);
         }
+        timer_free(handshake_timer);
         client_close(client, false);
         return;
     }
 
+    timer_free(handshake_timer);
     WITH_QEMU_LOCK_GUARD(&client->lock) {
         nbd_client_receive_next_request(client);
     }
diff --git a/nbd/trace-events b/nbd/trace-events
index 00ae3216a1..cbd0a4ab7e 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -76,6 +76,7 @@ nbd_co_receive_request_payload_received(uint64_t cookie, uint64_t len) "Payload
 nbd_co_receive_ext_payload_compliance(uint64_t from, uint64_t len) "client sent non-compliant write without payload flag: from=0x%" PRIx64 ", len=0x%" PRIx64
 nbd_co_receive_align_compliance(const char *op, uint64_t from, uint64_t len, uint32_t align) "client sent non-compliant unaligned %s request: from=0x%" PRIx64 ", len=0x%" PRIx64 ", align=0x%" PRIx32
 nbd_trip(void) "Reading request"
+nbd_handshake_timer_cb(void) "client took too long to negotiate"
 
 # client-connection.c
 nbd_connect_thread_sleep(uint64_t timeout) "timeout %" PRIu64
-- 
2.39.2


