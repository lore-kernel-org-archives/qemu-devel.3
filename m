Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1982A606A323
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=oUXO+HPz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWowI-00055U-2p; Fri, 27 Nov 2026 00:56:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWow2-0004dQ-F9; Fri, 27 Nov 2026 00:55:52 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWovz-0000UY-02; Fri, 27 Nov 2026 00:55:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758870; bh=WjM3QESDaLnrLWxn/7EB5HrfBrKfkz8RR94ADlpKBIM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oUXO+HPz2eyAKMb6LLEkqSCtKWU/49E9bqVpbMwKSKr8K0wedKalRhQm9Z+N6usCf
 +KeEnMu32vDiociMB1+Lami6nyVkUdIr+ATyXHJyNIgDCCrHIqZq0Ge1kkVUyfkL/D
 AE14WxEPI68ByaJfvTq9Q9sy5T6ALZPGblLunfGl4qthUmEVDlGrmliYi7JgQannCt
 ZQDO4RQhG9tdBVsiwm8caBpvvkn2R3TxxXRcU+4fV/M1UyVOBALVwITQrSVKNrma4z
 66CmUP33Y+YdEpw1y7vjRO6p00w4LDsswgBlVo2F7ndaepz15DNxSqlwyrBEMn84II
 IdQbOMkks2pRw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E7D641EA2D3;
 Fri, 27 Nov 2026 08:54:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E46D9469911;
 Fri, 27 Nov 2026 08:54:30 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C3089CF22E; Fri, 27 Nov 2026 08:54:30 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-stable@nongu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 076/140] net: Pad short packets consistently
 regardless of backend
Date: Fri, 27 Nov 2026 08:53:02 +0300
Message-ID: <20261127055421.39015-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

Currently our handling of short network packets (i.e.  those which
are smaller than the minimum ethernet frame size of 60 bytes) is a
little confused.  The intention is that we allow network device
models to transmit short packets, but we protect them from having to
deal with receiving short packets unless they explicitly opt into it.
This means we don't have to have a lot of code in each network device
to try to handle the short packet size -- historically that code was
untested, and often a source of "carefully crafted packet can cause
an out-of-bounds memory access" bugs.

Our implementation of the padding is currently done when each network
backend feeds a packet into the system via one of the
qemu_send_packet family of functions.  This mostly works, except that
we missed some of the more obscure backends (e.g.  the socket
backend), and it means code duplication in each backend.  We'd like
to switch to making qemu_send_packet do the padding itself.  To do
that, we first need to make sure that all the NetClientState
implementations which do not want padding set the do_not_pad flag.
We do this by setting the flag for NetClientState instances created
by qemu_new_net_client() and qemu_new_net_control_client().  Emulated
network devices use qemu_new_nic(), which does not set the flag.

Note that this also causes the net/hub client to request no padding.
This is the right behaviour: we want the hub to accept short packets
and forward them on to all destinations.  Each destination then gets
to choose whether it sees a padded packet or the short one.  The
hub.c code is length-agnostic and doesn't look inside the packets it
is passing on, so it has no issues with short packets.

That change means we can rely on do_not_pad being correct for all
NetClientInfo structs, and so we can pad short packets in the
qemu_send_packet() and qemu_sendv_packet() family of functions.

If the callsite is already padding, then this will have no effect,
but callsites like the socket and dgram backends will now correctly
add padding.  This fixes the bug where when two QEMU instances are
connected via one of those backends a short ARP packet transmitted by
one is not correctly padded by the other and gets dropped.

Note that if we pad a packet, our return value on success will
be the size of the padded packet, not the original. This is OK
because this function (like the NetQueueDeliverFunc function type
documented in include/net/queue.h and which we will eventually
end up calling and returning the return value of) returns
   >0 - success
    0 - queue packet for future redelivery
   <0 - failure (discard packet)
and doesn't guarantee to return exactly the size of the packet
sent. None of the callers try to use the return value as an
exact size.

