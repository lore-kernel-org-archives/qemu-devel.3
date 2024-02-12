Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD737C48BC1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 13:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZWoV-0006tm-Hb; Mon, 12 Feb 2024 08:57:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rZWo9-0006Zc-Fe
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 08:57:18 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rZWo5-0007F3-AT
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 08:57:15 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41CD4MPB019025; Mon, 12 Feb 2024 13:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=UgpOaAovTeO1vDAdQ6kfN2u1nHhSjOolyDkJtfp+V2E=;
 b=G6OaRhTe+50IwwAntbWCncwoPaPcCg8ri4N/vNK2aCHAFwHxfluhIBz2xoIXrzCNEGvO
 6z5fv0zIkZMq6nUKiIEufIBr/bRAtrHYdLmCURHeVJC5gztQE9RD0NcHDrgDIWHEe9Aa
 1IDTugfc5QsAuDy/7oqY9Np5AlS5c9hvRXgeSBQatuSLgrRQthEM322sVW3YnLEhVQA0
 tWINAnK3yVgUh5111tZ2YYSQBiP5zoeVzU8qVo+Hc2kBDv1KPkc8wYdJ6RSja/tKDOvk
 44HmHNtvBym8mAzhcOoOq5jUiDDmQsXjatoP4nNrFSDHt62K+BXOTxUiZW7ECDWrK1Oj yA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7kw1g42p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Feb 2024 13:57:09 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41CDS3JM024776; Mon, 12 Feb 2024 13:57:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3w5ykc2122-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Feb 2024 13:57:09 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CDuqiD026744;
 Mon, 12 Feb 2024 13:57:08 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-27-30.vpn.oracle.com
 [10.175.27.30])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3w5ykc20rs-6; Mon, 12 Feb 2024 13:57:08 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH RFCv2 5/8] vfio/iommufd: Implement
 VFIOIOMMUClass::query_dirty_bitmap support
Date: Mon, 12 Feb 2024 13:56:40 +0000
Message-Id: <20240212135643.5858-6-joao.m.martins@oracle.com>
In-Reply-To: <20240212135643.5858-1-joao.m.martins@oracle.com>
References: <20240212135643.5858-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_10,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402120105
X-Proofpoint-GUID: ylsCExZkejUxexDwlQQ0CDPDCC0cXTXX
X-Proofpoint-ORIG-GUID: ylsCExZkejUxexDwlQQ0CDPDCC0cXTXX
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

ioctl(iommufd, IOMMU_HWPT_GET_DIRTY_BITMAP, arg) is the UAPI
that fetches the bitmap that tells what was dirty in an IOVA
range.

A single bitmap is allocated and used across all the hwpts
sharing an IOAS which is then used in log_sync() to set Qemu
global bitmaps.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 backends/iommufd.c       | 24 ++++++++++++++++++++++++
 backends/trace-events    |  1 +
 hw/vfio/iommufd.c        | 30 ++++++++++++++++++++++++++++++
 include/sysemu/iommufd.h |  3 +++
 4 files changed, 58 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 954de61c2da0..dd676d493c37 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -259,6 +259,30 @@ int iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
     return !ret ? 0 : -errno;
 }
 
+int iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
+                                     uint64_t iova, ram_addr_t size,
+                                     uint64_t page_size, uint64_t *data)
+{
+    int ret;
+    struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap = {
+        .size = sizeof(get_dirty_bitmap),
+        .hwpt_id = hwpt_id,
+        .iova = iova, .length = size,
+        .page_size = page_size, .data = (uintptr_t)data,
+    };
+
+    ret = ioctl(be->fd, IOMMU_HWPT_GET_DIRTY_BITMAP, &get_dirty_bitmap);
+    trace_iommufd_backend_get_dirty_bitmap(be->fd, hwpt_id, iova, size,
+                                           page_size, ret);
+    if (ret) {
+        error_report("IOMMU_HWPT_GET_DIRTY_BITMAP (iova: 0x%"PRIx64
+                     " size: 0x%"PRIx64") failed: %s", iova,
+                     size, strerror(errno));
+    }
+
+    return !ret ? 0 : -errno;
+}
+
 static const TypeInfo iommufd_backend_info = {
     .name = TYPE_IOMMUFD_BACKEND,
     .parent = TYPE_OBJECT,
diff --git a/backends/trace-events b/backends/trace-events
index feba2baca5f7..11a27cb114b6 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -17,3 +17,4 @@ iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_
 iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas, int ret) " iommufd=%d ioas=%d (%d)"
 iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
 iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%d enable=%d (%d)"
+iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t page_size, int ret) " iommufd=%d hwpt=%d iova=0x%"PRIx64" size=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 361e659288fd..79b13bd262cc 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -25,6 +25,7 @@
 #include "qemu/cutils.h"
 #include "qemu/chardev_open.h"
 #include "pci.h"
+#include "exec/ram_addr.h"
 #include "migration/migration.h"
 
 static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
@@ -142,6 +143,34 @@ err:
     return ret;
 }
 
+static int iommufd_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
+                                      VFIOBitmap *vbmap, uint64_t iova,
+                                      uint64_t size)
+{
+    VFIOIOMMUFDContainer *container = container_of(bcontainer,
+                                                   VFIOIOMMUFDContainer,
+                                                   bcontainer);
+    int ret;
+    VFIOIOASHwpt *hwpt;
+    unsigned long page_size;
+
+    if (!bcontainer->dirty_pages_supported) {
+        return 0;
+    }
+
+    page_size = qemu_real_host_page_size();
+    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
+        ret = iommufd_backend_get_dirty_bitmap(container->be, hwpt->hwpt_id,
+                                               iova, size, page_size,
+                                               vbmap->bitmap);
+        if (ret) {
+            break;
+        }
+    }
+
+    return ret;
+}
+
 static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
 {
     long int ret = -ENOTTY;
@@ -765,6 +794,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
     vioc->pci_hot_reset = iommufd_cdev_pci_hot_reset;
     vioc->host_iommu_device_init = vfio_cdev_host_iommu_device_init;
     vioc->set_dirty_page_tracking = iommufd_set_dirty_page_tracking;
+    vioc->query_dirty_bitmap = iommufd_query_dirty_bitmap;
 };
 
 static const TypeInfo types[] = {
diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
index 562c189dd92c..ba19b7ea4c19 100644
--- a/include/sysemu/iommufd.h
+++ b/include/sysemu/iommufd.h
@@ -55,5 +55,8 @@ int iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id,
                                void *data_ptr, uint32_t *out_hwpt);
 int iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
                                        bool start);
+int iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
+                                     uint64_t iova, ram_addr_t size,
+                                     uint64_t page_size, uint64_t *data);
 
 #endif
-- 
2.39.3


