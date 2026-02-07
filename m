Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7EFEE0ADC
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 13:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voifJ-00030H-FG; Sat, 07 Feb 2026 08:48:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1voifE-000305-0S
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 08:47:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1voif9-0003Ca-BT
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 08:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770472070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+/kZUQ2TG1BpuGHqKkikBty9u1J/HcAWH6IWltMHcy4=;
 b=AfMPSglmmZTWbRo+GlAGQW+fI5TEsMYhSmJJPQxC9uMv3XxhlDhodxYeSDx1l5dPOQTuEg
 Xrjtunzd7WL9RMwD4/49ppxPJeYhx8l7QnbE6rZyhKwBbPn0uR6dGm3COeZXJga4lsiPSA
 prcjGDdKTHrRUb8FBDuuJIcxXD5imuM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-0naedmn0ObaYECvfR7nX7g-1; Sat,
 07 Feb 2026 08:47:47 -0500
X-MC-Unique: 0naedmn0ObaYECvfR7nX7g-1
X-Mimecast-MFC-AGG-ID: 0naedmn0ObaYECvfR7nX7g_1770472066
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA49D1955F12; Sat,  7 Feb 2026 13:47:45 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.15])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8556718004AD; Sat,  7 Feb 2026 13:47:42 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, qemu-devel@nongnu.org
Subject: [PATCH 01/12] net: introduce read_poll/write_poll
Date: Sat,  7 Feb 2026 21:47:17 +0800
Message-ID: <20260207134728.1495932-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jason Wang <jasowang@redhat.com>

The existing NetClientInfo::poll() callback enables or disables both read
and write polling together. However, some use cases (such as filter-redirector
with enable_when_stopped) need finer control to enable only read polling
while the VM is stopped, without affecting write polling.

This patch adds separate read_poll() and write_poll() callbacks to
NetClientInfo, allowing independent control of read and write fd handlers.

Changes:
- Add NetReadPoll and NetWritePoll typedefs to net/net.h
- Add read_poll and write_poll fields to NetClientInfo
- Rename internal functions (e.g., tap_read_poll -> tap_update_read_poll)
  to avoid name collision with the new callbacks
- Implement read_poll/write_poll callbacks for tap, af-xdp, l2tpv3, and
  netmap backends

This infrastructure will be used by filter-redirector to selectively enable
backend read polling when the VM is stopped, allowing network traffic to be
drained into the netfilter chain during migration pre-switchover.

Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 include/net/net.h |  4 ++++
 net/af-xdp.c      | 32 +++++++++++++++++++++++---------
 net/l2tpv3.c      | 38 ++++++++++++++++++++++++++------------
 net/netmap.c      | 30 ++++++++++++++++++++++--------
 net/tap.c         | 36 +++++++++++++++++++++++++-----------
 5 files changed, 100 insertions(+), 40 deletions(-)

