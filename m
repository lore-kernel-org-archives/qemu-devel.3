Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBEEC71130
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP28g-0004oP-It; Tue, 10 Jun 2025 12:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15r-0004ZN-VO
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15o-0006Ee-2z
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:55 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEXeHJ027903;
 Tue, 10 Jun 2025 15:40:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=cAnDG67bAlekGC+BaPcckgqyZXgWQH2eruNb9eucybQ=; b=
 J4HANV8XaYgYImt3ajUlx7BrJxlbf6RRDpmqvAIqshfGcmM3qvlBxVLSFNZqrgJn
 CeQl+aXb/1g7TDrxagH7UbLMZ3/eNNWS6RJNc4U39FDN9AvT6CADN+vlndG8ccuc
 z/qbY58X9+asedJTSuRHrariw9FajScu9TiZMEhqQPfkhNkWjtNTtxyr677ByQFG
 tKp0/0YXRfmUSvQp0WQU4NneR8vF4NZ7O3XvyTaHLJE5qCPdFpd8ZKTVRUosGpBf
 vxgWaaX1vHqU14mv+P2KHQ8hULYTmPUiBVLEIWhXQ/ACxxdJATdzjs0+dvRqg+z7
 Mwrw1QS7wokpU3lQgE/ctg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474cbech6q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:38 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55AF0F37003984; Tue, 10 Jun 2025 15:40:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bv8wbrx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:37 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55AFdrg1028825;
 Tue, 10 Jun 2025 15:40:36 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 474bv8wak1-28; Tue, 10 Jun 2025 15:40:36 +0000
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
Subject: [PATCH V5 27/38] vfio/iommufd: add vfio_device_free_name
Date: Tue, 10 Jun 2025 08:39:40 -0700
Message-Id: <1749569991-25171-28-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: laYNKQBw2C73eOT_gNGMgSEsvbhSOsb1
X-Authority-Analysis: v=2.4 cv=BffY0qt2 c=1 sm=1 tr=0 ts=684851f6 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=cF8GLI2TDnzqfzOqKfcA:9 cc=ntf
 awl=host:14714
X-Proofpoint-ORIG-GUID: laYNKQBw2C73eOT_gNGMgSEsvbhSOsb1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEyNiBTYWx0ZWRfXwLOUsSilBZ49
 07qQ55iLtPOZCTsN26rfCllaVEw8RzFS7WiAu6V16TpPy2e6UfxGWRb0hurahsynYFuLoCUbg33
 0ldLa9jZm5PVGerZTzv7MUAh3YoUVtmR9+qmzXS6ZMG++0tod5hwoZpdRqgGW4h6aqe0uR9YJ5L
 J38pieS2u8BH1uwBVyQk8VCMpXdE3SUYjzJfYey0IMLYNESrHJi/amLxvUtsprmp+uQLfSz/e1n
 dEilMRysfM9QDE4IpPk0dNXwitpOinmxjuFonzzCXA09e6vyCY/oAozfXCxt5XeNnR/fC7Xy/aO
 f7cEHWVa4QmDNRvKpEg/xOiYOKrYM4sZdicWPDtwHxXMlWBGG4jy5Q4GzR+Z2ry56eo63VOwdpx
 HuLUJ+rcxcUM1rQyIYWHvgijGRsqUxizjUuB1R0EZAlHZK4DR7vzGtSo2jyzY3IcJMp1S99K
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
index 71fa9f4..a3603f5 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -317,6 +317,11 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
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
index b52c488..b4136432 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2966,7 +2966,7 @@ static void vfio_pci_put_device(VFIOPCIDevice *vdev)
 
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


