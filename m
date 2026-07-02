Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E12C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:17:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHI5-0001hF-Oc; Thu, 02 Jul 2026 09:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1wfHI4-0001fR-1i
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:17:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1wfHI2-0008Q0-AB
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782998233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bOmDtT3Mr9ISOC1mGVQ9xbshhTvrX0+CeB3rP9gccXM=;
 b=D5wSLErg4n+jWqSIH49xS0z4r7abrjVtGVKXYoYYHmo5wa3Wt9tmIGV9nAGyG64Ql711V4
 weyX731zg1ClMitiv2AAHxJOO/4H5Ghp76q9ZaACU1Zo//bGXq5xyb9GsV3RzJmwrwUbzI
 65Y8pYTQc+xvY14KPOrwJcJmsP+NlGU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-NVkqCLPHNZyHYSR0pjDStQ-1; Thu,
 02 Jul 2026 09:17:09 -0400
X-MC-Unique: NVkqCLPHNZyHYSR0pjDStQ-1
X-Mimecast-MFC-AGG-ID: NVkqCLPHNZyHYSR0pjDStQ_1782998228
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D714118974FC; Thu,  2 Jul 2026 13:16:42 +0000 (UTC)
Received: from kdutta-thinkpadp1gen7.bengluru.csb (unknown [10.74.81.96])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AAA9C1800845; Thu,  2 Jul 2026 13:16:39 +0000 (UTC)
From: Koushik Dutta <kdutta@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v9 1/2] [PATCH 1/2] Introduce virtio_net_handle_tx_dispatch()
 to unify TX path handling. This dispatcher dynamically selects between
 timer-based and BH-based TX processing based on configuration.
Date: Thu,  2 Jul 2026 18:46:31 +0530
Message-ID: <20260702131632.1180309-2-kdutta@redhat.com>
In-Reply-To: <20260702131632.1180309-1-kdutta@redhat.com>
References: <20260702131632.1180309-1-kdutta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kdutta@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Previously, the tx=timer selected between two completely separate
code paths at queue creation time. This refactoring introduces a
runtime dispatch mechanism while maintaining identical behavior.

This is a preparatory patch with no functional changes, making it
easier to add dynamic TX notification coalescing in a subsequent patch.

Signed-off-by: Koushik Dutta <kdutta@redhat.com>
---
 hw/net/virtio-net.c            | 44 ++++++++++++++++++++++------------
 include/hw/virtio/virtio-net.h |  1 +
 2 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 2a5d642a64..319842cf28 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1002,6 +1002,8 @@ static void virtio_net_set_features(VirtIODevice *vdev,
     }
 }
 
+static void virtio_net_tx_timer(void *opaque);
+
 static int virtio_net_handle_rx_mode(VirtIONet *n, uint8_t cmd,
                                      struct iovec *iov, unsigned int iov_cnt)
 {
@@ -2817,7 +2819,6 @@ detach:
     return -EINVAL;
 }
 
-static void virtio_net_tx_timer(void *opaque);
 
 static void virtio_net_handle_tx_timer(VirtIODevice *vdev, VirtQueue *vq)
 {
@@ -2973,6 +2974,22 @@ static void virtio_net_tx_bh(void *opaque)
     }
 }
 
+static void virtio_net_handle_tx_dispatch(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtIONet *n = VIRTIO_NET(vdev);
+    VirtIONetQueue *q = &n->vqs[vq2q(virtio_get_queue_index(vq))];
+
+    if (n->tx_timer_activate) {
+        if (q->tx_timer == NULL) {
+            q->tx_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                       virtio_net_tx_timer, q);
+        }
+        virtio_net_handle_tx_timer(vdev, vq);
+    } else {
+        virtio_net_handle_tx_bh(vdev, vq);
+    }
+}
+
 static void virtio_net_add_queue(VirtIONet *n, int index)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
@@ -2980,20 +2997,13 @@ static void virtio_net_add_queue(VirtIONet *n, int index)
     n->vqs[index].rx_vq = virtio_add_queue(vdev, n->net_conf.rx_queue_size,
                                            virtio_net_handle_rx);
 
-    if (n->net_conf.tx && !strcmp(n->net_conf.tx, "timer")) {
-        n->vqs[index].tx_vq =
-            virtio_add_queue(vdev, n->net_conf.tx_queue_size,
-                             virtio_net_handle_tx_timer);
-        n->vqs[index].tx_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                              virtio_net_tx_timer,
-                                              &n->vqs[index]);
-    } else {
-        n->vqs[index].tx_vq =
-            virtio_add_queue(vdev, n->net_conf.tx_queue_size,
-                             virtio_net_handle_tx_bh);
-        n->vqs[index].tx_bh = qemu_bh_new_guarded(virtio_net_tx_bh, &n->vqs[index],
-                                                  &DEVICE(vdev)->mem_reentrancy_guard);
-    }
+    n->vqs[index].tx_vq =
+        virtio_add_queue(vdev, n->net_conf.tx_queue_size,
+                         virtio_net_handle_tx_dispatch);
+
+    n->vqs[index].tx_bh =
+        qemu_bh_new_guarded(virtio_net_tx_bh, &n->vqs[index],
+                            &DEVICE(vdev)->mem_reentrancy_guard);
 
     n->vqs[index].tx_waiting = 0;
     n->vqs[index].n = n;
@@ -3970,6 +3980,10 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
         error_printf("Defaulting to \"bh\"");
     }
 
+    if (n->net_conf.tx && strcmp(n->net_conf.tx, "timer") == 0) {
+        n->tx_timer_activate = true;
+    }
+
     n->net_conf.tx_queue_size = MIN(virtio_net_max_tx_queue_size(n),
                                     n->net_conf.tx_queue_size);
 
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 371e376428..a4eb3f407e 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -230,6 +230,7 @@ struct VirtIONet {
     struct EBPFRSSContext ebpf_rss;
     uint32_t nr_ebpf_rss_fds;
     char **ebpf_rss_fds;
+    bool tx_timer_activate;
 };
 
 size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
-- 
2.53.0


