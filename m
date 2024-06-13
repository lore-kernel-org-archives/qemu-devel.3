Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE743C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 09:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHggy-00048w-9l; Thu, 13 Jun 2024 05:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sHggw-00048P-Lc
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 05:24:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sHggu-0005UD-VS
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 05:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718270660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b468c27YIaodWhCUoR2euqW9Eev+chYW0+hCXZU8pBE=;
 b=USoc8A8+baptdqpBXXYx8Tj7kZw62NgsaHqoZjY3JC6LzrSRyPKKsYrNu4YXsG0iNiJWXo
 q8FYnTlT3WZZMLi/ftyen3XWMlbP3SeE0Dw/5qq1yYrXxIfSghBImig7Bw6V/i0YPfjpWr
 egb0gJdmulHlI9xVQWW1i4pekGpSXoY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-6MKdBydSPIuLAuAAX2R09w-1; Thu,
 13 Jun 2024 05:24:16 -0400
X-MC-Unique: 6MKdBydSPIuLAuAAX2R09w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B8581955F2F; Thu, 13 Jun 2024 09:24:15 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.191])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DB0121956050; Thu, 13 Jun 2024 09:24:10 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 peter.maydell@linaro.org, clg@redhat.com, yanghliu@redhat.com,
 zhenzhong.duan@intel.com
Cc: alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com
Subject: [PATCH v3 1/7] HostIOMMUDevice: Store the VFIO/VDPA agent
Date: Thu, 13 Jun 2024 11:20:03 +0200
Message-ID: <20240613092359.847145-2-eric.auger@redhat.com>
In-Reply-To: <20240613092359.847145-1-eric.auger@redhat.com>
References: <20240613092359.847145-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Store the agent device (VFIO or VDPA) in the host IOMMU device.
This will allow easy access to some of its resources.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/sysemu/host_iommu_device.h | 1 +
 hw/vfio/container.c                | 1 +
 hw/vfio/iommufd.c                  | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
index a57873958b..3e5f058e7b 100644
--- a/include/sysemu/host_iommu_device.h
+++ b/include/sysemu/host_iommu_device.h
@@ -34,6 +34,7 @@ struct HostIOMMUDevice {
     Object parent_obj;
 
     char *name;
+    void *agent; /* pointer to agent device, ie. VFIO or VDPA device */
     HostIOMMUDeviceCaps caps;
 };
 
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 26e6f7fb4f..b728b978a2 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1145,6 +1145,7 @@ static bool hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
 
     hiod->name = g_strdup(vdev->name);
     hiod->caps.aw_bits = vfio_device_get_aw_bits(vdev);
+    hiod->agent = opaque;
 
     return true;
 }
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 409ed3dcc9..dbdae1adbb 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -631,6 +631,8 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
         struct iommu_hw_info_vtd vtd;
     } data;
 
+    hiod->agent = opaque;
+
     if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid,
                                          &type, &data, sizeof(data), errp)) {
         return false;
-- 
2.41.0


