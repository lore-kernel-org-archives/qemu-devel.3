Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E50C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 11:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSEkn-00069j-5B; Fri, 12 Jul 2024 07:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sSEkd-0005aI-1M
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 07:47:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sSEkZ-0007qX-Hr
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 07:47:46 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46C1BY8T020921;
 Fri, 12 Jul 2024 11:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=E
 uP+9tx4Z2mEPUkxDDMNgGgs5n4zxPOhxuAcR4g1PNg=; b=MC2h4KyQOnNyqcqE+
 QQyLdLQ9dZX4HrcSAdKr3g0fin7X+6HaahWHmHijZyem6JuCpTKjl5OMc1B48DKo
 Nqha8tsgV3wBsr6AyWRRZ3a03auu+6i++TeLuCV9bmk9EzlOGjwJZCWvxMhOv3pk
 4d9W3oKyWSGOlMNWhdhsUAQVgXyMKpdf2F8qZIKLB98cbGhzCIebHY+r+J4PUKYF
 +y+NOiEjtVP9+gyWn73CbBaWYQRAkXAAmclKZ/lx4O+X85LLgVcN051h014zMuFG
 lj66sILUUmhSeW0ucQI1kDbi46IJZ8oOqizEpaM8/3El/En+X9TeDmM7X6s85az0
 x81UA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 407emt30au-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jul 2024 11:47:38 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46CBVCmh022685; Fri, 12 Jul 2024 11:47:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 409vv3pq8q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jul 2024 11:47:37 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46CBlCCk008041;
 Fri, 12 Jul 2024 11:47:37 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-0-59.vpn.oracle.com
 [10.175.0.59])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 409vv3ppxv-10; Fri, 12 Jul 2024 11:47:36 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v4 09/12] vfio/iommufd: Implement
 VFIOIOMMUClass::set_dirty_tracking support
Date: Fri, 12 Jul 2024 12:47:01 +0100
Message-Id: <20240712114704.8708-10-joao.m.martins@oracle.com>
In-Reply-To: <20240712114704.8708-1-joao.m.martins@oracle.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_08,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407120080
X-Proofpoint-GUID: 6XW-QbcQGThaYXj5oN6jvqLmDTd1WBFb
X-Proofpoint-ORIG-GUID: 6XW-QbcQGThaYXj5oN6jvqLmDTd1WBFb
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

ioctl(iommufd, IOMMU_HWPT_SET_DIRTY_TRACKING, arg) is the UAPI that
enables or disables dirty page tracking. It is used if the hwpt
has been created with dirty tracking supported domain (stored in
hwpt::flags) and it is called on the whole list of iommu domains
it is are tracking. On failure it rolls it back.

The checking of hwpt::flags is introduced here as a second user
and thus consolidate such check into a helper function
iommufd_hwpt_dirty_tracking().

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 include/sysemu/iommufd.h |  3 +++
 backends/iommufd.c       | 23 +++++++++++++++++++++++
 hw/vfio/iommufd.c        | 39 ++++++++++++++++++++++++++++++++++++++-
 backends/trace-events    |  1 +
 4 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
index e917e7591d05..7416d9219703 100644
--- a/include/sysemu/iommufd.h
+++ b/include/sysemu/iommufd.h
@@ -55,6 +55,9 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
                                 uint32_t data_type, uint32_t data_len,
                                 void *data_ptr, uint32_t *out_hwpt,
                                 Error **errp);
+bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
+                                        bool start, Error **errp);
 
 #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
+
 #endif
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 41a9dec3b2c5..239f0976e0ad 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -239,6 +239,29 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
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
+            .flags = !start ? 0 : IOMMU_HWPT_DIRTY_TRACKING_ENABLE,
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
index edc8f97d8f3d..da678315faeb 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -110,6 +110,42 @@ static void iommufd_cdev_unbind_and_disconnect(VFIODevice *vbasedev)
     iommufd_backend_disconnect(vbasedev->iommufd);
 }
 
+static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
+{
+    return hwpt->hwpt_flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
+}
+
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
@@ -278,7 +314,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
     QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
     QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
     container->bcontainer.dirty_pages_supported |=
-                              (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING);
+                              iommufd_hwpt_dirty_tracking(hwpt);
     return true;
 }
 
@@ -717,6 +753,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
     vioc->attach_device = iommufd_cdev_attach;
     vioc->detach_device = iommufd_cdev_detach;
     vioc->pci_hot_reset = iommufd_cdev_pci_hot_reset;
+    vioc->set_dirty_page_tracking = iommufd_set_dirty_page_tracking;
 };
 
 static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
diff --git a/backends/trace-events b/backends/trace-events
index 4d8ac02fe7d6..28aca3b859d4 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -16,3 +16,4 @@ iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t si
 iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
 iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
 iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
+iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
-- 
2.17.2


