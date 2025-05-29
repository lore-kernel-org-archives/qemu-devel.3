Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFA1C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKisq-0004L8-UD; Thu, 29 May 2025 15:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisR-0004Dn-Nv
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:19 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisQ-0000Te-1c
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:19 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfwxV003896;
 Thu, 29 May 2025 19:25:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=RUPU+p5R3zovx4aXmSFKcy70vmSFig/SCMfwIUf7W8c=; b=
 d8b6dFNhoIm2kEw4srWBxAvPhwOETU94Ghk7dpmOGNj+UOMsSAlGH1HO9GyqMHpc
 8s1PpNKDqrtkqNUyCFptVEBeJVdTHf3v/N3Z9byQwrOcA+WxFTNSsLwAunWc+xtE
 lL0QEMGwHMGbmnOl1xy+vAktBmQZN5sdhu5rlavZJ/i7MS99TgiFr2tGgfSVe8Ay
 nSer9y9H8cZmBuNLA45syZn2U22xg+JG44z3swNLuGNGV/nUBc3SMiitVwYux8s9
 kP8o+5NXTNMvpvDp0ILVdM3e3qB73njY0ecu0qWsXfOebXxN06pj6dqxT5q3+HpN
 iLCQde51+ebndgsfuRVcbw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v2pf0n0t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:15 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54TJKdNu020323; Thu, 29 May 2025 19:25:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4wab-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:14 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeS7022158;
 Thu, 29 May 2025 19:25:13 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-41; Thu, 29 May 2025 19:25:13 +0000
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
Subject: [PATCH V4 40/43] vfio/iommufd: reconstruct hwpt
Date: Thu, 29 May 2025 12:24:36 -0700
Message-Id: <1748546679-154091-41-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: ljLxeQ5Ks-k1LhLHsKAUM236HSinxYqE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfX3L3epmdCSKj/
 eVuLVlYsm4LqUH9CkussGjlx7RpM72pRIwjH+3D8WVfu6WFy2PNyzYoY9JAb+83Ll7c1PgNad19
 /EFN6kvMpS1GlEUXO2pLzHrJrXf6ulrQHPPL0+2NEgc3b2YF/QMusrvCFe7spaOCLXP6iIMP66t
 ABMFOfHoQWRwHjk4agjGcMbjwhSiN0SXAPA2Y4wuB4/SZJIy1qVN/1kPIAOZY5FPDT+KJAFdK4K
 FpPg1fsS9Gf7Ccolu110IUA5FDqmshQb85uvlZ0q4aiETHWWjIe9Ea6QrNeILaGB3KfAitcldcW
 2b+DNQ/CUbQ0hd4oEGCrl0QMl/kmqrj/QEqKeaATxRAQV/bLaLn3EfyXgPaC4Ugb4Aole/MbD0r
 GRrSDM7Kc0b2avkjiVyRrXV0hgrzXmOBeKpg6f1LKPOb2hMeoDwk+F/vnuiJH1ZisnnHwUGx
X-Proofpoint-GUID: ljLxeQ5Ks-k1LhLHsKAUM236HSinxYqE
X-Authority-Analysis: v=2.4 cv=TdeWtQQh c=1 sm=1 tr=0 ts=6838b49b cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=fSzQx-hFMApC99kTtbcA:9
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

Skip allocation of, and attachment to, hwpt_id.  Recover it from CPR state.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/iommufd.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 5119c17..f0abd41 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -332,7 +332,14 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
 
     /* Try to find a domain */
     QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
-        ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
+        if (!cpr_is_incoming()) {
+            ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
+        } else if (vbasedev->cpr.hwpt_id == hwpt->hwpt_id) {
+            ret = 0;
+        } else {
+            continue;
+        }
+
         if (ret) {
             /* -EINVAL means the domain is incompatible with the device. */
             if (ret == -EINVAL) {
@@ -349,6 +356,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
             return false;
         } else {
             vbasedev->hwpt = hwpt;
+            vbasedev->cpr.hwpt_id = hwpt->hwpt_id;
             QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
             vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
             return true;
@@ -371,6 +379,11 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
         flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
     }
 
+    if (cpr_is_incoming()) {
+        hwpt_id = vbasedev->cpr.hwpt_id;
+        goto skip_alloc;
+    }
+
     if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
                                     container->ioas_id, flags,
                                     IOMMU_HWPT_DATA_NONE, 0, NULL,
@@ -378,19 +391,20 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
         return false;
     }
 
+    ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt_id, errp);
+    if (ret) {
+        iommufd_backend_free_id(container->be, hwpt_id);
+        return false;
+    }
+
+skip_alloc:
     hwpt = g_malloc0(sizeof(*hwpt));
     hwpt->hwpt_id = hwpt_id;
     hwpt->hwpt_flags = flags;
     QLIST_INIT(&hwpt->device_list);
 
-    ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
-    if (ret) {
-        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
-        g_free(hwpt);
-        return false;
-    }
-
     vbasedev->hwpt = hwpt;
+    vbasedev->cpr.hwpt_id = hwpt->hwpt_id;
     vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
     QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
     QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
-- 
1.8.3.1


