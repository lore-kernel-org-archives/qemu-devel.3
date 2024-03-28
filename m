Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A05CD11DD
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 16:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpsWf-00074u-Ml; Thu, 28 Mar 2024 12:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1rpsWX-00071G-JX; Thu, 28 Mar 2024 12:22:41 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1rpsWT-000878-EK; Thu, 28 Mar 2024 12:22:41 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42SFOwnp009851; Thu, 28 Mar 2024 16:22:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=Oy5nFN0etsJJPGxpWCIMafxrPnNst3dVL5vKPOpE5qg=;
 b=RKgVt1mLZ4UZumfv/UHz0fd+O5U+jbduo8efFtGExWI3VQz1qU0eTdPK9Jkyncsfg9hi
 GYAmG1/d7gJamSdl1W36GkgGqyUAMW9EcoV8ubRP5wSwG4tt4t8YrXSqXdu/aJPWEva+
 rPJ5AgJ0HLg627bcDIqP/yFqLO+KDuBuU4Fgtvb4vmCD/80xmFJIn2rBuXnS9tZWxo8+
 fZd7ZIf2sJChOn10M46GsQRlMz+fmVtduA7jum/uGF/ZXpu3SguWMJimpR4/HXR4zR60
 1ryzefN5xTfFmg05sMK5tdoQQPZsKX5hqNa37Rg6FfnQL54vSc+1JOqjC0a1F4WW1ua6 wg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x2f6h8w75-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Mar 2024 16:22:10 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42SG2jwR015085; Thu, 28 Mar 2024 16:22:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3x1nhgfgj6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Mar 2024 16:22:09 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42SGM5a1010492;
 Thu, 28 Mar 2024 16:22:09 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-39-220-183.vpn.oracle.com
 [10.39.220.183])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3x1nhgfgcy-4; Thu, 28 Mar 2024 16:22:09 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, raphael@enfabrica.net, kwolf@redhat.com, hreitz@redhat.com,
 jasowang@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 eperezma@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org,
 schalla@marvell.com, leiyang@redhat.com, virtio-fs@lists.linux.dev,
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [RFC v2 3/5] virtio: In-order support for packed VQs
Date: Thu, 28 Mar 2024 12:22:01 -0400
Message-Id: <20240328162203.3775114-4-jonah.palmer@oracle.com>
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
X-Proofpoint-GUID: k7Vubl2-zRR0a3m-VmYP5KX2AJ3YbW-E
X-Proofpoint-ORIG-GUID: k7Vubl2-zRR0a3m-VmYP5KX2AJ3YbW-E
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
the packed virtqueue layout.

For a virtio device that has negotiated the VIRTIO_F_IN_ORDER feature
whose virtqueues use a packed virtqueue layout, it's essential that used
VirtQueueElements are written to the descriptor ring in-order.

In the packed virtqueue case, since we already write to the virtqueue's
used_elems array at the start of virtqueue_fill, we don't need to call
virtqueue_packed_fill. Furthermore, due to change in behavior of the
used_elems array and not knowing how many unused in-order elements
exist, separate logic is required for the flushing operation of packed
virtqueues.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/virtio/virtio.c | 50 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 19d3d43816..dc2eabd18b 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -960,7 +960,8 @@ void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
         vq->used_elems[seq_idx].out_num = elem->out_num;
     }
 
-    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED) &&
+        !virtio_vdev_has_feature(vq->vdev, VIRTIO_F_IN_ORDER)) {
         virtqueue_packed_fill(vq, elem, len, idx);
     } else {
         virtqueue_split_fill(vq, elem, len, idx);
@@ -997,18 +998,53 @@ static void virtqueue_split_flush(VirtQueue *vq, unsigned int count)
 
 static void virtqueue_packed_flush(VirtQueue *vq, unsigned int count)
 {
-    unsigned int i, ndescs = 0;
+    unsigned int i, j, uelem_idx, ndescs = 0;
 
     if (unlikely(!vq->vring.desc)) {
         return;
     }
 
-    for (i = 1; i < count; i++) {
-        virtqueue_packed_fill_desc(vq, &vq->used_elems[i], i, false);
-        ndescs += vq->used_elems[i].ndescs;
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_IN_ORDER)) {
+        /* First expected element is used, nothing to do */
+        if (vq->used_elems[vq->used_idx].in_num +
+            vq->used_elems[vq->used_idx].out_num <= 0) {
+            return;
+        }
+
+        j = vq->used_idx;
+
+        for (i = j + 1; ; i++) {
+            uelem_idx = i % vq->vring.num;
+
+            /* Stop if element has been used */
+            if (vq->used_elems[uelem_idx].in_num +
+                vq->used_elems[uelem_idx].out_num <= 0) {
+                break;
+            }
+
+            virtqueue_packed_fill_desc(vq, &vq->used_elems[uelem_idx],
+                                       uelem_idx, false);
+            ndescs += vq->used_elems[uelem_idx].ndescs;
+
+            /* Mark this element as used */
+            vq->used_elems[uelem_idx].in_num = 0;
+            vq->used_elems[uelem_idx].out_num = 0;
+        }
+
+        /* Mark first expected element as used */
+        vq->used_elems[vq->used_idx].in_num = 0;
+        vq->used_elems[vq->used_idx].out_num = 0;
+    } else {
+        j = 0;
+
+        for (i = 1; i < count; i++) {
+            virtqueue_packed_fill_desc(vq, &vq->used_elems[i], i, false);
+            ndescs += vq->used_elems[i].ndescs;
+        }
     }
-    virtqueue_packed_fill_desc(vq, &vq->used_elems[0], 0, true);
-    ndescs += vq->used_elems[0].ndescs;
+
+    virtqueue_packed_fill_desc(vq, &vq->used_elems[j], j, true);
+    ndescs += vq->used_elems[j].ndescs;
 
     vq->inuse -= ndescs;
     vq->used_idx += ndescs;
-- 
2.39.3


