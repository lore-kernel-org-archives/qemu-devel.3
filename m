Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E086EF48DB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 07:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqnL2-0002k7-0T; Fri, 13 Feb 2026 02:11:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1vqnKy-0002jb-2G
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 02:11:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1vqnKv-0005eC-PB
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 02:11:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770966693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HfmaBTP49ifwDZty9C9MLcDDDX6UwWiMdcZezZPYKs0=;
 b=BCgWYEQKnImQpGsDAP94XN9e62koCQUo53WXDXqE0mtN5BLV99bQmkGaerXgIvSqYKzJIG
 Ii9tV5SOIhWjIJ4HA7nshg2d5sLeoHv7aIjtDXorV+pySp6bzxe6GAtBiwzebopQyyWWjw
 VgSjJ5zAvt/wP9jbU3ZlX9KgBhGCw7E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-3GPXCd5hOvuvtV6Qi5_0cA-1; Fri,
 13 Feb 2026 02:11:29 -0500
X-MC-Unique: 3GPXCd5hOvuvtV6Qi5_0cA-1
X-Mimecast-MFC-AGG-ID: 3GPXCd5hOvuvtV6Qi5_0cA_1770966688
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 343651955D8F; Fri, 13 Feb 2026 07:11:28 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.33])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E09801800464; Fri, 13 Feb 2026 07:11:24 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, qemu-devel@nongnu.org
Subject: [RFC 4/5] net/filter-redirector: add AF_PACKET redirect datapath
Date: Fri, 13 Feb 2026 15:08:04 +0800
Message-ID: <20260213071042.3733239-5-lulu@redhat.com>
In-Reply-To: <20260213071042.3733239-1-lulu@redhat.com>
References: <20260213071042.3733239-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Complete the AF_PACKET based packet forwarding implementation for
filter-redirector:

1. filter_redirector_send_netdev_packet(): Send packets via AF_PACKET
   socket to out_netdev. Updates netdev_tx statistics.

2. filter_redirector_recv_from_chardev(): Handle packets received from
   chardev indev. Can forward to either chardev outdev, AF_PACKET
   out_netdev, or inject into the netfilter chain.

3. filter_redirector_recv_from_netdev(): Handle packets received from
   AF_PACKET in_netdev. Can forward to chardev outdev or inject into
   the netfilter chain.

4. Updated filter_redirector_receive_iov() to support out_netdev as
   an output endpoint. Added logic to skip netdev path consumption
   when redirector has an input endpoint (indev/in_netdev) to prevent
   packet loops.

5. Added netdev_rx and netdev_tx counters to query-netfilter-stats
   output for monitoring AF_PACKET datapath activity.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 net/filter-mirror.c | 177 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 171 insertions(+), 6 deletions(-)

diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index f8001612ec..d9e8fcba59 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -65,6 +65,11 @@ struct MirrorState {
     uint64_t indev_bytes;
     uint64_t outdev_packets;
     uint64_t outdev_bytes;
+    /* netdev replay/capture statistics for filter-redirector */
+    uint64_t netdev_rx_packets;
+    uint64_t netdev_rx_bytes;
+    uint64_t netdev_tx_packets;
+    uint64_t netdev_tx_bytes;
 };
 
 typedef struct FilterSendCo {
@@ -158,6 +163,59 @@ static int filter_send(MirrorState *s,
     return data.ret;
 }
 
+static ssize_t filter_redirector_send_netdev_packet(MirrorState *s,
+                                                    const struct iovec *iov,
+                                                    int iovcnt)
+{
+    ssize_t size = iov_size(iov, iovcnt);
+    g_autofree uint8_t *buf = NULL;
+
+    if (s->out_netfd < 0) {
+        return -ENODEV;
+    }
+    if (size > NET_BUFSIZE) {
+        return -EINVAL;
+    }
+
+    buf = g_malloc(size);
+    iov_to_buf(iov, iovcnt, 0, buf, size);
+
+    ssize_t ret = send(s->out_netfd, buf, size, 0);
+    if (ret < 0) {
+        return -errno;
+    }
+    if (ret > 0) {
+        s->netdev_tx_packets++;
+        s->netdev_tx_bytes += ret;
+    }
+    return ret;
+}
+static ssize_t filter_redirector_send_chardev_iov(MirrorState *s,
+                                                  const struct iovec *iov,
+                                                  int iovcnt)
+{
+    if (!s->outdev) {
+        return -ENODEV;
+    }
+
+    if (!qemu_chr_fe_backend_connected(&s->chr_out)) {
+        return 0;
+    }
+
+    return filter_send(s, iov, iovcnt);
+}
+
+static ssize_t filter_redirector_send_netdev_iov(MirrorState *s,
+                                                 const struct iovec *iov,
+                                                 int iovcnt)
+{
+    if (!s->out_netdev) {
+        return -ENODEV;
+    }
+
+    return filter_redirector_send_netdev_packet(s, iov, iovcnt);
+}
+
 static void redirector_to_filter(NetFilterState *nf,
                                  const uint8_t *buf,
                                  int len)
@@ -230,6 +288,75 @@ static void redirector_chr_event(void *opaque, QEMUChrEvent event)
     }
 }
 
