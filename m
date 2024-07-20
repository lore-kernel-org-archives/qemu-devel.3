Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD90C3DA49
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 19:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVFZA-0007BH-Ls; Sat, 20 Jul 2024 15:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVFYx-0006qA-MM
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:16:14 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVFYk-0000rP-Sl
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:16:07 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46KJFiNR017251;
 Sat, 20 Jul 2024 19:15:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=PXLtbP39VoPZ9SgE3nPBLw9XhUEMVA2a59Rjc1/ZxJQ=; b=
 RTBuJ50/RLvFX5kkE1w1bfnf1Nk23JPep4i6pVRa99r8ZoYefuIuqxFoYF63fwja
 Oz9I27/bDxOxfSO1cCQppGc6MDNixAvMdi6slHP31h2XAI+4c9b1PBF73txjgSPY
 GLja6Z56gIyBpfkAvbm+3jb2LkYmB2e/KPMNSZ3x9JNqkQ86FrOfXzN8pX2aD97v
 DiI8i3G/3lSqECGAb5SXbzToI0Ze9ci4W/cDqxN3A0cKyi4mub2vFvkK5foSLYSw
 7nHYb+xPlcBzLrfMDMYa+Zc9xJbu3E174bWZM0k7TeiADYFah8g/OEAZPBSU0NWH
 1fzwyyJ3KFRCc+xM516PaA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40gk7w000f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 19:15:52 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46KGUQZE027514; Sat, 20 Jul 2024 19:15:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40g3p5puvx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 19:15:52 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46KJFdfJ028365;
 Sat, 20 Jul 2024 19:15:51 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 40g3p5pusv-10; Sat, 20 Jul 2024 19:15:51 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 09/12] vfio/iommufd: rebuild device
Date: Sat, 20 Jul 2024 12:15:34 -0700
Message-Id: <1721502937-87102-10-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1721502937-87102-1-git-send-email-steven.sistare@oracle.com>
References: <1721502937-87102-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-20_16,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407200140
X-Proofpoint-ORIG-GUID: seeqehVg5KQJEa7glOrPghQDQuQg9jVz
X-Proofpoint-GUID: seeqehVg5KQJEa7glOrPghQDQuQg9jVz
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Rebuild userland device state after CPR.  During vfio_realize, skip all
ioctls that configure the device, as it was already configured in old
QEMU, and we preserved the device descriptor.

Preserve the ioas_id in vmstate.  Because we skip ioctl's, it is not needed
at realize time.  However, we do need to gather range info, so defer the
call to iommufd_cdev_get_info_iova_range to a post_load handler, at which
time the ioas_id is known.

Registering the vfio_memory_listener causes spurious calls to map and
unmap DMA, as devices are created and the address space is built.  This
memory was already already mapped by the device, so suppress map and unmap
during CPR -- eg, if the reused flag is set.  Clear the reused flag in the
post_load handler.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 backends/iommufd.c    |  8 ++++++++
 hw/vfio/cpr-iommufd.c | 24 ++++++++++++++++++++++++
 hw/vfio/iommufd.c     | 14 +++++++++++++-
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 243178e..86fd9db 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -172,6 +172,10 @@ int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
         .length = size,
     };
 
+    if (be->reused) {
+        return 0;
+    }
+
     if (!readonly) {
         map.flags |= IOMMU_IOAS_MAP_WRITEABLE;
     }
@@ -203,6 +207,10 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
         .length = size,
     };
 
+    if (be->reused) {
+        return 0;
+    }
+
     ret = ioctl(fd, IOMMU_IOAS_UNMAP, &unmap);
     /*
      * IOMMUFD takes mapping as some kind of object, unmapping
diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
index f2e34f4..c38485a 100644
--- a/hw/vfio/cpr-iommufd.c
+++ b/hw/vfio/cpr-iommufd.c
@@ -27,12 +27,36 @@ static bool vfio_can_cpr_exec(VFIOIOMMUFDContainer *container, Error **errp)
     return true;
 }
 
+static int vfio_container_post_load(void *opaque, int version_id)
+{
+    VFIOIOMMUFDContainer *container = opaque;
+    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIODevice *vbasedev;
+    Error *err = NULL;
+    uint32_t ioas_id = container->ioas_id;
+
+    if (!iommufd_cdev_get_info_iova_range(container, ioas_id, &err)) {
+        error_report_err(err);
+        return -1;
+    }
+
+    bcontainer->reused = false;
+    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
+        vbasedev->reused = false;
+    }
+    container->be->reused = false;
+
+    return 0;
+}
+
 static const VMStateDescription vfio_container_vmstate = {
     .name = "vfio-iommufd-container",
     .version_id = 0,
     .minimum_version_id = 0,
+    .post_load = vfio_container_post_load,
     .needed = cpr_needed_for_reuse,
     .fields = (VMStateField[]) {
+        VMSTATE_UINT32(ioas_id, VFIOIOMMUFDContainer),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 585bf09..186edc7 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -357,6 +357,11 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
         }
     }
 
+    if (vbasedev->reused) {
+        ioas_id = -1;           /* ioas_id will be sent in vmstate */
+        goto skip_ioas_alloc;
+    }
+
     /* Need to allocate a new dedicated container */
     if (!iommufd_backend_alloc_ioas(vbasedev->iommufd, &ioas_id, errp)) {
         goto err_alloc_ioas;
@@ -364,6 +369,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
 
     trace_iommufd_cdev_alloc_ioas(vbasedev->iommufd->fd, ioas_id);
 
+skip_ioas_alloc:
     container = VFIO_IOMMU_IOMMUFD(object_new(TYPE_VFIO_IOMMU_IOMMUFD));
     container->be = vbasedev->iommufd;
     container->ioas_id = ioas_id;
@@ -371,7 +377,8 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
     bcontainer = &container->bcontainer;
     vfio_address_space_insert(space, bcontainer);
 
-    if (!iommufd_cdev_attach_container(vbasedev, container, errp)) {
+    if (!vbasedev->reused &&
+        !iommufd_cdev_attach_container(vbasedev, container, errp)) {
         goto err_attach_container;
     }
 
@@ -380,6 +387,10 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
         goto err_discard_disable;
     }
 
+    if (vbasedev->reused) {
+        goto skip_info;
+    }
+
     if (!iommufd_cdev_get_info_iova_range(container, ioas_id, &err)) {
         error_append_hint(&err,
                    "Fallback to default 64bit IOVA range and 4K page size\n");
@@ -388,6 +399,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
         bcontainer->pgsizes = qemu_real_host_page_size();
     }
 
+skip_info:
     bcontainer->listener = vfio_memory_listener;
     memory_listener_register(&bcontainer->listener, bcontainer->space->as);
 
-- 
1.8.3.1


