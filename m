Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141E4C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 22:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX5U3-0003SS-QK; Wed, 02 Jul 2025 17:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5U0-0003PW-Dj
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:12 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5Ty-0003hQ-O9
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:12 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562LQZ9c027452;
 Wed, 2 Jul 2025 21:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=RHCvWCugjmwGE7e8TYTJJfowo0Vxru2C4uSUq+oQAeo=; b=
 YzQXH7e9BYY0v+tvsAiLMsAQ8FgiqELbdJJW/sxxMqTEGZSjNtNFsNnzYzz2Io7r
 /NWuamcPnVP6KVmfPLBAPu2zR7YSVa5Cu4OeOk/CnPze8snGbhmGrYaLtaDYbnaP
 3QHSVDS/C/XJMCz5f1hAB5UTnQ4L5oBKQ0EAZYK64toIXxLNUsco2gu/4WFfxRGG
 +3RpwWrETB79ajndLceOsNOu+KyZjxvTYZ3j6Y6ytEIGTIAg07h+M+BFZAAMBiID
 0UAT8zH3jmVlSYIs5d/39WrGo21Vewy7xjdqE9c1Iq5NizpAm/QxOiigUebBOQYC
 tUP2mVEC6z7kYZMt199XHg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j80w7vr4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:08 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 562KRI8s033624; Wed, 2 Jul 2025 21:59:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6ubtd3a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:07 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 562LwxgE020012;
 Wed, 2 Jul 2025 21:59:06 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47j6ubtcxb-11; Wed, 02 Jul 2025 21:59:06 +0000
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
Subject: [PATCH V6 10/21] vfio/iommufd: add vfio_device_free_name
Date: Wed,  2 Jul 2025 14:58:47 -0700
Message-Id: <1751493538-202042-11-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
References: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020182
X-Proofpoint-GUID: v3wxxCuJJaj9udvPNHO-qeKZUjq8W2r9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE4MiBTYWx0ZWRfX2i9PLnFB1BDS
 EGxp2AsSjMqXBZ/ZbWfOSBdcsRjSpuE9z+DUklyLY9hQp2aRDhdXVg9m75R9kzC+7cVH8oLW+s1
 e4LQTTo4RJO7lsZL7Bi0OE9IiwHEFp2vL46eU0uzPeGViHLMakYwIuRoM/Yikc3RXcjVaZoNyxh
 lJXZotyBvpHlPFhQRFVsuESBOqsadsVvW7JU5qTjAtM7rvVq0KTH+SDV3tbkRJGbZoEvpyYw10V
 svx1toiVB9J9xEqZO/zPHwSM1il2fAF5i6zebumng/bbGokTa3vzzEFIE/K/mnkU+LH0WED6RoG
 B5ops4CR29ms8o2bCbbZpsabB+Ly2Brj4FwloVA3fp48z8RLD4HZSEh56SxbfxAjyYEod8TH0kH
 P0lR93xQ+u5zoGJeP2DvYe1DkE5U/1e3iCEQHP3fDckrPdLkF6OD2zXWNsvxTnTXgUzKGuVy
X-Authority-Analysis: v=2.4 cv=D6hHKuRj c=1 sm=1 tr=0 ts=6865abac cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=QyXUC8HyAAAA:8 a=k3-JSidODddoZ9E4aD4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: v3wxxCuJJaj9udvPNHO-qeKZUjq8W2r9
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Define vfio_device_free_name to free the name created by
vfio_device_get_name.  A subsequent patch will do more there.
No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-device.h | 1 +
 hw/vfio/ap.c                  | 4 ++--
 hw/vfio/ccw.c                 | 4 ++--
 hw/vfio/device.c              | 5 +++++
 hw/vfio/pci.c                 | 2 +-
 hw/vfio/platform.c            | 2 +-
 6 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index f503837..1901a35 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -279,6 +279,7 @@ int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
 
 /* Returns 0 on success, or a negative errno. */
 bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
+void vfio_device_free_name(VFIODevice *vbasedev);
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
 void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
                       DeviceState *dev, bool ram_discard);
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 1df4438..7719f24 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -265,7 +265,7 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
 
 error:
     error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
-    g_free(vbasedev->name);
+    vfio_device_free_name(vbasedev);
 }
 
 static void vfio_ap_unrealize(DeviceState *dev)
@@ -275,7 +275,7 @@ static void vfio_ap_unrealize(DeviceState *dev)
     vfio_ap_unregister_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX);
     vfio_ap_unregister_irq_notifier(vapdev, VFIO_AP_CFG_CHG_IRQ_INDEX);
     vfio_device_detach(&vapdev->vdev);
-    g_free(vapdev->vdev.name);
+    vfio_device_free_name(&vapdev->vdev);
 }
 
 static const Property vfio_ap_properties[] = {
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index cea9d6e..9560b8d 100644
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
@@ -637,7 +637,7 @@ static void vfio_ccw_unrealize(DeviceState *dev)
     vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX);
     vfio_ccw_put_region(vcdev);
     vfio_device_detach(&vcdev->vdev);
-    g_free(vcdev->vdev.name);
+    vfio_device_free_name(&vcdev->vdev);
 
     if (cdc->unrealize) {
         cdc->unrealize(cdev);
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 3cd365f..97eddd0 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -333,6 +333,11 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
     return true;
 }
 
+void vfio_device_free_name(VFIODevice *vbasedev)
+{
+    g_clear_pointer(&vbasedev->name, g_free);
+}
+
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
 {
     ERRP_GUARD();
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index dd0b2a0..1093b28 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2996,7 +2996,7 @@ void vfio_pci_put_device(VFIOPCIDevice *vdev)
 
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


