Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B912DC369D3
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 16:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7GB4-0005wj-JK; Tue, 22 Apr 2025 12:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7G5r-0007R4-2K
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:03:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7G5o-000537-K0
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745337807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4bKe87yw3UalntCEf1VLjS4RuQPmi2EvxYa5Q8J0ASY=;
 b=frEV84Lht92Ta7wsEcZu7y+zwxFj4gojJZeOW0PuqWLR+hPl9VMAaI9H2EsOhr5HgY3A7q
 5/Zf39HoCoFyMlCP7v3J7tDyvAzGrv8atWbpbmFLHnZnHaYjNtN1+QLfvlR+r79JR2HFA0
 DhBTrE0K/4cfE3eodEpDuzOH0mH52g8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-J-3Y6nrZMF2fdcwwksMk5g-1; Tue,
 22 Apr 2025 12:03:26 -0400
X-MC-Unique: J-3Y6nrZMF2fdcwwksMk5g-1
X-Mimecast-MFC-AGG-ID: J-3Y6nrZMF2fdcwwksMk5g_1745337804
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 577EC195609D; Tue, 22 Apr 2025 16:03:24 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.105])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F264118001DA; Tue, 22 Apr 2025 16:03:20 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 15/37] vfio: Move Host IOMMU type declarations into their
 respective files
Date: Tue, 22 Apr 2025 18:02:02 +0200
Message-ID: <20250422160224.199714-16-clg@redhat.com>
In-Reply-To: <20250422160224.199714-1-clg@redhat.com>
References: <20250422160224.199714-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

These definitions don't have any use outside of their respective
submodules. There is no need to expose them externally. Keep them
private.

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250318095415.670319-15-clg@redhat.com
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-16-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h | 5 -----
 hw/vfio/container.c           | 2 ++
 hw/vfio/iommufd.c             | 3 +++
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index b2d4ff68650b205dca42ef00c7dfc7f2505b7e51..072b2c028f36234807c71b451a4e3c7caefa7f14 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -115,11 +115,6 @@ struct VFIODeviceOps {
     int (*vfio_load_config)(VFIODevice *vdev, QEMUFile *f);
 };
 
-
-#define TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO TYPE_HOST_IOMMU_DEVICE "-legacy-vfio"
-#define TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO \
-            TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
-
 void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
 void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
 void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index);
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 9b86e24a4072e579bcdc2c060ce42608ee44ee2e..9aa9f6931f591211e46f57029df2ca194f9c3eaf 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -34,6 +34,8 @@
 #include "pci.h"
 #include "hw/vfio/vfio-container.h"
 
+#define TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO TYPE_HOST_IOMMU_DEVICE "-legacy-vfio"
+
 typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
 static VFIOGroupList vfio_group_list =
     QLIST_HEAD_INITIALIZER(vfio_group_list);
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index a520d40afc00d79ae8617fd3c40433e228583b5a..2ec15bc2692e2eb90299e5a1c09ab6b738c69cf0 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -27,6 +27,9 @@
 #include "pci.h"
 #include "vfio-iommufd.h"
 
+#define TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO             \
+            TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
+
 static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly)
 {
-- 
2.49.0


