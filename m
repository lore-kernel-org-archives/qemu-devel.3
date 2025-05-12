Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F05C3ABD7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEVBM-0007r4-2d; Mon, 12 May 2025 11:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9n-0004gT-52
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:31 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9j-0006kj-Id
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:30 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9eMc024087;
 Mon, 12 May 2025 15:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=Xjobk/1rJ3vJrWSw7VJO1OEKbtazDfI4eEjd0ljfGB8=; b=
 E9IXucGe7JUvbKRFLJxug6ECQl3eE8dZOTLFHi/U/sQlsOWsjDh03whKS8a/PpxQ
 0pNOA0bDctozBzvJatqMhx9BOMpopmM6BCG6YNwDlpMGpoKnX4mPSRZhMOPDSO8b
 S7QrDw9NHIEGWw0wbHuzwd/ywUFP2zx6lmAjtytgwiYdq2xFaf8a8VP7vv3VZ3JE
 FQKoZuHE9sr7ggocy4WxZ+PINBnYFkoF4HJIdx74Ox0SilTgHMD5sVRxfSRv0F52
 pyuHwNRqm0f6RutePCjJv577UZVGxwqPmHQ2IrfVvewZyy4yANzUPH+SM/tiHrNU
 SoSnhU0wzswu6WxjzfJ30A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j1d2aqs3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:23 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CE7gRv002441; Mon, 12 May 2025 15:33:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx366tx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:22 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk5q030605;
 Mon, 12 May 2025 15:33:22 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-38; Mon, 12 May 2025 15:33:22 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 37/42] vfio/iommufd: reconstruct device
Date: Mon, 12 May 2025 08:32:48 -0700
Message-Id: <1747063973-124548-38-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_05,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505120161
X-Proofpoint-ORIG-GUID: vnjMeyOmgHLulbCnrRMQYrgVwKFu5HqU
X-Proofpoint-GUID: vnjMeyOmgHLulbCnrRMQYrgVwKFu5HqU
X-Authority-Analysis: v=2.4 cv=XNcwSRhE c=1 sm=1 tr=0 ts=682214c3 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=BM63Ccodv5DQBdYdqMgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfXx9eqhwCsrW4r
 GkyWXUCEPBsbUKAcz+a5ytvHW1Ip6xpu33/lHZ7aiyrOH4o3DRHuZ+bwMM0y8jWr0TjY1mUiuzE
 hFCFgOKM61zxFViJJq33aQBhC+aiq4bcPd7cG+hvLtbCc+WJXkTMWp8LVqqja+36tPY7cFzTQkY
 9U7540vrZF0wUECRQV7OWtoBr5FVTvYdPZzx9f5S55RN75LbjtwqcC/qbFs3VJihMJwJLnDOJNc
 hySF+OUJhRY2fWTY/OwTIZ8swLZPnlNQep0xl68neZbHMsxXwi33Wo8CDb46nJweE/Tai9qpd9G
 qgeoxYh/pbgxmIrCRlIqP3TKcgWMU18LRzcoEPDlzI+NELNTXdctxTNQT2AB0Vco6p9nOkiPgtk
 KiNIxIM6GQRTgXmuUDeMFUry7WMR1/8GXZqNdyh5ZD2XN5txXZnshjX8hkRLeThu7THhM3oN
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reconstruct userland device state after CPR.  During vfio_realize, skip
all ioctls that configure the device, as it was already configured in old
QEMU.

Save the ioas_id in vmstate, and skip its allocation in vfio_realize.
Because we skip ioctl's, it is not needed at realize time.  However, we do
need the range info, so defer the call to iommufd_cdev_get_info_iova_range
to a post_load handler, at which time the ioas_id is known.

This reconstruction is not complete.  hwpt_id and devid need special
treatment, handled in subsequent patches.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/cpr-iommufd.c |  8 ++++++++
 hw/vfio/iommufd.c     | 17 +++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
index b760bd3..3d430f0 100644
--- a/hw/vfio/cpr-iommufd.c
+++ b/hw/vfio/cpr-iommufd.c
@@ -31,6 +31,13 @@ static int vfio_container_post_load(void *opaque, int version_id)
     VFIOIOMMUFDContainer *container = opaque;
     VFIOContainerBase *bcontainer = &container->bcontainer;
     VFIODevice *vbasedev;
+    Error *err = NULL;
+    uint32_t ioas_id = container->ioas_id;
+
+    if (!iommufd_cdev_get_info_iova_range(container, ioas_id, &err)) {
+        error_report_err(err);
+        return -1;
+    }
 
     QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
         vbasedev->cpr.reused = false;
@@ -47,6 +54,7 @@ static const VMStateDescription vfio_container_vmstate = {
     .post_load = vfio_container_post_load,
     .needed = cpr_needed_for_reuse,
     .fields = (VMStateField[]) {
+        VMSTATE_UINT32(ioas_id, VFIOIOMMUFDContainer),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 046f601..c49a7e7 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -122,6 +122,10 @@ static bool iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
         goto err_kvm_device_add;
     }
 
+    if (vbasedev->cpr.reused) {
+        goto skip_bind;
+    }
+
     /* Bind device to iommufd */
     bind.iommufd = iommufd->fd;
     if (ioctl(vbasedev->fd, VFIO_DEVICE_BIND_IOMMUFD, &bind)) {
@@ -133,6 +137,8 @@ static bool iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
     vbasedev->devid = bind.out_devid;
     trace_iommufd_cdev_connect_and_bind(bind.iommufd, vbasedev->name,
                                         vbasedev->fd, vbasedev->devid);
+
+skip_bind:
     return true;
 err_bind:
     iommufd_cdev_kvm_device_del(vbasedev);
@@ -580,6 +586,11 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
         }
     }
 
+    if (vbasedev->cpr.reused) {
+        ioas_id = -1;           /* ioas_id will be received from vmstate */
+        goto skip_ioas_alloc;
+    }
+
     /* Need to allocate a new dedicated container */
     if (!iommufd_backend_alloc_ioas(vbasedev->iommufd, &ioas_id, errp)) {
         goto err_alloc_ioas;
@@ -587,6 +598,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
 
     trace_iommufd_cdev_alloc_ioas(vbasedev->iommufd->fd, ioas_id);
 
+skip_ioas_alloc:
     container = VFIO_IOMMU_IOMMUFD(object_new(TYPE_VFIO_IOMMU_IOMMUFD));
     container->be = vbasedev->iommufd;
     container->ioas_id = ioas_id;
@@ -605,6 +617,10 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
         goto err_discard_disable;
     }
 
+    if (vbasedev->cpr.reused) {
+        goto skip_info;
+    }
+
     if (!iommufd_cdev_get_info_iova_range(container, ioas_id, &err)) {
         error_append_hint(&err,
                    "Fallback to default 64bit IOVA range and 4K page size\n");
@@ -613,6 +629,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
         bcontainer->pgsizes = qemu_real_host_page_size();
     }
 
+skip_info:
     if (!vfio_listener_register(bcontainer, errp)) {
         goto err_listener_register;
     }
-- 
1.8.3.1


