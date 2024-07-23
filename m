Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29083C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 14:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWG4e-0000hK-JC; Tue, 23 Jul 2024 10:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sWG4X-0000Qf-87
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:00:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sWG4V-0003go-Ic
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721743253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N9/kCN81sHufGI2sBNo0AKR9w6L3px1fmwChM4EnCoc=;
 b=hLUru548snNc2yHr2IbPzzohaU1W+MCPa2ISUN9JC6QaMHKsML8N8Kfz2E3iOefAfQ0YGi
 YHh5XTrxqaXgd0Mbu0i8vne/ul4V5Itxao0deR5cHTOaS1QJvVY1PEBxItnYtB3vrLP9JB
 3K/CNIsYbEZLcpaEHuOlpOzwn363D00=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-iuzggiC1O_qbNF2lAxXMGw-1; Tue,
 23 Jul 2024 10:00:51 -0400
X-MC-Unique: iuzggiC1O_qbNF2lAxXMGw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C60E0196E09D; Tue, 23 Jul 2024 14:00:48 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.91])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A21B4195605A; Tue, 23 Jul 2024 14:00:46 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL 10/16] vfio/iommufd: Add hw_caps field to HostIOMMUDeviceCaps
Date: Tue, 23 Jul 2024 16:00:13 +0200
Message-ID: <20240723140019.387786-11-clg@redhat.com>
In-Reply-To: <20240723140019.387786-1-clg@redhat.com>
References: <20240723140019.387786-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Joao Martins <joao.m.martins@oracle.com>

Store the value of @caps returned by iommufd_backend_get_device_info()
in a new field HostIOMMUDeviceCaps::hw_caps. Right now the only value is
whether device IOMMU supports dirty tracking (IOMMU_HW_CAP_DIRTY_TRACKING).

This is in preparation for HostIOMMUDevice::realize() being called early
during attach_device().

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 include/sysemu/host_iommu_device.h | 4 ++++
 hw/vfio/iommufd.c                  | 1 +
 2 files changed, 5 insertions(+)

diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
index d1c10ff7c239d9a0ae31894abe929e1e96b63ef2..809cced4ba5c56263132b474a382e4bd0ffdd3cd 100644
--- a/include/sysemu/host_iommu_device.h
+++ b/include/sysemu/host_iommu_device.h
@@ -19,9 +19,13 @@
  * struct HostIOMMUDeviceCaps - Define host IOMMU device capabilities.
  *
  * @type: host platform IOMMU type.
+ *
+ * @hw_caps: host platform IOMMU capabilities (e.g. on IOMMUFD this represents
+ *           the @out_capabilities value returned from IOMMU_GET_HW_INFO ioctl)
  */
 typedef struct HostIOMMUDeviceCaps {
     uint32_t type;
+    uint64_t hw_caps;
 } HostIOMMUDeviceCaps;
 
 #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index f1e7cf3e9cafde08a0353876da973f3713006df3..fb87e64e443035bc239f4f4272ae1c28fa8ab8c9 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -725,6 +725,7 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
 
     hiod->name = g_strdup(vdev->name);
     caps->type = type;
+    caps->hw_caps = hw_caps;
 
     return true;
 }
-- 
2.45.2


