Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B38EFED2D1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 07:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0aGQ-0004mV-6Y; Thu, 12 Mar 2026 03:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w0aGO-0004go-Bk
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 03:15:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w0aGM-00006W-Dh
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 03:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773299717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yE5EXIHdVZ99o8ilpweRUBgvHp9JQoVeZq5rHLllXU8=;
 b=I0ap4H82xyz6GgZIp/xg91urdAPYVI2/MVGE7oj/h4y/0X3IbniD/ZG1glP3QJYr7xwtQa
 2j0GJTJrHbIdRomQ8+FJCwjzC+N9/yQ6iREVneiaijYSJ6OM4Z7eik9ULgMtahvyfUTBlv
 oUfkf13twK6IBHsdVLOGopHxu4i50Gw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-0LdE4Yq_M2eHULldj3rA_Q-1; Thu,
 12 Mar 2026 03:15:13 -0400
X-MC-Unique: 0LdE4Yq_M2eHULldj3rA_Q-1
X-Mimecast-MFC-AGG-ID: 0LdE4Yq_M2eHULldj3rA_Q_1773299712
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A666180047F; Thu, 12 Mar 2026 07:15:12 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.170])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CFC4719540C2; Thu, 12 Mar 2026 07:15:08 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, jmarcin@redhat.com, qemu-devel@nongnu.org
Subject: [RFC v2 5/9] net/filter-redirector: route chardev and AF_PACKET
 receive paths
Date: Thu, 12 Mar 2026 15:09:33 +0800
Message-ID: <20260312071415.1836655-6-lulu@redhat.com>
In-Reply-To: <20260312071415.1836655-1-lulu@redhat.com>
References: <20260312071415.1836655-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Packets captured from AF_PACKET now either go to the chardev outdev or
into the filter chain, and both paths update the new netdev statistics.
Use the same routing from redirector_rs_finalize() so replay traffic and
normal receive handling share one dispatch policy.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 net/filter-mirror.c | 107 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 101 insertions(+), 6 deletions(-)

diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index e57fbc94b8..1ff58e1d27 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -305,6 +305,81 @@ static void redirector_chr_event(void *opaque, QEMUChrEvent event)
     }
 }
 
+static void filter_redirector_recv_from_chardev(NetFilterState *nf,
+                                                        const uint8_t *buf,
+                                                        int len)
+{
+    MirrorState *s = FILTER_REDIRECTOR(nf);
+    bool inject_netdev = filter_redirector_use_inject_netdev(nf);
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
+    if (inject_netdev) {
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
+
+    if (s->outdev) {
+        ret = filter_redirector_send_chardev_iov(s, &iov, 1);
+        if (ret > 0) {
+            s->outdev_packets++;
+            s->outdev_bytes += ret;
+        }
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
@@ -329,7 +404,9 @@ static void filter_redirector_netdev_read(void *opaque)
             continue;
         }
 
-        redirector_to_filter(nf, s->in_netbuf, len);
+        s->netdev_rx_packets++;
+        s->netdev_rx_bytes += len;
+        filter_redirector_recv_from_netdev(nf, s->in_netbuf, len);
     }
 
     if (len < 0 && errno != EAGAIN && errno != EWOULDBLOCK &&
@@ -369,21 +446,34 @@ static ssize_t filter_redirector_receive_iov(NetFilterState *nf,
                                              NetPacketSent *sent_cb)
 {
     MirrorState *s = FILTER_REDIRECTOR(nf);
+    bool capture_netdev = filter_redirector_use_capture_netdev(nf);
+    bool inject_netdev = filter_redirector_use_inject_netdev(nf);
     int ret;
 
-    if (qemu_chr_fe_backend_connected(&s->chr_out)) {
-        ret = filter_send(s, iov, iovcnt);
+    if (s->indev || inject_netdev) {
+        return 0;
+    }
+
+    if (capture_netdev || s->outdev) {
+        if (capture_netdev) {
+            return 0;
+        }
+
+        ret = filter_redirector_send_chardev_iov(s, iov, iovcnt);
         if (ret < 0) {
             error_report("filter redirector send failed(%s)", strerror(-ret));
         } else if (ret > 0) {
-            /* Update outdev statistics on successful send */
             s->outdev_packets++;
             s->outdev_bytes += ret;
         }
-        return iov_size(iov, iovcnt);
-    } else {
+        /*
+         * Without an active AF_PACKET capture socket, outdev mirroring is a
+         * sideband copy only and must not consume the guest-bound packet.
+         */
         return 0;
     }
+
+    return 0;
 }
 
 static void filter_mirror_cleanup(NetFilterState *nf)
@@ -444,6 +534,11 @@ static void redirector_rs_finalize(SocketReadState *rs)
     MirrorState *s = container_of(rs, MirrorState, rs);
     NetFilterState *nf = NETFILTER(s);
 
+    if (s->outdev || filter_redirector_use_inject_netdev(nf)) {
+        filter_redirector_recv_from_chardev(nf, rs->buf, rs->packet_len);
+        return;
+    }
+
     /* Update indev statistics */
     s->indev_packets++;
     s->indev_bytes += rs->packet_len;
-- 
2.52.0


