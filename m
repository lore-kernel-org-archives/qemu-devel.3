Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E339DC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEVB6-0006j4-0M; Mon, 12 May 2025 11:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9o-0004kX-5K
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:32 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9k-0006lF-QO
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:31 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9fnx026122;
 Mon, 12 May 2025 15:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=82rlGMPEEWXeCuNso4foFd8cLn89h1PlEeduY4R+CJg=; b=
 HBbNp5ung5hV8/27oHR9jzeWV/9rpZ/F6AwfrB1g6zZMl1Rv8m9G2poTHwkG4Asc
 LGwpOLP/WKB2SrtZhpOaWBnrqmyO3ZzhRZ/jDE3u1k+ZVR2EaUoNon6sFtNmGpDE
 gFm3Qeq2/HZtD2cc1LFu2MSki+7R2GUYmKoqOoVNJU9LBkv8Q/8HrZ8NSnS3oMVh
 SV3E/BV8KmTmsJYE4PdPN5S/OvCXQUJCLRLiiQ9LnI5+8v0hbDu8gWwMjyNJLF3Z
 Tb69j4oHORpvPNjDmX7a9OIjIZNMdGzA8iuqko+mgRpSuML/oMGaRTfDrpofBoj8
 yshb9jhrcthb3cVgG+4xBA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j11c2rbj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:24 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CE47Tm002436; Mon, 12 May 2025 15:33:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx366ue-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:23 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk5s030605;
 Mon, 12 May 2025 15:33:22 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-39; Mon, 12 May 2025 15:33:22 +0000
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
Subject: [PATCH V3 38/42] vfio/iommufd: reconstruct hw_caps
Date: Mon, 12 May 2025 08:32:49 -0700
Message-Id: <1747063973-124548-39-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfX9zAz5IgocEEb
 WtDKUjWHlizH6qn8m2cPnvmwDawy8XhSMhr7z4uIEUnIa1MA6crk0XtjgqTQ+QLW9dYxt+Mfiqg
 H/gpksjYlFYOlfxnh1j0GBpPSJWQYgHDndkw7KkGuB5pPx0/ga5Vv61ytuPm6mlGBsNiKXKv7P2
 HPDVZpe3ak9xmz91vAAzieOPpdE3EKVSN1h6rX4I4OODhKVuMZIyr0QPfByVJB/PzkTcs5I36ZK
 ruafYhb54j7TXB67tH3Xn7jbCMp39ZtGwKC/IK7tv1Kd7aFZpsVlS9h0kw/CnCr6eBtWQUR9Gvo
 6TyHZm7hKfp639W//vembthItoCSwZbcdUGrese1YYrJ0TaDzlol75XCxR8GrGVeGOg5k3PG/Ad
 3h8uOgiguUU+L/ntKux6v/f6sxZkyE7lAw0AMYyx4BlRAs0a+b5RCjDYvnHT5jciUuNXSkcN
X-Authority-Analysis: v=2.4 cv=YJ2fyQGx c=1 sm=1 tr=0 ts=682214c4 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=A-RYWJId-zWG7sgqZJoA:9
X-Proofpoint-GUID: oVDJCO0hizXMVqKK4qnrADAKf-M-yZvl
X-Proofpoint-ORIG-GUID: oVDJCO0hizXMVqKK4qnrADAKf-M-yZvl
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

hw_caps is normally derived during realize, at
vfio_device_hiod_create_and_realize -> hiod_iommufd_vfio_realize ->
iommufd_backend_get_device_info.  However, this depends on the devid, which
is not preserved during CPR.

Save devid in vmstate.  Defer the vfio_device_hiod_create_and_realize call
to post_load time, after devid has been recovered from vmstate.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/cpr-iommufd.c  | 15 +++++++++++++++
 hw/vfio/iommufd.c      |  6 ++----
 hw/vfio/vfio-iommufd.h |  3 +++
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
index 3d430f0..24cdf10 100644
--- a/hw/vfio/cpr-iommufd.c
+++ b/hw/vfio/cpr-iommufd.c
@@ -100,12 +100,27 @@ void vfio_iommufd_cpr_unregister_container(VFIOIOMMUFDContainer *container)
     migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
 }
 
+static int vfio_device_post_load(void *opaque, int version_id)
+{
+    VFIODevice *vbasedev = opaque;
+    Error *err = NULL;
+
+    if (!vfio_device_hiod_create_and_realize(vbasedev,
+                     TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO, &err)) {
+        error_report_err(err);
+        return false;
+    }
+    return true;
+}
+
 static const VMStateDescription vfio_device_vmstate = {
     .name = "vfio-iommufd-device",
     .version_id = 0,
     .minimum_version_id = 0,
+    .post_load = vfio_device_post_load,
     .needed = cpr_needed_for_reuse,
     .fields = (VMStateField[]) {
+        VMSTATE_INT32(devid, VFIODevice),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index c49a7e7..d980684 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -32,9 +32,6 @@
 #include "vfio-helpers.h"
 #include "vfio-listener.h"
 
-#define TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO             \
-            TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
-
 static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly)
 {
@@ -557,7 +554,8 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
 
     space = vfio_address_space_get(as);
 
-    if (!vfio_device_hiod_create_and_realize(vbasedev,
+    if (!vbasedev->cpr.reused &&
+        !vfio_device_hiod_create_and_realize(vbasedev,
             TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO, errp)) {
         goto err_alloc_ioas;
     }
diff --git a/hw/vfio/vfio-iommufd.h b/hw/vfio/vfio-iommufd.h
index cc57a05..148ce89 100644
--- a/hw/vfio/vfio-iommufd.h
+++ b/hw/vfio/vfio-iommufd.h
@@ -11,6 +11,9 @@
 
 #include "hw/vfio/vfio-container-base.h"
 
+#define TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO             \
+            TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
+
 typedef struct VFIODevice VFIODevice;
 
 typedef struct VFIOIOASHwpt {
-- 
1.8.3.1