diff --git a/include/net/net.h b/include/net/net.h
index 72b476ee1d..d2b2e6fc44 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -55,6 +55,8 @@ typedef struct NetOffloads {
 /* Net clients */
 
 typedef void (NetPoll)(NetClientState *, bool enable);
+typedef void (NetReadPoll)(NetClientState *, bool enable);
+typedef void (NetWritePoll)(NetClientState *, bool enable);
 typedef bool (NetCanReceive)(NetClientState *);
 typedef int (NetStart)(NetClientState *);
 typedef int (NetLoad)(NetClientState *);
@@ -96,6 +98,8 @@ typedef struct NetClientInfo {
     LinkStatusChanged *link_status_changed;
     QueryRxFilter *query_rx_filter;
     NetPoll *poll;
+    NetReadPoll *read_poll;
+    NetWritePoll *write_poll;
     HasUfo *has_ufo;
     HasUso *has_uso;
     HasTunnel *has_tunnel;
diff --git a/net/af-xdp.c b/net/af-xdp.c
index 14f302ea21..b6e50b698f 100644
--- a/net/af-xdp.c
+++ b/net/af-xdp.c
@@ -72,7 +72,7 @@ static void af_xdp_update_fd_handler(AFXDPState *s)
 }
 
 /* Update the read handler. */
-static void af_xdp_read_poll(AFXDPState *s, bool enable)
+static void af_xdp_update_read_poll(AFXDPState *s, bool enable)
 {
     if (s->read_poll != enable) {
         s->read_poll = enable;
@@ -81,7 +81,7 @@ static void af_xdp_read_poll(AFXDPState *s, bool enable)
 }
 
 /* Update the write handler. */
-static void af_xdp_write_poll(AFXDPState *s, bool enable)
+static void af_xdp_update_write_poll(AFXDPState *s, bool enable)
 {
     if (s->write_poll != enable) {
         s->write_poll = enable;
@@ -100,6 +100,18 @@ static void af_xdp_poll(NetClientState *nc, bool enable)
     }
 }
 
+static void af_xdp_read_poll(NetClientState *nc, bool enable)
+{
+    AFXDPState *s = DO_UPCAST(AFXDPState, nc, nc);
+    af_xdp_update_read_poll(s, enable);
+}
+
+static void af_xdp_write_poll(NetClientState *nc, bool enable)
+{
+    AFXDPState *s = DO_UPCAST(AFXDPState, nc, nc);
+    af_xdp_update_write_poll(s, enable);
+}
+
 static void af_xdp_complete_tx(AFXDPState *s)
 {
     uint32_t idx = 0;
@@ -135,7 +147,7 @@ static void af_xdp_writable(void *opaque)
      * and kernel needs a wake up.
      */
     if (!s->outstanding_tx || !xsk_ring_prod__needs_wakeup(&s->tx)) {
-        af_xdp_write_poll(s, false);
+        af_xdp_update_write_poll(s, false);
     }
 
     /* Flush any buffered packets. */
@@ -163,7 +175,7 @@ static ssize_t af_xdp_receive(NetClientState *nc,
          * Out of buffers or space in tx ring.  Poll until we can write.
          * This will also kick the Tx, if it was waiting on CQ.
          */
-        af_xdp_write_poll(s, true);
+        af_xdp_update_write_poll(s, true);
         return 0;
     }
 
@@ -178,7 +190,7 @@ static ssize_t af_xdp_receive(NetClientState *nc,
     s->outstanding_tx++;
 
     if (xsk_ring_prod__needs_wakeup(&s->tx)) {
-        af_xdp_write_poll(s, true);
+        af_xdp_update_write_poll(s, true);
     }
 
     return size;
@@ -192,7 +204,7 @@ static void af_xdp_send_completed(NetClientState *nc, ssize_t len)
 {
     AFXDPState *s = DO_UPCAST(AFXDPState, nc, nc);
 
-    af_xdp_read_poll(s, true);
+    af_xdp_update_read_poll(s, true);
 }
 
 static void af_xdp_fq_refill(AFXDPState *s, uint32_t n)
@@ -215,7 +227,7 @@ static void af_xdp_fq_refill(AFXDPState *s, uint32_t n)
 
     if (xsk_ring_prod__needs_wakeup(&s->fq)) {
         /* Receive was blocked by not having enough buffers.  Wake it up. */
-        af_xdp_read_poll(s, true);
+        af_xdp_update_read_poll(s, true);
     }
 }
 
@@ -246,7 +258,7 @@ static void af_xdp_send(void *opaque)
              * The peer does not receive anymore.  Packet is queued, stop
              * reading from the backend until af_xdp_send_completed().
              */
-            af_xdp_read_poll(s, false);
+            af_xdp_update_read_poll(s, false);
 
             /* Return unused descriptors to not break the ring cache. */
             xsk_ring_cons__cancel(&s->rx, n_rx - i - 1);
@@ -438,6 +450,8 @@ static NetClientInfo net_af_xdp_info = {
     .size = sizeof(AFXDPState),
     .receive = af_xdp_receive,
     .poll = af_xdp_poll,
+    .read_poll = af_xdp_read_poll,
+    .write_poll = af_xdp_write_poll,
     .cleanup = af_xdp_cleanup,
 };
 
@@ -571,7 +585,7 @@ int net_init_af_xdp(const Netdev *netdev,
         }
     }
 
-    af_xdp_read_poll(s, true); /* Initially only poll for reads. */
+    af_xdp_update_read_poll(s, true); /* Initially only poll for reads. */
 
     return 0;
 
diff --git a/net/l2tpv3.c b/net/l2tpv3.c
index cdfc641aa6..9f24982a94 100644
--- a/net/l2tpv3.c
+++ b/net/l2tpv3.c
@@ -143,7 +143,7 @@ static void l2tpv3_update_fd_handler(NetL2TPV3State *s)
                         s);
 }
 
