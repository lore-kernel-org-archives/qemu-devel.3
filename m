Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EACC3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 11:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR9Mv-0005Mb-F6; Tue, 09 Jul 2024 07:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR9Mo-0004tC-9g
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:50:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR9Mh-0006Jz-2P
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720525833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ycE0kOAbk35t/G7qJITOZOUF1v6Ay4CxIjywLtMCyQM=;
 b=SA9e0xM2bFOExWMSnoD06nBUdB3pr3g3DRMPVG4yggq54Mvjmlwm6R7f0TFexcvzkD3YZz
 krmvCiTiQyAQ0jOk0FykzOQpflsWHg/55tvA/PXEfmLVeeGanSduH/GQZElFberXpk/tOf
 L5vf07XUXjsAWIG2p4cDsEZqng7ywVU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-N-XUN6gNPSadr584DlvgoA-1; Tue,
 09 Jul 2024 07:50:29 -0400
X-MC-Unique: N-XUN6gNPSadr584DlvgoA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF672196CE01; Tue,  9 Jul 2024 11:50:28 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.193.243])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CCBCF3000181; Tue,  9 Jul 2024 11:50:26 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 3/9] HostIOMMUDevice : remove Error handle from get_iova_ranges
 callback
Date: Tue,  9 Jul 2024 13:50:11 +0200
Message-ID: <20240709115017.798043-4-clg@redhat.com>
In-Reply-To: <20240709115017.798043-1-clg@redhat.com>
References: <20240709115017.798043-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Eric Auger <eric.auger@redhat.com>

The error handle argument is not used anywhere. let's remove it.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/sysemu/host_iommu_device.h | 3 +--
 hw/vfio/container.c                | 2 +-
 hw/vfio/iommufd.c                  | 2 +-
 hw/virtio/virtio-iommu.c           | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
index ee6c813c8b2299ed1d1d3b34d143c20a8ec27400..05c7324a0d1ccd2e30bc42ca1f0353e55361500a 100644
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
index 0804c1b8de2af203fd8f7ef91ee12fef105df9b5..ddd835996cfae13dcab01e53fd381ace1cdae668 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1165,7 +1165,7 @@ static int hiod_legacy_vfio_get_cap(HostIOMMUDevice *hiod, int cap,
 }
 
 static GList *
-hiod_legacy_vfio_get_iova_ranges(HostIOMMUDevice *hiod, Error **errp)
+hiod_legacy_vfio_get_iova_ranges(HostIOMMUDevice *hiod)
 {
     VFIODevice *vdev = hiod->agent;
 
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 890d8d6a38e98138fc14780a76dc8261285f90b5..211e7223f150ee3c8447a9c454c5a3528860682f 100644
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
index 8fe69ab094f501fced7098f1ba790c26e63aa775..f278417f2bd95bc57832e9d03671e2834fca5f36 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -635,7 +635,7 @@ static bool virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
 
     if (hiodc->get_iova_ranges) {
         int ret;
-        host_iova_ranges = hiodc->get_iova_ranges(hiod, errp);
+        host_iova_ranges = hiodc->get_iova_ranges(hiod);
         if (!host_iova_ranges) {
             return true; /* some old kernels may not support that capability */
         }
-- 
2.45.2


