Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375D5EB28F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 07:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpLrj-0000n4-9n; Mon, 09 Feb 2026 02:39:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vpLre-0000mh-1t
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:39:22 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vpLrb-0004fi-CG
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:39:21 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 083C280758;
 Mon, 09 Feb 2026 10:39:16 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:129::1:13])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id BdLXu72As8c0-gJBXToVs; Mon, 09 Feb 2026 10:39:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770622755;
 bh=Tg9Wo8LzNbhUKtnAcX9CnLy/WiMzPyuzhZr7FMX6fHw=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Hu8cxbPNvN/t4d7uXBWPa1PFpVxKK/ukxaZzcptBb6G6uDAkR8F0WLi+69T/TO38R
 v2GDLcaf6awoosJtaNT3Scs6VQpJUefEquowmzszug/sI/X9/u7gcgi/4njeXeM4SI
 L4tMJ5Gx09wK7j77bhtECQk0FsproEWjeKvMeWDI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: [PATCH 04/10] vhost: replace .vhost_vq_get_addr() with
 .vhost_phys_vring_addr()
Date: Mon,  9 Feb 2026 10:39:01 +0300
Message-ID: <20260209073908.2125178-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260209073908.2125178-1-vsementsov@yandex-team.ru>
References: <20260209073908.2125178-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

Make a simper handler to consolidate the logic in one place. That
helps further changes.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost-vdpa.c            | 13 +++----------
 hw/virtio/vhost.c                 | 12 ++++++------
 include/hw/virtio/vhost-backend.h |  6 ++----
 3 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index fd9e92092d..5752474b64 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -1571,16 +1571,9 @@ static int vhost_vdpa_set_owner(struct vhost_dev *dev)
     return 0;
 }
 
-static int vhost_vdpa_vq_get_addr(struct vhost_dev *dev,
-                    struct vhost_vring_addr *addr, struct vhost_virtqueue *vq)
+static bool vhost_vdpa_phys_vring_addr(struct vhost_dev *dev)
 {
-    assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_VDPA);
-    addr->desc_user_addr = (uint64_t)(unsigned long)vq->desc_phys;
-    addr->avail_user_addr = (uint64_t)(unsigned long)vq->avail_phys;
-    addr->used_user_addr = (uint64_t)(unsigned long)vq->used_phys;
-    trace_vhost_vdpa_vq_get_addr(dev, vq, addr->desc_user_addr,
-                                 addr->avail_user_addr, addr->used_user_addr);
-    return 0;
+    return true;
 }
 
 static bool  vhost_vdpa_force_iommu(struct vhost_dev *dev)
@@ -1617,7 +1610,7 @@ const VhostOps vdpa_ops = {
         .vhost_send_device_iotlb_msg = NULL,
         .vhost_dev_start = vhost_vdpa_dev_start,
         .vhost_get_device_id = vhost_vdpa_get_device_id,
-        .vhost_vq_get_addr = vhost_vdpa_vq_get_addr,
+        .vhost_phys_vring_addr = vhost_vdpa_phys_vring_addr,
         .vhost_force_iommu = vhost_vdpa_force_iommu,
         .vhost_set_config_call = vhost_vdpa_set_config_call,
         .vhost_reset_status = vhost_vdpa_reset_status,
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index fe63091985..587f301832 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1093,16 +1093,16 @@ static int vhost_virtqueue_set_addr(struct vhost_dev *dev,
                                     struct vhost_virtqueue *vq,
                                     unsigned idx, bool enable_log)
 {
+    bool phys = dev->vhost_ops->vhost_phys_vring_addr &&
+        dev->vhost_ops->vhost_phys_vring_addr(dev);
     struct vhost_vring_addr addr;
     int r;
     memset(&addr, 0, sizeof(struct vhost_vring_addr));
 
-    if (dev->vhost_ops->vhost_vq_get_addr) {
-        r = dev->vhost_ops->vhost_vq_get_addr(dev, &addr, vq);
-        if (r < 0) {
-            VHOST_OPS_DEBUG(r, "vhost_vq_get_addr failed");
-            return r;
-        }
+    if (phys) {
+        addr.desc_user_addr = (uint64_t)(unsigned long)vq->desc_phys;
+        addr.avail_user_addr = (uint64_t)(unsigned long)vq->avail_phys;
+        addr.used_user_addr = (uint64_t)(unsigned long)vq->used_phys;
     } else {
         addr.desc_user_addr = (uint64_t)(unsigned long)vq->desc;
         addr.avail_user_addr = (uint64_t)(unsigned long)vq->avail;
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index aab6bf3ef7..7cc3bb5441 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -141,9 +141,7 @@ typedef int (*vhost_set_inflight_fd_op)(struct vhost_dev *dev,
 
 typedef int (*vhost_dev_start_op)(struct vhost_dev *dev, bool started);
 
-typedef int (*vhost_vq_get_addr_op)(struct vhost_dev *dev,
-                    struct vhost_vring_addr *addr,
-                    struct vhost_virtqueue *vq);
+typedef bool (*vhost_phys_vring_addr_op)(struct vhost_dev *dev);
 
 typedef int (*vhost_get_device_id_op)(struct vhost_dev *dev, uint32_t *dev_id);
 
@@ -211,7 +209,7 @@ typedef struct VhostOps {
     vhost_get_inflight_fd_op vhost_get_inflight_fd;
     vhost_set_inflight_fd_op vhost_set_inflight_fd;
     vhost_dev_start_op vhost_dev_start;
-    vhost_vq_get_addr_op  vhost_vq_get_addr;
+    vhost_phys_vring_addr_op vhost_phys_vring_addr;
     vhost_get_device_id_op vhost_get_device_id;
     vhost_force_iommu_op vhost_force_iommu;
     vhost_set_config_call_op vhost_set_config_call;
-- 
2.52.0


