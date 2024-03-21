Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9F9C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 15:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnKnd-0002j4-Qi; Thu, 21 Mar 2024 11:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1rnKnb-0002hH-2k; Thu, 21 Mar 2024 11:57:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1rnKnY-00045y-Kn; Thu, 21 Mar 2024 11:57:46 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42LCmR9j018779; Thu, 21 Mar 2024 15:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=mGZM/6oaHIZKBe6ciPnIlFN7mAWphWahyPp6XX/uaBM=;
 b=WjJDYv+GS0/xrV41t4lvvf4eqO28TBf7LlqHz2dUWM1MdSv7ZZLCzWNuG7dnx/t29AT3
 ejHWS63J3UJsx+yaPbLbZ8tw3m/nhzhTkXXBnTm0zYk29VeWgLJCBth2j0zJ69Yj4U/C
 X9lOfYIPhvvQC2itmYZw27uZrC2cuJyeWmbKFnGhCyXtrXobkq/V25ltRB6WJ6jOooWU
 CpsrvxguSK2P3jtB1eKQ3jXI8w+BH9nDkD6ULx+N1kYZEKgex9JpJjlBAjOkTlFLui71
 lKr7MN1HNlcw/uGZnhrtlCIO+vqvYL0a0AOTIl0rlET1uJrDzkGaMUcba0j7r+Nl/1xR lA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww2732wsk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Mar 2024 15:57:27 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42LFWKaa006138; Thu, 21 Mar 2024 15:57:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3ww1v9q1sc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Mar 2024 15:57:26 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42LFsWZO005094;
 Thu, 21 Mar 2024 15:57:25 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-39-211-118.vpn.oracle.com
 [10.39.211.118])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3ww1v9q1p9-5; Thu, 21 Mar 2024 15:57:25 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, raphael@enfabrica.net, kwolf@redhat.com, hreitz@redhat.com,
 jasowang@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 eperezma@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org,
 schalla@marvell.com, leiyang@redhat.com, virtio-fs@lists.linux.dev,
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [RFC 4/8] virtio: Implement in-order handling for virtio devices
Date: Thu, 21 Mar 2024 11:57:13 -0400
Message-Id: <20240321155717.1392787-5-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240321155717.1392787-1-jonah.palmer@oracle.com>
References: <20240321155717.1392787-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_10,2024-03-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403210115
X-Proofpoint-GUID: 95Q5AiPUy931IcWiIoHXFsuCaEtY7DBV
X-Proofpoint-ORIG-GUID: 95Q5AiPUy931IcWiIoHXFsuCaEtY7DBV
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Implements in-order handling for most virtio devices using the
VIRTIO_F_IN_ORDER transport feature, specifically those who call
virtqueue_push to push their used elements onto the used ring.

The logic behind this implementation is as follows:

1.) virtqueue_pop always enqueues VirtQueueElements in-order.

virtqueue_pop always retrieves one or more buffer descriptors in-order
from the available ring and converts them into a VirtQueueElement. This
means that the order in which VirtQueueElements are enqueued are
in-order by default.

By virtue, as VirtQueueElements are created, we can assign a sequential
key value to them. This preserves the order of buffers that have been
made available to the device by the driver.

As VirtQueueElements are assigned a key value, the current sequence
number is incremented.

2.) Requests can be completed out-of-order.

While most devices complete requests in the same order that they were
enqueued by default, some devices don't (e.g. virtio-blk). The goal of
this out-of-order handling is to reduce the impact of devices that
process elements in-order by default while also guaranteeing compliance
with the VIRTIO_F_IN_ORDER feature.

Below is the logic behind handling completed requests (which may or may
not be in-order).

3.) Does the incoming used VirtQueueElement preserve the correct order?

In other words, is the sequence number (key) assigned to the
VirtQueueElement the expected number that would preserve the original
order?

3a.)
If it does... immediately push the used element onto the used ring.
Then increment the next expected sequence number and check to see if
any previous out-of-order VirtQueueElements stored on the hash table
has a key that matches this next expected sequence number.

For each VirtQueueElement found on the hash table with a matching key:
push the element on the used ring, remove the key-value pair from the
hash table, and then increment the next expected sequence number. Repeat
this process until we're unable to find an element with a matching key.

Note that if the device uses batching (e.g. virtio-net), then we skip
the virtqueue_flush call and let the device call it themselves.

