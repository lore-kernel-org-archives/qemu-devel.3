Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DE6CD11DD
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 16:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpsWr-00078H-Te; Thu, 28 Mar 2024 12:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1rpsWZ-00072F-Gv; Thu, 28 Mar 2024 12:22:43 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1rpsWT-00087L-HE; Thu, 28 Mar 2024 12:22:43 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42SFP3Gj009598; Thu, 28 Mar 2024 16:22:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=t+MOBr6NcxD2+45PzNWIRJWhFZkAKFOHgU3aasbwS2Q=;
 b=PeEXh6VPCBq5F3IObjBRiYRY8OhsqKH9MqkWsnSSQbUyLzawWN1d0kAoYNZXISEQ87d/
 nCjKVcacYvftWcoL4aV3bpUlumYuoWvoqsZnZIts4vILCuThfbV1Zy4Y5SNgzVF+xwhP
 I62Qz1mS7q0EKXWnPCgmFRRFv750fXXSgVPykwC3kDngFgWOFTroa7knSm7SPQeIw8RS
 eSZjiJvukKcEldeVf9stki0t8GxnMsi1pi217wcHC8XiHniB2idgr6RTFuJp5kppRVcw
 jlkQEIQevR/3o8Clh9eK8ZKwSivrn0D95F+wBOGCd9fHE3SMK37z4OR9uow2BvFwx1yk qA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x2s9h0jtw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Mar 2024 16:22:09 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42SGG4FM015182; Thu, 28 Mar 2024 16:22:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3x1nhgfgfk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Mar 2024 16:22:07 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42SGM5Zv010492;
 Thu, 28 Mar 2024 16:22:07 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-39-220-183.vpn.oracle.com
 [10.39.220.183])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3x1nhgfgcy-2; Thu, 28 Mar 2024 16:22:07 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, raphael@enfabrica.net, kwolf@redhat.com, hreitz@redhat.com,
 jasowang@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 eperezma@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org,
 schalla@marvell.com, leiyang@redhat.com, virtio-fs@lists.linux.dev,
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [RFC v2 1/5] virtio: Initialize sequence variables
Date: Thu, 28 Mar 2024 12:21:59 -0400
Message-Id: <20240328162203.3775114-2-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240328162203.3775114-1-jonah.palmer@oracle.com>
References: <20240328162203.3775114-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_15,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403280111
X-Proofpoint-GUID: yIwmXhld4fui8KBKq2wn5XuC7ZmmavOX
X-Proofpoint-ORIG-GUID: yIwmXhld4fui8KBKq2wn5XuC7ZmmavOX
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Initialize sequence variables for VirtQueue and VirtQueueElement
structures. A VirtQueue's sequence variables are initialized when a
VirtQueue is being created or reset. A VirtQueueElement's sequence
variable is initialized when a VirtQueueElement is being initialized.
These variables will be used to support the VIRTIO_F_IN_ORDER feature.

A VirtQueue's used_seq_idx represents the next expected index in a
sequence of VirtQueueElements to be processed (put on the used ring).
The next VirtQueueElement added to the used ring must match this
sequence number before additional elements can be safely added to the
used ring. It's also particularly useful for helping find the number of
new elements added to the used ring.

A VirtQueue's current_seq_idx represents the current sequence index.
This value is essentially a counter where the value is assigned to a new
VirtQueueElement and then incremented. Given its uint16_t type, this
sequence number can be between 0 and 65,535.

A VirtQueueElement's seq_idx represents the sequence number assigned to
the VirtQueueElement when it was created. This value must match with the
VirtQueue's used_seq_idx before the element can be put on the used ring
by the device.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/virtio/virtio.c         | 18 ++++++++++++++++++
 include/hw/virtio/virtio.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index fb6b4ccd83..069d96df99 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -132,6 +132,10 @@ struct VirtQueue
     uint16_t used_idx;
     bool used_wrap_counter;
 
+    /* In-Order sequence indices */
+    uint16_t used_seq_idx;
+    uint16_t current_seq_idx;
+
     /* Last used index value we have signalled on */
     uint16_t signalled_used;
 
@@ -1621,6 +1625,11 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
         elem->in_sg[i] = iov[out_num + i];
     }
 
+    /* Assign sequence index for in-order processing */
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_IN_ORDER)) {
+        elem->seq_idx = vq->current_seq_idx++;
+    }
+
     vq->inuse++;
 
     trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
@@ -1760,6 +1769,11 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
     vq->shadow_avail_idx = vq->last_avail_idx;
     vq->shadow_avail_wrap_counter = vq->last_avail_wrap_counter;
 
+    /* Assign sequence index for in-order processing */
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_IN_ORDER)) {
+        elem->seq_idx = vq->current_seq_idx++;
+    }
+
     trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
 done:
     address_space_cache_destroy(&indirect_desc_cache);
@@ -2087,6 +2101,8 @@ static void __virtio_queue_reset(VirtIODevice *vdev, uint32_t i)
     vdev->vq[i].notification = true;
     vdev->vq[i].vring.num = vdev->vq[i].vring.num_default;
     vdev->vq[i].inuse = 0;
+    vdev->vq[i].used_seq_idx = 0;
+    vdev->vq[i].current_seq_idx = 0;
     virtio_virtqueue_reset_region_cache(&vdev->vq[i]);
 }
 
@@ -2334,6 +2350,8 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
     vdev->vq[i].vring.align = VIRTIO_PCI_VRING_ALIGN;
     vdev->vq[i].handle_output = handle_output;
     vdev->vq[i].used_elems = g_new0(VirtQueueElement, queue_size);
+    vdev->vq[i].used_seq_idx = 0;
+    vdev->vq[i].current_seq_idx = 0;
 
     return &vdev->vq[i];
 }
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index b3c74a1bca..910b2a3427 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -75,6 +75,7 @@ typedef struct VirtQueueElement
     hwaddr *out_addr;
     struct iovec *in_sg;
     struct iovec *out_sg;
+    uint16_t seq_idx;
 } VirtQueueElement;
 
 #define VIRTIO_QUEUE_MAX 1024
-- 
2.39.3


