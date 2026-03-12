Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A1FFED2D1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 07:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0aGV-0004ta-OZ; Thu, 12 Mar 2026 03:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w0aGT-0004rp-KP
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 03:15:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w0aGR-00008H-PQ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 03:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773299720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b/Cx5BhQaOZNCa2vAX1kb6o68eYgtv5EzkoSngDiIJ4=;
 b=QBa7cqO3wmTzhwmWceHa9EuaugZEPt6+HvyQ/K3Y20GJzctuu9gxKWMW590rrcgWt+Zxku
 xM7P8XtlJ8WoV2Hc/R/q9DGSFs3yFrIPFxBWn4A3KhGzYNptiU8Hsh4+ES0NLN0Uu5rIsC
 WLZdSFrCeJiR1KsmQ8LeukUxUJRChk0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-GqIb6kmAOcezgR2ZeLsZgg-1; Thu,
 12 Mar 2026 03:15:17 -0400
X-MC-Unique: GqIb6kmAOcezgR2ZeLsZgg-1
X-Mimecast-MFC-AGG-ID: GqIb6kmAOcezgR2ZeLsZgg_1773299716
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75C43197768B; Thu, 12 Mar 2026 07:15:16 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.170])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0A29A19540C2; Thu, 12 Mar 2026 07:15:12 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, jmarcin@redhat.com, qemu-devel@nongnu.org
Subject: [RFC v2 6/9] net/filter: Add support for filter-buffer
Date: Thu, 12 Mar 2026 15:09:34 +0800
Message-ID: <20260312071415.1836655-7-lulu@redhat.com>
In-Reply-To: <20260312071415.1836655-1-lulu@redhat.com>
References: <20260312071415.1836655-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Allow filter-buffer on the same vhost backend as filter-redirector,
add an internal redirector-injected packet flag, and route indev packets
through the preceding filter-buffer before they are reinjected.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 include/net/queue.h |  5 +++
 net/filter-mirror.c | 98 +++++++++++++++++++++++++++++++++++++++++----
 net/filter.c        |  5 ++-
 3 files changed, 98 insertions(+), 10 deletions(-)

diff --git a/include/net/queue.h b/include/net/queue.h
index 2e686b1b61..213abe62ec 100644
--- a/include/net/queue.h
+++ b/include/net/queue.h
@@ -32,6 +32,11 @@ typedef void (NetPacketSent) (NetClientState *sender, ssize_t ret);
 
 #define QEMU_NET_PACKET_FLAG_NONE  0
 #define QEMU_NET_PACKET_FLAG_RAW  (1<<0)
