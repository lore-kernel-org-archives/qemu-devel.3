Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E9CC83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 22:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX5UI-0003Yk-9L; Wed, 02 Jul 2025 17:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5UF-0003Xc-P3
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:27 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5UE-0003k9-2r
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:27 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562LQhuZ019445;
 Wed, 2 Jul 2025 21:59:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=7tr83i3Cu/9rLbKZRDxbDsyo2n/hOR98SyjkmEgZzHk=; b=
 Gthb1JM0mA5NWuIBW2jn2G324LyLpqFMKWkMTKo5euO89Zvvyc6e35CoSgGrmjQa
 xgNDJ+S1ZWh2k4jx/2nNxp8iHL2lQgrSbnfa1VYkewdxGkyxu5vaj81W5X3qAPQg
 XrV20eJyxBAC6Nzo3FvWZ0y4oTeERNVpOhh1CvJgtozfcjPDfbsuxBwPRuOKlrFg
 LeytHb1CuHttSjLnAHeqPYwqji+HZtXQSSWyofdZMyJeqhwhccaS7EBbcFixMOiv
 o6PUMDADH4pgUka2HfIlcMA638vbTHCJQJ0vWRnUa6Cq6B1fFn6ICUPcKHsaihQ+
 YywKRYN++rj7ych+tJPqfw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47jum7y5bs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:13 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 562LLA90033618; Wed, 2 Jul 2025 21:59:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6ubtd6j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:12 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 562LwxgS020012;
 Wed, 2 Jul 2025 21:59:12 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47j6ubtcxb-18; Wed, 02 Jul 2025 21:59:12 +0000
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
Subject: [PATCH V6 17/21] vfio/iommufd: reconstruct hwpt
Date: Wed,  2 Jul 2025 14:58:54 -0700
Message-Id: <1751493538-202042-18-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
References: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020182
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE4MiBTYWx0ZWRfXzH0CGt4Y5YYP
 4C63qGFRv7iEJKi/53LY08DO1S04faAS8ayrG9r1iLXNgUtsRcwz/P83uoGD6PU7jL6cipYKL7r
 fQw4QXhmwwYDs2eB7AKttwltKnNcV0wGopieAz8rEmlgi8hKLhKolo6hBe+2T3ntj+3ve/uAHxP
 WcBSmW8G3FYp5E3l75PDBrkvqBfA/Djg/DL+SBeDSdzsIQkjXGm5hpXeq6WsTG10JLTyMVfCJv3
 H71k3pi0t063kc4v714OZNQnX1fH8Don/Ja3VZLwEaL00XF2UJcvEa5eFpPDmIklZtcYRGGVKdF
 7UoWWbml7szuBopM5iVVXIxyOjrpidN56XFjv65AGYUU0KrtP9vMVLHoQeaNFCXlibwxhUH3arv
 KTz5nouve3patgf3xnaEqPeMeQ0oSeOa0k7Znal9NKSPiKgL6KuSIyZM3ZA8uzDZ7kxX2L2/
X-Authority-Analysis: v=2.4 cv=MvBS63ae c=1 sm=1 tr=0 ts=6865abb1 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=fSzQx-hFMApC99kTtbcA:9
X-Proofpoint-ORIG-GUID: Tb3KL5niIMOT4DA4c3_RRRlBADZe-MNQ
X-Proofpoint-GUID: Tb3KL5niIMOT4DA4c3_RRRlBADZe-MNQ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
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


