Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E727C52D7B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 21:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scB77-0004bP-Vr; Thu, 08 Aug 2024 17:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1scB6y-0004CE-O7
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 17:55:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1scB6v-0004bk-1d
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 17:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723154150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZsKmWGYl1FCCzGUB0I+eE+oG1CKKLVObfir/0TYGWI0=;
 b=jFpwHmwNzpK5P0VJsJPToW5LEzdWxN85kCL/OelSBtx/idVoMTxSNpYB89O5liTet76tJv
 WTHvwlO/88XTbSv21f+4mabQbaVyIN31dcUfLEfW8GA2EHu9IT2kHqrbW4lBOVDdxhULOr
 CX5mip0Wb2AXmfVVbpqisCHOc/wXDWA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-ktFTkvJYOIyun1Wy22Bw7Q-1; Thu,
 08 Aug 2024 17:55:49 -0400
X-MC-Unique: ktFTkvJYOIyun1Wy22Bw7Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E7591944A80; Thu,  8 Aug 2024 21:55:48 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A71B819560A3; Thu,  8 Aug 2024 21:55:46 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 4/5] nbd/server: CVE-2024-7409: Drop non-negotiating clients
Date: Thu,  8 Aug 2024 16:53:42 -0500
Message-ID: <20240808215529.1065336-11-eblake@redhat.com>
In-Reply-To: <20240808215529.1065336-7-eblake@redhat.com>
References: <20240808215529.1065336-7-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 nbd/server.c     | 28 +++++++++++++++++++++++++++-
 nbd/trace-events |  1 +
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/nbd/server.c b/nbd/server.c
index fee04415d83..c30e687fc8b 100644
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
2.46.0


