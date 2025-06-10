Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C4EC71130
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP2Ae-0001Ap-0w; Tue, 10 Jun 2025 12:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15n-0004Z2-At
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:52 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15l-0006Fd-H4
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:51 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEXZqH006965;
 Tue, 10 Jun 2025 15:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=T4aMHOiKKYHUKjGyPhRmkBqvOKsha5fwTb3PdZzrq7o=; b=
 LbwElNI1vDhG7P7NXaN20ew1FUxS0xfDfKRLLvWFpKhLxDoShXPEPeFJvtfupYsI
 DayCf5IchD1ir+pH6k8tRCXWS7C4DAV4PcFlHwddsEyvm64XPe1Uhg0VZeAATWBY
 e/COWZleSnkSjrskWFHxqY/JUHKByHlTLEYnBRobwmyZ9c8ZnXZ+a/1FCbacIDqO
 mAZmYkYtpntTMEV/DsAeJeIg/TjKgjD+fWKlWrSNouFlf29S9Mga8XdUy07h5/8/
 OkXPGFPC9b1wJnWDfPms5BAUVkF0TRG2qJhgX/cYGjk8J8+kzhhZNopQCEDGyOGB
 9ZYJBGXUb9LD25/6impizQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c74vjra-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:45 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55AEfgqo003281; Tue, 10 Jun 2025 15:40:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bv8wbyu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:45 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55AFdrgD028825;
 Tue, 10 Jun 2025 15:40:44 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 474bv8wak1-34; Tue, 10 Jun 2025 15:40:44 +0000
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
Subject: [PATCH V5 33/38] vfio/iommufd: reconstruct device
Date: Tue, 10 Jun 2025 08:39:46 -0700
Message-Id: <1749569991-25171-34-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100125
X-Authority-Analysis: v=2.4 cv=LIpmQIW9 c=1 sm=1 tr=0 ts=684851fd b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=ftf5knHnZ1C_9xVUNSsA:9 cc=ntf
 awl=host:14714
X-Proofpoint-ORIG-GUID: bNiUTVI20qwDhDF96BJEh66P3q1WDEDq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEyNiBTYWx0ZWRfX/tEjxzPcVZMu
 7as1/YfLNtbg99Lgta487GAqONuGfotXFWoyVVksOUAtH6VYSLu2K24tGuimK7RwVWKMX90wF+T
 /XinuPhpawsfeHdQn8mnV2i9ggxTTDlzF1SYgv+GEiF5VcvJyuc8xMZysB9j65+JwUAF2pFzo8Y
 G9+QmAQZXKgr3pbaPTy9JFglNis0PX4FE4O9i7l0ZRJtAQsnGlNwUuGFL4+2spKrN1avACM3wEH
 LELKbIYyZRvcyMcvazfycE9bu/dr54sF9NvcdKJeXuDYf+YyBs12+wpk1kwAiCyoTY4pEl4kLDN
 XQAbOzzzJfUdyV8XE5VgbM2YFhi1VWsH95IapwwE9u7Zu5ZcOywIHhBCymXNqD/cLWAJvpgFBwJ
 KlNJmuoEiaJ//k1BrjgQUTkfY+ssLnvn1hGWd8WgKJFGSZZgl+PSZRWepsElr/ui4wGt3wsj
X-Proofpoint-GUID: bNiUTVI20qwDhDF96BJEh66P3q1WDEDq
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
index f0d57ea..a650517 100644
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


