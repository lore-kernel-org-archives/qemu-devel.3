Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B602CA1002
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 21:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uv02Y-0003TH-Sl; Sat, 06 Sep 2025 17:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uv02N-0003QH-A4; Sat, 06 Sep 2025 17:01:31 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uv02J-0005ow-95; Sat, 06 Sep 2025 17:01:30 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EE5AB150F7F;
 Sun, 07 Sep 2025 00:00:54 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id A8DD927868A;
 Sun,  7 Sep 2025 00:00:56 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.20 20/34] virtio-net: Add only one queue pair when
 realizing
Date: Sun,  7 Sep 2025 00:00:40 +0300
Message-ID: <20250906210056.127031-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-7.2.20-20250906235950@cover.tls.msk.ru>
References: <qemu-stable-7.2.20-20250906235950@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Multiqueue usage is not negotiated yet when realizing. If more than
one queue is added and the guest never requests to enable multiqueue,
the extra queues will not be deleted when unrealizing and leak.

Fixes: f9d6dbf0bf6e ("virtio-net: remove virtio queues if the guest doesn't support multiqueue")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 8c49756825dab430b17648637735c2736d23f778)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 0ba1db5b14..d7d155a44d 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3640,9 +3640,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     n->net_conf.tx_queue_size = MIN(virtio_net_max_tx_queue_size(n),
                                     n->net_conf.tx_queue_size);
 
-    for (i = 0; i < n->max_queue_pairs; i++) {
-        virtio_net_add_queue(n, i);
-    }
+    virtio_net_add_queue(n, 0);
 
     n->ctrl_vq = virtio_add_queue(vdev, 64, virtio_net_handle_ctrl);
     qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);
-- 
2.47.3


