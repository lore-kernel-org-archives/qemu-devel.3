Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B1BCD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqC0-0005xf-BC; Sun, 14 Jun 2026 15:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBu-0005MJ-6i
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBs-00029j-GK
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FchcoYqetxRLX+8KPnVCCEBTRzg70wUN0lFDoJ7PCfE=;
 b=QeCBW58ZYGnpmNRBPYe4oIEbfDKKF/izJusv9isr/P66786XZCC0azZLHuOjqLu5jyGowN
 WPoGnbv27baIYmodQwmBx0Bl9mcSws5s4hySaVjX1v1VY2CLOy8FtUlIrPUvSsXp6a3SRm
 pPEL8Dg3T6cmHVA14w34xLSRJ3RL7pM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-EacYfflgNv-lsyChcqYLFg-1; Sun, 14 Jun 2026 15:08:14 -0400
X-MC-Unique: EacYfflgNv-lsyChcqYLFg-1
X-Mimecast-MFC-AGG-ID: EacYfflgNv-lsyChcqYLFg_1781464093
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-46010392f89so2479994f8f.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464093; x=1782068893; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FchcoYqetxRLX+8KPnVCCEBTRzg70wUN0lFDoJ7PCfE=;
 b=ShAG38+/epL8TVxlYg1KGxBGvVT5sRbmItWWb8J+UGFhhpmrk9mStrLmxsUWe+AQhh
 f8EGhxWQkahMHnxqq2rQpBiblz8ADd/cfa3s/bAafQSln5pKDor0v6x+1D0lpGWhsKXz
 QFpNKhMkIOQurk7Tp5ypZNF/7Og4vBzlZIWqjpUxqd+BsDI9AoxGoc1s4r7sFxI8X5JY
 aQ4lxkRZZ9h644MrA6AsSiTWU5XnlOMviaooNrNx+UxVnY4OdNFytpSIdTBAKK9JyfVp
 AwZeSXxI52KYV+Auacw1dmSbbdrsho/EYwyQ+r8zLSoIxJwgD8H/hQvfM7StJGdisdZ4
 WFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464093; x=1782068893;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FchcoYqetxRLX+8KPnVCCEBTRzg70wUN0lFDoJ7PCfE=;
 b=Afmo/bdhdU/sZ3uac+BGbaQ1EJomOq7fANXuXUbdJfotiuqnBgUtw+vWmkYPG5qC+m
 TvbgD3rdJ4rv1znn6p3lhGHdxKgNyTr0HW7xDXgrJiolOy4MUXLBfsspZsQSt+IH29lM
 iphW6cbYWK81jG4RzbWH1ok/AogHtlL3XlGk7p06vxKNFmeGJ17WHTzyMJFYWepYNxue
 1RXl8qt4eBTK0bq1XaGdA8oBBXTqU/4zsLjebJQgarnA4HF5gz2YV5tollxI4s177+Hq
 FnGZN+unHoUK144ysA6gp57ioSvbNjCUGhvccSjJSCSIWPpXYfm3DPmu8jGahV4H3WBW
 RFsA==
X-Gm-Message-State: AOJu0YxI3FeBlNyR18+L8AwZ5IhqUdAkB+PJYVqwXwmKKx4AAmWQOa4g
 JGha8px8IN9KRWPMCILvyFZqcgbl51ebvj/SU/FyO8w8amdQnLXVHNjSHODT0izu9xQTN3iAwAo
 tsApkM9W0ejLCuTcIU2JtrVFrS6EsfU9QpEfZ/UkVJfumn0vvw4kxxUVmAP7wGl6/oILlQ7oyKe
 /tOoX4Kby7Fqn6vaKB58mglbDusC5s+H68Dg==
X-Gm-Gg: Acq92OGRToSNGwTJSewysCkQmxTNnjeDmPO/hF4bbV7mknBcIsmYF0U0Pco2BpiIaVw
 vB58c/myB7AYmC5uyRPi/sVLpULHwzBLkimOZkB7MbUXklM7M6jsvAVD4EjrJNujwb7IibnJOiV
 UlZ4a19wTQmPJjMItoT3UuB9lrTmGMU4mifMaPgMzqSuUkEHZTEHXxSbvIa9LXDV5EwynOA91pN
 wgh7qkZpZcwP/jTfo2iwVjab7a4FqYdBevGahUPOyC4EZruRlnpKLe8LFr5c//KOzkqW8ZZiOJL
 aUpKQoXkrf8uIPmtlqROfcxwCEl+JIoDgSDG+/T5W3gVEKcwzXuRTbM/qMc74cS0sZ7KYDj4+X9
 iRh+zGeYaJkafbjo7Qf+7qcJfiwD7W5GfQhWp442cJUM=
X-Received: by 2002:a05:6000:428a:b0:45e:edcc:f6dc with SMTP id
 ffacd0b85a97d-4606db9667amr15561807f8f.6.1781464093184; 
 Sun, 14 Jun 2026 12:08:13 -0700 (PDT)
X-Received: by 2002:a05:6000:428a:b0:45e:edcc:f6dc with SMTP id
 ffacd0b85a97d-4606db9667amr15561767f8f.6.1781464092571; 
 Sun, 14 Jun 2026 12:08:12 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c473bsm30398162f8f.28.2026.06.14.12.08.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:08:12 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:08:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 057/106] vhost: add .vhost_phys_iotlb_msg() handler
Message-ID: <04f0d0a69eb93c3da135068afd081871ab4f6bd5.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Allow backends to chose, which addr to put into vhost_iotlb_msg:
user or physical. To be used in further commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Based-on: <20260206095258.894504-1-vsementsov@yandex-team.ru>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260420202032.714884-10-vsementsov@yandex-team.ru>
---
 hw/virtio/vhost.c                 | 11 ++++++++---
 include/hw/virtio/vhost-backend.h |  3 +++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index e3d452a763..af41841b52 100644
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
index 7cc3bb5441..00881a0bd4 100644
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
MST


