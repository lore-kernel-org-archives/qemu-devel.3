Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306A9FB3CE4
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w78eO-0006T2-A4; Mon, 30 Mar 2026 05:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w78dv-00069M-KY
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 05:10:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w78dt-0000Q8-0i
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 05:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774861840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b3CqbJi2MH8xVeq0Ual/M4Y93TyxFUpwdAas+AN4prc=;
 b=DKM4I1zy769AwH66BvsfmfgUS81ovGV0coxaXvskN4xCiWIq9k7avl9MZWwjYv+UoCoerR
 bHSIKJj01UG2W14KubgTbDC4fEcf8KW7op7WnO38zmU332eNEs/KS5xfrN2R98za10seVR
 WNAbapwj3V3rXLEhX5dkJgiJe8T/9BI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-OtkyH6U5P6-sJYQu2gy6JQ-1; Mon,
 30 Mar 2026 05:10:36 -0400
X-MC-Unique: OtkyH6U5P6-sJYQu2gy6JQ-1
X-Mimecast-MFC-AGG-ID: OtkyH6U5P6-sJYQu2gy6JQ_1774861835
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D97A1944EB3; Mon, 30 Mar 2026 09:10:35 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.39])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6720B19560AB; Mon, 30 Mar 2026 09:10:32 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, jmarcin@redhat.com, qemu-devel@nongnu.org
Subject: [RFC v3 5/7] net/filter-redirector: add AF_PACKET inject path
Date: Mon, 30 Mar 2026 16:58:13 +0800
Message-ID: <20260330090944.1008027-6-lulu@redhat.com>
In-Reply-To: <20260330090944.1008027-1-lulu@redhat.com>
References: <20260330090944.1008027-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

Allow redirector packets to be injected back into a vhost-backed TAP
backend without going through the normal peer queue.

Export a redirector helper that sends an iov directly through the
redirector's AF_PACKET inject socket, and teach qemu_netfilter_pass_to_next()
to use it when the sender is backed by vhost. This lets the redirector
reinject traffic into the TAP device even when the regular userspace path
is bypassed by vhost.

The redirector chardev transport may carry an empty vnet header wrapper
before the Ethernet frame. Detect the longest supported all-zero wrapper
and strip it before sendmsg() so the AF_PACKET inject side always writes a
raw L2 frame back to TAP.

Propagate sendmsg() failures through ssize_t so the caller can report
partial/failed injection cleanly.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 include/net/filter.h |  6 +++
 net/filter-mirror.c  | 94 ++++++++++++++++++++++++++++++++++++++++++++
 net/filter.c         | 11 +++++-
 3 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/include/net/filter.h b/include/net/filter.h
index f0673c9163..68076a66ad 100644
--- a/include/net/filter.h
+++ b/include/net/filter.h
@@ -91,6 +91,12 @@ ssize_t qemu_netfilter_pass_to_next(NetClientState *sender,
                                     int iovcnt,
                                     void *opaque);
 
+bool qemu_netfilter_redirector_inject_netdev(NetFilterState *nf,
+                                             NetClientState *sender,
+                                             const struct iovec *iov,
+                                             int iovcnt,
+                                             ssize_t *retp);
+
 void colo_notify_filters_event(int event, Error **errp);
 
 #endif /* QEMU_NET_FILTER_H */
diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index e114ddb7d1..165a7ee1ea 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -74,6 +74,100 @@ typedef struct FilterSendCo {
     int ret;
 } FilterSendCo;
 
