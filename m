Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D45CD1283
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 16:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpsWh-00076B-6u; Thu, 28 Mar 2024 12:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1rpsWX-00071E-Gw; Thu, 28 Mar 2024 12:22:41 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1rpsWT-00087D-Fh; Thu, 28 Mar 2024 12:22:41 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42SFOrIh015505; Thu, 28 Mar 2024 16:22:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=Lw0nJnb3HAsgTV+5C1hLep7WC/u74bJmes3myuB1IwE=;
 b=ku/SXYP5LuBlMU1SvrYjuu54BzfR/zXLM7mLFof3TL3rlTM2hl59YukVo5MRoe2o1pXZ
 JTPeawBmOG9HblLSFMx0DOvVe+4rNn0i88sJTlP7uppnxPRpRsVbW6YN5lQUz1dLF5B8
 q3K3e+HQCnwbnC6ZroVZB7at/9oCZoKY1ubgvHko5DhCCSGRr2EPLt3klw4NVQkByb8N
 36H7rcn3JI5vwWQvOIF7oyqkX5TwlvCPRpns809M7whz3YCHIk99HQ5COxWkV6MEVFVj
 6i1D6f7rGwiKDz2YpemK3VsXnXRw4MvRDXg+ibbZJDaMKPgBj1X69/LARFyCaDk+5PnC /Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1nv4a2pn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Mar 2024 16:22:09 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42SEwKhr015043; Thu, 28 Mar 2024 16:22:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3x1nhgfggj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Mar 2024 16:22:08 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42SGM5Zx010492;
 Thu, 28 Mar 2024 16:22:08 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-39-220-183.vpn.oracle.com
 [10.39.220.183])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3x1nhgfgcy-3; Thu, 28 Mar 2024 16:22:08 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, raphael@enfabrica.net, kwolf@redhat.com, hreitz@redhat.com,
 jasowang@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 eperezma@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org,
 schalla@marvell.com, leiyang@redhat.com, virtio-fs@lists.linux.dev,
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [RFC v2 2/5] virtio: In-order support for split VQs
Date: Thu, 28 Mar 2024 12:22:00 -0400
Message-Id: <20240328162203.3775114-3-jonah.palmer@oracle.com>
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
X-Proofpoint-ORIG-GUID: nppdPIFbTzmLh9H_ehYtfI2vc6hghKlk
X-Proofpoint-GUID: nppdPIFbTzmLh9H_ehYtfI2vc6hghKlk
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

Implements VIRTIO_F_IN_ORDER feature support for virtio devices using
the split virtqueue layout.

For a virtio device that has negotiated the VIRTIO_F_IN_ORDER feature
whose virtqueues use a split virtqueue layout, it's essential that
used VirtQueueElements are written to the used ring in-order.

For devices that use this in-order feature, its VirtQueue's used_elems
array is used to hold processed VirtQueueElements until they can be
presented to the driver in-order.

In the split virtqueue case, we check to see if the element was the next
expected element to be written to the used ring. If it's not, nothing
get written to the used ring and we're done. If it is, the element is
written to the used ring and then we check to see if the next expected
element continues the order. This process is repeated until we're unable
to continue the order.

If no elements were written to the used ring, no update to the used
ring's index is needed.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/virtio/virtio.c | 50 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 069d96df99..19d3d43816 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -856,16 +856,38 @@ static void virtqueue_split_fill(VirtQueue *vq, const VirtQueueElement *elem,
                     unsigned int len, unsigned int idx)
 {
     VRingUsedElem uelem;
+    uint16_t uelem_idx;
 
     if (unlikely(!vq->vring.used)) {
         return;
     }
 
-    idx = (idx + vq->used_idx) % vq->vring.num;
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_IN_ORDER)) {
+        /* Write element(s) to used ring if they're in-order */
+        while (true) {
+            uelem_idx = vq->used_seq_idx % vq->vring.num;
 
-    uelem.id = elem->index;
-    uelem.len = len;
-    vring_used_write(vq, &uelem, idx);
+            /* Stop if element has been used */
+            if (vq->used_elems[uelem_idx].in_num +
+                vq->used_elems[uelem_idx].out_num <= 0) {
+                break;
+            }
+            uelem.id = vq->used_elems[uelem_idx].index;
+            uelem.len = vq->used_elems[uelem_idx].len;
+            vring_used_write(vq, &uelem, uelem_idx);
+
+            /* Mark this element as used */
+            vq->used_elems[uelem_idx].in_num = 0;
+            vq->used_elems[uelem_idx].out_num = 0;
+            vq->used_seq_idx++;
+        }
+    } else {
+        idx = (idx + vq->used_idx) % vq->vring.num;
+
+        uelem.id = elem->index;
+        uelem.len = len;
+        vring_used_write(vq, &uelem, idx);
+    }
 }
 
 static void virtqueue_packed_fill(VirtQueue *vq, const VirtQueueElement *elem,
@@ -918,6 +940,8 @@ static void virtqueue_packed_fill_desc(VirtQueue *vq,
 void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
                     unsigned int len, unsigned int idx)
 {
+    uint16_t seq_idx;
+
     trace_virtqueue_fill(vq, elem, len, idx);
 
     virtqueue_unmap_sg(vq, elem, len);
@@ -926,6 +950,16 @@ void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
         return;
     }
 
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_IN_ORDER)) {
+        seq_idx = elem->seq_idx % vq->vring.num;
+
+        vq->used_elems[seq_idx].index = elem->index;
+        vq->used_elems[seq_idx].len = elem->len;
+        vq->used_elems[seq_idx].ndescs = elem->ndescs;
+        vq->used_elems[seq_idx].in_num = elem->in_num;
+        vq->used_elems[seq_idx].out_num = elem->out_num;
+    }
+
     if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
         virtqueue_packed_fill(vq, elem, len, idx);
     } else {
@@ -944,6 +978,14 @@ static void virtqueue_split_flush(VirtQueue *vq, unsigned int count)
 
     /* Make sure buffer is written before we update index. */
     smp_wmb();
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_IN_ORDER)) {
+        count = (vq->used_seq_idx - vq->used_idx) % vq->vring.num;
+
+        /* No in-order elements were written, nothing to update */
+        if (!count) {
+            return;
+        }
+    }
     trace_virtqueue_flush(vq, count);
     old = vq->used_idx;
     new = old + count;
-- 
2.39.3