-static void l2tpv3_read_poll(NetL2TPV3State *s, bool enable)
+static void l2tpv3_update_read_poll(NetL2TPV3State *s, bool enable)
 {
     if (s->read_poll != enable) {
         s->read_poll = enable;
@@ -151,7 +151,7 @@ static void l2tpv3_read_poll(NetL2TPV3State *s, bool enable)
     }
 }
 
-static void l2tpv3_write_poll(NetL2TPV3State *s, bool enable)
+static void l2tpv3_update_write_poll(NetL2TPV3State *s, bool enable)
 {
     if (s->write_poll != enable) {
         s->write_poll = enable;
@@ -162,21 +162,33 @@ static void l2tpv3_write_poll(NetL2TPV3State *s, bool enable)
 static void l2tpv3_writable(void *opaque)
 {
     NetL2TPV3State *s = opaque;
-    l2tpv3_write_poll(s, false);
+    l2tpv3_update_write_poll(s, false);
     qemu_flush_queued_packets(&s->nc);
 }
 
 static void l2tpv3_send_completed(NetClientState *nc, ssize_t len)
 {
     NetL2TPV3State *s = DO_UPCAST(NetL2TPV3State, nc, nc);
-    l2tpv3_read_poll(s, true);
+    l2tpv3_update_read_poll(s, true);
 }
 
 static void l2tpv3_poll(NetClientState *nc, bool enable)
 {
     NetL2TPV3State *s = DO_UPCAST(NetL2TPV3State, nc, nc);
-    l2tpv3_write_poll(s, enable);
-    l2tpv3_read_poll(s, enable);
+    l2tpv3_update_write_poll(s, enable);
+    l2tpv3_update_read_poll(s, enable);
+}
+
+static void l2tpv3_read_poll(NetClientState *nc, bool enable)
+{
+    NetL2TPV3State *s = DO_UPCAST(NetL2TPV3State, nc, nc);
+    l2tpv3_update_read_poll(s, enable);
+}
+
+static void l2tpv3_write_poll(NetClientState *nc, bool enable)
+{
+    NetL2TPV3State *s = DO_UPCAST(NetL2TPV3State, nc, nc);
+    l2tpv3_update_write_poll(s, enable);
 }
 
 static void l2tpv3_form_header(NetL2TPV3State *s)
@@ -252,7 +264,7 @@ static ssize_t net_l2tpv3_receive_dgram_iov(NetClientState *nc,
         /* signal upper layer that socket buffer is full */
         ret = -errno;
         if (ret == -EAGAIN || ret == -ENOBUFS) {
-            l2tpv3_write_poll(s, true);
+            l2tpv3_update_write_poll(s, true);
             ret = 0;
         }
     }
@@ -295,7 +307,7 @@ static ssize_t net_l2tpv3_receive_dgram(NetClientState *nc,
         ret = -errno;
         if (ret == -EAGAIN || ret == -ENOBUFS) {
             /* signal upper layer that socket buffer is full */
-            l2tpv3_write_poll(s, true);
+            l2tpv3_update_write_poll(s, true);
             ret = 0;
         }
     }
@@ -369,7 +381,7 @@ static void net_l2tpv3_process_queue(NetL2TPV3State *s)
                             l2tpv3_send_completed
                         );
                     if (size == 0) {
-                        l2tpv3_read_poll(s, false);
+                        l2tpv3_update_read_poll(s, false);
                     }
                     bad_read = false;
                 } else {
@@ -497,8 +509,8 @@ static void net_l2tpv3_cleanup(NetClientState *nc)
 {
     NetL2TPV3State *s = DO_UPCAST(NetL2TPV3State, nc, nc);
     qemu_purge_queued_packets(nc);
-    l2tpv3_read_poll(s, false);
-    l2tpv3_write_poll(s, false);
+    l2tpv3_update_read_poll(s, false);
+    l2tpv3_update_write_poll(s, false);
     if (s->fd >= 0) {
         close(s->fd);
     }
@@ -514,6 +526,8 @@ static NetClientInfo net_l2tpv3_info = {
     .receive = net_l2tpv3_receive_dgram,
     .receive_iov = net_l2tpv3_receive_dgram_iov,
     .poll = l2tpv3_poll,
+    .read_poll = l2tpv3_read_poll,
+    .write_poll = l2tpv3_write_poll,
     .cleanup = net_l2tpv3_cleanup,
 };
 
@@ -715,7 +729,7 @@ int net_init_l2tpv3(const Netdev *netdev,
     s->fd = fd;
     s->counter = 0;
 
-    l2tpv3_read_poll(s, true);
+    l2tpv3_update_read_poll(s, true);
 
     qemu_set_info_str(&s->nc, "l2tpv3: connected");
     return 0;
diff --git a/net/netmap.c b/net/netmap.c
index 6cd8f2bdc5..2e2a95a256 100644
--- a/net/netmap.c
+++ b/net/netmap.c
@@ -113,7 +113,7 @@ static void netmap_update_fd_handler(NetmapState *s)
 }
 
 /* Update the read handler. */
-static void netmap_read_poll(NetmapState *s, bool enable)
+static void netmap_update_read_poll(NetmapState *s, bool enable)
 {
     if (s->read_poll != enable) { /* Do nothing if not changed. */
         s->read_poll = enable;
@@ -122,7 +122,7 @@ static void netmap_read_poll(NetmapState *s, bool enable)
 }
 
 /* Update the write handler. */
-static void netmap_write_poll(NetmapState *s, bool enable)
+static void netmap_update_write_poll(NetmapState *s, bool enable)
 {
     if (s->write_poll != enable) {
         s->write_poll = enable;
@@ -141,6 +141,18 @@ static void netmap_poll(NetClientState *nc, bool enable)
     }
 }
 
+static void netmap_read_poll(NetClientState *nc, bool enable)
+{
+    NetmapState *s = DO_UPCAST(NetmapState, nc, nc);
+    netmap_update_read_poll(s, enable);
+}
+
+static void netmap_write_poll(NetClientState *nc, bool enable)
+{
+    NetmapState *s = DO_UPCAST(NetmapState, nc, nc);
+    netmap_update_write_poll(s, enable);
+}
+
 /*
  * The fd_write() callback, invoked if the fd is marked as
  * writable after a poll. Unregister the handler and flush any
@@ -150,7 +162,7 @@ static void netmap_writable(void *opaque)
 {
     NetmapState *s = opaque;
 
-    netmap_write_poll(s, false);
+    netmap_update_write_poll(s, false);
     qemu_flush_queued_packets(&s->nc);
 }
 
@@ -175,7 +187,7 @@ static ssize_t netmap_receive_iov(NetClientState *nc,
          * ones), but without publishing any new slots to be processed
          * (e.g., we don't advance ring->head). */
         ring->cur = tail;
-        netmap_write_poll(s, true);
+        netmap_update_write_poll(s, true);
         return 0;
     }
 
@@ -195,7 +207,7 @@ static ssize_t netmap_receive_iov(NetClientState *nc,
                 /* We ran out of netmap slots while splitting the
                    iovec fragments. */
                 ring->cur = tail;
-                netmap_write_poll(s, true);
+                netmap_update_write_poll(s, true);
                 return 0;
             }
 
@@ -242,7 +254,7 @@ static void netmap_send_completed(NetClientState *nc, ssize_t len)
 {
     NetmapState *s = DO_UPCAST(NetmapState, nc, nc);
 
-    netmap_read_poll(s, true);
+    netmap_update_read_poll(s, true);
 }
 
 static void netmap_send(void *opaque)
@@ -289,7 +301,7 @@ static void netmap_send(void *opaque)
         if (iovsize == 0) {
             /* The peer does not receive anymore. Packet is queued, stop
              * reading from the backend until netmap_send_completed(). */
-            netmap_read_poll(s, false);
+            netmap_update_read_poll(s, false);
             break;
         }
     }
@@ -384,6 +396,8 @@ static NetClientInfo net_netmap_info = {
     .receive = netmap_receive,
     .receive_iov = netmap_receive_iov,
     .poll = netmap_poll,
+    .read_poll = netmap_read_poll,
+    .write_poll = netmap_write_poll,
     .cleanup = netmap_cleanup,
     .has_ufo = netmap_has_vnet_hdr,
     .has_vnet_hdr = netmap_has_vnet_hdr,
@@ -418,7 +432,7 @@ int net_init_netmap(const Netdev *netdev,
     s->rx = NETMAP_RXRING(nmd->nifp, 0);
     s->vnet_hdr_len = 0;
     pstrcpy(s->ifname, sizeof(s->ifname), netmap_opts->ifname);
-    netmap_read_poll(s, true); /* Initially only poll for reads. */
+    netmap_update_read_poll(s, true); /* Initially only poll for reads. */
 
     return 0;
 }
diff --git a/net/tap.c b/net/tap.c
index abe3b2d036..c2e7e4d1d8 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -99,13 +99,13 @@ static void tap_update_fd_handler(TAPState *s)
                         s);
 }
 
