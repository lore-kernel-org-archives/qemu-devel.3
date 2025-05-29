Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36B0C5B543
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKisy-0004mC-S4; Thu, 29 May 2025 15:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisM-0004AU-0D
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:15 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisJ-0000SI-PE
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:13 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfpx8022094;
 Thu, 29 May 2025 19:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=gXScG2GfqwtY0oCJVKlKfstIhPSAjyCPQfL6S2SQFTc=; b=
 I5baR1G2DiDxsR/A4/CatiPyOszFnkG5l3adBe2Kmf5Bxg6cbdx2sHwuMsrSPtPx
 w2Om0HaIpKjclNoEFHQ1Yh/shfrgG+6OnHb7/LdtSs/Ji7+psdN6BCvaP3nrL8pY
 H3Oas2KAem3SErnKDJb+tc2tihM+Z1ajykqQXAOT16tznwoCQWcyYwjuyQYZPdN6
 rutEAq1EUAZm13Dttd8hy2lHS59bGhTLYW9mT/VMLxmUG9gNih8GMppbQR0HRruL
 AxVXviLreU86Aoj8tgf40YI2EuQ8cz8uhQjsqP9YRC1+q6Hz1rXn26wA0bNPtLpl
 3e6TqPrqwXUXrWb+JvjUEQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0g2h189-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:09 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54TJLKIp020341; Thu, 29 May 2025 19:25:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4w47-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:08 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeRr022158;
 Thu, 29 May 2025 19:25:07 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-34; Thu, 29 May 2025 19:25:07 +0000
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
Subject: [PATCH V4 33/43] vfio/iommufd: add vfio_device_free_name
Date: Thu, 29 May 2025 12:24:29 -0700
Message-Id: <1748546679-154091-34-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfX0CwcqfkkfaAy
 XfJrm7rhkSk3lEbrd3oVbkgKB1am6lGv0di/LVODgrrWgOQ2XE2IhwlaVNtopta3znpulyFHATv
 oicEnJ1r8OGsLdmfK6SqdBezUpcxRMnwnrn9a5rumgB1L5VIwDmuc0deUnd3rUKHKN4Eyh3ptOx
 Fjt2UhYNAtdz3CzaAa9g1W9QjbW4m9D/qGwMRmj24kdcvqKxmfO/mT/77ZO255Da9C+gXQg9nEL
 G3rlwyZi3Y4eJlDIgkHM3WD/0jzixMbayPiTZrxWfckXfNmfn+HVR6mGzu/ROhtemg5lIyzpwMZ
 MdSeW5KXdoF6efPKNRloEfrUdXurLGeqj4YGz+AgAB1/j7sB1M0MCUI33ZxdyW0TsIquT9fxnUJ
 Cparkz7UNeom7b7VHk9h6ypQ9wYTGlqu+TrTRHly/frL8ujAF+0FvR+4zj/hebYSqabHdEFK
X-Authority-Analysis: v=2.4 cv=NJLV+16g c=1 sm=1 tr=0 ts=6838b495 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=cF8GLI2TDnzqfzOqKfcA:9
X-Proofpoint-ORIG-GUID: DxQl4LquLIZhFN5CuAr1A7rL0mVl3kkr
X-Proofpoint-GUID: DxQl4LquLIZhFN5CuAr1A7rL0mVl3kkr
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

Define vfio_device_free_name to free the name created by
vfio_device_get_name.  A subsequent patch will do more there.
No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/hw/vfio/vfio-device.h | 1 +
 hw/vfio/ap.c                  | 2 +-
 hw/vfio/ccw.c                 | 2 +-
 hw/vfio/device.c              | 5 +++++
 hw/vfio/pci.c                 | 2 +-
 hw/vfio/platform.c            | 2 +-
 6 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 6eb6f21..321b442 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -227,6 +227,7 @@ int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
 
 /* Returns 0 on success, or a negative errno. */
 bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
+void vfio_device_free_name(VFIODevice *vbasedev);
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
 void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
                       DeviceState *dev, bool ram_discard);
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 785c0a0..013bd59 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -180,7 +180,7 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
 
 error:
     error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
-    g_free(vbasedev->name);
+    vfio_device_free_name(vbasedev);
 }
 
 static void vfio_ap_unrealize(DeviceState *dev)
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index cea9d6e..903b8b0 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -619,7 +619,7 @@ out_io_notifier_err:
 out_region_err:
     vfio_device_detach(vbasedev);
 out_attach_dev_err:
-    g_free(vbasedev->name);
+    vfio_device_free_name(vbasedev);
 out_unrealize:
     if (cdc->unrealize) {
         cdc->unrealize(cdev);
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 71fa9f4..151c618 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -317,6 +317,11 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
     return true;
 }
 
+void vfio_device_free_name(VFIODevice *vbasedev)
+{
+    g_free(vbasedev->name);
+}
+
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
 {
     ERRP_GUARD();
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c8d6ee0..7da7a9c 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2949,7 +2949,7 @@ static void vfio_pci_put_device(VFIOPCIDevice *vdev)
 {
     vfio_device_detach(&vdev->vbasedev);
 
-    g_free(vdev->vbasedev.name);
+    vfio_device_free_name(&vdev->vbasedev);
     g_free(vdev->msix);
 }
 
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 9a21f2e..5c1795a 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -530,7 +530,7 @@ static bool vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
 {
     /* @fd takes precedence over @sysfsdev which takes precedence over @host */
     if (vbasedev->fd < 0 && vbasedev->sysfsdev) {
-        g_free(vbasedev->name);
+        vfio_device_free_name(vbasedev);
         vbasedev->name = g_path_get_basename(vbasedev->sysfsdev);
     } else if (vbasedev->fd < 0) {
         if (!vbasedev->name || strchr(vbasedev->name, '/')) {
-- 
1.8.3.1


