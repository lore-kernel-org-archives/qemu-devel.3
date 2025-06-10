Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DEBC5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP27c-0002EG-0e; Tue, 10 Jun 2025 12:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP160-0004bu-6w
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:41:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15w-0006Fv-Of
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:41:03 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEXafo030392;
 Tue, 10 Jun 2025 15:40:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=NIzLiHEsAbi0ZG3n2CdDO+JXTFRjLjQ2BYbpcmqa1gU=; b=
 RqleTJkiagjoYbo7UTAw1PqVN9T+iq/w4NhFTPVhPsimhm5NXO/ITgyAfmosSYhY
 d3wItCR+61nu7/sfv/fcL9PQT1XbFxCsMeUg6zYAwa23xKw9+cIDVSo88KOxEFw0
 aa/4JFMRRyqh1ZfwRT3e7NWCbvvRJ6NTHtrpe81VIq6KRcxnG+Fpu3wOM1N5+Bis
 RIW/3Lchv2wmelJojK0BQeDbTZIBBlMVr8CDTT0yl6/20x26NaGA16I4MFVbm6/0
 E59PGRVIqNC6jj/cKq85T5z9yInTJM5YmcwqWdzZJE6wDX2s+fOQBGOFF6u3uQA1
 2BPt5h67NHnAYfGxbq5mUA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c14cgxf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:48 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55AEiqkr003975; Tue, 10 Jun 2025 15:40:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bv8wc12-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:46 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55AFdrgF028825;
 Tue, 10 Jun 2025 15:40:46 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 474bv8wak1-35; Tue, 10 Jun 2025 15:40:46 +0000
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
Subject: [PATCH V5 34/38] vfio/iommufd: reconstruct hwpt
Date: Tue, 10 Jun 2025 08:39:47 -0700
Message-Id: <1749569991-25171-35-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: oy9Hfturtzw3G3RPN_UWRfvhpDlZS11S
X-Authority-Analysis: v=2.4 cv=GcEXnRXL c=1 sm=1 tr=0 ts=68485200 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=fSzQx-hFMApC99kTtbcA:9 cc=ntf
 awl=host:14714
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEyNiBTYWx0ZWRfXxbnMaKi8uAW/
 C42SZbmQFBkdxAG6ul5Z1OLWOak7RQDhzp5lX4Jn6dUKHFQMS//BvabKLesCIRoeFL88cVD9DnJ
 kx/rx1G8RbLnxnHXdZ6Jmpg6JfbeJmilNm+HEFDCOKOGRP2CFrrPlvjH54nSOq+bYryDpDJh0Qo
 vbqN+/LsBy5iLzsKT6hgNYWx9/EAyVEHw1CzsXqXgSjgdxRe3Cb+eKpU0g0SBY/iAaeQmXyGOJj
 l2s3nF0xf5ysPP6ErJMMltohjCcFIYkKfxHZxHMRD15uFaTrBYs139Sv9ajc6AZuQ4CL2iy84vw
 gYbFDPDVwPlGxe6elfGjO3LGvhLzQOwFQ5PR+CYO8z0hDdc+EtMZ1RKb+VXyUdYJ3dV1nzj+IWn
 CTvCHZ1dEQP7lif9L8tPhcoXabTIo9zVQR0/Hdh+3agndteBtxU8hweCeehF5tXEbJzfd9l+
X-Proofpoint-ORIG-GUID: oy9Hfturtzw3G3RPN_UWRfvhpDlZS11S
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Skip allocation of, and attachment to, hwpt_id.  Recover it from CPR state.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/iommufd.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index a650517..48c590b 100644
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


