Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E37FB3CE4
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w78eF-0006FO-So; Mon, 30 Mar 2026 05:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w78dr-00067Y-5d
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 05:10:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w78dp-0000Pa-4W
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 05:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774861834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JCiM3aSs/f1RsAuqeti67op//+DqhHvZTedMuAAYf4w=;
 b=Sw17PCiD+uReuAiseG5SattOGpTvGVcfp9p+swltT+RTg4QuZPKqBjb47kh/5EN7P3vMdV
 FWV2/6gIUrQEuEcU7gOSRLl6egC1ssMLTt+BruIbkaTYLGGg6nO8j7RQE22Q0IJcXkQoJo
 7nGy4EBng8PVVCoJOOJQaTSHbDvuwTU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-yRAAiayANlWoY3rpqRISPA-1; Mon,
 30 Mar 2026 05:10:32 -0400
X-MC-Unique: yRAAiayANlWoY3rpqRISPA-1
X-Mimecast-MFC-AGG-ID: yRAAiayANlWoY3rpqRISPA_1774861831
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B4E7719560A1; Mon, 30 Mar 2026 09:10:31 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.39])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 422DD19560AB; Mon, 30 Mar 2026 09:10:27 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, jmarcin@redhat.com, qemu-devel@nongnu.org
Subject: [RFC v3 4/7] net/filter-redirector: add AF_PACKET capture path
Date: Mon, 30 Mar 2026 16:58:12 +0800
Message-ID: <20260330090944.1008027-5-lulu@redhat.com>
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

Wire the capture-side AF_PACKET socket into filter-redirector.

When the redirector owns an AF_PACKET capture socket, install a read
handler that drains PACKET_OUTGOING frames from the TAP device and forwards
them into the existing redirector chardev path. Reuse the normal chardev
packet framing so downstream code sees the same transport format as it
already handles today, and keep redirector statistics updated through the
same helper.

AF_PACKET delivers a raw Ethernet frame while the redirector chardev path
can carry packets with an empty vnet header wrapper. When the backend has a
vnet header length, prepend an empty legacy virtio-net header before the
frame so the captured packet can move through the same chardev transport as
regular redirector traffic.

Hook the fd handler up during setup, status changes and VM state changes so
capture is only active when the redirector is enabled and allowed to run in
the current VM state.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 net/filter-mirror.c | 121 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index d9f6a11d6b..e114ddb7d1 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -43,6 +43,7 @@ DECLARE_INSTANCE_CHECKER(MirrorState, FILTER_REDIRECTOR,
                          TYPE_FILTER_REDIRECTOR)
 
 #define REDIRECTOR_MAX_LEN NET_BUFSIZE
+#define REDIRECTOR_AF_PACKET_WRAP_LEN sizeof(struct virtio_net_hdr)
 
 struct MirrorState {
     NetFilterState parent_obj;
@@ -181,6 +182,17 @@ static int redirector_chr_can_read(void *opaque)
     return REDIRECTOR_MAX_LEN;
 }
 
+static bool filter_redirector_input_active(NetFilterState *nf, bool enable)
+{
+    MirrorState *s = FILTER_REDIRECTOR(nf);
+
+    if (!enable) {
+        return false;
+    }
+
+    return runstate_is_running() || s->enable_when_stopped;
+}
+
 static void redirector_chr_read(void *opaque, const uint8_t *buf, int size)
 {
     NetFilterState *nf = opaque;
@@ -217,6 +229,91 @@ static void redirector_chr_event(void *opaque, QEMUChrEvent event)
     }
 }
 
