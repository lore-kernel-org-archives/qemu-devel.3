Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBE7CF8840
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swknT-0002Pc-Jp; Fri, 04 Oct 2024 12:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1swknR-0002G7-65; Fri, 04 Oct 2024 12:04:49 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1swknP-0001bs-CE; Fri, 04 Oct 2024 12:04:48 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7A55D95572;
 Fri,  4 Oct 2024 19:03:30 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B45E514D980;
 Fri,  4 Oct 2024 19:03:32 +0300 (MSK)
Received: (nullmailer pid 1282542 invoked by uid 1000);
 Fri, 04 Oct 2024 16:03:32 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 13/23] vhost: Remove unused vhost_dev_{load|save}_inflight
Date: Fri,  4 Oct 2024 19:03:21 +0300
Message-Id: <20241004160331.1282441-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241004160331.1282441-1-mjt@tls.msk.ru>
References: <20241004160331.1282441-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

vhost_dev_load_inflight and vhost_dev_save_inflight have been
unused since they were added in 2019 by:

5ad204bf2a ("vhost-user: Support transferring inflight buffer between qemu and backend")

Remove them, and their helper vhost_dev_resize_inflight.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/virtio/vhost.c         | 56 ---------------------------------------
 include/hw/virtio/vhost.h |  2 --
 2 files changed, 58 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 7c5ef81b55..76f9b2aaad 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1930,62 +1930,6 @@ void vhost_dev_free_inflight(struct vhost_inflight *inflight)
     }
 }
 
-static int vhost_dev_resize_inflight(struct vhost_inflight *inflight,
-                                     uint64_t new_size)
-{
-    Error *err = NULL;
-    int fd = -1;
-    void *addr = qemu_memfd_alloc("vhost-inflight", new_size,
-                                  F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
-                                  &fd, &err);
-
-    if (err) {
-        error_report_err(err);
-        return -ENOMEM;
-    }
-
-    vhost_dev_free_inflight(inflight);
-    inflight->offset = 0;
-    inflight->addr = addr;
-    inflight->fd = fd;
-    inflight->size = new_size;
-
-    return 0;
-}
-
-void vhost_dev_save_inflight(struct vhost_inflight *inflight, QEMUFile *f)
-{
-    if (inflight->addr) {
-        qemu_put_be64(f, inflight->size);
-        qemu_put_be16(f, inflight->queue_size);
-        qemu_put_buffer(f, inflight->addr, inflight->size);
-    } else {
-        qemu_put_be64(f, 0);
-    }
-}
-
-int vhost_dev_load_inflight(struct vhost_inflight *inflight, QEMUFile *f)
-{
-    uint64_t size;
-
-    size = qemu_get_be64(f);
-    if (!size) {
-        return 0;
-    }
-
-    if (inflight->size != size) {
-        int ret = vhost_dev_resize_inflight(inflight, size);
-        if (ret < 0) {
-            return ret;
-        }
-    }
-    inflight->queue_size = qemu_get_be16(f);
-
-    qemu_get_buffer(f, inflight->addr, size);
-
-    return 0;
-}
-
 int vhost_dev_prepare_inflight(struct vhost_dev *hdev, VirtIODevice *vdev)
 {
     int r;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index c75be46c06..461c168c37 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -338,8 +338,6 @@ void vhost_virtqueue_stop(struct vhost_dev *dev, struct VirtIODevice *vdev,
 
 void vhost_dev_reset_inflight(struct vhost_inflight *inflight);
 void vhost_dev_free_inflight(struct vhost_inflight *inflight);
-void vhost_dev_save_inflight(struct vhost_inflight *inflight, QEMUFile *f);
-int vhost_dev_load_inflight(struct vhost_inflight *inflight, QEMUFile *f);
 int vhost_dev_prepare_inflight(struct vhost_dev *hdev, VirtIODevice *vdev);
 int vhost_dev_set_inflight(struct vhost_dev *dev,
                            struct vhost_inflight *inflight);
-- 
2.39.5


