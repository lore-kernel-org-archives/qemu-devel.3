Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730FCC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 13:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg3B4-0001Uz-Lz; Fri, 01 Mar 2024 08:43:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1rg3B2-0001Sm-Bw; Fri, 01 Mar 2024 08:43:52 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1rg3B0-0004qb-Ik; Fri, 01 Mar 2024 08:43:52 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 421942Bm008853; Fri, 1 Mar 2024 13:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=+DWxfmWULHp2lp6mFB4cFUDT3YJ6mzUWzBGgnQuAkl4=;
 b=B9XUdLfL3h2sHx+eyUSFZgdgpFxaNxAP67P0yNBwG4l9v9a7W0sqqcRQff/JzlczMGcp
 S10ZAr77UhXH/HSLIjvNOUP9ik30l/lOV7EEYaKxqndsHNRKwMdc1q0lHlN9fxGL5YDn
 Hyn5SxxNP81GCOb2nPQ5dsEOWS17sax4X5a0bhFVG3C1kjdvEbARHBf9xj3YwGVVjH4/
 6tPuoFXjHHRd9FDN38nHGdjiIGThJ2TeMS6anZv4G6GLOCOXpeI1j9UU+xmbV1DoZ39K
 FslEkSYm6PCPoD2Mf49+h/o4/ZW5Fh3744vZdxHwDP/XsBi/J+ZSJh8s0fYoJDUuBTnu lg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf6ve8rcm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Mar 2024 13:43:35 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 421Bqo3x009428; Fri, 1 Mar 2024 13:43:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wjrqmtrb7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Mar 2024 13:43:35 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 421DhWAK026578;
 Fri, 1 Mar 2024 13:43:34 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-65-160-211.vpn.oracle.com
 [10.65.160.211])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3wjrqmtr9m-2; Fri, 01 Mar 2024 13:43:34 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, eperezma@redhat.com,
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com,
 jonah.palmer@oracle.com, raphael@enfabrica.net, kwolf@redhat.com,
 hreitz@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, thuth@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, iii@linux.ibm.com, cohuck@redhat.com,
 pbonzini@redhat.com, fam@euphon.net, stefanha@redhat.com,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, virtio-fs@lists.linux.dev
Subject: [RFC 1/8] virtio/virtio-pci: Handle extra notification data
Date: Fri,  1 Mar 2024 08:43:23 -0500
Message-Id: <20240301134330.4191007-2-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240301134330.4191007-1-jonah.palmer@oracle.com>
References: <20240301134330.4191007-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_13,2024-03-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 suspectscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403010114
X-Proofpoint-ORIG-GUID: PBJYUy23tsr-5kXTuQnQ_a8j8E6mk-I-
X-Proofpoint-GUID: PBJYUy23tsr-5kXTuQnQ_a8j8E6mk-I-
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 - upper 16 bits: last_avail_idx
 - lower 16 bits: virtqueue index

In a packed virtqueue layout, this data includes:
 - upper 16 bits: 1-bit wrap counter & 15-bit last_avail_idx
 - lower 16 bits: virtqueue index

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/virtio/virtio-pci.c     | 13 ++++++++++---
 hw/virtio/virtio.c         | 13 +++++++++++++
 include/hw/virtio/virtio.h |  1 +
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 1a7039fb0c..c7c577b177 100644
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
@@ -408,8 +408,15 @@ static void virtio_ioport_write(void *opaque, uint32_t addr, uint32_t val)
             vdev->queue_sel = val;
         break;
     case VIRTIO_PCI_QUEUE_NOTIFY:
-        if (val < VIRTIO_QUEUE_MAX) {
-            virtio_queue_notify(vdev, val);
+        if (virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA)) {
+            vq_idx = val & 0xFFFF;
+            virtio_set_notification_data(vdev, vq_idx, val);
+        } else {
+            vq_idx = val;
+        }
+
+        if (vq_idx < VIRTIO_QUEUE_MAX) {
+            virtio_queue_notify(vdev, vq_idx);
         }
         break;
     case VIRTIO_PCI_STATUS:
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index d229755eae..a61f69b7fd 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2052,6 +2052,19 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
     return 0;
 }
 
+void virtio_set_notification_data(VirtIODevice *vdev, uint16_t i, uint32_t data)
+{
+    VirtQueue *vq = &vdev->vq[i];
+
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        vq->last_avail_wrap_counter = (data >> 31) & 0x1;
+        vq->last_avail_idx = (data >> 16) & 0x7FFF;
+    } else {
+        vq->last_avail_idx = (data >> 16) & 0xFFFF;
+    }
+    vq->shadow_avail_idx = vq->last_avail_idx;
+}
+
 static enum virtio_device_endian virtio_default_endian(void)
 {
     if (target_words_bigendian()) {
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index c8f72850bc..c92d8afc42 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -345,6 +345,7 @@ void virtio_queue_reset(VirtIODevice *vdev, uint32_t queue_index);
 void virtio_queue_enable(VirtIODevice *vdev, uint32_t queue_index);
 void virtio_update_irq(VirtIODevice *vdev);
 int virtio_set_features(VirtIODevice *vdev, uint64_t val);
+void virtio_set_notification_data(VirtIODevice *vdev, uint16_t i, uint32_t data);
 
 /* Base devices.  */
 typedef struct VirtIOBlkConf VirtIOBlkConf;
-- 
2.39.3


