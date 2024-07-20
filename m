Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E680C3DA49
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 19:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVFZB-0007Di-7E; Sat, 20 Jul 2024 15:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVFYx-0006q6-JO
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:16:14 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVFYk-0000pY-Sj
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:16:06 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46KJFiNO017251;
 Sat, 20 Jul 2024 19:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=gpAaa9HSbr+6w0SO4zYiChdvbrFszVDHKwG0Gs2gAnA=; b=
 om6GkSBV9fU0KTC/X/UlR3e+eCZdqHvRuIJyoHTtEUB0FduZPd91RRU13EZSDYu1
 9JG+bocvhOWX5KZnTe+t+yPb75h/YDGxYZsA5Rv+CC77LEtpOyWl/WsMIoysJT8X
 P9DFwBsPEa1S+82UxJwATTVPch3nbetUeokQyD5oBqGhD4YdnFynL3rZ1R5oPiBF
 rbAouQwiineI+vpcPnhSoMeNLTht27Wu8wWYir1yss1Sar7lWdPN7flY6nkxPvsu
 NKa+dIZ+pAZpVM13Qy1EXrpp5pKLOFbiKBRFSum6FCv71VH4kMPgnAXw2BWCQuEF
 ZA4vuPdqCGiN3jMliNK1nQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40gk7w000a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 19:15:44 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46KH5ckn027509; Sat, 20 Jul 2024 19:15:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40g3p5putv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 19:15:43 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46KJFdf7028365;
 Sat, 20 Jul 2024 19:15:43 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 40g3p5pusv-4; Sat, 20 Jul 2024 19:15:43 +0000
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
Subject: [RFC V1 03/12] iommufd: pass name to connect
Date: Sat, 20 Jul 2024 12:15:28 -0700
Message-Id: <1721502937-87102-4-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: jshvbBiRpXkyEkfobyOr4P5ltYtE2vGk
X-Proofpoint-GUID: jshvbBiRpXkyEkfobyOr4P5ltYtE2vGk
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

Pass device name to iommufd_backend_connect and iommufd_backend_disconnect,
for use by CPR in a subsequent patch.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 backends/iommufd.c       | 4 ++--
 hw/vfio/iommufd.c        | 6 +++---
 include/sysemu/iommufd.h | 5 +++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 84fefbc..fc37386 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -72,7 +72,7 @@ static void iommufd_backend_class_init(ObjectClass *oc, void *data)
     object_class_property_add_str(oc, "fd", NULL, iommufd_backend_set_fd);
 }
 
-bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
+bool iommufd_backend_connect(IOMMUFDBackend *be, const char *name, Error **errp)
 {
     int fd;
 
@@ -90,7 +90,7 @@ bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
     return true;
 }
 
-void iommufd_backend_disconnect(IOMMUFDBackend *be)
+void iommufd_backend_disconnect(IOMMUFDBackend *be, const char *name)
 {
     if (!be->users) {
         goto out;
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index c2f158e..255966a 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -71,7 +71,7 @@ static bool iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
         .flags = 0,
     };
 
-    if (!iommufd_backend_connect(iommufd, errp)) {
+    if (!iommufd_backend_connect(iommufd, vbasedev->name, errp)) {
         return false;
     }
 
@@ -99,7 +99,7 @@ static bool iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
 err_bind:
     iommufd_cdev_kvm_device_del(vbasedev);
 err_kvm_device_add:
-    iommufd_backend_disconnect(iommufd);
+    iommufd_backend_disconnect(iommufd, vbasedev->name);
     return false;
 }
 
@@ -107,7 +107,7 @@ static void iommufd_cdev_unbind_and_disconnect(VFIODevice *vbasedev)
 {
     /* Unbind is automatically conducted when device fd is closed */
     iommufd_cdev_kvm_device_del(vbasedev);
-    iommufd_backend_disconnect(vbasedev->iommufd);
+    iommufd_backend_disconnect(vbasedev->iommufd, vbasedev->name);
 }
 
 static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
index 9edfec6..aa195d1 100644
--- a/include/sysemu/iommufd.h
+++ b/include/sysemu/iommufd.h
@@ -37,8 +37,9 @@ struct IOMMUFDBackend {
     /*< public >*/
 };
 
-bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
-void iommufd_backend_disconnect(IOMMUFDBackend *be);
+bool iommufd_backend_connect(IOMMUFDBackend *be, const char *name,
+                             Error **errp);
+void iommufd_backend_disconnect(IOMMUFDBackend *be, const char *name);
 
 bool iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
                                 Error **errp);
-- 
1.8.3.1


