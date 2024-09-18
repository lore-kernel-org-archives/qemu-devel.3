Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9D7CDD556
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 20:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr1fh-0004oC-48; Wed, 18 Sep 2024 16:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sr1fd-0004e5-TG
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 16:53:05 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sr1fb-0008I2-U8
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 16:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=l66vfY6FwdV4zag7Q0tLWaWPKalJm5Zmp5Gxv7K/RIA=; b=UddxxjN48ezbBni4
 ow1x7PIFTuPzt3Dqz3k6CSsgTRnRyzlcgKB6hYQpTjcFXHQZl/UkKKjFl+QbP9PzEFketX8JXDKTF
 q3+xV/4ocuUBFYJSYp0J/GnTT882TUxfJg9xC0KjBOMOYQtCXf0lABfmBnB3jRs0ow85d1zKUaqs1
 L3cAVcYzH1RqD1awdIElRFqrzejBabCn/LolLajIWQZA3wkY6J84zmWRycmJ8W+27WI1N+C1F6ecX
 ermyvPmv45GMyp79dsm2JrXLUsDp0D1d48oZNp4rADs20XeCU1f8izKaA9AYZQ0k5lAYw3zVzm6B+
 oUJjNGOl/ytmOdJ8RQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1sr1fX-006L8s-0m;
 Wed, 18 Sep 2024 20:52:59 +0000
From: dave@treblig.org
To: jasowang@redhat.com,
	qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH] net: Remove deadcode
Date: Wed, 18 Sep 2024 21:52:58 +0100
Message-ID: <20240918205258.444880-1-dave@treblig.org>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

net_hub_port_find is unused since 2018's commit
  af1a5c3eb4 ("net: Remove the deprecated "vlan" parameter")

qemu_receive_packet_iov is unused since commit
  ffbd2dbd8e ("e1000e: Perform software segmentation for loopback")

in turn it was the last user of qemu_net_queue_receive_iov.

Remove them.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 include/net/net.h   |  4 ----
 include/net/queue.h |  4 ----
 net/hub.c           | 25 -------------------------
 net/net.c           | 10 ----------
 net/queue.c         | 11 -----------
 5 files changed, 54 deletions(-)

diff --git a/include/net/net.h b/include/net/net.h
index c8f679761b..cdd5b109b0 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -172,9 +172,6 @@ ssize_t qemu_sendv_packet_async(NetClientState *nc, const struct iovec *iov,
                                 int iovcnt, NetPacketSent *sent_cb);
 ssize_t qemu_send_packet(NetClientState *nc, const uint8_t *buf, int size);
 ssize_t qemu_receive_packet(NetClientState *nc, const uint8_t *buf, int size);
-ssize_t qemu_receive_packet_iov(NetClientState *nc,
-                                const struct iovec *iov,
-                                int iovcnt);
 ssize_t qemu_send_packet_raw(NetClientState *nc, const uint8_t *buf, int size);
 ssize_t qemu_send_packet_async(NetClientState *nc, const uint8_t *buf,
                                int size, NetPacketSent *sent_cb);
@@ -307,7 +304,6 @@ void hmp_host_net_remove(Monitor *mon, const QDict *qdict);
 void netdev_add(QemuOpts *opts, Error **errp);
 
 int net_hub_id_for_client(NetClientState *nc, int *id);
-NetClientState *net_hub_port_find(int hub_id);
 
 #define DEFAULT_NETWORK_SCRIPT CONFIG_SYSCONFDIR "/qemu-ifup"
 #define DEFAULT_NETWORK_DOWN_SCRIPT CONFIG_SYSCONFDIR "/qemu-ifdown"
diff --git a/include/net/queue.h b/include/net/queue.h
index 9f2f289d77..2e686b1b61 100644
--- a/include/net/queue.h
+++ b/include/net/queue.h
@@ -59,10 +59,6 @@ ssize_t qemu_net_queue_receive(NetQueue *queue,
                                const uint8_t *data,
                                size_t size);
 
-ssize_t qemu_net_queue_receive_iov(NetQueue *queue,
-                                   const struct iovec *iov,
-                                   int iovcnt);
-
 ssize_t qemu_net_queue_send(NetQueue *queue,
                             NetClientState *sender,
                             unsigned flags,
diff --git a/net/hub.c b/net/hub.c
index 4c8a469a50..496a3d3b4b 100644
--- a/net/hub.c
+++ b/net/hub.c
@@ -193,31 +193,6 @@ NetClientState *net_hub_add_port(int hub_id, const char *name,
     return &port->nc;
 }
 
-/**
- * Find a available port on a hub; otherwise create one new port
- */
-NetClientState *net_hub_port_find(int hub_id)
-{
-    NetHub *hub;
-    NetHubPort *port;
-    NetClientState *nc;
-
-    QLIST_FOREACH(hub, &hubs, next) {
-        if (hub->id == hub_id) {
-            QLIST_FOREACH(port, &hub->ports, next) {
-                nc = port->nc.peer;
-                if (!nc) {
-                    return &(port->nc);
-                }
-            }
-            break;
-        }
-    }
-
-    nc = net_hub_add_port(hub_id, NULL, NULL);
-    return nc;
-}
-
 /**
  * Print hub configuration
  */
diff --git a/net/net.c b/net/net.c
index fc1125111c..d9b23a8f8c 100644
--- a/net/net.c
+++ b/net/net.c
@@ -750,16 +750,6 @@ ssize_t qemu_receive_packet(NetClientState *nc, const uint8_t *buf, int size)
     return qemu_net_queue_receive(nc->incoming_queue, buf, size);
 }
 
-ssize_t qemu_receive_packet_iov(NetClientState *nc, const struct iovec *iov,
-                                int iovcnt)
-{
-    if (!qemu_can_receive_packet(nc)) {
-        return 0;
-    }
-
-    return qemu_net_queue_receive_iov(nc->incoming_queue, iov, iovcnt);
-}
-
 ssize_t qemu_send_packet_raw(NetClientState *nc, const uint8_t *buf, int size)
 {
     return qemu_send_packet_async_with_flags(nc, QEMU_NET_PACKET_FLAG_RAW,
diff --git a/net/queue.c b/net/queue.c
index c872d51df8..fb33856c18 100644
--- a/net/queue.c
+++ b/net/queue.c
@@ -193,17 +193,6 @@ ssize_t qemu_net_queue_receive(NetQueue *queue,
     return qemu_net_queue_deliver(queue, NULL, 0, data, size);
 }
 
-ssize_t qemu_net_queue_receive_iov(NetQueue *queue,
-                                   const struct iovec *iov,
-                                   int iovcnt)
-{
-    if (queue->delivering) {
-        return 0;
-    }
-
-    return qemu_net_queue_deliver_iov(queue, NULL, 0, iov, iovcnt);
-}
-
 ssize_t qemu_net_queue_send(NetQueue *queue,
                             NetClientState *sender,
                             unsigned flags,
-- 
2.46.0