3b.)
If it does not... stash the VirtQueueElement, along with relevant data,
as a InOrderVQElement on the hash table. The key used is the order_key
that was assigned when the VirtQueueElement was created.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/virtio/virtio.c         | 70 ++++++++++++++++++++++++++++++++++++--
 include/hw/virtio/virtio.h |  8 +++++
 2 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 40124545d6..40e4377f1e 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -992,12 +992,56 @@ void virtqueue_flush(VirtQueue *vq, unsigned int count)
     }
 }
 
+void virtqueue_order_element(VirtQueue *vq, const VirtQueueElement *elem,
+                             unsigned int len, unsigned int idx,
+                             unsigned int count)
+{
+    InOrderVQElement *in_order_elem;
+
+    if (elem->order_key == vq->current_order_idx) {
+        /* Element is in-order, push to used ring */
+        virtqueue_fill(vq, elem, len, idx);
+
+        /* Batching? Don't flush */
+        if (count) {
+            virtqueue_flush(vq, count);
+        }
+
+        /* Increment next expected order, search for more in-order elements */
+        while ((in_order_elem = g_hash_table_lookup(vq->in_order_ht,
+                        GUINT_TO_POINTER(++vq->current_order_idx))) != NULL) {
+            /* Found in-order element, push to used ring */
+            virtqueue_fill(vq, in_order_elem->elem, in_order_elem->len,
+                           in_order_elem->idx);
+
+            /* Batching? Don't flush */
+            if (count) {
+                virtqueue_flush(vq, in_order_elem->count);
+            }
+
+            /* Remove key-value pair from hash table */
+            g_hash_table_remove(vq->in_order_ht,
+                                GUINT_TO_POINTER(vq->current_order_idx));
+        }
+    } else {
+        /* Element is out-of-order, stash in hash table */
+        in_order_elem = virtqueue_alloc_in_order_element(elem, len, idx,
+                                                         count);
+        g_hash_table_insert(vq->in_order_ht, GUINT_TO_POINTER(elem->order_key),
+                            in_order_elem);
+    }
+}
+
 void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
                     unsigned int len)
 {
     RCU_READ_LOCK_GUARD();
-    virtqueue_fill(vq, elem, len, 0);
-    virtqueue_flush(vq, 1);
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_IN_ORDER)) {
+        virtqueue_order_element(vq, elem, len, 0, 1);
+    } else {
+        virtqueue_fill(vq, elem, len, 0);
+        virtqueue_flush(vq, 1);
+    }
 }
 
 /* Called within rcu_read_lock().  */
@@ -1478,6 +1522,18 @@ void virtqueue_map(VirtIODevice *vdev, VirtQueueElement *elem)
                                                                         false);
 }
 
+void *virtqueue_alloc_in_order_element(const VirtQueueElement *elem,
+                                       unsigned int len, unsigned int idx,
+                                       unsigned int count)
+{
+    InOrderVQElement *in_order_elem = g_malloc(sizeof(InOrderVQElement));
+    in_order_elem->elem = elem;
+    in_order_elem->len = len;
+    in_order_elem->idx = idx;
+    in_order_elem->count = count;
+    return in_order_elem;
+}
+
 static void *virtqueue_alloc_element(size_t sz, unsigned out_num, unsigned in_num)
 {
     VirtQueueElement *elem;
@@ -1626,6 +1682,11 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
         elem->in_sg[i] = iov[out_num + i];
     }
 
+    /* Assign key for in-order processing */
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_IN_ORDER)) {
+        elem->order_key = vq->current_order_key++;
+    }
+
     vq->inuse++;
 
     trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
@@ -1762,6 +1823,11 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
         vq->last_avail_wrap_counter ^= 1;
     }
 
+    /* Assign key for in-order processing */
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_IN_ORDER)) {
+        elem->order_key = vq->current_order_key++;
+    }
+
     vq->shadow_avail_idx = vq->last_avail_idx;
     vq->shadow_avail_wrap_counter = vq->last_avail_wrap_counter;
 
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index f83d7e1fee..eeeda397a9 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -275,6 +275,14 @@ void virtio_del_queue(VirtIODevice *vdev, int n);
 
 void virtio_delete_queue(VirtQueue *vq);
 
+void *virtqueue_alloc_in_order_element(const VirtQueueElement *elem,
+                                       unsigned int len, unsigned int idx,
+                                       unsigned int count);
+
+void virtqueue_order_element(VirtQueue *vq, const VirtQueueElement *elem,
+                             unsigned int len, unsigned int idx,
+                             unsigned int count);
+
 void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
                     unsigned int len);
 void virtqueue_flush(VirtQueue *vq, unsigned int count);
-- 
2.39.3