+/*
+ * Internal marker used by filter-redirector when packets are injected from
+ * indev through filter-buffer before being reinjected.
+ */
+#define QEMU_NET_PACKET_FLAG_REDIRECTOR_INJECT (1<<1)
 
 /* Returns:
  *   >0 - success
diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 1ff58e1d27..dabf52275a 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -233,6 +233,73 @@ static ssize_t filter_redirector_send_netdev_iov(MirrorState *s,
     return filter_redirector_send_netdev_packet(s, iov, iovcnt);
 }
 
+static NetFilterState *filter_redirector_prev_in_direction(NetFilterState *nf,
+                                                           NetFilterDirection dir)
+{
+    if (dir == NET_FILTER_DIRECTION_TX) {
+        return QTAILQ_PREV(nf, next);
+    }
+    return QTAILQ_NEXT(nf, next);
+}
+
+static NetFilterState *filter_redirector_find_buffer_before(NetFilterState *nf,
+                                                            NetFilterDirection dir)
+{
+    NetFilterState *iter = filter_redirector_prev_in_direction(nf, dir);
+
+    while (iter) {
+        if ((iter->direction == dir ||
+             iter->direction == NET_FILTER_DIRECTION_ALL) &&
+            object_dynamic_cast(OBJECT(iter), "filter-buffer")) {
+            return iter;
+        }
+        iter = filter_redirector_prev_in_direction(iter, dir);
+    }
+
+    return NULL;
+}
+
+static bool filter_redirector_inject_to_buffer(NetFilterState *nf,
+                                               const uint8_t *buf,
+                                               int len)
+{
+    struct iovec iov = {
+        .iov_base = (void *)buf,
+        .iov_len = len,
+    };
+    NetFilterState *buffer;
+    bool injected = false;
+
+    if (nf->direction == NET_FILTER_DIRECTION_ALL ||
+        nf->direction == NET_FILTER_DIRECTION_TX) {
+        buffer = filter_redirector_find_buffer_before(nf,
+                                                      NET_FILTER_DIRECTION_TX);
+        if (buffer) {
+            qemu_netfilter_receive(buffer, NET_FILTER_DIRECTION_TX,
+                                   nf->netdev,
+                                   QEMU_NET_PACKET_FLAG_REDIRECTOR_INJECT,
+                                   &iov, 1, NULL);
+            injected = true;
+        }
+    }
+
+    if ((nf->direction == NET_FILTER_DIRECTION_ALL ||
+         nf->direction == NET_FILTER_DIRECTION_RX) &&
+        nf->netdev->peer) {
+        buffer = filter_redirector_find_buffer_before(nf,
+                                                      NET_FILTER_DIRECTION_RX);
+        if (buffer) {
+            qemu_netfilter_receive(buffer, NET_FILTER_DIRECTION_RX,
+                                   nf->netdev->peer,
+                                   QEMU_NET_PACKET_FLAG_REDIRECTOR_INJECT,
+                                   &iov, 1, NULL);
+            injected = true;
+        }
+    }
+
+    return injected;
+}
+
 static void redirector_to_filter(NetFilterState *nf,
                                  const uint8_t *buf,
                                  int len)
@@ -310,7 +377,6 @@ static void filter_redirector_recv_from_chardev(NetFilterState *nf,
                                                         int len)
 {
     MirrorState *s = FILTER_REDIRECTOR(nf);
-    bool inject_netdev = filter_redirector_use_inject_netdev(nf);
     ssize_t ret;
     struct iovec iov = {
         .iov_base = (void *)buf,
@@ -325,7 +391,11 @@ static void filter_redirector_recv_from_chardev(NetFilterState *nf,
     s->indev_packets++;
     s->indev_bytes += len;
 
-    if (inject_netdev) {
+    if (!s->outdev && filter_redirector_inject_to_buffer(nf, buf, len)) {
+        return;
+    }
+
+    if (s->out_netfd >= 0) {
         ret = filter_redirector_send_netdev_iov(s, &iov, 1);
         if (ret < 0) {
             error_report("filter redirector send failed(%s)", strerror(-ret));
@@ -446,16 +516,22 @@ static ssize_t filter_redirector_receive_iov(NetFilterState *nf,
                                              NetPacketSent *sent_cb)
 {
     MirrorState *s = FILTER_REDIRECTOR(nf);
-    bool capture_netdev = filter_redirector_use_capture_netdev(nf);
-    bool inject_netdev = filter_redirector_use_inject_netdev(nf);
     int ret;
 
-    if (s->indev || inject_netdev) {
-        return 0;
+    if (s->out_netfd >= 0) {
+        if (!(flags & QEMU_NET_PACKET_FLAG_REDIRECTOR_INJECT)) {
+            return 0;
+        }
+
+        ret = filter_redirector_send_netdev_iov(s, iov, iovcnt);
+        if (ret < 0) {
+            error_report("filter redirector send failed(%s)", strerror(-ret));
+        }
+        return iov_size(iov, iovcnt);
     }
 
-    if (capture_netdev || s->outdev) {
-        if (capture_netdev) {
+    if (s->outdev) {
+        if (s->in_netfd >= 0) {
             return 0;
         }
 
@@ -473,6 +549,12 @@ static ssize_t filter_redirector_receive_iov(NetFilterState *nf,
         return 0;
     }
 
+    if (s->indev) {
+        if (!(flags & QEMU_NET_PACKET_FLAG_REDIRECTOR_INJECT)) {
+            return 0;
+        }
+    }
+
     return 0;
 }
 
diff --git a/net/filter.c b/net/filter.c
index b9646b9e00..cc23e743cf 100644
--- a/net/filter.c
+++ b/net/filter.c
@@ -260,8 +260,9 @@ static void netfilter_complete(UserCreatable *uc, Error **errp)
         bool buffer = object_dynamic_cast(OBJECT(uc), "filter-buffer");
         bool vhost_filter = redirector || buffer;
 
-        if (!redirector) {
-            error_setg(errp, "Vhost is not supported");
+        if (!vhost_filter) {
+            error_setg(errp, "Vhost only supports filter-redirector and "
+                             "filter-buffer");
             return;
         }
         if (vhost_filter && ncs[0]->info->type != NET_CLIENT_DRIVER_TAP) {
-- 
2.52.0


