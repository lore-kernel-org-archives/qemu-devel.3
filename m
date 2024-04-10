Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BACDCD1297
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 05:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruQon-0006Et-Vt; Wed, 10 Apr 2024 01:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruQoR-00050n-FP; Wed, 10 Apr 2024 01:47:59 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruQoO-00027V-4E; Wed, 10 Apr 2024 01:47:59 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 54CB55D500;
 Wed, 10 Apr 2024 08:46:17 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 1611AB0167;
 Wed, 10 Apr 2024 08:44:19 +0300 (MSK)
Received: (nullmailer pid 4182123 invoked by uid 1000);
 Wed, 10 Apr 2024 05:44:16 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Yajun Wu <yajunw@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.11 40/41] hw/net/virtio-net: fix qemu set used ring flag
 even vhost started
Date: Wed, 10 Apr 2024 08:44:01 +0300
Message-Id: <20240410054416.4181891-40-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.11-20240410084037@cover.tls.msk.ru>
References: <qemu-stable-7.2.11-20240410084037@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Yajun Wu <yajunw@nvidia.com>

When vhost-user or vhost-kernel is handling virtio net datapath,
QEMU should not touch used ring.

But with vhost-user socket reconnect scenario, in a very rare case
(has pending kick event). VRING_USED_F_NO_NOTIFY is set by QEMU in
following code path:

	#0  virtio_queue_split_set_notification (vq=0x7ff5f4c920a8, enable=0) at ../hw/virtio/virtio.c:511
	#1  0x0000559d6dbf033b in virtio_queue_set_notification (vq=0x7ff5f4c920a8, enable=0) at ../hw/virtio/virtio.c:576
	#2  0x0000559d6dbbbdbc in virtio_net_handle_tx_bh (vdev=0x559d703a6aa0, vq=0x7ff5f4c920a8) at ../hw/net/virtio-net.c:2801
	#3  0x0000559d6dbf4791 in virtio_queue_notify_vq (vq=0x7ff5f4c920a8) at ../hw/virtio/virtio.c:2248
	#4  0x0000559d6dbf79da in virtio_queue_host_notifier_read (n=0x7ff5f4c9211c) at ../hw/virtio/virtio.c:3525
	#5  0x0000559d6d9a5814 in virtio_bus_cleanup_host_notifier (bus=0x559d703a6a20, n=1) at ../hw/virtio/virtio-bus.c:321
	#6  0x0000559d6dbf83c9 in virtio_device_stop_ioeventfd_impl (vdev=0x559d703a6aa0) at ../hw/virtio/virtio.c:3774
	#7  0x0000559d6d9a55c8 in virtio_bus_stop_ioeventfd (bus=0x559d703a6a20) at ../hw/virtio/virtio-bus.c:259
	#8  0x0000559d6d9a53e8 in virtio_bus_grab_ioeventfd (bus=0x559d703a6a20) at ../hw/virtio/virtio-bus.c:199
	#9  0x0000559d6dbf841c in virtio_device_grab_ioeventfd (vdev=0x559d703a6aa0) at ../hw/virtio/virtio.c:3783
	#10 0x0000559d6d9bde18 in vhost_dev_enable_notifiers (hdev=0x559d707edd70, vdev=0x559d703a6aa0) at ../hw/virtio/vhost.c:1592
	#11 0x0000559d6d89a0b8 in vhost_net_start_one (net=0x559d707edd70, dev=0x559d703a6aa0) at ../hw/net/vhost_net.c:266
	#12 0x0000559d6d89a6df in vhost_net_start (dev=0x559d703a6aa0, ncs=0x559d7048d890, data_queue_pairs=31, cvq=0) at ../hw/net/vhost_net.c:412
	#13 0x0000559d6dbb5b89 in virtio_net_vhost_status (n=0x559d703a6aa0, status=15 '\017') at ../hw/net/virtio-net.c:311
	#14 0x0000559d6dbb5e34 in virtio_net_set_status (vdev=0x559d703a6aa0, status=15 '\017') at ../hw/net/virtio-net.c:392
	#15 0x0000559d6dbb60d8 in virtio_net_set_link_status (nc=0x559d7048d890) at ../hw/net/virtio-net.c:455
	#16 0x0000559d6da64863 in qmp_set_link (name=0x559d6f0b83d0 "hostnet1", up=true, errp=0x7ffdd76569f0) at ../net/net.c:1459
	#17 0x0000559d6da7226e in net_vhost_user_event (opaque=0x559d6f0b83d0, event=CHR_EVENT_OPENED) at ../net/vhost-user.c:301
	#18 0x0000559d6ddc7f63 in chr_be_event (s=0x559d6f2ffea0, event=CHR_EVENT_OPENED) at ../chardev/char.c:62
	#19 0x0000559d6ddc7fdc in qemu_chr_be_event (s=0x559d6f2ffea0, event=CHR_EVENT_OPENED) at ../chardev/char.c:82

This issue causes guest kernel stop kicking device and traffic stop.

Add vhost_started check in virtio_net_handle_tx_bh to fix this wrong
VRING_USED_F_NO_NOTIFY set.

Signed-off-by: Yajun Wu <yajunw@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20240402045109.97729-1-yajunw@nvidia.com>
[PMD: Use unlikely()]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 4c54f5bc8e1d38f15cc35b6a6932d8fbe219c692)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 57d5a377c8..b6177a6afe 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2746,6 +2746,10 @@ static void virtio_net_handle_tx_bh(VirtIODevice *vdev, VirtQueue *vq)
     VirtIONet *n = VIRTIO_NET(vdev);
     VirtIONetQueue *q = &n->vqs[vq2q(virtio_get_queue_index(vq))];
 
+    if (unlikely(n->vhost_started)) {
+        return;
+    }
+
     if (unlikely((n->status & VIRTIO_NET_S_LINK_UP) == 0)) {
         virtio_net_drop_tx_queue_data(vdev, vq);
         return;
-- 
2.39.2


