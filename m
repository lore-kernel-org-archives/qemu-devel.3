Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF004C44501
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifmm-0007Bq-IZ; Sat, 11 Jul 2026 18:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifmU-000759-Gd; Sat, 11 Jul 2026 18:02:48 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifmL-0008RN-9x; Sat, 11 Jul 2026 18:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807180; bh=lqu+kprOeII3+eEnwuEAvOlbZGnBz2nwZfl6x19HGcM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=tVCifyZO0GmhP/IbKb34Qv2MBCGQ4SguKsHW60HonSb95vEI82VUci/t6JU1aCQc8
 WAvfEONwL0XNw5TJGp8v13YUVB4Rh3s454tsOZsew/KJaC+HfHnaDPZxfHe2WxmEBU
 AWWEmMIwxrfTMbuXGjEmSkRqpc8L5p+pbvVQKk58Fv5Ydqi6iE4qL41xle3F3fEEoH
 JwFSjcXm6hK29NYWPOVx64tRNpy3Eb2sNK2qofKIfi0DpVKtLSEwhOXkHYufOEb5K3
 39ZckbMEyqpg7agzesDHUJMidQDnqygqApGJ++WXnjngSE2vMB6iFmSJ/UntQSXgFQ
 FiQ/X73eeePog==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D051F1C0AAB;
 Sun, 12 Jul 2026 00:59:40 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 86F8A3EAF36;
 Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 82C4813323; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 32/81] hw/char/virtio-serial-bus: fix
 guest-triggerable OOM in control_out()
Date: Sun, 12 Jul 2026 00:58:10 +0300
Message-ID: <20260711215904.3757-32-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Laurent Vivier <lvivier@redhat.com>

A malicious guest can craft virtqueue descriptors with arbitrary lengths.
control_out() calls iov_size() on the guest-supplied scatter-gather list
and passes the result directly to g_malloc(), allowing a guest to force
QEMU to attempt multi-gigabyte allocations and crash the host process.

Fix this by copying at most sizeof(struct virtio_console_control) into a
stack-local variable instead of allocating a buffer sized by the guest.
handle_control_message() only accesses the fixed-size id, event, and
value fields, so no data beyond the struct was ever needed.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3585
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260622161144.2883799-1-lvivier@redhat.com>
(cherry picked from commit 36b37f8494800ed9c5d4b6ef03924bd1636cb810)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index cd234dc6db1..c1973f0248f 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -344,22 +344,16 @@ void virtio_serial_throttle_port(VirtIOSerialPort *port, bool throttle)
 }
 
 /* Guest wants to notify us of some event */
-static void handle_control_message(VirtIOSerial *vser, void *buf, size_t len)
+static void handle_control_message(VirtIOSerial *vser,
+                                   struct virtio_console_control *gcpkt)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(vser);
     struct VirtIOSerialPort *port;
     VirtIOSerialPortClass *vsc;
-    struct virtio_console_control cpkt, *gcpkt;
+    struct virtio_console_control cpkt;
     uint8_t *buffer;
     size_t buffer_len;
 
-    gcpkt = buf;
-
-    if (len < sizeof(cpkt)) {
-        /* The guest sent an invalid control packet */
-        return;
-    }
-
     cpkt.event = virtio_lduw_p(vdev, &gcpkt->event);
     cpkt.value = virtio_lduw_p(vdev, &gcpkt->value);
 
@@ -457,41 +451,27 @@ static void control_in(VirtIODevice *vdev, VirtQueue *vq)
 
 static void control_out(VirtIODevice *vdev, VirtQueue *vq)
 {
+    struct virtio_console_control cpkt;
     VirtQueueElement *elem;
     VirtIOSerial *vser;
-    uint8_t *buf;
     size_t len;
 
     vser = VIRTIO_SERIAL(vdev);
 
-    len = 0;
-    buf = NULL;
     for (;;) {
-        size_t cur_len;
-
         elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
         if (!elem) {
             break;
         }
 
-        cur_len = iov_size(elem->out_sg, elem->out_num);
-        /*
-         * Allocate a new buf only if we didn't have one previously or
-         * if the size of the buf differs
-         */
-        if (cur_len > len) {
-            g_free(buf);
-
-            buf = g_malloc(cur_len);
-            len = cur_len;
+        len = iov_to_buf(elem->out_sg, elem->out_num, 0, &cpkt, sizeof(cpkt));
+        if (len == sizeof(cpkt)) {
+            handle_control_message(vser, &cpkt);
         }
-        iov_to_buf(elem->out_sg, elem->out_num, 0, buf, cur_len);
 
-        handle_control_message(vser, buf, cur_len);
         virtqueue_push(vq, elem, 0);
         g_free(elem);
     }
-    g_free(buf);
     virtio_notify(vdev, vq);
 }
 
-- 
2.47.3


