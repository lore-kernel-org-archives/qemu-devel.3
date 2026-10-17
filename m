Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC09BCCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 19:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIA1d-0002Ay-F4; Sat, 17 Oct 2026 15:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1xIA0l-00024T-9z
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 15:24:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1xIA0h-0006lg-FI
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 15:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792265042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yWM+ZGnFj3k/vrA6oj5Heji1u8Dpb4jcwMcVE6Q4sQU=;
 b=Le7X3ch3Gfgecv5bOFbghpLpZkGnAnWBx98nl2/aSbWcpUqTViuNxUx53tavRrmT3EoYSp
 2tdvGWLB0uZi4T4sv4rko/nA46weR97RlNNOPR3RdLZDJFbpwju0wfh7HWDcgbvf9ioJkS
 58zusZfT3Rya3qVLCd/PkEQdwVfy/SA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-uOFpHFw0MgadAd2wAYFvVA-1; Sat,
 17 Oct 2026 19:22:52 +0000
X-MC-Unique: uOFpHFw0MgadAd2wAYFvVA-1
X-Mimecast-MFC-AGG-ID: uOFpHFw0MgadAd2wAYFvVA_1792264970
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 811391956042; Sat, 17 Oct 2026 19:22:50 +0000 (UTC)
Received: from kdutta-thinkpadp1gen7.bengluru.csb (unknown [10.74.64.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4933418004D2; Sat, 17 Oct 2026 19:22:46 +0000 (UTC)
From: Koushik Dutta <kdutta@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v11 3/3] [PATCH 3/3] vhost-vdpa: Add VIRTIO_NET_F_NOTF_COAL
 support for vDPA
Date: Sun, 18 Oct 2026 00:52:32 +0530
Message-ID: <20261017192232.1545578-4-kdutta@redhat.com>
In-Reply-To: <20261017192232.1545578-1-kdutta@redhat.com>
References: <20261017192232.1545578-1-kdutta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kdutta@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Software mode (svq=on): QEMU implements coalescing using timers in
virtio_net_handle_ctrl(). Delays RX/TX notifications based on packet
count and microsecond thresholds configured via control virtqueue.

Hardware mode (svq=off): Commands passed through to vDPA device.
Requires hardware support for VIRTIO_NET_F_NOTF_COAL in silicon

Signed-off-by: Koushik Dutta <kdutta@redhat.com>
---
 net/vhost-vdpa.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index ebd77135da..e8dc79fb23 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -118,6 +118,7 @@ static const uint64_t vdpa_svq_device_features =
     BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) |
     BIT_ULL(VIRTIO_NET_F_STATUS) |
     BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |
+    BIT_ULL(VIRTIO_NET_F_NOTF_COAL) |
     BIT_ULL(VIRTIO_NET_F_GSO) |
     BIT_ULL(VIRTIO_NET_F_CTRL_RX) |
     BIT_ULL(VIRTIO_NET_F_CTRL_VLAN) |
@@ -1233,6 +1234,58 @@ static int vhost_vdpa_net_load_vlan(VhostVDPAState *s,
     return 0;
 }
 
+static int vhost_vdpa_net_load_coal(VhostVDPAState *s,
+                                    const VirtIONet *n,
+                                    struct iovec *out_cursor,
+                                    struct iovec *in_cursor)
+{
+    struct virtio_net_ctrl_coal_rx coal_rx;
+    struct virtio_net_ctrl_coal_tx coal_tx;
+    ssize_t dev_written;
+
+    if (!virtio_vdev_has_feature(VIRTIO_DEVICE(n), VIRTIO_NET_F_NOTF_COAL)) {
+        return 0;
+    }
+
+    coal_rx.rx_max_packets = cpu_to_le32(n->vqs[0].rx_coal.packets);
+    coal_rx.rx_usecs = cpu_to_le32(n->vqs[0].rx_coal.usecs);
+
+    const struct iovec data_rx[] = {
+        {
+            .iov_base = &coal_rx,
+            .iov_len = sizeof(coal_rx),
+        },
+    };
+
+    dev_written = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
+                                          VIRTIO_NET_CTRL_NOTF_COAL,
+                                          VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,
+                                          data_rx, ARRAY_SIZE(data_rx));
+    if (unlikely(dev_written < 0)) {
+        return dev_written;
+    }
+
+    coal_tx.tx_max_packets = cpu_to_le32(n->vqs[0].tx_coal.packets);
+    coal_tx.tx_usecs = cpu_to_le32(n->vqs[0].tx_coal.usecs);
+
+    const struct iovec data_tx[] = {
+        {
+            .iov_base = &coal_tx,
+            .iov_len = sizeof(coal_tx),
+        },
+    };
+
+    dev_written = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
+                                          VIRTIO_NET_CTRL_NOTF_COAL,
+                                          VIRTIO_NET_CTRL_NOTF_COAL_TX_SET,
+                                          data_tx, ARRAY_SIZE(data_tx));
+    if (unlikely(dev_written < 0)) {
+        return dev_written;
+    }
+
+    return 0;
+}
+
 static int vhost_vdpa_net_cvq_load(NetClientState *nc)
 {
     VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
@@ -1271,6 +1324,10 @@ static int vhost_vdpa_net_cvq_load(NetClientState *nc)
         if (unlikely(r)) {
             return r;
         }
+        r = vhost_vdpa_net_load_coal(s, n, &out_cursor, &in_cursor);
+        if (unlikely(r < 0)) {
+            return r;
+        }
 
         /*
          * We need to poll and check all pending device's used buffers.
-- 
2.53.0


