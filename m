Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1F7C79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 04:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5FHg-0003gy-1L; Sat, 12 Sep 2026 00:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=md17091CFB4C=lirongqing@baidu.com>)
 id 1x5FHe-0003er-CR
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 00:24:10 -0400
Received: from mx22.baidu.com ([220.181.50.185] helo=outbound.baidu.com)
 by eggs.gnu.org with smtp (Exim 4.90_1)
 (envelope-from <prvs=md17091CFB4C=lirongqing@baidu.com>)
 id 1x5FHZ-0002id-9C
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 00:24:10 -0400
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] virtio-qmp: Fix out-of-bounds vqs index in vhost queue status
Date: Sat, 12 Sep 2026 12:23:43 +0800
Message-ID: <20260912042343.2362-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.127.73.8]
X-ClientProxiedBy: bjkjy-exc14.internal.baidu.com (172.31.51.14) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
 s=selector1; t=1789187033;
 bh=5F2HrjIeDQ0eVo5nliWNiLYSkkw3kXGIBx1FOuOQUtY=;
 h=From:To:CC:Subject:Date:Message-ID:Content-Type;
 b=O1kq7LwtLN/2yaufTkM5EpCPqNFA7Re1RNlA4X9F8vcMjiQqnOOKSoG+f2kxEQrQF
 tTqMz1d7oQcwtHiHtA299xOmutqtXI09H2PMiDuGR5pwQ1XcfRf890mLiThfep0cQv
 0/6z0lkAlaHtIF1UENyvoj86hnV656MX5VQa8r58uItz0q1Tvvrk4oHKQwQ5J5/9Ei
 Gs9a/LYQEDgzYtVoRs8cbAlh7aIpofPDWOkh9+GctTnCLHr9Pd+1Qh59nPy+Ph901Y
 uR6MrzM8Rt9PuQSu68ajFIE2lGdIlJzUjZj8aJ9LW7zo1PEkaK4FqmiZ9P+RJGklq/
 OqSmIdoWF4mfQ==
Received-SPF: pass client-ip=220.181.50.185;
 envelope-from=prvs=md17091CFB4C=lirongqing@baidu.com; helo=outbound.baidu.com
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

From: Li RongQing <lirongqing@baidu.com>

qmp_x_query_virtio_vhost_queue_status() validates the queue number
against the vhost device's global range (queue < hdev->vq_index +
hdev->nvqs), confirming that 'queue' is a global index.  But it then
indexes hdev->vqs[] directly with that global index.

hdev->vqs is allocated as g_new0(struct vhost_virtqueue, hdev->nvqs),
so valid local indices are 0..nvqs-1.  When hdev->vq_index > 0
(multiqueue vhost-net queue pairs other than the first), every access
hdev->vqs[queue] reads past the end of the array.

Use queue - hdev->vq_index to compute the local index, consistent with
the rest of vhost.c (e.g. vhost_virtqueue_pending/mask).

Fixes: 07536ddda73a07 ("qmp: add QMP commands for virtio/vhost queue-status")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 hw/virtio/virtio-qmp.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 8b7cd7a..8d190c4 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -789,6 +789,7 @@ VirtVhostQueueStatus *qmp_x_query_virtio_vhost_queue_status(const char *path,
 
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
     struct vhost_dev *hdev = vdc->get_vhost(vdev);
+    int vq = queue - hdev->vq_index;
 
     if (queue < hdev->vq_index || queue >= hdev->vq_index + hdev->nvqs) {
         error_setg(errp, "Invalid vhost virtqueue number %d", queue);
@@ -797,15 +798,15 @@ VirtVhostQueueStatus *qmp_x_query_virtio_vhost_queue_status(const char *path,
 
     status = g_new0(VirtVhostQueueStatus, 1);
     status->name = g_strdup(vdev->name);
-    status->kick = hdev->vqs[queue].kick;
-    status->call = hdev->vqs[queue].call;
-    status->num = hdev->vqs[queue].num;
-    status->desc_phys = hdev->vqs[queue].desc_phys;
-    status->desc_size = hdev->vqs[queue].desc_size;
-    status->avail_phys = hdev->vqs[queue].avail_phys;
-    status->avail_size = hdev->vqs[queue].avail_size;
-    status->used_phys = hdev->vqs[queue].used_phys;
-    status->used_size = hdev->vqs[queue].used_size;
+    status->kick = hdev->vqs[vq].kick;
+    status->call = hdev->vqs[vq].call;
+    status->num = hdev->vqs[vq].num;
+    status->desc_phys = hdev->vqs[vq].desc_phys;
+    status->desc_size = hdev->vqs[vq].desc_size;
+    status->avail_phys = hdev->vqs[vq].avail_phys;
+    status->avail_size = hdev->vqs[vq].avail_size;
+    status->used_phys = hdev->vqs[vq].used_phys;
+    status->used_size = hdev->vqs[vq].used_size;
 
     return status;
 }
-- 
2.9.4


