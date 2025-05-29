Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A7BC54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKisq-0004Ko-CC; Thu, 29 May 2025 15:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisR-0004Di-90
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:19 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisP-0000TV-7w
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:18 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGftwA022112;
 Thu, 29 May 2025 19:25:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=hpVtungQHhhkp1Mii5aQcMk6lw3ZqoRrYyM6nOxH5FQ=; b=
 du1I5AnNYYbVPSllbPYbnuc8Fy7zhO9r7SvbxlpGlpFDueiAgfhY1nLUC7gwoZ1s
 H+9WKJkZhC9e8PCy9qmpk7D0zGIWjIjErDmhodY8nv/eAHnyx+T6ptvHBBtUSU1A
 zALQ9udg2PtJlKu0v18QQAlrfoIZrWPO2bIGn0bM8uHr7zIPp77Wpen3wt7S5YHE
 X/gEymzcKbTRf9pa4K90Xw0x7IufSdnz1MvyHJNe3orJiK3lMAqpDoKAd6vEhJOU
 h4JRkddAB2/02sUb+wn4iHuBp1T+ol88DmAXaMqkc4ML1Spq+mdYWYMAA80FrKKt
 FBDceb/Xwjdy/RENL7ZtaQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0g2h18c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:14 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54THl0S3020325; Thu, 29 May 2025 19:25:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4w9j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:13 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeS5022158;
 Thu, 29 May 2025 19:25:13 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-40; Thu, 29 May 2025 19:25:12 +0000
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
Subject: [PATCH V4 39/43] vfio/iommufd: reconstruct device
Date: Thu, 29 May 2025 12:24:35 -0700
Message-Id: <1748546679-154091-40-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_09,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290189
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfX6d2sM4AncGhq
 TI5BR5+GHpNVDV/AxZHpser9kmWUXG2rKCdnV/J+BkIjjwTkDV+DJvpFsuwFFNSmgxog6nhGj4f
 he6Y6Y8z1pD8P7OVz70r93pfz0MQEnZjd7TB90EvQbT9OFkmgMisweOl9atXT31+r1gCypDhOuF
 AW0KJjE6ipSUFbJHTsXPoFREwfJVafTrNsXlZH4e+OIpJFM/7g1XXE4WbcvWbWDkcrMVsU7y8/M
 i2WglgJ3BAHaiINIHpNht1/wjqgAgnGc4ApLbDGjpp/3kOHwoJsYOEm+HvSoKy8VHj2csunP2oQ
 YzBoIXFNzaF7w5f+nuka54Si6r/pZh2BA7/2s5nNJRXb/z9A6WXu1H4t0/XSyBzMYBEr4BZcddE
 nWaxYRBd877t3Hd7+ia5wZ7AQesrDuKLMQQHCO5nxFTIrxKS/Ln6rPm4B8B5qWtF8XHRq7x9
X-Authority-Analysis: v=2.4 cv=NJLV+16g c=1 sm=1 tr=0 ts=6838b49a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=ftf5knHnZ1C_9xVUNSsA:9
X-Proofpoint-ORIG-GUID: t7__xzCwuCxnj8e2nb7cVQMAAVbg6pYg
X-Proofpoint-GUID: t7__xzCwuCxnj8e2nb7cVQMAAVbg6pYg
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

Reconstruct userland device state after CPR.  During vfio_realize, skip all
ioctls that configure the device, as it was already configured in old QEMU.

Skip bind, and use the devid from CPR state.

Skip allocation of, and attachment to, ioas_id.  Recover ioas_id from CPR
state, and use it to find a matching container, if any, before creating a
new one.

This reconstruction is not complete.  hwpt_id is handled in a subsequent
patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/iommufd.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 1fd383e..5119c17 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -25,6 +25,7 @@
 #include "system/reset.h"
 #include "qemu/cutils.h"
 #include "qemu/chardev_open.h"
+#include "migration/cpr.h"
 #include "pci.h"
 #include "vfio-iommufd.h"
 #include "vfio-helpers.h"
@@ -121,6 +122,10 @@ static bool iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
         goto err_kvm_device_add;
     }
 
+    if (cpr_is_incoming()) {
+        goto skip_bind;
+    }
+
     /* Bind device to iommufd */
     bind.iommufd = iommufd->fd;
     if (ioctl(vbasedev->fd, VFIO_DEVICE_BIND_IOMMUFD, &bind)) {
@@ -132,6 +137,8 @@ static bool iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
     vbasedev->devid = bind.out_devid;
     trace_iommufd_cdev_connect_and_bind(bind.iommufd, vbasedev->name,
                                         vbasedev->fd, vbasedev->devid);
+
+skip_bind:
     return true;
 err_bind:
     iommufd_cdev_kvm_device_del(vbasedev);
@@ -421,7 +428,9 @@ static bool iommufd_cdev_attach_container(VFIODevice *vbasedev,
         return iommufd_cdev_autodomains_get(vbasedev, container, errp);
     }
 
-    return !iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id, errp);
+    /* If CPR, we are already attached to ioas_id. */
+    return cpr_is_incoming() ||
+           !iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id, errp);
 }
 
 static void iommufd_cdev_detach_container(VFIODevice *vbasedev,
@@ -510,6 +519,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
     VFIOAddressSpace *space;
     struct vfio_device_info dev_info = { .argsz = sizeof(dev_info) };
     int ret, devfd;
+    bool res;
     uint32_t ioas_id;
     Error *err = NULL;
     const VFIOIOMMUClass *iommufd_vioc =
@@ -540,7 +550,16 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
             vbasedev->iommufd != container->be) {
             continue;
         }
-        if (!iommufd_cdev_attach_container(vbasedev, container, &err)) {
+
+        if (!cpr_is_incoming()) {
+            res = iommufd_cdev_attach_container(vbasedev, container, &err);
+        } else if (vbasedev->cpr.ioas_id == container->ioas_id) {
+            res = true;
+        } else {
+            continue;
+        }
+
+        if (!res) {
             const char *msg = error_get_pretty(err);
 
             trace_iommufd_cdev_fail_attach_existing_container(msg);
@@ -557,6 +576,11 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
         }
     }
 
+    if (cpr_is_incoming()) {
+        ioas_id = vbasedev->cpr.ioas_id;
+        goto skip_ioas_alloc;
+    }
+
     /* Need to allocate a new dedicated container */
     if (!iommufd_backend_alloc_ioas(vbasedev->iommufd, &ioas_id, errp)) {
         goto err_alloc_ioas;
@@ -564,10 +588,12 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
 
     trace_iommufd_cdev_alloc_ioas(vbasedev->iommufd->fd, ioas_id);
 
+skip_ioas_alloc:
     container = VFIO_IOMMU_IOMMUFD(object_new(TYPE_VFIO_IOMMU_IOMMUFD));
     container->be = vbasedev->iommufd;
     container->ioas_id = ioas_id;
     QLIST_INIT(&container->hwpt_list);
+    vbasedev->cpr.ioas_id = ioas_id;
 
     bcontainer = &container->bcontainer;
     vfio_address_space_insert(space, bcontainer);
-- 
1.8.3.1