+static size_t filter_redirector_wrapped_vnet_hdr_len(const struct iovec *iov,
+                                                     int iovcnt)
+{
+    static const size_t lens[] = {
+        sizeof(struct virtio_net_hdr_v1_hash_tunnel),
+        sizeof(struct virtio_net_hdr_v1_hash),
+        sizeof(struct virtio_net_hdr_mrg_rxbuf),
+        sizeof(struct virtio_net_hdr),
+    };
+    uint8_t hdr[sizeof(struct virtio_net_hdr_v1_hash_tunnel)] = { 0 };
+    uint8_t zero[sizeof(hdr)] = { 0 };
+    size_t total = iov_size(iov, iovcnt);
+    size_t len;
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(lens); i++) {
+        len = lens[i];
+        if (len >= total) {
+            continue;
+        }
+        if (iov_to_buf(iov, iovcnt, 0, hdr, len) == len &&
+            !memcmp(hdr, zero, len)) {
+            return len;
+        }
+    }
+
+    return 0;
+}
+
+
+bool qemu_netfilter_redirector_inject_netdev(NetFilterState *nf,
+                                             NetClientState *sender,
+                                             const struct iovec *iov,
+                                             int iovcnt,
+                                             ssize_t *retp)
+{
+    MirrorState *s;
+    struct iovec local_iov = { 0 };
+    struct msghdr msg = {
+        .msg_iov = (struct iovec *)iov,
+        .msg_iovlen = iovcnt,
+    };
+    ssize_t ret;
+    size_t size;
+    size_t wrapped_vnet_hdr_len;
+
+    if (!object_dynamic_cast(OBJECT(nf), TYPE_FILTER_REDIRECTOR)) {
+        return false;
+    }
+
+    s = FILTER_REDIRECTOR(nf);
+    if (s->out_netfd < 0 || !sender || sender != nf->netdev) {
+        return false;
+    }
+
+    wrapped_vnet_hdr_len = (!s->vnet_hdr && qemu_get_vnet_hdr_len(sender)) ?
+                           filter_redirector_wrapped_vnet_hdr_len(iov, iovcnt) :
+                           0;
+    if (wrapped_vnet_hdr_len) {
+        /*
+         * Redirector chardev packets can carry an empty virtio-net header
+         * before the Ethernet frame. Strip the longest supported wrapped
+         * header before injecting the packet back to TAP.
+         */
+        local_iov.iov_len = iov_size(iov, iovcnt) - wrapped_vnet_hdr_len;
+        local_iov.iov_base = g_malloc(local_iov.iov_len);
+        iov_to_buf(iov, iovcnt, wrapped_vnet_hdr_len,
+                   local_iov.iov_base,
+                   local_iov.iov_len);
+        msg.msg_iov = &local_iov;
+        msg.msg_iovlen = 1;
+    }
+
+    size = iov_size(iov, iovcnt);
+    if (local_iov.iov_base) {
+        size = local_iov.iov_len;
+    }
+    do {
+        ret = sendmsg(s->out_netfd, &msg, 0);
+    } while (ret < 0 && errno == EINTR);
+
+    if (ret < 0) {
+        *retp = -errno;
+    } else if (ret != size) {
+        *retp = -EIO;
+    } else {
+        *retp = ret;
+    }
+
+    g_free(local_iov.iov_base);
+
+    return true;
+}
+
 static int _filter_send(MirrorState *s,
                        char *buf,
                        ssize_t size)
diff --git a/net/filter.c b/net/filter.c
index 76345c1a9d..847dd34698 100644
--- a/net/filter.c
+++ b/net/filter.c
@@ -81,7 +81,7 @@ ssize_t qemu_netfilter_pass_to_next(NetClientState *sender,
                                     int iovcnt,
                                     void *opaque)
 {
-    int ret = 0;
+    ssize_t ret = 0;
     int direction;
     NetFilterState *nf = opaque;
     NetFilterState *next = NULL;
@@ -124,6 +124,15 @@ ssize_t qemu_netfilter_pass_to_next(NetClientState *sender,
      * deleted while we go through filters.
      */
     if (sender && sender->peer) {
+        if (get_vhost_net(sender) &&
+            qemu_netfilter_redirector_inject_netdev(nf, sender,
+                                                    iov, iovcnt, &ret)) {
+            if (ret < 0) {
+                error_report("filter redirector AF_PACKET send failed(%s)",
+                             strerror(-ret));
+            }
+            goto out;
+        }
         qemu_net_queue_send_iov(sender->peer->incoming_queue,
                                 sender, flags, iov, iovcnt, NULL);
     }
-- 
2.52.0


