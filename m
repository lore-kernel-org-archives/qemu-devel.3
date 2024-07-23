Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606B7C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 14:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWG4g-0000xq-6x; Tue, 23 Jul 2024 10:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sWG4Z-0000YG-Bj
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:01:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sWG4X-0003he-Mp
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721743257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/1GpTRvIzXhRFqPza1TSDlQxajbX3soGdn+1SqqLOtI=;
 b=M6AaBmuzKHs2EyU1Wm7Vq0/OtI6fMKrYPcDHJuXXBbbXbvjWT8rUsi93vkO+GS3T8ppcHE
 gSH5ibA3XCLGkx8OMbJPFSJOECGv3EXxHE+fBnOIbJ4G3zbbsJK4v6dSNafzrNjDDQrPjY
 MiJUl6ikZpZBrNk6xk8gck9kdTIkqfY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-ESDd5u5LOY-0g6-wFy-HTA-1; Tue,
 23 Jul 2024 10:00:54 -0400
X-MC-Unique: ESDd5u5LOY-0g6-wFy-HTA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 625A419560AA; Tue, 23 Jul 2024 14:00:53 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.91])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B232B1955D45; Tue, 23 Jul 2024 14:00:51 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PULL 12/16] vfio/iommufd: Probe and request hwpt dirty tracking
 capability
Date: Tue, 23 Jul 2024 16:00:15 +0200
Message-ID: <20240723140019.387786-13-clg@redhat.com>
In-Reply-To: <20240723140019.387786-1-clg@redhat.com>
References: <20240723140019.387786-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

From: Joao Martins <joao.m.martins@oracle.com>

In preparation to using the dirty tracking UAPI, probe whether the IOMMU
supports dirty tracking. This is done via the data stored in
hiod::caps::hw_caps initialized from GET_HW_INFO.

Qemu doesn't know if VF dirty tracking is supported when allocating
hardware pagetable in iommufd_cdev_autodomains_get(). This is because
VFIODevice migration state hasn't been initialized *yet* hence it can't pick
between VF dirty tracking vs IOMMU dirty tracking. So, if IOMMU supports
dirty tracking it always creates HWPTs with IOMMU_HWPT_ALLOC_DIRTY_TRACKING
even if later on VFIOMigration decides to use VF dirty tracking instead.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
[ clg: - Fixed vbasedev->iommu_dirty_tracking assignment in
         iommufd_cdev_autodomains_get()
       - Added warning for heterogeneous dirty page tracking support
	 in iommufd_cdev_autodomains_get() ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h |  2 ++
 hw/vfio/iommufd.c             | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 4e44b26d3c453b5b47a819df371a21a4ca3b39c3..1e02c98b09babb6878fed1130cd1d6a00ac3641e 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -97,6 +97,7 @@ typedef struct IOMMUFDBackend IOMMUFDBackend;
 
 typedef struct VFIOIOASHwpt {
     uint32_t hwpt_id;
+    uint32_t hwpt_flags;
     QLIST_HEAD(, VFIODevice) device_list;
     QLIST_ENTRY(VFIOIOASHwpt) next;
 } VFIOIOASHwpt;
@@ -139,6 +140,7 @@ typedef struct VFIODevice {
     OnOffAuto pre_copy_dirty_page_tracking;
     bool dirty_pages_supported;
     bool dirty_tracking;
+    bool iommu_dirty_tracking;
     HostIOMMUDevice *hiod;
     int devid;
     IOMMUFDBackend *iommufd;
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 798c4798a55e0c839c5128b3cd9571356157dce9..240c476eaf5b9b79090b6767c18316ade3b3b794 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -110,6 +110,11 @@ static void iommufd_cdev_unbind_and_disconnect(VFIODevice *vbasedev)
     iommufd_backend_disconnect(vbasedev->iommufd);
 }
 
+static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
+{
+    return hwpt && hwpt->hwpt_flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
+}
+
 static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
 {
     ERRP_GUARD();
@@ -243,10 +248,22 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
         } else {
             vbasedev->hwpt = hwpt;
             QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
+            vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
             return true;
         }
     }
 
+    /*
+     * This is quite early and VFIO Migration state isn't yet fully
+     * initialized, thus rely only on IOMMU hardware capabilities as to
+     * whether IOMMU dirty tracking is going to be requested. Later
+     * vfio_migration_realize() may decide to use VF dirty tracking
+     * instead.
+     */
+    if (vbasedev->hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
+        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
+    }
+
     if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
                                     container->ioas_id, flags,
                                     IOMMU_HWPT_DATA_NONE, 0, NULL,
@@ -256,6 +273,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
 
     hwpt = g_malloc0(sizeof(*hwpt));
     hwpt->hwpt_id = hwpt_id;
+    hwpt->hwpt_flags = flags;
     QLIST_INIT(&hwpt->device_list);
 
     ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
@@ -266,8 +284,16 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
     }
 
     vbasedev->hwpt = hwpt;
+    vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
     QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
     QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
+    container->bcontainer.dirty_pages_supported |=
+                                vbasedev->iommu_dirty_tracking;
+    if (container->bcontainer.dirty_pages_supported &&
+        !vbasedev->iommu_dirty_tracking) {
+        warn_report("IOMMU instance for device %s doesn't support dirty tracking",
+                    vbasedev->name);
+    }
     return true;
 }
 
-- 
2.45.2