Cc: qemu-stable@nongu.org
Fixes: CVE-2026-118490
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2362
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-id: 20261110180655.2072265-3-peter.maydell@linaro.org
(cherry picked from commit f448e6d9cf0a637234ab3c9825c390a35971f7c3)
(Mjt: back-port across v11.1.0-1283-ge1c7f36f151c "net/tap: QOMify tap backend")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/net/eth.h b/include/net/eth.h
index aa432b8ef01..ef3478b446c 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -439,4 +439,26 @@ eth_parse_ipv6_hdr(const struct iovec *pkt, int pkt_frags,
 bool eth_pad_short_frame(uint8_t *padded_pkt, size_t *padded_buflen,
                          const void *pkt, size_t pkt_size);
 
+/**
+ * eth_pad_short_frame_iov - pad a short frame, iovec version
+ *
+ * This is equivalent to eth_pad_short_frame(), except that it works
+ * on a packet stored in a struct iovec.
+ *
+ * If the Ethernet frame size is shorter than 60 bytes, it will be padded to
+ * 60 bytes at the address @padded_pkt (and the caller will need to handle
+ * it as a not-in-an-iovec packet).
+ *
+ * @padded_pkt: buffer address to hold the padded frame
+ * @padded_buflen: pointer holding length of @padded_pkt. If the frame is
+ *                 padded, the length will be updated to the padded one.
+ * @iov: iovec holding the original Ethernet frame
+ * @iovcnt: number of elements in @iov
+ * @pkt_size: size of the original Ethernet frame (i.e. iov_size(iov, iovcnt))
+ * @return true if the frame is padded, otherwise false
+ */
+bool eth_pad_short_frame_iov(uint8_t *padded_pkt, size_t *padded_buflen,
+                             const struct iovec *iov, int iovcnt,
+                             size_t pkt_size);
+
 #endif
diff --git a/net/eth.c b/net/eth.c
index 2b7c7fc4000..5ce02d5d903 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -615,3 +615,21 @@ bool eth_pad_short_frame(uint8_t *padded_pkt, size_t *padded_buflen,
 
     return true;
 }
+
+bool eth_pad_short_frame_iov(uint8_t *padded_pkt, size_t *padded_buflen,
+                             const struct iovec *iov, int iovcnt,
+                             size_t pkt_size)
+{
+    assert(padded_buflen && *padded_buflen >= ETH_ZLEN);
+
+    if (pkt_size >= ETH_ZLEN) {
+        return false;
+    }
+
+    /* pad to minimum Ethernet frame length */
+    iov_to_buf(iov, iovcnt, 0, padded_pkt, pkt_size);
+    memset(&padded_pkt[pkt_size], 0, ETH_ZLEN - pkt_size);
+    *padded_buflen = ETH_ZLEN;
+
+    return true;
+}
diff --git a/net/net.c b/net/net.c
index 4a5ceaf7865..7e1441a019f 100644
--- a/net/net.c
+++ b/net/net.c
@@ -266,7 +266,8 @@ static void qemu_net_client_setup(NetClientState *nc,
                                   const char *model,
                                   const char *name,
                                   NetClientDestructor *destructor,
-                                  bool is_datapath)
+                                  bool is_datapath,
+                                  bool do_not_pad)
 {
     nc->info = info;
     nc->model = g_strdup(model);
@@ -286,6 +287,7 @@ static void qemu_net_client_setup(NetClientState *nc,
     nc->incoming_queue = qemu_new_net_queue(qemu_deliver_packet_iov, nc);
     nc->destructor = destructor;
     nc->is_datapath = is_datapath;
+    nc->do_not_pad = do_not_pad;
     QTAILQ_INIT(&nc->filters);
 }
 
@@ -300,7 +302,7 @@ NetClientState *qemu_new_net_client(NetClientInfo *info,
 
     nc = g_malloc0(info->size);
     qemu_net_client_setup(nc, info, peer, model, name,
-                          qemu_net_client_destructor, true);
+                          qemu_net_client_destructor, true, true);
 
     return nc;
 }
@@ -316,7 +318,7 @@ NetClientState *qemu_new_net_control_client(NetClientInfo *info,
 
     nc = g_malloc0(info->size);
     qemu_net_client_setup(nc, info, peer, model, name,
-                          qemu_net_client_destructor, false);
+                          qemu_net_client_destructor, false, true);
 
     return nc;
 }
@@ -343,7 +345,7 @@ NICState *qemu_new_nic(NetClientInfo *info,
 
     for (i = 0; i < queues; i++) {
         qemu_net_client_setup(&nic->ncs[i], info, peers[i], model, name,
-                              NULL, true);
+                              NULL, true, false);
         nic->ncs[i].queue_index = i;
     }
 
@@ -714,6 +716,8 @@ static ssize_t qemu_send_packet_async_with_flags(NetClientState *sender,
 {
     NetQueue *queue;
     int ret;
+    uint8_t min_pkt[ETH_ZLEN];
+    size_t min_pktsz = sizeof(min_pkt);
 
 #ifdef DEBUG_NET
     printf("qemu_send_packet_async:\n");
@@ -724,6 +728,13 @@ static ssize_t qemu_send_packet_async_with_flags(NetClientState *sender,
         return size;
     }
 
+    if (net_peer_needs_padding(sender)) {
+        if (eth_pad_short_frame(min_pkt, &min_pktsz, buf, size)) {
+            buf = min_pkt;
+            size = min_pktsz;
+        }
+    }
+
     /* Let filters handle the packet first */
     ret = filter_receive(sender, NET_FILTER_DIRECTION_TX,
                          sender, flags, buf, size, sent_cb);
@@ -878,6 +889,19 @@ ssize_t qemu_sendv_packet_async(NetClientState *sender,
         return size;
     }
 
+    if (net_peer_needs_padding(sender)) {
+        uint8_t min_pkt[ETH_ZLEN];
+        size_t min_pktsz = sizeof(min_pkt);
+
+        /*
+         * If we pad the packet, we get back a simple buffer, so handle
+         * it by sending it to the non-iov qemu_send_packet function
+         */
+        if (eth_pad_short_frame_iov(min_pkt, &min_pktsz, iov, iovcnt, size)) {
+            return qemu_send_packet_async(sender, min_pkt, min_pktsz, sent_cb);
+        }
+    }
+
     /* Let filters handle the packet first */
     ret = filter_receive_iov(sender, NET_FILTER_DIRECTION_TX, sender,
                              QEMU_NET_PACKET_FLAG_NONE, iov, iovcnt, sent_cb);
-- 
2.47.3


