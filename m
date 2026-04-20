Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC2AF5A8BB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 20:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEv79-000677-6S; Mon, 20 Apr 2026 16:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wEv6x-00062z-2X
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 16:20:52 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wEv6v-0006Q1-6T
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 16:20:50 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:c00c:0:640:e0de:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id E76ED8077E;
 Mon, 20 Apr 2026 23:20:47 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:54b::1:34])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id XKYwe10MOSw0-NWPniVVL; Mon, 20 Apr 2026 23:20:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1776716447;
 bh=+5Ir8ta7fWrDRTJr8RmvUcBm5Hy7vJgrEXmOl04iJcw=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=wYgb7lTbQMlJGhPPBEUDaCsNtVz3EQ35yUx4YNaIwqst7ePNhLabhqMubXQcReOX8
 zevmt00+J7kfLqAiIqreiSNTgj6md0HqHCqYdOy4s3CgH7CXTIiH99W8ToVk4afTfu
 R5woBc2y6zg333ADJNPmJkDPkAL44FAeEJV7Z2ww=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: [PATCH v2 09/10] vhost: add .vhost_phys_iotlb_msg() handler
Date: Mon, 20 Apr 2026 23:20:30 +0300
Message-ID: <20260420202032.714884-10-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260420202032.714884-1-vsementsov@yandex-team.ru>
References: <20260420202032.714884-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

Allow backends to chose, which addr to put into vhost_iotlb_msg:
user or physical. To be used in further commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost.c                 | 11 ++++++++---
 include/hw/virtio/vhost-backend.h |  3 +++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index e3d452a7637..af41841b529 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -920,14 +920,18 @@ static void vhost_region_addnop(MemoryListener *listener,
 }
 
 static int vhost_update_device_iotlb(struct vhost_dev *dev,
-                                     uint64_t iova, uint64_t uaddr,
+                                     uint64_t iova,
+                                     uint64_t paddr,
+                                     uint64_t uaddr,
                                      uint64_t len,
                                      IOMMUAccessFlags perm)
 {
+    bool phys = dev->vhost_ops->vhost_phys_iotlb_msg &&
+        dev->vhost_ops->vhost_phys_iotlb_msg(dev);
     struct vhost_iotlb_msg imsg;
 
     imsg.iova =  iova;
-    imsg.uaddr = uaddr;
+    imsg.uaddr = phys ? paddr : uaddr;
     imsg.size = len;
     imsg.type = VHOST_IOTLB_UPDATE;
 
@@ -1385,7 +1389,8 @@ int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write)
         len = MIN(iotlb.addr_mask + 1, len);
         iova = iova & ~iotlb.addr_mask;
 
-        ret = vhost_update_device_iotlb(dev, iova, uaddr, len, iotlb.perm);
+        ret = vhost_update_device_iotlb(dev, iova, iotlb.translated_addr, uaddr,
+                                        len, iotlb.perm);
         if (ret) {
             trace_vhost_iotlb_miss(dev, 4);
             error_report("Fail to update device iotlb");
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index 7cc3bb54418..00881a0bd44 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -143,6 +143,8 @@ typedef int (*vhost_dev_start_op)(struct vhost_dev *dev, bool started);
 
 typedef bool (*vhost_phys_vring_addr_op)(struct vhost_dev *dev);
 
+typedef bool (*vhost_phys_iotlb_msg_op)(struct vhost_dev *dev);
+
 typedef int (*vhost_get_device_id_op)(struct vhost_dev *dev, uint32_t *dev_id);
 
 typedef bool (*vhost_force_iommu_op)(struct vhost_dev *dev);
@@ -210,6 +212,7 @@ typedef struct VhostOps {
     vhost_set_inflight_fd_op vhost_set_inflight_fd;
     vhost_dev_start_op vhost_dev_start;
     vhost_phys_vring_addr_op vhost_phys_vring_addr;
+    vhost_phys_iotlb_msg_op vhost_phys_iotlb_msg;
     vhost_get_device_id_op vhost_get_device_id;
     vhost_force_iommu_op vhost_force_iommu;
     vhost_set_config_call_op vhost_set_config_call;
-- 
2.52.0


