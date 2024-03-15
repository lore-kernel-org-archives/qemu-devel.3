Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03731C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 16:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlArk-0003qC-Nt; Fri, 15 Mar 2024 12:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1rlArf-0003nm-Qi; Fri, 15 Mar 2024 12:57:03 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1rlArY-0001DE-BF; Fri, 15 Mar 2024 12:57:03 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42FGWsk7023964; Fri, 15 Mar 2024 16:56:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=j7weDARqbnaPZ+NpopRduEohkW8wiXoUF0ueJc51V/0=;
 b=fl62rq1r6ntpluu/3UlXrQjN9CrGJsNljHbYnfAbaiTA1f8hCOZMX3sAg+Zey6unKrGh
 Ynjp8dSpB0QxfxqkdlTjPCpvs6Wk5PT26ME5vc/U7fPLvtgjImlAsuXvIts0kYckaaK4
 np/iD8h64upE+mQy4+6NQmV4+Zt0JBu1qQY2EEL1CTqqJUijqNWn1eiALAnnbdxPshtF
 3qlQtY1aVheJ/0DyH8SaTX13H4WOxSH6cDvIBH18wNRHMqfXJpcoeAjsrjiN7E7duy9A
 9toxDL550ZzOswUDfleArPJvfuJzRmd7LkWIkZu8bXVV/9McMFf2A8XA1UIJ9t/+Mc9D DA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wvsxh815u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Mar 2024 16:56:08 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42FFLv1D033763; Fri, 15 Mar 2024 16:56:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wre7bw7ng-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Mar 2024 16:56:07 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42FGu2YQ039399;
 Fri, 15 Mar 2024 16:56:06 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-65-177-130.vpn.oracle.com
 [10.65.177.130])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3wre7bw7fq-2; Fri, 15 Mar 2024 16:56:06 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, eperezma@redhat.com,
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com,
 jonah.palmer@oracle.com, raphael@enfabrica.net, kwolf@redhat.com,
 hreitz@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, thuth@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, iii@linux.ibm.com, cohuck@redhat.com,
 pbonzini@redhat.com, fam@euphon.net, stefanha@redhat.com,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, leiyang@redhat.com,
 schalla@marvell.com, vattunuru@marvell.com, jerinj@marvell.com,
 dtatulea@nvidia.com, virtio-fs@lists.linux.dev
Subject: [PATCH v3 for 9.1 1/6] virtio/virtio-pci: Handle extra notification
 data
Date: Fri, 15 Mar 2024 12:55:52 -0400
Message-Id: <20240315165557.26942-2-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240315165557.26942-1-jonah.palmer@oracle.com>
References: <20240315165557.26942-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-15_04,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403150138
X-Proofpoint-ORIG-GUID: znWpf0FVVu5PHiLWzEMAV_Yy6amXt9Lq
X-Proofpoint-GUID: znWpf0FVVu5PHiLWzEMAV_Yy6amXt9Lq
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add support to virtio-pci devices for handling the extra data sent
from the driver to the device when the VIRTIO_F_NOTIFICATION_DATA
transport feature has been negotiated.

The extra data that's passed to the virtio-pci device when this
feature is enabled varies depending on the device's virtqueue
layout.

In a split virtqueue layout, this data includes:
 - upper 16 bits: shadow_avail_idx
 - lower 16 bits: virtqueue index

In a packed virtqueue layout, this data includes:
 - upper 16 bits: 1-bit wrap counter & 15-bit shadow_avail_idx
 - lower 16 bits: virtqueue index

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/virtio/virtio-pci.c     | 11 ++++++++---
 hw/virtio/virtio.c         | 18 ++++++++++++++++++
 include/hw/virtio/virtio.h |  2 ++
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index cb6940fc0e..f3e0a08f53 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -384,7 +384,7 @@ static void virtio_ioport_write(void *opaque, uint32_t addr, uint32_t val)
 {
     VirtIOPCIProxy *proxy = opaque;
     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
-    uint16_t vector;
+    uint16_t vector, vq_idx;
     hwaddr pa;
 
     switch (addr) {
@@ -408,8 +408,13 @@ static void virtio_ioport_write(void *opaque, uint32_t addr, uint32_t val)
             vdev->queue_sel = val;
         break;
     case VIRTIO_PCI_QUEUE_NOTIFY:
-        if (val < VIRTIO_QUEUE_MAX) {
-            virtio_queue_notify(vdev, val);
+        vq_idx = val;
+        if (vq_idx < VIRTIO_QUEUE_MAX && virtio_queue_get_num(vdev, vq_idx)) {
+            if (virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA)) {
+                virtio_queue_set_shadow_avail_idx(virtio_get_queue(vdev, vq_idx),
+                                                  val >> 16);
+            }
+            virtio_queue_notify(vdev, vq_idx);
         }
         break;
     case VIRTIO_PCI_STATUS:
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index d229755eae..463426ca92 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2255,6 +2255,24 @@ void virtio_queue_set_align(VirtIODevice *vdev, int n, int align)
     }
 }
 
+void virtio_queue_set_shadow_avail_idx(VirtQueue *vq, uint16_t shadow_avail_idx)
+{
+    if (!vq->vring.desc) {
+        return;
+    }
+
+    /*
+     * 16-bit data for packed VQs include 1-bit wrap counter and
+     * 15-bit shadow_avail_idx.
+     */
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
+        vq->shadow_avail_wrap_counter = (shadow_avail_idx >> 15) & 0x1;
+        vq->shadow_avail_idx = shadow_avail_idx & 0x7FFF;
+    } else {
+        vq->shadow_avail_idx = shadow_avail_idx;
+    }
+}
+
 static void virtio_queue_notify_vq(VirtQueue *vq)
 {
     if (vq->vring.desc && vq->handle_output) {
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index c8f72850bc..cdd4f86b61 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -306,6 +306,8 @@ int virtio_queue_ready(VirtQueue *vq);
 
 int virtio_queue_empty(VirtQueue *vq);
 
+void virtio_queue_set_shadow_avail_idx(VirtQueue *vq, uint16_t idx);
+
 /* Host binding interface.  */
 
 uint32_t virtio_config_readb(VirtIODevice *vdev, uint32_t addr);
-- 
2.39.3