+static int filter_redirector_send_chardev_iov(MirrorState *s,
+                                              const struct iovec *iov,
+                                              int iovcnt)
+{
+    int ret;
+
+    if (!qemu_chr_fe_backend_connected(&s->chr_out)) {
+        return 0;
+    }
+
+    ret = filter_send(s, iov, iovcnt);
+    if (ret > 0) {
+        s->outdev_packets++;
+        s->outdev_bytes += ret;
+    }
+
+    return ret;
+}
+
+static void filter_redirector_capture_netdev_read(void *opaque)
+{
+    NetFilterState *nf = opaque;
+    MirrorState *s = FILTER_REDIRECTOR(nf);
+    char vnet_hdr[REDIRECTOR_AF_PACKET_WRAP_LEN] = { 0 };
+    struct iovec iov[2];
+    struct sockaddr_ll sll;
+    socklen_t sll_len;
+    ssize_t len;
+    size_t wrap_vnet_hdr_len;
+    int iovcnt;
+    int ret;
+
+    if (!s->in_netbuf || s->in_netfd < 0) {
+        return;
+    }
+
+    for (;;) {
+        sll_len = sizeof(sll);
+        len = recvfrom(s->in_netfd, s->in_netbuf, REDIRECTOR_MAX_LEN, 0,
+                       (struct sockaddr *)&sll, &sll_len);
+        if (len <= 0) {
+            break;
+        }
+
+        if (sll.sll_pkttype != PACKET_OUTGOING) {
+            continue;
+        }
+
+        /*
+         * AF_PACKET gives us a raw Ethernet frame. Wrap it as a regular
+         * redirector payload by prepending an empty legacy virtio-net header,
+         * so the downstream chardev path can treat it like a normal packet.
+         */
+        wrap_vnet_hdr_len = qemu_get_vnet_hdr_len(nf->netdev) ?
+                            REDIRECTOR_AF_PACKET_WRAP_LEN : 0;
+        if (len + wrap_vnet_hdr_len > REDIRECTOR_MAX_LEN) {
+            error_report("filter redirector packet too large after wrap(%zd)",
+                         len);
+            continue;
+        }
+
+        iov[0].iov_base = s->in_netbuf;
+        iov[0].iov_len = len;
+        iovcnt = 1;
+        if (wrap_vnet_hdr_len) {
+            iov[0].iov_base = vnet_hdr;
+            iov[0].iov_len = wrap_vnet_hdr_len;
+            iov[1].iov_base = s->in_netbuf;
+            iov[1].iov_len = len;
+            iovcnt = 2;
+        }
+
+        ret = filter_redirector_send_chardev_iov(s, iov, iovcnt);
+        if (ret < 0) {
+            error_report("filter redirector send failed(%s)", strerror(-ret));
+        }
+    }
+
+    if (len < 0 && errno != EAGAIN && errno != EWOULDBLOCK &&
+        errno != EINTR) {
+        error_report("filter redirector read netdev failed(%s)",
+                     strerror(errno));
+    }
+}
+
 static ssize_t filter_mirror_receive_iov(NetFilterState *nf,
                                          NetClientState *sender,
                                          unsigned flags,
@@ -353,6 +450,14 @@ static void filter_redirector_vm_state_change(void *opaque, bool running,
     NetFilterState *nf = opaque;
     MirrorState *s = FILTER_REDIRECTOR(nf);
     NetClientState *nc = nf->netdev;
+    bool active = filter_redirector_input_active(nf, nf->on);
+
+    if (s->in_netfd >= 0) {
+        qemu_set_fd_handler(s->in_netfd,
+                            active ?
+                            filter_redirector_capture_netdev_read : NULL,
+                            NULL, active ? nf : NULL);
+    }
 
     if (!running && s->enable_when_stopped && nc->info->read_poll) {
         nc->info->read_poll(nc, true);
@@ -448,6 +553,7 @@ static void filter_redirector_setup(NetFilterState *nf, Error **errp)
 {
     MirrorState *s = FILTER_REDIRECTOR(nf);
     Chardev *chr;
+    bool active = filter_redirector_input_active(nf, nf->on);
 
     if (!s->indev && !s->outdev) {
         error_setg(errp, "filter redirector needs 'indev' or "
@@ -501,6 +607,13 @@ static void filter_redirector_setup(NetFilterState *nf, Error **errp)
     s->vmsentry = qemu_add_vm_change_state_handler(
         filter_redirector_vm_state_change, nf);
 
+    if (s->in_netfd >= 0) {
+        qemu_set_fd_handler(s->in_netfd,
+                            active ?
+                            filter_redirector_capture_netdev_read : NULL,
+                            NULL, active ? nf : NULL);
+    }
+
     filter_redirector_maybe_enable_read_poll(nf);
 
     filter_redirector_refresh_allow_send_when_stopped(nf);
@@ -509,6 +622,7 @@ static void filter_redirector_setup(NetFilterState *nf, Error **errp)
 static void filter_redirector_status_changed(NetFilterState *nf, Error **errp)
 {
     MirrorState *s = FILTER_REDIRECTOR(nf);
+    bool active = filter_redirector_input_active(nf, nf->on);
 
     if (s->indev) {
         if (nf->on) {
@@ -521,6 +635,13 @@ static void filter_redirector_status_changed(NetFilterState *nf, Error **errp)
         }
     }
 
+    if (s->in_netfd >= 0) {
+        qemu_set_fd_handler(s->in_netfd,
+                            active ?
+                            filter_redirector_capture_netdev_read : NULL,
+                            NULL, active ? nf : NULL);
+    }
+
     if (nf->on) {
         filter_redirector_maybe_enable_read_poll(nf);
     }
-- 
2.52.0