+static void filter_redirector_recv_from_chardev(NetFilterState *nf,
+                                                        const uint8_t *buf,
+                                                        int len)
+{
+    MirrorState *s = FILTER_REDIRECTOR(nf);
+    ssize_t ret;
+    struct iovec iov = {
+        .iov_base = (void *)buf,
+        .iov_len = len,
+    };
+
+    if (len <= 0) {
+        return;
+    }
+
+    /* chardev indev */
+    s->indev_packets++;
+    s->indev_bytes += len;
+
+    if (s->out_netdev) {
+        ret = filter_redirector_send_netdev_iov(s, &iov, 1);
+        if (ret < 0) {
+            error_report("filter redirector send failed(%s)", strerror(-ret));
+        }
+        return;
+    }
+
+    if (s->outdev) {
+        ret = filter_redirector_send_chardev_iov(s, &iov, 1);
+        if (ret < 0) {
+            error_report("filter redirector send failed(%s)", strerror(-ret));
+        } else if (ret > 0) {
+            s->outdev_packets++;
+            s->outdev_bytes += ret;
+        }
+        return;
+    }
+
+    redirector_to_filter(nf, buf, len);
+}
+
+static bool filter_redirector_recv_from_netdev(NetFilterState *nf,
+                                                          const uint8_t *buf,
+                                                          int len)
+{
+    MirrorState *s = FILTER_REDIRECTOR(nf);
+    ssize_t ret;
+    struct iovec iov = {
+        .iov_base = (void *)buf,
+        .iov_len = len,
+    };
+
+    if (len <= 0) {
+        return false;
+    }
+    if (s->outdev) {
+        ret = filter_redirector_send_chardev_iov(s, &iov, 1);
+    } else {
+        redirector_to_filter(nf, buf, len);
+        return true;
+    }
+
+    if (ret < 0) {
+        error_report("filter redirector send failed(%s)", strerror(-ret));
+        return false;
+    }
+    return true;
+}
+
 static void filter_redirector_netdev_read(void *opaque)
 {
     NetFilterState *nf = opaque;
@@ -254,7 +381,9 @@ static void filter_redirector_netdev_read(void *opaque)
             continue;
         }
 
-        redirector_to_filter(nf, s->in_netbuf, len);
+        s->netdev_rx_packets++;
+        s->netdev_rx_bytes += len;
+        filter_redirector_recv_from_netdev(nf, s->in_netbuf, len);
     }
 
     if (len < 0 && errno != EAGAIN && errno != EWOULDBLOCK &&
@@ -296,19 +425,33 @@ static ssize_t filter_redirector_receive_iov(NetFilterState *nf,
     MirrorState *s = FILTER_REDIRECTOR(nf);
     int ret;
 
-    if (qemu_chr_fe_backend_connected(&s->chr_out)) {
-        ret = filter_send(s, iov, iovcnt);
+    /*
+     * If this redirector has an explicit input endpoint (indev/in_netdev),
+     * it acts as an injector for that endpoint and must not consume packets
+     * from the regular netdev data path. Consuming here can create loops when
+     * out_netdev points back to the same TAP netdev.
+     */
+    if (s->indev || s->in_netdev) {
+        return 0;
+    }
+
+    if (s->out_netdev || s->outdev) {
+        if (s->out_netdev) {
+            ret = filter_redirector_send_netdev_iov(s, iov, iovcnt);
+        } else {
+            ret = filter_redirector_send_chardev_iov(s, iov, iovcnt);
+        }
         if (ret < 0) {
             error_report("filter redirector send failed(%s)", strerror(-ret));
-        } else if (ret > 0) {
+        } else if (ret > 0 && !s->out_netdev) {
             /* Update outdev statistics on successful send */
             s->outdev_packets++;
             s->outdev_bytes += ret;
         }
         return iov_size(iov, iovcnt);
-    } else {
-        return 0;
     }
+
+    return 0;
 }
 
 static void filter_mirror_cleanup(NetFilterState *nf)
@@ -369,6 +512,16 @@ static void redirector_rs_finalize(SocketReadState *rs)
     MirrorState *s = container_of(rs, MirrorState, rs);
     NetFilterState *nf = NETFILTER(s);
 
+    /*
+     * If redirector has an explicit output endpoint, keep the redirect path
+     * (e.g. indev=red0 -> out_netdev=net0).
+     * Fallback to direct netfilter injection only when no output is set.
+     */
+    if (s->outdev || s->out_netdev) {
+        filter_redirector_recv_from_chardev(nf, rs->buf, rs->packet_len);
+        return;
+    }
+
     /* Update indev statistics */
     s->indev_packets++;
     s->indev_bytes += rs->packet_len;
@@ -826,6 +979,18 @@ static GList *filter_redirector_get_stats(NetFilterState *nf)
     counter->bytes = s->outdev_bytes;
     list = g_list_append(list, counter);
 
+    counter = g_new0(NetFilterCounter, 1);
+    counter->name = g_strdup("netdev_rx");
+    counter->packets = s->netdev_rx_packets;
+    counter->bytes = s->netdev_rx_bytes;
+    list = g_list_append(list, counter);
+
+    counter = g_new0(NetFilterCounter, 1);
+    counter->name = g_strdup("netdev_tx");
+    counter->packets = s->netdev_tx_packets;
+    counter->bytes = s->netdev_tx_bytes;
+    list = g_list_append(list, counter);
+
     return list;
 }
 
-- 
2.52.0


