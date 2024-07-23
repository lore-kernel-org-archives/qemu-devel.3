Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB4CC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 14:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWG5B-00034k-F7; Tue, 23 Jul 2024 10:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sWG58-0002jO-NA
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:01:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sWG56-0003mg-TQ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721743292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L6LWwZ8d6VyWjINBiX1CtuubsP8TwW3ib6HhJI4FC6s=;
 b=CvHujRSrZohJ51tUL7+sDXnPE/Lzxe/Ycoc3h5jpW348oM9RvDI7/mvfq/7uzIJzGDrpnH
 N4BqOpb0+svcvAhjhZy6BXL2HrwsJnIBGJ9+x5eKyT9FP8KmF0dhRfPVD0C3SowMEpi8FQ
 PWQXkd2+0WtMwwkUhBy2tWZA9H+zMZQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-6-I4wl4FNtCfYLsNybey0Q-1; Tue,
 23 Jul 2024 10:00:57 -0400
X-MC-Unique: 6-I4wl4FNtCfYLsNybey0Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F36931944B2D; Tue, 23 Jul 2024 14:00:55 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.91])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C249A195605A; Tue, 23 Jul 2024 14:00:53 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL 13/16] vfio/iommufd: Implement
 VFIOIOMMUClass::set_dirty_tracking support
Date: Tue, 23 Jul 2024 16:00:16 +0200
Message-ID: <20240723140019.387786-14-clg@redhat.com>
In-Reply-To: <20240723140019.387786-1-clg@redhat.com>
References: <20240723140019.387786-1-clg@redhat.com>
MIME-Version: 1.0
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

ioctl(iommufd, IOMMU_HWPT_SET_DIRTY_TRACKING, arg) is the UAPI that
enables or disables dirty page tracking. The ioctl is used if the hwpt
has been created with dirty tracking supported domain (stored in
hwpt::flags) and it is called on the whole list of iommu domains.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 include/sysemu/iommufd.h |  2 ++
 backends/iommufd.c       | 23 +++++++++++++++++++++++
 hw/vfio/iommufd.c        | 32 ++++++++++++++++++++++++++++++++
 backends/trace-events    |  1 +
 4 files changed, 58 insertions(+)

diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
index e917e7591d050bd02945f6feb8d268e6d51d49aa..6fb412f61144e91ae02710291368ec9d577832f8 100644
--- a/include/sysemu/iommufd.h
+++ b/include/sysemu/iommufd.h
@@ -55,6 +55,8 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
                                 uint32_t data_type, uint32_t data_len,
                                 void *data_ptr, uint32_t *out_hwpt,
                                 Error **errp);
+bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
+                                        bool start, Error **errp);
 
 #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
 #endif
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 06b135111f303ca95d55dc0f71ad3bbb76211337..b9788350388481f449b1969366efa8d7766fc080 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -238,6 +238,29 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
     return true;
 }
 
+bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be,
+                                        uint32_t hwpt_id, bool start,
+                                        Error **errp)
+{
+    int ret;
+    struct iommu_hwpt_set_dirty_tracking set_dirty = {
+            .size = sizeof(set_dirty),
+            .hwpt_id = hwpt_id,
+            .flags = start ? IOMMU_HWPT_DIRTY_TRACKING_ENABLE : 0,
+    };
+
+    ret = ioctl(be->fd, IOMMU_HWPT_SET_DIRTY_TRACKING, &set_dirty);
+    trace_iommufd_backend_set_dirty(be->fd, hwpt_id, start, ret ? errno : 0);
+    if (ret) {
+        error_setg_errno(errp, errno,
+                         "IOMMU_HWPT_SET_DIRTY_TRACKING(hwpt_id %u) failed",
+                         hwpt_id);
+        return false;
+    }
+
+    return true;
+}
+
 bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
                                      uint32_t *type, void *data, uint32_t len,
                                      uint64_t *caps, Error **errp)
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 240c476eaf5b9b79090b6767c18316ade3b3b794..e39fbf4dd60a62321def4349fd727da335d82d8d 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -115,6 +115,37 @@ static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
     return hwpt && hwpt->hwpt_flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
 }
 
+static int iommufd_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
+                                           bool start, Error **errp)
+{
+    const VFIOIOMMUFDContainer *container =
+        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
+    VFIOIOASHwpt *hwpt;
+
+    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
+        if (!iommufd_hwpt_dirty_tracking(hwpt)) {
+            continue;
+        }
+
+        if (!iommufd_backend_set_dirty_tracking(container->be,
+                                                hwpt->hwpt_id, start, errp)) {
+            goto err;
+        }
+    }
+
+    return 0;
+
+err:
+    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
+        if (!iommufd_hwpt_dirty_tracking(hwpt)) {
+            continue;
+        }
+        iommufd_backend_set_dirty_tracking(container->be,
+                                           hwpt->hwpt_id, !start, NULL);
+    }
+    return -EINVAL;
+}
+
 static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
 {
     ERRP_GUARD();
@@ -739,6 +770,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
     vioc->attach_device = iommufd_cdev_attach;
     vioc->detach_device = iommufd_cdev_detach;
     vioc->pci_hot_reset = iommufd_cdev_pci_hot_reset;
+    vioc->set_dirty_page_tracking = iommufd_set_dirty_page_tracking;
 };
 
 static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
diff --git a/backends/trace-events b/backends/trace-events
index 4d8ac02fe7d6c6d3780dfef48406872ee46fd4df..28aca3b859d43f35511a95d6eba196046bfda835 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -16,3 +16,4 @@ iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t si
 iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
 iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
 iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
+iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
-- 
2.45.2


