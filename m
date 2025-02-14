Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8919BC02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwUd-0007vx-Pj; Fri, 14 Feb 2025 09:16:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwTp-0006PB-IL
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:15:47 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwTi-0004kT-Nc
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:15:42 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECtRB5011445;
 Fri, 14 Feb 2025 14:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=+Yztyi6Ja1nZDKOCyh8rDA3zvhN8dFHXhj/9UC3pi/Q=; b=
 nTt2gPQ8oXe9KajZLRO1B3yvxeY3m1i4cT0jJT54ASwZc1grGdU3T/Thc5v5Qwro
 s4qQujPUNqYAosdOt8qU+JCCqyOmJ+L63zVChmuKAm54l62qmp1sFqHGzxxJBXM8
 6XGNkfO7z4dQYcHN+7ip/jnSA0N+443EZuoIoeXeKchUAnXEb+sNbiiC6X+qK4zj
 PUIFVdy1rboe6lVfPX+ohXJMVJ5Lw0aGnyCFF1BINJ5jKzsCN1++PEy3X7elsn4l
 zPf+IocvkIvHWihkG/z5it996+63vllOFuhRZnNbcxwwLEeRcDwuxMTZ8ArrwWMI
 0s4ImPOGwLcBrCGiZm+9SQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0sqbwp2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:15:25 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51EC5VhG025186; Fri, 14 Feb 2025 14:15:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqksh8n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:15:25 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51EEETQZ006920;
 Fri, 14 Feb 2025 14:15:24 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 44nwqksg2h-42; Fri, 14 Feb 2025 14:15:24 +0000
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
Subject: [PATCH V2 41/45] vfio/iommufd: reconstruct hw_caps
Date: Fri, 14 Feb 2025 06:14:23 -0800
Message-Id: <1739542467-226739-42-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140104
X-Proofpoint-ORIG-GUID: 3nyD_Tz5LaZCMiKI3UF1WWLibIgJotX9
X-Proofpoint-GUID: 3nyD_Tz5LaZCMiKI3UF1WWLibIgJotX9
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

hw_caps is normally derived during realize, at vfio_device_hiod_realize ->
hiod_iommufd_vfio_realize -> iommufd_backend_get_device_info.  However,
this depends on the devid, which is not preserved during CPR.

Save devid in vmstate.  Defer the vfio_device_hiod_realize call to
post_load time, after devid has been recovered from vmstate.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/cpr-iommufd.c | 14 ++++++++++++++
 hw/vfio/iommufd.c     |  3 ++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
index 8453d76..a1ac517 100644
--- a/hw/vfio/cpr-iommufd.c
+++ b/hw/vfio/cpr-iommufd.c
@@ -99,12 +99,26 @@ void vfio_iommufd_cpr_unregister_container(VFIOIOMMUFDContainer *container)
     migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
 }
 
+static int vfio_device_post_load(void *opaque, int version_id)
+{
+    VFIODevice *vbasedev = opaque;
+    Error *err = NULL;
+
+    if (!vfio_device_hiod_realize(vbasedev, &err)) {
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
index 3fc530d..693ed19 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -536,7 +536,8 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
      * FD to be connected and having a devid to be able to successfully call
      * iommufd_backend_get_device_info().
      */
-    if (!vfio_device_hiod_realize(vbasedev, errp)) {
+    if (!vbasedev->cpr.reused &&
+        !vfio_device_hiod_realize(vbasedev, errp)) {
         goto err_alloc_ioas;
     }
 
-- 
1.8.3.1