-static void tap_read_poll(TAPState *s, bool enable)
+static void tap_update_read_poll(TAPState *s, bool enable)
 {
     s->read_poll = enable;
     tap_update_fd_handler(s);
 }
 
-static void tap_write_poll(TAPState *s, bool enable)
+static void tap_update_write_poll(TAPState *s, bool enable)
 {
     s->write_poll = enable;
     tap_update_fd_handler(s);
@@ -115,7 +115,7 @@ static void tap_writable(void *opaque)
 {
     TAPState *s = opaque;
 
-    tap_write_poll(s, false);
+    tap_update_write_poll(s, false);
 
     qemu_flush_queued_packets(&s->nc);
 }
@@ -127,7 +127,7 @@ static ssize_t tap_write_packet(TAPState *s, const struct iovec *iov, int iovcnt
     len = RETRY_ON_EINTR(writev(s->fd, iov, iovcnt));
 
     if (len == -1 && errno == EAGAIN) {
-        tap_write_poll(s, true);
+        tap_update_write_poll(s, true);
         return 0;
     }
 
@@ -174,7 +174,7 @@ ssize_t tap_read_packet(int tapfd, uint8_t *buf, int maxlen)
 static void tap_send_completed(NetClientState *nc, ssize_t len)
 {
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
-    tap_read_poll(s, true);
+    tap_update_read_poll(s, true);
 }
 
 static void tap_send(void *opaque)
@@ -212,7 +212,7 @@ static void tap_send(void *opaque)
 
         size = qemu_send_packet_async(&s->nc, buf, size, tap_send_completed);
         if (size == 0) {
-            tap_read_poll(s, false);
+            tap_update_read_poll(s, false);
             break;
         } else if (size < 0) {
             break;
@@ -334,8 +334,8 @@ static void tap_cleanup(NetClientState *nc)
     tap_exit_notify(&s->exit, NULL);
     qemu_remove_exit_notifier(&s->exit);
 
-    tap_read_poll(s, false);
-    tap_write_poll(s, false);
+    tap_update_read_poll(s, false);
+    tap_update_write_poll(s, false);
     close(s->fd);
     s->fd = -1;
 }
@@ -343,8 +343,20 @@ static void tap_cleanup(NetClientState *nc)
 static void tap_poll(NetClientState *nc, bool enable)
 {
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
-    tap_read_poll(s, enable);
-    tap_write_poll(s, enable);
+    tap_update_read_poll(s, enable);
+    tap_update_write_poll(s, enable);
+}
+
+static void tap_read_poll(NetClientState *nc, bool enable)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    tap_update_read_poll(s, enable);
+}
+
+static void tap_write_poll(NetClientState *nc, bool enable)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    tap_update_write_poll(s, enable);
 }
 
 static bool tap_set_steering_ebpf(NetClientState *nc, int prog_fd)
@@ -382,6 +394,8 @@ static NetClientInfo net_tap_info = {
     .receive = tap_receive,
     .receive_iov = tap_receive_iov,
     .poll = tap_poll,
+    .read_poll = tap_read_poll,
+    .write_poll = tap_write_poll,
     .cleanup = tap_cleanup,
     .has_ufo = tap_has_ufo,
     .has_uso = tap_has_uso,
@@ -425,7 +439,7 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
     if (vnet_hdr) {
         tap_fd_set_vnet_hdr_len(s->fd, s->host_vnet_hdr_len);
     }
-    tap_read_poll(s, true);
+    tap_update_read_poll(s, true);
     s->vhost_net = NULL;
 
     s->exit.notify = tap_exit_notify;
-- 
2.52.0


