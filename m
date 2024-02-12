Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB85C4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 13:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZWp8-0007ZX-Vv; Mon, 12 Feb 2024 08:58:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rZWoI-0006fx-5p
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 08:57:27 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rZWo7-0007FZ-Dm
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 08:57:18 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41CD4PK1019057; Mon, 12 Feb 2024 13:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=8K7Ud06VPXm69TMQsoAjMMYa+HU1h5r5mLzUbjebFGE=;
 b=LqFxF4YKV4JxprjYcdG8zEztCnaQwMxr7HWHouK33xdcyAro3J5zoPEGX9gyH04M6d2D
 WMJQ5FBSNZ82/DkMdZoBZQl8sxVB4RjFb/AroIloBnJJPvpUAOrwlslznCGJg/pOyINc
 HPlZ+PLHxfRVkURXQJU7ieGuFEd5IqDZeKBXwSIF9l2qi1oqSPrZ5j8KTxuPu0ucH9/M
 wKbLw2SLDqnabkqTx8UrTs8krk1UABtzI2ZjtNDbradn5UnP+gcPiA+f3qTM59Fn4mOG
 mEjkk1jXLVjcVKmidRlrXucyEVi9LGSG6I1eiJhomvV0hgASQc69wICzZuc8uBh/HpPO XA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7kw1g42w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Feb 2024 13:57:12 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41CDB4xI024619; Mon, 12 Feb 2024 13:57:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3w5ykc213q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Feb 2024 13:57:12 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CDuqiF026744;
 Mon, 12 Feb 2024 13:57:11 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-27-30.vpn.oracle.com
 [10.175.27.30])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3w5ykc20rs-7; Mon, 12 Feb 2024 13:57:11 +0000
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
Subject: [PATCH RFCv2 6/8] backends/iommufd: Add ability to disable hugepages
Date: Mon, 12 Feb 2024 13:56:41 +0000
Message-Id: <20240212135643.5858-7-joao.m.martins@oracle.com>
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
X-Proofpoint-GUID: Kv5VI4NtVXWM-NB-7FgKHEMac4pkcU_X
X-Proofpoint-ORIG-GUID: Kv5VI4NtVXWM-NB-7FgKHEMac4pkcU_X
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

Allow disabling hugepages to be dirty track at base page
granularity in similar vein to vfio_type1_iommu.disable_hugepages
but per IOAS.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 backends/iommufd.c       | 36 ++++++++++++++++++++++++++++++++++++
 backends/trace-events    |  1 +
 hw/vfio/iommufd.c        |  4 ++++
 include/sysemu/iommufd.h |  4 ++++
 qapi/qom.json            |  2 +-
 5 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index dd676d493c37..72fd98a9a50c 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -29,6 +29,7 @@ static void iommufd_backend_init(Object *obj)
     be->fd = -1;
     be->users = 0;
     be->owned = true;
+    be->hugepages = 1;
 }
 
 static void iommufd_backend_finalize(Object *obj)
@@ -63,6 +64,14 @@ static bool iommufd_backend_can_be_deleted(UserCreatable *uc)
     return !be->users;
 }
 
+static void iommufd_backend_set_hugepages(Object *obj, bool enabled,
+                                          Error **errp)
+{
+    IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
+
+    be->hugepages = enabled;
+}
+
 static void iommufd_backend_class_init(ObjectClass *oc, void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
@@ -70,6 +79,11 @@ static void iommufd_backend_class_init(ObjectClass *oc, void *data)
     ucc->can_be_deleted = iommufd_backend_can_be_deleted;
 
     object_class_property_add_str(oc, "fd", NULL, iommufd_backend_set_fd);
+
+    object_class_property_add_bool(oc, "hugepages", NULL,
+                                   iommufd_backend_set_hugepages);
+    object_class_property_set_description(oc, "hugepages",
+                                          "Set to 'off' to disable hugepages");
 }
 
 int iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
@@ -106,6 +120,28 @@ out:
     trace_iommufd_backend_disconnect(be->fd, be->users);
 }
 
+int iommufd_backend_set_option(int fd, uint32_t object_id,
+                               uint32_t option_id, uint64_t val64)
+{
+    int ret;
+    struct iommu_option option = {
+        .size = sizeof(option),
+        .option_id = option_id,
+        .op = IOMMU_OPTION_OP_SET,
+        .val64 = val64,
+        .object_id = object_id,
+    };
+
+    ret = ioctl(fd, IOMMU_OPTION, &option);
+    if (ret) {
+        error_report("Failed to set option %x to value %"PRIx64" %m", option_id,
+                     val64);
+    }
+    trace_iommufd_backend_set_option(fd, object_id, option_id, val64, ret);
+
+    return ret;
+}
+
 int iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
                                Error **errp)
 {
diff --git a/backends/trace-events b/backends/trace-events
index 11a27cb114b6..076166552881 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -15,6 +15,7 @@ iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t iova, u
 iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
 iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
 iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas, int ret) " iommufd=%d ioas=%d (%d)"
+iommufd_backend_set_option(int iommufd, uint32_t object_id, uint32_t option_id, uint64_t val, int ret) " iommufd=%d object_id=%u option_id=%u val64=0x%"PRIx64" (%d)"
 iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
 iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%d enable=%d (%d)"
 iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t page_size, int ret) " iommufd=%d hwpt=%d iova=0x%"PRIx64" size=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 79b13bd262cc..697d40841d7f 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -521,6 +521,10 @@ static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
         goto err_alloc_ioas;
     }
 
+    if (!vbasedev->iommufd_dev.iommufd->hugepages) {
+        iommufd_backend_set_option(vbasedev->iommufd_dev.iommufd->fd, ioas_id,
+                                   IOMMU_OPTION_HUGE_PAGES, 0);
+    }
     trace_iommufd_cdev_alloc_ioas(vbasedev->iommufd_dev.iommufd->fd, ioas_id);
 
     container = g_malloc0(sizeof(*container));
diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
index ba19b7ea4c19..bc6607e3d444 100644
--- a/include/sysemu/iommufd.h
+++ b/include/sysemu/iommufd.h
@@ -19,6 +19,7 @@ struct IOMMUFDBackend {
     /*< protected >*/
     int fd;            /* /dev/iommu file descriptor */
     bool owned;        /* is the /dev/iommu opened internally */
+    bool hugepages;    /* are hugepages enabled on the IOAS */
     uint32_t users;
 
     /*< public >*/
@@ -30,6 +31,9 @@ void iommufd_backend_disconnect(IOMMUFDBackend *be);
 int iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
                                Error **errp);
 void iommufd_backend_free_id(IOMMUFDBackend *be, uint32_t id);
+int iommufd_backend_set_option(int fd, uint32_t object_id,
+                               uint32_t option_id,
+                               uint64_t val64);
 int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly);
 int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
diff --git a/qapi/qom.json b/qapi/qom.json
index 84af23fe245d..9ad27e2b939b 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -809,7 +809,7 @@
 # Since: 9.0
 ##
 { 'struct': 'IOMMUFDProperties',
-  'data': { '*fd': 'str' } }
+  'data': { '*fd': 'str', '*hugepages': 'bool' } }
 
 ##
 # @RngProperties:
-- 
2.39.3


