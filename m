Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D70CD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSQx-0005wy-8E; Wed, 10 Apr 2024 03:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSQW-0005S4-Tv; Wed, 10 Apr 2024 03:31:29 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSQV-0005Sw-8f; Wed, 10 Apr 2024 03:31:24 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AC05F5D6C5;
 Wed, 10 Apr 2024 10:25:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4F8ABB0305;
 Wed, 10 Apr 2024 10:23:10 +0300 (MSK)
Received: (nullmailer pid 4191907 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, lyx634449800 <yuxue.liu@jaguarmicro.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 85/87] vdpa-dev: Fix the issue of device status not
 updating when configuration interruption is triggered
Date: Wed, 10 Apr 2024 10:22:58 +0300
Message-Id: <20240410072303.4191455-85-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: lyx634449800 <yuxue.liu@jaguarmicro.com>

The set_config callback function vhost_vdpa_device_get_config in
vdpa-dev does not fetch the current device status from the hardware
device, causing the guest os to not receive the latest device status
information.

The hardware updates the config status of the vdpa device and then
notifies the os. The guest os receives an interrupt notification,
triggering a get_config access in the kernel, which then enters qemu
internally. Ultimately, the vhost_vdpa_device_get_config function of
vdpa-dev is called

One scenario encountered is when the device needs to bring down the
vdpa net device. After modifying the status field of virtio_net_config
in the hardware, it sends an interrupt notification. However, the guest
os always receives the STATUS field as VIRTIO_NET_S_LINK_UP.

Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20240408020003.1979-1-yuxue.liu@jaguarmicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 6ae72f609a21cfc56bf655cd4bcded5d07691ce7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index c9c6d6c611..74af1822c1 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -192,7 +192,14 @@ static void
 vhost_vdpa_device_get_config(VirtIODevice *vdev, uint8_t *config)
 {
     VhostVdpaDevice *s = VHOST_VDPA_DEVICE(vdev);
+    int ret;
 
+    ret = vhost_dev_get_config(&s->dev, s->config, s->config_size,
+                            NULL);
+    if (ret < 0) {
+        error_report("get device config space failed");
+        return;
+    }
     memcpy(config, s->config, s->config_size);
 }
 
-- 
2.39.2


