Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E6EEE0AEC
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 13:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voigm-0004Ex-0i; Sat, 07 Feb 2026 08:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1voigV-0003qB-MM
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 08:49:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1voigS-0003I7-CM
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 08:49:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770472151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C93QEt4+9NSIa7tGhk2Jhi8x7JbqFTf/e7c2vwZ6I7o=;
 b=Qr9pN24iI9YbdpsMyG1YmgsUG1jj7P/Yt2oFueiIGoMzwcT+BWDK3eUaJ7JmZ5GPs8N1+Y
 I1Z/x+Igv4uK8qtiW2KTJA+kPWcQ6GA0Mjt8+5LHM3b9er4rVeqlTn7lTJrxLTSXIS2hLe
 tmefiPJ0EN+4qjCQ5UTcwVRWpyhQwpc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-It29qq1DN86JT-m3fqzkkw-1; Sat,
 07 Feb 2026 08:49:08 -0500
X-MC-Unique: It29qq1DN86JT-m3fqzkkw-1
X-Mimecast-MFC-AGG-ID: It29qq1DN86JT-m3fqzkkw_1770472147
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B19F180047F; Sat,  7 Feb 2026 13:49:07 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.15])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5C50518004BB; Sat,  7 Feb 2026 13:49:03 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, qemu-devel@nongnu.org
Subject: [PATCH 10/12] net/filter-buffer: store raw frames and synthesize
 vnet_hdr on release
Date: Sat,  7 Feb 2026 21:47:26 +0800
Message-ID: <20260207134728.1495932-10-lulu@redhat.com>
In-Reply-To: <20260207134728.1495932-1-lulu@redhat.com>
References: <20260207134728.1495932-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Buffer only the Ethernet frame so packets can be re-framed using the current
netdev vnet_hdr_len at release time (important across migration). Add a custom
queue deliver callback to prepend a zeroed vnet_hdr when needed, and fix iov
trimming to avoid freeing adjusted pointers or enqueueing empty packets.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 net/filter-buffer.c | 82 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 4 deletions(-)

diff --git a/net/filter-buffer.c b/net/filter-buffer.c
index 427da24097..f26b212b06 100644
--- a/net/filter-buffer.c
+++ b/net/filter-buffer.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "net/filter.h"
+#include "net/net.h"
 #include "net/queue.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
@@ -28,6 +29,43 @@ struct FilterBufferState {
     QEMUTimer release_timer;
 };
 
+static ssize_t filter_buffer_pass_to_next(NetClientState *sender,
+                                          unsigned flags,
+                                          const struct iovec *iov,
+                                          int iovcnt,
+                                          void *opaque)
+{
+    NetFilterState *nf = opaque;
+    int vnet_hdr_len = 0;
+
+    /*
+     * filter-buffer stores Ethernet frames without the vnet_hdr prefix.
+     * When releasing packets, synthesize a zeroed vnet_hdr of the current
+     * netdev vnet_hdr_len (if any) so the downstream NIC/backend sees the
+     * expected framing even across migration where vnet_hdr_len can change.
+     */
+    if (nf && nf->netdev) {
+        vnet_hdr_len = qemu_get_vnet_hdr_len(nf->netdev);
+    }
+
+    if (vnet_hdr_len > 0) {
+        uint8_t vnet_hdr[128] = { 0 };
+        g_autofree struct iovec *iov2 = g_new(struct iovec, iovcnt + 1);
+
+        g_assert((size_t)vnet_hdr_len <= sizeof(vnet_hdr));
+        iov2[0].iov_base = vnet_hdr;
+        iov2[0].iov_len = vnet_hdr_len;
+        memcpy(&iov2[1], iov, iovcnt * sizeof(*iov));
+
+        return qemu_netfilter_pass_to_next(sender,
+                                           QEMU_NET_PACKET_FLAG_NONE,
+                                           iov2, iovcnt + 1, opaque);
+    }
+
+    return qemu_netfilter_pass_to_next(sender, QEMU_NET_PACKET_FLAG_RAW,
+                                       iov, iovcnt, opaque);
+}
+
 static void filter_buffer_flush(NetFilterState *nf)
 {
     FilterBufferState *s = FILTER_BUFFER(nf);
@@ -64,6 +102,11 @@ static ssize_t filter_buffer_receive_iov(NetFilterState *nf,
                                          NetPacketSent *sent_cb)
 {
     FilterBufferState *s = FILTER_BUFFER(nf);
+    size_t skip = 0;
+    size_t total;
+    struct iovec *iov_copy;
+    struct iovec *iov_copy_base;
+    unsigned int iovcnt_copy;
 
     /*
      * We return size when buffer a packet, the sender will take it as
@@ -79,9 +122,40 @@ static ssize_t filter_buffer_receive_iov(NetFilterState *nf,
      * the packets without caring about the receiver. This is suboptimal.
      * May need more thoughts (e.g keeping sent_cb).
      */
-    qemu_net_queue_append_iov(s->incoming_queue, sender, flags,
-                              iov, iovcnt, NULL);
-    return iov_size(iov, iovcnt);
+    total = iov_size(iov, iovcnt);
+
+    /*
+     * The backend (e.g. tap) may prepend a vnet_hdr. Buffer only the Ethernet
+     * frame so we can re-synthesize the right vnet_hdr_len at release time.
+     */
+    if (!(flags & QEMU_NET_PACKET_FLAG_RAW) && nf->netdev) {
+        skip = qemu_get_vnet_hdr_len(nf->netdev);
+        if (skip > total) {
+            skip = total;
+        }
+    }
+
+    iov_copy = g_new(struct iovec, iovcnt);
+    iov_copy_base = iov_copy;
+    memcpy(iov_copy, iov, iovcnt * sizeof(*iov_copy));
+    iovcnt_copy = iovcnt;
+    if (skip) {
+        iov_discard_front(&iov_copy, &iovcnt_copy, skip);
+    }
+    if (iovcnt_copy == 0) {
+        g_free(iov_copy_base);
+        return total;
+    }
+
+    /*
+     * Stored packets are raw Ethernet frames (no vnet_hdr prefix).
+     */
+    qemu_net_queue_append_iov(s->incoming_queue, sender,
+                              QEMU_NET_PACKET_FLAG_RAW,
+                              iov_copy, iovcnt_copy, NULL);
+    g_free(iov_copy_base);
+
+    return total;
 }
 
 static void filter_buffer_cleanup(NetFilterState *nf)
@@ -126,7 +200,7 @@ static void filter_buffer_setup(NetFilterState *nf, Error **errp)
         return;
     }
 
-    s->incoming_queue = qemu_new_net_queue(qemu_netfilter_pass_to_next, nf);
+    s->incoming_queue = qemu_new_net_queue(filter_buffer_pass_to_next, nf);
     filter_buffer_setup_timer(nf);
 }
 
-- 
2.52.0


