Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1679CC52D73
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 17:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbknd-0007iP-3X; Wed, 07 Aug 2024 13:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sbknb-0007cb-Ev
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 13:50:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sbknY-0000ec-W6
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 13:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723053006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mSsShYzPlJI57BAyKKLWDzA6RZk1TkPdg3ohuGwM5oU=;
 b=hiAzxwtT2bnubVoCa3CqkerokrGwFVRmFhMWs9jYvecqHG8tf3X8gyqP2eRC3CpjwNYsXP
 oEzA9DuWaoFww2NkyXawi1d5K91jgm9L33FP+qYyHcK1E5W5ooghO/2tw30lQNlAlt8+kt
 76gzthz87+PSoXoEuvriEzlq5RA5/pg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-ynPJrK0RPsiEhxrKOeFMcw-1; Wed,
 07 Aug 2024 13:50:02 -0400
X-MC-Unique: ynPJrK0RPsiEhxrKOeFMcw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6781E19560B6; Wed,  7 Aug 2024 17:50:01 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4F0A7300018D; Wed,  7 Aug 2024 17:49:58 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, vsementsov@yandex-team.ru
Subject: [PATCH v4 4/7] nbd/server: CVE-2024-7409: Drop non-negotiating clients
Date: Wed,  7 Aug 2024 12:43:30 -0500
Message-ID: <20240807174943.771624-13-eblake@redhat.com>
In-Reply-To: <20240807174943.771624-9-eblake@redhat.com>
References: <20240807174943.771624-9-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

where later connections get to start progressing once earlier ones are
forcefully dropped for taking too long, rather than hanging.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c     | 31 ++++++++++++++++++++++++++++++-
 nbd/trace-events |  1 +
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/nbd/server.c b/nbd/server.c
index 31b77bf0d4f..a470052d957 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -132,6 +132,7 @@ struct NBDClient {
     QCryptoTLSCreds *tlscreds;
     char *tlsauthz;
     uint32_t handshake_limit;
+    QEMUTimer *handshake_timer;
     QIOChannelSocket *sioc; /* The underlying data channel */
     QIOChannel *ioc; /* The current I/O channel which may differ (eg TLS) */

@@ -3186,6 +3187,14 @@ static void nbd_client_receive_next_request(NBDClient *client)
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
@@ -3193,15 +3202,35 @@ static coroutine_fn void nbd_co_client_start(void *opaque)

     qemu_co_mutex_init(&client->send_lock);

-    /* TODO - utilize client->handshake_limit */
+    /*
+     * Create a timer to bound the time spent in negotiation. If the
+     * timer expires, it is likely nbd_negotiate will fail because the
+     * socket was shutdown.
+     */
+    client->handshake_timer = aio_timer_new(qemu_get_aio_context(),
+                                            QEMU_CLOCK_REALTIME,
+                                            SCALE_NS,
+                                            nbd_handshake_timer_cb,
+                                            client->sioc);
+    if (client->handshake_limit > 0) {
+        timer_mod(client->handshake_timer,
+                  qemu_clock_get_ns(QEMU_CLOCK_REALTIME) +
+                  client->handshake_limit * NANOSECONDS_PER_SECOND);
+    }
+
     if (nbd_negotiate(client, &local_err)) {
         if (local_err) {
             error_report_err(local_err);
         }
+        timer_free(client->handshake_timer);
+        client->handshake_timer = NULL;
         client_close(client, false);
         return;
     }

+    timer_free(client->handshake_timer);
+    client->handshake_timer = NULL;
+
     WITH_QEMU_LOCK_GUARD(&client->lock) {
         nbd_client_receive_next_request(client);
     }
diff --git a/nbd/trace-events b/nbd/trace-events
index 00ae3216a11..cbd0a4ab7e4 100644
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
2.45.2


