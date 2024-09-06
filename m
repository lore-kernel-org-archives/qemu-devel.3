Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F45CE7B02
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 11:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smWw5-0000q3-JD; Fri, 06 Sep 2024 07:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWvl-0000Cq-NO; Fri, 06 Sep 2024 07:15:11 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWvh-0007lb-Sq; Fri, 06 Sep 2024 07:15:08 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E26BB8C485;
 Fri,  6 Sep 2024 14:12:07 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E202F1336EF;
 Fri,  6 Sep 2024 14:13:25 +0300 (MSK)
Received: (nullmailer pid 353607 invoked by uid 1000);
 Fri, 06 Sep 2024 11:13:24 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.3 21/69] hw/virtio: Fix the de-initialization of
 vhost-user devices
Date: Fri,  6 Sep 2024 14:12:30 +0300
Message-Id: <20240906111324.353230-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
References: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

The unrealize functions of the various vhost-user devices are
calling the corresponding vhost_*_set_status() functions with a
status of 0 to shut down the device correctly.

Now these vhost_*_set_status() functions all follow this scheme:

    bool should_start = virtio_device_should_start(vdev, status);

    if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
        return;
    }

    if (should_start) {
        /* ... do the initialization stuff ... */
    } else {
        /* ... do the cleanup stuff ... */
    }

The problem here is virtio_device_should_start(vdev, 0) currently
always returns "true" since it internally only looks at vdev->started
instead of looking at the "status" parameter. Thus once the device
got started once, virtio_device_should_start() always returns true
and thus the vhost_*_set_status() functions return early, without
ever doing any clean-up when being called with status == 0. This
causes e.g. problems when trying to hot-plug and hot-unplug a vhost
user devices multiple times since the de-initialization step is
completely skipped during the unplug operation.

This bug has been introduced in commit 9f6bcfd99f ("hw/virtio: move
vm_running check to virtio_device_started") which replaced

 should_start = status & VIRTIO_CONFIG_S_DRIVER_OK;

with

 should_start = virtio_device_started(vdev, status);

which later got replaced by virtio_device_should_start(). This blocked
the possibility to set should_start to false in case the status flag
VIRTIO_CONFIG_S_DRIVER_OK was not set.

Fix it by adjusting the virtio_device_should_start() function to
only consider the status flag instead of vdev->started. Since this
function is only used in the various vhost_*_set_status() functions
for exactly the same purpose, it should be fine to fix it in this
central place there without any risk to change the behavior of other
code.

Fixes: 9f6bcfd99f ("hw/virtio: move vm_running check to virtio_device_started")
Buglink: https://issues.redhat.com/browse/RHEL-40708
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240618121958.88673-1-thuth@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit d72479b11797c28893e1e3fc565497a9cae5ca16)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 7d5ffdc145..2eafad17b8 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -470,9 +470,9 @@ static inline bool virtio_device_started(VirtIODevice *vdev, uint8_t status)
  * @vdev - the VirtIO device
  * @status - the devices status bits
  *
- * This is similar to virtio_device_started() but also encapsulates a
- * check on the VM status which would prevent a device starting
- * anyway.
+ * This is similar to virtio_device_started() but ignores vdev->started
+ * and also encapsulates a check on the VM status which would prevent a
+ * device from starting anyway.
  */
 static inline bool virtio_device_should_start(VirtIODevice *vdev, uint8_t status)
 {
@@ -480,7 +480,7 @@ static inline bool virtio_device_should_start(VirtIODevice *vdev, uint8_t status
         return false;
     }
 
-    return virtio_device_started(vdev, status);
+    return status & VIRTIO_CONFIG_S_DRIVER_OK;
 }
 
 static inline void virtio_set_started(VirtIODevice *vdev, bool started)
-- 
2.39.2


