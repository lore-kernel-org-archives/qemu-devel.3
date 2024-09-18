Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F407BCCD1A3
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 12:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqtWB-0004Dn-L0; Wed, 18 Sep 2024 08:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sqtWA-0004DE-Ig
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 08:10:46 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sqtW5-00069w-2q
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 08:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=L6FvinB64ChqoiH1YRZKtZr2bLXrxFni72IS/qefi3c=; b=Ow4hbxHqUZVoyuWO
 epctmHpXrGTyOwRQvKrmyaUxYQQyJ6UIBG2QkFxt2qoFzlB+iqSdpoZD9CbfouYXtmR5NruuE+gip
 E5m9UbVHf7D8AlfuHarTC106Xpob3GuuGN89k4/NZTgbM0S/i3HA+gcUcNB4es6BAePnUkZyRW+nr
 /CqMeKwHqhKD13hR/sRTq16PQV7TB7GPi/zdVvB0Top+Jq75IAd8MJKuTn2eeC5qHPFl9mBTh/nnE
 I6TFjVQY7lid8Xs+CwtEX5nSawyUPFdjqthjpuCgO9KwMg5DcdYs0Ty3Zylqlz8jeGZzJNw1QQ9TW
 CkH32q4HP7WvYXoJBQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1sqtW0-006HZH-2X;
 Wed, 18 Sep 2024 12:10:36 +0000
From: dave@treblig.org
To: mst@redhat.com,
	sgarzare@redhat.com
Cc: qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH] vhost: Remove unused vhost_dev_{load|save}_inflight
Date: Wed, 18 Sep 2024 13:10:34 +0100
Message-ID: <20240918121034.16417-1-dave@treblig.org>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
2.46.0


