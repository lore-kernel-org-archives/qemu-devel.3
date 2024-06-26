Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B5EC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 08:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMO0Y-00072Q-2e; Wed, 26 Jun 2024 04:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sMO0V-0006ys-SQ
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 04:28:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sMO0U-0007AG-BI
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 04:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719390477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NDTYo/p7rWWGol+dOUs5Dsf60vz8nXghSY68K5KXSmM=;
 b=SKiLUZ1Ibzmk0KWbL9G7ow3sR/Au3itrhulLmZ5b0BW7E0YcLoGRFjGRLRPVYiezxuBhfD
 rtq969YvDmoy3oT/jm0uFsgqp4YR9iLlxXb/hHAFD2SrNUibrCT73zjYI6onFLUrrL0csI
 bg7Gym56o+NzIgkrFcBmWM8ljxlHc/w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-eSr8stjDNsyyrCgcsYHaoQ-1; Wed,
 26 Jun 2024 04:27:55 -0400
X-MC-Unique: eSr8stjDNsyyrCgcsYHaoQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C683195609F; Wed, 26 Jun 2024 08:27:54 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.191])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0B5651956087; Wed, 26 Jun 2024 08:27:49 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 peter.maydell@linaro.org, clg@redhat.com, yanghliu@redhat.com,
 zhenzhong.duan@intel.com, alex.williamson@redhat.com
Subject: [PATCH 3/7] HostIOMMUDevice : remove Error handle from
 get_iova_ranges callback
Date: Wed, 26 Jun 2024 10:26:48 +0200
Message-ID: <20240626082727.1278530-4-eric.auger@redhat.com>
In-Reply-To: <20240626082727.1278530-1-eric.auger@redhat.com>
References: <20240626082727.1278530-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The error handle argument is not used anywhere. let's remove it.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/sysemu/host_iommu_device.h | 3 +--
 hw/vfio/container.c                | 2 +-
 hw/vfio/iommufd.c                  | 2 +-
 hw/virtio/virtio-iommu.c           | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
index ee6c813c8b..05c7324a0d 100644
--- a/include/sysemu/host_iommu_device.h
+++ b/include/sysemu/host_iommu_device.h
@@ -87,9 +87,8 @@ struct HostIOMMUDeviceClass {
      * @hiod Host IOMMU device
      *
      * @hiod: handle to the host IOMMU device
-     * @errp: error handle
      */
-    GList* (*get_iova_ranges)(HostIOMMUDevice *hiod, Error **errp);
+    GList* (*get_iova_ranges)(HostIOMMUDevice *hiod);
 };
 
 /*
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 2ad57cd845..adeab1ac89 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1166,7 +1166,7 @@ static int hiod_legacy_vfio_get_cap(HostIOMMUDevice *hiod, int cap,
 }
 
 static GList *
-hiod_legacy_vfio_get_iova_ranges(HostIOMMUDevice *hiod, Error **errp)
+hiod_legacy_vfio_get_iova_ranges(HostIOMMUDevice *hiod)
 {
     VFIODevice *vdev = hiod->agent;
 
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 890d8d6a38..211e7223f1 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -644,7 +644,7 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
 }
 
 static GList *
-hiod_iommufd_vfio_get_iova_ranges(HostIOMMUDevice *hiod, Error **errp)
+hiod_iommufd_vfio_get_iova_ranges(HostIOMMUDevice *hiod)
 {
     VFIODevice *vdev = hiod->agent;
 
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index b708fb96fd..b8f75d2b1a 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -615,7 +615,7 @@ static bool virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
 
     if (hiodc->get_iova_ranges) {
         int ret;
-        host_iova_ranges = hiodc->get_iova_ranges(hiod, errp);
+        host_iova_ranges = hiodc->get_iova_ranges(hiod);
         if (!host_iova_ranges) {
             return true; /* some old kernels may not support that capability */
         }
-- 
2.41.0


